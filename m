Return-Path: <netdev+bounces-130066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD24987F72
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 09:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551B11C20A83
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 07:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1453170A27;
	Fri, 27 Sep 2024 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="DmGUjfu9"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0471B158557;
	Fri, 27 Sep 2024 07:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727422221; cv=none; b=eNPaNy9F5jzmxkx1TTj/u22uMsdD+8WKksBK6oZ8LYiN++iE3XKrw65DwRpmndIYwl8/EYep0b7zwzo7/sRRYukOWMYqVS1A2cM6DMsAtlijWgQWzML9WzpiNFRBF58jD4UadaLgD8mMBp3NWaiY65DXn2+w64w7B+YmoKRyVrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727422221; c=relaxed/simple;
	bh=X1EbbchWBqe7kbUWUcRB4Udab8NrA9vLhm7bmk0PrAU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vap17U/EgpGLE81X/xpj+kk/FsyXpupURgy55aRcpea6CiVeGv4caKOkdAEaSEqHs9IuwQqov7uO5qW7ew1AU80QW3UFKM44qXCry3q5wXVRulEa/GlG7bNndXzHyj3ZUwn/U7umbilmQAARjFOv876A5fLBCH5YIKJtE/nFoKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=DmGUjfu9; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 81E2E2087B;
	Fri, 27 Sep 2024 09:30:11 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 70YR9yFkRM4s; Fri, 27 Sep 2024 09:30:10 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 8AAF820520;
	Fri, 27 Sep 2024 09:30:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 8AAF820520
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1727422210;
	bh=Y7bDXPx3wgFkMtrWB50i7268p5aSWwld5cDeHJN70vQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=DmGUjfu9XoTS7oIw+WXmoCVkhHu0yVAdG0kzZ/O+q/NHPTxR/YpPCjdoTOnmyWXIx
	 oyr18Wp/ospvb5o3Qc9B+Navo7ljSxyi+btD5A/A3DMow7vlMHSicmJswM5w+ducwP
	 LzZ36qkvEzMytxAdUbiIcgZOsztRp9oM3QpLwL1FvMFosdD8Cc9Op6KoKzIMHhVoB7
	 cphIBQ1Xh6jFunmSAY8eOpj4e+FqgCy8cCLA+fL8lcrXQn1AeUrJqgNCoCCTuqDLiS
	 Jy9tTrHyyvMxfostnOuwoO11pgTOlflpd4WMITcLgLePfQukY9LFE6mO3Sr/rxKkkl
	 8tloe3qZjil1A==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 09:30:10 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 09:30:10 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id E96A23181523; Fri, 27 Sep 2024 09:30:09 +0200 (CEST)
Date: Fri, 27 Sep 2024 09:30:09 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <pabeni@redhat.com>, syzbot
	<syzbot+cc39f136925517aed571@syzkaller.appspotmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <herbert@gondor.apana.org.au>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] UBSAN: shift-out-of-bounds in
 xfrm_selector_match (2)
Message-ID: <ZvZfAQ4IGX/3N/Ne@gauss3.secunet.de>
References: <00000000000088906d0622445beb@google.com>
 <66f33458.050a0220.457fc.001e.GAE@google.com>
 <ZvPvQMDvWRygp4IC@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZvPvQMDvWRygp4IC@hog>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Sep 25, 2024 at 01:08:48PM +0200, Sabrina Dubroca wrote:
> 2024-09-24, 14:51:20 -0700, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> > 
> > HEAD commit:    151ac45348af net: sparx5: Fix invalid timestamps
> > git tree:       net-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=15808a80580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=37c006d80708398d
> > dashboard link: https://syzkaller.appspot.com/bug?extid=cc39f136925517aed571
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122ad2a9980000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1387b107980000
> 
> syzbot managed to create an SA with:
> 
> usersa.sel.family = 0
> usersa.sel.prefixlen_s = 128
> usersa.family = AF_INET
> 
> Because of the AF_UNSPEC selector, verify_newsa_info doesn't put
> limits on prefixlen_{s,d}. But then copy_from_user_state sets
> x->sel.family to usersa.family (AF_INET).
> 
> So I think verify_newsa_info should do the same conversion before
> checking prefixlen:
> 
> 
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index 55f039ec3d59..8d06a37adbd9 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -201,6 +201,7 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
>  {
>  	int err;
>  	u8 sa_dir = attrs[XFRMA_SA_DIR] ? nla_get_u8(attrs[XFRMA_SA_DIR]) : 0;
> +	u16 family = p->sel.family;
>  
>  	err = -EINVAL;
>  	switch (p->family) {
> @@ -221,7 +222,10 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
>  		goto out;
>  	}
>  
> -	switch (p->sel.family) {
> +	if (!family && !(p->flags & XFRM_STATE_AF_UNSPEC))
> +		family = p->family;
> +
> +	switch (family) {
>  	case AF_UNSPEC:
>  		break;
>  
> 
> 
> Steffen, does that make sense?

Yes, it does. Later, in copy_from_user_state() we do

if (!x->sel.family && !(p->flags & XFRM_STATE_AF_UNSPEC))
	x->sel.family = p->family;

anyway.

> Without this, we have prefixlen=128 when we get to addr4_match, which
> does a shift of (32 - prefixlen), so we get
> 
> UBSAN: shift-out-of-bounds in ./include/net/xfrm.h:900:23
> shift exponent -96 is negative
> 
> 
> Maybe a check for prefixlen < 128 would also be useful in the
> XFRM_STATE_AF_UNSPEC case, to avoid the same problems with syzbot
> passing prefixlen=200 for an ipv6 SA. I don't know how
> XFRM_STATE_AF_UNSPEC is used, so I'm not sure what restrictions we can
> put. If we end up with prefixlen = 100 used from ipv4 we'll still have
> the same issues.

I've introduced XFRM_STATE_AF_UNSPEC back in 2008 to make
inter addressfamily tunnels working while maintaining
backwards compatibility to openswan that did not set
the selector family. At least that's what I found in
an E-Mail conversation from back then.

A check for prefixlen <= 128 would make sense in any case.
But not sure if we can restrict that somehow further.

> 
> >  __ip4_datagram_connect+0x96c/0x1260 net/ipv4/datagram.c:49
> >  __ip6_datagram_connect+0x194/0x1230
> >  ip6_datagram_connect net/ipv6/datagram.c:279 [inline]
> >  ip6_datagram_connect_v6_only+0x63/0xa0 net/ipv6/datagram.c:291
> 
> This path also looks a bit dubious. From the reproducer, we have a
> rawv6 socket trying to connect to a v4mapped address, despite having
> ip6_datagram_connect_v6_only as its ->connect.
> 
> pingv6 sockets also use ip6_datagram_connect_v6_only and set
> sk->sk_ipv6only=1 (in net/ipv4/ping.c ping_init_sock), but rawv6 don't
> have this, so __ip6_datagram_connect can end up in
> __ip4_datagram_connect. I guess it would make sense to set it in rawv6
> too. rawv6_bind already rejected v4mapped addresses.
> 
> And then we could add a DEBUG_NET_WARN_ON_ONCE(!ipv6_only_sock(sk)) in
> ip6_datagram_connect_v6_only, or maybe even call ipv6_addr_type to
> reject v4mapped addresses and reject them like the non-AF_INET6 case.

I can't comment on that now, let me have a closer look into it.


