Return-Path: <netdev+bounces-91442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574218B2911
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 21:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B726D2853C1
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 19:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7543E152514;
	Thu, 25 Apr 2024 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dBdjCENE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F057015250D
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714073694; cv=none; b=FedPl61O0/sSgLo/GoUZQ2Zv0mMsfUL3iGg+FWfs/Mmzf2OJfAkZqgl4+gTjvvBGiliHdH1AqiXKWPDV6RUxl1P1aRN3fvRwLcd7ofhz4PWZBxjhwvhdh5P6aR4IkHmPSWXzLaN79bWwST8lRX2/l2ivOc5vPGIhfbvr41wfUzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714073694; c=relaxed/simple;
	bh=+GNFxBxaRTknwww0703b7nQ2P17CbGiTmoV6lH+LrQ8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e0kbGgj/JtSPXcVN8pYXv+G4kjtCfwpJNVAc7rP0WVLyw/ypgeszkwi1atYxgyN1fReCSh6xKojMIH5k6xf7CE3quCcUpn/opFzwa5mgNFUzZb01P2acNVw2G8Wfs6UkzKE/1aoFINWxKYA70eMpArTJ30xoeo56dBhjfBlZ8y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dBdjCENE; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61b4ede655aso23749927b3.0
        for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 12:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714073692; x=1714678492; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ENxYQjgQRKfjJU31eioJ/dmNNTRtoD9qAtUCQ/6a29c=;
        b=dBdjCENEJsC/XTUGuqTN+RMMWYh9T4WS+c6DCuZ9eBd+zhADHZxmFN31noUFkbYxQ4
         LZ9FMLf45bm09/F1HQ/6h3AvbtRd+tgmGgE2bw57SMJmBS3oB3bICFex4vXG0eiB7XzQ
         HOhMCoLFIl9uUOJMHrVTogC8FTFXbUdodhNRQT3iEsva0GZ4yw/b5CQuS9kA5wh7kW+s
         Li2UH1w1p41VspdC9IHnVzRT/013SnAQsICvl94Bevgm/ML+tcjgZ7zPKu+FzX44fdhH
         itX0nHbARct1VnBVB/lFlginhHKPf90yRETHSNoanKwB9XaiSTVf1NMwmlSp+VQBDRy/
         9b+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714073692; x=1714678492;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ENxYQjgQRKfjJU31eioJ/dmNNTRtoD9qAtUCQ/6a29c=;
        b=bbq2UkZrM5NlKNe6t8hLSYIqCQLjPG8MdSfMZJRPCuWlTiZj39F+xaNyztfcRnqoTw
         BYp1FgYBy33xKdLWr6Ig0iMm0w3x775Hy6K+ZnYtbdF8/fyrZMN+MGML4mo2iVTJNlJc
         uz+H13Qg/clh4045dw2FPu2yY+EcW052+/C2Bo2XyuES+EvryWdhTSChsOXmdJsqGFLy
         2qdM9ARubMrbiEldFvMQEgkK5FPKG8XTBIh1KfDHgQ1YL/rNro0pqPz+68v+3QaAY9cH
         ziwU8BbVTr0HO27xYMMOHbtAmrdHFOM0iVHPb0WX2V/AoslW1oHM2F0APDTbRnrKyNPl
         kn/g==
X-Gm-Message-State: AOJu0YysO4lA6IovxQJAyYuPFvmSxVSGexz/kqXXTxP1t1SNpWUpphQ4
	UMaF2pIvKLQX75PQ9OcBVye3gFNXVwW8TGTsKdJR+1lyTn7HE8gq9xup1++V3HslTdToCalZR4j
	OShosDVqRFg==
X-Google-Smtp-Source: AGHT+IGbIjul9I9V4tKs2eZD5/+oiEvF1LVVDjkU5aTHORMYzASrBVW9r4zDFT6j7v1KZWuVZyh82Ww8G5Z6Mw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1005:b0:dce:30f5:6bc5 with SMTP
 id w5-20020a056902100500b00dce30f56bc5mr68789ybt.4.1714073691969; Thu, 25 Apr
 2024 12:34:51 -0700 (PDT)
Date: Thu, 25 Apr 2024 19:34:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240425193450.411640-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: fix tcp_grow_skb() vs tstamps
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"

I forgot to call tcp_skb_collapse_tstamp() in the
case we consume the second skb in write queue.

Neal suggested to create a common helper used by tcp_mtu_probe()
and tcp_grow_skb().

Fixes: 8ee602c63520 ("tcp: try to send bigger TSO packets")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
---
 net/ipv4/tcp_output.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index ce59e4499b66dfd2fe00c255c11187e3c08c5806..ef25556c48139c1904ac3fe6e484676ba10ba1bf 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2403,6 +2403,21 @@ static int tcp_clone_payload(struct sock *sk, struct sk_buff *to,
 	return 0;
 }
 
+/* tcp_mtu_probe() and tcp_grow_skb() can both eat an skb (src) if
+ * all its payload was moved to another one (dst).
+ * Make sure to transfer tcp_flags, eor, and tstamp.
+ */
+static void tcp_eat_one_skb(struct sock *sk,
+			    struct sk_buff *dst,
+			    struct sk_buff *src)
+{
+	TCP_SKB_CB(dst)->tcp_flags |= TCP_SKB_CB(src)->tcp_flags;
+	TCP_SKB_CB(dst)->eor = TCP_SKB_CB(src)->eor;
+	tcp_skb_collapse_tstamp(dst, src);
+	tcp_unlink_write_queue(src, sk);
+	tcp_wmem_free_skb(sk, src);
+}
+
 /* Create a new MTU probe if we are ready.
  * MTU probe is regularly attempting to increase the path MTU by
  * deliberately sending larger packets.  This discovers routing
@@ -2508,16 +2523,7 @@ static int tcp_mtu_probe(struct sock *sk)
 		copy = min_t(int, skb->len, probe_size - len);
 
 		if (skb->len <= copy) {
-			/* We've eaten all the data from this skb.
-			 * Throw it away. */
-			TCP_SKB_CB(nskb)->tcp_flags |= TCP_SKB_CB(skb)->tcp_flags;
-			/* If this is the last SKB we copy and eor is set
-			 * we need to propagate it to the new skb.
-			 */
-			TCP_SKB_CB(nskb)->eor = TCP_SKB_CB(skb)->eor;
-			tcp_skb_collapse_tstamp(nskb, skb);
-			tcp_unlink_write_queue(skb, sk);
-			tcp_wmem_free_skb(sk, skb);
+			tcp_eat_one_skb(sk, nskb, skb);
 		} else {
 			TCP_SKB_CB(nskb)->tcp_flags |= TCP_SKB_CB(skb)->tcp_flags &
 						   ~(TCPHDR_FIN|TCPHDR_PSH);
@@ -2705,11 +2711,10 @@ static void tcp_grow_skb(struct sock *sk, struct sk_buff *skb, int amount)
 	TCP_SKB_CB(next_skb)->seq += nlen;
 
 	if (!next_skb->len) {
+		/* In case FIN is set, we need to update end_seq */
 		TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(next_skb)->end_seq;
-		TCP_SKB_CB(skb)->eor = TCP_SKB_CB(next_skb)->eor;
-		TCP_SKB_CB(skb)->tcp_flags |= TCP_SKB_CB(next_skb)->tcp_flags;
-		tcp_unlink_write_queue(next_skb, sk);
-		tcp_wmem_free_skb(sk, next_skb);
+
+		tcp_eat_one_skb(sk, skb, next_skb);
 	}
 }
 
-- 
2.44.0.769.g3c40516874-goog


