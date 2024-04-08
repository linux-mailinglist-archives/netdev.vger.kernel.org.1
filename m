Return-Path: <netdev+bounces-85810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6623189C6A9
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 16:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1881C21CFE
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 14:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080DE85C43;
	Mon,  8 Apr 2024 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3q9ZnrQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9B08173C
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585786; cv=none; b=UopITOW/x0dHtE6cV0o5NKq3mQlFGpvS7I/j+YheqoYX9mjKsng2c3iwdu1bHYtoYWt/BKck3mCUzPdTi2i6nzpyuGz3Rni87JOJFMQBdZ5OB9GOto8iHJMeCOwIz0+KRn5h7iLoGpsRPhKLwxm10AZEbEDM5CXRdl9H/1YP0NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585786; c=relaxed/simple;
	bh=1/vSBWLMUd7MQbHJDdQ2avGl+TjXP+/kGM2hPAl5AvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ag8hhD1uVVL76M7vb6MrWio18urxH7uJkDWtI0+rAaXgOpnIywNkblLJd7mg+KqkzRloASwlVoxHosmmnS5rrbz7WjtvbClAvZaOhDShyyQ2B4nf1z7cx9yuauaTVDFRonqpFE6IZwx7ratuitJ3xYRFlZgTzq6phnW0j++Ya2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3q9ZnrQ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e2e09fc27so5930613a12.0
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 07:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712585783; x=1713190583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5c9zaur2makbeSzs8tMbbNAwtw8YnLlVv5IRMVa4MxI=;
        b=f3q9ZnrQPjT8DksD6+xR7UNj5Nlbl6Nj5SH0u0pLH8FkKqe+oEOzu6Alkym0KYRsdS
         1G69lONC/7+04MBGbDYe64Zn/UioWWl7GfEQRuPOF4I+eSLQl/GQikwTwkaNpdVzoQi7
         O1TL5smHOSoKGpBP9pHrhLaLX86Y4jG0LRVEqvaFxMD1quhJT8y6gicrDqK3SEY/rcQs
         cVHzXlFLXWhchJHZVlkNibjIkldkC54nKDDZyRwM2FZudbVg1w3JL0G/0Evz3JeYQxLU
         AH+Qk2vF/rfENH961Tw3G1jx93ksrz4aB1SM2tsHyuUWmdx6IhLhQK9/cbnBBrKBkZsZ
         L2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712585783; x=1713190583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5c9zaur2makbeSzs8tMbbNAwtw8YnLlVv5IRMVa4MxI=;
        b=B8WWSToDYNiHbMyXszLnZpVDT1SEMTnKJ9Sionms4g6Vt5pe7WqjEzI306Ukmjh3Xw
         NbT36g5p3AEdG6hjRAb55XeGpFwokA1NUrTXvAzd5cfgCATSA0aBTrriS5lrSuFOLAcY
         y7/n6FfEkkzlQeGl8gnO+w8f8iWU/YcEQBX+n9HBGobujG/ri7qBLNQbeJKOmYdEsr9o
         qQbek3GrUGHNvWql+gbqxl9bHc7jarPhvAjD0WSOHNusVN9sTYOWbfCjYz39SAlEsnGf
         3olMeey2LUomE5IqhXLE4s7I0wWad8jf5wwg7ImiuBCDxVXcoYBDLUPcECMzwJhxbVOK
         W71w==
X-Gm-Message-State: AOJu0YzIIY3W95Xe8l54eTz9ceNLF/uksvynZDZvnHTHgNFPORWOGsIQ
	zoAQ4yD6iU7UnezDj+O/L9H2Cm7XWlAPtYPX+rta0Owe7TJgP8D685iZ3DnB
X-Google-Smtp-Source: AGHT+IH3vxXBMuT0zvQnjwz2Rhu8oauxp9+9rXTZxO4/zwUJfV2u4PwKwWJK7h1BMpCvmdnc1SlM9Q==
X-Received: by 2002:a50:cd46:0:b0:56d:f29d:c80d with SMTP id d6-20020a50cd46000000b0056df29dc80dmr1983703edj.5.1712585782883;
        Mon, 08 Apr 2024 07:16:22 -0700 (PDT)
