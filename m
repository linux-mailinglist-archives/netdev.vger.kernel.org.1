Return-Path: <netdev+bounces-203558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF167AF65CA
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8B5E7B4C53
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44CC2F5097;
	Wed,  2 Jul 2025 23:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc9bnZw5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9052E7BA5
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 23:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497346; cv=none; b=QXwbRORJQRJ9cj0XMZix3+x5TXSa2AtlQtRANfO+7kfOlz6/eGk7ZLsQLPSiXa0KLv7BBLDW9r4ZpHxB0oZAYrcmUsW5bHFzqhsAMtPWzBI8Xvq0IBTMtdstJHwjAn25uFjheuR09RSDIsZYev+WzkS5+8GeNpKGPkZxKBE0jn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497346; c=relaxed/simple;
	bh=tHZZwPW3lv1jL+PIYyN8tKUhYMm58niNgplBk0aS9Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMz6yEIA28ciSrKbbeK2vTnSQd/0oL540uGOMiVXwNN5Z0ZXDRzVSouD7hmGuES0rPlZb7yFOoAqckgr+wfdn5DbCHQZat90aO8cX5diAbxjQuaUEA9bkl3n+WkqJasUkKCltcIJ4vNqRjE+M7GuCc3iYI6b5kHnUAhWlfI9+Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gc9bnZw5; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-315c1b0623cso5064297a91.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 16:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497345; x=1752102145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pSPKSteeg5bY4aYHp3kRXOpHaon94DoUSgL4WmVkqY=;
        b=Gc9bnZw5EwDsD95KNeKF64Y6p899xYv+IP/eCJfEp6igOllIjBnCaRbCXT9y91w8+A
         3I2T8V9k8VzymnnSovHz/QKJ+UjhAClpVqcW6Qmibb55vNy4CJgvvy9FBfu8f4XjNGSX
         xw8t9JcqgacCHZLS8Lu7lGaFieLsO06VPSyPExNMzGkenOgEVB68W2dzyKVuadhGh0kD
         014Qb8kUoWFqQOEpDRBt2/6lSU8Y6voqHDDsg23/mIWuTYFtjE2clqxc+12QjtIKff9M
         MaGiBoVyGjvCiUiwlrbKr6gitZ7WN6C445MdL1R+ZHL+ynZYC+5ptLtElbkk92L+dZnD
         SRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497345; x=1752102145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pSPKSteeg5bY4aYHp3kRXOpHaon94DoUSgL4WmVkqY=;
        b=jS/aaZqHEv4mf1BoXROStRYZA5Z2hYTun6cCiB/A9AlzpyLo/sDXJ9bHBw7DL+j/8D
         eVg/hpJQtXyERvfiGqQueOiGDUYAFv/1o/FaSTiqfz2J8OKsRY2Gap+ToYJfMo/IN2zh
         k1jt1IbW1NR5aN1AHLE9ezOuTASYOEHffoPDfJCd/uvJdFX+jNhphk5+IUjkpPvBcZq5
         i+oK/RC9TidamIFQJUJk0EHxdyUqu0Sw77RE5NWwe0USb0+pMmeUrr3GfN5oROEWh0yU
         3n782+9O+iqJjkazn32BVJJeH0qsxjKlfTeAHlEHTkyfgJpb3DGabZq4ayeQ83u6hM8a
         958Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTh0B38yrhkmk/+F6UIfnj2VfY+S1c0mu65GZXu+9fW1cUU8L4CENFkoq02d6dw2xvMiLkzg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGTFcyr5QFgHuZzMkqnM7QROJ8yPWoe5719OIWwAzZtkLl0czN
	ub4/QOkTAk9eTArQrnIKIJXyNyvLTH3kF7hKQvTdUtOlG6AInnHSh0s=
X-Gm-Gg: ASbGncv3zIpS5Ym12akOv3CFKXlMsb2eplAeuerN5H+v8T6+osVhfRnwhvSJxNudshO
	6ZhrDDqyFzRqIW2HpC5kObBi5FA2ql5prgf5SOENaKsRnGXCeAarz+zh/MgcRFYm607jrvRvOb2
	1r5aihYKSOxCkyH9wU39Qp/zG7RVWvb9MFc9f76g+NzfxC6JT7DmzAVsBKW8wyD68vB3v8SVe0S
	DpL8Iu+QUJ3p5E3SK2gLGaYCOOOVljHC+8k+jeSYhKJm3K7uzmRI65/vJ86ZV2TamfS7/rTAMQi
	2+rqRos1WTSGdumox1uZb6E9rV1agbf8hjyM+EU=
X-Google-Smtp-Source: AGHT+IHgfxB/C2AiWmViUrDOFHTf6f9IEd1wFTGUjJYAQgxjXRvb3a0uL9x5hAfHE2NcxEoazrFfLw==
X-Received: by 2002:a17:90b:3e50:b0:311:c939:c84a with SMTP id 98e67ed59e1d1-31a90b5a6cbmr7710208a91.15.1751497344457;
        Wed, 02 Jul 2025 16:02:24 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc70a17sm727071a91.26.2025.07.02.16.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:02:23 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v3 net-next 08/15] ipv6: mcast: Don't hold RTNL in ipv6_sock_mc_close().
Date: Wed,  2 Jul 2025 16:01:25 -0700
Message-ID: <20250702230210.3115355-9-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702230210.3115355-1-kuni1840@gmail.com>
References: <20250702230210.3115355-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

In __ipv6_sock_mc_close(), per-socket mld data is protected by lock_sock(),
and only __dev_get_by_index() and __in6_dev_get() require RTNL.

Let's call __ipv6_sock_mc_drop() and drop RTNL in ipv6_sock_mc_close().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/mcast.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index ed40f5b132ae..5c5f69f23d4a 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -334,28 +334,10 @@ void __ipv6_sock_mc_close(struct sock *sk)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct ipv6_mc_socklist *mc_lst;
-	struct net *net = sock_net(sk);
-
-	ASSERT_RTNL();
 
 	while ((mc_lst = sock_dereference(np->ipv6_mc_list, sk)) != NULL) {
-		struct net_device *dev;
-
 		np->ipv6_mc_list = mc_lst->next;
-
-		dev = __dev_get_by_index(net, mc_lst->ifindex);
-		if (dev) {
-			struct inet6_dev *idev = __in6_dev_get(dev);
-
-			ip6_mc_leave_src(sk, mc_lst, idev);
-			if (idev)
-				__ipv6_dev_mc_dec(idev, &mc_lst->addr);
-		} else {
-			ip6_mc_leave_src(sk, mc_lst, NULL);
-		}
-
-		atomic_sub(sizeof(*mc_lst), &sk->sk_omem_alloc);
-		kfree_rcu(mc_lst, rcu);
+		__ipv6_sock_mc_drop(sk, mc_lst);
 	}
 }
 
@@ -366,11 +348,9 @@ void ipv6_sock_mc_close(struct sock *sk)
 	if (!rcu_access_pointer(np->ipv6_mc_list))
 		return;
 
-	rtnl_lock();
 	lock_sock(sk);
 	__ipv6_sock_mc_close(sk);
 	release_sock(sk);
-	rtnl_unlock();
 }
 
 int ip6_mc_source(int add, int omode, struct sock *sk,
-- 
2.49.0


