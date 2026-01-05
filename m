Return-Path: <netdev+bounces-246952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DB6CF2CAD
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 10:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C40243034400
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 09:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F54030E83B;
	Mon,  5 Jan 2026 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EOhtbFA1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5148432F745
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767605725; cv=none; b=hPc8pcghHUjBgfP4j+rGTExZXAMHr3QD9N4ABSucVZyIcV4J+5vmOHAcaOlB5qFfD7LKfFk6hQWgJ78qAO6VABKDMshUBeWXHQvZQz/8YHPsD+F8m8+IRAcEewZqOEAp3BLxMs++0D7KYWFlcFRQuJ/txt0UebvbJt8B6Z0pkA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767605725; c=relaxed/simple;
	bh=UKU6Zworj3V5wHU66nzg1AZfrM19ZaKUmijKceUqaig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIBNOTA8dFoy4k7K3/PFmRUgdHcxS+bJwOi19nrJSaGofprgGsXJNqZEyA+Zws6PTYMnzCRCoe2kHuMRANT5w27Lsbz2IyEiO4Vqjv5vgcsG4lJoe6BUIwjYGdOG8GqmaDa9l4S0rfU4awJ7GGET/Ld/iSDGj9iAcSmvKocCCww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EOhtbFA1; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c24f867b75so640247685a.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 01:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767605719; x=1768210519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVyYrZ9t2n6wY+F8Pza8nnxeo3jNz08JtRtWSWTr1zw=;
        b=EOhtbFA1fh+fcHYHKK1pfr1L1jea4TsBZwIiFwcU4flPAWJrBAim7HpnOtks6RD/yh
         gPch9ZodLX0wfPGtVFoHyY99t5BRMnPzvxB3uLdvsup/VYFoRpeWI+1B2H3BUuccdAXU
         t9+HyWg4z1meSBjy/vdQQZl5GUqZWvMN1HLpZduNTpnjjjaKlyQoxMcNvaky5HA5rLT9
         wZYtu4RCrk+hsLSuTYajdqcqmSgQ26hRoIn9y2XaognWTR7L+BkD+6ik9keW2A9tOu+A
         ApQkW9DgN0xvRblNpd4sWz9uZxVFbyf61gSyAZP0OLELFYo5SGc5JZL3wAHCgnFUStvp
         Uyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767605719; x=1768210519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mVyYrZ9t2n6wY+F8Pza8nnxeo3jNz08JtRtWSWTr1zw=;
        b=bvilI8VnnK+HLdRFDjCHnJFaCbvKebLeFOwWeRyjlHcHJk0Ug9enURV7YQgMYHdF6T
         F1ztD7IBre6BuGnuI9YrP/1POtMSH1YNN/xaKmaoNWVexB4r2sUjxAQXVj0Bw9lf5i3f
         n47P52Po9kx8Vd7nVUfVWJDibURWalZaShljTEnVKbw+xg6wIb4EzPEdjJdIUUff7xSb
         LS28a20+S9Zb9ZGH3hVarYMunCn19rSRKbaSmx5CvEZJzx8Fk9jLov3Rl6jMqLfJ7BzA
         zgkIteXEbH5Cvg7eMjaGaJRDCHM6x+Wr0OVgwtyiBl41LsVsSdeQ/CalMl/qCXSsoC9S
         lySg==
X-Forwarded-Encrypted: i=1; AJvYcCVOozyaJuFY32LBDLyR06bnDkJfpSTULx+hFLE4zKOPCQKAVd24FtyCB4UXg8pblTENTpQNTaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuuIt1n/MTIcT4Mi7hmqQx2YImrFbW2spted6qzJboS0ySpBW2
	kVHTvdW3Lzsprs5nnmhEUHSwbvlNRDffZKYLOyvKODmVGVZG0YNEv89FAEFVhT9wYdk+hoHhMjP
	EQ6Ja9WoFlb4GSSGCO80KKNIVO4vmHn8zu2kYkivw