Received: from 127.0.0.1localhost ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id g23-20020aa7c857000000b0056e5a095c49sm1621187edt.78.2024.04.08.07.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 07:16:22 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH net-next v3] net: enable SOCK_NOSPACE for UDP
Date: Mon,  8 Apr 2024 15:16:20 +0100
Message-ID: <0e2077519aafb2a47b6a6f25532bfd43c8b931aa.1712581881.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wake_up_poll() and variants can be expensive even if they don't actually
wake anything up as it involves disabling irqs, taking a spinlock and
walking through the poll list, which is fraught with cache bounces.
That might happen when someone waits for POLLOUT or even POLLIN as the
waitqueue is shared, even though we should be able to skip these
false positive calls when the tx queue is not full.

Add support for SOCK_NOSPACE for UDP sockets. The udp_poll() change is
straightforward and repeats after tcp_poll() and others. In sock_wfree()
it's done as an optional feature because it requires support from the
poll handlers, however there are users of sock_wfree() that might be
unprepared to that.

Note, it optimises the sock_wfree() path but not sock_def_write_space().
That's fine because it leads to more false positive wake ups, which is
tolerable and not performance critical.

It wins +5% to throughput testing with a CPU bound tx only io_uring
based benchmark and showed 0.5-3% in more realistic workloads.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---

v3: fix a race in udp_poll() (Eric)
    clear SOCK_NOSPACE in sock_wfree()

v2: implement it in sock_wfree instead of adding a UDP specific
    free callback.

 include/net/sock.h |  1 +
 net/core/sock.c    |  9 +++++++++
 net/ipv4/udp.c     | 15 ++++++++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 2253eefe2848..027a398471c4 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -944,6 +944,7 @@ enum sock_flags {
 	SOCK_XDP, /* XDP is attached */
 	SOCK_TSTAMP_NEW, /* Indicates 64 bit timestamps always */
 	SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
+	SOCK_NOSPACE_SUPPORTED, /* socket supports the SOCK_NOSPACE flag */
 };
 
 #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
diff --git a/net/core/sock.c b/net/core/sock.c
index 5ed411231fc7..ae7446570726 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3393,6 +3393,15 @@ static void sock_def_write_space_wfree(struct sock *sk)
 
 		/* rely on refcount_sub from sock_wfree() */
 		smp_mb__after_atomic();
+
+		if (sock_flag(sk, SOCK_NOSPACE_SUPPORTED)) {
+			struct socket *sock = sk->sk_socket;
+
+			if (!test_bit(SOCK_NOSPACE, &sock->flags))
+				return;
+			clear_bit(SOCK_NOSPACE, &sock->flags);
+		}
+
 		if (wq && waitqueue_active(&wq->wait))
 			wake_up_interruptible_sync_poll(&wq->wait, EPOLLOUT |
 						EPOLLWRNORM | EPOLLWRBAND);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 11460d751e73..e23973bafed6 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -342,6 +342,7 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
 		hslot2->count++;
 		spin_unlock(&hslot2->lock);
 	}
+	sock_set_flag(sk, SOCK_NOSPACE_SUPPORTED);
 	sock_set_flag(sk, SOCK_RCU_FREE);
 	error = 0;
 fail_unlock:
@@ -2885,8 +2886,20 @@ __poll_t udp_poll(struct file *file, struct socket *sock, poll_table *wait)
 	/* psock ingress_msg queue should not contain any bad checksum frames */
 	if (sk_is_readable(sk))
 		mask |= EPOLLIN | EPOLLRDNORM;
-	return mask;
 
+	if (!(mask & (EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND))) {
+		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+
+		/* Order with the wspace read so either we observe it
+		 * writeable or udp_sock_wfree() would find SOCK_NOSPACE and
+		 * wake us up.
+		 */
+		smp_mb__after_atomic();
+
+		if (sock_writeable(sk))
+			mask |= EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND;
+	}
+	return mask;
 }
 EXPORT_SYMBOL(udp_poll);
 
-- 
2.44.0


