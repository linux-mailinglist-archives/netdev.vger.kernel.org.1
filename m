Return-Path: <netdev+bounces-184244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A799A93FC4
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 00:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA3BD7A116A
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 22:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684AB254853;
	Fri, 18 Apr 2025 22:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PSROWmdI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7600253B59
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745014386; cv=none; b=fflf71x7n/H4kRDR1W5txSeqEGfFEJ8mpNMxSyFTOWCbAdTdal1Fd9igcfGo+4SLB7j6xuxgueehYX/qyWgD1IX8HJmfa8cVyy2kPhAZFb0MX212uKy9Z6aNTN9jKmV8hdup20oraB/SGqa1EiREqzn3fewqkz5WLqtPJXDJQTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745014386; c=relaxed/simple;
	bh=LDgGYHe8WA8ukbxnUNq27MZRp/79LOgnW+Ea0tdUQtI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UEWKR+HMsswK9Kl9kKFXSE+vgeb3bfJcLwYRMtjJYha8lfyeYE348XPr+2jBW1sIIr6nwdkYXqcPGXqw5ChZjSKCmtNZHmFTQ3ChRWc2q2L/cBuqFAYjiCRwAs5YGOlEZgPLlFYC0eAFO30YY0plocYGmCTs0aza2gothFLgdbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PSROWmdI; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736c1ea954fso1253185b3a.3
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 15:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745014384; x=1745619184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3az9duQD4SoXSFpkKw6AxoXhKZsRVTLRACFG0KE1Wlc=;
        b=PSROWmdIa7vPOJTrXTI1W3OiBMySpMUnVS1YH1or+2fOtX5ZNO4YldOmrGGwcY0AI0
         aXNO1qKAmFFzxXPWWtUIvB43KwcNdfgf1pXRQqUaPLYxcbY8yJ4cLZJgYBb1qiOjojeo
         jVcMDegGO643Jtnqdf2N5aT875j9w+M9eV67zIfwUsQKT79902iJj1vboThJ+/r/l4Yx
         BG061Tf2HPvGnbb/prt785C4NYmtnWix/yMgEKFoHkM7Vw2DNDMhnaYHmGpTIdDVb5of
         j+KYPilCkYyblBDtbS3JnOExSTKxbpox9jSeM17Smn+coWA6Ej2Yqb6RFjpPaFzvpCO/
         6nMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745014384; x=1745619184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3az9duQD4SoXSFpkKw6AxoXhKZsRVTLRACFG0KE1Wlc=;
        b=QJw/4/J+DiYmzvEGnZT7I53/BVo0YAq/mt8XVLtdMvUA8zhE1lrI/NOlYJN7gor4oV
         lO7OFqbORkkMEDbdTgB22vw2SbsBROEskY2TPdznuaTyHJHvLjGpmTVAYBp1LrVozDRv
         J5oFdXGY+kFp+AO3yVPynbCI/Yh5k6/VtiWn+zjjF5Zz2+lgO6U6iHh9QWe2PQwsFDu7
         Kb+0L8Uv7PptKEnL3oO4w6BdI3h1o7jnoeQ2hWtbea/wlWts6uH8Dvak2bOiSlcGQ0w4
         jknm61eJit3cdLdDowzzQu+zvRhEbqT+kBTORbqrmxjQzlaGnguW0LskDEncvrGTestV
         bsTg==
X-Gm-Message-State: AOJu0YzdjYbETjJwZPCUJjZMDmp/pzTUFRpfkgwK5mSxSDzOxFth0e6b
	ZxUHq5pEBY1AfVvzzuUBArw6SD9fFbk8C5ACL6UWD63IzRsjt1l8772iklN1oZDBXh6Sf5EC0Qg
	ABPae0F4FHG25nbgDQtJ7a/2GBuytD0c2anA/UiWF5u/6cdamy5FqXml70x5YvuPulHRgK3YTUQ
	bCTzZGarxu5QOe3Zi3snMOno/+TZdxSVV9xNSzVdpCmMaTeMaF6FHlRbfcLas=
X-Google-Smtp-Source: AGHT+IG4xLR4Go44keFo94aEtdtI/SjU6ph+hUQLL+hTOgGcr7s91IwoXVMEfwjbG57hwdEPTAMppEXJYrzLVk7ovg==
X-Received: from pgie8.prod.google.com ([2002:a63:ee08:0:b0:b0e:1d1:49c9])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3a92:b0:1fd:f56f:1cbe with SMTP id adf61e73a8af0-203cbc53800mr6359235637.13.1745014383952;
 Fri, 18 Apr 2025 15:13:03 -0700 (PDT)
Date: Fri, 18 Apr 2025 22:12:52 +0000
In-Reply-To: <20250418221254.112433-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250418221254.112433-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418221254.112433-5-hramamurthy@google.com>
Subject: [PATCH net-next 4/6] gve: Add rx hardware timestamp expansion
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com, 
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com, 
	shailend@google.com, linux@treblig.org, thostet@google.com, 
	jfraker@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
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

Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: John Fraker <jfraker@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index dcb0545baa50..483d188d33ab 100644
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
+	s64 last_read = rx->gve->last_sync_nic_counter;
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
2.49.0.805.g082f7c87e0-goog


