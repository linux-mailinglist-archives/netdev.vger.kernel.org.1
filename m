Return-Path: <netdev+bounces-64200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19666831B6C
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 15:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C64AA281917
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 14:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CC7375;
	Thu, 18 Jan 2024 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Puw+xXCi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6053631
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588508; cv=none; b=UghRSn6RQ7tsK2+M9dfA0ipUbwgKgvZAu1L4qMHC5X24RW1NYXuLMhLvIY+Fj1pIyCpKx4i7Ksto9kqKh82XWT5EwoyuTrFzEHnZYOYX4wEOEgov4o7wjZCG3RWI/v0p7QLc0eMWoGs/PrFkCVkiVrE51VK3VZYKH+Ny7PFXIp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588508; c=relaxed/simple;
	bh=VBle0F+IQyCrsIV7oe4Zx4LMZb73zXvQz0RTKucQqEo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	b=A0Qe7Jn+UNjhogT0n4TKiBIXCG3VhpMDvAOaYzMy+95ltGA3YAG20V7Wh0QLA+fAUREMxSRjGl54Evx4lyTq5XOanspUqKNUMUQA6XMPPe/aVAq94PjviQxV1xEZ+fj/eyA11+OIMTUowdWKwfvS/dMHFpdycoaNwI+uXFn/xH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Puw+xXCi; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc221ed88d9so4655637276.3
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 06:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705588506; x=1706193306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kg1FCUzShZpaA3L2oq597U467/68fYyKDNiGJd7f51k=;
        b=Puw+xXCiPzQSu3yRbEa4X9cA5I7vgiOqI7qpl6xgCKc2c5o4VEDFck1Fw0EWsDHvgO
         jQqCGUAjvMdJX3bK4H4bsiPtOhlT7hrjwNQPBdLC07WdhVpZsgbRCkJu33ugLXfjbD+1
         xn0RgC/YX1nJuflyPEXTUOtZFvSoAr6fs8el7tKVRfoJqkqShrroCiZLul2vk8KMP+Nv
         13P5WfLoEEGDknRHs9A1GOF68HoPBckKrz7hd3tiEzcoe34j8u12p2v8VG6alYRv/DPp
         iGvJFrMpwclYZR1auieVAM1pb3rf5TEDJWV6QITM4LUQE5t3In5G/6+fYGPZacDHRuad
         fbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705588506; x=1706193306;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kg1FCUzShZpaA3L2oq597U467/68fYyKDNiGJd7f51k=;
        b=HClKfPMVZ3Hn8KQGbzyaLffy1MmJhg1z3qgqoVPNDpHdtlLjEzt60sQMDy8KyQdaGd
         AOEhxD3mUt86Cgr294GFW58N2tmJxW2yxhG9jKwcjXKwmjwz6jJ+hUoIDAJOql9J6fJn
         71iMUB9o53kWMa61yOerivuMq+LFzRgWAYMwdDKR+B0h4aSotslVm7E5dJFmD2brbKQw
         AkHjIkDlzBfoZH40BV+EcBRQ11ScTO3+UYIsFZzzNmy38CSrzm2uPEeGAqSEmd2KiV+c
         vD18U3Ay7ECBeKBheTG6Cb4qS70RPOlvjz3zeVCMI8yKzzCjKJ9sj0qCfgdvbCtLZ+cn
         Z8aw==
X-Gm-Message-State: AOJu0YyE+0g+d8p2erm5jbePaFPvS0xsLP2I2SC5AVCpTKJLrtrDi7FW
	KI887fKcDRdDUYvi0hZ7S8dclHrCAvdfIpoUNPzbKvCrjRmQ246oK0mT2+dh/0tDCh1ljuzpcMq
	FDMN1TpL8RA==
X-Google-Smtp-Source: AGHT+IET0jet/PF78pGDmwAeyFo1ZFwpFHdc2ye+6c4uCS/2kmodLv58FnrfYOpNYO44mCHLdApHsT0Dfv7RKA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1827:b0:dc2:3426:c9ee with SMTP
 id cf39-20020a056902182700b00dc23426c9eemr40868ybb.11.1705588505915; Thu, 18
 Jan 2024 06:35:05 -0800 (PST)
Date: Thu, 18 Jan 2024 14:35:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <20240118143504.3466830-1-edumazet@google.com>
Subject: [PATCH net] udp: fix busy polling
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Generic sk_busy_loop_end() only looks at sk->sk_receive_queue
for presence of packets.

Problem is that for UDP sockets after blamed commit, some packets
could be present in another queue: udp_sk(sk)->reader_queue

In some cases, a busy poller could spin until timeout expiration,
even if some packets are available in udp_sk(sk)->reader_queue.

Fixes: 2276f58ac589 ("udp: use a separate rx queue for packet reception")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/skmsg.h |  6 ------
 include/net/sock.h    |  5 +++++
 net/core/sock.c       | 10 +++++++++-
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 888a4b217829fd4d6baf52f784ce35e9ad6bd0ed..e65ec3fd27998a5b82fc2c4597c575125e653056 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -505,12 +505,6 @@ static inline bool sk_psock_strp_enabled(struct sk_psock *psock)
 	return !!psock->saved_data_ready;
 }
 
-static inline bool sk_is_udp(const struct sock *sk)
-{
-	return sk->sk_type == SOCK_DGRAM &&
-	       sk->sk_protocol == IPPROTO_UDP;
-}
-
 #if IS_ENABLED(CONFIG_NET_SOCK_MSG)
 
 #define BPF_F_STRPARSER	(1UL << 1)
diff --git a/include/net/sock.h b/include/net/sock.h
index a7f815c7cfdfdf1296be2967fd100efdb10cdd63..b1ceba8e179aa5cc4c90e98d353551b3a3e1ab86 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2770,6 +2770,11 @@ static inline bool sk_is_tcp(const struct sock *sk)
 	return sk->sk_type == SOCK_STREAM && sk->sk_protocol == IPPROTO_TCP;
 }
 
+static inline bool sk_is_udp(const struct sock *sk)
+{
+	return sk->sk_type == SOCK_DGRAM && sk->sk_protocol == IPPROTO_UDP;
+}
+
 static inline bool sk_is_stream_unix(const struct sock *sk)
 {
 	return sk->sk_family == AF_UNIX && sk->sk_type == SOCK_STREAM;
diff --git a/net/core/sock.c b/net/core/sock.c
index 158dbdebce6a3693deb63e557e856d9cdd7500ae..e7e2435ed28681772bf3637b96ddd9334e6a639e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -107,6 +107,7 @@
 #include <linux/interrupt.h>
 #include <linux/poll.h>
 #include <linux/tcp.h>
+#include <linux/udp.h>
 #include <linux/init.h>
 #include <linux/highmem.h>
 #include <linux/user_namespace.h>
@@ -4143,8 +4144,15 @@ subsys_initcall(proto_init);
 bool sk_busy_loop_end(void *p, unsigned long start_time)
 {
 	struct sock *sk = p;
+	bool packet_ready;
 
-	return !skb_queue_empty_lockless(&sk->sk_receive_queue) ||
+	packet_ready = !skb_queue_empty_lockless(&sk->sk_receive_queue);
+	if (!packet_ready && sk_is_udp(sk)) {
+		struct sk_buff_head *reader_queue = &udp_sk(sk)->reader_queue;
+
+		packet_ready = !skb_queue_empty_lockless(reader_queue);
+	}
+	return packet_ready ||
 	       sk_busy_loop_timeout(sk, start_time);
 }
 EXPORT_SYMBOL(sk_busy_loop_end);
-- 
2.43.0.381.gb435a96ce8-goog


