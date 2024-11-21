Return-Path: <netdev+bounces-146672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC8F9D4F14
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21BFA1F211A4
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935F91E1042;
	Thu, 21 Nov 2024 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iiP9yTk5"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487061E0DF9;
	Thu, 21 Nov 2024 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200260; cv=none; b=Eunu4nv63f0t9h5NVtIzMJC4/+C4hqAYBfQ+aLt/gbjNf2mXZLwR9JGEPzcxmIYAQIrIakKfUOZG0AGUtuCvjr3/Ndw7tP6/wDSTgv+cypL1Udl1Wkw2dCoyAI5tCxzkUbjklGbjK3VudomSaqTmzesGTkbeGiGg0pq4upKGzxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200260; c=relaxed/simple;
	bh=OqzDm7Z/gQBlx9q8tSj+GJD9uMx9aZ5dguVYSY8A9lE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tfsjrsgv9bWo6ko1DDVi7lYBobgA7UKCsqCMLADpDt4X2TVboVkN6OLq6dnG0wJPGiZ+/9ChnKHXRnmtW0OzgEh9Jp4HdJtWZjYeBs9ynRr6ZHTyPlh+F4DcUv8DTzhbsjsmbsMl9ADK6c86reIXV4ygDb9fGnDmxJ51bHD+jAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iiP9yTk5; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9A3E740008;
	Thu, 21 Nov 2024 14:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bp11jeKFQf+n77xKj8jA9tjL6fptB01Kk8DXFAMTdXw=;
	b=iiP9yTk5YpbTLBvUN7p3G7uT+izT2eY3XFm2arhqYsB4ZsrrJ0iJysm+UbWLMNL8spNZBB
	zLxshzKNFVvfSXsgyPIHmr5Lwi80ZvDBYY1UJ15yCh+5SgA7lbLtmh9SD0v0hpzX2FBaRl
	z+qBXeWq7ZTjvoQXyhn6WXp+oyAcjn/dVQ4Vv/bACN2x2I4TWXybybWmnUIZcr81OJHqqS
	2lc+ZTduHAptqRqT6BQ1FARPZLH7Qgigfwoxkua/zI7rS7KMjXOWJPV+IUX+z88Swym75+
	qzQPYT/QdiBOqzIWkuzxgEaJE8rrWOoQUPjdxPRf/NAzZjiFfhd/lj4Q/CwV/A==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:46 +0100
Subject: [PATCH RFC net-next v3 20/27] net: ethtool: Add support for new
 power domains index description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-feature_poe_port_prio-v3-20-83299fa6967c@bootlin.com>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
In-Reply-To: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Report the index of the newly introduced PSE power domain to the user,
enabling improved management of the power budget for PSE devices.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- Add support power domain id = 0 in ethtool.

Changes in v2:
- new patch.
---
 Documentation/networking/ethtool-netlink.rst | 4 ++++
 drivers/net/pse-pd/pse_core.c                | 3 +++
 include/linux/pse-pd/pse.h                   | 2 ++
 include/uapi/linux/ethtool_netlink.h         | 1 +
 net/ethtool/pse-pd.c                         | 7 +++++++
 5 files changed, 17 insertions(+)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index bd7173d1fa4d..3573543ae5ad 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1767,6 +1767,7 @@ Kernel response contents:
   ``ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES``       nested  Supported power limit
                                                       configuration ranges.
   ``ETHTOOL_A_PSE_ID``                           u32  Index of the PSE
+  ``ETHTOOL_A_PSE_PW_D_ID``                      u32  Index of the PSE power domain
   ==========================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_STATE`` attribute identifies
@@ -1843,6 +1844,9 @@ equal.
 The ``ETHTOOL_A_PSE_ID`` attribute identifies the index of the PSE
 controller.
 
+The ``ETHTOOL_A_PSE_PW_D_ID`` attribute identifies the index of PSE power
+domain.
+
 PSE_SET
 =======
 
diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 8b9ce8c6ecef..ff0ffbccf139 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -980,6 +980,9 @@ static int _pse_ethtool_get_status(struct pse_controller_dev *pcdev,
 	}
 
 	status->pse_id = pcdev->id;
+	if (pcdev->pi[id].pw_d)
+		status->pw_d_id = pcdev->pi[id].pw_d->id;
+
 	return ops->ethtool_get_status(pcdev, id, extack, status);
 }
 
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 9d06eb9ca663..bdf3e8c468fc 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -42,6 +42,7 @@ struct pse_control_config {
  * struct pse_control_status - PSE control/channel status.
  *
  * @pse_id: index number of the PSE. Set by PSE core.
+ * @pw_d_id: PSE power domain index. Set by PSE core.
  * @podl_admin_state: operational state of the PoDL PSE
  *	functions. IEEE 802.3-2018 30.15.1.1.2 aPoDLPSEAdminState
  * @podl_pw_status: power detection status of the PoDL PSE.
@@ -64,6 +65,7 @@ struct pse_control_config {
  */
 struct pse_control_status {
 	u32 pse_id;
+	u32 pw_d_id;
 	enum ethtool_podl_pse_admin_state podl_admin_state;
 	enum ethtool_podl_pse_pw_d_status podl_pw_status;
 	enum ethtool_c33_pse_admin_state c33_admin_state;
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 91c1bd9349b0..088ad7b956fb 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -972,6 +972,7 @@ enum {
 	ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT,	/* u32 */
 	ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES,	/* nest - _C33_PSE_PW_LIMIT_* */
 	ETHTOOL_A_PSE_ID,			/* u32 */
+	ETHTOOL_A_PSE_PW_D_ID,			/* u32 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_PSE_CNT,
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 19ab6bd35ad4..d67803b67e76 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -84,6 +84,8 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
 	int len = 0;
 
 	len += nla_total_size(sizeof(u32)); /* _PSE_ID */
+	if (st->pw_d_id > 0)
+		len += nla_total_size(sizeof(u32)); /* _PSE_PW_D_ID */
 	if (st->podl_admin_state > 0)
 		len += nla_total_size(sizeof(u32)); /* _PODL_PSE_ADMIN_STATE */
 	if (st->podl_pw_status > 0)
@@ -152,6 +154,11 @@ static int pse_fill_reply(struct sk_buff *skb,
 	if (nla_put_u32(skb, ETHTOOL_A_PSE_ID, st->pse_id))
 		return -EMSGSIZE;
 
+	if (st->pw_d_id > 0 &&
+	    nla_put_u32(skb, ETHTOOL_A_PSE_PW_D_ID,
+			st->pw_d_id))
+		return -EMSGSIZE;
+
 	if (st->podl_admin_state > 0 &&
 	    nla_put_u32(skb, ETHTOOL_A_PODL_PSE_ADMIN_STATE,
 			st->podl_admin_state))

-- 
2.34.1


