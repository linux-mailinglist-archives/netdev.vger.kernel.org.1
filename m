Return-Path: <netdev+bounces-131334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8DC98E1A6
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 19:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A529C1C22F08
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171D91D1751;
	Wed,  2 Oct 2024 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LKAhsgiE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5271D173C
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890252; cv=none; b=hRRyFxtWsgMcvvYDoFWGsJ/hhZGo8lqlIpN814vMst5G3EdCoXOFKlQYU8AFFkHoEBGnqAyBK/HmVHeUIyB5HJK6+2fhadwfW8kQdxSgHk3AJ3IhTnzPig0k2MWpZ1AlkLTsQrB/0GHErySxp4ulDe9q8xk3t3SMVD2tXWxL1zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890252; c=relaxed/simple;
	bh=Mx9NAXyY/1panWYdtBpAMYDxh3+0RQEKEHcQ7fZZYhU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PlCq294xrVqwNGCheSUaNI4b9I2NX1+VX9xmVkncBjcal25L9eIUGqYJC7sXuhhQQYNv7AQ58z7kjh43PuSqTVZWO8j8xN1VodiHQebwcpT3OM29+Yugel1HSCk+IgyZq6tmcEwVU5KQHmlWe5AXbsrAp+PTUWV1r/s/kzqm7H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LKAhsgiE; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28690bc290so59780276.1
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 10:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727890249; x=1728495049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6krIsvtX8XuYRz/GzAA29M9JLrUvABMa7apKXA969/8=;
        b=LKAhsgiE2rhQNJDeKMHXU2wrTdYNHRgaKviwWwAga44G/QvWuXAxNXNrhOUowwxROk
         n3k2zRg3PF5+ehyAmTv4f603I6cSgY4VOHHjBqAaR33KiBokPJxjo7wA/APGKHKltAdM
         uO8dc2lyOIbmh2eqNCeX6TwsK42ylv4tfOkuhmLY0LyUZ4Qbu3VwYfN8wJ+HnyYEhweV
         NG7ywmq26YfUCn8wh0KZDW8Z2fscetPYai3FXvDiHpVzyvUdIoimGt4rxWbnG5siKHKR
         9Sf5D2aVKq8iCIQjNxJKSzeGMuaTD3DVKOsO8cbJH8V1bCZpbrB3vwpIu80cRtrWQals
         hvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727890249; x=1728495049;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6krIsvtX8XuYRz/GzAA29M9JLrUvABMa7apKXA969/8=;
        b=JlptfsEyxB+Z3I/+Ji7NJ/lQP/cZl4JJ+atNJTtM35zzKoUwtAFKEvapDIA9TNhamI
         pFNPiG7JHF7fw/ACGU1HMWL60KCJby55jJyPWV5koOrzrOkLrREWdVAqLp4FGRSub0Ze
         ihX8w/gK8fGXC/uk3oYeIIk5Mq7DYimPquIUa8AJGaEIFWcx5Ux1pmZVcfsKPHksnuxF
         AS8Mk5PvLuiiAfgalTohJqpeB4MJd1W7skEoUHSYwa2hwmLtH/VM9KbEskxNRklKTgsW
         pha7ITz18d+l6O1/PQh1VLqKU+dhsc34SI6VrrlrSjM8iTsN2bvgl1o2/er0vYJ4inW0
         9PLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsfqxK25swTkKvTusq3Vnd6d18fLdo+od229w7xDlTW5iTzpGUy6W+MUjTdl/kIz6K+AJklKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqKi/1EUq79GbnNb7LFWzmdnEMz7Ju9CMCtM3l/hG/UhR/7Lq1
	CtJ2NdpQKlqxIZeOx+2KGF2hIXz//Ej64sRGdqcsP0ZNdTLcUon5dpjK68TFP4jvOTkuyoEwqlH
	S6hKtQjHPYQ==
X-Google-Smtp-Source: AGHT+IGqSoiL1LzssJ3SQ9XcexQ6smWfeWWTWro7wOAO9TZpxvhW01YNT1aM3CXbgVtNHjocMKbm5gKC1fASiw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:e088:0:b0:e24:96b1:696 with SMTP id
 3f1490d57ef6-e2638382b0cmr2237276.1.1727890249270; Wed, 02 Oct 2024 10:30:49
 -0700 (PDT)
Date: Wed,  2 Oct 2024 17:30:41 +0000
In-Reply-To: <20241002173042.917928-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241002173042.917928-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241002173042.917928-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] tcp: add a fast path in tcp_write_timer()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

retransmit timer is not stopped from inet_csk_clear_xmit_timer()
because we do not define INET_CSK_CLEAR_TIMERS.

This is a conscious choice : for active TCP flows, it is better
to only call mod_timer(), because there is more chances of
keeping the timer unchanged. Also inet_csk_clear_xmit_timer()
is often called from another cpu, and calling del_timer()
would cause false sharing and lock contention.

This means that very often, tcp_write_timer() is called
at the timer expiration, while there is nothing to retransmit.

This can be detected very early, avoiding the socket spinlock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_timer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 56c597e763ac7a8cebeba324f84e57b1eeeae977..b7266b9101ce5933776bd38d086287667e3a7f18 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -717,6 +717,10 @@ static void tcp_write_timer(struct timer_list *t)
 			from_timer(icsk, t, icsk_retransmit_timer);
 	struct sock *sk = &icsk->icsk_inet.sk;
 
+	/* Avoid locking the socket when there is no pending event. */
+	if (!smp_load_acquire(&icsk->icsk_pending))
+		goto out;
+
 	bh_lock_sock(sk);
 	if (!sock_owned_by_user(sk)) {
 		tcp_write_timer_handler(sk);
@@ -726,6 +730,7 @@ static void tcp_write_timer(struct timer_list *t)
 			sock_hold(sk);
 	}
 	bh_unlock_sock(sk);
+out:
 	sock_put(sk);
 }
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog


