Return-Path: <netdev+bounces-119037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04201953E75
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849711F22633
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 00:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0D21392;
	Fri, 16 Aug 2024 00:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4HO7ML+P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F8A36C
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 00:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723769742; cv=none; b=A5qTZiCt49DdD2Ulw89IbRyVTfgWvVouPLTe5GXPxWd5RLV3ivYmRsnJzYnsACijEqieVUezxbxuTaNqGEyqmfEeMPLrFD3vKtctmNrhBYoRZHGK3YCHW5RkPfW0fb2scipiRZDzYHKbMKXp9mEJJ5Uu44XWDozrwJoGNAvhsTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723769742; c=relaxed/simple;
	bh=1572Hd6SD4YVY2Yqc5DeQwlQSD412Fj+aznWVoZvspw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAEUIcwJdwm69mA5vD2yAi+vqGGT4kETSQvDhot8Cw3w7YM/hOfTYPaDcO/5njmUtiSef6AUuuHlCQlcKC2M5BKfDYo1h+MEMfx3fpdjbD9NBD4drowNOVT1hpPFsgDDg0wdvjKrWXjF0V+jDjRdGIUkuoB5eQ8crYMavZiWKZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4HO7ML+P; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5bec507f4ddso3465a12.0
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 17:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723769739; x=1724374539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZeLTSbFc+zquV51g0H2lKwMceeWphKtOc8Br2W1JUU=;
        b=4HO7ML+PoBF8fNO1Rt6JfoOKpg1ba1rO32CVh1UuysdfQp86ero0Pyny9Q+SziKQEH
         RI3EoxrcBu7Cx4GRnHP7wkuHAMSLBROYjN27lY4oD6CqB1YS57Yj7NwozHZPSGjrJ4Lv
         581xg+fdVGR9z5jPKlDVrZL+IswxBc4T3WYkuYqVGvXfAy92GrRkMov7jxSl5pbjinwp
         Gmj0XMzbE7UpsBYGVX5dilLBfpp4uyUARCL/iuF21NmOAOLDeaEf3yYfvnNunGkEkySx
         ruUGbDj2oqtL5XLdJp+lzCdu+4v1NoOxZHoGQQHQ3PmWJLUoWSoGUFLj4ymNFomcVv6p
         kNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723769739; x=1724374539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZeLTSbFc+zquV51g0H2lKwMceeWphKtOc8Br2W1JUU=;
        b=fijEpwFOFP8DtqqMQJ097JSUMFviaqT0J8dtVCqEBLMFKOc1iZuFj2bWLuLMv3vpgM
         gkPZXJG4ZBi8Z7ToNa4w7bxBTrM4QO11O5ymQ9rj+MtToX3HPxXe7FNvVIv0yHXHO2j9
         fZPHLcpJWwuMergf7hm/Dco3OVBnQ7guYpI/3a2kIy+af40CwykKMT23pqmxY2M1HRDa
         YvxM/cFYuft4VYbY7zwTmogh84jAWYRDanR1qi1i2zx1W/JPS17DXE1sv3BUb6NNKYKD
         LO3nS2fo0LmAe6wKQdYfuT1ycNQHRdOsKJ+X75uqBsG8SsSFw1ytS02+K3qX+n6WMzQe
         kJdA==
X-Gm-Message-State: AOJu0Yw8WlrJTNk1x//pMfiZV23M6+kfGd83tyN066bFHGSIchD806nC
	ZajIvKv43ZKZbaWZlPLbz+bwFXU0tAuJac8iBVUjkz2Ei8uNTTheCBfZIAAzGhDoyBsNoP+VW2D
	yUHJrH8n1Iwz0SuhhGq7bGJhdggx1EsPelW8K
X-Google-Smtp-Source: AGHT+IEcbHajHNNq4mkFz4Bc2SxQ6K5ggIU/eeZNEDg9DqA1rr4i+KMEGi6Wqtwd9i0rnPP5Xoa65sKN2syXyOQ6ONM=
X-Received: by 2002:a05:6402:2710:b0:57c:c5e2:2c37 with SMTP id
 4fb4d7f45d1cf-5becd68425amr15899a12.3.1723769738364; Thu, 15 Aug 2024
 17:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813223325.3522113-1-maze@google.com> <a4f73bac-12dd-4fbf-ac56-0c704563d0c1@amd.com>
In-Reply-To: <a4f73bac-12dd-4fbf-ac56-0c704563d0c1@amd.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 15 Aug 2024 17:55:26 -0700
Message-ID: <CANP3RGfarvhSFm8UhtJC2gzgigt2wUcBQAoVC+ZRP7zCXH=wtA@mail.gmail.com>
Subject: Re: [PATCH net-next] ethtool: add tunable api to disable various
 firmware offloads
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>, Ahmed Zaki <ahmed.zaki@intel.com>, 
	Edward Cree <ecree.xilinx@gmail.com>, Yuyang Huang <yuyanghuang@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 9:13=E2=80=AFAM Nelson, Shannon <shannon.nelson@amd=
