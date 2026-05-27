Return-Path: <netdev+bounces-292047-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOdCJ1NMFmrZkQcAu9opvQ
	(envelope-from <netdev+bounces-292047-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:43:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F26955DE558
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA377307B572
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E36302CD5;
	Wed, 27 May 2026 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JH32DcH7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1201D326942
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 01:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846083; cv=none; b=Dl8So9XKdU53lxmwLJuh9vd6e6YUHcrnXrsNqbTd2rl+ZE23spXY+/XwBldKCnpbSV4KqNjaD6KdXuJQk/duEHKyyAYsaewjXtjhuHuok30R2+4GNgGxbTQlSjfGmQmpwjVcK45fp9ElsGQYo979o0m9wxbWGGcTGfayf43HpDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846083; c=relaxed/simple;
	bh=M6e01UGL9dCMqKJpezSNhfHIRw0TQrxSI27KxMSG4Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVGll8TEW+o9PMLP3kSC7CQZY7OE+MMvhK1yTmKaJ+kZ+lExVwlGPrIdIfS1WBpRGO95zrkVqwTXPYtrNaC5nQo8m66xImBfmUkMMHUE4t6uIlV31XWKIG+o0X9cRlfFHjPoagCaOAPUyxxpzv7x4KIwFIQQQIXqkMHfiy2mnRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JH32DcH7; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c80170db7d6so4454661a12.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 18:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779846080; x=1780450880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XQD3rG0rqbKIVDDKlzx6Q/Fhij3jOBMywQxrhZwUFk=;
        b=JH32DcH7PXNLh8Gw5LXp2tM8czlZSE9yd2/FQy6iyz3hq0vdwYMSqQzgoeX/zzkBV1
         4a8DlckCstcgZOngEZR2mS9xEfvvQihY/FTaLJUCWj7osrdytyQub4QNjHjzjt8hpOLQ
         bYzwCF0HSak+QX9ZyIjLnmvaujwNjr3BiL7XKJ90Ng9SwnMdDUAccEjR9MH6USZt1FcH
         qc0HTIRWn4c2Ojk7P+VRvzfF0kCTVSdNJ+ru9jIivo/nsoWPaWHu3HkW4hs8HM83oefR
         rr0VUPGFwsV8cllBwJsdo2qLnzLyDvelSq3mk9lUKxy+Enuui/w2qG8nN1yR2vNVuLp5
         y//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779846080; x=1780450880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7XQD3rG0rqbKIVDDKlzx6Q/Fhij3jOBMywQxrhZwUFk=;
        b=htdYq+9NmLWvj8fLKAi0KKXopdGbg6kqbHjYwzqEoUCr94DYETtwN1FNJuZ8eW9zxZ
         MbXgz0bgxO8nHiUSnCU3Pd1Vzz+WhGwm6hFGjxvcQiVc23FWCG5D2lv4ykSIMvxJcclR
         N9weg0rEpB5RfabrhR/UcqqPoBQZRIrWOX4xoYIZ4m9FYmPllXmpEGlXbRlX45xNXXa1
         0sP4godAE4+3F5tlKbfnTwdXG5twvnfvdzh9ggwrmSfEWz/Zst1rHjuBXeYiQeytvlkE
         iK4eI9txcwnh2EPBIt0IXdBVxH7J5gzZ0OgufsVnCCBIlMbyiIAJXXI1TZ7nhs9HJs++
         W8AA==
X-Gm-Message-State: AOJu0YwC7/l9FSRoT16p0JEsXKj2+YsqQQHb9vOI+BTdF25LNna5Zy4g
	efBqWL+DBeDm5ve80dDwrhILefy1suPiPT+eGvDhiJZQlwTPGKZAiP91sOg6LevD
X-Gm-Gg: Acq92OGc41Fm4dEf4MwDItOhY5R3vpPCfgR6ZeMTaQAuY/hDQ1SxwvtvZ/4881M9Mxl
	meQey8v8gktJNPHD2Vc2AvDcWFnZun/0MbAlRCaA8PYAWtsK1XKgpQTz6byga+JrycevNofvMh1
	Zrf3Jp4gejYMNyBtoQrqB1QlWn3SzY04Gbzq30vq8p3awaLhsEiiIq6BibvIa2cjocFSxhI+3W8
	JhX9sYb6NuAzkGnIpLiRz+Cl34aerGZMId47nEfnQgfANMe5bhEeffGB8QfqkJJwsAiMeLwfJSI
	3EjkJskBwrP1S33hC0LqKKSLTDxKgwfVd7Bb1DRZlVxufysfEZqDNEkRDuh1sz/ni2wLsZJophW
	UlmqjyARd85fZf7LD0KvWHdSZOb1rQP8lRsd1/AfSPHgdfH2ke0JOmrJ6MouV5yLtWDwFHiYvGb
	SXMzsa+E6nJqSJXnKx45zMxCjNUA==
X-Received: by 2002:a05:6a21:4d8d:b0:3a2:d79c:4159 with SMTP id adf61e73a8af0-3b3293404c6mr21300530637.32.1779846080431;
        Tue, 26 May 2026 18:41:20 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85202902b1sm11200903a12.6.2026.05.26.18.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 18:41:20 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 2/3] net: add retry mechanism to ndo_set_rx_mode_async
