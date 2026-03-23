Return-Path: <netdev+bounces-270353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEHMN2a1wGkQKQQAu9opvQ
	(envelope-from <netdev+bounces-270353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 04:37:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB3E2EC3E3
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 04:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF88A30071D7
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 03:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD09296BBC;
	Mon, 23 Mar 2026 03:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAfgWmOX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5153224D6
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 03:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774237024; cv=none; b=nz8FPogiklOFqKGzZxIfR807n4IjxWzIVUkOLBjTcrEazLJMBI9nF2UJ5dm+P20kJy2h4M1d4KCMhItMty102qpkLNa5NUVStSRGsoN1EseBY8sgBM1uYjvR1iQtugrGYLw/wbXcHm5YcGDVN3QXaiHdoWRhFMbdZg3PrCxWGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774237024; c=relaxed/simple;
	bh=zO9D8pqZBsCFQ5i6vo6sPdMe/Qy+sTwFfmT9XCD+BT8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FWS1j5oay8gCyV3uJ4WPKYIkALYf3XAdC2cEFBn443q1HlgPalhF0XfaMhwvcI8S0f+UcDUpEtQC8ORGfjY85GgCJa+4xj5cLlnU+RwIjWP13OikqcmcwUJ/Ev+phryCOpudHUzSJMSIVVN/XDmKHvdh0RtzqedvEOBHWs5O3qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAfgWmOX; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64ad019bbd4so2321308d50.0
        for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 20:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774237021; x=1774841821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWUP/fn4IXtSz7TFgWsVYrJXOzIvfTRyAiJyeBjUpqs=;
        b=EAfgWmOXW4lSnKfZwUWdFj70nma6LaLRHFOu6lLn3X88PIBxW6XlEmym+dttvPNnDZ
         FIFRCFsLdWC31gPjhaZcfqQ43MR0HC3nteodBRZj/NPe+gg2dkdEayVpzTF368QzOsYe
         zWjRlhDXb+2I6Ei7+ZkGg9brjht8Pdhrewj1LdjdE4Qbg7Cj2hHkJIgWXwo817m6P0Tv
         erqF0iyqzB50FfzcyPx+E8RUG/CDwHXFCqa8VlSvFF2okF1y1DiXeIapogPiO7Ot0rvo
         /ysFTnYw59lTLsotF9L5aO1mQMgTGh3Cm9i618LEr6l9Zk29Rt+fzQU6R/vCnbFBbDgq
         cU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774237021; x=1774841821;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sWUP/fn4IXtSz7TFgWsVYrJXOzIvfTRyAiJyeBjUpqs=;
        b=Hr4A4MASlBfmWY6XNPhOrkwgWUUtqGAZUhGRJ3FcSDD/r14t1DcNLC7WWKln5Dql6v
         MNCpYle4DKtK/Tkqpui5JjkUkrQ6LAeDgG7Af+vQUdpOW7GW43H10V777ZyhySqqmFgb
         i1TB95e+cX9OzlgBK5jD+gR0/8tggYlWo819OwdP5uIU8275TgR9cwbSJgEy62icXkZV
         dPc3NbQIhZN83Q81428IywOKMyCIKgg1gDFuFuP0PDf58vMrV+I7uQ4H8moT4yvRqdBA
         Vol3LFMYe6QlWqV9ph7OJM1YOiny8v9UiGK4nD6OiQ2gJ36cm25yPMAoM/6B6Lsadq8b
         dqYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMRcAXydT7dxs9B++A8C64xMBq543UQ6EixRKn/Cz4Yztg9b67CXUkSOtrmzV8yMVUZ2d8LP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNN4F+7epygeJQjx7NehuquAlwKy5MeHvtBdneARk32nlasEt/
	8At3xEvnFMXEqgY2d4ovPT7XUydG8EHFJbiPGN7/XqZ/mKnzKBX3zZ35
X-Gm-Gg: ATEYQzwUOKnxdN6FeiHSknkutPX2ouegUR87IlZwC9Qw/pttD9VtkY9EUf70omV2d7Z
	tWWGDA0BQ0e+BFgLV+SPGlFNGON2SZw5p8FUG/lbYYm4qIgo7+Ebx2t/7pcvmWPU9nCTJ840Eqe
	2oz69o7RCcmoQ5Hry8SFAPW+xYA5eA0ImedkNvDds4/t8eaa5DJKBck05iDLwuXrB0Jl0WshZBY
	rPMD/6mYgNz6DCEZVw0sAySnRNDaUD35aSe16yZ93XLAnxV5Lvy0PoAXDJTuLcf5ZpPFDLxttvb
	v7XmHZA3FFtAlO/V/uzTvaawd/csqrUS8jfGq+p4J17yfbuY0mvOOJV9CLDpp/fnyFP2abuMzRe
	gNyJ/BuFFdMuD2hXy4ikfZA4KR1ALAatiODQcSfaaEHsQhHXbtJmvBf2jVBRkddkKy9PKjI2kdj
	qhBncQyBK4EOhz+W8XfL2wr1LTIf403Gp0O+rPjCHI/M+hyVv9gSg2getB22caL2arfgtGc1/aW
	vJX
X-Received: by 2002:a53:b466:0:b0:64a:d6b4:9489 with SMTP id 956f58d0204a3-64eaa69eecdmr8174480d50.4.1774237020615;
        Sun, 22 Mar 2026 20:37:00 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64eabe7f88dsm5626846d50.13.2026.03.22.20.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 20:36:59 -0700 (PDT)
Date: Sun, 22 Mar 2026 23:36:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Guoyu Su <yss2813483011xxl@gmail.com>, 
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
Message-ID: <willemdebruijn.kernel.35a7766bac9d6@gmail.com>
In-Reply-To: <CAMa1Pe5XGeyk4rf7rX+4FjwPzUhxdKEw5Qsi2GwkeOMr6fw6Jg@mail.gmail.com>
References: <willemdebruijn.kernel.c0bb5d182993@gmail.com>
 <20260320141459.9691-1-yss2813483011xxl@gmail.com>
 <willemdebruijn.kernel.2018fae77325e@gmail.com>
 <willemdebruijn.kernel.2497131610e6a@gmail.com>
 <CAMa1Pe4sxiyekrMKV6w5E3SJ1sk1ZzJs7wdepx6oLKGpRsi35A@mail.gmail.com>
 <willemdebruijn.kernel.5c56580eb49@gmail.com>
 <CAMa1Pe5XGeyk4rf7rX+4FjwPzUhxdKEw5Qsi2GwkeOMr6fw6Jg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270353-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1543a7d954d9c6d00407];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BB3E2EC3E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Guoyu Su wrote:
