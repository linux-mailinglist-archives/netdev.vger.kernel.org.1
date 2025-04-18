Return-Path: <netdev+bounces-184141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12018A9371A
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 14:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DE91896441
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 12:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69812269823;
	Fri, 18 Apr 2025 12:32:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D9C1E492;
	Fri, 18 Apr 2025 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744979533; cv=none; b=c76fXMQf0AQHObwPn3z3LAib8127pnBMsa1nfNCqbYTpi2o8RsW8c23f7LygAC1QZImwsCwquimHnDw1l8brKIqbp1osEhNjEFyx9ZLiFG+hKfSCTbLyqM3QUs5XoUC+oh+IXo+voIqwHqwAB/X0unSjo266BPXqgafHaoU8G5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744979533; c=relaxed/simple;
	bh=NPm4S1GZRDhpjTK6+SqCdr7oBRhy0ptbmVLK3fFFepI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BI1nU9BhupF0BQ2NhENJQ8hxZ7DIsVC9X1e2J6RA39ll3UeA0YEkluyMlucJfQx2s/V/TeJSzJ9MRUKvhmWC+h8R00b4RymH70v2qRAA2+mo8cIUOGen9KDrJZYhW5HafFRhtZNlwkxe1n8AuftSGw8IyzgVPRyRfE8n9M7tqIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E991DC4CEE2;
	Fri, 18 Apr 2025 12:32:10 +0000 (UTC)
Date: Fri, 18 Apr 2025 08:33:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Ahern <dsahern@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, kuniyu@amazon.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 yonghong.song@linux.dev, song@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next] udp: Add tracepoint for udp_sendmsg()
Message-ID: <20250418083351.20a60e64@gandalf.local.home>
In-Reply-To: <1b17ce33-015f-4a10-9a98-ebea586c3ce4@kernel.org>
References: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
	<4dd9504c-4bce-4acd-874c-8eed8c311a2f@kernel.org>
	<aADpIftw30HBT8pq@gmail.com>
	<8dc4d1a8-184b-4d0d-9b38-d5b65ce7e2a6@kernel.org>
	<aAElmpUWd6D7UBZY@gmail.com>
	<1b17ce33-015f-4a10-9a98-ebea586c3ce4@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 21:57:56 -0700
David Ahern <dsahern@kernel.org> wrote:

> On 4/17/25 10:00 AM, Breno Leitao wrote:
> >> $ git grep trace_ net drivers/net | grep _tp
> >> net/bpf/test_run.c:	trace_bpf_trigger_tp(nonce);
> >> net/ipv4/tcp_input.c:	trace_tcp_cwnd_reduction_tp(sk,
> >> newly_acked_sacked, newly_lost, flag);  
> > 
> > Do we want to rename them and remove the _tp? I suppose it is OK given
> > that tracepoints are not expected to be stable?
> > 
> > Also, if we have consensus about this patch, I will remove the _tp from
> > it.
> >   
> 
> I am only asking for consistency. Based on existing networking
> instances, consistency is no _tp suffix.

I was looking at what other tracepoints have "_tp" and found a few. What it
appears to be is that the "_tp" tracepoints are defined by:

  DECLARE_TRACEPOINT()

and have no corresponding trace event in tracefs (/sys/kernel/tracing/events).

I like that distinction because it lets the developer know that this
tracepoint is in kernel only, and not exposed to user space.

Perhaps it should stay as "_tp()" if it's not exposed via tracefs.

In fact, if there is a clean up, it should be adding "_tp" to all
tracepoints that do not have a corresponding trace event attached to them.
As they are in kernel only, that change should not cause any ABI breakage.

-- Steve

