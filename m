Return-Path: <netdev+bounces-301739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ent2G5YPPGqfjQgAu9opvQ
	(envelope-from <netdev+bounces-301739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 19:10:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 912716C0408
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 19:10:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=eYcEgvqW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301739-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301739-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB9363007B24
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45E53D1715;
	Wed, 24 Jun 2026 17:10:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960AE3D0919
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 17:10:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782321040; cv=none; b=M6lzkI/Xelcq4GiAPtrryYocgBJ1BAL44HOg6FGlWRzhAwmQSZ4KeZWNu+lLRQeV8s/2RhJLVsFEq45KljaENUHtskD1eElPRvJzteUbj4aRVWbXEBg0arIZvci8iPJOAB0dQzv/ScZLuZEgRkKr+yP/oUASI/8WFtBTTe6AexM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782321040; c=relaxed/simple;
	bh=orl3ymwn6MRLDk0B1dUfStRJvibU2OS50IgujtuAuJU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uJoj3iHWw6oHt8Fts61zDHraB9Wb6OYnEAMf+XiBQ/tJT+t1KMcwKXqzeVRhikV4L3rMSWKlBAAKjI07/yEEwxGz/LNoaMqQlC7Nb2IVvU34sf9F7UnxDQC/8hHQJEu0yKtkfkAzH+L6A0d/ZFu233U65X6NGEYmeS9TsAUgUbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eYcEgvqW; arc=none smtp.client-ip=209.85.222.202
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-92158791d14so127418785a.2
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 10:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782321036; x=1782925836; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gvK87bp9dCyAisUHSOKIwqLtbGDfec6Sd9wpqQRUIic=;
        b=eYcEgvqWWAsb/ph5mvopbWAF+zW2sDus7ZFssyKyj/NktXC5JM1EHE5GN7bcDRjUVG
         wSZqnjZerIYVSxRwoxWUWk/b8zpIqHFJM0k+k8yex/NzBYEjX6Vn20AyThkgslEMszoW
         ifRq8k8aH6twl/lJes2mM2beF1mS53n5FpgImriLmNi7GWWMnzme3bV4TYYN4Luj2TYm
         Ei+SD/nQKgAuGBJjZq5iwgIaRxfn/djfO9ibswao82Sc/Vs+eQrs1VB/vNX5doVk0gBr
         9YJma5ZicoCEDiSOt4nwWPeYkZvWAIjgYRJzJQ3eOXT2UkcUKFll6qktNf+UvnYbUyAf
         GZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782321036; x=1782925836;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gvK87bp9dCyAisUHSOKIwqLtbGDfec6Sd9wpqQRUIic=;
        b=qSqudnkR2qRgOKPSzxm/7ddYLNvISEtcg0zBuh/JmZvZG3rCaz3+trEnWsasAOmwOG
         4YOH2tAB61aot87ukIp4r8/rxBcIYy07Iz1rZESU+yzq1JU6EAwvkq4ni69xPut0noFV
         5WUJzrTaudRbkbv7jBrSATZ/eV0jC/Da73voWJm+ypWDgbGdV19ernzLqrFa31oJR6kP
         DN1E2GHC9TJjVXFUuYHqOFWJWucbT8k2e8n0vkX+UbZkHsdsJJHFfBkF2KRrk1dst9nx
         /AR5qxe0HDIbIJVF+3rDTHfew4coL0pFGG8NpbFUXUUmRwYRXufxHw5AdEveiZmx84MC
         Efrg==
X-Forwarded-Encrypted: i=1; AFNElJ+YJ0aXEnVjrkbWoTY7jZGMKhw7VFeV4aouMj8ohdVPW2v8RvPIhm9iLfm6SFRFheO651d09Io=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvYkEeKUy37UJi4pYY/dFHMUJOy4dYUNpXKyNnYjYU4zWWcpwr
	H6RLDnyuP+SESnZE1dIReZYgDAkz54x5W5PdUHG9zCnKUrhgkDBuE8s6Hx/R/vuvQEv1dgTANnN
	0r5ZN4KZE7/qhQA==
X-Received: from qkaf13.prod.google.com ([2002:a05:620a:20cd:b0:915:6def:f6c3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:bc6:b0:915:f96b:8f5a with SMTP id af79cd13be357-92783a4c746mr666521485a.36.1782321035649;
 Wed, 24 Jun 2026 10:10:35 -0700 (PDT)
Date: Wed, 24 Jun 2026 17:10:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624171034.4117423-1-edumazet@google.com>
Subject: [PATCH net] net: udp_tunnel: fix use-after-free by refcounting udp_tunnel_nic
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Yue Sun <samsun1006219@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301739-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:samsun1006219@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 912716C0408

Yue Sun reported a use-after-free and debugobjects warning in
udp_tunnel_nic_device_sync_work() during concurrent device operations.

The state flags of struct udp_tunnel_nic were originally bitfields
sharing a byte, modified concurrently without locking (RCU vs worker).
Even after converting to atomic bitops, a single WORK_PENDING flag
races: the workqueue core clears the pending bit before running the
worker. A concurrent queueing sets the flag, but the running worker
clears it, leading to premature freeing in unregister() while the
re-queued work is still active.

Fix this introducing reference counting for struct
udp_tunnel_nic. Increment the refcount on successful queue_work(),
and decrement it at the end of the worker. Defer the dev_put() call
for the last device to the free path to ensure the net_device remains
valid as long as the structure is alive.

Additionally, convert concurrent modifications of the 'missed' bitmap
to atomic operations (set_bit, bitmap_zero) to prevent data races there.

Fixes: cc4e3835eff4 ("udp_tunnel: add central NIC RX port offload infrastructure")
Reported-by: Yue Sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/netdev/20260624090135.95763-1-samsun1006219@gmail.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/udp_tunnel_nic.c | 75 +++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 30 deletions(-)

diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
index 9944ed923ddfd10f9adf6ad788c0740daeaf2adb..884b5d93b7b39f7f20855ff8ca2ec4d7ef5a9ef6 100644
--- a/net/ipv4/udp_tunnel_nic.c
+++ b/net/ipv4/udp_tunnel_nic.c
@@ -30,9 +30,8 @@ struct udp_tunnel_nic_table_entry {
  * @work:	async work for talking to hardware from process context
  * @dev:	netdev pointer
  * @lock:	protects all fields
- * @need_sync:	at least one port start changed
- * @need_replay: space was freed, we need a replay of all ports
- * @work_pending: @work is currently scheduled
+ * @flags:	sync, replay flags
+ * @refcnt:	reference count
  * @n_tables:	number of tables under @entries
  * @missed:	bitmap of tables which overflown
  * @entries:	table of tables of ports currently offloaded
@@ -44,9 +43,11 @@ struct udp_tunnel_nic {
 
 	struct mutex lock;
 
-	u8 need_sync:1;
-	u8 need_replay:1;
-	u8 work_pending:1;
+	unsigned long flags;
+#define UDP_TUNNEL_NIC_NEED_SYNC	0
+#define UDP_TUNNEL_NIC_NEED_REPLAY	1
+
+	refcount_t refcnt;
 
 	unsigned int n_tables;
 	unsigned long missed;
@@ -116,7 +117,7 @@ udp_tunnel_nic_entry_queue(struct udp_tunnel_nic *utn,
 			   unsigned int flag)
 {
 	entry->flags |= flag;
-	utn->need_sync = 1;
+	set_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags);
 }
 
 static void
@@ -283,7 +284,7 @@ udp_tunnel_nic_device_sync_by_table(struct net_device *dev,
 static void
 __udp_tunnel_nic_device_sync(struct net_device *dev, struct udp_tunnel_nic *utn)
 {
-	if (!utn->need_sync)
+	if (!test_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags))
 		return;
 
 	if (dev->udp_tunnel_nic_info->sync_table)
@@ -291,21 +292,24 @@ __udp_tunnel_nic_device_sync(struct net_device *dev, struct udp_tunnel_nic *utn)
 	else
 		udp_tunnel_nic_device_sync_by_port(dev, utn);
 
-	utn->need_sync = 0;
+	clear_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags);
 	/* Can't replay directly here, in case we come from the tunnel driver's
 	 * notification - trying to replay may deadlock inside tunnel driver.
 	 */
-	utn->need_replay = udp_tunnel_nic_should_replay(dev, utn);
+	if (udp_tunnel_nic_should_replay(dev, utn))
+		set_bit(UDP_TUNNEL_NIC_NEED_REPLAY, &utn->flags);
+	else
+		clear_bit(UDP_TUNNEL_NIC_NEED_REPLAY, &utn->flags);
 }
 
 static void
 udp_tunnel_nic_device_sync(struct net_device *dev, struct udp_tunnel_nic *utn)
 {
-	if (!utn->need_sync)
+	if (!test_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags))
 		return;
 
-	queue_work(udp_tunnel_nic_workqueue, &utn->work);
-	utn->work_pending = 1;
+	if (queue_work(udp_tunnel_nic_workqueue, &utn->work))
+		refcount_inc(&utn->refcnt);
 }
 
 static bool
@@ -348,7 +352,7 @@ udp_tunnel_nic_has_collision(struct net_device *dev, struct udp_tunnel_nic *utn,
 			if (!udp_tunnel_nic_entry_is_free(entry) &&
 			    entry->port == ti->port &&
 			    entry->type != ti->type) {
-				__set_bit(i, &utn->missed);
+				set_bit(i, &utn->missed);
 				return true;
 			}
 		}
@@ -483,7 +487,7 @@ udp_tunnel_nic_add_new(struct net_device *dev, struct udp_tunnel_nic *utn,
 		 * are no devices currently which have multiple tables accepting
 		 * the same tunnel type, and false positives are okay.
 		 */
-		__set_bit(i, &utn->missed);
+		set_bit(i, &utn->missed);
 	}
 
 	return false;
@@ -552,7 +556,7 @@ static void __udp_tunnel_nic_reset_ntf(struct net_device *dev)
 
 	mutex_lock(&utn->lock);
 
-	utn->need_sync = false;
+	clear_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags);
 	for (i = 0; i < utn->n_tables; i++)
 		for (j = 0; j < info->tables[i].n_entries; j++) {
 			struct udp_tunnel_nic_table_entry *entry;
@@ -696,8 +700,8 @@ udp_tunnel_nic_flush(struct net_device *dev, struct udp_tunnel_nic *utn)
 	for (i = 0; i < utn->n_tables; i++)
 		memset(utn->entries[i], 0, array_size(info->tables[i].n_entries,
 						      sizeof(**utn->entries)));
-	WARN_ON(utn->need_sync);
-	utn->need_replay = 0;
+	WARN_ON(test_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags));
+	clear_bit(UDP_TUNNEL_NIC_NEED_REPLAY, &utn->flags);
 }
 
 static void
