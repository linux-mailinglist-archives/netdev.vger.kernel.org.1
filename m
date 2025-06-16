Return-Path: <netdev+bounces-198337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3098CADBDB9
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F75175DB8
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C8823815F;
	Mon, 16 Jun 2025 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enKW4K/8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AF2238C36
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116894; cv=none; b=Y10MYUg+HVlREF9QWIAuzxfvuLT4ZLcNb6Sse0v8anWgAsxUZoIbzsKUY8lLIe2r456FNYJKvy/f3PQGhQQFLAn/n/mAj+TeyoMAFHOb1aJAnfSjI1teGOc2oRmPdr7l/JyDiJVoaLteRX/cd+/P+GBlVhy496XcGjWCBmUf2GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116894; c=relaxed/simple;
	bh=Rlx50UeLGtIQLjwfjg+tAHN9dPK4B4kLXPy07wHdPNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVkAwXTSpyDafJ4AED4HwRHwo9oMRl5Pdzwoj79A2EF5wvP9HPkWngVbshILx/xGg7LSpKzvKNFn9bX/mEYtMpeHdBwm3+NFQ+Q6dIPw31iUkj8lGG6QuguvTW5tJwab1FpluuDeUj6iPXGdsbYgt1mz1DF/wL8jTf969JQiGnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enKW4K/8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso5791729a91.3
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750116893; x=1750721693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RI4xoY58S3ck2UdCQ7dr2b3rMhEjoj8/T7LDZGfNd0g=;
        b=enKW4K/8tfHs0c3ASGMBSSyKpQ1HNqaPNIerVhdWIQVCXKTnTCWewyb/NFzTi4vrih
         tHok8Caoq5uJpqtq0mYKgxGO//P+k8vZjgG41NYwa/naPKMgutN/I8GBviH8m232y06x
         M3U7uCzwC8MkBF0xxEjauxztZkdKkg9fDAHMy/GGy/ntlnGlNd40MQO76VO9ADnPNutE
         tYRbKLT0exiFA3BkYC86Auty3usKzYqWXLyzQpnfi8349KBnPU0Pbpo9ZxSXW08AUHCm
         YKDVSKQPUnZTk9ecs/+Q635UprcR7NCPnPkzGwYBNgFdjgCNv2/LA2vYXLTZbofWdy+d
         CzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750116893; x=1750721693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RI4xoY58S3ck2UdCQ7dr2b3rMhEjoj8/T7LDZGfNd0g=;
        b=BwRv/x3iBx0hGHpEv5OunV8dlxr7M32oSfaF0c1RWJ+fIhhht3ANbjA8iCehv6giiG
         KJ5PTAZmcXrF50oAw1rtCRo6qssvr9spFMS24A3oNrvDh6G6v6NYI4WpveZnk00fhMUc
         pSUp2CYVbSwqGy+6HQ8MVV9l6JQUNDzlEE9w5gnKH48+LSt2aV50Z0WLtnvRn+wNWjDd
         /VDnBkj1QKHFfAcguenjpunVT30/oWj9/9UhDskR6s4KOhJuAEDlumyPSBM27qpetgaX
         tufd0ld8BzDWsvjLsg6v5QffvUrOXwXLdOAvApS4V8OSgeRZcYrZaoyLXHBbeZs+ckIe
         hyXw==
X-Forwarded-Encrypted: i=1; AJvYcCXkBn/rbgCkFLnRr8/KAQ682ZNyH66O4dzxPScXUYta7dee7/O5QDzun5gqbKGh4neJKupasWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwvfK7HzMJcKwdIfAfWJRLAET6rbP/5Gh4QeR3WyL95BSsVrlQ
	dNzRAkWpOs/ySgzNlrHxPbHcZG5i5W9n7ZeKavbuR8Ct+DlmidIkeyM=
X-Gm-Gg: ASbGnctVWX2Rf26PofK8DODRIEW2/BmjLqdYbv88sIw7vG8GyBDNzeHyxpQauJzNW3e
	Ed3WC50YMRD3Uen+Vsuc9ef0xTtKjOTs/qXK6dQOMKCediygcsrvqGD5P4//WRlUtQDqlTU44vq
	W9+o4bl37bFvQvDYEr5+Y4PHVnYcV/+hVeJqnTZ0Ee/yDQ4N3fNNzUDMr8HAWxWkJhVAP0MhjEg
	U1mSRoWjJQTpRZ6DZ5hR+Tirm68czkOl5gaV1kEbStd1BKmVqK11T4HI8JlYulKumawhhrwCspZ
	xOzwk9MZRj2kydI6Vr+L01UbOrWy+zwurnq2ggc=
