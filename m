Return-Path: <netdev+bounces-210425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C468B13375
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 05:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA51175F2B
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 03:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EC7214A6A;
	Mon, 28 Jul 2025 03:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWf2QjR2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE03E1EA7C4;
	Mon, 28 Jul 2025 03:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753674681; cv=none; b=kc4CEANhrVJmRyggBM49lxQLWINLON1xPkwuLaT8WSSA0488VT2jjEyimOuXuxIUWIQ6aSLa+RjDXsnPczINvWul4XTl7kwEZ9CEz42PItXE5XgroVaa2uyW7EebFVh3Znlb+5gEgmhAgqijfgJPvhmWfS92H8lESKmbCd3I4fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753674681; c=relaxed/simple;
	bh=R+Szdc9IZEupB29lbdW/bHnVnpDKxXmiFUCekZcQk1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9RfIM9Ix5FMQrnHTaQtaVod26jEmPazrQgBvp5szP1NkANnFqCp+fKBNAh+E0ujd8uy4XUZIFKKYQ/BZ6n+SQsaYofGpnSTETpo4AwH5p5s/OboGOlsMSemYrWs9TdCZCUiuc5eK4hmAtDwJA3WxtYwvAWyjgSOC6SLzriC51c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWf2QjR2; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71a04654b82so7523697b3.2;
        Sun, 27 Jul 2025 20:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753674678; x=1754279478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrehipaAg9x4RIFKtETchHQEThsc/Gdzu3QWzY579jk=;
        b=JWf2QjR2gkaAmZOjpw4g1fFfj/DVt02E4Ba7NxG7KSErmhLRv3DDRH/1rH+GdTtlaZ
         OZqQT9oEJZ0gTkplqnPkseW26KX88HOnciNBkQQe621b2fKxrjhvac/1Ydt/EUCPBdbU
         Uddj7xv7so7r2KZiJpdCphuwWWot1Bpuvca6FRrXkEJrUvhJaplHDXMvWfGS6HMkqKCi
         rH3xdCrf49FNCV52ziveHKznRrwPp1qv4MJ7Cl//UMSo+5myhM4UKVpeT9DnYSdVwAk0
         KalYda+M0xhYJB0yuWDhRctcMJ4/7CVC9XdZVAqo0Q2XAEDDqZ4V5HaHD3b4W+eqTUBq
         aQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753674678; x=1754279478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrehipaAg9x4RIFKtETchHQEThsc/Gdzu3QWzY579jk=;
        b=G1JvOgcuH42zrX+9Atq4HQ2n8OHI+i0eMKlzY94oROzMGh6SuFGIVB5AXqzxqNTuvp
         glODB7z0J+cSqs3H9wg6QXn70QoeeZ0iY1f3i2alnlO6kerYo4hhjt7hIjNXuwZd9UXP
         Ir4a42fq+ivgfZXysynBRIhzcxtXOmOIRMgDTyiqgrYR453s73o5uroJD92NdAbzVi/r
         izrwfYb4V+ti9rDiVWKNGvzGj0uEJOyrn9vwWzJehuKFS54kNPcF+3WsZsccrSUjaipE
         u1YvD7a8pA7o1jic8sxBZUyESZxQEcK+R5rhl6PgW9M5hDxl9hrtw3dXO7zvigYefHn+
         K0WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOrUCLD2wbMNf5uRGeUobgAYtYNRbZR0UjiNZrkL7pD6zL/1DiEm8KgQycM6DxwrRqTHJnW5AwAWxUee0=@vger.kernel.org, AJvYcCVGGWYr8Z5lI4ursjscv/cOO0UB+TRN55201xtcoVxNyFmLA5vE9ecLm04wAmlEway8IW1obd9Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb0m6+lbMZcRyc0cg49B8R8ErO0bb7udwXImvw4b6THyXAcip0
	MwzaayFe+aY6wsju6BNVQ34JZ2HqgwS9nO29k9GRLhoTU5QZzHoudmf410T9+7Bkh3W6YdGA2+f
	h2hSMmbJTjrAzwfLMlmEBUx1pbktlhK0=
