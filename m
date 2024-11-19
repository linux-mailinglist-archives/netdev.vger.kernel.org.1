Return-Path: <netdev+bounces-146026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9189D9D1C27
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 01:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AC6280E40
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 00:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842D51876;
	Tue, 19 Nov 2024 00:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="en+BIKAF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D3A4C79;
	Tue, 19 Nov 2024 00:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731975165; cv=none; b=ahM3vK0NhHrdJuoVETtg2HmArRDaF/v96qYFiOy1LKCYXVOlGxtzgotlTVHkemBtwmQTg/xd3roVmPvtL/gAxYYLvWBLMf4uXf2nT1Xwig44/Sq4+YllwyWHW0ixZdJlJn1erMOjlHPAILkTifYLTNdBBZ1sbPabNcmpFhehILo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731975165; c=relaxed/simple;
	bh=DGHPR51uRHUPukb2rIe3ofMbIuCZTjfafAGw9yjHnVU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gjmlmkLzXBg8Z/6gX8Kazj9dWZbTzH07rWv4j3I25q3letDFIfSdCGJhfVvpy5XNKT0BE5Nxmy6spNXSsBwQdSgdIC6K/Tl5X0upBgMUpYxSiRsXqoTJWAwCdSTYOrHiDVq2MprFTDtr3eLqG8nBuq0LUqcgmw1KxGkaJeFimKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=en+BIKAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E3FC4CECC;
	Tue, 19 Nov 2024 00:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731975164;
	bh=DGHPR51uRHUPukb2rIe3ofMbIuCZTjfafAGw9yjHnVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=en+BIKAF8n7fR0snuOjMQUX4q4c/2kQqy1qCHU00WxCejJIG3MR+0K4GgpW3T0nuG
	 AO6vYyglaok8B0PMRDvkdU91D+It4CNlf92R+naXukCGZS9njHKWrPcTISI1aUjYnX
	 S4wJ9WEkoGfdvEJYJVyxfzPDfJfkPFc5fBZSv4kCsSkAIXsHwxeePvz7iMn11PM2Gb
	 s4t6Ihkj9rtQTL2KgTLX9tpCpfGzBiHWpSdF3A1CRGZLKDiwxs1t3TK8vFbm4jmO0B
	 2EzL118tY1ucdfQJaBoC+Yl1C2mnjpDRZLWtohEuIXints0HzCF7fg8IEkS9ByPsCw
	 8OdEMvoCdQPgg==
Date: Mon, 18 Nov 2024 16:12:43 -0800
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
Message-ID: <20241118161243.21dd9bc0@kernel.org>
In-Reply-To: <CAJwJo6YdAEj1GscO-DQ2hAHeS3cvqU_xev3TKbpLSqf-EqiMiQ@mail.gmail.com>
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
	<20241115160816.09df40eb@kernel.org>
	<CAJwJo6ax-Ltpa2xY7J7VxjDkUq_5NJqYx_g+yNn9yfrNHfWeYA@mail.gmail.com>
	<20241115175838.4dec771a@kernel.org>
	<CAJwJo6YdAEj1GscO-DQ2hAHeS3cvqU_xev3TKbpLSqf-EqiMiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Nov 2024 03:52:47 +0000 Dmitry Safonov wrote:
> On Sat, 16 Nov 2024 at 01:58, Jakub Kicinski <kuba@kernel.org> wrote:
> > On Sat, 16 Nov 2024 00:48:17 +0000 Dmitry Safonov wrote:  
> > > Yeah, I'm not sure. I thought of keeping it simple and just marking
> > > the nlmsg "inconsistent". This is arguably a change of meaning for
> > > NLM_F_DUMP_INTR because previously, it meant that the multi-message
> > > dump became inconsistent between recvmsg() calls. And now, it is also
> > > utilized in the "do" version if it raced with the socket setsockopts()
> > > in another thread.  
> >
> > NLM_F_DUMP_INTR is an interesting idea, but exactly as you say NLM_F_DUMP_INTR
> > was a workaround for consistency of the dump as a whole. Single message
> > we can re-generate quite easily in the kernel, so forcing the user to
> > handle INTR and retry seems unnecessarily cruel ;)  
> 
> Kind of agree. But then, it seems to be quite rare. Even on a
> purposely created selftest it fires not each time (maybe I'm not
> skilful enough). Yet somewhat sceptical about a re-try in the kernel:
> the need for it is caused by another thread manipulating keys, so we
> may need another re-try after the first re-try... So, then we would
> have to introduce a limit on retries :D

Wouldn't be the first time ;)
But I'd just retry once with a "very large" buffer.

> Hmm, what do you think about a kind of middle-ground/compromise
> solution: keeping this NLM_F_DUMP_INTR flag and logic, but making it
> hardly ever/never happen by purposely allocating larger skb. I don't
> want to set some value in stone as one day it might become not enough
> for all different socket infos, but maybe just add 4kB more to the
> initial allocation? So, for it to reproduce, another thread would have
> to add 4kB/sizeof(tcp_diag_md5sig) = 4kB/100 ~= 40 MD5 keys on the
> socket between this thread's skb allocation and filling of the info
> array. I'd call it "attempting to be nice to a user, but not at their
> busylooping expense".

The size of the retry buffer should be larger than any valid size.
We can add a warning if calculated size >= 32kB.
If we support an inf number of md5 keys we need to cap it.

Eric is back later this week, perhaps we should wait for his advice.

> > Right, the table based parsing doesn't work well with multi-attr,
> > but other table formats aren't fundamentally better. Or at least
> > I never came up with a good way of solving this. And the multi-attr
> > at least doesn't suffer from the u16 problem.  
> 
> Yeah, also an array of structs that makes it impossible to extend such
> an ABI with new members.
> 
> And with regards to u16, I was thinking of this diff for net-next, but
> was not sure if it's worth it:
> 
> diff --git a/lib/nlattr.c b/lib/nlattr.c
> index be9c576b6e2d..01c5a49ffa34 100644
> --- a/lib/nlattr.c
> +++ b/lib/nlattr.c
> @@ -903,6 +903,9 @@ struct nlattr *__nla_reserve(struct sk_buff *skb,
> int attrtype, int attrlen)
>  {
>   struct nlattr *nla;
> 
> + DEBUG_NET_WARN_ONCE(attrlen >= U16_MAX,
> +     "requested nlattr::nla_len %d >= U16_MAX", attrlen);
> +
>   nla = skb_put(skb, nla_total_size(attrlen));
>   nla->nla_type = attrtype;
>   nla->nla_len = nla_attr_size(attrlen);

I'm slightly worried that this can be triggered already from user
space, but we can try DEBUG_NET_* and see. Here and in nla_nest_end().

