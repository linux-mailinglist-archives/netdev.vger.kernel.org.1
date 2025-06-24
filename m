Return-Path: <netdev+bounces-200823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C78AE70A8
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC0617E8A4
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4992EE279;
	Tue, 24 Jun 2025 20:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfZGVOGQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898492E9ECC
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750796795; cv=none; b=LcH1DoefX0m1TNlXCV/QNu4r0anJF9P7lLBM4PzusqfjFqrsn5a10aHU07Z5EXxbp2Gs8vSCCNjhfRvxhmQhAXNs2Y4fAEEr6Po2PK4Oqxcad9TNeAxM1jdU1UAnlfF72WZC6guCKtF8hXRZEYRsOj3PF0i0nWm2OV/GyUo7Jkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750796795; c=relaxed/simple;
	bh=6KfumiYA30J/AFNogPP8Hsko69pQ7OPaKAQFSlxMZDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fr+3xLscSgO1ONF9hFhTDwD5f5mU+iZaBm8mWEXm+9U6pIk3MxJOgSiI/qjZAXtkV51MP4LUe55QhWQyo1GrgdhwLoX66mbyCpFKW8VUsbhLLi2p0nFvVvoSm4zl05gwF2rOhlcQv9bdbS777xmTUVyA0JUNU4oP+BJ8+7nT+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfZGVOGQ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso4487742b3a.3
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 13:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750796793; x=1751401593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQ1LE11bXqvfKDR/oWXFer7PIDXYl/MgUZLZhN514kY=;
        b=UfZGVOGQozu36yhhTptddiE9UcsplFa7JEAcVHm92uL3A6XvL5RzyOgc6RzXFpgSdd
         D4BSGRX/o8k7CDJnR9AoxdITTXh4ciZqw/b3za0OJjhQU7IstcQ0tlV4ePlyoSdwfAeQ
         GUuuTc/oWfcLaVVsINa5PmjflRP5utic8SgvCRpXN/5LFrtHJlSBO532ipewUgs4G52V
         FP+Mt380ARegqfUP9cUHqsxuqw9j7URLBlNmJVyHbV9MStQO8Re9e9RxiUnMW7GSkoTW
         DwdNuh0n5xb0gYVAhYEkzrj2jws4pKKBlekWaJn2nTXYZtKHwmK5Ki9/7H9KjK0oRZT0
         YQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750796793; x=1751401593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQ1LE11bXqvfKDR/oWXFer7PIDXYl/MgUZLZhN514kY=;
        b=MGShMR0eTSg6sLLXXyTPZjikAMZZEE5Uv4lKAdXgSBnOGha3B0kjyADfppJ7MKshx1
         M1kFVtRdl7NKujPZsbJ3INz3FNL0QuaYdSG3L4hHxjmsD+y9M6juxJK8WmXIYRgp4mOD
         0ZtGmns9gi+1YV3NGaH+9zF/rpXOu6/prEnnnMg70CtV35paWUMJ+OKcWRJTp4oNI37x
         JoMyzGv0ddw7e+TJ6AiwGwt1YtL65pIfrTUIb/EozpgqIj7Rm7t8eMpjcqXfMrwbCPDY
         5yNK7yXyqZw0eEYzLpG3AwdJ8vFCgWYUSmPmfLM3mqySiCNAxanPltOhTnH0xP2XvMif
         E4/w==
X-Forwarded-Encrypted: i=1; AJvYcCVRofBkiJsDqCP/5OjN0VW5LIgQNk7tJgh6214BkviweTMxxqoXixeEr5YwAzWXf+ifb3FOtLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ284aFBYdFkhCopxabgrifCWkYvQpbFMlZVDJgxHDLn6hXUTP
	3OLginhgx6o6k/iJ/+EgcgCqsf4XtA2XZQzZj0jFOdwBlAEWLkaImco=
X-Gm-Gg: ASbGncvFD8nk9wAbLN/o+m5Hfeok0U/ssG7DCIwgYDjX0JGNBPHTi3wFzgIEu+GCs1P
	/YjZCr5eouArzy3Rn2um09rmS2OyqxBntZ4/iRRdUDPdjHNtqCxiMdhwXSrW0UM+9g4ssEdEUSl
	WRa17d73EBJT2P1EdZYmTW3lf38X3YM4a1fU7+eh0+xLWpooKGzVl+CJh7y2K1RaMWVHJudmyJ0
	56z7Addlgw0TLzV5WoZy/M+fzbUAXYEtxHZ7pram5+ZVRi4K3rxyTTL8DhgfkhqvSg3fNSq2e7O
	qKDZ6xSrlbXpMJ1sGSA26Jf6A23BlQWAGpjHULw=
