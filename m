Return-Path: <netdev+bounces-224887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D9CB8B3C9
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 22:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248751CC341F
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7132C0F8A;
	Fri, 19 Sep 2025 20:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OwZIRtj4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9B22D23A6
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758314955; cv=none; b=geasaUiQnC8F8zACcRdhI/o+6Yr1KTiRhWxuzsrN4NE86NiGVbIUVYtsgItBgpGtwNIaZ9Ll8RTt3m/ZmzHrW3Zu/3pg6LVqS+iblYBqyOSnxEdqDmtLKwWyWMzVRJ53uOLTAEjl9qyu8QszhJxAzggAyZ2ChCbLY6gnQqQ2EgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758314955; c=relaxed/simple;
	bh=rdG1NWmUVijjquwqhu1eOKo0pCx+t18uSk6BTuFeoCo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hcKEvabP4nPorUlzLhbIjicCdV8/myrXjk+haA+GRNwlhopyKRsyHl9vtlcFg8nYD74t3nSl21ocK2z2LWybL/RHq7KdV/SzQjTuwS0tgoltNXvtj73TxEFpSNtZ6PsDgiz9sqdfkGTIFgdl2oqUafWmT5Rkl67Ys2GWSKleSxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OwZIRtj4; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4b5e9b60ce6so78683971cf.2
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 13:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758314952; x=1758919752; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uk8W71Tuld5fpOw2bD9QoJ0h7Ezm7xSfrGVg9F/vVgg=;
        b=OwZIRtj42Biq8CETLLq76ckPXjS86vUgUW9ouVYCgmL0xs7C/7g7oBXBay6dzcWT2r
         XQB324emk5ZaC0F0/ZrJwrPCCjI0seaYQoXGg89WnNv4rHjwIrq9o9QCR47rglDteydH
         Swz4RmTwfCMZ9TAwncp5RdjIKXgmr8Qp/FJTrwYNOhqRK3WUtxhV3dHe7c7zJrHNuqpv
         PONzKHRSUUrHJ4TRo0YwFvSphRA1jvzWm3qXbAnkOyPpuwLBhT2idXuqCBOgU7F5ydu8
         YI6rWnKTzgZ4/2zpio6qt/JXSWzVXBWP5XIdsGdYt5hHjM1Wk+SjrgMZk3uGiUaFhaeK
         Xz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758314952; x=1758919752;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uk8W71Tuld5fpOw2bD9QoJ0h7Ezm7xSfrGVg9F/vVgg=;
        b=l6xiskk5zu3LhCJi7obe2TGVbjukOABtYkSdQz/k2LXs/xQotb26HEHKuz8jLWHHW4
         HcgKTAqU16rJDlwQdsKfTliZxpzK3v8MxxQxYyZuefmvioQJfmLJElrrAQ38ZIhrQJ+C
         VH0WH/PySaL7PfZnAsYuqNV6WocQk/4mqE0846UfJ326LM6PfQ0BwUjPDRh6S46IukUx
         4ZXeBGw8m5CpX51OPoodpfoGy5CiK9vh/9bPpM0oJNMKvwB07QxtppJxYiZOxy0U6c/P
         3UYD69kahSYkUlIZKLPePAI8w2zRYkcoEH/UJlL92vVzBI61+B7NHZO76iXgEf8kXeFo
         TRDA==
X-Forwarded-Encrypted: i=1; AJvYcCX0CRI1/WTtp2ZVRxUPjbcl57UTh56pm00xQOuGX6P+BWKFeuHYRrPli3TzFc9raJz5cfsRBpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFvXVTusuITv9EKfQK2zV120dDjlA9gjyyJy9U7sEbk6ZSjWCn
	3nw5tPtuKfS94sKqxTzgnkn9+fDETUWliMKtxiSxOTvwSB4eqlaVkKukoQPEQkezR0PxniyTaCA
	FogrF9aF2bqIziA==
X-Google-Smtp-Source: AGHT+IGPV/xfjkqrSqpBq8MJfWq9u+/TKtq24K5qNISY7HerbfI5dcWVVd6wZwiprk3iUMxRO27p2lLs+NpVMg==
X-Received: from qtob23.prod.google.com ([2002:ac8:44d7:0:b0:4b7:93a9:ea9b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2518:b0:4b7:a71b:7eaa with SMTP id d75a77b69052e-4c06cdd8ed3mr54810211cf.11.1758314952102;
 Fri, 19 Sep 2025 13:49:12 -0700 (PDT)
Date: Fri, 19 Sep 2025 20:48:56 +0000
In-Reply-To: <20250919204856.2977245-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919204856.2977245-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919204856.2977245-9-edumazet@google.com>
Subject: [PATCH v2 net-next 8/8] tcp: reclaim 8 bytes in struct request_sock_queue
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
2.51.0.470.ga7dc726c21-goog


