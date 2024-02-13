Return-Path: <netdev+bounces-71364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98411853173
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD74281839
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA4954FBB;
	Tue, 13 Feb 2024 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnIfysGL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6715654FB9
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829937; cv=none; b=cc8rJeFQ/Ly48Xh8zBl0xdi47fUgF5qmmqt3uT6jQLuE68Ftvgw2HE+TqVDifOFhhMx8VkeXHfIyVve1QV8JoCcSL6rZRNmTEtcMXVDhd37yPTurHL2xIhB3xAu7S3DieQNgpzfSogtvv0v1icjMWk64n+IVvveCuKakPdcygSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829937; c=relaxed/simple;
	bh=cqX974zxs/5GcsA86//MsC3IJ99TB/s1akyQ3d6M458=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oNTgGxt4x/ViP9aewSJ5+C6dPuhYckmOV043pMLpfr9hykn7bXjszEz/CSNyXj4OVLE/0UFoGFcphWsoOaLx+TAwkckn7lFnw67ii2YzBQZNMgl+bmQ6ZvwwRIOlU4uhBzzkpj595jsF72bT4iZfGeWQpJk1AWbZlx+PLo+sfhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnIfysGL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso780201b3a.2
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 05:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707829936; x=1708434736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=03tVZgso8LARCIJ62RkbajeFgbCMpGrAoKJjL7QS9Qk=;
        b=RnIfysGLGa1sOra+MUa6AkqHCkjacFdU44ZBgnKBbKkSpmhVZmg7PGESqfZvn/5lhb
         6XFiQnPszCdZZ2qZ57zD3yKEG37nrtLN1X4nrqamy7CCDmOAKnbNLzA78c6cEd25QPjn
         Y01wE9LuGJVLqC2pS8UuyCGwemzUz7bohgYENJMJ3BGmyjPUkSKT6QgI0PItUiUO1pR5
         pZNpYhZW0tgFFSVC7GU9xyxUUgDJuYuNyfOcHOq3pdNgE67+dB+e+dQFzfo+LD0Ws4eC
         H2ad/nr89hAEIsQLEBoTsWNIfJgUBWnOosEF3G5igmx42L4p5urxyxel3sTIOU2SKvrQ
         LglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707829936; x=1708434736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03tVZgso8LARCIJ62RkbajeFgbCMpGrAoKJjL7QS9Qk=;
        b=QTy4tTLrpFBtriZ/+W9tSiwKt3c/AcSWpon6vuIp2Qj/eHcCfJftCrPx58rvQ7dm8m
         3uuCN3w9DAI8baQEvaXTeQ781jwRxgHXt4ToonqLtB6AMctP8yOqa3qrncq5nyq34/Pb
         xYTpxIdBloDYF+Bu5IabBQ5jJjnEbt+6xueCb74r9DEyPEorDhlKRxqt5lwiK01CVgOC
         WgakzTJpYEVNDUpz/kZbmji4j5Z9pNk77gRwGG8waxZh2nK0hiDU2hDDf3jh9NtaGTsE
         oZ4TM5QX8Fwb02liRz55DVbQ5ZgRQmZ/QV5oIMPN80/UKEJ8PVm8xndkBWXIFjv7iUie
         MybQ==
X-Gm-Message-State: AOJu0YzHPtqUaHU9b4R7LWmJKz1WzgBYTcfeg8YFew1+loHzyuCFQgTU
	w/4cJ2ZS7xhYOFg0bFeRCEzBFB2mtXNfAfxVrQfmO+fPHIgO9zBT
X-Google-Smtp-Source: AGHT+IEFFKhx5l1wHUsV30dV7PL3f8jhMlb368hN3NVu6h3sU50j7eTeB6nnldQDOCx6xMoBN8QNSg==
X-Received: by 2002:aa7:86d4:0:b0:6dd:c3fd:45fb with SMTP id h20-20020aa786d4000000b006ddc3fd45fbmr9146420pfo.24.1707829935616;
        Tue, 13 Feb 2024 05:12:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXwJVWZZ42Y91p/ZtB83md2fqy/mGknlk9/6IV3H4M0VdI5ze3f/d7PMqthuupix3mn76wC2rYwGc60yuwl7jwhoKj7dX9jiSsyDgp5RI3MweZybose1P04iOPf1+VKfMA7Oq/CRcV8Wv3mn0psIT2uIRY+vCecLtQiAaUK7feC3zAepTYk8vqaiKG9yq3NX1xF0hzCdHwQH+lb8MLqZAQdj8DqT0Kf1DXFj8MJFkrIC17jfhpYjmgDAr13X1G3O1GS
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id k63-20020a632442000000b005dc832ed816sm1488920pgk.59.2024.02.13.05.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 05:12:15 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next] tcp: no need to use acceptable for conn_request
Date: Tue, 13 Feb 2024 21:12:05 +0800
Message-Id: <20240213131205.4309-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Since tcp_conn_request() always returns zero, there is no need to
keep the dead code. Remove it then.

Link: https://lore.kernel.org/netdev/CANn89iJwx9b2dUGUKFSV3PF=kN5o+kxz3A_fHZZsOS4AnXhBNw@mail.gmail.com/
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp_input.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 2d20edf652e6..b1c4462a0798 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6623,7 +6623,6 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct request_sock *req;
 	int queued = 0;
-	bool acceptable;
 	SKB_DR(reason);
 
 	switch (sk->sk_state) {
@@ -6649,12 +6648,10 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 			 */
 			rcu_read_lock();
 			local_bh_disable();
-			acceptable = icsk->icsk_af_ops->conn_request(sk, skb) >= 0;
+			icsk->icsk_af_ops->conn_request(sk, skb);
 			local_bh_enable();
 			rcu_read_unlock();
 
-			if (!acceptable)
-				return 1;
 			consume_skb(skb);
 			return 0;
 		}
-- 
2.37.3


