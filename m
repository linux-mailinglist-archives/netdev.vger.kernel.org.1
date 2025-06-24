Return-Path: <netdev+bounces-200471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 364D1AE58DB
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 02:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90033AED0C
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 00:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A946F06A;
	Tue, 24 Jun 2025 00:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpamkmc/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F65179A3
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 00:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750726577; cv=none; b=HJCYr6M72IC8S03wjKD9GEQRf9JcKkzgolO0SCAU0SbYg32fZBMYP9+BQ5z21Rmdl/CIy0jh++kmkVKOJnmkf/lVl/N3jEsRr7RAcb0S3nUC8BVKTGX9IxRixxdk3sMNHySeaVsDGbj5qDsmXtRQV1A4buYCUtDhaQjrLhkk8qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750726577; c=relaxed/simple;
	bh=LPp/B+WutxF6LjQc4j5NKhQYu2SHxH52+JiCjW4r/pI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKQq+SGBx9PSSSXCpOqIrnCq6zuEaGrUNvSiS6pvhiueTKRojlO0q8QLmuWudcsEFE/g9kPNt/CnCP0ChvjX92ycwk3wrE4e4rAE+V2Kg8vwxOI1tSkSEvUUwxIfykhUzJsErDHd2A+zZkcdLTM3Pu1HFvahY88XbCmohgW3U10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gpamkmc/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750726573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/trHkhW0KAetBMV1mf5CCTz8jxKg2YXFh0RM8C9OA1c=;
	b=gpamkmc/hOpqXLMZ6hHenJkoxjYVtW1va88LBhbPD62XPKxNatN3VEYXWPPXWTHl6zCIXr
	epCaAYiXpwzSLYk9wMXQtQYav/3ffQyUQDf9P8aEibBejjsYK2/3F6jgMuTsuEzPFkqLeI
	Ko45Y6nKXyPYUOkffn7FRMXAAtmcJT0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-xYkpLtfqNo6e5nvaDikp3g-1; Mon, 23 Jun 2025 20:56:11 -0400
X-MC-Unique: xYkpLtfqNo6e5nvaDikp3g-1
X-Mimecast-MFC-AGG-ID: xYkpLtfqNo6e5nvaDikp3g_1750726571
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b31e1ef8890so2966177a12.2
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 17:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750726571; x=1751331371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/trHkhW0KAetBMV1mf5CCTz8jxKg2YXFh0RM8C9OA1c=;
        b=a8q9+3ixHeMjMjX5Rf5F+M0vE8U+22D+xl6R/wXtzE6vySTKBcPqunCDu7x+/c1Vwl
         L+AOUtYL/toHgIhamAiyyJNep1W++UAliyTVABZtavcRsls+vIRItCf/ZbT0UNW4iJVh
         NvFBzY5X0kRzxfBfGdyfroHrMC9lMTY/NHjanCDeZloNpk2mg0ZJLDt0cHVmBS+r8QGG
         ADHRxh0Fs/1R29HZJRDH/YVOzNX5op3g04/WytRaARj2tgEx4Ql5Ic9jylP2liW25RbT
         61Og23tq8QJAm1C5r6zAjp/H8JIqnCq+8gVObEOJ3R3o7gH1JIfxFmgompjBaldFMFUC
         Q8DA==
X-Forwarded-Encrypted: i=1; AJvYcCX8tc0ojECCdSvFwwsJeVqDy2FWyZF9OsbKK1WRpQ4zRLX8CQ4W2I/NteQKzzu7Z6OmPL9DgBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM/2JqesZy1O6vV87k6F5W1phQhk0Xhyg1ePTb/JFUnU8pE5Vj
	88K6QSu22XhLNLRdEblSdTaioLLrpoNz6LLyRsPanJOfug5Zlh2e7rWHdJc4IoUJeii6WX1GYJS
	FMl6iMjTZq2xjJG3hYwOLnTmKjwQKBDJcZgNTr5ACDTw4R+ejE44//lW5HBUTSR0AyI1sgALiZV
	Dd/6e+8Pr0t1bF9nO2eYA6hQ1x7vrMAqQ4
