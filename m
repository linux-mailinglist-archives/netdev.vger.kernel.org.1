Return-Path: <netdev+bounces-98394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 902BD8D13C7
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 07:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D161F216BE
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 05:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C96D4AEC6;
	Tue, 28 May 2024 05:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f+80J5ze"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F0E1C6B8;
	Tue, 28 May 2024 05:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716873510; cv=none; b=WX6L3ps4L3X2nm0D0bJiPi5taWjYaPKGSQn45G57zH3gSC4hhegheeS/487VTO5nfrNXsoFLjH9RAEhgLTjJNw+M4Y/vJaq90KUbi4Se+PrDK0RWceWdGmgMbnFhh77mm8UDn2ypFhsaClNgaoz4/tIeJdBl80+mmOrXqw/XiMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716873510; c=relaxed/simple;
	bh=lMVHz7jvK7Ugc5LUZZa7PlBOhJneKTAMs0NlEsr6e1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pEzKgq+vwRVX+FYqe54RLL+AaEKIvNqNqWtMPCndh0f/QhridTg/h/xXw2VqRDTZKI3BbhAnCKE/DmFzEC9SQNyKgzE/vL3NbawqTzVsUbfdU/VIfy8vgttF11+HybjogwXwKLbuiZ1JqB/xIe166m9DA1VjP01wK9GWKdv7GPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=f+80J5ze; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S5HvUf056795;
	Tue, 28 May 2024 00:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716873477;
	bh=d4NVnCBPhDacoO1O+VTQbfD7+ZfFBnp9f17Rt6n+qxA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=f+80J5zegDDMBEdZ46oNvUERXssRlWS4uAwR82QoJwK65qohTrxLEjANbg6Ei0PFz
	 +Ydoyex4qeiK/DJ97D1acu6lbDgqD16kwYarG3qRI2ptKt99fFa0OpD40mPqNJc+jk
	 eA5JkXr2+JgfZ1AptsOTxAyHBMT+XES5Kwh3sX7c=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S5HvYF076466
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 May 2024 00:17:57 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 00:17:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 00:17:57 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44S5HoDJ015196;
	Tue, 28 May 2024 00:17:51 -0500
Message-ID: <595c2551-c2f1-4ffe-8976-7f8bbd290aab@ti.com>
Date: Tue, 28 May 2024 10:47:49 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 0/2] Add TAPRIO offload support for ICSSG
 driver
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: Jan Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Simon Horman <horms@kernel.org>, Diogo Ivo
	<diogo.ivo@siemens.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Niklas Schnelle
	<schnelle@linux.ibm.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>
References: <20240527055300.154563-1-danishanwar@ti.com>
 <57f6ed32-65cd-49e4-bfe6-c8d320e8de53@lunn.ch>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <57f6ed32-65cd-49e4-bfe6-c8d320e8de53@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

On 28/05/24 3:46 am, Andrew Lunn wrote:
> On Mon, May 27, 2024 at 11:22:58AM +0530, MD Danish Anwar wrote:
>> This series adds taprio offload support for ICSSG driver.
>>
>> Patch [1/2] of the series moves some structures and API definition to .h
>> files so that these can be accessed by taprio (icssg_qos.c) file.
>>
>> Patch [2/2] of the series intoduces the taprio support for icssg driver.
> 
> What is the dependency between these patches and switchdev support? It
> is good to make that clear in the cover note, especially if this code
> will not apply without some other patches first.
> 

I have developed this patch and the switchdev series independently. Both
series can be applied to latest net-next without any error. Once one of
these gets applied I will rebase it on top of the other one. There is no
dependency between switch and mac mode for taprio support.

>      Andrew

-- 
Thanks and Regards,
Danish

