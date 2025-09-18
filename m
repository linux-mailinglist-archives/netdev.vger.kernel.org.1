Return-Path: <netdev+bounces-224523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E481FB85DB7
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5701A3B7BEF
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E1B3161AC;
	Thu, 18 Sep 2025 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hqVQDgNG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CE8316190
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210942; cv=none; b=CkJWjiik2lZEHmz0BL49AXBlqw3KIjWn6bv9dfHwJksZDU6uXjCftXvbEQENGX8vGC/aPAjz7PQQSIPNwSJVORv1bsoxj6TdCSBdVW8rnYDCUPs4TLK9O7YvBvevgZWE+TumRM7nIV9rKw3p0wJbQZgvSh63j1v158W5zQcS+bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210942; c=relaxed/simple;
	bh=CcH/NSm+rkkVdqBZnUt8E6uTNOn0XgDElfk11BxxGR8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qj8Bb0u9p/BI2TFNMk22pIy3G2Uk9+C+Nu3b9H0Y5x96yNX6C/qSQ95MVyEuESXPq+d7qseLK+YcTAYsji2reoZZWkvzT58qOzVTyV42+UUniMZwYMdLm2ku+7/gBSgxoahqaHFivGbROjYuXOe3WsIfF2GqI63Lk4EF5gYqdfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hqVQDgNG; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-827a6eaaf18so254995685a.1
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758210940; x=1758815740; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dU7dXc78YH/E6bCin2hdlJBP4obED7req13tKFCBhqo=;
        b=hqVQDgNGJyD7h8XqPYLjRhk+IoNU8BtzPn8bhh9l1/J9F5fkBi/UzFAG6ZhSF72IqV
         XDTqA5TJTCu6CogSGHOqNyK6BlWcEdrPSVOwfN3SQSRq5J8zJCgzrwDkQ9Nq9csxvgNi
         qc8r3amLGHjRTAPBwy18mCOoMC4ANayBa+qleSHHEyNoLLsLMnZbZrVepHbeH0BULbe2
         MPJiQVzV9ROqxdTqeR/65HDmkPiQZGFkHomLx5lOY5dXbuTYN8bdBIFk8jdRlY7thmGl
         S7mm/+1yI17Dh6C3NzlwKl6P75FH5B0IYSxzKIeapMDYxtndd3TQ7214It4uR2IqQX9E
         spKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210940; x=1758815740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dU7dXc78YH/E6bCin2hdlJBP4obED7req13tKFCBhqo=;
        b=NBiDfkQymWxCcXdYcgdvejMgh1Wu/4ldYxW0Eela2y65yAi+R+6V9xVgdMpcidNLPR
         +1Sq8AIYKO689J0XSfhqTPKnsHxyg9dsnMSSJqrmrKr3+rbIYs3NCVNRjLTrkkrilPOB
         LNsLvI2cMiRsiU+elUuSkNrz+7dBBu1+/kDRCYYjI8tJ3YgfOaQ6nf0QkLniBYXIu3fl
         Ewm6QjIaMNRCtnccOjgR+8DYAKzxmLp95odjwEqag5eXKLiVmee7c9DtzwPvoXZc2opm
         iRtDNoaCY7LbCHDb5olPJg0PUw9rosN3Nh/5zzSjWE+JzysTgDi7xKoUqmKA9wssf1ng
         JF2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9dA3jE0+Qpe35DnoDP8d0QhA5pAsRvft9HLlY22fn3jRxu7RdoIipSq4/bRK9Ysc4eDSF58U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Az8gbxEd3XEqRnP+0pLpCy0yMYDzCz0uVzPscxyTNjsZ7edL
	bSPKk9iy/pvPwxxagoVTPUrkiCWjiLXIlaweT5Su6kwOU2g8104uRaamBxYA/hcQAAZF+FIAC38
	HkLgd/SB3AjthMg==
X-Google-Smtp-Source: AGHT+IGMV2huK6MnY5yJQM9jNt8ME5LARsgCb9Wqlz9YpPmMUcjBIOMfejVBAGONmckgz9kLdC+hv+ibBvHRCQ==
X-Received: from qknpq5.prod.google.com ([2002:a05:620a:84c5:b0:824:ed61:a93])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:8dd:b0:823:b719:954e with SMTP id af79cd13be357-83ba2d8a063mr8108085a.9.1758210939611;
 Thu, 18 Sep 2025 08:55:39 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:55:29 +0000
In-Reply-To: <20250918155532.751173-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918155532.751173-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918155532.751173-5-edumazet@google.com>
Subject: [PATCH net-next 4/7] tcp: move recvmsg_inq to tcp_sock_read_txrx
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Fill a hole in tcp_sock_read_txrx, instead of possibly wasting
a cache line.

Note that tcp_recvmsg_locked() is also reading tp->repair,
so this removes one cache line miss in tcp recvmsg().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/networking/net_cachelines/tcp_sock.rst | 2 +-
 include/linux/tcp.h                                  | 4 ++--
 net/ipv4/tcp.c                                       | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 429df29fba8bc08bce519870e403815780a2182b..c2138619b995882663a06c2a388d5333d6fe54f0 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -57,7 +57,7 @@ u8:1                          is_sack_reneg                               read_m
 u8:2                          fastopen_client_fail
 u8:4                          nonagle                 read_write                              tcp_skb_entail,tcp_push_pending_frames
 u8:1                          thin_lto
-u8:1                          recvmsg_inq
+u8:1                          recvmsg_inq                                 read_mostly         tcp_recvmsg
 u8:1                          repair                  read_mostly                             tcp_write_xmit
 u8:1                          frto
 u8                            repair_queue
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 1e6c2ded22c985134bd48b7bf5fd464e01e2fd51..c1d7fce251d74be8c5912526637f44c97905e738 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -232,7 +232,8 @@ struct tcp_sock {
 		repair      : 1,
 		tcp_usec_ts : 1, /* TSval values in usec */
 		is_sack_reneg:1,    /* in recovery from loss with SACK reneg? */
-		is_cwnd_limited:1;/* forward progress limited by snd_cwnd? */
+		is_cwnd_limited:1,/* forward progress limited by snd_cwnd? */
+		recvmsg_inq : 1;/* Indicate # of bytes in queue upon recvmsg */
 	__cacheline_group_end(tcp_sock_read_txrx);
 
 	/* RX read-mostly hotpath cache lines */
@@ -252,7 +253,6 @@ struct tcp_sock {
 #if defined(CONFIG_TLS_DEVICE)
 	void (*tcp_clean_acked)(struct sock *sk, u32 acked_seq);
 #endif
-	u8	recvmsg_inq : 1;/* Indicate # of bytes in queue upon recvmsg */
 	__cacheline_group_end(tcp_sock_read_rx);
 
 	/* TX read-write hotpath cache lines */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 24787d2b04aa3d442175df41e0f507ad60398120..1d8611ad4c88f164eb45a54e1f6b812b1d02637d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5123,9 +5123,9 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, snd_ssthresh);
 #if IS_ENABLED(CONFIG_TLS_DEVICE)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, tcp_clean_acked);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_rx, 73);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_rx, 72);
 #else
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_rx, 65);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_rx, 64);
 #endif
 
 	/* TX read-write hotpath cache lines */
-- 
2.51.0.384.g4c02a37b29-goog


