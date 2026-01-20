Return-Path: <netdev+bounces-251333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5E2D3BC3E
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 01:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2929C3040A60
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 00:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A04199FB0;
	Tue, 20 Jan 2026 00:01:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB2A149C6F
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 00:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768867270; cv=none; b=bE3fpDMQarggMoImW2eGzk++xvaWddj4WuHh5+sTbwp4mMFTExQHLLCz+vyH9TZ7DJ+zvUQIbD1uRY1JtDXEZklY1PB4W2lGBvgmde4/wMv0+RUGFVgvVn+kMF27r610v92v7l8vHfA/CZmcAC+N8DJvo+9sqh+V/ZpSagoWJqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768867270; c=relaxed/simple;
	bh=eARXrDalK2XMNY9fhPqlkzJ8SDghSSdVP0qkC98TgUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsVjMFMHKEZh8DMG3qfOLKnL7Lsr+FQQgNN3gvpvucofyfaTTS274qWRqj/Bw7/6nUctv8fgYuT8+YVSDztZYRHZZqPg51CLEzExp5+jbpYho4H1e4lUVWVB5KhhssT/uRwSGLJCZCzS8SmFAq/Kjq35IWI6irx03oAwU1sdu7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 48E2E6033F; Tue, 20 Jan 2026 01:01:06 +0100 (CET)
Date: Tue, 20 Jan 2026 01:01:01 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com,
	davem@davemloft.net, Mazin Al Haddad <mazin@getstate.dev>
Subject: Re: [PATCH net v3] ip6_gre: use skb_vlan_inet_prepare() instead of
 pskb_inet_may_pull()
Message-ID: <aW7FvS8wE2zNDDZ2@strlen.de>
References: <20260119112512.28196-1-fw@strlen.de>
 <20260119090629.20d202e8@kernel.org>
 <CANn89iJOz_PQ_N4e=FS+toEDfLw-Ei9SwV6LU9Jmsvhtyxb7SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJOz_PQ_N4e=FS+toEDfLw-Ei9SwV6LU9Jmsvhtyxb7SQ@mail.gmail.com>

Eric Dumazet <edumazet@google.com> wrote:
> On Mon, Jan 19, 2026 at 6:06 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Mon, 19 Jan 2026 12:24:57 +0100 Florian Westphal wrote:
> > > From: Eric Dumazet <edumazet@google.com>
> > >
> > > I added skb_vlan_inet_prepare() helper in the cited commit, hinting
> > > that we would need to use it more broadly.
> >
> > I _think_ this makes GRE forwarding tests a bit unhappy:
> >
> > https://netdev.bots.linux.dev/contest.html?branch=net-next-2026-01-19--12-00&executor=vmksft-forwarding&pw-n=0&pass=0
> > --
> 
> I was unsure about ip6erspan_tunnel_xmit() change, I think I started
> full tests days ago but probably was distracted.
> 
> I had :
> 
> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index d19d86ed43766bbc8ec052113be02ab231a5272c..9e214c355e6ce15fa828866ae20fa8fe321b4bf7
> 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -881,7 +881,7 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
>         __be16 payload_protocol;
>         int ret;
> 
> -       if (!pskb_inet_may_pull(skb))
> +       if (skb_vlan_inet_prepare(skb, true))
>                 goto tx_err;

It has to be either true or false depending on test case 8-/

gre_gso.sh needs this to be set to true, skbs don't have a mac
header: with "false": skb nhoff gets munged from 0 to 14.

But in mirror_gre.sh test case, skbs do have a mac header:
"true" munges nh offset from 14 to 0 and test fails.

