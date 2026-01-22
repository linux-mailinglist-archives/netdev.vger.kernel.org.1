Return-Path: <netdev+bounces-252445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIYlH6pWcmkpiwAAu9opvQ
	(envelope-from <netdev+bounces-252445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:56:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA706A737
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90350308342A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239AA39CECE;
	Thu, 22 Jan 2026 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g01su5s/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AC5350A17
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099365; cv=none; b=eYphRxTe4uhP3ZLzBJGWmM0R6xF3r/Jn2mjeJQkdpxWosVI/Osn2zoamBaW3EK76/cNAgJ7GVjF4g4Va4GKgvp1AelQUNK3hYXx1FXgJjcRktV0ToDSaaPLDsDpOCfzEXYBQq4ABTEfqZWxOvCcXJ7ag4lGOTXV/R0gFKEA+Ujw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099365; c=relaxed/simple;
	bh=Ebn21ksJbPBcdCuin1RzN63D3qteVdyrbwzYSTOmOuw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QeOpD9uM8MxsOThn6ppIM+K3+Sh8krvCkfiMVVEJrZU6BfAiFk3f3u1CjPaLGkqBi+xcpzQrNr0xn5JJD6VBLuAyaHiEQZcoZjZAcexGaaB2ICaTmrbYYnFlGDyxpCjJC9m5ON827v1FwLUp0EZjBUf9+NhUsHUI9ujd199+jmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g01su5s/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-790afc07667so13606857b3.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 08:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769099355; x=1769704155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h10dF6okl7CkiTOoXUox6nDzWbmwRR+IcHY3InFS6hM=;
        b=g01su5s/YNYS1Nx7eD8l+3j/WDZBkmC3LYZHknzqfyN+w71oyiTqmdLZLT3ufLA0eu
         zNH75I6Lo3eqh0D2r3CyAeXPU+m8bJ4At/UlA1aBonQWZgLUNPdsQux3wI49p/K7bxUT
         kLZhZhljezGwgdX6aWpFgMLXR3Q8BbWskhyAtHV28mgudbYaMsqhZNmmYMEivcc1kilD
         +TBDBOR40WOaqvBWz2FEUAsvipHzezABHrtvfAj2/I/cIwU5h5zOEF408Duhxqi7x2Wz
         orZBe85Z6YdEHDDN04QdegAKDT+9Lrxx7rdoZy07msUL+Os7WRaEmXq81mi/kMpJQi+/
         0iEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769099355; x=1769704155;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h10dF6okl7CkiTOoXUox6nDzWbmwRR+IcHY3InFS6hM=;
        b=PzXjX7rDHIS3scMexzyBRt4QGM/RAyvZlf4BWHAN4b089Muh7unCEqRs8kRwB+NPEG
         cP2/cqh7S5ITOj7HrW3exkH6AK7xIodDKPhgEpVwdl8G7LxrZVCsS2+xCVXOJO8MpXMD
         itQ48aFmcHJU0qb7SAXol13e0r+v01nSt7uHHTfEP1AUL5NKZJDMbcZiqkDz53/khNZc
         lycoe+ZBqGVpMM+FnPCM/6uZKocL2pGyyk1aYKhdJ7iY0Pz7eB/ZdIrn2ZQhIDQgd2g0
         Shw+U9H25vJWPTgvry5eOS7eZHu7qOLvC3ApUmvcGVpUc7WJm9wwkMGHqWSZujZQImNM
         uegA==
X-Forwarded-Encrypted: i=1; AJvYcCXi+o2y+7iyKNw/0uqVQLScMjU6J1eT2uQX6LANlXdTWyRkkNveDeT9XgqH0a2bgBn1QCq3n+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGzdFC1CGAR+AbDl36kFSCw5Lmy4jTie9J3jQMPONqpUqF8mcy
	ZmVsYy8lr10zRpIx4k974krWQ2J1oUnHh+RR1HkGzCH+XzRdbXNQ6Tk9mtMg/hxkjro2r8BUW2w
	2Z5dCdUQ7HBHJJw==
X-Received: from yxvs7.prod.google.com ([2002:a53:ac07:0:b0:644:7109:1048])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:b88:b0:649:4640:f8ea with SMTP id 956f58d0204a3-6494640f9eamr4856067d50.4.1769099355118;
 Thu, 22 Jan 2026 08:29:15 -0800 (PST)
Date: Thu, 22 Jan 2026 16:29:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122162914.2299312-1-edumazet@google.com>
Subject: [PATCH v2 net] bonding: annotate data-races around slave->last_rx
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252445-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,greyhouse.net,vger.kernel.org,google.com,googlegroups.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FA706A737
X-Rspamd-Action: no action

slave->last_rx and slave->target_last_arp_rx[...] can be read and written
locklessly. Add READ_ONCE() and WRITE_ONCE() annotations.

syzbot reported:

BUG: KCSAN: data-race in bond_rcv_validate / bond_rcv_validate

write to 0xffff888149f0d428 of 8 bytes by interrupt on cpu 1:
  bond_rcv_validate+0x202/0x7a0 drivers/net/bonding/bond_main.c:3335
  bond_handle_frame+0xde/0x5e0 drivers/net/bonding/bond_main.c:1533
  __netif_receive_skb_core+0x5b1/0x1950 net/core/dev.c:6039
  __netif_receive_skb_one_core net/core/dev.c:6150 [inline]
  __netif_receive_skb+0x59/0x270 net/core/dev.c:6265
  netif_receive_skb_internal net/core/dev.c:6351 [inline]
  netif_receive_skb+0x4b/0x2d0 net/core/dev.c:6410
...

write to 0xffff888149f0d428 of 8 bytes by interrupt on cpu 0:
  bond_rcv_validate+0x202/0x7a0 drivers/net/bonding/bond_main.c:3335
  bond_handle_frame+0xde/0x5e0 drivers/net/bonding/bond_main.c:1533
  __netif_receive_skb_core+0x5b1/0x1950 net/core/dev.c:6039
  __netif_receive_skb_one_core net/core/dev.c:6150 [inline]
  __netif_receive_skb+0x59/0x270 net/core/dev.c:6265
  netif_receive_skb_internal net/core/dev.c:6351 [inline]
  netif_receive_skb+0x4b/0x2d0 net/core/dev.c:6410
  br_netif_receive_skb net/bridge/br_input.c:30 [inline]
  NF_HOOK include/linux/netfilter.h:318 [inline]
...

value changed: 0x0000000100005365 -> 0x0000000100005366

Fixes: f5b2b966f032 ("[PATCH] bonding: Validate probe replies in ARP monitor")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
---
v2: Addressed AI feedback about _bond_options_ns_ip6_target_set()
    Added {READ,WRITEE_ONCE() in bond_option_arp_ip_target_rem()
v1: https://lore.kernel.org/netdev/20260120152856.1694824-1-edumazet@google.com/

 drivers/net/bonding/bond_main.c    | 18 ++++++++++--------
 drivers/net/bonding/bond_options.c |  8 ++++----
 include/net/bonding.h              | 13 +++++++------
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e7caf400a59cbd9680adea3d1b8ab7a22c78f7e6..a909ebcf1102d46beadc216a1b1a8a10e227ecb4 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3047,8 +3047,8 @@ static void bond_validate_arp(struct bonding *bond, struct slave *slave, __be32
 			   __func__, &sip);
 		return;
 	}
-	slave->last_rx = jiffies;
-	slave->target_last_arp_rx[i] = jiffies;
+	WRITE_ONCE(slave->last_rx, jiffies);
+	WRITE_ONCE(slave->target_last_arp_rx[i], jiffies);
 }
 
 static int bond_arp_rcv(const struct sk_buff *skb, struct bonding *bond,
@@ -3267,8 +3267,8 @@ static void bond_validate_na(struct bonding *bond, struct slave *slave,
 			  __func__, saddr);
 		return;
 	}
