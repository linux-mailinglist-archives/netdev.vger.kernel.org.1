Return-Path: <netdev+bounces-106467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DC49167FE
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B91285F87
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 12:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDCD1667D8;
	Tue, 25 Jun 2024 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QQzrRs37"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7796E15746B;
	Tue, 25 Jun 2024 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318847; cv=none; b=X1v8cNgzrv+njrz988ND6ENlzDbgctxNXmPICxdk8qIryFxxzYTn0dTxF8h3MZXLSurxu+lnFpFD9FQ+N3iKO9+dYIRxDmIAv27aaTAA292SSW9ZrA5fQoe+r3h6emrMLT5THJj1A5+cAKu+ZnsXoPtUUVqIhnGATfnwIZ0ThVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318847; c=relaxed/simple;
	bh=mASXcD9cXEQY9eKDKauyYUaq2bGxwi0Q8kcCria5U6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VZl0Rb21E0d/p6IuThbOKbLULuf56/TbL+DVhEQ6q18+AGXrNjNcOykmph/6llfzyKaztBCrsNOtrnv0QbLxfXgp20HIeQtvVGuESYQXl1ocUoP86MgBn6933Md2/S6auD7F+Th+2v+7uUUICUQJG/0nzd4QA9Re7KP9QE2szl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QQzrRs37; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1824760003;
	Tue, 25 Jun 2024 12:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719318842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ykqBQDYM2+5EMH+2a/KHKTtMYkBaceIaZQGEDki9FUU=;
	b=QQzrRs37Xk9ZyDP3mXcJ65jthSXIC4FWj1LsJw3LKEarlxCc+MUhHVe3/7PJNIZp6kWtSm
	T6LGJ8UvsPeK7OhQgQqnXWXOQkMYZnbpwKFV7numHii696mdIFAt42ZTuv6Psba84O9Ivo
	j2BWLWXHEflfdgZYbWaRcrONp3rCtebkd0ouOBEuIghOLLsvsRoTGKoIMKCxVSYn2a0eb7
	qJUPuZyR6fa8aO+4Nm4NYGYSmMWD6mMSLBbrjHzgZZScJDrlztNZajkcurirYIThFydU/y
	ZRqurrIbNwaXzxXKxUklMDgdVLoiWwElljARZCXMp0diacE6USGghwakF05rKg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 25 Jun 2024 14:33:50 +0200
Subject: [PATCH net-next v4 5/7] net: ethtool: Add new power limit get and
 set features
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-feature_poe_power_cap-v4-5-b0813aad57d5@bootlin.com>
References: <20240625-feature_poe_power_cap-v4-0-b0813aad57d5@bootlin.com>
In-Reply-To: <20240625-feature_poe_power_cap-v4-0-b0813aad57d5@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 linux-doc@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch expands the status information provided by ethtool for PSE c33
with available power limit and available power limit ranges. It also adds
a call to pse_ethtool_set_pw_limit() to configure the PSE control power
limit.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v3:
- Add ethtool netlink documentation.

Change in v4:
- Update documentation
- Add support for c33 pse power limit ranges.
---
 Documentation/networking/ethtool-netlink.rst | 64 ++++++++++++++------
 include/linux/ethtool.h                      |  5 ++
 include/uapi/linux/ethtool_netlink.h         |  8 +++
 net/ethtool/pse-pd.c                         | 89 +++++++++++++++++++++++++---
 4 files changed, 141 insertions(+), 25 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 7dbf2ef3ac0e..5cba6ef39927 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1720,24 +1720,28 @@ Request contents:
 
 Kernel response contents:
 
-  ======================================  ======  =============================
-  ``ETHTOOL_A_PSE_HEADER``                nested  reply header
-  ``ETHTOOL_A_PODL_PSE_ADMIN_STATE``         u32  Operational state of the PoDL
-                                                  PSE functions
-  ``ETHTOOL_A_PODL_PSE_PW_D_STATUS``         u32  power detection status of the
-                                                  PoDL PSE.
-  ``ETHTOOL_A_C33_PSE_ADMIN_STATE``          u32  Operational state of the PoE
-                                                  PSE functions.
-  ``ETHTOOL_A_C33_PSE_PW_D_STATUS``          u32  power detection status of the
-                                                  PoE PSE.
-  ``ETHTOOL_A_C33_PSE_PW_CLASS``             u32  power class of the PoE PSE.
-  ``ETHTOOL_A_C33_PSE_ACTUAL_PW``            u32  actual power drawn on the
-                                                  PoE PSE.
-  ``ETHTOOL_A_C33_PSE_EXT_STATE``            u32  power extended state of the
-                                                  PoE PSE.
-  ``ETHTOOL_A_C33_PSE_EXT_SUBSTATE``         u32  power extended substatus of
-                                                  the PoE PSE.
-  ======================================  ======  =============================
+  ==========================================  ======  =============================
+  ``ETHTOOL_A_PSE_HEADER``                    nested  reply header
+  ``ETHTOOL_A_PODL_PSE_ADMIN_STATE``             u32  Operational state of the PoDL
+                                                      PSE functions
+  ``ETHTOOL_A_PODL_PSE_PW_D_STATUS``             u32  power detection status of the
+                                                      PoDL PSE.
+  ``ETHTOOL_A_C33_PSE_ADMIN_STATE``              u32  Operational state of the PoE
+                                                      PSE functions.
+  ``ETHTOOL_A_C33_PSE_PW_D_STATUS``              u32  power detection status of the
+                                                      PoE PSE.
+  ``ETHTOOL_A_C33_PSE_PW_CLASS``                 u32  power class of the PoE PSE.
+  ``ETHTOOL_A_C33_PSE_ACTUAL_PW``                u32  actual power drawn on the
+                                                      PoE PSE.
+  ``ETHTOOL_A_C33_PSE_EXT_STATE``                u32  power extended state of the
+                                                      PoE PSE.
+  ``ETHTOOL_A_C33_PSE_EXT_SUBSTATE``             u32  power extended substatus of
+                                                      the PoE PSE.
+  ``ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT``           u32  currently configured power
+                                                      limit of the PoE PSE.
+  ``ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES``       nested  Supported power limit
+                                                      configuration ranges.
+  ==========================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_STATE`` attribute identifies
 the operational state of the PoDL PSE functions.  The operational state of the
