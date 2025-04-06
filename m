Return-Path: <netdev+bounces-179486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F1BA7D0F7
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 00:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5265188D6D7
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 22:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41D12222A1;
	Sun,  6 Apr 2025 22:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4rj3QJL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F915221DAA;
	Sun,  6 Apr 2025 22:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743977708; cv=none; b=RasXTnPUUrfu15p9QZ/lAGu/W7LVFtENN2cu+Sj7hqySlOUJ1oqWp22hQJEvjU2anCOD3em6QmnKsH7N1oARvIYYpgdxsiWEVl2+vUU6PGOqGYwF0vHDzf+bGQxdtbtsMRAfD2OdTdRC6a18rVVI7Ot7fYfa7XIKq7Up5NgcVIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743977708; c=relaxed/simple;
	bh=zfd4jbikPvp5WfShDl+0Bt53/4htQ4XPTw6B0AvzUl8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQ/uf/9wnSH8HcQHAr0CViF9brH/BGLyoEsXGr9PrKGtLQAIIkr0Q345LRxx3GrtsQ7DYrZlhc0sBZ8Znq+Zh7q/xn/SKPNSjNrjRBqRrDH7FbZRgUZUCH3DD//9FlQ11XHtZp1sIPwCKtlJ98D6L3TXdasaqzdsYbDocuOheIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4rj3QJL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso40668885e9.0;
        Sun, 06 Apr 2025 15:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743977705; x=1744582505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5SVzT3jCIpt/kTPAnKwWGxsSgtoaKNGf4OiBXndvyMw=;
        b=H4rj3QJLkMJNKw0b05LrNUuvYOtJbHOV7CLVWKVdgJFL2+qnqp+GTOsA/WwMomIx/B
         MBzTu9DHZegKrfANW/AeWfe/psxBOrjUwLM1CbShpa8O7jA1aJFYdLKVqJsBqvK3svZs
         5HiWB0WPBAfe19C7lsIzVm1UJr4dw5gPz15z46/Pyu5N+rrnfTmuLFCpX7MF9LJcQLeH
         s8+5pVcUy20tkuFq6kVmFM+QOnniC6u2BrKIbMO4v6YvVSJHvf/gVH0kuuwhWvFp6D6r
         2gOhie/JfznJ80xFCeH+YQBr9ZX0XsO9RwwVRzlKqMMQ/nSWo6tZb2kDCyOboO0kvnGE
         HuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743977705; x=1744582505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SVzT3jCIpt/kTPAnKwWGxsSgtoaKNGf4OiBXndvyMw=;
        b=EObn5aad8tPAXt6FZ8jkyAXSF+Uvk3cowil2kS0xJf+yTa1dKYSmo4mRLAEUumUA7I
         FRzXjPjIjmdHVDGF9MmHfjmBNZLzfFM01sWtDbd/NTXfsHc4CGWg7PSbFC/Iu9ysbW7G
         sy4Zmo9DNaOxBOji0zU7Un4ByOW70hfC79+LSqjeF2sTbxURdsxKP/FjmelmCUQTDmkh
         /9PLv3I+MP8w/BgNGkCrBn/QoOtS2dbkK1tTvv0dtgEr30H2y6FPJcVMf8O92V9su7dw
         3StAVKPYcEI8vsJkJVNlIBSJIYt8T8MlDwVFh0blYIVJxxQWl4hpZKl9Oe6haU+Cfvp1
         LuyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO9cncB/2+OxXhIZx2tHDgSR5xjVs6/Uiy4IJyZWV79hDJ80K5OacPPa3DGWTMualdT/yeYLMjefM/@vger.kernel.org, AJvYcCUiKDQjGPv/yeMB8Av4OtdhyoelPZHvXFI0rVAto4swkBcpNzcT9tZGnYnp6vNNzhMnlQ9mauG0/pbWs9N6@vger.kernel.org, AJvYcCX9HUnf9r1V2aqtxuy9gauJX/1wmBjTU06unoSoNFYeIcC2sEl3p0WP7iJLEVDTSQk6QvrARpk0@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwh2UNnUhptrLh3ZobhIFI9/6ly1Ax1lzfzx6+J5xAh6W4D6KD
	Zf0zzZU6ObPxOEdTUkBnH9Y4MwuTVbbTH+2ykOKPzNdGakLTufo/
