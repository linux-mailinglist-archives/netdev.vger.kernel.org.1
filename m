Return-Path: <netdev+bounces-198329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 077BCADBDB1
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209761892C22
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E1E23498E;
	Mon, 16 Jun 2025 23:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd7irCiz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C7B230D35
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116884; cv=none; b=LWCSfXnDoDD4H2CvrG4vWc5yqNc09HWJEj31fWSXVimN35F0I/y8yXqomuc82FamNza0JOnr88gv/lc/xAoCXugx2580SFhNBZHY9vXzro/GejMo4rrqkzmL0bFotVkXDIdu+pUXKc8A8780P4gQ81jv0yV+zV7UJFdIZ5nHcQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116884; c=relaxed/simple;
	bh=pdn7S/dQnqU2T11puBoCWwmMdGFX86ByMYdZIFSi8wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbJVDEMcr1vc+WuYRQY41TKN0ggw7bp2cr0M1ft3amTuNtysqfNg0sXttWl+YDeyj8kz3T+eO52e62CAKMvdPyMGTKbTuP2W4efGmXt75+X/Jrt/PHQyuV6NtN+q6hJLAzEhTJgyihqchmFPOCupIUbaafmCvLEeRRYI1GJ8cZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bd7irCiz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2366e5e4dbaso19788685ad.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750116882; x=1750721682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v98T4Qjhj3E25B9suhHhfSaudyzIuav/yv4R0A+07T8=;
        b=bd7irCizfKLNuzSfcxCtdXGOYXh4PiSfZlqkjd0tgFlxatlKNpyVNy1TZ8KVyX/Blp
         m3IJPOJGuKn3YoDOXegQaxbxqERWzNys6GddWm4KcfEVJ/XlyvXUj9idGQS/rrDC4/kl
         zxK9I/WAO0cKbdqKO0BNGs9I0e+lVwRWOMHXKLZXA3DSf+WlqhIQ0klADh1aBlB0d+hp
         WskSptSDR4ThBJ56imK8mWc5mZ+bviTPmecWY3DfhmedGl/t5yh1aL2pHnHxTm4mc/8o
         0ytnmpg65BmAyobOvdsPp/HELAnvmclnskto7Xu3mmNuviNy+Zp0Bto2yeJLPZONKsyJ
         yE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750116882; x=1750721682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v98T4Qjhj3E25B9suhHhfSaudyzIuav/yv4R0A+07T8=;
        b=GOEvMn7zDehonvdz87ZWoruhQU7u8QzR/lE6SUJ0/FmLL7uI2Z1RdY3K4uYBaNBNiu
         LKWfWXcnIpZyL5VoJ7bZBMYVPv7w01TtNmplz3a714JLZ2wRx1syMfP65Qkn0spa4iow
         Y0c4/k35ABX3AGRFbSNFPskeqFFtn66pQydPA0fhF+FEBC7Zf1QuebWJQQlnVHls+sFn
         DkKyxCNXqpL0+A12h4Dw79jJg1VHXiq7ZX0dKbm+g5Xhoc75j+/DTnALKhPHbf0vsrwr
         ZXwmfRebKHBV/erILFOsoti/kciYRj72vZFwtdANPaaOKeQikpD7prBFOGmClPsa63qj
         wBhw==
X-Forwarded-Encrypted: i=1; AJvYcCUF9dj/8qvhdMzbdSLxRVWqA5wqJ6L8ZZt92v2lV6Wquzfp3ijUgID+ggaZD6KZQKsxVo10INA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ2NgKLCl+6QgAmyd4FKhUq5aDbFUxSUH0H+83Y42t3TspHoQ4
	DZjnou7A7a1fNz9lomVPJnfl+Krh/WQPuHchi1UQSK4iwmYbVUL3fxw=
X-Gm-Gg: ASbGncvGcWz23r9E3SeGs7H2BVHC7X6wjKbyM8TjKI/SkXv5btlKUUXOFvBtrMxODsI
	cay9kA7CY+PDejCbjsIKJbs2NamBx8MrtgaZJ7Tz3Mmre5EfuP/Xcp1LVcpM1R3hdfIA92OEsvJ
	6PsqidcRAFWF7NnFOv06PgC9cGPH5W7NgAldQg6FiktJgsLJBfwHjzWgM+x58zTLbE1xKNxYmtB
	K1yu6hB2yUBMyRiksp6KiPXWPk60Ap5tTNwNLe190vPnoi6liBRwxrhFrF7jeBanQOWMtjq+MFq
	BW8ZhXjPaWKEY/MKZaOG+MzeSc3ZGUNZESRw6Mq4ayZgp9WYkw==
