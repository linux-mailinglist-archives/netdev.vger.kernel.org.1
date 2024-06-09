Return-Path: <netdev+bounces-102090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78892901632
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 15:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D21A8B20EE1
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 13:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F663EA98;
	Sun,  9 Jun 2024 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoYqPmr+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1249B17E9;
	Sun,  9 Jun 2024 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717939204; cv=none; b=jys+4LNjD8785PSbxyGtyK53S6jDdefIVdr9m8W5Z30dwMRnWRSaOg/WteNEZgMm/xJaJyaaJjMQkvjMLs3OYnIAUzgfR60IJ34/zq/r1+TiJENM46W077sWyS45Iz7Y+FCjjpp6zKYl2/h9XRCR83VHKgWB78E2PxiisfxQzzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717939204; c=relaxed/simple;
	bh=R8rf9gElSVWNbxaihuWSeJY2iohB/5mHKU+bJ2Mlk08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTDYf0wo5Zb4aCfsQfbTQP9CxsNw1bgwArvHMEOcDnPzLjKRdYMOcceXAOMu4x3mRFoyA9SYPlo250Rs9nzRVuEDME8xyItVB6geR54hdHbnOYZGG/eKdUr/MuGj8V67dm7VZDmbBK/+FTY32zt/R9HvGyQkD26oozLWVyMh85Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoYqPmr+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a62ef52e837so483531366b.3;
        Sun, 09 Jun 2024 06:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717939201; x=1718544001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uq2w4gNTRTICtQgQewJ8JOIDB4REwLjdALYvNIFCoKY=;
        b=XoYqPmr+yYQykzkL49d9bh7cH65HPW10Va1L/IprCakgH6y/pbwMza1imHxXVxa9TO
         vx2CmR+NjIaXdq/AvOtw7oieKJsGuoTuoLfI4zSS5em+9C+zmsvpX02YOeSFdrT+sf5f
         B2vEyZl90HPf2vxmuZ7llgBI0XJt0s23+UzD9YS6ygw7FUenLumL8lcJPwtAED6xI2ox
         KpSfGqTHPqKhmmPxzBk4IIX2l1BdgLsmwdxgvOHBckhhQLva1e+y1RW2FoTCbsDonDFM
         HEwGmtc65Oc4MaIA9wRrgsQZyivdcWVuH1TsqND6v4otqrz5h8qozQ0Wvl5J4nU5kGv4
         B4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717939201; x=1718544001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uq2w4gNTRTICtQgQewJ8JOIDB4REwLjdALYvNIFCoKY=;
        b=QDZosW5dC2edPUss7hLggifUTVgZuzm0EEfGEbsATDfb56/R7hDDFidx1LLGybeax6
         G34SGOir1H6ApJNCTWmlzZ0/UuseFrsho896FdSMg0dbkasrBGQdtmoYO6emA6+hzcBw
         kE8HpMaPcQ6kF1+7UcaLnZn6X1tXWSERR3HUtLGOgF/R153fB6hGghwQe0Z5PIIEMIiv
         hHOqx2UChbHdzN7rmgVPspkHT9EdsWKfWMYNNKz5u/kQI0QuT1t4r06h9kP2at15+KmU
         OEd+c4L/9Jc7UZftyVuKjfv5vu0BlqKbG9LejSGuwWSyK5QwWweJVm2khMjlS9gWxclh
         ZsYg==
X-Forwarded-Encrypted: i=1; AJvYcCVu2nDez13pIUl28Qx6wcvqjf+jG/FVCNu4oHvzA8B2rpcBrMEDnVsn35+8Pb53ZLOmTg4+Qatl0LF8ASFbgQCDU1dFyAWUzHK6LfOvOuYPNvQ4imKobinIMJnMpsLE0RQ3TJOF
X-Gm-Message-State: AOJu0YznA4CSRwVjg1O9pa7nkMr1VVvrUdUfx4jYrPeFa2HU5tuEC55y
	PcNY4ZMbfUCC5Jao3F0lYlMuLvZYu3XtATB7IBuDMo53DHxXJukF3wRNDSa47V/wBy+j4RkdDw+
	hHRyuhm6eiW+fLkR4+YXv+b1mnsg=
