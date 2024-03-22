Return-Path: <netdev+bounces-81315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8A1887295
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 19:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AE53B2468A
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 18:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B58562160;
	Fri, 22 Mar 2024 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOCWhua+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CDD6168B
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 18:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130847; cv=none; b=ndgzStD5TN6vxxxgPKZjSZykQ/LRho7pWuq5EjD8lYVGtS26cx3Oe1APmwfTaL0dpS7WsGVcSaMuv/ghXNKvcOV4mKg9rNMPPi5+kES3XUO9G5MvRI4n+i5f4rwp+qrZJNEKDTayaWoxIhqBSx4b4izA+Cqiax/14r/scYLE9JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130847; c=relaxed/simple;
	bh=VzNJWeT4LnretOp4dDd8oziKvUgCg2qAD7fQ35nmF6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKnEfvJJ1jp44gVr05/733e1w7hjeYvZMaAQ1RzHNU6JDrvXFwPJSfL1pkJyf3Fxgr9ye8cE3kkzgAI4V1ESQmA+cRzwZuN4wqEHzD5WlDRQKUln774nc1QcLqQ+KmU4i2Dl0AajPaKwjAQ2oPJDULxu5W7gAlnykZCIXZC/zBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOCWhua+; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51588f70d2dso2805651e87.3
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 11:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711130843; x=1711735643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2zXKuaZNdI00IAr7msu6NOJfwjZ0lEdYhP/02Vw3HFs=;
        b=aOCWhua+S206ASBpFWNjgjbHRYfpKSJ5hVFxM/Ytsy2SkYEKE4Uzag52zrZl2VZxDt
         isf6djF6cYLqNL9hLzmtUdq00rCiHIe+xswNoDesaZdu4zaOp29bnulSXWiRKFiKBPlc
         c/R5ZKSSDTm+hmW/88AZPD6vATFG7jcJrcbvdJ4I52QO4aNbYajltSkIIJ2yLeXjfAq+
         fQn4dS2r+RmRdi/2QLV2b5g/X3XIzVza5uSDAJzuRt0iZ5FujM5H5Qmoo0QKUy9z8YdC
         OfZXx/KFDdiLDZ8rwxz5j7NdTzX8lbakMrMk5zDFwECWaPXr249ZGO+ghgHcVKEV6GR+
         uSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711130843; x=1711735643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zXKuaZNdI00IAr7msu6NOJfwjZ0lEdYhP/02Vw3HFs=;
        b=LY25rNqisJIw7mFKJ3urW1Wli9D1Sjo/N+b/CUgTRMshrS63fwzwWc/tGW0EL3mbFm
         ecs27xPCvRHV5NwWgGgzmQhl08GtTrhxIPeqCvaHCzfpba9BRjo9KFSs7fe0uHr0h3Ho
         16+AB2hSAdqPxD8bkuIR06qoXPil2jyYhu9fsawAvZOzr0RtEx0afUIAZZvboQzyjv+H
         mRjaz58sMoUpM0jouwXGoK/7tDWs7ycnkjYdBaTPFe/4MHfl22Mw00vIAdrQw3PL/BUI
         Jx27APaFzqNMGxQ3n6gBfMKFykLQOj1xKeYt6YR6dVBBYsPxhEWYpuh5aB7z77j/eF8t
         avTA==
X-Forwarded-Encrypted: i=1; AJvYcCUCgnyJjHk6C/TvwX5SkF9NzKTeez9RXkUooQVj8E8Ior66EEXBprsSW90n0Q+ZL5A4h1qEkbaDX6KvkCeZrYSJ0QTrjvVc
X-Gm-Message-State: AOJu0YyUsnouZFT+u/7gt5z9jufyZMFFsZB1+WcYPw2YlA010k+PBhV2
	1Eab8scrNhrztm0yIf/62tSMRVE8llVN/DqDcpGroDrrtNiY0G7X
