Return-Path: <netdev+bounces-173177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A632A57BAF
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 16:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FFFE7A77EE
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 15:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6921E51EC;
	Sat,  8 Mar 2025 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Gpb4oegQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEDF1DE3DC;
	Sat,  8 Mar 2025 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741449295; cv=none; b=rd9tFkzpJrL28NMr5f13RANYs2q8DVqG0pWMSW0xB7q9QtrLad6Sqsz3YZoJ9jn1R9TFSsePKi51EuyeKJyKQHirJWrXJ85iU88YUaBDaKfikGr4/jNW3TYmTraf8BxEYGajPIKh5C0UmJ05ia+Xtw8s1ZuQ9Ue8VFO4oijg7c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741449295; c=relaxed/simple;
	bh=fqJVVd2/eraKWPgIGQ/4lIhI4jdqIcKF8O6qa6eMI/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6KuWoHJSkrHXY/7Px5NZ3VwNALA0BigSY0QFUAQPsoMqJguU69+TN8KdWjsBNR4ofu/JoWn646fTPihkG68n6mn9LJLhk9uWVCZUFxgCGDxDzswf1UOp6splCjYDAB03WtVnT2mmCOkEFbVe2m+hQlSbKVHRZMXfMMzwYhfArU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Gpb4oegQ; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E957620479;
	Sat,  8 Mar 2025 15:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741449286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2UwmBGloiWK5RwG3+9CXOmQkF8j2hUhncuhw9qjmriY=;
	b=Gpb4oegQ0coBIBM3ZWW/WpaeaMhPt0yPBi+WTZWqOqUqhppPHy734euH4mwL+78H7sHCvq
	0ANkNlcCoHLXZOwaZHlzlYUcRwKrSC09UDWFEGBfKbSu3spc8Ka95ykhhwMrvdSIOL74dS
	rcO+EkhKob04QplJ2jtGL10y3UJxarW8Jega5Va+qqZmXhY1QKq0sTj2BrKLS9hBFraGpe
	QiiuR4YIgazL1uJHL6BMDAqlrMKtQ1Gb77DBouHftmMco+zmyi2KqZ24lm0LnZPsMS5Ulh
	kBBUBQ/AtibuODr1FhyKO6difcanpvR6TaINtHBu6hbM4pyhJZ6x/xrePqxjhQ==
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
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v2 1/7] net: ethtool: netlink: Allow per-netdevice DUMP operations
Date: Sat,  8 Mar 2025 16:54:33 +0100
Message-ID: <20250308155440.267782-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250308155440.267782-1-maxime.chevallier@bootlin.com>
References: <20250308155440.267782-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudefleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddvpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmr
 giivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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
V2: - Rebase
    - Fix kdoc
    - Fix bissectabilitu by using the right function names

 net/ethtool/netlink.c | 45 ++++++++++++++++++++++++++++---------------
 net/ethtool/netlink.h |  2 ++
 2 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 70834947f474..11e4122b7707 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -586,21 +586,34 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
 	int ret = 0;
 
 	rcu_read_lock();
-	for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
-		dev_hold(dev);
+	if (ctx->req_info->dev) {
+		dev = ctx->req_info->dev;
 		rcu_read_unlock();
-
-		ret = ethnl_default_dump_one(skb, dev, ctx, genl_info_dump(cb));
-
+		/* Filtered DUMP request targeted to a single netdev. We already
+		 * hold a ref to the netdev from ->start()
+		 */
+		ret = ethnl_default_dump_one(skb, dev, ctx,
+					     genl_info_dump(cb));
 		rcu_read_lock();
-		dev_put(dev);
-
-		if (ret < 0 && ret != -EOPNOTSUPP) {
-			if (likely(skb->len))
-				ret = skb->len;
-			break;
+		netdev_put(ctx->req_info->dev, &ctx->req_info->dev_tracker);
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
+
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
 
@@ -634,10 +647,10 @@ static int ethnl_default_start(struct netlink_callback *cb)
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


