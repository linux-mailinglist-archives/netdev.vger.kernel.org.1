Return-Path: <netdev+bounces-157093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D370A08E38
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06C71885FA4
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33EF209F56;
	Fri, 10 Jan 2025 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fJnh7G1Z"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5706818FC80
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736505686; cv=none; b=D+jwLEFftR81qwXoLeHXrD44eCMuFXtpPROSHP9BMzMWB3LilbAaOh5gEW5/iAwihs+e2WQG7Yve9+Xuuc109O5rd6syCiGTyQoU12CcwUAfBzbhu9J6y3E8hsxY5HTNFKbkJ4ZrVSuDlEC81MBd4U2buntF869s7j1I4NLIXFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736505686; c=relaxed/simple;
	bh=ZGpsDtnWyo3zEMhwPPCSvj86CNgfHjnIjCy3szDAN18=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pk6B6ie9B2GpafICJQzsjZk9CZ4Jo/lUYGxqoeVaRrsG+xpi0kDpcU3npy5hB+sOGmdDMz79m3LMw8WC/2BFxkbefFxskvHJxIVNfX4Fm5UaH4RyvgVAt2tDJ8q74ZN0gKBSewe8iM8L3Dv4q+/DDx/k+PREz2dwbz6UEpdMEkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fJnh7G1Z; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50AAfAQj3021518
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 04:41:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1736505670;
	bh=mTolHO0NEoSdz2XwlQPySRMV+3zhIKzK5ZkgGbaKBlY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=fJnh7G1Z8ObhnRvbOKLabZpvThSz3XagmLwCtlU0lsstWO+znde9zC4H01EYDkVc2
	 STvs2TUajbXJoagMuubuLweACdvNNU/5EtyU8mv97wfsuPbHJ221CILAsdKmH7u1ZR
	 fW6gfr3wHs/kURynhwIjqEGj1DGIYc/LV9WyEODA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50AAfA75009571
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 10 Jan 2025 04:41:10 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 Jan 2025 04:41:10 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 Jan 2025 04:41:10 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.104])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50AAf8av079059;
	Fri, 10 Jan 2025 04:41:09 -0600
Date: Fri, 10 Jan 2025 16:11:08 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <netdev@vger.kernel.org>,
        Andrew
 Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Roger Quadros
	<rogerq@kernel.org>, Chintan Vankar <c-vankar@ti.com>,
        Julien Panis
	<jpanis@baylibre.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpsw: VLAN-aware CPSW
 only if !DSA
Message-ID: <t34jbpf2dwhuszreyxby3qzvhachu3nt2wsbqiq4fkbw3uoxrb@aq6uqo3kg6ct>
References: <20250110092624.287209-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250110092624.287209-1-alexander.sverdlin@siemens.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Fri, Jan 10, 2025 at 10:26:21AM +0100, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Only configure VLAN-aware CPSW mode if no port is used as DSA CPU port.
> VLAN-aware mode interferes with some DSA tagging schemes and makes stacking
> DSA switches downstream of CPSW impossible. Previous attempts to address
> the issue linked below.
> 
> Link: https://lore.kernel.org/netdev/20240227082815.2073826-1-s-vadapalli@ti.com/
> Link: https://lore.kernel.org/linux-arm-kernel/4699400.vD3TdgH1nR@localhost/
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index dcb6662b473d..e445acb29e16 100644
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
> @@ -724,13 +725,23 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
>  	u32 val, port_mask;
>  	struct page *page;
>  
> +	/* Control register */
> +	val = AM65_CPSW_CTL_P0_ENABLE | AM65_CPSW_CTL_P0_TX_CRC_REMOVE |
> +	      AM65_CPSW_CTL_P0_RX_PAD;
> +	for (port_idx = 0; port_idx < common->port_num; port_idx++) {
> +		struct am65_cpsw_port *port = &common->ports[port_idx];
> +
> +		if (netdev_uses_dsa(port->ndev))
> +			break;
> +	}
> +	/* VLAN aware CPSW mode is incompatible with some DSA tagging schemes */
> +	if (port_idx == common->port_num)
> +		val |= AM65_CPSW_CTL_VLAN_AWARE;
> +	writel(val, common->cpsw_base + AM65_CPSW_REG_CTL);
> +

Though it functionally enables VLAN_AWARE mode only when none of the ports
are a DSA port, the implementation and the comment appear inconsistent.
The comment states that VLAN aware CPSW mode is incompatible with DSA
and the lines following it are enabling VLAN_AWARE mode albeit for the
case where none of the ports are a DSA port. Since the IF condition
doesn't indicate that in an obvious manner, the implementation could be
improved to maintain consistency between what the comment states and what
the code does.

How about the following?
-------------------------------------------------------------------------
	/* Control register */
	val = AM65_CPSW_CTL_P0_ENABLE | AM65_CPSW_CTL_P0_TX_CRC_REMOVE |
	      AM65_CPSW_CTL_VLAN_AWARE | AM65_CPSW_CTL_P0_RX_PAD;

	/* VLAN aware CPSW mode is incompatible with some DSA tagging
	 * schemes. Therefore disable VLAN_AWARE mode if any of the
	 * ports is a DSA Port.
	 */
	for (port_idx = 0; port_idx < common->port_num; port_idx++)
		if (netdev_uses_dsa(&common->ports[port_idx]->ndev)) {
			val &= ~AM65_CPSW_CTL_VLAN_AWARE;
			break;
		}

	writel(val, common->cpsw_base + AM65_CPSW_REG_CTL);
-------------------------------------------------------------------------

>  	if (common->usage_count)
>  		return 0;
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

