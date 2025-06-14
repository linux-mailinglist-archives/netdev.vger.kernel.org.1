Return-Path: <netdev+bounces-197679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BC9AD98F0
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 02:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D613BED17
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 00:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE82132122;
	Sat, 14 Jun 2025 00:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qCEd4C8/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421525FEE6
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 00:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749859693; cv=none; b=rtGuP3VnoiW7eu636Uev2Eg5zj8o4gn/HzJzaKj55LRLYg0m2KsdwM6NbxWJ8yYMcp2Dp8D2nVF35Vh6IhKlGioQLE2yOmbiF3IVPQjY7u//rC5e6DI0KPv2Fhx4yZ99L0Vxo/ZmIWN+4JG5DdPa3FRcKkrlvuB8RZOVeWuhqjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749859693; c=relaxed/simple;
	bh=AUqZSuiBe3PPkayRXE+1vl6STB7+UaA9jA3sUFVwyeo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qAnIheylXeWSQz+7aCfsSnGVSKoaws7THhOW/ptVJavzSBNc9vE+xbGQcCLoOWVPNCnTjTWHzenCKCZpIVIJH+pPqTOvRq2gfwNuUKDRRNBQcg7Wr6dMjI9sZ1Vvuwnz6enDXOCo3T4OqnzVyaICGp2pOeUCcVsKFzMPO56HljA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qCEd4C8/; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b0f807421c9so1669533a12.0
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 17:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749859690; x=1750464490; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wQ77PoXoZhxHkicjW2DRoewCReIJSoD7R1A24IDLpDg=;
        b=qCEd4C8/2EGolwlNypZa9xDJr8wIKtEr+Z7QPrbX62lFBc5CFowAGfBH08ZhspgcBO
         oQt9uhFzr2h6erpB3HEANu+Hne1EKF358VLxIqZkVUxN9IQPfL9W8Z9NEoLe9eIwc03V
         WeQE/bRGEFSrRrdCnZXITo7CNAYAqm+IWDzhot+MPHBgwmlixsAIx3xYHjzCa7iWi82l
         n2ZNT4ehMN9lSefLl+6+H8N7WGgWZ0KKoQOwSnzYH2iemi6rc98jhLa06J+wBtD6lKG0
         K1Ww4Ab6rQNhBBOkosIjyBRjbpdhH06RKVYZs1L6BN8NvjMTy1B/DIZK3ND4WIP3s7Sf
         bBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749859690; x=1750464490;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wQ77PoXoZhxHkicjW2DRoewCReIJSoD7R1A24IDLpDg=;
        b=eFak3iNNNevrdWpafs/5N2bLptQM7wOHlomU2Ahko48pj2tP4FgOjxbvRrHEebleET
         6rtyO7HFrN0C5IkkZHLtIEybLHBjXs9WqeQp9WcfCXiH6sWP55ioyb6c3/mRKh096mc2
         T42oVxwvBKxYNdq3tOzLRrRBE4reqQZXNvHWO8ADfMzFoN7n1r7c6HPgAewvvarU3H8y
         a6rIx3e9wTHK11zBEmTPVEqARsT7ixFnOYOw9rUtvuOIPcggDUgQapkAD/svvvrWRYHm
         /W4jd5OX2HjAuUUue19AkQKADXrgtx3kLA0MV3roQYp4lGovsIsA4+gBgxUjPED7E8HJ
         uYVg==
X-Gm-Message-State: AOJu0YwuosCXhGiZDGFA3GCXWnwPL7aoWb3A6XC137pptAKB+bIO2Ybp
	WuYHoe1q8Sv3aR2MUfa3DolDaHjAc1Edz4hsOdXhTnDbEdqVILZo8HPBAkH2JI0Qc5gaiil0qH/
	hEU2q0pl15CgUitduIh7xHMW+GTIz2L2NmujbJxBoyP4RHqyURCvx8/SC6fjV1OwIXxJjQmfwak
	S4AxrR9crPnbS1+vzbmHsSEsMYkZJz4Lm3l7aWKQkDdB1vpMJOuSXR9j/NwaOY+6c=
X-Google-Smtp-Source: AGHT+IGpt8cTMfKUdKgjk+25Jrog2GjB0qM8UCNp6eTJcDfJyHbgtJn77pvdxSnRwYARFCY1cI+LKo5NauUFzP/O3Q==
X-Received: from pfwy28.prod.google.com ([2002:a05:6a00:1c9c:b0:746:2414:11ef])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:47df:b0:21f:becf:5f4d with SMTP id adf61e73a8af0-21fbecf5f6dmr999246637.20.1749859690301;
 Fri, 13 Jun 2025 17:08:10 -0700 (PDT)
Date: Sat, 14 Jun 2025 00:07:52 +0000
In-Reply-To: <20250614000754.164827-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250614000754.164827-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250614000754.164827-7-hramamurthy@google.com>
Subject: [PATCH net-next v5 6/8] gve: Add rx hardware timestamp expansion
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
2.50.0.rc1.591.g9c95f17f64-goog


