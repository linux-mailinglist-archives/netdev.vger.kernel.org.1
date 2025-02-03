Return-Path: <netdev+bounces-162192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6041AA260F5
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 18:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D213A1345
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 17:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50A71D5159;
	Mon,  3 Feb 2025 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oc8RcVuF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f73.google.com (mail-vs1-f73.google.com [209.85.217.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A5820967F
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738602523; cv=none; b=p3wIXLLhWyWMbzynAR9/9lPenCjSYkvSPqALgXO6tynxZuS2D+Z4iMYygnRIjni/XjQKFr7URmGeNleEBfrlc+Moz2cssy7fAXqHWgxQRUslYZI02g8qNoqo+bLmXFDkUPcxLie0TFJZG3LgR82fVwQo/xE+5GrP1eHTlx2tQ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738602523; c=relaxed/simple;
	bh=OvMdGiiMqtXJxpeP8aigdadenc+x5SCzzZ+wdLQFuLo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MIap4LoPI18JdWRCW1tHvi3umv/GuPPXBt6ZdVVpfJzrwR0Js6P8XN0kAIXNkFwf2J+pGJHATcWYLIUmo/5nkA0sAgAAltpyGLR08NHEtr0Dv19X55iWcUovYNterFs7FZc4whr77GOUmGLUlncLSLosEiKsm+Q5yF6utu0nVSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oc8RcVuF; arc=none smtp.client-ip=209.85.217.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f73.google.com with SMTP id ada2fe7eead31-4b11463b42aso522430137.0
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 09:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738602520; x=1739207320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=me08butiSxHFI78MR+uQVHza+d6wwiZ+sBFW+rxvF00=;
        b=Oc8RcVuFFJUl2507yRV1KYxB8XzErhjAm3IxHiGxkSYQV6EAlAu7kdHnzPREztVfhx
         oSmdA8h4G+Z41SVIOYBVu7XHOEppMT49xrnuJ9Ucwe3yM0Z2HUiNFa8lPDRt2VF4oXOV
         ZuNOMqcZKQiWrZyo6p+S7p9dfj2lUvD/iYLjwxYtgau/Y8vZb3j4sGFpDUjS7Gp3Mhk5
         YQUXOQQjdYpjR++cCiXc5TaaUfpZF2zG/ols0x3pjtYbDgsToa2x7ZdBihDTHRelc/1A
         vnEFnl9hgD+8qeMPiGDNQISf8ZWIELJNev06l9AuCN1IMkaTZZRrdjK0LU4V6HEn895v
         ZKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738602520; x=1739207320;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=me08butiSxHFI78MR+uQVHza+d6wwiZ+sBFW+rxvF00=;
        b=SONpUP+kASFYPC96/9eKC2buQILEFhGOYyru/NuYM1Uwu2IR7T7MwioL30IVILV9wk
         iIY5xh28nZHINAscaf/3GoQgxixfTqrd85rMk9a92W68SBv8iF4eJWQbBpmcSiSt1Kaa
         tA1HlegLXnNxM0mSHPL0t4fmEW3hdPPbiJtlPJklHtWMmm283J3nEqBTEUTrQe6rqKnB
         we9Pm6F34KqWIgZ10U2j/WoM+tS0wRv7rDrmXpSJRg4Cp/yjqSU4uP4Jrq68RRfLbnba
         rKbz8bpjuy1mRt1I+VtQJ3VvrF5ZHalnoj0ySkp5ixm0Ex4oywdiZlDyXCupIlOcjiKY
         LBwQ==
X-Gm-Message-State: AOJu0Yx1bz133Koi8fxj0gKulFO8/ZF+HJrOou1vdU3V64S8mcHWXEo2
	x8PvhHnVyVjDExMJbFR5vl7dfCuMQUEtrabxvR/r+KQycvqgZXonLTXNHFefqCR+tAZ+zxSLRok
	OyyAo2ZjchQ==
X-Google-Smtp-Source: AGHT+IGJfDdWlBwnAh25ty+kAl7DeVSKazdg6KfJfEDBefBXkNg3c1Af7EENhY148rZ/wIFYlOspXOgWM1qUKg==
X-Received: from vsvf16.prod.google.com ([2002:a05:6102:1510:b0:4af:e21c:a8f3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:c8d:b0:4af:fca2:1b7 with SMTP id ada2fe7eead31-4b9a4f8cae6mr15414300137.14.1738602519954;
 Mon, 03 Feb 2025 09:08:39 -0800 (PST)
Date: Mon,  3 Feb 2025 17:08:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203170838.3521361-1-edumazet@google.com>
Subject: [PATCH net] net: rose: lock the socket in rose_bind()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+7ff41b5215f0c534534e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported a soft lockup in rose_loopback_timer(),
with a repro calling bind() from multiple threads.

rose_bind() must lock the socket to avoid this issue.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+7ff41b5215f0c534534e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/67a0f78d.050a0220.d7c5a.00a0.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/rose/af_rose.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 72c65d938a150e6794b1a769070843ec5c5fa32a..a4a668b88a8f27c77d2faa39ba9ad174e748966b 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -701,11 +701,9 @@ static int rose_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	struct net_device *dev;
 	ax25_address *source;
 	ax25_uid_assoc *user;
+	int err = -EINVAL;
 	int n;
 
-	if (!sock_flag(sk, SOCK_ZAPPED))
-		return -EINVAL;
-
 	if (addr_len != sizeof(struct sockaddr_rose) && addr_len != sizeof(struct full_sockaddr_rose))
 		return -EINVAL;
 
@@ -718,8 +716,15 @@ static int rose_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	if ((unsigned int) addr->srose_ndigis > ROSE_MAX_DIGIS)
 		return -EINVAL;
 
-	if ((dev = rose_dev_get(&addr->srose_addr)) == NULL)
-		return -EADDRNOTAVAIL;
+	lock_sock(sk);
+
+	if (!sock_flag(sk, SOCK_ZAPPED))
+		goto out_release;
+
+	err = -EADDRNOTAVAIL;
+	dev = rose_dev_get(&addr->srose_addr);
+	if (!dev)
+		goto out_release;
 
 	source = &addr->srose_call;
 
@@ -730,7 +735,8 @@ static int rose_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	} else {
 		if (ax25_uid_policy && !capable(CAP_NET_BIND_SERVICE)) {
 			dev_put(dev);
-			return -EACCES;
+			err = -EACCES;
+			goto out_release;
 		}
 		rose->source_call   = *source;
 	}
@@ -753,8 +759,10 @@ static int rose_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	rose_insert_socket(sk);
 
 	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	return 0;
+	err = 0;
+out_release:
+	release_sock(sk);
+	return err;
 }
 
 static int rose_connect(struct socket *sock, struct sockaddr *uaddr, int addr_len, int flags)
-- 
2.48.1.362.g079036d154-goog


