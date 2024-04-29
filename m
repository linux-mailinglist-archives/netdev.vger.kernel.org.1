Return-Path: <netdev+bounces-92160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69478B5A49
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 15:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7D51C21548
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 13:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504E074C07;
	Mon, 29 Apr 2024 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AJisP3TL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0499745E5
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398034; cv=none; b=lKQt1lj8w8kOlmfoXUHJ89g2uwK2Y1ruBGoCftNo9Rq9L/DpUdDXgpsPUhO7t5qwNKWfondo940SuwWPGkrIMrVpx7EjfoAIi4RSGjLUUcXOPTmmbf+vfCCisa5tA92h5Vc3LGnMeqJg+2HJreDIE302WUJvwyomPnOQz2PKkRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398034; c=relaxed/simple;
	bh=7pV90Q5Ihi9rLSac7cbe5iS2rypHyXNXcMjhPs3Rg7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PixnZr2QqIGxQWNKN3Mmy+lOB8Zxr9ww4OdcHZMqRoO9MGMtUXX12Gtta9NRJhiW69xLv+e0R8KRFU7PPiB0ysDBQFyV13ST6QJtPu4NBkr9u0yq+kZ9Syq59d/Cnh+/px2W0XLfmExNsWWkQjomftLeR9tEeNYPS8nXCK+/biY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AJisP3TL; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269686aso7467499276.1
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 06:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714398032; x=1715002832; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fSlmQg4KJrc53W+wqm3ZW/aeFGj8jFIF2sA21GFh/RU=;
        b=AJisP3TLO81IiTACvbC29FKcrvj5NwjvUfFneimvRNtvcmRVV0fcsd8TINLvuHj5lC
         qyEvyInGor9Zr0H5u1gelqqZPB2Shs0vSR1yD9FCXYQv+yUGWkSRRFhzV6btCScdBPAa
         5di8Kq2431cj3j/JrmCyHXutar24N9auIrK8G4fuo+vSEaZR+y65Vc4Oi4PsTkEqh7wZ
         P51lkQHko76l50o9YPTdT2Y8+Gs9SCgS8yse8PBDIl04T5qkNtC8v85qiilLZI6roBbG
         MqJjSQmMBaz2Aegkl8U8ok74oL/emnjYm+AoHtvJ/7n/0YuTj0c6SnCy4jqOsDs7kO2S
         FQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714398032; x=1715002832;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fSlmQg4KJrc53W+wqm3ZW/aeFGj8jFIF2sA21GFh/RU=;
        b=Ll4VNmzOBEzg3U489yzC9UVOnGUYUqrC47sqZCO9VMh2uJdXB2vnxe0kiLB0+Cu4Vi
         Yv10nmKao3j9zg3Fzf5r7AjOuVAEIqFBBC8JVoByhs4xLxLZMMqmARVzwfrfUVEHfKYY
         IBeS7pjWFE/h9KqRE+3tbRlKYkjFB/gUv8GHbtQ/tDPTpEHTaDn1b4ULYw266B3e1tGv
         J60m/+7qM5NO9PIRvvwC7d31xI/G5ZVmuwkXGkhL2Gf0Ey1vdBPqRK9n0D9skh9993lc
         7UGwg/EOW1SffzKABogRAFN8FreyiuM956ymc+mNcLYrm3V2ebilKHp5yIRvybdg2CFW
         LcuA==
X-Gm-Message-State: AOJu0Yw/1Bgh7Ae5owaKmDrWgHiySngHr96rulSKyWkBFvVxifcedDEM
	5rKSUZwD2NfVM33YNQdnPp+TNie4wSXVsSJX41R3NHIPokNIFnScLtGW7HlUC5Ar1qPVDGUTsDw
	WpXSruDhKIg==
X-Google-Smtp-Source: AGHT+IEYOhc3vHQS7/QV+Kpdv3JY9wgjOz9vfdDGJfHGkjqzRTEojIeYxV/Mghn10wQanTNEEcEgygq/OULPiw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:703:b0:de4:c681:ca96 with SMTP
 id k3-20020a056902070300b00de4c681ca96mr671511ybt.2.1714398032004; Mon, 29
 Apr 2024 06:40:32 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:40:23 +0000
In-Reply-To: <20240429134025.1233626-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429134025.1233626-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429134025.1233626-4-edumazet@google.com>
Subject: [PATCH net-next 3/5] tcp: move tcp_out_of_memory() to net/ipv4/tcp.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_out_of_memory() has a single caller: tcp_check_oom().

Following patch will also make sk_memory_allocated()
not anymore visible from <net/sock.h> and <net/tcp.h>

Add const qualifier to sock argument of tcp_out_of_memory()
and tcp_check_oom().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h | 10 +---------
 net/ipv4/tcp.c    | 10 +++++++++-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index a9eb21251195c3707c892247bfba5b430e7bc1bb..39e36b9a5f1c11462b0ff01a2de7b08ee0fb9258 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -296,14 +296,6 @@ static inline bool between(__u32 seq1, __u32 seq2, __u32 seq3)
 	return seq3 - seq2 >= seq1 - seq2;
 }
 
-static inline bool tcp_out_of_memory(struct sock *sk)
-{
-	if (sk->sk_wmem_queued > SOCK_MIN_SNDBUF &&
-	    sk_memory_allocated(sk) > sk_prot_mem_limits(sk, 2))
-		return true;
-	return false;
-}
-
 static inline void tcp_wmem_free_skb(struct sock *sk, struct sk_buff *skb)
 {
 	sk_wmem_queued_add(sk, -skb->truesize);
@@ -316,7 +308,7 @@ static inline void tcp_wmem_free_skb(struct sock *sk, struct sk_buff *skb)
 
 void sk_forced_mem_schedule(struct sock *sk, int size);
 
-bool tcp_check_oom(struct sock *sk, int shift);
+bool tcp_check_oom(const struct sock *sk, int shift);
 
 
 extern struct proto tcp_prot;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 388f6e115bf168e6f70b762096a984a2cacfa5c9..0a3aa30470837f27d7db1a0328228b2e3323bad0 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2752,7 +2752,15 @@ static bool tcp_too_many_orphans(int shift)
 		READ_ONCE(sysctl_tcp_max_orphans);
 }
 
-bool tcp_check_oom(struct sock *sk, int shift)
+static bool tcp_out_of_memory(const struct sock *sk)
+{
+	if (sk->sk_wmem_queued > SOCK_MIN_SNDBUF &&
+	    sk_memory_allocated(sk) > sk_prot_mem_limits(sk, 2))
+		return true;
+	return false;
+}
+
+bool tcp_check_oom(const struct sock *sk, int shift)
 {
 	bool too_many_orphans, out_of_socket_memory;
 
-- 
2.44.0.769.g3c40516874-goog


