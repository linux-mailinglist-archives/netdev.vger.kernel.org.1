Return-Path: <netdev+bounces-39249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493247BE779
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 19:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D210F2818BD
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E0C347D0;
	Mon,  9 Oct 2023 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UdBaLU12"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CA518E28
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 17:12:47 +0000 (UTC)
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8750094
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 10:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696871565; x=1728407565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uwpDOZOpfYsuww61p0m2L1qVRCOH3Jii+8Qxzvp20ZE=;
  b=UdBaLU120t575kQC4mRMtuHodw2/E2zBSpYFkN9vN+con32pmvVT/WPo
   P7+65mBWYiCe2N2t4YTLwoBhZV5L7GlBhvYTJTqyEJHpCvtlp+8gNxwg3
   yK2EOHMQHL3UFRSRsZlzkXckzc3yYqDMzLfjupCl7upukJx1EKH2PCeQh
   Y=;
X-IronPort-AV: E=Sophos;i="6.03,210,1694736000"; 
   d="scan'208";a="360903781"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 17:12:42 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id D7261806F1;
	Mon,  9 Oct 2023 17:12:40 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 9 Oct 2023 17:12:39 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 9 Oct 2023 17:12:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <keescook@chromium.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <slyich@gmail.com>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v1 net] af_packet: Fix fortified memcpy() without flex array.
Date: Mon, 9 Oct 2023 10:12:28 -0700
Message-ID: <20231009171228.89827-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <202310090852.E9A6558@keescook>
References: <202310090852.E9A6558@keescook>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.12]
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kees Cook <keescook@chromium.org>
Date: Mon, 9 Oct 2023 09:01:34 -0700
> On Mon, Oct 09, 2023 at 08:31:52AM -0700, Kuniyuki Iwashima wrote:
> > Sergei Trofimovich reported a regression [0] caused by commit a0ade8404c3b
> > ("af_packet: Fix warning of fortified memcpy() in packet_getname().").
> > 
> > It introduced a flex array sll_addr_flex in struct sockaddr_ll as a
> > union-ed member with sll_addr to work around the fortified memcpy() check.
> > 
> > However, a userspace program uses a struct that has struct sockaddr_ll in
> > the middle, where a flex array is illegal to exist.
> > 
> >   include/linux/if_packet.h:24:17: error: flexible array member 'sockaddr_ll::<unnamed union>::<unnamed struct>::sll_addr_flex' not at end of 'struct packet_info_t'
> >      24 |                 __DECLARE_FLEX_ARRAY(unsigned char, sll_addr_flex);
> >         |                 ^~~~~~~~~~~~~~~~~~~~
> > To fix the regression, let's go back to the first attempt [1] telling
> > memcpy() the actual size of the array.
> > 
> > Reported-by: Sergei Trofimovich <slyich@gmail.com>
> > Closes: https://github.com/NixOS/nixpkgs/pull/252587#issuecomment-1741733002 [0]
> 
> Eww. That's a buggy definition -- it could get overflowed.

Only if they pass sizeof(struct sockaddr_storage) to getsockname().


> 
> But okay, we don't break userspace.
> 
> > Link: https://lore.kernel.org/netdev/20230720004410.87588-3-kuniyu@amazon.com/ [1]
> > Fixes: a0ade8404c3b ("af_packet: Fix warning of fortified memcpy() in packet_getname().")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  include/uapi/linux/if_packet.h | 6 +-----
> >  net/packet/af_packet.c         | 7 ++++++-
> >  2 files changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/uapi/linux/if_packet.h b/include/uapi/linux/if_packet.h
> > index 4d0ad22f83b5..9efc42382fdb 100644
> > --- a/include/uapi/linux/if_packet.h
> > +++ b/include/uapi/linux/if_packet.h
> > @@ -18,11 +18,7 @@ struct sockaddr_ll {
> >  	unsigned short	sll_hatype;
> >  	unsigned char	sll_pkttype;
> >  	unsigned char	sll_halen;
> > -	union {
> > -		unsigned char	sll_addr[8];
> > -		/* Actual length is in sll_halen. */
> > -		__DECLARE_FLEX_ARRAY(unsigned char, sll_addr_flex);
> > -	};
> > +	unsigned char	sll_addr[8];
> >  };
> 
> Yup, we need to do at least this.
> 
> >  
> >  /* Packet types */
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index 8f97648d652f..a84e00b5904b 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -3607,7 +3607,12 @@ static int packet_getname(struct socket *sock, struct sockaddr *uaddr,
> >  	if (dev) {
> >  		sll->sll_hatype = dev->type;
> >  		sll->sll_halen = dev->addr_len;
> > -		memcpy(sll->sll_addr_flex, dev->dev_addr, dev->addr_len);
> > +
> > +		/* Let __fortify_memcpy_chk() know the actual buffer size. */
> > +		memcpy(((struct sockaddr_storage *)sll)->__data +
> > +		       offsetof(struct sockaddr_ll, sll_addr) -
> > +		       offsetofend(struct sockaddr_ll, sll_family),
> > +		       dev->dev_addr, dev->addr_len);
> >  	} else {
> >  		sll->sll_hatype = 0;	/* Bad: we have no ARPHRD_UNSPEC */
> >  		sll->sll_halen = 0;
> 
> I still think this is a mistake. We're papering over so many lies to the
> compiler. :P If "uaddr" is actually "struct sockaddr_storage", then we
> should update the callers...

We could update all callers to pass sockaddr_storage but it seems too much
for net.git.. :/  I think the conversion should be done later for net-next.

  $ grep -rn -E "\.getname.*?=" | cut -f 2 -d"=" | sort | uniq | wc -l
  40


> and if "struct sockaddr_ll" doesn't have a
> fixed size trailing array, we should make a new struct that is telling
> the truth. ;)
> 
> Perhaps add this to the UAPI:
> 
> +struct sockaddr_ll_flex {
> +       unsigned short  sll_family;
> +       __be16          sll_protocol;
> +       int             sll_ifindex;
> +       unsigned short  sll_hatype;
> +       unsigned char   sll_pkttype;
> +       unsigned char   sll_halen;
> +       unsigned char   sll_addr[] __counted_by(sll_halen);
> +};
> 
> And update the memcpy():
> 
> -       DECLARE_SOCKADDR(struct sockaddr_ll *, sll, uaddr);
> +       struct sockaddr_ll_flex * sll = (struct sockaddr_ll_flex *)uaddr;
> 
> ?
> 
> -- 
> Kees Cook

