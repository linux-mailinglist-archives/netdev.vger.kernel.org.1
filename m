Return-Path: <netdev+bounces-119802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BAD957035
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 18:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708C91C21329
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD204171E5A;
	Mon, 19 Aug 2024 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJ4f9CQR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8D082D94
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084849; cv=none; b=AFV5Skbayt57y50xvdpDjXHeuEqRB4mZwM7H71EGgng+x3Tchpg0dNnBIjVrtmRcvq0mew+11eBTKYUvhcE2d2oKn+QfMZS5FP6/CKAZ5+gdF3pOxB6THpJeckUXI2Kg5rNIMIVP6uYKF8mjuMVOc6KrLVHSPMVerihjqkVjVCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084849; c=relaxed/simple;
	bh=L67rNTOGCdBkDQMLIMDTBr2h2D9BJ3lWh1sDIG3gSSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g33MQcEcDYA6CSFfYbCZ5CiRGzMByMnRQs8vk4r3qfOqd+4A/vDPIfgNwH4rBWwkBqwvq1GlsLB66Ba1RYIJ+BtiEaJIi6SyQIs0dqspcF2/kIQJj+52EgnmroTpmZSVXMbStwM7Btw/mMHgCrDRx/SgI89alAkIkjQ7TwaRwKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hJ4f9CQR; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7d26c2297eso525676266b.2
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724084846; x=1724689646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2IbD4QdB4aNtr+13IEioNi54TR0kNQi5UKwIJ2d/Dw=;
        b=hJ4f9CQRZpldzB4CsTK3yb62pnEndo0XzkJ6cjtd351ZYslPP88t53Fs1Pf/rPE7kX
         CG9/gPNvQalLCIo0VlHy92T0Ma13lr9jKa5CCx6xI5tEsXANqnx+z9jx72QwjkRgxL/V
         EGM+/pD9YjWXl4YmDUbVcYCYy+wTGB7hFmzCriKlg2nfBEVffhUqrqNhpv40z5LlkUmM
         Z6/AAyFrvOHmd8hKSlpZHLXmxkarPTCRabrjwbMFQgLOEdkj9IJjp/v+c8rTQJRNna33
         SPwKO7GUTCnGHVZvpM7Y17X4hl7R9YQrZKtNy3rGB55r0XO/rsv4lD6cLPDTuA3IuYTz
         /mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724084846; x=1724689646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2IbD4QdB4aNtr+13IEioNi54TR0kNQi5UKwIJ2d/Dw=;
        b=Z9u7LyQRp6163CYhzdsh2X2zqaTqnPLX09nj9RUzgUpQJ9Jza00pIAG4WcRMkbM1Nq
         aKYTqPhK/Dod7Yp2SlfOO0wkGALmCoJTpujju9z+y4VAABo3DgAzElrdLbGwRyEwtj4W
         SO572OxKTUyVkYDZ1pw/d99alZTq2Eb6eQsDtl++2RWKSwbae1zfG4wPpZ9DkK50Rf/Z
         4YHTYrDCRzGwluxgxAbcSjnvYCprsHK+8D28YGlRqtsOEXaCAQ/S42PEfz/rRuCR2ORV
         BVaWjeDEbVpjQUOuTvpuSNAz79rENu8Cf5ud+8BIQ2nXahjL88hqW4rgX0xSakuVr4wY
         q8dA==
X-Forwarded-Encrypted: i=1; AJvYcCVGURfLZzTG7PAzbkfiiUzZd3lzTzT9G4PryIDuXgkZTfri/RTI8GEeH4ZOJwh/pFpL2Z3+Q4f5MsZr4lajK8y6I7T8ZOjF
X-Gm-Message-State: AOJu0YyG8pr1DMRorCwiXGyrHT+9wY1FXeV6TeTi/E5BQkPdpi3Fqs7d
	xL323aANC4J6JSdL+aUJrvs4pu9U38ipJMKHLL1VvwFQukrFpIM9MfPRJWNXFs2RnCbbZEzWRGK
	ckPRnrxZLGe1Jb1mSzGmSCrKsBB1NCX9Cli0z
X-Google-Smtp-Source: AGHT+IE0rKP0jYxOQpgb2J6y9aTWSbrssnfqdqTTMiCw7X2maxrKUKIaWl4pMy0XfoyyGRhi8ZIXRwcP/UW2dxrfZQU=
X-Received: by 2002:a17:906:6a1c:b0:a80:f79c:bc44 with SMTP id
 a640c23a62f3a-a839256a2c6mr874696466b.0.1724084845554; Mon, 19 Aug 2024
 09:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABnpCuCLN6VNgmoWHwc4_8AT34xqmQnEoUHLncvE2yLqYZBaKg@mail.gmail.com>
 <1233c766-0260-497d-8700-87f0f76d2bcd@lunn.ch>
In-Reply-To: <1233c766-0260-497d-8700-87f0f76d2bcd@lunn.ch>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Aug 2024 18:27:14 +0200
Message-ID: <CANn89iKV0usnRRcywkDqytOhnJNu8Bfs72D+BCg8+ESn6EA3Qw@mail.gmail.com>
Subject: Re: [BUG] net: stmmac: crash within stmmac_rx()
To: Andrew Lunn <andrew@lunn.ch>
Cc: Shane Francis <bigbeeshane@gmail.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 6:25=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
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

Could this be related to IP fragments ?

Header splitting might not work as intended for IP fragments.

