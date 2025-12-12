Return-Path: <netdev+bounces-244454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA7ECB7E04
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 05:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B9B43028589
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 04:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD323090E2;
	Fri, 12 Dec 2025 04:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Uzj/D/Hb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD1830AACA
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 04:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765514470; cv=none; b=aKejzz+UMXojBRLgy1OMlYxsnKCdubdUJ1AhL/q0qIv6gifcSi1QodkTLEWC+gBy+8T1Yr6aQ1pAbajQgM6/wI/wmwnmj3B/BX+cWue441uGGgz7WJqWCktB+FO6SYmDmd2wHNg8tY52yJakND/HeaoIfuSmYD82qA3IMGPvgGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765514470; c=relaxed/simple;
	bh=tKseG5gYSJeCAWspW2ZESEYmrC1AP47UvmldaZPNzNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fwYuDRuwNClB/AZntIXrJv+ZLi7mXx1Ey7KyYFakbwFcmV51XR983A5vW7nbvldsS0vRStXgvr7lRsTeAxLkm3D9r36gJeAn1HcAsFesD2OWZ3WvXoUeo+hlRtM1VgbiXKpAtAGY+WmtEZxWONe4RRYl4l6V2zxtfQUbsdrPaQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Uzj/D/Hb; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-298145fe27eso12108755ad.1
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 20:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765514467; x=1766119267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZSzbAqILqIc0sgDWu53ygkH2B1txzwb9FnKFs2Xg3k=;
        b=v8mVcxsr7NF/0pVRSdQX6OLMqCpCE9Pt1+Fb3sxYWigat99qFo5NYTM/zLAEuR01u5
         m75rKZGLTRcw4S0fFwfwUq8JhDXXO6hdz6C8bWbzxTGTv8aLroixK8bvyoTlMFP0aby1
         VbL0eEDSmxIvgIjK8fv2LLisD4ioL7Jv2RnDsmNII916L0CTIlC+FkOY09IjdOMbXNMp
         ZJ7TeY7n3ZjHThPgYUf6sC6vOjMWo3OtmcWU/PJuTCREruimliVHjIzftQRBL80TicCj
         9CZO2K9uNm9pwfCH0EvQqoL9hqQLYOKu7qkBcyw5RQh0X2/Ep+VJUTYd9Cg9d8iYW5pg
         kyhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJgGCGX5ExiziyrraeA9Q5AkB2a0xavmA9CSsPW/vC/Jg5LVAMtOvH/oz0V/RHGviDrkHTQvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx1cyIuL/pDBnfGs1kDPIljVKbSxd0cwYeCz6/D3RzJNNDlyad
	iGBkbCbkWkRjZ4n2MH5/O0KstcvLMaFvoIuwITbDKJyno3N4hzc9ZK9UnoP43M5qt8kOdnKti1L
	GwTUEVFddjbDCKwOzUZkJG46cguTjnEqz25kVjkKaeNXKE7ZbpB9U6mTFcl1+Dq9ZSjmBA3mMWT
	gY/DsdyMWu5oaLcKqcrKRM+jiqCfTSFG0KnM7laVztW2c8Gzmp1oRhPZ7VdBwDqMEwBFEj9TZjx
	vEQDRaLGHcZOHveURDqqA==
X-Gm-Gg: AY/fxX4SGs4VdiwtJBS7wEcckTZrxvU5x6l8IJjVsgefGsFARbyviyXR+VHWOF6ToCd
	giONOUzmLFVWOz1B+r/Zfa9KyyN+Bn+Z2MG7PzwcP0wB/6XjZup7DI1hltil2xc6e6zZYi1CdMx
	J5FAJHdxS1hPxw2E/QHsDNIZ0JANrgaWJbJrH8GElNds1/RvvwRm+KowkvZSZPjMCT4epHQGhGp
	pVzfJWI1gb9WZYmzOrxaEqHYJ2ttUJiTnQ08FkB2VaQJuRb4/9qSiQix09pQ/ECgKfo7Cbcc/8d
	2QgwducMkRM97AZB3ozFov6UCw29Sn0dj7f6PH8INzJV+hSAh8qbCrv+8kgwyYirPduzAe2EK5I
	p6l8z44IByGZVRtLXPZX4eVfB8bJfHO0yd+9g7vnGRsNU8ChQuTHqn0GZnGQbY6jMYjrFf3cFxC
	B9e6r/nN1/QyE/avLOFcqnRmvylbDHCvnGpoE26qlb3VrBzewDKghZ
X-Google-Smtp-Source: AGHT+IHBoU4jm+XxVJU7x8pgWWyZnUxsbbkLo72XZBs2odcpm8+N0epQxRBba8rIWzgv7XYRLu4zAvQ4jXCt
X-Received: by 2002:a17:903:1cc:b0:298:2afa:796d with SMTP id d9443c01a7336-29f23d44e59mr9178995ad.61.1765514467388;
        Thu, 11 Dec 2025 20:41:07 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29ee98ca705sm6377665ad.17.2025.12.11.20.41.07
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Dec 2025 20:41:07 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee41b07099so10528211cf.2
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 20:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1765514466; x=1766119266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FZSzbAqILqIc0sgDWu53ygkH2B1txzwb9FnKFs2Xg3k=;
        b=Uzj/D/HbJWi2EkH5T6/dgPumnDZDSsyIvSkgPtLb6vPge0pINJKG4i/6dShEJ24Bd5
         wdrYKk037nxUZfheRSgLhknTcRUb07uZOXv5+EM2JsmSQvkAjzUHtCWUscz+y9UHdUhb
         4JgaTz4QKpKNO+VTJftI9lTyXJCfS27H/Ue2Q=
