Return-Path: <netdev+bounces-123356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E52289649BF
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6EA5B207D0
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466471B1514;
	Thu, 29 Aug 2024 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hapwIfMf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ABE1B2508
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944683; cv=none; b=NbIulA0wwS1pqHgiJmBrcgXRHH/vo11j2rUVsME1jeO2+XAmRdNT5+VpfslVMmy2eI1i/eEYHlu/N2E4LmVaYLuUO6t0H5E4p8xHL3pyE6GKPsv5xoSSmKNNKxVsoyasnAxTFfBPLBf7Yli+i+MyBJx3tM9X3/q6R/ysoOWsflw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944683; c=relaxed/simple;
	bh=prxbfwQUi22v2LEpPXzbfVslqxIpFONUDUCqB8vR2IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSrA1vJiXBWFBfTHgOe7WseF59kdD8Cd/v4mCuLAID61eLQzizqyuKcdOcMe+BOaZgfOFovvtfmdkEzk60Y6ztSWkMEJ8xIaBT+mQ+wPuxWWG4YCDoM6ZqRUlC5asNEdbXtKV1x8T/q2Tcn8dykzDi2x4zlDrBvuEJ2vO+dLlPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hapwIfMf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724944680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7RTWLeNuTd3THAPhgQZAWQBar62RfIOOxscc4k7O9c=;
	b=hapwIfMfv8j433unk9RwAfjH6k75iqxB3FBV3ivoQEOBhhTm5UcjzdbAL3VffsgYSxfgwo
	ChR+XdrBqsnNAHTeP+5hDmJS8MI2942QId3RGRKFq3Rudzgu+tgMlFiYPKDShCG2Axt3AX
	G11i9ECaJ0UCoWxWGxCRM0sNwQ2++mE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-ots-xb-_Nxuk0Ix-TkxfLg-1; Thu,
 29 Aug 2024 11:17:55 -0400
X-MC-Unique: ots-xb-_Nxuk0Ix-TkxfLg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6019819560B4;
	Thu, 29 Aug 2024 15:17:53 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.217])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7BD05300019C;
	Thu, 29 Aug 2024 15:17:48 +0000 (UTC)
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
Subject: [PATCH v5 net-next 05/12] net-shapers: implement delete support for NODE scope shaper
Date: Thu, 29 Aug 2024 17:16:58 +0200
Message-ID: <c84fe3b76210a3a2224e16bc5c5826f3b71617f9.1724944117.git.pabeni@redhat.com>
In-Reply-To: <cover.1724944116.git.pabeni@redhat.com>
References: <cover.1724944116.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Leverage the previously introduced group operation to implement
the removal of NODE scope shaper, re-linking its leaves under the
the parent node before actually deleting the specified NODE scope
shaper.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:
 - replace net_device* with binding* in most helpers