@@ -1799,6 +1803,16 @@ Possible values are:
 		  ethtool_c33_pse_ext_substate_power_not_available
 		  ethtool_c33_pse_ext_substate_short_detected
 
+When set, the optional ``ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT`` attribute
+identifies the C33 PSE power limit in mW.
+
+When set the optional ``ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES`` nested attribute
+identifies the C33 PSE power limit ranges through
+``ETHTOOL_A_C33_PSE_PWR_VAL_LIMIT_RANGE_MIN`` and
+``ETHTOOL_A_C33_PSE_PWR_VAL_LIMIT_RANGE_MAX``.
+If the controller works with fixed classes, the min and max values will be
+equal.
+
 PSE_SET
 =======
 
@@ -1810,6 +1824,8 @@ Request contents:
   ``ETHTOOL_A_PSE_HEADER``                nested  request header
   ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL``       u32  Control PoDL PSE Admin state
   ``ETHTOOL_A_C33_PSE_ADMIN_CONTROL``        u32  Control PSE Admin state
+  ``ETHTOOL_A_C33_PSE_AVAIL_PWR_LIMIT``      u32  Control PoE PSE available
+                                                  power limit
   ======================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL`` attribute is used
@@ -1820,6 +1836,18 @@ to control PoDL PSE Admin functions. This option is implementing
 The same goes for ``ETHTOOL_A_C33_PSE_ADMIN_CONTROL`` implementing
 ``IEEE 802.3-2022`` 30.9.1.2.1 acPSEAdminControl.
 
+When set, the optional ``ETHTOOL_A_C33_PSE_AVAIL_PWR_LIMIT`` attribute is
+used to control the available power value limit for C33 PSE in milliwatts.
+This attribute corresponds  to the `pse_available_power` variable described in
+``IEEE 802.3-2022`` 33.2.4.4 Variables  and `pse_avail_pwr` in 145.2.5.4
+Variables, which are described in power classes.
+
+It was decided to use milliwatts for this interface to unify it with other
+power monitoring interfaces, which also use milliwatts, and to align with
+various existing products that document power consumption in watts rather than
+classes. If power limit configuration based on classes is needed, the
+conversion can be done in user space, for example by ethtool.
+
 RSS_GET
 =======
 
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 3c96aa8765d9..d8a73a35e1cc 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1170,4 +1170,9 @@ struct ethtool_c33_pse_ext_state_info {
 		u32 __c33_pse_ext_substate;
 	};
 };
+
+struct ethtool_c33_pse_pw_limit_range {
+	u32 min;
+	u32 max;
+};
 #endif /* _LINUX_ETHTOOL_H */
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 398a0aa8daad..b35be6c78d4b 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -906,6 +906,12 @@ enum {
 };
 
 /* Power Sourcing Equipment */
+enum {
+	ETHTOOL_A_C33_PSE_PW_LIMIT_UNSPEC,
+	ETHTOOL_A_C33_PSE_PW_LIMIT_MIN,	/* u32 */
+	ETHTOOL_A_C33_PSE_PW_LIMIT_MAX,	/* u32 */
+};
+
 enum {
 	ETHTOOL_A_PSE_UNSPEC,
 	ETHTOOL_A_PSE_HEADER,			/* nest - _A_HEADER_* */
@@ -919,6 +925,8 @@ enum {
 	ETHTOOL_A_C33_PSE_ACTUAL_PW,		/* u32 */
 	ETHTOOL_A_C33_PSE_EXT_STATE,		/* u32 */
 	ETHTOOL_A_C33_PSE_EXT_SUBSTATE,		/* u32 */
+	ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT,	/* u32 */
+	ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES,	/* nest - _C33_PSE_PW_LIMIT_* */
 
 	/* add new constants above here */
 	__ETHTOOL_A_PSE_CNT,
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index d2a1c14d789f..ba46c9c8b12d 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -96,9 +96,46 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
 			/* _C33_PSE_EXT_SUBSTATE */
 			len += nla_total_size(sizeof(u32));
 	}
+	if (st->c33_avail_pw_limit > 0)
+		/* _C33_AVAIL_PSE_PW_LIMIT */
+		len += nla_total_size(sizeof(u32));
+	if (st->c33_pw_limit_nb_ranges > 0)
+		/* _C33_PSE_PW_LIMIT_RANGES */
+		len += st->c33_pw_limit_nb_ranges *
+		       (nla_total_size(0) +
+			nla_total_size(sizeof(u32)) * 2);
+
 	return len;
 }
 