X-Gm-Gg: ASbGncsCpENhIzDrfMsSCx20efzjQvPD4D8Nu8Fuc0UkewluVxpcQjK59bWNk4kFfWy
	VNTAN3UEiDD6+ZpUQ1l6IS3mUrwcO3UDtTozNXnn3eETqjJa2ngwsBLFatLvM2Z2mw5TPDHQfy5
	v2VSai+gLxN1D40Wu8HfRfKUZRBdMqX1cs4C1p+WpLIYkLd8oRs/NuyfJjqCRNnosEYWzm4HhCy
	fPY8b2+H+4TEs/Nhdz4aMtklCgdfe7wBCFgDM2vLQ==
X-Google-Smtp-Source: AGHT+IEe8t4zH9Jep2O4bZaR1QE3V/MNiGneZNNvs4ZGlVtrTRVKeRdxtgbxH/VTFPO9qqV5hxccBCyovNKBN973ZDI=
X-Received: by 2002:a05:690c:6f02:b0:71a:2c7d:d2a0 with SMTP id
 00721157ae682-71a2c7e2642mr738037b3.12.1753674677854; Sun, 27 Jul 2025
 20:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724083005.3918375-1-wangliang74@huawei.com>
 <688235273230f_39271d29430@willemb.c.googlers.com.notmuch>
 <bef878c0-4d7f-4e9a-a05d-30f6fde31e3c@huawei.com> <68865594e28d8_9f93f29443@willemb.c.googlers.com.notmuch>
 <68865ecee5cc4_b1f6a29442@willemb.c.googlers.com.notmuch> <CACGkMEvAWj5CFPwXx=zWjvZnMUYBORuXm-mMQe89P8xdBRid5w@mail.gmail.com>
In-Reply-To: <CACGkMEvAWj5CFPwXx=zWjvZnMUYBORuXm-mMQe89P8xdBRid5w@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sun, 27 Jul 2025 23:50:40 -0400
X-Gm-Features: Ac12FXwPKd7szapBYuV4uvG7PKjftRwBqchAR0LB9d-9bKC_MUvlni1NjW3v80o
Message-ID: <CAF=yD-+Mzk0ibfgByXqiS_y=FoKqLVtATKQF4PPpUL4Pk8hosw@mail.gmail.com>
Subject: Re: [PATCH net] net: check the minimum value of gso size in virtio_net_hdr_to_skb()
To: Jason Wang <jasowang@redhat.com>
Cc: Wang Liang <wangliang74@huawei.com>, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, pabeni@redhat.com, davem@davemloft.net, 
	willemb@google.com, atenart@kernel.org, yuehaibing@huawei.com, 
	zhangchangzhong@huawei.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	steffen.klassert@secunet.com, tobias@strongswan.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 11:21=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Jul 28, 2025 at 1:16=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Willem de Bruijn wrote:
