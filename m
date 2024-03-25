Return-Path: <netdev+bounces-81699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E30888AD98
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 19:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90FF61C3EF83
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648C25B697;
	Mon, 25 Mar 2024 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rGywCu7H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D5919470
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 17:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389094; cv=none; b=mNaStyMgr93uUFFxAQbPlGIXs/HiKRL3yxaH1nWmWVfWFzqyVJSFMubtzRdcLu1x97X6BozpaeR/RWhAI0DuIH8c6TOP6oe6XbVqcN5DZoP66kPah4JLmyHBSz56E5BfeIKvurmMawzOtgTYc3E9tFQsBgA3FhkwZxnd3juQePw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389094; c=relaxed/simple;
	bh=oFpHfxEjjRkNLqnsvIUKqne7g3O5V4xs8FadzevC+Fo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Je/XBz+LS5d61XT1wyVydwaxzU7m1tqopS3G3smyrJQx6Gr7zrPeUevc+qFYiGrogygxztkdSQDnZy04BSsJkykDywOXFri7KTe9AQyrFT0Dt8NRFHXC0slmqH5LCMaMlgGsVgSxyJgAMEUDsUmV00o01eCT76cPKSxFF4gdIo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rGywCu7H; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711389092; x=1742925092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y1wTvNSJ5qZH0QMGxScVxerKjnvhRgA790JYY+X/zvI=;
  b=rGywCu7HUNN/cMUkvz/G7NRQNzruZxXoZgFFBSiQZCTfaa9NmxoJ+7VU
   IWUd0vIc4QRNxXdI4XWnT5tyEtc52WMPn3sha9qZ22EIpSpuXg2V3XtrP
   2tACfXYktbBjuLk3BZHN2NzxmyQs3qf9DlVivcvVOMP58X/WjHkB/cld8
   0=;
X-IronPort-AV: E=Sophos;i="6.07,153,1708387200"; 
   d="scan'208";a="643440557"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 17:51:29 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:29039]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.164:2525] with esmtp (Farcaster)
 id 8f0dbf91-4c20-4388-a9c9-b0875f1d4056; Mon, 25 Mar 2024 17:51:28 +0000 (UTC)
