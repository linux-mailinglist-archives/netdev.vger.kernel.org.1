Return-Path: <netdev+bounces-174704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C65A5FF2C
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 19:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E336D3BF602
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 18:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A861F153C;
	Thu, 13 Mar 2025 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eUX3yj5e"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582CA1EF0AE;
	Thu, 13 Mar 2025 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890418; cv=none; b=aXDaav4KX2ENyEsvpv5DqeO1Pzo7x9FOdPJTnR//Z9xE+W17GLTvFTfXtSH8NRLRPz+Bz2AA/O3RqISnJ+4SSLpRLcRreA/pPaoOsNCGQ7L56MfijVKSx9gk58Nrxb04qrILl582dCCH43biLschfVxm5Z+yIRn8u8naqY7ekZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890418; c=relaxed/simple;
	bh=Trwzh+1uI089xxbPr/5OoLwfOISvTCGFKd1xgYcuuYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPPdk9DDZvL8QRbi2gl4JV4II4deBS+aW5FdBs7qejpW4JsdQIoUJJedKfRrxJxTGQ4J0Hf4riAtsffp8XF0p7Lblr0txi1QHEsD8CP2yszgUEaNIGp9VbRpfQhVv1oA6xD3KoXDLHYzklgCYwrDeiIR6bZdfRmNDb5Typ/JWP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eUX3yj5e; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2EED220483;
	Thu, 13 Mar 2025 18:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741890414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7p82QQTCNn5aWbI81oQLDxx2PK3gOSFMLvfRqeu+jK8=;
	b=eUX3yj5eyIIaJqOtg3SkruBLDLB+tKfXbiI9y4ExzDaKx8ahud/DqStq3TTzFCM33tzSIv
	e0DjiT0kuULaGHIyC9IIQa3gw5YZuvUsPCQGtsOqH80Z63yArtMpOooUh4bRyz6Y/76t8u
	cU75FeVOF02ZggQArJuPOZjTsZQxnxwqwfUgWnmxgCxphmD8q3UVVkN0O+oirna+lVHI2o
	8ifYSKosIy9dFKX7qLYCv8ZjGd1CszmiApGBgCqqR78fGGVIDrDjBKQbHzMlhpbqDB3c+r
	UpAjZFGko4hx6db0ch1CH5vTNSr313cVBHsnvp20W74zZmyUqbab+f4BuY9FhA==
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
Subject: [PATCH net-next v3 3/7] net: ethtool: netlink: Introduce command-specific dump_one_dev
Date: Thu, 13 Mar 2025 19:26:42 +0100
Message-ID: <20250313182647.250007-4-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdqvddrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguu
 hhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Prepare more generic ethnl DUMP hanldling, by allowing netlink commands
to register their own dump_one_dev() callback. This avoids having to
roll with a fully custom genl ->dumpit callback, allowing the re-use
of some ethnl plumbing.

Fallback to the default dump_one_dev behaviour when no custom callback
is found.

The command dump context is maintained within the ethnl_dump_ctx, that
we move in netlink.h so that command handlers can access it.

This context can be allocated/freed in new ->dump_start() and
->dump_done() callbacks.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 net/ethtool/netlink.c | 62 +++++++++++++++++++++++++------------------
 net/ethtool/netlink.h | 35 ++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 26 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 644c202d284d..2dc6086e1ab5 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -339,24 +339,6 @@ int ethnl_multicast(struct sk_buff *skb, struct net_device *dev)
 
 /* GET request helpers */
 
-/**
- * struct ethnl_dump_ctx - context structure for generic dumpit() callback
- * @ops:        request ops of currently processed message type
- * @req_info:   parsed request header of processed request
- * @reply_data: data needed to compose the reply
- * @pos_ifindex: saved iteration position - ifindex
- *
- * These parameters are kept in struct netlink_callback as context preserved
- * between iterations. They are initialized by ethnl_default_start() and used
- * in ethnl_default_dumpit() and ethnl_default_done().
- */
-struct ethnl_dump_ctx {
-	const struct ethnl_request_ops	*ops;
-	struct ethnl_req_info		*req_info;
-	struct ethnl_reply_data		*reply_data;
-	unsigned long			pos_ifindex;
-};
-
 static const struct ethnl_request_ops *
 ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_STRSET_GET]	= &ethnl_strset_request_ops,
