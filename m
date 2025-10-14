Return-Path: <netdev+bounces-229000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94065BD6E49
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 02:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 597D74E20A7
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 00:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C8E1F4297;
	Tue, 14 Oct 2025 00:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ub3/bYSR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E03C1E8337
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 00:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760402865; cv=none; b=R7xc+m9f5C3iDHZ333kfmRTTiEexsnivn34PhVGVXsZZmOh7J1T5i7yathhlioAbpN+Nym6niEPR6kn+UOms4bcN8RwoHrRbq50G4g6DSO1RLlouEUMj7yjL3LcP8LfPZOlBM4XRKbFlIv/VsQGS6AG9C9DY4KthD0FXrE+yFQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760402865; c=relaxed/simple;
	bh=4j/wr+NV+OGjyjc0tgLHhsWamrVErlfeEpEf5fc81rQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FV3n1E3TUFpFvRfFDyIU8HKCREFDZlhK2g4LGnhFrPohgWH4xwh6nWgbzG8HOUAQ0jutNLSjdsjNlEASN/oHl/OEhR0a9aneQow69G4h+cIcQfo3rUboOZQ8ZMZgSoX8uXcYJMdEh5DIuoJTqsymjCZA76qrrS/EA9lZZUWBYVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ub3/bYSR; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27c62320f16so103652335ad.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 17:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760402863; x=1761007663; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aSVYxs6AJZm83SaX9b/VllgChCtMo/ExnUJyejp3mZI=;
        b=ub3/bYSRcUvNCxfhF85wWSuaKCgHzCDd0kX2G0VoPKwW04y3uuUAD717djY44uwNBY
         zAfchIfbzTGtenEv16MhtWg6SAVXrVhvCdBIDDMX4EqLOOvy2oDLfCNAELLl19+u/FCL
         rkAKRJAopp74l/EG8NCCL/5YijxTfCjkN47owe6oeF7XGnY/iZ/cBhwv398/ivVDaYhw
         K3zc+k33L1/qjGkXBA4WIrLPkJNXV89Fry0xG6oYBwbCVBvcLHE1aWf0X0GIA0eYalQW
         9surBszJBFG7tK7tXH3MJx/yGnLLaxeflPZKOBpR5BRapBLn5+jDlg49O7YsDsTUJElG
         vtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760402863; x=1761007663;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aSVYxs6AJZm83SaX9b/VllgChCtMo/ExnUJyejp3mZI=;
        b=eEU9tLCdCIa83p5dpi9Pf1ZurJizKqhwiKHG9vKdmOfKp+32CzP01/tsj5cHi5QdIS
         qnxQHy0PiEJlhmDSiP4EzhWab+qhKXh3uggQviRsYEJ0jOXRWcKACLadDFRtI51qSz3r
         Fqe5rzGdt6V+8k2zUinpZMR0eIscQHJoHpRt5l/JU+ZcGDFwkK+Y0Uwz4eDsHMs5I1Yp
         qsqEPQjwXitoa129Bf9W/58QMn+gzXeH5vmM4KW+4eTsnSWCj2FBO7vBg+8hAJlJHlLC
         qZcEJvNsViIOQEl0tpSUtcPGu20c0Z3l26X0812boJkMnMlIIAqHngm2pxY4m8J8d5Fe
         k+vw==
X-Gm-Message-State: AOJu0YwrewBvTlIa3vZQXkUQy8vTwMNk4ls0oBfY+QHHImI6jm4hW8zc
	NGYmPLt70WpOtJ82ecmLi9zEutZO2R/lJiuyV5D5EIvb2/8TX66p+FCvzZo8QZneQos5lGsaNse
	toBJNO3eD6IWIoU2dnoc2HzgtHhdgE/kfa+y4lx3bELHiWTC3d4TShFQqzb4II8Iqq7IzZaPR/K
	OOIlbcYjusLINO58DcDysbFmBlfyQodWaD18MpEkU3r+PQY7Rclt2vpHskRgYF6Zs=
X-Google-Smtp-Source: AGHT+IHBTD15jMQtH8/mEKSxIA6jN/9InByyjygOexw4uv4P27BlVue30aW7yBjsu+DPqjHAAiQvURuwJNBVdd8BMQ==
X-Received: from plbiz23.prod.google.com ([2002:a17:902:ef97:b0:269:607f:f138])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:384d:b0:25b:f1f3:815f with SMTP id d9443c01a7336-290272ff7cfmr251025405ad.58.1760402863383;
 Mon, 13 Oct 2025 17:47:43 -0700 (PDT)