X-Google-Smtp-Source: AGHT+IHPa3w5TniaCGVB+KY3RKY8IbJ5sefPRkEjTH7QwmZPVKi/ZQHY0tQwcvJem4vCtJ+4eiU58A==
X-Received: by 2002:a19:741a:0:b0:515:9abe:6c46 with SMTP id v26-20020a19741a000000b005159abe6c46mr98273lfe.34.1711130843001;
        Fri, 22 Mar 2024 11:07:23 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id e7-20020a05651236c700b005158f6f5905sm1978lfs.81.2024.03.22.11.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 11:07:22 -0700 (PDT)
Date: Fri, 22 Mar 2024 21:07:19 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch, 
	hkallweit1@gmail.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 09/11] net: stmmac: dwmac-loongson: Fix half
 duplex
Message-ID: <fu3f6uoakylnb6eijllakeu5i4okcyqq7sfafhp5efaocbsrwe@w74xe7gb6x7p>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <3382be108772ce56fe3e9bb99c9c53b7e9cd6bad.1706601050.git.siyanteng@loongson.cn>
 <dp4fhkephitylrf6a3rygjeftqf4mwrlgcdasstrq2osans3zd@zyt6lc7nu2e3>
 <vostvybxawyhzmcnabnh7hsc7kk6vdxfdzqu4rkuqv6sdm7cuw@fd2y2o7di5am>
 <88c8f5a4-16c1-498b-9a2a-9ba04a9b0215@loongson.cn>
 <ZfF+IAWbe1rwx3Xs@shell.armlinux.org.uk>
 <cd8be3b1-fcfa-4836-9d28-ced735169615@loongson.cn>
 <em3r6w7ydvjxualqifjurtrrfpztpil564t5k5b4kxv4f6ddrd@4weteqhekyae>
 <Zfq8TNrt0KxW/IWh@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfq8TNrt0KxW/IWh@shell.armlinux.org.uk>

On Wed, Mar 20, 2024 at 10:37:00AM +0000, Russell King (Oracle) wrote:
> Serge,
> 
> Again, please learn to trim your replies.

Ok, got it.

> 
> On Wed, Mar 20, 2024 at 01:10:04PM +0300, Serge Semin wrote:
> ...
> > 
> > In general you are right for sure - it's better to avoid one part
> > setting capabilities and another part unsetting them at least from the
> > readability and maintainability point of view. But in this case we've
> > already got implemented a ready-to-use internal interface
> > stmmac_ops::phylink_get_caps() which can be used to extend/reduce the
> > capabilities field based on the particular MAC abilities. Moreover
> > it's called right from the component setting the capabilities. Are you
> > saying that the callback is supposed to be utilized for extending the
> > capabilities only?
> 
> What concerns me is that the proposed code _overwrites_ the
> capabilities from the MAC layer, so from a maintanability point of
> view it's a nightmare, because you will now have the situation where
> MACs provide their capabilities, and then platform code may overwrite
> it - which means it's like a spiders web trying to work out what
> capabilities are provided.
> 
> The reality is surely that the MAC dictates what it can do, but there
> may be further restrictions by other components in the platform, so
> the capabilities provided to phylink should be:
> 
> 	mac_capabilities & platform_capabilities
> 
> And what I'm proposing is that _that_ should be done in a way that
> makes it _easy_ for the platform code to get right. Overriding
> stmmac_ops::phylink_get_caps() doesn't do that - as can be seen in
> the proposed patch.
> 
> Help your users write correct code by adopting a structure that makes
> it easy for them to do the right thing.

Got it. Thanks for the detailed explanation. So you prefer not to
provide too much freedom in the interface to refrain the users from
unwillingly doing something wrong. Sounds very reasonable.

> 
> > If you insist on not overriding the stmmac_ops::phylink_get_caps()
> > anyway then please explain what is the principal difference
> > between the next two code snippets:
> > 	/* Get the MAC specific capabilities */
> >         stmmac_mac_phylink_get_caps(priv);
> > and
> > 	priv->phylink_config.mac_capabilities &= ~priv->plat->mac_caps_mask;
> 
> 
> I was thinking:
> 
> 	stmmac_mac_phylink_get_caps(priv);
> 
> 	if (priv->plat->mac_capabilities)
> 		priv->phylink_config.mac_capabilities &=
> 			priv->plat->mac_capabilities;
> 
> In other words, if a platform sets plat->mac_capabilities, then it is
> providing the capabilities that it supports, and those need to reduce
> the capabilities provided by the MAC.
> 
> This will _also_ allow stmmac_set_half_duplex() to do the right thing.
> Consider something in the platform side that doesn't allow half-duplex,
> but allows tx_queues_to_use == 1. That'll set the half-duplex modes
> when stmmac_set_half_duplex() is called, overriding what the platform
> supports.
> 
> Now that I look at the stmmac implementation, there's even more that
> is wrong. Consider plat->max_speed = 100, like
> arch/arc/boot/dts/axs10x_mb.dtsi sets. If stmmac_set_half_duplex()
> is called as it can be from stmmac_reinit_queues(), it'll enable
> 1000 half-duplex, despite the plat->max_speed = 100.

