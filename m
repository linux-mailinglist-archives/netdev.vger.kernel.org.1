Return-Path: <netdev+bounces-99795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E603C8D6874
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 19:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9111F2885B
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 17:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF71446D1;
	Fri, 31 May 2024 17:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="ZA4T4lzH"
X-Original-To: netdev@vger.kernel.org
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FB91DFCB
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717177739; cv=none; b=FRy9Id96LPR6N2lTzdiFWkea6zyEA9+dpFHkunUHIl0z2umJHXf46dqjO5sqIhq6YoNK9UsTJm7Q2odwIVywhvxt4ouaUnXpaOoWP2guJ1xV/6UspFXDoQSsPPLuhv6bPDIrg9vMmm5vKWZ1J50bB10HzSWvUzoHBAbxNTD2+PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717177739; c=relaxed/simple;
	bh=MXqn0xeA2HqxHTRc1nTtDIQVZRm+olzLnPAvyUPI2QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MYCAVrxz1PTJHiTe9d1u05iTCBnwjrejeahGWEPjMiQkp9fVbdz2s0Qwv4KkRfzxGhL0RgQs5k5L9P58RZE74dkSTLIQjB8HXoz/VEP3Q9yl6nrKnm+meCYCppj8sBQ+AR0AK0e1dlmyUVjFlG/1LCGGV1Xd4CTwFrtndXPySCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=ZA4T4lzH; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1717177731; x=1719769731;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MXqn0xeA2HqxHTRc1nTtDIQVZRm+olzLnPAvyUPI2QM=;
	b=ZA4T4lzH7QGt3f0O18jjmVSizCsSkHJeh8ODoezaUrRyxH2WDOjhbe1gS5Om20h4
	VO6JPByrwj38Iaj9PfKt8XaUaxaTQTceU1XgW7KvKsN/xotJb3Ti6Y0w+zHlbVBn
	rEk32qSBgVfjc/Ft04H34G8+lsmdsZHDkbXxKK6Rb/s=;
X-AuditID: ac14000a-03251700000021bc-eb-665a0d834430
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 55.77.08636.38D0A566; Fri, 31 May 2024 19:48:51 +0200 (CEST)
Received: from [10.0.0.42] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 31 May
 2024 19:48:43 +0200
Message-ID: <828e0af0-bad4-4012-b519-2d292f0035a5@phytec.de>
Date: Fri, 31 May 2024 19:48:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: net: dp8386x: Add MIT license along with
 GPL-2.0
To: Udit Kumar <u-kumar1@ti.com>, <vigneshr@ti.com>, <nm@ti.com>,
	<tglx@linutronix.de>, <tpiepho@impinj.com>
CC: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Kip Broadhurst <kbroadhurst@ti.com>
References: <20240531165725.1815176-1-u-kumar1@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240531165725.1815176-1-u-kumar1@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsWyRpKBR7eZNyrNoG2PtMX5u4eYLdbsPcdk
	Med8C4vF/CPnWC2eHnvEbrH+q6TFy1n32CwubOtjtdj0+BqrxeVdc9gsji0Qs3jz4yyTxbfT
	bxgt/u/ZwW6xedNUZoslcx+yW0zbO4PZ4v/ZD+wOQh5bVt5k8liwqdTjzYTbTB6bVnWyebw7
	d47dY/OSeo+dOz4zebzfd5XN4/iN7UwenzfJBXBFcdmkpOZklqUW6dslcGWsmXGUpeCeaMWj
	R/oNjLcEuxg5OSQETCT2r7jB0sXIxSEksIRJYvHPyUwQzi1GiaWbL7KBVPEK2EgcbVsFZrMI
	qEqsWbidFSIuKHFy5hMWEFtUQF7i/q0Z7CC2sEC4xIpru4HiHBwiAnkSB6ZVgcxkFrjOJNHw
	aCNYvZCAmcTWg3eZQWxmAXGJW0/mM4HYbALqEnc2fAObzylgLjHn8Xc2iBoLicVvDrJD2PIS
	29/OYYaYIy/x4tJyFohv5CWmnXvNDGGHSmz9sp1pAqPwLCSnzkKybhaSsbOQjF3AyLKKUSg3
	Mzk7tSgzW68go7IkNVkvJXUTIyiuRRi4djD2zfE4xMjEwXiIUYKDWUmE91d6RJoQb0piZVVq
	UX58UWlOavEhRmkOFiVx3tUdwalCAumJJanZqakFqUUwWSYOTqkGRgkHU6bV9779uCu2/0cZ
	R7mjZ3yl37Vzh/dbfw36+XWGeeav2fOvP+RirlnTzNkWGCu/+LvM3OajT7Qsj382CHn9TNLX
	2mWiL2N28WaD+d4q11csF+20U9mls+hNr8cxYc65mWtWPds2RSuau7HBWERl56b9PWEWChuq
	+jnWfPa6b7zOK3nXUiWW4oxEQy3mouJEAIKNn37ZAgAA



