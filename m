Return-Path: <netdev+bounces-224438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4E1B84C7B
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428E53AB77D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A0A2FB62B;
	Thu, 18 Sep 2025 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lwq91pyk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F6119E7F7
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201611; cv=none; b=r34/cvxudwaL6twJiOe8c5vh7X6rPM/gYw1UjljhjTmC1jpqy3yyN06OIg0L/BRQyXtIXUvkGLpy458WXVnDcRu/DMXSfCs+PgFF+tSqTv8LHwjOCThwwF1Wke0cxUIztQMcvRU2fnkHeG/xwiw+EPCgcFyjS7kuvuNPhk8P5Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201611; c=relaxed/simple;
	bh=VTblUJUbLun3X1WvbZdqfGgyMgvlowuldbVp7T4kJOY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Y4h2kRy3GWDTjhBS1etCz43meZNa15AOM/zx2PgFkeMAG77Eye+0GwOjHwYXjQpHNIMwtcFb04Ik5VHraU0Mgja6tAr4aqhgTlo3bA4L2zvD9tgaoYNsukezO9ZMBttPBzbNAn7W8PO5S4pBdtN49JR7RI42rNfFn9vsu+/fihE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lwq91pyk; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-804512c4373so188745985a.3
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 06:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758201609; x=1758806409; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=txXnyi8LvTmFUtT8dUwwZLSLufR0inm1maIv2kHZBN4=;
        b=Lwq91pyk/byEa/HlKE5iNKulhr/tCMVv/F2ElE98RXQffx3BblGsQxdbMTATaD5YqM
         /S303h2X4k3qA8HK0ruSTRHVZKTtVqCpe0vPqJPGg3I6MLwL0TvuF/Ka2XKqqWAejIXm
         8vD7CkXgMlQdA6kqWERA+9vNGXh1GVFHgpETudqix4MnmMpRYusoZhX9Yp+rSZh1/mKY
         st29XY1fbT8dlQ2oRi9qIh8ZciBHs3PrGooMZMJRIEmjpJ6qnb+0HqDBuknxjfDMLQsy
         AyJCYCsAO1nrWiVAE7/r6lRXl55cW0uVeFsWpKCR1x42CRjTh+vJuqzgd3nkw0FFIp3X
         xc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758201609; x=1758806409;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=txXnyi8LvTmFUtT8dUwwZLSLufR0inm1maIv2kHZBN4=;
        b=EAMBQiT4VCpvXyR2p8FgD7jt6pQz2UP/QimBlWkEqvyThq0CY4mO1Qq/6Y1ed/fYUy
         6pZ6KyOwy+OA9BufNxFDl4pSoeQa4/c9EZ1Y/R/dqPE76j6IlGERIF2JZy9yKvEaETrD
         wRcHBPGO2sG9yrrMofx8Z5QVZ/E+Xv+/zPLaT6GWwJ62N1Yzw63ZoH0N6uLBqT/ZvzwL
         dpsOGMOr1i1JjddhfQTN+GcA12u1W7d5hs3CAx7B0q7qy+O2eE7bsy/XrcnJHct1Vw04
         k8PhuamRSGBxZJ7vHkOhvV+8m5SfWvHAHM0LywFDRi30LCGUe5y7NmjYhucp2eKBSnkL
         zixg==
X-Forwarded-Encrypted: i=1; AJvYcCV/TpRgSuDhMHG28x1JYSyvtjw5cpRtT7pwIv8t2SwcI16tNdIFy2r6Le355EybQmGCqsAaWn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAeJklJI5NTyFGjksKj6x4IL4L8byAeDWpj0H9/KFosIeLdyfW
	bbbXC0mW2gQd+NGDhbIVq9/x+Rmt4nayE7pjzJ41yuhzm0xlA3Jd4qgORdaf/Q5DzW2+glEEBxD
	74xPC7lTna8gA9Q==
X-Google-Smtp-Source: AGHT+IGtkq1IbmRdA5HWNcPi6XKNjWn3GkalHE+30A10eIkKRuk4ltRnrxSyfVlFxxx4Xj46oyGCTa1WllyVrw==
X-Received: from qkoz38.prod.google.com ([2002:a05:620a:2626:b0:7fb:99fd:1071])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a87:b0:801:a5f7:1645 with SMTP id af79cd13be357-831172ba4dcmr523494285a.85.1758201608824;
 Thu, 18 Sep 2025 06:20:08 -0700 (PDT)
Date: Thu, 18 Sep 2025 13:20:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918132007.325299-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: prefer sk_skb_reason_drop()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Daniel Zahka <daniel.zahka@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Replace two calls to kfree_skb_reason() with sk_skb_reason_drop().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
---
 net/ipv4/tcp_output.c | 2 +-
 net/psp/psp_sock.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 223d7feeb19d4671fcbc9f21caf588c661b4bbe0..bb3576ac0ad7d7330ef272e1d9dc1f19bb8f86bb 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1586,7 +1586,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 		err = tcp_ao_transmit_skb(sk, skb, key.ao_key, th,
 					  opts.hash_location);
 		if (err) {
-			kfree_skb_reason(skb, SKB_DROP_REASON_NOT_SPECIFIED);
+			sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_NOT_SPECIFIED);
 			return -ENOMEM;
 		}
 	}
diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index d19e37e939672c1f8fc0ebb62e50a3fb32cc8d25..5324a7603bed64d3f1f71b66dd44f622048519a6 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -37,7 +37,7 @@ psp_validate_xmit(struct sock *sk, struct net_device *dev, struct sk_buff *skb)
 	good = !pas || rcu_access_pointer(dev->psp_dev) == pas->psd;
 	rcu_read_unlock();
 	if (!good) {
-		kfree_skb_reason(skb, SKB_DROP_REASON_PSP_OUTPUT);
+		sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PSP_OUTPUT);
 		return NULL;
 	}
 
-- 
2.51.0.384.g4c02a37b29-goog


