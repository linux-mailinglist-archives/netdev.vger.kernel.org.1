Return-Path: <netdev+bounces-20077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C41F75D8C1
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 03:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBFED1C21823
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 01:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD816138;
	Sat, 22 Jul 2023 01:40:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946EC1C3B
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 01:40:09 +0000 (UTC)
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5771986
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 18:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689990007; x=1721526007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wQS9Lz2v95QhJjfon4Ulrk2imHaH4eIRHko2XM274G4=;
  b=T6rMxk8jaxlw6o33dO/9Wy2K0K/Hzhis+FeoJPsfh430bZnqCvlA9wFE
   Kqk6WBNrepdIyaRoHEXYfERRdTCdu89VrDf/Apy/9SRwbp+s/BOO8uLCc
   f0vqtpdAshdZAYLE7HUCfjiGhSiFgwGOFGFR9LFVBwH0QgZ9dhyv6B7ux
   0=;
X-IronPort-AV: E=Sophos;i="6.01,223,1684800000"; 
   d="scan'208";a="17957937"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 01:40:05 +0000
Received: from EX19MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com (Postfix) with ESMTPS id 06CD0A0843;
	Sat, 22 Jul 2023 01:40:01 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 22 Jul 2023 01:39:59 +0000
Received: from 88665a182662.ant.amazon.com (10.135.225.135) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Sat, 22 Jul 2023 01:39:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <aksecurity@gmail.com>
CC: <benh@amazon.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<samjonas@amazon.com>, <trawets@amazon.com>
Subject: Re: [PATCH v2 net] tcp: Reduce chance of collisions in inet6_hashfn().
Date: Fri, 21 Jul 2023 18:39:48 -0700
Message-ID: <20230722013948.42820-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANEQ_+KSPSy3cQmVf_WdkdHMaNdCh-Qyo_7M8p+qFXXqbeZWgw@mail.gmail.com>
References: <CANEQ_+KSPSy3cQmVf_WdkdHMaNdCh-Qyo_7M8p+qFXXqbeZWgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.135.225.135]
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Amit Klein <aksecurity@gmail.com>
Date: Sat, 22 Jul 2023 03:07:49 +0300
> Resending because some recipients require plaintext email. Sorry.
> Original message:
> 
> This is certainly better than the original code.

Thanks for reviewing!


> 
> Two remarks:
> 
> 1. In general, using SipHash is more secure, even if only for its
> longer key (128 bits, cf. jhash's 32 bits), which renders simple
> enumeration attacks infeasible. I understand that in a different
> context, switching from jhash to siphash incurred some overhead, but
> maybe here it won't.

I see.  Stewart tested hsiphash and observed more overhead as
noted in the changelog, but let me give another shot to SipHash
and HSiphash.

I'll report back here next week.


> 
> 2. Taking a more holistic approach to __ipv6_addr_jhash(), I surveyed
> where and how it's used. In most cases, it is used for hashing
> together the IPv6 local address, foreign address and optionally some
> more data (e.g. layer 4 protocol number, layer 4 ports).
> Security-wise, it makes more sense to hash all data together once, and
> not piecewise as it's done today (i.e. today it's
> jhash(....,jhash(faddr),...), which cases the faddr into 32 bits,
> whereas the recommended way is to hash all items in their entirety,
> i.e. jhash(...,faddr,...)).

Agree.


> This requires scrutinizing all 6
> invocations of __ipv6_addr_jhash() one by one and modifying the
> calling code accordingly.

At a glance, only rds_conn_bucket() seems a little bit tricky
as it uses v4 hash function later.

But I'll take a deeper look.

Thanks!


> 
> Thanks,
> -Amit
> 
> On Sat, Jul 22, 2023 at 1:24 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > From: Stewart Smith <trawets@amazon.com>
> >
> > For both IPv4 and IPv6 incoming TCP connections are tracked in a hash
> > table with a hash over the source & destination addresses and ports.
> > However, the IPv6 hash is insufficient and can lead to a high rate of
> > collisions.
> >
> > The IPv6 hash used an XOR to fit everything into the 96 bits for the
> > fast jenkins hash, meaning it is possible for an external entity to
> > ensure the hash collides, thus falling back to a linear search in the
> > bucket, which is slow.
> >
> > We take the approach of hash the full length of IPv6 address in
> > __ipv6_addr_jhash() so that all users can benefit from a more secure
> > version.
> >
> > While this may look like it adds overhead, the reality of modern CPUs
> > means that this is unmeasurable in real world scenarios.
> >
> > In simulating with llvm-mca, the increase in cycles for the hashing
> > code was ~16 cycles on Skylake (from a base of ~155), and an extra ~9
> > on Nehalem (base of ~173).
> >
> > In commit dd6d2910c5e0 ("netfilter: conntrack: switch to siphash")
> > netfilter switched from a jenkins hash to a siphash, but even the faster
> > hsiphash is a more significant overhead (~20-30%) in some preliminary
> > testing.  So, in this patch, we keep to the more conservative approach to
> > ensure we don't add much overhead per SYN.
> >
> > In testing, this results in a consistently even spread across the
> > connection buckets.  In both testing and real-world scenarios, we have
> > not found any measurable performance impact.
> >
> > Fixes: 08dcdbf6a7b9 ("ipv6: use a stronger hash for tcp")
> > Signed-off-by: Stewart Smith <trawets@amazon.com>
> > Signed-off-by: Samuel Mendoza-Jonas <samjonas@amazon.com>
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> > v2:
> >   * Hash all IPv6 bytes once in __ipv6_addr_jhash() instead of reusing
> >     some bytes twice.
> >
> > v1: https://lore.kernel.org/netdev/20230629015844.800280-1-samjonas@amazon.com/
> > ---
> >  include/net/ipv6.h | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> > index 7332296eca44..2acc4c808d45 100644
> > --- a/include/net/ipv6.h
> > +++ b/include/net/ipv6.h
> > @@ -752,12 +752,8 @@ static inline u32 ipv6_addr_hash(const struct in6_addr *a)
> >  /* more secured version of ipv6_addr_hash() */
> >  static inline u32 __ipv6_addr_jhash(const struct in6_addr *a, const u32 initval)
> >  {
> > -       u32 v = (__force u32)a->s6_addr32[0] ^ (__force u32)a->s6_addr32[1];
> > -
> > -       return jhash_3words(v,
> > -                           (__force u32)a->s6_addr32[2],
> > -                           (__force u32)a->s6_addr32[3],
> > -                           initval);
> > +       return jhash2((__force const u32 *)a->s6_addr32,
> > +                     ARRAY_SIZE(a->s6_addr32), initval);
> >  }
> >
> >  static inline bool ipv6_addr_loopback(const struct in6_addr *a)
> > --
> > 2.30.2


