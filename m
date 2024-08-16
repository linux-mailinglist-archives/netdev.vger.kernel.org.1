Return-Path: <netdev+bounces-119230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F022A954DDD
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 17:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B640281980
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 15:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7DC1BDA9E;
	Fri, 16 Aug 2024 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHh0EHcs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9AD1DDF5
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822436; cv=none; b=mkrbNFjrw7XNUIXvJZ03LXzV09leJ8+NVH1z/viOaoRNPcmeN6xdTQGHpeqwELhPT0Mf+7ObBMm+KIN8G5y4QGY07NB+942AdobU3VLOFKGg4sUM7fEPd/hofENaJ/qtCK53r8h5IKnshLjA9BQS+ViVwfJA2QohDTG2fRZV0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822436; c=relaxed/simple;
	bh=7GNSM+IlEHHmKgjuUlOoAascjhdI51PrHpSEU5fdJlo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a/LyxH3fyeiiARYhD+1GjBHTITz6SQHk2sizM8Euc6vQ96F8TqZY2N5jDu2Hlip4q4xJ6WC+itu1DAhJIE/DaGxe7r03nJSVXvc3wN+9jvXda01LD1XZ2cHF/vcSBMXmOA1MF7g3jrLmIzy1TDr/AGM1O1Wt7zCNVuKn5LcI8Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHh0EHcs; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-201d6ac1426so17246325ad.1
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 08:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723822434; x=1724427234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ESlhC3N3Ie2h8tZYy3+PTQ4vt2VAaO109qKMzUNXQg=;
        b=bHh0EHcsU/84QcWoy5BLJRdeOA0Wk5/LtafpTcDhdUUAzcd5tomZxVIfcW15LK0Fu3
         +YKzI6ejA68BREvXXv7oe7D4xTB+iT77sVnceRpL9yX5mKFKzHc6CzGmgIlj8U0h5UWn
         CJJSJTS74IlYZbT+uDw2MpLhPrhGcAQBIj8Du7O5oYlz8ZNgN40M39B/hmc1Tw3AsMn3
         TlAIveFy2g2kdlEmR7tWTsTjWcf+0R7OSTpnCqjRqhH1bKSqVsBtGPYl+s3ZF81PrFU/
         uLN2Zz9MidmPcVQ2vbzluKXSjJibZQW9oaY7UKbtNNXNBwh2tnVq56HhUdkhvJfOw+xX
         ovew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723822434; x=1724427234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ESlhC3N3Ie2h8tZYy3+PTQ4vt2VAaO109qKMzUNXQg=;
        b=Map5CuwB7qtYU38vQ9Yae8vT0MhXSVEk5E/OMhgwldTGInaRy8mb490EymdlBwaNCq
         v2hVAl57mzuG7uzI0NdppLBV4VIE/wtHrvdZFndKzXuk6nt8neJqsM0bldJx3yD3UxlW
         Q0DHMBMDxoRLMFQQ0RIqHLM9Z5wY8rEK14OZp2Gfa03R0bYLXGT6LVqZWXMG6XSjdo6z
         58GYNiihwU7grAMvTmXrH4/PM2UPlRI7yijt+I/z25d1t4DryeYbw9gcpT6UzzeD7C0Q
         7xcRgCrOTbqx37iY6Hb0y8VmizZ8O4gkuvpHbBFM+B53tHEHy1Sk4buopZ0vZ0HwKVn0
         A6Iw==
X-Gm-Message-State: AOJu0Ywzc37OlOmzXZPbnJ1EJ7JBBCYP9Qdnf0RlYDN74dPZTZerxJiX
	FgppcCCqWnVHqAx3f6lMT/5pU1G+QkAGB6a5IsDxjs+ugAIGNj09
X-Google-Smtp-Source: AGHT+IGhAlOHWz+qdLKH+UTFq8V7L5ltBDpEwa/g6A8o24pB7S1ObbIjRDruq+oWbhwpUbLOs44anA==
X-Received: by 2002:a17:903:70d:b0:1fd:9269:72c6 with SMTP id d9443c01a7336-2020407b7f0mr28119815ad.62.1723822433939;
        Fri, 16 Aug 2024 08:33:53 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f038d2aasm26833055ad.223.2024.08.16.08.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 08:33:53 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ncardwell@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next] tcp: change source port selection at bind() time
Date: Fri, 16 Aug 2024 23:32:04 +0800
Message-Id: <20240816153204.93787-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This is a follow-up patch to an eariler commit 207184853dbd ("tcp/dccp:
change source port selection at connect() time").

This patch extends the use of IP_LOCAL_PORT_RANGE option, so that we
don't need to iterate every two ports which means only favouring odd
number like the old days before 2016, which can be good for some
users who want to keep in consistency with IP_LOCAL_PORT_RANGE in
connect().

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/inet_connection_sock.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 64d07b842e73..6eb509832c90 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -333,19 +333,20 @@ inet_csk_find_open_port(const struct sock *sk, struct inet_bind_bucket **tb_ret,
 			struct inet_bind_hashbucket **head2_ret, int *port_ret)
 {
 	struct inet_hashinfo *hinfo = tcp_or_dccp_get_hashinfo(sk);
-	int i, low, high, attempt_half, port, l3mdev;
+	int i, low, high, attempt_half, port, l3mdev, step;
 	struct inet_bind_hashbucket *head, *head2;
+	bool local_ports, relax = false;
 	struct net *net = sock_net(sk);
 	struct inet_bind2_bucket *tb2;
 	struct inet_bind_bucket *tb;
 	u32 remaining, offset;
-	bool relax = false;
 
 	l3mdev = inet_sk_bound_l3mdev(sk);
 ports_exhausted:
 	attempt_half = (sk->sk_reuse == SK_CAN_REUSE) ? 1 : 0;
 other_half_scan:
-	inet_sk_get_local_port_range(sk, &low, &high);
+	local_ports = inet_sk_get_local_port_range(sk, &low, &high);
+	step = local_ports ? 1 : 2;
 	high++; /* [32768, 60999] -> [32768, 61000[ */
 	if (high - low < 4)
 		attempt_half = 0;
@@ -358,18 +359,19 @@ inet_csk_find_open_port(const struct sock *sk, struct inet_bind_bucket **tb_ret,
 			low = half;
 	}
 	remaining = high - low;
-	if (likely(remaining > 1))
+	if (!local_ports && remaining > 1)
 		remaining &= ~1U;
 
 	offset = get_random_u32_below(remaining);
 	/* __inet_hash_connect() favors ports having @low parity
 	 * We do the opposite to not pollute connect() users.
 	 */
-	offset |= 1U;
+	if (!local_ports)
+		offset |= 1U;
 
 other_parity_scan:
 	port = low + offset;
-	for (i = 0; i < remaining; i += 2, port += 2) {
+	for (i = 0; i < remaining; i += step, port += step) {
 		if (unlikely(port >= high))
 			port -= remaining;
 		if (inet_is_local_reserved_port(net, port))
@@ -400,9 +402,11 @@ inet_csk_find_open_port(const struct sock *sk, struct inet_bind_bucket **tb_ret,
 		cond_resched();
 	}
 
-	offset--;
-	if (!(offset & 1))
-		goto other_parity_scan;
+	if (!local_ports) {
+		offset--;
+		if (!(offset & 1))
+			goto other_parity_scan;
+	}
 
 	if (attempt_half == 1) {
 		/* OK we now try the upper half of the range */
-- 
2.37.3