X-Gm-Gg: ASbGncvpyCrT8/NLd8i4JqQTrl9j3xAHTEgY6WnQ5zCpm0fr8JQYARPfqwBTjnptsVj
	R/bVOr0IonAFeEGwcyfXkBhtFfSAGd9GQEro/eJN7cZCaTeIIi5kfWbbMmdO5dUnh6Po0iFuvQO
	dnlydybsJQVvzWpCoXtay/XHUQfThcfi9k4UMeq+O3vCaKCXXurLi7+yVieZBOeI+ELy7vJ1Mji
	EN4b2jjqAb1sSF6+z2A1rr/EoeWFKuX704AylWhsdvVJFkhx6kt22p0p1yh2HKgWA/4YxcynifF
	r4W5aZcs/kM9wtUIuRdf878LP56dLRRYBYuDDm9f6IVEzVY6ah+2UeLkKqByJHLWTMUh/5z0b/J
	BIAtPPrRZgaPUqg==
X-Google-Smtp-Source: AGHT+IFhhEBdDIehuxH/183ggtu2Kb0/mVb91yA/cUDjgY3KEJVITCWD/N41eSwqTm2RsECbNT7+qA==
X-Received: by 2002:adf:b644:0:b0:39c:1257:cd40 with SMTP id ffacd0b85a97d-39d14663109mr5731160f8f.58.1743977704555;
        Sun, 06 Apr 2025 15:15:04 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ec366aa29sm111517055e9.39.2025.04.06.15.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 15:15:04 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	"Lei Wei (QUIC)" <quic_leiwei@quicinc.com>
Subject: [RFC PATCH net-next v2 04/11] net: phylink: introduce internal phylink PCS handling
Date: Mon,  7 Apr 2025 00:13:57 +0200
Message-ID: <20250406221423.9723-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250406221423.9723-1-ansuelsmth@gmail.com>
References: <20250406221423.9723-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce internal handling of PCS for phylink. This is an alternative
to .mac_select_pcs that moves the selection logic of the PCS entirely to
phylink with the usage of supported_interface value in the PCS struct.

MAC should now provide an array of available PCS in phylink_config in
.available_pcs and fill the .num_available_pcs with the number of
elements in the array. MAC should also define a new bitmap,
pcs_interfaces, in phylink_config to define for what interface mode a
dedicated PCS is required.

On phylink_create() this array is parsed and a linked list of PCS is
created based on the PCS passed in phylink_config.
Also the supported_interface value in phylink struct is updated with the
new supported_interface from the provided PCS.

On phylink_start() every PCS in phylink PCS list gets attached to the
phylink instance. This is done by setting the phylink value in
phylink_pcs struct to the phylink instance.

On phylink_stop(), every PCS in phylink PCS list is detached from the
phylink instance. This is done by setting the phylink value in
phylink_pcs struct to NULL.

On phylink_stop(), every PCS in phylink PCS list is removed from the
list.

phylink_validate_mac_and_pcs(), phylink_major_config() and
phylink_inband_caps() are updated to support this new implementation
with the PCS list stored in phylink.

They will make use of phylink_validate_pcs_interface() that will loop
for every PCS in the phylink PCS available list and find one that supports
the passed interface.

phylink_validate_pcs_interface() apply the same logic of .mac_select_pcs
where if a supported_interface value is not set for the PCS struct, then
it's assumed every interface is supported.

It's required for a MAC that implement either a .mac_select_pcs or make
use of the PCS list implementation. Implementing both will result in a fail
on MAC/PCS validation.

phylink value in phylink_pcs struct with this implementation is used to
track from PCS side when it's attached to a phylink instance. PCS driver
will make use of this information to correctly detach from a phylink
instance if needed.

