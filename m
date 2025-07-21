Return-Path: <netdev+bounces-208639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CB9B0C790
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 17:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9784C3BB9F6
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 15:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2865328F95E;
	Mon, 21 Jul 2025 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOrQf2JL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043BC1ADC83
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111650; cv=none; b=sot2UZIrdX7t5Ns2MXxdI8DMwgWXYrdWRe72NS5Tszk2IMGJPWHg+5KdVJF2K5sxRfRybo+ENglg3K1JMZK9NAR5cWT1IqQLLCTxaigSA75MLGbJFo1RJ17vvJp4nTe6TuToLawrcgRrL7jkksRe2O6U8DfEOYMDxg6d2CDVAKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111650; c=relaxed/simple;
	bh=g1tBAu/cC9jnlafvEZsD7sFmnIbmzbkLQxtCnDbjXk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Amn2hK/FTLaorTkrQjUjBJuxrPDcaefLdd+m69pez3f51i13wEyybJfuqWCeVU64InsB56fr/3bBjyPCLQW17xktnOjwC6ESTmv4ashNGt0CT6wcLA8DYHg7NBe5Ni3aoLpi8mo6RqzSlY+Qp7F79md/JRxr219pNMsR9f5l2Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOrQf2JL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7C0C4CEED;
	Mon, 21 Jul 2025 15:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753111649;
	bh=g1tBAu/cC9jnlafvEZsD7sFmnIbmzbkLQxtCnDbjXk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NOrQf2JLS/0ax6fFgfq5MIGumN7hiFnLm79ltroIniQPCalApFBL0yMghBLVA4JKh
	 wp4RguE9iRMhy2KJGa0p7D5L/5bBFtx3WIl8GN2pUDlyuXhvrDUa2kLF5/BcRU4Mim
	 RTtEIEE9vgItth0WDD8zRLrKJLOGZRsMq3BlowdDMKGjRTu5KexTtqyT1hn9oBhxGF
	 yW5C104Ja3j7PpOfgF9vjqABr0zofmWi056sESUsAR8Jt+RDE3QiqCRi2Ypji01Zw6
	 Eblhyrlioi193ZMkrwzIuSq1+xS9QOgwOBEQfFeWdWmNDS7N98TYZLjFIuP4/4+Dsh
	 G4LO62xk4w/vw==
Date: Mon, 21 Jul 2025 08:27:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Neal
 Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
Subject: Re: [PATCH net-next 1/2] tcp: do not set a zero size receive buffer
Message-ID: <20250721082728.355745f2@kernel.org>
In-Reply-To: <1d78b781-5cca-440c-b9d0-bdf40a410a3d@redhat.com>
References: <cover.1752859383.git.pabeni@redhat.com>
	<3e080bdba9981988ff86e120df40a5f0dc6cd033.1752859383.git.pabeni@redhat.com>
	<CANn89i+KCsw+LH1X1yzmgr1wg5Vxm47AbAEOeOnY5gqq4ngH4w@mail.gmail.com>
	<f8178814-cf90-4021-a3e2-f2494dbf982a@redhat.com>
	<CANn89i+baSpvbJM6gcbSjZMmWVyvwsFotvH1czui9ARVRjS5Bw@mail.gmail.com>
	<ebc7890c-e239-4a64-99af-df5053245b28@redhat.com>
	<CANn89iJeXXJV-D5g3+hqStM1sH0UZ3jDeZmOu9mM_E_i9ZYaeA@mail.gmail.com>
	<1d78b781-5cca-440c-b9d0-bdf40a410a3d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Jul 2025 16:56:06 +0200 Paolo Abeni wrote:
> >> I *think* that catching only the !sk_rmem_alloc case would avoid the
> >> stall, but I think it's a bit 'late'.  
> > 
> > A packetdrill test here would help understanding your concern.  
> 
> I fear like a complete working script would take a lot of time, let me
> try to sketch just the relevant part:
> 
> # receiver state is:
> # rmem=110592 rcvbuf=174650 scaling_ratio=253 rwin=63232
> # no OoO data, no memory pressure,
> 
> # the incoming packet is in sequence
> +0 > P. 109297:172528(63232) ack 1
> 
> With just the 0 rmem check in tcp_prune_queue(), such function will
> still invoke tcp_clamp_window() that will shrink the receive buffer to
> 110592.
> tcp_collapse() can't make enough room and the incoming packet will be
> dropped. I think we should instead accept such packet.
> 
> Side note: the above data are taken from an actual reproduction of the issue
> 
> Please LMK if the above clarifies a bit my doubt or if a full pktdrill
> is needed.

Not the first time we stumble on packetdrills for scaling ratio.
Solving it is probably outside the scope of this discussion but 
I wonder what would be the best way to do it. My go to is to
integrate packetdrill with netdevsim and have an option for netdevsim
to inflate truesize on demand. But perhaps there's a clever way we can
force something like tap to give us the ratio we desire. Other ideas?

