Return-Path: <netdev+bounces-102334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 075E090278A
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 19:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D92DB22545
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00516152175;
	Mon, 10 Jun 2024 16:54:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F8414AD3E;
	Mon, 10 Jun 2024 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718038467; cv=none; b=EMaclGYCNEHDHg/caw29vEAKHx8iaSu/lY5WHxZocHkchtrdLI9Ny75+ehTzVCaHdAfY32OWcMdnhkbbcBqhkYPW0Sipuci2C9zH7IBQ6oItClMzkrd1dlZpENX7iQidbTUl41+D2no6cOUBHZLfGY/A7VVIZynEzqkonSmIV/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718038467; c=relaxed/simple;
	bh=IHKjkJJmNUwQBgZoGJ0QQEMWCIHokZu18EE5Cx8Z+f8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GyCA0oUHdIJE5GpENnff5CrnAxFvYo6LJT5FYhdFdplqs2z6a0GYma6flsyVKlVbWpl98N1a2UmIdwHkXvJm4qyPc3ar56aZ9rwvS7IvRlNt2hyYhfzmOFQeWCzk19TQWsxqAmyW0fzlE5f6Di1GIPhZTcXL3o4vFgLLlNzwxw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599B4C2BBFC;
	Mon, 10 Jun 2024 16:54:24 +0000 (UTC)
Date: Mon, 10 Jun 2024 12:54:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, Abhishek Chauhan <quic_abchauha@quicinc.com>, Mina
 Almasry <almasrymina@google.com>, Florian Westphal <fw@strlen.de>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, David Howells
 <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann
 <daniel@iogearbox.net>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Pavel Begunkov
 <asml.silence@gmail.com>, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com, Jesper Dangaard Brouer <hawk@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Neil Horman <nhorman@tuxdriver.com>,
 linux-trace-kernel@vger.kernel.org, Dan Carpenter
 <dan.carpenter@linaro.org>
Subject: Re: [RFC v3 net-next 1/7] net: add rx_sk to trace_kfree_skb
Message-ID: <20240610125422.252da487@rorschach.local.home>
In-Reply-To: <CAO3-PbqRNRduSAyN9CtaxPFsOs9xtGHruu1ACfJ5e-mrvTo2Cw@mail.gmail.com>
References: <cover.1717529533.git.yan@cloudflare.com>
	<983c54f98746bd42d778b99840435d0a93963cb3.1717529533.git.yan@cloudflare.com>
	<20240605195750.1a225963@gandalf.local.home>
	<CAO3-PbqRNRduSAyN9CtaxPFsOs9xtGHruu1ACfJ5e-mrvTo2Cw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Jun 2024 10:37:46 -0500
Yan Zhai <yan@cloudflare.com> wrote:

> > name: kfree_skb
> > ID: 1799
> > format:
> >         field:unsigned short common_type;       offset:0;       size:2; signed:0;
> >         field:unsigned char common_flags;       offset:2;       size:1; signed:0;
> >         field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
> >         field:int common_pid;   offset:4;       size:4; signed:1;
> >
> >         field:void * skbaddr;   offset:8;       size:8; signed:0;
> >         field:void * location;  offset:16;      size:8; signed:0;
> >         field:unsigned short protocol;  offset:24;      size:2; signed:0;
> >         field:enum skb_drop_reason reason;      offset:28;      size:4; signed:0;
> >
> > Notice that "protocol" is 2 bytes in size at offset 24, but "reason" starts
> > at offset 28. This means at offset 26, there's a 2 byte hole.
> >  
> The reason I added the pointer as the last argument is trying to
> minimize the surprise to existing TP users, because for common ABIs
> it's fine to omit later arguments when defining a function, but it
> needs change and recompilation if the order of arguments changed.

Nothing should be hard coding the offsets of the fields. This is
exported to user space so that tools can see where the fields are.
That's the purpose of libtraceevent. The fields should be movable and
not affect anything. There should be no need to recompile.

> 
> Looking at the actual format after the change, it does not add a new
> hole since protocol and reason are already packed into the same 8-byte
> block, so rx_skaddr starts at 8-byte aligned offset:
> 
> # cat /sys/kernel/debug/tracing/events/skb/kfree_skb/format
> name: kfree_skb
> ID: 2260
> format:
>         field:unsigned short common_type;       offset:0;
> size:2; signed:0;
>         field:unsigned char common_flags;       offset:2;
> size:1; signed:0;
>         field:unsigned char common_preempt_count;       offset:3;
>  size:1; signed:0;
>         field:int common_pid;   offset:4;       size:4; signed:1;
> 
>         field:void * skbaddr;   offset:8;       size:8; signed:0;
>         field:void * location;  offset:16;      size:8; signed:0;
>         field:unsigned short protocol;  offset:24;      size:2; signed:0;
>         field:enum skb_drop_reason reason;      offset:28;
> size:4; signed:0;
>         field:void * rx_skaddr; offset:32;      size:8; signed:0;
> 
> Do you think we still need to change the order?

Up to you, just wanted to point it out.

-- Steve


