Return-Path: <netdev+bounces-210706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814B9B14662
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 04:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF953A64B9
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 02:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC72212B2F;
	Tue, 29 Jul 2025 02:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5zVs1l3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AEB217648
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 02:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756876; cv=none; b=CwaxTZ1rCGpnveY6M5KoqjSU6HaF5/UHYDHp+uqeoGH+MjdA+AcQsJt02A2tBzSfs0V60n3PmpBdcXdIgGwhJMUdcccx7DlH5VuCgKKMv+jmVyv0cMmffIQjFnB1Nu55aZtwbOOMhgV/I2utUnZXRT9SC9It/LrRYwGTNiA1X/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756876; c=relaxed/simple;
	bh=X309qTXiUmXcWUW47hmX5f9RiETUsGDeMR4fFUgVZok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNz8hszPHKG3O2uQKdMcSjtUIg59NX8UxlPE8unN1/kie/PpDT63JlaiskOsjOdMVf60tmm3Fu59wUElPMk8I2inGq2aKOPTt6zYPglFGioDPIeDGf9t6KlB/JR7Bs2KfPLsi9VRCPAJ8RJlfpOK+g/f+x2v8z8ziAEodpTMVUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X5zVs1l3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753756871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gHAAqXw/KuXP6KCHImnMfYHqGrLwhp1YW8sP9wzIXaE=;
	b=X5zVs1l3/zRgN/V+lUywzplOM7HqWQ4u8XB1B4CDanzB9bfkQ+YWPkPgmDmRitu5OQ4Vkb
	wdCtZCc2i0K4QGuZ3xf/vhlehn60/QOFvwgygUSZhc5CF9YUhng7MmgMitOPOAxL7KYmgH
	v5icMBIwKaM4UMIgFe5e+flVN/KF5uY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-WkYuhHt9NISMlO69M2cpsw-1; Mon, 28 Jul 2025 22:41:05 -0400
X-MC-Unique: WkYuhHt9NISMlO69M2cpsw-1
X-Mimecast-MFC-AGG-ID: WkYuhHt9NISMlO69M2cpsw_1753756864
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31f32271a1fso296511a91.0
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 19:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756864; x=1754361664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHAAqXw/KuXP6KCHImnMfYHqGrLwhp1YW8sP9wzIXaE=;
        b=nJOoJYWn21ACxoiC+Yq/UzkZZH5I4/NaD0oPts7wFmTwIchLztWfhoP23aJsa9x20g
         fMQEYFohdO4Knlb3IkKWNXj4+nWiAi0le1EgOPfe3LaGsMDJR6nyRC6dMR+zylPrJPkh
         8l4enzctLGjRaYMm0CWXXMvM7W+0ZGJeFCLskpaB+FEAQt/ZkbFDNtjVLKULWoCfMSyB
         xFQlLI9z6tlU+dwE75HZpGHipZiMzj9Xx2uOAXOmypUW6kvXoaeZ+SPav2ZedT4sZqb5
         yrAzUaCMY1+MrlPeuz8dFn3l9runeT9vTvUJ/XN+DPLizHxjgg+1QcIy7KZe5uz9Cxgg
         4zhA==
X-Forwarded-Encrypted: i=1; AJvYcCUaDNBhLhde1aetYas+nAXmliYmihlGSyfcb4iliS9I7DJ72P7mRyxJW1oEut6Ze1pm6w4Pwwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5hYrHzUw2oDzHjw8jWDnNhUQBttUJzbQCQn2aDzvI/KC3lI9l
	WaVl1bbVv+aJgTVD5h0pxF2I+irInwShZQ7dEgVvEaZiwLaNas42fIYwgQ6oxQX9T/EGPnFwaCl
	Gf1+Pxg9CJhxetok/e+uV82rFsP/PXvjyRetXeBsTOW76IXloD6ouTKN9y6RZNO37g1Uj9XMOsw
	vDkKqipA0PDiWn78wFmbfo9kSCA5Ifyeem0Osq3Ho6nng=
X-Gm-Gg: ASbGncv1hgipAEm0WMZBxGJWJ+9C/THWeuzP2Ay2IH7861YpANHvjbglF73JQgbw2/h
	Sac6N2CATlRWduEhPSm40xb2OtyjDjzv3I7JILt5xl5VONbdo9f/Qk5y2IWjW+loi4F909fgbA0
	ouCYIRXF0sn24pHsxLFBE=