Right. Plus to that I found three more issues in the MAC-capabilities
detection code:
1. There is DW MAC100 (see dwmac100_core.c, dwmac100_dma.c), which
doesn't seem like supporting 1G speed, but stmmac_phy_setup() and
stmmac_set_half_duplex() enable the MAC_1000* capabilities anyway.
2. DW XGMAC doesn't support 10/100Mbps speed and half-duplex, but the
stmmac_phy_setup() and stmmac_set_half_duplex() methods set them up
anyway.
3. It seems that the Tx-queues-based constraint of the
half-duplex-ness is only specific for DW QoS Eth (DW GMAC v4/v5).
The databook explicitly says about that:
"In multi queue/channel configurations, enable only Q0/CH0 on Tx and
Rx for half-duplex operation. If you want to enable single
queue/channel in full-duplex operation, any queue/channel can be
enabled."
There is no such note in the DW GMAC v3.x databook.

At least first two problems look as bugs. The last note will be
interesting for Yanteng who has the multi-channel DW GMAC _v3_ device
with the half-duplex mode working for all channels. Therefore the
statement
        if (priv->plat->tx_queues_to_use > 1)
                priv->phylink_config.mac_capabilities &=
                        ~(MAC_10HD | MAC_100HD | MAC_1000HD);
        else
                priv->phylink_config.mac_capabilities |=
                        (MAC_10HD | MAC_100HD | MAC_1000HD);
won't be acceptable for his device.

> 
> > in the MAC-capabilities update implementation? Do you think the later
> > approach would be more descriptive? If so then would the
> > callback-based approach almost equally descriptive if the callback
> > name was, suppose, stmmac_mac_phylink_set_caps() or similar?
> 

> From what I can see of the existing stmmac MAC phylink_get_caps
> implementations, there seem to be two - xgmac_phylink_get_caps()
> and dwmac4_phylink_get_caps(). Both of these merely set additional
> modes in priv->phylink_config.mac_capabilities. Is there a reason
> to have this as an instruction stream, rather than providing data
> to the core stmmac code from the MAC about its capabilities? Is
> there a reason why it would be necessary for the code in a MAC backend
> to make a decision about what capabilities to enable based on some
> condition?

Seeing the Tx-queues-based constraint is DW QoS Eth-specific there is
such reason. It might be better to move the selective Half-duplex
mode disabling to the MAC-specific callback.

But based on what you already demonstrated in the following up email
messages there is a better option to implement the MAC capabilities
detection procedure. Let's see what MAC-capabilities can be currently
specified based on the DW MAC IP-core versions:

DW MAC100: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
	   MAC_10 | MAC_100

DW GMAC: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
         MAC_10 | MAC_100 | MAC_1000

DW QoS Eth: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
            MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD
but if the amount of the active Tx queues is > 1, then:
	   MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
           MAC_10FD | MAC_100FD | MAC_1000FD | MAC_2500FD 

DW XGMAC: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
          MAC_1000FD | MAC_2500FD | MAC_5000FD |
          MAC_10000FD | MAC_25000FD |
          MAC_40000FD | MAC_50000FD |
          MAC_100000FD

As you can see there are only two common capabilities:
MAC_ASYM_PAUSE | MAC_SYM_PAUSE. Seeing the flow-control is implemented
as a callback for each MAC IP-core (see dwmac100_flow_ctrl(),
dwmac1000_flow_ctrl(), sun8i_dwmac_flow_ctrl(), etc) we can freely
move all the PHYLINK MAC capabilities initializations to the
MAC-specific setup methods (similarly to what you already did in your
patch but specifying the full MAC capabilities list).

