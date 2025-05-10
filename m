Return-Path: <netdev+bounces-189455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7527AB2359
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 12:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581D01BA5C4C
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 10:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EFD239E76;
	Sat, 10 May 2025 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZiyszQH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677362367B0;
	Sat, 10 May 2025 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746872673; cv=none; b=QSvZZer3TrfaX5f4D3/ge4F1oYjynVVi6F9OIzpBv1GpOgBohhSfGlzgjWdKzxpvNHxsS9Kk+lb/p70Fuh2CfDGYKv9P5VICvw2jN88AryjB0bqdCp6qrxHqmRpbGszKUm2QOQONAAV05ZG9fttQm0mUyC6XWSHq4BC8QC61XBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746872673; c=relaxed/simple;
	bh=IjQgxg9NWK+nqIZo5pP2kLnDIB2AShZ3hwdj0fr//r0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ugNCsGjz0URUBGOoJnVyxH5O+9kRCuimhpy9rvOlm5MvTDlhpVAgvIbWHP9tMuxZFZ0DNySDnsqHbI48LpE3kNlb41+Boqc8rHBSB7xDZs4DFwur6ajahAn3iCiS2L/Vu2F57bswbI8qz8NHv09KC8pg2Un+q7/ZrTcsUM1Jg7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZiyszQH; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d0618746bso22038375e9.2;
        Sat, 10 May 2025 03:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746872669; x=1747477469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtPCwgV0dhLDShOB9CXUcxV1ws2hcz9LCAibb1C2sKU=;
        b=YZiyszQH8dTkcBn9cUlAwoM7rQ/b6qn+PRuSsu8LwES/gCmGBdbnsg3Wtq1lm8deOU
         kBeRd/V3DTv1sTmO6RIfDPfsYNctkuX8jbfm4XfU0LV6UytjpptGDg2x/A+6CNjuQx2h
         0dU6sKQzEMCY/lBTzjGdeZtDyM7ZNNFYtpRKQjA8zwKZUJvAtZwDCEgIoCyoJKz0aJVU
         rrnCTDp3x7/ece+ZxM8vlrQOvX/4uWukAnt7hwJ2eIuqpLRulWEdtXDQ/LEJw+4uMoIC
         bNElpuKob7I/6ZTxtsxtUfS2PPSuFHZMDpmooGQgjWzfOoe2vwTlX8HrrgPhTcZJo4oz
         mB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746872669; x=1747477469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtPCwgV0dhLDShOB9CXUcxV1ws2hcz9LCAibb1C2sKU=;
        b=wgYA+qBHtbWnwM+WwYZWnzbhWz8Og8V1k558+J1KCdmXUoO2v68EhPfYtRU2ossXAq
         umG227157htz8xwVo2ASy4H2mp1wHJumwd/FYBPrbVAjYWTXoPtXw38fbGLZa8gVMizp
         FowzUk78vwzjwei4zzyQFbNBb+sb6ntZ/IrXAjYWgyRuawZ3Slv4JG2e9RRMB36Wi6XC
         fYJjUX6/qk05xGkb+Bw6qO4ljYlY8iwEygi+skgGpT+cHQ4PZ4WlDWKw1jFIowlH8rWd
         qJTvgm9/mbeKPVhjuGFti8vGDSn+wJ5RbkkimmVuUOIEYNUBuc7l3CyuMD/QYqs5KlfX
         BTsw==
X-Forwarded-Encrypted: i=1; AJvYcCVEIzVkp/tl9WE6XOn524/yyYWqvjUL2BLXWFNoEassQCyC8aHMlsRY5RjweSudb2yHRtqEd4k7NpnwAh+y@vger.kernel.org, AJvYcCWDFWfBrGiCPGxT7pkoSDyHSTO8JqH7wqKW53dFF1WxvbYO1fXPMBOkwTzGM29L3uWzkWmYuiy1X9t3@vger.kernel.org, AJvYcCWkBHePE5pcH6OJNuYvU1FJhRqCtDggvbwHk1wo9BiqiuFDXsNluSDtfnfhFr0bA3QOikcoc6t3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw54tx0Ns4YKVF+l7B6c4CWHXAb3wtOqU3reiF1I0q6tVJQ+xf2
	GEzO2i4+PWwmDcBX/hHAw7Iy1QzGoBjeDvSq7vzB3+uk/ZKNG4Wg
X-Gm-Gg: ASbGncsg8SFN8NsyhfdhkPDNDuCEoBLDpKbYJKJQ1lqB/RGQ1cI/Ze/OvYwsNpOewFF
	QuzRbur41x36G/6P82UDSdVPxXq64R/QZc7UMzJEDohuS8vipbDsPU81EMntdtf/nhqBAHpsGuQ
	uMDWWDeMe9XyCFAF+P0EDOitCrrI0NbwGhASlw4+BCtJiypUHLLy+2fHouMEyBAsFfdoiDLcz4r
	+Y9hCRdfBnEz0uw9AT/yhPx67GCwQlfMyxOFzAB9A5HklQLv+DzxcDHGonAAnaMFBhowMlqSITe
	FB83v9cvCLxkR8QI1s4V1zXHl1HsWBOlhJ45u7s1AQnPlmnCkTHhttqpmL4fzWQ4Mwot6BCxI60
	2kvZGMMWQr+MW4zQ3QfHl