X-Gm-Gg: ASbGnct0Q/HmR+j3SSZncBcl537QpphzWE2p7y7YtDpb9hImPv5SUASA38ceA54Uo+e
	duwgEjAf/Q6/kj+X4v0WwbWBzc5bIQZmocYyacD/eiADXwgy3JjB3AOQNcRKN1TFQZu8kWI4ZOe
	TkUKh5
X-Received: by 2002:a17:90b:274b:b0:313:28f1:fc1b with SMTP id 98e67ed59e1d1-3159d6481eamr23311858a91.9.1750726570326;
        Mon, 23 Jun 2025 17:56:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmp+TkCzc61bwTpkk7Gk2l98/dZPn/8p4VCGf0Sf2GnbykogqxG56BFIgucQz7H5EwnpyKCDY1KYewAOXrzXk=
X-Received: by 2002:a17:90b:274b:b0:313:28f1:fc1b with SMTP id
 98e67ed59e1d1-3159d6481eamr23311816a91.9.1750726569767; Mon, 23 Jun 2025
 17:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750176076.git.pabeni@redhat.com> <1c6ffd4bd0480ecc4c8442cef7c689fbfb5e0e56.1750176076.git.pabeni@redhat.com>
 <add3a48e-f16a-4e32-91d4-fc34b1ff3ce6@daynix.com>
