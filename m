Return-Path: <netdev+bounces-177049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C03A6D86B
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 11:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A263A8790
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 10:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EA725DCF2;
	Mon, 24 Mar 2025 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y2dv5YKT"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9C725C6FE;
	Mon, 24 Mar 2025 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742812825; cv=none; b=phQM6WBe/yzl9dmczeIQAl6GH2TzwMiB7uyXpgnQH2/iz+1deBLTgrvfm9pcWR1fXuHGQZ0oqNIgQQGuiuTKaAakFrv9iIw4GM/yNNoYaZPvDxcvavgRR7C5U3ZfVWQUwl1h0JCYahYcc8pmzbDc1Ft72LeK+BFJlNv+lGJVpMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742812825; c=relaxed/simple;
	bh=kMybscdgGaHJw9+FAnU/QcjQMP6+FYe6JZlRsdjOPlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRxhtYpIZUB/H9EOa5fNwXFcVbAfanO87ZhS9SAbPzjVRrygWlmG8RBlPI+PhUpl1lcnCB2hJ0q/6TBnVaPaCFBXXuYD4MIVURvBOjLl6RVdSMCRR1HsWNw/JNhkQDrA29+7mzypSKYVKSZWR4nv8MawITDJAz/Py6xXbBS//6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y2dv5YKT; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A56114331A;
	Mon, 24 Mar 2025 10:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742812821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bynjWbNkBctQ6Jxc04916fgsV3PBTm6dOdvJ+TUtb28=;
	b=Y2dv5YKTqVI8LdnEynEEO/37DPTOzkNLhbj+/4oIPs9LaP6Iq2pM3IaIJcKxO8JIzlaO2F
	hA+FdvuGywcj37YQEnc47Bn2xT2dX8zw8iefuQDj3xqpVnxN7YQvB/cdz5y8E8Wnluc/jk
	5h2E6f7dbPlbe9EnUco/DpmzjCkznAy5fElySBksLNSWfCMFE1kXPrUkBe0zr7Y9oyXZQg
	aEREUI6+3cGao3DRqjU0jdV0LfCKwnxPO1IzoWiiAVzBPwgJKVqG2CaHkhz4x3LZ7kfiDj
	ey1REc7JthamfCvzaAmJUdOmamCrA1akbv9gEhrlLzJmuKbEVrDkNox3UPC7xQ==
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
Subject: [PATCH net-next v4 3/8] net: ethtool: netlink: Rename ethnl_default_dump_one
Date: Mon, 24 Mar 2025 11:40:05 +0100
Message-ID: <20250324104012.367366-4-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeehvdgrfeemjegsledumeduhegtleemtgeltdeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemhedvrgefmeejsgeludemudehtgelmegtledtiedphhgvlhhopeguvghvihgtvgdqvdegrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvuddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvu
 ghumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

As we work on getting more objects out of a per-netdev DUMP, rename
ethnl_default_dump_one() into ethnl_default_dump_one_dev(), making it
explicit that this dumps everything for one netdev.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V4 : No changes

 net/ethtool/netlink.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 31ab89ca0bcc..63ede3638708 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -540,9 +540,9 @@ static int ethnl_default_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
-				  const struct ethnl_dump_ctx *ctx,
-				  const struct genl_info *info)
+static int ethnl_default_dump_one_dev(struct sk_buff *skb, struct net_device *dev,
+				      const struct ethnl_dump_ctx *ctx,
+				      const struct genl_info *info)
 {
 	void *ehdr;
 	int ret;
@@ -590,7 +590,8 @@ static int ethnl_dump_all(struct sk_buff *skb, struct netlink_callback *cb)
 		rcu_read_unlock();
 
 		ctx->req_info->dev = dev;
-		ret = ethnl_default_dump_one(skb, dev, ctx, genl_info_dump(cb));
+		ret = ethnl_default_dump_one_dev(skb, dev, ctx,
+						 genl_info_dump(cb));
 
 		rcu_read_lock();
 		dev_put(dev);
@@ -618,8 +619,8 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
 		/* Filtered DUMP request targeted to a single netdev. We already
 		 * hold a ref to the netdev from ->start()
 		 */
-		ret = ethnl_default_dump_one(skb, ctx->req_info->dev, ctx,
-					     genl_info_dump(cb));
+		ret = ethnl_default_dump_one_dev(skb, ctx->req_info->dev, ctx,
+						 genl_info_dump(cb));
 		netdev_put(ctx->req_info->dev, &ctx->req_info->dev_tracker);
 
 		if (ret < 0 && ret != -EOPNOTSUPP && likely(skb->len))
-- 
2.48.1


