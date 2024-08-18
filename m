Return-Path: <netdev+bounces-119448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E0C955AC5
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 06:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B484281F2A
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 04:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570A08BFF;
	Sun, 18 Aug 2024 04:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABZE4IIB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21E823BB
	for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 04:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723955148; cv=none; b=s5qHO5xgSVLC2tVqV05fPUmJuV8GDU0hJN4YNGEYpRAc9hHFWuIg4FQHmBeWFNz6+cIWcaKHC2FHAmMSf8iYzJ/gSMbABzpgZmDCG2IbR5esAAK+KhnbG0vUS/K/if9CvhuSFcrJ4WLbd7D4yHkGtAjYhCZxevcs0gUOOqT9ThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723955148; c=relaxed/simple;
	bh=1qtZc9HlEVYrmxwQ2xccl0/VIGZaP+MIPW7hOYBWN3g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G9IDxKbjs0oNs3dnsuxHvp5blMPbt3IjUORTyWUU+v14l9FPhBlXiAINPyBgpGRkAgqZbGNgaHQySbpWqW7k2+viaympGNgbsUTFtoqmXUK6Vt0ch3QtPbF0hRlGgy+IOrLOQtB078iFm1YuCvMFBZl4nvCloFOe747WvtKsFEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABZE4IIB; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2701824beeeso1552804fac.1
        for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 21:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723955145; x=1724559945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oMp9rH2OAHY0fddABk+t+uetNaZNub/eE/AKJJ3GBIs=;
        b=ABZE4IIBy6Wv+rLr+VaO6gdjtrRMc13fy3A/LjDr5/CNUO8cy9CrfdEbI81CLH4yO5
         6yozj63kmiQGrqugIlIzkMfBxZ5Uhi5In6CDVOHn+x8jH/6A9nqXbs0WvNE3Ni1+2ijg
         FJS0rQknRtahU2sEvHzCZ36Lz7YUYPaBOu87kLabu2lQMHwTatOWkf0PgnCwDdJ4aAWv
         ZKcaKJxknGuAoxbkzXNL5WMFA8Vy26GDJYFxM1LCFDWOivG8YiGIBJ3wtnmBrqsP5eSz
         3mA84FFOgYguEaRrVznWCIYh7hLlTWjXXWuz5sTdrCzE+e/FxlZnzttrlcsFOO4Kk6lE
         AF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723955145; x=1724559945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMp9rH2OAHY0fddABk+t+uetNaZNub/eE/AKJJ3GBIs=;
        b=F3lul+dWbW6RKodM3WpdG9krc6GfRa6RXOz5sCs6NhwV/dzP70XHbvakldZbwEY3Wx
         g71gY7dY/lNTggLsE94wiam8JCAeGu9ymvbTbmTem7UiNrH4JlcYjy0/O0+mSNSe/ZnY
         nIUoBWAYE1je7bbYObOeosOsWDgiHs8KH7Ck2qTQD9inPiHLzQpPkFdvOEgc1jr9CQLk
         LdK9wq1AWAGB18g4MECKiOuDOngty/lD5DN88jMHh/RD9X5J7xCudFR+v1xQHRcBMV/W
         o46JEEQSwpnOl5zj8/xVuUF8UE+P45NPriz0dg4WzWDwGUseDCEK5l4QkaTmhV1MQFwN
         B+nQ==
X-Gm-Message-State: AOJu0Yz67dw6/CJ2fM2BcwbnVeW5b1E0LDDmGcfxMg+Xq12qvtnCxlIY
	Ode9uEWzZQyGSbmNUtOuJbqs8666xE16K2wt/ibZcljAuTEfUG8/
X-Google-Smtp-Source: AGHT+IH5BEc0lWUH/uHb3uY+LnWO6T1qy8NvIP8kWUWwxHzDgn5k+BdInCNaqJA32deq0mJe5YZ8fQ==
X-Received: by 2002:a05:6358:9045:b0:1ad:424:ae4 with SMTP id e5c5f4694b2df-1b393145524mr1028332155d.2.1723955145370;
        Sat, 17 Aug 2024 21:25:45 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3da60b66fsm5197008a91.22.2024.08.17.21.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 21:25:45 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ncardwell@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next] tcp: do not allow to connect with the four-tuple symmetry socket
Date: Sun, 18 Aug 2024 12:25:38 +0800
Message-Id: <20240818042538.40195-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Four-tuple symmetry here means the socket has the same remote/local
port and ipaddr, like this, 127.0.0.1:8000 -> 127.0.0.1:8000.
$ ss -nat | grep 8000
ESTAB      0      0          127.0.0.1:8000       127.0.0.1:8000

Before this patch, one client could start a connection successfully
as above even without a listener, which means, the socket connects
to its self. Then every time other threads trying to bind/listen on
this port will encounter a failure surely, unless the thread owning
the socket exits.

It can rarely happen on the loopback device when the connect() finds
the same port as its remote port while listener is not running. It
has the side-effect on other threads. Besides, this solo flow has no
merit, no significance at all.

After this patch, the moment we try to connect with a 4-tuple symmetry
socket, we will get an error "connect: Cannot assign requested address".

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/inet_hashtables.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 9bfcfd016e18..2f8f34ee62fb 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -978,6 +978,21 @@ void inet_bhash2_reset_saddr(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(inet_bhash2_reset_saddr);
 
+/* SYMMETRY means the socket has the same local and remote port/ipaddr */
+#define INET_ADDR_SYMMETRY(sk) (inet_sk(sk)->inet_rcv_saddr == \
+				inet_sk(sk)->inet_daddr)
+#define INET_PORT_SYMMETRY(sk) (inet_sk(sk)->inet_num == \
+				ntohs(inet_sk(sk)->inet_dport))
+#define INET_PORT_SYMMETRY_MATCH(sk, port) (port == \
+					    ntohs(inet_sk(sk)->inet_dport))
+static inline int inet_tuple_symmetry(struct sock *sk)
+{
+	if (INET_ADDR_SYMMETRY(sk) && INET_PORT_SYMMETRY(sk))
+		return -EADDRNOTAVAIL;
+
+	return 0;
+}
+
 /* RFC 6056 3.3.4.  Algorithm 4: Double-Hash Port Selection Algorithm
  * Note that we use 32bit integers (vs RFC 'short integers')
  * because 2^16 is not a multiple of num_ephemeral and this
@@ -997,13 +1012,13 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 			struct sock *, __u16, struct inet_timewait_sock **))
 {
 	struct inet_hashinfo *hinfo = death_row->hashinfo;
+	bool tb_created = false, symmetry_test = false;
 	struct inet_bind_hashbucket *head, *head2;
 	struct inet_timewait_sock *tw = NULL;
 	int port = inet_sk(sk)->inet_num;
 	struct net *net = sock_net(sk);
 	struct inet_bind2_bucket *tb2;
 	struct inet_bind_bucket *tb;
-	bool tb_created = false;
 	u32 remaining, offset;
 	int ret, i, low, high;
 	bool local_ports;
@@ -1011,12 +1026,18 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	u32 index;
 
 	if (port) {
-		local_bh_disable();
-		ret = check_established(death_row, sk, port, NULL);
-		local_bh_enable();
+		ret = inet_tuple_symmetry(sk);
+		if (!ret) {
+			local_bh_disable();
+			ret = check_established(death_row, sk, port, NULL);
+			local_bh_enable();
+		}
 		return ret;
 	}
 
+	if (INET_ADDR_SYMMETRY(sk))
+		symmetry_test = true;
+
 	l3mdev = inet_sk_bound_l3mdev(sk);
 
 	local_ports = inet_sk_get_local_port_range(sk, &low, &high);
@@ -1046,6 +1067,8 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 			port -= remaining;
 		if (inet_is_local_reserved_port(net, port))
 			continue;
+		if (symmetry_test && INET_PORT_SYMMETRY_MATCH(sk, port))
+			continue;
 		head = &hinfo->bhash[inet_bhashfn(net, port,
 						  hinfo->bhash_size)];
 		spin_lock_bh(&head->lock);
-- 
2.37.3


