Return-Path: <netdev+bounces-219659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E4CB42892
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 20:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00036865E0
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 18:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23F1362096;
	Wed,  3 Sep 2025 18:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b="uYn/wP4z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0CA35FC0D
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756923574; cv=none; b=QCJXILeBHH9g7aJGEIVaNZzUDSCnOxAJjl9gQgHHEcAK1YjLmKyRCJtIhwzL/kt4igxu1w9GahlCoorvR16LdSa+hSdsXv4M0FLka2pjr+SxZQ/0MqnlKHFyN/EpVy1DgvGnTI+7Zik1GS/rHdEYn90yx/CJEZP20pt0Yi01Vo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756923574; c=relaxed/simple;
	bh=6Jfffm6Ua3AWymd6nMsiCyKUez1IiVld7g/bqmJmrOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t5C0SeEl/yFl5u/54xToUro9YMfvUkl+3sMwJAccC5eqI+fP+xGU7DUzSwSfCFoMsTQj8KRelSzh0Nzafw4fxvVMSulIEkpdBPYHbAY1Ty6Wv42zAd94xYZ5xMF7jiAWOCwkgjvXJ8xQcWPHJ+CFqN6O5M7SctKWIp85lHkWZQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com; spf=pass smtp.mailfrom=aisle.com; dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b=uYn/wP4z; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisle.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3df2f4aedc7so140703f8f.2
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 11:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aisle.com; s=google; t=1756923571; x=1757528371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3PqNDVva9AiPaCqeSKtvTwY0a1PD50DZGYN4Z5/1vo=;
        b=uYn/wP4zKBMc/b0MYisM5TIDB3v/7clpAl3mKr0wPpElZWifVov0uF5VqySauX87CF
         QYq7GWh7hwtQzqU/D0OYfqTRgLOP29fH3SBpwYLPGibOv5DNavK9/ZN+SVlCP/mF+eWo
         7PQ2+Rd548ULJgFZGd2R7ECBrdaboXHIS61fSlcN2dsMH9U1OVdyxTJAxZ5xflPbJ1GO
         HV/zucnenwXMHupTt5p2lNlAjIIBq8V9KMYz3im5vjMcGVIFu3jL0KwbwtCE012OgML1
         dOkWiQywBKoNexiQwBW98p3LozuKXxddg/KDM0OhYXdk0APtz/COOtDYUGVasgCaoARU
         jnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756923571; x=1757528371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3PqNDVva9AiPaCqeSKtvTwY0a1PD50DZGYN4Z5/1vo=;
        b=FWj7hYRXe5MVahHff6f+OcVxcbUcfu1TZ491uTUlgun8MYot9JkQkwkxMtMLECBf5/
         VrKGNc4lOq0SOgzxOHAzsI12BpdfrN7rXWF5VR/m0KT0O6ZgOshRjEQqFAPQ+gAXk7WR
         NgBWTmDsdDm3tpJyuVeeo/3EarfH6Qf4blklPBqxkAZ7jdKnRnHwHCM4pJa09EbFnFWe
         VOL+IKpu3eyqWoiXkrGtYuu7r6XM7Ft/p577DskEuLZlbRu2Uhn61Ga9Yzewv61ZhFxs
         Xk8cQQb4OdG44SfZaUBSRKopHn5mlH0eH8/xn/gWdFffI/yHGLwcTvh+mpSFPwPQBXUy
         4vgA==
X-Gm-Message-State: AOJu0YzsTTq0lfwIPMemt14nnqlUsoRTGgc+QqUcOxUbyKRVzmwJIIat
	uoSAegyjIqCMo/kfB9bVJpiuDgQS6DIMRvjO/oiGKmB7CqQKkly+SGJZjSngs90TUgA8hic8bM7
	TWjcpkH5KEHVq
