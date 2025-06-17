Return-Path: <netdev+bounces-198401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36610ADBFD4
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 05:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264383B473D
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A601D143C61;
	Tue, 17 Jun 2025 03:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+sljC5K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792C58BEC
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 03:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750130684; cv=none; b=Juzn/dIbCmn52lu6p3vG7m8plla5UMTQvFRretd28ZdB4azc+tZ7o6mwIA9Xn1sr3JAtok8Siaqyd5+1QzdDh4D87zGu74z5tYbNp52e0koQl9tYVWFJh6D19M2T8N+HejUJOQ0yJZqj5Zl/VmxLkhDfovRv7DRBzIAWf2w7zlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750130684; c=relaxed/simple;
	bh=as3teyKqrzFl9S++ScMVJ5X58cpYf1CU1ICfBaOlV4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITixr7I/UFFG4IDG+hMTHcESK3QI7WMBVWvJ/mVty90DhjZMvKv/KH7M/eR91raYA4wUrC06FK/NL2snBEuGjHoBhSNbdXA4mcdfsS9292OP06MSGgag7HCfSUEf2W3FcS++60og4hCmnenEBjb/9/jrIr7anVB69Lr5o+U7rBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+sljC5K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750130681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IES4OEcARwBvPnsidi2m6ybrD+CM/2ggk1lkfoCToGg=;
	b=Q+sljC5K7lK8vn5adGgaXjIpn9P/74siwJ1PJEfKyOmUS2WSfdw4h0T4Vi8cfCvYfSFB1I
	A1SA70TrAQJS0ES00VHeOhzSOTyZAyqqE/UqjZX7XfTLeU8C/Dy55T/13IU2g8CRLm9WFf
	mJ83rR4265ikQYLfi8LVJB3t2sWEAcM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-CGTCV7fsMhSbq1WOaqVrHg-1; Mon, 16 Jun 2025 23:24:39 -0400
X-MC-Unique: CGTCV7fsMhSbq1WOaqVrHg-1
X-Mimecast-MFC-AGG-ID: CGTCV7fsMhSbq1WOaqVrHg_1750130678
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b3184712fd8so1962703a12.3
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 20:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750130678; x=1750735478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IES4OEcARwBvPnsidi2m6ybrD+CM/2ggk1lkfoCToGg=;
        b=jorK6LUYov2dkWGvyOWHJipQhvmSmyECT3w+bQ/6x9lC8ypwoB2UIB5HyxPZFOQcDh
         fVkCsexuseuQyUSk3a3tzgO4+vcuNINwCW9ITkMIo+FW+AwmxHleVqMxVWSAtws+y8mP
         S6/qrsJnUCz2CKMbqVJMC27cgwZiWWszQdl5ov68MiL4dF7Uffjvdv5LJZL8c55WmTfD
         9RZ1e0RQsu7DIKwya7aZ5Jli8+mo+O5Nv1NViIhzcy4J28W54ykSkIDMi0w8h9ZRVvEf
         YptGw3DrvBqJnjsU5Z7TAzXDmBDM0K6dCI9VnsPKufqzN3Fk32y8vlOzl9hVmSdggF2D
         XgnA==
X-Forwarded-Encrypted: i=1; AJvYcCW1XcxbJuIVFdYlQhhpjQENjwKRcEmrb13p8Dkihh/xQp73htRvom6i1He+HCOZfoqonmMFExU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc2ruXCObdKRZjGhHWWctReoTguyUgi3IlhVPEhXiIGvAzjk7x
	W+zILi2d36PXt5dKpTGZBSzNE5/O+zoJQgJoibv96buD/AQcxvNsoLpgpd5cLl10Zu0sqOtfqkf
	+ohBJH9fF2G9aJaY6R0GJ6+WMVcm/uugbbtdpB5gfBFj9qOigmMiXl6FrOlkpNpvDudOabeCN3b
	0BQ3wS+/nTYRdrMVE5wS6/bNxRcZmVdAGQ
X-Gm-Gg: ASbGncurO/7O1hO1fwocMhtD1cWO85/x4P4vhUq90Cxzpqbsjhtb1OI4BTyTiyM/O6+
	yoRdxgctDy0ABc8PeXgB9PERSrXg2fuUH6/lT4DoUfc3ATxkostQYLZ6o5wcgSbzSktAMfCOYDL
	/w5gQZ
X-Received: by 2002:a05:6a21:b90:b0:21f:a883:d1dd with SMTP id adf61e73a8af0-21fbd4ddac8mr18709484637.14.1750130678310;
        Mon, 16 Jun 2025 20:24:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoYPOIsM1+IfFJw9di/BhSKLHCBv/fkorMNtLJsixKJrzAf0ZzDxBP/7z6vbIkblCH36IxZAQcT4RIar7X+wg=
