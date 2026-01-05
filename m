Return-Path: <netdev+bounces-246951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E67CF2BF6
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 10:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A153300E422
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 09:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4BE21348;
	Mon,  5 Jan 2026 09:27:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7001A328624;
	Mon,  5 Jan 2026 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767605225; cv=none; b=t1gDyWLaLf5876z5hsyzYEoetmh0XJn/hNExLXIba/M/8ZkCMeHa65pF9S9dM6BEU2MBc/kNCeRXQpoChcodUuibvTuve9D6kWmUaiSzG21e+xT/0mdhnWnKCbLl1NUp6+1RBZikU2t+t5mjFhwBPz0Ot/tCmtF/tWN56L2Ku+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767605225; c=relaxed/simple;
	bh=P4tAo4/WQLYn30agyYI3wvZUykqKF8I7XS9sZMg4JuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/lwlcMrnYIJ5KUX2S1LZquE6+Q3SEOHY9RnCD9WPqcJvEtxSXq0VNzrt/yA/fMnKGqGvYVf7aOhm+S8n1QpgQrB8mlgMyKI/YGqhvrqSXFsUS+usnegDV+UBRLXM1Nr65B+FYwOSvxgTKsmftUP0sF+AvT7TInqjgGHBHs/mi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 5DBFA604E3; Mon, 05 Jan 2026 10:26:58 +0100 (CET)
Date: Mon, 5 Jan 2026 10:26:58 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Mazin Al Haddad <mazin@getstate.dev>, davem@davemloft.net,
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com
Subject: Re: [PATCH] ip6_tunnel: Fix uninit-value in ip6_tnl_xmit
Message-ID: <aVuD4kwMyyJlSxIV@strlen.de>
References: <20241217030751.11226-1-mazin@getstate.dev>
 <CANn89iJeh5wCRpiBBBucmJXRdTb=DbOjXTHtEm1rOpvq=dGgvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJeh5wCRpiBBBucmJXRdTb=DbOjXTHtEm1rOpvq=dGgvQ@mail.gmail.com>

Eric Dumazet <edumazet@google.com> wrote:

Hi Eric

> > When taking the branch with skb_realloc_headroom, pskb_expand_head is
> > called, as such, pointers referencing content within the new skb's header
> > are invalid. Currently, the assignment of hop_limit accesses the now
> > invalid pointer in the network header of this "new" skb. Fix this by
> > moving the logic to assign hop_limit earlier so that the assignment
> > references the original un-resized skb instead.
> 
> Unfortunately this is not fixing anything.
> 
> If the IPv6 header was in the skb head before skb_realloc_headroom()
> and/or pskb_expand_head(),
> it would be copied in the new skb head.
> 
> Note how the repro is sending a packet with vlan tag (88A8 : ETH_P_8021AD)
> 
> endto$packet(r0, &(0x7f0000000180)="a6bea8a120e5f8320c30ce5088a8",
> 0x12, 0x0, &(0x7f0000000140)={0x11, 0x0, r3, 0x1, 0x0, 0x6, @local},
> 0x14)
> 
> Current code, using pskb_inet_may_pull() is not ready yet.
> 
> My patch has been tested by syzbot and I was about to submit it.
> 
> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index 235808cfec705032b545d6f396f8e58f4693e8d8..c4f0383a136cf5f5e6846293078ec8b826c754c9
> 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -910,7 +910,7 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
>         __be16 payload_protocol;
>         int ret;
> 
> -       if (!pskb_inet_may_pull(skb))
> +       if (!skb_vlan_inet_prepare(skb, false))
>                 goto tx_err;
> 
>         if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
> @@ -958,7 +958,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct
> sk_buff *skb,
>         __u32 mtu;
>         int nhoff;
> 
> -       if (!pskb_inet_may_pull(skb))
> +       if (!skb_vlan_inet_prepare(skb, false))
>                 goto tx_err;
> 
>         if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))

Could you please submit this fix?  There appears to be an open
syzbot report (https://syzkaller.appspot.com/bug?extid=6023ea32e206eef7920a)
that would be addressed by this.

Thanks!