X-Gm-Gg: ASbGnct/5Bj4TYaqt4lVdAnegBF1NGAJ8abPugm9hu2N09poD8ZtAL0t9BWeFpQ/nd9
	YBpOVc59mlqMRlzmM+MLqe1DHlLlYCJj2D/b5gAF9GUYs4ycRmKPsxoaE/X0etcU6tmX6oBSr85
	T8wpxVSqVuEmjW/OkwtqJp2DasovURHzowqJUkJ/mzO0OS51ufTSAduKYoh6Nzke4P24679dKpI
	Ap2OaNuU4FeZ8dZ1XnKXYsw4WPaetqhN2KCy8TzLaH3AojB0upqwitvmUAt3TBja/rF1PJP4PYe
	7LFr8JihdXRpMWXHdD1+7fmV278OsDMYzf0GgLHC0hZl2GCP1rJ8nsWqvwCpVCJ+xHGHPNbHK/2
	BXZfgY5tQBSNlUOdBt7b+lT1T3MDpwAuHoCN5H74mPG9rnXmHB6XTKcqx3wWVFs+aXBhv
X-Google-Smtp-Source: AGHT+IGTxOknj5RaZyA3JSSeXvkflIO38qpSnUEvBiIgHTzY8z8Chetm+wS+Zk0akLDeBgRS9qY3Vw==
X-Received: by 2002:a5d:5d02:0:b0:3d5:55c9:f218 with SMTP id ffacd0b85a97d-3d555c9f834mr8571425f8f.2.1756923570788;
        Wed, 03 Sep 2025 11:19:30 -0700 (PDT)
Received: from localhost ([149.102.246.10])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b72c55c1bsm350140715e9.10.2025.09.03.11.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:19:30 -0700 (PDT)
From: Stanislav Fort <stanislav.fort@aisle.com>
X-Google-Original-From: Stanislav Fort <disclosure@aisle.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	Stanislav Fort <disclosure@aisle.com>
Subject: [PATCH net v3] netrom: linearize and validate lengths in nr_rx_frame()
Date: Wed,  3 Sep 2025 21:19:15 +0300
Message-Id: <20250903181915.6359-1-disclosure@aisle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250902112652.26293-1-disclosure@aisle.com>
References: <20250902112652.26293-1-disclosure@aisle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linearize skb and add targeted length checks in nr_rx_frame() to avoid out-of-bounds reads and potential use-after-free when processing malformed NET/ROM frames.

- Linearize skb and require at least NR_NETWORK_LEN + NR_TRANSPORT_LEN (20 bytes) before reading network/transport fields.
- For existing sockets path, ensure NR_CONNACK includes the window byte (>= 21 bytes).
- For CONNREQ handling, ensure window (byte 20) and user address (bytes 21-27) are present (>= 28 bytes).
- Maintain existing BPQ extension handling:
  - NR_CONNACK len == 22 implies 1 extra byte (TTL)
  - NR_CONNREQ len == 37 implies 2 extra bytes (timeout)

Suggested-by: Eric Dumazet <edumazet@google.com>
Reported-by: Stanislav Fort <disclosure@aisle.com>
Signed-off-by: Stanislav Fort <disclosure@aisle.com>
---
 net/netrom/af_netrom.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 3331669d8e33..f0660dd6d3b0 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -885,6 +885,11 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 	 *	skb->data points to the netrom frame start
 	 */
 
+	if (skb_linearize(skb))
+		return 0;
+	if (skb->len < NR_NETWORK_LEN + NR_TRANSPORT_LEN)
+		return 0;
+
 	src  = (ax25_address *)(skb->data + 0);
 	dest = (ax25_address *)(skb->data + 7);
 
@@ -927,6 +932,11 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	if (sk != NULL) {
+		if (frametype == NR_CONNACK &&
+		    skb->len < NR_NETWORK_LEN + NR_TRANSPORT_LEN + 1) {
+			sock_put(sk);
+			return 0;
+		}
 		bh_lock_sock(sk);
 		skb_reset_transport_header(skb);
 
@@ -961,10 +971,14 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 		return 0;
 	}
 
-	sk = nr_find_listener(dest);
+	/* Need window (byte 20) and user address (bytes 21-27) */
+	if (skb->len < NR_NETWORK_LEN + NR_TRANSPORT_LEN + 1 + AX25_ADDR_LEN)
+		return 0;
 
 	user = (ax25_address *)(skb->data + 21);
 
+	sk = nr_find_listener(dest);
+
 	if (sk == NULL || sk_acceptq_is_full(sk) ||
 	    (make = nr_make_new(sk)) == NULL) {
 		nr_transmit_refusal(skb, 0);
-- 
2.39.3 (Apple Git-146)


