Return-Path: <netdev+bounces-196803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11952AD66F8
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 06:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BCB73ABD51
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 04:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3D71EA91;
	Thu, 12 Jun 2025 04:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3cx4BRo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE41C10957
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 04:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749704153; cv=none; b=QuP81DL5wg2lOFrWVAuNp9a+2A67ioASEdYkUo0gwWNoNDBj1izXvl4HaCl8jUAAAHphg5GlRMet7VJkMW+Vkppq+4a3ctCLpcsB2e+nBl4JEYb8KWIw9v/smpCeir6vvsX4QnwyWLHc7vmPsihJmdSf/PJIQAKRuGlF+cQMKQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749704153; c=relaxed/simple;
	bh=WdYAfD73hYfW7ocdQIIJQWX4UVF6pSMvZZT1qU9UQ1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvN6HJ47IUBECciJqdKQV9ZycQWxG3kg2aPceHwO6DU0nz5oi9ZSagLn3vKAndIktz1ithDdmTTLnlF3PIupsPdX6zo0IkWZoWpIKTirr7O7RsPzUUcXgJOHOhG6e3XPpAwKBktHD1HH1ct2oewD+siWL9bLxJZ53CLyJS0yheo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S3cx4BRo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749704149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nglbH0Cq3+jZXnJQFhzZG1FiMUuPD2DQzfFyG1ZSb5U=;
	b=S3cx4BRorVCQ5mix/U1mx0zooqQm6Uh0449+UNQ+y2PJLWq8ibK7XWPQ6HBc4FBPXunxFt
	kKshLrVi8C9ilmpX0HFPfhdZGElte89gPRkvHOGaoVltARTT2whUNUgXSSOmacR7nryYtV
	Dn1a2xsmXhLJBdb+NsCVtUzfoGbOqNA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-rK2S7ICfNaSgRlq6BjmUcw-1; Thu, 12 Jun 2025 00:55:46 -0400
X-MC-Unique: rK2S7ICfNaSgRlq6BjmUcw-1
X-Mimecast-MFC-AGG-ID: rK2S7ICfNaSgRlq6BjmUcw_1749704146
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-311d067b3faso827326a91.1
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 21:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749704146; x=1750308946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nglbH0Cq3+jZXnJQFhzZG1FiMUuPD2DQzfFyG1ZSb5U=;
        b=Sly+vt+gtU6Yfx3K4WZb3JbLyc8O7d/TaIFU6Zz/qMB/CG1ou60g1r62HJnq4JIS4R
         GbEmDVhUzkAkGid2cU7ZB/G5tyyazs6iSyl+sRFzomq2mX6OpfuAPZTRGUuwWax53mOL
         ZAYUVr52VBN6KyeXh5CmluHm5matsqCjYz009wQxd4SqRpJaP+4J60NlBWauKne4uSpc
         IAPSjR2ZCVpSo6zDLQbk1sX+WMr/I+uKNar8V0jXS17ucIWsagxOU7baK0nt+i7fid8Y
         PFZkq3jsC3FmeuCFXVKaVuiYSwumCHYf8WHWszucSYDE1CLVrJgFD70PfEblQQm8seiM
         gZKg==
X-Gm-Message-State: AOJu0Yw+Ay51xNp4UeTrgUkNwP9PofwltmnaPIxVEbiIrkKcfTQl0cWi
	ddZhScJhewmRBcYsH4xV8jgEx7JHIIoOtB33h1n05JF7MSIv28A/L+uvtL+3riLxysc7y3+Yfp6
	Ke15Tlo1DQhk4VPYhSdu1jUYlBVDqBKo3J6VhTqME3DCoYa1nWaRx+wixFofPk69qQztWIJ1xMA
	tGucS0nElCt7Z7HOTMuobig+fDspfMvn9z
