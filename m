Return-Path: <netdev+bounces-119887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B22C957562
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 22:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A132837C0
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 20:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A391DD390;
	Mon, 19 Aug 2024 20:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpJ8eKb2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170571DC491
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724098151; cv=none; b=JcJItiYNIfmegjA0mj2tvMuQiNcPILiG8qD6P+T9zNhJgVavhCriJxkhu3/LXssueHKkBQoPNK3v+uEWmqTLblZBPvGdd2183ZR+iSIgc/oMP9x1HINWSfzYxCShLBKwhYhSJRyti7Ru0OU4SN0avSVCOE+Xm/zw1ujkPYmnX18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724098151; c=relaxed/simple;
	bh=wbalN9YW/s1SkFWJrn4WKA31Wphjmi60btrfhztm/Yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1WWsBmbkL2pB2Kx0cVbzcZNbGE2QwQJ2nluD36o8G2ALNfoHkvIMMA43WjOgh9T6+p7Dvh/V0pwjkrzDdTrg5d7u6yZyNvSMOoYlDSWqFEsY4V5Fv5eeDj8gZjd72RS8Rg0JfGVoUdMLmrPgHCKLPPnbuFHp1sOU9DIklHvATo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpJ8eKb2; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6b45d23a2daso23433537b3.3
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 13:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724098149; x=1724702949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxvnRHSOgHCD90TbHScAVNAsiDA2H/PD4vXLDPg+rYI=;
        b=JpJ8eKb2qaC8h8azDbUpdU+wMqMxqp6Yt0tXHU6MooswJ8sTNv0LiiTfXgM+FzYHMe
         h9bsSmF0myxCC5yLhE7qDRL3eBNcPl+1iAH/7MBVrq5tCw/6G1LUq93ylUuhdNuTauXx
         8nHlvf0lmZZU2vlJn27XhOz9iu1DOnm/KtD5VuDAIZ+PooLFv2T4m/Hk7yz3nwyzihGK
         YSjhjkjDPjxnH5qWa0/PUWGF0tM7Hqyui9Fy/IIXed6H2Nwd5SE+OQ68BH6xD+JOJJPI
         QJgVEUUCIx5j0GcQt3j7dMKxtTsolmdpYfkJnIjVgsdm3peVx919yn7Pl2p/YQQCiFCH
         wlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724098149; x=1724702949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxvnRHSOgHCD90TbHScAVNAsiDA2H/PD4vXLDPg+rYI=;
        b=aoGtdc5RN4cpUeCY4921mtNPwcMq9inEse4Wk7FRL0NDNi2rUlXRM8XY5bv4a4y6X2
         ELQdNQa6TOsTrsf55vOJ7tsR2pfquKhoCnbIpaYQxHx3PrWogDBmNMTOYKpTkcygsOIL
         Bq9gFOO1rxqJclM29ZBAGxX4V+PuUE0jv/O/dOFDRx55lNouyBfleiD6S3oMicxOToeY
         bDZub0Pt3zk5TEX7Orh+nW4LmBzZhbqOhAiOG6PES+W1tVVWxjnqB3xo9EqTXMVUD8/B
         TWHzmTZYu8+zrOGX5LGghoyhUJnx6gqhQ9tnBlave/HPCiDrNjelCMPtuuLlRLWrNgdP
         kYqw==
X-Forwarded-Encrypted: i=1; AJvYcCVw/yuDEx1oqTzWCYAlmGHNKX9vGSmdljyVQEl47E893BNQiTJ2eiNaxX2GWx2k+K14nTxH7nROtO+NCMggVmci8dZTs84K
X-Gm-Message-State: AOJu0Yylv7gF+33JzH7qjfyf4Rcgl3z8JYpbGBQW6u9cTQIIZhaqZm53
	j9U3eM9aaGmrw1MKwbDKyvtqlbvJUtyEL/lGhynr48SwEl2UP36jyQNaOwOmTMuG+1rYPuDla6f
	RN3raedE94Au/ePKDEvEmYSOFhXo=
