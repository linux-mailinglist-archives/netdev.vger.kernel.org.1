Return-Path: <netdev+bounces-74815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D06866978
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 05:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C92E1C20DD3
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 04:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101D31B279;
	Mon, 26 Feb 2024 04:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTTvxzs9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F272C95
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 04:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708923583; cv=none; b=dC/l6zhsIW/0FPhHbQULS9XS6LiTeeQNM2KBGvfY71nPSutVQXJHV7XGEMWdjZq2dphA0c4a6pHSKqjch7Y/wyXiyexcUbuv+Csroj3TMP2Jw4jWtIW+6e7MDt/WjoFSvsE7RRyOsBxNo3lkMYxRFj9aHUt4KJePis+Fv1hnyrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708923583; c=relaxed/simple;
	bh=AaJMamp2Nb+Yq5spo7QL5Q4FyDBAAXS9vg0TE+DBw+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5mt7VeHdZsqeM/PfUjiLdemGQaV1kNIRbSPEenq8ya/WNOC8ySeVEgqkhMGRyjzx/UyXhhsJlhnK3dRgy4+6ooWRoIvYqwTVr376vETpWyFvHk+0DXSouIX+vEjG4CGTJ55hv4mW5wLg+rVadAQTzxPQa/WE8WjLp3gVw0cKHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PTTvxzs9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708923580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iso6K6DyWAnnF++t9+yhMMEiOuk3VKMqC/cJQai+WRQ=;
	b=PTTvxzs9cVIp3acEcuWwCUtXx5yfaWsYiYrTGrWJz4wB5+Mo0lHsJmViIJ4TleKTKzrJxY
	nT+zwDvpPpED8hec+tXPfZZW0Pc6kMcWjoHqYMCs1LlN47spMAofsKafX++0HgY9IE9SsP
	5W1QPxZjjm/5aImp/WGIF13YJjVkrVA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-kFVqwBzkM0yXxNZ_1efxhg-1; Sun, 25 Feb 2024 23:59:39 -0500
X-MC-Unique: kFVqwBzkM0yXxNZ_1efxhg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-29a82907e96so2178076a91.2
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 20:59:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708923578; x=1709528378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iso6K6DyWAnnF++t9+yhMMEiOuk3VKMqC/cJQai+WRQ=;
        b=NWQuvZzDh++NXBVLficYhyUitZMtvh1ig6SEQhI2mkqU3L3d8TXi2NexcBE7eWVgHm
         zkleildlMzAtrH3vSo6yJhQG9v7ipOMwTj4iWYs+g53MLmWH60Ho8tjryG0MIMogRm24
         jdfDACa+LrZY3IcHUTsTR8ONqDzb+EnGvNMeeWv2Bk/Ad9+eZpHYtNAY5OZzDAM9m4As
         GuDuLgFyfzyUsOJg61Qq0WnuRjUiS+jgo168zB5wI+kXR5px7DMh0rmAzpUvJA8xopdi
         dBLS7g8H57nHxL0oKm+cMKwVHZXUm9lAI7OX7hpIyYFOiPp3qP6K55HLuY8dCXoxU9dW
         D2FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy3SsUwFVQVnBhI7EXjZMabty738wbiiv62gQyWwkcDvJg0tG/oLOiA0hevb9o2COTVB92mRpKUa/+hDiX0j7dwLdTD8FC
X-Gm-Message-State: AOJu0YwGotp9yHm5FR7OEUFngie4IhJ37HkRcxQ1YUHZ6UyvLmTAxlI+
	drwkxonjMuvocVoKSOMP9dwi0eeo1sxijW62rZBwaRcqamD03HDQtC8R8FPCuu7Q7uTYJHfFm3t
	pdIzT3FHjUUszdsRmp/lR3M11pvnaiJgHYanRTjF8sYPasam1nhEHFUQUjCtuCMb6b2Y4ukEhON
	w4XfcNr3vMsKW1ZeJ0e975rjdfdaAY