---
 net/shaper/shaper.c | 99 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 87 insertions(+), 12 deletions(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index f5e8464b8408..f0d594a34588 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -799,7 +799,7 @@ static int __net_shaper_delete(struct net_shaper_binding *binding,
 }
 
 static int __net_shaper_group(struct net_shaper_binding *binding,
-			      int leaves_count,
+			      bool cache_node, int leaves_count,
 			      const struct net_shaper_handle *leaves_handles,
 			      struct net_shaper_info *leaves,
 			      struct net_shaper_handle *node_handle,
@@ -850,12 +850,15 @@ static int __net_shaper_group(struct net_shaper_binding *binding,
 		}
 	}
 
-	/* For newly created node scope shaper, the following will update
-	 * the handle, due to id allocation.
-	 */
-	ret = net_shaper_cache_pre_insert(binding, node_handle, extack);
-	if (ret)
-		return ret;
+	if (cache_node) {
+		/* For newly created node scope shaper, the following will
+		 * update the handle, due to id allocation.
+		 */
+		ret = net_shaper_cache_pre_insert(binding, node_handle,
+						  extack);
+		if (ret)
+			return ret;
+	}
 
 	for (i = 0; i < leaves_count; ++i) {
 		leaf_handle = leaves_handles[i];
@@ -883,7 +886,8 @@ static int __net_shaper_group(struct net_shaper_binding *binding,
 
 	if (parent)
 		parent->leaves++;
-	net_shaper_cache_commit(binding, 1, node_handle, node);
+	if (cache_node)
+		net_shaper_cache_commit(binding, 1, node_handle, node);
 	net_shaper_cache_commit(binding, leaves_count, leaves_handles, leaves);
 	return 0;
 
@@ -892,6 +896,76 @@ static int __net_shaper_group(struct net_shaper_binding *binding,
 	return ret;
 }
 
+static int __net_shaper_pre_del_node(struct net_shaper_binding *binding,
+				     const struct net_shaper_handle *handle,
+				     const struct net_shaper_info *shaper,
+				     struct netlink_ext_ack *extack)
+{
+	struct net_shaper_data *data = net_shaper_binding_data(binding);
+	struct net_shaper_handle *leaves_handles, node_handle;
+	struct net_shaper_info *cur, *leaves, node = {};
+	int ret, leaves_count = 0;
+	unsigned long index;
+	bool cache_node;
+
+	if (!shaper->leaves)
+		return 0;
+
+	if (WARN_ON_ONCE(!data))
+		return -EINVAL;
+
+	/* Fetch the new node information. */
+	node_handle = shaper->parent;
+	cur = net_shaper_cache_lookup(binding, &node_handle);
+	if (cur) {
+		node = *cur;
+	} else {
+		/* A scope NODE shaper can be nested only to the NETDEV scope
+		 * shaper without creating the latter, this check may fail only
+		 * if the cache is in inconsistent status.
+		 */
+		if (WARN_ON_ONCE(node_handle.scope != NET_SHAPER_SCOPE_NETDEV))
+			return -EINVAL;
+	}
+
+	leaves = kcalloc(shaper->leaves,
+			 sizeof(struct net_shaper_info) +
+			 sizeof(struct net_shaper_handle), GFP_KERNEL);
+	if (!leaves)
+		return -ENOMEM;
+
+	leaves_handles = (struct net_shaper_handle *)&leaves[shaper->leaves];
+
+	/* Build the leaves arrays. */
+	xa_for_each(&data->shapers, index, cur) {
+		if (cur->parent.scope != handle->scope ||
+		    cur->parent.id != handle->id)
+			continue;
+
+		if (WARN_ON_ONCE(leaves_count == shaper->leaves)) {
+			ret = -EINVAL;
+			goto free;
+		}
+
+		net_shaper_index_to_handle(index,
+					   &leaves_handles[leaves_count]);
+		leaves[leaves_count++] = *cur;
+	}
+
+	/* When re-linking to the netdev shaper, avoid the eventual, implicit,
+	 * creation of the new node, would be surprising since the user is
+	 * doing a delete operation.
+	 */
+	cache_node = node_handle.scope != NET_SHAPER_SCOPE_NETDEV;
+	ret = __net_shaper_group(binding, cache_node, leaves_count,
+				 leaves_handles, leaves, &node_handle, &node,
+				 extack);
+
+free:
+	kfree(leaves);
+	return ret;
+}
+
 static int net_shaper_delete(struct net_shaper_binding *binding,
 			     const struct net_shaper_handle *handle,
 			     struct netlink_ext_ack *extack)
@@ -914,9 +988,10 @@ static int net_shaper_delete(struct net_shaper_binding *binding,
 	}
 
 	if (handle->scope == NET_SHAPER_SCOPE_NODE) {
-		/* TODO: implement support for scope NODE delete. */
-		ret = -EINVAL;
-		goto unlock;
+		ret = __net_shaper_pre_del_node(binding, handle, shaper,
+						extack);
+		if (ret)
+			goto unlock;
 	}
 
 	ret = __net_shaper_delete(binding, handle, shaper, extack);
@@ -972,7 +1047,7 @@ static int net_shaper_group(struct net_shaper_binding *binding,
 			old_nodes[old_nodes_count++] = leaves[i].parent;
 
 	mutex_lock(&data->lock);
-	ret = __net_shaper_group(binding, leaves_count, leaves_handles,
+	ret = __net_shaper_group(binding, true, leaves_count, leaves_handles,
 				 leaves, node_handle, node, extack);
 
 	/* Check if we need to delete any NODE left alone by the new leaves
-- 
2.45.2


