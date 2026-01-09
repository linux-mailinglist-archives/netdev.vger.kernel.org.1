Return-Path: <netdev+bounces-248462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEE8D08D0D
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 12:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B8553004F6D
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 11:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE79334C06;
	Fri,  9 Jan 2026 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e6u/lY3j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A541F339705
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767956860; cv=none; b=sWtoL5HCSfHO7nN2eScfgTFFtT2FrqcnsJTe7LhC8qDfdTjmhyS2AJAh2OJXpT6Ra46uH7pe25wpCrdFq0UZIzpI3QFf88KPrUgSFG1MTaTTuHM+j6YOzZqMWYlAIxRmqOWt8zftOlwTpM3J1AbG5dMFHR2p36IwEU0/8xbCKYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767956860; c=relaxed/simple;
	bh=bClo26dKQKfmtH6wmORSjwie/4l4DK0i8SN38XFShIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RbPhx7VPQoV9AuAg9f2iZ5TFnLuKSD5Yh7uC4wGG3XJBeMdNy1O6wbAgAeFObzrWrRgRNpK9H86y4Sogo6Urv82W/MSwJzKqNbYcGfOhFqxT3EXd6FYESbkV8uqqkO/hcyeNz/tngFrkPq8LHnK4OME+hN4rCat694tze1FZLEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e6u/lY3j; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a3e89aa5d0so30603055ad.1
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 03:07:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767956858; x=1768561658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eD5pHYGilsMyb5v5eXOJGZgBHsDewfP3AwzPbcKcT5s=;
        b=NW0OvWQnKgSNt3GDNscUaw21veyoSaud18cK9TKVxzqjdg7BD0hyzTzg7PycBR4+eB
         9Viin9oDWPx5imINFpbnwdLZ/p+2N1Yb++Z+ipzWWrQ2TWZ2cTjUD8FZOaLyIWcUp7HD
         Itjt0mvn7mR58do8n89St0BzNIYQk1cXvExcW1E+kdORye7EGaqNCOaKAlEfdDYH9Kxt
         rjSaaM4wV+tItAGXQ0ohanyZpL2/7dATEIwQJrgD2cQwn4yZGf/zTMoJGCShdEcnDSlt
         +Q+0dM9/91QY1+h86fnxAU8HZl1xBGBPegG8r00uIvEZHY5yB+4Z3Sdv2+FzMVYyoXRX
         lsDg==
X-Forwarded-Encrypted: i=1; AJvYcCVtWHGta7bq39+24uB5qDLtF6POnaYktOnhyo9opGHsfwljfMBHjt4/eeZaxoA06TU3VrYDfXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzILx7qOWnK4OFM8MCaT5HwN/qMsySUYjc1PaZ5MKhqR2/PBKcs
	da0oJUk/7s3vexh1yXt6FujNftY/qfEbZrPDjwdblVz/FGIzUKeLm2afjSMUEAK5QchDU9ZM8ej
	EP59AX0cql1co6k4owkD5llOihCovch9AFoTykMXDLJU5HJJ8LLwyUKacbziKkzsftkmwdJbNvR
	VVA5oSbKjVlEGyefHu8DE/iY2vzEIgjKajdTL7EX6uRi8ejy/PEsXkCGQDW6vneNtkETEqF3nk6
	oJnuR/3aCtr69VXjd0bjA==
X-Gm-Gg: AY/fxX4iaEYlxN/4bh5lVliFoyvhthWmXAZn/v2RROr52aedTqTVMNeEIbpO2cb8+dU
	eJkvkchqvxV7BPLVoLc1LxywWLeKE8w6ae9l72wdM+fR/3K6ZNeGtjOhfdJta2J0S960BctS4fZ
	2Hwr385a+S1VSa12wC6AJh8hxOuzV9lazsu94+Os9l8g77wiiV7tfVKQgDBVXyRLt1vITAHG5Xq
	u40BnNC1utepbcweWtsrLb+XuA6pF0Vz1/P+b0QWRLlyIEywgrsDAVr1KOl8WhFBwtorN+z+Ke0
	dn2BNfQ5A13rxhiwSRJCZuSFwtn3OzabwvZBSjpLYldxNatlfnuMBdXvepJPIFcZ8h5bgYq3RZB
	VxDb/yJAjqFH5RWTG79/5RiWaQh/ZQVvKvQ4AgKjqEB0wtL2rQOHijn1g+1vki/L8ro/KGShRm5
	SZf5I8eFIyvPoqLnh4tN1vGpi3BYAyJ4QAwpoWuplZTrC/5QYMNA==
X-Google-Smtp-Source: AGHT+IGY/5Y5dTzx1kvnNyi29umrZ6aaGyMKZx5qKVmx8nXK9wE1ALA5MmDe4+KqPZEWruxNPoC2G+ENdu35
X-Received: by 2002:a17:902:f546:b0:290:ac36:2ed6 with SMTP id d9443c01a7336-2a3ee42a386mr86359555ad.14.1767956857957;
        Fri, 09 Jan 2026 03:07:37 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3cc4b54sm11932235ad.49.2026.01.09.03.07.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jan 2026 03:07:37 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ac363a9465so3245991eec.0
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 03:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767956856; x=1768561656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eD5pHYGilsMyb5v5eXOJGZgBHsDewfP3AwzPbcKcT5s=;
        b=e6u/lY3jiyHaefD2gMMsIPSsetyln1ny1Vsbu96XaS/t3uXU5mJx/Y3BE/Iky4nuAY
         UtQyGqLngUqAUmrqwPviYJrWPfxzG2YA5XCDj7DdZu9T+ws1CXYSjs5NA7spnr+eOXYY
         09Q2GES7lXRiWZPf8YNJLcQqaE1fWiXgsVRbc=
X-Forwarded-Encrypted: i=1; AJvYcCV7v5sffD/eWgaNJ2+cnga+LnqcYwakb2pc+FGFgOzV1Z6msqNGABP847LciRGnpv/uH20McSw=@vger.kernel.org
X-Received: by 2002:a05:7301:7214:b0:2ae:5d7d:4f1d with SMTP id 5a478bee46e88-2b17d238b33mr8081319eec.1.1767956856154;
        Fri, 09 Jan 2026 03:07:36 -0800 (PST)
X-Received: by 2002:a05:7301:7214:b0:2ae:5d7d:4f1d with SMTP id 5a478bee46e88-2b17d238b33mr8081297eec.1.1767956855605;
        Fri, 09 Jan 2026 03:07:35 -0800 (PST)
Received: from photon-big-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1775fe27dsm8783818eec.29.2026.01.09.03.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 03:07:35 -0800 (PST)
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
	Harinadh Dommaraju <Harinadh.Dommaraju@broadcom.com>
Subject: [PATCH v2 v5.10.y] bpf, sockmap: Don't let sock_map_{close,destroy,unhash} call itself
Date: Fri,  9 Jan 2026 10:20:11 +0000
Message-ID: <20260109102011.3904861-1-harinadh.dommaraju@broadcom.com>
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
[Harinadh: Modified to apply on v5.10.y ]
Signed-off-by: Harinadh Dommaraju <Harinadh.Dommaraju@broadcom.com>
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


