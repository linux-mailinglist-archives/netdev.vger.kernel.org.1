Return-Path: <netdev+bounces-135867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEDC99F76A
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 21:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D210C28493C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3299B1B6D07;
	Tue, 15 Oct 2024 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="22Mj0xz6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93863176228
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729021282; cv=none; b=W6mnXOy8qA548KzXBKhgwVbNtPaSCJMrLmMkgPHsGCxIgA4NYxNl5zKto5jPQXQhZ8WGRKWBkU33RCWnJMBthps9CGEIZMRKTUkCL6AZOK19ZRtpO6CJgX6OnN2/WaRuPIbolxPmGZoxlHjmwRAygFPa2WehwXu6GlolwFYAKQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729021282; c=relaxed/simple;
	bh=u1nHyn49z3Ie5rS+Gise21zMxOIyqdyakEmeJXIMqOI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=L2bJcW4DTZ6DPXaRd1Nb6gZN9Q5cJ03U8NMmcbKAAXn12R32IegRgEu1WUrVc9x/R6spne13KAIfR9Yiz9cBotfJc7MNx5GenHMzJRrMJsq7/VcvVZLOcc7ZUaGDmpXGl8PcngJQIL2WldD/BsW/FeG96U66b/ppATGjRD/dhFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=22Mj0xz6; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e293b3e014aso4478223276.3
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 12:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729021279; x=1729626079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C34RbrV5RscxnInxdbsFU69/amtxycWH9NlU+nUp1Z8=;
        b=22Mj0xz6s+Dv83RU5Y22m5AK8wPwl1WqN5bWvjp2wuY3ncZRBRpZl1T0mTARVzn+Gp
         1ExDpqBs4f4TvnuVz6lJHKTnfRITNMU9xSNtQjwKbLCwAX/TIVs/E1T1PelIOPnEKj6S
         Gyln7bshp8yc73Z5f++RYVk/naF0bsLaxCZ/e8KZcGXAQa1f608eMzgXf6m/smKcG0he
         gdSA4kCdLvpwqJ4Sj8IyJu1xnm2Lh5tQZH3gfIZNYPVHw90yoyeg9H2M/4xQUdBCEJro
         3oGTf8EwWplAQfFloLmxZboRCgmk00pCUeI/e5p7qW35xFk28FIeWXg+fpoxCItOYwmS
         hLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729021279; x=1729626079;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C34RbrV5RscxnInxdbsFU69/amtxycWH9NlU+nUp1Z8=;
        b=rQ9vWVyF+9inFLYzBG9TP8psAC+Tn/acMWVymNv7H8kO68/vkADws0PekkV+C20/DF
         M4BHtM4r9GoEx1uxCLtstGMWXaK0q3T4mMezsRl/uJWY6Bfm3zBDTnQiD9JaOtxA4JVG
         sdhB7+YgaQG3htChNVjOyOZqI6ROO2/5kGpXP/bxc8PpB/OGd+bzSY7nDFJNACWuVv1R
         M1cPwoGrkmqRwpfc9Puf4CXuhcjS2y2egKtHZ9+ChrWsRVgdSgQJGtid8wB4YQkeGoJQ
         2Dgw4rHgo/QGBiJopNFFp5BDBMsAY0KjNx4/b6yFHXL0VAujPsKxKgua5jSigUg7zU9c
         3Oxg==
X-Gm-Message-State: AOJu0YwLKZmKMbNG5umeGj2VJhy2bSNu7xBtWLVhI+MoQ3E16HcpEgbP
	yl6A7FeaQQC7ceCaIXGds8riIernWz7DrCJne4AZoaeIaWd2ObeIEkG9POLJSRomH4BZW9oj7eF
	HBRlaUNl8wA==
X-Google-Smtp-Source: AGHT+IH0KYLLRcgWYYR3/EZ4z3kKcrbdpo0VOTZAsL7EgzGr3Uqzx8AfHEw+VLoX40yHrf7mtRFxSc3+GYVZNQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:9702:0:b0:e28:e510:6ab1 with SMTP id
 3f1490d57ef6-e297857f673mr671276.8.1729021279389; Tue, 15 Oct 2024 12:41:19
 -0700 (PDT)