X-Received: by 2002:a05:6a21:b90:b0:21f:a883:d1dd with SMTP id
 adf61e73a8af0-21fbd4ddac8mr18709446637.14.1750130677879; Mon, 16 Jun 2025
 20:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749210083.git.pabeni@redhat.com> <a38c6a4618962237dde1c4077120a3a9d231e2c0.1749210083.git.pabeni@redhat.com>
 <CACGkMEtExmmfmtd0+6YwgjuiWR-T5RvfcnHEbmH=ewqNXHPHYA@mail.gmail.com>
 <b7099b02-f0d4-492c-a15b-2a93a097d3f5@redhat.com> <CACGkMEsuRSOY3xe9=9ONMM3ZBGdyz=5cbTZ0sUp38cYrgtE07w@mail.gmail.com>
 <1f0933e0-ab58-41b8-832b-5336618be8b3@redhat.com>
In-Reply-To: <1f0933e0-ab58-41b8-832b-5336618be8b3@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Jun 2025 11:24:26 +0800
X-Gm-Features: AX0GCFtjFokecGrFCmamqCZX8pF_HH4pzNmqNAq-QMWcWQ9TLHUTMikpe8W9ic0
Message-ID: <CACGkMEv1m0RBWeuzgH2XnbsKZXo79Q3xqmzAPb+C5gOtUzm8WQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 7/8] tun: enable gso over UDP tunnel support.
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 6:17=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 6/16/25 6:53 AM, Jason Wang wrote:
> > On Thu, Jun 12, 2025 at 7:03=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 6/12/25 6:55 AM, Jason Wang wrote:
> >>> On Fri, Jun 6, 2025 at 7:46=E2=80=AFPM Paolo Abeni <pabeni@redhat.com=
> wrote:
> >>>> @@ -1720,8 +1732,16 @@ static ssize_t tun_get_user(struct tun_struct=
 *tun, struct tun_file *tfile,
> >>>>
> >>>>         if (tun->flags & IFF_VNET_HDR) {
> >>>>                 int vnet_hdr_sz =3D READ_ONCE(tun->vnet_hdr_sz);
> >>>> +               int parsed_size;
> >>>>
> >>>> -               hdr_len =3D tun_vnet_hdr_get(vnet_hdr_sz, tun->flags=
, from, &gso);
> >>>> +               if (vnet_hdr_sz < TUN_VNET_TNL_SIZE) {
> >>>
> >>> I still don't understand why we need to duplicate netdev features in
> >>> flags, and it seems to introduce unnecessary complexities. Can we
> >>> simply check dev->features instead?
> >>>
> >>> I think I've asked before, for example, we don't duplicate gso and
> >>> csum for non tunnel packets.
> >>
> >> My fear was that if
> >> - the guest negotiated VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO
> >> - tun stores the negotiated offload info netdev->features
> >> - the tun netdev UDP tunnel feature is disabled via ethtool
> >>
> >> tun may end-up sending to the guest packets without filling the tnl hd=
r,
> >> which should be safe, as the driver should not use such info as no GSO
> >> over UDP packets will go through, but is technically against the
> >> specification.
> >
> > Probably not? For example this is the way tun works with non tunnel GSO=
 as well.
> >
> > (And it allows the flexibility of debugging etc).
> >
> >>
> >> The current implementation always zero the whole virtio net hdr space,
> >> so there is no such an issue.
> >>
> >> Still the additional complexity is ~5 lines and makes all the needed
> >> information available on a single int, which is quite nice performance
> >> wise. Do you have strong feeling against it?
> >
> > See above and at least we can disallow the changing of UDP tunnel GSO
> > (but I don't see too much value).
>
> I'm sorry, but I don't understand what is the suggestion/request here.
> Could you please phrase it?

I meant I don't see strong reasons to duplicate tunnel gso/csum in tun->fla=
gs:

1) extra complexity
2) non tunnel gso doesn't do this (and for macvtap, it tries to
emulate netdev->features)
3) we can find way to disallow toggling tunnel gso/csum via ethtool
(but I don't see too much value)

>
> Also please allow me to re-state my main point. The current
> implementation adds a very limited amount of code in the control path,
> and makes the data path simpler and faster - requiring no new argument
> to the tun_hdr_* helper instead of (at least) one as the other alternativ=
e.
>
> It looks like tun_hdr_* argument list could grow with every new feature,
> but I think we should try to avoid that.

See above:

1) for HOST_UDP_XXX we can assume it is enabled
2) for GUEST_UDP_XXX we can check netdev->features

So passing netdev->features seems to be sufficient, it avoids
introducing new argument when a new offload is supported in the
future.

