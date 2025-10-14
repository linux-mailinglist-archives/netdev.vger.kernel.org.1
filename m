Return-Path: <netdev+bounces-229336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD422BDAC0D
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 19:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FCC24EC478
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E465305976;
	Tue, 14 Oct 2025 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uYVM/rwg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66973016FE
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760462355; cv=none; b=UocD1rj8B/AJV6lK9NdeS11MIQrfi1mCRnGWQqmqQqwAq9xOhyQG+ZLEyPlSNci1/e8Ks3LWvziWbefeZK80Jd2DB09afTzrXFqrq8Wp2pm0tdUWlUkG4i7TFPMWBXL+T17PQjnClWTPGws9zG5kBLsPSYilUfXWWl2db5G/1/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760462355; c=relaxed/simple;
	bh=s7hXqZX/bf+HlAkXJC+jVIDeHKcKiEvKJ4j9LQoShp4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b++iBDWvSAbMA5Md4f0RIk5IZZ182vAk4n2MtcqoxDzzr6F/TuaAzp5IyUhVkMbxBfFpzYoozgDzSPzZPglA0XJp5c15t6R12+zJYVWVYNOWOgCqSHuAUD5/dGAjMroeuEt9kOCZU7P0EIflh4IAgKLLslxfeHBr6OUqZNvEYXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uYVM/rwg; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7810378d885so100760337b3.2
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 10:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760462352; x=1761067152; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yOrLaM2xGUKFtw+Sf75Vy3AaINXKTF4KJfCNxd8iM4o=;
        b=uYVM/rwg0hpPQZ6vQNqLZiLk4QAKUDKjLrsjdlsA9cOzwmfOmqC+Bd2kojgVa7Joze
         9V50ZPQoSSHhMNpQtH8afJ+LlxFcajsxebWOOmODFwvfMKjAKLOU3CWJFxr3F1CqYZtV
         UIeMZlr0Dmkz8gAtTyf57uSIsToIg+PW2gB548N7fYnjS63/4pfITr7PxE24jFTaSRwU
         y5jvsaVgr3yu1Nq30M6+r86t9rVF8uYXp225R0/m4ziuwYdut4fKIOcmQDDFJN7AKeDg
         AXU4qkN87ke7tbMxRDxVX5BDmt24Y7LrCmAzPatgt2GSYYCgeNjjkA51orgbHIh7MwcC
         t4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760462352; x=1761067152;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yOrLaM2xGUKFtw+Sf75Vy3AaINXKTF4KJfCNxd8iM4o=;
        b=gVULUNPhN1rLyumpELWgyuoFBaJNTrmiIBxIJ/9UXI/FmfM17CRGkHpNod6gTLP/5K
         6XD/0BzXrfzO7yN0gWAjrBRr4EC3gqoRkmVSsxov4FlZAiga4AgSVed+Oa0fACPO8RDl
         bCtr77lu43MSSBUtcNWwLLbBg9P92uXH7FS/NesgB6nOvh4NSUiJj+vzyOWvZUT/plDl
         +Pbm9y0HkcLe7+epVRmmcXcXHTd/gtV9SftC3RpGW3asm3Yk6Xt1vip457Hhn3epcZKx
         tvAlEudAhSaHhytSzaG570VWmK61f2N7QhRbsXQwQllYt0RAPUSCCsjlf5VRoC/rAA5z
         YhaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2A1IZHokpeNDJjifDMCQJF19rQT1H7j2GK+98AGbSUN/K/u69HyS1G1cIp1keaFIzY/TwRwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5xyPGHUqn0NNdw1MZqWDaKW/T9QlbQnCsvJN0+n8kkGtqI+3f
	D3qXHrsxN3iWCX7koaBbUUMTkGo72B9umiR1yLviuCA94iNvud9gxQXO6iqQqhGGfpLksea/0l5
	lxf6Y6v8kRo2STw==
X-Google-Smtp-Source: AGHT+IExSBpUsq0XxwRTMEzC1Ypb7kpaOapoliud5ovd0GfRwqciLZnnU+NaX/m+vbuRy7jWLwq6u8k3WI9dHQ==
X-Received: from ywbjd15.prod.google.com ([2002:a05:690c:6f0f:b0:780:e432:6fcc])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:3690:b0:737:a768:7df4 with SMTP id 00721157ae682-780e170c5e3mr410625267b3.51.1760462352549;
 Tue, 14 Oct 2025 10:19:12 -0700 (PDT)
Date: Tue, 14 Oct 2025 17:19:03 +0000
In-Reply-To: <20251014171907.3554413-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251014171907.3554413-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251014171907.3554413-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/6] net: add add indirect call wrapper in skb_release_head_state()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

While stress testing UDP senders on a host with expensive indirect
calls, I found cpus processing TX completions where showing
a very high cost (20%) in sock_wfree() due to
CONFIG_MITIGATION_RETPOLINE=y.

Take care of TCP and UDP TX destructors and use INDIRECT_CALL_3() macro.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/skbuff.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index bc12790017b0..692e3a70e75e 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1136,7 +1136,16 @@ void skb_release_head_state(struct sk_buff *skb)
 	skb_dst_drop(skb);
 	if (skb->destructor) {
 		DEBUG_NET_WARN_ON_ONCE(in_hardirq());
-		skb->destructor(skb);
+#ifdef CONFIG_INET
+		INDIRECT_CALL_3(skb->destructor,
+				tcp_wfree, __sock_wfree, sock_wfree,
+				skb);
+#else
+		INDIRECT_CALL_1(skb->destructor,
+				sock_wfree,
+				skb);
+
+#endif
 	}
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 	nf_conntrack_put(skb_nfct(skb));
-- 
2.51.0.788.g6d19910ace-goog