Date: Tue, 15 Oct 2024 19:41:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015194118.3951657-1-edumazet@google.com>
Subject: [PATCH net] net: fix races in netdev_tx_sent_queue()/dev_watchdog()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Some workloads hit the infamous dev_watchdog() message:

"NETDEV WATCHDOG: eth0 (xxxx): transmit queue XX timed out"

It seems possible to hit this even for perfectly normal
BQL enabled drivers:

1) Assume a TX queue was idle for more than dev->watchdog_timeo
   (5 seconds unless changed by the driver)

2) Assume a big packet is sent, exceeding current BQL limit.

3) Driver ndo_start_xmit() puts the packet in TX ring,
   and netdev_tx_sent_queue() is called.

4) QUEUE_STATE_STACK_XOFF could be set from netdev_tx_sent_queue()
   before txq->trans_start has been written.

5) txq->trans_start is written later, from netdev_start_xmit()

    if (rc == NETDEV_TX_OK)
          txq_trans_update(txq)

dev_watchdog() running on another cpu could read the old
txq->trans_start, and then see QUEUE_STATE_STACK_XOFF, because 5)
did not happen yet.

To solve the issue, write txq->trans_start right before one XOFF bit
is set :

- _QUEUE_STATE_DRV_XOFF from netif_tx_stop_queue()
- __QUEUE_STATE_STACK_XOFF from netdev_tx_sent_queue()

From dev_watchdog(), we have to read txq->state before txq->trans_start.

Add memory barriers to enforce correct ordering.

In the future, we could avoid writing over txq->trans_start for normal
operations, and rename this field to txq->xoff_start_time.

Fixes: bec251bc8b6a ("net: no longer stop all TX queues in dev_watchdog()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h | 12 ++++++++++++
 net/sched/sch_generic.c   |  8 +++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 4d20c776a4ff3d0e881b8d9b99901edb35f66da2..8896705ccd638bcb7d2ca8f3905351fc823f71b8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3325,6 +3325,12 @@ static inline void netif_tx_wake_all_queues(struct net_device *dev)
 
 static __always_inline void netif_tx_stop_queue(struct netdev_queue *dev_queue)
 {
+	/* Paired with READ_ONCE() from dev_watchdog() */
+	WRITE_ONCE(dev_queue->trans_start, jiffies);
+
+	/* This barrier is paired with smp_mb() from dev_watchdog() */
+	smp_mb__before_atomic();
+
 	/* Must be an atomic op see netif_txq_try_stop() */
 	set_bit(__QUEUE_STATE_DRV_XOFF, &dev_queue->state);
 }
@@ -3451,6 +3457,12 @@ static inline void netdev_tx_sent_queue(struct netdev_queue *dev_queue,
 	if (likely(dql_avail(&dev_queue->dql) >= 0))
 		return;
 
+	/* Paired with READ_ONCE() from dev_watchdog() */
+	WRITE_ONCE(dev_queue->trans_start, jiffies);
+
+	/* This barrier is paired with smp_mb() from dev_watchdog() */
+	smp_mb__before_atomic();
+
 	set_bit(__QUEUE_STATE_STACK_XOFF, &dev_queue->state);
 
 	/*
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 2af24547a82c49efc64528fd27087144c4f43b7c..38ec18f73de43aed565c653fffb838f54e7c824b 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -512,9 +512,15 @@ static void dev_watchdog(struct timer_list *t)
 				struct netdev_queue *txq;
 
 				txq = netdev_get_tx_queue(dev, i);
-				trans_start = READ_ONCE(txq->trans_start);
 				if (!netif_xmit_stopped(txq))
 					continue;
+
+				/* Paired with WRITE_ONCE() + smp_mb...() in
+				 * netdev_tx_sent_queue() and netif_tx_stop_queue().
+				 */
+				smp_mb();
+				trans_start = READ_ONCE(txq->trans_start);
+
 				if (time_after(jiffies, trans_start + dev->watchdog_timeo)) {
 					timedout_ms = jiffies_to_msecs(jiffies - trans_start);
 					atomic_long_inc(&txq->trans_timeout);
-- 
2.47.0.rc1.288.g06298d1525-goog