X-Google-Smtp-Source: AGHT+IH/7cxvZQYiaBlD8/f3ysqDewNm0rEWbg/8tKXKhnCwDs0wxKL8DQTZjQWCZnTz6y+AcAgwXXnq1Qkui0s5AJw=
X-Received: by 2002:a17:906:71c1:b0:a6a:6ed0:fbd7 with SMTP id
 a640c23a62f3a-a6cd7891aeemr454044566b.37.1717939201028; Sun, 09 Jun 2024
 06:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216094154.3263843-1-leitao@debian.org> <20240216092905.4e2d3c7c@hermes.local>
 <0e0ba573-1ae0-4a4b-8286-fdbc8dbe7639@gmail.com> <CANn89i+5F7d4i7Ds4V6TtkzzAjQjNQ8xOeoYqZr8tY6tWWmMEg@mail.gmail.com>
 <ZdMjaCSKFSkAoDOS@gmail.com> <CAL+tcoDqyYy7mE6W8qvDJZgMK_4sYwXPzpidvgEu=r-uJ46k4Q@mail.gmail.com>
In-Reply-To: <CAL+tcoDqyYy7mE6W8qvDJZgMK_4sYwXPzpidvgEu=r-uJ46k4Q@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 9 Jun 2024 21:19:23 +0800
Message-ID: <CAL+tcoCfOnL4uv_0JQZvxsBogF+bTLxDEre9fORKDofMdfWDtQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: sysfs: Do not create sysfs for non BQL device
To: Breno Leitao <leitao@debian.org>
Cc: Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, kuba@kernel.org, davem@davemloft.net, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	horms@kernel.org, Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 9, 2024 at 12:47=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Hello Breno, Eric
>
> On Mon, Feb 19, 2024 at 5:47=E2=80=AFPM Breno Leitao <leitao@debian.org> =
wrote:
> >
> > On Fri, Feb 16, 2024 at 07:45:37PM +0100, Eric Dumazet wrote:
> > > On Fri, Feb 16, 2024 at 7:41=E2=80=AFPM Florian Fainelli <f.fainelli@=
gmail.com> wrote:
> > > >
> > > > On 2/16/24 09:29, Stephen Hemminger wrote:
> > > > > On Fri, 16 Feb 2024 01:41:52 -0800
> > > > > Breno Leitao <leitao@debian.org> wrote:
> > > > >
> > > > >> +static bool netdev_uses_bql(const struct net_device *dev)
> > > > >> +{
> > > > >> +    if (dev->features & NETIF_F_LLTX ||
> > > > >> +        dev->priv_flags & IFF_NO_QUEUE)
> > > > >> +            return false;
> > > > >> +
> > > > >> +    return IS_ENABLED(CONFIG_BQL);
> > > > >> +}
> > > > >
> > > > > Various compilers will warn about missing parens in that expressi=
on.
> > > > > It is valid but mixing & and || can be bug trap.
> > > > >
> > > > >       if ((dev->features & NETIF_F_LLTX) || (dev->priv_flags & IF=
F_NO_QUEUE))
> > > > >               return false;
> > > > >
> > > > > Not all drivers will be using bql, it requires driver to have tha=
t code.
> > > > > So really it means driver could be using BQL.
> > > > > Not sure if there is a way to find out if driver has the required=
 BQL bits.
> > > >
> > > > There is not a feature flag to be keying off if that is what you ar=
e
> > > > after, you would need to audit the drivers and see whether they mak=
e
> > > > calls to netdev_tx_sent_queue(), netdev_tx_reset_queue(),
> > > > netdev_tx_completed_queue().
> > > >
> > > > I suppose you might be able to programmatically extract that inform=
ation
> > > > by looking at whether a given driver object file has a reference to
> > > > dql_{reset,avail,completed} or do that at the source level, whichev=
er is
> > > > easier.
> > >
> > > Note that the suggested patch does not change current functionality.
> > >
> > > Traditionally, we had sysfs entries fpr BQL for all netdev, regardles=
s of them
> > > using BQL or not.
> > >
> > > The patch seems to be a good first step.
> >
> > Thanks Eric. I agree it solves the problem without creating a new
> > feature flag, that could also be done, but maybe less important than
> > this first step.
>
> When I'm reading and testing the dqs codes in my VM, I realize that
> the virtio_net driver should have been excluded from BQL drivers,
> which means VM using virtio_net driver should not have the
> /sys/class/net/eth1/queues/tx-1/byte_queue_limits directory because It
> has neither NETIF_F_LLTX nor IFF_NO_QUEUE.
>
> I'm trying to cook a patch to fix it without introducing a new feature
> like NETIF_F_LOOPBACK, but I failed to have a good patch.
>
> I have two options in my mind:
> 1) introduce a feature flag only for virtion_net [1]
> 2) introduce a BQL flag, and then apply it to all the drivers which
> has either NETIF_F_LLTX or IFF_NO_QUEUE bit, including virtio_net
> driver

