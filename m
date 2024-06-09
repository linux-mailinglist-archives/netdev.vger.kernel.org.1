Return-Path: <netdev+bounces-102051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7393A90146E
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 06:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF390B212C7
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 04:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B42D299;
	Sun,  9 Jun 2024 04:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrvGRWcz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CDD613D;
	Sun,  9 Jun 2024 04:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717908485; cv=none; b=aoWXgMsZpnFA/59DrPhuiWU3VMiYVM9e248dWhT32aN5CbqB4ZR/Cc4VeOecYCHl21aEasLCzePCRInfvn1L4WeWmvScDuVpvJgLke0kz4T7TQlpYTFkhRXBpRWoIP/WFNULH4bf7P4CTYy+0zXC40c9DVch8NjyRG1+aaTYJi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717908485; c=relaxed/simple;
	bh=ZC0NIExRadZz9pF4BtWQfbzpwRPdq83BjwULj/auO6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPp359sLpeSBA0iafBvJ04DINvaaB2cRTVi5OLExo/8VrzrFMUVzU/OyqUdwJWz4IgOCq6s1x+HGOcZzeddqH8ydlm9X8SwadNHiNQxnv6qf2rwScRe/4PSRG/oLUEBP3Y1eVJwjKCZvMocYudptjAm9KhbGtei2Wh8ujN6E7wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrvGRWcz; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6efacd25ecso62232466b.1;
        Sat, 08 Jun 2024 21:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717908481; x=1718513281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=de3XEag55PlRNeVsKoa46EW3T6BQjhB8VBX3S+KwyRs=;
        b=YrvGRWczg1Q/laiPgvua92upgfg7LZF6WoKYfdF5WAgLLdjIqY29iBCZHbKvKNVrIB
         B1lJSc6JSmvfuo6LcaBmuBaG0mpsi9U6v0ZVU2ENRTpZ6gqh6dfsB5etjOOfI2Uoo/Fx
         4kf7lxBDXbXaexokhTpfJqvrATPng9cfHDFb9DctgLELjj6gjifR60ipO7M5RqI9wdP/
         Gl9IPCcOzZIBXDXMzXSAV8RX6rLohM0lFqQT4PhDrkV5n28p0PigAPO34qJAeAe57y7r
         QW7mVyer7H/AgshCAuKOqTXuOAUZH/WCD0momv+69mQkrpdLHwLwE3gGznYGENOxLe14
         Qhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717908481; x=1718513281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=de3XEag55PlRNeVsKoa46EW3T6BQjhB8VBX3S+KwyRs=;
        b=H8hos+pkm0r5yFh76dr06AZ1VNwoGhPvfZfQc1pRGcOb9aWFYeOo47LOXIbEY7Z3QC
         e5QaNwVMVMrJOh8zfu2lXP0e6pMwSIm/9jWaDrZY2yQn3MsKYdCVGoRJTNm20p8H4BqD
         zqIRWiK9ataDbKwGr2uW6j4QbhdAaXYdFAAS0vV2veqB4ER5bSzkYth9Je2+p8djifDy
         v0zaoVLfg6scXlyBRXYiK1fO0HUVpEwxs0LXn0KI9+czvVscdtyyt3Ys/dX/h6UXbDNf
         4XKFixzNzQkA28eFs4D/GpWSfFVOumx9T3aIMT2j20sfO3ID4GGQtJMhO+JLsvoD4OZt
         8rrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmaH4TMXcQB+lb3c1Z2Yw1HnXU+qTHEiJDP91lvSqPvXCLatst9TS2/kXamYxVHzBvJ0X8xVVbsr1aIQ+ZQ2JNaWJDZHjrinm3j3l+I5M2DoDbB5v/+v6e3ry0Z4EP4HBLIvmE
X-Gm-Message-State: AOJu0YzfXsOu/hmV5c82mBfvucr/124PnGVmNxRFyZ36oDyjpXxRw58B
	O/DL8bWKbcCqhwJ/ZqmjBvVfpoGY2KfhM4wYG3BIzQNILvyYAQw2EIqShvuH9zdpdGakzmuzTU7
	rpB0btEv9dAUD7tpPWH9T42aojMlsbsOP
