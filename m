Return-Path: <netdev+bounces-195826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F74EAD25CA
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 20:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19CD316F611
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 18:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED3B22128C;
	Mon,  9 Jun 2025 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RrpKECT9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FA4220F52
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 18:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494445; cv=none; b=SNLmfMJzHc1HI9/Q2xCq4AF6cQJ7MNEF5sHaK82mOXU9wdq6ZDVfLjXG2fGTJl70PRvs/hMUI0iKu24s3UBo0Pdtdq2TetnthOYttvNhUT4+dc7wX/MxCd29PTgfJogTUMFkgcEeVpXvHPAp9x1CSndPMe3izxvlQxFm7Zr6fhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494445; c=relaxed/simple;
	bh=QCRiqA7VAn5Bzf/uSF17xCHxhjH76+/XxZuTS3QiaZk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NpAOpISKITpmUmsTvRyE5rSbshS0n+Eb8no+bPa68PkwAgu59I+cZNVuUK2gq/Z7Tl2+3EHKk5wib4EGk81FED8g1Bk+yBf+4boTHcsCeWBV55HoEgPqiJRc30x0lQ00IC8kM4JmcqdtpN3WV25xcEqrL9cj2Kwg49vzQd0U4dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RrpKECT9; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-235842baba4so39111075ad.3
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 11:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749494443; x=1750099243; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D1Y0C/FAqHRDO+LbKE5JJcds0KjGxqFEGkislmx1t1o=;
        b=RrpKECT98/x2di4uwa527TrM4LE/i4EmuRgX9QMjjy+YJtlYu2Ti9UsekvPmZCwjkr
         ZqyTgevU7/cKlUylNfwcBzLxGptCAF9YbCDdvRAtlLUCmQLUZp21MY8QHMJDYP+yi8d0
         6XYPHqZIH606c2sJ0+kw1QWoBw31Hc7/ySCkZodDbkSfdPLI3ON9unVyQW8y1S5vdX0K
         bTsWVBBOD3cHJ5uY5ffF+SJt5bzGjyB12F1h+PzWfnoYbAl41NM2YBhGkNm9/U/ymZhg
         Wld9p52cFRYMVJLvpc88/cKli5J6trsudMrg3L+M3YduJBel03VYwJ00T55RYRT3ZhLF
         qQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749494443; x=1750099243;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1Y0C/FAqHRDO+LbKE5JJcds0KjGxqFEGkislmx1t1o=;
        b=lusa2XHVjCTq39BcIe07NRAYc7z5lTPoCq1SjAESOSh3WP5oiedGXQyU/Ctf6p1cpY
         xXcWSU4r9WEoviRdYzw93d60rbC44HVA3McAoQCaf2EKedo7xiufboPJe2xvxA58UQci
         eVDqhhH2e37PsNosykcKGqvxq5/DFv/wSLcjZte2dDNrcTcjZPKVxlFTVlCOccU3Cmlu
         A1utxAjQSRTJ6x16x5xb9EcInI9xSsLVo1tQmTZ5CPqCjmOgPyw0JqX8fRQA9wvyXsI2
         orUJSItxwzt/Yt9lvR5W24ZVMlTMEWGEmjKfQ/6bI4WoRDfQlgs/nY8MyVFILlOuP/zI
         UBsg==
X-Gm-Message-State: AOJu0YyEysIOw6advha2K2zm7eVMqyDh/ovs9+VTxP9DGo/dBqWL2k3T
	iPfNB+Iw5WbZ5be5Z7cJp5MvFnUNq4S9VcfSKWcGuPjXJSTQL+tReiExk3AkKjp75Y1Vt3iBs1W
	QdyhaT7pWGQ3HfxNFCrRSjp2HEc+AoR5KxcOb8wyb8ShIifgre/21zWvvDWAWhmrEVqvnjt0Wu7
	dUuZPGAjVyUUHK98QUopzvpvVjUVwvC9loF/szKdD7cH6VH/ka2RSmYQEQ2EV00Xo=
X-Google-Smtp-Source: AGHT+IGB3OBVlk0SWiXjb3AMVXr9DDsoik9k3mZFUm83Ee4eF5UbNhOncUDYbatUZI+8Qmpaz+R6DWjZTE/muCLw/A==
X-Received: from pgcv10.prod.google.com ([2002:a05:6a02:530a:b0:b2f:556f:74a2])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1b47:b0:234:c549:da13 with SMTP id d9443c01a7336-23601e4b749mr207119415ad.17.1749494443018;
 Mon, 09 Jun 2025 11:40:43 -0700 (PDT)
Date: Mon,  9 Jun 2025 18:40:27 +0000
In-Reply-To: <20250609184029.2634345-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250609184029.2634345-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250609184029.2634345-7-hramamurthy@google.com>
Subject: [PATCH net-next v4 6/8] gve: Add rx hardware timestamp expansion
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com, 
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com, 
	shailend@google.com, linux@treblig.org, thostet@google.com, 
	jfraker@google.com, richardcochran@gmail.com, jdamato@fastly.com, 
	vadim.fedorenko@linux.dev, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: John Fraker <jfraker@google.com>

Allow the rx path to recover the high 32 bits of the full 64 bit rx
timestamp.

Use the low 32 bits of the last synced nic time and the 32 bits of the
timestamp provided in the rx descriptor to generate a difference, which
is then applied to the last synced nic time to reconstruct the complete
64-bit timestamp.

This scheme remains accurate as long as no more than ~2 seconds have
passed between the last read of the nic clock and the timestamping
application of the received packet.

Signed-off-by: John Fraker <jfraker@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 Changes in v3:
 - Change the last_read to be u64 (Vadim Fedorenko)

 Changes in v2:
 - Add the missing READ_ONCE (Joe Damato)
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index dcb0545baa50..9aadf8435f8b 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -437,6 +437,29 @@ static void gve_rx_skb_hash(struct sk_buff *skb,
 	skb_set_hash(skb, le32_to_cpu(compl_desc->hash), hash_type);
 }
 
+/* Expand the hardware timestamp to the full 64 bits of width, and add it to the
+ * skb.
+ *
+ * This algorithm works by using the passed hardware timestamp to generate a
+ * diff relative to the last read of the nic clock. This diff can be positive or
+ * negative, as it is possible that we have read the clock more recently than
+ * the hardware has received this packet. To detect this, we use the high bit of
+ * the diff, and assume that the read is more recent if the high bit is set. In
+ * this case we invert the process.
+ *
+ * Note that this means if the time delta between packet reception and the last
+ * clock read is greater than ~2 seconds, this will provide invalid results.
+ */
+static void __maybe_unused gve_rx_skb_hwtstamp(struct gve_rx_ring *rx, u32 hwts)
+{
+	u64 last_read = READ_ONCE(rx->gve->last_sync_nic_counter);
+	struct sk_buff *skb = rx->ctx.skb_head;
+	u32 low = (u32)last_read;
+	s32 diff = hwts - low;
+
+	skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(last_read + diff);
+}
+
 static void gve_rx_free_skb(struct napi_struct *napi, struct gve_rx_ring *rx)
 {
 	if (!rx->ctx.skb_head)
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


