Return-Path: <netdev+bounces-270255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OQSxKIYGv2mcqAMAu9opvQ
	(envelope-from <netdev+bounces-270255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 21:58:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C64B2E740F
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 21:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF10D3017505
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 20:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C47430EF92;
	Sat, 21 Mar 2026 20:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMAs2H1E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101A030DED1
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 20:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774126722; cv=none; b=LHceEG7aYlrmaaBLqmGwf1+x5p9mfuj4IX9GdCnCGv2xKEszGRjiunM74rNe1TccbBK06d6DZLxCI553A4XqX+kgr37R4uVuK2pHsTdl0FgaCKdZwSa0zegImRnmQDuc7GZexFN3KvuJwe29t1zxXI/rUPIfIIxxjqAj0Z2YhsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774126722; c=relaxed/simple;
	bh=ddvJdRi8u2sMfHug0QMTVhEX8HWKCUzQz6+w4wp1whs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SXcV4xUEvS6VOsk6BHLm9uCPf2Oak6HnCCu2u5w45prgF4e73yhGeV/D/uiOupaxi00nqxtwqkwOaRg6Ev313URFYb6FD6fU2Q8X+48IcxiJ30oYErTVxgcN+hNJ1BVM4Gk/LIL8edpWGjE6GAmiZKL86ri2gVw1ds++onCEd2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMAs2H1E; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79a40fb9890so15468887b3.1
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 13:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774126720; x=1774731520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uE6W2qhWFKGNud0bdraZVKnHfaVSheGs9LAWNbVGkWg=;
        b=BMAs2H1EeraC3fjawDVTPEcgLK3K2HHmP9/nZ8JKyekeoS97sgGLxPHIB4SJOutZg7
         OnMVbvemfYpRncr7sMdfq/f8r2gaGNyvgp9YTuABZQiGR6CvRLTaEhuLNvgiER3voNpa
         gmgmUrcnma1cndgggY2686D6N4DXqv17jv6KvLH5Ts7+qewYMPGB9wiiuZDY5GcKGA06
         bYt7wPlslHmelNxILUSH7GvpIF5pGW2YDqp9DJSnkkQuBFORXPvXGgTN17BEatVoVZuh
         ZFExjH98br0x9FYmGQwSk83UZdW1ze8qJXsZpxTNItS1cSLJfjx+PPkFgt4eBFTqLJON
         BwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774126720; x=1774731520;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uE6W2qhWFKGNud0bdraZVKnHfaVSheGs9LAWNbVGkWg=;
        b=GBDFMO0LRUtRNcS6+elmw9sT4cl9CcqJxC7Fxq6vsq31Y0b0zWMCKs0qgyEchCqqdW
         FoiPtqT6NdA70dXhmkP/zv9eeAI4M1hU4DkVe57MWKh8E/fXBUm/rbGDw/Jd31e+q80O
         Y2ilYEBd4VVAvUIgPM6xEBujs3KYCS6cv4+rvDJk6FHUZ6TXyCZ1JXEjSltfxYoMNLwe
         07R/cq40c8qD2+71vXkGJQUEo2U+k4jfTWsByPAQ+r5NXHs5mPzl7dvdEpuAEcDydAaS
         6cl2kMgJhDyIOOo5BZsL0JDwG1hadJGCgzQAQE6YnKMKgpyKbTz2nFRHzzvhBoo8pYUW
         zFOw==
X-Forwarded-Encrypted: i=1; AJvYcCVSfYonTgVeFMOD9WKpE0Pp3FpcgaHCFcZcYL8Q2pw76xbp+Wgy42OrrwNGUNnp+bXAIuXZ/RY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysl639ET3h99naIsbEhgCKKJvAjkG23ybdc2YAa9DGxrfs6GIJ
	a5x/NpssKN4j+fZoCIFirO60bTslvlGzEMsPHENnJnagIjFGOghY4qyf
X-Gm-Gg: ATEYQzz4rt9chvU6jv0IZnjZc3c7N+iQviygYMultVVaVrMwi264njC9rHsMGAj+Liw
	ihnm/izVD2Uc6pvjeT19OKwE/yf5MatO7iIbK/Lel87ZKV5sTMojThNU+V3l5OzfjI6rxKwQbRJ
	beVtio2vxAcNHsIDIZyXJf+DWhWhtzkHV+vxyCkvDeVj0TkD0Ld2COYLeri52Cc8ZoOHo+tpUhY
	9vHj3Uy6P5ITo4R0JbyDCu8dO+GcfN1sZ71gqQSBSQyj91e25f56/HAqXuwDTEbKf08lHRmyN6s
	jF3biElK8fcryy//LHuGcEhIYPy1KOkQ+CKPkl3cEgSlWUNkPYtUpYL/AuyGqHY9hzniGWvJc7J
	z/ImDvXMu3HWByrwpck1vsy854CfP8jhUYu2WzuLdl6XCsJesNRfzUBkYkFjkVtHtG71jSoEDnK
	yLjJ4xMwJQbfB7iZx/wCFYsKXqGsCCmzNuu8kLm9JddfOny8GxLN9xFDHabCunow5u2XQiZwICt
	M8R
X-Received: by 2002:a05:690c:e68a:b0:79a:4419:71a7 with SMTP id 00721157ae682-79a90bbc964mr49850917b3.30.1774126720099;
        Sat, 21 Mar 2026 13:58:40 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79a903f4190sm34990727b3.15.2026.03.21.13.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 13:58:38 -0700 (PDT)
Date: Sat, 21 Mar 2026 16:58:38 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Scars <yss2813483011xxl@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: edumazet@google.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 netdev@vger.kernel.org, 
 horms@kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com, 
 syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
Message-ID: <willemdebruijn.kernel.5c56580eb49@gmail.com>
In-Reply-To: <CAMa1Pe4sxiyekrMKV6w5E3SJ1sk1ZzJs7wdepx6oLKGpRsi35A@mail.gmail.com>
References: <willemdebruijn.kernel.c0bb5d182993@gmail.com>
 <20260320141459.9691-1-yss2813483011xxl@gmail.com>
 <willemdebruijn.kernel.2018fae77325e@gmail.com>
 <willemdebruijn.kernel.2497131610e6a@gmail.com>
 <CAMa1Pe4sxiyekrMKV6w5E3SJ1sk1ZzJs7wdepx6oLKGpRsi35A@mail.gmail.com>
Subject: Re: [PATCH net v5] net: use skb_header_pointer() only for DODGY TCPv4
 GSO skbs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-270255-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1543a7d954d9c6d00407];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 0C64B2E740F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Scars wrote:
