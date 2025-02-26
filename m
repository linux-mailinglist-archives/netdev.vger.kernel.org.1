Return-Path: <netdev+bounces-170035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6FEA46FA3
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 00:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA4E16C51B
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 23:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C58270050;
	Wed, 26 Feb 2025 23:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kaz3srJy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AA2270028;
	Wed, 26 Feb 2025 23:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740613598; cv=none; b=iY3WpxeP6YgGvS7XP0+szk1eye7Inz4qeFzn2BsAJKqO/YOJ1+RIu1HO3Aw5GZXBLlidqoHwJw5wUJK4GW+0fjlMatT7bux8Yzj35KQM6COXQzpBkQquZE5Z1d2uxOSvwiU9HArr0peYeEoW/Zzmz863otNXO6gP6KLHpJxmr2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740613598; c=relaxed/simple;
	bh=6ftfCkEYFUthTag7/WYnVErlCC9sJd5WAdqss6rh2RM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Gy7knkF8vdNZ2niEZMvjcoWGNUTCy50FEquUCTrJ45UBkeuTmev/+5swC3Ee8/quSsMeBLbhALYSDbJ1YK6tZH0fofRDwup9EJCaVi0x6gLrp+WrEmma0igj3Yk5sgMWlhhOEN+9RP084zgdOE22D9TM1leJrU1aH8OjR5o2yxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kaz3srJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC13C4CEE8;
	Wed, 26 Feb 2025 23:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740613598;
	bh=6ftfCkEYFUthTag7/WYnVErlCC9sJd5WAdqss6rh2RM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kaz3srJylFaYL/nS4MWe15aZ/hJlqNZJt9Tr1AVBW3HIFKSgn2vXCsrv6yyPr9wcU
	 uTtk7ujLLszX/EITv9PsHUFY9tlEBW58SF1LxnteqZ1+HBPU73jYT16Tl30QzIpN3r
	 diAQ5N49wtB5OVFlcEc8BRRRuazNP4ZNoV1vrxdNII8cukaI9ognOG/bji3PINP1Ip
	 GMZ4DnFQnvD8ufDxk50u6n7bKEcWz6VYsq9f/9YH4N6wC3TLMq0aAKdtVcd4OgqZFZ
	 yXv/Vo8b+rwDneQ5AY5ShUQB7/xaa5FAwqZkQYTbM6gd6pJNdmpnnmThlTOZV5mNPG
	 tKoarA7aM1n4w==
Date: Thu, 27 Feb 2025 08:46:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Yonghong Song <yhs@meta.com>, Breno Leitao <leitao@debian.org>, Neal
 Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>, Kernel Team <kernel-team@meta.com>,
 "yonghong.song@linux.dev" <yonghong.song@linux.dev>
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for tcp_sendmsg()
Message-Id: <20250227084631.025e02eee682c42f296fe570@kernel.org>
In-Reply-To: <CANn89i+zxMje+wbQzLKbSq_WKYnwGdMyAdStMm4GqkdJCvWPOg@mail.gmail.com>
References: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
	<CANn89iLybqJ22LVy00KUOVscRr8GQ88AcJ3Oy9MjBUgN=or0jA@mail.gmail.com>
	<SA3PR15MB5630CFBB36C212008DA8ACC7CAC02@SA3PR15MB5630.namprd15.prod.outlook.com>
	<CANn89i+zxMje+wbQzLKbSq_WKYnwGdMyAdStMm4GqkdJCvWPOg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 24 Feb 2025 20:23:00 +0100
Eric Dumazet <edumazet@google.com> wrote:

> On Mon, Feb 24, 2025 at 8:13 PM Yonghong Song <yhs@meta.com> wrote:
> >
> > > ________________________________________
> > >
> > > On Mon, Feb 24, 2025 at 7:24 PM Breno Leitao <leitao@debian.org> wrote:
> > >>
> > >> Add a lightweight tracepoint to monitor TCP sendmsg operations, enabling
> > >> the tracing of TCP messages being sent.
> > >>
> > >> Meta has been using BPF programs to monitor this function for years,
> > >> indicating significant interest in observing this important
> > >> functionality. Adding a proper tracepoint provides a stable API for all
> > >> users who need visibility into TCP message transmission.
> > >>
> > >> The implementation uses DECLARE_TRACE instead of TRACE_EVENT to avoid
> > >> creating unnecessary trace event infrastructure and tracefs exports,
> > >> keeping the implementation minimal while stabilizing the API.
> > >>
> > >> Given that this patch creates a rawtracepoint, you could hook into it
> > >> using regular tooling, like bpftrace, using regular rawtracepoint
> > >> infrastructure, such as:
> > >>
> > >>         rawtracepoint:tcp_sendmsg_tp {
> > >>                 ....
> > >>         }
> > >
> > > I would expect tcp_sendmsg() being stable enough ?
> > >
> > > kprobe:tcp_sendmsg {
> > > }
> >
> > In LTO mode, tcp_sendmsg could be inlined cross files. For example,
> >
> >   net/ipv4/tcp.c:
> >        int tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
> >   net/ipv4/tcp_bpf.c:
> >        ...
> >       return tcp_sendmsg(sk, msg, size);
> >   net/ipv6/af_inet6.c:
> >        ...
> >        return INDIRECT_CALL_2(prot->sendmsg, tcp_sendmsg, udpv6_sendmsg, ...)
> >
> > And this does happen in our production environment.
> 
> And we do not have a way to make the kprobe work even if LTO decided
> to inline a function ?

There is `perf probe` command to set it up based on the debuginfo. But
the function parameters sometimes optimized out and no more accessible.
(You can try.)

Thus if you needs this tracepoint not temporarily nor debugging,
I would recommend to use tracepoint (or trace event).

Thank you,

> 
> This seems like a tracing or LTO issue, this could be addressed there
> in a generic way
> and avoid many other patches to work around this.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

