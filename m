Return-Path: <netdev+bounces-157130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A41A08F9F
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 181BC7A2F58
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649EE20ADFF;
	Fri, 10 Jan 2025 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WbCJ2gcu"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440CF20B210
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736509351; cv=none; b=IMSoXvLG+/rlr0dlS9t3Lid0kP9bvwnlNVg9N71xFigQcURb/WKBJ0f79voU4R46pu7W0a3e+WCyMRfYG1bPFOKnPIfzRA5G8fcyhV3r5ccbrvqNEwKIDuknVl19g4Vi/GlI73VsOXBflxxqP8xbh9qB9HawxQYddlRvYnx9m9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736509351; c=relaxed/simple;
	bh=e85/59QkdtZy0+hmfyYTDy2qjw0Ngd9L6Dg2yAH0R6g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6h5qB/Y++GDsQIciQ1HK+42PKOJobfx2M3DDG2b8/a7zZUPo7n+3I/LOEskpo81mtQyDri7FZ/EYwszisAAOjwlUcMfJPSl19U9qNT7oO6AuWUV/Xv7F4IqqMAMHW97M3E2D4o/gLXcvaChJaHhKoLSRFqx5059OoT1w1SJ6xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WbCJ2gcu; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50ABgGtD3111168
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 05:42:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1736509336;
	bh=ycDC2CpNWrRJUViUT3opj//rTY04fPjXCUvxsVHWZgs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=WbCJ2gcuztlRsAZtTGqi4ET2U5cVblCLHP9lPWldqD9M82HnWgTdpd7d0+iZd/EKp
	 Fhwg+KgOWRT/yZoG18Faw8wZsKtBOgiCm5Yx3V/fjAc3gmYBfFq5nl7tG3SnoHW4ME
	 3gMv5hE9HyX3oDTjATfC3j35WT33a0fPGstwlsrA=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50ABgGnY091763
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 10 Jan 2025 05:42:16 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 Jan 2025 05:42:15 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 Jan 2025 05:42:15 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.104])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50ABgECQ025851;
	Fri, 10 Jan 2025 05:42:15 -0600
Date: Fri, 10 Jan 2025 17:12:14 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
CC: <netdev@vger.kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
        Andrew
 Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Roger Quadros
	<rogerq@kernel.org>, Chintan Vankar <c-vankar@ti.com>,
        Julien Panis
	<jpanis@baylibre.com>
Subject: Re: [PATCH net-next v2] net: ethernet: ti: am65-cpsw: VLAN-aware
 CPSW only if !DSA
Message-ID: <fgt5mqpmibxjbfd3ae46hxk3m2sowpbxs3ffurwxiqairvlj4d@7ns2gdwh3v7h>
References: <20250110112725.415094-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250110112725.415094-1-alexander.sverdlin@siemens.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Fri, Jan 10, 2025 at 12:27:17PM +0100, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Only configure VLAN-aware CPSW mode if no port is used as DSA CPU port.
> VLAN-aware mode interferes with some DSA tagging schemes and makes stacking
> DSA switches downstream of CPSW impossible. Previous attempts to address
> the issue linked below.
> 
> Link: https://lore.kernel.org/netdev/20240227082815.2073826-1-s-vadapalli@ti.com/
> Link: https://lore.kernel.org/linux-arm-kernel/4699400.vD3TdgH1nR@localhost/
> Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

A Co-developed-by tag should be followed by a Signed-off-by tag of the
same individual.

> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
> Changelog:
> v2: Thanks to Siddharth it does look much clearer now (conditionally clear
>     AM65_CPSW_CTL_VLAN_AWARE instead of setting)
> 
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index 5465bf872734..58c840fb7e7e 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -32,6 +32,7 @@
>  #include <linux/dma/ti-cppi5.h>
>  #include <linux/dma/k3-udma-glue.h>
>  #include <net/page_pool/helpers.h>
> +#include <net/dsa.h>
>  #include <net/switchdev.h>
>  
>  #include "cpsw_ale.h"
> @@ -724,13 +725,22 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
>  	u32 val, port_mask;
>  	struct page *page;
>  
> +	/* Control register */
> +	val = AM65_CPSW_CTL_P0_ENABLE | AM65_CPSW_CTL_P0_TX_CRC_REMOVE |
> +	      AM65_CPSW_CTL_VLAN_AWARE | AM65_CPSW_CTL_P0_RX_PAD;
> +	/* VLAN aware CPSW mode is incompatible with some DSA tagging schemes.
> +	 * Therefore disable VLAN_AWARE mode if any of the ports is a DSA Port.
> +	 */
> +	for (port_idx = 0; port_idx < common->port_num; port_idx++)
> +		if (netdev_uses_dsa(common->ports[port_idx].ndev)) {
> +			val &= ~AM65_CPSW_CTL_VLAN_AWARE;
> +			break;
> +		}
> +	writel(val, common->cpsw_base + AM65_CPSW_REG_CTL);
> +
>  	if (common->usage_count)
>  		return 0;

The changes above should be present HERE, i.e. below the
"common->usage_count" check, as was the case earlier.

>  
> -	/* Control register */
> -	writel(AM65_CPSW_CTL_P0_ENABLE | AM65_CPSW_CTL_P0_TX_CRC_REMOVE |
> -	       AM65_CPSW_CTL_VLAN_AWARE | AM65_CPSW_CTL_P0_RX_PAD,
> -	       common->cpsw_base + AM65_CPSW_REG_CTL);
>  	/* Max length register */
>  	writel(AM65_CPSW_MAX_PACKET_SIZE,
>  	       host_p->port_base + AM65_CPSW_PORT_REG_RX_MAXLEN);

Regards,
Siddharth.

