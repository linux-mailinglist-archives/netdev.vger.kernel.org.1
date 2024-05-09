Return-Path: <netdev+bounces-94959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5135A8C11A8
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 17:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E112822DE
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9483714B097;
	Thu,  9 May 2024 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LhE/TWlJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7BB133423
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267195; cv=none; b=X5Ou8qiS/Kr/W5UhsbmWMT1tSEIH7GZJ0SFomznQrcSDL8SJbj13GEiYfJDdiw5vyz8yu71Sni1yq9Pp3up0XaX1ePQU8DiCzJtUiI1dux4OfY+4q9yJGSDk/Ew7nOpKPKcsjfCE3yuu5Ca5kfKuRQlGjcnxZd25cV3tLV08Ers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267195; c=relaxed/simple;
	bh=6tQ/kpfo3bSUY3HTFyTZlalJjR/rdLdEbYR9XEtb7xI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwD9vEEBTTozNEBfu0XdFpKmAooa8sYY450OpW1CJmaq+UGuvK8R/XbULrEC6e7+vJAFQqQGFzKxRHR+Iw9+OYSTNoUuoOrz7ZrFaWrauhzqk1C4vikm8fTyQiDB5jKUgAIlsR0FlUNE6SIOf6Lm8/kWqF5udt3htnXBVWuD6rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LhE/TWlJ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso10230a12.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 08:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715267192; x=1715871992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEiFFHcxUxdnPmM7bfs7DZScYtvzoVO9bo/3zomkVJ8=;
        b=LhE/TWlJr3iZN90Ra+8GKkoufX8XD7mD42AeM1aIaOWVELR8y6Y7aZUY65+q625v8I
         BWvFjXFKVnIFse9EGWSWfZZrdX0IyLv4/FjLwfxw0YpBJqOl1cPHhHmIKcIISCNsGSjH
         yCXw1xU4StrwfAtSN6mDtwjKq2JVlhluwQI5/GsyPYqI0Xac50dRFxxLEf/CT9CRMebx
         vGG0d5+X6Yv4pyuU3z4BUR/aHi3UcEK4W19eVHodyDTo1PCDYCrVF28eAl1COoYa7Eh5
         WDCEqzcnZpzaThn3HG9h2M1Ppvrr5LR8eBFFd/2QZ2m0FIlycdUWhIEye3iE1maKdqHY
         D0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715267192; x=1715871992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEiFFHcxUxdnPmM7bfs7DZScYtvzoVO9bo/3zomkVJ8=;
        b=GC0vvdBmRsuFlcgUE+/+aQjOvlPqXj/Tt66QO7mVkUfRfldINJ/VtRE7pe5rOYWgLj
         nbExu8PadgcdG12DCN1maI877dz0At+P/jOWEn/uctgH613l+PSvp+yfqdQILwdUpuU+
         21H0H+0uN2We6bZHq4H/Ts9Be5+MbIRaq3G0MRMeqn4XT5ULa5UnmCfe7divICfyH9jN
         TK9RbQmi+OX3FjXYYW2LuS0+l+dSfpHIo4buXfqYX/JivyE+oxL/EBj3y23RSFca1Ujd
         ZaDxkkq2k4aJG1xDOaKmb6uNjfs4TSBNKA7oAIuOxpfDNwF8WUcuc3Y4eNIQkw1zD+vR
         228Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTOXx8avsS0jDYQrgbHlpE4rLn4V48Q+1oR9pzWxVnP2W2T6DUfh3P5w89l9Gv210l/kg8TNbmWetdJRGx/WamaHBKD3+3
X-Gm-Message-State: AOJu0YyRLoQkzWoO5PZchpBy3n15dpIp9d/NG0Q0CM0IZUPcHMEU4hGr
	xV8LflolP/YzaO04m53Oz2UV8F8BcwI04iP5Ip1CuFSf9jUKMM9tWUzfFx2UIUsZ9TDJsbxzhzt
	8JSeR0bz4NMBL2PLsfGPijf+D/aJmJGwvgxy1