In-Reply-To: <add3a48e-f16a-4e32-91d4-fc34b1ff3ce6@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Jun 2025 08:55:57 +0800
X-Gm-Features: AX0GCFtPoNZJHTuoh0AkLLKjxLunjVH-cXHU3aAWcTEB-w7wdjGJNzf6EK6VuMQ
Message-ID: <CACGkMEs4_Zs_YpjV7CfXu7ycZxgtxqyScTi5CULdz9ZrUoHW6w@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 7/8] tun: enable gso over UDP tunnel support.
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 12:03=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> On 2025/06/18 1:12, Paolo Abeni wrote:
> > Add new tun features to represent the newly introduced virtio
> > GSO over UDP tunnel offload. Allows detection and selection of
> > such features via the existing TUNSETOFFLOAD ioctl and compute
> > the expected virtio header size and tunnel header offset using
> > the current netdev features, so that we can plug almost seamless
> > the newly introduced virtio helpers to serialize the extended
> > virtio header.
> >
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v3 -> v4:
> >    - virtio tnl-related fields are at fixed offset, cleanup
> >      the code accordingly.
> >    - use netdev features instead of flags bit to check for
> >      the configured offload
> >    - drop packet in case of enabled features/configured hdr
> >      size mismatch
> >
> > v2 -> v3:
> >    - cleaned-up uAPI comments
> >    - use explicit struct layout instead of raw buf.
> > ---
> >   drivers/net/tun.c           | 70 ++++++++++++++++++++++++-----
> >   drivers/net/tun_vnet.h      | 88 +++++++++++++++++++++++++++++++++---=
-
> >   include/uapi/linux/if_tun.h |  9 ++++
> >   3 files changed, 148 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index f8c5e2fd04df..bae0370a8152 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -186,7 +186,8 @@ struct tun_struct {
> >       struct net_device       *dev;
> >       netdev_features_t       set_features;
> >   #define TUN_USER_FEATURES (NETIF_F_HW_CSUM|NETIF_F_TSO_ECN|NETIF_F_TS=
O| \
> > -                       NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4)
> > +                       NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4 | \
> > +                       NETIF_F_GSO_UDP_TUNNEL | NETIF_F_GSO_UDP_TUNNEL=
_CSUM)
> >
> >       int                     align;
> >       int                     vnet_hdr_sz;
> > @@ -925,6 +926,7 @@ static int tun_net_init(struct net_device *dev)
> >       dev->hw_features =3D NETIF_F_SG | NETIF_F_FRAGLIST |
> >                          TUN_USER_FEATURES | NETIF_F_HW_VLAN_CTAG_TX |
> >                          NETIF_F_HW_VLAN_STAG_TX;
> > +     dev->hw_enc_features =3D dev->hw_features;
> >       dev->features =3D dev->hw_features;
> >       dev->vlan_features =3D dev->features &
> >                            ~(NETIF_F_HW_VLAN_CTAG_TX |
> > @@ -1698,7 +1700,8 @@ static ssize_t tun_get_user(struct tun_struct *tu=
n, struct tun_file *tfile,
> >       struct sk_buff *skb;
> >       size_t total_len =3D iov_iter_count(from);
> >       size_t len =3D total_len, align =3D tun->align, linear;
> > -     struct virtio_net_hdr gso =3D { 0 };
> > +     struct virtio_net_hdr_v1_hash_tunnel hdr;
> > +     struct virtio_net_hdr *gso;
> >       int good_linear;
> >       int copylen;
> >       int hdr_len =3D 0;
> > @@ -1708,6 +1711,15 @@ static ssize_t tun_get_user(struct tun_struct *t=
un, struct tun_file *tfile,
> >       int skb_xdp =3D 1;
> >       bool frags =3D tun_napi_frags_enabled(tfile);
> >       enum skb_drop_reason drop_reason =3D SKB_DROP_REASON_NOT_SPECIFIE=
D;
> > +     netdev_features_t features =3D 0;
> > +
> > +     /*
> > +      * Keep it easy and always zero the whole buffer, even if the
> > +      * tunnel-related field will be touched only when the feature
> > +      * is enabled and the hdr size id compatible.
> > +      */
> > +     memset(&hdr, 0, sizeof(hdr));
> > +     gso =3D (struct virtio_net_hdr *)&hdr;
> >
> >       if (!(tun->flags & IFF_NO_PI)) {
> >               if (len < sizeof(pi))
> > @@ -1721,7 +1733,12 @@ static ssize_t tun_get_user(struct tun_struct *t=
un, struct tun_file *tfile,
> >       if (tun->flags & IFF_VNET_HDR) {
> >               int vnet_hdr_sz =3D READ_ONCE(tun->vnet_hdr_sz);
> >
> > -             hdr_len =3D tun_vnet_hdr_get(vnet_hdr_sz, tun->flags, fro=
m, &gso);
> > +             if (vnet_hdr_sz >=3D TUN_VNET_TNL_SIZE)
> > +                     features =3D NETIF_F_GSO_UDP_TUNNEL |
> > +                                NETIF_F_GSO_UDP_TUNNEL_CSUM;
> > +
> > +             hdr_len =3D __tun_vnet_hdr_get(vnet_hdr_sz, tun->flags,
> > +                                          features, from, gso);
> >               if (hdr_len < 0)
> >                       return hdr_len;
> >
> > @@ -1755,7 +1772,7 @@ static ssize_t tun_get_user(struct tun_struct *tu=
n, struct tun_file *tfile,
> >                * (e.g gso or jumbo packet), we will do it at after
> >                * skb was created with generic XDP routine.
> >                */
> > -             skb =3D tun_build_skb(tun, tfile, from, &gso, len, &skb_x=
dp);
> > +             skb =3D tun_build_skb(tun, tfile, from, gso, len, &skb_xd=
p);
> >               err =3D PTR_ERR_OR_ZERO(skb);
> >               if (err)
> >                       goto drop;
> > @@ -1799,7 +1816,7 @@ static ssize_t tun_get_user(struct tun_struct *tu=
n, struct tun_file *tfile,
> >               }
> >       }
> >
> > -     if (tun_vnet_hdr_to_skb(tun->flags, skb, &gso)) {
> > +     if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
> >               atomic_long_inc(&tun->rx_frame_errors);
> >               err =3D -EINVAL;
> >               goto free_skb;
> > @@ -2050,13 +2067,21 @@ static ssize_t tun_put_user(struct tun_struct *=
tun,
> >       }
> >
> >       if (vnet_hdr_sz) {
> > -             struct virtio_net_hdr gso;
> > +             struct virtio_net_hdr_v1_hash_tunnel hdr;
> > +             struct virtio_net_hdr *gso;
> >
> > -             ret =3D tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, =
&gso);
> > +             ret =3D tun_vnet_hdr_tnl_from_skb(tun->flags, tun->dev, s=
kb,
> > +                                             &hdr);
> >               if (ret)
> >                       return ret;
> >
> > -             ret =3D tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
> > +             /*
> > +              * Drop the packet if the configured header size is too s=
mall
> > +              * WRT the enabled offloads.
> > +              */
> > +             gso =3D (struct virtio_net_hdr *)&hdr;
> > +             ret =3D __tun_vnet_hdr_put(vnet_hdr_sz, tun->dev->feature=
s,
> > +                                      iter, gso);
> >               if (ret)
> >                       return ret;
> >       }
> > @@ -2357,7 +2382,9 @@ static int tun_xdp_one(struct tun_struct *tun,
> >   {
> >       unsigned int datasize =3D xdp->data_end - xdp->data;
> >       struct tun_xdp_hdr *hdr =3D xdp->data_hard_start;
> > +     struct virtio_net_hdr_v1_hash_tunnel *tnl_hdr;
> >       struct virtio_net_hdr *gso =3D &hdr->gso;
> > +     netdev_features_t features =3D 0;
> >       struct bpf_prog *xdp_prog;
> >       struct sk_buff *skb =3D NULL;
> >       struct sk_buff_head *queue;
> > @@ -2426,7 +2453,17 @@ static int tun_xdp_one(struct tun_struct *tun,
> >       if (metasize > 0)
> >               skb_metadata_set(skb, metasize);
> >
> > -     if (tun_vnet_hdr_to_skb(tun->flags, skb, gso)) {
> > +     /*
> > +      * Assume tunnel offloads are enabled if the received hdr is larg=
e
> > +      * enough.
> > +      */
> > +     if (READ_ONCE(tun->vnet_hdr_sz) >=3D TUN_VNET_TNL_SIZE &&
> > +         xdp->data - xdp->data_hard_start >=3D TUN_VNET_TNL_SIZE)
> > +             features =3D NETIF_F_GSO_UDP_TUNNEL |
> > +                        NETIF_F_GSO_UDP_TUNNEL_CSUM;
>
> xdp->data - xdp->data_hard_start may not represent the header size.
>
> struct tun_xdp_hdr is filled in vhost_net_build_xdp() in
> drivers/vhost/net.c. This function sets the two fields with
> xdp_prepare_buff(), but the arguments passed to xdp_prepare_buff() does
> not seem to represent the exact size of the header.

It is? In vhost_net_build_xdp() it has:

        int pad =3D SKB_DATA_ALIGN(VHOST_NET_RX_PAD + headroom + nvq->sock_=
hlen);

Btw, I plan to remove tun_xdp_hdr and just use vnet header:

https://www.spinics.net/lists/netdev/msg1098039.html

Thanks

>
> > +
> > +     tnl_hdr =3D (struct virtio_net_hdr_v1_hash_tunnel *)gso;
> > +     if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr)) =
{
> >               atomic_long_inc(&tun->rx_frame_errors);
> >               kfree_skb(skb);
> >               ret =3D -EINVAL;
> > @@ -2812,6 +2849,8 @@ static void tun_get_iff(struct tun_struct *tun, s=
truct ifreq *ifr)
> >
> >   }
> >
> > +#define PLAIN_GSO (NETIF_F_GSO_UDP_L4 | NETIF_F_TSO | NETIF_F_TSO6)
> > +
> >   /* This is like a cut-down ethtool ops, except done via tun fd so no
> >    * privs required. */
> >   static int set_offload(struct tun_struct *tun, unsigned long arg)
> > @@ -2841,6 +2880,18 @@ static int set_offload(struct tun_struct *tun, u=
nsigned long arg)
> >                       features |=3D NETIF_F_GSO_UDP_L4;
> >                       arg &=3D ~(TUN_F_USO4 | TUN_F_USO6);
> >               }
> > +
> > +             /*
> > +              * Tunnel offload is allowed only if some plain offload i=
s
> > +              * available, too.
> > +              */
> > +             if (features & PLAIN_GSO && arg & TUN_F_UDP_TUNNEL_GSO) {
> > +                     features |=3D NETIF_F_GSO_UDP_TUNNEL;
> > +                     if (arg & TUN_F_UDP_TUNNEL_GSO_CSUM)
> > +                             features |=3D NETIF_F_GSO_UDP_TUNNEL_CSUM=
;
> > +                     arg &=3D ~(TUN_F_UDP_TUNNEL_GSO |
> > +                              TUN_F_UDP_TUNNEL_GSO_CSUM);
> > +             }
> >       }
> >
> >       /* This gives the user a way to test for new features in future b=
y
> > @@ -2852,7 +2903,6 @@ static int set_offload(struct tun_struct *tun, un=
signed long arg)
> >       tun->dev->wanted_features &=3D ~TUN_USER_FEATURES;
> >       tun->dev->wanted_features |=3D features;
> >       netdev_update_features(tun->dev);
> > -
> >       return 0;
> >   }
> >
> > diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> > index 58b9ac7a5fc4..7450fc153bb4 100644
> > --- a/drivers/net/tun_vnet.h
> > +++ b/drivers/net/tun_vnet.h
> > @@ -6,6 +6,8 @@
> >   #define TUN_VNET_LE     0x80000000
> >   #define TUN_VNET_BE     0x40000000
> >
> > +#define TUN_VNET_TNL_SIZE    sizeof(struct virtio_net_hdr_v1_hash_tunn=
el)
> > +
> >   static inline bool tun_vnet_legacy_is_little_endian(unsigned int flag=
s)
> >   {
> >       bool be =3D IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
> > @@ -107,16 +109,26 @@ static inline long tun_vnet_ioctl(int *vnet_hdr_s=
z, unsigned int *flags,
> >       }
> >   }
> >
> > -static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
> > -                                struct iov_iter *from,
> > -                                struct virtio_net_hdr *hdr)
> > +static inline unsigned int tun_vnet_parse_size(netdev_features_t featu=
res)
> > +{
> > +     if (!(features & NETIF_F_GSO_UDP_TUNNEL))
> > +             return sizeof(struct virtio_net_hdr);
> > +
> > +     return TUN_VNET_TNL_SIZE;
> > +}
> > +
> > +static inline int __tun_vnet_hdr_get(int sz, unsigned int flags,
> > +                                  netdev_features_t features,
> > +                                  struct iov_iter *from,
> > +                                  struct virtio_net_hdr *hdr)
> >   {
> > +     unsigned int parsed_size =3D tun_vnet_parse_size(features);
> >       u16 hdr_len;
> >
> >       if (iov_iter_count(from) < sz)
> >               return -EINVAL;
> >
> > -     if (!copy_from_iter_full(hdr, sizeof(*hdr), from))
> > +     if (!copy_from_iter_full(hdr, parsed_size, from))
> >               return -EFAULT;
> >
> >       hdr_len =3D tun_vnet16_to_cpu(flags, hdr->hdr_len);
> > @@ -129,32 +141,59 @@ static inline int tun_vnet_hdr_get(int sz, unsign=
ed int flags,
> >       if (hdr_len > iov_iter_count(from))
> >               return -EINVAL;
> >
> > -     iov_iter_advance(from, sz - sizeof(*hdr));
> > +     iov_iter_advance(from, sz - parsed_size);
> >
> >       return hdr_len;
> >   }
> >
> > -static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> > -                                const struct virtio_net_hdr *hdr)
> > +static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
> > +                                struct iov_iter *from,
> > +                                struct virtio_net_hdr *hdr)
> > +{
> > +     return __tun_vnet_hdr_get(sz, flags, 0, from, hdr);
> > +}
> > +
> > +static inline int __tun_vnet_hdr_put(int sz, netdev_features_t feature=
s,
> > +                                  struct iov_iter *iter,
> > +                                  const struct virtio_net_hdr *hdr)
> >   {
> > +     unsigned int parsed_size =3D tun_vnet_parse_size(features);
> > +
> >       if (unlikely(iov_iter_count(iter) < sz))
> >               return -EINVAL;
> >
> > -     if (unlikely(copy_to_iter(hdr, sizeof(*hdr), iter) !=3D sizeof(*h=
dr)))
> > +     if (unlikely(copy_to_iter(hdr, parsed_size, iter) !=3D parsed_siz=
e))
> >               return -EFAULT;
> >
> > -     if (iov_iter_zero(sz - sizeof(*hdr), iter) !=3D sz - sizeof(*hdr)=
)
> > +     if (iov_iter_zero(sz - parsed_size, iter) !=3D sz - parsed_size)
> >               return -EFAULT;
> >
> >       return 0;
> >   }
> >
> > +static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> > +                                const struct virtio_net_hdr *hdr)
> > +{
> > +     return __tun_vnet_hdr_put(sz, 0, iter, hdr);
> > +}
> > +
> >   static inline int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_b=
uff *skb,
> >                                     const struct virtio_net_hdr *hdr)
> >   {
> >       return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_little_endian(=
flags));
> >   }
> >
> > +static inline int
> > +tun_vnet_hdr_tnl_to_skb(unsigned int flags, netdev_features_t features=
,
> > +                     struct sk_buff *skb,
> > +                     const struct virtio_net_hdr_v1_hash_tunnel *hdr)
> > +{
> > +     return virtio_net_hdr_tnl_to_skb(skb, hdr,
> > +                                      !!(features & NETIF_F_GSO_UDP_TU=
NNEL),
> > +                                      !!(features & NETIF_F_GSO_UDP_TU=
NNEL_CSUM),
> > +                                      tun_vnet_is_little_endian(flags)=
);
> > +}
> > +
> >   static inline int tun_vnet_hdr_from_skb(unsigned int flags,
> >                                       const struct net_device *dev,
> >                                       const struct sk_buff *skb,
> > @@ -183,4 +222,35 @@ static inline int tun_vnet_hdr_from_skb(unsigned i=
nt flags,
> >       return 0;
> >   }
> >
> > +static inline int
> > +tun_vnet_hdr_tnl_from_skb(unsigned int flags,
> > +                       const struct net_device *dev,
> > +                       const struct sk_buff *skb,
> > +                       struct virtio_net_hdr_v1_hash_tunnel *tnl_hdr)
> > +{
> > +     bool has_tnl_offload =3D !!(dev->features & NETIF_F_GSO_UDP_TUNNE=
L);
> > +     int vlan_hlen =3D skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
> > +
> > +     if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
> > +                                     tun_vnet_is_little_endian(flags),
> > +                                     vlan_hlen)) {
> > +             struct virtio_net_hdr_v1 *hdr =3D &tnl_hdr->hash_hdr.hdr;
> > +             struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> > +
> > +             if (net_ratelimit()) {
> > +                     netdev_err(dev, "unexpected GSO type: 0x%x, gso_s=
ize %d, hdr_len %d\n",
> > +                                sinfo->gso_type, tun_vnet16_to_cpu(fla=
gs, hdr->gso_size),
> > +                                tun_vnet16_to_cpu(flags, hdr->hdr_len)=
);
> > +                     print_hex_dump(KERN_ERR, "tun: ",
> > +                                    DUMP_PREFIX_NONE,
> > +                                    16, 1, skb->head,
> > +                                    min(tun_vnet16_to_cpu(flags, hdr->=
hdr_len), 64), true);
> > +             }
> > +             WARN_ON_ONCE(1);
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >   #endif /* TUN_VNET_H */
> > diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
> > index 287cdc81c939..79d53c7a1ebd 100644
> > --- a/include/uapi/linux/if_tun.h
> > +++ b/include/uapi/linux/if_tun.h
> > @@ -93,6 +93,15 @@
> >   #define TUN_F_USO4  0x20    /* I can handle USO for IPv4 packets */
> >   #define TUN_F_USO6  0x40    /* I can handle USO for IPv6 packets */
> >
> > +/* I can handle TSO/USO for UDP tunneled packets */
> > +#define TUN_F_UDP_TUNNEL_GSO         0x080
> > +
> > +/*
> > + * I can handle TSO/USO for UDP tunneled packets requiring csum offloa=
d for
> > + * the outer header
> > + */
> > +#define TUN_F_UDP_TUNNEL_GSO_CSUM    0x100
> > +
> >   /* Protocol info prepended to the packets (when IFF_NO_PI is not set)=
 */
> >   #define TUN_PKT_STRIP       0x0001
> >   struct tun_pi {
>


