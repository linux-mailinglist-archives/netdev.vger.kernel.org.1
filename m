Return-Path: <netdev+bounces-94961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0983B8C11B9
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 17:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CDD51C20F3C
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E0612FF9B;
	Thu,  9 May 2024 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KNAGAdcX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918DA2837F
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267412; cv=none; b=D5tgNE2RU40kFllctuRh5LDiA0RTKvL18oS5tv1A247EUT514OkN2tcnW5bpwnqdSknLbBB/w7YtGm7z6TWPhgN091Rqw9o3BK2Hwj9yKXiFDtx9Q1fxlTHn/ZnRTEQQQicoj+ySkHw4TvKoF2gTW+oYCSYDuZgSkqQMhZ2SEjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267412; c=relaxed/simple;
	bh=c94BWUB9xllWePD8FJFwzpzcm7ztovQIR53LLeeIv80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyT3E69d91dMByFBb2m1rHW5HieDGC3gVsB49+mbN9MNzt+rIzS0sqem1JBLgtolDdeciYmfh3Rf/gKYmMW4DEAMbd2Qfw+l060TgPMVFDwzMNYtYMABCx0ape5qoDPPVTSJlc6asAnpnJbwBoG0p90+6Cts0PZuwp8lul1lbfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KNAGAdcX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41e79ec20a6so69175e9.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 08:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715267408; x=1715872208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RukwYj0CzeT8RuVf+FRxEPfyYkM4MW5x4/mn4HrWkbQ=;
        b=KNAGAdcXbm9vbZYHyzIsdyZZynu0hCXHkugx4YRxiTJDWucEhm8SqStwtZgC+xgfw6
         GAC5vtRinGyNd6+L/ruwwI40aCBiUrHEwWSMGvEb5UysOgWVxg3LH2kZNW6OUHbLHwJL
         YfRYRqym2hSYfze/VMVMfb34TtZCN9MvNIsJf/Iuzqj7dRtHIQxcmMaUgVPmpzxATy7k
         vp9n6O5quvNdlZZoDoe3qSiSnc6z1ev/HtzG354YLWHPMDcUgLI3nXcmpiVw2oOIDe7s
         wcFQHCPOxOXKc5gnbbEcvy+biogWQfqvuwfrHvbl5ATI7loYLAKVzIBI+TfdbAb6bJGi
         kHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715267408; x=1715872208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RukwYj0CzeT8RuVf+FRxEPfyYkM4MW5x4/mn4HrWkbQ=;
        b=A7ONI666iJwv1QXy+q4o3j3hMwuYQChP9sR8xmLloLtqK0nestRb7EfKW30z1F0T9N
         LG9932nUhLvYexTkbS7FZ1k7ZvMXaxD8wIhD1r9lVHq+vew0nfm7EUTaaMFi+VCt9fFY
         XHa8BC2LsvuCJNJHpDOlefmWXvYzhyBhcm/RV+4f4O2CzRSxfrYYdSeJW3cr2F5j7R9s
         ifz3xI2sVp0KAolQwbB9tMP1r1nH2HATdd7COZ/xr8EmC7ucPn5SD1H1LM0eip4R9qSO
         dj3wx/KAxlBcpJ+2Pr+ORhsKTCeXcBy0mjdp4qYhrCkwUuGJV54pkz59zzT6YDu0UJF7
         fIbw==
X-Forwarded-Encrypted: i=1; AJvYcCURHfkcNdS6d4aPeU3rnXxUkm2WV5kS3HrQ2M9P4+xYNnYGiFvetjOtjtZQGTsoFpu4C/q2kQYpUf45WmtZjDVWCKgbig2K
X-Gm-Message-State: AOJu0YyoNnPL+vd/a19/76jNNksg5FtpnrP0eWTDjg42RkGqXsTUTAd5
	HIP8u5V10rkIT76WPY4gwatkZaBAnL8MABo99lzy5jaZEqPAeDsPI2YtV0z3pKvnIbyHKjIs4PI
	IeuHSztvlTDrq92JXtNjXF5cfaCp0NbvXd+FT