After that the only IP-core which requires the capabilities update will
be DW QoS Eth. So the Tx-queue-based capabilities update can be moved
there and the rest of the xgmac_phylink_get_caps() callback can be
dropped.

We can go further. Instead of calling the
stmmac_set_half_duplex()/stmmac_set_mac_capabilties() methods on the
device init and queues reinit stages, we can move their bodies into
the phylink:mac_get_caps() callback.

Here is what the described changes will look like:

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 721c1f8e892f..2339af32ac77 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -525,6 +525,7 @@ extern const struct stmmac_hwtimestamp stmmac_ptp;
 extern const struct stmmac_mode_ops dwmac4_ring_mode_ops;
 
 struct mac_link {
+	u32 caps;
 	u32 speed_mask;
 	u32 speed10;
 	u32 speed100;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 137741b94122..6bc18d4c4da9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -1097,6 +1097,8 @@ static struct mac_device_info *sun8i_dwmac_setup(void *ppriv)
 
 	priv->dev->priv_flags |= IFF_UNICAST_FLT;
 
+	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			 MAC_10 | MAC_100 | MAC_1000;
 	/* The loopback bit seems to be re-set when link change
 	 * Simply mask it each time
 	 * Speed 10/100/1000 are set in BIT(2)/BIT(3)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 3927609abc44..8555299443f4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -539,6 +539,8 @@ int dwmac1000_setup(struct stmmac_priv *priv)
 	if (mac->multicast_filter_bins)
 		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
 
+	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			 MAC_10 | MAC_100 | MAC_1000;
 	mac->link.duplex = GMAC_CONTROL_DM;
 	mac->link.speed10 = GMAC_CONTROL_PS;
 	mac->link.speed100 = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
index a6e8d7bd9588..7667d103cd0e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
@@ -175,6 +175,8 @@ int dwmac100_setup(struct stmmac_priv *priv)
 	dev_info(priv->device, "\tDWMAC100\n");
 
 	mac->pcsr = priv->ioaddr;
+	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			 MAC_10 | MAC_100;
 	mac->link.duplex = MAC_CONTROL_F;
 	mac->link.speed10 = 0;
 	mac->link.speed100 = 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 6b6d0de09619..c51dc946e8ef 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -70,7 +70,11 @@ static void dwmac4_core_init(struct mac_device_info *hw,
 
 static void dwmac4_phylink_get_caps(struct stmmac_priv *priv)
 {
-	priv->phylink_config.mac_capabilities |= MAC_2500FD;
+	/* Half-Duplex can only work with single tx queue */
+	if (priv->plat->tx_queues_to_use > 1)
+		priv->hw->link.caps &= ~(MAC_10HD | MAC_100HD | MAC_1000HD);
+	else
+		priv->hw->link.caps |= (MAC_10HD | MAC_100HD | MAC_1000HD);
 }
 
 static void dwmac4_rx_queue_enable(struct mac_device_info *hw,
@@ -1356,6 +1360,8 @@ int dwmac4_setup(struct stmmac_priv *priv)
 	if (mac->multicast_filter_bins)
 		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
 
+	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			 MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
 	mac->link.duplex = GMAC_CONFIG_DM;
 	mac->link.speed10 = GMAC_CONFIG_PS;
 	mac->link.speed100 = GMAC_CONFIG_FES | GMAC_CONFIG_PS;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index eb48211d9b0e..79ea8329ead5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -47,14 +47,6 @@ static void dwxgmac2_core_init(struct mac_device_info *hw,
 	writel(XGMAC_INT_DEFAULT_EN, ioaddr + XGMAC_INT_EN);
 }
 
-static void xgmac_phylink_get_caps(struct stmmac_priv *priv)
-{
-	priv->phylink_config.mac_capabilities |= MAC_2500FD | MAC_5000FD |
-						 MAC_10000FD | MAC_25000FD |
-						 MAC_40000FD | MAC_50000FD |
-						 MAC_100000FD;
-}
-
 static void dwxgmac2_set_mac(void __iomem *ioaddr, bool enable)
 {
 	u32 tx = readl(ioaddr + XGMAC_TX_CONFIG);
@@ -1618,6 +1610,11 @@ int dwxlgmac2_setup(struct stmmac_priv *priv)
 	if (mac->multicast_filter_bins)
 		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
 
+	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			 MAC_1000FD | MAC_2500FD | MAC_5000FD |
+			 MAC_10000FD | MAC_25000FD |
+			 MAC_40000FD | MAC_50000FD |
+			 MAC_100000FD;
 	mac->link.duplex = 0;
 	mac->link.speed1000 = XLGMAC_CONFIG_SS_1000;
 	mac->link.speed2500 = XLGMAC_CONFIG_SS_2500;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 25519952f754..24ff5d1eb963 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -936,6 +936,22 @@ static void stmmac_mac_flow_ctrl(struct stmmac_priv *priv, u32 duplex)
 			priv->pause, tx_cnt);
 }
 