X-Google-Smtp-Source: AGHT+IGcg3wMy7eE2npwO1RTXuQW6Fe+l8B+K9qGckLomGr3LVcJhfYQo07XwCJQv5fOzOduWbXqKC2ehNOj6kGMbtA=
X-Received: by 2002:a05:6402:40c2:b0:572:554b:ec4f with SMTP id
 4fb4d7f45d1cf-5733b9cc025mr198273a12.3.1715267191565; Thu, 09 May 2024
 08:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509-gemini-ethernet-fix-tso-v1-0-10cd07b54d1c@linaro.org>
 <20240509-gemini-ethernet-fix-tso-v1-1-10cd07b54d1c@linaro.org>
 <CANn89iKgi6yEEenSy1M-PVRYWz=Ri9UorV7irCywOZ8xTbNk_A@mail.gmail.com>
 <CACRpkdYyyQ_=2FmEe7FjDT-2BrhO5GezdXk35werHwBNA=uO=Q@mail.gmail.com> <CANn89i+JphFK4TCVjXxbxCicJwrxFC=+ngjnheZWK3KvCJ4Ocg@mail.gmail.com>
In-Reply-To: <CANn89i+JphFK4TCVjXxbxCicJwrxFC=+ngjnheZWK3KvCJ4Ocg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 May 2024 17:06:16 +0200
Message-ID: <CANn89i+neubYmpc5VNamXoSjWkw+7-wQ6S-Q5jQjqWtEhiwgfg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: ethernet: cortina: Restore TSO support
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 4:49=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, May 9, 2024 at 4:38=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:
> >
> > On Thu, May 9, 2024 at 10:21=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > > On Thu, May 9, 2024 at 9:48=E2=80=AFAM Linus Walleij <linus.walleij@l=
inaro.org> wrote:
> > > >
> > > > An earlier commit deleted the TSO support in the Cortina Gemini
> > > > driver because the driver was confusing gso_size and MTU,
> > > > probably because what the Linux kernel calls "gso_size" was
> > > > called "MTU" in the datasheet.
> > > >
> > > > Restore the functionality properly reading the gso_size from
> > > > the skbuff.
> > > >
> > > > Tested with iperf3, running a server on a different machine
> > > > and client on the device with the cortina gemini ethernet:
> > > >
> > > > Connecting to host 192.168.1.2, port 5201
> > > > 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=3D=
1c8a
> > > > 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=3D=
1c8a
> > > > 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=3D=
27da
> > > > 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=3D=
0b92
> > > > 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=3D=
2bda
> > > > (...)
> > > >
> > > > It also performs well: ~268 MBit/s.
> > >
> > > This does not look very good to me ?
> >
> > Oh it's pretty typical. This is an ARMv4 router from 2007, end-of-lifed
> > in 2015, and it is not meant to be stressed by the software like
> > this, the idea is that packets get routed by the DSA switch
> > (RTL8366RB).
> >
> > > What number do you have when/if TSO is turned off ?
> >
> > Around 187 MBit/s.
> >
> > > > +       /* Translate to link layer size */
> > > > +       mss +=3D ETH_HLEN;
> > > > +       if (skb->protocol =3D=3D htons(ETH_P_8021Q))
> > > > +               mss +=3D VLAN_HLEN;
> > >
> > > Are you sure this is needed at all ?
> > > Why not include IP and TCP header sizes as well, if the datasheet
> > > mentions 'link layer size' ?
> >
> > Actually that code is just reusing the mss variable for
> > skb->len in the case where TSO is not used, so I'll try to
> > be more elaborate in the code :/
> >
> > I guess I actually need to account for it if ->gso_size expand
> > to the MTU of the interface if I bump it up. But I don't
> > know if the the TSO code actually does this or if it is
> > more conservative?
> >
> > > To double check, please disable GRO on the receive side and verify th=
e
> > > packet sizes with tcpdump.
> > >
> > > Typically, for MTU=3D1500, IPv4, and TCP timestamp enabled,
> > > skb_shinfo(skb)->gso_size is 1448
> > >
> > > (Because 20 (ipv4 header) + 32 (tcp header with TS option) + 1448 =3D=
 1500)
