Return-Path: <netdev+bounces-223748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96065B5A43D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5199D17B85D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCED7323F66;
	Tue, 16 Sep 2025 21:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GEkSFj6G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338AF31FEE4
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059292; cv=none; b=GY9+kRHAsWJPGKaY6Gs2+GUnNXiaXixFzW9/OotPpTDQADYJHVGD2g+HcxeDQwncB9jSPAivgonwVbzP+5lQVZEq2/5bi01u5Mw+tp13hnq8TtTYkeXbcSqPuaD63qfOs8te5MgZYwKC9pMyL753S12GNK9KeMnNXLLuEdzVv/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059292; c=relaxed/simple;
	bh=dI2fxOZumwf1A98VcKvR3x0t9iORh71GXyvSqDwDV9w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bm2Aks8rcFaQ7hTpn9tYNLk1Vh0W3FwMaXQ+UJjU/KZD3ta7ChQbo4UsLyn2cg4Ucs09lOp7uWpMiyQaOp1T1VHbMyOfSAAwtsk7tEjHGKxC0WfPneV25/Azga7ZmODIuULS7I+supjxl7Ewns0siuk1jvB9M1ewWjUk0CX5TJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GEkSFj6G; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ec67fcb88so631374a91.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758059290; x=1758664090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zd/DJ5adDesHyGLwexvXHpnhbgXEiGpH2D2QGWRkaAI=;
        b=GEkSFj6GcwxgYgrxxvqsaPlTEiR5Yi9K7QCRmNG/+ZTdzFlW2WobaJ9FnyCJqvIzhz
         9ZlKf2fD4tykO7JAArjOJDp3NsWeei8mJ8t6QlGaKrdJ06d/lQ0JlUhzut7zG0awE8XZ
         SZjnUVoliwfqXf8U953eTGkpWnmjc9F61ETc3aLForgMg8OeML2aU6NzK1MhNKLTZEMY
         7wVKCvHZG51HqpCtq8YLqZR8Nt3x1/kQ5DKm/431DyO4ThD+pMd1I+fxMNLP5QVkSr54
         wmX3FhCBwf7oLFoEJomaqFgc/KpSM6qZbfpL8zk3kFJx8R7EWhcTn6rhJNaVuxunQgOL
         R98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758059290; x=1758664090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zd/DJ5adDesHyGLwexvXHpnhbgXEiGpH2D2QGWRkaAI=;
        b=PoashtduV3R+h2zT991dWmezbiwYUspp2LgpTVoRCDwImN064BaLT+uuabbHc1ND78
         EXPBtNtoOhxu2CwrVdsdi6169zPTgZytKD39d6QFJd42ptPUBBlH614vW2fHodtjXObp
         /ya/ZPeWHEp5aFDU+jcrIoKIPu7/caizhhtJtrfZfiZOB70bAOImtTbAeNdyd2sPuehv
         Kk0UpkOqmxRjAm5nAAsuWHRmk1qnOnzfFNCtqie17n3egam2wEXzAO3nefpMxt7OKmGB
         JV6q9TaGaahEURpRsH8X1wPezVavYdNtr+iSOZLX5+k6ZwEG0wwEYA/ZAWBQ9C/CBlIC
         5LOw==
X-Forwarded-Encrypted: i=1; AJvYcCVwdKEWVqQgeg+6qIcrnpHrEN/+Y6//EDPSm5HnI/pXdk+xhdJq6/0KIRen149L67TUb4p7iNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQw7LAFXxENAiM5K3stzgCfx7WN0ZbuWM5++IEdUNKpmKlQMnw
	DMcwfAJP5r7CRuirxCBRcThxO2ZieJK4DsSrFCdUM5Mq+jpScEdV8VuBDRlUR0jwCFSYN1MvWdy
	gJqbEhQ==
X-Google-Smtp-Source: AGHT+IG58fz5u3Im2NKSFcMn7Wnk5G/9SnItYpmazANGVNXLMmHhCTHH9DJCPwymEC771T4FS2fo91no45M=
X-Received: from pjtq15.prod.google.com ([2002:a17:90a:c10f:b0:32e:8396:7798])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b09:b0:32e:a4d:41cb
 with SMTP id 98e67ed59e1d1-32e0a4d449amr16531343a91.1.1758059290361; Tue, 16
 Sep 2025 14:48:10 -0700 (PDT)
Date: Tue, 16 Sep 2025 21:47:23 +0000
In-Reply-To: <20250916214758.650211-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250916214758.650211-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916214758.650211-6-kuniyu@google.com>
Subject: [PATCH v2 net-next 5/7] tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Ilya Lesokhin <ilyal@mellanox.com>
Content-Type: text/plain; charset="UTF-8"

get_netdev_for_sock() is called during setsockopt(),
so not under RCU.

Using sk_dst_get(sk)->dev could trigger UAF.

Let's use __sk_dst_get() and dst_dev_rcu().

Note that the only ->ndo_sk_get_lower_dev() user is
bond_sk_get_lower_dev(), which uses RCU.

Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>
Cc: Ilya Lesokhin <ilyal@mellanox.com>
---
 net/tls/tls_device.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index f672a62a9a52..a82fdcf19969 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -123,17 +123,19 @@ static void tls_device_queue_ctx_destruction(struct tls_context *ctx)
 /* We assume that the socket is already connected */
 static struct net_device *get_netdev_for_sock(struct sock *sk)
 {
-	struct dst_entry *dst = sk_dst_get(sk);
-	struct net_device *netdev = NULL;
+	struct net_device *dev, *lowest_dev = NULL;
+	struct dst_entry *dst;
 
-	if (likely(dst)) {
-		netdev = netdev_sk_get_lowest_dev(dst->dev, sk);
-		dev_hold(netdev);
+	rcu_read_lock();
+	dst = __sk_dst_get(sk);
+	dev = dst ? dst_dev_rcu(dst) : NULL;
+	if (likely(dev)) {
+		lowest_dev = netdev_sk_get_lowest_dev(dev, sk);
+		dev_hold(lowest_dev);
 	}
+	rcu_read_unlock();
 
-	dst_release(dst);
-
-	return netdev;
+	return lowest_dev;
 }
 
 static void destroy_record(struct tls_record_info *record)
-- 
2.51.0.384.g4c02a37b29-goog


