Return-Path: <netdev+bounces-145533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF9D9CFC4C
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 02:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E81BB218B2
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 01:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F772AF1D;
	Sat, 16 Nov 2024 01:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpH5LTrF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588262913;
	Sat, 16 Nov 2024 01:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731722321; cv=none; b=Vgw+ZILK2x7i6ETq1V1O+qYGrqEEAfWv7eoXksaq0PVfG3jGQ87q8NIwca4Hbru6fQL4UygLBwuUC/IfTw1V5Yn1jK9U+LXSRTF1FP7IAzo6+GLaD4PIZ5EwyjEQCgSdrWHhHhsJ2uO3EZ3UiubJXXzeznhHXEFlx2gLDLaUWgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731722321; c=relaxed/simple;
	bh=YpKqZkkXKh9vi9wPu8pqea+VYDD9G5A8z/ZyYchkG9k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aMUlZTDNQwZvRkQVZ6E4fftDzR75+UmG2UOWh216V43U5VMVmxyO5HXifXivyIdYUyQOnkQyrUVvQKy1OepQ7GPlWhteHSgBTMEfsLMr7iaKMiIN/4mltYpwehKwT8rnaboPOa28VD4aOSXxRQ6YE2VWRaDRNxtBvlbciPvbXro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpH5LTrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F56C4CECF;
	Sat, 16 Nov 2024 01:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731722320;
	bh=YpKqZkkXKh9vi9wPu8pqea+VYDD9G5A8z/ZyYchkG9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hpH5LTrFT3T4HqFaINW0+opeFJazWvFJZb304m4Z3bWbFR3H6ovOSETh+Rm5T4Bb1
	 oDHN47t4OrPoSpIyWERE8GTepAQjebM5dKktap1D8DNBP2lx9zbCyFwveFYKZAinkb
	 UgttPZJ7RT6cWJBj6ogrIjXainLi+KXtdpqpLnE660bwIN+OhfEa6CMJKmL9QTtMLR
	 QAad8cP07olO8nzaFikQCe+xlOAZJAGz+/ka7fNoRsFVhM4Jfa4ktv6G1WVuQDjKWb
	 WJnjH8IOxbMCkitIbnJqL3azHywn3TQjTw3oPr8M3PMRRdjb6YuhMXuJzHiaqaz+uW
	 cNKO5GbOIxUpQ==
Date: Fri, 15 Nov 2024 17:58:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Ivan Delalande
 <colona@arista.com>, Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Davide Caratti <dcaratti@redhat.com>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, mptcp@lists.linux.dev, Johannes Berg
 <johannes@sipsolutions.net>
Subject: Re: [PATCH net v2 0/5] Make TCP-MD5-diag slightly less broken
Message-ID: <20241115175838.4dec771a@kernel.org>
In-Reply-To: <CAJwJo6ax-Ltpa2xY7J7VxjDkUq_5NJqYx_g+yNn9yfrNHfWeYA@mail.gmail.com>
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
	<20241115160816.09df40eb@kernel.org>
	<CAJwJo6ax-Ltpa2xY7J7VxjDkUq_5NJqYx_g+yNn9yfrNHfWeYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Nov 2024 00:48:17 +0000 Dmitry Safonov wrote:
> On Sat, 16 Nov 2024 at 00:08, Jakub Kicinski <kuba@kernel.org> wrote:
> > On Wed, 13 Nov 2024 18:46:39 +0000 Dmitry Safonov via B4 Relay wrote:  
> > > 2. Inet-diag allocates netlink message for sockets in
> > >    inet_diag_dump_one_icsk(), which uses a TCP-diag callback
> > >    .idiag_get_aux_size(), that pre-calculates the needed space for
> > >    TCP-diag related information. But as neither socket lock nor
> > >    rcu_readlock() are held between allocation and the actual TCP
> > >    info filling, the TCP-related space requirement may change before
> > >    reaching tcp_diag_put_md5sig(). I.e., the number of TCP-MD5 keys on
> > >    a socket. Thankfully, TCP-MD5-diag won't overwrite the skb, but will
> > >    return EMSGSIZE, triggering WARN_ON() in inet_diag_dump_one_icsk().  
> >
> > Would it be too ugly if we simply retried with a 32kB skb if the initial
> > dump failed with EMSGSIZE?  
> 
> Yeah, I'm not sure. I thought of keeping it simple and just marking
> the nlmsg "inconsistent". This is arguably a change of meaning for
> NLM_F_DUMP_INTR because previously, it meant that the multi-message
> dump became inconsistent between recvmsg() calls. And now, it is also
> utilized in the "do" version if it raced with the socket setsockopts()
> in another thread.

NLM_F_DUMP_INTR is an interesting idea, but exactly as you say NLM_F_DUMP_INTR
was a workaround for consistency of the dump as a whole. Single message
we can re-generate quite easily in the kernel, so forcing the user to
handle INTR and retry seems unnecessarily cruel ;)

> > > In order to remove the new limit from (4) solution, my plan is to
> > > convert the dump of TCP-MD5 keys from an array to
> > > NL_ATTR_TYPE_NESTED_ARRAY (or alike), which should also address (1).
> > > And for (3), it's needed to teach tcp-diag how-to remember not only
> > > socket on which previous recvmsg() stopped, but potentially TCP-MD5
> > > key as well.  
> >
> > Just putting the same attribute type multiple times is preferable
> > to array types.  
> 
> Cool. I didn't know that. I think I was confused by iproute way of
> parsing [which I read very briefly, so might have misunderstood]:
> : while (RTA_OK(rta, len)) {
> :         type = rta->rta_type & ~flags;
> :         if ((type <= max) && (!tb[type]))
> :                 tb[type] = rta;
> :         rta = RTA_NEXT(rta, len);
> : }
> https://github.com/iproute2/iproute2/blob/main/lib/libnetlink.c#L1526
> 
> which seems like it will just ignore duplicate attributes.
> 
> That doesn't mean iproute has to dictate new code in kernel, for sure.

Right, the table based parsing doesn't work well with multi-attr,
but other table formats aren't fundamentally better. Or at least
I never came up with a good way of solving this. And the multi-attr
at least doesn't suffer from the u16 problem.

