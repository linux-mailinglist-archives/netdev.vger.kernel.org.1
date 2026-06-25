Return-Path: <netdev+bounces-301876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TFbeIgzSPGpEswgAu9opvQ
	(envelope-from <netdev+bounces-301876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:00:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D422A6C32EE
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:00:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=qpmj0wpm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301876-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301876-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 424343050908
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 06:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF063C1418;
	Thu, 25 Jun 2026 06:59:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B0B3C10A2
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 06:59:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782370786; cv=none; b=ZwvH8NNkSBgQOjM3kz1SzmUxBiW7V+69HXc5vMisidSSmAMIzzf7bi8/a4D/zUzvgfoZF5/sx41iYDxVh9JxEJM7cuLC8rne00C6GIZzBhktyyh6LbHgj6GPEsp9NIUE9P89N4VnL+rqMFRYEyjBEG82ZAM0d0EOQC+0be68a1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782370786; c=relaxed/simple;
	bh=Tb2IDHRzzorWR9cEbtn4yaZ/Jd061aJ5xR+aNMe+TxY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sp4reMteBfip1F740N3Ueuw2KrwDqfA31ojgiij6jjbWsTD8LlXZGKr+TzfUihtlRth2hU7Wh5ccIJK8Xp63HgHXHzUtR74V4dgrrcekfT925sSSGRbbT/TZZ9Nqar6eLVoTOWhs90GF3b8kJ1uSvK5OUotPXd7O56gsgDtC+G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qpmj0wpm; arc=none smtp.client-ip=209.85.219.74
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8e0df2461fdso52974886d6.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 23:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782370783; x=1782975583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UTcs06GL2TDTUrqHy4GCkpcNWqRvRAQATZ7ioCHlYHM=;
        b=qpmj0wpmWa2AlzfVAGAVYaSDbpLbidkbkMt3VFGBihcGvhhurfuywD5IdUOA6XpFAE
         LRdg4OkjZahNywxRkeWDcfaXlxEQ58uW1Wvnymgy1cANxTYjtxR1Mkwj/dsM8ZHNXnRc
         w63hthaJygTwx23B59CDDloQpnhRKnxuAZyCiGI6g40sgNGdK4kBEz1Zrsf2FcQ/Tjg7
         XGJc0KaCJcx+lvy+GqwCz0m6D34aVKcDFpDOL9fnyVaD77WsHK6w+39+HwgEDSWtDRwV
         ZAzk1IE3AdCATT4vJoeVB1NWF9AIckxLxLEpxz1r0PEE2p14GdW0BnUWjRPfWeMKa1LV
         Dtpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782370783; x=1782975583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UTcs06GL2TDTUrqHy4GCkpcNWqRvRAQATZ7ioCHlYHM=;
        b=TBMINg1ys8DEPu9r3k5bvJjLBXU7MzTbfBTiVNrMWoByg5L8jNAWMmvZobwQ4kvMAk
         /jLLIzm4XOOiwkhAAV9rBeOyCVm6C5aSV5gEwFqIkVDt5gxhKijvkXhWNuve2iCOwM4a
         izPIQFmx+JSqWflRnvzJBstyCTGFbLFvcynVKMArteqmMGlcwg+WQLnZHrUSoUmrH/cw
         uGq/R2zvVw1cQgAfybetNLg+flDFPkHJgVtCF40j/Gk9e11RNrfGyPn4EaweAJr7CArL
         ozH3ge8WHZNifEWgX3qDn/IIc2UYJpOJuKhpYqHMZKNn15uJ5s5xI3YWA2aUeK3Rm3A0
         NoZQ==
X-Forwarded-Encrypted: i=1; AHgh+RqS67RMHPB0FWX8bavA69W2qEBcn/D2UA5gtZjdjkBEj93NJLQYFb77kIEN5aZnzIpWrO7X7QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYepKRnOYl5tLSG6xXUIvV3EEu3EtRrM5R1N+1b3MM0SdN/bni
	wlU0EQPfWXRCq1/CIE13fVkSsERkVxJTLqRdvjvdlh9h6fMCHi4RytJN9zndxikF53PllOFeuc9
	KMOrpZ0b7n7kp+g==
X-Received: from qvbpe2.prod.google.com ([2002:a05:6214:4942:b0:8db:4b24:67b2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:4589:b0:8ce:b018:89ff with SMTP id 6a1803df08f44-8e6d5bb41eamr24499176d6.36.1782370783194;
 Wed, 24 Jun 2026 23:59:43 -0700 (PDT)
Date: Thu, 25 Jun 2026 06:59:37 +0000
In-Reply-To: <20260625065938.654652-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625065938.654652-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625065938.654652-3-edumazet@google.com>
Subject: [PATCH v2 net 2/3] net: udp_tunnel: convert state flags to atomic bitops
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Yue Sun <samsun1006219@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,fomichev.me,vger.kernel.org,google.com];
	TAGGED_FROM(0.00)[bounces-301876-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:samsun1006219@gmail.com,m:sdf@fomichev.me,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D422A6C32EE

The state flags of struct udp_tunnel_nic (need_sync, need_replay,
work_pending) are currently bitfields sharing a single byte.

These flags can be modified concurrently from different contexts:
- RTNL-locked paths (like add_port/del_port) write to need_sync and
  work_pending.
- The RTNL-less reset path (reset_ntf, used by netdevsim) writes to
  need_sync and need_replay under utn->lock.

Since they share a byte, concurrent writes are compiled into non-atomic
Read-Modify-Write (RMW) operations that can corrupt each other. For
example, a write to need_replay in reset_ntf can overwrite and clear
work_pending, defeating the double-queueing prevention and causing UAF.

Fix this by converting these state flags to atomic bitops, ensuring
safe concurrent writes across RTNL-locked and RTNL-less paths.

Fixes: 1ead7501094c ("udp_tunnel: remove rtnl_lock dependency")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/udp_tunnel_nic.c | 43 ++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
index 3b32a0afa9798d3c416d9ae570e6d529f70e6697..840be5d79fc0ac3142049dcb9f1105a5844da9ae 100644
--- a/net/ipv4/udp_tunnel_nic.c
+++ b/net/ipv4/udp_tunnel_nic.c
@@ -30,9 +30,7 @@ struct udp_tunnel_nic_table_entry {
  * @work:	async work for talking to hardware from process context
  * @dev:	netdev pointer
  * @lock:	protects all fields
- * @need_sync:	at least one port start changed
- * @need_replay: space was freed, we need a replay of all ports
- * @work_pending: @work is currently scheduled
+ * @flags:	sync, replay, pending flags
  * @n_tables:	number of tables under @entries
  * @missed:	bitmap of tables which overflown
  * @entries:	table of tables of ports currently offloaded
@@ -44,9 +42,10 @@ struct udp_tunnel_nic {
 
 	struct mutex lock;
 
-	u8 need_sync:1;
-	u8 need_replay:1;
-	u8 work_pending:1;
+	unsigned long flags;
+#define UDP_TUNNEL_NIC_NEED_SYNC	0
+#define UDP_TUNNEL_NIC_NEED_REPLAY	1
+#define UDP_TUNNEL_NIC_WORK_PENDING	2
 
 	unsigned int n_tables;
 	unsigned long missed;
@@ -116,7 +115,7 @@ udp_tunnel_nic_entry_queue(struct udp_tunnel_nic *utn,
 			   unsigned int flag)
 {
 	entry->flags |= flag;
-	utn->need_sync = 1;
+	set_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags);
 }
 
 static void
@@ -283,7 +282,7 @@ udp_tunnel_nic_device_sync_by_table(struct net_device *dev,
 static void
 __udp_tunnel_nic_device_sync(struct net_device *dev, struct udp_tunnel_nic *utn)
 {
-	if (!utn->need_sync)
+	if (!test_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags))
 		return;
 
 	if (dev->udp_tunnel_nic_info->sync_table)
@@ -291,21 +290,27 @@ __udp_tunnel_nic_device_sync(struct net_device *dev, struct udp_tunnel_nic *utn)
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
-	if (!utn->need_sync || utn->work_pending)
+	if (!test_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags))
+		return;
+
+	if (test_bit(UDP_TUNNEL_NIC_WORK_PENDING, &utn->flags))
 		return;
 
 	queue_work(udp_tunnel_nic_workqueue, &utn->work);
-	utn->work_pending = 1;
+	set_bit(UDP_TUNNEL_NIC_WORK_PENDING, &utn->flags);
 }
 
 static bool
@@ -552,7 +557,7 @@ static void __udp_tunnel_nic_reset_ntf(struct net_device *dev)
 
 	mutex_lock(&utn->lock);
 
-	utn->need_sync = false;
+	clear_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags);
 	for (i = 0; i < utn->n_tables; i++)
 		for (j = 0; j < info->tables[i].n_entries; j++) {
 			struct udp_tunnel_nic_table_entry *entry;
@@ -696,8 +701,8 @@ udp_tunnel_nic_flush(struct net_device *dev, struct udp_tunnel_nic *utn)
 	for (i = 0; i < utn->n_tables; i++)
 		memset(utn->entries[i], 0, array_size(info->tables[i].n_entries,
 						      sizeof(**utn->entries)));
-	WARN_ON(utn->need_sync);
-	utn->need_replay = 0;
+	WARN_ON(test_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags));
+	clear_bit(UDP_TUNNEL_NIC_NEED_REPLAY, &utn->flags);
 }
 
 static void
@@ -714,7 +719,7 @@ udp_tunnel_nic_replay(struct net_device *dev, struct udp_tunnel_nic *utn)
 		for (j = 0; j < info->tables[i].n_entries; j++)
 			udp_tunnel_nic_entry_freeze_used(&utn->entries[i][j]);
 	utn->missed = 0;
-	utn->need_replay = 0;
+	clear_bit(UDP_TUNNEL_NIC_NEED_REPLAY, &utn->flags);
 
 	if (!info->shared) {
 		udp_tunnel_get_rx_info(dev);
@@ -736,10 +741,10 @@ static void udp_tunnel_nic_device_sync_work(struct work_struct *work)
 	rtnl_lock();
 	mutex_lock(&utn->lock);
 
-	utn->work_pending = 0;
+	clear_bit(UDP_TUNNEL_NIC_WORK_PENDING, &utn->flags);
 	__udp_tunnel_nic_device_sync(utn->dev, utn);
 
-	if (utn->need_replay)
+	if (test_bit(UDP_TUNNEL_NIC_NEED_REPLAY, &utn->flags))
 		udp_tunnel_nic_replay(utn->dev, utn);
 
 	mutex_unlock(&utn->lock);
@@ -904,7 +909,7 @@ udp_tunnel_nic_unregister(struct net_device *dev, struct udp_tunnel_nic *utn)
 	/* Wait for the work to be done using the state, netdev core will
 	 * retry unregister until we give up our reference on this device.
 	 */
-	if (utn->work_pending)
+	if (test_bit(UDP_TUNNEL_NIC_WORK_PENDING, &utn->flags))
 		return;
 
 	udp_tunnel_nic_free(utn);
-- 
2.55.0.rc0.799.gd6f94ed593-goog


