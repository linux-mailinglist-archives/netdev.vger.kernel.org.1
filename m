Return-Path: <netdev+bounces-98028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E86378CEA67
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 21:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75E2EB22151
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 19:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DC0823D0;
	Fri, 24 May 2024 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OesLBc+E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499C27D417
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716579398; cv=none; b=VSfCVcdK4xYdGl7uBegZat7O2v42No8g7C8rPtmtxBWF8SygNUxYiqBDbVx3BDHguD+LfxFN8hFXJ4yCSHHMUoSI8Tn0ryAO0E3aR7AIpQVq+t2VqaVUlwkrCTu8ILEfrmycX6zFQKG5NZSm6M2kCNYvQcTe/1/k7Ur6H7+6WMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716579398; c=relaxed/simple;
	bh=+szacDh+W2jKFCKUX8UxhahCd90OddhIR0HoBtOTpxE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gYDWVGnGvB4O5cNEJdkOiVaZwFRchtNSy8WrsHEifavQSR49KAKiWd6bLy3vG/ty1CBU2wc93jXCS5fkOnA9QOGu0sGHlaxIKsYv4FDRQGMZ+nCkqeRunk+WHoOkO3PjVPpP6/HQgpp+dZJT1Y11J+j5gH6tJ08cH4mBxQCYNG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OesLBc+E; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-629f8a92145so11217167b3.0
        for <netdev@vger.kernel.org>; Fri, 24 May 2024 12:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716579396; x=1717184196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z1ap8e/6CqnJSY60s8zHiniTznOnCIezUplYpbSVn2M=;
        b=OesLBc+ERr6lKO6yTI5iinEoqCdilDJhezMPTmhXJqZfY2R7dno4dDM+dYheSUf8QP
         cmGU2WZpLELDGsHojh8kh+2BimlzViFpTPfkZCJe35mN0wJd5YiFrRANKrey+PwB//7c
         24kzHC/x5ebRAdWUYMAMuEvPh/QxmpFBpjSQjhDvH8x7R/2YsN07d8WTX4qPI11jbqYd
         kOY9CZbyvA8cB6bm0Hj2cwNSamJ5HivpFdcPi4ukLb3xKbXVE/vOHxEpK67e5IFuou5S
         b5clu4rISUUooxrXMBe08dmtnsCeDOe0MU8V+Mgq6H8XJeJM8Noa87+sm9M5a/PawvGR
         1bdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716579396; x=1717184196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z1ap8e/6CqnJSY60s8zHiniTznOnCIezUplYpbSVn2M=;
        b=ZVQFg61Q113y12WHDN6lulgnlaup1h1aDsJyTp6KtKmy1V9qb0s9zx9GTHJbEvEdcD
         XTvpMuYDeG0wGUDjSxMR0cvHIOhlkeQNss17miH5cwd1a0ILJcJcJPvkozNLM9eM5oBY
         dRzLutktS57/dF7gQl5KtWyJR0sD5/eOSztQUCQ5N6Fie/AiGjsgSgt/0gWL5gQefAxW
         UOA1ogPlv/3GEzRLhG7BNCiXUEte6yIFcXqFDdBygF+L44iE2qTgLn3DQnbGrcZ4qi3S
         FANmmPfq/4fill9rbMf5IkJqDoPitbIZgrKZgMTg41igtstTj+wTB7EdjjnI53/oMCip
         U2bA==
X-Forwarded-Encrypted: i=1; AJvYcCW1NhNdSZ2sXjUadhST+7TSGTOGR/+Olzx45DWtF/rKGJzj2pOOLxTVxyJv4jhSgsgA7qb93VX/AHcyY1JsLBJ4cYnEpMrh
X-Gm-Message-State: AOJu0YxnFk+uRasd6hKO0xDq8eaSQJ0DeVwBDtlkIVo04RuAGycgTPI1
	eFXUwzdAOgmXsjjIA4UA5MwHEfHqAZqK9uFyOQ6uleR/0FKmeYBLKVnLe/Eu4Xw68g3U23Y0f8E
	1VXs/yimNnQ==
X-Google-Smtp-Source: AGHT+IGNKQK8Wo+Q6Avn9+/FtR1eWMe/oeS7H5oYqITuxIPRwq6+DSipGmAqDu8wYe7A+QciB+kxUpOxeUnE5g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:62c8:b0:61b:e689:7347 with SMTP
 id 00721157ae682-62a08d701cbmr7634367b3.2.1716579396336; Fri, 24 May 2024
 12:36:36 -0700 (PDT)
Date: Fri, 24 May 2024 19:36:28 +0000
In-Reply-To: <20240524193630.2007563-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240524193630.2007563-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240524193630.2007563-3-edumazet@google.com>
Subject: [PATCH net 2/4] tcp: fix race in tcp_write_err()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

I noticed flakes in a packetdrill test, expecting an epoll_wait()
to return EPOLLERR | EPOLLHUP on a failed connect() attempt,
after multiple SYN retransmits. It sometimes return EPOLLERR only.

The issue is that tcp_write_err():
 1) writes an error in sk->sk_err,
 2) calls sk_error_report(),
 3) then calls tcp_done().

tcp_done() is writing SHUTDOWN_MASK into sk->sk_shutdown,
among other things.

Problem is that the awaken user thread (from 2) sk_error_report())
might call tcp_poll() before tcp_done() has written sk->sk_shutdown.

tcp_poll() only sees a non zero sk->sk_err and returns EPOLLERR.

This patch fixes the issue by making sure to call sk_error_report()
after tcp_done().

tcp_write_err() also lacks an smp_wmb().

We can reuse tcp_done_with_error() to factor out the details,
as Neal suggested.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_timer.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 83fe7f62f7f10ab111512a3ef15a97a04c79cb4a..ed614fe67a587dc4238458155dda4c66d58d2687 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -75,10 +75,9 @@ u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when)
 static void tcp_write_err(struct sock *sk)
 {
 	WRITE_ONCE(sk->sk_err, READ_ONCE(sk->sk_err_soft) ? : ETIMEDOUT);
-	sk_error_report(sk);
 
-	tcp_write_queue_purge(sk);
-	tcp_done(sk);
+	tcp_done_with_error(sk);
+
 	__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONTIMEOUT);
 }
 
-- 
2.45.1.288.g0e0cd299f1-goog