> I instrumented packet_snd(), __virtio_net_hdr_to_skb(), and
> gso_features_check() while running the C repro.
> =

> In repeated runs, for the same skb, I consistently observed:
> - __virtio_net_hdr_to_skb() (NEEDS_CSUM path):
> skb_transport_offset=3D88, thlen=3D20, so p_off=3D108;
> pskb_may_pull(..., 108) =


All the above matches the skb_dump from my previous post.

> succeeds (headlen=3D172).

My output shows headlen 108. Here we start to diverge.

> - gso_features_check() on the resulting DODGY TCPv4 skb uses
> nhoff=3Dskb_network_offset(skb)=3D172.

And I see headroom of 4, so mac at 4, skb->network_header at 80 and
skb->transport_header at 92. No 172.

That part is key. My measurement is in packet_snd right after
virtio_net_hdr_to_skb. Where do you see this, and can you perhaps get
an skb_dump (NOT full_skb, as these are large, just the header
metadata).

I don't mean to delay the fix. Just, in general, a preferable fix for
these weird user injected packets is to detect and drop as close to
kerne entry as possible, meaning in virtio_net_hdr_to_skb, rather than
have to make the main datapath robust against crazy packets -- which
comes with branches and other overhead on the legitimate hot path.


> =

> So the pull checks in __virtio_net_hdr_to_skb() guarantee access up to
> p_off, but do not guarantee that the
> header at nhoff is safely linear for direct iph->frag_off dereference.
> =

> In this run, nhoff=3D=3Dheadlen on the observed packets (IPv4 header
> starts at the linear tail boundary). Using
> skb_header_pointer() in the DODGY branch avoids this gap.
> =

