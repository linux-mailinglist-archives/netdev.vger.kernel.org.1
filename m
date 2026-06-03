Return-Path: <netdev+bounces-294955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2u1TAVSsIGo96gAAu9opvQ
	(envelope-from <netdev+bounces-294955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:36:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D3163B9E2
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:36:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gcARqGIo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294955-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294955-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E8DF3017099
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 22:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0838C4DB55E;
	Wed,  3 Jun 2026 22:35:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB464A138C
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 22:35:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780526142; cv=none; b=hDbo+le48826iBTbHAEEEzyvlwRBfbIkfUb8DUYCzGsM3CL9wq5LtPGb5+V0Rzx3VngEF0dvoVHA6Dfyq0ByvJvuNxhW7tIEkPcJD0jfVoErqcnk/FlyTOR81wZl/yPalZ9htcztTV5OsX8wI2E7AW2+to2Po5VYubzsSoBgyRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780526142; c=relaxed/simple;
	bh=UXLkCeo7+dqN98TDiWaCuHg5NclosRIZfsGFXwmbf6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lok26SmVs1z5LkTeD8StrcAdfkJ7DT/EpzUoTruAgjIvU2riXXko0Md6Ep92XMGW5QbyVoKu282rCNrwSqqMTc1L81hxteJ9iEdxv8Jafgnx5qh1u651+6PBqFxyUUSucMJVAKTC5zSVRbo7qtluPAxLRy8/OcPy/GnRmhEUd7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcARqGIo; arc=none smtp.client-ip=209.85.215.193
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c8585c51f1fso576353a12.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 15:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780526138; x=1781130938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5a8ktoEXPXYtkn7Qm9OpmYd016J2xfcDkxnL9O/Z0o=;
        b=gcARqGIoXX7/3XsDb+lAxDqAqKTK1uz8ST+4STLh38uujaH0l2FRkzKt6Jv2M2Y5Se
         nUU02CMAydXTb9CkU0NXJglCjiggm4ji6keGS9okazrqZ9V3AsJn916iUhmqYXKG1RyT
         tbiLp10kovo3XBuW/jhyoYM5MzmLKsWU8xGEcl66IoQOzMTU9UxpE2LJHQemJ3Ddy13Z
         JJhYLhGqOdzY7TbyFQjHFkBTzEzZIuVz49qRc4zhLVeuFUCyVVTtlofSEIaaODKi2tG7
         ZMfoX8Dh53FVoC1sBs0LcoXWW7/f2x4polCM3ut6531VyY+icVyqiUBJfZ1Z8X0XRw08
         wM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780526138; x=1781130938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x5a8ktoEXPXYtkn7Qm9OpmYd016J2xfcDkxnL9O/Z0o=;
        b=tXEDYtcr562gIwx87A2SD/tlKm8i7jnTj74qAocunSlPCONFXUmd7CAp2T0z4ch6D0
         sd2XyMht6QR+9B7c4FWAsEz3XNELdEdtUmJRQmh8VyhmOsZcq8IJPSYhVgpHnx18qjRn
         +TfbtDzuwLeFD6fOpRgKrY5o5TdusIGBVz4gBeiLAscxQsqWlBUHYjGGh2Dp/7sMHLSB
         Du+OJZC8OSz7yS8Hno7TRnJcCHWCs0FrLbWCYXSRo/fnPS0cTKJzfXkOEMWfdmiW4u1I
         sn+lNC3QtFe+BLKErTvhR+cAIQJuZ4ScZ5V4eFnTOaKgLAqchhx1G105NvcKvAp1W1bK
         pbgQ==
X-Gm-Message-State: AOJu0YwxGrtyy8+KSYrBb04VIr8XZUj6GSTstCaABQ5u0wwjTmQVFXS9
	VEX3JhyCLiBYSNVC2zJbPVKGLbB9CbF27T88T3ftLJoBUVd4WyhzhdHn6Xk9R66e
X-Gm-Gg: Acq92OFfdVNXoHybEkPf6vpecjOeDSa576tr9vQpA0TRkSIK/6RfIor2qU07IBWKWE8
	5GNGHIbQkNNxZ03Sf462L8whtcwrvCsxQQMvvUpAAARo9lA1bn2UZeGXF1Ke2iIDIPDJsC+p/Xk
	+sU5ngiRbencgjl9aNV9tXOh1GOnBrePosenO9pW9YWH1QTurvh4pAHJ2xbggXLBwTE0rRJrE+O
	72TlK9suv0eUOL7BpIsqZowNisziuWMo4b8h53SDz11HPshPaHNkObTl6pHrI5Lz9NJ9/ccP2kP
	YdaXto9BnGo71YinRJ0cKWwhYIsY5l56jDFaSi4RS45N8IiFNYn/Q8w9XWKqBRSk7M/TCWEutJv
	DOVQvHcAin82VdRXXyOkIdn0JP9lb22K5Aw2hc2THai4N8t3JXCIyQn5GzB6uNpuqM+toORatt6
	pdDkwcNIzXD1USEqaW01fxXzR7lr8Ebe1qg6J+5Q==
X-Received: by 2002:a17:903:903:b0:2bf:2d0:8877 with SMTP id d9443c01a7336-2c197ebc727mr10143265ad.23.1780526138319;
        Wed, 03 Jun 2026 15:35:38 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f875casm37326865ad.22.2026.06.03.15.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 15:35:37 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v2 2/3] net: add retry mechanism to ndo_set_rx_mode_async