Am 31.05.24 um 18:57 schrieb Udit Kumar:
> Modify license to include dual licensing as GPL-2.0-only OR MIT
> license for TI specific phy header files. This allows for Linux
> kernel files to be used in other Operating System ecosystems
> such as Zephyr or FreeBSD.
> 
> While at this, update the GPL-2.0 to be GPL-2.0-only to be in sync
> with latest SPDX conventions (GPL-2.0 is deprecated).
> 
> While at this, update the TI copyright year to sync with current year
> to indicate license change.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Trent Piepho <tpiepho@impinj.com>
> Cc: Wadim Egorov <w.egorov@phytec.de>
> Cc: Kip Broadhurst <kbroadhurst@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>

Acked-by: Wadim Egorov <w.egorov@phytec.de>

> ---
> Changelog:
> Changes in v2:
> - Updated Copyright information as per review comments of v1
> - Added all authors[0] in CC list of patch
> - Extended patch to LAKML list
> v1 link: https://lore.kernel.org/all/20240517104226.3395480-1-u-kumar1@ti.com/
> 
> [0] Patch cc list is based upon (I am representing @ti.com for this patch)
> git log --no-merges --pretty="%ae" $files|grep -v "@ti.com"
> 
> Requesting Acked-by, from the CC list of patch at the earliest
> 
> 
>   include/dt-bindings/net/ti-dp83867.h | 4 ++--
>   include/dt-bindings/net/ti-dp83869.h | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/dt-bindings/net/ti-dp83867.h b/include/dt-bindings/net/ti-dp83867.h
> index 6fc4b445d3a1..b8a4f3ff4a3b 100644
> --- a/include/dt-bindings/net/ti-dp83867.h
> +++ b/include/dt-bindings/net/ti-dp83867.h
> @@ -1,10 +1,10 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
>   /*
>    * Device Tree constants for the Texas Instruments DP83867 PHY
>    *
>    * Author: Dan Murphy <dmurphy@ti.com>
>    *
> - * Copyright:   (C) 2015 Texas Instruments, Inc.
> + * Copyright (C) 2015-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   #ifndef _DT_BINDINGS_TI_DP83867_H
> diff --git a/include/dt-bindings/net/ti-dp83869.h b/include/dt-bindings/net/ti-dp83869.h
> index 218b1a64e975..917114aad7d0 100644
> --- a/include/dt-bindings/net/ti-dp83869.h
> +++ b/include/dt-bindings/net/ti-dp83869.h
> @@ -1,10 +1,10 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
>   /*
>    * Device Tree constants for the Texas Instruments DP83869 PHY
>    *
>    * Author: Dan Murphy <dmurphy@ti.com>
>    *
> - * Copyright:   (C) 2019 Texas Instruments, Inc.
> + * Copyright (C) 2015-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   #ifndef _DT_BINDINGS_TI_DP83869_H