I decided to use this method. Please review :
https://lore.kernel.org/all/20240609131732.73156-1-kerneljasonxing@gmail.co=
m/

Thanks.

>
> Do you have any ideas or suggestions?
>
> Thanks in advance!
>
> [1]
> untested patch for now:
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 61a57d134544..e39417d99ea8 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5634,7 +5634,7 @@ static int virtnet_probe(struct virtio_device *vdev=
)
>                            IFF_TX_SKB_NO_LINEAR;
>         dev->netdev_ops =3D &virtnet_netdev;
>         dev->stat_ops =3D &virtnet_stat_ops;
> -       dev->features =3D NETIF_F_HIGHDMA;
> +       dev->features =3D NETIF_F_HIGHDMA | NETIF_F_VIRTNET;
>
>         dev->ethtool_ops =3D &virtnet_ethtool_ops;
>         SET_NETDEV_DEV(dev, &vdev->dev);
> diff --git a/include/linux/netdev_features.h b/include/linux/netdev_featu=
res.h
> index 7c2d77d75a88..4ade9cdf079e 100644
> --- a/include/linux/netdev_features.h
> +++ b/include/linux/netdev_features.h
> @@ -14,7 +14,7 @@ typedef u64 netdev_features_t;
>  enum {
>         NETIF_F_SG_BIT,                 /* Scatter/gather IO. */
>         NETIF_F_IP_CSUM_BIT,            /* Can checksum TCP/UDP over IPv4=
. */
> -       __UNUSED_NETIF_F_1,
> +       //__UNUSED_NETIF_F_1,
>         NETIF_F_HW_CSUM_BIT,            /* Can checksum all the packets. =
*/
>         NETIF_F_IPV6_CSUM_BIT,          /* Can checksum TCP/UDP over IPV6=
 */
>         NETIF_F_HIGHDMA_BIT,            /* Can DMA to high memory. */
> @@ -91,6 +91,7 @@ enum {
>         NETIF_F_HW_HSR_FWD_BIT,         /* Offload HSR forwarding */
>         NETIF_F_HW_HSR_DUP_BIT,         /* Offload HSR duplication */
>
> +       NETIF_F_VIRTNET_BIT,            /* Enable virtnet */
>         /*
>          * Add your fresh new feature above and remember to update
>          * netdev_features_strings[] in net/ethtool/common.c and maybe
> @@ -122,6 +123,7 @@ enum {
>  #define NETIF_F_IPV6_CSUM      __NETIF_F(IPV6_CSUM)
>  #define NETIF_F_LLTX           __NETIF_F(LLTX)
>  #define NETIF_F_LOOPBACK       __NETIF_F(LOOPBACK)
> +#define NETIF_F_VIRTNET                __NETIF_F(VIRTNET)
>  #define NETIF_F_LRO            __NETIF_F(LRO)
>  #define NETIF_F_NETNS_LOCAL    __NETIF_F(NETNS_LOCAL)
>  #define NETIF_F_NOCACHE_COPY   __NETIF_F(NOCACHE_COPY)
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 4c27a360c294..d52d95ea6fb6 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -1764,7 +1764,7 @@ static const struct kobj_type netdev_queue_ktype =
=3D {
>
>  static bool netdev_uses_bql(const struct net_device *dev)
>  {
> -       if (dev->features & NETIF_F_LLTX ||
> +       if (dev->features & (NETIF_F_LLTX | NETIF_F_VIRTNET) ||
>             dev->priv_flags & IFF_NO_QUEUE)
>                 return false;
>
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index 6b2a360dcdf0..efb39a185e4b 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -74,6 +74,7 @@ const char
> netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] =3D {
>         [NETIF_F_HW_HSR_TAG_RM_BIT] =3D    "hsr-tag-rm-offload",
>         [NETIF_F_HW_HSR_FWD_BIT] =3D       "hsr-fwd-offload",
>         [NETIF_F_HW_HSR_DUP_BIT] =3D       "hsr-dup-offload",
> +       [NETIF_F_VIRTNET_BIT] =3D         "virtnet",
>  };
>
>  const char
>
> >
> > Hoping this is OK, I am planning to send a v2 adding the extra
> > parenthesis as reported above.
> >
> > Thanks
> >

