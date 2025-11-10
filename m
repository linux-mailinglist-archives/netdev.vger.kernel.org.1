Return-Path: <netdev+bounces-237135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB58C45B62
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 10:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F19354EA8ED
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 09:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949B8302CC7;
	Mon, 10 Nov 2025 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W3gyeeI0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26963019BF
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767937; cv=none; b=CQBaTZCmVao1w8KGVQdD9UPbm0s29nL4wOnQ5/j5k0V9Erx1KpFcvoIEKOhefFgRwyFWHAHpxLvLnN3HpB1SBOzbmhokfzxfnySbPct5exIXC7XkuwODE8uTHcZeE8+gYUDqKkUKr1/vyW+7sFAhfps1f4p8cwfigJltmN9w2yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767937; c=relaxed/simple;
	bh=2IMaUuZHWdq8mJdKkSWNSiWwGJorDuGAC/7D8NWRUv0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WPhhrZC65wnwjGEfnMYkBpSe+aJOelfO/A6e3B+LO+nQb8VoAUyLBcilHlA1ENwm5/wA6sSj/HB4+Fw6fbKSuN9dIo+aKI5hZ7xrRdP2zFxuHSz1Z065U8LruZxeaaHZXNoy+L/xC4Q3zAUxMilCq2Ma1cPC96/ENGMzVQ4Fkas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W3gyeeI0; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-88050708ac2so91348676d6.2
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 01:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762767935; x=1763372735; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Odq2IEX8OrUzjcYl7vR2j6Y2ZCtLKhGJU/voeINUPmY=;
        b=W3gyeeI0/ACqsckCo8R6QvgL6vGy4M3UvT+l1AeBO1idFuXwPzY6JmQavRvCl4wh4m
         PhAVYn8iDaeTtOdJ6ECBFr3V13Jz33iuUxtYRMalLDAPJgmLMKJKPt21kY5hEKCclAvM
         0ihkWnXdHC7LAl3QAD4DkbKLS2JU9MCi8tferxg21urJO4WtbUhUgJtNXhUKMiffSej6
         3Pjlp/TVIDzdf44cjw5RTGNh9oJwML3f6jLzFNEjiF6wg0Cvzfc1zrliku/Fia7fQaU+
         vPeTH6Oe+SJ09/0XC7b90qtX6vNmix31WTFRDptXqm1cLBO7El6npZrSsFIXY0hnvkv9
         SEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767935; x=1763372735;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Odq2IEX8OrUzjcYl7vR2j6Y2ZCtLKhGJU/voeINUPmY=;
        b=N60CliwGSVytMiPEDpLv6fYpm5lY6LatCuaqlinDRWJ+BJtpaBnBoa0fSkst0neoVH
         x4r1ArwC0QYMG7s29LM7PubeOxNtKSQL+J/kXR1+Mf9dLD1E0zlrtcHKH+/7/v1gGzWr
         7yO7ocrVQYQMsf5C2I8UOxwDVRjXztqdEdds1G/cNRz4uxmSM0bmTNqC4/KsNVQlQMIo
         y4G4J28/EkJAuVPmjTQ2wiLebyUVt5f3IF0+5dDKOmC4YM0DTAJsFk+3k+mQRfU3z+YK
         AyMHI+2RvS+G76PT3QleBzoN1WNv1oz+PGY0VSo4XixGyx9P/EzLyHYrBDM2LxPNdj8+
         4yYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6zZYhz4Oz7EHggOgnFaKO9vk8GlYIHQf/By9oMQ8HVlArMJISjyKoyythLfFaMNbrS6EgCXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtMJfkZDEhS2jGoc/0Ufepaww5frKVEhy1rr31rRf9kHRS6uC0
	geBgX56sgZynH+D8FwdbsXmWaraXSBqjgawNLfERVR7IyEBxu6ePZNSHSih2x0Q8xP3+/Zrd6Sb
	EdbFTn2lXd4BMNg==
X-Google-Smtp-Source: AGHT+IEHu9+/bl1WEOxmC1BGyH8Ya+yQqrwCDC3qSqHUprcsbOAW/yUv5fU5CuuhZ1EGD5yFBvkYuTZcZBuWLQ==
X-Received: from qvbqu6.prod.google.com ([2002:a05:6214:4706:b0:882:42e6:2792])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:f6c:b0:87e:32:8f16 with SMTP id 6a1803df08f44-882386eb993mr103747756d6.52.1762767934957;
 Mon, 10 Nov 2025 01:45:34 -0800 (PST)
Date: Mon, 10 Nov 2025 09:45:04 +0000
In-Reply-To: <20251110094505.3335073-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110094505.3335073-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251110094505.3335073-10-edumazet@google.com>
Subject: [PATCH net-next 09/10] net: prefech skb->priority in __dev_xmit_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Most qdiscs need to read skb->priority at enqueue time().
__dev_xmit_skb()

In commit 100dfa74cad9 ("net: dev_queue_xmit() llist adoption")
I added a prefetch(next), lets add another one for the second
half of skb.

Note that skb->priority and skb->hash share a common cache line,
so this patch helps qdiscs needing both fields.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 895c3e37e686f0f625bd5eec7079a43cbd33a7eb..44022fdec655e40e70ff5e1894f55fc76235b00c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4246,6 +4246,7 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 
 		llist_for_each_entry_safe(skb, next, ll_list, ll_node) {
 			prefetch(next);
+			prefetch(&next->priority);
 			skb_mark_not_on_list(skb);
 			rc = dev_qdisc_enqueue(skb, q, &to_free, txq);
 			count++;
-- 
2.51.2.1041.gc1ab5b90ca-goog


