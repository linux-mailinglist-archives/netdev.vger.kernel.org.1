Return-Path: <netdev+bounces-197942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E22ADA744
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 06:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D47F16DDD0
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 04:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B47719066B;
	Mon, 16 Jun 2025 04:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxG2C2mO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4DC72607
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 04:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750049657; cv=none; b=Bu9az2HBoM17oFk207sd/O6bsEKffE2WChW1nrIbYCgslvlNksMrxbcDOU6doktG/hYwAihmdcNjsKZ6XkjKEShGhHsxQV83U7195s2ST9C1zBYZHK7jo7DAQXEI5FI0r5PvH5F6pOg5b7MLv8sHitXmI+bsFsv+dDWFIlYqzoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750049657; c=relaxed/simple;
	bh=w6i5tUd7QW7W3YRKg/HLoAyro5ql+lS9uaEkizzq7eQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFUZb4XD3t5OOvt1eYfMEopS/vWtgOY9RsBXRceF2MEXbHImkV4pvcjKbHkRqbxMWK0gCM8wpBHHX1D06qaI8cCm1xxI00soVuTOXgdi5kpYIgkMGu67hVJxFZXd6kuz0VBO0TC5VITjSTx2NWUdvc6kIhcR9KXVe7e1KzUgiL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XxG2C2mO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750049654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fbobQgwbU+rV7Go8/td1SM8YsocSBVLMBvh8vJDrPho=;
	b=XxG2C2mOaJdFh+d75MZQCJXCZDUshSMwldcL5B5hgMe8aQz/eHfKnXynjSLwJ7OIEuPSLZ
	lVazdcb9mmvz8e7/VfazRHmj6jdzbLp20ti4hFn+cB6u1VPeWc1XvtnTaMGzHEtfL3ofY5
	JmRcHYBhxx+6ALEQYKSfQ++v7lQz3h8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-LvCjB4EHPoeMR-T7Mm17PQ-1; Mon, 16 Jun 2025 00:54:13 -0400
X-MC-Unique: LvCjB4EHPoeMR-T7Mm17PQ-1
X-Mimecast-MFC-AGG-ID: LvCjB4EHPoeMR-T7Mm17PQ_1750049652
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23507382e64so36392205ad.2
        for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 21:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750049652; x=1750654452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbobQgwbU+rV7Go8/td1SM8YsocSBVLMBvh8vJDrPho=;
        b=QVNkfdM0CgmIO2I5ZuxI4zjZVkmYllsgXEY55dmvDJ6Sg0NXTcq+zyYWqhSxGetkXJ
         HN39HLR9qLINJM4OoP7c38nO9lrpn2qRvq4q+aFNSS5jRbXw1GBzPElFixU4aP0YtTs1
         qQj2UBP/XI2XwPXpFHhIAI/jS2KHbExWClHjDotxg94OQwC194QBL+WmsZSmYrUxJn6v
         o3tpbKF3eqcsM4kfmKpbuero0VtbW8dMzgB51m38B09CJxVjHvS5lrTu+yZ2/2e3NCw+
         0uM+UzI42olseqpZD8Dwsg5U8gVXM9aYiFuq2PHtePV0TdLC8BXR3T8+yF5gR9x2Cs7Y
         znmA==
X-Gm-Message-State: AOJu0Yw4EGQvP0aJ1+VkSKK1PcmBzx1mecP7YANtykiJQKzDfm5k+SCv
	LuYQvej70jvREW/aIzrdx9+XABJJ/G/iIuLdl5hi9NHIvagvj7T9oUiV8K+zXY6mAFN82Zgd0Gp
	93eMBNIRWctNzzaBfXi+OO6Z5opD4BzCwW6OroNvZ8Kb6XL16dB4cSYP0M+QqldaQN2iSciRtGw
	cUFqUzHLw9uWWJAmaloUpUOLNn+NN8WfVpHHZ0n0PtaQkRqbfw
X-Gm-Gg: ASbGncs08N3T/8X3SRmb55IrqZFCnqolTp8evdAKTZUWulQmvQ//6ydBg0WD+OkSv6v
	JFmlDQHAujUDoqfdeYJcMvLDIHBE+/n6eKItjRX4N6NAvPq23QCZYrNZwyA1v9OqJ4Ufqhztj2R
	3xhQ==
X-Received: by 2002:a17:903:1b0c:b0:234:ba37:879e with SMTP id d9443c01a7336-2366b3c3c7cmr126866495ad.38.1750049651659;
        Sun, 15 Jun 2025 21:54:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPvzCfJQ7KKrJE3bzM+JfRz97/lkM1iy7BYkNrcKKC+Byv5LoRNQmwTvlj6SXGXULlKubj3EzTxe2zmTYMWlE=
X-Received: by 2002:a17:903:1b0c:b0:234:ba37:879e with SMTP id
 d9443c01a7336-2366b3c3c7cmr126866235ad.38.1750049651220; Sun, 15 Jun 2025
 21:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749210083.git.pabeni@redhat.com> <a38c6a4618962237dde1c4077120a3a9d231e2c0.1749210083.git.pabeni@redhat.com>
 <CACGkMEtExmmfmtd0+6YwgjuiWR-T5RvfcnHEbmH=ewqNXHPHYA@mail.gmail.com> <b7099b02-f0d4-492c-a15b-2a93a097d3f5@redhat.com>
