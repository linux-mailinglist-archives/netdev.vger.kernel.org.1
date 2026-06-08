Return-Path: <netdev+bounces-296648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 452nMg3uJmrYnQIAu9opvQ
	(envelope-from <netdev+bounces-296648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:30:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC608658B84
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:30:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QQ3FVrjQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296648-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296648-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 216B9326D8B0
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 15:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11033E6DD0;
	Mon,  8 Jun 2026 15:40:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428993E6399
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 15:40:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933221; cv=none; b=FsXciMJtx3LWBBOlSHh1NmKyuIUEfhGjAJKQQzZIzkN8elmqPX9HfVnPvWDDf1WgF/k//pSQbHWWekT3ZgfYxcYLP4JsZzDQStmSKYoBLRiZKDaxGJYJRFpbhB/r1rJQznGh22bHpNZiojAfNpuTHsjWocZJsneoYv3baVXu3ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933221; c=relaxed/simple;
	bh=tT4oeUeFjWU+OSbLRhSMzeWzZ3tyPCGKwp1S5hODlH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAI+BMj2+WNdI5lt7VV0zllm4aJbEXXHe+eO6I+Ao4GGcrZIjegoGqqv5loQGTdtpd2+OaEFgOtULjW71/YteIPFI+DggEbRYmIHwKK+bnlirzJmkwEjFh90BsA9be5uysga5HDofrNU9FGm+cree5KsXDQTsK0vM1RfQzt+2T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQ3FVrjQ; arc=none smtp.client-ip=209.85.214.193
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2bf114b0cf9so39622075ad.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 08:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780933220; x=1781538020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34SEDVmgA1u5k6b1S2QFC1V7XikdIgykkEDyqIzS12Y=;
        b=QQ3FVrjQW7rs//c77qYCC/KG2D8j29hKEG2y81hKDIbTtnqGABUiBfKSefFseicrXV
         AzycdXCXo8uwIjA8SPEf4rLEtD79y+vAlwiiIdhnWIJTQOC2X5sirrZejaX1vdHzAaFY
         5f4w2aTzJT+4K9QzdBQotgjuckGM2hyuLoXLlAeFaPn2h+Jz7cC5ZlL/AtUrqwD/GS26
         9sMkygxAfr9NeFjAJeD9SrQ3/12fKJRl5lbavada5lcsIZRcZT1qTA8giqEhOknsIh6u
         fsO6FmDwth8iVKYNJPlruleuyBWIBg7flAD0Xjndter4dpWC7RDLuuiCcg8vmcjqZIqP
         uREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780933220; x=1781538020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=34SEDVmgA1u5k6b1S2QFC1V7XikdIgykkEDyqIzS12Y=;
        b=Q038QKpX2QYiAjkPfj9DgjF9chZLVWRozObrQHFW8ZjadlxTZWkhGej3SRVxx2mQnR
         VTRncQQEocdT11O9jUjdUWbLIz4HYgD1jK2ukZNwv9bclovnLjB8i81KO6qT+c4ZXWP6
         1ZAiouO+KG8uvTyyD+xwJ/OQ//I2O++qgtUYcRFohMN9irLlIhGvHB0wCyPg80D7fY/T
         STHp/lH0vF59ntvFaybwA12x8bCN7uWSIpON5Vl4anEoTdCtMLFVRLvXNDhutQYT1uZX
         2OELT9l0bxptLdpwFOyj7LiSbdjHb6Z9M5+sNGPyGCjDkN7+cbgbL8HbPPyVwlHQb4Zr
         dJqA==
X-Gm-Message-State: AOJu0Yx9aruWzKu1lKOsx+I9I81zv+H5r8ztnr2IG70QCVSEoBC3vSPu
	k1zJarOHgejLsNj97hJrwh8/H/KekAYqAZkAUpH8782/9MQd5pjnhvxhX2nSrWF1
X-Gm-Gg: Acq92OEUiE7/YEQMvtMOrZIjCPP0JVOOu1WpefXT1RwYgK5ripe0OjJOWMD3rxGhFQe
	69Q07HhMo4y4R5+SHjr5yA3XykGDzoCswucK3CWwKwZTwC1UR/BzMf9Ez7WlpMGYDi44YkjX1kH
	ySBbHluA8W/ZYHmIXwamwvlcq077JgakpHpu1tPoya3jdc+Diqd5EL02mtdiCPdTzsRBN/AjtoG
	0xhGTQr/sgQ9uvQ8Dwksz54kgc1XqmBuqpBdZzZ7GhuPXCaQq72CxFIY36dYL9keAlqSm9LgDvJ
	VC9YR3H9Z97HAFcn9oLSOTdc3crkoY377ESnIi1s/AotnMTq4cap5R2n4gFOXUD51Mo1MwK+vN7
	aZRDGDQHY2x41Vap3Wc9r26D/oUp17XR0sINzfCedl1s3QOfTdvo6dSlHQbYee0pMH803Zzr2uh
	oqF3d1zyULu/qHnR7cV5ILxUCJtw==
X-Received: by 2002:a17:902:ce8f:b0:2c0:cb0e:ac42 with SMTP id d9443c01a7336-2c1e80f9d2bmr180753795ad.3.1780933219255;
        Mon, 08 Jun 2026 08:40:19 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d45csm252304355ad.14.2026.06.08.08.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:40:18 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v3 2/3] net: add retry mechanism to ndo_set_rx_mode_async
Date: Mon,  8 Jun 2026 08:40:13 -0700
Message-ID: <20260608154014.227538-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260608154014.227538-1-sdf@fomichev.me>
References: <20260608154014.227538-1-sdf@fomichev.me>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296648-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC608658B84

When ndo_set_rx_mode_async returns an error, schedule a retry with
exponential backoff (1s, 2s, 4s, 8s -- 15s total). Give up after the
4th retry and log an error via netdev_err().

This moves retry logic from individual drivers into the core stack.

Timer callback does not hold a ref on dev. Safe because the timer can
only be armed when dev is IFF_UP, and __dev_close_many runs
timer_delete_sync before clearing IFF_UP. Unregister always closes
IFF_UP devices first, so by the time dev can be freed the timer is
dead and cannot be re-armed.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
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
index 1ecd5691992e..202e35acb15b 100644
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
index 9e9431440869..4121c50e7c88 100644
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
index 6b493af8dc8b..e17f64a65e17 100644
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
+	netdev_assert_locked_ops_compat(dev);
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


