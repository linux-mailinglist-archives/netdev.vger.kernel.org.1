Return-Path: <netdev+bounces-224880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB44B8B3B4
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 22:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B7F1CC3259
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA402C0F8A;
	Fri, 19 Sep 2025 20:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RoM8ORXC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA9429B78D
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758314943; cv=none; b=BG1nUVsaEza36jRGHVM9G2bnhowOwIP+Lxp9LM7FMqic58d47v0CDPYqgNwPNp/9jF4RRIlYufpf2wcP479vecBNaBf/I2YzL84lQGAvuxv9jU3fabnJM52eYgfrjcBKHXTaFwHZc6oINbWNg9a7T+Otao8t/N5PhSPGxI3mMNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758314943; c=relaxed/simple;
	bh=U/HfgbxsNPm6wW6egbxPtHHvAzfjgxnOMralWgmNh6w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T315csx3NrgE3/ZhS0xeYvwX60IVJ11I3+0VcbK0X+1NCADpSrALXltaAQGXMk5Kf1uGH6HkdTcdSGCqkeO/H7guG1kqpjJK4SDXtz7IVIfTOq6KDIa0jmaKynwdT23cDPXb29eyIJaZ9na/JUhpwbZTyISLeV+r2Ofe/4byABg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RoM8ORXC; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-811917bdcfeso560178785a.3
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 13:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758314940; x=1758919740; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3nbkByJpWTLEBVp4KbzpfZaZQAlzJNiyfEFFxH0zO48=;
        b=RoM8ORXC9cGz7pe7hv/QvSagtKE8ty1iLgn9nxSxjptgMKmRzDEStY2xE9/B3jItpH
         wzQUpMXJFT71WBhOcuejl7djuSVhj7uYJonTXw6jjSFKsvdO+AOgMj3Do3hzsaXhb6wE
         gQ2lMbN2oFFlyCcOtJ+Y847JHM4f3E9FcNSSh67FtlY3R6lazyxdQRfEyg18ytcYb5Xt
         4sNkrsm5pc1Ob9D0nNLrrKPnY7hvvPJlYr0N6x593lOGPO6cS17w9rVQQCeocHDsfEnf
         EwxI/GHbibN5I+UIApcEhxGdJNCaJrNKJdy60ogXmeJ/dmdeY5ttMwVI5auXEBB7Dz5J
         pLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758314940; x=1758919740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3nbkByJpWTLEBVp4KbzpfZaZQAlzJNiyfEFFxH0zO48=;
        b=XcOuZ1WwgNnwvWyD74z/a5A6bTrzb23bSPCJRBHAhIYt17+XzRyd5mnXAVTP7WJO1B
         lCDz3qY9tEKoR1S2b5Hsw6azzz/RY89W8kkP7Zr7Q6sd6wSsdgOQOtBxXvRHKvtMtE09
         23CUwwOsIcjhHv+1V7zW/6EjmhGjhqB+rOWVguXVrP5sEolKyX49FZS0g1TL1WMgy0/+
         61FeyU7ax4aKrZdEoKTleAUyGD+jmnLY9vMGjRAxqXDcqP+ZXkU9APZa1ZgpoUX4/VDO
         3MWT0YZNi2QfB8zjwPlYyuWj1k6K00bPGK4HbBpdKqt+XsMFpvnCcZMCbkD4VlSbx4d6
         DFog==
X-Forwarded-Encrypted: i=1; AJvYcCUsFdFsw+MVXlWUrcUKPRnpgvVM5FhG1Hodzvbd/3JGpIDMOLnkIWOP61U6C/FWQw/HQmJCX4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4IVEirHHbDcF3O7EXHvUw9YCmLF9iwllJ51gp3FAMA2MM+hyq
	mFUDFUy/Di8vvfGcFnX/DzXN926bvYkVAiPtU5DVUOvFSXKO+4Ws7Ud0tlt6tB2ajdI4IDSEUDV
	6l2J2F2ESMI1C0Q==
X-Google-Smtp-Source: AGHT+IEYKZyQjUPUeD3ZeteXFixUedI9Yi7gH22HuZD3OL5EdMITVS9PCeY/AhnB8NwuYArY4kzNCiGdhqQaAw==
X-Received: from qkpa15.prod.google.com ([2002:a05:620a:438f:b0:824:54dc:52d9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:448d:b0:800:367d:b9cf with SMTP id af79cd13be357-83ba494f092mr598219985a.38.1758314940592;
 Fri, 19 Sep 2025 13:49:00 -0700 (PDT)
Date: Fri, 19 Sep 2025 20:48:49 +0000
In-Reply-To: <20250919204856.2977245-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919204856.2977245-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919204856.2977245-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/8] net: move sk_uid and sk_protocol to sock_read_tx
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

sk_uid and sk_protocol are read from inet6_csk_route_socket()
for each TCP transmit.

Also read from udpv6_sendmsg(), udp_sendmsg() and others.

Move them to sock_read_tx for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h | 6 +++---
 net/core/sock.c    | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index ee95081b0c0bb24b6603a20f099606d350a26092..66c2f396b57de5a0048b4ae1e6181c4473be15c5 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -492,6 +492,9 @@ struct sock {
 	long			sk_sndtimeo;
 	u32			sk_priority;
 	u32			sk_mark;
+	kuid_t			sk_uid;
+	u16			sk_protocol;
+	u16			sk_type;
 	struct dst_entry __rcu	*sk_dst_cache;
 	netdev_features_t	sk_route_caps;
 #ifdef CONFIG_SOCK_VALIDATE_XMIT
@@ -517,15 +520,12 @@ struct sock {
 				sk_no_check_tx : 1,
 				sk_no_check_rx : 1;
 	u8			sk_shutdown;
-	u16			sk_type;
-	u16			sk_protocol;
 	unsigned long	        sk_lingertime;
 	struct proto		*sk_prot_creator;
 	rwlock_t		sk_callback_lock;
 	int			sk_err_soft;
 	u32			sk_ack_backlog;
 	u32			sk_max_ack_backlog;
-	kuid_t			sk_uid;
 	unsigned long		sk_ino;
 	spinlock_t		sk_peer_lock;
 	int			sk_bind_phc;
diff --git a/net/core/sock.c b/net/core/sock.c
index 21742da19e45bbe53e84b8a87d5a23bc2d2275f8..ad79efde447675c8a8a3aafe204e2bbb1a5efe7c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -4471,6 +4471,8 @@ static int __init sock_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_sndtimeo);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_priority);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_mark);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_uid);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_protocol);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_dst_cache);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_route_caps);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_gso_type);
-- 
2.51.0.470.ga7dc726c21-goog


