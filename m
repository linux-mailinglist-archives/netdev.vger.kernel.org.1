Return-Path: <netdev+bounces-98541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8DC8D1BAC
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C81A1F22BBE
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE3516D31F;
	Tue, 28 May 2024 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hVOT3/0V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9992016D9CF
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900785; cv=none; b=ErCMlhgQhsV0NDK6DaXZC88l7Xem3oeVskp4984MKMbZOP/c2bLMcOpq+waIChhsYSU/2qQ/bmTRuxkUq1eEaFHmfJRVNbOLxX3u48ULd3RCxJhwOVoL3hdQqyC6+jaCVcjg6cxDaD6L75sV008HB3dB72rXkVj9//+PSeEYEZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900785; c=relaxed/simple;
	bh=2bEM0Vdj69RbU+Ng2J1vFnI6UGxQv0T6zWDf22KxmvA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TFlb42fmz3oI46QvBsXoLsE0OW1FfSNkrCnNfyapVFmmxIcxt2ifvwo5wivBQBcf5h8CxhAVmBHA0V3BHuDKaHB/zUaOKUaZJCxl7mNt1xO5Ue13dpO8RzWI2UNU5BoKripGXRfhRTle/OnG0LPGB6kdYnUb/o3QVjgY6nZi8as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hVOT3/0V; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df7bdb0455bso1173994276.2
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 05:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716900782; x=1717505582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=enO1CN/0applm4uZNOehy0RY7PCIzFl6GbDmIfliayI=;
        b=hVOT3/0VrJeJiJrKl+XKJRUcQEkPaex1MoD/2rCubj+/TuAgi+SlJFlQlfy1OjcM56
         0tsorZmlbQpyxSJJllMnqT0MqRLv3OT0yPvBaaNypRKca9xYMGy5T7Mgc3MR8k8vE/9W
         AjNJ0qoWDdwgUO+4USkzzNea83yOkAAKb0zFwm8E/EhPrWNmSVqpsWHorUaev58LUqr5
         mjB3g5YOkqCZY5mPBqFhVK9sLo5fFs1cV6kf46p1Utg1bakSrIn6UmwTpj++e/whxWFa
         owdZ7eeZiSh0L+S9BbjJ92zg7W1rJYK+Ck8b2LnB5nSEuKUY2D7Twjlc246P+7k14Mlk
         zCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716900782; x=1717505582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=enO1CN/0applm4uZNOehy0RY7PCIzFl6GbDmIfliayI=;
        b=a1bGzlOJ7VcOIqmpBK4/OQ04DaFpzFzPiw0+xHvYb9vzGGPC3ZTiKce2JiOG1LfaFq
         BwPzmZ7IP7YWF6HMUxJLcljog0PLhmZFgH6LKU828+mZyjYnfU+rkqNLmRwUlGlDWd9q
         SLDY9/VwvDWKbjAOMlunPp7nYanLaWtvOrSQixnymolTtwozxsC8B+enuxiQfL3ISGG1
         C7P2d3uPY7T/2yezZ6O+2NmER2wGPRe1PcY0y002/fyrrVG/T0XpNWOHcN0tdFQp1TaX
         wv8YT9NGl2wYv+9EejsNX9vwXIOdbgkZHK26YHweFHEEqRvGX/WPH1Xq02S69vLYYgZr
         ti1g==
X-Forwarded-Encrypted: i=1; AJvYcCUon7WYT7sUqBjqji6v0ZBbSwBVUW+PhGLk1d3+yBjiJHEJIjgMY71Fyck2A7e69lzrNsjbtE7Ri78BJzFHQlsc+xI7Acdm
X-Gm-Message-State: AOJu0YxNVe9QFtMsZG4/UiHC/f1CoqBzIGE0Mp2yECGcVN7L6X6dJwPx
	NNTdc5d22Ni4362LFkOlMtEorE18Z/eQPUvSpto62s2K/QO0n/URn01c5LU5pWaxINWP7k5bcL1
	/K0TJ1BGo1A==
X-Google-Smtp-Source: AGHT+IEPQtEs1LLWFkn9N9fQSALKMHsbtz+5CSElIvKwqzOIirhCdfxkhbQoLMpNl8GESyADKZDZxBzYz9RoXQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1207:b0:dee:615c:ac3a with SMTP
 id 3f1490d57ef6-df77218837cmr836706276.5.1716900782506; Tue, 28 May 2024
 05:53:02 -0700 (PDT)
Date: Tue, 28 May 2024 12:52:51 +0000
In-Reply-To: <20240528125253.1966136-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240528125253.1966136-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240528125253.1966136-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/4] tcp: fix race in tcp_write_err()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, David Laight <David.Laight@aculab.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
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
 net/ipv4/tcp_timer.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 83fe7f62f7f10ab111512a3ef15a97a04c79cb4a..3e8604ae7d06c5b010a2034e3295675a7d358f13 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -74,11 +74,7 @@ u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when)
 
 static void tcp_write_err(struct sock *sk)
 {
-	WRITE_ONCE(sk->sk_err, READ_ONCE(sk->sk_err_soft) ? : ETIMEDOUT);
-	sk_error_report(sk);
-
-	tcp_write_queue_purge(sk);
-	tcp_done(sk);
+	tcp_done_with_error(sk, READ_ONCE(sk->sk_err_soft) ? : ETIMEDOUT);
 	__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONTIMEOUT);
 }
 
-- 
2.45.1.288.g0e0cd299f1-goog


