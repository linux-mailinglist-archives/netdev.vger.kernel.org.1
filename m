Return-Path: <netdev+bounces-203540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C78C1AF655A
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 00:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDAAC524541
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B702F6F8B;
	Wed,  2 Jul 2025 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r1soa/87"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700B624469B
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751495773; cv=none; b=cLlxsCOb9yQmdU8vfIeaprImfsWbSnY9umjfXQo+ZbJxgHgYz8IIYKCPDKb/lvuPy0ESDEdTuR5oI+JCQQMwpon4fapAfIBEpIcmjuELJHh3OYarai4tbjxdzwcsY1LpLcxOwqYRQrtQBzCVVnD/LbusQXLmjWMrOWR85WyU6T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751495773; c=relaxed/simple;
	bh=Ec2zhBNEqZVBAaUtoh+dwcbSM9J0PPgGYAYbMYhg9A8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DrVb5vg3rLqLY51rAgP9COxXcs/wPbGybRJMoFKLiLibvaBaA4ZZXkr9T30yuyKMiy+d2zjBQ6uDMD5M0+PrtzKovdx58hl95JOoj8PXc7ZEdEawrKEGy2qaNlpqlm3ET9TGEcu8oyScRCDh6J3Vy4Al8HotzTJnI3ji6/i3uJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r1soa/87; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3139c0001b5so4604680a91.2
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 15:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751495772; x=1752100572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IJUjH6DsAuK/KBRAZqWRqQKo31xReWxNFO3fvTzLCKU=;
        b=r1soa/87+yJAc4T3KM+aoQMcS8NKfznIeiFhDOfOhlnS+38cff53xNNO+kp5bLNJgu
         A3HARSfMr3Cr4K8CiykWhBPcV34CP2CWQNcRtaxxiE2K68N7nZ5CKDs3oA74/6iLgFP5
         a4rgmW2JKlDOKpgbeHCGarcyUHTkI4KN4SU29iR8FaLzJPIp5EXTyAgBZjezY6qi04Kw
         C8TvDpm6i1hoSruO0iRpN5TZ6VudkZl7xwvioUq+HuXFCH3D9JZdMujrQ0RCQ4yX4Sk/
         zt2+UiXbORmNKCDk320Q12aZvs13jgT1edmxcUQxTn+FY2u/jHCb2rJsGz2yC6amEvlQ
         Atdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751495772; x=1752100572;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJUjH6DsAuK/KBRAZqWRqQKo31xReWxNFO3fvTzLCKU=;
        b=oti6L4xUWtyqE/rQLZ9pY6dGD/AIemg8KRiGDKyf/hpYfmK6KGZezg2pshQ0XXfYbm
         eDKo9xabi1TeGM2nUefqB/XhD7WFmRnarqzKsmXK1lVmoxyd67tr8M2jYNJIatov8byX
         27RmzCN04lcN37qb7ZMi5w3G4TcqAGMajkgIm6pZx1oY/pbCJcaCoPqqpqqTREuGYtvl
         zIqdhED7prgpm+0Woj2MK++PVYWoX+ZpIYKDeSaRrjAYOhQ0k7rMpy61Z5HeoD53oUQr
         EY0zNwJJqc6SKGxlZr62V0jxcNEZvAuD8TL0670B7vWPGt5eEYBNBC69MUxRhoOoBN8x
         bMmA==
X-Forwarded-Encrypted: i=1; AJvYcCXfEt5XYm88S1Z/8OVQcCkJlvl0getR9/iFgRPs2MVO9hIoOq5iZlX/rc4MUIFjp0hYxpMi/Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNhkLtTcOl9LrhbNMnH1jkKFckT/eMud9Lkk+EoxyiOIZtSCa9
	fiDQtSonLAy+s0qtHrixpVWuGuSZcJhNVcHKLqZD2wp1OQ/hkfNCYPsnsQ24tIzPr6GSs3X4JED
	TWe9PyQ==
X-Google-Smtp-Source: AGHT+IHFN8rvx7qYc5hxNHiTBvFPeaHzgs4NkhysLVkIyQRVeKxtptUfKkK/NdhB5XlGIFmBQKjPX2OMHA4=
X-Received: from pjbst8.prod.google.com ([2002:a17:90b:1fc8:b0:315:b7f8:7ff])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dd2:b0:312:26d9:d5b2
 with SMTP id 98e67ed59e1d1-31a9d426d45mr1755636a91.0.1751495771730; Wed, 02
 Jul 2025 15:36:11 -0700 (PDT)
Date: Wed,  2 Jul 2025 22:35:14 +0000
In-Reply-To: <20250702223606.1054680-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250702223606.1054680-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250702223606.1054680-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/7] af_unix: Don't check SOCK_DEAD in unix_stream_read_skb().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

unix_stream_read_skb() checks SOCK_DEAD only when the dequeued skb is
OOB skb.

unix_stream_read_skb() is called for a SOCK_STREAM socket in SOCKMAP
when data is sent to it.

The function is invoked via sk_psock_verdict_data_ready(), which is
set to sk->sk_data_ready().

During sendmsg(), we check if the receiver has SOCK_DEAD, so there
is no point in checking it again later in ->read_skb().

Also, unix_read_skb() for SOCK_DGRAM does not have the test either.

Let's remove the SOCK_DEAD test in unix_stream_read_skb().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/af_unix.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 1fa232ff4a2e..be4c68876740 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2804,14 +2804,6 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	if (unlikely(skb == READ_ONCE(u->oob_skb))) {
 		bool drop = false;
 
-		unix_state_lock(sk);
-
-		if (sock_flag(sk, SOCK_DEAD)) {
-			unix_state_unlock(sk);
-			kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
-			return -ECONNRESET;
-		}
-
 		spin_lock(&sk->sk_receive_queue.lock);
 		if (likely(skb == u->oob_skb)) {
 			WRITE_ONCE(u->oob_skb, NULL);
@@ -2819,8 +2811,6 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		}
 		spin_unlock(&sk->sk_receive_queue.lock);
 
-		unix_state_unlock(sk);
-
 		if (drop) {
 			kfree_skb_reason(skb, SKB_DROP_REASON_UNIX_SKIP_OOB);
 			return -EAGAIN;
-- 
2.50.0.727.gbf7dc18ff4-goog