X-Google-Smtp-Source: AGHT+IF53n389uhL+8TVtuPZ5i2UavB61tRYUq2E5NGdI8JyMIWvfivhSYpmI2JgzTI0yFxkrqOKAQ==
X-Received: by 2002:a05:6a00:4b13:b0:73c:b86:b47f with SMTP id d2e1a72fcca58-74ad443d66emr768631b3a.4.1750796792917;
        Tue, 24 Jun 2025 13:26:32 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74a9697817esm2252994b3a.124.2025.06.24.13.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 13:26:32 -0700 (PDT)
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
Subject: [PATCH v2 net-next 06/15] ipv6: mcast: Don't hold RTNL for IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.
Date: Tue, 24 Jun 2025 13:24:12 -0700
Message-ID: <20250624202616.526600-7-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624202616.526600-1-kuni1840@gmail.com>
References: <20250624202616.526600-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

In __ipv6_sock_mc_join(), per-socket mld data is protected by lock_sock(),
and only __dev_get_by_index() requires RTNL.

Let's use dev_get_by_index() and drop RTNL for IPV6_ADD_MEMBERSHIP and
MCAST_JOIN_GROUP.

Note that we must call rt6_lookup() and dev_hold() under RCU.

If rt6_lookup() returns an entry from the exception table, dst_dev_put()
could change rt->dev.dst to loopback concurrently, and the original device
could lose the refcount before dev_hold() and unblock device registration.

dst_dev_put() is called from NETDEV_UNREGISTER and synchronize_net() follows
it, so as long as rt6_lookup() and dev_hold() are called within the same
RCU critical section, the dev is alive.

Even if the race happens, they are synchronised by idev->dead and mcast
addresses are cleaned up.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Hold rcu_read_lock() around rt6_lookup & dev_hold()
---
 net/ipv6/ipv6_sockglue.c |  2 --
 net/ipv6/mcast.c         | 22 ++++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 1e225e6489ea..cb0dc885cbe4 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -121,11 +121,9 @@ static bool setsockopt_needs_rtnl(int optname)
 {
 	switch (optname) {
 	case IPV6_ADDRFORM:
-	case IPV6_ADD_MEMBERSHIP:
 	case IPV6_DROP_MEMBERSHIP:
 	case IPV6_JOIN_ANYCAST:
 	case IPV6_LEAVE_ANYCAST:
-	case MCAST_JOIN_GROUP:
 	case MCAST_LEAVE_GROUP:
 	case MCAST_JOIN_SOURCE_GROUP:
 	case MCAST_LEAVE_SOURCE_GROUP:
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index b3f063b5ffd7..9fc7672926bf 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -175,14 +175,12 @@ static int unsolicited_report_interval(struct inet6_dev *idev)
 static int __ipv6_sock_mc_join(struct sock *sk, int ifindex,
 			       const struct in6_addr *addr, unsigned int mode)
 {
-	struct net_device *dev = NULL;
-	struct ipv6_mc_socklist *mc_lst;
 	struct ipv6_pinfo *np = inet6_sk(sk);
+	struct ipv6_mc_socklist *mc_lst;
 	struct net *net = sock_net(sk);
+	struct net_device *dev = NULL;
 	int err;
 
-	ASSERT_RTNL();
-
 	if (!ipv6_addr_is_multicast(addr))
 		return -EINVAL;
 
@@ -202,13 +200,18 @@ static int __ipv6_sock_mc_join(struct sock *sk, int ifindex,
 
 	if (ifindex == 0) {
 		struct rt6_info *rt;
+
+		rcu_read_lock();
 		rt = rt6_lookup(net, addr, NULL, 0, NULL, 0);
 		if (rt) {
 			dev = rt->dst.dev;
+			dev_hold(dev);
 			ip6_rt_put(rt);
 		}
-	} else
-		dev = __dev_get_by_index(net, ifindex);
+		rcu_read_unlock();
+	} else {
+		dev = dev_get_by_index(net, ifindex);
+	}
 
 	if (!dev) {
 		sock_kfree_s(sk, mc_lst, sizeof(*mc_lst));
@@ -219,12 +222,11 @@ static int __ipv6_sock_mc_join(struct sock *sk, int ifindex,
 	mc_lst->sfmode = mode;
 	RCU_INIT_POINTER(mc_lst->sflist, NULL);
 
-	/*
-	 *	now add/increase the group membership on the device
-	 */
-
+	/* now add/increase the group membership on the device */
 	err = __ipv6_dev_mc_inc(dev, addr, mode);
 
+	dev_put(dev);
+
 	if (err) {
 		sock_kfree_s(sk, mc_lst, sizeof(*mc_lst));
 		return err;
-- 
2.49.0


