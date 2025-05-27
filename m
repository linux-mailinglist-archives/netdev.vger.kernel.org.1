Return-Path: <netdev+bounces-193561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E039AC4733
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 06:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA271895802
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 04:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25AA1A9B48;
	Tue, 27 May 2025 04:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYemeO5A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75C5464E
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 04:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748319592; cv=none; b=GHO8YU68D40/B4YQ8MOUXoh4YcHU/5eL801nUw17uVzfwowuHw0uccCam6nOp0IQgH5khPRqCn1dHacZZcPIo9LhSnr7z3kGSrAaghbxGvIFj38Tis1Wlnjhf7k/y60NYnkQ7w0zQ73H1BHEmobfJ2IXqvPs3l7iy3ltJLAMr2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748319592; c=relaxed/simple;
	bh=O+3mZdsYmA+KgnxluSUbJajb+KM4e5rotsLs3lRRpok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UugTP8K9klVaSe6bJk2HcoJ/GEBJS86DrHeKi81PXbNxQ7MzjL30EfnYabLFYHa1DkJCit06ST3w68DJrzmOaXXSkHIxXVX4lmRzw9s25BsuJLMJMbiALDX+ixpBvAI2ffi6W4w0n+1w7n8+nZHSkysrY3GkpFp2TWSn7jbziJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bYemeO5A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748319589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JIiJJgPbflStsT+vfj63BCaUQM6c6UA/rITGjNIWHu4=;
	b=bYemeO5AoPiu95s+FozR4Zpwr9eeBSi1dWW2GLUEvT90ykA/aL1cyjrwaZz81jeXBHmuaN
	0it5k9clWoQdzxAOzAgWOLIPicT7J+NETpOKhEWdjJjKh0zJ/3Y80JBlnWpW+7VYIyELVc
	ue3zMHB4SC91N3t4D5G0qQ8qar2TuwA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-h8DIsl_1Mhaks4NCh5h_og-1; Tue, 27 May 2025 00:19:48 -0400
X-MC-Unique: h8DIsl_1Mhaks4NCh5h_og-1
X-Mimecast-MFC-AGG-ID: h8DIsl_1Mhaks4NCh5h_og_1748319587
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31147652b36so1982187a91.2
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 21:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748319587; x=1748924387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIiJJgPbflStsT+vfj63BCaUQM6c6UA/rITGjNIWHu4=;
        b=TSwxszmg98JL8GsGoTfBInuoA2EUVnzJqUxXX80udh6iNJD5Yvt9o0X0IRd5RA2nKu
         IKd33WLhQgS3WjHdxSIwYRqori4tRQrjlMfPJyPVwFP23NwiDpAmaNZm3eoFU037lAI+
         OqzMaxpCs2LcEML7k54iusgLu8ogVkVQ41XcmfSORuzaMErxGt4cyskKaTUTDC9L7F8h
         XhZ19tSdvxoXTxG7T2XdnGXfPsgk/P9fx/daiN/21Yu4P0lZ2RuGnI+q3sXkQnuCeEvm
         ZPs//NfE4bu764arHFwLIOxLTIjGwkPoW6tRtV97z35HnvND/pjNGzmn2/pWcem9giiT
         0ARw==
X-Gm-Message-State: AOJu0Yxhw/1rRRFsO8F4D+XI0lmEGXk8F3w0mItqpaZBAHgZHpVBFQ0n
	ojcDqdWhhsIM3HA0DpNpFm/wbXTpvdCr2ik2ZDtZr4jFEN8CgM+xb73uQxHTgHlGn2M2hn2m3Z6
	R4TCGywv0CBn3eVcXbJwbxHMYUGWU+1iNzjEx9TawqnBIrLAD2l6kAlKBCwjklHDyzXLMZ0BK7F
	5e0SmOMjySTUaLZIhNqTky3k/sPXe2gX69
X-Gm-Gg: ASbGncsiy6qTNM9sAG/rHHv5Gv2SBWUddH9PipzlHwyGbUDVBhbR3tWz/7xYo+ijSGU
	96M2iGWjIEb67qvGOGsX5bEHAe+aECkdVc+5tnpp5chQ9c1yRwYvBkwHj66yGWyaAZhWM6g==
X-Received: by 2002:a17:90b:3f0d:b0:2fe:99cf:f566 with SMTP id 98e67ed59e1d1-3110fc038aemr16525573a91.13.1748319586909;
        Mon, 26 May 2025 21:19:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtzHKCMhM7lTjRKcGgBasFi6e0YR1Sd/MEeaYlrV6Dq/EEUvewEGiIG1rmXoUBqpTXzIhcQYp1H5EASL2RjEA=
X-Received: by 2002:a17:90b:3f0d:b0:2fe:99cf:f566 with SMTP id
 98e67ed59e1d1-3110fc038aemr16525541a91.13.1748319586446; Mon, 26 May 2025
 21:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747822866.git.pabeni@redhat.com> <bb441f9ccadc27bf41eb1937101d1d30fa827af5.1747822866.git.pabeni@redhat.com>
 <CACGkMEv5cXoA7aPOUmE63fRg21Kefx3MNE4VenGciL92WbvS_g@mail.gmail.com> <68620cd9-923e-49df-ad39-482c3fa22be4@redhat.com>
