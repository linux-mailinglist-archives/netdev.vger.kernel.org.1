Return-Path: <netdev+bounces-203553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1654BAF65C2
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE551C42B12
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97E52882CB;
	Wed,  2 Jul 2025 23:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mw39WXlb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD9A2571D7
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 23:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497340; cv=none; b=PULJpjPeivEtuzXvHLhIxTzGQbpvvS8uKX+BeY2Sp7OH0M7EUP/Si9I1pgSDKfKxiRrrQcibG7rbwfwrzXZMaEcAk6N4oX4OCOY1W6ravulCrLtBd7NLzWv58GMQB/mxDG7jBlphwG/J4NA0kp90wjOyvtjM0+9N40pcUidxDho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497340; c=relaxed/simple;
	bh=Abth/biW28FWoMiVoW0dS3YfqLdrd6/rvoFsposiTu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7Quni+f6zZJJqxs+Wnhr7Us7gDmf6fhm0AOeK5SnfIcDFFuCt0ijtM8mxg/YFXq3W/g6hnQhic5027Q3LhadW81gplNRRjO3bZagSZiCHZnnvOQXHtsmOYFzgcKzkFm1d8SsQ8pw/6fmdtrFTu9ccG5lC9LVWYqwmQAPb38XN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mw39WXlb; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-313eeb77b1fso3892131a91.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 16:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497339; x=1752102139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJFbN7WIBxa/Oi0MFVBur9Xjy1zWj6zkfVWihlv4ZVc=;
        b=mw39WXlbZPigt3RqAci2qupTgdzIAf+63u4hDqOZTfMhqVsvIKymR9TBn1+sH1uFMV
         LoqyufoPrD77x1vUDJAJXOoepofB6kAGhQher1xLDvu+wdCUrLE5HRXNYLXPI9fNMMH5
         kgt/MjckbGQm9/0tDhtdNxRptKdW0hjNiH0jMsiQFsJnWw0G+u3SG+GejCmog3TXVzgg
         x16AZVrGUMuONJS/meOsjI1a8iQldxIcmUfkroXYpB2JGiAoIIehvvczk4gZGuUnNyQj
         hY9+rJwcYehgPQIxWyd0OICMSWMMhA+9LTcSGUMxNvjGWbUU5w5MFMmVZaWBNnpSdP+D
         GtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497339; x=1752102139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJFbN7WIBxa/Oi0MFVBur9Xjy1zWj6zkfVWihlv4ZVc=;
        b=hKy2NVqpeqrNNfTNPB5DvFT5hkrd1I+zpIHESrA+nJCitWhtBGsFhYFWU2jdQcPPXp
         yysloJ0UZ42BDbj9zHlg5rP/LUhoMU/y7L/9BiEQUT6IULYSni0/mADCMDo25qhrtW0I
         usedCGtaKP5Jm7p8KtA31rDhab+tidOrKY+r0M3bQQED2KpOuCico7OMd6vGj31Q2I7I
         VJ/9SWttgyrZNbqbMhLjB46r9vpI8GqAzkE1lKNiYMEQXNEZq8bzha4y+3uUYNOHzhx5
         NFY2b+I6bRr44V90ztEymy6vNjeSBbw2OM3WofjuWwoTLZiD+DlYe+K/i2mug3vIsCp2
         7ABQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/egDxiC8IkftCIrrynUnt5mRwf7wMj/R92PMV1H3IG83XDlQXTpKnK14HFvVbiT7deKFKLZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyac6A0VhJd/ERwuOv+WlYFKm6/gRMjBM25k49sci6Y954YIawU
	Jc9EeBK7fslgWQpdysb9mIvvOrGIDmt4Km7nM9gfOauxhBPOriRwiW4=
X-Gm-Gg: ASbGncvkZtW+/JSbl4lmWGBWTYYmJhP8ceHA8C6FRI1q+IIaoSOWNHcY/dqOVLl6NM/
	Jh+jY6LJZAA2O11AbQRIWlqKnu6BVAHP/5lfFCDLOXwayzIVqs6QS/x5cEttW8PkMSWbaeI4vZL
	G0S2UHpE/CBu5KYwzfg0HXX0zbdySFZC4WIbyR7snu8LXYpn/d9JF8NZuIJyqIj37XMz6tN2wCm
	zAzQmLdFA5GU4e3CmucDVrWi0YF8eAwdSh9oF82IBe7Joj9JtyeIxj3u9UB/DcW3SA8Ak7VoIj+
	yJw5KLKxEB+1x8esFC6qJJCjtja85KbZtAyNjSo=
X-Google-Smtp-Source: AGHT+IFhHhlbCr4rbJ7mAfRTZ1dEEAGr0pTOfxVi1BjEj7qeIfuRv+N/7w2IuMfl+H/HiuuLxDE6cQ==
X-Received: by 2002:a17:90b:2f4c:b0:312:f0d0:bb0 with SMTP id 98e67ed59e1d1-31a90b39399mr8314483a91.12.1751497338468;
        Wed, 02 Jul 2025 16:02:18 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc70a17sm727071a91.26.2025.07.02.16.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:02:18 -0700 (PDT)
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
Subject: [PATCH v3 net-next 03/15] ipv6: mcast: Check inet6_dev->dead under idev->mc_lock in __ipv6_dev_mc_inc().
Date: Wed,  2 Jul 2025 16:01:20 -0700
Message-ID: <20250702230210.3115355-4-kuni1840@gmail.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/addrconf.c |  7 +++----
 net/ipv6/mcast.c    | 11 +++++------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 9c297974d3a6..dcc07767e51f 100644
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


