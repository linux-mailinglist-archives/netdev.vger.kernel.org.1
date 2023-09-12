Return-Path: <netdev+bounces-33049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B07C79C8FA
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 09:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2D228168E
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 07:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C52B17731;
	Tue, 12 Sep 2023 07:59:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA1B1640D
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 07:59:23 +0000 (UTC)
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351F149C6
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 00:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1694505563; x=1726041563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vhazh1SrZA6FB1IEMzyGzfsIBckbQNb/H4sfy6yVw5E=;
  b=qo+TQUOXu9Akp65v0itGmSR51KwZc2dpMHjEBGx6wVyxTvgvunKIvNrE
   b/TSUx8atvI74sJb+3Uhue7QLs7RuLv/mPEvEhU0GsiDTM4t3ekS6NZh7
   pkafw0fqOnnx9c68eeJvPGehvWdAF+0WOf8as+KvBe1/F7yu5lfi0b3Ar
   M=;
X-IronPort-AV: E=Sophos;i="6.02,245,1688428800"; 
   d="scan'208";a="153883263"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-94edd59b.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 07:59:20 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2c-m6i4x-94edd59b.us-west-2.amazon.com (Postfix) with ESMTPS id F2B0A40AEB;
	Tue, 12 Sep 2023 07:59:18 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 12 Sep 2023 07:59:18 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 12 Sep 2023 07:59:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <avagin@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<joannelkoong@gmail.com>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net 3/6] tcp: Fix bind() regression for v4-mapped-v6 non-wildcard address.
