Return-Path: <netdev+bounces-246953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7409CF2CE0
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 10:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CE66304F2F3
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 09:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48923313278;
	Mon,  5 Jan 2026 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jp+SL4EQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DEC329373
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 09:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767605797; cv=none; b=Z6UEYCGpdkRv9UVhX1xOtptTC4/YcI1KNhYeNV8i30+7Lchuf+n1oh709lB/0Q4e+W90fJMVk3Kq+eot1YIapM4FzCY9ZErjQoL6FQRZkKuNB5dMMdP6gRqRSYFLf6TyHtmi6mm+vM/bjQAsalf/jWtXnpEgRn7tZfIWp6zrFpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767605797; c=relaxed/simple;
	bh=xrG1IgJHxF4Z6cQFs07ixva/rLKLyJcIi+p2N40shaM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SJWEL1d6SuJZOsuCwsTYZrkQpRKTyPq//+HVlFEFQ11Tp6eUwrlEOEgU0+vyEShH8107nkE7ViPHICphsPYufvE6tRdtMo39clQ3ND0cbL6GHTcE32GJQLJiHK5bOjQ/2Odqxp+YK65fGswgIZa2o+hBJrUG1kl3Rj9Vc/j2ze0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jp+SL4EQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-79043e14dfdso62271227b3.0
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 01:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767605792; x=1768210592; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5HzVnWxU9Yu2Z5ki+V8ILagYcpICNq5AkhVFodDP7s8=;
        b=jp+SL4EQeQoJ9LghkaAc0bK2+uT3MNrwVUh51N8a7IwzYifUXI6Yrph1vbpasDotF1
         QE2KUP/m1Lf2OykswZhC5j72klAxNBlkcVjsyHildWpnnGhq09OD1ddIY4vkKO5RXI6v
         O8b0DuxOsEPdE98NZK5wCoU3tE12YpXmehKOyRQJoBw5Te2V0T3MR0l/sNnxF13BMUpS
         0WQdbZqPTkY5FJcIqEv6KAGIwxhdRW1B466fiKD70v81s2Dqe+GgzUzlWTO/o403A0oB
         mHh9gR2DSGGAVz7QFhh1STa1PYUmTACtUFxJ8ux6MJgi4ThAWAHvI8EyJWKu1DNhtV9k
         CC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767605792; x=1768210592;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5HzVnWxU9Yu2Z5ki+V8ILagYcpICNq5AkhVFodDP7s8=;
        b=NlNvh7apqMs4/mz6jW6xC3jkCZeMsxwasexS9jLOVf24SiT0+u3kWxqYtmNlJHXVxD
         EMjk5gEMQrCdGSk3LnouNeRnc42Eob6OdbGaP0qmOQk20+E0Bat/n/0Rc0kyZ9JH1ntm
         GG5NnoIxdKBNrWINUpm7N3L51apMRNIVRhRqpRuSyywY+5c53PmAJtL1DowSKqA46JTf
         wwtJMcc5y/KYN/NX+c3d6YoOHzmsaUvgW1kTwsBfwJzEL+HxyWG44rROfUmaO2zgs8sW
         Y/ZE+jWIYS37xS8wsK37gmHP0m5kyMrT2gZzXtSLbMl79aOCZtHCBvlUOkfhhe+jtxPx
         yxcA==
X-Forwarded-Encrypted: i=1; AJvYcCUwspzFu6R0AdNnwpzLlZ/aI5uRrjBl5ycplt0iYzBM9Q6pUhNuDZmZcl6zFxsrRl4SD+R7WTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaT/wduCosTVkWJpigqIzQ01FygxC3XiPydpW9P6zyOe4f1dSm
	0V9ktn9KzETVSgFdrc1f4qpQEkeMj82UIv+5W43M6QY1eWKrcSWJ2vmdI2rb/CYquYLMv9gziAl
	GlwyD7ucfDJkRzw==
X-Google-Smtp-Source: AGHT+IGBKmHSd3NdQL1j5mphIBFu/TaMAZMz/TCd0Z8CBF0gtn6I7U7Pbt/dWXPo8uhIS8gkfQGOq9SW8Ly/Bg==
X-Received: from ybul4.prod.google.com ([2002:a05:6902:15c4:b0:ed5:30e6:515a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:6e0d:b0:787:f341:6b06 with SMTP id 00721157ae682-78fb3f29362mr446753707b3.24.1767605792190;
 Mon, 05 Jan 2026 01:36:32 -0800 (PST)
Date: Mon,  5 Jan 2026 09:36:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260105093630.1976085-1-edumazet@google.com>
Subject: [PATCH net] udp: call skb_orphan() before skb_attempt_defer_free()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+3e68572cf2286ce5ebe9@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Standard UDP receive path does not use skb->destructor.

But skmsg layer does use it, since it calls skb_set_owner_sk_safe()
from udp_read_skb().

This then triggers this warning in skb_attempt_defer_free():

    DEBUG_NET_WARN_ON_ONCE(skb->destructor);

We must call skb_orphan() to fix this issue.

Fixes: 6471658dc66c ("udp: use skb_attempt_defer_free()")
Reported-by: syzbot+3e68572cf2286ce5ebe9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/695b83bd.050a0220.1c9965.002b.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/udp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index ffe074cb5865..ee63af0ef42c 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1851,6 +1851,7 @@ void skb_consume_udp(struct sock *sk, struct sk_buff *skb, int len)
 		sk_peek_offset_bwd(sk, len);
 
 	if (!skb_shared(skb)) {
+		skb_orphan(skb);
 		skb_attempt_defer_free(skb);
 		return;
 	}
-- 
2.52.0.351.gbe84eed79e-goog