X-Google-Smtp-Source: AGHT+IHP8HGzX82aQNFbEGq/ZGoxKkikSjUOyU0j6V9fv3sCk+2En/aYkYH+zwW7IdPpBpoYNvsLJg==
X-Received: by 2002:a17:903:2ac7:b0:235:278c:7d06 with SMTP id d9443c01a7336-2366ae00e80mr184243835ad.8.1750116881952;
        Mon, 16 Jun 2025 16:34:41 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de89393sm67220485ad.114.2025.06.16.16.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 16:34:41 -0700 (PDT)
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
Subject: [PATCH v1 net-next 03/15] ipv6: mcast: Check inet6_dev->dead under idev->mc_lock in __ipv6_dev_mc_inc().
Date: Mon, 16 Jun 2025 16:28:32 -0700
Message-ID: <20250616233417.1153427-4-kuni1840@gmail.com>
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

Since commit 63ed8de4be81 ("mld: add mc_lock for protecting
per-interface mld data"), every multicast resource is protected
by inet6_dev->mc_lock.

RTNL is unnecessary in terms of protection but still needed for
synchronisation between addrconf_ifdown() and __ipv6_dev_mc_inc().

Once we removed RTNL, there would be a race below, where we could
add a multicast address to a dead inet6_dev.

  CPU1                            CPU2
  ====                            ====
  addrconf_ifdown()               __ipv6_dev_mc_inc()
                                    if (idev->dead) <-- false
    dead = true                       return -ENODEV;
    ipv6_mc_destroy_dev() / ipv6_mc_down()
      mutex_lock(&idev->mc_lock)
      ...
      mutex_unlock(&idev->mc_lock)
                                    mutex_lock(&idev->mc_lock)
                                    ...
                                    mutex_unlock(&idev->mc_lock)

The race window can be easily closed by checking inet6_dev->dead
under inet6_dev->mc_lock in __ipv6_dev_mc_inc() as addrconf_ifdown()
will acquire it after marking inet6_dev dead.

Let's check inet6_dev->dead under mc_lock in __ipv6_dev_mc_inc().

Note that now __ipv6_dev_mc_inc() no longer depends on RTNL and
we can remove ASSERT_RTNL() there and the RTNL comment above
addrconf_join_solict().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/addrconf.c |  7 +++----
 net/ipv6/mcast.c    | 11 +++++------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index ba2ec7c870cc..e4c48638211b 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2229,13 +2229,12 @@ void addrconf_dad_failure(struct sk_buff *skb, struct inet6_ifaddr *ifp)
 	in6_ifa_put(ifp);
 }
 
-/* Join to solicited addr multicast group.
- * caller must hold RTNL */
+/* Join to solicited addr multicast group. */
 void addrconf_join_solict(struct net_device *dev, const struct in6_addr *addr)
 {
 	struct in6_addr maddr;
 
-	if (dev->flags&(IFF_LOOPBACK|IFF_NOARP))
+	if (READ_ONCE(dev->flags) & (IFF_LOOPBACK | IFF_NOARP))
 		return;
 
 	addrconf_addr_solict_mult(addr, &maddr);
@@ -3865,7 +3864,7 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 	 *	   Do not dev_put!
 	 */
 	if (unregister) {
-		idev->dead = 1;
+		WRITE_ONCE(idev->dead, 1);
 
 		/* protected by rtnl_lock */
 		RCU_INIT_POINTER(dev->ip6_ptr, NULL);
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 5cd94effbc92..15a37352124d 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -952,23 +952,22 @@ static void inet6_ifmcaddr_notify(struct net_device *dev,
 static int __ipv6_dev_mc_inc(struct net_device *dev,
 			     const struct in6_addr *addr, unsigned int mode)
 {
-	struct ifmcaddr6 *mc;
 	struct inet6_dev *idev;
-
-	ASSERT_RTNL();
+	struct ifmcaddr6 *mc;
 
 	/* we need to take a reference on idev */
 	idev = in6_dev_get(dev);
-
 	if (!idev)
 		return -EINVAL;
 
-	if (idev->dead) {
+	mutex_lock(&idev->mc_lock);
+
+	if (READ_ONCE(idev->dead)) {
+		mutex_unlock(&idev->mc_lock);
 		in6_dev_put(idev);
 		return -ENODEV;
 	}
 
-	mutex_lock(&idev->mc_lock);
 	for_each_mc_mclock(idev, mc) {
 		if (ipv6_addr_equal(&mc->mca_addr, addr)) {
 			mc->mca_users++;
-- 
2.49.0