X-Google-Smtp-Source: AGHT+IFsT118/o0gPWZX0jHnuN275eJnBE40lxI1LFZ9NIVucG/l8yDbjTN9hGrnUFc9jNJSmyNw8p31liFEoNSn44M=
X-Received: by 2002:a05:600c:b5a:b0:41b:e416:1073 with SMTP id
 5b1f17b1804b1-41fc27b0e81mr2009975e9.0.1715267407497; Thu, 09 May 2024
 08:10:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509-gemini-ethernet-fix-tso-v1-0-10cd07b54d1c@linaro.org>
 <20240509-gemini-ethernet-fix-tso-v1-1-10cd07b54d1c@linaro.org>
 <CANn89iKgi6yEEenSy1M-PVRYWz=Ri9UorV7irCywOZ8xTbNk_A@mail.gmail.com>
 <CACRpkdYyyQ_=2FmEe7FjDT-2BrhO5GezdXk35werHwBNA=uO=Q@mail.gmail.com>
 <CANn89i+JphFK4TCVjXxbxCicJwrxFC=+ngjnheZWK3KvCJ4Ocg@mail.gmail.com> <CANn89i+neubYmpc5VNamXoSjWkw+7-wQ6S-Q5jQjqWtEhiwgfg@mail.gmail.com>
