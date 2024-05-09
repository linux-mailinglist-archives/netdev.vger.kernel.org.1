Return-Path: <netdev+bounces-94956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8523D8C117F
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 16:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E671C208CF
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301C43AC2B;
	Thu,  9 May 2024 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eFf8zukh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B891A291
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715266188; cv=none; b=QYhM//CMHvd2l0C/TLK7cd/glRbNObQLLhdXAoit3FDjyshgIes8z9QaFcfhd8DhiPgzq2kIypo4HKaqYFs5H/xumgagrlfIg6DMaQgZrRECBtteS1ociy6zMJ1qZda5niHWMOrrofl7JpEwWbMvcJTAMHy9yJijNLFKmoTb2Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715266188; c=relaxed/simple;
	bh=WQEXcfTY50KR4jNxT0kstC2ZQMe6GUcPl3mXTMvdVks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4D6lN9XAgcBYhUJ8TS+8XlOARSddVhreiSKhsJYD/P4SH68atKW01zxkvVUKC72iV2qXcx1vv8Hpx4joo4SRfXEd92CUJgluEPQzdOWIluQ0G8ceQkjZ2ctfkgUZoC6aYMNybZlSaSKRhvLC8DWpGvxza92o18/6EOJJ+MYtLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eFf8zukh; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso17643a12.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 07:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715266184; x=1715870984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXmNcVc3OL5b8qlh51akDuOijw6KmJMEpIHgtYE7qgc=;
        b=eFf8zukhjjV8tGJHCjSSHo7qd1sw5OYKRSzuNYO1IuwpHzr88CMV0hVPJ5mnugYD+C
         mw/fU+0mZhqm31mk7fcoceVgoiL2tBKlfkQ9PO45swYME6Em6wjuDaxuKD/L8vte5w9D
         +W8c9JgxziMPKMLE+7EsmRtC1jZ9HxMYGm/GKGXY38dRrbJqkRVfkACQIikOr0j6VYXB
         uH2KJN66JHaRcYPb1EgUL9H54nHD/4WaRTIuJx4E3pMm99Hxndqr0I/V3+ux4Xl0RenF
         880nfLos8NeAUkNseEtvna25YKB5xBCVhdunsbaCEwl3TDW6+PqXOc5TFsK3bRjh+xD8
         MPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715266184; x=1715870984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXmNcVc3OL5b8qlh51akDuOijw6KmJMEpIHgtYE7qgc=;
        b=VUcUmp2BNe2nUn9U2ekusprqJDBuMDBzscqSGbl40uKTw2cp2VZJf/1jG6RlOhGdqQ
         58C4FpeDruRFpNggD3QOt5RNRmNgPwEfDYqE6aki8fUw7vYaFjYND/ysqvlPX3luE6Ou
         ngzm/ub90he+F89GcKQBePWLH5lKzUygeo77SuBelUPxWxxxtI9iOYneX/IUN80A43bu
         i28wm2uMAlo6GsoEPDSh8L9YoQYeQs7TEnWEiI7Km+VK+y3Nuj9OwwjZ+ZT8mSEvrHai
         0OuGbIJlebi0RH1MK7NhaxeEJc0rueHRykNEnf1vB7L5NOhzn920GCARAs7aeCXwq5XS
         xNGA==
X-Forwarded-Encrypted: i=1; AJvYcCUb3hfhG9mtQjaI5cAqFDm0dIVedLkmbDzb3pQfgJt0FASQ705URLmRdct1H335VI3t+rgPmVZ60kkKVb4a8VTwoCbSdymY
X-Gm-Message-State: AOJu0YzO2ZjP8SNJGjp+fe2qlVwv8suNe+ls6kfbRukIcY1A/w7vPbpF
	pWvxN/rfGaH3ug8t/Lwup7XJRtINqidRN/dsmF6mhwys25aq57kvqJUYmXSPUn4lGilq5yjIXok
	em0V8IstuGJbvQ7G6bQngsMIf2VB2XTS8Aiyg
X-Google-Smtp-Source: AGHT+IHpgmi+JfcaEEiOj6RfPhdxMYW2Sm/QS6Q8XvqZTKfvSH800aRiu7iKUXWfcHd3uashCFWiB6o9aHdEiPjDAn4=
X-Received: by 2002:aa7:d704:0:b0:572:57d8:4516 with SMTP id
 4fb4d7f45d1cf-5733415ad8cmr187759a12.2.1715266184217; Thu, 09 May 2024
 07:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509-gemini-ethernet-fix-tso-v1-0-10cd07b54d1c@linaro.org>
 <20240509-gemini-ethernet-fix-tso-v1-1-10cd07b54d1c@linaro.org>
 <CANn89iKgi6yEEenSy1M-PVRYWz=Ri9UorV7irCywOZ8xTbNk_A@mail.gmail.com> <CACRpkdYyyQ_=2FmEe7FjDT-2BrhO5GezdXk35werHwBNA=uO=Q@mail.gmail.com>
