Return-Path: <netdev+bounces-169417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6DBA43C7D
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7813AEDAA
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B0E2673B2;
	Tue, 25 Feb 2025 10:58:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE3379D0;
	Tue, 25 Feb 2025 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481098; cv=none; b=IKmrYb/DMax8UTjmwFv+i//oWvdhwFYV9MI+rcyqWVAfGa1w9/9TORXafIRhdzQ0Es7aq3n0eoMavRlimqnskYlCUwPEHE2fC8kcaYGgXK6Ja4pyNFUMUoD6UoBVQhxK9yWFXKCxhiI9Y/Pe6wVvyaXnaAf48iUoYp6EeuHr01s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481098; c=relaxed/simple;
	bh=YE2cVH7ILPdji763dvBKtSttuGhyBEY/b0k+dsw7F3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZx4dJ+2v6WhAvTBLk7qRs7XLS7oRzmLauW+/8fGoVjZw7pBVUK0F35xhwrwTr1jc4fEIC3CA9H3ibcBvn/cEg7FuMO/nCwmkKvPa72sOjeUgHJrvQuKvr9iAAYUcF0pqfKaU51d5POGNOG6rkG5zn+/NjM8zD7+v3c/EZRLnVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5ded368fcd9so7831989a12.1;
        Tue, 25 Feb 2025 02:58:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481094; x=1741085894;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVLEsWhXKjAp+8uIFfafhY+8jwVrpBjpGy0ScKqrlr4=;
        b=uUNczNCTxdyTj8J768jGx47vQvboekOEmK/O1sXKzuHB/ckmhiWTHkbK7wdzta+UTT
         p1A2N5VpBuyHrs3ZaiW3258S41n9zCz+WNALLbNL3r5PBNwyPCRp/fCMltb0sxcCw+A2
         BmDKTfBowWA4Stf6zV++TaS9UPjs2o2GsszYtYdn/IS7lkjAEGqrLymM8MpZL4/hx4jH
         8qT5AVL8Ur2GrWERD7SGDtuIdv70PhVZv8lecs9m1jZnDIN4aYNyMZcKua4wlJ3g5FGv
         w2QZJJtjK4ilvhkvci/hkBLIH8MNWqr4Mw93ZmRcVkNPF8Gk3+bM/cOqon98/IYzoo3u
         +TOw==
X-Forwarded-Encrypted: i=1; AJvYcCUPsMDQn1I8q6F+nnKT2p13YxijBpXdJX0RH2CZorM6mE4KAVz+Gnxi9FdyIL4RV5weYLNXmGK7isje36U=@vger.kernel.org, AJvYcCVXA9EIQsiWrpIlUIcScSBbKppQxv8lxKQ6ng+zBvFf4ndsuhKRcsHqutcfAxdlilvnLQM5bUxm@vger.kernel.org, AJvYcCXcccvsHkIbseytSzwADgYUz0gZ763WN896ll9RITftgBp7k78fSMbZqgFscbq+poNjYy2TFAAL+naXpcUkde9p0xEg@vger.kernel.org
X-Gm-Message-State: AOJu0YyGPiKN17UtElzGmRPFcS/ozUtxNCL+VJm7t5tllyqYMhN86QRa
	uzzzIyqZioqf/lcZpzU/gt1ciXLBPxpjpMzAqTedNhdREKfteIpU
X-Gm-Gg: ASbGncuRe6pePO9Nc4Z+Jklj/sD+X2TfK6b2Huer3c0YHDWfWgSzfYfHxtnFi1eHYY3
	h4ohPA20d2ykUgzH1lWMAGBhzDDLNkBqmq1abd95tyBOmzljv5dq6pjfit3pr0wIdv+GPORAgNC
	5ziWP4gYZNnZ+JNhQyUss5ZPzEv2tkD6hU0LFKdpXYMoA0CFPf40+bEeFRrPW1TLMpWvela1RWa
	oqcSR9vWA0OcUJI90LxatXV+iqTBIFqm27ZQpmIxNJ4a8yIvCfD+cgneyNbybWWxyC+o6X0M97a
	LbVaobDmLQkne0CE
X-Google-Smtp-Source: AGHT+IEfEbllpJqiUZsNY0r/y/6uQFmExRBKuIYrUFWMQE/Vjz9p0dnbVslSpj4Y3IbZeejiizwMxw==
X-Received: by 2002:a17:907:3f92:b0:abb:e259:2a64 with SMTP id a640c23a62f3a-abc09b21c99mr1664018866b.33.1740481093781;
        Tue, 25 Feb 2025 02:58:13 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1da0befsm121016066b.74.2025.02.25.02.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 02:58:13 -0800 (PST)
Date: Tue, 25 Feb 2025 02:58:10 -0800
From: Breno Leitao <leitao@debian.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Yonghong Song <yhs@meta.com>, Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for tcp_sendmsg()
Message-ID: <20250225-interesting-nocturnal-okapi-b43735@leitao>
References: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
 <CANn89iLybqJ22LVy00KUOVscRr8GQ88AcJ3Oy9MjBUgN=or0jA@mail.gmail.com>
 <SA3PR15MB5630CFBB36C212008DA8ACC7CAC02@SA3PR15MB5630.namprd15.prod.outlook.com>
 <CANn89i+zxMje+wbQzLKbSq_WKYnwGdMyAdStMm4GqkdJCvWPOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+zxMje+wbQzLKbSq_WKYnwGdMyAdStMm4GqkdJCvWPOg@mail.gmail.com>

Hello Eric,

On Mon, Feb 24, 2025 at 08:23:00PM +0100, Eric Dumazet wrote:
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
> 
> This seems like a tracing or LTO issue, this could be addressed there
> in a generic way
> and avoid many other patches to work around this.

I understand that the {raw}tracepoint ensures the compiler cannot
interfere with these hook points. For everything else, we rely on the
hope that the compiler behaves favorably, which is far from ideal.

