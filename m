Return-Path: <netdev+bounces-159775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB74A16D49
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 14:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B99C3A1595
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 13:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4FF1E0DCB;
	Mon, 20 Jan 2025 13:20:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2853C1DED4B;
	Mon, 20 Jan 2025 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737379212; cv=none; b=GvIiH43it9SPGSp6XQou9qzeRqr5fNzA8lYt+3VsUrQDV9TQEbmuc+sm1zeILu203NB6jZvm7PwX6/2VjgT6uV41UI7M40P+Tbe5T1wDWUK6iXOzQOS4SgnZIc91w5NwJIuH83Adz+aQJxtp/KBR5Tx0ltuhnC3+cPqaO1Xh0d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737379212; c=relaxed/simple;
	bh=d9a6Dg0J1W39GmDDQnU3gGeZLq5v7YQZlKnUnXzuL/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPyk8srhse6zdnp1XmiQeXXy67pjsxHIee7iHw50jlUfCJBlZa4Hz+DgMTAxRzGIfTNKQALSdUHQZFbljoSChibjpkS2/3Yvd2pweCeTlLcJ4K06mWlNnlWYdPh2xeEpSj8zjGGpW3GFPT9gXF83j83Ai+6us+Y91k6YWRQwfUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso6296866a12.0;
        Mon, 20 Jan 2025 05:20:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737379209; x=1737984009;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MYis6HlhGRplgWvBiMnJFZfekMZ1/jUFI1n7CycfIOE=;
        b=qjD9KkoZxJSR6a7Q5im1ism1v+gGBAJ7R3jDe3aZFY4NiSdCJW3Xytx2bEZMQb9p90
         OkdrC7kFcPjxb5U0qsjAkd5iMLPsRH7pDEqGvFx1uVxu4z/xM5OHEL8kWJxgiQQrnItP
         v7OwE7vDANqu+CyNXoCpv25GOtR7Bx+G0jcar+n+GG+2N4A2pLHOE/qMgvKnim+9y9v8
         +yrSO0NQWKiS1Pnrp8BQszQpGRg/diIdbmcXfrDf8VMtoK1s6zA8Acna+oWBaUTAm/e4
         GJcSqzwnVVqNimYznLnPWvFGs24Vm2MmTb/0PAybOb0VzA9ED1cmqODysP0GScuXSSLW
         oxDw==
X-Forwarded-Encrypted: i=1; AJvYcCUYKwT7VL4wmYoPhC8hGOT0RVMkAZWFp2vLXUdsIh/0lpyKiOa3oNG1HZAt5UZHtqbR4+RaHmZYIzILIYQ=@vger.kernel.org, AJvYcCW4T8WUm5rKTidC1VsPfnNGflwVM22D8MI3FerKeaVKb9PB1IuTm1pgI+cuJPpLq/ozRxySkv5RWW1s9ijjmgeXMXV4@vger.kernel.org, AJvYcCXplHedURpt1W64OdzYTOYSk7S5lVad0FA4fxZvcs347uQk4mSGqoZRjOVA5RWWhuzYRzfno0p4@vger.kernel.org
X-Gm-Message-State: AOJu0YzHX1CLCr6R3S7OKB+CRpPDuUuzq+8h0+MfB148Iw9oENM4ytnB
	R9cH1c2prfANGD9BgLHxq5shmieGPptp1z7V9xvLIR37/4NhQiSD
X-Gm-Gg: ASbGncuGaK3YoGI2TaH6+bLu9nQq99eSKqP0rIgLwWRJd0cF5fmtBprDvPeX40rKdFe
	P+lvZdvQpgYUdu7N8cP94g3tkSyo1aY7wY2AMJOo7vYP0XnI6tEX+ENZt4NXuvlgc4fjJPH6Ou/
	FLtdi9Tb4QB+QennqvD+KEccN1MZYBmH/zFqfz57KXvFPTxFw0Q2sI082XCNISkcECsbMH8aNld
	ddK9/P4x28cTtkrAVtdwdF+Z4Ti5d/q2r6TabEeOq+MMaOnY+8j6eUllHl8
X-Google-Smtp-Source: AGHT+IFy3FOxk+8eI835a5jNbNilc9gYzUh2iQOx9IPlYEyV7KZ+ksbJ5wQ7qQW5yEreKbQHYI+RnA==
X-Received: by 2002:a05:6402:34d2:b0:5d0:bde9:2992 with SMTP id 4fb4d7f45d1cf-5db7db1459dmr10784754a12.26.1737379209072;
        Mon, 20 Jan 2025 05:20:09 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73642621sm5546279a12.13.2025.01.20.05.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 05:20:07 -0800 (PST)
Date: Mon, 20 Jan 2025 05:20:05 -0800
From: Breno Leitao <leitao@debian.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com,
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH RFC net-next] trace: tcp: Add tracepoint for
 tcp_cwnd_reduction()
Message-ID: <20250120-daring-outstanding-jaguarundi-c8aaed@leitao>
References: <20250120-cwnd_tracepoint-v1-1-36b0e0d643fa@debian.org>
 <CAL+tcoC+A94uzaSZ+SKhV04=iDWrvUGEfxYJKYCF0ovqvyhfOg@mail.gmail.com>
 <20250120-panda-of-impressive-aptitude-2b714e@leitao>
 <CAL+tcoCzStjkEMdNw5ORYbQy3VnVE9A6aj6HcmQvGj3VG1VypA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoCzStjkEMdNw5ORYbQy3VnVE9A6aj6HcmQvGj3VG1VypA@mail.gmail.com>


On Mon, Jan 20, 2025 at 09:06:43PM +0800, Jason Xing wrote:
> On Mon, Jan 20, 2025 at 9:02 PM Breno Leitao <leitao@debian.org> wrote:
> > On Mon, Jan 20, 2025 at 08:08:52PM +0800, Jason Xing wrote:
> > > On Mon, Jan 20, 2025 at 8:03 PM Breno Leitao <leitao@debian.org> wrote:
> > > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > > index 4811727b8a02258ec6fa1fd129beecf7cbb0f90e..fc88c511e81bc12ec57e8dc3e9185a920d1bd079 100644
> > > > --- a/net/ipv4/tcp_input.c
> > > > +++ b/net/ipv4/tcp_input.c
> > > > @@ -2710,6 +2710,8 @@ void tcp_cwnd_reduction(struct sock *sk, int newly_acked_sacked, int newly_lost,
> > > >         if (newly_acked_sacked <= 0 || WARN_ON_ONCE(!tp->prior_cwnd))
> > > >                 return;
> > > >
> > > > +       trace_tcp_cwnd_reduction(sk, newly_acked_sacked, newly_lost, flag);
> > > > +
> > >
> > > Are there any other reasons why introducing a new tracepoint here?
> > > AFAIK, it can be easily replaced by a bpf related program or script to
> > > monitor in the above position.
> >
> > In which position exactly?
> 
> I meant, in the position where you insert a one-line tracepoint, which
> should be easily replaced with a bpf program (kprobe
> tcp_cwnd_reduction with two checks like in the earlier if-statement).
> It doesn't mean that I object to this new tracepoint, just curious if
> you have other motivations.

This is exactly the current implementation we have at Meta, as it relies on
hooking into this specific function. This approach is unstable, as
compiler optimizations like inlining can break the functionality.

This patch enhances the API's stability by introducing a guaranteed hook
point, allowing the compiler to make changes without disrupting the
BPF program's functionality.