In-Reply-To: <68620cd9-923e-49df-ad39-482c3fa22be4@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 May 2025 12:19:35 +0800
X-Gm-Features: AX0GCFtXFanRd3vbuZMswaN02wOfafzfZIf5yMGAcxvNxyXIVQi6MfkCCgP11V0
Message-ID: <CACGkMEvpr1cqh2CaA6rP03T-dqzKcqkKV6cq+zCfCgAew=+CRw@mail.gmail.com>
Subject: Re: [PATCH net-next 7/8] tun: enable gso over UDP tunnel support.
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 7:20=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 5/26/25 6:40 AM, Jason Wang wrote:
> > On Wed, May 21, 2025 at 6:34=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >>
> >> Add new tun features to represent the newly introduced virtio
> >> GSO over UDP tunnel offload. Allows detection and selection of
> >> such features via the existing TUNSETOFFLOAD ioctl, store the
> >> tunnel offload configuration in the highest bit of the tun flags
> >> and compute the expected virtio header size and tunnel header
> >> offset using such bits, so that we can plug almost seamless the
> >> the newly introduced virtio helpers to serialize the extended
> >> virtio header.
> >>
> >> As the tun features and the virtio hdr size are configured
> >> separately, the data path need to cope with (hopefully transient)
> >> inconsistent values.
> >
> > I'm not sure it's a good idea to deal with this inconsistency in this
> > series as it is not specific to tunnel offloading. It could be a
> > dependency for this patch or we can leave it for the future and just
> > to make sure mis-configuration won't cause any kernel issues.
>
> The possible inconsistency is not due to a misconfiguration, but to the
> facts that:
> - configuring the virtio hdr len and the offload is not atomic
> - successful GSO over udp tunnel parsing requires the relevant offloads
> to be enabled and a suitable hdr len.
>
> Plain GSO don't have a similar problem because all the relevant fields
> are always available for any sane virtio hdr length, but we need to deal
> with them here.

Just to make sure we're on the same page.

I meant tun has TUNSETVNETHDRSZ, so user space can set it to any value
at any time as long as it's not smaller than sizeof(struct
virtio_net_hdr). Tun and vhost need to cope with this otherwise it
should be a bug. This is allowed before the introduction of tunnel
gso.

>
> >> @@ -1698,7 +1700,8 @@ static ssize_t tun_get_user(struct tun_struct *t=
un, struct tun_file *tfile,
> >>         struct sk_buff *skb;
> >>         size_t total_len =3D iov_iter_count(from);
> >>         size_t len =3D total_len, align =3D tun->align, linear;
> >> -       struct virtio_net_hdr gso =3D { 0 };
> >> +       char buf[TUN_VNET_TNL_SIZE];
> >
> > I wonder why not simply
> >
> > 1) define the structure virtio_net_hdr_tnl_gso and use that
> >
> > or
> >
> > 2) stick the gso here and use iter advance to get
> > virtio_net_hdr_tunnel when necessary?
>
> Code wise 2) looks more complex

I don't know how to define complex but we've already use a conatiner struct=
ure:

struct virtio_net_hdr_v1_hash {
        struct virtio_net_hdr_v1 hdr;
        __le32 hash_value;
...
        __le16 hash_report;
        __le16 padding;
};

> and 1) will require additional care when
> adding hash report support.

I don't understand here, you're doing:

        iov_iter_advance(from, sz - parsed_size);

in __tun_vnet_hdr_get(), so this logic needs to be extended for hash
report as well.

>
> >> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> >> index 58b9ac7a5fc40..ab2d4396941ca 100644
> >> --- a/drivers/net/tun_vnet.h
> >> +++ b/drivers/net/tun_vnet.h
> >> @@ -5,6 +5,12 @@
> >>  /* High bits in flags field are unused. */
> >>  #define TUN_VNET_LE     0x80000000
> >>  #define TUN_VNET_BE     0x40000000
> >> +#define TUN_VNET_TNL           0x20000000
> >> +#define TUN_VNET_TNL_CSUM      0x10000000
> >> +#define TUN_VNET_TNL_MASK      (TUN_VNET_TNL | TUN_VNET_TNL_CSUM)
> >> +
> >> +#define TUN_VNET_TNL_SIZE (sizeof(struct virtio_net_hdr_v1) + \
> >
> > Should this be virtio_net_hdr_v1_hash?
>
> If tun does not support HASH_REPORT, no: the GSO over UDP tunnels header
> could be present regardless of the hash-related field presence. This has
> been discussed extensively while crafting the specification.

Ok, so it excludes the hash report fields, more below.

>
> Note that tun_vnet_parse_size() and  tun_vnet_tnl_offset() should be
> adjusted accordingly after that HASH_REPORT support is introduced.

This is suboptimal as we know a hash report will be added so we can
treat the field as anonymous one. See

https://patchwork.kernel.org/project/linux-kselftest/patch/20250307-rss-v9-=
3-df76624025eb@daynix.com/

>
> >> +                          sizeof(struct virtio_net_hdr_tunnel))
> >>
> >>  static inline bool tun_vnet_legacy_is_little_endian(unsigned int flag=
s)
> >>  {
> >> @@ -45,6 +51,13 @@ static inline long tun_set_vnet_be(unsigned int *fl=
ags, int __user *argp)
> >>         return 0;
> >>  }
> >>
> >> +static inline void tun_set_vnet_tnl(unsigned int *flags, bool tnl, bo=
ol tnl_csum)
> >> +{
> >> +       *flags =3D (*flags & ~TUN_VNET_TNL_MASK) |
> >> +                tnl * TUN_VNET_TNL |
> >> +                tnl_csum * TUN_VNET_TNL_CSUM;
> >
> > We could refer to netdev via tun_struct, so I don't understand why we
> > need to duplicate the features in tun->flags (we don't do that for
> > other GSO/CSUM stuffs).
>
> Just to be consistent with commit 60df67b94804b1adca74854db502a72f7aeaa12=
5

I don't see a connection here, the above commit just moves decouple
vnet to make it reusable, it doesn't change the semantic of
tun->flags.

Thanks

>
> /P
>


