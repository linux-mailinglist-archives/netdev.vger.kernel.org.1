Return-Path: <netdev+bounces-224038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A906B7FA7E
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE26540418
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 13:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EA7328970;
	Wed, 17 Sep 2025 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y3FFbOLa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8F0316193
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117222; cv=none; b=p3DInW+IL240EUSKRMsHq75Rw9+Gi6m1X9gdqg7YTriVqWPVXPe1+5Z0/FQHi4jbckaRjARupsORFIqJxckpdIKd3jGgpki2xBvXgbuYP9HRzM8uVYdUNQcrFk6ErQhYCUR6AgV71e8k5j2ekA/oEOQTloGWBMz/fuKgf7v4DHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117222; c=relaxed/simple;
	bh=809Xoa81SsuA/YaVGt54p8msWHOJUrtDL2RTeT0u+Is=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qfUrkoGrTZIs7qd5SUS/yNrSvOhnLoI+uIMhXxu7Z7CUJAoiSmjc0DGd7KvCw+c3K5BcRBzSjoYTQ+H7RjkFX89VWYeuaGlRiT0DEHPibO4S5FLjwyu+u9U43HyrfdCA6Ur6k6CJQ/simMqrIrFr46xJBT0hXMVvfygfRy5xxIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y3FFbOLa; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-81ea2bb8602so1945461085a.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 06:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758117219; x=1758722019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aJILwjN0524PmDn2xMZf53Vv0Yu8hqDvySpvkgdBkdc=;
        b=Y3FFbOLa/Kn5uRZFJMkLjFcMx4CG9ivKwhO7AxW2KXqfF+vwvgCpQnQF+OkimJZ2e2
         vXT+wTERwLAZoLsiE6BxpB5nhBtWaGpDsSvwb6SK5Wm8jScOERfEKbTTs6duU0SkBJ+J
         gRr/42YFARxVPaLjEn/yjAGnME3kOFUMKMB6g5W6hWxPI6WmuF0Gm2Q+Wbj4M7TgVOIV
         6Zb3fCApVp0e+TfQzypBZ/eb9iD8s2ALm5BIr0y4w0w6bWJqXUcA71OkaNrLhtx3Vp2P
         WyBnP5kxaOPrvXHQxBn6Z1Pg4MNwBOiCOK3jNE2jzb9dEOXZBvXETYLSvacDg7ep/z3w
         BkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758117219; x=1758722019;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aJILwjN0524PmDn2xMZf53Vv0Yu8hqDvySpvkgdBkdc=;
        b=GsP5C0+tWFiguYjCZjYcjbWMUaIBIgKlt1e3J/1BwTW+FRniaWNZsXjGs8hx/jtSOv
         o16eTeaiuek4glfg8bxVuaZ4BYM2fHgFhT+FfB0wK/bz+N6v4bROy7laHWnWLRCzQPD/
         TisexoRqsScIlfQfEcCA8KJf52li4nI/7PObZc9gUNJ69xJbLhwOBZQ3xrCOxkgRXHZe
         p0RmkU9lP+r3dKmiZZLhN/kimWU1QDfQPDZoPuxawcp/yT33HzV8LPgLO2au5/AHMwAh
         9Ahhn3bIc1RSxGQ2SnklQYhE0dEaJsvadTiXfQeyb14IBYj1NBl9sC3dtAKUMfGXEoJA
         01PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaQY/RmhGUdYx2nBgRCkoPemlgDQLSbQdfP+MUsO2ecdmq30Xl1FWVU39BAiioxpCaAV8gZzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM1nnNj0x3sGzgKqSlNLS8J8OMEbxm2HpuB1KDa5tTw6LrvX9l
	QSRICX0i3JF+r2Qv+17DFmdH+twu7y/Yk6lLoXIqUr9p/7phy/vZ7o3Mh3A8qK9TRbpt49AlbyY
	8j+8GPpUzHoKPlw==
X-Google-Smtp-Source: AGHT+IF8JLS0Han2K15u5D6bRo/vItKKpuZe0LS/S4/WvawkmQZcC8BjeQ8zgMl8RxYhTBdl8EsA5Bu2ZM5U7w==
X-Received: from qknqf4.prod.google.com ([2002:a05:620a:6604:b0:829:9702:a0f8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:7013:b0:829:edaa:a0d7 with SMTP id af79cd13be357-83106ccb8ecmr217687485a.1.1758117219143;
 Wed, 17 Sep 2025 06:53:39 -0700 (PDT)
Date: Wed, 17 Sep 2025 13:53:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917135337.1736101-1-edumazet@google.com>
Subject: [PATCH net] net: clear sk->sk_ino in sk_set_socket(sk, NULL)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"

Andrei Vagin reported that blamed commit broke CRIU.

Indeed, while we want to keep sk_uid unchanged when a socket
is cloned, we want to clear sk->sk_ino.

Otherwise, sock_diag might report multiple sockets sharing
the same inode number.

Move the clearing part from sock_orphan() to sk_set_socket(sk, NULL),
called both from sock_orphan() and sk_clone_lock().

Fixes: 5d6b58c932ec ("net: lockless sock_i_ino()")
Closes: https://lore.kernel.org/netdev/aMhX-VnXkYDpKd9V@google.com/
Closes: https://github.com/checkpoint-restore/criu/issues/2744
Reported-by: Andrei Vagin <avagin@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index fb13322a11fcf75211ce3ee8925807e888374f70..2e14283c5be1adeddc024527bd10dbd8a97a54bf 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2061,6 +2061,9 @@ static inline void sk_set_socket(struct sock *sk, struct socket *sock)
 	if (sock) {
 		WRITE_ONCE(sk->sk_uid, SOCK_INODE(sock)->i_uid);
 		WRITE_ONCE(sk->sk_ino, SOCK_INODE(sock)->i_ino);
+	} else {
+		/* Note: sk_uid is unchanged. */
+		WRITE_ONCE(sk->sk_ino, 0);
 	}
 }
 
@@ -2082,8 +2085,6 @@ static inline void sock_orphan(struct sock *sk)
 	sock_set_flag(sk, SOCK_DEAD);
 	sk_set_socket(sk, NULL);
 	sk->sk_wq  = NULL;
-	/* Note: sk_uid is unchanged. */
-	WRITE_ONCE(sk->sk_ino, 0);
 	write_unlock_bh(&sk->sk_callback_lock);
 }
 
-- 
2.51.0.384.g4c02a37b29-goog