X-Google-Smtp-Source: AGHT+IGI47MmWpEzVuImXsTzF874PGu3BCsotc5+aZAKjuJTM2v2YxIyZPJKXzz1V6F017Tt40cYzDPK9jsZByqJJQU=
X-Received: by 2002:a05:690c:60ca:b0:6b7:a7b3:8d94 with SMTP id
 00721157ae682-6b7a7b3925bmr56233577b3.6.1724098148897; Mon, 19 Aug 2024
 13:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABnpCuCLN6VNgmoWHwc4_8AT34xqmQnEoUHLncvE2yLqYZBaKg@mail.gmail.com>
 <1233c766-0260-497d-8700-87f0f76d2bcd@lunn.ch>
In-Reply-To: <1233c766-0260-497d-8700-87f0f76d2bcd@lunn.ch>
From: Shane Francis <bigbeeshane@gmail.com>
Date: Mon, 19 Aug 2024 21:08:57 +0100
Message-ID: <CABnpCuD1J0Y-pdoSZTApYscdexSQD6RfLUFT-X-WQ_Ygj7a86A@mail.gmail.com>
Subject: Re: [BUG] net: stmmac: crash within stmmac_rx()
To: Andrew Lunn <andrew@lunn.ch>, edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew & Eric


I think you are both onto the root cause, although MTU is set at 1500 on ea=
ch
side of the connection I tried with 2 other gigabit devices connected (1 de=
sktop
and 1 laptop). These devices were able to achieve a full 940mbps in each
direction, only minor issue is a large latency penalty while under 900mbps =
load
(approx +120ms).

The device that triggers the issue when connected is a QCOM IPQ8074 based
router / access point. I'm starting to wonder if that is doing ....
some unintended
optimizations at a firmware level that the stmmac drive is not happy with. =
To
confirm the MTU was set to 1500 and nothing like GRO / Jumbo packets is set=
.

I will keep digging and pass back any more information, as even with a
potentially
misbehaving connected device the driver should not crash.


Thanks Again

On Mon, Aug 19, 2024 at 5:25=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Aug 19, 2024 at 01:26:37PM +0100, Shane Francis wrote:
> > Summary of the problem:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Crash observed within stmmac_rx when under high RX demand
> >
> > Hardware : Rockchip RK3588 platform with an RTL8211F NIC
> >
> > the issue seems identical to the one described here :
> > https://lore.kernel.org/netdev/20210514214927.GC1969@qmqm.qmqm.pl/T/
> >
> > Full description of the problem/report:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > I have observed that when under high upload scenarios the stmmac
> > driver will crash due to what I think is an overflow error, after some
> > debugging I found that stmmac_rx_buf2_len() is returning an
> > unexpectedly high value and assigning to buf2_len here
> > https://github.com/torvalds/linux/blob/v6.6/drivers/net/ethernet/stmicr=
o/stmmac/stmmac_main.c#L5466
> >
> > an example value set that i have observed to causes the crash :
> >     buf1_len =3D 0
> >     buf2_len =3D 4294966330
> >
> > from within the stmmac_rx_buf2_len function
> >     plen =3D 2106
> >     len =3D 3072
> >
> > the return value would be plen-len or -966 (4294966330 as a uint32
> > that matches the buf2_len)
> >
> > I am unsure on how to debug this further, would clamping
> > stmmac_rx_buf2_len function to return the dma_buf_sz if the return
> > value would have otherwise exceeded it ?
>
> Clamping will just paper over the problem, not fix it. You need to
> keep debugging to really understand what the issue is.
>
> Clearly len > plen is a problem, so you could add a BUG_ON(len > plen)
> which will give you a stack trace. But i doubt that is very
> interesting. You probably want to get into stmmac_get_rx_frame_len()
> and see how it calculates plan. stmmac obfustication makes it hard to
> say which of:
>
> dwmac4_descs.c: .get_rx_frame_len =3D dwmac4_wrback_get_rx_frame_len,
> dwxgmac2_descs.c:       .get_rx_frame_len =3D dwxgmac2_get_rx_frame_len,
> enh_desc.c:     .get_rx_frame_len =3D enh_desc_get_rx_frame_len,
> norm_desc.c:    .get_rx_frame_len =3D ndesc_get_rx_frame_len,
>
> is being used. But they all look pretty similar.
>
> What i find interesting is that both are greater than 1512, a typical
> ethernet frame size. Are you using jumbo packets? Is the hardware
> doing some sort of GRO?
>
>       Andrew

