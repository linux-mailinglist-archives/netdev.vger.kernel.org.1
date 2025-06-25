Return-Path: <netdev+bounces-201156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFE9AE84F0
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DD7A7AD1C4
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D458263C8F;
	Wed, 25 Jun 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SnZe9hQa"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A282586FE;
	Wed, 25 Jun 2025 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858694; cv=none; b=ClUQAuapFdidYxOakRejVpWx6zhRUV3oBlYNg7j9OrfGpL8XiFkFtQsPXkE8JSj6osaUDL2uNVR98WY85mh17MFmv4TYZ+Out+cCA81kaLMD1sW9UtccVABT7Hx9Tcpgu6Cxm1QeXt4EwPuka7E/ER/Ix49qO/vtHiXLvudfN5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858694; c=relaxed/simple;
	bh=S9iiT4rY8yVVZDT56xagnLIu0yLrzENhVz9p8gepu8Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGqTicm+2WGwyqbA5m+MzFRA3mc+O3Ulkzjn8jwWGWjLp6Hr+Pc0LSQgsSHMZpwdCVY/VJxvNCAYQyEwhEt5Gim/GVjQEaNdvWDCIPmUwEKIHW/DpWve9xSC4jmCSY4vsyBGegDutSqtuT4a9LV2CsrUiQuuOOioUWIgBES9R/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SnZe9hQa; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55PDbxqD1465797;
	Wed, 25 Jun 2025 08:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750858679;
	bh=guk5khPV1esxhmZJdQY9lFpxB3t0IE6ThuJ7UOmdAbA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=SnZe9hQaY/wm0APwKeF/zpnwo/W/lZyDLwBI7Yokx8Rn7X7eXF14GCicheyBQ9M4G
	 heoDnaEjAhad3S2yQ1Np3qKrXPswhOvdEKsaJrTSEfYjJ36BX2ynoWEXdufD/c4sjk
	 uk1LmK90r+l21bc5FeGYroumBiqIvwlHwl6QyuXo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55PDbxKm2612962
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 25 Jun 2025 08:37:59 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 25
 Jun 2025 08:37:59 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 25 Jun 2025 08:37:59 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.169])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55PDbwUg3729052;
	Wed, 25 Jun 2025 08:37:58 -0500
Date: Wed, 25 Jun 2025 19:07:57 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <rogerq@kernel.org>,
        <horms@kernel.org>, <mwalle@kernel.org>, <jacob.e.keller@intel.com>,
        <jpanis@baylibre.com>, <s-vadapalli@ti.com>, <danishanwar@ti.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw-nuss: Fix skb size by
 accounting for skb_shared_info
Message-ID: <598f9e77-8212-426b-97ab-427cb8bd4910@ti.com>
References: <20250625112725.1096550-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250625112725.1096550-1-c-vankar@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Wed, Jun 25, 2025 at 04:57:25PM +0530, Chintan Vankar wrote:

Hello Chintan,

> While transitioning from netdev_alloc_ip_align to build_skb, memory for

nitpick: Add parantheses when referring to functions:
netdev_alloc_ip_align()
build_skb()

> skb_shared_info was not allocated. Fix this by including

Enclose structures within double quotes and preferably refer to them
in the context of an "skb":

...memory for the "skb_shared_info" member of an "skb" was not allocated...

> sizeof(skb_shared_info) in the packet length during allocation.
> 
> Fixes: 8acacc40f733 ("net: ethernet: ti: am65-cpsw: Add minimal XDP support")

> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
> 
> This patch is based on the commit '9caca6ac0e26' of origin/main branch of
> Linux-net repository.
> 
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index f20d1ff192ef..3905eec0b11e 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -857,6 +857,7 @@ static struct sk_buff *am65_cpsw_build_skb(void *page_addr,
>  	struct sk_buff *skb;
>  
>  	len += AM65_CPSW_HEADROOM;
> +	len += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));

This could be added to the previous line itself:

	len += AM65_CPSW_HEADROOM + SKB_DATA_ALIGN(sizeof(struct skb_shared_info));

>  
>  	skb = build_skb(page_addr, len);
>  	if (unlikely(!skb))

Thank you for finding the bug and fixing it.

Regards,
Siddharth.

