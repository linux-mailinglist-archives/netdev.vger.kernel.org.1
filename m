Return-Path: <netdev+bounces-267820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPMnH/qotWmw3AAAu9opvQ
	(envelope-from <netdev+bounces-267820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 19:29:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7AE28E72B
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 19:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67D633013703
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88D7336885;
	Sat, 14 Mar 2026 18:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAATbJb3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9EE3B28D
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773512930; cv=none; b=lEDwnFTKNF51n3pSlAUmuz2iIhn1GaiprP9HkZUifor7ofKMk+Ns72PiCXRGlBex25hAy7ceEa7vRFRSc7EOhzv4OYfWZH6SHIkWyhSPE96XMWEYQ9tAJjBvLLG5kszscy1kjzOaefwjMYllVgmvpxJwWli/uV+ENo52NaIy780=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773512930; c=relaxed/simple;
	bh=bPSZT7dVTriF4TZgmZTUAw22Sgou+Fmk1o1FCPOSVME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxWjtGj/eldov03e6tGc5BZkb/x0kzYT+OS96DozEbkAeMF1bpiqi24kpcSwHe5ITqUmw6qwUc9cC0LsluQllYV/Z5VUmi/pfGGujvVnENMUC9KnAbiBdyck+ShuKCy5wYnPiIxBISH56l4Ml7AV/PXuaT3jXZVmifAjngU+z1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAATbJb3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad21f437eeso25728005ad.0
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 11:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773512929; x=1774117729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KgmmudIxXUanwK3aFbv0ip54pwkZrkMg6RJuyR+qxA=;
        b=bAATbJb3Ii4e802Gy4kD7idMwljBlOjFyMjcXs25aop8D1oVDo0uAQ0gjeslGZmfc3
         B9xUIjHrX2sUgyCP+p9uN5R0nhdV4TqszMkZjnSwH5xzPKpxe5SJly2/X/9eSJWS0eU7
         PrQMlDvYzY/LkI7r7b7qL+m5zXT6dveayYBFNdqLNKJ9+mR5B6w6ZSW1xI0ERvv+6xkM
         pbjBjNWAY7vxO0Vy4tZZnk+49RMhHEGPEKFcAVFaYtrhJ5gMIxdHMeJwq9DcjcqE0YTm
         etrImy77Hb6/BASxW/+gNC0vNEI4oxugx6NTmv3gZgIjT3hy+p/CJzlO1PdYxmsla4DD
         HzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773512929; x=1774117729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4KgmmudIxXUanwK3aFbv0ip54pwkZrkMg6RJuyR+qxA=;
        b=OI7ks9fOPvBhKGENRSxk/YQQvv+UyDl24jQ5K/lV1cRpI/z77CfBMjDQukdmwNjIL9
         MPA1/+xsGjLGdJvEGbL7788DwTlUm8MVg4Y1K9ZeZjV9cRhwFD4iA22k7h9RtioZUZhh
         HUStC8OZLStVET0bp52NFhbXzXxamG7+/y7h48KptaFa7nHZBUn4B21wHsiF+USDbnfy
         LBCclEX8mgCASmKMhnTucqNNE2VZKzNBapkXCFL1n4Rs/pRumi9/+lr8sY24kE88yaxI
         8+rHLVGUDypn8R/HlnNK9JRVYfZUjpxTkj5CqneWYpByaHLeVDEZ7LSwKPHKo+ulyNB/
         ppPA==
X-Forwarded-Encrypted: i=1; AJvYcCVG8On8CPcZATnvPyBK7ux7OjZl6UJ40SA7vrEXe3RsR7qJhPF9noxZobKwuhbN2OBne9wldlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuEXIYrfrxOZ/D7wHkcmJybircOi/iqor1M5GSd9Ikuf9dH39V
	YATZvGWasSED2/SG/6ZluKvhTfWuz5+u5Yf3UztGQS3R6JrHWusmgcV5
X-Gm-Gg: ATEYQzzFrJXLfLBQil5RSWBmg5swz5c5VF5+Ypy3cTw3bnBWs9qRQy6lll9+EvhK3Tj
	7tyY8OR1OMFTZDzeWOXZantqspELnuD+Gf2sOQCMHfWGEjkApOWxHlpQwr6ECloIOpMSs2okMXu
	BIWo5852tj07PzHj+i22lKyI1ZNXU/2TwY/lcHYagkTvqqAdFqy7ohivGptwO+2VFgiV/ykFkLl
	soW/u2OFCVqoXozBpYXZMGFCzxl83xScUKmRhOwuZg8N4he+ktT6a2UQbFrhQ51B1QRRdj9Z41t
	cxjTxUmq+mITi3UttZ9LXHilkpQzxr8K7WVmjYZ4w78DiKe2H7smA9XUfmGgzZWyycItfHb5VtG
	2cKemt/hQBvVfRs3SVcV001B5AowuWvU7UpolbCHGMeyDhaf3Bvqt1u9soup4SfKRCgeEnGrFg1
	H4Rmodl2EvZaAzE6FVpTE7zNYn7OAwwJYi3fP7ruqUwf71M+WI7icF6YU58XP6srwDQZ3NzVrAd
	Crklg==
X-Received: by 2002:a17:902:ea09:b0:2b0:4cbe:fbea with SMTP id d9443c01a7336-2b04cbf0114mr7880195ad.25.1773512928560;
        Sat, 14 Mar 2026 11:28:48 -0700 (PDT)
Received: from localhost.localdomain ([122.168.66.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece62c581sm77673525ad.33.2026.03.14.11.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 11:28:47 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: stfomichev@gmail.com,
	horms@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	kuba@kernel.org,
	davem@davemloft.net,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	jasowang@redhat.com,
	mst@redhat.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	ronak.doshi@broadcom.com,
	pcnet32@frontier.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v9 1/7] net: core: Add state tracking for async netdev ops
Date: Sat, 14 Mar 2026 23:58:03 +0530
Message-ID: <20260314182809.362808-2-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260314182809.362808-1-viswanathiyyappan@gmail.com>
References: <20260314182809.362808-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[broadcom.com,vger.kernel.org,lists.linux.dev,lists.osuosl.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-267820-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,google.com,redhat.com,lunn.ch,davemloft.net,linux.alibaba.com,intel.com,broadcom.com,frontier.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viswanathiyyappan@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E7AE28E72B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Async netdev ops are tricky because of the following problems:

1) Freeing the context associated with async netdev ops might require
   waiting for completion of the associated work which might require the
   rtnl lock or the instance lock. However this will deadlock in
   __dev_close_many as the cleanup is done with those locks already held.

2) We need a way to enable/disable async netdev ops depending on the PM
   state to allow/prevent hardware access as appropriate.

We solve these problems by introducing a state variable to track
the current state of netdev. This can take the following values:
- ACTIVE (up and normal operation)
- DOWN (down)
- INACTIVE (in suspend/shutdown)

To solve 1, we set the state to down in __dev_close_many. In the
associated op handler, we check for the current state and return if
the netdev is down.

To solve 2, the commit introduces the following functions:
- netif_enable_async_ops  -> sets state to ACTIVE
- netif_disable_async_ops -> sets state to INACTIVE and cancels any
			     pending work as required.

The op implementation can use the state information to do the required
processing.

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 include/linux/netdevice.h | 29 ++++++++++++++
 net/core/dev.c            | 84 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ae269a2e7f4d..6d426dc66af9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1062,6 +1062,16 @@ struct netdev_net_notifier {
 	struct notifier_block *nb;
 };
 
+enum netif_async_state {
+	NETIF_ASYNC_ACTIVE,
+	NETIF_ASYNC_DOWN,
+	NETIF_ASYNC_INACTIVE
+};
+
+struct netif_async_ctx {
+	enum netif_async_state state;
+};
+
 /*
  * This structure defines the management hooks for network devices.
  * The following hooks can be defined; unless noted otherwise, they are
@@ -2027,6 +2037,8 @@ enum netdev_reg_state {
  *	@sfp_bus:	attached &struct sfp_bus structure.
  *
  *	@qdisc_tx_busylock: lockdep class annotating Qdisc->busylock spinlock
+ *	@async_ctx	  : Context required for async ops
+ *	@needs_async_ctx  : Does dev need async op context?
  *
  *	@proto_down:	protocol port state information can be sent to the
  *			switch driver and used to set the phys state of the
@@ -2454,6 +2466,8 @@ struct net_device {
 	struct phy_device	*phydev;
 	struct sfp_bus		*sfp_bus;
 	struct lock_class_key	*qdisc_tx_busylock;
+	struct netif_async_ctx  *async_ctx;
+	bool			needs_async_ctx;
 	bool			proto_down;
 	bool			irq_affinity_auto;
 	bool			rx_cpu_rmap_auto;
@@ -3376,6 +3390,21 @@ int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
 u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
 		     struct net_device *sb_dev);
 
+void netif_disable_async_ops(struct net_device *dev);
+void netif_enable_async_ops(struct net_device *dev);
+
+static inline void netif_set_async_state(struct net_device *dev,
+					 enum netif_async_state state)
+{
+	dev->async_ctx->state = state;
+}
+
+static inline enum netif_async_state
+netif_get_async_state(struct net_device *dev)
+{
+	return dev->async_ctx->state;
+}
+
 int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev);
 int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 200d44883fc1..b1797bd28a6b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1664,6 +1664,33 @@ static int napi_kthread_create(struct napi_struct *n)
 	return err;
 }
 
+static int __netif_alloc_async_ctx(struct net_device *dev)
+{
+	dev->async_ctx = kzalloc_obj(*dev->async_ctx);
+	if (!dev->async_ctx)
+		return -ENOMEM;
+
+	netif_set_async_state(dev, NETIF_ASYNC_ACTIVE);
+	return 0;
+}
+
+static int netif_alloc_async_ctx(struct net_device *dev)
+{
+	int ret;
+
+	ret = __netif_alloc_async_ctx(dev);
+	return ret;
+}
+
+static void netif_free_async_ctx(struct net_device *dev)
+{
+	if (!dev->async_ctx)
+		return;
+
+	kfree(dev->async_ctx);
+	dev->async_ctx = NULL;
+}
+
 static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
@@ -1698,14 +1725,18 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 	if (ops->ndo_validate_addr)
 		ret = ops->ndo_validate_addr(dev);
 
+	if (!ret && dev->needs_async_ctx)
+		ret = netif_alloc_async_ctx(dev);
+
 	if (!ret && ops->ndo_open)
 		ret = ops->ndo_open(dev);
 
 	netpoll_poll_enable(dev);
 
-	if (ret)
+	if (ret) {
 		clear_bit(__LINK_STATE_START, &dev->state);
-	else {
+		netif_free_async_ctx(dev);
+	} else {
 		netif_set_up(dev, true);
 		dev_set_rx_mode(dev);
 		dev_activate(dev);
@@ -1772,6 +1803,11 @@ static void __dev_close_many(struct list_head *head)
 
 		netdev_ops_assert_locked(dev);
 
+		if (dev->needs_async_ctx) {
+			netif_set_async_state(dev, NETIF_ASYNC_DOWN);
+			netif_free_async_ctx(dev);
+		}
+
 		if (ops->ndo_stop)
 			ops->ndo_stop(dev);
 
@@ -1821,6 +1857,50 @@ void netif_close(struct net_device *dev)
 }
 EXPORT_SYMBOL(netif_close);
 
+/* netif_disable_async_ops - disable execution of async NDOs.
+ *
+ * To be used in cases of the device shutting down, suspending or
+ * failing to resume.
+ *
+ * Should be called in the shutdown callback and in the PM suspend
+ * callbacks: @suspend(), @freeze(), @poweroff() and in the error
+ * path of PM resume callbacks.
+ */
+void netif_disable_async_ops(struct net_device *dev)
+{
+	netdev_lock_ops_compat(dev);
+
+	if (!dev->needs_async_ctx || !netif_running(dev)) {
+		netdev_unlock_ops_compat(dev);
+		return;
+	}
+
+	netif_set_async_state(dev, NETIF_ASYNC_INACTIVE);
+	netdev_unlock_ops_compat(dev);
+}
+EXPORT_SYMBOL(netif_disable_async_ops);
+
+/* netif_enable_async_ops - enable execution of async NDOs.
+ *
+ * To be used when the device attempts to resume or fails to suspend.
+ *
+ * Should be called in the PM resume callbacks: @resume(), @thaw(),
+ * @restore() and in the error path of PM suspend callbacks.
+ */
+void netif_enable_async_ops(struct net_device *dev)
+{
+	netdev_lock_ops_compat(dev);
+
+	if (!dev->needs_async_ctx || !netif_running(dev)) {
+		netdev_unlock_ops_compat(dev);
+		return;
+	}
+
+	netif_set_async_state(dev, NETIF_ASYNC_ACTIVE);
+	netdev_unlock_ops_compat(dev);
+}
+EXPORT_SYMBOL(netif_enable_async_ops);
+
 void netif_disable_lro(struct net_device *dev)
 {
 	struct net_device *lower_dev;
-- 
2.47.3