X-Farcaster-Flow-ID: 8f0dbf91-4c20-4388-a9c9-b0875f1d4056
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 17:51:28 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Mon, 25 Mar 2024 17:51:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <wujianguo106@163.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH] tcp: Fix inet_bind2_bucket_match_addr_any() regression
Date: Mon, 25 Mar 2024 10:51:17 -0700
Message-ID: <20240325175117.45750-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <94d400d8-cb71-9f3a-32ad-a2492c1a5bd8@163.com>
References: <94d400d8-cb71-9f3a-32ad-a2492c1a5bd8@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jianguo Wu <wujianguo106@163.com>
Date: Fri, 22 Mar 2024 11:16:09 +0800
> Hi Kuniyuki,
> Thanks for your reply!
> 
> On 2024/3/21 12:55, Kuniyuki Iwashima wrote:
> > Hi,
> > 
> > Thanks for the patch.
> > 
> > From: Jianguo Wu <wujianguo106@163.com>
> > Date: Thu, 21 Mar 2024 11:02:36 +0800
> >> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> >>
> >> If we bind() a TCPv4 socket to 0.0.0.0:8090, then bind() a TCPv6(ipv6only) socket
> > 
> > Please wrap each line at <75 characters except for logs/output like below.
> > 
> OK.
> > 
> >> to :::8090, both without SO_REUSEPORT, then bind() 127.0.0.1:8090, it should fail
> > 
> > [::]:8090 is easier to read and the recommended way.
> > https://datatracker.ietf.org/doc/html/rfc5952#section-6
> > 
> > But please keep the netstat output as is.
> > 
> >> but now succeeds. like this:
> >>   tcp        0      0 127.0.0.1:8090          0.0.0.0:*               LISTEN
> >>   tcp        0      0 0.0.0.0:8090            0.0.0.0:*               LISTEN
> >>   tcp6       0      0 :::8090                 :::*                    LISTEN
> >>
> >> bind() 0.0.0.0:8090, :::8090 and ::1:8090 are all fail.
> > 
> > What do you mean by all fail ?
> > At least, [::1]:8090 would fail with the current code in this case.
> In my test, 127.0.0.1:8090  succeeds, 0.0.0.0:8090, [::]:8090 and [::1]:8090 are all fail
> 
> > 
> > 
> >> But if we bind() a TCPv6(ipv6only) socket to :::8090 first, then  bind() a TCPv4
> >> socket to 0.0.0.0:8090, then bind() 127.0.0.1:8090, 0.0.0.0:8090, :::8090 and ::1:8090 are all fail.
> >>
> >> When bind() 127.0.0.1:8090, inet_bind2_bucket_match_addr_any() will return true as tb->addr_type == IPV6_ADDR_ANY,
> > 
> > Let's use tb2 here for inet_bind2_bucket.. yes it's not consistent
> > in some functions like inet_bind2_bucket_match_addr_any() though.
> yes, inet_bind2_bucket_match_addr_any() use tb, so I use tb here.
> 
> > 
> > 
> >> and tb is refer to the TCPv6 socket(:::8090), then inet_bhash2_conflict() return false, That is, there is no conflict,
> > 
> > Also make it clear that the TCPv6 socket is ipv6only one.
> > 
> > 
> >> so bind() succeeds.
> >>
> >>   inet_bhash2_addr_any_conflict()
> >>   {
> >> 	inet_bind_bucket_for_each(tb2, &head2->chain)
> >> 		// tb2 is IPv6
> >> 		if (inet_bind2_bucket_match_addr_any(tb2, net, port, l3mdev, sk))
> >> 			break;
> >>
> >> 	// inet_bhash2_conflict() return false
> >> 	if (tb2 && inet_bhash2_conflict(sk, tb2, uid, relax, reuseport_cb_ok,
> >>                                 reuseport_ok)) {
> >> 		spin_unlock(&head2->lock);
> >> 		return true;
> >> 	}
> >>
> >>   }
> >>
> >> Fixes: 5a22bba13d01 ("tcp: Save address type in inet_bind2_bucket.")
> > 
> > This is not the commit that introduced the regression.
> I will remove this.
> > 
> > Also, you need Signed-off-by tag here.
> OK.
> > 
> > 
> >> ---
> >>  net/ipv4/inet_hashtables.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> >> index 7498af320164..3eeaca8a113f 100644
> >> --- a/net/ipv4/inet_hashtables.c
> >> +++ b/net/ipv4/inet_hashtables.c
> >> @@ -830,8 +830,8 @@ bool inet_bind2_bucket_match_addr_any(const struct inet_bind2_bucket *tb, const
> >>  		return false;
> >>
> >>  #if IS_ENABLED(CONFIG_IPV6)
> >> -	if (tb->addr_type == IPV6_ADDR_ANY)
> >> -		return true;
> >> +	if (sk->sk_family == AF_INET6)
> >> +		return tb->addr_type == IPV6_ADDR_ANY;
> > 
> > This fix is not correct and will break v4-mapped-v6 address cases.
> > You can run bind_wildcard under the selftest directory.
> >> Probably we need v6_only bit in tb2 and should add some test cases
> > in the selftest.
> How about this?
> I add a new field ipv6_only to struct inet_bind2_bucket{}
> 
> diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
> index 7f1b38458743..fb7c250a663b 100644
> --- a/include/net/inet_hashtables.h
> +++ b/include/net/inet_hashtables.h
> @@ -96,6 +96,7 @@ struct inet_bind2_bucket {
>  	int			l3mdev;
>  	unsigned short		port;
>  #if IS_ENABLED(CONFIG_IPV6)
> +	bool			ipv6_only;
>  	unsigned short		addr_type;
>  	struct in6_addr		v6_rcv_saddr;
>  #define rcv_saddr		v6_rcv_saddr.s6_addr32[3]
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index cf88eca5f1b4..5fc749f8f2b1 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -110,6 +110,7 @@ static void inet_bind2_bucket_init(struct inet_bind2_bucket *tb2,
>  	tb2->port = tb->port;
>  #if IS_ENABLED(CONFIG_IPV6)
>  	BUILD_BUG_ON(USHRT_MAX < (IPV6_ADDR_ANY | IPV6_ADDR_MAPPED));
> +	tb2->ipv6_only = ipv6_only_sock(sk);
>  	if (sk->sk_family == AF_INET6) {
>  		tb2->addr_type = ipv6_addr_type(&sk->sk_v6_rcv_saddr);
>  		tb2->v6_rcv_saddr = sk->sk_v6_rcv_saddr;
> @@ -831,7 +832,8 @@ bool inet_bind2_bucket_match_addr_any(const struct inet_bind2_bucket *tb, const
> 
>  #if IS_ENABLED(CONFIG_IPV6)
>  	if (tb->addr_type == IPV6_ADDR_ANY)
> -		return true;
> +		if (sk->sk_family == AF_INET6 || !tb->ipv6_only)
> +			return true;
> 
>  	if (tb->addr_type != IPV6_ADDR_MAPPED)
>  		return false;
> 

I found a corner case that does not work with this change.
The 3rd bind() should fail but succeeds with the v6only flag approach.

---8<---
from socket import *

s1 = socket(AF_INET6)
s1.setsockopt(41, IPV6_V6ONLY, 1)
s1.setsockopt(SOL_SOCKET, SO_REUSEADDR, 1)
s1.bind(('::', 8000))

s2 = socket(AF_INET6)
s2.setsockopt(SOL_SOCKET, SO_REUSEADDR, 1)
s2.bind(('::', 8000))

s3 = socket(AF_INET)
s3.bind(('127.0.0.1', 8000))
---8<---


To cover this case, the only solution is to iterate over the buckets
in the same hash.  Also, this change can be backported to 6.1.

---8<---
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 612aa1d2eff7..63e8f2df0681 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -288,6 +288,7 @@ static bool inet_bhash2_addr_any_conflict(const struct sock *sk, int port, int l
 	struct sock_reuseport *reuseport_cb;
 	struct inet_bind_hashbucket *head2;
 	struct inet_bind2_bucket *tb2;
+	bool conflict = false;
 	bool reuseport_cb_ok;
 
 	rcu_read_lock();
@@ -300,18 +301,20 @@ static bool inet_bhash2_addr_any_conflict(const struct sock *sk, int port, int l
 
 	spin_lock(&head2->lock);
 
-	inet_bind_bucket_for_each(tb2, &head2->chain)
-		if (inet_bind2_bucket_match_addr_any(tb2, net, port, l3mdev, sk))
-			break;
+	inet_bind_bucket_for_each(tb2, &head2->chain) {
+		if (!inet_bind2_bucket_match_addr_any(tb2, net, port, l3mdev, sk))
+			continue;
 
-	if (tb2 && inet_bhash2_conflict(sk, tb2, uid, relax, reuseport_cb_ok,
-					reuseport_ok)) {
-		spin_unlock(&head2->lock);
-		return true;
+		if (!inet_bhash2_conflict(sk, tb2, uid, relax, reuseport_cb_ok,	reuseport_ok))
+			continue;
+
+		conflict = true;
+		break;
 	}
 
 	spin_unlock(&head2->lock);
-	return false;
+
+	return conflict;
 }
 
 /*
---8<---


Also, I found another regression that my recent patch introduced.
The second bind() should succeed but now fails.

---8<---
from socket import *

s1 = socket(AF_INET6)
s1.setsockopt(41, IPV6_V6ONLY, 1)
s1.bind(('::', 8000))

s2 = socket(AF_INET6)
s2.bind(('::ffff:127.0.0.1', 8000))
---8<---

and we need this change.

---8<---
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 7d8090f109ef..612aa1d2eff7 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -203,7 +203,8 @@ static bool __inet_bhash2_conflict(const struct sock *sk, struct sock *sk2,
 				   kuid_t sk_uid, bool relax,
 				   bool reuseport_cb_ok, bool reuseport_ok)
 {
-	if (sk->sk_family == AF_INET && ipv6_only_sock(sk2))
+	if (ipv6_only_sock(sk2) &&
+	    (sk->sk_family == AF_INET || ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr)))
 		return false;
 
 	return inet_bind_conflict(sk, sk2, sk_uid, relax,
---8<---


I'll post a series including necessary tests.

Thanks!