> Thanks Willem, this is a good point.
> =

> I reran with instrumentation at two exact points:
> 1) packet_snd(), immediately after virtio_net_hdr_to_skb() returns
>    (net/packet/af_packet.c)
> 2) gso_features_check(), in the SKB_GSO_DODGY branch before frag_off ac=
cess
>    (net/core/dev.c)
> =

> For the same skb, I consistently see (first 20 dumps):
> - pkt_after_vnet:
>   skb=3D... len=3D56584 headlen=3D172 data_len=3D56412 netoff=3D172 tra=
nsoff=3D88
> gso_type=3D0x3
>   skb_dump: headroom=3D4, mac=3D(4,172), trans=3D92
> - gso_dodgy:
>   skb=3D... nhoff=3D172 headlen=3D172 netoff=3D172 transoff=3D88
> =

> So in this run, coverage up to p_off on the transport-side does not imp=
ly
> safe direct access at nhoff on the network-side (nhoff/headlen are
> both 172 here).

Perhaps you're running a different repro from the one I used. Which is
the C repro from the run at commit ca4ee40bf13d.

I see that the virtio_net_hdr has hdr_len 106 and csum_start 88. Those
are fine. Same for your repro?

The question is how skb->network_header can be greater than
skb->transport_header right after virtio_net_hdr_to_skb. And whether
this can be a sanity test to drop clearly malformed packets.

