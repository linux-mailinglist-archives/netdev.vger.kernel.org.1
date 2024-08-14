Return-Path: <netdev+bounces-118531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FC6951E1D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 17:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B88AEB26595
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B519F1B3F39;
	Wed, 14 Aug 2024 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f0CzECq+"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E021B3F19;
	Wed, 14 Aug 2024 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647404; cv=none; b=KB/TfH1mgfVoM3/pMJKXwKIEN8kBsvXX58F2kjVmM6uFGxTp7+rdtCbVF/Y0Er6DLzvoNJkYysfnKDHHrbizXMMvMs9KnpPZO+dAu2a5Jq7TawbLHbUbFneLe5s+66arh+oIALCapYk5M+cWCc+v0UsymmBAIe/n6EyF0Y5R1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647404; c=relaxed/simple;
	bh=/URbDQUe8tpIr2dF/FiO/AySyoYhlLDMC4EylewElsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Sdz0yWfveU0KFqJYCZ9+FQ/XqLzWvhn+SbKkbygn5+rUt3jiFjf44S9Xl2XG9pQHITANlezMzZSzfovojaG/9V9WsVpl0a3qTyOgbKzv0xQW3UIIV5ojIp7GPbe02n0mI4g5l02vIVU46a8eaYnTYLvcQLIJR/pdcAePGaOoFZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=f0CzECq+; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47EEuNS1070138;
	Wed, 14 Aug 2024 09:56:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723647383;
	bh=Zn7iFpMlSGpI1yEk3oG9a9XVdYvt4GFFLghB4MSQFjE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=f0CzECq+zUcrW9q40RbgpXHu30zd29ys5SLfqOzdJRpS751EUzBkIUjYRUakS4vS0
	 Rh1z/GaRpOpouBnbmZ5inBCD03zfh+Sp5ALuYP6GEJWwfdWwr+HNJLRRvuDuwO25qa
	 nf9Txojd3X8pwHoUQI18cLTYjoHRaSnYy8pL2ets=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47EEuNR1105612
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 09:56:23 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 09:56:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 09:56:22 -0500
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47EEuDgU034028;
	Wed, 14 Aug 2024 09:56:14 -0500
Message-ID: <b1e1f90c-5477-4fc7-b2ac-c6fb0a41d556@ti.com>
Date: Wed, 14 Aug 2024 20:26:12 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/7] Introduce HSR offload support for ICSSG
To: Andrew Lunn <andrew@lunn.ch>, MD Danish Anwar <danishanwar@ti.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka
	<jan.kiszka@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Javier
 Carrasco <javier.carrasco.cruz@gmail.com>,
        Jacob Keller
	<jacob.e.keller@intel.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman
	<horms@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <d061bfb6-0ccc-4a41-adad-68a90a340475@lunn.ch>
 <69043091-dd59-4b7a-aae0-34f9695b378d@ti.com>
 <c2f99f7e-4f36-47eb-aee5-795d41be819e@lunn.ch>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <c2f99f7e-4f36-47eb-aee5-795d41be819e@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 8/14/2024 7:34 PM, Andrew Lunn wrote:
>> We have these 3 firmwares only for ICSSG.
> 
> O.K. But i also hope you have learned from this and the next
> generation of the hardware with have more RAM for firmware, so you
> only need one firmware image for everything.
> 

Yes Andrew, The goal will always be to have a firmware which can do all
these instead of multiple firmwares in future. Thanks for all the
reviews and sugestions.

>      Andrew

-- 
Thanks and Regards,
Md Danish Anwar

