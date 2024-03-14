Return-Path: <netdev+bounces-79989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FA087C558
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 23:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F82282D6F
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 22:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FA1DDDA;
	Thu, 14 Mar 2024 22:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JRn3z+Ce"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00366DDB7
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 22:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710456572; cv=none; b=Z3DtRiVEy24/WDIcTgS2iswaAYXKMD7dF9sDZLjsuckWJUvgEaC+sy3M3Cs55xzmfQga4u7D0pid+purbHLYBpYRjoh/wwrEV+mb97dQv/2FKFhwH58QiDdJ87bszGavYbCK9oBWrulL7KQVxa4wmKD/aoJpBzmyF/PF0Grj7+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710456572; c=relaxed/simple;
	bh=kDEsIrg6Nol8QzsT5eioSka1ZUvLJR8G3JUJXLZ4YSE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GT4+zXplH3k8+Bg+pPncNnsEErsqaaGXYKn6STXChiNHckhEF5cBWNzDqzdYQZznpejfBHdEPRYbAX4bctpDpSf3HGPFnkdsaZwLQJu+MMmc/DqEayk2BUOqzAw87ye9RUcDAjDHSFJGFx+fXvgh+svVFAu3V2m/FT22kQcEd5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=JRn3z+Ce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B38CC43394;
	Thu, 14 Mar 2024 22:49:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JRn3z+Ce"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1710456569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R9TXL22rgEgfNPNTOX7FofZ4jip3awg0IVdEpjuRqRM=;
	b=JRn3z+Ce5bxY2eZf3mbQ1XFjJ3RbnuHC0exfBSZEvRl+v9IBJpzMdVTzVkILsOTbTllghx
	oYxct13qriayhp6gwiFG4D1hqiQ0IwLecS1ziv0WplBADn1zvmT9nhagdrKSG5VOwHOndw
	tB+mlbt3xVqSB4jFvfeWu9lt1+zKmMc=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bcf8cf5e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Mar 2024 22:49:29 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org
Subject: [PATCH net 1/6] wireguard: receive: annotate data-race around receiving_counter.counter
Date: Thu, 14 Mar 2024 16:49:06 -0600
Message-ID: <20240314224911.6653-2-Jason@zx2c4.com>
In-Reply-To: <20240314224911.6653-1-Jason@zx2c4.com>
References: <20240314224911.6653-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

Syzkaller with KCSAN identified a data-race issue when accessing
keypair->receiving_counter.counter. Use READ_ONCE() and WRITE_ONCE()
annotations to mark the data race as intentional.

    BUG: KCSAN: data-race in wg_packet_decrypt_worker / wg_packet_rx_poll

    write to 0xffff888107765888 of 8 bytes by interrupt on cpu 0:
     counter_validate drivers/net/wireguard/receive.c:321 [inline]
     wg_packet_rx_poll+0x3ac/0xf00 drivers/net/wireguard/receive.c:461
     __napi_poll+0x60/0x3b0 net/core/dev.c:6536
     napi_poll net/core/dev.c:6605 [inline]
     net_rx_action+0x32b/0x750 net/core/dev.c:6738
     __do_softirq+0xc4/0x279 kernel/softirq.c:553
     do_softirq+0x5e/0x90 kernel/softirq.c:454
     __local_bh_enable_ip+0x64/0x70 kernel/softirq.c:381
     __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:167 [inline]
     _raw_spin_unlock_bh+0x36/0x40 kernel/locking/spinlock.c:210
     spin_unlock_bh include/linux/spinlock.h:396 [inline]
     ptr_ring_consume_bh include/linux/ptr_ring.h:367 [inline]
     wg_packet_decrypt_worker+0x6c5/0x700 drivers/net/wireguard/receive.c:499
     process_one_work kernel/workqueue.c:2633 [inline]
     ...

    read to 0xffff888107765888 of 8 bytes by task 3196 on cpu 1:
     decrypt_packet drivers/net/wireguard/receive.c:252 [inline]
     wg_packet_decrypt_worker+0x220/0x700 drivers/net/wireguard/receive.c:501
     process_one_work kernel/workqueue.c:2633 [inline]
     process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2706
     worker_thread+0x525/0x730 kernel/workqueue.c:2787
     ...

Fixes: a9e90d9931f3 ("wireguard: noise: separate receive counter from send counter")
Reported-by: syzbot+d1de830e4ecdaac83d89@syzkaller.appspotmail.com
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/receive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/receive.c
index df275b4fccb6..eb8851113654 100644
--- a/drivers/net/wireguard/receive.c
+++ b/drivers/net/wireguard/receive.c
@@ -251,7 +251,7 @@ static bool decrypt_packet(struct sk_buff *skb, struct noise_keypair *keypair)
 
 	if (unlikely(!READ_ONCE(keypair->receiving.is_valid) ||
 		  wg_birthdate_has_expired(keypair->receiving.birthdate, REJECT_AFTER_TIME) ||
-		  keypair->receiving_counter.counter >= REJECT_AFTER_MESSAGES)) {
+		  READ_ONCE(keypair->receiving_counter.counter) >= REJECT_AFTER_MESSAGES)) {
 		WRITE_ONCE(keypair->receiving.is_valid, false);
 		return false;
 	}
@@ -318,7 +318,7 @@ static bool counter_validate(struct noise_replay_counter *counter, u64 their_cou
 		for (i = 1; i <= top; ++i)
 			counter->backtrack[(i + index_current) &
 				((COUNTER_BITS_TOTAL / BITS_PER_LONG) - 1)] = 0;
-		counter->counter = their_counter;
+		WRITE_ONCE(counter->counter, their_counter);
 	}
 
 	index &= (COUNTER_BITS_TOTAL / BITS_PER_LONG) - 1;
@@ -463,7 +463,7 @@ int wg_packet_rx_poll(struct napi_struct *napi, int budget)
 			net_dbg_ratelimited("%s: Packet has invalid nonce %llu (max %llu)\n",
 					    peer->device->dev->name,
 					    PACKET_CB(skb)->nonce,
-					    keypair->receiving_counter.counter);
+					    READ_ONCE(keypair->receiving_counter.counter));
 			goto next;
 		}
 
-- 
2.44.0


