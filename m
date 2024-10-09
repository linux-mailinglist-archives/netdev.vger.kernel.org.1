Return-Path: <netdev+bounces-133497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 784D8996212
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD801F233A6
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7A7188587;
	Wed,  9 Oct 2024 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4KEZT9J"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401D2184527
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461522; cv=none; b=Vfl5z2zL1mJb0+JVJOY0RxinsW1C/ReLn2wHKvKNOlQbrNY9Glzn4l3e2fiOqHY9A8UrxgmpAIvwyyFQwhMastCx9Ah18qcbcRODUV5KHGAjGB+vW6zCyidCuFI3Gyb+ydTTlg0MPot3djgAELdxIl0e0iaHjfvQm88QXoh+GFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461522; c=relaxed/simple;
	bh=42Ux5HDeGe5cO+3ymlmq7kv+mHEdwSC8QcDn8fRXDZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brM6bGMVqVUAaXWu6KsNCoeOOADzfzKOqUZwKFLrT2rF7aZClhq9Xai9YVgcRh8K3SPSHx9mKSEZtYM15VP3p3zb7hkNgJj3XEy7SVOpsREYpDmDiZ3YInWPW8SZJeKDYyaXYD+gzBSosHcjlRpvlpolDNQWClvWYkKsGVK4u4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A4KEZT9J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728461519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eui556oY87SbUJSjkwki1SLeRle62IC4AC++NE4LUXs=;
	b=A4KEZT9Js8Bv5Oynt8HebkK6HqmOvhJprPGuzTsP4VOkErceFZx2Z6YbDxTT4PEBnAHkHA
	pO9+0vJVq4l/l8NrV2lmCqdSEWAG4TxAX7Rvv80auPnYqd4T6CdWE7rVsjuNuIsrj1gApn
	af7kp756HLt/12DhN8jB1vb8PowOcsk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-EfZXg6wnMXuELczmjNYNOA-1; Wed,
 09 Oct 2024 04:11:54 -0400
X-MC-Unique: EfZXg6wnMXuELczmjNYNOA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D195D1934D76;
	Wed,  9 Oct 2024 08:10:56 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.249])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 917E219560A2;
	Wed,  9 Oct 2024 08:10:51 +0000 (UTC)
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
Subject: [PATCH v9 net-next 07/15] net-shapers: implement shaper cleanup on queue deletion
Date: Wed,  9 Oct 2024 10:09:53 +0200
Message-ID: <6da4ee03cae2b2a757d7b59e88baf09cc94c5ef1.1728460186.git.pabeni@redhat.com>
In-Reply-To: <cover.1728460186.git.pabeni@redhat.com>
References: <cover.1728460186.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

hook into netif_set_real_num_tx_queues() to cleanup any shaper
configured on top of the to-be-destroyed TX queues.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v6 -> v7:
 - don't touch the H/W for the queue shaper, the driver
   is supposed to reset clean it up.
 - it's up to the net shaper enabled caller to acquire the
   dev lock
---
 net/core/dev.c      |  2 ++
 net/core/dev.h      |  4 ++++
 net/shaper/shaper.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 6e727c49a6f7..b590eefce3b4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2949,6 +2949,8 @@ int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
 		if (dev->num_tc)
 			netif_setup_tc(dev, txq);
 
+		net_shaper_set_real_num_tx_queues(dev, txq);
+
 		dev_qdisc_change_real_num_tx(dev, txq);
 
 		dev->real_num_tx_queues = txq;
diff --git a/net/core/dev.h b/net/core/dev.h
index 13c558874af3..d3ea92949ff3 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -37,8 +37,12 @@ void dev_addr_check(struct net_device *dev);
 
 #if IS_ENABLED(CONFIG_NET_SHAPER)
 void net_shaper_flush_netdev(struct net_device *dev);
+void net_shaper_set_real_num_tx_queues(struct net_device *dev,
+				       unsigned int txq);
 #else
 static inline void net_shaper_flush_netdev(struct net_device *dev) {}
+static inline void net_shaper_set_real_num_tx_queues(struct net_device *dev,
+						     unsigned int txq) {}
 #endif
 
 /* sysctls not referred to from outside net/core/ */
diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index ddd1999b3f27..85ad172833fc 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -1157,6 +1157,54 @@ void net_shaper_flush_netdev(struct net_device *dev)
 	net_shaper_flush(&binding);
 }
 
+void net_shaper_set_real_num_tx_queues(struct net_device *dev,
+				       unsigned int txq)
+{
+	struct net_shaper_hierarchy *hierarchy;
+	struct net_shaper_binding binding;
+	int i;
+
+	binding.type = NET_SHAPER_BINDING_TYPE_NETDEV;
+	binding.netdev = dev;
+	hierarchy = net_shaper_hierarchy(&binding);
+	if (!hierarchy)
+		return;
+
+	/* Only drivers implementing shapers support ensure
+	 * the lock is acquired in advance.
+	 */
+	lockdep_assert_held(&dev->lock);
+
+	/* Take action only when decreasing the tx queue number. */
+	for (i = txq; i < dev->real_num_tx_queues; ++i) {
+		struct net_shaper_handle handle, parent_handle;
+		struct net_shaper *shaper;
+		u32 index;
+
+		handle.scope = NET_SHAPER_SCOPE_QUEUE;
+		handle.id = i;
+		shaper = net_shaper_lookup(&binding, &handle);
+		if (!shaper)
+			continue;
+
+		/* Don't touch the H/W for the queue shaper, the drivers already
+		 * deleted the queue and related resources.
+		 */
+		parent_handle = shaper->parent;
+		index = net_shaper_handle_to_index(&handle);
+		xa_erase(&hierarchy->shapers, index);
+		kfree_rcu(shaper, rcu);
+
+		/* The recursion on parent does the full job. */
+		if (parent_handle.scope != NET_SHAPER_SCOPE_NODE)
+			continue;
+
+		shaper = net_shaper_lookup(&binding, &parent_handle);
+		if (shaper && !--shaper->leaves)
+			__net_shaper_delete(&binding, shaper, NULL);
+	}
+}
+
 static int __init shaper_init(void)
 {
 	return genl_register_family(&net_shaper_nl_family);
-- 
2.45.2