X-Gm-Gg: AY/fxX5F8zolNamBpx5iblVAasq6JMhWgDkI4Y7HRDzkKzA1QdKAZpfiQCXWl7SZsj6
	2pVRnmoQPJA7zu5F6CBJpzs3yYsrEU+AL6NQsUASdcWuNePB3a92K9lEzTRpaBJuE857EE/gA61
	FqJIXKnP9GtKgUk5v97oXtnB9/5fPDbyAV3vvH6+sEyGxW6L4zhv8kO6U+ESPYkfh0s4qCRJHVq
	ijyVKGoCL1T5VuVcLlR+gbWaoZMfSHGT4WhRgT8E1y9bK5EK8xfOBOT0OWZzYzVghnLabMja/mU
	/agc64o=
X-Google-Smtp-Source: AGHT+IFh2Pb1Z/EyP3zQaETIo9JGJKHNYL68DN+oLKH16jzI1ROB2+EKmUySd50GvPeNCo6w3SvdOOVknHIlW9/AVoY=
X-Received: by 2002:a05:622a:64b:b0:4ee:4128:bec1 with SMTP id
 d75a77b69052e-4f4abcd0634mr775694481cf.1.1767605718476; Mon, 05 Jan 2026
 01:35:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217030751.11226-1-mazin@getstate.dev> <CANn89iJeh5wCRpiBBBucmJXRdTb=DbOjXTHtEm1rOpvq=dGgvQ@mail.gmail.com>
 <aVuD4kwMyyJlSxIV@strlen.de>
In-Reply-To: <aVuD4kwMyyJlSxIV@strlen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 5 Jan 2026 10:35:06 +0100
X-Gm-Features: AQt7F2qC0FON8KECIQ8tDLoX-JINtBRdhgOILQQIyiIr_kdfSqHMMe1M60hSXe8
Message-ID: <CANn89iJfAq5f3++3_yYpTtL0LPXXF4b1LOFH=6ZGwA5k7S5v6w@mail.gmail.com>
Subject: Re: [PATCH] ip6_tunnel: Fix uninit-value in ip6_tnl_xmit
To: Florian Westphal <fw@strlen.de>
Cc: Mazin Al Haddad <mazin@getstate.dev>, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 10:26=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Eric Dumazet <edumazet@google.com> wrote:
>
> Hi Eric
>
> > > When taking the branch with skb_realloc_headroom, pskb_expand_head is
> > > called, as such, pointers referencing content within the new skb's he=
ader
> > > are invalid. Currently, the assignment of hop_limit accesses the now
> > > invalid pointer in the network header of this "new" skb. Fix this by
> > > moving the logic to assign hop_limit earlier so that the assignment
> > > references the original un-resized skb instead.
> >
> > Unfortunately this is not fixing anything.
> >
> > If the IPv6 header was in the skb head before skb_realloc_headroom()
> > and/or pskb_expand_head(),
> > it would be copied in the new skb head.
> >
> > Note how the repro is sending a packet with vlan tag (88A8 : ETH_P_8021=
AD)
> >
> > endto$packet(r0, &(0x7f0000000180)=3D"a6bea8a120e5f8320c30ce5088a8",
> > 0x12, 0x0, &(0x7f0000000140)=3D{0x11, 0x0, r3, 0x1, 0x0, 0x6, @local},
> > 0x14)
> >
> > Current code, using pskb_inet_may_pull() is not ready yet.
> >
> > My patch has been tested by syzbot and I was about to submit it.
> >
> > diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> > index 235808cfec705032b545d6f396f8e58f4693e8d8..c4f0383a136cf5f5e684629=
3078ec8b826c754c9
> > 100644
> > --- a/net/ipv6/ip6_gre.c
> > +++ b/net/ipv6/ip6_gre.c
> > @@ -910,7 +910,7 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buf=
f *skb,
> >         __be16 payload_protocol;
> >         int ret;
> >
> > -       if (!pskb_inet_may_pull(skb))
> > +       if (!skb_vlan_inet_prepare(skb, false))
> >                 goto tx_err;
> >
> >         if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
> > @@ -958,7 +958,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct
> > sk_buff *skb,
> >         __u32 mtu;
> >         int nhoff;
> >
> > -       if (!pskb_inet_may_pull(skb))
> > +       if (!skb_vlan_inet_prepare(skb, false))
> >                 goto tx_err;
> >
> >         if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
>
> Could you please submit this fix?  There appears to be an open
> syzbot report (https://syzkaller.appspot.com/bug?extid=3D6023ea32e206eef7=
920a)
> that would be addressed by this.
>
> Thanks!

Yes, I am back to work and was looking at a similar syzbot issue.