In-Reply-To: <b7099b02-f0d4-492c-a15b-2a93a097d3f5@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 16 Jun 2025 12:53:59 +0800
X-Gm-Features: AX0GCFvQuYwGqZ-nzMOW2goumSuaq5gxA1paIPL_v3O-NmNGLsA-SnFm5VN-5Z4
Message-ID: <CACGkMEsuRSOY3xe9=9ONMM3ZBGdyz=5cbTZ0sUp38cYrgtE07w@mail.gmail.com>
Subject: Re: [PATCH RFC v3 7/8] tun: enable gso over UDP tunnel support.
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 7:03=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 6/12/25 6:55 AM, Jason Wang wrote:
> > On Fri, Jun 6, 2025 at 7:46=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >> @@ -1720,8 +1732,16 @@ static ssize_t tun_get_user(struct tun_struct *=
tun, struct tun_file *tfile,
> >>
> >>         if (tun->flags & IFF_VNET_HDR) {
> >>                 int vnet_hdr_sz =3D READ_ONCE(tun->vnet_hdr_sz);
> >> +               int parsed_size;
> >>
> >> -               hdr_len =3D tun_vnet_hdr_get(vnet_hdr_sz, tun->flags, =
from, &gso);
> >> +               if (vnet_hdr_sz < TUN_VNET_TNL_SIZE) {
> >
> > I still don't understand why we need to duplicate netdev features in
> > flags, and it seems to introduce unnecessary complexities. Can we
> > simply check dev->features instead?
> >
> > I think I've asked before, for example, we don't duplicate gso and
> > csum for non tunnel packets.
>
> My fear was that if
> - the guest negotiated VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO
> - tun stores the negotiated offload info netdev->features
> - the tun netdev UDP tunnel feature is disabled via ethtool
>
> tun may end-up sending to the guest packets without filling the tnl hdr,
> which should be safe, as the driver should not use such info as no GSO
> over UDP packets will go through, but is technically against the
> specification.

Probably not? For example this is the way tun works with non tunnel GSO as =
well.

(And it allows the flexibility of debugging etc).

>
> The current implementation always zero the whole virtio net hdr space,
> so there is no such an issue.
>
> Still the additional complexity is ~5 lines and makes all the needed
> information available on a single int, which is quite nice performance
> wise. Do you have strong feeling against it?

See above and at least we can disallow the changing of UDP tunnel GSO
(but I don't see too much value).

>
> >> @@ -2426,7 +2460,16 @@ static int tun_xdp_one(struct tun_struct *tun,
> >>         if (metasize > 0)
> >>                 skb_metadata_set(skb, metasize);
> >>
> >> -       if (tun_vnet_hdr_to_skb(tun->flags, skb, gso)) {
> >> +       /* Assume tun offloads are enabled if the provided hdr is larg=
e
> >> +        * enough.
> >> +        */
> >> +       if (READ_ONCE(tun->vnet_hdr_sz) >=3D TUN_VNET_TNL_SIZE &&
> >> +           xdp->data - xdp->data_hard_start >=3D TUN_VNET_TNL_SIZE)
> >> +               flags =3D tun->flags | TUN_VNET_TNL_MASK;
> >> +       else
> >> +               flags =3D tun->flags & ~TUN_VNET_TNL_MASK;
> >
> > I'm not sure I get the point that we need dynamics of
> > TUN_VNET_TNL_MASK here. We know if tunnel gso and its csum or enabled
> > or not,
>
> How does tun know about VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO or
> VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM?

I think it can be done in a way that works for non-tunnel gso.

The most complicated case is probably the case HOST_UDP_TUNNEL_X is
enabled but GUEST_UDP_TUNNEL_X is not. In this case tun can know this
by:

1) vnet_hdr_len is large enough
2) UDP tunnel GSO is not enabled in netdev->features

If HOST_UDP_TUNNEL_X is not enabled by GUEST_UDP_TUNNEL_X is enabled,
it can behave like existing non-tunnel GSO: still accept the UDP GSO
tunnel packet.

>
> The user-space does not tell the tun device about any of the host
> offload features. Plain/baremetal GSO information are always available
> in the basic virtio net header, so there is no size check, but the
> overall behavior is similar - tun assumes the features have been
> negotiated if the relevant bits are present in the header.

I'm not sure I understand here, there's no bit in the virtio net
header that tells us if the packet contains the tunnel gso field. And
the check of:

READ_ONCE(tun->vnet_hdr_sz) >=3D TUN_VNET_TNL_SIZE

seems to be not buggy. As qemu already did:

static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
                                       int version_1, int hash_report)
{
    int i;
    NetClientState *nc;

    n->mergeable_rx_bufs =3D mergeable_rx_bufs;

    if (version_1) {
        n->guest_hdr_len =3D hash_report ?
            sizeof(struct virtio_net_hdr_v1_hash) :
            sizeof(struct virtio_net_hdr_mrg_rxbuf);
        n->rss_data.populate_hash =3D !!hash_report;

...

>
> Here before checking the relevant bit we ensures we have enough vitio
> net hdr data - that makes the follow-up test simpler.
>
> > and we know the vnet_hdr_sz here, we can simply drop the
> > packet with less header.
>
> That looks prone migration or connectivity issue, and different from the
> current general behavior of always accepting any well formed packet even
> if shorter than what is actually negotiated (i.e. tun accepts packets
> with just virtio_net_hdr header even when V1 has been negotiated).

Tun doesn't know V1, it can only see vnet_hdr_len, it is the userspace
(Qemu) that needs to configure all parties correctly. So I meant if we
get a XDP buff with less header, it should be more like a userspace
(Qemu) but. I'm not sure we need to workaround it by kernel.

Thanks

>
> /P
>


