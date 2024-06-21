Return-Path: <netdev+bounces-105758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DF6912AD4
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D14EB2117D
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 16:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A743B15EFD4;
	Fri, 21 Jun 2024 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="V/RM0Zau"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BCB4F215
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718985930; cv=none; b=s3HLj58ZtO9ZBQnQ6gfQvjqpjbwuCIGJgxlBf+4kDlrVbCDjk0d+Nr2KqE678lDwocpcQnEwPL0AVbzANUf4D1PQ7+mpYlij2HzpHxUCKtmibMWQSiVdh+v96KjgxiHQb3P4CKicdWSmGVQh9RQfVIq0zujGyN/NINpJJ50qZCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718985930; c=relaxed/simple;
	bh=fkwPZLyQNQ4ZNXfxazc5Zwbqv5MiORFU7s6HGX0pBXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/MplrobUu6NiPN+ZeIffXK8W5TEvBFzDDi5B2DveTYHcaWjDVvNjiFNfKy7P3hQza7xUoiT/naOVlUcFTcn4/8xPbHhp2k7Absv4kc1xxsUEBzmqTqW20QA4RVaERvb58mBZZfxKuSOdQFK7qeOwbMhsrjKwUM4qdCKa452xYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=V/RM0Zau; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57d280e2d5dso1766203a12.1
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718985927; x=1719590727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2aLeA46ZAcGtDVAAuPO+bTYmu9QSz8VmaNmucxcUMo=;
        b=V/RM0ZauFfBwHiyGmK69tMrTEtIlck9+4z5c+chqweQK7pscIT5gmLbxwJsMw0kXij
         aZtfvoPX47z8UnwHZ6TYdv3IYaM9uMeJp/obQMgR0S67uAgul4jVrAFDExWYY7e3Cdxn
         zv01dX7S76E3o8nPKHsdv4aByMscP3clQ6gV+jAyfTvlYG+69yRb9I+44x5ISly0fyES
         LivPrYzfMn276anaK5ua7FSqgR1/B0u2H3Qr7gxFiaGysxQkFFXdEDqzt+AEYiCKIMDl
         k/MGflMmsKJWDhxHVRyB2pld3NK7LMN644LDvAM0Bi67zLeLwai22JfuYLnxAXnsX2x8
         LRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718985927; x=1719590727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2aLeA46ZAcGtDVAAuPO+bTYmu9QSz8VmaNmucxcUMo=;
        b=opOuZ3/F5MSKGeFlbaZ9onPaa9Oki8pQbSVtC4WunzUaa5iQ99Q9myjiEAlA61Nat+
         Bjm9QkcvN71YsNrH9DXKWf6k4CwqCMePjILUkulvwR1GL8u7ICFnBQXlgpVjSd1GM70m
         DFeOb/ILwCgcaFAJDAA7oLhsNt9PhMHdL28okxN3QCxAlvFIZbCxWvhtvIu7xC68a8sX
         wHTufTVxpIDvZxFGuWeXmzPFUmiCzHfPWg0OSJwl655FDAW4bRa48EvpNW9HOMP6OHzB
         mdgrTYfw/DcxgGjKaZiemu/V7FJKbLTqAPVNozHiUjxpK1sH03moTE3BanVoyMRDpTfA
         89FQ==
X-Gm-Message-State: AOJu0YxVciBKsUCQXyp9ev4NsGrI8zoS5pcVxUQIscuZPB5YbxX9HQWC
	kHeNeE1hRgHTzA7XK+mpN1o5gAZjgnC8HvNwdSNjA+gnYSz+iYNDxkM2jgeQlpSNlmbJ7ngVgD3
	26r7jMItpQ+zTKcglXptDu/vXNlZKtOSxiZSIeQ==
X-Google-Smtp-Source: AGHT+IGD3zOZ+DlFfttlvVbViNyesT1FVgv0TCou1a6PzL45XRc693Rl+UIwHlsumxzTa5uTopBV2v3bgejeyto8xfA=
X-Received: by 2002:a50:9e67:0:b0:57d:57c:ce99 with SMTP id
 4fb4d7f45d1cf-57d07e68e29mr4776325a12.2.1718985927129; Fri, 21 Jun 2024
 09:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718919473.git.yan@cloudflare.com> <a9eba425bfd3bfac7e7be38fe86ad5dbff3ae01f.1718919473.git.yan@cloudflare.com>
 <6414deb0-165c-4a98-8467-ba6949166f96@intel.com>