The .mac_select_pcs implementation is not changed but it's expected that
every MAC driver migrates to the new implementation to later deprecate
and remove .mac_select_pcs.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 147 +++++++++++++++++++++++++++++++++-----
 include/linux/phylink.h   |  10 +++
 2 files changed, 139 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 6a7d6e3768da..f889fced379d 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -66,6 +66,9 @@ struct phylink {
 	/* The link configuration settings */
 	struct phylink_link_state link_config;
 
+	/* List of available PCS */
+	struct list_head pcs_list;
+
 	/* What interface are supported by the current link.
 	 * Can change on removal or addition of new PCS.
 	 */
@@ -150,6 +153,8 @@ static const phy_interface_t phylink_sfp_interface_preference[] = {
 
 static DECLARE_PHY_INTERFACE_MASK(phylink_sfp_interfaces);
 
+static void phylink_run_resolve(struct phylink *pl);
+
 /**
  * phylink_set_port_modes() - set the port type modes in the ethtool mask
  * @mask: ethtool link mode mask
@@ -505,22 +510,59 @@ static void phylink_validate_mask_caps(unsigned long *supported,
 	linkmode_and(state->advertising, state->advertising, mask);
 }
 
+static int phylink_validate_pcs_interface(struct phylink_pcs *pcs,
+					  phy_interface_t interface)
+{
+	/* If PCS define an empty supported_interfaces value, assume
+	 * all interface are supported.
+	 */
+	if (phy_interface_empty(pcs->supported_interfaces))
+		return 0;
+
+	/* Ensure that this PCS supports the interface mode */
+	if (!test_bit(interface, pcs->supported_interfaces))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int phylink_validate_mac_and_pcs(struct phylink *pl,
 					unsigned long *supported,
 					struct phylink_link_state *state)
 {
-	struct phylink_pcs *pcs = NULL;
 	unsigned long capabilities;
+	struct phylink_pcs *pcs;
+	bool pcs_found = false;
 	int ret;
 
 	/* Get the PCS for this interface mode */
 	if (pl->mac_ops->mac_select_pcs) {
+		/* Make sure either PCS internal validation or .mac_select_pcs
+		 * is used. Return error if both are defined.
+		 */
+		if (!list_empty(&pl->pcs_list)) {
+			phylink_err(pl, "either phylink_pcs_add() or .mac_select_pcs must be used\n");
+			return -EINVAL;
+		}
+
 		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
 		if (IS_ERR(pcs))
 			return PTR_ERR(pcs);
+
+		pcs_found = !!pcs;
+	} else {
+		/* Check every assigned PCS and search for one that supports
+		 * the interface.
+		 */
+		list_for_each_entry(pcs, &pl->pcs_list, list) {
+			if (!phylink_validate_pcs_interface(pcs, state->interface)) {
+				pcs_found = true;
+				break;
+			}
+		}
 	}
 
-	if (pcs) {
+	if (pcs_found) {
 		/* The PCS, if present, must be setup before phylink_create()
 		 * has been called. If the ops is not initialised, print an
 		 * error and backtrace rather than oopsing the kernel.
@@ -532,13 +574,10 @@ static int phylink_validate_mac_and_pcs(struct phylink *pl,
 			return -EINVAL;
 		}
 
-		/* Ensure that this PCS supports the interface which the MAC
-		 * returned it for. It is an error for the MAC to return a PCS
-		 * that does not support the interface mode.
-		 */
-		if (!phy_interface_empty(pcs->supported_interfaces) &&
-		    !test_bit(state->interface, pcs->supported_interfaces)) {
-			phylink_err(pl, "MAC returned PCS which does not support %s\n",
+		/* Recheck PCS to handle legacy way for .mac_select_pcs */
+		ret = phylink_validate_pcs_interface(pcs, state->interface);
+		if (ret) {
+			phylink_err(pl, "selected PCS does not support %s\n",
 				    phy_modes(state->interface));
 			return -EINVAL;
 		}
@@ -943,12 +982,22 @@ static unsigned int phylink_inband_caps(struct phylink *pl,
 					 phy_interface_t interface)
 {
 	struct phylink_pcs *pcs;
+	bool pcs_found = false;
 
-	if (!pl->mac_ops->mac_select_pcs)
-		return 0;
+	if (pl->mac_ops->mac_select_pcs) {
+		pcs = pl->mac_ops->mac_select_pcs(pl->config,
+						  interface);
+		pcs_found = !!pcs;
+	} else {
+		list_for_each_entry(pcs, &pl->pcs_list, list) {
+			if (!phylink_validate_pcs_interface(pcs, interface)) {
+				pcs_found = true;
+				break;
+			}
+		}
+	}
 
-	pcs = pl->mac_ops->mac_select_pcs(pl->config, interface);
-	if (!pcs)
+	if (!pcs_found)
 		return 0;
 
 	return phylink_pcs_inband_caps(pcs, interface);
@@ -1234,10 +1283,36 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 			pl->major_config_failed = true;
 			return;
 		}
+	/* Find a PCS in available PCS list for the requested interface.
+	 * This doesn't overwrite the previous .mac_select_pcs as either
+	 * .mac_select_pcs or PCS list implementation are permitted.
+	 *
+	 * Skip searching if the MAC doesn't require a dedicaed PCS for
+	 * the requested interface.
+	 */
+	} else if (test_bit(state->interface, pl->config->pcs_interfaces)) {
+		bool pcs_found = false;
+
+		list_for_each_entry(pcs, &pl->pcs_list, list) {
+			if (!phylink_validate_pcs_interface(pcs,
+							    state->interface)) {
+				pcs_found = true;
+				break;
+			}
+		}
+
+		if (!pcs_found) {
+			phylink_err(pl,
+				    "couldn't find a PCS for %s\n",
+				    phy_modes(state->interface));
 
-		pcs_changed = pl->pcs != pcs;
+			pl->major_config_failed = true;
+			return;
+		}
 	}
 
+	pcs_changed = pl->pcs != pcs;
+
 	phylink_pcs_neg_mode(pl, pcs, state->interface, state->advertising);
 
 	phylink_dbg(pl, "major config, active %s/%s/%s\n",
@@ -1264,10 +1339,12 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 	if (pcs_changed) {
 		phylink_pcs_disable(pl->pcs);
 
-		if (pl->pcs)
-			pl->pcs->phylink = NULL;
+		if (pl->mac_ops->mac_select_pcs) {
+			if (pl->pcs)
+				pl->pcs->phylink = NULL;
 
-		pcs->phylink = pl;
+			pcs->phylink = pl;
+		}
 
 		pl->pcs = pcs;
 	}
@@ -1803,8 +1880,9 @@ struct phylink *phylink_create(struct phylink_config *config,
 			       phy_interface_t iface,
 			       const struct phylink_mac_ops *mac_ops)
 {
+	struct phylink_pcs *pcs;
 	struct phylink *pl;
-	int ret;
+	int i, ret;
 
 	/* Validate the supplied configuration */
 	if (phy_interface_empty(config->supported_interfaces)) {
@@ -1819,9 +1897,21 @@ struct phylink *phylink_create(struct phylink_config *config,
 
 	mutex_init(&pl->state_mutex);
 	INIT_WORK(&pl->resolve, phylink_resolve);
+	INIT_LIST_HEAD(&pl->pcs_list);
+
+	/* Fill the PCS list with available PCS from phylink config */
+	for (i = 0; i < config->num_available_pcs; i++) {
+		pcs = config->available_pcs[i];
+
+		list_add(&pcs->list, &pl->pcs_list);
+	}
 
 	phy_interface_copy(pl->supported_interfaces,
 			   config->supported_interfaces);
+	list_for_each_entry(pcs, &pl->pcs_list, list)
+		phy_interface_or(pl->supported_interfaces,
+				 pl->supported_interfaces,
+				 pcs->supported_interfaces);
 
 	pl->config = config;
 	if (config->type == PHYLINK_NETDEV) {
@@ -1900,10 +1990,16 @@ EXPORT_SYMBOL_GPL(phylink_create);
  */
 void phylink_destroy(struct phylink *pl)
 {
+	struct phylink_pcs *pcs, *tmp;
+
 	sfp_bus_del_upstream(pl->sfp_bus);
 	if (pl->link_gpio)
 		gpiod_put(pl->link_gpio);
 
+	/* Remove every PCS from phylink PCS list */
+	list_for_each_entry_safe(pcs, tmp, &pl->pcs_list, list)
+		list_del(&pcs->list);
+
 	cancel_work_sync(&pl->resolve);
 	kfree(pl);
 }
@@ -2380,6 +2476,7 @@ static irqreturn_t phylink_link_handler(int irq, void *data)
  */
 void phylink_start(struct phylink *pl)
 {
+	struct phylink_pcs *pcs;
 	bool poll = false;
 
 	ASSERT_RTNL();
@@ -2406,6 +2503,10 @@ void phylink_start(struct phylink *pl)
 
 	pl->pcs_state = PCS_STATE_STARTED;
 
+	/* link available PCS to phylink struct */
+	list_for_each_entry(pcs, &pl->pcs_list, list)
+		pcs->phylink = pl;
+
 	phylink_enable_and_run_resolve(pl, PHYLINK_DISABLE_STOPPED);
 
 	if (pl->cfg_link_an_mode == MLO_AN_FIXED && pl->link_gpio) {
@@ -2450,6 +2551,8 @@ EXPORT_SYMBOL_GPL(phylink_start);
  */
 void phylink_stop(struct phylink *pl)
 {
+	struct phylink_pcs *pcs;
+
 	ASSERT_RTNL();
 
 	if (pl->sfp_bus)
@@ -2467,6 +2570,14 @@ void phylink_stop(struct phylink *pl)
 	pl->pcs_state = PCS_STATE_DOWN;
 
 	phylink_pcs_disable(pl->pcs);
+
+	/* Drop link between phylink and PCS */
+	list_for_each_entry(pcs, &pl->pcs_list, list)
+		pcs->phylink = NULL;
+
+	/* Restore original supported interfaces */
+	phy_interface_copy(pl->supported_interfaces,
+			   pl->config->supported_interfaces);
 }
 EXPORT_SYMBOL_GPL(phylink_stop);
 
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 1f5773ab5660..7d69e6a44f68 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -150,12 +150,16 @@ enum phylink_op_type {
  *		     if MAC link is at %MLO_AN_FIXED mode.
  * @supported_interfaces: bitmap describing which PHY_INTERFACE_MODE_xxx
  *                        are supported by the MAC/PCS.
+ * @pcs_interfaces: bitmap describing for which PHY_INTERFACE_MODE_xxx a
+ *		    dedicated PCS is required.
  * @lpi_interfaces: bitmap describing which PHY interface modes can support
  *		    LPI signalling.
  * @mac_capabilities: MAC pause/speed/duplex capabilities.
  * @lpi_capabilities: MAC speeds which can support LPI signalling
  * @lpi_timer_default: Default EEE LPI timer setting.
  * @eee_enabled_default: If set, EEE will be enabled by phylink at creation time
+ * @available_pcs: array of available phylink_pcs PCS
+ * @num_available_pcs: num of available phylink_pcs PCS
  */
 struct phylink_config {
 	struct device *dev;
@@ -168,11 +172,14 @@ struct phylink_config {
 	void (*get_fixed_state)(struct phylink_config *config,
 				struct phylink_link_state *state);
 	DECLARE_PHY_INTERFACE_MASK(supported_interfaces);
+	DECLARE_PHY_INTERFACE_MASK(pcs_interfaces);
 	DECLARE_PHY_INTERFACE_MASK(lpi_interfaces);
 	unsigned long mac_capabilities;
 	unsigned long lpi_capabilities;
 	u32 lpi_timer_default;
 	bool eee_enabled_default;
+	struct phylink_pcs **available_pcs;
+	unsigned int num_available_pcs;
 };
 
 void phylink_limit_mac_speed(struct phylink_config *config, u32 max_speed);
@@ -460,6 +467,9 @@ struct phylink_pcs {
 	struct phylink *phylink;
 	bool poll;
 	bool rxc_always_on;
+
+	/* private: */
+	struct list_head list;
 };
 
 /**
-- 
2.48.1