X-Gm-Gg: ASbGnctfPrOD07QPYahgO9026OqOsqSq9KToAA0PC7uBiCyhSe7BMAmtjqjjTnHCp6q
	jnbaQgHvjh40jbXAJ+kWPkLZbvWhcZZvzuGlCWrlp4isgGwMMP8rrfUSjyzBWsGqpjfcN/DSHmK
	LO
X-Received: by 2002:a17:90b:4c44:b0:312:959:dc3f with SMTP id 98e67ed59e1d1-313af0fd27amr7470761a91.3.1749704145446;
        Wed, 11 Jun 2025 21:55:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmGwoWfPG9hpWyEV1n/+fatiOKlS0BC/RcgXzs3ToB66m47lkqqY+NAnq+kN4NgFGWd9WmxkPpQwh58g+CUGI=
X-Received: by 2002:a17:90b:4c44:b0:312:959:dc3f with SMTP id
 98e67ed59e1d1-313af0fd27amr7470727a91.3.1749704144977; Wed, 11 Jun 2025
 21:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749210083.git.pabeni@redhat.com> <a38c6a4618962237dde1c4077120a3a9d231e2c0.1749210083.git.pabeni@redhat.com>
In-Reply-To: <a38c6a4618962237dde1c4077120a3a9d231e2c0.1749210083.git.pabeni@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Jun 2025 12:55:33 +0800
X-Gm-Features: AX0GCFsnyc-CXoTSBLRKAIfMHUZXBAHSyRCQHSkdB-5bfSe5roHUautDfOH0Wko
Message-ID: <CACGkMEtExmmfmtd0+6YwgjuiWR-T5RvfcnHEbmH=ewqNXHPHYA@mail.gmail.com>
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

