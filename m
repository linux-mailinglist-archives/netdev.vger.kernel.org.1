Return-Path: <netdev+bounces-192899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9AEAC18C4
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 01:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EEB2A40E9E
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 23:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A992D4B49;
	Thu, 22 May 2025 23:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="waae8oH/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DDF2D1931
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 23:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747958272; cv=none; b=bJKzKFLR2OCoP/DOXwOBnnBjFYw2qci2DZ89zgM/ABLh7raYBUxHAUD4P+J2Pkiau1WMA/K68fT8hMbrHB0I/OKWdoTjfSxozLegX10k5nQAYyzok1ebpqpcfKu6OUzafSfBcvrKKDe0CR83p7smHut6S3CLXOD+JEMhdujasYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747958272; c=relaxed/simple;
	bh=KsU85/LVK/RVxvxFqeEmiH8e3CRbB9hHdYDVZaU9NXQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O9EPIkPm1Qp4xDA5Y2po19yNXQm4GvdL2No7N2GU0Egj8/sH/JfA2g+aGcPNfN6+P2QVlgPuc1f723yXScnsEl50G9nkdaoclWNzVBt2yLj8arg0AS/8fb3jVyw6dBPAdss7lJVvZDTnYlsu/7GEBvz18e7IYmQcbXYUc8Dd5o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=waae8oH/; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-742c620e236so4956650b3a.1
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 16:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747958270; x=1748563070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/U4F4F2baZjVLSiJ5F9H7XP7MI6hq4zoM+YfBft1UC4=;
        b=waae8oH/sCJjko+/EAqIpvri4iQvuZZJHxZakfRhb2zERy58+9rQ1i6u92OAZJqoPE
         BkFMVWxTIKiy89XiDW5P8okf2oPOYj429a9hH2j38FH8BiovDqsxbw3tdNMHK2HN1hKp
         7Lrs1Vxwk/yEguYF5hIKuDYUDB/XSGubxlvSnklm/wvy1oXxx1ddYR9Gm4gLJnheypBa
         07L9LGFqdvEyj6nXl5AfC+2O08O4vZsm630eM52Ja/NjnIDSCIC2tzz1vXU+GpVH/APT
         skw8XEs6+cTKjn7XOHR3DLbw90YdElNFTjOYgtXswR94Z5iBH1TTVgZMOcyL6hf2Qq5L
         YPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747958270; x=1748563070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/U4F4F2baZjVLSiJ5F9H7XP7MI6hq4zoM+YfBft1UC4=;
        b=Oogo/MnGNnM0a3myq4c0RBiNVYkiMASQX9++DXddgsQiOEClh6TRtshWjiwpgKIR3l
         SQcgyVGOpgFXN0jJJuVx6/ME0MhXw8olLzB0ByDonr9/DKiG8C8sKwU9zA0TnNppro0U
         BqFJKXUnFJXtaqQ6ScAQK+eqk/nAWGhayk/dL1U4V4wXiqJsmNS5asxEWWiWzO/oNoQ9
         Lj/EzhF8Vw3UXfvkoxqsr/xWH/8KJvwUQwdLaVXRXZAVnKrbc/rROwKuhYPFbdNPD3FC
         ad+OOfRFdeyOrjf9hydilCaET4X22QDccomDozkJa71IKtJc5NXjJixcZDkDlgfmMflU
         2qdQ==
X-Gm-Message-State: AOJu0YylM1RVqbQ8bwMTq6rFpacF7b5kM0ukLp4pTBJsobJ6QfkvBz9s
	Gsjf3vPOrxbXl7Ky/X3Id2+3z/Pa6chGSVg2oBo42YW2+THMZys0ztT1xKOMjhQ6rbTcT9WbmeV
	oikAd2JM0fX8EKbX3mPAowny1UIF0L5WzSqMscRobFslg/kmTZ3qZLQfAnkCrlKkHdp6cE5cY2d
	wrZ5kAYEfUaz6fyQYl1lSYIKUYAGwarFCYkkodOEOdbJzU0I1/vRT0YPkFMTDJvS4=
X-Google-Smtp-Source: AGHT+IEJdalaKRNSP2s4lpQ4yBO8ShRBy3a/J7ixPVGUEG0s+ijq9EKgywPOSNxjqQNTcKp5dNY+vqa+ntvXZiBf0A==
X-Received: from pfux21.prod.google.com ([2002:a05:6a00:bd5:b0:740:b53a:e67f])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a18:b0:740:afda:a742 with SMTP id d2e1a72fcca58-745ed7763dbmr1443151b3a.0.1747958269860;
 Thu, 22 May 2025 16:57:49 -0700 (PDT)
Date: Thu, 22 May 2025 23:57:35 +0000
In-Reply-To: <20250522235737.1925605-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250522235737.1925605-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250522235737.1925605-7-hramamurthy@google.com>
Subject: [PATCH net-next v3 6/8] gve: Add rx hardware timestamp expansion
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
2.49.0.1143.g0be31eac6b-goog


