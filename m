Return-Path: <netdev+bounces-190240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81218AB5D38
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 21:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A0B860B7C
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 19:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE252C0329;
	Tue, 13 May 2025 19:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GIJwgkSv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899602C0312
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 19:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747165169; cv=none; b=lKyED7vZVT/AZE9Ruvhw4tKjGzKjzzyNUA8YJmhScw6KwkMpv0ONTIsSniqjDbyqlU6pMoeqT5lkN0Ctux7D2QIOIi8kc+9LZqWsHaWTV9faf4wv70izfkkCc9XJCcr7Bf7yD8Xosh/WTS3c2zHlEdKF3qkoXqPcLrPZ/BSmPh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747165169; c=relaxed/simple;
	bh=WMOYvGl5qmszYfsVQ8YE5fD5TXa947jABy+VAozdgzA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oZK44jqdr0WEIN1iqXZnpZqZAczsBeIjA9tq8CJBeoWMpKqRJYfaA2SJXdNvRVTy2mlubLJ8bMVvzLyyNX/aKGBHl+YcSWdXSBuavR16e20teYTWFa6a/QiaHcZ82HOd1l5J4bcF6Ii3O5HQkWUTHYgcVqI5tEzAtX5GiTrcMwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GIJwgkSv; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7caee990722so1165149885a.2
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 12:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747165166; x=1747769966; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IFuP/Lqi4P3FwpuS5ICeEEdYO5MZT1/PI4tFtc2Kbx4=;
        b=GIJwgkSvokj5Eh95/ZppFn90gcZKPVM+Zz3uRjqu8oYKRfnbcoIc9GvHFlQ1bcAIUo
         mzX+1dV5S53AxR6soa4U2V7O9e7mwiSEkWkIPuxRftOGn7/tYNlMxM/c/7Qrjy/gZIsw
         FUNQEvsCveFl0vwM0dzXLBpy/JXn4clpM/6ybbq2Dqu5U4pLdeZua9IYfpxKj8xtOJyf
         WK5yJup2vGWs32cietLbr5usboYd17FzhZuuZ0wrNGPmDbVdfCOQsdxLxgFYo9/unu8t
         VJQNmPbF3AB6k63WJonE5wXFCr0e8SmLsriatva9xmonAilMFSeBf/DLucEMdtLhsHCz
         zOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747165166; x=1747769966;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IFuP/Lqi4P3FwpuS5ICeEEdYO5MZT1/PI4tFtc2Kbx4=;
        b=RR5oYlXG5GmdnZSYrYuuoh5ag1+5bLzR86Sn4BY7H/aS5qpeMR4qKX+1T1gc5TfCg1
         MzdfXIF+LP3LEivw1i9n9Q9tfFZZLFzZToeu1+w8DxJDj6qDDwE5nb125MNDj5J+FG5b
         ANPtdBQHpApjBJpx6R5nlLN+7YOix6aGRYJuhNleIfhsN/8SSvvHCQOumrjW2lEZVv49
         Im626NtjOh05zbHca9PHr3w3z5yuQDQ75GKdey0n0i8sJ0nIqbgqSCzLdxu4r+7kTv1G
         YL//0hf7TJSd0H/Bs2inBZG4azY2WBPyHYLJvyoMEr7PxB6Wyh2fW3fKu1CHZ9I6JB4J
         8eUg==
X-Forwarded-Encrypted: i=1; AJvYcCUeiccE3WhfIy7TTB5Qfpr3Gp4sPPpW1mZt+3cH+90762kyfW9/Qg8qHaiuC7ljA4aqrzBdlGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUspF8F5TJJATlHMhJGC0TJfunebsfC9ZcGZ9UeZ7d7jVOmMCe
	hQej9uI4tRn/1CSe5OqH1GueZpoZSS9eSrWOeF2vclUCfo2HDd828U3wjUnrZYl8oSc3pTo8TLh
	QEzsm3IRMlw==
X-Google-Smtp-Source: AGHT+IGGYTKhemjF0+7qrAh4yniE+oHB45AU5jgt7a/UZe2DmyX8nUL8hyHbzuMEO2Rlfj9JGVCjyXela8DoLw==
X-Received: from qkpg10.prod.google.com ([2002:a05:620a:278a:b0:7cc:ccf4:e8ca])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:46ab:b0:7ca:c990:8fc7 with SMTP id af79cd13be357-7cd287e8bbfmr113397685a.18.1747165166396;
 Tue, 13 May 2025 12:39:26 -0700 (PDT)
Date: Tue, 13 May 2025 19:39:11 +0000
In-Reply-To: <20250513193919.1089692-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250513193919.1089692-1-edumazet@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250513193919.1089692-4-edumazet@google.com>
Subject: [PATCH net-next 03/11] tcp: adjust rcvbuf in presence of reorders
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Rick Jones <jonesrick@google.com>, Wei Wang <weiwan@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch takes care of the needed provisioning
when incoming packets are stored in the out of order queue.

This part was not implemented in the correct way, we need
to decouple it from tcp_rcv_space_adjust() logic.

Without it, stalls in the pipe could happen.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 89e886bb0fa11666ca4b51b032d536f233078dca..f799200db26492730fbd042a68c8d206d85455d4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -760,6 +760,9 @@ static void tcp_rcvbuf_grow(struct sock *sk)
 	/* slow start: allow the sender to double its rate. */
 	rcvwin = tp->rcvq_space.space << 1;
 
+	if (!RB_EMPTY_ROOT(&tp->out_of_order_queue))
+		rcvwin += TCP_SKB_CB(tp->ooo_last_skb)->end_seq - tp->rcv_nxt;
+
 	cap = READ_ONCE(net->ipv4.sysctl_tcp_rmem[2]);
 
 	rcvbuf = min_t(u32, tcp_space_from_win(sk, rcvwin), cap);
@@ -5166,6 +5169,7 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 		skb_condense(skb);
 		skb_set_owner_r(skb, sk);
 	}
+	tcp_rcvbuf_grow(sk);
 }
 
 static int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb,
-- 
2.49.0.1045.g170613ef41-goog


