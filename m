Return-Path: <netdev+bounces-126721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDDE97250A
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 00:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7021F24BF9
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 22:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA5918CBE2;
	Mon,  9 Sep 2024 22:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/r2jklh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA5E18CBFF
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 22:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725919890; cv=none; b=ZD3OKdFEv+9EzwUFm0mee85vffTgymNMipF1K8kRXbwwv0VnkGBRDl+Jy6rFmRFlmvOApkyoJ6ObLvkB/+ePp5Jc3BR3O+oV77b9Fz9kjACI9So1RQTPM0Tnp27YEc4jT/ThJv9eh7x16qNHhGb4m/yWxZcv6zsNd4OP1m6Z/ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725919890; c=relaxed/simple;
	bh=rsP9Ll/uiVZ+HuTriAUJokmS6+iG2fbVRcpsqz0GD18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZoEaKfM+koGW9BoYW2jq5vSRkCQPLpo2RcNOnxRtW9SLN8foqxoDrzLBHiAXF1ap/yJFCCz34jNOM2w2wyoUR6IwI6rDTmvEJ9m5gnr8ygSg1TPFozrMRlrUPXYkbB9bdyn4SoHWVlDXlk16lD9hEvKxZ999f/PJ4KfyuvdQtaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/r2jklh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725919888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J01Bjsl7YWsZl9fOHpMh3iI7EGbOprCnGy3SY28REac=;
	b=F/r2jklh0xoThkNur2LGjtendkhYpnAxEEb54kgAtUysUPT4FC2kbKfvWxlf07IL42HCsX
	ryoeITafw3AvGjRhvi8BH9lY9+58yIin4oOXivrYewLjtbCjZLHuG5F4Fth39eaknaA8IT
	Te8gQKcznb7/b2dPzzGZJ4J3vqFeXXU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-a7mO6zluMuyHO_V-jiCNrQ-1; Mon,
 09 Sep 2024 18:11:23 -0400
X-MC-Unique: a7mO6zluMuyHO_V-jiCNrQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 023A119560B0;
	Mon,  9 Sep 2024 22:11:21 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.56])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F01C11956086;
	Mon,  9 Sep 2024 22:11:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	edumazet@google.com
Subject: [PATCH v7 net-next 06/15] net-shapers: implement delete support for NODE scope shaper
Date: Tue, 10 Sep 2024 00:10:00 +0200
Message-ID: <692d979b5f61e626f5ec078845d5557e85119375.1725919039.git.pabeni@redhat.com>
In-Reply-To: <cover.1725919039.git.pabeni@redhat.com>
References: <cover.1725919039.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Leverage the previously introduced group operation to implement
the removal of NODE scope shaper, re-linking its leaves under the
the parent node before actually deleting the specified NODE scope
shaper.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:
 - replace net_device* with binding* in most helpers
---
 net/shaper/shaper.c | 86 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 74 insertions(+), 12 deletions(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 3ffbd83b3e05..b502918b0a76 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -787,7 +787,8 @@ static int net_shaper_parent_from_leaves(int leaves_count,
 }
 
 static int __net_shaper_group(struct net_shaper_binding *binding,
-			      int leaves_count, struct net_shaper *leaves,
+			      bool update_node, int leaves_count,
+			      struct net_shaper *leaves,
 			      struct net_shaper *node,
 			      struct netlink_ext_ack *extack)
 {
@@ -833,12 +834,14 @@ static int __net_shaper_group(struct net_shaper_binding *binding,
 		}
 	}
 
-	/* For newly created node scope shaper, the following will update
-	 * the handle, due to id allocation.
-	 */
-	ret = net_shaper_pre_insert(binding, &node->handle, extack);
-	if (ret)
-		return ret;
+	if (update_node) {
+		/* For newly created node scope shaper, the following will
+		 * update the handle, due to id allocation.
+		 */
+		ret = net_shaper_pre_insert(binding, &node->handle, extack);
+		if (ret)
+			return ret;
+	}
 
 	for (i = 0; i < leaves_count; ++i) {
 		leaf_handle = leaves[i].handle;
@@ -866,7 +869,8 @@ static int __net_shaper_group(struct net_shaper_binding *binding,
 	 */
 	if (new_node && parent)
 		parent->leaves++;
-	net_shaper_commit(binding, 1, node);
+	if (update_node)
+		net_shaper_commit(binding, 1, node);
 	net_shaper_commit(binding, leaves_count, leaves);
 	return 0;
 
@@ -875,6 +879,64 @@ static int __net_shaper_group(struct net_shaper_binding *binding,
 	return ret;
 }
 
+static int net_shaper_pre_del_node(struct net_shaper_binding *binding,
+				   const struct net_shaper *shaper,
+				   struct netlink_ext_ack *extack)
+{
+	struct net_shaper_hierarchy *hierarchy = net_shaper_hierarchy(binding);
+	struct net_shaper *cur, *leaves, node = {};
+	int ret, leaves_count = 0;
+	unsigned long index;
+	bool update_node;
+
+	if (!shaper->leaves)
+		return 0;
+
+	/* Fetch the new node information. */
+	node.handle = shaper->parent;
+	cur = net_shaper_lookup(binding, &node.handle);
+	if (cur) {
+		node = *cur;
+	} else {
+		/* A scope NODE shaper can be nested only to the NETDEV scope
+		 * shaper without creating the latter, this check may fail only
+		 * if the data is in inconsistent status.
+		 */
+		if (WARN_ON_ONCE(node.handle.scope != NET_SHAPER_SCOPE_NETDEV))
+			return -EINVAL;
+	}
+
+	leaves = kcalloc(shaper->leaves, sizeof(struct net_shaper),
+			 GFP_KERNEL);
+	if (!leaves)
+		return -ENOMEM;
+
+	/* Build the leaves arrays. */
+	xa_for_each(&hierarchy->shapers, index, cur) {
+		if (net_shaper_handle_cmp(&cur->parent, &shaper->handle))
+			continue;
+
+		if (WARN_ON_ONCE(leaves_count == shaper->leaves)) {
+			ret = -EINVAL;
+			goto free;
+		}
+
+		leaves[leaves_count++] = *cur;
+	}
+
+	/* When re-linking to the netdev shaper, avoid the eventual, implicit,
+	 * creation of the new node, would be surprising since the user is
+	 * doing a delete operation.
+	 */
+	update_node = node.handle.scope != NET_SHAPER_SCOPE_NETDEV;
+	ret = __net_shaper_group(binding, update_node, leaves_count,
+				 leaves, &node, extack);
+
+free:
+	kfree(leaves);
+	return ret;
+}
+
 int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net_shaper_hierarchy *hierarchy;
@@ -907,9 +969,9 @@ int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (handle.scope == NET_SHAPER_SCOPE_NODE) {
-		/* TODO: implement support for scope NODE delete. */
-		ret = -EINVAL;
-		goto unlock;
+		ret = net_shaper_pre_del_node(binding, shaper, info->extack);
+		if (ret)
+			goto unlock;
 	}
 
 	ret = __net_shaper_delete(binding, shaper, info->extack);
@@ -1029,7 +1091,7 @@ int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	ret = __net_shaper_group(binding, leaves_count, leaves, &node,
+	ret = __net_shaper_group(binding, true, leaves_count, leaves, &node,
 				 info->extack);
 	if (ret)
 		goto free_msg;
-- 
2.45.2