X-Received: by 2002:a17:90b:53c6:b0:313:d361:73d7 with SMTP id 98e67ed59e1d1-31f28cc103bmr2607650a91.13.1753756863930;
        Mon, 28 Jul 2025 19:41:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcQejW7k/8dP6hOLwNt4pKjQZBInzGCnHmY7rDBeaCFzof5J/jzWQYd1AedFT1fTNe/pYL8sgxdB4R01T/1CY=
X-Received: by 2002:a17:90b:53c6:b0:313:d361:73d7 with SMTP id
 98e67ed59e1d1-31f28cc103bmr2607620a91.13.1753756863474; Mon, 28 Jul 2025
 19:41:03 -0700 (PDT)
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
 <CAF=yD-+Mzk0ibfgByXqiS_y=FoKqLVtATKQF4PPpUL4Pk8hosw@mail.gmail.com>
In-Reply-To: <CAF=yD-+Mzk0ibfgByXqiS_y=FoKqLVtATKQF4PPpUL4Pk8hosw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Jul 2025 10:40:52 +0800
X-Gm-Features: Ac12FXzzqIS2NvTpn0ksYhOGQwfypqEKPmDB9p0TZTS8VxgjhLHI2isMfShyY3I
Message-ID: <CACGkMEvL0_6a1u0riEbQV-oVem_vfnTy48X2H3RcXF_MgL-zZg@mail.gmail.com>
Subject: Re: [PATCH net] net: check the minimum value of gso size in virtio_net_hdr_to_skb()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Wang Liang <wangliang74@huawei.com>, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, pabeni@redhat.com, davem@davemloft.net, 
	willemb@google.com, atenart@kernel.org, yuehaibing@huawei.com, 
	zhangchangzhong@huawei.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	steffen.klassert@secunet.com, tobias@strongswan.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 11:51=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Sun, Jul 27, 2025 at 11:21=E2=80=AFPM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Mon, Jul 28, 2025 at 1:16=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Willem de Bruijn wrote:
> > > > Wang Liang wrote:
> > > > >
> > > > > =E5=9C=A8 2025/7/24 21:29, Willem de Bruijn =E5=86=99=E9=81=93:
> > > > > > Wang Liang wrote:
> > > > > >> When sending a packet with virtio_net_hdr to tun device, if th=
e gso_type
> > > > > >> in virtio_net_hdr is SKB_GSO_UDP and the gso_size is less than=
 udphdr
> > > > > >> size, below crash may happen.
> > > > > >>
> > > > > > gso_size is the size of the segment payload, excluding the tran=
sport
> > > > > > header.
> > > > > >
> > > > > > This is probably not the right approach.
> > > > > >
> > > > > > Not sure how a GSO skb can be built that is shorter than even t=
he
> > > > > > transport header. Maybe an skb_dump of the GSO skb can be eluci=
dating.
> > > > > >>                          return -EINVAL;
> > > > > >>
> > > > > >>                  /* Too small packets are not really GSO ones.=
 */
