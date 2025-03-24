Return-Path: <netdev+bounces-177053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ADDA6D872
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 11:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DFF33B0B62
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 10:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF58C25E824;
	Mon, 24 Mar 2025 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Aj2Dg5yx"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E15825E449;
	Mon, 24 Mar 2025 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742812828; cv=none; b=pBVQgu+MF/4uGPA8ObBuiCLDOQJcOx+PDYd9RAbk+nXHWw8V8m2X8ZogZF9lJXd5YTItsGhIYx685Powe5oqxlp4vgGm2nFPrSoyjucc0VWgeEArehhsBzPRjRqNC1OrGDNkZQFkVHF9rEV0LTn+4sxtnXsOBoEfvLAkQnfD4Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742812828; c=relaxed/simple;
	bh=wSctPJUpF0rtx9N3jH6XS54ad/SvF7VBhNszWNA6rqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGN4docj1NTlYOQ+RdhKxOS2dY++2kLdF/0FNZnE83THQn49wYOWH9I1KUsYd/zFPNHH8moi9xKKkm6zaKZetYcN0rN6lezYTwsPHnqQwR9dUE+qN4oINeUfjE4LeKRzdv9Bzzt+Rb06vn6AlwwWJ+1WUSVUSxI5t1JmDbkUCDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Aj2Dg5yx; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 929E7442EE;
	Mon, 24 Mar 2025 10:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742812824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDbIERip0Aw6jQC6iqtBU6ZWhviMT+JOgUWmYFk3wzU=;
	b=Aj2Dg5yxphJNgtHUL969nOuxWReU7qmtx0cmn/9YPDhziepzrT8/iAoktgp88J3huIFwH5
	Hnjh1DcAQiWQc35109d2WixMG88pYvK2WxXvtpUWqIlU07+mzWOgq3MpnLz/Qw13gUeRLg
	iCOxJp8Ov+KMiRQftrQMGgjIL4hVJuPVhqq4xycxrgI3/re/rMMNlXfuWDhqsZJE7rVvEG
	40BiTTTe8Yko/3WceU321nAnbEMD7Wj/VGyRo72REB/7qOo8UoYqREceit58qIpRRY3+Uu
	hI64UH1j3hUOcebmMb1jJQmBtahBF3kEWXHSgJAWhi1G1AZXLL5Kg3Czb+Cw2w==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Subject: [PATCH net-next v4 5/8] net: ethtool: netlink: Introduce per-phy DUMP helpers
Date: Mon, 24 Mar 2025 11:40:07 +0100
Message-ID: <20250324104012.367366-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324104012.367366-1-maxime.chevallier@bootlin.com>
References: <20250324104012.367366-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeehvdgrfeemjegsledumeduhegtleemtgeltdeinecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemhedvrgefmeejsgeludemudehtgelmegtledtiedphhgvlhhopeguvghvihgtvgdqvdegrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvuddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvu
 ghumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

As there are multiple ethnl commands that report messages based on
phy_device information, let's introduce a set of ethnl generic dump
helpers to allow DUMP support for each PHY on a given netdev.

This logic iterates over the phy_link_topology of each netdev (or a
single netdev for filtered DUMP), and call ethnl_default_dump_one() with
the req_info populated with ifindex + phyindex.

This allows re-using all the existing infra for phy-targetting commands
that already use ethnl generic helpers.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V4 : No changes

 net/ethtool/netlink.c | 78 +++++++++++++++++++++++++++++++++++++++++++
 net/ethtool/netlink.h |  6 ++++
 2 files changed, 84 insertions(+)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 0345bffa0678..171290eaf406 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -560,6 +560,84 @@ static int ethnl_default_dump_one(struct sk_buff *skb,
 	return ret;
 }
 
+/* Specific context for phy-targeting command DUMP operatins. We keep in context
+ * the latest phy_index we dumped, in case of an interrupted DUMP.
+ */
+struct ethnl_dump_ctx_perphy {
+	unsigned long phy_index;
+};
+
+/**
+ * ethnl_dump_start_perphy() - Initialise a dump for PHY cmds
+ * @ctx: Generic ethnl dump context whose cmd_ctx will be initialized
+ *
+ * Initializes a dump context for ethnl commands that may return
+ * one message per PHY on a single netdev.
+ *
+ * Returns: 0 for success, a negative value for errors.
+ */
+int ethnl_dump_start_perphy(struct ethnl_dump_ctx *ctx)
+{
+	struct ethnl_dump_ctx_perphy *dump_ctx;
+
+	dump_ctx = kzalloc(sizeof(*dump_ctx), GFP_KERNEL);
+	if (!dump_ctx)
+		return -ENOMEM;
+
+	ctx->cmd_ctx = dump_ctx;
+
+	return 0;
+}
+
+/**
+ * ethnl_dump_done_perphy() - Releases the per-phy dump context
+ * @ctx: Generic ethnl dump context whose cmd_ctx will be released
+ */
+void ethnl_dump_done_perphy(struct ethnl_dump_ctx *ctx)
+{
+	kfree(ctx->cmd_ctx);
+}
+
+/**
+ * ethnl_dump_one_dev_perphy() - Dump all PHY-related messages for one netdev
+ * @skb: skb containing the DUMP result
+ * @ctx: Dump context. Will be kept across the DUMP operation.
+ * @info: Genl receive info
+ *
+ * Some commands are related to PHY devices attached to netdevs. As there may be
+ * multiple PHYs, this DUMP handler will populate the reply with one message per
+ * PHY on a single netdev.
+ *
+ * Returns: 0 for success or when nothing to do, a negative value otherwise.
+ */
+int ethnl_dump_one_dev_perphy(struct sk_buff *skb,
+			      struct ethnl_dump_ctx *ctx,
+			      const struct genl_info *info)
+{
+	struct ethnl_dump_ctx_perphy *dump_ctx = ctx->cmd_ctx;
+	struct net_device *dev = ctx->reply_data->dev;
+	struct phy_device_node *pdn;
+	int ret = 0;
+
+	if (!dev->link_topo)
+		return 0;
+
+	xa_for_each_start(&dev->link_topo->phys, dump_ctx->phy_index,
+			  pdn, dump_ctx->phy_index) {
+		ctx->req_info->phy_index = dump_ctx->phy_index;
+
+		/* We can re-use the original dump_one as ->prepare_data in
+		 * commands use ethnl_req_get_phydev(), which gets the PHY from
+		 * what's in req_info
+		 */
+		ret = ethnl_default_dump_one(skb, ctx, info);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 static int ethnl_default_dump_one_dev(struct sk_buff *skb, struct net_device *dev,
 				      struct ethnl_dump_ctx *ctx,
 				      const struct genl_info *info)
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 79fe98190c64..530a9b5c8b39 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -327,6 +327,12 @@ struct ethnl_dump_ctx {
 	void				*cmd_ctx;
 };
 
+/* Generic callbacks to be used by PHY targeting commands */
+int ethnl_dump_start_perphy(struct ethnl_dump_ctx *ctx);
+int ethnl_dump_one_dev_perphy(struct sk_buff *skb, struct ethnl_dump_ctx *ctx,
+			      const struct genl_info *info);
+void ethnl_dump_done_perphy(struct ethnl_dump_ctx *ctx);
+
 int ethnl_ops_begin(struct net_device *dev);
 void ethnl_ops_complete(struct net_device *dev);
 
-- 
2.48.1


