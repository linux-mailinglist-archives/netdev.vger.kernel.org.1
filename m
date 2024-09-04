Return-Path: <netdev+bounces-125115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B56396BF56
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34291F22E36
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D026E1DAC46;
	Wed,  4 Sep 2024 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFUDVyEw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8361DA31E
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458247; cv=none; b=ht2nxqx9eSnj2HTHD3EVozNKTHzHJZjv0gC8nBhLrpu7DMR9MxRs3v+MxE9wegidgzRUEPSGCfjK8pQJSyeosG0SiHCkfC/jkjanUr/o+8qI3Y6xQye1r3t1PhGn61pC0ABYv+OZHbfMoWGfyz/XAc8Lxj6B6IJerX5VDivOycU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458247; c=relaxed/simple;
	bh=BfFFUz95pnSk0uQIqlt2Y4dDPCdL6uN7ijzUgxVtm8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/p94ZBV0tzBUg7mvPLFez1uEs9feS8wxKFSqELS3MeAryjI0ElOPsU17zUA+Bdp7i2PfcBiIJJmqS0OtM3nX3zSbMg63CWoU3mLEl9mdx1AXwnq0frdrZ4qV+GiUYrRxG9jTSXqnTyrBaZwdZPinJaQ014w/p5nUP8sZqRZB5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BFUDVyEw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725458245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XdTmUgJ2ULGvYG1rp4S3sHXg6KhU2KXc8KSoC3XxhBc=;
	b=BFUDVyEwX8DJW/12BXeDALYg0Vwx30wpoJq6RWEf0OKgnzk78JBqbRnxqNtzEM2V3tZSdK
	4qQ58sWZ7JFjPGK8Ig5iElHBwal8pBNhX0gzJ4biHd22P4NFAfeC8dRg4c+fODGhr+yFvs
	SXkZZJFLpZ6eo2+VG1fR23CQ/SGOch4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-eyzxUEdpMze0i-2U8BpzOQ-1; Wed,
 04 Sep 2024 09:57:21 -0400
X-MC-Unique: eyzxUEdpMze0i-2U8BpzOQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A89F19560B7;
	Wed,  4 Sep 2024 13:57:19 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.58])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B8A71956088;
	Wed,  4 Sep 2024 13:57:11 +0000 (UTC)
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
Subject: [PATCH v6 net-next 07/15] net-shapers: implement shaper cleanup on queue deletion
Date: Wed,  4 Sep 2024 15:53:39 +0200
Message-ID: <160421ccd6deedfd4d531f0239e80077f19db1d0.1725457317.git.pabeni@redhat.com>
In-Reply-To: <cover.1725457317.git.pabeni@redhat.com>
References: <cover.1725457317.git.pabeni@redhat.com>
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
 net/core/dev.c      |  2 ++
 net/core/dev.h      |  4 ++++
 net/shaper/shaper.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 8615f16e8456..33629a9d0661 100644
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
index 1255d532b36a..f6f5712d7b3c 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -1201,6 +1201,37 @@ void net_shaper_flush_netdev(struct net_device *dev)
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
+	net_shaper_lock(&binding);
+
+	/* Take action only when decreasing the tx queue number. */
+	for (i = txq; i < dev->real_num_tx_queues; ++i) {
+		struct net_shaper_handle handle;
+		struct net_shaper *shaper;
+
+		handle.scope = NET_SHAPER_SCOPE_QUEUE;
+		handle.id = i;
+		shaper = net_shaper_lookup(&binding, &handle);
+		if (!shaper)
+			continue;
+
+		__net_shaper_delete(&binding, shaper, NULL);
+	}
+	net_shaper_unlock(&binding);
+}
+
 static int __init shaper_init(void)
 {
 	return genl_register_family(&net_shaper_nl_family);
-- 
2.45.2


