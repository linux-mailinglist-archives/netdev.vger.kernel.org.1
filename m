Return-Path: <netdev+bounces-157140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8681EA08FEF
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 13:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 809107A4AC2
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6521BBBC6;
	Fri, 10 Jan 2025 12:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OoIu3Fca"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E6F19ABDE
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 12:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736510569; cv=none; b=Lxrw9M8BKd6DVICajumNnoPz6k7yfJ7bzAIUyTs+EPwiH/Bdgs47m5h5XR25wuvA13bd81mAnU2faJqn+HMDXnNnB2HUUzdEE0U/gQFaKkLyWvFz1BRML/Za/iTDPW5whx5gi9ypfBlgwbbSbbSBhiTbIlI0N27YdsiBiJ/d6Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736510569; c=relaxed/simple;
	bh=ZESpBHlwK7EwTmETMBsccGmsW7BsEV8Fcy809BvZT7U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTt/tN4l2zPTT/ozb6mybXS8SWHCKi7HC9vbAZhs8BtItS7zSV0jdZkvPmi22c2ohnB6dIrWTM8vKNn13r6ZcHhp66sDABqXXvMjNXcR8q/tL3asQB6veQjpjxJnWi0vCTYufWevdwYqv37PLdI8rcVXQxsoSJYV8it2ghqnFyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OoIu3Fca; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 50AC2WDQ008047;
	Fri, 10 Jan 2025 06:02:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1736510552;
	bh=hZUGTKomQMp6ZXjuSYGHYCQzAB/8jmOW6WdpQZUcrD0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=OoIu3Fca0swjhwykdOOfpb900KfDCHVAS20rfzWuh04wDuK5BIku78ys7UiQGF4eo
	 expfJxcMMCYAS/lHzObsqprYHxRURp9Zw8QEoBEwCwyHMgrOEcUGLY05EhygFU8f7c
	 +bjCuBlmj+bH7Xc/NnZp4mZyd/TR5khlsuq5nqb0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50AC2WSD102720
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 10 Jan 2025 06:02:32 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 Jan 2025 06:02:32 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 Jan 2025 06:02:32 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.104])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50AC2Vb9045040;
	Fri, 10 Jan 2025 06:02:31 -0600
Date: Fri, 10 Jan 2025 17:32:30 +0530
From: "s-vadapalli@ti.com" <s-vadapalli@ti.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
CC: "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
        "c-vankar@ti.com"
	<c-vankar@ti.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jpanis@baylibre.com"
	<jpanis@baylibre.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "rogerq@kernel.org"
	<rogerq@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: ethernet: ti: am65-cpsw: VLAN-aware
 CPSW only if !DSA
Message-ID: <tjc6uc74j3add7bzh7of32i5topeenzv64y3hudne2lioqwqzb@qlhi4gdfn6ww>
References: <20250110112725.415094-1-alexander.sverdlin@siemens.com>
 <fgt5mqpmibxjbfd3ae46hxk3m2sowpbxs3ffurwxiqairvlj4d@7ns2gdwh3v7h>
 <5864db3fdb5fea960b76a87d11527becf355650b.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5864db3fdb5fea960b76a87d11527becf355650b.camel@siemens.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Fri, Jan 10, 2025 at 11:48:45AM +0000, Sverdlin, Alexander wrote:
> Hi Siddharth!

Hello Alexander,