X-Google-Smtp-Source: AGHT+IFwQwHKQMI1ptjXHGrEzZJ2HTI2c/FXymP1ZmYV5h+jwjeb8aMpA/3UT5et1Z2OJ65CfJr1sA==
X-Received: by 2002:a05:600c:64c7:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-442d6d18ba1mr51996325e9.6.1746872669328;
        Sat, 10 May 2025 03:24:29 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442d67df639sm57981265e9.13.2025.05.10.03.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 03:24:28 -0700 (PDT)
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
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [net-next PATCH v3 03/11] net: phylink: introduce internal phylink PCS handling
Date: Sat, 10 May 2025 12:23:23 +0200
Message-ID: <20250510102348.14134-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250510102348.14134-1-ansuelsmth@gmail.com>
References: <20250510102348.14134-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce internal handling of PCS for phylink. This is an alternative
to .mac_select_pcs that moves the selection logic of the PCS entirely to
phylink with the usage of the supported_interface value in the PCS
struct.

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

phylink_validate_mac_and_pcs(), phylink_major_config() and
phylink_inband_caps() are updated to support this new implementation
with the PCS list stored in phylink.

They will make use of phylink_validate_pcs_interface() that will loop
for every PCS in the phylink PCS available list and find one that supports
the passed interface.

phylink_validate_pcs_interface() applies the same logic of .mac_select_pcs
where if a supported_interface value is not set for the PCS struct, then
it's assumed every interface is supported.

A MAC is required to implement either a .mac_select_pcs or make use of
the PCS list implementation. Implementing both will result in a fail
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
index ec42fd278604..95d7e06dee56 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -59,6 +59,9 @@ struct phylink {
 	/* The link configuration settings */
 	struct phylink_link_state link_config;
 
+	/* List of available PCS */
+	struct list_head pcs_list;
+
 	/* What interface are supported by the current link.
 	 * Can change on removal or addition of new PCS.
 	 */
@@ -144,6 +147,8 @@ static const phy_interface_t phylink_sfp_interface_preference[] = {
 
 static DECLARE_PHY_INTERFACE_MASK(phylink_sfp_interfaces);
 
+static void phylink_run_resolve(struct phylink *pl);
+
 /**
  * phylink_set_port_modes() - set the port type modes in the ethtool mask
  * @mask: ethtool link mode mask
@@ -499,22 +504,59 @@ static void phylink_validate_mask_caps(unsigned long *supported,
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
@@ -526,13 +568,10 @@ static int phylink_validate_mac_and_pcs(struct phylink *pl,
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
@@ -937,12 +976,22 @@ static unsigned int phylink_inband_caps(struct phylink *pl,
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
@@ -1228,10 +1277,36 @@ static void phylink_major_config(struct phylink *pl, bool restart,
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
@@ -1258,10 +1333,12 @@ static void phylink_major_config(struct phylink *pl, bool restart,
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
@@ -1797,8 +1874,9 @@ struct phylink *phylink_create(struct phylink_config *config,
 			       phy_interface_t iface,
 			       const struct phylink_mac_ops *mac_ops)
 {
+	struct phylink_pcs *pcs;
 	struct phylink *pl;
-	int ret;
+	int i, ret;
 
 	/* Validate the supplied configuration */
 	if (phy_interface_empty(config->supported_interfaces)) {
@@ -1813,9 +1891,21 @@ struct phylink *phylink_create(struct phylink_config *config,
 
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
@@ -1894,10 +1984,16 @@ EXPORT_SYMBOL_GPL(phylink_create);
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
@@ -2374,6 +2470,7 @@ static irqreturn_t phylink_link_handler(int irq, void *data)
  */
 void phylink_start(struct phylink *pl)
 {
+	struct phylink_pcs *pcs;
 	bool poll = false;
 
 	ASSERT_RTNL();
@@ -2400,6 +2497,10 @@ void phylink_start(struct phylink *pl)
 
 	pl->pcs_state = PCS_STATE_STARTED;
 
+	/* link available PCS to phylink struct */
+	list_for_each_entry(pcs, &pl->pcs_list, list)
+		pcs->phylink = pl;
+
 	phylink_enable_and_run_resolve(pl, PHYLINK_DISABLE_STOPPED);
 
 	if (pl->cfg_link_an_mode == MLO_AN_FIXED && pl->link_gpio) {
@@ -2444,6 +2545,8 @@ EXPORT_SYMBOL_GPL(phylink_start);
  */
 void phylink_stop(struct phylink *pl)
 {
+	struct phylink_pcs *pcs;
+
 	ASSERT_RTNL();
 
 	if (pl->sfp_bus)
@@ -2461,6 +2564,14 @@ void phylink_stop(struct phylink *pl)
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
index 30659b615fca..ef0b5a0729c8 100644
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
@@ -469,6 +476,9 @@ struct phylink_pcs {
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