@@ -713,8 +717,8 @@ udp_tunnel_nic_replay(struct net_device *dev, struct udp_tunnel_nic *utn)
 	for (i = 0; i < utn->n_tables; i++)
 		for (j = 0; j < info->tables[i].n_entries; j++)
 			udp_tunnel_nic_entry_freeze_used(&utn->entries[i][j]);
-	utn->missed = 0;
-	utn->need_replay = 0;
+	bitmap_zero(&utn->missed, UDP_TUNNEL_NIC_MAX_TABLES);
+	clear_bit(UDP_TUNNEL_NIC_NEED_REPLAY, &utn->flags);
 
 	if (!info->shared) {
 		udp_tunnel_get_rx_info(dev);
@@ -728,6 +732,8 @@ udp_tunnel_nic_replay(struct net_device *dev, struct udp_tunnel_nic *utn)
 			udp_tunnel_nic_entry_unfreeze(&utn->entries[i][j]);
 }
 
+static void udp_tunnel_nic_put(struct udp_tunnel_nic *utn);
+
 static void udp_tunnel_nic_device_sync_work(struct work_struct *work)
 {
 	struct udp_tunnel_nic *utn =
@@ -736,14 +742,15 @@ static void udp_tunnel_nic_device_sync_work(struct work_struct *work)
 	rtnl_lock();
 	mutex_lock(&utn->lock);
 
-	utn->work_pending = 0;
 	__udp_tunnel_nic_device_sync(utn->dev, utn);
 
-	if (utn->need_replay)
+	if (test_bit(UDP_TUNNEL_NIC_NEED_REPLAY, &utn->flags))
 		udp_tunnel_nic_replay(utn->dev, utn);
 
 	mutex_unlock(&utn->lock);
 	rtnl_unlock();
+
+	udp_tunnel_nic_put(utn);
 }
 
 static struct udp_tunnel_nic *
