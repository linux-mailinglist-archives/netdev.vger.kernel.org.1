Return-Path: <netdev+bounces-85047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0EA89922D
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 01:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1E01C21DE8
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 23:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BE713C680;
	Thu,  4 Apr 2024 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMDHRDrt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B314013C672
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 23:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712273852; cv=none; b=BOLR69bdIodFLIGw5S4BZPZ6hYkj0MnR+UfDTq3eBejIe9jMQkzbVe1Fq/GYOddaSVmzuHxEgEwFiWEHWnOo3rMvWwvNcaXdA4iNjLjoTghxuarYWMjXsrjeqHUgn8825sRW8Bf5Zhasjnw5WhNG1TkxY88bFyJDVUSqbZXsHtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712273852; c=relaxed/simple;
	bh=8xmpO2PO8497s3ULBFRLxqphXzhM1UY1y8vkK+fYWsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kx/v3lOonHXocmaiOg5JoKebXWXE/U2upE9PPnBqB4gm42GqObikqp/ncrs5mgFVMShrinazxY00ZHliP1qgC+3LL7KhWq+UDVCvoh++JxtxoFJK/na7f+3Cq6QYYon3Ghiz1xNKrkYK8nvcXFlbOHQNMWf4v3H7qfRJv+4ZUA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMDHRDrt; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4162ae2a0e4so7889085e9.3
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 16:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712273848; x=1712878648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bopkRUSgMPXZeQzrpuGp2v8LQiisYBbDtRQN02asSEw=;
        b=gMDHRDrtVdjFlhQEYNavhHS8rZ/dkKJcONCGdvy+gllPmg39iybkWO5NcImElL/aU7
         KGLS/rARulXcrwhx2dNLRy/1IzDWr+jkv53YdKSki2SA9lxnFh51q/dZpVDvlWWHTUqu
         nsN8O4opYq2vD2sdD/rfztamNCMncEzdyrwXJWPow9ekspnWQqaroukHKsk4OqfCBYQe
         89jshRs/UlJe+slDmoEQBeS/kV/rlvEr8fh4GATMkNKDlmfR/gJRuzkUefksjAus110o
         cZyoMGMOwFAUj5iYrB5cnQprgRbJ/WLPTxSaXjqUwBN2wN1UWaon5SfZjHMsqguo9K8u
         A6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712273848; x=1712878648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bopkRUSgMPXZeQzrpuGp2v8LQiisYBbDtRQN02asSEw=;
        b=qsSzUemgUr8GoTzDelMwiLpB2kUp6eYTrbpyxFWYbvN2iN+Bo/hARguL6l8rT61L2U
         pCg8KqQVPR2vPdtqCM9GNhvfjuYcQYd23YmYCT/VaOuRtq1Zwb3bDvQHWhiux/3Hfab+
         QMAIT8z/4gH5szthok1XMtl5YPpovCakypO3gG92/GF62AJnTFgw2moaQYpwocm9sz2S
         uvEoeRxALju35ng8y5keDThGmy325Zwo5Dx3DCXZHFdhWoH1MYkvjk1++TzHRXL14FiB
         X89ozy8XVAC5D12FetytHAzSN0WIQf8KZFb7gvkxS0cTEpIBYxhoub1JRYa6wdmVpHPT
         j8oQ==
X-Gm-Message-State: AOJu0YzZzOMIrl5lHnpAKQb4v44nlirfh2Tb/sblriGx11/sdEqy0XJl
	Xm39qquXo5Uk6HTg6xsfJyjrJez9jwRsiHSMyRY+B97xBw2KRwEAUwbigwgx
X-Google-Smtp-Source: AGHT+IHb0lhuDbU0xhfRciXzpicNvCGP2FhqOFy+by03KenU3CeDjqzGPs+/aYCnq1sz7ve+iCUwcg==
X-Received: by 2002:a05:600c:6b06:b0:415:611f:a0a4 with SMTP id jn6-20020a05600c6b0600b00415611fa0a4mr3100107wmb.37.1712273848288;
        Thu, 04 Apr 2024 16:37:28 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.144.46])
        by smtp.gmail.com with ESMTPSA id ay14-20020a05600c1e0e00b004146a304863sm4359856wmb.34.2024.04.04.16.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 16:37:27 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH net-next v2] net: enable SOCK_NOSPACE for UDP
Date: Fri,  5 Apr 2024 00:37:25 +0100
Message-ID: <1da265997eb754925e30260eb4c5b15f3bff3b43.1712273351.git.asml.silence@gmail.com>
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
straightforward and repeats after tcp_poll() and others. However, for
sock_wfree() it's done as an optional feature flagged by
SOCK_SUPPORT_NOSPACE, because the feature requires support from the
corresponding poll handler but there are many users of sock_wfree()
that might be not prepared.

Note, it optimises the sock_wfree() path but not sock_def_write_space().
That's fine because it leads to more false positive wake ups, which is
tolerable and not performance critical.

It wins +5% to throughput testing with a CPU bound tx only io_uring
based benchmark and showed 0.5-3% in more realistic workloads.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/sock.h |  1 +
 net/core/sock.c    |  5 +++++
 net/ipv4/udp.c     | 15 ++++++++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

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
index 5ed411231fc7..e4f486e9296a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3393,6 +3393,11 @@ static void sock_def_write_space_wfree(struct sock *sk)
 
 		/* rely on refcount_sub from sock_wfree() */
 		smp_mb__after_atomic();
+
+		if (sock_flag(sk, SOCK_NOSPACE_SUPPORTED) &&
+		    !test_bit(SOCK_NOSPACE, &sk->sk_socket->flags))
+			return;
+
 		if (wq && waitqueue_active(&wq->wait))
 			wake_up_interruptible_sync_poll(&wq->wait, EPOLLOUT |
 						EPOLLWRNORM | EPOLLWRBAND);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 11460d751e73..309fa96e9020 100644
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
 
+	if (!sock_writeable(sk)) {
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