>
> >>>> @@ -2426,7 +2460,16 @@ static int tun_xdp_one(struct tun_struct *tun=
,
> >>>>         if (metasize > 0)
> >>>>                 skb_metadata_set(skb, metasize);
> >>>>
> >>>> -       if (tun_vnet_hdr_to_skb(tun->flags, skb, gso)) {
> >>>> +       /* Assume tun offloads are enabled if the provided hdr is la=
rge
> >>>> +        * enough.
> >>>> +        */
> >>>> +       if (READ_ONCE(tun->vnet_hdr_sz) >=3D TUN_VNET_TNL_SIZE &&
> >>>> +           xdp->data - xdp->data_hard_start >=3D TUN_VNET_TNL_SIZE)
> >>>> +               flags =3D tun->flags | TUN_VNET_TNL_MASK;
> >>>> +       else
> >>>> +               flags =3D tun->flags & ~TUN_VNET_TNL_MASK;
> >>>
> >>> I'm not sure I get the point that we need dynamics of
> >>> TUN_VNET_TNL_MASK here. We know if tunnel gso and its csum or enabled
> >>> or not,
> >>
> >> How does tun know about VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO or
> >> VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM?
> >
> > I think it can be done in a way that works for non-tunnel gso.
> >
> > The most complicated case is probably the case HOST_UDP_TUNNEL_X is
> > enabled but GUEST_UDP_TUNNEL_X is not. In this case tun can know this
> > by:
> >
> > 1) vnet_hdr_len is large enough
> > 2) UDP tunnel GSO is not enabled in netdev->features
> >
> > If HOST_UDP_TUNNEL_X is not enabled by GUEST_UDP_TUNNEL_X is enabled,
> > it can behave like existing non-tunnel GSO: still accept the UDP GSO
> > tunnel packet.
>
> AFAICS the text above matches/describes quite accurately the
> implementation proposed in this patch and quoted above. Which in turn
> confuses me, because I don't see what you would prefer to see
> implemented differently.

I meant those can be done without using tun->flags.

>
> >> The user-space does not tell the tun device about any of the host
> >> offload features. Plain/baremetal GSO information are always available
> >> in the basic virtio net header, so there is no size check, but the
> >> overall behavior is similar - tun assumes the features have been
> >> negotiated if the relevant bits are present in the header.
> >
> > I'm not sure I understand here, there's no bit in the virtio net
> > header that tells us if the packet contains the tunnel gso field. And
> > the check of:
> >
> > READ_ONCE(tun->vnet_hdr_sz) >=3D TUN_VNET_TNL_SIZE
> >
> > seems to be not buggy. As qemu already did:
> >
> > static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_b=
ufs,
> >                                        int version_1, int hash_report)
> > {
> >     int i;
> >     NetClientState *nc;
> >
> >     n->mergeable_rx_bufs =3D mergeable_rx_bufs;
> >
> >     if (version_1) {
> >         n->guest_hdr_len =3D hash_report ?
> >             sizeof(struct virtio_net_hdr_v1_hash) :
> >             sizeof(struct virtio_net_hdr_mrg_rxbuf);
> >         n->rss_data.populate_hash =3D !!hash_report;
> >
> > ...
>
> Note that the qemu code quoted above does not include tunnel handling.
>
> TUN_VNET_TNL_SIZE (=3D=3D sizeof(struct virtio_net_hdr_v1_tunnel)) will b=
e
> too small when VIRTIO_NET_F_HASH_REPORT is enabled, too.
>
> I did not handle that case here, due to the even greater overlapping with=
:
>
> https://lore.kernel.org/netdev/20250530-rss-v12-0-95d8b348de91@daynix.com=
/
>
> What I intended to do is:
> - set another bit in `flags` according to the negotiated
> VIRTIO_NET_F_HASH_REPORT value
> - use such info in tun_vnet_parse_size() to computed the expected vnet
> hdr len correctly.
> - replace TUN_VNET_TNL_SIZE usage in tun.c with tun_vnet_parse_size() cal=
ls
>
> I'm unsure if the above answer your question/doubt.

For hash reporting since we don't have a netdev feature for that, a
new argument for tun_hdr_XXX() is probably needed for that

>
> Anyhow I now see that keeping the UDP GSO related fields offset constant
> regardless of VIRTIO_NET_F_HASH_REPORT would remove some ambiguity from
> the relevant control path.

Not a native speaker but I think the ambiguity mainly come from the
"Only if" that is something like

"Only if VIRTIO_NET_F_HASH_REPORT negotiated"

>
> I think/hope we are still on time to update the specification clarifying
> that, but I'm hesitant to take that path due to the additional
> (hopefully small) overhead for the data path - and process overhead TBH.
>
> On the flip (positive) side such action will decouple more this series
> from the HASH_REPORT support.
>
> Please advice, thanks!
>
> /P
>

Thanks


