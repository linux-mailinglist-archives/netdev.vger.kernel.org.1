Return-Path: <netdev+bounces-133217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C01995554
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 19:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27BE4B21C59
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 17:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64901E0DDB;
	Tue,  8 Oct 2024 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uwLthmQw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0422F1E0DD0
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407368; cv=none; b=Xr4xG24UDV51pvchfP53JBB5TdWYGLDBeYJN/ZdeJRxgB8v4LE2tVYxHlF+y6w88Q8uLjNVdlbjvT1G56NuUPrl69tj1Lkha1FVF+Vx/mUKvIGM89zDpJiVvDXku6LE3g/SBqLLLXADeu1G0bQAczLVzh2WZlbdIvzF0Pd4mFiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407368; c=relaxed/simple;
	bh=Z8xI+ZcafAWVcAese76pHRNu9/MY3/Ah8jSu0fpemjQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fswK9VMCk6xwvVS6mlADRer7Tai45NsqnSHmyNyP+FS8LUJFGAUAsnRDou7qaFMYWmNnmHdgZ6p/XUDjhrJIlVY0Yk5ydC/SxYyLREi84YNi5kKeWZcN5lUD2ZIxuqjcs68U0tbd3bMIEa79Jg+7c94N7jXKTG8TswAjyDDW2VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=uwLthmQw; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728407367; x=1759943367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FOQO6eyfHfX7KXtr2U9N6PjiGqNcYtkrixtUO6PyVRA=;
  b=uwLthmQwYwk3yzHX+dg/Uq6NJjoBw/COw6lwuaspfzgXDeXlnjU39zbg
   sR0PFR+yd+SkYmggaz9sQ6jTq09sjeM35dJW9zauAdLzWZwWSYm8tlGCJ
   TeJDyY+jkoSqelUIcU8xEAR0phqcTkm45DLjSTKgFBlx3A9Hl+Iw+khrQ
   g=;
X-IronPort-AV: E=Sophos;i="6.11,187,1725321600"; 
   d="scan'208";a="439225158"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 17:09:22 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:43855]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.26:2525] with esmtp (Farcaster)
 id ed7bf527-d62c-4595-ab7a-50d51d4db8c8; Tue, 8 Oct 2024 17:09:21 +0000 (UTC)
X-Farcaster-Flow-ID: ed7bf527-d62c-4595-ab7a-50d51d4db8c8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 8 Oct 2024 17:09:16 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 8 Oct 2024 17:09:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 4/4] ipv4: Retire global IPv4 hash table inet_addr_lst.
Date: Tue, 8 Oct 2024 10:09:06 -0700
Message-ID: <20241008170906.98082-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iJKu_ZnkP0WjDXmFQpBKK=LRPvsoPiHiv8hkmoq123K0w@mail.gmail.com>
References: <CANn89iJKu_ZnkP0WjDXmFQpBKK=LRPvsoPiHiv8hkmoq123K0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D032UWA003.ant.amazon.com (10.13.139.37) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Oct 2024 13:21:08 +0200
> On Tue, Oct 8, 2024 at 1:10 PM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > On 10/4/24 21:59, Kuniyuki Iwashima wrote:
> > > No one uses inet_addr_lst anymore, so let's remove it.
> > >
> > > While at it, we can remove net_hash_mix() from the hash calculation.
> >
> > Is that really safe? it will make hash collision predictable in a
> > deterministic way.
> >
> > FTR, IPv6 still uses the net seed.
> 
> I was planning to switch ipv6 to a safer hash, because the
> ipv6_addr_hash() is also predictable.
> It is easy for an attacker to push 10000 ipv6 addresses on the same slot.
> 
> We have netns isolation for sure, but being able to use a big amount
> of cpu cycles in the kernel is an issue.

I'll keep inet_addr_hash() as is in patch 4, and once the IPv6
changes are applied, I'll post another patch to follow the change
in IPv4 using __ipv4_addr_hash().

static inline u32 __ipv4_addr_hash(const struct net *net, __be32 ip)
{
	return jhash_1word((__force u32)ip, net_hash_mix(net));
}

Thanks!

