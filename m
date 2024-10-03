Return-Path: <netdev+bounces-131699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B3F98F4BF
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52791F226B2
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB6D1A3BA1;
	Thu,  3 Oct 2024 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dZfgCuOX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BABD1A76DA
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974941; cv=none; b=LhOHjz407i5FSmR0pZ6y4KUXznDFvYvOi3Gwr8wfw1ssCtAdxLVS9HaMggS73kAVyTh/5sVG2JUMrFIsDogORgzCAq93M8ga2xgzM3Gjw68wXZ44u1fr4EYSnaJhnm6GMFsbE7GW/+lr4I4yqInrH13xbwd8fFUKkNkFokU3Jpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974941; c=relaxed/simple;
	bh=q5fnZalcCifiTYmt624hvA/GHzcWXModIxitdcD4x3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TEo94VG1G9cR9DDEoSdCls4ZgNoh+Vl2KhKvcoRQmI/hMjqXqYhOOCHOstydJogsEjxqSZfiE6PZFOR+G6QQ4IaSZfKTTekF+wnEpbDRQk8Tg3Lic0LBaon8anMNAmVucb6YxZUW6t+GSiQJwac52rfWZMzB3H9zsMajUKJVyLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dZfgCuOX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cbc22e1c4so9868885e9.2
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 10:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1727974938; x=1728579738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L2K9Rx95eEIwrccz12T8FYrmBSVI/zqc5CLtbN9+dAo=;
        b=dZfgCuOXrqJtq16DftDq0HKLhMQJIXr4LszGm/WCAKgzxuFt8EZOvrw0zyzCs9/JLe
         A5HQCs0i7moqf9aRkKoyq6LZe+Iqnh7qRORgXSL85yMm/OzjiScFkdknfNOtub5ndbOD
         +jKx38laVv80U2DnOOA+Ak2VolA1TYnFma6hEbEQoMulw4WsU+FWw9RRNGY8s84QoJc+
         P3vYRxoBamQb73gyk6ZPrSO6caPUvniZllOA0tbYXiaBGDykaHQGnqg7wQZptGzJcr7l
         RigoU1Dtp/iXpPfHwgBVz+WjkdCKLCIUf6SDfQPEicw766Y0gPoX4tyBZDdO64qVm/1h
         vQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974938; x=1728579738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2K9Rx95eEIwrccz12T8FYrmBSVI/zqc5CLtbN9+dAo=;
        b=q6ShzIB3fF38cTWtL74kfd7APDhmDI78ESCVCNSER/1Abst8f8e9xp0nZ0ImOdG8JN
         Pn2U9s3apD21IBYRrMcL++bLPeqyHNykSzE1e877sJnqAtt2vkQ5THSZjJxg6KePBxCi
         bwX7pz465Z8Op/wLirAL2R3or4vZvqciAaEFjjis7t0UoJQksxGgHltewDNnssisebFP
         FhUnowQqk6rwoMk+msMu+PFpKqD75Nj4AFB/CX0ZQ/bnCgvedj/aWP1SKEFX7dSGj36n
         Y288vzgh5ubf67kFujTv0YcvCf25CEkBaVWU2WYW40Ca253lH6qlqWzxOnaGoVllUOBi
         ThCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgYMzKFi00hY3g8vjuSGP3pi/mMjRIXXW1EajNB44rseO5N9PJcKQ+fPyYYBY0xrX3IJ/xygQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5t//keuu5mgRIBVzYsJhyDdnKoRl5zLqndH7JMqkjtZ6anyfi
	9DdY3nEFtcOM0V8T5HckmryFSytlsVBDkSkGjfQg8DQr8Lf6Dv6JSGB7myLhtgM=
X-Google-Smtp-Source: AGHT+IFvGS0AaOWIo2/ClTjMA5NELifeE+GDYetSD2J0UfxJBPFOi79ArzJpDHsBe02D/v3GZVuSNw==
X-Received: by 2002:a05:600c:138a:b0:425:80d5:b8b2 with SMTP id 5b1f17b1804b1-42f777c6f57mr56953245e9.16.1727974937680;
        Thu, 03 Oct 2024 10:02:17 -0700 (PDT)
Received: from localhost.localdomain ([104.28.200.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f802a01fesm19874695e9.32.2024.10.03.10.02.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Oct 2024 10:02:16 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	kuniyu@amazon.com,
	alibuda@linux.alibaba.com,
	Ignat Korchagin <ignat@cloudflare.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: explicitly clear the sk pointer, when pf->create fails
Date: Thu,  3 Oct 2024 18:01:51 +0100
Message-Id: <20241003170151.69445-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have recently noticed the exact same KASAN splat as in commit
6cd4a78d962b ("net: do not leave a dangling sk pointer, when socket
creation fails"). The problem is that commit did not fully address the
problem, as some pf->create implementations do not use sk_common_release
in their error paths.

For example, we can use the same reproducer as in the above commit, but
changing ping to arping. arping uses AF_PACKET socket and if packet_create
fails, it will just sk_free the allocated sk object.

While we could chase all the pf->create implementations and make sure they
NULL the freed sk object on error from the socket, we can't guarantee
future protocols will not make the same mistake.

So it is easier to just explicitly NULL the sk pointer upon return from
pf->create in __sock_create. We do know that pf->create always releases the
allocated sk object on error, so if the pointer is not NULL, it is
definitely dangling.

Fixes: 6cd4a78d962b ("net: do not leave a dangling sk pointer, when socket creation fails")
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Cc: stable@vger.kernel.org
---
 net/socket.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/socket.c b/net/socket.c
index 7b046dd3e9a7..19afac3c2de9 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1575,8 +1575,13 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 	rcu_read_unlock();
 
 	err = pf->create(net, sock, protocol, kern);
-	if (err < 0)
+	if (err < 0) {
+		/* ->create should release the allocated sock->sk object on error
+		 * but it may leave the dangling pointer
+		 */
+		sock->sk = NULL;
 		goto out_module_put;
+	}
 
 	/*
 	 * Now to bump the refcnt of the [loadable] module that owns this
-- 
2.39.5


