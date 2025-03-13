Return-Path: <netdev+bounces-174702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06255A5FF28
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 19:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250B919C15EC
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 18:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE1E1EEA2C;
	Thu, 13 Mar 2025 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nHZrjwQo"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71FA17E8E2;
	Thu, 13 Mar 2025 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890416; cv=none; b=UE/uv2gQ6glr+7+sIlQ56KnpXn2bSbWA8UPtjKNIcc5Ke3fdwJC/OJadEGI7RuyWuJC6yJTcPEdT2kiscSBMyk9yAN/A6qsLIyHtCUlmiTU3nffPPufG4XDqPlNGgskb6cEZtmEF0OeYJcZidzcitJkmqsAjjMbalCWw2ev7Qo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890416; c=relaxed/simple;
	bh=48ntiqbYlyXy3mLOsdT8Eab46zF4uPHG4q4ytOJAtIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYZ6gsOauyWnecBsVdzpd7PkVVSjexFDl4XWw3bMpgD0cPf4Ry0L5Y2z5Pok69Ldv/HnoOYaGNG69fB3ZoIeNBS7o9wShQ0oQqfkBCDvOKKOjIw++uu7p8MhyGmtn6J5ZiOFMP0eDAPrwA9y4+T7WKZKUGbyrLweYk2GMde5nsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nHZrjwQo; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C477220457;
	Thu, 13 Mar 2025 18:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741890411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ur4qggA9DegsBrL273HPT9/qtLwWjJSN1L4MMDhc1oY=;
	b=nHZrjwQo1jwTdKg2UlRWbWxLNc1+6ovFJVD+wCVxESvlFOu3LtsPvOXj35tWgAfDt7XVYf
	lbpJv8dvrJmt0z/RSwn/uuwDuEL8a3ftj4HCbidJ6qjuP8/eehmjkMXuIVLSWOC2f281CQ
	r2JQ3MnzebgItLsgCoxUWl3sSUwTOlBjsDp8J3ETRWdbTDkwas4xWFOZ3MhSsm+HSNkz1s
	TaNyaaD3AZA4zn3hJbLRWWRO5y4LIUAv8toNWy75ACtOgdFBx+WaY+tRxOzO8AdpmpaIbu
	x7rsT9JQFvj00uwm73jzrNbr3G6/Zq3X0uZeO3InObbA2sZJPxRSd/1ynN44Bw==
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
Subject: [PATCH net-next v3 1/7] net: ethtool: netlink: Allow per-netdevice DUMP operations
Date: Thu, 13 Mar 2025 19:26:40 +0100
Message-ID: <20250313182647.250007-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313182647.250007-1-maxime.chevallier@bootlin.com>
References: <20250313182647.250007-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdqvddrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguu
 hhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

We have a number of netlink commands in the ethnl family that may have
multiple objects to dump even for a single net_device, including :

 - PLCA, PSE-PD, phy: one message per PHY device
 - tsinfo: one message per timestamp source (netdev + phys)
 - rss: One per RSS context

To get this behaviour, these netlink commands need to roll a custom
->dumpit().

To prepare making per-netdev DUMP more generic in ethnl, introduce a
member in the ethnl ops to indicate if a given command may allow
pernetdev DUMPs (also referred to as filtered DUMPs).

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 net/ethtool/netlink.c | 45 +++++++++++++++++++++++++++++--------------
 net/ethtool/netlink.h |  2 ++
 2 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index a163d40c6431..7adede5e4ff1 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -587,21 +587,38 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
 	int ret = 0;
 
 	rcu_read_lock();
-	for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
-		dev_hold(dev);
+	if (ctx->req_info->dev) {
+		dev = ctx->req_info->dev;
 		rcu_read_unlock();
+		/* Filtered DUMP request targeted to a single netdev. We already
+		 * hold a ref to the netdev from ->start()
+		 */
+		ret = ethnl_default_dump_one(skb, dev, ctx,
+					     genl_info_dump(cb));
+		rcu_read_lock();
+		netdev_put(ctx->req_info->dev, &ctx->req_info->dev_tracker);
 
-		ret = ethnl_default_dump_one(skb, dev, ctx, genl_info_dump(cb));
+		if (ret < 0 && ret != -EOPNOTSUPP && likely(skb->len))
+			ret = skb->len;
 
-		rcu_read_lock();
-		dev_put(dev);
+	} else {
+		for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
+			dev_hold(dev);
+			rcu_read_unlock();
+
+			ret = ethnl_default_dump_one(skb, dev, ctx,
+						     genl_info_dump(cb));
+
+			rcu_read_lock();
+			dev_put(dev);
 
-		if (ret < 0 && ret != -EOPNOTSUPP) {
-			if (likely(skb->len))
-				ret = skb->len;
-			break;
+			if (ret < 0 && ret != -EOPNOTSUPP) {
+				if (likely(skb->len))
+					ret = skb->len;
+				break;
+			}
+			ret = 0;
 		}
-		ret = 0;
 	}
 	rcu_read_unlock();
 
@@ -635,10 +652,10 @@ static int ethnl_default_start(struct netlink_callback *cb)
 	}
 
 	ret = ethnl_default_parse(req_info, &info->info, ops, false);
-	if (req_info->dev) {
-		/* We ignore device specification in dump requests but as the
-		 * same parser as for non-dump (doit) requests is used, it
-		 * would take reference to the device if it finds one
+	if (req_info->dev && !ops->allow_pernetdev_dump) {
+		/* We ignore device specification in unfiltered dump requests
+		 * but as the same parser as for non-dump (doit) requests is
+		 * used, it would take reference to the device if it finds one
 		 */
 		netdev_put(req_info->dev, &req_info->dev_tracker);
 		req_info->dev = NULL;
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index ec6ab5443a6f..4aaa73282d6a 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -331,6 +331,7 @@ int ethnl_sock_priv_set(struct sk_buff *skb, struct net_device *dev, u32 portid,
  * @req_info_size:    size of request info
  * @reply_data_size:  size of reply data
  * @allow_nodev_do:   allow non-dump request with no device identification
+ * @allow_pernetdev_dump: allow filtering dump requests with ifname/ifindex
  * @set_ntf_cmd:      notification to generate on changes (SET)
  * @parse_request:
  *	Parse request except common header (struct ethnl_req_info). Common
@@ -388,6 +389,7 @@ struct ethnl_request_ops {
 	unsigned int		req_info_size;
 	unsigned int		reply_data_size;
 	bool			allow_nodev_do;
+	bool			allow_pernetdev_dump;
 	u8			set_ntf_cmd;
 
 	int (*parse_request)(struct ethnl_req_info *req_info,
-- 
2.48.1


