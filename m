Return-Path: <netdev+bounces-141072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C529B95DD
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 17:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47738B21632
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 16:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AF71A3BD5;
	Fri,  1 Nov 2024 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CvUl1lQk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9714E155324;
	Fri,  1 Nov 2024 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479737; cv=none; b=C9QJA1gPj5aq0/24ry113n8/0w87fQCHADgGGNwLflHbqq02suQYj9D/fRs+D3rtbNkvXo9QvoWQyXf9o4zyoxG01BCZIgKPIJVuNjOnsXNo7IqyGyMHYtZpaXfaE5RekP4hVK8GkxcUwztOQZF+wJcEI8mTbfTbQ04GTdiny0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479737; c=relaxed/simple;
	bh=G8AV6hUbYa5ufbufEfytoznfbGDOKodSueBqedNnNwk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ss4f3zL9CLx57L+nuf2YEDUI8y6MJZ4x+N1QUzLMZLawkU59Lfh9UKIgVgLj68eSgWTo87MJrxk2KPJGER/rtKvpB8UFaS7aqEGatGhBa4LGKAlcyq938BiK4ur0jpklOygm6FY5ufVKAfG1GprtSVYDwhd1x0Et9TMxuaaoD4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CvUl1lQk; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730479736; x=1762015736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mqeYyGNdYJSCQ7x0jqlRY8aiViXaRNHtVV7905ZpVjU=;
  b=CvUl1lQkzmypSkbD9v3v9EVDoKezYoL7nKSMZmUvE6YzS22jrUhe9Faq
   OdssSSaOm1I3V9lJBfigy3XjQl6HLtwtCXZspS1auaDMU5d/rAEIE3sqm
   en9H3dN4mGdTDZU0NQddUQ6KX8f9VnPE7Nf5tEMTykn7/ly3MawwxJLm/
   0=;
X-IronPort-AV: E=Sophos;i="6.11,250,1725321600"; 
   d="scan'208";a="38237743"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 16:48:52 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:36608]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.125:2525] with esmtp (Farcaster)
 id 68162ca2-5306-4bf9-8435-391cac41bce8; Fri, 1 Nov 2024 16:48:50 +0000 (UTC)
X-Farcaster-Flow-ID: 68162ca2-5306-4bf9-8435-391cac41bce8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 1 Nov 2024 16:48:48 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 1 Nov 2024 16:48:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <lulie@linux.alibaba.com>
CC: <antony.antony@secunet.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<dust.li@linux.alibaba.com>, <edumazet@google.com>,
	<fred.cc@alibaba-inc.com>, <horms@kernel.org>, <jakub@cloudflare.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <steffen.klassert@secunet.com>,
	<willemdebruijn.kernel@gmail.com>, <yubing.qiuyubing@alibaba-inc.com>,
	<kuniyu@amazon.com>
Subject: Re: [PATCH v6 net-next 4/4] ipv6/udp: Add 4-tuple hash for connected socket
Date: Fri, 1 Nov 2024 09:48:40 -0700
Message-ID: <20241101164840.73324-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <33862f10-726d-49d3-8f86-ccef1f6792e7@linux.alibaba.com>
References: <33862f10-726d-49d3-8f86-ccef1f6792e7@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Philo Lu <lulie@linux.alibaba.com>
Date: Fri, 1 Nov 2024 19:40:19 +0800
> On 2024/10/31 20:45, Philo Lu wrote:
> > Implement ipv6 udp hash4 like that in ipv4. The major difference is that
> > the hash value should be calculated with udp6_ehashfn(). Besides,
> > ipv4-mapped ipv6 address is handled before hash() and rehash().
> > 
> > Core procedures of hash/unhash/rehash are same as ipv4, and udpv4 and
> > udpv6 share the same udptable, so some functions in ipv4 hash4 can also
> > be shared.
> > 
> > Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> > Signed-off-by: Cambda Zhu <cambda@linux.alibaba.com>
> > Signed-off-by: Fred Chen <fred.cc@alibaba-inc.com>
> > Signed-off-by: Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
> > ---
> >   net/ipv6/udp.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++--
> >   1 file changed, 94 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> > index 1ea99d704e31..64f13f258fca 100644
> > --- a/net/ipv6/udp.c
> > +++ b/net/ipv6/udp.c
> > @@ -110,8 +110,17 @@ void udp_v6_rehash(struct sock *sk)
> >   	u16 new_hash = ipv6_portaddr_hash(sock_net(sk),
> >   					  &sk->sk_v6_rcv_saddr,
> >   					  inet_sk(sk)->inet_num);
> > +	u16 new_hash4;
> >   
> > -	udp_lib_rehash(sk, new_hash, 0); /* 4-tuple hash not implemented */
> > +	if (ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr)) {
> > +		new_hash4 = udp_ehashfn(sock_net(sk), sk->sk_rcv_saddr, sk->sk_num,
> > +					sk->sk_daddr, sk->sk_dport);
> 
> Just found udp_ehashfn() used here results in an build error of 
> undefined function.
> 
> I think the `ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr)` branch can be 
> moved into udp_lib_rehash() to fix the issue. So in the worst case, we 
> need to calculate the newhash4 twice in ipv6 hash4 rehash, one in 
> udp_v6_rehash() and the other in udp_lib_rehash().

You can simply export udp_ehashfn().

