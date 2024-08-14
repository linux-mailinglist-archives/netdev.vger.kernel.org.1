Return-Path: <netdev+bounces-118344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CD49514F9
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971571C2287D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 07:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719D612EBCA;
	Wed, 14 Aug 2024 07:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Z86Fe3O8"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C416383BF;
	Wed, 14 Aug 2024 07:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723619268; cv=none; b=DhjH+mw1m3iKHH2rkg/WJyfjUVoIezMmHMUC8yHBU/9SJHkVrnF1DYd2BD0uvgLN+krOBm5kY6bmiDfbLq7FFjF8y4OvkepdHq4O8LDWHGS6Hhy/bqa6gpWuRkQXZv1sOKFrpDotiO0qKZju6NhQGrFcWuCLtZZSHE+MpxD//4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723619268; c=relaxed/simple;
	bh=Cpi8GQLgY9JlTH5eHcbt02bHo3t8kotWxohYFaE602M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QUcWvZ85N9phGzoNHNDWdcmhoGwh4sXt+MpyBXZC1EnB+9TpOjQs5YYl76Uf3X4i6FgukaqY1ZRvMyECSwcNOosPyVv3waWaOziflvNM/ccbGUPVcXeHZVdjLzCfukTETeqv+Bl77njD4m6m7FhJaDXOIJdRHo38Dp69LHlIrP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Z86Fe3O8; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47E77Nhm025367;
	Wed, 14 Aug 2024 02:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723619243;
	bh=MKLdCsSbTvY34AF4URxfsRZ7/JQWH7kQVV6BxO6LVaE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Z86Fe3O8vjE4zlWgdEvUiSG2B08Fj3gxBtPXzWb1Ys24YEYwxo0Vi8LjV4c3LVsrE
	 e5t4oCxjDiVAZRGFeERGmN0LS5zvqiKsHtt3CHfYtJc+P/gFBqH+1bxvMLAtWWYUXJ
	 6Sd6kE9cKTQubjWDEju0jsZJCpDopmzjuBCAGCkE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47E77NeO038949
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 02:07:23 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 02:07:23 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 02:07:23 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47E77FJ7003619;
	Wed, 14 Aug 2024 02:07:15 -0500
Message-ID: <dd2cf042-f354-4512-9326-cfe5dd29dd9d@ti.com>
Date: Wed, 14 Aug 2024 12:37:14 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] dt-bindings: soc: ti: pruss: Add documentation for
 PA_STATS support
To: Jakub Kicinski <kuba@kernel.org>, Nishanth Menon <nm@ti.com>
CC: Roger Quadros <rogerq@kernel.org>, Suman Anna <s-anna@ti.com>,
        Sai Krishna
	<saikrishnag@marvell.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Heiner
 Kallweit <hkallweit1@gmail.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        <srk@ti.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
References: <20240729113226.2905928-1-danishanwar@ti.com>
 <20240729113226.2905928-2-danishanwar@ti.com>
 <b6196edc-4e14-41e9-826e-7b58f9753ef5@kernel.org>
 <20240806150341.evrprkjp3hb6d74p@mockup>
 <39ed6b90-aab6-452d-a39b-815498a00519@ti.com>
 <20240812172218.3c63cfaf@kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20240812172218.3c63cfaf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 13/08/24 5:52 am, Jakub Kicinski wrote:
> On Mon, 12 Aug 2024 11:20:56 +0530 MD Danish Anwar wrote:
>>> If the net maintainers are OK, they could potentially take the binding
>>> patch along with the driver mods corresponding to this - I am a bit
>>> unsure of picking up a binding if the driver implementation is heading
>>> the wrong way.   
>>
>> Hi Jakub, Paolo, David, Andrew,
>>
>> Will it be okay to pick this binding patch to net-next tree. Nishant is
>> suggesting since the driver changes are done in drivers/net/ the binding
>> can be picked by net maintainers.
>>
>> Please let us know if it will be okay to take this binding to net-next.
>> I can post a new series with just the binding and the driver patch to
>> net-next if needed.
> 
> Nishanth, could you send an official Ack tag?
> 
> No problem with merging it via net-next.
> On the code itself you may want to use ethtool_puts().

Thanks Jakub, I will send out a new series with just the binding and
driver patch and send it to net-next. I will take care of ethtool_puts().

-- 
Thanks and Regards,
Danish

