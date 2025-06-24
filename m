Return-Path: <netdev+bounces-200828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9962AE70AE
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2601BC4A41
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5CC2EF2A9;
	Tue, 24 Jun 2025 20:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7wwOFSY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAA22EE96F
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750796802; cv=none; b=trNNt5UTi2O23ijCvUBImZz+Xbdjj84x/+ramVeEc5MBJlb33x68GVH0cjW7ceurOZ28Ob04VDYSja9VpQuGowTwQefERwykuA5erLOaFPtZT/kYsxKjOKZ8tHFdm0tib93TJz7B1ozeJQ361VCZUMYfUUqrZ7+ZYKqjVd2uIG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750796802; c=relaxed/simple;
	bh=wLyM5yxxx5j7+XQzS+pf/0GOuxVe2CazDwSLJr+D3h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tM8JpIObjppvFjBoVjFmVtiNgy2tUW+BGZCHF+i7frh5FgKvwGpvoYQsT0bEWy7+Wf/NhobnS+Pz7jOb0c37r0Wdt7pSqWqItGA1xgsT4nRE1LuJj3dheGl+tDE0i74zFR5x+HfudbHvMlG6apS6Ej5vTlyGhpTaleieScnMtS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7wwOFSY; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748d982e97cso4982179b3a.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 13:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750796800; x=1751401600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaSuHWKj6ByyVxlDicXMSCiJF5GaFLVUNosNFU7DZgE=;
        b=K7wwOFSYNPdBjDmuC5Tsg0UdW36nd2zpa2zTnQM8u1Dc4CJYr+pIVDMiY0SnOeaw33
         wFhtqUIvhfEHOll8wunLqtjlID/6L5nRKqaSFE6DcQav2c+7s4yzvoS15KbOR14Tcdt8
         gbryWW0qAh3hG5pOm+SjdBsiZKf/9jEORc9oAtfvqouSV57KjdoXvaLvicxb8aSVhi9/
         8MxaxMAxTJamKFZSHCYXmUquxI5EwnNH20GKnPdAS9PWtWfkZOnRRQrPeSt96GnZnLai
         tei5ru0PGszY1x6evRQV5kQQGMy+vaYbAeHyCOluTGfMex9k32c5qqnF/0ZJfnQq+m5H
         UMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750796800; x=1751401600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JaSuHWKj6ByyVxlDicXMSCiJF5GaFLVUNosNFU7DZgE=;
        b=lV/6a4JIQPOudSRPWBqKYo2I9RFN7KLSr9p8uph2lmC/f0M110hK6nk3RM5DOtzD8t
         by6ta6AU+FC2OPLEXtNv0r7alf0NixMUFgomM7RuN/QXDP7jpEu+gLfd6kYKfx0iDYkP
         6vPqT6N3MuITIWHLT9yW+PifCYhcy0dKbqMi45aN6yeIM5h/c0waNFsgIMbfBdR/Mb8i
         Q825rX7CA3RmPLxlcMX7Ak8WVDn6XBFtnH1uDreBEGHjRj4OPUGg/OVfkjbK8WYFpXn6
         yqOLk6BHPEMQRcbH16Lh6xg0mPQUkppCa2ijJ2JbFHWcy9GmNpUhzpdbt2YBh4BSjh/7
         9bGg==
X-Forwarded-Encrypted: i=1; AJvYcCWAU1OUzCR4mmOUDpk24wzzvGjCHVC44qNQbEwiv2GTxaix2LfjIyPnhiYB00azuuma6aPL8M4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx3+PnBnSxvOOfs8j6RpMq6rrqkNRcf7bbIKJbA4kz8Xqi5MUo
	adEweLDsenKaX1uQ4r6OWdiSPSjvwUbHfVYgJMBWQ2XESk9OvKvzlGU=
X-Gm-Gg: ASbGncsvv3hgD9P3Mi12N0uCAlPLjaTKN5CyI+a/WE/VFZIWq9kAbnYShXk7f/LmEKe
	PIRtZSC+TYqCUrI67dtB3nZueCMwhdZCcVH6KwQmeKP+tXZXOifh3G1IOpy99LMrJocOxHWEJi/
	9Pbfb+HbWorzOqMS8bbENu1zqZM8B52sEoTsJH4KeFzBHmYyedvMx46CISGMP1wadDsxNjPZtx6
	9hXDw/wudIwC8fu8YP2YC3lwPoqdCrGCka9VThYgqrTR8hrkMf9wOmCwt72CKlFqEQX/+hCjWKd
	K0YMkk/Wl/6VIj/WZ1Gpi7euNLdAqnK2E+7qclg=
X-Google-Smtp-Source: AGHT+IGicDYjzJoM4FNdLFdd58LqpRyQT5byzY5g1sNCeeJLMlLOvXjdz3+erI/iayca3CarKiWo1w==
X-Received: by 2002:a05:6a00:9291:b0:748:3385:a4a with SMTP id d2e1a72fcca58-74ad45e6fffmr727913b3a.23.1750796800165;
        Tue, 24 Jun 2025 13:26:40 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74a9697817esm2252994b3a.124.2025.06.24.13.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 13:26:39 -0700 (PDT)
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
Subject: [PATCH v2 net-next 11/15] ipv6: anycast: Don't use rtnl_dereference().
Date: Tue, 24 Jun 2025 13:24:17 -0700
Message-ID: <20250624202616.526600-12-kuni1840@gmail.com>
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


