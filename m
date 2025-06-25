Return-Path: <netdev+bounces-201071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAA3AE7F5A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F301189D164
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73349234973;
	Wed, 25 Jun 2025 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA4tne61"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2A31C07C4
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750847553; cv=none; b=HklSr05iZwV8FIh6QD4IQFukYRn0diOlrs23wwpxO707e0AeYst6AHCLIwH/9UPtymvo/H53QEEv0TKrEVtgUo9UNUA92W5eHB6cBOhhWCWbBLeVW3gHuhGPIrayMZP/ch8/xw8RTr1dwZK716os9MnnmlHTr90HBArtFw9sumc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750847553; c=relaxed/simple;
	bh=Oedbmcf9fB/hlEK0LIU83mHtNInB5LkM2W9uVuyque0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEHAfB1Hq5W5zHUxSMPl84/pcz++Z9es3AwIy8zE8BVammI7HsW/uCny/yTCbUqyShGpYGWbGUAhGtErs0ekYbATkTL4X7aqddOONv9KuYIvl7ZIIUCENiAi2eU1JLiW6Sx83SXxnYNivk/rQ8TeUhn5ohxccAGyjD2sN6igkWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RA4tne61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615B1C4CEEA;
	Wed, 25 Jun 2025 10:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750847552;
	bh=Oedbmcf9fB/hlEK0LIU83mHtNInB5LkM2W9uVuyque0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RA4tne612QzOTjmnU0oXlcFF8vMhWduBrvOcRCCxYi4ewJux/87lWeIKWNumwBYwU
	 sFpCO9Lz/5S1tlFzMq1x8Z+dLIESlsA0TXY3LgHxDlhj59Qqj0CAkvUeeVsy9k291h
	 OxNgwoZRO7bzsZoYL1shZrcpdyllQTHySwi2Cm9/MTF1IVImvtXyoWphNJZJFkxL2g
	 JbOIRXQk3vVIc2BH4iYi2iHbxljHAIqMdpSRNlxahBCDFtlumqtMd23E8vGyFJE0gq
	 P9tmQhbX0IdDC5rEgwn/yWXBVB2bTXyOXHo/kyhPs0KO9H2pOW9aP5fND1+S4P+5YB
	 ih3hQOTOqTC1A==
Date: Wed, 25 Jun 2025 12:32:29 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Antoine Tenart <atenart@kernel.org>, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	Menglong Dong <menglong8.dong@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH net] net: ipv4: fix stat increase when udp early demux
 drops the packet
Message-ID: <a2snjvff2xus2fp235cwaz5q7vdbbcyr7xokt6axbahsajn7a6@4b3b24ltf3ec>
References: <20250625090035.261653-1-atenart@kernel.org>
 <CANn89iK07a=NFRddVOmO1mMCFeRx3o2Lwjqakq-MCfXF=M_BhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iK07a=NFRddVOmO1mMCFeRx3o2Lwjqakq-MCfXF=M_BhA@mail.gmail.com>

On Wed, Jun 25, 2025 at 02:43:22AM -0700, Eric Dumazet wrote:
> On Wed, Jun 25, 2025 at 2:00 AM Antoine Tenart <atenart@kernel.org> wrote:
> > @@ -319,8 +319,8 @@ static int ip_rcv_finish_core(struct net *net,
> >                               const struct sk_buff *hint)
> >  {
> >         const struct iphdr *iph = ip_hdr(skb);
> > -       int err, drop_reason;
> >         struct rtable *rt;
> > +       int drop_reason;
> >
> >         if (ip_can_use_hint(skb, iph, hint)) {
> >                 drop_reason = ip_route_use_hint(skb, iph->daddr, iph->saddr,
> > @@ -345,8 +345,8 @@ static int ip_rcv_finish_core(struct net *net,
> >                         break;
> >                 case IPPROTO_UDP:
> >                         if (READ_ONCE(net->ipv4.sysctl_udp_early_demux)) {
> > -                               err = udp_v4_early_demux(skb);
> > -                               if (unlikely(err))
> > +                               drop_reason = udp_v4_early_demux(skb);
> > +                               if (unlikely(drop_reason))
> >                                         goto drop_error;
> 
> 
> This would leave @drop_reason == SKB_NOT_DROPPED_YET here, furtur
> "goto drop;" would be confused.
> 
> if (iph->ihl > 5 && ip_rcv_options(skb, dev))
>      goto drop;    // Oops

Good catch, thanks!

> The following would be easier to review ?
> 
> diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
> index 30a5e9460d006de306b5bac49c92f9b9bf21f2f5..d105df76dd81696d98b3df581934c27af2e0494e
> 100644
> --- a/net/ipv4/ip_input.c
> +++ b/net/ipv4/ip_input.c
> @@ -346,8 +346,10 @@ static int ip_rcv_finish_core(struct net *net,
>                 case IPPROTO_UDP:
>                         if (READ_ONCE(net->ipv4.sysctl_udp_early_demux)) {
>                                 err = udp_v4_early_demux(skb);
> -                               if (unlikely(err))
> +                               if (unlikely(err)) {
> +                                       drop_reason = err; /* temporary fix. */
>                                         goto drop_error;
> +                               }
> 
>                                 /* must reload iph, skb->head might
> have changed */
>                                 iph = ip_hdr(skb);
> 

Or just resetting the drop reason to SKB_DROP_REASON_NOT_SPECIFIED, to
keep it consistent with the rest of the function?

As a follow-up we could remove those and set the reason explicitly
before the drop to avoid such issue later. That makes things easier to
read too.

Thanks,
Antoine

