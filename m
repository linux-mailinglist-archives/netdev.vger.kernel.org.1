Return-Path: <netdev+bounces-120243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4548A958AD2
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9392CB21F40
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E3D191F6A;
	Tue, 20 Aug 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5Ml+iZV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7E71917D6
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166808; cv=none; b=QUIwkMSjXrStg3srgLN7eCi90rwJ68ebzwO8yOnlBJ5NBINH+Ic15VgkiXxEs6Ie4G4zOKbbSNiEEqf2PZnBfQOaE3QZxeagu9Z+Muo1XXer6yCm2qU6lRK/sdJXnlL3rCPZ1fcrCv3Up7FB/PU58rAQaDOAIy6axiAAR1RUBnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166808; c=relaxed/simple;
	bh=KQcR+NPhT79yNGKeCwKmsIQM79rHbUlZQ5juTsmb3aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTZ+ukRVnFASWPK9KqDshHHTdbXifZa3jQihf9FHUOlX9kihVnzDC1a0OEsY7dNv7Ra1ALfh0IUX4TC3vakxrwQlMTI2a4R4kNJpCPfAsyDOBs5k8uZcMUZY/Nnh0u9cjUM4gao5WaKWuxAGV0M86klEhxOqS90FXhkU/DDTl5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5Ml+iZV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724166806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t8CwNKXrFBMCdgw9btM7eh6zGa4rvEsYZ8Th4AttWOY=;
	b=Q5Ml+iZVn9dEmWyaFM8TARBZcMjhYnzIwVXZj6KyUikB7oqmtZypCp+yExvgd0+MwBwHle
	v02f9VYkZy0e05JA41+DQ2nHwYhxxr8Sfr2Kf+SUrTap/U9JK8eKz8y/qGJ0MiMdblon16
	b+myW5mWmfyp2hzdRSmWZE8EzzEhSzY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-SCIDlFiTPVeh1q_kOXsLzA-1; Tue,
 20 Aug 2024 11:13:22 -0400
X-MC-Unique: SCIDlFiTPVeh1q_kOXsLzA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B48891955F08;
	Tue, 20 Aug 2024 15:13:19 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.213])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 053DF1955F42;
	Tue, 20 Aug 2024 15:13:15 +0000 (UTC)
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
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH v4 net-next 06/12] net-shapers: implement delete support for NODE scope shaper
Date: Tue, 20 Aug 2024 17:12:27 +0200
Message-ID: <4a7080e83b953ca2aeae5ababcb5cb873794e82a.1724165948.git.pabeni@redhat.com>
In-Reply-To: <cover.1724165948.git.pabeni@redhat.com>
References: <cover.1724165948.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Leverage the previously introduced group operation to implement
the removal of NODE scope shaper, re-linking its leaves under the
the parent node before actually deleting the specified NODE scope
shaper.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/shaper/shaper.c | 98 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 86 insertions(+), 12 deletions(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index c4228f98b416..e5282c5bebe1 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -675,7 +675,8 @@ static int __net_shaper_delete(struct net_device *dev,
 	return 0;
 }
 
-static int __net_shaper_group(struct net_device *dev, int leaves_count,
+static int __net_shaper_group(struct net_device *dev,
+			      bool cache_root, int leaves_count,
 			      const struct net_shaper_handle *leaves_handles,
 			      struct net_shaper_info *leaves,
 			      struct net_shaper_handle *root_handle,
@@ -710,12 +711,14 @@ static int __net_shaper_group(struct net_device *dev, int leaves_count,
 		}
 	}
 
-	/* For newly created node scope shaper, the following will update
-	 * the handle, due to id allocation.
-	 */
-	ret = net_shaper_cache_pre_insert(dev, root_handle, extack);
-	if (ret)
-		return ret;
+	if (cache_root) {
+		/* For newly created node scope shaper, the following will
+		 * update the handle, due to id allocation.
+		 */
+		ret = net_shaper_cache_pre_insert(dev, root_handle, extack);
+		if (ret)
+			return ret;
+	}
 
 	for (i = 0; i < leaves_count; ++i) {
 		leaf_handle = leaves_handles[i];
@@ -750,7 +753,8 @@ static int __net_shaper_group(struct net_device *dev, int leaves_count,
 
 	if (parent)
 		parent->leaves++;
-	net_shaper_cache_commit(dev, 1, root_handle, root);
+	if (cache_root)
+		net_shaper_cache_commit(dev, 1, root_handle, root);
 	net_shaper_cache_commit(dev, leaves_count, leaves_handles, leaves);
 	return 0;
 
@@ -758,6 +762,76 @@ static int __net_shaper_group(struct net_device *dev, int leaves_count,
 	net_shaper_cache_rollback(dev);
 	return ret;
 }
+
+static int __net_shaper_pre_del_node(struct net_device *dev,
+				     const struct net_shaper_handle *handle,
+				     const struct net_shaper_info *shaper,
+				     struct netlink_ext_ack *extack)
+{
+	struct net_shaper_handle *leaves_handles, root_handle;
+	struct xarray *xa = net_shaper_cache_container(dev);
+	struct net_shaper_info *cur, *leaves, root = {};
+	int ret, leaves_count = 0;
+	unsigned long index;
+	bool cache_root;
+
+	if (!shaper->leaves)
+		return 0;
+
+	if (WARN_ON_ONCE(!xa))
+		return -EINVAL;
+
+	/* Fetch the new root information. */
+	root_handle = shaper->parent;
+	cur = net_shaper_cache_lookup(dev, &root_handle);
+	if (cur) {
+		root = *cur;
+	} else {
+		/* A scope NODE shaper can be nested only to the NETDEV scope
+		 * shaper without creating the latter, this check may fail only
+		 * if the cache is in inconsistent status.
+		 */
+		if (WARN_ON_ONCE(root_handle.scope != NET_SHAPER_SCOPE_NETDEV))
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
+	xa_for_each(xa, index, cur) {
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
+	 * creation of the new root, would be surprising since the user is
+	 * doing a delete operation.
+	 */
+	cache_root = root_handle.scope != NET_SHAPER_SCOPE_NETDEV;
+	ret = __net_shaper_group(dev, cache_root, leaves_count, leaves_handles,
+				 leaves, &root_handle, &root, extack);
+
+free:
+	kfree(leaves);
+	return ret;
+}
+
 static int net_shaper_delete(struct net_device *dev,
 			     const struct net_shaper_handle *handle,
 			     struct netlink_ext_ack *extack)
@@ -780,9 +854,9 @@ static int net_shaper_delete(struct net_device *dev,
 	}
 
 	if (handle->scope == NET_SHAPER_SCOPE_NODE) {
-		/* TODO: implement support for scope NODE delete. */
-		ret = -EINVAL;
-		goto unlock;
+		ret = __net_shaper_pre_del_node(dev, handle, shaper, extack);
+		if (ret)
+			goto unlock;
 	}
 
 	ret = __net_shaper_delete(dev, handle, shaper, extack);
@@ -843,7 +917,7 @@ static int net_shaper_group(struct net_device *dev, int leaves_count,
 			old_roots[old_roots_count++] = leaves[i].parent;
 
 	mutex_lock(lock);
-	ret = __net_shaper_group(dev, leaves_count, leaves_handles,
+	ret = __net_shaper_group(dev, true, leaves_count, leaves_handles,
 				 leaves, root_handle, root, extack);
 
 	/* Check if we need to delete any NODE left alone by the new leaves
-- 
2.45.2