@@ -759,6 +766,7 @@ udp_tunnel_nic_alloc(const struct udp_tunnel_nic_info *info,
 	utn->n_tables = n_tables;
 	INIT_WORK(&utn->work, udp_tunnel_nic_device_sync_work);
 	mutex_init(&utn->lock);
+	refcount_set(&utn->refcnt, 1);
 
 	for (i = 0; i < n_tables; i++) {
 		utn->entries[i] = kzalloc_objs(*utn->entries[i],
@@ -782,9 +790,19 @@ static void udp_tunnel_nic_free(struct udp_tunnel_nic *utn)
 
 	for (i = 0; i < utn->n_tables; i++)
 		kfree(utn->entries[i]);
+
+	if (utn->dev)
+		dev_put(utn->dev);
+
 	kfree(utn);
 }
 
+static void udp_tunnel_nic_put(struct udp_tunnel_nic *utn)
+{
+	if (refcount_dec_and_test(&utn->refcnt))
+		udp_tunnel_nic_free(utn);
+}
+
 static int udp_tunnel_nic_register(struct net_device *dev)
 {
 	const struct udp_tunnel_nic_info *info = dev->udp_tunnel_nic_info;
@@ -863,6 +881,7 @@ static void
 udp_tunnel_nic_unregister(struct net_device *dev, struct udp_tunnel_nic *utn)
 {
 	const struct udp_tunnel_nic_info *info = dev->udp_tunnel_nic_info;
+	bool last = true;
 
 	udp_tunnel_nic_lock(dev);
 
@@ -889,6 +908,7 @@ udp_tunnel_nic_unregister(struct net_device *dev, struct udp_tunnel_nic *utn)
 			udp_tunnel_drop_rx_info(dev);
 			utn->dev = first->dev;
 			udp_tunnel_nic_unlock(dev);
+			last = false;
 			goto release_dev;
 		}
 
@@ -901,16 +921,11 @@ udp_tunnel_nic_unregister(struct net_device *dev, struct udp_tunnel_nic *utn)
 	udp_tunnel_nic_flush(dev, utn);
 	udp_tunnel_nic_unlock(dev);
 
-	/* Wait for the work to be done using the state, netdev core will
-	 * retry unregister until we give up our reference on this device.
-	 */
-	if (utn->work_pending)
-		return;
-
-	udp_tunnel_nic_free(utn);
+	udp_tunnel_nic_put(utn);
 release_dev:
 	dev->udp_tunnel_nic = NULL;
-	dev_put(dev);
+	if (!last)
+		dev_put(dev);
 }
 
 static int
-- 
2.55.0.rc0.799.gd6f94ed593-goog


