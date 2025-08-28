Return-Path: <netdev+bounces-217601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E64C1B392D9
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 07:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279A61BA5B7E
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 05:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3D21F8ACA;
	Thu, 28 Aug 2025 05:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UtCBv87A"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C51D347C3;
	Thu, 28 Aug 2025 05:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756358615; cv=none; b=j7aXC6uQ4o6WCytq+YKP1Ycw1vzaGbZS/p02IkcTIz2SDL8zmaZtotwDSlY14A7crka4cM4iq9CCU/XWEncRieZ2ul8KQsQIX/JoxBbfs6w9RvCu7CUW5+QZfemuNjZ7LJagdS2c2CcK+2bm/2askfgLN2FsJLJ2/1k3Y2JpMc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756358615; c=relaxed/simple;
	bh=MPv9upYSfnuMVEjCiBx+rrWvB2IX5FK6oSbWZnwJQG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ocRslrXBJ6FxX2oysKvfiPjigYaGg84t6uu9uwqOoh/1JyjTcjks8lVqKQ+ce5U2jP0IjuvNFGtG97e/zMo1uJH4dd4q7eI209GKsliYg3XtSDkLjN4o5aFwZ2EQu1+bDQFuv9UMt9KLj+wLSBAwb/JQ3jlNwNhqtZ23ZhAKHKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UtCBv87A; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57S5MV2N1933390;
	Thu, 28 Aug 2025 00:22:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756358551;
	bh=dSYTJRLUiaKEblrv6ghM/tLJvlJ4dpZF50LtDEoi190=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=UtCBv87A9YotW4e0Kpza0rumkfMUe9aQQ2p9MoF0eYg5POwikHGkZbX+Bgu53YtPl
	 p8n7XbPCMDlm58CbFqlzv2bgVsdB+NixoVNm0fZShswC4fxgoQzAiNyJrEwswLNAUY
	 megeYWaaIVmdw5gPZcFB9aQ8bE4jkUQdD9mhYxx4=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57S5MUZR2661524
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 28 Aug 2025 00:22:30 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 28
 Aug 2025 00:22:29 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 28 Aug 2025 00:22:29 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57S5ML1t072116;
	Thu, 28 Aug 2025 00:22:22 -0500
Message-ID: <0651d5a9-dd02-4936-94b8-834bd777003c@ti.com>
Date: Thu, 28 Aug 2025 10:52:21 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 0/5] Add driver for 1Gbe network chips from
 MUCSE
To: Dong Yibo <dong100@mucse.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <corbet@lwn.net>,
        <gur.stavi@huawei.com>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
        <lee@trager.us>, <gongfan1@huawei.com>, <lorenzo@kernel.org>,
        <geert+renesas@glider.be>, <Parthiban.Veerasooran@microchip.com>,
        <lukas.bulwahn@redhat.com>, <alexanderduyck@fb.com>,
        <richardcochran@gmail.com>, <kees@kernel.org>, <gustavoars@kernel.org>,
        <rdunlap@infradead.org>, <vadim.fedorenko@linux.dev>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20250828025547.568563-1-dong100@mucse.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250828025547.568563-1-dong100@mucse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Dong Yibo,

On 28/08/25 8:25 am, Dong Yibo wrote:
> Hi maintainers,
> 
> This patch series is v9 to introduce support for MUCSE N500/N210 1Gbps
> Ethernet controllers. I divide codes into multiple series, this is the
> first one which only register netdev without true tx/rx functions.
> 
> Changelog:
> v8 -> v9:
> 1. update function description format '@return' to 'Return' 
> 2. update 'negative on failure' to 'negative errno on failure'
> 
> links:
> v8: https://lore.kernel.org/netdev/20250827034509.501980-1-dong100@mucse.com/
> v7: https://lore.kernel.org/netdev/20250822023453.1910972-1-dong100@mucse.com
> v6: https://lore.kernel.org/netdev/20250820092154.1643120-1-dong100@mucse.com/
> v5: https://lore.kernel.org/netdev/20250818112856.1446278-1-dong100@mucse.com/
> v4: https://lore.kernel.org/netdev/20250814073855.1060601-1-dong100@mucse.com/
> v3: https://lore.kernel.org/netdev/20250812093937.882045-1-dong100@mucse.com/
> v2: https://lore.kernel.org/netdev/20250721113238.18615-1-dong100@mucse.com/
> v1: https://lore.kernel.org/netdev/20250703014859.210110-1-dong100@mucse.com/

Please wait for at least 24 hours before posting a new version. You
posted v8 yesterday and most folks won't have noticed v8 by now or they
maybe looking to give comments on v8. But before they could do that you
posted v9.

Keep good amount of gaps between the series so that more folks can look
at it. 24 hours is the minimum.

-- 
Thanks and Regards,
Danish