> 
> On Fri, 2025-01-10 at 17:12 +0530, Siddharth Vadapalli wrote:
> > On Fri, Jan 10, 2025 at 12:27:17PM +0100, A. Sverdlin wrote:
> > > From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> > > 
> > > Only configure VLAN-aware CPSW mode if no port is used as DSA CPU port.
> > > VLAN-aware mode interferes with some DSA tagging schemes and makes stacking
> > > DSA switches downstream of CPSW impossible. Previous attempts to address
> > > the issue linked below.
> > > 
> > > Link: https://lore.kernel.org/netdev/20240227082815.2073826-1-s-vadapalli@ti.com/
> > > Link: https://lore.kernel.org/linux-arm-kernel/4699400.vD3TdgH1nR@localhost/
> > > Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > 
> > A Co-developed-by tag should be followed by a Signed-off-by tag of the
> > same individual.
> 
> You are right, thanks!
> 
> > > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> > > ---
> > > Changelog:
> > > v2: Thanks to Siddharth it does look much clearer now (conditionally clear
> > >      AM65_CPSW_CTL_VLAN_AWARE instead of setting)
> > > 
> > >   drivers/net/ethernet/ti/am65-cpsw-nuss.c | 18 ++++++++++++++----
> > >   1 file changed, 14 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > > index 5465bf872734..58c840fb7e7e 100644
> > > --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > > +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > > @@ -32,6 +32,7 @@
> > >   #include <linux/dma/ti-cppi5.h>
> > >   #include <linux/dma/k3-udma-glue.h>
> > >   #include <net/page_pool/helpers.h>
> > > +#include <net/dsa.h>
> > >   #include <net/switchdev.h>
> > >   
> > >   #include "cpsw_ale.h"
> > > @@ -724,13 +725,22 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
> > >   	u32 val, port_mask;
> > >   	struct page *page;
> > >   
> > > +	/* Control register */
> > > +	val = AM65_CPSW_CTL_P0_ENABLE | AM65_CPSW_CTL_P0_TX_CRC_REMOVE |
> > > +	      AM65_CPSW_CTL_VLAN_AWARE | AM65_CPSW_CTL_P0_RX_PAD;
> > > +	/* VLAN aware CPSW mode is incompatible with some DSA tagging schemes.
> > > +	 * Therefore disable VLAN_AWARE mode if any of the ports is a DSA Port.
> > > +	 */
> > > +	for (port_idx = 0; port_idx < common->port_num; port_idx++)
> > > +		if (netdev_uses_dsa(common->ports[port_idx].ndev)) {
> > > +			val &= ~AM65_CPSW_CTL_VLAN_AWARE;
> > > +			break;
> > > +		}
> > > +	writel(val, common->cpsw_base + AM65_CPSW_REG_CTL);
> > > +
> > >   	if (common->usage_count)
> > >   		return 0;
> > 
> > The changes above should be present HERE, i.e. below the
> > "common->usage_count" check, as was the case earlier.
> 
> It has been moved deliberately, consider first port is being brought up
> and only then the second port is being brought up (as part of
> dsa_conduit_setup(), which sets dev->dsa_ptr right before opening the
> port). As this isn't RMW operation and actually happens under RTNL lock,
> moving in front of "if" looks safe to me... What do you think?

I understand the issue now. Does the following work?

1. am65_cpsw_nuss_common_open() can be left as-is i.e. no changes to be
made.
2. Interfaces being brought up will invoke am65_cpsw_nuss_ndo_slave_open()
   which then invokes am65_cpsw_nuss_common_open().
3. Within am65_cpsw_nuss_ndo_slave_open(), immediately after the call to
   am65_cpsw_nuss_common_open() returns, clear AM65_CPSW_CTL_VLAN_AWARE
   bit within AM65_CPSW_REG_CTL register if the interface is DSA.

The patch then effectively is the DSA.h include plus the following diff:
------------------------------------------------------------------------------------------------
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 5465bf872734..7819a5674f9c 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1014,6 +1014,15 @@ static int am65_cpsw_nuss_ndo_slave_open(struct net_device *ndev)

        common->usage_count++;

+       /* VLAN aware CPSW mode is incompatible with some DSA tagging schemes.
+        * Therefore disable VLAN_AWARE mode if any of the ports is a DSA Port.
+        */
+       if (netdev_uses_dsa(port->ndev) {
+               reg = readl(common->cpsw_base + AM65_CPSW_REG_CTL);
+               reg &= ~AM65_CPSW_CTL_VLAN_AWARE;
+               writel(reg, common->cpsw_base + AM65_CPSW_REG_CTL);
+       }
+
        am65_cpsw_port_set_sl_mac(port, ndev->dev_addr);
        am65_cpsw_port_enable_dscp_map(port);
------------------------------------------------------------------------------------------------

> 
> > > -	/* Control register */
> > > -	writel(AM65_CPSW_CTL_P0_ENABLE | AM65_CPSW_CTL_P0_TX_CRC_REMOVE |
> > > -	       AM65_CPSW_CTL_VLAN_AWARE | AM65_CPSW_CTL_P0_RX_PAD,
> > > -	       common->cpsw_base + AM65_CPSW_REG_CTL);
> > >   	/* Max length register */
> > >   	writel(AM65_CPSW_MAX_PACKET_SIZE,
> > >   	       host_p->port_base + AM65_CPSW_PORT_REG_RX_MAXLEN);
> 

Regards,
Siddharth.

