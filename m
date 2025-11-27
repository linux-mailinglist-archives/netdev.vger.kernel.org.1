Return-Path: <netdev+bounces-242109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0AEC8C672
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 01:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A103AEFAC
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 00:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9967F20311;
	Thu, 27 Nov 2025 00:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LW00lKRJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F788944F
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 00:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764202077; cv=none; b=pGv8SMI+Iph4cjMTdUPnblKTc/LcWFpU1bFdyiXwwF5xUf3w0nkSglTOMn0EhfFC7g0XCmhHrLBSSMZVIM7RRFECOxHp23pEPC4bh9PbIZXghIsV2wlBbWfBIsK/VUlVqPWgNSU+Q2je0LHqBG4zYqfiw4fFux3mNL2qW6jei4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764202077; c=relaxed/simple;
	bh=PVwqPtohHLQR8u+q6aeUNdyYbu/y4oRVcTilsjce+Ko=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AgcxMA+c5GPSNSvWTN1OXNDIR6KM+q9mUhrNU5xErpgv/CkqQ4bBZ6wkSbKSZyt6wjUXddPGVbjU5LRBQpXR70R+m4C4RFyqsOWRoQCOq6lKLh4MpyaW16hos2YVkvDhBafF85BhYhBs4RG6xBAJFUVFZtMilVy1lvJ37Mroyd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LW00lKRJ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7ae3e3e0d06so177310b3a.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 16:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764202075; x=1764806875; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dnKcf2+51kURgvBReSH5vkNuGQRyYKTVBdC22OlhFiE=;
        b=LW00lKRJCOD6broJZk7Pq8M2gSC4MrqhNlwmhzdH8V58SKBkpdSGZjmirZnoiui0tA
         m39d20pL1k0QwPXD8mdAZpKLiZC4tU2EYy0M8nidcJGMSVLT1Ft2cpgokAlLZnQZNLN1
         9WHKobmlfKz73kZyDrCVhC0ZlreDJdRtYeNpfLvxymPNdyPY22iu2bA1eJR85f6ce2V9
         6l2Za59AuQOtKv2Nl7q8cA/Vm7E3RQME6cQaAUDpFRSZjtMpFKp3/y09jMp9b1YALqe1
         qCguFzSnx/E43O7eXppws+5ImOFl8kLiPv1on5WJDq33pccHSy5KHmpEXzefVwVfQMsW
         zh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764202075; x=1764806875;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dnKcf2+51kURgvBReSH5vkNuGQRyYKTVBdC22OlhFiE=;
        b=J/MOLV+u8C9knw9nlNyaomwCSRIl0GX9t2VkmuQl2udwNQLoSrzqp4HJ7y9LLPystI
         Zuel72T7wwzeD/Di2EZ03+8jR/ikcoEhx6ouAo/1YB8xTHuA44trDeIa44bI3YSIS0SF
         zzfYg0sTtv6Xz+dduO8w/m+3cazwuwsY3JDkqrnax1WHvVXhMHMBnyrcDqrjzIcIOPDo
         hpvSiNRjKnjcHuR2mgoe5qWNXc7Y/YZfbR/ZyBfAqVpmU1EjzOTY9URWNo6zMHAgtT4I
         YwImRaAWOPdxDLG879MLb5JdVWO4oqvqYrw9+dFoO11dB8unk7id13ykPqbWL3qxobGg
         RYBQ==
X-Gm-Message-State: AOJu0Ywrf6xC2GysuY3WRTy6F3I947n4nVMXPUHZ8FlpzhMfyqEXcxS4
	Tx7eD1ZD+ubfZxa57o4htB3iRfkdwPiJXfbY8Zuq4wloAdzjUGybfXuyM0SicDFU+tEJu1c4N/R
	cnWAc2IARzvCJ8lq/xhbHzpq11QPyTiD/SsSwuSS+YHHcdAQ/1o0lpSLFUnnDg4XiwgX6OQyuyF
	xY/hYmvUBQ4oNZL425DGtH52NHHmwfgAOtf9SkeHEDuUnP5XeLNrg0+Hrs7Rr3iNo=
X-Google-Smtp-Source: AGHT+IGnhmhMCtW2cqlbfM3z72gA3XlXtWRfaLc1b3OcMPSW0COKY++7leT3iMEM1SYLmLlnoSD7fB5Ar+eIczA8Pg==
X-Received: from pfbfx22.prod.google.com ([2002:a05:6a00:8216:b0:7cf:2dad:ff8d])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:9508:b0:7aa:93d5:820f with SMTP id d2e1a72fcca58-7c58e9f97bcmr22294145b3a.30.1764202075226;
 Wed, 26 Nov 2025 16:07:55 -0800 (PST)
Date: Thu, 27 Nov 2025 00:07:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251127000751.662959-1-hramamurthy@google.com>
Subject: [PATCH net-next] gve: Fix race condition on tx->dropped_pkt update
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, pkaligineedi@google.com, linux-kernel@vger.kernel.org, 
	Max Yuan <maxyuan@google.com>, Jordan Rhee <jordanrhee@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Max Yuan <maxyuan@google.com>

The tx->dropped_pkt counter is a 64-bit integer that is incremented
directly. On 32-bit architectures, this operation is not atomic and
can lead to read/write tearing if a reader accesses the counter during
the update. This can result in incorrect values being reported for
dropped packets.

To prevent this potential data corruption, wrap the increment
operation with u64_stats_update_begin() and u64_stats_update_end().
This ensures that updates to the 64-bit counter are atomic, even on
32-bit systems, by using a sequence lock.

The u64_stats_sync API requires the writer to have exclusive access,
which is already provided in this context by the network stack's
serialization of the transmit path (net_device_ops::ndo_start_xmit
[1]) for a given queue.

[1]: https://www.kernel.org/doc/Documentation/networking/netdevices.txt

Signed-off-by: Max Yuan <maxyuan@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_tx.c     | 2 ++
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
index c6ff0968929d..97efc8d27e6f 100644
--- a/drivers/net/ethernet/google/gve/gve_tx.c
+++ b/drivers/net/ethernet/google/gve/gve_tx.c
@@ -730,7 +730,9 @@ static int gve_tx_add_skb_no_copy(struct gve_priv *priv, struct gve_tx_ring *tx,
 		gve_tx_unmap_buf(tx->dev, &tx->info[idx & tx->mask]);
 	}
 drop:
+	u64_stats_update_begin(&tx->statss);
 	tx->dropped_pkt++;
+	u64_stats_update_end(&tx->statss);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 6f1d515673d2..40b89b3e5a31 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -1002,7 +1002,9 @@ static int gve_try_tx_skb(struct gve_priv *priv, struct gve_tx_ring *tx,
 	return 0;
 
 drop:
+	u64_stats_update_begin(&tx->statss);
 	tx->dropped_pkt++;
+	u64_stats_update_end(&tx->statss);
 	dev_kfree_skb_any(skb);
 	return 0;
 }
@@ -1324,7 +1326,11 @@ static void remove_miss_completions(struct gve_priv *priv,
 		/* This indicates the packet was dropped. */
 		dev_kfree_skb_any(pending_packet->skb);
 		pending_packet->skb = NULL;
+
+		u64_stats_update_begin(&tx->statss);
 		tx->dropped_pkt++;
+		u64_stats_update_end(&tx->statss);
+
 		net_err_ratelimited("%s: No reinjection completion was received for: %d.\n",
 				    priv->dev->name,
 				    (int)(pending_packet - tx->dqo.pending_packets));
-- 
2.52.0.487.g5c8c507ade-goog