X-Received: by 2002:a17:90a:ad8a:b0:29a:a38c:8262 with SMTP id s10-20020a17090aad8a00b0029aa38c8262mr2919883pjq.48.1708923577747;
        Sun, 25 Feb 2024 20:59:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFTAN/Lw+RGzf9GeokVG5jtOCl25KGwF/7DbhV8aGSvRwum+aJwJ9WzPtrwumrWZ0Ki7ztusPHGEY87VqwktA=
X-Received: by 2002:a17:90a:ad8a:b0:29a:a38c:8262 with SMTP id
 s10-20020a17090aad8a00b0029aa38c8262mr2919868pjq.48.1708923577403; Sun, 25
 Feb 2024 20:59:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202121151.65710-1-liangchen.linux@gmail.com>
 <c8d59e75-d0bb-4a03-9ef4-d6de65fa9356@kernel.org> <CAKhg4tJFpG5nUNdeEbXFLonKkFUP0QCh8A9CpwU5OvtnBuz4Sw@mail.gmail.com>
 <5297dad6499f6d00f7229e8cf2c08e0eacb67e0c.camel@redhat.com>
 <CAKhg4tLbF8SfYD4dU9U9Nhii4FY2dftjPKYz-Emrn-CRwo10mg@mail.gmail.com>
 <73c242b43513bde04eebb4eb581deb189443c26b.camel@redhat.com>
 <CAKhg4tJPjcShkw4-FHFkKOcgzHK27A5pMu9FP7OWj4qJUX1ApA@mail.gmail.com>
 <1b2d471a5d06ecadcb75e3d9155b6d566afb2767.camel@redhat.com> <1708652254.1517398-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1708652254.1517398-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Feb 2024 12:59:25 +0800
Message-ID: <CACGkMEuUeQTJYpZDx8ggqwBWULQS1Fjd_DgPvVMLq-_cjYfm7g@mail.gmail.com>
Subject: Re: [PATCH net-next v5] virtio_net: Support RX hash XDP hint
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, mst@redhat.com, 
	hengqi@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, john.fastabend@gmail.com, 
	daniel@iogearbox.net, ast@kernel.org, Liang Chen <liangchen.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 9:42=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Fri, 09 Feb 2024 13:57:25 +0100, Paolo Abeni <pabeni@redhat.com> wrote=
