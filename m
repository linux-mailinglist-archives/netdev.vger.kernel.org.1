Return-Path: <netdev+bounces-203561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C772BAF65C9
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F2A4A0F24
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E302F5C53;
	Wed,  2 Jul 2025 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B04y7bCM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D22A253F39
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 23:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497350; cv=none; b=WIN8m4333x8Di1h+ToKwu+TBYNvP5gIB7n35FlI4taDFmWN30ADZBL5Ue8tIfQbVZsDLeRxeBTGte38rkSZWevIJ2NR+c0EfsyG8qoGSVWSRMx+obF5XoCfB3CIy8BLyYtTh8Bmx8orCdBsWvYGHbF20NYdGirInHw8dQqRxxYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497350; c=relaxed/simple;
	bh=7y7yCPQ8CEAstM2pDZtT7Z3Z7yK6wRvOvvWNJfjs59A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0JrPL2VfupASYI456qZSWleyxTnrH3pBHyWDzSsEjdBbxt9A6cLcLERTdULtm0WxYl1GwfoxhWpbpGV23RD9gBsaaVH0B5lW2QhpcUeJfdXF2kNxl2q/kW665QnzVGOaDeLBPtMGn1jb9xjyX04qNtfHG4futUtFnvzxjIdML4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B04y7bCM; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b3226307787so3792506a12.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 16:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497348; x=1752102148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzHDHdLcqHmKiPd28yPqq7Ayk0Gi6xKA/rTjgoJ+4pY=;
        b=B04y7bCMg6P58mWHjagAs9UJzIoR5KpSgsKOVPq2lUYLytnInUGyFuvFDE4UYjWAqN
         MjNMmJUF2SOqYvV6SHV3Q9ZjzVR98XdnrzKfrmnpqZ4T8X+QQO7jDkHtmqh6BHYaUgm4
         zdtlSmLf2lStQcnZFmlObrMDtr8QncjugTkg7L/kuKkNGEQka4LYX7cLtjRo1i/qDZFp
         +E8ZpE2Mi6CMimvvmoelo/3Wjh65wcdRuG0sFCYHX1t5hlYShoKShgam578plfX0CPBh
         2TlkRTCyTvVFvAqn59VZQu6L+5UAptwRUO4VEpGZZes2guUxN2drDXCogsZZiSqhMXPx
         B1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497348; x=1752102148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzHDHdLcqHmKiPd28yPqq7Ayk0Gi6xKA/rTjgoJ+4pY=;
        b=gXcUhIFpew/PoaHf7GHkApLGAPuZDcjoHvqvH92gWcxZCVJrKx8j/1v9XGpA2CT+DJ
         Wi1DNV4JElgoZAPDrtofqQvUSFVzHMEowhs5eTPRtM/rGPUA32ovPY3yl4jALR4hYHfu
         ay4eL22MYiSfHhlt9od9d/dPJ+0PT6hvTFX3PuoYt6ajnjdWtOIcBVBAnUxvIoRj5YdL
         bgzhJZumPOebJSRKycH52BAJhqBAdUC0daNnP2EqXRVRSmF8kkC2QlCko/RErOucqTAD
         AEraV8FUKD7+ZLIu+2oVc+4EsYPTFX2U5VX8Rm4EtAmFvhZ9LMRKkvaSQ5d8b5LsX6ai
         fjYA==
X-Forwarded-Encrypted: i=1; AJvYcCWbkHWLjo6cjHdzpyvTxXI/spqxzZZSy0HHL+CtzuPIDK8sYs5e+gwsZp3KXChJSnw1ERTwOKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxfjTcMCMYiSwvF1INQn5V+OC0dGJRiSSPKv6CfSMZgl7l+CZE
	qbAv3GTZePeCr/+hxjdZBYvCXCHXZBLoS9G7dsRzeMlZ0V51KjCJSQg=
X-Gm-Gg: ASbGncsAR2TQRUTfYqKn60EP5982gybLqbGs0XDsu17xPoKy1SDaXYObX0U8Az1Llxe
	uOeDc2w4kiRg2ujkcl4jMejOk/YD4LajK/YK/+Y8DnxaxNfDukIIQbhHern4M4rJaD1kMl3Rroz
	Qku0hWfacn3eCaX6FcxmlBAgi+M1xocgx6Sg4ELM0sAx6NP22kjXnrCUlqFmYtnSBYtNt/9+Y4g
	LAhgf+Nvm34wKiAY4dA52bK3QsJCOr/QaPlrpyIjgQqke8s7SYIpA+R+9/EMLY+c4XcxS9m67Cn
	0ILhWFIITUQCBhb6Btg5ryEEibys9/FwD/vN38Pjx85fXwty5g==
X-Google-Smtp-Source: AGHT+IHQcZqU45J+ssSKCkNZhKEMR+Ycqp5xrCWdZy38fYSFKhW/HSiCLfuFjc6htCF+TTflavsZuQ==
X-Received: by 2002:a17:90b:58c7:b0:311:af8c:51cd with SMTP id 98e67ed59e1d1-31a90bd4921mr7969621a91.18.1751497347801;
        Wed, 02 Jul 2025 16:02:27 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc70a17sm727071a91.26.2025.07.02.16.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:02:27 -0700 (PDT)
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
Subject: [PATCH v3 net-next 11/15] ipv6: anycast: Don't use rtnl_dereference().
Date: Wed,  2 Jul 2025 16:01:28 -0700
Message-ID: <20250702230210.3115355-12-kuni1840@gmail.com>
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

inet6_dev->ac_list is protected by inet6_dev->lock, so rtnl_dereference()
is a bit rough annotation.

As done in mcast.c, we can use ac_dereference() that checks if
inet6_dev->lock is held.

Let's replace rtnl_dereference() with a new helper ac_dereference().

Note that now addrconf_join_solict() / addrconf_leave_solict() in
__ipv6_dev_ac_inc() / __ipv6_dev_ac_dec() does not need RTNL, so we
can remove ASSERT_RTNL() there.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/addrconf.c |  2 --
 net/ipv6/anycast.c  | 17 ++++++++---------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 8451014457dd..3c200157634e 100644
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


