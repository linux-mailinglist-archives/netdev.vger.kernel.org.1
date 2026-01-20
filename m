Return-Path: <netdev+bounces-251524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDMaACS8b2kOMQAAu9opvQ
	(envelope-from <netdev+bounces-251524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:32:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE69489A7
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 896627EB948
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 15:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8863E480940;
	Tue, 20 Jan 2026 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VFsy/Rf8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2213480947
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922942; cv=none; b=sqwVUl5rHgZbvdWYFfZNY1sPEeVGPLqLaBMO8exlaqKiBMk+xAt+SHrXl16td0ucfNY0/v53didPVkMJrE8mitZNNyXMS0TD4bCY5BImmx0TLkgyXfWraiE1QUeputB9Xi/o7rZRWtqgRzlz2Rje16LiiKGQGiK06wiAMEtjtgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922942; c=relaxed/simple;
	bh=nbs5SUYLB2JBRRXqxOK6GxNwZBuTb0AWHBbLi9X1qLA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SQzXRGQVctGIe9Z48P3vmsC5O/PV86CF4oSC2lPNJTKwbxvkxqNZciFisLODQHgtT/gB7qDa5oJAYsM5N1E3FNKGUw3nhm8yRsDIs/SRRUb0SCmEn4Z6BgRzwJRaP1FTv6i0VQ4EPba3aovMkg/MgORD0od5Ef+fSkyJFuN9a8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VFsy/Rf8; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8887c0d3074so142132556d6.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 07:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768922938; x=1769527738; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o0bqIIfJ3y5B69fE7DZh2AoGI2oVIbSlq52qlebV/k8=;
        b=VFsy/Rf8HWYKw7S8/pegV+1GMdskk3vU4ong8qHlC5QRmI5DwtPUyfHwVMHKm7T5KT
         Spf03goSr2sFfhGocYXCxOb2HBSlBjTndwjAzkkifMJVh7dXx79YS2bY6Klq9dBqx/XC
         NSuf0W+pkPw6leFV8Ufz+nab3uA4jyiX/5AOYuHhLrpvhL5Ffq9XiiG3iNp4wdRimS0v
         C6vmWyZPu+p3YMXr4SumURmrdGqL9SGkBO4ew9FEYDyzHPA+K8yLncGYlAcYBK6TWSQo
         BzVnporRh3rKh6gBnPZU2p62wpQ4m+Ee9YdCvEPEGxcM0y/T3UosIAha8rKJGME3zTJz
         Wdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768922938; x=1769527738;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o0bqIIfJ3y5B69fE7DZh2AoGI2oVIbSlq52qlebV/k8=;
        b=olagTSjrJK5VhK8Wa4gjma5uucpsBtuycKAVMhtyZLWpRfKeKqXhWBnI0suAAo0eKW
         ub+iM1lPGQjaaxuT8YEF9pkJ9gINJqfcbWT44iVmkmcSwAOVJBqihRWnlJztwf7FhxiR
         sPQP0pfQqulEsjL5IZLDGQByGZQn6uXOLfj45JfDSEBhmJc/chw6qNw77u9OudYgVVmZ
         sS5Cky8wxf9OhhiS3zGgcaT+wlFX08dRGlknWFkVb35B6Pihg7mSigIqDPXE4NeEAebk
         LxxMm2xie0j9KLiiJNj1u7OX8QH1cnKOCMAOItoHqn+0xoYYs3RRTwrmR9veKyTNwIXV
         ZDCA==
X-Forwarded-Encrypted: i=1; AJvYcCW6oQUlMeGpJQEaJY0+WFbKu8FcLAK++YMcYJoO9iqaRPm8ANTXaGlubzZFDmj4G4BxWR6I+tY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuBmtPtEYoVZAe31uux5uB17OW/uRycqB98L19Mb3ue+XEK02Z
	C15gn9Rty51tYbDgqaFGsfI1xwVXYnWf25RZj6VlabRq+3QEmOowCbVc21sW6NbDqDIvo4/JdwB
	WwhuvWsIo96Smsg==
X-Received: from qvblr8.prod.google.com ([2002:a05:6214:5bc8:b0:882:2f2f:a04])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:1bc8:b0:892:6f12:608d with SMTP id 6a1803df08f44-8946390be79mr25800066d6.57.1768922938481;
 Tue, 20 Jan 2026 07:28:58 -0800 (PST)
Date: Tue, 20 Jan 2026 15:28:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260120152856.1694824-1-edumazet@google.com>
Subject: [PATCH net] bonding: annotate data-races around slave->last_rx
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251524-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,greyhouse.net,vger.kernel.org,google.com,googlegroups.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,googlegroups.com:email]
X-Rspamd-Queue-Id: 9AE69489A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/net/bonding/bond_main.c    | 18 ++++++++++--------
 drivers/net/bonding/bond_options.c |  2 +-
 include/net/bonding.h              | 13 +++++++------
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 0aca6c937297def91d5740dfd456800432b5e343..0ab400b870b4247cc64a698c2ad7961406cec82e 100644
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
index 384499c869b8da9f036c43eb081095f1bf2141af..74708bd2570ef1d09e8faa596c6064ad11ffb3a8 100644
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


