Return-Path: <netdev+bounces-18752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC11C758893
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 00:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA491C20CBD
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 22:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3A3171A7;
	Tue, 18 Jul 2023 22:36:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E96168BE
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 22:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE15C433C8;
	Tue, 18 Jul 2023 22:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689719792;
	bh=+YhLgoRHKOH64etKNRAxD8sMX3l+0iZdgCUoDa3/pMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N3ghm/7ygWZ0gysELMTMg/s+DVa+x0WsnV7KLYqckpromzgMKWEynSn8zUMs5c/DS
	 nTgq/jUr0nO8+iJ+XhctPyICxHFYmYpCTbsi2edQQVQscM9vqTcaQ70YQIhTGEYh9E
	 wzSF51A6NwCbi2FRrLpvtch1KrbkzTWHyLY+KOj8QRyik7HxBah4DchkXpNl8FEdA+
	 i8SQ8jK7uUU8hKIBXxDy6JKy3NOgQa0v7eU043ryXKZilYnKmTb/w1MgC0lwucJxpJ
	 wOtOm7IthTNl+UIUEyEP2goOjvLos6dIOgzOnysTuur1vMNN8xvrQuZALSGFHlH/Cs
	 NpTfbeWz68d7g==
Date: Tue, 18 Jul 2023 15:36:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>, Ivan Babrou <ivan@cloudflare.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, kernel-team
 <kernel-team@cloudflare.com>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: Stacks leading into skb:kfree_skb
Message-ID: <20230718153631.7a08a6ec@kernel.org>
In-Reply-To: <e64291ac-98e0-894f-12cb-d01347aef36c@kernel.org>
References: <CABWYdi00L+O30Q=Zah28QwZ_5RU-xcxLFUK2Zj08A8MrLk9jzg@mail.gmail.com>
	<e64291ac-98e0-894f-12cb-d01347aef36c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jul 2023 18:54:14 -0600 David Ahern wrote:
> > I made some aggregations for the stacks we see leading into
> > skb:kfree_skb endpoint. There's a lot of data that is not easily
> > digestible, so I lightly massaged the data and added flamegraphs in
> > addition to raw stack counts. Here's the gist link:
> > 
> > * https://gist.github.com/bobrik/0e57671c732d9b13ac49fed85a2b2290  
> 
> I see a lot of packet_rcv as the tip before kfree_skb. How many packet
> sockets do you have running on that box? Can you accumulate the total
> packet_rcv -> kfree_skb_reasons into 1 count -- regardless of remaining
> stacktrace?

On a quick look we have 3 branches which can get us to kfree_skb from
packet_rcv:

	if (skb->pkt_type == PACKET_LOOPBACK)
		goto drop;
...
	if (!net_eq(dev_net(dev), sock_net(sk)))
		goto drop;
...
	res = run_filter(skb, sk, snaplen);
	if (!res)
		goto drop_n_restore;

I'd guess is the last one? Which we should mark with the SOCKET_FILTER
drop reason? 

