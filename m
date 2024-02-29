Return-Path: <netdev+bounces-76237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD5886CEF4
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 17:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D3A285EF6
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 16:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE0B7A14A;
	Thu, 29 Feb 2024 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suiMkyj0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B689B7A121
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223672; cv=none; b=mEbZnqU+EGH6p7DzO8qbvGtJiZg9wMkfK8eslrMDUrM4lziELlGO2vcJiUkkS+LvrPW4ksqE3S3Wzo6+aJuCdEwbNlZAWtwRiVKSZZaouRENJECFvyQg02rsyAXxq5TxjkXHhHSsxnJ0P5d7Tyko7lDMBUXtYT8djP2JAAi+rIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223672; c=relaxed/simple;
	bh=NY52okGZOciVTC1jYblcmJbsxmdnPZXLvi0Nt1mpcuM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lh6+67kZ0Uztsnk6NB358GYVkDOId6eFbzZYf+sJ31KkNCs6pdIMQa7PvchZ9D620SSN+xvWBzQEFyapotJzcTdxso6B5P8xjvKg3JlPqQ9+aiY9eBEfmIwwlINQl01OKIbEDwUkP+UfhErOzEtsgFHPwkhmHs6jZHBkoSoj4xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suiMkyj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3694C433C7;
	Thu, 29 Feb 2024 16:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709223672;
	bh=NY52okGZOciVTC1jYblcmJbsxmdnPZXLvi0Nt1mpcuM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=suiMkyj0a9j/d7DaM3ptJ4JYLGZPA2mqFBoUa56S0nFXr68p0gpLo9n/VK+K5aM9B
	 ERBP0FzFhYjeU1jsUwjVST6oKvDtA2R23KnzaBLg1SkxFH9b8gerqdm1vE9v7LKuS7
	 ne+okkUi+SLEFIN69N40XYjOs+a/AMKnShsn7JktjZ25wY3ZI27E33iFMGAftBM8MU
	 A1eUjsqwyMaizjbUSzoq4TXp02WXorFOFytnbZ/6DT/pF8VRJv/kOiaqqPQvdSuYlS
	 hLX6fkNDhNmti3X9HtakmOxWjz1/CRRF/Uf7Rfz44Ee6z3tW4DLt0NiWpEhqotTBam
	 exaS1LzjEQBhw==
Date: Thu, 29 Feb 2024 08:21:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Jiri Pirko <jiri@nvidia.com>, David Ahern
 <dsahern@kernel.org>, netdev@vger.kernel.org, Florian Westphal
 <fw@strlen.de>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 6/6] inet: use xa_array iterator to implement
 inet_dump_ifaddr()
Message-ID: <20240229082110.796fbb09@kernel.org>
In-Reply-To: <CANn89iLPo61i8-ycKYVrUtEUVMGg09mw153eB3sPX24jXaD9WA@mail.gmail.com>
References: <20240229114016.2995906-1-edumazet@google.com>
	<20240229114016.2995906-7-edumazet@google.com>
	<20240229073750.6e59155e@kernel.org>
	<CANn89iLMZ2NT=DSdvGG9GpOnrfbvHo7bCk3Cj-v9cPgK-4N-oA@mail.gmail.com>
	<CANn89iLPo61i8-ycKYVrUtEUVMGg09mw153eB3sPX24jXaD9WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 16:50:45 +0100 Eric Dumazet wrote:
> > > You basically only want to return skb->len when message has
> > > overflown, so the somewhat idiomatic way to do this is:
> > >
> > >         err = (err == -EMSGSIZE) ? skb->len : err;  
> 
> This would set err to zero if skb is empty at this point.
> 
> I guess a more correct action would be:
> 
> if (err == -EMSGSIZE && likely(skb->len))
>     err = skb->len;

Ugh, fair point.
We should probably move the EMSGSIZE handling to the core, this is
getting too complicated for average humans.. Like this?

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 765921cf1194..ce27003b90a8 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2264,6 +2264,8 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 		if (extra_mutex)
 			mutex_lock(extra_mutex);
 		nlk->dump_done_errno = cb->dump(skb, cb);
+		if (nlk->dump_done_errno == -EMSGSIZE && skb->len)
+			nlk->dump_done_errno = skb->len;
 		if (extra_mutex)
 			mutex_unlock(extra_mutex);

> > >
> > > Assuming err can't be set to some weird positive value.
> > >
> > > IDK if you want to do this in future patches or it's risky, but I have
> > > the itch to tell you every time I see a conversion which doesn't follow
> > > this pattern :)  
> >
> > This totally makes sense.
> >
> > I will send a followup patch to fix all these in one go, if this is ok
> > with you ?

Definitely not a blocker

