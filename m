Return-Path: <netdev+bounces-126722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D912697250B
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 00:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84EF01F24AA7
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 22:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DAB18CBEC;
	Mon,  9 Sep 2024 22:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fi1E4z0P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D80D18CBFF
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 22:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725919894; cv=none; b=iP9fexpoObIouBIUlcs4jkFv5vh9QVGtHR2xpwkc9RCWfQ8QXZcOto94USBxWADflgy277PcQ3u2ct7dE0lRrjQ3wrqMs+S8t1bHHPDqVZq0c3Hfxg2xt/JXhlw6yHVcVFe8Ea74c8rD43W8ahudsq+JAS/q6VNfSt9aDrQL9GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725919894; c=relaxed/simple;
	bh=NpRZOl3bL7JRxVN51CBLB92CQpPmaccyaHSjMAgZFSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LB6IJjoOwrhhLMnyrkORjSbqKzSU6Z9ahJW2hIdl/6vYJ7VQu4UO6l/BtJy7teP7oyQpxOpoK8Sks7/IF1zo6XNF5aFzxOurrdG4oxpv4ecfGuYNHea6sZ523G+9i9uDIqP7xU2ZDoPxiwnI5LFHhZC2LU8RpVyAZ+qDYjp5eTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fi1E4z0P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725919891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=haaj6QWfZ3f4f/0CGzntQEj06240hoo6CdwmjyyTOcA=;
	b=fi1E4z0PwR2B+tZ8Qr86S42lV+AdrYD+ouL7oV7zLG+GKNOoXG3+f2uRTmYb7PLNQS8trg
	Dt3H6XO9SfgdljP+rx9agsV95znBE36ajAcxvh9EnQ64EaER1TNV+J0Y7y2JSYGjTOyfKU
	hCwFGIuEBgC2paecrdZN593DfCIa8Ds=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-BTWbuX9UNUWg65tVwves3w-1; Mon,
 09 Sep 2024 18:11:28 -0400
X-MC-Unique: BTWbuX9UNUWg65tVwves3w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 321B91955DC3;
	Mon,  9 Sep 2024 22:11:26 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.56])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 53B671956086;
	Mon,  9 Sep 2024 22:11:21 +0000 (UTC)
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
Subject: [PATCH v7 net-next 07/15] net-shapers: implement shaper cleanup on queue deletion
Date: Tue, 10 Sep 2024 00:10:01 +0200
Message-ID: <634b63e19c1466fd1c3e7db4276e14b6b223cc86.1725919039.git.pabeni@redhat.com>
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

hook into netif_set_real_num_tx_queues() to cleanup any shaper
configured on top of the to-be-destroyed TX queues.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v6 -> v7:
 - don't touch the H/W for the queue shaper, the driver
   is supposed to clean it up.
 - it's up to the net shaper enabled caller to acquire the
   dev lock
---
 net/core/dev.c      |  2 ++
 net/core/dev.h      |  4 ++++
 net/shaper/shaper.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 0e7e13db94db..23c0d0acbc40 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2948,6 +2948,8 @@ int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
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
index b502918b0a76..2ddd52ec28e3 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -1159,6 +1159,54 @@ void net_shaper_flush_netdev(struct net_device *dev)
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


