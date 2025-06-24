Return-Path: <netdev+bounces-200820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FC6AE70A6
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F6E1BC46D3
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AB72ED14F;
	Tue, 24 Jun 2025 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/koTjt5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C2629AAF0
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 20:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750796790; cv=none; b=rNMf+PaabOh8lVwuHrHo3V8nhMyOxBKKRySiDxYWQbjKeE7vkdpzBHFyCF0MVp4gxKCq51hJ3sdm/tPAHNuas+RAMgNNUEoLitPJtyt+631d7YBaRdAHBSN5mzhRufS4+6oV7mPk/cFcscupHrXpifwai5xm1Zu9DcZYV3zRtj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750796790; c=relaxed/simple;
	bh=Ce/YvzVoFUpXMRQbh6TXtrvzBDJLpSa0PnAV1CS73sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5iHqFPATgFHnSZuYsKQsPBL4l8Bnzo0vCbpasep3egGymX4xQUeMj50RJGshjN4Rq49V0TIOGd1dUlxcGC4DuH94n5x15sZ/AA1mhNRzOwvahML6qKIP3/aPaLA/peKNiYwjNZDY1xEiOsQ+4130nrHqmhKrnvVl8E5At8oDRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/koTjt5; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso7115115a12.2
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 13:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750796788; x=1751401588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Z0ZuZHbKlLXvvm5ejvFB9K/+8DI8M6Rw4T5aP/jNZA=;
        b=M/koTjt5Z9pmbT0N8k16UbRHxMeTRmLzS1v7A8ARc/tiR3QxaIc812VQ1oj2KN9ECz
         DqPr9X254xDzvhwLipAqc+G8UCxzcHCyuCFAYpW88/8KbbdIseslBgx2OacwGi9QCjKW
         GZY0WxeSgnDveBUjLN6K88aIG5jOF/DNmzNjOn4oW1ZnFet9IpXa8ZTQi5yOgkqvINkV
         enxXopTlm4xt0dH5RU/wN4UgQV2HNGhevvDqw1GUkRHZ8dqjPTK0boig3Mut9A5fVkDt
         H1fZjkfzGwI13zEbYW9t6GXr4HHu9ASih3DSCY0rmtOhsrvMKnbKc9usbtRxxNN1yT56
         Yzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750796788; x=1751401588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Z0ZuZHbKlLXvvm5ejvFB9K/+8DI8M6Rw4T5aP/jNZA=;
        b=WoKRUdZIHpU+iy5mksQmLG8xvADN8k5zsaYMpMsu0hCEr0/OaJA8x33pQlS74bdTZo
         76ShAuJ8spuXUUHg/Gk+dr/Ky5oj+E1201WR/3vNjZOLZdKGDJPH19Oo13hsPywiW+Il
         zYy5f5O4MMjb1RfrdsOJhS4SjenqmZ4kFFVtRHS0JJ/oSLAfwjegP2MfQMHEnGhNFXHg
         gxSEmU4EwQdzGbmbp+ruqX/XkqFhJ3lBZkVLlxW2XPueJUNOH5FkHBGBpmO4+HxFh8Gg
         Y6zI+nhp93KNJFQj1QwFX2te+wAkChGXd4kfL7crscEM+GirZgTDHClSc5tFKqyghbzP
         IUrw==
X-Forwarded-Encrypted: i=1; AJvYcCV7FPlQgSKGApv+S02to6Vk/zDfFluP9mhA+8DPREA3s5P0PxGg3MjOvHwxneIU0cxwAb6S/g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxioZDe7wHSCBVQVtPuwKiex8pYTARUK0ZcAGFAYZxRbot+ctf
	w6jQG7ofzAy0Fqfkw4msxd9L+AiaCKqpdtkDSc81MMSW1iNKVxRaQIA=
X-Gm-Gg: ASbGncukTR+x0+3x8iHEr83tzUhkqdpYsitNnCn17tMws0nMV2CNR8kAcU3h+EkW1At
	I4rpTB5H3tRh50Tj+he7QzlHuBk0bWiQuevAKiSPpj2fnoiYE53sS/FMrBKjfmV/7UX9vnzkRQs
	CHrVEBYj8JN+NZxHpVBFjyjTa3ofMOyJrZjmGb2KE04MFM4386ZPWLwMWKGSx4ONu92bp9Zvcl1
	t929hTrYdXVVFqVj65h+i21JE/qmVwEbDbn+IVHnlrO5l3THtO1pw3hznrOC1bHyyFvpKq2j8Nu
	9pthJH5UHHcb9wHtESJ196viAtiZeueLX1xM724=
X-Google-Smtp-Source: AGHT+IEVr5LluaqzLspuTVOHLdELhz9mFOgKxSRDGXVw0Z1tZ/ciZjT/4OYdbRM6iXS2ldzcAYDbeQ==
X-Received: by 2002:a05:6a20:12d5:b0:220:7342:b863 with SMTP id adf61e73a8af0-2207f1c381fmr583415637.3.1750796788092;
        Tue, 24 Jun 2025 13:26:28 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74a9697817esm2252994b3a.124.2025.06.24.13.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 13:26:27 -0700 (PDT)
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
Subject: [PATCH v2 net-next 03/15] ipv6: mcast: Check inet6_dev->dead under idev->mc_lock in __ipv6_dev_mc_inc().
Date: Tue, 24 Jun 2025 13:24:09 -0700
Message-ID: <20250624202616.526600-4-kuni1840@gmail.com>
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