.com> wrote:
>
> On 8/13/2024 3:33 PM, Maciej =C5=BBenczykowski wrote:
> >
> > In order to save power (battery), most network hardware
> > designed for low power environments (ie. battery powered
> > devices) supports varying types of hardware/firmware offload
> > (filtering and/or generating replies) of incoming packets.
> >
> > The goal being to prevent device wakeups caused by ingress 'spam'.
> >
> > This is particularly true for wifi (especially phones/tablets),
> > but isn't actually wifi specific.  It can also be implemented
> > in wired nics (TV) or usb ethernet dongles.
> >
> > For examples TVs require this to keep power consumption
> > under (the EU mandated) 2 Watts while idle (display off),
> > while still being discoverable on the network.
> >
> > This may include things like: ARP/IPv6 ND, IGMP/MLD, ping, mdns,
> > but various other possibilities are also possible,
> > for example:
> >    ethertype filtering (discarding non-IP ethertypes),
> >    nat-t keepalive (discarding ingress, automating periodic egress),
> >    tcp keepalive (generation/processing/filtering),
> >    tethering (forwarding) offload
> >
> > In many ways, in its goals, it is somewhat similar to the
> > relatively standard destination mac filtering most wired nics
> > have supported for ages: reduce the amount of traffic the host
> > must handle.
> >
> > While working on Android we've discovered that there is
> > no device/driver agnostic way to disable these offloads.
> >
> > This patch is an attempt to rectify this.
> >
> > It does not add an API to configure these offloads, as usually
> > this isn't needed as the driver will just fetch the required
> > configuration information straight from the kernel.
> >
> > What it does do is add a simple API to allow disabling (masking)
> > them, either for debugging or for test purposes.
>
> I can see how this would be useful for test/debug, but it seems to me it
> is only half of a solution.  Wouldn't there also be a need to re-enable
> the offloads without having to reboot/restart the gizmo being tested?
> Or even query the current status?

Since it's a mask of things to disable, setting the mask to 0, or the
relevant bit of the mask to 0 would reenable (assuming there was
anything to enable).

>
> sln
>
> >
> > Cc: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
> > Cc: Ahmed Zaki <ahmed.zaki@intel.com>
> > Cc: Edward Cree <ecree.xilinx@gmail.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Yuyang Huang <yuyanghuang@google.com>
> > Cc: Lorenzo Colitti <lorenzo@google.com>
> > Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> > ---
> >   include/uapi/linux/ethtool.h | 15 +++++++++++++++
> >   net/ethtool/common.c         |  1 +
> >   net/ethtool/ioctl.c          |  5 +++++
> >   3 files changed, 21 insertions(+)
> >
> > diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.=
h
> > index 4a0a6e703483..7b58860c3731 100644
> > --- a/include/uapi/linux/ethtool.h
> > +++ b/include/uapi/linux/ethtool.h
> > @@ -224,12 +224,27 @@ struct ethtool_value {
> >   #define PFC_STORM_PREVENTION_AUTO      0xffff
> >   #define PFC_STORM_PREVENTION_DISABLE   0
> >
> > +/* For power/wakeup (*not* performance) related offloads */
> > +enum tunable_fw_offload_disable {
> > +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_ALL,
> > +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV4_ARP,
> > +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV6_ND,
> > +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV4_PING,
> > +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV6_PING,
> > +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV4_IGMP,
> > +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV6_MLD,
> > +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV4_MDNS,
> > +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV6_MDNS,
> > +       /* 55 bits remaining for future use */
> > +};
> > +
> >   enum tunable_id {
> >          ETHTOOL_ID_UNSPEC,
> >          ETHTOOL_RX_COPYBREAK,
> >          ETHTOOL_TX_COPYBREAK,
> >          ETHTOOL_PFC_PREVENTION_TOUT, /* timeout in msecs */
> >          ETHTOOL_TX_COPYBREAK_BUF_SIZE,
> > +       ETHTOOL_FW_OFFLOAD_DISABLE, /* u64 bits numbered from LSB per t=
unable_fw_offload_disable */
> >          /*
> >           * Add your fresh new tunable attribute above and remember to =
update
> >           * tunable_strings[] in net/ethtool/common.c
> > diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> > index 7257ae272296..8dc0c084fce5 100644
> > --- a/net/ethtool/common.c
> > +++ b/net/ethtool/common.c
> > @@ -91,6 +91,7 @@ tunable_strings[__ETHTOOL_TUNABLE_COUNT][ETH_GSTRING_=
LEN] =3D {
> >          [ETHTOOL_TX_COPYBREAK]  =3D "tx-copybreak",
> >          [ETHTOOL_PFC_PREVENTION_TOUT] =3D "pfc-prevention-tout",
> >          [ETHTOOL_TX_COPYBREAK_BUF_SIZE] =3D "tx-copybreak-buf-size",
> > +       [ETHTOOL_FW_OFFLOAD_DISABLE] =3D "fw-offload-disable",
> >   };
> >
> >   const char
> > diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> > index 18cf9fa32ae3..31318ded17a7 100644
> > --- a/net/ethtool/ioctl.c
> > +++ b/net/ethtool/ioctl.c
> > @@ -2733,6 +2733,11 @@ static int ethtool_get_module_eeprom(struct net_=
device *dev,
> >   static int ethtool_tunable_valid(const struct ethtool_tunable *tuna)
> >   {
> >          switch (tuna->id) {
> > +       case ETHTOOL_FW_OFFLOAD_DISABLE:
> > +               if (tuna->len !=3D sizeof(u64) ||
> > +                   tuna->type_id !=3D ETHTOOL_TUNABLE_U64)
> > +                       return -EINVAL;
> > +               break;
> >          case ETHTOOL_RX_COPYBREAK:
> >          case ETHTOOL_TX_COPYBREAK:
> >          case ETHTOOL_TX_COPYBREAK_BUF_SIZE:
> > --
> > 2.46.0.76.ge559c4bf1a-goog
> >
> >

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

