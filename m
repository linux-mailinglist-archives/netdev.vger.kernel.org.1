Return-Path: <netdev+bounces-163653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9569A2B260
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 20:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C45188BB7E
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 19:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229BE1B0420;
	Thu,  6 Feb 2025 19:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3p/VMAy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718021AB531
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 19:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738870535; cv=none; b=oMpgf0hXNKaFLrxgylLEFvWXUgrIKt4yVUAnlfvMAXVLyz5oCv4zSI8NdtiXWTfnygzVLhlSSP+xT6kRI3qjf1zp3nt4t7Yy7Vzyx84GUXoKZ9R5zzDPsHIq+WmkGVxX66fayvbOifZiYlQYWcKK/F0BqI7o9xG3SweQdIXzHHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738870535; c=relaxed/simple;
	bh=6A1Yr0Nt2Y/i+CplfXUAh9Lytzs53pef80EIPY87Uso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6ptGd7GFL/YzspwGfy0P+VpnkhWY8YwPVOUToiLptlhOFMwyMrcNIegW/tEX4ZCbRUf3NsqwzcFKr3DvcsW9BNmfzStZQ/vJo9ZrGCwOZfWJB5DjxtnsTtNoszVBVT7BpxDfLHnBQMbVRwhamhj0yECmQmRITOFcxz/JLc+BFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3p/VMAy; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-467a37a2a53so14756361cf.2
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 11:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738870532; x=1739475332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvZCJalBx72YoEeHFrYTX0UbCE0kMxHPZc2AdScVOTM=;
        b=X3p/VMAyNExXmJqj28iHnkL0ind5ip+cD/kyFgm5deAdPHwi8WBH9B9g7lKzwM0CDs
         dtMjJeMX6RXJDfFIRm/bUCwpqFBbwefnGG572oxQbAKvRDImkxYhf+iZsVYKyIEMP8cK
         jEasb88y/SiSKyXkMJ3w84ciWJ9IJYgvbL3U650NXUi22TJzNGzam5i+RebCaWg6D1lm
         asf9lfHdQeCYSKN+RPPy78TyPxKa2yh8hlIBiT2VrbP1bjLy9IzF81pq/C1jXlC4x2Oh
         wuPACUfkj6JN56AzEwIjvsvQ2EERfH+Hw7mtROtD+sGuYJNdrr1eXgJH2b/SZJ+E5bOi
         mIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738870532; x=1739475332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvZCJalBx72YoEeHFrYTX0UbCE0kMxHPZc2AdScVOTM=;
        b=V38xQ4V0eEpyNhZQ8qsPfNUx4jAp+j/WvI6t0pwoKgxdETySk9wadV9seCiUcw7bOs
         F4ekwwVPQeJQ3LYu5i1ykhvb/LXf9IZ8lUlSGyf1qD9xufOoNhhMIHxksZIa9Q36vcB1
         4FHSb6t7v1on4t/X5pL9EM7zuI4CizVbI+DPqmI87b1ASty11XWGXPHjf6319aWYd3ox
         Vq+ED1Ot87nxwJm+NgZdVIpzCNxUjqV8WtKbLGXDenfxtwkgig28PcByLa2RmZUQ5usJ
         LxW9LXdBqzJYq6CUif7m83ufbd+hq6Dn3tZQyC1JimMD74E85jycFfnXTqgrjYsf3EGv
         c3dQ==
X-Gm-Message-State: AOJu0YxBDbTJLQ0+XcK0RN2RAmrY9K+fuhyG3l7EB9aOSlKYTNwdBJ2Z
	gTaI5HlO7QE6urUUqEOVGcDyPz0cV7UN6HuCV1L/UOn1lKKwi0E2C0peiw==