+static int pse_put_pw_limit_ranges(struct sk_buff *skb,
+				   const struct pse_control_status *st)
+{
+	const struct ethtool_c33_pse_pw_limit_range *pw_limit_ranges;
+	int i;
+
+	pw_limit_ranges = st->c33_pw_limit_ranges;
+	for (i = 0; i < st->c33_pw_limit_nb_ranges; i++) {
+		struct nlattr *nest;
+
+		nest = nla_nest_start(skb, ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES);
+		if (!nest)
+			return -EMSGSIZE;
+
+		if (nla_put_u32(skb, ETHTOOL_A_C33_PSE_PW_LIMIT_MIN,
+				pw_limit_ranges->min) ||
+		    nla_put_u32(skb, ETHTOOL_A_C33_PSE_PW_LIMIT_MAX,
+				pw_limit_ranges->max)) {
+			nla_nest_cancel(skb, nest);
+			return -EMSGSIZE;
+		}
+		nla_nest_end(skb, nest);
+		pw_limit_ranges++;
+	}
+
+	return 0;
+}
+
 static int pse_fill_reply(struct sk_buff *skb,
 			  const struct ethnl_req_info *req_base,
 			  const struct ethnl_reply_data *reply_base)
@@ -147,9 +184,25 @@ static int pse_fill_reply(struct sk_buff *skb,
 			return -EMSGSIZE;
 	}
 
+	if (st->c33_avail_pw_limit > 0 &&
+	    nla_put_u32(skb, ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT,
+			st->c33_avail_pw_limit))
+		return -EMSGSIZE;
+
+	if (st->c33_pw_limit_nb_ranges > 0 &&
+	    pse_put_pw_limit_ranges(skb, st))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
+static void pse_cleanup_data(struct ethnl_reply_data *reply_base)
+{
+	const struct pse_reply_data *data = PSE_REPDATA(reply_base);
+
+	kfree(data->status.c33_pw_limit_ranges);
+}
+
 /* PSE_SET */
 
 const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1] = {
@@ -160,6 +213,7 @@ const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1] = {
 	[ETHTOOL_A_C33_PSE_ADMIN_CONTROL] =
 		NLA_POLICY_RANGE(NLA_U32, ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED,
 				 ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED),
+	[ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT] = { .type = NLA_U32 },
 };
 
 static int
@@ -202,19 +256,39 @@ static int
 ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 {
 	struct net_device *dev = req_info->dev;
-	struct pse_control_config config = {};
 	struct nlattr **tb = info->attrs;
 	struct phy_device *phydev;
+	int ret = 0;
 
 	phydev = dev->phydev;
+
+	if (tb[ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT]) {
+		unsigned int pw_limit;
+
+		pw_limit = nla_get_u32(tb[ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT]);
+		ret = pse_ethtool_set_pw_limit(phydev->psec, info->extack,
+					       pw_limit);
+		if (ret)
+			return ret;
+	}
+
 	/* These values are already validated by the ethnl_pse_set_policy */
-	if (pse_has_podl(phydev->psec))
-		config.podl_admin_control = nla_get_u32(tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL]);
-	if (pse_has_c33(phydev->psec))
-		config.c33_admin_control = nla_get_u32(tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL]);
+	if (tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL] ||
+	    tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL]) {
+		struct pse_control_config config = {};
+
+		if (pse_has_podl(phydev->psec))
+			config.podl_admin_control = nla_get_u32(tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL]);
+		if (pse_has_c33(phydev->psec))
+			config.c33_admin_control = nla_get_u32(tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL]);
+
+		ret = pse_ethtool_set_config(phydev->psec, info->extack,
+					     &config);
+		if (ret)
+			return ret;
+	}
 
-	/* Return errno directly - PSE has no notification */
-	return pse_ethtool_set_config(phydev->psec, info->extack, &config);
+	return ret;
 }
 
 const struct ethnl_request_ops ethnl_pse_request_ops = {
@@ -227,6 +301,7 @@ const struct ethnl_request_ops ethnl_pse_request_ops = {
 	.prepare_data		= pse_prepare_data,
 	.reply_size		= pse_reply_size,
 	.fill_reply		= pse_fill_reply,
+	.cleanup_data		= pse_cleanup_data,
 
 	.set_validate		= ethnl_set_pse_validate,
 	.set			= ethnl_set_pse,

-- 
2.34.1


