Return-Path: <netdev+bounces-130415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC34D98A665
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6460B284357
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00BF193401;
	Mon, 30 Sep 2024 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKD1h8oa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D91218FC74
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704522; cv=none; b=RI/94ISte7H2F7XloLNIyvIap6yiik/C1gKnWwCHr6j2+0NIrh5rXYGo+5XYfamqMV1UtFaE2mZ5gND08Dec5tJgTPDt98eosVCyRZ8NF6MQoY3Xz2Ag6zQyyBfgRwb6uoToYMjhog2g8mDA7KgAn7jgexdQ+sm58J3ypKp+vVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704522; c=relaxed/simple;
	bh=vddy9NWLglMK6oL8m64aoQO+m/cu4fD/IF23fKp7gfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efE+up7GjMqZjecdxlB4LKibQ04t/o5drQoTK93em0gK2Y0aVqL0lsP0Zrh7BLiJ4aB0BjCih1ObB1rTE/MCq5sE0M+n5ctLjqw0BgAekr1O44a+ntfXGbaJp1k01RV0fwDwut3fHW+HrLX/1Y2edgP9gMZPWFYoPQbYtldgzmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKD1h8oa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727704520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qsi71Hm1UeUEZ/LQK4aUh57A5qUn9IgPxKBtHb6+cKI=;
	b=iKD1h8oaMlMWvBrJ4E3QgmMuqDKKnTE+EFC/FzCc7YhigIkOC2bz0J6vbloifX3ij7OiI5
	zVHAYQFcY/J4lMu/zH87ZkYpQWEsZFOoKjXEAADYja8myZ0M9Uu2WXWTny8oYPpHTAPfMP
	6PoGaMKeaPRfwGSEiltqZdrLWt64d0g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-eOvX5DPxObaPOMt8NCqCkA-1; Mon,
 30 Sep 2024 09:55:16 -0400
X-MC-Unique: eOvX5DPxObaPOMt8NCqCkA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75991193EF48;
	Mon, 30 Sep 2024 13:55:14 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.210])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E3671954B0F;
	Mon, 30 Sep 2024 13:55:09 +0000 (UTC)
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
Subject: [PATCH v8 net-next 07/15] net-shapers: implement shaper cleanup on queue deletion
Date: Mon, 30 Sep 2024 15:53:54 +0200
Message-ID: <094ea42117070aaacff25145b23feadef53dbfbc.1727704215.git.pabeni@redhat.com>
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

hook into netif_set_real_num_tx_queues() to cleanup any shaper
configured on top of the to-be-destroyed TX queues.

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
index 1e19797d8edd..35c159161b9f 100644
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