Date: Tue, 26 May 2026 18:41:16 -0700
Message-ID: <20260527014117.1401809-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260527014117.1401809-1-sdf@fomichev.me>
References: <20260527014117.1401809-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292047-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rx_mode_retry_work.work:url]
X-Rspamd-Queue-Id: F26955DE558
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When ndo_set_rx_mode_async returns an error, schedule a retry with
exponential backoff (1s, 2s, 4s, 8s — 15s total). Give up after the
4th retry and log an error via netdev_err().

This moves retry logic from individual drivers into the core stack.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/linux/netdevice.h |  5 ++++
 net/core/dev.c            |  7 +++--
 net/core/dev.h            |  2 ++
 net/core/dev_addr_lists.c | 56 +++++++++++++++++++++++++++++++++++++--
 4 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 07356e784282..ea4eb7d2cad8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1933,6 +1933,8 @@ enum netdev_reg_state {
  *	@rx_mode_node:		List entry for rx_mode work processing
  *	@rx_mode_tracker:	Refcount tracker for rx_mode work
  *	@rx_mode_addr_cache:	Recycled snapshot entries for rx_mode work
+ *	@rx_mode_retry_work:	Delayed work for failed rx_mode
+ *	@rx_mode_retry_delay:	Backoff delay for the next rx_mode attempt
  *	@uc:			unicast mac addresses
  *	@mc:			multicast mac addresses
  *	@dev_addrs:		list of device hw addresses
@@ -2327,6 +2329,8 @@ struct net_device {
 	struct list_head	rx_mode_node;
 	netdevice_tracker	rx_mode_tracker;
 	struct netdev_hw_addr_list	rx_mode_addr_cache;
+	struct delayed_work	rx_mode_retry_work;
+	unsigned long		rx_mode_retry_delay;
 #ifdef CONFIG_LOCKDEP
 	unsigned char		nested_level;
 #endif
@@ -5150,6 +5154,7 @@ static inline void __dev_mc_unsync(struct net_device *dev,
 
 /* Functions used for secondary unicast and multicast support */
 void dev_set_rx_mode(struct net_device *dev);
+void netif_rx_mode_schedule_retry(struct net_device *dev);
 int netif_set_promiscuity(struct net_device *dev, int inc);
 int dev_set_promiscuity(struct net_device *dev, int inc);
 int netif_set_allmulti(struct net_device *dev, int inc, bool notify);
diff --git a/net/core/dev.c b/net/core/dev.c
index 26ac8eb9b259..751d6b5c4e23 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1775,6 +1775,8 @@ static void __dev_close_many(struct list_head *head)
 		if (ops->ndo_stop)
 			ops->ndo_stop(dev);
 
+		netif_rx_mode_cancel_retry(dev);
+
 		netif_set_up(dev, false);
 		netpoll_poll_enable(dev);
 	}
@@ -11720,6 +11722,8 @@ void netdev_run_todo(void)
 			continue;
 		}
 
+		if (cancel_delayed_work_sync(&dev->rx_mode_retry_work))
+			dev_put(dev);
 		netdev_lock(dev);
 		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERED);
 		netdev_unlock(dev);
