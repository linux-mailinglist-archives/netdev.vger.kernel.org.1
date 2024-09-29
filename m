Return-Path: <netdev+bounces-130256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7928D989844
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 00:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C19FB22220
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 22:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B805314389F;
	Sun, 29 Sep 2024 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV01UXUA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985744C69
	for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727648225; cv=none; b=I2YLXJqqvMN1F2IFKYcK/PW6DmqtpGbGcLk/rjtKnq+lyRlZpYIYqzGj/GADuQYk3nZcPr42p6fWCXcBQsdc1jHqllmz9nHnna8o5Myr3a4T78x7Vu27fF1DNNOUpdZYi1FsrZrS1gignu9ZWlCgWK5T1iUXnyUd1QndvvKwSPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727648225; c=relaxed/simple;
	bh=48H4fxqxU4LVk4a9IGYsFEQKUFzhXL6EIZajqkJ1BeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhrdFl83IzD3I7Kj42WEAKfvkWpkHx/IPvEekCAIJyodkn9fbCN9tH6H3EFtkSDg6Gs4xhkdph5QvV1Q0NLxqnJZ8HAGS7OyWU4mwWZD8SWc7W5zWwcg4fQG3jaAANZmU6v6FZJ4plkGmThc8Z5wqe9iIdxzUN5Cozq2ViVx8bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV01UXUA; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5398b589032so1926767e87.1
        for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 15:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727648222; x=1728253022; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Izjhl0v5dQtj10Rwrq+MMgX7BNnDMZ1O7QMpOTgx4B0=;
        b=KV01UXUAwdP0EGG3zJ4wW2IGpZvi4ex9NX98OEyEGZJsTE8/te2KHt/vdh7MJh2UFM
         JFbEj6IG3gg5W/LRO169C5QhuZiDpvZCG2eePdhVn8woH4zG6CXQKIvpepcqA18vc/9B
         dcPgrQuSH3M9ZpM0Eif7bXtqmo90B9o/5CymnlzzsYbQztBTPxHZE+yuSrCGZrtNYMeH
         bhmFJpiPJW1rGtONDYTOqVQtxbDhr3Dpth22h/fcw0MBQgAdpqERI7u7GWwGyMZ2LZd6
         oEAUXcKKSgGi84GailYEQgBqA20ZkbQ66hMQbhlH0/u38k0j5gUC6Hj2JBishxSQnduv
         r5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727648222; x=1728253022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Izjhl0v5dQtj10Rwrq+MMgX7BNnDMZ1O7QMpOTgx4B0=;
        b=a7Jwj0TAFZiSolksgikOo7z2/pqJSkk9Z8yMnRHXwQzfGb/8EYJOU8rUj9JxKREJVl
         hq4kVlpDX8K041vmuK4VojguNUVaDsCsJIan/rXpxdNjsSWUGKybslZsV0DTnAMtHHIA
         yVFmgJV/eIpjVL9InheyFcTTN9KZqr3f4gW6KoI/v6X/jiO0X48FiIktLyXh+13bWsi1
         B5pbvwW8CglUBKOJRmGS0ToHTrrQY61uzr5Ph1vqcA9nN74lQbj9SBpTIk/l7gJQreB2
         td3ykGy/NYj83qx7vR6L4PEd5OV5ExV6Xzdv70NMIv1STzsgd17mjB7H+F1zuLXqC1in
         RVTw==
X-Forwarded-Encrypted: i=1; AJvYcCWsgNkYh2K3MDdTAIXQDr34U/VB7GpUqaznBRxK1BGRZx0+0bU4iNJ7woDWn0Y17gFQ6/oOlR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzzfQcIFnZNfb3pvmqCKoMyIosE5JapNdJkAjYesdaLY02mnUr
	p4EOZF76vW+sLwPc2r8cf0R3WpX0C5D5BAYzXrLjil+kOKK1zcjn