Date: Wed,  3 Jun 2026 15:35:34 -0700
Message-ID: <20260603223535.2504695-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260603223535.2504695-1-sdf@fomichev.me>
References: <20260603223535.2504695-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-294955-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99D3163B9E2

When ndo_set_rx_mode_async returns an error, schedule a retry with
exponential backoff (1s, 2s, 4s, 8s -- 15s total). Give up after the
4th retry and log an error via netdev_err().

This moves retry logic from individual drivers into the core stack.

Timer callback does not hold a ref on dev. Safe because the timer can
only be armed when dev is IFF_UP, and __dev_close_many runs
timer_delete_sync before clearing IFF_UP. Unregister always closes
IFF_UP devices first, so by the time dev can be freed the timer is
dead and cannot be re-armed.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/linux/netdevice.h |  5 ++++
 net/core/dev.c            |  4 +--
 net/core/dev.h            |  2 ++
 net/core/dev_addr_lists.c | 53 +++++++++++++++++++++++++++++++++++++--
 4 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 4a1eae18d7e3..bc687dc5ecd8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1933,6 +1933,8 @@ enum netdev_reg_state {
  *	@rx_mode_node:		List entry for rx_mode work processing
  *	@rx_mode_tracker:	Refcount tracker for rx_mode work
  *	@rx_mode_addr_cache:	Recycled snapshot entries for rx_mode work
+ *	@rx_mode_retry_timer:	Timer that re-queues rx_mode work after failure
+ *	@rx_mode_retry_count:	Number of consecutive retries already scheduled
  *	@uc:			unicast mac addresses
  *	@mc:			multicast mac addresses
  *	@dev_addrs:		list of device hw addresses
@@ -2326,6 +2328,8 @@ struct net_device {
 	struct list_head	rx_mode_node;
 	netdevice_tracker	rx_mode_tracker;
 	struct netdev_hw_addr_list	rx_mode_addr_cache;
+	struct timer_list	rx_mode_retry_timer;
+	unsigned int		rx_mode_retry_count;
 #ifdef CONFIG_LOCKDEP
 	unsigned char		nested_level;
 #endif
@@ -5149,6 +5153,7 @@ static inline void __dev_mc_unsync(struct net_device *dev,
 
 /* Functions used for secondary unicast and multicast support */
 void dev_set_rx_mode(struct net_device *dev);
+void netif_rx_mode_schedule_retry(struct net_device *dev);
 int netif_set_promiscuity(struct net_device *dev, int inc);
 int dev_set_promiscuity(struct net_device *dev, int inc);
 int netif_set_allmulti(struct net_device *dev, int inc, bool notify);
diff --git a/net/core/dev.c b/net/core/dev.c
index 804e8ad25010..478645250009 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1775,6 +1775,7 @@ static void __dev_close_many(struct list_head *head)
 		if (ops->ndo_stop)
 			ops->ndo_stop(dev);
 
+		netif_rx_mode_cancel_retry(dev);
 		netif_set_up(dev, false);
 		netpoll_poll_enable(dev);
 	}
@@ -12094,8 +12095,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 #endif
 
 	mutex_init(&dev->lock);
-	INIT_LIST_HEAD(&dev->rx_mode_node);
-	__hw_addr_init(&dev->rx_mode_addr_cache);
+	netif_rx_mode_init(dev);
 
 	dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
 	setup(dev);
diff --git a/net/core/dev.h b/net/core/dev.h
index 0cf24b8f5008..4352f39c8dfe 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -166,8 +166,10 @@ int dev_change_carrier(struct net_device *dev, bool new_carrier);
 
 void __dev_set_rx_mode(struct net_device *dev);
 int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify);
+void netif_rx_mode_init(struct net_device *dev);
 bool netif_rx_mode_clean(struct net_device *dev);
 void netif_rx_mode_sync(struct net_device *dev);
+void netif_rx_mode_cancel_retry(struct net_device *dev);
 
 void __dev_notify_flags(struct net_device *dev, unsigned int old_flags,
 			unsigned int gchanges, u32 portid,
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index d73fcb0c6785..4872ea56d07c 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -1252,6 +1252,35 @@ static int netif_uc_promisc_update(struct net_device *dev)
 	return 0;
 }
 
+/* Total retry budget (4): 1+2+4+8 = 15 seconds */
+#define NETIF_RX_MODE_RETRY_MAX	4
+
+void netif_rx_mode_schedule_retry(struct net_device *dev)
+{
+	unsigned long delay;
+
+	netdev_ops_assert_locked(dev);
+
+	if (dev->rx_mode_retry_count >= NETIF_RX_MODE_RETRY_MAX) {
+		netdev_err(dev, "rx_mode retry limit reached, giving up\n");
+		return;
+	}
+
+	delay = HZ << dev->rx_mode_retry_count;
+	if (mod_timer(&dev->rx_mode_retry_timer, jiffies + delay))
+		return;
+	if (!dev->rx_mode_retry_count)
+		netdev_info(dev, "rx_mode install failed, retrying with backoff\n");
+	dev->rx_mode_retry_count++;
+}
+EXPORT_SYMBOL_GPL(netif_rx_mode_schedule_retry);
+
+void netif_rx_mode_cancel_retry(struct net_device *dev)
+{
+	timer_delete_sync(&dev->rx_mode_retry_timer);
+	dev->rx_mode_retry_count = 0;
+}
+
 static void netif_rx_mode_run(struct net_device *dev)
 {
 	struct netdev_hw_addr_list uc_snap, mc_snap, uc_ref, mc_ref;
@@ -1275,8 +1304,8 @@ static void netif_rx_mode_run(struct net_device *dev)
 		err = netif_addr_lists_snapshot(dev, &uc_snap, &mc_snap,
 						&uc_ref, &mc_ref);
 		if (err) {
-			netdev_WARN(dev, "failed to sync uc/mc addresses\n");
 			netif_addr_unlock_bh(dev);
+			netif_rx_mode_schedule_retry(dev);
 			return;
 		}
 
@@ -1292,12 +1321,17 @@ static void netif_rx_mode_run(struct net_device *dev)
 		__dev_set_promiscuity(dev, promisc_inc, false);
 
 	if (ops->ndo_set_rx_mode_async) {
-		ops->ndo_set_rx_mode_async(dev, &uc_snap, &mc_snap);
+		err = ops->ndo_set_rx_mode_async(dev, &uc_snap, &mc_snap);
 
 		netif_addr_lock_bh(dev);
 		netif_addr_lists_reconcile(dev, &uc_snap, &mc_snap,
 					   &uc_ref, &mc_ref);
 		netif_addr_unlock_bh(dev);
+
+		if (err)
+			netif_rx_mode_schedule_retry(dev);
+		else
+			dev->rx_mode_retry_count = 0;
 	} else if (ops->ndo_set_rx_mode) {
 		netif_addr_lock_bh(dev);
 		ops->ndo_set_rx_mode(dev);
@@ -1350,6 +1384,21 @@ static void netif_rx_mode_queue(struct net_device *dev)
 	schedule_work(&rx_mode_work);
 }
 
+static void netif_rx_mode_retry(struct timer_list *t)
+{
+	struct net_device *dev =
+		timer_container_of(dev, t, rx_mode_retry_timer);
+
+	netif_rx_mode_queue(dev);
+}
+
+void netif_rx_mode_init(struct net_device *dev)
+{
+	INIT_LIST_HEAD(&dev->rx_mode_node);
+	__hw_addr_init(&dev->rx_mode_addr_cache);
+	timer_setup(&dev->rx_mode_retry_timer, netif_rx_mode_retry, 0);
+}
+
 /**
  * __dev_set_rx_mode() - upload unicast and multicast address lists to device
  * and configure RX filtering.
-- 
2.53.0-Meta