In-Reply-To: <CACRpkdYyyQ_=2FmEe7FjDT-2BrhO5GezdXk35werHwBNA=uO=Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 May 2024 16:49:30 +0200
Message-ID: <CANn89i+JphFK4TCVjXxbxCicJwrxFC=+ngjnheZWK3KvCJ4Ocg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: ethernet: cortina: Restore TSO support
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 4:38=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> On Thu, May 9, 2024 at 10:21=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> > On Thu, May 9, 2024 at 9:48=E2=80=AFAM Linus Walleij <linus.walleij@lin=
aro.org> wrote:
> > >
> > > An earlier commit deleted the TSO support in the Cortina Gemini
> > > driver because the driver was confusing gso_size and MTU,
> > > probably because what the Linux kernel calls "gso_size" was
> > > called "MTU" in the datasheet.
> > >
> > > Restore the functionality properly reading the gso_size from
> > > the skbuff.
> > >
> > > Tested with iperf3, running a server on a different machine
> > > and client on the device with the cortina gemini ethernet:
> > >
> > > Connecting to host 192.168.1.2, port 5201
> > > 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=3D1c=
8a
> > > 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=3D1c=
8a
> > > 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=3D27=
da
> > > 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=3D0b=
92
> > > 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=3D2b=
da
> > > (...)
> > >
> > > It also performs well: ~268 MBit/s.
> >
> > This does not look very good to me ?
>
> Oh it's pretty typical. This is an ARMv4 router from 2007, end-of-lifed
> in 2015, and it is not meant to be stressed by the software like
> this, the idea is that packets get routed by the DSA switch
> (RTL8366RB).
>
> > What number do you have when/if TSO is turned off ?
>
> Around 187 MBit/s.
>
> > > +       /* Translate to link layer size */
> > > +       mss +=3D ETH_HLEN;
> > > +       if (skb->protocol =3D=3D htons(ETH_P_8021Q))
> > > +               mss +=3D VLAN_HLEN;
> >
> > Are you sure this is needed at all ?
> > Why not include IP and TCP header sizes as well, if the datasheet
> > mentions 'link layer size' ?
>
> Actually that code is just reusing the mss variable for
> skb->len in the case where TSO is not used, so I'll try to
> be more elaborate in the code :/
>
> I guess I actually need to account for it if ->gso_size expand
> to the MTU of the interface if I bump it up. But I don't
> know if the the TSO code actually does this or if it is
> more conservative?
>
> > To double check, please disable GRO on the receive side and verify the
> > packet sizes with tcpdump.
> >
> > Typically, for MTU=3D1500, IPv4, and TCP timestamp enabled,
> > skb_shinfo(skb)->gso_size is 1448
> >
> > (Because 20 (ipv4 header) + 32 (tcp header with TS option) + 1448 =3D 1=
500)
>
> I disabled all segment offloading on the receiving side:
> ethtool -K enp2s0 gro off gso off tso off

>
> The iperf3 -c generates segmens like in the commit message:
> gemini-ethernet-port 60008000.ethernet-port eth0: segment offloading
> mss =3D 05a8 len=3D2bda
> gemini-ethernet-port 60008000.ethernet-port eth0: segment offloading
> mss =3D 05a8 len=3D27da
> gemini-ethernet-port 60008000.ethernet-port eth0: segment offloading
> mss =3D 05a8 len=3D0b92
>
> And 05a8 is 1448 so it is expected.
>
> tcpdump -e -X enp2s0 gives this on a single segment in a segmented
> iperf3 -c transfer:
>
> 16:24:09.182095 14:d6:4d:a8:3c:4f (oui Unknown) > fc:34:97:01:a0:c6
> (oui Unknown), ethertype IPv4 (0x0800), length 1448: OpenWrt.lan.56624
> > Fecusia.targus-getdata1: Flags [.], seq 18664:20046, ack 1, win
> 4198, options [nop,nop,TS val 2770370491 ecr 3490176978], length 1382
>     0x0000:  4500 059a 8ff6 4000 4006 218d c0a8 0188  E.....@.@.!.....
>     0x0010:  c0a8 0102 dd30 1451 a701 4f9d e809 8788  .....0.Q..O.....
>     0x0020:  8010 1066 0b60 0000 0101 080a a520 7fbb  ...f.`..........
> (...)
>     0x0580:  de60 2081 5678 4f8b 31b1 6f85 87fe ae63  .`..VxO.1.o....c
>     0x0590:  e2ca 8281 fa72 16aa 52e2                 .....r..R.
>
> As can be seen in the header, it is indeed 1448 bytes when arriving
> as well, so it seems to work!

Not really.

Try to disable TSO, and look at the resulting incoming packets, how
they are different.

If skb_shinfo(skb)->gso_size is 1448, you should receive something like

seq 18664:20112 .... length 1448  (this is the payload len at this stage)

If you receive instead ".... length 1382" this means you gave to the
NIC a 'link layer MSS' too small by 66 bytes.