X-Google-Smtp-Source: AGHT+IGJFBiQwOYIBwnmbXy03wwvtaYZedINXriwaRz02O6V+MX1nNzxgLqqd3FtA6MRfZx3wm133g==
X-Received: by 2002:a05:6512:31c1:b0:536:5625:511f with SMTP id 2adb3069b0e04-5389fc7d145mr6470661e87.45.1727648221168;
        Sun, 29 Sep 2024 15:17:01 -0700 (PDT)
Received: from mobilestation ([95.79.225.241])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a044154asm1036056e87.261.2024.09.29.15.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 15:17:00 -0700 (PDT)
Date: Mon, 30 Sep 2024 01:16:57 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Jose Abreu <joabreu@synopsys.com>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH RFC net-next 01/10] net: pcs: xpcs: move PCS reset to
 .pcs_pre_config()
Message-ID: <mykeabksgikgk6otbub2i3ksfettbozuhqy3gt5vyezmemvttg@cpjn5bcfiwei>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
 <E1ssjcZ-005Nrf-QL@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zw667ru7dw37dqxv"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1ssjcZ-005Nrf-QL@rmk-PC.armlinux.org.uk>


--zw667ru7dw37dqxv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Russell

On Mon, Sep 23, 2024 at 03:00:59PM GMT, Russell King (Oracle) wrote:
> Move the PCS reset to .pcs_pre_config() rather than at creation time,
> which means we call the reset function with the interface that we're
> actually going to be using to talk to the downstream device.

The PCS-reset procedure actually can be converted to being independent
from the PHY-interface. Thus you won't need to move the PCS resetting
to the pre_config() method, and get rid from the pointer to
dw_xpcs_compat utilization each time the reset is required.
Please see the attached patch for details.*

* I was going to submit it as a part of a one more XPCS-related series,
but seeing my work interfere with yours I'll hold on with sending my
patch set for until yours is merged in.

> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/pcs/pcs-xpcs.c   | 39 +++++++++++++++++++++++++++---------
>  include/linux/pcs/pcs-xpcs.h |  1 +
>  2 files changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index 82463f9d50c8..7c6c40ddf722 100644
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c
> @@ -659,6 +659,30 @@ int xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns, int enable)
>  }
>  EXPORT_SYMBOL_GPL(xpcs_config_eee);
>  
> +static void xpcs_pre_config(struct phylink_pcs *pcs, phy_interface_t interface)
> +{
> +	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
> +	const struct dw_xpcs_compat *compat;
> +	int ret;
> +
> +	if (!xpcs->need_reset)
> +		return;
> +

> +	compat = xpcs_find_compat(xpcs->desc, interface);
> +	if (!compat) {
> +		dev_err(&xpcs->mdiodev->dev, "unsupported interface %s\n",
> +			phy_modes(interface));
> +		return;
> +	}

Please note, it's better to preserve the xpcs_find_compat() call even
if the need_reset flag is false, since it makes sure that the
PHY-interface is actually supported by the PCS.

> +
> +	ret = xpcs_soft_reset(xpcs, compat);
> +	if (ret)
> +		dev_err(&xpcs->mdiodev->dev, "soft reset failed: %pe\n",
> +			ERR_PTR(ret));
> +
> +	xpcs->need_reset = false;
> +}
> +
>  static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
>  				      unsigned int neg_mode)
>  {
> @@ -1365,6 +1389,7 @@ static const struct dw_xpcs_desc xpcs_desc_list[] = {
>  
>  static const struct phylink_pcs_ops xpcs_phylink_ops = {
>  	.pcs_validate = xpcs_validate,
> +	.pcs_pre_config = xpcs_pre_config,
>  	.pcs_config = xpcs_config,
>  	.pcs_get_state = xpcs_get_state,
>  	.pcs_an_restart = xpcs_an_restart,
> @@ -1460,18 +1485,12 @@ static int xpcs_init_id(struct dw_xpcs *xpcs)
>  
>  static int xpcs_init_iface(struct dw_xpcs *xpcs, phy_interface_t interface)
>  {
> -	const struct dw_xpcs_compat *compat;
> -
> -	compat = xpcs_find_compat(xpcs->desc, interface);
> -	if (!compat)
> -		return -EINVAL;
> -
> -	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
> +	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
>  		xpcs->pcs.poll = false;
> -		return 0;
> -	}
> +	else
> +		xpcs->need_reset = true;
>  
> -	return xpcs_soft_reset(xpcs, compat);
> +	return 0;
>  }
>  
>  static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
> diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
> index b4a4eb6c8866..fd75d0605bb6 100644
> --- a/include/linux/pcs/pcs-xpcs.h
> +++ b/include/linux/pcs/pcs-xpcs.h
> @@ -61,6 +61,7 @@ struct dw_xpcs {
>  	struct clk_bulk_data clks[DW_XPCS_NUM_CLKS];
>  	struct phylink_pcs pcs;
>  	phy_interface_t interface;

> +	bool need_reset;

If you still prefer the PCS-reset being done in the pre_config()
function, then what about just directly checking the PMA id in there?

	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
		return 0;

	return xpcs_soft_reset(xpcs);

-Serge(y)

>  };
>  
>  int xpcs_get_an_mode(struct dw_xpcs *xpcs, phy_interface_t interface);
> -- 
> 2.30.2
> 
> 

--zw667ru7dw37dqxv
Content-Type: text/x-patch; charset=iso-8859-1
Content-Disposition: attachment;
	filename="0001-net-pcs-xpcs-Drop-compat-arg-from-soft-reset-method.patch"
Content-Transfer-Encoding: 8bit

From 7e36cef5d954cc17586194b8e0b3c58fe0dfe592 Mon Sep 17 00:00:00 2001
From: Serge Semin <fancer.lancer@gmail.com>
Date: Tue, 4 Jul 2023 12:39:29 +0300
Subject: [PATCH] net: pcs: xpcs: Drop compat arg from soft-reset method
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It's very much inconvenient to have the soft-reset method requiring the
xpcs_compat structure instance passed. The later one is found based on the
PHY-interface type which isn't always available. Such design makes an
ordinary reset-method context depended and unnecessary limits its usage
area. Indeed based on [1,2] all Soft-RST flags exported by the PMA/PMD,
PCS, AN or MII MMDs are _shared_. It means it resets all the DWX_xpcs
internal blocks including CSRs, but except the Management Interface (MDIO,
MCI, APB). Thus it doesn't really matter which MMDs soft-reset flag is
set, the result will be the same. So the AN-mode-depended code can be
freely dropped from the soft-reset method. But depending on the DW XPCS
device capabilities (basically it depends on the IP-core synthesize
parameters) it can lack some of the MMDs. In order to solve that
difficulty the Vendor-Specific 1 MMD can be utilized. It is also called as
Control MMD and exports some generic device info about the device
including a list of the available MMDs: PMA/PMD, XS/PCS, AN or MII. This
MMD persists on all the DW XPCS device [3]. Thus it can be freely utilize
to cross-platformly determine actual MMD to perform the soft-reset.

[1] DesignWare® Cores Ethernet PCS, Version 3.11b, June 2015, p.111.
[2] DesignWare® Cores Ethernet PCS, Version 3.11b, June 2015, p.268.
[3] DesignWare® Cores Ethernet PCS, Version 3.11b, June 2015, p.269.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/pcs/pcs-xpcs.c   | 31 ++++++++++++++++---------------
 drivers/net/pcs/pcs-xpcs.h   |  7 +++++++
 include/linux/pcs/pcs-xpcs.h |  1 +
 3 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 014ca2b067f4..81c166726636 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -271,24 +271,18 @@ static int xpcs_poll_reset(struct dw_xpcs *xpcs, int dev)
 	return (ret & MDIO_CTRL1_RESET) ? -ETIMEDOUT : 0;
 }
 
-static int xpcs_soft_reset(struct dw_xpcs *xpcs,
-			   const struct dw_xpcs_compat *compat)
+static int xpcs_soft_reset(struct dw_xpcs *xpcs)
 {
 	int ret, dev;
 
-	switch (compat->an_mode) {
-	case DW_AN_C73:
-	case DW_10GBASER:
-		dev = MDIO_MMD_PCS;
-		break;
-	case DW_AN_C37_SGMII:
-	case DW_2500BASEX:
-	case DW_AN_C37_1000BASEX:
+	if (xpcs->mmd_ctrl & DW_SR_CTRL_MII_MMD_EN)
 		dev = MDIO_MMD_VEND2;
-		break;
-	default:
+	else if (xpcs->mmd_ctrl & DW_SR_CTRL_PCS_XS_MMD_EN)
+		dev = MDIO_MMD_PCS;
+	else if (xpcs->mmd_ctrl & DW_SR_CTRL_PMA_MMD_EN)
+		dev = MDIO_MMD_PMAPMD;
+	else
 		return -EINVAL;
-	}
 
 	ret = xpcs_write(xpcs, dev, MDIO_CTRL1, MDIO_CTRL1_RESET);
 	if (ret < 0)
@@ -935,7 +929,7 @@ static int xpcs_get_state_c73(struct dw_xpcs *xpcs,
 	/* ... and then we check the faults. */
 	ret = xpcs_read_fault_c73(xpcs, state, pcs_stat1);
 	if (ret) {
-		ret = xpcs_soft_reset(xpcs, compat);
+		ret = xpcs_soft_reset(xpcs);
 		if (ret)
 			return ret;
 
@@ -1485,17 +1479,24 @@ static int xpcs_init_id(struct dw_xpcs *xpcs)
 static int xpcs_init_iface(struct dw_xpcs *xpcs, phy_interface_t interface)
 {
 	const struct dw_xpcs_compat *compat;
+	int ret;
 
 	compat = xpcs_find_compat(xpcs->desc, interface);
 	if (!compat)
 		return -EINVAL;
 
+	ret = xpcs_read(xpcs, MDIO_MMD_VEND1, DW_SR_CTRL_MMD_CTRL);
+	if (ret < 0)
+		return ret;
+
+	xpcs->mmd_ctrl = ret;
+
 	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
 		xpcs->pcs.poll = false;
 		return 0;
 	}
 
-	return xpcs_soft_reset(xpcs, compat);
+	return xpcs_soft_reset(xpcs);
 }
 
 static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index fa05adfae220..774b71801cc0 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -52,6 +52,13 @@
 #define DW_C73_2500KX			BIT(0)
 #define DW_C73_5000KR			BIT(1)
 
+/* VR_CTRL_MMD */
+#define DW_SR_CTRL_MMD_CTRL		0x0009
+#define DW_SR_CTRL_AN_MMD_EN		BIT(0)
+#define DW_SR_CTRL_PCS_XS_MMD_EN	BIT(1)
+#define DW_SR_CTRL_MII_MMD_EN		BIT(2)
+#define DW_SR_CTRL_PMA_MMD_EN		BIT(3)
+
 /* Clause 37 Defines */
 /* VR MII MMD registers offsets */
 #define DW_VR_MII_MMD_CTRL		0x0000
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index b4a4eb6c8866..241a1a959406 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -59,6 +59,7 @@ struct dw_xpcs {
 	const struct dw_xpcs_desc *desc;
 	struct mdio_device *mdiodev;
 	struct clk_bulk_data clks[DW_XPCS_NUM_CLKS];
+	u16 mmd_ctrl;
 	struct phylink_pcs pcs;
 	phy_interface_t interface;
 };
-- 
2.46.1


--zw667ru7dw37dqxv--