X-Google-Smtp-Source: AGHT+IGdn1fEFpQkOilc6scv6rf5kFsxm6xroGSwWJReZhXqdcYJB8ZHIwhPOVK7olruhU83UUn4V8nH1ePdiMVhTUM=
X-Received: by 2002:a50:bb28:0:b0:57a:4c22:b3 with SMTP id 4fb4d7f45d1cf-57c5085e6ecmr5330318a12.1.1717908481327;
 Sat, 08 Jun 2024 21:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216094154.3263843-1-leitao@debian.org> <20240216092905.4e2d3c7c@hermes.local>
 <0e0ba573-1ae0-4a4b-8286-fdbc8dbe7639@gmail.com> <CANn89i+5F7d4i7Ds4V6TtkzzAjQjNQ8xOeoYqZr8tY6tWWmMEg@mail.gmail.com>
 <ZdMjaCSKFSkAoDOS@gmail.com>
In-Reply-To: <ZdMjaCSKFSkAoDOS@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 9 Jun 2024 12:47:23 +0800
Message-ID: <CAL+tcoDqyYy7mE6W8qvDJZgMK_4sYwXPzpidvgEu=r-uJ46k4Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: sysfs: Do not create sysfs for non BQL device
To: Breno Leitao <leitao@debian.org>
Cc: Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, kuba@kernel.org, davem@davemloft.net, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	horms@kernel.org, Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Breno, Eric

On Mon, Feb 19, 2024 at 5:47=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Fri, Feb 16, 2024 at 07:45:37PM +0100, Eric Dumazet wrote:
> > On Fri, Feb 16, 2024 at 7:41=E2=80=AFPM Florian Fainelli <f.fainelli@gm=
ail.com> wrote:
> > >
> > > On 2/16/24 09:29, Stephen Hemminger wrote:
> > > > On Fri, 16 Feb 2024 01:41:52 -0800
> > > > Breno Leitao <leitao@debian.org> wrote:
> > > >
> > > >> +static bool netdev_uses_bql(const struct net_device *dev)
> > > >> +{
> > > >> +    if (dev->features & NETIF_F_LLTX ||
> > > >> +        dev->priv_flags & IFF_NO_QUEUE)
> > > >> +            return false;
> > > >> +
> > > >> +    return IS_ENABLED(CONFIG_BQL);
> > > >> +}
> > > >
> > > > Various compilers will warn about missing parens in that expression=
.
> > > > It is valid but mixing & and || can be bug trap.
> > > >
> > > >       if ((dev->features & NETIF_F_LLTX) || (dev->priv_flags & IFF_=
NO_QUEUE))
> > > >               return false;
> > > >
> > > > Not all drivers will be using bql, it requires driver to have that =
code.
> > > > So really it means driver could be using BQL.
> > > > Not sure if there is a way to find out if driver has the required B=
QL bits.
> > >
> > > There is not a feature flag to be keying off if that is what you are
> > > after, you would need to audit the drivers and see whether they make
> > > calls to netdev_tx_sent_queue(), netdev_tx_reset_queue(),
> > > netdev_tx_completed_queue().
> > >
> > > I suppose you might be able to programmatically extract that informat=
ion
> > > by looking at whether a given driver object file has a reference to
> > > dql_{reset,avail,completed} or do that at the source level, whichever=
 is
> > > easier.
> >
> > Note that the suggested patch does not change current functionality.
> >
> > Traditionally, we had sysfs entries fpr BQL for all netdev, regardless =
of them
> > using BQL or not.
> >
> > The patch seems to be a good first step.
>
> Thanks Eric. I agree it solves the problem without creating a new
> feature flag, that could also be done, but maybe less important than
> this first step.

When I'm reading and testing the dqs codes in my VM, I realize that
the virtio_net driver should have been excluded from BQL drivers,
which means VM using virtio_net driver should not have the
/sys/class/net/eth1/queues/tx-1/byte_queue_limits directory because It
has neither NETIF_F_LLTX nor IFF_NO_QUEUE.