X-Forwarded-Encrypted: i=1; AJvYcCWhQSXnzqA6Xkx0gAqSrRkx9eH4f/psaq1CtwQdol+wVMo00kgXyuzjL7D/Rr8voQoExu3m2Yk=@vger.kernel.org
X-Received: by 2002:a05:622a:106:b0:4ee:4a3a:bd08 with SMTP id d75a77b69052e-4f1d066fe70mr9249741cf.80.1765514465916;
        Thu, 11 Dec 2025 20:41:05 -0800 (PST)
X-Received: by 2002:a05:622a:106:b0:4ee:4a3a:bd08 with SMTP id d75a77b69052e-4f1d066fe70mr9249471cf.80.1765514465413;
        Thu, 11 Dec 2025 20:41:05 -0800 (PST)
Received: from photon-big-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5d3da25sm380483285a.44.2025.12.11.20.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 20:41:04 -0800 (PST)
From: HarinadhD <harinadh.dommaraju@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: john.fastabend@gmail.com,
	daniel@iogearbox.net,
	jakub@cloudflare.com,
	lmb@cloudflare.com,
	davem@davemloft.net,
	kuba@kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	kpsingh@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Eric Dumazet <edumazet@google.com>,
	Sasha Levin <sashal@kernel.org>,
	HarinadhD <Harinadh.Dommaraju@broadcom.com>
Subject: [PATCH v5.10.y] bpf, sockmap: Don't let sock_map_{close,destroy,unhash} call itself
Date: Fri, 12 Dec 2025 03:54:58 +0000
Message-ID: <20251212035458.1794979-1-harinadh.dommaraju@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Jakub Sitnicki <jakub@cloudflare.com>

[ Upstream commit 5b4a79ba65a1ab479903fff2e604865d229b70a9 ]

sock_map proto callbacks should never call themselves by design. Protect
against bugs like [1] and break out of the recursive loop to avoid a stack
overflow in favor of a resource leak.

[1] https://lore.kernel.org/all/00000000000073b14905ef2e7401@google.com/

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/r/20230113-sockmap-fix-v2-1-1e0ee7ac2f90@cloudflare.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Harinadh: Modified to apply on v5.10.y ]
Signed-off-by: HarinadhD <Harinadh.Dommaraju@broadcom.com>
---
 net/core/sock_map.c | 53 +++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 3a9e0046a780..438bbef5ff75 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1558,15 +1558,16 @@ void sock_map_unhash(struct sock *sk)
 	psock = sk_psock(sk);
 	if (unlikely(!psock)) {
 		rcu_read_unlock();
-		if (sk->sk_prot->unhash)
-			sk->sk_prot->unhash(sk);
-		return;
+		saved_unhash = READ_ONCE(sk->sk_prot)->unhash;
+	} else {
+		saved_unhash = psock->saved_unhash;
+		sock_map_remove_links(sk, psock);
+		rcu_read_unlock();
 	}
-
-	saved_unhash = psock->saved_unhash;
-	sock_map_remove_links(sk, psock);
-	rcu_read_unlock();
-	saved_unhash(sk);
+	if (WARN_ON_ONCE(saved_unhash == sock_map_unhash))
+		return;
+	if (saved_unhash)
+		saved_unhash(sk);
 }
 
 void sock_map_destroy(struct sock *sk)
@@ -1578,16 +1579,17 @@ void sock_map_destroy(struct sock *sk)
 	psock = sk_psock_get(sk);
 	if (unlikely(!psock)) {
 		rcu_read_unlock();
-		if (sk->sk_prot->destroy)
-			sk->sk_prot->destroy(sk);
-		return;
+		saved_destroy = READ_ONCE(sk->sk_prot)->destroy;
+	} else {
+		saved_destroy = psock->saved_destroy;
+		sock_map_remove_links(sk, psock);
+		rcu_read_unlock();
+		sk_psock_put(sk, psock);
 	}
-
-	saved_destroy = psock->saved_destroy;
-	sock_map_remove_links(sk, psock);
-	rcu_read_unlock();
-	sk_psock_put(sk, psock);
-	saved_destroy(sk);
+	if (WARN_ON_ONCE(saved_destroy == sock_map_destroy))
+		return;
+	if (saved_destroy)
+		saved_destroy(sk);
 }
 EXPORT_SYMBOL_GPL(sock_map_destroy);
 
@@ -1602,13 +1604,18 @@ void sock_map_close(struct sock *sk, long timeout)
 	if (unlikely(!psock)) {
 		rcu_read_unlock();
 		release_sock(sk);
-		return sk->sk_prot->close(sk, timeout);
+		saved_close = READ_ONCE(sk->sk_prot)->close;
+	} else {
+		saved_close = psock->saved_close;
+		sock_map_remove_links(sk, psock);
+		rcu_read_unlock();
+		release_sock(sk);
 	}
-
-	saved_close = psock->saved_close;
-	sock_map_remove_links(sk, psock);
-	rcu_read_unlock();
-	release_sock(sk);
+	/* Make sure we do not recurse. This is a bug.
+	 * Leak the socket instead of crashing on a stack overflow.
+	 */
+	if (WARN_ON_ONCE(saved_close == sock_map_close))
+		return;
 	saved_close(sk, timeout);
 }
 
-- 
2.43.7


