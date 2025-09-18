Return-Path: <netdev+bounces-224526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E54B85DDF
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0E118887D7
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5F43168F4;
	Thu, 18 Sep 2025 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gwnnj2+C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EC231691D
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210948; cv=none; b=J8Lywm2jXR+mzXd+JGPvtB4cTzqqU1IqkCFKCHN4q03Dyl75ZymoXH4Xbq9gx7jo0D0em1R4+f33aiQSWRFjUu1tefnuXm1EdNNmdTalcRHqv4PCX+AQbkhlmSs9TLUc9vN3kaqgR+Um5unPIvmM+HHVXB7NB9Ag4znxWZlbwO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210948; c=relaxed/simple;
	bh=az2yAgODHkk3UNjNvp6YMsZ1T4B3L6irQ9G2CXnjkFA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=irx/amwwz5Ejqv67GoGVkbYyZIItn5S9ar9cnMaF1SUeFqnskg1wsYa4yKYQiXWd5h0LIrvg20KISOnS9P4Z4tgKtNE99XsoBiPxPUtXMB4/pNusW6pYfKpEw6fsGqV35hSWOMx+WhBpWSGE/ORidfocOd4xFNNRbua7shVxfOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gwnnj2+C; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8178135137fso237284985a.2
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758210945; x=1758815745; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U3TluJj0egsx6VGlVnLIyP07QHgIYR+yLagWUVyZmLg=;
        b=gwnnj2+C7oeRvqc17GeMv/bc3wXiA5cV/hD40a7iCsZa8PpheUxD1hCmv3vmkNjfWF
         UNE9mG9sDTHYHgkU+PQU4jQLvA9DOe//cxTAPnJr42KvRV2mCjbEQlOkWXvXzPnjDCK/
         L5glbNvdix0DnwH+s/9pS9X2mhDv38aDwkySiLIy5/d+Oiy3w4LHgMJ1fz29IeaquVBJ
         Oqb8tqtvKgc5wLIwJEQh52yCzgld01k0SMuTbJM28iIneDDS8F7dMfzA8PLQWmjz9ngM
         3ddnPtLD75Txa6dSeFwNSVlbNfVbKgAzLKEFw7NXHmd4xda/a6TMm3yDOnb/p+bX5EXp
         nOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210945; x=1758815745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3TluJj0egsx6VGlVnLIyP07QHgIYR+yLagWUVyZmLg=;
        b=ELrR+sNBeyy/vU6ZamLsr26FTHeBZw+U+87GNNn5YZ9VLqoVtZZhDKjeNAHBoeWGuu
         TPvjpOGhrJ6t3/Rqbm0aiDYW967VYCK6MDUZOgQuZ/WCl6TlvuwhXiNf5va8Sf+SPf+9
         pi0tChWFSeZIS8SSE9uqJU07GicxcuaUWPyG9GQ5sDbhhpfz+MyO0VRH7oUHN/uG8Rpk
         ZN20UW5IhkTAPi+LYzSVMEN3MZ0CoHDq6cv1GvpHpT21oD20b4QbL1P8LBSAnXxNn2VC
         98ZcxXKlaJNEW/0imKxBlFeDmLDOVCJDwF5YllgNvWnZhjbc9m3slr/FNfyEpY2kLpTx
         7ysg==
X-Forwarded-Encrypted: i=1; AJvYcCU/j8hu39vp2KmEweP2PMSWWs0WPLijvV4+GNUpT7D17XpDDkLYUmOUaPMuSZbD9E2pxbeGHtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy90RqzJIu/Y3wVcCuyn/izDUaY5/CIFYf25JiZzxkk0Dw9y++C
	wn4I7OQUfInBtBCuep7euAyV/Q+HvOUsJC4ZA352dR48wos8XWIShCjwKrsJ/YD7/NuSv0zZt1k
	e7OK7pWv+UJ5b3A==
X-Google-Smtp-Source: AGHT+IG6N54dSfOJjCohOcVrl12xs6oYf/UjJgoNKx4QpaZpDXw1gDFKm4Q9azy/23pG2F+/1aQfzsjWlOP7Mw==
X-Received: from qknpb18.prod.google.com ([2002:a05:620a:8392:b0:80f:d3f1:62a6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1491:b0:829:2d2e:4df1 with SMTP id af79cd13be357-83ba40ade93mr7793685a.25.1758210945342;
 Thu, 18 Sep 2025 08:55:45 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:55:32 +0000
In-Reply-To: <20250918155532.751173-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918155532.751173-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918155532.751173-8-edumazet@google.com>
Subject: [PATCH net-next 7/7] tcp: reclaim 8 bytes in struct request_sock_queue
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

synflood_warned had to be u32 for xchg(), but ensuring
atomicity is not really needed.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/request_sock.h | 2 +-
 net/ipv4/tcp_input.c       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index 6a5ec1418e8552b4aa9d25d61afa5376187b569d..cd4d4cf71d0d22bdb980f6e1cbe10e8307965b0e 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -185,8 +185,8 @@ struct fastopen_queue {
 struct request_sock_queue {
 	spinlock_t		rskq_lock;
 	u8			rskq_defer_accept;
+	u8			synflood_warned;
 
-	u32			synflood_warned;
 	atomic_t		qlen;
 	atomic_t		young;
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index f93d48d98d5dacf2ee868cd6b2d65a396443d106..79d5252ed6cc1a24ec898f4168d47c39c6e92fe1 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7282,8 +7282,8 @@ static bool tcp_syn_flood_action(struct sock *sk, const char *proto)
 #endif
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPREQQFULLDROP);
 
-	if (!READ_ONCE(queue->synflood_warned) && syncookies != 2 &&
-	    xchg(&queue->synflood_warned, 1) == 0) {
+	if (syncookies != 2 && !READ_ONCE(queue->synflood_warned)) {
+		WRITE_ONCE(queue->synflood_warned, 1);
 		if (IS_ENABLED(CONFIG_IPV6) && sk->sk_family == AF_INET6) {
 			net_info_ratelimited("%s: Possible SYN flooding on port [%pI6c]:%u. %s.\n",
 					proto, inet6_rcv_saddr(sk),
-- 
2.51.0.384.g4c02a37b29-goog


