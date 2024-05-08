Return-Path: <netdev+bounces-94513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF3C8BFBC3
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9613283C59
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA8526AFF;
	Wed,  8 May 2024 11:19:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EFF823AF;
	Wed,  8 May 2024 11:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167142; cv=none; b=KF/wGD5KGuKqfkKfaKZqOqbqc3fPOZsxniYUPoWeW9I1aiULyWlxPe1iqcNzHgXFvnimTtXkoV8pBfjhwjqfbFEfJnmIOfrdBgR7lcvKxnk6v+Eu6rzYiwgkUllN6HjmkAspWE82juMmj+/8/dunCWlH0J/gqUBANVtxUUSFzd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167142; c=relaxed/simple;
	bh=Wt6hBn/E8/rcOV/yvuQND3bBYWKNlqQD6+pprEZT1U8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u59PV53h0Puvgjk8+DsjyGErW9DpoHT+nWwjdJEFW7GhsL3wM8/b4L3g2W5LLjUK1Gwp3Z3A93Junoymx5p1z2M2udrfnAWM5k8J2IzVw8DNbgKsJBOilz1GstF7x5rox62HkNyBu/5YH0O/L3qaVcES1ww9nFN6jovmcvgjhTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51fea3031c3so5480513e87.0;
        Wed, 08 May 2024 04:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715167137; x=1715771937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4K236F83xIjOHXZVpnRuR+gp9TcM6droQplL3I6znE=;
        b=XQvOA0BEh+INREhdtm0JQEgwThG28A8LgJLFmEexBSKHgS5sOJwPwkfEfcwV91ivid
         vVzdRrvbp0M0hS2bOOmm+TXBBy9yUCBcFNNDe+FQfdSqfCMwdsf1/8vxBXnfD5IMdNAh
         ITbZY8DbAZHkJswx7GkRYWZD7hQnV5xE3sXC3anvuWsQNG03Hj94gquRKw5kfhfqqzqL
         TgHXTpxvZmeZ6Z4yAqf31cxmGg0+xjj51/p+GzYQHfKSgUqXMMegk6KsEOr6anziSBZT
         m61EvUWC27hQK+FEHXZzLPy+bB4x9u+GKGULARqg2eDOxCG56cHXzvgLr8EO24yNca1G
         603A==
X-Forwarded-Encrypted: i=1; AJvYcCViqMZcnLqY1aP+uyj2XEDiPYSVPKOv2q0BaMnEfr3s2/RO9RsOcxKXyf2sP1MrBQU7HeGn8IhXKQDv8XBF0N0hceJSl4xi9TzlZ86b
X-Gm-Message-State: AOJu0YzXJOfmlKPKrIwhgpyTUhHt0BBXz1X+r6Mx7UKqbdQDE91LuUyZ
	zHG5r7qIV7B6AoUxP5EaaA4ZPUneHqRgdSQngBc04ShB+7fc02OiuBHETQ==
X-Google-Smtp-Source: AGHT+IFHlpDZ23iWMflSbn+Bqk/HBR/+rVo0kskLofTqQoJYroOXR/UZ6UyBGN5V7B1WiMmNAo4u0Q==
X-Received: by 2002:ac2:43bc:0:b0:51d:8842:f0b8 with SMTP id 2adb3069b0e04-5217c373de3mr1879465e87.13.1715167137178;
        Wed, 08 May 2024 04:18:57 -0700 (PDT)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id wp1-20020a170907060100b00a59a70d748dsm5456605ejb.56.2024.05.08.04.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:18:56 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuniyu@amazon.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	paulmck@kernel.org,
	David Howells <dhowells@redhat.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] af_unix: Fix data races in unix_release_sock/unix_stream_sendmsg
Date: Wed,  8 May 2024 04:17:45 -0700
Message-ID: <20240508111749.2386649-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A data-race condition has been identified in af_unix. In one data path,
the write function unix_release_sock() atomically writes to
sk->sk_shutdown using WRITE_ONCE. However, on the reader side,
unix_stream_sendmsg() does not read it atomically. Consequently, this
issue is causing the following KCSAN splat to occur:

	BUG: KCSAN: data-race in unix_release_sock / unix_stream_sendmsg

	write (marked) to 0xffff88867256ddbb of 1 bytes by task 7270 on cpu 28:
	unix_release_sock (net/unix/af_unix.c:640)
	unix_release (net/unix/af_unix.c:1050)
	sock_close (net/socket.c:659 net/socket.c:1421)
	__fput (fs/file_table.c:422)
	__fput_sync (fs/file_table.c:508)
	__se_sys_close (fs/open.c:1559 fs/open.c:1541)
	__x64_sys_close (fs/open.c:1541)
	x64_sys_call (arch/x86/entry/syscall_64.c:33)
	do_syscall_64 (arch/x86/entry/common.c:?)
	entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

	read to 0xffff88867256ddbb of 1 bytes by task 989 on cpu 14:
	unix_stream_sendmsg (net/unix/af_unix.c:2273)
	__sock_sendmsg (net/socket.c:730 net/socket.c:745)
	____sys_sendmsg (net/socket.c:2584)
	__sys_sendmmsg (net/socket.c:2638 net/socket.c:2724)
	__x64_sys_sendmmsg (net/socket.c:2753 net/socket.c:2750 net/socket.c:2750)
	x64_sys_call (arch/x86/entry/syscall_64.c:33)
	do_syscall_64 (arch/x86/entry/common.c:?)
	entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

	value changed: 0x01 -> 0x03

The line numbers are related to commit dd5a440a31fa ("Linux 6.9-rc7").

Commit e1d09c2c2f57 ("af_unix: Fix data races around sk->sk_shutdown.")
addressed a comparable issue in the past regarding sk->sk_shutdown.
However, it overlooked resolving this particular data path.

To prevent potential race conditions in the future, all read accesses to
sk->sk_shutdown in af_unix need be marked with READ_ONCE(). Although
there are additional reads in other->sk_shutdown without atomic reads,
I'm excluding them as I'm uncertain about their potential parallel
execution.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/unix/af_unix.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 9a6ad5974dff..74795e6d13c6 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2270,7 +2270,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 			goto out_err;
 	}
 
-	if (sk->sk_shutdown & SEND_SHUTDOWN)
+	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
 		goto pipe_err;
 
 	while (sent < len) {
@@ -2446,7 +2446,7 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
 		unix_state_lock(sk);
 		/* Signal EOF on disconnected non-blocking SEQPACKET socket. */
 		if (sk->sk_type == SOCK_SEQPACKET && err == -EAGAIN &&
-		    (sk->sk_shutdown & RCV_SHUTDOWN))
+		    (READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN))
 			err = 0;
 		unix_state_unlock(sk);
 		goto out;
@@ -2566,7 +2566,7 @@ static long unix_stream_data_wait(struct sock *sk, long timeo,
 		if (tail != last ||
 		    (tail && tail->len != last_len) ||
 		    sk->sk_err ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
+		    (READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN) ||
 		    signal_pending(current) ||
 		    !timeo)
 			break;
@@ -2764,7 +2764,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 			err = sock_error(sk);
 			if (err)
 				goto unlock;
-			if (sk->sk_shutdown & RCV_SHUTDOWN)
+			if (READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN)
 				goto unlock;
 
 			unix_state_unlock(sk);
-- 
2.43.0