@@ -12100,8 +12104,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
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
index d73fcb0c6785..c02aa05c9975 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -23,6 +23,24 @@ static LIST_HEAD(rx_mode_list);
 static DEFINE_SPINLOCK(rx_mode_lock);
 static DECLARE_WORK(rx_mode_work, netdev_rx_mode_work);
 
+static void netif_rx_mode_queue(struct net_device *dev);
+
+static void netif_rx_mode_retry(struct work_struct *work)
+{
+	struct net_device *dev = container_of(work, struct net_device,
+					      rx_mode_retry_work.work);
+
+	netif_rx_mode_queue(dev);
+	dev_put(dev);
+}
+
+void netif_rx_mode_init(struct net_device *dev)
+{
+	INIT_LIST_HEAD(&dev->rx_mode_node);
+	__hw_addr_init(&dev->rx_mode_addr_cache);
+	INIT_DELAYED_WORK(&dev->rx_mode_retry_work, netif_rx_mode_retry);
+}
+
 /*
  * General list handling functions
  */
@@ -1252,6 +1270,35 @@ static int netif_uc_promisc_update(struct net_device *dev)
 	return 0;
 }
 
+void netif_rx_mode_schedule_retry(struct net_device *dev)
+{
+	unsigned long delay;
+
+	/* Total retry budget: 1+2+4+8 = 15 seconds. */
+	if (dev->rx_mode_retry_delay >= 8 * HZ) {
+		netdev_err(dev, "rx_mode retry limit reached, giving up\n");
+		return;
+	}
+
+	delay = dev->rx_mode_retry_delay ? dev->rx_mode_retry_delay * 2 : HZ;
+	dev_hold(dev);
+	if (!schedule_delayed_work(&dev->rx_mode_retry_work, delay)) {
+		dev_put(dev);
+		return;
+	}
+	if (!dev->rx_mode_retry_delay)
+		netdev_info(dev, "rx_mode install failed, retrying with backoff\n");
+	dev->rx_mode_retry_delay = delay;
+}
+EXPORT_SYMBOL_GPL(netif_rx_mode_schedule_retry);
+
+void netif_rx_mode_cancel_retry(struct net_device *dev)
+{
+	if (cancel_delayed_work(&dev->rx_mode_retry_work))
+		dev_put(dev);
+	dev->rx_mode_retry_delay = 0;
+}
+
 static void netif_rx_mode_run(struct net_device *dev)
 {
 	struct netdev_hw_addr_list uc_snap, mc_snap, uc_ref, mc_ref;
@@ -1275,8 +1322,8 @@ static void netif_rx_mode_run(struct net_device *dev)
 		err = netif_addr_lists_snapshot(dev, &uc_snap, &mc_snap,
 						&uc_ref, &mc_ref);
 		if (err) {
-			netdev_WARN(dev, "failed to sync uc/mc addresses\n");
 			netif_addr_unlock_bh(dev);
+			netif_rx_mode_schedule_retry(dev);
 			return;
 		}
 
@@ -1292,12 +1339,17 @@ static void netif_rx_mode_run(struct net_device *dev)
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
+			netif_rx_mode_cancel_retry(dev);
 	} else if (ops->ndo_set_rx_mode) {
 		netif_addr_lock_bh(dev);
 		ops->ndo_set_rx_mode(dev);
-- 
2.53.0-Meta


