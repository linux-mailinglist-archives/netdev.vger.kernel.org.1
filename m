Return-Path: <netdev+bounces-189586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0824DAB2ABA
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 22:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F833B92DA
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 20:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D178E2641E2;
	Sun, 11 May 2025 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zfgfsj8Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EF425FA34;
	Sun, 11 May 2025 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746994409; cv=none; b=qBmd6guVWIwTRrOLWXVUDTGdkznUZ4qH1iqIUVtGHN7jVppsoleBRdy3kurat0ZhNJdD6+MIdNTv0o5wvkDr0OX0UbrDYm6lqslXE8yy8TQLkTkfEfBmWLbWugllg0BuC9Ex7DpugH18Mne7Kohrl0xNFGZFZYLIKX5Q7ZMboyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746994409; c=relaxed/simple;
	bh=IjQgxg9NWK+nqIZo5pP2kLnDIB2AShZ3hwdj0fr//r0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUDmvDhCzvHmS/GDu9it8RMlz/LFwCaIHespQFxyXoSCkc2ArqnSckk9iu5ABagFHhPYJAwUx3a/43LKKkbb1AgpR+8DVeeSILtA6GhPuQZLHSTDJmanxIjB90Hk6Qr/emJveqhYEQMuCZsUzzkRvY19n1FYZ6/I5cOqu86SqXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zfgfsj8Q; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso19635105e9.3;
        Sun, 11 May 2025 13:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746994406; x=1747599206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtPCwgV0dhLDShOB9CXUcxV1ws2hcz9LCAibb1C2sKU=;
        b=Zfgfsj8QgsdGXb6R/fqOtOTcDREuWigl3ePqexDsqUB1AkGo+0wmCk1ePsZF7vX2pL
         2o+KviRz0/oz/FmZh14/UqtGb6lATWPZlphw73wTSz2DvwseHc1IJCAFiTln5VxFY7DV
         Qezv94q6j0wpBY/f8eqbrvOG4snUOaTU2uaWg2REY/IjbE6ER9IJCk2VWSgqxw9oNzPu
         F5Z/QWQ3PjdfCqM4p9/Jw63oZyu+pcvUhiohpUlY+5Iqy+tjaXgZ3vjprvrcoHKoqUtL
         PdewIEZoyBULAmhuh4fQbI9n1wjrSnS26SCDamY44NuTeS+4jvYKAA1+UDqLAFt2VOEX
         X1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746994406; x=1747599206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtPCwgV0dhLDShOB9CXUcxV1ws2hcz9LCAibb1C2sKU=;
        b=IxfsWZLmOoCcF8wJ2Ok6GAOKIFxk/kTDqZWcN5erR0FidKb1tlMccAVmw+O0wOjpWN
         63By/9ZiBHQgS0QRijISdAAcxcwsLzW97m5lDUN5npM9FE5kvf1ZVryJ5ruN9XNWgiyX
         Q7dKXi++l9unX0wXSKguhL1a5qGbrtxLWlbPwLoAhUn+XhAiYymEh6dkLNkfnHoCrswj
         5djNplEOfMZesgE4xKmif3jm7oINAN34JRypX/wYHK+xFCMK49/PdKGI5yzqQB6GOSfo
         9Xp/NIaLajA+wlKQ45UOlUSTxeKSh9ZEF3BetFiVfLLOyhdKSLd3Y20Acj385SgWARpO
         18yg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ4o5vcO2UHK9BmtOIXVUevk6G5vp1h2NSo4zCm3me3/C5BwUr0rm5PKB5zCpwcv0aRRf9ks+4iVc2fsTK@vger.kernel.org, AJvYcCW2oQS5Pk8dCjLGcMcM9u5bF3210UJuz0WqtJ3EDumcWIwgjlHZgOtTiBexugC2N04HtvsmBjI/@vger.kernel.org, AJvYcCXi+4y4RHVttS1HC5RFVJ7VdUu76GO1pFLv3N20tGM8mbz03TXMrG4S53yw0w2Qud9cPBnW9msYyXyu@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp0vO9OadwQLUZfE95FvHtwhN+Pyul0/zcqI3mVImpPsaWkXyF
	CO2NgHHSn2dusVsmnDJpL0DelP60SPw5XVWNLSgCTCCYZZtcaoD7
X-Gm-Gg: ASbGnctUheLaMWsVIexbt6kiR7vYFjKlOLC+NzV4cEWYUCTGeRHSAP+f6kviacI7Vl6
	1SUo4l/ems83WxjBfE+MZZOzpq/SR65NbcmwD1gWG03YTXI4o9BCZ40XnguHrapPqmKwGA4qlWT
	3Xxb28ne83Kbbh4WYMYvJXxE4DDsqAxNmQZvl0vmyFnkOICr44WIzMa6EYr38zxoMZKXq/zLU8Y
	1U2oq+Pb+cWJE6Nukici2e8Efy/OaSjAxNWTIC80JMCxmw1xHkEpggtz9ZvsVVtCfk65j/ZDNrj
	L9/tq1Z3+n07xEgSsLWspI277BYFk0Vlr3gtZWtdhhcW56r50C3dVeb9Xwgs2JqmTUclwfwGwd4
	Cg5T95dl3ANRGymRD/tpN
X-Google-Smtp-Source: AGHT+IFnXVRhB+OrPVJwQRNCQLY1D9wSNV4Ubyo9+JniJCjNQb2Zr7EOWaxj2pQvkwliRp8Thz35hA==
X-Received: by 2002:a05:600c:b91:b0:441:b3eb:5720 with SMTP id 5b1f17b1804b1-442d6ddeb79mr82981525e9.29.1746994405302;
        Sun, 11 May 2025 13:13:25 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442d67ee275sm100615165e9.19.2025.05.11.13.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 13:13:24 -0700 (PDT)
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
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [net-next PATCH v4 03/11] net: phylink: introduce internal phylink PCS handling
Date: Sun, 11 May 2025 22:12:29 +0200
Message-ID: <20250511201250.3789083-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250511201250.3789083-1-ansuelsmth@gmail.com>
References: <20250511201250.3789083-1-ansuelsmth@gmail.com>
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