> >
> > I disabled all segment offloading on the receiving side:
> > ethtool -K enp2s0 gro off gso off tso off
>
> >
> > The iperf3 -c generates segmens like in the commit message:
> > gemini-ethernet-port 60008000.ethernet-port eth0: segment offloading
> > mss =3D 05a8 len=3D2bda
> > gemini-ethernet-port 60008000.ethernet-port eth0: segment offloading
> > mss =3D 05a8 len=3D27da
> > gemini-ethernet-port 60008000.ethernet-port eth0: segment offloading
> > mss =3D 05a8 len=3D0b92
> >
> > And 05a8 is 1448 so it is expected.
> >
> > tcpdump -e -X enp2s0 gives this on a single segment in a segmented
> > iperf3 -c transfer:
> >
> > 16:24:09.182095 14:d6:4d:a8:3c:4f (oui Unknown) > fc:34:97:01:a0:c6
> > (oui Unknown), ethertype IPv4 (0x0800), length 1448: OpenWrt.lan.56624
> > > Fecusia.targus-getdata1: Flags [.], seq 18664:20046, ack 1, win
> > 4198, options [nop,nop,TS val 2770370491 ecr 3490176978], length 1382
> >     0x0000:  4500 059a 8ff6 4000 4006 218d c0a8 0188  E.....@.@.!.....
> >     0x0010:  c0a8 0102 dd30 1451 a701 4f9d e809 8788  .....0.Q..O.....
> >     0x0020:  8010 1066 0b60 0000 0101 080a a520 7fbb  ...f.`..........
> > (...)
> >     0x0580:  de60 2081 5678 4f8b 31b1 6f85 87fe ae63  .`..VxO.1.o....c
> >     0x0590:  e2ca 8281 fa72 16aa 52e2                 .....r..R.
> >
> > As can be seen in the header, it is indeed 1448 bytes when arriving
> > as well, so it seems to work!
>
> Not really.
>
> Try to disable TSO, and look at the resulting incoming packets, how
> they are different.
>
> If skb_shinfo(skb)->gso_size is 1448, you should receive something like
>
> seq 18664:20112 .... length 1448  (this is the payload len at this stage)
>
> If you receive instead ".... length 1382" this means you gave to the
> NIC a 'link layer MSS' too small by 66 bytes.

I would use something like this (modulo GMAC_OFFLOAD_FEATURES changes)

diff --git a/drivers/net/ethernet/cortina/gemini.c
b/drivers/net/ethernet/cortina/gemini.c
index 2f98f644b9d7b5e48c4983dd2450a8c10fe04008..88cddd73851215666c26a10da82=
23c0fa0ac5473
100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1143,13 +1143,21 @@ static int gmac_map_tx_bufs(struct net_device
*netdev, struct sk_buff *skb,
        skb_frag_t *skb_frag;
        dma_addr_t mapping;
        void *buffer;
+       u32 mss;
        int ret;

-       /* TODO: implement proper TSO using MTU in word3 */
-       word1 =3D skb->len;
+       word1 =3D mss =3D skb->len;
        word3 =3D SOF_BIT;

-       if (skb->len >=3D ETH_FRAME_LEN) {
+       if (skb_is_gso(skb)) {
+               mss =3D skb_shinfo(skb)->gso_size + skb_tcp_all_headers(skb=
);
+               /* skb->len will be all segments in this case */
+               netdev_dbg(netdev, "segment offloading mss =3D %04x len=3D%=
04x\n",
+                          mss, skb->len);
+               word1 |=3D TSS_MTU_ENABLE_BIT;
+               word3 |=3D mss;
+       }
+       if (mss >=3D ETH_FRAME_LEN) {
                /* Hardware offloaded checksumming isn't working on frames
                 * bigger than 1514 bytes. A hypothesis about this is that =
the
                 * checksum buffer is only 1518 bytes, so when the frames g=
et