-	slave->last_rx = jiffies;
-	slave->target_last_arp_rx[i] = jiffies;
+	WRITE_ONCE(slave->last_rx, jiffies);
+	WRITE_ONCE(slave->target_last_arp_rx[i], jiffies);
 }
 
 static int bond_na_rcv(const struct sk_buff *skb, struct bonding *bond,
@@ -3338,7 +3338,7 @@ int bond_rcv_validate(const struct sk_buff *skb, struct bonding *bond,
 		    (slave_do_arp_validate_only(bond) && is_ipv6) ||
 #endif
 		    !slave_do_arp_validate_only(bond))
-			slave->last_rx = jiffies;
+			WRITE_ONCE(slave->last_rx, jiffies);
 		return RX_HANDLER_ANOTHER;
 	} else if (is_arp) {
 		return bond_arp_rcv(skb, bond, slave);
@@ -3406,7 +3406,7 @@ static void bond_loadbalance_arp_mon(struct bonding *bond)
 
 		if (slave->link != BOND_LINK_UP) {
 			if (bond_time_in_interval(bond, last_tx, 1) &&
-			    bond_time_in_interval(bond, slave->last_rx, 1)) {
+			    bond_time_in_interval(bond, READ_ONCE(slave->last_rx), 1)) {
 
 				bond_propose_link_state(slave, BOND_LINK_UP);
 				slave_state_changed = 1;
@@ -3430,8 +3430,10 @@ static void bond_loadbalance_arp_mon(struct bonding *bond)
 			 * when the source ip is 0, so don't take the link down
 			 * if we don't know our ip yet
 			 */
-			if (!bond_time_in_interval(bond, last_tx, bond->params.missed_max) ||
-			    !bond_time_in_interval(bond, slave->last_rx, bond->params.missed_max)) {
+			if (!bond_time_in_interval(bond, last_tx,
+						   bond->params.missed_max) ||
+			    !bond_time_in_interval(bond, READ_ONCE(slave->last_rx),
+						   bond->params.missed_max)) {
 
 				bond_propose_link_state(slave, BOND_LINK_DOWN);
 				slave_state_changed = 1;
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 384499c869b8da9f036c43eb081095f1bf2141af..f1c6e9d8f61671e817bb417af39271dc14dd7bd9 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1152,7 +1152,7 @@ static void _bond_options_arp_ip_target_set(struct bonding *bond, int slot,
 
 	if (slot >= 0 && slot < BOND_MAX_ARP_TARGETS) {
 		bond_for_each_slave(bond, slave, iter)
-			slave->target_last_arp_rx[slot] = last_rx;
+			WRITE_ONCE(slave->target_last_arp_rx[slot], last_rx);
 		targets[slot] = target;
 	}
 }
@@ -1221,8 +1221,8 @@ static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target)
 	bond_for_each_slave(bond, slave, iter) {
 		targets_rx = slave->target_last_arp_rx;
 		for (i = ind; (i < BOND_MAX_ARP_TARGETS-1) && targets[i+1]; i++)
-			targets_rx[i] = targets_rx[i+1];
-		targets_rx[i] = 0;
+			WRITE_ONCE(targets_rx[i], READ_ONCE(targets_rx[i+1]));
+		WRITE_ONCE(targets_rx[i], 0);
 	}
 	for (i = ind; (i < BOND_MAX_ARP_TARGETS-1) && targets[i+1]; i++)
 		targets[i] = targets[i+1];
@@ -1377,7 +1377,7 @@ static void _bond_options_ns_ip6_target_set(struct bonding *bond, int slot,
 
 	if (slot >= 0 && slot < BOND_MAX_NS_TARGETS) {
 		bond_for_each_slave(bond, slave, iter) {
-			slave->target_last_arp_rx[slot] = last_rx;
+			WRITE_ONCE(slave->target_last_arp_rx[slot], last_rx);
 			slave_set_ns_maddr(bond, slave, target, &targets[slot]);
 		}
 		targets[slot] = *target;
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 49edc7da05867f355f880329817bdc2a371f226b..46207840355709ee28d771c803b8ee6ef8920538 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -521,13 +521,14 @@ static inline int bond_is_ip6_target_ok(struct in6_addr *addr)
 static inline unsigned long slave_oldest_target_arp_rx(struct bonding *bond,
 						       struct slave *slave)
 {
+	unsigned long tmp, ret = READ_ONCE(slave->target_last_arp_rx[0]);
 	int i = 1;
-	unsigned long ret = slave->target_last_arp_rx[0];
-
-	for (; (i < BOND_MAX_ARP_TARGETS) && bond->params.arp_targets[i]; i++)
-		if (time_before(slave->target_last_arp_rx[i], ret))
-			ret = slave->target_last_arp_rx[i];
 
+	for (; (i < BOND_MAX_ARP_TARGETS) && bond->params.arp_targets[i]; i++) {
+		tmp = READ_ONCE(slave->target_last_arp_rx[i]);
+		if (time_before(tmp, ret))
+			ret = tmp;
+	}
 	return ret;
 }
 
@@ -537,7 +538,7 @@ static inline unsigned long slave_last_rx(struct bonding *bond,
 	if (bond->params.arp_all_targets == BOND_ARP_TARGETS_ALL)
 		return slave_oldest_target_arp_rx(bond, slave);
 
-	return slave->last_rx;
+	return READ_ONCE(slave->last_rx);
 }
 
 static inline void slave_update_last_tx(struct slave *slave)
-- 
2.52.0.457.g6b5491de43-goog