@@ -540,9 +522,9 @@ static int ethnl_default_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static int ethnl_default_dump_one_dev(struct sk_buff *skb, struct net_device *dev,
-				      const struct ethnl_dump_ctx *ctx,
-				      const struct genl_info *info)
+static int ethnl_default_dump_one(struct sk_buff *skb,
+				  const struct ethnl_dump_ctx *ctx,
+				  const struct genl_info *info)
 {
 	void *ehdr;
 	int ret;
@@ -553,15 +535,15 @@ static int ethnl_default_dump_one_dev(struct sk_buff *skb, struct net_device *de
 	if (!ehdr)
 		return -EMSGSIZE;
 
-	ethnl_init_reply_data(ctx->reply_data, ctx->ops, dev);
 	rtnl_lock();
-	netdev_lock_ops(dev);
+	netdev_lock_ops(ctx->reply_data->dev);
 	ret = ctx->ops->prepare_data(ctx->req_info, ctx->reply_data, info);
-	netdev_unlock_ops(dev);
+	netdev_unlock_ops(ctx->reply_data->dev);
 	rtnl_unlock();
 	if (ret < 0)
 		goto out;
-	ret = ethnl_fill_reply_header(skb, dev, ctx->ops->hdr_attr);
+	ret = ethnl_fill_reply_header(skb, ctx->reply_data->dev,
+				      ctx->ops->hdr_attr);
 	if (ret < 0)
 		goto out;
 	ret = ctx->ops->fill_reply(skb, ctx->req_info, ctx->reply_data);
@@ -569,11 +551,29 @@ static int ethnl_default_dump_one_dev(struct sk_buff *skb, struct net_device *de
 out:
 	if (ctx->ops->cleanup_data)
 		ctx->ops->cleanup_data(ctx->reply_data);
-	ctx->reply_data->dev = NULL;
+
 	if (ret < 0)
 		genlmsg_cancel(skb, ehdr);
 	else
 		genlmsg_end(skb, ehdr);
+
+	return ret;
+}
+
+static int ethnl_default_dump_one_dev(struct sk_buff *skb, struct net_device *dev,
+				      struct ethnl_dump_ctx *ctx,
+				      const struct genl_info *info)
+{
+	int ret;
+
+	ethnl_init_reply_data(ctx->reply_data, ctx->ops, dev);
+
+	if (ctx->ops->dump_one_dev)
+		ret = ctx->ops->dump_one_dev(skb, ctx, info);
+	else
+		ret = ethnl_default_dump_one(skb, ctx, info);
+
+	ctx->reply_data->dev = NULL;
 	return ret;
 }
 
@@ -606,6 +606,7 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
 			dev_hold(dev);
 			rcu_read_unlock();
 
+			ctx->req_info->dev = dev;
 			ret = ethnl_default_dump_one_dev(skb, dev, ctx,
 							 genl_info_dump(cb));
 
@@ -668,6 +669,12 @@ static int ethnl_default_start(struct netlink_callback *cb)
 	ctx->reply_data = reply_data;
 	ctx->pos_ifindex = 0;
 
+	if (ctx->ops->dump_start) {
+		ret = ctx->ops->dump_start(ctx);
+		if (ret)
+			goto free_reply_data;
+	}
+
 	return 0;
 
 free_reply_data:
@@ -683,6 +690,9 @@ static int ethnl_default_done(struct netlink_callback *cb)
 {
 	struct ethnl_dump_ctx *ctx = ethnl_dump_context(cb);
 
+	if (ctx->ops->dump_done)
+		ctx->ops->dump_done(ctx);
+
 	kfree(ctx->reply_data);
 	kfree(ctx->req_info);
 
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 4aaa73282d6a..79fe98190c64 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -307,6 +307,26 @@ struct ethnl_reply_data {
 	struct net_device		*dev;
 };
 
+/**
+ * struct ethnl_dump_ctx - context structure for generic dumpit() callback
+ * @ops:        request ops of currently processed message type
+ * @req_info:   parsed request header of processed request
+ * @reply_data: data needed to compose the reply
+ * @pos_ifindex: saved iteration position - ifindex
+ * @cmd_ctx: command-specific context to maintain across the dump.
+ *
+ * These parameters are kept in struct netlink_callback as context preserved
+ * between iterations. They are initialized by ethnl_default_start() and used
+ * in ethnl_default_dumpit() and ethnl_default_done().
+ */
+struct ethnl_dump_ctx {
+	const struct ethnl_request_ops	*ops;
+	struct ethnl_req_info		*req_info;
+	struct ethnl_reply_data		*reply_data;
+	unsigned long			pos_ifindex;
+	void				*cmd_ctx;
+};
+
 int ethnl_ops_begin(struct net_device *dev);
 void ethnl_ops_complete(struct net_device *dev);
 
@@ -373,6 +393,15 @@ int ethnl_sock_priv_set(struct sk_buff *skb, struct net_device *dev, u32 portid,
  *	 - 0 if no configuration has changed
  *	 - 1 if configuration changed and notification should be generated
  *	 - negative errno on errors
+ * @dump_start:
+ *	Optional callback to prepare a dump operation, should there be a need
+ *	to maintain some context across the dump.
+ * @dump_one_dev:
+ *	Optional callback to generate all messages for a given netdev. This
+ *	is relevant only when a request can produce different results for the
+ *	same netdev depending on command-specific attributes.
+ * @dump_done:
+ *	Optional callback to cleanup any context allocated in ->dump_start()
  *
  * Description of variable parts of GET request handling when using the
  * unified infrastructure. When used, a pointer to an instance of this
@@ -409,6 +438,12 @@ struct ethnl_request_ops {
 			    struct genl_info *info);
 	int (*set)(struct ethnl_req_info *req_info,
 		   struct genl_info *info);
+
+	int (*dump_start)(struct ethnl_dump_ctx *ctx);
+	int (*dump_one_dev)(struct sk_buff *skb,
+			    struct ethnl_dump_ctx *ctx,
+			    const struct genl_info *info);
+	void (*dump_done)(struct ethnl_dump_ctx *ctx);
 };
 
 /* request handlers */
-- 
2.48.1


