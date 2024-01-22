Return-Path: <netdev+bounces-64617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E201835F95
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 11:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 144621F27A46
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 10:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2F33A8EE;
	Mon, 22 Jan 2024 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ODwehQH0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B25E3A8DB
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919011; cv=none; b=jHjO2hBAvriJeKkjP3buKZASsSomO6YuyQNi+NAzu6k6L2JfW71fFRAzMLWsR1y/DfRvmpVB6mEWZBM/k0ojuzoZHtlP1LwOo5qTVZCMN1V8MX1jxSn8dSpugQTXIFBC1Axd9FD30ivdGKvGFDyMTByKD0zQjew9Xtk+7cVc8K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919011; c=relaxed/simple;
	bh=3AmijIeD2kUt9jIKU4EfDUx5Yg/WBeq2ovXNrSvWzB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q0RfwEJb/4wG7xg/9QpLPLG+kigvs+8OW0LmW+0osUk0ou4MCOlorOjGdGPhR1bGvI+7hxtK+fTKXlOC0PisypcVuSLoRfPCD8zbqnKjkd8kxhhBMd61XuzUYWFPbShsUycsuWyAMeqP7vuxjv0KqTG2MY6cNMOk/OfXG2Fytfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ODwehQH0; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5993047a708so1468719eaf.3
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 02:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705919009; x=1706523809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=losw5b7MbaVXvh621rKMQxyUdxFbdvo0MVniZWvwIA4=;
        b=ODwehQH0qziVkdtlAig+Ay2OwYfPOhhyU+0EXkJKfFl8A15uNW3RxSRMwthm23AZGw
         NT+lzhK6HyOtw2V5S46Kk4QGTrkJuhSrz/1akaz1PtMohly8ZEydRFqEkWUSv8uSX0pl
         RB3D21Uax5NLLX8x6JTc5ccV8yidnQt7wdgdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705919009; x=1706523809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=losw5b7MbaVXvh621rKMQxyUdxFbdvo0MVniZWvwIA4=;
        b=hsQUdabVFOkWf/SNn9MzYwisLCykkTfRX99bcB2q5RgzrOoFr3SyAy0GyPwnaUbFd4
         y4PV3We1LLPKwyjOX/Jgn72oyQH6cI4qPQNwvHbIYboyf7lZ3OdGrDUljHg5diYevkfb
         AZVJT4XMer2lSVAEaHnYv2ZlmU7eANOktAGNCyMVs8NcI2HPZptCOBfKfivUwcC5Z0mF
         LB28BzqHpRG2eJNEn+uRosEgN8b5A8gH5Bmdlz6NnVBnQ9WknNkBkhna3HgPC++Jz5/b
         4P7h29MPrJVjXnj5xskWOu3u2uH4WeCQm8AjPTQzww9AhUdUX2XrU2eGFbd+8+EQKvIk
         JmCg==
X-Gm-Message-State: AOJu0YzVV3wkBXQoBuqSViUXU82UOfl4SFA+7HD81/jb7bauVJ33RySE
	8y5E1NXMFSPsESkjJMv93YmUk/09PZCZX3ifX1g1vB6xpJUwGcsHFqjZljVDPA==
X-Google-Smtp-Source: AGHT+IGg6TNkGvfYg87GZ0KqIuGgeoQoRTtY1pWTA8Zibi1zh7cNKUTM822h5KXdwP2qCO/WDm37zQ==
X-Received: by 2002:a05:6358:7e9d:b0:176:520c:c6a with SMTP id o29-20020a0563587e9d00b00176520c0c6amr1166286rwn.9.1705919009247;
        Mon, 22 Jan 2024 02:23:29 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:262c:66a:f637:81b7])
        by smtp.gmail.com with ESMTPSA id s66-20020a635e45000000b005cf9472aaf8sm8117986pgb.25.2024.01.22.02.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 02:23:28 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Zhengchao Shao <shaozhengchao@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH netdev] ipv6: Make sure tcp accept_queue's spinlocks are initialized
Date: Mon, 22 Jan 2024 18:23:20 +0800
Message-ID: <20240122102322.1131826-1-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 198bc90e0e73 ("tcp: make sure init the accept_queue's spinlocks
once") moved the TCP accept_queue spinlock initialization from a common
core function to two places for two cases: the common accept callback,
and the socket create callback.

For the second case, only AF_INET (IPv4) was considered. This results
in a lockdep error when accepting an incoming IPv6 TCP connection.

    INFO: trying to register non-static key.
    The code is fine but needs lockdep annotation, or maybe
    you didn't initialize this object before use?
    turning off the locking correctness validator.
    Call trace:
    ... <stack dump> ...
    register_lock_class (kernel/locking/lockdep.c:977 kernel/locking/lockdep.c:1289)
    __lock_acquire (kernel/locking/lockdep.c:5014)
    lock_acquire (./arch/arm64/include/asm/percpu.h:40 kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5756 kernel/locking/lockdep.c:5719)
    _raw_spin_lock (./include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154)
    inet_csk_complete_hashdance (net/ipv4/inet_connection_sock.c:1303 net/ipv4/inet_connection_sock.c:1355)
    tcp_check_req (net/ipv4/tcp_minisocks.c:653)
    tcp_v6_rcv (net/ipv6/tcp_ipv6.c:1837)
    ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:438)
    ip6_input_finish (./include/linux/rcupdate.h:779 net/ipv6/ip6_input.c:484)
    ip6_input (./include/linux/netfilter.h:314 ./include/linux/netfilter.h:308 net/ipv6/ip6_input.c:492)
    ip6_sublist_rcv_finish (net/ipv6/ip6_input.c:86 (discriminator 3))
    ip6_sublist_rcv (net/ipv6/ip6_input.c:317)
    ipv6_list_rcv (net/ipv6/ip6_input.c:326)
    __netif_receive_skb_list_core (net/core/dev.c:5577 net/core/dev.c:5625)
    netif_receive_skb_list_internal (net/core/dev.c:5679 net/core/dev.c:5768)
    napi_complete_done (./include/linux/list.h:37 (discriminator 2) ./include/net/gro.h:440 (discriminator 2) ./include/net/gro.h:435 (discriminator 2) net/core/dev.c:6108 (discriminator 2))
    ... <device callback> ...

Fix this by adding the appropriate code to AF_INET6 (IPv6) socket create
callback, mirroring what was added for AF_INET.

Fixes: 198bc90e0e73 ("tcp: make sure init the accept_queue's spinlocks once")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 net/ipv6/af_inet6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 13a1833a4df5..959bfd9f6344 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -199,6 +199,9 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	if (INET_PROTOSW_REUSE & answer_flags)
 		sk->sk_reuse = SK_CAN_REUSE;
 
+	if (INET_PROTOSW_ICSK & answer_flags)
+		inet_init_csk_locks(sk);
+
 	inet = inet_sk(sk);
 	inet_assign_bit(IS_ICSK, sk, INET_PROTOSW_ICSK & answer_flags);
 
-- 
2.43.0.429.g432eaa2c6b-goog


