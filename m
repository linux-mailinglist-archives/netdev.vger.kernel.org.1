Return-Path: <netdev+bounces-130414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5295898A664
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D15901F24924
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF91D193078;
	Mon, 30 Sep 2024 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOuTcNe0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535FF193094
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704518; cv=none; b=J+mz3Xgse2OJto7scwgDSo0pq4MkAMwzN/QxmIxnuCwKkv7UnDStEsCETYpKG5cSVJG+uOKri3y7wB6bczSGS9MhNmWXTp/lYGbY7kcAnQ2syJnZKaWgvKQZgyqrk+WLY7eCcYWQHdfC6KF93cnJo2lNJafXNOMpgng0OJmbNpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704518; c=relaxed/simple;
	bh=kjHW+7JzBRY5FwCd+65gtgeg/VXc4jwR7Qo7McisNnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7rktkBg7dZ/1OECAbF7GFHsnghHCNc1gCt//0N+Wgo0D9WncAGT+pTbupOeYCUwE6vrcyYrrcJegQXJzbimKg8KgOsFtNPAhHaIifJJjHpDJIcyqhoCDe1ciulsSuxLLGp0BTMAsWkj5hvBxqx8EYSAiIJcLzuwj/f+WN56Y/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dOuTcNe0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727704516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itQqSMmcnuqOcTVKrIqn0qwdQgFoZVIuBpjfiR3qywk=;
	b=dOuTcNe0hqKe3uU7Ad3ViM5E/azDF6E78+EN5Loy5CYXVksxuI37XRY+mxs78pno3/gxVa
	o9/YFTWLWcO/PLwqPrfWc8zhIxiJPpHSvG7vqunMw0lnKv8vFUFVOPg2RMwp3SqbvvJRKy
	/HzEPXLNXOzLbnyIvk3u79yPjAaqlNk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-P3enHXx3P1ikreEE3knA1g-1; Mon,
 30 Sep 2024 09:55:11 -0400
X-MC-Unique: P3enHXx3P1ikreEE3knA1g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D69521955D42;
	Mon, 30 Sep 2024 13:55:08 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.210])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE73F19541A6;
	Mon, 30 Sep 2024 13:55:03 +0000 (UTC)
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
	edumazet@google.com,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH v8 net-next 06/15] net-shapers: implement delete support for NODE scope shaper
Date: Mon, 30 Sep 2024 15:53:53 +0200
Message-ID: <cf78b5bc635b31f6d589cd5f8fdd21fe6237789c.1727704215.git.pabeni@redhat.com>
In-Reply-To: <cover.1727704215.git.pabeni@redhat.com>
References: <cover.1727704215.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
index c23ac611850d..ddd1999b3f27 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -785,7 +785,8 @@ static int net_shaper_parent_from_leaves(int leaves_count,
 }
 
 static int __net_shaper_group(struct net_shaper_binding *binding,
-			      int leaves_count, struct net_shaper *leaves,
+			      bool update_node, int leaves_count,
+			      struct net_shaper *leaves,
 			      struct net_shaper *node,
 			      struct netlink_ext_ack *extack)
 {
@@ -831,12 +832,14 @@ static int __net_shaper_group(struct net_shaper_binding *binding,
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
@@ -864,7 +867,8 @@ static int __net_shaper_group(struct net_shaper_binding *binding,
 	 */
 	if (new_node && parent)
 		parent->leaves++;
-	net_shaper_commit(binding, 1, node);
+	if (update_node)
+		net_shaper_commit(binding, 1, node);
 	net_shaper_commit(binding, leaves_count, leaves);
 	return 0;
 
@@ -873,6 +877,64 @@ static int __net_shaper_group(struct net_shaper_binding *binding,
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
@@ -905,9 +967,9 @@ int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -1027,7 +1089,7 @@ int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	ret = __net_shaper_group(binding, leaves_count, leaves, &node,
+	ret = __net_shaper_group(binding, true, leaves_count, leaves, &node,
 				 info->extack);
 	if (ret)
 		goto free_msg;
-- 
2.45.2