:
> > On Fri, 2024-02-09 at 18:39 +0800, Liang Chen wrote:
> > > On Wed, Feb 7, 2024 at 10:27=E2=80=AFPM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> > > >
> > > > On Wed, 2024-02-07 at 10:54 +0800, Liang Chen wrote:
> > > > > On Tue, Feb 6, 2024 at 6:44=E2=80=AFPM Paolo Abeni <pabeni@redhat=
.com> wrote:
> > > > > >
> > > > > > On Sat, 2024-02-03 at 10:56 +0800, Liang Chen wrote:
> > > > > > > On Sat, Feb 3, 2024 at 12:20=E2=80=AFAM Jesper Dangaard Broue=
r <hawk@kernel.org> wrote:
> > > > > > > > On 02/02/2024 13.11, Liang Chen wrote:
> > > > > > [...]
> > > > > > > > > @@ -1033,6 +1039,16 @@ static void put_xdp_frags(struct x=
dp_buff *xdp)
> > > > > > > > >       }
> > > > > > > > >   }
> > > > > > > > >
> > > > > > > > > +static void virtnet_xdp_save_rx_hash(struct virtnet_xdp_=
buff *virtnet_xdp,
> > > > > > > > > +                                  struct net_device *dev=
,
> > > > > > > > > +                                  struct virtio_net_hdr_=
v1_hash *hdr_hash)
> > > > > > > > > +{
> > > > > > > > > +     if (dev->features & NETIF_F_RXHASH) {
> > > > > > > > > +             virtnet_xdp->hash_value =3D hdr_hash->hash_=
value;
> > > > > > > > > +             virtnet_xdp->hash_report =3D hdr_hash->hash=
_report;
> > > > > > > > > +     }
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > >
> > > > > > > > Would it be possible to store a pointer to hdr_hash in virt=
net_xdp_buff,
> > > > > > > > with the purpose of delaying extracting this, until and onl=
y if XDP
> > > > > > > > bpf_prog calls the kfunc?
> > > > > > > >
> > > > > > >
> > > > > > > That seems to be the way v1 works,
> > > > > > > https://lore.kernel.org/all/20240122102256.261374-1-liangchen=
.linux@gmail.com/
> > > > > > > . But it was pointed out that the inline header may be overwr=
itten by
> > > > > > > the xdp prog, so the hash is copied out to maintain its integ=
rity.
> > > > > >
> > > > > > Why? isn't XDP supposed to get write access only to the pkt
> > > > > > contents/buffer?
> > > > > >
> > > > >
> > > > > Normally, an XDP program accesses only the packet data. However,
> > > > > there's also an XDP RX Metadata area, referenced by the data_meta
> > > > > pointer. This pointer can be adjusted with bpf_xdp_adjust_meta to
> > > > > point somewhere ahead of the data buffer, thereby granting the XD=
P
> > > > > program access to the virtio header located immediately before th=
e
> > > >
> > > > AFAICS bpf_xdp_adjust_meta() does not allow moving the meta_data be=
fore
> > > > xdp->data_hard_start:
> > > >
> > > > https://elixir.bootlin.com/linux/latest/source/net/core/filter.c#L4=
210
> > > >
> > > > and virtio net set such field after the virtio_net_hdr:
> > > >
> > > > https://elixir.bootlin.com/linux/latest/source/drivers/net/virtio_n=
et.c#L1218
> > > > https://elixir.bootlin.com/linux/latest/source/drivers/net/virtio_n=
et.c#L1420
> > > >
> > > > I don't see how the virtio hdr could be touched? Possibly even more
> > > > important: if such thing is possible, I think is should be somewhat
> > > > denied (for the same reason an H/W nic should prevent XDP from
> > > > modifying its own buffer descriptor).
> > >
> > > Thank you for highlighting this concern. The header layout differs
> > > slightly between small and mergeable mode. Taking 'mergeable mode' as
> > > an example, after calling xdp_prepare_buff the layout of xdp_buff
> > > would be as depicted in the diagram below,
> > >
> > >                       buf
> > >                        |
> > >                        v
> > >         +--------------+--------------+-------------+
> > >         | xdp headroom | virtio header| packet      |
> > >         | (256 bytes)  | (20 bytes)   | content     |
> > >         +--------------+--------------+-------------+
> > >         ^                             ^
> > >         |                             |
> > >  data_hard_start                    data
> > >                                   data_meta
> > >
> > > If 'bpf_xdp_adjust_meta' repositions the 'data_meta' pointer a little
> > > towards 'data_hard_start', it would point to the inline header, thus
> > > potentially allowing the XDP program to access the inline header.
> >
> > I see. That layout was completely unexpected to me.
> >
> > AFAICS the virtio_net driver tries to avoid accessing/using the
> > virtio_net_hdr after the XDP program execution, so nothing tragic
> > should happen.
> >
> > @Michael, @Jason, I guess the above is like that by design? Isn't it a
> > bit fragile?

Yes.

>
> YES. We process it carefully. That brings some troubles, we hope to put t=
he
> virtio-net header to the vring desc like other NICs. But that is a big pr=
oject.

Yes, and we still need to support the "legacy" layout.

>
> I think this patch is ok, this can be merged to net-next firstly.

+1

Thanks

>
> Thanks.
>
>
> >
> > Thanks!
> >
> > Paolo
> >
>


