Return-Path: <netdev+bounces-125102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB4896BEBE
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E2A288596
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529971DA626;
	Wed,  4 Sep 2024 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MitQCgco"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDCB1922CF
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457049; cv=none; b=pdCMDeoOidKzJSRPsaEL76lEvmfLnP1UHbvB7P8L0obl+NUZCntq59zOL6DTF4r1qJC5DNwRFns6/k5GN7DCqZs7gF3ftnsjCwbpVk0FN+NVjMV6hApfhZmFox7ARpWO0IG9klAXBqx/3KAq7nKUhqVlu5qJVwD9yxRY4TqsfoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457049; c=relaxed/simple;
	bh=zMGAX8BxLsmpWre/epUq3h3imtWn36sCqy+2nW8+3Jw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dma9Jkjk+aYVNe1XuQNuZUYuvyBrtYq/R/Wpmf8QyXGn13L61yTjB/ytgeBEZ9+b4Fiaa6vIlaP0jVXHjge5IryTw+g7VVlq5KWPhWdGSoaaXklelWj04VBeI1jBLdzypy8SBooguOyqIEgI63tWMfsfwxsHKNd2gN1eRZ0X82k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MitQCgco; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d470831e3aso112483707b3.3
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 06:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725457046; x=1726061846; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JmMIVb+8SAYGK1kyzBa9TG18gbWHU7Lncb2+NTsd5xU=;
        b=MitQCgcoNj/CzxAGbB06qQKR9TBqkNNJ8POeVsPNZ3eHeIS8197rOzkNUO5IE7bK7r
         1cJuzsZSwMlPX5HawDunGOOHw1Fhkl4gZmZP2NWQDqTCHUhnWh/W3RJd3KVJ5MitfGW0
         nigT6LC3s51VkI+diKuq0PuK2j1utxCL7y/mAyUhxiUAZL+rKyGgzlw8lcHN59IPGjQQ
         9c/Lw6NqBZhYdTDLtWzrcuMnqVIUkHc5jlYXERGlf9vQMdjZGeotrkW6Vgwpv+uStIBg
         4YMnFe21W855QKAP5dCfCAEqSXBaO1eTCWQ7m0XlqoKtnOdp47YjvHXs2BBnk49qoBll
         FBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725457046; x=1726061846;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JmMIVb+8SAYGK1kyzBa9TG18gbWHU7Lncb2+NTsd5xU=;
        b=nOMRm4XXgtnkOAxhlxyIoXKSzhQvDHWOfMLOKmuys0IWHLR8PIVUDGrwPXtWf8/ASJ
         ucBRTuPDAGaNOJpkMatwurJxDSB3CVW0VdpEAkS9IEnSUz50vVCuw7T4yrd/w/x0XJa9
         4OBQP/n+RTAfmZBi7yg7i0U13pbFD/tjGMoWayjvp6WVwd+lUDOmUUmCytuccdZYI6d2
         6xG/RGxk/X6Vz2Cvjv83Y5Ixu+5a+klc63k6VJRdMB8b1/unnNjaYwbh1AW3CNH7HZfv
         YRA3C8yMIumNqTtq3JukeapX+HhCSuukS8v3t0dmQHvkbci3ZaOv9tIv5QzdNCPZ8I9P
         kKiQ==
X-Gm-Message-State: AOJu0Yw45Nqu6ov7z2GB+vm0a/PjGEH3iyderuucimimyfqvu6Q+iPQ+
	1C0St0XkpxtOcp22N/I9x75AP5XJCrF2vjCjvTu+TurQ/qvhrQcCb3/jvZIo+GMjSZdSOYHYM4x
	8oui3CTV+fA==
X-Google-Smtp-Source: AGHT+IElNp/uEe5I2A5SB6FTmEONiwzuHk1FqmkE6FLfQyFugvcEZWTr81oPqfA61umadbn09FyZMZKbAf9t0w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:a07:b0:64a:d1b0:4f24 with SMTP
 id 00721157ae682-6d40fe13279mr7555297b3.7.1725457046458; Wed, 04 Sep 2024
 06:37:26 -0700 (PDT)
Date: Wed,  4 Sep 2024 13:37:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240904133725.1073963-1-edumazet@google.com>
Subject: [PATCH net] net: hsr: remove seqnr_lock
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

syzbot found a new splat [1].

Instead of adding yet another spin_lock_bh(&hsr->seqnr_lock) /
spin_unlock_bh(&hsr->seqnr_lock) pair, remove seqnr_lock
and use atomic_t for hsr->sequence_nr and hsr->sup_sequence_nr.

This also avoid a race in hsr_fill_info().

Also remove interlink_sequence_nr which is unused.

[1]
 WARNING: CPU: 1 PID: 9723 at net/hsr/hsr_forward.c:602 handle_std_frame+0x247/0x2c0 net/hsr/hsr_forward.c:602