E.g.,

	@@ -105,8 +108,12 @@ static inline int __virtio_net_hdr_to_skb(struct sk=
_buff *skb,
				return -EINVAL;
			if (skb_transport_offset(skb) < nh_min_len)
				return -EINVAL;
	+               if (skb_transport_offset(skb) < skb_network_offset(skb) =
+ nh_min_len)
	+                       return -EINVAL;


As far as I can see network_header is set entirely in packet_snd, not
updated in virtio_net_hdr_to_skb in this path.

It seems that hard_header_len for this device is 76. That is part of
the answer. It is an ip6gretap device, so this is the encap hlen.

> I agree that validating/dropping malformed packets as early as possible=
 in
> virtio_net_hdr_to_skb() would be preferable if we can make that check p=
recise.
> This patch addresses the observed safety gap at gso_features_check() fo=
r DODGY
> packets in the current path.
> =

> If helpful, I can share more skb_dump snippets / full serial log.

Friendly reminder to not top post

https://docs.kernel.org/process/submitting-patches.html#use-trimmed-inter=
leaved-replies-in-email-discussions

> Willem de Bruijn <willemdebruijn.kernel@gmail.com> =E4=BA=8E2026=E5=B9=B4=
3=E6=9C=8822=E6=97=A5=E5=91=A8=E6=97=A5 04:58=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Scars wrote:
> > > I instrumented packet_snd(), __virtio_net_hdr_to_skb(), and
> > > gso_features_check() while running the C repro.
> > >
> > > In repeated runs, for the same skb, I consistently observed:
> > > - __virtio_net_hdr_to_skb() (NEEDS_CSUM path):
> > > skb_transport_offset=3D88, thlen=3D20, so p_off=3D108;
> > > pskb_may_pull(..., 108)
> >
> > All the above matches the skb_dump from my previous post.
> >
> > > succeeds (headlen=3D172).
> >
> > My output shows headlen 108. Here we start to diverge.
> >
> > > - gso_features_check() on the resulting DODGY TCPv4 skb uses
> > > nhoff=3Dskb_network_offset(skb)=3D172.
> >
> > And I see headroom of 4, so mac at 4, skb->network_header at 80 and
> > skb->transport_header at 92. No 172.
> >
> > That part is key. My measurement is in packet_snd right after
> > virtio_net_hdr_to_skb. Where do you see this, and can you perhaps get=

> > an skb_dump (NOT full_skb, as these are large, just the header
> > metadata).
> >
> > I don't mean to delay the fix. Just, in general, a preferable fix for=

> > these weird user injected packets is to detect and drop as close to
> > kerne entry as possible, meaning in virtio_net_hdr_to_skb, rather tha=
n
> > have to make the main datapath robust against crazy packets -- which
> > comes with branches and other overhead on the legitimate hot path.
> >
> >
> > >
> > > So the pull checks in __virtio_net_hdr_to_skb() guarantee access up=
 to
> > > p_off, but do not guarantee that the
> > > header at nhoff is safely linear for direct iph->frag_off dereferen=
ce.
> > >
> > > In this run, nhoff=3D=3Dheadlen on the observed packets (IPv4 heade=
r
> > > starts at the linear tail boundary). Using
> > > skb_header_pointer() in the DODGY branch avoids this gap.
> > >
> > > I did not hit a KMSAN report in this rerun (instrumented/patched
> > > kernel), but the offset mismatch above was
> > > reproducible.
> > >
> > > Willem de Bruijn <willemdebruijn.kernel@gmail.com> =E4=BA=8E2026=E5=
=B9=B43=E6=9C=8821=E6=97=A5=E5=91=A8=E5=85=AD 09:36=E5=86=99=E9=81=93=EF=BC=
=9A
> > > >
> > > > Willem de Bruijn wrote:
> > > > > Guoyu Su wrote:
> > > > > > Syzbot reported a KMSAN uninit-value warning in gso_features_=
check()
> > > > > > called from netif_skb_features() [1].
> > > > > >
> > > > > > The current direct skb->len check is not sufficient for SKB_G=
SO_DODGY
> > > > > > packets. In the AF_PACKET/PACKET_VNET_HDR path, packet_snd() =
can build
> > > > > > a DODGY GSO skb whose total length is large enough, while the=
 IPv4
> > > > > > header is not fully available as initialized linear data for =
a direct
> > > > > > iph->frag_off access.
> > > > >
> > > > > The fix looks fine, but the AI review of an earlier revision br=
ings up
> > > > > a good point: __virtio_net_hdr_to_skb calls pskb_may_pull in al=
l paths
> > > > > to ensure the network header is fully in skb linear. What kind =
of packet
> > > > > is this that managed to escape those checks?
> > > >
> > > > The packets I got out of the C repro just after virtio_net_hdr_to=
_skb
> > > > look as below.
> > > >
> > > > [   76.539562] vnet_hdr: flags=3D0x75 gso_type=3D0x1 hlen=3D0x6a =
gso_sz=3D0x416d cstart=3D0x58
> > > > [   76.539755] skb len=3D56584 data_len=3D56476 headroom=3D4 head=
len=3D108 tailroom=3D0
> > > > [   76.539755] end-tail=3D208 mac=3D(4,76) mac_len=3D0 net=3D(80,=
12) trans=3D92
> > > > [   76.539755] shinfo(txflags=3D0 nr_frags=3D3 gso(size=3D16749 t=
ype=3D3 segs=3D0))
> > > > [   76.539755] csum(0x10005c start=3D92 offset=3D16 ip_summed=3D3=
 complete_sw=3D0 valid=3D0 level=3D0)
> > > > [   76.539755] hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D0=
 iif=3D0
> > > > [   76.539755] priority=3D0x0 mark=3D0x0 alloc_cpu=3D0 vlan_all=3D=
0x0
> > > > [   76.539755] encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, n=
et=3D0, trans=3D0)
> > > > [   76.540713] dev name=3Dip6gretap0 feat=3D0x0000000e401d4869
> > > > [   76.540843] sk family=3D17 type=3D3 proto=3D0
> > > >
> > > > Clearly fishy. They do have VIRTIO_NET_HDR_F_NEEDS_CSUM set, so w=
e
> > > > know which branch they take.
> > > >
> > > >         skb_reset_mac_header(skb);
> > > >
> > > >         if (hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
> > > >                 u32 start =3D __virtio16_to_cpu(little_endian, hd=
r->csum_start);
> > > >                 u32 off =3D __virtio16_to_cpu(little_endian, hdr-=
>csum_offset);
> > > >                 u32 needed =3D start + max_t(u32, thlen, off + si=
zeof(__sum16));
> > > >
> > > > // start =3D=3D 88
> > > > // needed =3D=3D 88 + 18 =3D=3D 106
> > > >
> > > >                 if (!pskb_may_pull(skb, needed))
> > > >                         return -EINVAL;
> > > >
> > > >                 if (!skb_partial_csum_set(skb, start, off))
> > > >                         return -EINVAL;
> > > >                 if (skb_transport_offset(skb) < nh_min_len)
> > > >                         return -EINVAL;
> > > >
> > > >                 nh_min_len =3D skb_transport_offset(skb);
> > > >
> > > > // nh_min_len =3D=3D 88
> > > >
> > > >                 p_off =3D nh_min_len + thlen;
> > > >
> > > > // p_off =3D=3D 108
> > > >
> > > >                 if (!pskb_may_pull(skb, p_off))
> > > >                         return -EINVAL;
> > > >
> > > > // headlen =3D=3D 108
> > > >
> > > > At the end of this headlen =3D=3D 108, so all of iphdr should be =
in
> > > > linear.
> > > >
> > > > Since the syz repro requires repeat it is possible that I simply =
did
> > > > not capture the right packet, but I don't see the C program vary =
the
> > > > packet contents.
> >
> >



