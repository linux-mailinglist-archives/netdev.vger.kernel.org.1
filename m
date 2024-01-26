Return-Path: <netdev+bounces-66273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D57283E32E
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 21:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05911F2698B
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 20:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2DE22EE6;
	Fri, 26 Jan 2024 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Db+JmxD1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B68123742
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 20:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300094; cv=none; b=nUz9iSwhI4ePNIwQDdCxIgGzVMLPusX5shG/63jX3WAyw2SeuHN0HmiK1Q/anAgqtmf1wBHh+kMbJ2u7vIQHHJ09Om/0zgYltGy3wJ9nTuEvs7Z7C+jf4/j9Y3zOmktEBpQTqnMVtic54mfVkbATfknrwCjZsPkRUJnmJtZn1uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300094; c=relaxed/simple;
	bh=+ZC6EtUn0yC4lmfCkBIoBYYac/G8j4ugd66iraSTUAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MAN2zF4CJYlRfgPZ4BdlL3bVv0T3+UsQ5VFunaDJoUUJ/PLC8YZh9M3VHB0ZufjdElervH2VD3heXplm5Jn+ucJwmBoIsqGYYJn27bcuXieT1vwPm6IdVAA+9LYIqjOOOrRP+dy3QCt9jocmTDrKI1e5lkiNvdJVvsVTBITSvx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Db+JmxD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75465C433F1;
	Fri, 26 Jan 2024 20:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706300093;
	bh=+ZC6EtUn0yC4lmfCkBIoBYYac/G8j4ugd66iraSTUAs=;
	h=From:To:Cc:Subject:Date:From;
	b=Db+JmxD1k6fw5KmrkYkTvU5cVBzjONn2URwG+kL3Zt3mM8r/sRkHbwh9l51zS8MA6
	 ld5MrlyPTHfSXGsyEP2aetO61JASW1TXa9FyLiJOydwVa3DXpx9ySrIPHuJp/5d0ax
	 sh76lRMIcqZrd8Bebq/k0Odb4Qm2J7q8NJzgkd4EWE4DU4QeVg1uDsB56N02rwwKIo
	 RX/Ly6qXS8X7SgOO3mMcnYMttdHadbkzuNcH1m0NjV7sGspnoC6QIVcEoat1ZUwsHb
	 E4MebQeRWzSW1T/e4AP8f2Ww1JP5SD9tBCBbfchxaNICprw5Kr6IUtH0n5l84oK5+y
	 Q+otlseCERERg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	daniel@iogearbox.net,
	jiri@resnulli.us,
	lucien.xin@gmail.com,
	johannes.berg@intel.com
Subject: [PATCH net-next] net: free altname using an RCU callback
Date: Fri, 26 Jan 2024 12:14:49 -0800
Message-ID: <20240126201449.2904078-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We had to add another synchronize_rcu() in recent fix.
Bite the bullet and add an rcu_head to netdev_name_node,
free from RCU.

Note that name_node does not hold any reference on dev
to which it points, but there must be a synchronize_rcu()
on device removal path, so we should be fine.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: daniel@iogearbox.net
CC: jiri@resnulli.us
CC: lucien.xin@gmail.com
CC: johannes.berg@intel.com
---
 net/core/dev.c | 27 ++++++++++++++++-----------
 net/core/dev.h |  1 +
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index cb2dab0feee0..b53b9c94de40 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -341,13 +341,22 @@ int netdev_name_node_alt_create(struct net_device *dev, const char *name)
 	return 0;
 }
 
-static void __netdev_name_node_alt_destroy(struct netdev_name_node *name_node)
+static void netdev_name_node_alt_free(struct rcu_head *head)
 {
-	list_del(&name_node->list);
+	struct netdev_name_node *name_node =
+		container_of(head, struct netdev_name_node, rcu);
+
 	kfree(name_node->name);
 	netdev_name_node_free(name_node);
 }
 
+static void __netdev_name_node_alt_destroy(struct netdev_name_node *name_node)
+{
+	netdev_name_node_del(name_node);
+	list_del(&name_node->list);
+	call_rcu(&name_node->rcu, netdev_name_node_alt_free);
+}
+
 int netdev_name_node_alt_destroy(struct net_device *dev, const char *name)
 {
 	struct netdev_name_node *name_node;
@@ -362,10 +371,7 @@ int netdev_name_node_alt_destroy(struct net_device *dev, const char *name)
 	if (name_node == dev->name_node || name_node->dev != dev)
 		return -EINVAL;
 
-	netdev_name_node_del(name_node);
-	synchronize_rcu();
 	__netdev_name_node_alt_destroy(name_node);
-
 	return 0;
 }
 
@@ -373,8 +379,10 @@ static void netdev_name_node_alt_flush(struct net_device *dev)
 {
 	struct netdev_name_node *name_node, *tmp;
 
-	list_for_each_entry_safe(name_node, tmp, &dev->name_node->list, list)
-		__netdev_name_node_alt_destroy(name_node);
+	list_for_each_entry_safe(name_node, tmp, &dev->name_node->list, list) {
+		list_del(&name_node->list);
+		netdev_name_node_alt_free(&name_node->rcu);
+	}
 }
 
 /* Device list insertion */
@@ -11576,11 +11584,8 @@ static void __net_exit default_device_exit_net(struct net *net)
 			snprintf(fb_name, IFNAMSIZ, "dev%%d");
 
 		netdev_for_each_altname_safe(dev, name_node, tmp)
-			if (netdev_name_in_use(&init_net, name_node->name)) {
-				netdev_name_node_del(name_node);
-				synchronize_rcu();
+			if (netdev_name_in_use(&init_net, name_node->name))
 				__netdev_name_node_alt_destroy(name_node);
-			}
 
 		err = dev_change_net_namespace(dev, &init_net, fb_name);
 		if (err) {
diff --git a/net/core/dev.h b/net/core/dev.h
index 7480b4c84298..a43dfe3de50e 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -56,6 +56,7 @@ struct netdev_name_node {
 	struct list_head list;
 	struct net_device *dev;
 	const char *name;
+	struct rcu_head rcu;
 };
 
 int netdev_get_name(struct net *net, char *name, int ifindex);
-- 
2.43.0