Modules linked in:
CPU: 1 UID: 0 PID: 9723 Comm: syz.0.1657 Not tainted 6.11.0-rc6-syzkaller-00026-g88fac17500f4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
 RIP: 0010:handle_std_frame+0x247/0x2c0 net/hsr/hsr_forward.c:602
Code: 49 8d bd b0 01 00 00 be ff ff ff ff e8 e2 58 25 00 31 ff 89 c5 89 c6 e8 47 53 a8 f6 85 ed 0f 85 5a ff ff ff e8 fa 50 a8 f6 90 <0f> 0b 90 e9 4c ff ff ff e8 cc e7 06 f7 e9 8f fe ff ff e8 52 e8 06
RSP: 0018:ffffc90000598598 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffc90000598670 RCX: ffffffff8ae2c919
RDX: ffff888024e94880 RSI: ffffffff8ae2c926 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
R13: ffff8880627a8cc0 R14: 0000000000000000 R15: ffff888012b03c3a
FS:  0000000000000000(0000) GS:ffff88802b700000(0063) knlGS:00000000f5696b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000020010000 CR3: 00000000768b4000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
  hsr_fill_frame_info+0x2c8/0x360 net/hsr/hsr_forward.c:630
  fill_frame_info net/hsr/hsr_forward.c:700 [inline]
  hsr_forward_skb+0x7df/0x25c0 net/hsr/hsr_forward.c:715
  hsr_handle_frame+0x603/0x850 net/hsr/hsr_slave.c:70
  __netif_receive_skb_core.constprop.0+0xa3d/0x4330 net/core/dev.c:5555
  __netif_receive_skb_list_core+0x357/0x950 net/core/dev.c:5737
  __netif_receive_skb_list net/core/dev.c:5804 [inline]
  netif_receive_skb_list_internal+0x753/0xda0 net/core/dev.c:5896
  gro_normal_list include/net/gro.h:515 [inline]
  gro_normal_list include/net/gro.h:511 [inline]
  napi_complete_done+0x23f/0x9a0 net/core/dev.c:6247
  gro_cell_poll+0x162/0x210 net/core/gro_cells.c:66
  __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:6772
  napi_poll net/core/dev.c:6841 [inline]
  net_rx_action+0xa92/0x1010 net/core/dev.c:6963
  handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
  do_softirq kernel/softirq.c:455 [inline]
  do_softirq+0xb2/0xf0 kernel/softirq.c:442
 </IRQ>
 <TASK>

Fixes: 06afd2c31d33 ("hsr: Synchronize sending frames to have always incremented outgoing seq nr.")
Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/hsr/hsr_device.c  | 35 ++++++++++-------------------------
 net/hsr/hsr_forward.c |  4 +---
 net/hsr/hsr_main.h    |  6 ++----
 net/hsr/hsr_netlink.c |  2 +-
 4 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index e4cc6b78dcfc40643ad386780573a53dd089bb54..ac56784c327c0293fef13e3ecfa9fc32ca1ab839 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -231,9 +231,7 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		skb->dev = master->dev;
 		skb_reset_mac_header(skb);
 		skb_reset_mac_len(skb);
-		spin_lock_bh(&hsr->seqnr_lock);
 		hsr_forward_skb(skb, master);
-		spin_unlock_bh(&hsr->seqnr_lock);
 	} else {
 		dev_core_stats_tx_dropped_inc(dev);
 		dev_kfree_skb_any(skb);
@@ -314,14 +312,10 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
 	set_hsr_stag_HSR_ver(hsr_stag, hsr->prot_version);
 
 	/* From HSRv1 on we have separate supervision sequence numbers. */
-	spin_lock_bh(&hsr->seqnr_lock);
-	if (hsr->prot_version > 0) {
-		hsr_stag->sequence_nr = htons(hsr->sup_sequence_nr);
-		hsr->sup_sequence_nr++;
-	} else {
-		hsr_stag->sequence_nr = htons(hsr->sequence_nr);
-		hsr->sequence_nr++;
-	}
+	if (hsr->prot_version > 0)
+		hsr_stag->sequence_nr = htons(atomic_inc_return(&hsr->sup_sequence_nr));
+	else
+		hsr_stag->sequence_nr = htons(atomic_inc_return(&hsr->sequence_nr));
 
 	hsr_stag->tlv.HSR_TLV_type = type;
 	/* TODO: Why 12 in HSRv0? */
@@ -343,13 +337,11 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
 		ether_addr_copy(hsr_sp->macaddress_A, hsr->macaddress_redbox);
 	}
 
-	if (skb_put_padto(skb, ETH_ZLEN)) {
-		spin_unlock_bh(&hsr->seqnr_lock);
+	if (skb_put_padto(skb, ETH_ZLEN))
 		return;
-	}
 
 	hsr_forward_skb(skb, port);