I'm trying to cook a patch to fix it without introducing a new feature
like NETIF_F_LOOPBACK, but I failed to have a good patch.

I have two options in my mind:
1) introduce a feature flag only for virtion_net [1]
2) introduce a BQL flag, and then apply it to all the drivers which
has either NETIF_F_LLTX or IFF_NO_QUEUE bit, including virtio_net
driver

Do you have any ideas or suggestions?

Thanks in advance!

[1]
untested patch for now:
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 61a57d134544..e39417d99ea8 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5634,7 +5634,7 @@ static int virtnet_probe(struct virtio_device *vdev)
                           IFF_TX_SKB_NO_LINEAR;
        dev->netdev_ops =3D &virtnet_netdev;
        dev->stat_ops =3D &virtnet_stat_ops;
-       dev->features =3D NETIF_F_HIGHDMA;
+       dev->features =3D NETIF_F_HIGHDMA | NETIF_F_VIRTNET;

        dev->ethtool_ops =3D &virtnet_ethtool_ops;
        SET_NETDEV_DEV(dev, &vdev->dev);
diff --git a/include/linux/netdev_features.h b/include/linux/netdev_feature=
s.h
index 7c2d77d75a88..4ade9cdf079e 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -14,7 +14,7 @@ typedef u64 netdev_features_t;
 enum {
        NETIF_F_SG_BIT,                 /* Scatter/gather IO. */
        NETIF_F_IP_CSUM_BIT,            /* Can checksum TCP/UDP over IPv4. =
*/
-       __UNUSED_NETIF_F_1,
+       //__UNUSED_NETIF_F_1,
        NETIF_F_HW_CSUM_BIT,            /* Can checksum all the packets. */
        NETIF_F_IPV6_CSUM_BIT,          /* Can checksum TCP/UDP over IPV6 *=
/
        NETIF_F_HIGHDMA_BIT,            /* Can DMA to high memory. */
@@ -91,6 +91,7 @@ enum {
        NETIF_F_HW_HSR_FWD_BIT,         /* Offload HSR forwarding */
        NETIF_F_HW_HSR_DUP_BIT,         /* Offload HSR duplication */

+       NETIF_F_VIRTNET_BIT,            /* Enable virtnet */
        /*
         * Add your fresh new feature above and remember to update
         * netdev_features_strings[] in net/ethtool/common.c and maybe
@@ -122,6 +123,7 @@ enum {
 #define NETIF_F_IPV6_CSUM      __NETIF_F(IPV6_CSUM)
 #define NETIF_F_LLTX           __NETIF_F(LLTX)
 #define NETIF_F_LOOPBACK       __NETIF_F(LOOPBACK)
+#define NETIF_F_VIRTNET                __NETIF_F(VIRTNET)
 #define NETIF_F_LRO            __NETIF_F(LRO)
 #define NETIF_F_NETNS_LOCAL    __NETIF_F(NETNS_LOCAL)
 #define NETIF_F_NOCACHE_COPY   __NETIF_F(NOCACHE_COPY)
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 4c27a360c294..d52d95ea6fb6 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1764,7 +1764,7 @@ static const struct kobj_type netdev_queue_ktype =3D =
{

 static bool netdev_uses_bql(const struct net_device *dev)
 {
-       if (dev->features & NETIF_F_LLTX ||
+       if (dev->features & (NETIF_F_LLTX | NETIF_F_VIRTNET) ||
            dev->priv_flags & IFF_NO_QUEUE)
                return false;

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 6b2a360dcdf0..efb39a185e4b 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -74,6 +74,7 @@ const char
netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] =3D {
        [NETIF_F_HW_HSR_TAG_RM_BIT] =3D    "hsr-tag-rm-offload",
        [NETIF_F_HW_HSR_FWD_BIT] =3D       "hsr-fwd-offload",
        [NETIF_F_HW_HSR_DUP_BIT] =3D       "hsr-dup-offload",
+       [NETIF_F_VIRTNET_BIT] =3D         "virtnet",
 };

 const char

>
> Hoping this is OK, I am planning to send a v2 adding the extra
> parenthesis as reported above.
>
> Thanks
>