In-Reply-To: <CANn89i+neubYmpc5VNamXoSjWkw+7-wQ6S-Q5jQjqWtEhiwgfg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 May 2024 17:09:56 +0200
Message-ID: <CANn89iL1GK3cqY=bowYu0idtJ3o3FMJh5hkLAY9Lt4RE+Q560Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: ethernet: cortina: Restore TSO support
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 5:06=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, May 9, 2024 at 4:49=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Thu, May 9, 2024 at 4:38=E2=80=AFPM Linus Walleij <linus.walleij@lin=
aro.org> wrote:
> > >
> > > On Thu, May 9, 2024 at 10:21=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
> > > > On Thu, May 9, 2024 at 9:48=E2=80=AFAM Linus Walleij <linus.walleij=
@linaro.org> wrote:
> > > > >
> > > > > An earlier commit deleted the TSO support in the Cortina Gemini
> > > > > driver because the driver was confusing gso_size and MTU,
> > > > > probably because what the Linux kernel calls "gso_size" was
> > > > > called "MTU" in the datasheet.
> > > > >
> > > > > Restore the functionality properly reading the gso_size from
> > > > > the skbuff.
> > > > >
> > > > > Tested with iperf3, running a server on a different machine
> > > > > and client on the device with the cortina gemini ethernet:
> > > > >
> > > > > Connecting to host 192.168.1.2, port 5201
> > > > > 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=
=3D1c8a
> > > > > 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=
=3D1c8a
> > > > > 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=
=3D27da
> > > > > 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=
=3D0b92
> > > > > 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=
=3D2bda
> > > > > (...)
> > > > >
> > > > > It also performs well: ~268 MBit/s.
> > > >
> > > > This does not look very good to me ?
> > >
> > > Oh it's pretty typical. This is an ARMv4 router from 2007, end-of-lif=
ed
> > > in 2015, and it is not meant to be stressed by the software like
> > > this, the idea is that packets get routed by the DSA switch
> > > (RTL8366RB).
> > >
> > > > What number do you have when/if TSO is turned off ?
> > >
> > > Around 187 MBit/s.
> > >
> > > > > +       /* Translate to link layer size */
> > > > > +       mss +=3D ETH_HLEN;
> > > > > +       if (skb->protocol =3D=3D htons(ETH_P_8021Q))
> > > > > +               mss +=3D VLAN_HLEN;
> > > >
> > > > Are you sure this is needed at all ?
> > > > Why not include IP and TCP header sizes as well, if the datasheet
> > > > mentions 'link layer size' ?
> > >
> > > Actually that code is just reusing the mss variable for
> > > skb->len in the case where TSO is not used, so I'll try to
> > > be more elaborate in the code :/
> > >
> > > I guess I actually need to account for it if ->gso_size expand
> > > to the MTU of the interface if I bump it up. But I don't
> > > know if the the TSO code actually does this or if it is
> > > more conservative?
> > >
> > > > To double check, please disable GRO on the receive side and verify =
the
> > > > packet sizes with tcpdump.
> > > >
> > > > Typically, for MTU=3D1500, IPv4, and TCP timestamp enabled,
> > > > skb_shinfo(skb)->gso_size is 1448
> > > >
> > > > (Because 20 (ipv4 header) + 32 (tcp header with TS option) + 1448 =
=3D 1500)
> > >
> > > I disabled all segment offloading on the receiving side:
> > > ethtool -K enp2s0 gro off gso off tso off
> >
> > >
> > > The iperf3 -c generates segmens like in the commit message:
> > > gemini-ethernet-port 60008000.ethernet-port eth0: segment offloading
> > > mss =3D 05a8 len=3D2bda
> > > gemini-ethernet-port 60008000.ethernet-port eth0: segment offloading
> > > mss =3D 05a8 len=3D27da
> > > gemini-ethernet-port 60008000.ethernet-port eth0: segment offloading
> > > mss =3D 05a8 len=3D0b92
> > >
> > > And 05a8 is 1448 so it is expected.
> > >
> > > tcpdump -e -X enp2s0 gives this on a single segment in a segmented
> > > iperf3 -c transfer:
> > >
> > > 16:24:09.182095 14:d6:4d:a8:3c:4f (oui Unknown) > fc:34:97:01:a0:c6
> > > (oui Unknown), ethertype IPv4 (0x0800), length 1448: OpenWrt.lan.5662=
4
> > > > Fecusia.targus-getdata1: Flags [.], seq 18664:20046, ack 1, win
> > > 4198, options [nop,nop,TS val 2770370491 ecr 3490176978], length 1382
> > >     0x0000:  4500 059a 8ff6 4000 4006 218d c0a8 0188  E.....@.@.!....=
.
> > >     0x0010:  c0a8 0102 dd30 1451 a701 4f9d e809 8788  .....0.Q..O....=
.
> > >     0x0020:  8010 1066 0b60 0000 0101 080a a520 7fbb  ...f.`.........=
.
> > > (...)
> > >     0x0580:  de60 2081 5678 4f8b 31b1 6f85 87fe ae63  .`..VxO.1.o....=
c
> > >     0x0590:  e2ca 8281 fa72 16aa 52e2                 .....r..R.
> > >
> > > As can be seen in the header, it is indeed 1448 bytes when arriving
> > > as well, so it seems to work!
> >
> > Not really.
> >
> > Try to disable TSO, and look at the resulting incoming packets, how
> > they are different.
> >
> > If skb_shinfo(skb)->gso_size is 1448, you should receive something like
> >
> > seq 18664:20112 .... length 1448  (this is the payload len at this stag=
e)
> >
> > If you receive instead ".... length 1382" this means you gave to the
> > NIC a 'link layer MSS' too small by 66 bytes.
>
> I would use something like this (modulo GMAC_OFFLOAD_FEATURES changes)
>
> diff --git a/drivers/net/ethernet/cortina/gemini.c
> b/drivers/net/ethernet/cortina/gemini.c
> index 2f98f644b9d7b5e48c4983dd2450a8c10fe04008..88cddd73851215666c26a10da=
8223c0fa0ac5473
> 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -1143,13 +1143,21 @@ static int gmac_map_tx_bufs(struct net_device
> *netdev, struct sk_buff *skb,
>         skb_frag_t *skb_frag;
>         dma_addr_t mapping;
>         void *buffer;
> +       u32 mss;
>         int ret;
>
> -       /* TODO: implement proper TSO using MTU in word3 */
> -       word1 =3D skb->len;
> +       word1 =3D mss =3D skb->len;
>         word3 =3D SOF_BIT;
>
> -       if (skb->len >=3D ETH_FRAME_LEN) {
> +       if (skb_is_gso(skb)) {
> +               mss =3D skb_shinfo(skb)->gso_size + skb_tcp_all_headers(s=
kb);
> +               /* skb->len will be all segments in this case */
> +               netdev_dbg(netdev, "segment offloading mss =3D %04x len=
=3D%04x\n",
> +                          mss, skb->len);
> +               word1 |=3D TSS_MTU_ENABLE_BIT;
> +               word3 |=3D mss;
> +       }
> +       if (mss >=3D ETH_FRAME_LEN) {

Also this last check makes little sense, because normal MTU/MSS would
trigger this condition.

Forcing software checksumming would make TSO useless.

I suspect this code is there because of the old buggy TSO
implementation of this driver.

