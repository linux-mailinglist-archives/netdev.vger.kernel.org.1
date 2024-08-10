Return-Path: <netdev+bounces-117390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FFD94DB4A
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 10:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61CD21F221AF
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 08:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB1314A4DD;
	Sat, 10 Aug 2024 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqQua/SI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8EB146D6B
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723276938; cv=none; b=D9D36jqhWdaf98z9ys6dKJOH64YJM5hDQXVSc6IEdDKkDfI6MU5c8Z5bAwiHhQlqzUG3vzW7HMHwRlDxi3+UR6N4xg0fJbA0fmwEVlSw/wKmsKP1nRSAdjfAGNW5vcNEprL4yppnXzbArxKjqn76AB0dUGEmt9tDw3RzLGFlMiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723276938; c=relaxed/simple;
	bh=ScafrKHLDmywyJAhuxq8zU3jN37C4ehxZ+0tG7NIiUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8fq/6exqShVaUNUAaQIFzC1LbJJXTNGaeJHA/xnTCSB2j7daWTcQSzpxbjHUKxyrB7KRgsHO+Xz3ezFHrKZzJY1su4M2uYfAGKF4+Egrx6v4xLHKQHK5w1ZEgdsa3X/PUNYwREjGiDNwLHOaCaWYj/Lg9RYErfBLXrXg4s/AOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cqQua/SI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723276936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UPjljH6iA3oWOviZCmtQ15dhjMJkybfiIUkL/U+qP9w=;
	b=cqQua/SIZ3YCxCbWKnz84NhIikWymA0JRlV+TzTflbs0t922ghe3kziLHkO7ZuWbS+FxJ1
	ShdUEx4R/l7bOBdO+r61Cnrhv7Gz3VxyMhrVRixNjBRR/b99QotmZG3RzsDULp4lmXWgA/
	4b9GqDs2VCH41+MuayyR3L8VCkno1P8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-tTS2cQP-NfWOMupnNZ-BTw-1; Sat, 10 Aug 2024 04:02:14 -0400
X-MC-Unique: tTS2cQP-NfWOMupnNZ-BTw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4282164fcbcso21136335e9.2
        for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 01:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723276933; x=1723881733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPjljH6iA3oWOviZCmtQ15dhjMJkybfiIUkL/U+qP9w=;
        b=kjpsz+aYOr6sYTjye7+5ktcgq3gYLrTHsNIXfa0lb8DIwclHxcBwpwNWrXXmWfgwNb
         15Utgx0kIk635CCNvzaea6pRlxygv0S7WlMo826UdpXy3A/we1MrqF/vRhsxIKY3wUc8
         bF8br1SZ67X3hdBoNfSsF00YSOGP0fSY4ehpb1QOUMfugNWwWvGBnQF/VAuWq/bygMOq
         wP9MxO3O4kT9h3XX8TWy83nnV5SsHyOI3NreC1kYWye7A5HhdCv/2nIEmwGsH8NC1vSs
         ljBzKGem0vr+kK5s1CBpnYkYBEyvdSVr2ZF/zrCo6MVnCsMXlEScoQNnV8N5X10DlcF4
         PikQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmQjSxGIuXUVLqFhFtMgSlrL6rrkKnNO1+gqo7XYg9VRQz2noXuh55PJl591TsAEboDQ1xM+t/ONcqktFFWvBPNuFAGTID
X-Gm-Message-State: AOJu0YxFAQZJRbK0N820Rakd+AOk1/ZIoGOsXFRQkVNx1K21qUHQePjI
	84Y45uZi2sCXgPnGRx9KKSvZfQVYOnOKclJfpqbVOef8qg+WC5u4xvQ59Kocmk0cYcBspsJTukD
	6FLhKcdYzyZhxCbh+lWzWi01PLIM0CSxUipWm/U8fZpiYOxMRicwkiw==
X-Received: by 2002:a05:600c:c1b:b0:426:6822:861 with SMTP id 5b1f17b1804b1-429c3a5a0eemr24962645e9.36.1723276933050;
        Sat, 10 Aug 2024 01:02:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEswwbJndKkTgRmb2GZMwgJGUmCsGI2khfChZ1jJnnBT6x87O9kGvzmqv4CHnpklOnjHkE8XA==
X-Received: by 2002:a05:600c:c1b:b0:426:6822:861 with SMTP id 5b1f17b1804b1-429c3a5a0eemr24962345e9.36.1723276932491;
        Sat, 10 Aug 2024 01:02:12 -0700 (PDT)