Date: Tue, 12 Sep 2023 00:59:07 -0700
Message-ID: <20230912075907.91325-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ZQAShrVUokZR/WGs@google.com>
References: <ZQAShrVUokZR/WGs@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.14]
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Andrei Vagin <avagin@gmail.com>
Date: Tue, 12 Sep 2023 00:25:58 -0700
> On Mon, Sep 11, 2023 at 11:36:57AM -0700, Kuniyuki Iwashima wrote:
> > Since bhash2 was introduced, the example below does not work as expected.
> > These two bind() should conflict, but the 2nd bind() now succeeds.
> > 
> >   from socket import *
> > 
> >   s1 = socket(AF_INET6, SOCK_STREAM)
> >   s1.bind(('::ffff:127.0.0.1', 0))
> > 
> >   s2 = socket(AF_INET, SOCK_STREAM)
> >   s2.bind(('127.0.0.1', s1.getsockname()[1]))
> > 
> > During the 2nd bind() in inet_csk_get_port(), inet_bind2_bucket_find()
> > fails to find the 1st socket's tb2, so inet_bind2_bucket_create() allocates
> > a new tb2 for the 2nd socket.  Then, we call inet_csk_bind_conflict() that
> > checks conflicts in the new tb2 by inet_bhash2_conflict().  However, the
> > new tb2 does not include the 1st socket, thus the bind() finally succeeds.
> > 
> > In this case, inet_bind2_bucket_match() must check if AF_INET6 tb2 has
> > the conflicting v4-mapped-v6 address so that inet_bind2_bucket_find()
> > returns the 1st socket's tb2.
> > 
> > Note that if we bind two sockets to 127.0.0.1 and then ::FFFF:127.0.0.1,
> > the 2nd bind() fails properly for the same reason mentinoed in the previous
> > commit.
> > 
> > Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and address")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/ipv4/inet_hashtables.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> > index a58b04052ca6..c32f5e28758b 100644
> > --- a/net/ipv4/inet_hashtables.c
> > +++ b/net/ipv4/inet_hashtables.c
> > @@ -820,8 +820,13 @@ static bool inet_bind2_bucket_match(const struct inet_bind2_bucket *tb,
> 
> Should we fix inet_bind2_bucket_addr_match too?

No, there's no real bug.

I have this patch in my local branch and will post it against
net-next after this series is merged.

---8<---
commit 06333d4b0d053e4c0d40090b29e5a8546b42bb50
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Sun Sep 10 19:01:23 2023 +0000

    tcp: Remove redundant sk_family check in inet_bind2_bucket_addr_match().

    Commit 5456262d2baa ("net: Fix incorrect address comparison when
    searching for a bind2 bucket") added the test for the KMSAN report.

    However, the condition never be true as tb2 is listener's
    inet_csk(sk)->icsk_bind2_hash and its sk_family always matches with
    child->sk_family.

    Link: https://lore.kernel.org/netdev/CAG_fn=Ud3zSW7AZWXc+asfMhZVL5ETnvuY44Pmyv4NPv-ijN-A@mail.gmail.com/
    Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index c32f5e28758b..dfb1c61c0c2b 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -149,9 +149,6 @@ static bool inet_bind2_bucket_addr_match(const struct inet_bind2_bucket *tb2,
 					 const struct sock *sk)
 {
 #if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family != tb2->family)
-		return false;
-
 	if (sk->sk_family == AF_INET6)
 		return ipv6_addr_equal(&tb2->v6_rcv_saddr,
 				       &sk->sk_v6_rcv_saddr);
---8<---


> 
> >  		return false;
> >  
> >  #if IS_ENABLED(CONFIG_IPV6)
> > -	if (sk->sk_family != tb->family)
> > +	if (sk->sk_family != tb->family) {
> > +		if (sk->sk_family == AF_INET)
> > +			return ipv6_addr_v4mapped(&tb->v6_rcv_saddr) &&
> > +				tb->v6_rcv_saddr.s6_addr32[3] == sk->sk_rcv_saddr;
> 
> I was wondering why we don't check a case when sk is AF_INET6 and tb is
> AF_INET. I tried to run the next test:
> 
> import socket
> sk4 = socket.socket(socket.AF_INET, socket.SOCK_STREAM, 0)
> sk6 = socket.socket(socket.AF_INET6, socket.SOCK_STREAM, 0)
> sk4.bind(("127.0.0.1", 32773))
> sk6.bind(("::ffff:127.0.0.1", 32773))
> 
> The second bind returned EADDRINUSE. It works as expected only because
> inet_use_bhash2_on_bind returns false for all v4mapped addresses. This
> doesn't look right, and I am not sure it was intentional. I think it can
> to be changed this way:
> 
> @@ -158,7 +158,7 @@ static bool inet_use_bhash2_on_bind(const struct sock *sk)
>                 int addr_type = ipv6_addr_type(&sk->sk_v6_rcv_saddr);
> 
>                 return addr_type != IPV6_ADDR_ANY &&
> -                       addr_type != IPV6_ADDR_MAPPED;
> +                       !ipv6_addr_v4mapped_any(&sk->sk_v6_rcv_saddr);
>         }
>  #endif
>         return sk->sk_rcv_saddr != htonl(INADDR_ANY);
> 
> As for this patch, I think it may be a good idea if bind2 buckets for
> v4-mapped addresses are created with the AF_INET family and matching
> ipv4 addresses.

Let's say we create tb2 with AF_INET for v4-mapped address.  If we bind
::ffff:127.0.0.1 and 127.0.0.1, in the second bind(), both tb->family and
sk->sk_family is AF_INET.  So, we can remove this AF_INET test.

  if (sk->sk_family != tb->family) {
      if (sk->sk_family == AF_INET)

But what about 127.0.0.1 and then ::ffff:127.0.0.1 ?  There tb->family is
AF_INET and sk->sk_family is AF_INET6.  We need to add another AF_INET6
test in the same place.

So, finally we need to check the special case in either way.

Also, as you may notice, we need to change inet_bind2_bucket_addr_match()
as well.  As mentioned in my patch above, sk->sk_family always match
tb2->family there, but v4-mapped AF_INET tb2 breaks the rule.

Using bhash2 for v4-mapped-v6 address could be done but churns code a lot.
So, I think we should not include such changes as fix at least.


> 
> > +
> >  		return false;
> > +	}
> >  
> >  	if (sk->sk_family == AF_INET6)
> >  		return ipv6_addr_equal(&tb->v6_rcv_saddr, &sk->sk_v6_rcv_saddr);