X-Gm-Gg: ASbGncvN6X/g8Rf1byyy1umk59jOPArakWAQH4bZK6Fc6FKXUvtCnkaIbZ60m/F+uMB
	HRSJQfrfhacZ7EXDkmtLldqMhX6eGuaqhM50i+u1y3nxEFhsafXxLmeOvEbn/86kotEpLTuWqO3
	tgXvSAs6Z+zRekJxpNq7e5Oc6QRfyZthO80k99TFP8r6kWdHvKHG4zhUqp9Z0xiqQSCfD+7Yt88
	PyijF+nlTUADddx3rIlxF3/kn5XpAUs+4pFPZhqw+jOF4vspp3sPgQHCzr3KKXq9xVbjXYhfXfM
	6SnYMY5cPWrFwbXihZOclu/D5tKcJjdKaUC/pJlNg4F10LbvBDn7RUmMD70O8+bw7CnTm5Bq68H
	PcYuEI0iBZg==
X-Google-Smtp-Source: AGHT+IGkY+JMfwba7VxB+PVQmMvFkCo7/YXD7BOIvb/28yhyacGspyXnvDpUrLu702oXvm3bXCQWuQ==
X-Received: by 2002:a05:622a:199a:b0:467:6bd8:accd with SMTP id d75a77b69052e-47167a9ed37mr6206191cf.15.1738870532241;
        Thu, 06 Feb 2025 11:35:32 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471492accc2sm8349301cf.30.2025.02.06.11.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 11:35:31 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 7/7] ipv6: initialize inet socket cookies with sockcm_init
Date: Thu,  6 Feb 2025 14:34:54 -0500
Message-ID: <20250206193521.2285488-8-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250206193521.2285488-1-willemdebruijn.kernel@gmail.com>
References: <20250206193521.2285488-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Avoid open coding the same logic.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 include/net/ipv6.h | 2 ++
 net/ipv6/ping.c    | 3 ---
 net/ipv6/raw.c     | 9 +++------
 net/ipv6/udp.c     | 3 ---
 4 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 46a679d9b334..9614006f483c 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -371,6 +371,8 @@ static inline void ipcm6_init_sk(struct ipcm6_cookie *ipc6,
 		.tclass = inet6_sk(sk)->tclass,
 		.dontfrag = inet6_test_bit(DONTFRAG, sk),
 	};
+
+	sockcm_init(&ipc6->sockc, sk);
 }
 
 static inline struct ipv6_txoptions *txopt_get(const struct ipv6_pinfo *np)
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index 46b8adf6e7f8..84d90dd8b3f0 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -119,9 +119,6 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		return -EINVAL;
 
 	ipcm6_init_sk(&ipc6, sk);
-	ipc6.sockc.priority = READ_ONCE(sk->sk_priority);
-	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
-	ipc6.sockc.mark = READ_ONCE(sk->sk_mark);
 
 	fl6.flowi6_oif = oif;
 
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index ae68d3f7dd32..fda640ebd53f 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -769,19 +769,16 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	hdrincl = inet_test_bit(HDRINCL, sk);
 
+	ipcm6_init_sk(&ipc6, sk);
+
 	/*
 	 *	Get and verify the address.
 	 */
 	memset(&fl6, 0, sizeof(fl6));
 
-	fl6.flowi6_mark = READ_ONCE(sk->sk_mark);
+	fl6.flowi6_mark = ipc6.sockc.mark;
 	fl6.flowi6_uid = sk->sk_uid;
 
-	ipcm6_init_sk(&ipc6, sk);
-	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
-	ipc6.sockc.mark = fl6.flowi6_mark;
-	ipc6.sockc.priority = READ_ONCE(sk->sk_priority);
-
 	if (sin6) {
 		if (addr_len < SIN6_LEN_RFC2133)
 			return -EINVAL;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 8d1ef8e2fe1e..1c6c86c0b8a9 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1496,9 +1496,6 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	ipcm6_init_sk(&ipc6, sk);
 	ipc6.gso_size = READ_ONCE(up->gso_size);
-	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
-	ipc6.sockc.mark = READ_ONCE(sk->sk_mark);
-	ipc6.sockc.priority = READ_ONCE(sk->sk_priority);
 
 	/* destination address check */
 	if (sin6) {
-- 
2.48.1.502.g6dc24dfdaf-goog