> > > Wang Liang wrote:
> > > >
> > > > =E5=9C=A8 2025/7/24 21:29, Willem de Bruijn =E5=86=99=E9=81=93:
> > > > > Wang Liang wrote:
> > > > >> When sending a packet with virtio_net_hdr to tun device, if the =
gso_type
> > > > >> in virtio_net_hdr is SKB_GSO_UDP and the gso_size is less than u=
dphdr
> > > > >> size, below crash may happen.
> > > > >>
> > > > > gso_size is the size of the segment payload, excluding the transp=
ort
> > > > > header.
> > > > >
> > > > > This is probably not the right approach.
> > > > >
> > > > > Not sure how a GSO skb can be built that is shorter than even the
> > > > > transport header. Maybe an skb_dump of the GSO skb can be elucida=
ting.
> > > > >>                          return -EINVAL;
> > > > >>
> > > > >>                  /* Too small packets are not really GSO ones. *=
/
> > > > >> --
> > > > >> 2.34.1
> > > > >>
> > > >
> > > > Thanks for your review!
> > >
> > > Thanks for the dump and repro.
> > >
> > > I can indeed reproduce, only with the UDP_ENCAP_ESPINUDP setsockopt.
> > >
> > > > Here is the skb_dump result:
> > > >
> > > >      skb len=3D4 headroom=3D98 headlen=3D4 tailroom=3D282
> > > >      mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
> > > >      shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=3D0=
))
> > > >      csum(0x8c start=3D140 offset=3D0 ip_summed=3D1 complete_sw=3D0=
 valid=3D1 level=3D0)
> > >
> > > So this is as expected not the original GSO skb, but a segment,
> > > after udp_rcv_segment from udp_queue_rcv_skb.
> > >
> > > It is a packet with skb->data pointing to the transport header, and
> > > only 4B length. So this is an illegal UDP packet with length shorter
> > > than sizeof(struct udphdr).
> > >
> > > The packet does not enter xfrm4_gro_udp_encap_rcv, so we can exclude
> > > that.
> > >
> > > It does enter __xfrm4_udp_encap_rcv, which will return 1 because the
> > > pskb_may_pull will fail. There is a negative integer overflow just
> > > before that:
> > >
> > >         len =3D skb->len - sizeof(struct udphdr);
> > >         if (!pskb_may_pull(skb, sizeof(struct udphdr) + min(len, 8)))
> > >                 return 1;
> > >
> > > This is true for all the segments btw, not just the last one. On
> > > return of 1 here, the packet does not enter encap_rcv but gets
> > > passed to the socket as a normal UDP packet:
> > >
> > >       /* If it's a keepalive packet, then just eat it.
> > >        * If it's an encapsulated packet, then pass it to the
> > >        * IPsec xfrm input.
> > >        * Returns 0 if skb passed to xfrm or was dropped.
> > >        * Returns >0 if skb should be passed to UDP.
> > >        * Returns <0 if skb should be resubmitted (-ret is protocol)
> > >        */
> > >       int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
> > >
> > > But so the real bug, an skb with 4B in the UDP layer happens before
> > > that.
> > >
> > > An skb_dump in udp_queue_rcv_skb of the GSO skb shows
> > >
> > > [  174.151409] skb len=3D190 headroom=3D64 headlen=3D190 tailroom=3D6=
6
> > > [  174.151409] mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
> > > [  174.151409] shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D4 type=3D65=
538 segs=3D0))
> > > [  174.151409] csum(0x8c start=3D140 offset=3D0 ip_summed=3D3 complet=
e_sw=3D0 valid=3D1 level=3D0)
> > > [  174.151409] hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D2 iif=
=3D8
> > > [  174.151409] priority=3D0x0 mark=3D0x0 alloc_cpu=3D1 vlan_all=3D0x0
> > > [  174.151409] encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=
=3D0, trans=3D0)
> > > [  174.152101] dev name=3Dtun0 feat=3D0x00002000000048c1
> > >
> > > And of segs[0] after segmentation
> > >
> > > [  103.081442] skb len=3D38 headroom=3D64 headlen=3D38 tailroom=3D218
> > > [  103.081442] mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
> > > [  103.081442] shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 =
segs=3D0))
> > > [  103.081442] csum(0x8c start=3D140 offset=3D0 ip_summed=3D1 complet=
e_sw=3D0 valid=3D1 level=3D0)
> > > [  103.081442] hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D2 iif=
=3D8
> > > [  103.081442] priority=3D0x0 mark=3D0x0 alloc_cpu=3D0 vlan_all=3D0x0
> > > [  103.081442] encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=
=3D0, trans=3D0)
> > >
> > > So here translen is already 38 - (98-64) =3D=3D 38 - 34 =3D=3D 4.
> > >
> > > So the bug happens in segmentation.
> > >
> > > [ongoing ..]
> >
> > Oh of course, this is udp fragmentation offload (UFO):
> > VIRTIO_NET_HDR_GSO_UDP.
> >
> > So only the first packet has an UDP header, and that explains why the
> > other packets are only 4B.
> >
> > They are not UDP packets, but they have already entered the UDP stack
> > due to this being GSO applied in udp_queue_rcv_skb.
> >
> > That was never intended to be used for UFO. Only for GRO, which does
> > not build such packets.
> >
> > Maybe we should just drop UFO (SKB_GSO_UDP) packets in this code path?
> >
>
> Just to make sure I understand this. Did you mean to disable UFO for
> guest -> host path? If yes, it seems can break some appllication.

No, I mean inside the special segmentation path inside UDP receive.

I know that we have to keep UFO segmentation around because existing
guests may generate those packets and these features cannot be
re-negotiated once enabled, even on migration. But no new kernel
generates UFO packets.

Segmentation inside UDP receive was added when UDP_GRO was added, in
case packets accidentally add up at a local socket receive path that
does not support large packets.

Since GRO never builds UFO packets, such packets should not arrive at
such sockets to begin with.

Evidently we forgot about looping virtio_net_hdr packets. They were
never intended to be supported in this new path, nor clearly have they
ever worked. We just need to mitigate them without crashing.

