Return-Path: <netdev+bounces-132856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7BA993945
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 23:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23FBDB22707
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 21:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC6018CBFD;
	Mon,  7 Oct 2024 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="gBg2Fv9f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBE918C350
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 21:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336939; cv=none; b=HmP/fIBRIu5h3DIs9Vv8TPqxPYoA8KHLL2V26GRmtRCPA0SZ5PokIjAvO5UiicF8izNm3HYbYqvrgh8idNg3jxXY1MG3v8+mw8ewgBgj67oxSiG5/BkLJKE4qfE0l18dDbrRsbRT8NiALMfnQRLqSVKSGAnb6aCymHi8URsPEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336939; c=relaxed/simple;
	bh=tF3+7/64K2pNMC2yMmqB0bNnDpkF/qc4QvYqWOU0LHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FJyisH6spxK1Q3KJagaxHwZIHmq3q8O3JMRI7WpzFstWQs/9beK/ezsPxiaaIJIDBGxczfyYQhXVsgpFPsKPgdh44jKFowseJyZPnGU5ClNQK6fnuE6XNa/GAXtsxLAHZKJsE4Q3lgqf1Ki2mxOuDgPxUSzQ6XIwYR+X+l7SA6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=gBg2Fv9f; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d00322446so3792457f8f.2
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 14:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728336935; x=1728941735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvyWYlYW9NKrX6tjwjorxSh4AbupOomnLhmwVzPjUzY=;
        b=gBg2Fv9fYDeUYC50Ah1y/IuP8inxo5A5v/KcTviaSFNvLolTTCWlM5HJB68gye0c1x
         4jOFPRQZt8d2nO62/XgR9SnncQZlI0BeB3i21p956gRiGjtH1WqzdQAUxQbELVB4hEFe
         R2DLs5mTUzHu5AqurfR9YPBACBECX8QQxLijrB01TMDPfd+NTqAarSO2HgvZKYuhXad8
         9ynkNC6RyuAfZ/f6kwdqo6Nt3356JDixtuCwoDEbhGVBFygrSqjwwF0mWBT/5GeTf+yj
         gm7CNQi7glWXVXe/xyJxp7luIyE4c796sbgJbL66eqqeYdfp2/aKFKucbbBPb8r/rE8S
         686w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728336935; x=1728941735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvyWYlYW9NKrX6tjwjorxSh4AbupOomnLhmwVzPjUzY=;
        b=C4L3D5f8Qa2hGx2PwBqpoFnRZywSfJ1WGhcl5JTTDof3gGcffHvJAm4ShLo5j5v1V4
         qilqmHbn2+giSy4QLNemV69sn7EzLVXahrRKw7tnXv+G/WWe79BhGQMWdtg6J61FV0nL
         DqFE1LBth/t4p31ymps2wOE9Z2P0CBEHAzL4fxTiPJ8HHwHcfGzHUq/fHSNArKforFnN
         ZiKf/caWs2cxYtPA2mq88WnXT2gNk25iuBSxbpF8EYr9iz7je0Axbv51x2QiFnYe/oKX
         zs9dDBxKCdyT1ha8Yr7Tsjfyvg6F0J4cKDiF3VBKnLuO8bNeu41MRm4+yIf3YSYPfntx
         eHDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4oDRBYrTyjPtG5fWNvQ9OUKcriD1LL0KYCsJYzYRUA+msQ6skvdLYI9hCvlHcb4qSwxjZ8IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0hw19a8UHgMDCnPfn3FHC8pbf43G+/Z9BlNk3/JDs/jXB39PK
	GdPTv9DkLPtqRJZ7D5gw84xZcXzNCXoLRIiNI+WDq3aFNkVekHhvHI8uk+enE20=
X-Google-Smtp-Source: AGHT+IHLqNN1LAQf8g76woikHrigZw9N4TvlV2Fn4+zidESGtMa7IAByD8UA/IadWMwT9LMt7nSTnA==
X-Received: by 2002:adf:f8d0:0:b0:374:c454:dbb3 with SMTP id ffacd0b85a97d-37d0eae49f1mr6186667f8f.55.1728336934922;
        Mon, 07 Oct 2024 14:35:34 -0700 (PDT)
Received: from localhost.localdomain ([104.28.192.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a4absm6535887f8f.29.2024.10.07.14.35.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Oct 2024 14:35:34 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-wpan@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	kuniyu@amazon.com,
	alibuda@linux.alibaba.com,
	Ignat Korchagin <ignat@cloudflare.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/8] net: explicitly clear the sk pointer, when pf->create fails
Date: Mon,  7 Oct 2024 22:34:55 +0100
Message-Id: <20241007213502.28183-2-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241007213502.28183-1-ignat@cloudflare.com>
References: <20241007213502.28183-1-ignat@cloudflare.com>
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
 net/core/sock.c | 3 ---
 net/socket.c    | 7 ++++++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 039be95c40cf..e6e04081949c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3819,9 +3819,6 @@ void sk_common_release(struct sock *sk)
 
 	sk->sk_prot->unhash(sk);
 
-	if (sk->sk_socket)
-		sk->sk_socket->sk = NULL;
-
 	/*
 	 * In this point socket cannot receive new packets, but it is possible
 	 * that some packets are in flight because some CPU runs receiver and
diff --git a/net/socket.c b/net/socket.c
index 601ad74930ef..042451f01c65 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1574,8 +1574,13 @@ int __sock_create(struct net *net, int family, int type, int protocol,
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