On Fri, Jun 6, 2025 at 7:46=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> Add new tun features to represent the newly introduced virtio
> GSO over UDP tunnel offload. Allows detection and selection of
> such features via the existing TUNSETOFFLOAD ioctl, store the
> tunnel offload configuration in the highest bit of the tun flags
> and compute the expected virtio header size and tunnel header
> offset using such bits, so that we can plug almost seamless the
> the newly introduced virtio helpers to serialize the extended
> virtio header.
>
> As the tun features and the virtio hdr size are configured
> separately, the data path need to cope with (hopefully transient)
> inconsistent values.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2 -> v3:
>   - cleaned-up uAPI comments
>   - use explicit struct layout instead of raw buf.
> ---
>  drivers/net/tun.c           | 77 ++++++++++++++++++++++++++++++++-----
>  drivers/net/tun_vnet.h      | 73 ++++++++++++++++++++++++++++-------
>  include/uapi/linux/if_tun.h |  9 +++++
>  3 files changed, 136 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 1207196cbbed..d326800dce9d 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -186,7 +186,8 @@ struct tun_struct {
>         struct net_device       *dev;
>         netdev_features_t       set_features;
>  #define TUN_USER_FEATURES (NETIF_F_HW_CSUM|NETIF_F_TSO_ECN|NETIF_F_TSO| =
\
> -                         NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4)
> +                         NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4 | \
> +                         NETIF_F_GSO_UDP_TUNNEL | NETIF_F_GSO_UDP_TUNNEL=
_CSUM)
>
>         int                     align;
>         int                     vnet_hdr_sz;
> @@ -925,6 +926,7 @@ static int tun_net_init(struct net_device *dev)
>         dev->hw_features =3D NETIF_F_SG | NETIF_F_FRAGLIST |
>                            TUN_USER_FEATURES | NETIF_F_HW_VLAN_CTAG_TX |
>                            NETIF_F_HW_VLAN_STAG_TX;
> +       dev->hw_enc_features =3D dev->hw_features;
>         dev->features =3D dev->hw_features;
>         dev->vlan_features =3D dev->features &
>                              ~(NETIF_F_HW_VLAN_CTAG_TX |
> @@ -1698,7 +1700,8 @@ static ssize_t tun_get_user(struct tun_struct *tun,=
 struct tun_file *tfile,
>         struct sk_buff *skb;
>         size_t total_len =3D iov_iter_count(from);
>         size_t len =3D total_len, align =3D tun->align, linear;
> -       struct virtio_net_hdr gso =3D { 0 };
> +       struct virtio_net_hdr_v1_tunnel full_hdr;
> +       struct virtio_net_hdr *gso;
>         int good_linear;
>         int copylen;
>         int hdr_len =3D 0;
> @@ -1708,6 +1711,15 @@ static ssize_t tun_get_user(struct tun_struct *tun=
, struct tun_file *tfile,
>         int skb_xdp =3D 1;
>         bool frags =3D tun_napi_frags_enabled(tfile);
>         enum skb_drop_reason drop_reason =3D SKB_DROP_REASON_NOT_SPECIFIE=
D;
> +       unsigned int flags =3D tun->flags & ~TUN_VNET_TNL_MASK;
> +
> +       /*
> +        * Keep it easy and always zero the whole buffer, even if the
> +        * tunnel-related field will be touched only when the feature
> +        * is enabled and the hdr size id compatible.
> +        */
> +       memset(&full_hdr, 0, sizeof(full_hdr));
> +       gso =3D (struct virtio_net_hdr *)&full_hdr.hdr;
>
>         if (!(tun->flags & IFF_NO_PI)) {
>                 if (len < sizeof(pi))
> @@ -1720,8 +1732,16 @@ static ssize_t tun_get_user(struct tun_struct *tun=
, struct tun_file *tfile,
>
>         if (tun->flags & IFF_VNET_HDR) {
>                 int vnet_hdr_sz =3D READ_ONCE(tun->vnet_hdr_sz);
> +               int parsed_size;
>
> -               hdr_len =3D tun_vnet_hdr_get(vnet_hdr_sz, tun->flags, fro=
m, &gso);
> +               if (vnet_hdr_sz < TUN_VNET_TNL_SIZE) {

I still don't understand why we need to duplicate netdev features in
flags, and it seems to introduce unnecessary complexities. Can we
simply check dev->features instead?

I think I've asked before, for example, we don't duplicate gso and
csum for non tunnel packets.

> +                       parsed_size =3D vnet_hdr_sz;
> +               } else {
> +                       parsed_size =3D TUN_VNET_TNL_SIZE;
> +                       flags |=3D TUN_VNET_TNL_MASK;
> +               }
> +               hdr_len =3D __tun_vnet_hdr_get(vnet_hdr_sz, parsed_size,
> +                                            flags, from, gso);
>                 if (hdr_len < 0)
>                         return hdr_len;
>
> @@ -1755,7 +1775,7 @@ static ssize_t tun_get_user(struct tun_struct *tun,=
 struct tun_file *tfile,
>                  * (e.g gso or jumbo packet), we will do it at after
>                  * skb was created with generic XDP routine.
>                  */
> -               skb =3D tun_build_skb(tun, tfile, from, &gso, len, &skb_x=
dp);
> +               skb =3D tun_build_skb(tun, tfile, from, gso, len, &skb_xd=
p);
>                 err =3D PTR_ERR_OR_ZERO(skb);
>                 if (err)
>                         goto drop;
> @@ -1799,7 +1819,7 @@ static ssize_t tun_get_user(struct tun_struct *tun,=
 struct tun_file *tfile,
>                 }
>         }
>
> -       if (tun_vnet_hdr_to_skb(tun->flags, skb, &gso)) {
> +       if (tun_vnet_hdr_to_skb(flags, skb, gso)) {
>                 atomic_long_inc(&tun->rx_frame_errors);
>                 err =3D -EINVAL;
>                 goto free_skb;
> @@ -2050,13 +2070,26 @@ static ssize_t tun_put_user(struct tun_struct *tu=
n,
>         }
>
>         if (vnet_hdr_sz) {
> -               struct virtio_net_hdr gso;
> +               struct virtio_net_hdr_v1_tunnel full_hdr;
> +               struct virtio_net_hdr *gso;
> +               int flags =3D tun->flags;
> +               int parsed_size;
> +
> +               gso =3D (struct virtio_net_hdr *)&full_hdr.hdr;
> +               parsed_size =3D tun_vnet_parse_size(tun->flags);
> +               if (unlikely(vnet_hdr_sz < parsed_size)) {
> +                       /* Inconsistent hdr size and (tunnel) offloads:
> +                        * strips the latter
> +                        */
> +                       flags &=3D ~TUN_VNET_TNL_MASK;
> +                       parsed_size =3D sizeof(struct virtio_net_hdr);
> +               };
>
> -               ret =3D tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, =
&gso);
> +               ret =3D tun_vnet_hdr_from_skb(flags, tun->dev, skb, gso);
>                 if (ret)
>                         return ret;
>
> -               ret =3D tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
> +               ret =3D __tun_vnet_hdr_put(vnet_hdr_sz, parsed_size, iter=
, gso);
>                 if (ret)
>                         return ret;
>         }
> @@ -2366,6 +2399,7 @@ static int tun_xdp_one(struct tun_struct *tun,
>         int metasize =3D 0;
>         int ret =3D 0;
>         bool skb_xdp =3D false;
> +       unsigned int flags;
>         struct page *page;
>
>         if (unlikely(datasize < ETH_HLEN))
> @@ -2426,7 +2460,16 @@ static int tun_xdp_one(struct tun_struct *tun,
>         if (metasize > 0)
>                 skb_metadata_set(skb, metasize);
>
> -       if (tun_vnet_hdr_to_skb(tun->flags, skb, gso)) {
> +       /* Assume tun offloads are enabled if the provided hdr is large
> +        * enough.
> +        */
> +       if (READ_ONCE(tun->vnet_hdr_sz) >=3D TUN_VNET_TNL_SIZE &&
> +           xdp->data - xdp->data_hard_start >=3D TUN_VNET_TNL_SIZE)
> +               flags =3D tun->flags | TUN_VNET_TNL_MASK;
> +       else
> +               flags =3D tun->flags & ~TUN_VNET_TNL_MASK;

I'm not sure I get the point that we need dynamics of
TUN_VNET_TNL_MASK here. We know if tunnel gso and its csum or enabled
or not, and we know the vnet_hdr_sz here, we can simply drop the
packet with less header.

> +
> +       if (tun_vnet_hdr_to_skb(flags, skb, gso)) {
>                 atomic_long_inc(&tun->rx_frame_errors);
>                 kfree_skb(skb);
>                 ret =3D -EINVAL;
> @@ -2812,6 +2855,8 @@ static void tun_get_iff(struct tun_struct *tun, str=
uct ifreq *ifr)
>
>  }
>
> +#define PLAIN_GSO (NETIF_F_GSO_UDP_L4 | NETIF_F_TSO | NETIF_F_TSO6)
> +
>  /* This is like a cut-down ethtool ops, except done via tun fd so no
>   * privs required. */
>  static int set_offload(struct tun_struct *tun, unsigned long arg)
> @@ -2841,6 +2886,17 @@ static int set_offload(struct tun_struct *tun, uns=
igned long arg)
>                         features |=3D NETIF_F_GSO_UDP_L4;
>                         arg &=3D ~(TUN_F_USO4 | TUN_F_USO6);
>                 }
> +
> +               /* Tunnel offload is allowed only if some plain offload i=
s
> +                * available, too.
> +                */
> +               if (features & PLAIN_GSO && arg & TUN_F_UDP_TUNNEL_GSO) {
> +                       features |=3D NETIF_F_GSO_UDP_TUNNEL;
> +                       if (arg & TUN_F_UDP_TUNNEL_GSO_CSUM)
> +                               features |=3D NETIF_F_GSO_UDP_TUNNEL_CSUM=
;
> +                       arg &=3D ~(TUN_F_UDP_TUNNEL_GSO |
> +                                TUN_F_UDP_TUNNEL_GSO_CSUM);
> +               }
>         }
>
>         /* This gives the user a way to test for new features in future b=
y
> @@ -2852,7 +2908,8 @@ static int set_offload(struct tun_struct *tun, unsi=
gned long arg)
>         tun->dev->wanted_features &=3D ~TUN_USER_FEATURES;
>         tun->dev->wanted_features |=3D features;
>         netdev_update_features(tun->dev);
> -
> +       tun_set_vnet_tnl(&tun->flags, !!(features & NETIF_F_GSO_UDP_TUNNE=
L),
> +                        !!(features & NETIF_F_GSO_UDP_TUNNEL_CSUM));
>         return 0;
>  }
>
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index 58b9ac7a5fc4..c2374c26538b 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -5,6 +5,11 @@
>  /* High bits in flags field are unused. */
>  #define TUN_VNET_LE     0x80000000
>  #define TUN_VNET_BE     0x40000000
> +#define TUN_VNET_TNL           0x20000000
> +#define TUN_VNET_TNL_CSUM      0x10000000
> +#define TUN_VNET_TNL_MASK      (TUN_VNET_TNL | TUN_VNET_TNL_CSUM)
> +
> +#define TUN_VNET_TNL_SIZE      sizeof(struct virtio_net_hdr_v1_tunnel)
>
>  static inline bool tun_vnet_legacy_is_little_endian(unsigned int flags)
>  {
> @@ -45,6 +50,13 @@ static inline long tun_set_vnet_be(unsigned int *flags=
, int __user *argp)
>         return 0;
>  }
>
> +static inline void tun_set_vnet_tnl(unsigned int *flags, bool tnl, bool =
tnl_csum)
> +{
> +       *flags =3D (*flags & ~TUN_VNET_TNL_MASK) |
> +                tnl * TUN_VNET_TNL |
> +                tnl_csum * TUN_VNET_TNL_CSUM;
> +}
> +
>  static inline bool tun_vnet_is_little_endian(unsigned int flags)
>  {
>         return flags & TUN_VNET_LE || tun_vnet_legacy_is_little_endian(fl=
ags);
> @@ -107,16 +119,33 @@ static inline long tun_vnet_ioctl(int *vnet_hdr_sz,=
 unsigned int *flags,
>         }
>  }
>
> -static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
> -                                  struct iov_iter *from,
> -                                  struct virtio_net_hdr *hdr)
> +static inline unsigned int tun_vnet_parse_size(unsigned int flags)
> +{
> +       if (!(flags & TUN_VNET_TNL))
> +               return sizeof(struct virtio_net_hdr);
> +
> +       return TUN_VNET_TNL_SIZE;
> +}
> +
> +static inline unsigned int tun_vnet_tnl_offset(unsigned int flags)
> +{
> +       if (!(flags & TUN_VNET_TNL))
> +               return 0;
> +
> +       return sizeof(struct virtio_net_hdr_v1);
> +}
> +
> +static inline int __tun_vnet_hdr_get(int sz, int parsed_size,
> +                                    unsigned int flags,
> +                                    struct iov_iter *from,
> +                                    struct virtio_net_hdr *hdr)
>  {
>         u16 hdr_len;
>
>         if (iov_iter_count(from) < sz)
>                 return -EINVAL;
>
> -       if (!copy_from_iter_full(hdr, sizeof(*hdr), from))
> +       if (!copy_from_iter_full(hdr, parsed_size, from))
>                 return -EFAULT;
>
>         hdr_len =3D tun_vnet16_to_cpu(flags, hdr->hdr_len);
> @@ -129,30 +158,47 @@ static inline int tun_vnet_hdr_get(int sz, unsigned=
 int flags,
>         if (hdr_len > iov_iter_count(from))
>                 return -EINVAL;
>
> -       iov_iter_advance(from, sz - sizeof(*hdr));
> +       iov_iter_advance(from, sz - parsed_size);
>
>         return hdr_len;
>  }
>
> -static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> -                                  const struct virtio_net_hdr *hdr)
> +static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
> +                                  struct iov_iter *from,
> +                                  struct virtio_net_hdr *hdr)
> +{
> +       return __tun_vnet_hdr_get(sz, sizeof(*hdr), flags, from, hdr);
> +}
> +
> +static inline int __tun_vnet_hdr_put(int sz, int parsed_size,
> +                                    struct iov_iter *iter,
> +                                    const struct virtio_net_hdr *hdr)
>  {
>         if (unlikely(iov_iter_count(iter) < sz))
>                 return -EINVAL;
>
> -       if (unlikely(copy_to_iter(hdr, sizeof(*hdr), iter) !=3D sizeof(*h=
dr)))
> +       if (unlikely(copy_to_iter(hdr, parsed_size, iter) !=3D parsed_siz=
e))
>                 return -EFAULT;
>
> -       if (iov_iter_zero(sz - sizeof(*hdr), iter) !=3D sz - sizeof(*hdr)=
)
> +       if (iov_iter_zero(sz - parsed_size, iter) !=3D sz - parsed_size)
>                 return -EFAULT;
>
>         return 0;
>  }
>
> +static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> +                                  const struct virtio_net_hdr *hdr)
> +{
> +       return __tun_vnet_hdr_put(sz, sizeof(*hdr), iter, hdr);
> +}
> +
>  static inline int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff=
 *skb,
>                                       const struct virtio_net_hdr *hdr)
>  {
> -       return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_little_endian(=
flags));
> +       return virtio_net_hdr_tnl_to_skb(skb, hdr,
> +                                        tun_vnet_tnl_offset(flags),
> +                                        !!(flags & TUN_VNET_TNL_CSUM),
> +                                        tun_vnet_is_little_endian(flags)=
);
>  }
>
>  static inline int tun_vnet_hdr_from_skb(unsigned int flags,
> @@ -161,10 +207,11 @@ static inline int tun_vnet_hdr_from_skb(unsigned in=
t flags,
>                                         struct virtio_net_hdr *hdr)
>  {
>         int vlan_hlen =3D skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
> +       int tnl_offset =3D tun_vnet_tnl_offset(flags);
>
> -       if (virtio_net_hdr_from_skb(skb, hdr,
> -                                   tun_vnet_is_little_endian(flags), tru=
e,
> -                                   vlan_hlen)) {
> +       if (virtio_net_hdr_tnl_from_skb(skb, hdr, tnl_offset,
> +                                       tun_vnet_is_little_endian(flags),
> +                                       vlan_hlen)) {
>                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
>
>                 if (net_ratelimit()) {
> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
> index 287cdc81c939..79d53c7a1ebd 100644
> --- a/include/uapi/linux/if_tun.h
> +++ b/include/uapi/linux/if_tun.h
> @@ -93,6 +93,15 @@
>  #define TUN_F_USO4     0x20    /* I can handle USO for IPv4 packets */
>  #define TUN_F_USO6     0x40    /* I can handle USO for IPv6 packets */
>
> +/* I can handle TSO/USO for UDP tunneled packets */
> +#define TUN_F_UDP_TUNNEL_GSO           0x080
> +
> +/*
> + * I can handle TSO/USO for UDP tunneled packets requiring csum offload =
for
> + * the outer header
> + */
> +#define TUN_F_UDP_TUNNEL_GSO_CSUM      0x100
> +

Any reason we don't choose to use 0x40 and 0x60?

>  /* Protocol info prepended to the packets (when IFF_NO_PI is not set) */
>  #define TUN_PKT_STRIP  0x0001
>  struct tun_pi {
> --
> 2.49.0
>

Thanks


