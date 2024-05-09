Return-Path: <netdev+bounces-95027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAE78C143A
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 19:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50EE8B20F28
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 17:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44C96EB72;
	Thu,  9 May 2024 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y8xRmq5m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073F26BB21
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715276567; cv=none; b=A2S8f7c1PoBV1iOMtbcQDwhtymU/IFzmkw45K7hFWvTcnf32asiHpcQ8an/8DUSr6IO+zIuryh00Zi5n168PXpKVdAvxg3GCXMzDWk+9QQ4Dn4PtKxXYyhixV6MS0UsaLnvEs7r4XGB3zHjQ9usixlAo5WoMBqduUCCji53khuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715276567; c=relaxed/simple;
	bh=8Th+d+yqIk1x+V5D6veDU/jtQirevZYPvJp8NlJBRn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBG5llrEWcVZl3pzkGLf27v362ZWBh/6C9CbTekzlZ1nliLF/X3WhpWq5kNlHy+yPHMkEiWcgkvV6wrVpHkYPMJskz42ooCNe8nJtBD+LQYDMREHUbuP164hV+eBf9D5HtQsrBYxMOzUlYFt2ofh7T8+Ng4znqH1DgNmCe8Dttg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y8xRmq5m; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-debaa161ae3so1197771276.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 10:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715276565; x=1715881365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRkOx6kJ5XBmJbuREyjzpIsocenr4QnppqMrcEt3PXk=;
        b=y8xRmq5mEVbZdmJTBrS4duKE42741lzF1pjxFm5wzwk6TELEHMO1Ytwb/p3kyxsHsQ
         4FqHxE66pV+dC9gHaTKgLC8u+KCGocn3eAven7Vp+0ZJVMFTv7szpPuEG0UvhKxFHkcM
         4ITcpbkuGwy/7MozBattuSfgE/zfPG7IFnWZHKLASp6bIdGshsuCEXueh6/+NHzRxkpY
         A0GZhh1rgXsIyZHeiun+jVI8+KV+SXjqWWqZuUPz9R5lXbDkG9Q16sfrt3j9nhiTmSja
         gHWhI4+HuK63T5ZFdq23fJwB18bmqU0n6TP8h5KwdqaBtA5SkXsxHPY7C/K6g5U3AbAC
         ZhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715276565; x=1715881365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRkOx6kJ5XBmJbuREyjzpIsocenr4QnppqMrcEt3PXk=;
        b=fld+t4sPjxNo+Att2fe0nj2JA1pdcv8llbqSGwoaRNNdAD1zpvWTAI1r6y+1UOu2i4
         pXi7eYUVgBMyaiZH3cIBNz//QAmDc2p75tvsF4ChX1Qdhvgjtopaxk3A3m1rsJste8MH
         +nVBxeAYSYgzfCi5UuDvfiiMQpKF4L3Qa0FXZxAqcufX6HIfpEp0GA8MA6QiUNo6ykVd
         AtyQ8o35CSVhRSQRHV+VXdVVOsQNughg0QRJlJkwL45vSybJsVtlWEjSrPHGfVyK/Zf+
         N1+UFyJiQazzeJlhFeFmqhq1fSxrpgIYG5+8Cu4d8U3d422pRGtjXpj0hIaq5hFFUCbj
         fqcA==
X-Forwarded-Encrypted: i=1; AJvYcCVFCc/hvhjbDWZfbxk0Vumq5DPZQDemw0vQXqhyvsC/G6s22eveU4p4+d/dq1utG8EJraHRvdjCYnaNIyT8PCOgBq2RarrR
X-Gm-Message-State: AOJu0Yx7T77ibNfpBWV+CyuJ6lVWBvPY1bZ0FNNCsP3q5vAWdG2x7Rku
	QSQN5O6gH+2jRsrZ9dHGpUpu4uC7+GdxqBRPA3F9mTZLicVVmtE0YmNe7Rtgc2nOt4PQxNTQ1LH
	Hls+8W24qLygU+CifbTGxywv+itc9jZcpfFt9UDM5fSmzGcUlfHU=
X-Google-Smtp-Source: AGHT+IGLoq+EjQTKMOA+LiHF4eWnOldFC/sJUQPzaAtDe7V8bm6Q8Z9tlch/oXE4U67MrRtTWovej5R35FpMsBMxiOQ=
X-Received: by 2002:a5b:c3:0:b0:de1:d52:ddfc with SMTP id 3f1490d57ef6-dee4f35b5f2mr258499276.29.1715276564907;
 Thu, 09 May 2024 10:42:44 -0700 (PDT)
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
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 9 May 2024 19:42:33 +0200
Message-ID: <CACRpkdZYOR30Y1F-PfpDWznax09F-AxhwJjzWZHEgZPo=vW7Yg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: ethernet: cortina: Restore TSO support
To: Eric Dumazet <edumazet@google.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 4:49=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
> On Thu, May 9, 2024 at 4:38=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:


> > tcpdump -e -X enp2s0 gives this on a single segment in a segmented
> > iperf3 -c transfer:
> >
> > 16:24:09.182095 14:d6:4d:a8:3c:4f (oui Unknown) > fc:34:97:01:a0:c6
> > (oui Unknown), ethertype IPv4 (0x0800), length 1448: OpenWrt.lan.56624

Notice ^^^ "length 1448, that's at the link layer.

> > > Fecusia.targus-getdata1: Flags [.], seq 18664:20046, ack 1, win
> > 4198, options [nop,nop,TS val 2770370491 ecr 3490176978], length 1382

That is on ... whatever tcpdump decide to show.

OK I might not be the best with this tool.

> >     0x0000:  4500 059a 8ff6 4000 4006 218d c0a8 0188  E.....@.@.!.....
> >     0x0010:  c0a8 0102 dd30 1451 a701 4f9d e809 8788  .....0.Q..O.....
> >     0x0020:  8010 1066 0b60 0000 0101 080a a520 7fbb  ...f.`..........

Ethernet headers missing here.

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

I think that is what I get?

> If you receive instead ".... length 1382" this means you gave to the
> NIC a 'link layer MSS' too small by 66 bytes.

I think it's right, I just suck at using tcpdump switches :/

Yours,
Linus Walleij