Received: from localhost (53.116.107.80.static.otenet.gr. [80.107.116.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c750f0absm19507625e9.17.2024.08.10.01.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 01:02:12 -0700 (PDT)
Date: Sat, 10 Aug 2024 10:02:09 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xdp-hints@xdp-project.net
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch
 to GRO from netif_receive_skb_list()
Message-ID: <ZrcegfBkreaOmRgV@lore-rh-laptop>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
 <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
 <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>
 <308fd4f1-83a9-4b74-a482-216c8211a028@app.fastmail.com>
 <99662019-7e9b-410d-99fe-a85d04af215c@intel.com>
 <875xs9q2z6.fsf@toke.dk>
 <22333deb-21f8-43a9-b32f-bc3e60892661@intel.com>
 <8734ndq0cd.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4vCVb17oaXeHlWt+"
Content-Disposition: inline
In-Reply-To: <8734ndq0cd.fsf@toke.dk>


--4vCVb17oaXeHlWt+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 09, Toke wrote:
> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
>=20
> > From: Toke H=F8iland-J=F8rgensen <toke@redhat.com>
> > Date: Fri, 09 Aug 2024 14:45:33 +0200
> >
> >> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
> >>=20
> >>> From: Daniel Xu <dxu@dxuuu.xyz>
> >>> Date: Thu, 08 Aug 2024 16:52:51 -0400
> >>>
> >>>> Hi,
> >>>>
> >>>> On Thu, Aug 8, 2024, at 7:57 AM, Alexander Lobakin wrote:
> >>>>> From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
> >>>>> Date: Thu, 8 Aug 2024 06:54:06 +0200
> >>>>>
> >>>>>>> Hi Alexander,
> >>>>>>>
> >>>>>>> On Tue, Jun 28, 2022, at 12:47 PM, Alexander Lobakin wrote:
> >>>>>>>> cpumap has its own BH context based on kthread. It has a sane ba=
tch
> >>>>>>>> size of 8 frames per one cycle.
> >>>>>>>> GRO can be used on its own, adjust cpumap calls to the
> >>>>>>>> upper stack to use GRO API instead of netif_receive_skb_list() w=
hich
> >>>>>>>> processes skbs by batches, but doesn't involve GRO layer at all.
> >>>>>>>> It is most beneficial when a NIC which frame come from is XDP
> >>>>>>>> generic metadata-enabled, but in plenty of tests GRO performs be=
tter
> >>>>>>>> than listed receiving even given that it has to calculate full f=
rame
> >>>>>>>> checksums on CPU.
> >>>>>>>> As GRO passes the skbs to the upper stack in the batches of
> >>>>>>>> @gro_normal_batch, i.e. 8 by default, and @skb->dev point to the
> >>>>>>>> device where the frame comes from, it is enough to disable GRO
> >>>>>>>> netdev feature on it to completely restore the original behaviou=
r:
> >>>>>>>> untouched frames will be being bulked and passed to the upper st=
ack
> >>>>>>>> by 8, as it was with netif_receive_skb_list().
> >>>>>>>>
> >>>>>>>> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> >>>>>>>> ---
> >>>>>>>>  kernel/bpf/cpumap.c | 43 ++++++++++++++++++++++++++++++++++++++=
-----
> >>>>>>>>  1 file changed, 38 insertions(+), 5 deletions(-)
> >>>>>>>>
> >>>>>>>
> >>>>>>> AFAICT the cpumap + GRO is a good standalone improvement. I think
> >>>>>>> cpumap is still missing this.
> >>>>>
> >>>>> The only concern for having GRO in cpumap without metadata from the=
 NIC
> >>>>> descriptor was that when the checksum status is missing, GRO calcul=
ates
> >>>>> the checksum on CPU, which is not really fast.
> >>>>> But I remember sometimes GRO was faster despite that.
> >>>>
> >>>> Good to know, thanks. IIUC some kind of XDP hint support landed alre=
ady?
> >>>>
> >>>> My use case could also use HW RSS hash to avoid a rehash in XDP prog.
> >>>
> >>> Unfortunately, for now it's impossible to get HW metadata such as RSS
> >>> hash and checksum status in cpumap. They're implemented via kfuncs
> >>> specific to a particular netdevice and this info is available only wh=
en
> >>> running XDP prog.
> >>>
> >>> But I think one solution could be:
> >>>
> >>> 1. We create some generic structure for cpumap, like
> >>>
> >>> struct cpumap_meta {
> >>> 	u32 magic;
> >>> 	u32 hash;
> >>> }
> >>>
> >>> 2. We add such check in the cpumap code
> >>>
> >>> 	if (xdpf->metalen =3D=3D sizeof(struct cpumap_meta) &&
> >>> 	    <here we check magic>)
> >>> 		skb->hash =3D meta->hash;
> >>>
> >>> 3. In XDP prog, you call Rx hints kfuncs when they're available, obta=
in
> >>> RSS hash and then put it in the struct cpumap_meta as XDP frame metad=
ata.
> >>=20
> >> Yes, except don't make this cpumap-specific, make it generic for kernel
> >> consumption of the metadata. That way it doesn't even have to be stored
> >> in the xdp metadata area, it can be anywhere we want (and hence not
> >> subject to ABI issues), and we can use it for skb creation after
> >> redirect in other places than cpumap as well (say, on veth devices).
> >>=20
> >> So it'll be:
> >>=20
> >> struct kernel_meta {
> >> 	u32 hash;
> >> 	u32 timestamp;
> >>         ...etc
> >> }
> >>=20
> >> and a kfunc:
> >>=20
> >> void store_xdp_kernel_meta(struct kernel meta *meta);
> >>=20
> >> which the XDP program can call to populate the metadata area.
> >
> > Hmm, nice!
> >
> > But where to store this info in case of cpumap if not in xdp->data_meta?
> > When you convert XDP frames to skbs in the cpumap code, you only have
> > &xdp_frame and that's it. XDP prog was already run earlier from the
> > driver code at that point.
>=20
> Well, we could put it in skb_shared_info? IIRC, some of the metadata
> (timestamps?) end up there when building an skb anyway, so we won't even
> have to copy it around...

Before vacation I started looking into it a bit, I will resume this work in=
 one
week or so.

Regards,
Lorenzo

>=20
> -Toke
>=20

--4vCVb17oaXeHlWt+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZrcefgAKCRA6cBh0uS2t
rAWhAQCetdkAp+Z/1Ns5m03sBessZJS+q8gRJodpZZdXxU1EuAEAvK0zIPcM7BiO
hwuk4Jk43IjVvL7JR6J8TLYC7G85KA4=
=qu8K
-----END PGP SIGNATURE-----

--4vCVb17oaXeHlWt+--