In-Reply-To: <6414deb0-165c-4a98-8467-ba6949166f96@intel.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 21 Jun 2024 11:05:16 -0500
Message-ID: <CAO3-PbrVbOo9ydrtc7kfWitXrnftgT3QGpub3y2K209L0jis1Q@mail.gmail.com>
Subject: Re: [RFC net-next 5/9] ice: apply XDP offloading fixup when building skb
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 4:22=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Yan Zhai <yan@cloudflare.com>
> Date: Thu, 20 Jun 2024 15:19:22 -0700
>
> > Add a common point to transfer offloading info from XDP context to skb.
> >
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_txrx.c | 2 ++
> >  drivers/net/ethernet/intel/ice/ice_xsk.c  | 6 +++++-
> >  include/net/xdp_sock_drv.h                | 2 +-
> >  3 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/et=
hernet/intel/ice/ice_txrx.c
> > index 8bb743f78fcb..a247306837ed 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > @@ -1222,6 +1222,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring,=
 int budget)
> >
> >                       hard_start =3D page_address(rx_buf->page) + rx_bu=
f->page_offset -
> >                                    offset;
> > +                     xdp_init_buff_minimal(xdp);
>
> Two lines below, you have this:
>
>         xdp_buff_clear_frags_flag(xdp);
>
> Which clears frags bit in xdp->flags. I.e. since you always clear flags
> here, this call becomes redundant.
> But I'd say that `xdp->flags =3D 0` really wants to be moved from
> xdp_init_buff() to xdp_prepare_buff().
>
You are right, there is some redundancy here. I will fix it if people
feel good about the use case in general :)


> >                       xdp_prepare_buff(xdp, hard_start, offset, size, !=
!offset);
> >  #if (PAGE_SIZE > 4096)
> >                       /* At larger PAGE_SIZE, frame_sz depend on len si=
ze */
> > @@ -1287,6 +1288,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring,=
 int budget)
> >
> >               /* populate checksum, VLAN, and protocol */
> >               ice_process_skb_fields(rx_ring, rx_desc, skb);
> > +             xdp_buff_fixup_skb_offloading(xdp, skb);
> >
> >               ice_trace(clean_rx_irq_indicate, rx_ring, rx_desc, skb);
> >               /* send completed skb up the stack */
> > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/eth=
ernet/intel/ice/ice_xsk.c
> > index a65955eb23c0..367658acaab8 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > @@ -845,8 +845,10 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_rin=
g, int budget)
> >       xdp_prog =3D READ_ONCE(rx_ring->xdp_prog);
> >       xdp_ring =3D rx_ring->xdp_ring;
> >
> > -     if (ntc !=3D rx_ring->first_desc)
> > +     if (ntc !=3D rx_ring->first_desc) {
> >               first =3D *ice_xdp_buf(rx_ring, rx_ring->first_desc);
> > +             xdp_init_buff_minimal(first);
>
> xdp_buff_set_size() always clears flags, this is redundant.
>
> > +     }
> >
> >       while (likely(total_rx_packets < (unsigned int)budget)) {
> >               union ice_32b_rx_flex_desc *rx_desc;
> > @@ -920,6 +922,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring=
, int budget)
> >                       break;
> >               }
> >
> > +             xdp =3D first;
> >               first =3D NULL;
> >               rx_ring->first_desc =3D ntc;
> >
> > @@ -934,6 +937,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring=
, int budget)
> >               vlan_tci =3D ice_get_vlan_tci(rx_desc);
> >
> >               ice_process_skb_fields(rx_ring, rx_desc, skb);
> > +             xdp_buff_fixup_skb_offloading(xdp, skb);
> >               ice_receive_skb(rx_ring, skb, vlan_tci);
> >       }
> >
> > diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> > index 0a5dca2b2b3f..02243dc064c2 100644
> > --- a/include/net/xdp_sock_drv.h
> > +++ b/include/net/xdp_sock_drv.h
> > @@ -181,7 +181,7 @@ static inline void xsk_buff_set_size(struct xdp_buf=
f *xdp, u32 size)
> >       xdp->data =3D xdp->data_hard_start + XDP_PACKET_HEADROOM;
> >       xdp->data_meta =3D xdp->data;
> >       xdp->data_end =3D xdp->data + size;
> > -     xdp->flags =3D 0;
> > +     xdp_init_buff_minimal(xdp);
>
> Why is this done in the patch prefixed with "ice:"?
>
Good catch, this should be moved to the previous patch.

thanks
Yan

> >  }
> >
> >  static inline dma_addr_t xsk_buff_raw_get_dma(struct xsk_buff_pool *po=
ol,
>
> Thanks,
> Olek