Date: Tue, 14 Oct 2025 00:47:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.760.g7b8bcc2412-goog
Message-ID: <20251014004740.2775957-1-hramamurthy@google.com>
Subject: [PATCH net] gve: Check valid ts bit on RX descriptor before hw timestamping
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, pkaligineedi@google.com, jfraker@google.com, 
	ziweixiao@google.com, thostet@google.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Tim Hostetler <thostet@google.com>

The device returns a valid bit in the LSB of the low timestamp byte in
the completion descriptor that the driver should check before
setting the SKB's hardware timestamp. If the timestamp is not valid, do not
hardware timestamp the SKB.

Cc: stable@vger.kernel.org
Fixes: b2c7aeb49056 ("gve: Implement ndo_hwtstamp_get/set for RX timestamping")
Reviewed-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Tim Hostetler <thostet@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h          |  2 ++
 drivers/net/ethernet/google/gve/gve_desc_dqo.h |  3 ++-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c   | 18 ++++++++++++------
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index bceaf9b05cb4..4cc6dcbfd367 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -100,6 +100,8 @@
  */
 #define GVE_DQO_QPL_ONDEMAND_ALLOC_THRESHOLD 96
 
+#define GVE_DQO_RX_HWTSTAMP_VALID 0x1
+
 /* Each slot in the desc ring has a 1:1 mapping to a slot in the data ring */
 struct gve_rx_desc_queue {
 	struct gve_rx_desc *desc_ring; /* the descriptor ring */
diff --git a/drivers/net/ethernet/google/gve/gve_desc_dqo.h b/drivers/net/ethernet/google/gve/gve_desc_dqo.h
index d17da841b5a0..f7786b03c744 100644
--- a/drivers/net/ethernet/google/gve/gve_desc_dqo.h
+++ b/drivers/net/ethernet/google/gve/gve_desc_dqo.h
@@ -236,7 +236,8 @@ struct gve_rx_compl_desc_dqo {
 
 	u8 status_error1;
 
-	__le16 reserved5;
+	u8 reserved5;
+	u8 ts_sub_nsecs_low;
 	__le16 buf_id; /* Buffer ID which was sent on the buffer queue. */
 
 	union {
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 7380c2b7a2d8..02e25be8a50d 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -456,14 +456,20 @@ static void gve_rx_skb_hash(struct sk_buff *skb,
  * Note that this means if the time delta between packet reception and the last
  * clock read is greater than ~2 seconds, this will provide invalid results.
  */
-static void gve_rx_skb_hwtstamp(struct gve_rx_ring *rx, u32 hwts)
+static void gve_rx_skb_hwtstamp(struct gve_rx_ring *rx,
+				const struct gve_rx_compl_desc_dqo *desc)
 {
 	u64 last_read = READ_ONCE(rx->gve->last_sync_nic_counter);
 	struct sk_buff *skb = rx->ctx.skb_head;
-	u32 low = (u32)last_read;
-	s32 diff = hwts - low;
-
-	skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(last_read + diff);
+	u32 ts, low;
+	s32 diff;
+
+	if (desc->ts_sub_nsecs_low & GVE_DQO_RX_HWTSTAMP_VALID) {
+		ts = le32_to_cpu(desc->ts);
+		low = (u32)last_read;
+		diff = ts - low;
+		skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(last_read + diff);
+	}
 }
 
 static void gve_rx_free_skb(struct napi_struct *napi, struct gve_rx_ring *rx)
@@ -919,7 +925,7 @@ static int gve_rx_complete_skb(struct gve_rx_ring *rx, struct napi_struct *napi,
 		gve_rx_skb_csum(rx->ctx.skb_head, desc, ptype);
 
 	if (rx->gve->ts_config.rx_filter == HWTSTAMP_FILTER_ALL)
-		gve_rx_skb_hwtstamp(rx, le32_to_cpu(desc->ts));
+		gve_rx_skb_hwtstamp(rx, desc);
 
 	/* RSC packets must set gso_size otherwise the TCP stack will complain
 	 * that packets are larger than MTU.
-- 
2.51.0.740.g6adb054d12-goog


