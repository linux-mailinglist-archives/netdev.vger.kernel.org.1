Return-Path: <netdev+bounces-240695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02655C77EC7
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 09:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 7E393321EF
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 08:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958F533D6E9;
	Fri, 21 Nov 2025 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BZeQsKiw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB35533ADB4
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713995; cv=none; b=Dfw9S0Q7EOjthspQP4+4Qi2eEVri66FowB+ePFYF5x1eVt0Uz+f1z91oQFZz8SvNnpIdPznltvegrOLyDLZ94b9wYSUtBj03uL/E9kRNrWJfdad6oOWgHDskRE2uC3Y00lphZI8GRVM+YtS8gbVM049NWcKkmGp8wYXisz4rdnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713995; c=relaxed/simple;
	bh=DaYh4eacIzj7fnVYuLbFxktmBe5fYbH300IH3QLNkBE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BfD8mL+J3fpoTljZw0M+h1IOH355DwLfGg3BZgZozKhB2f92F2+smkV5pfgKnbjcKMzwapFcnhtyP9V0/Bxfo4L1sLjcHdBEgDzQdPQF9/sUH5YnVrfXbh4N7pRPXNdXHZbzMsKYr7wQn4CrZ2DzFUbf89VokIBGhHHPV9HaPGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BZeQsKiw; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-88041f9e686so55844726d6.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763713993; x=1764318793; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+O/PECJ9fW+HIpQreYW08Vwvliv5LsH0C5HRev27oE=;
        b=BZeQsKiw8g9nkQCXX9xv+j2CFKKak+ggGxXVQw+/w8RZbflsz2AFsUADUpuSCi9w5Y
         V3ETYhhxtWCYAmI7v22odqQK3s0fYleJAOO2Cmo8yK/Q44GjrghrJv/+mMvSbXKpCbL+
         77FOuXyU5P2lYPjraa89du06V95ONaNjWoj2TXjkhUgDN4QpQEw+axaA5COrpHnYow39
         vNC7C2LfnBoVOCEHXOpvTRJSpyTAcjvA6kZBsOfAL5XaJw1Xd4t8hvh3EA2FESs7MNWY
         w0JVe4x614NDNcYKvfPReQOBhIXrydOSKV3UJ+RbzAkbV8o0Xn2TnXfModBkuik2Q6Mv
         P/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713993; x=1764318793;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+O/PECJ9fW+HIpQreYW08Vwvliv5LsH0C5HRev27oE=;
        b=Zh0d15cGv7XFBweXMGySFZZhUdccYRN5DsYW4cZZYIWvG7Rz3pGjmgyYskbH+KEsym
         /sflTKtliRsGYLV60Y+XzxHqbBp0aRRaPwI1vHIrxwB0FTqWWjxQ9p0RX8BLapzVZzs7
         oF0RAi6972S3mXTEIfrVNZPC8e1g9qsygEBoTq2eYMrmjqBWzYVxNxuQmO5AsjEdmrHO
         wPibCEKkdIAQCDDpB5KF6LMptMMne+G0T6ZbAHOuJtAluVuXZ0HI9tPdaEECD8JLS5UB
         X1hZr+k8oo8PWCQ+czkTy2QokQIAoNbrBh/TjlOkrbevX9bSSE3w6rLSvkaZ7t+Ry5y5
         98Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVJwre2sDF3iZ2PgwZn3Ss7Uvy8QYVI/5FmQQPpEN8CG0DX8t0EJ7X43i132ZGEL0g/LPGDh6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcxdBsbxJPlsFgXyHS5d7RSOD63Gq5eYsxXlsvek/8McljFO9x
	dyC7vgFKvSHpYl+xpXAYrw8JJWiZeUHJcZxnbOcgDBta00i8iZr/+H5g5ZeNq+QHe7hWvm29f8V
	p1CMPCmoyOqg+qQ==
X-Google-Smtp-Source: AGHT+IEBIuUMOSTo1/GDd4HexicW2Cm/f7InEONKZSe/8dWSFOa4riuKAq2W1e2T9jyZ6pW+jfqkg4KXtyyU+w==
X-Received: from qvbpf7.prod.google.com ([2002:a05:6214:4987:b0:880:44cc:d923])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:1d06:b0:880:48c6:ad02 with SMTP id 6a1803df08f44-8847c53435fmr21203746d6.52.1763713992891;
 Fri, 21 Nov 2025 00:33:12 -0800 (PST)
Date: Fri, 21 Nov 2025 08:32:53 +0000
In-Reply-To: <20251121083256.674562-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121083256.674562-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251121083256.674562-12-edumazet@google.com>
Subject: [PATCH v3 net-next 11/14] net: annotate a data-race in __dev_xmit_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

q->limit is read locklessly, add a READ_ONCE().

Fixes: 100dfa74cad9 ("net: dev_queue_xmit() llist adoption")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 53e2496dc4292284072946fd9131d3f9a0c0af44..10042139dbb054b9a93dfb019477a80263feb029 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4194,7 +4194,7 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 	do {
 		if (first_n && !defer_count) {
 			defer_count = atomic_long_inc_return(&q->defer_count);
-			if (unlikely(defer_count > q->limit)) {
+			if (unlikely(defer_count > READ_ONCE(q->limit))) {
 				kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_DROP);
 				return NET_XMIT_DROP;
 			}
-- 
2.52.0.460.gd25c4c69ec-goog