> I did not hit a KMSAN report in this rerun (instrumented/patched
> kernel), but the offset mismatch above was
> reproducible.
> =

> Willem de Bruijn <willemdebruijn.kernel@gmail.com> =E4=BA=8E2026=E5=B9=B4=
3=E6=9C=8821=E6=97=A5=E5=91=A8=E5=85=AD 09:36=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Willem de Bruijn wrote:
> > > Guoyu Su wrote:
> > > > Syzbot reported a KMSAN uninit-value warning in gso_features_chec=
k()
> > > > called from netif_skb_features() [1].
> > > >
> > > > The current direct skb->len check is not sufficient for SKB_GSO_D=
ODGY
> > > > packets. In the AF_PACKET/PACKET_VNET_HDR path, packet_snd() can =
build
> > > > a DODGY GSO skb whose total length is large enough, while the IPv=
4
> > > > header is not fully available as initialized linear data for a di=
rect
> > > > iph->frag_off access.
> > >
> > > The fix looks fine, but the AI review of an earlier revision brings=
 up
> > > a good point: __virtio_net_hdr_to_skb calls pskb_may_pull in all pa=
ths
> > > to ensure the network header is fully in skb linear. What kind of p=
acket
> > > is this that managed to escape those checks?
> >
> > The packets I got out of the C repro just after virtio_net_hdr_to_skb=

> > look as below.
> >
> > [   76.539562] vnet_hdr: flags=3D0x75 gso_type=3D0x1 hlen=3D0x6a gso_=
sz=3D0x416d cstart=3D0x58
> > [   76.539755] skb len=3D56584 data_len=3D56476 headroom=3D4 headlen=3D=
108 tailroom=3D0
> > [   76.539755] end-tail=3D208 mac=3D(4,76) mac_len=3D0 net=3D(80,12) =
trans=3D92
> > [   76.539755] shinfo(txflags=3D0 nr_frags=3D3 gso(size=3D16749 type=3D=
3 segs=3D0))
> > [   76.539755] csum(0x10005c start=3D92 offset=3D16 ip_summed=3D3 com=
plete_sw=3D0 valid=3D0 level=3D0)
> > [   76.539755] hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D0 iif=
=3D0
> > [   76.539755] priority=3D0x0 mark=3D0x0 alloc_cpu=3D0 vlan_all=3D0x0=

> > [   76.539755] encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=3D=
0, trans=3D0)
> > [   76.540713] dev name=3Dip6gretap0 feat=3D0x0000000e401d4869
> > [   76.540843] sk family=3D17 type=3D3 proto=3D0
> >
> > Clearly fishy. They do have VIRTIO_NET_HDR_F_NEEDS_CSUM set, so we
> > know which branch they take.
> >
> >         skb_reset_mac_header(skb);
> >
> >         if (hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
> >                 u32 start =3D __virtio16_to_cpu(little_endian, hdr->c=
sum_start);
> >                 u32 off =3D __virtio16_to_cpu(little_endian, hdr->csu=
m_offset);
> >                 u32 needed =3D start + max_t(u32, thlen, off + sizeof=
(__sum16));
> >
> > // start =3D=3D 88
> > // needed =3D=3D 88 + 18 =3D=3D 106
> >
> >                 if (!pskb_may_pull(skb, needed))
> >                         return -EINVAL;
> >
> >                 if (!skb_partial_csum_set(skb, start, off))
> >                         return -EINVAL;
> >                 if (skb_transport_offset(skb) < nh_min_len)
> >                         return -EINVAL;
> >
> >                 nh_min_len =3D skb_transport_offset(skb);
> >
> > // nh_min_len =3D=3D 88
> >
> >                 p_off =3D nh_min_len + thlen;
> >
> > // p_off =3D=3D 108
> >
> >                 if (!pskb_may_pull(skb, p_off))
> >                         return -EINVAL;
> >
> > // headlen =3D=3D 108
> >
> > At the end of this headlen =3D=3D 108, so all of iphdr should be in
> > linear.
> >
> > Since the syz repro requires repeat it is possible that I simply did
> > not capture the right packet, but I don't see the C program vary the
> > packet contents.



