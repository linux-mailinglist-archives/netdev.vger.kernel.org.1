Return-Path: <netdev+bounces-146662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C719D4EF0
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397C31F219EB
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF86A1DF269;
	Thu, 21 Nov 2024 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iSPs/3vj"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677361DEFE2;
	Thu, 21 Nov 2024 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200236; cv=none; b=KBqiO0YlDRH3WbONf4gaJvVkTJ7r0GSGzlrvX8NDKvCODoTzwwHtv1XNlVuqmFy1loNHVGr/R4RW1y76c7Nfw4wdTPS4KJIRlWOlgFh0hvoBbEeMtUOKn6bflEkx/wf4q2z7zKc3tV7MSgFbKF69xfuAJQzRnZlGAgs0dqhNoFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200236; c=relaxed/simple;
	bh=GpiGdCyu1IXDR6hQGwdCSe4nlwJmEzxGDVSAK+kmfWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ouDM/Faw0FSkFx5K7rPMJqANIZ3EXyaB8Gj9BFcGhwDXVLAQf15T5DJFYc+g6ufGgi4MAPRuog9DyHMl2pK1KUgRCEDqfNJ/cKMCM9oYG/8oV9JugUglX5F/TuBQawAN4taV4mtg2DQPRq6xw1GZSerBgBE/GKm4Ltm28Qb/3IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iSPs/3vj; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F25F040007;
	Thu, 21 Nov 2024 14:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tkd5eN5qU75yl4G79Wuk8W+36wyuuBZi6jiU/wIf/k0=;
	b=iSPs/3vjQYI/RSDOUIFwCSb+QGwS4+6KtbVTf+OGPuFBlcCXx/qmPaoXTuVhSnCSzMBML3
	4VzoUQJaHxtaqQyTjYoUM3yP/GAjW+lie1sF1+oFPlnYWpZ3jcWvdL9FJvVZg96hzhDPdh
	55Mm2ciCcEr2li4DyZJlD2PdUG9Kp6fuhTq88eXspc+0tqZiCxoYDRRw0ttGQJCegJaZs5
	kX6TcEZWqpjaKAtuJylSan9YWWWGr3XV/Mzq9GXlLHJ475AjYjUnnSBbulQxM7Wd6a1bZ5
	/NnyISImnR5b4lFDH6D7GpIkI269I2Tx/x4Yqz59ttoOTNHDLyV1WHtb1Dqvhw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:36 +0100
Subject: [PATCH RFC net-next v3 10/27] net: ethtool: Add support for new
 PSE device index description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-feature_poe_port_prio-v3-10-83299fa6967c@bootlin.com>
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

Add functionality to report the newly introduced PSE device index to
the user, enabling better identification and management of PSE devices.

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- new patch.
---
 Documentation/networking/ethtool-netlink.rst | 4 ++++
 include/uapi/linux/ethtool_netlink.h         | 1 +
 net/ethtool/pse-pd.c                         | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index b25926071ece..bd7173d1fa4d 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1766,6 +1766,7 @@ Kernel response contents:
                                                       limit of the PoE PSE.
   ``ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES``       nested  Supported power limit
                                                       configuration ranges.
+  ``ETHTOOL_A_PSE_ID``                           u32  Index of the PSE
   ==========================================  ======  =============================
 
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_STATE`` attribute identifies
@@ -1839,6 +1840,9 @@ identifies the C33 PSE power limit ranges through
 If the controller works with fixed classes, the min and max values will be
 equal.
 
+The ``ETHTOOL_A_PSE_ID`` attribute identifies the index of the PSE
+controller.
+
 PSE_SET
 =======
 
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 283305f6b063..9a4c293a9a82 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -970,6 +970,7 @@ enum {
 	ETHTOOL_A_C33_PSE_EXT_SUBSTATE,		/* u32 */
 	ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT,	/* u32 */
 	ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES,	/* nest - _C33_PSE_PW_LIMIT_* */
+	ETHTOOL_A_PSE_ID,			/* u32 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_PSE_CNT,
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index a0705edca22a..5edb8b0a669e 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -83,6 +83,7 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
 	const struct pse_control_status *st = &data->status;
 	int len = 0;
 
+	len += nla_total_size(sizeof(u32)); /* _PSE_ID */
 	if (st->podl_admin_state > 0)
 		len += nla_total_size(sizeof(u32)); /* _PODL_PSE_ADMIN_STATE */
 	if (st->podl_pw_status > 0)
@@ -148,6 +149,9 @@ static int pse_fill_reply(struct sk_buff *skb,
 	const struct pse_reply_data *data = PSE_REPDATA(reply_base);
 	const struct pse_control_status *st = &data->status;
 
+	if (nla_put_u32(skb, ETHTOOL_A_PSE_ID, st->pse_id))
+		return -EMSGSIZE;
+
 	if (st->podl_admin_state > 0 &&
 	    nla_put_u32(skb, ETHTOOL_A_PODL_PSE_ADMIN_STATE,
 			st->podl_admin_state))

-- 
2.34.1