X-Google-Smtp-Source: AGHT+IHhKjPGqkwercFABIdTvtDbe23HWfrWCwJlf+IdKNbtiGH5aByOZ5Bn4tLqvyhF8IOkBzhPMg==
X-Received: by 2002:a17:90b:582f:b0:313:bf67:b354 with SMTP id 98e67ed59e1d1-313f1b87a40mr20952938a91.0.1750116892781;
        Mon, 16 Jun 2025 16:34:52 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de89393sm67220485ad.114.2025.06.16.16.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 16:34:52 -0700 (PDT)
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
Subject: [PATCH v1 net-next 11/15] ipv6: anycast: Don't use rtnl_dereference().
Date: Mon, 16 Jun 2025 16:28:40 -0700
Message-ID: <20250616233417.1153427-12-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616233417.1153427-1-kuni1840@gmail.com>
References: <20250616233417.1153427-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

inet6_dev->ac_list is protected by inet6_dev->lock, so rtnl_dereference()
is a bit rough annotation.

As done in mcast.c, we can use ac_dereference() that checks if
inet6_dev->lock is held.

Let's replace rtnl_dereference() with a new helper ac_dereference().

Note that now addrconf_join_solict() / addrconf_leave_solict() in
__ipv6_dev_ac_inc() / __ipv6_dev_ac_dec() does not need RTNL, so we
can remove ASSERT_RTNL() there.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/addrconf.c |  2 --
 net/ipv6/anycast.c  | 17 ++++++++---------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 78ee68771229..e9594938c2b4 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2252,7 +2252,6 @@ void addrconf_leave_solict(struct inet6_dev *idev, const struct in6_addr *addr)
 	__ipv6_dev_mc_dec(idev, &maddr);
 }
 
-/* caller must hold RTNL */
 static void addrconf_join_anycast(struct inet6_ifaddr *ifp)
 {
 	struct in6_addr addr;
@@ -2265,7 +2264,6 @@ static void addrconf_join_anycast(struct inet6_ifaddr *ifp)
 	__ipv6_dev_ac_inc(ifp->idev, &addr);
 }
 
-/* caller must hold RTNL */
 static void addrconf_leave_anycast(struct inet6_ifaddr *ifp)
 {
 	struct in6_addr addr;
diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
index 21e01695b48c..f510df93b1e9 100644
--- a/net/ipv6/anycast.c
+++ b/net/ipv6/anycast.c
@@ -47,6 +47,9 @@
 static struct hlist_head inet6_acaddr_lst[IN6_ADDR_HSIZE];
 static DEFINE_SPINLOCK(acaddr_hash_lock);
 
+#define ac_dereference(a, idev)						\
+	rcu_dereference_protected(a, lockdep_is_held(&(idev)->lock))
+
 static int ipv6_dev_ac_dec(struct net_device *dev, const struct in6_addr *addr);
 
 static u32 inet6_acaddr_hash(const struct net *net,
@@ -319,16 +322,14 @@ int __ipv6_dev_ac_inc(struct inet6_dev *idev, const struct in6_addr *addr)
 	struct net *net;
 	int err;
 
-	ASSERT_RTNL();
-
 	write_lock_bh(&idev->lock);
 	if (idev->dead) {
 		err = -ENODEV;
 		goto out;
 	}
 
-	for (aca = rtnl_dereference(idev->ac_list); aca;
-	     aca = rtnl_dereference(aca->aca_next)) {
+	for (aca = ac_dereference(idev->ac_list, idev); aca;
+	     aca = ac_dereference(aca->aca_next, idev)) {
 		if (ipv6_addr_equal(&aca->aca_addr, addr)) {
 			aca->aca_users++;
 			err = 0;
@@ -380,12 +381,10 @@ int __ipv6_dev_ac_dec(struct inet6_dev *idev, const struct in6_addr *addr)
 {
 	struct ifacaddr6 *aca, *prev_aca;
 
-	ASSERT_RTNL();
-
 	write_lock_bh(&idev->lock);
 	prev_aca = NULL;
-	for (aca = rtnl_dereference(idev->ac_list); aca;
-	     aca = rtnl_dereference(aca->aca_next)) {
+	for (aca = ac_dereference(idev->ac_list, idev); aca;
+	     aca = ac_dereference(aca->aca_next, idev)) {
 		if (ipv6_addr_equal(&aca->aca_addr, addr))
 			break;
 		prev_aca = aca;
@@ -429,7 +428,7 @@ void ipv6_ac_destroy_dev(struct inet6_dev *idev)
 	struct ifacaddr6 *aca;
 
 	write_lock_bh(&idev->lock);
-	while ((aca = rtnl_dereference(idev->ac_list)) != NULL) {
+	while ((aca = ac_dereference(idev->ac_list, idev)) != NULL) {
 		rcu_assign_pointer(idev->ac_list, aca->aca_next);
 		write_unlock_bh(&idev->lock);
 
-- 
2.49.0