> > > > > >> --
> > > > > >> 2.34.1
> > > > > >>
> > > > >
> > > > > Thanks for your review!
> > > >
> > > > Thanks for the dump and repro.
> > > >
> > > > I can indeed reproduce, only with the UDP_ENCAP_ESPINUDP setsockopt=
.
> > > >
> > > > > Here is the skb_dump result:
> > > > >
> > > > >      skb len=3D4 headroom=3D98 headlen=3D4 tailroom=3D282
> > > > >      mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
> > > > >      shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=
=3D0))
> > > > >      csum(0x8c start=3D140 offset=3D0 ip_summed=3D1 complete_sw=
=3D0 valid=3D1 level=3D0)
> > > >
> > > > So this is as expected not the original GSO skb, but a segment,
> > > > after udp_rcv_segment from udp_queue_rcv_skb.
> > > >
> > > > It is a packet with skb->data pointing to the transport header, and
> > > > only 4B length. So this is an illegal UDP packet with length shorte=
r
> > > > than sizeof(struct udphdr).
> > > >
> > > > The packet does not enter xfrm4_gro_udp_encap_rcv, so we can exclud=
e
> > > > that.
> > > >
> > > > It does enter __xfrm4_udp_encap_rcv, which will return 1 because th=
e
> > > > pskb_may_pull will fail. There is a negative integer overflow just
> > > > before that:
> > > >
> > > >         len =3D skb->len - sizeof(struct udphdr);
> > > >         if (!pskb_may_pull(skb, sizeof(struct udphdr) + min(len, 8)=
))
> > > >                 return 1;
> > > >
> > > > This is true for all the segments btw, not just the last one. On
> > > > return of 1 here, the packet does not enter encap_rcv but gets
> > > > passed to the socket as a normal UDP packet:
> > > >
> > > >       /* If it's a keepalive packet, then just eat it.
> > > >        * If it's an encapsulated packet, then pass it to the
> > > >        * IPsec xfrm input.
> > > >        * Returns 0 if skb passed to xfrm or was dropped.
> > > >        * Returns >0 if skb should be passed to UDP.
> > > >        * Returns <0 if skb should be resubmitted (-ret is protocol)
> > > >        */
> > > >       int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
> > > >
> > > > But so the real bug, an skb with 4B in the UDP layer happens before
> > > > that.
> > > >
> > > > An skb_dump in udp_queue_rcv_skb of the GSO skb shows
> > > >
> > > > [  174.151409] skb len=3D190 headroom=3D64 headlen=3D190 tailroom=
=3D66
> > > > [  174.151409] mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
> > > > [  174.151409] shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D4 type=3D=
65538 segs=3D0))
> > > > [  174.151409] csum(0x8c start=3D140 offset=3D0 ip_summed=3D3 compl=
ete_sw=3D0 valid=3D1 level=3D0)
> > > > [  174.151409] hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D2 i=
if=3D8
> > > > [  174.151409] priority=3D0x0 mark=3D0x0 alloc_cpu=3D1 vlan_all=3D0=
x0
> > > > [  174.151409] encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=
=3D0, trans=3D0)
> > > > [  174.152101] dev name=3Dtun0 feat=3D0x00002000000048c1
> > > >
> > > > And of segs[0] after segmentation
> > > >
> > > > [  103.081442] skb len=3D38 headroom=3D64 headlen=3D38 tailroom=3D2=
18
> > > > [  103.081442] mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
> > > > [  103.081442] shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D=
0 segs=3D0))
> > > > [  103.081442] csum(0x8c start=3D140 offset=3D0 ip_summed=3D1 compl=
ete_sw=3D0 valid=3D1 level=3D0)
> > > > [  103.081442] hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D2 i=
if=3D8
> > > > [  103.081442] priority=3D0x0 mark=3D0x0 alloc_cpu=3D0 vlan_all=3D0=
x0
> > > > [  103.081442] encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=
=3D0, trans=3D0)
> > > >
> > > > So here translen is already 38 - (98-64) =3D=3D 38 - 34 =3D=3D 4.
> > > >
> > > > So the bug happens in segmentation.
> > > >
> > > > [ongoing ..]
> > >
> > > Oh of course, this is udp fragmentation offload (UFO):
> > > VIRTIO_NET_HDR_GSO_UDP.
> > >
> > > So only the first packet has an UDP header, and that explains why the
> > > other packets are only 4B.
> > >
> > > They are not UDP packets, but they have already entered the UDP stack
> > > due to this being GSO applied in udp_queue_rcv_skb.
> > >
> > > That was never intended to be used for UFO. Only for GRO, which does
> > > not build such packets.
> > >
> > > Maybe we should just drop UFO (SKB_GSO_UDP) packets in this code path=
?
> > >
> >
> > Just to make sure I understand this. Did you mean to disable UFO for
> > guest -> host path? If yes, it seems can break some appllication.
>
> No, I mean inside the special segmentation path inside UDP receive.
>
> I know that we have to keep UFO segmentation around because existing
> guests may generate those packets and these features cannot be
> re-negotiated once enabled, even on migration. But no new kernel
> generates UFO packets.
>
> Segmentation inside UDP receive was added when UDP_GRO was added, in
> case packets accidentally add up at a local socket receive path that
> does not support large packets.
>
> Since GRO never builds UFO packets, such packets should not arrive at
> such sockets to begin with.
>
> Evidently we forgot about looping virtio_net_hdr packets. They were
> never intended to be supported in this new path, nor clearly have they
> ever worked. We just need to mitigate them without crashing.

Thanks a lot for the clarification. It's clear to me now.

>