+static unsigned long stmmac_mac_get_caps(struct phylink_config *config,
+					 phy_interface_t interface)
+{
+	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
+
+	/* Get the MAC-specific capabilities */
+	stmmac_mac_phylink_get_caps(priv);
+
+	config->mac_capabilities = priv->hw->link.caps;
+
+	if (priv->plat->max_speed)
+		phylink_limit_mac_speed(config, priv->plat->max_speed);
+
+	return config->mac_capabilities;
+}
+
 static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
 						 phy_interface_t interface)
 {
@@ -1105,6 +1121,7 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 }
 
 static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
+	.mac_get_caps = stmmac_mac_get_caps,
 	.mac_select_pcs = stmmac_mac_select_pcs,
 	.mac_config = stmmac_mac_config,
 	.mac_link_down = stmmac_mac_link_down,
@@ -1198,24 +1215,12 @@ static int stmmac_init_phy(struct net_device *dev)
 	return ret;
 }
 
-static void stmmac_set_half_duplex(struct stmmac_priv *priv)
-{
-	/* Half-Duplex can only work with single tx queue */
-	if (priv->plat->tx_queues_to_use > 1)
-		priv->phylink_config.mac_capabilities &=
-			~(MAC_10HD | MAC_100HD | MAC_1000HD);
-	else
-		priv->phylink_config.mac_capabilities |=
-			(MAC_10HD | MAC_100HD | MAC_1000HD);
-}
-
 static int stmmac_phy_setup(struct stmmac_priv *priv)
 {
 	struct stmmac_mdio_bus_data *mdio_bus_data;
 	int mode = priv->plat->phy_interface;
 	struct fwnode_handle *fwnode;
 	struct phylink *phylink;
-	int max_speed;
 
 	priv->phylink_config.dev = &priv->dev->dev;
 	priv->phylink_config.type = PHYLINK_NETDEV;
@@ -1236,19 +1241,6 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 		xpcs_get_interfaces(priv->hw->xpcs,
 				    priv->phylink_config.supported_interfaces);
 
-	priv->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
-						MAC_10FD | MAC_100FD |
-						MAC_1000FD;
-
-	stmmac_set_half_duplex(priv);
-
-	/* Get the MAC specific capabilities */
-	stmmac_mac_phylink_get_caps(priv);
-
-	max_speed = priv->plat->max_speed;
-	if (max_speed)
-		phylink_limit_mac_speed(&priv->phylink_config, max_speed);
-
 	fwnode = priv->plat->port_node;
 	if (!fwnode)
 		fwnode = dev_fwnode(priv->device);

---

Note I intentionally omitted the part with the platform-specific MAC
capabilities filtering because AFAICS it won't be necessary for
Yanteng. He'll have the plat_stmmacenet_data::setup() callback defined
anyway, in which he'll be able to initialize the MAC capabilities as
required by his platform.

-Serge(y)

> 
> > In anyway I am sure the approach suggested in the initial patch of
> > this thread isn't good since it motivates the developers to implement
> > more-and-more DW MAC-specific platform capabilities flags fixing
> > another flags, which makes the generic code even more complicated
> > than it already is with endless if-else-plat-flags statements.
> 
> Yes, I do agree with that.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