-	spin_unlock_bh(&hsr->seqnr_lock);
+
 	return;
 }
 
@@ -374,9 +366,7 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 	set_hsr_stag_HSR_ver(hsr_stag, (hsr->prot_version ? 1 : 0));
 
 	/* From HSRv1 on we have separate supervision sequence numbers. */
-	spin_lock_bh(&hsr->seqnr_lock);
-	hsr_stag->sequence_nr = htons(hsr->sup_sequence_nr);
-	hsr->sup_sequence_nr++;
+	hsr_stag->sequence_nr = htons(atomic_inc_return(&hsr->sup_sequence_nr));
 	hsr_stag->tlv.HSR_TLV_type = PRP_TLV_LIFE_CHECK_DD;
 	hsr_stag->tlv.HSR_TLV_length = sizeof(struct hsr_sup_payload);
 
@@ -384,13 +374,10 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 	hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
 	ether_addr_copy(hsr_sp->macaddress_A, master->dev->dev_addr);
 
-	if (skb_put_padto(skb, ETH_ZLEN)) {
-		spin_unlock_bh(&hsr->seqnr_lock);
+	if (skb_put_padto(skb, ETH_ZLEN))
 		return;
-	}
 
 	hsr_forward_skb(skb, master);
-	spin_unlock_bh(&hsr->seqnr_lock);
 }
 
 /* Announce (supervision frame) timer function
@@ -621,11 +608,9 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 	if (res < 0)
 		return res;
 
-	spin_lock_init(&hsr->seqnr_lock);
 	/* Overflow soon to find bugs easier: */
-	hsr->sequence_nr = HSR_SEQNR_START;
-	hsr->sup_sequence_nr = HSR_SUP_SEQNR_START;
-	hsr->interlink_sequence_nr = HSR_SEQNR_START;
+	atomic_set(&hsr->sequence_nr, HSR_SEQNR_START);
+	atomic_set(&hsr->sup_sequence_nr, HSR_SUP_SEQNR_START);
 
 	timer_setup(&hsr->announce_timer, hsr_announce, 0);
 	timer_setup(&hsr->prune_timer, hsr_prune_nodes, 0);
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index b38060246e62e8a8d94d78d32a530e3820e752a1..6f63c8a775c41195c7cde5b27c83ffb91733d5c8 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -599,9 +599,7 @@ static void handle_std_frame(struct sk_buff *skb,
 	if (port->type == HSR_PT_MASTER ||
 	    port->type == HSR_PT_INTERLINK) {
 		/* Sequence nr for the master/interlink node */
-		lockdep_assert_held(&hsr->seqnr_lock);
-		frame->sequence_nr = hsr->sequence_nr;
-		hsr->sequence_nr++;
+		frame->sequence_nr = atomic_inc_return(&hsr->sequence_nr);
 	}
 }
 
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index ab1f8d35d9dcf507f0b2f90b0cede6dd24a51f2a..6f7bbf01f3e4f3033446860fb584402cb81df336 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -202,11 +202,9 @@ struct hsr_priv {
 	struct timer_list	prune_timer;
 	struct timer_list	prune_proxy_timer;
 	int announce_count;
-	u16 sequence_nr;
-	u16 interlink_sequence_nr; /* Interlink port seq_nr */
-	u16 sup_sequence_nr;	/* For HSRv1 separate seq_nr for supervision */
+	atomic_t sequence_nr;
+	atomic_t sup_sequence_nr;	/* For HSRv1 separate seq_nr for supervision */
 	enum hsr_version prot_version;	/* Indicate if HSRv0, HSRv1 or PRPv1 */
-	spinlock_t seqnr_lock;	/* locking for sequence_nr */
 	spinlock_t list_lock;	/* locking for node list */
 	struct hsr_proto_ops	*proto_ops;
 #define PRP_LAN_ID	0x5     /* 0x1010 for A and 0x1011 for B. Bit 0 is set
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index f6ff0b61e08a966254625ad13fd3b97e99329cf7..8aea4ff5f49e305555773e6e8cc7be570f946ada 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -163,7 +163,7 @@ static int hsr_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 	if (nla_put(skb, IFLA_HSR_SUPERVISION_ADDR, ETH_ALEN,
 		    hsr->sup_multicast_addr) ||
-	    nla_put_u16(skb, IFLA_HSR_SEQ_NR, hsr->sequence_nr))
+	    nla_put_u16(skb, IFLA_HSR_SEQ_NR, atomic_read(&hsr->sequence_nr)))
 		goto nla_put_failure;
 	if (hsr->prot_version == PRP_V1)
 		proto = HSR_PROTOCOL_PRP;
-- 
2.46.0.469.g59c65b2a67-goog


