Return-Path: <netdev+bounces-166628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDACA369E0
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 01:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FEE7188D1CE
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 00:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B8B2904;
	Sat, 15 Feb 2025 00:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9VII3Qn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B9123CE
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 00:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739578608; cv=none; b=EMAk0FygK/aGiwkQ4c/AvjbKtHri+wd17bpvI3V/FwC8EFqxJWmL5y/wDoZv0SvOxFjiRCq/ZAErcjq7o92aR26rqSgtwurg0PfOdUDagQUvHRlBI6fNonhTM1MDHFq5Q7wMOwhzXrLoeRleTa4wVhGvJn5lQXRT9mo7bdlG0O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739578608; c=relaxed/simple;
	bh=D2SCaHdJ5Uv9zwhYnr6/q0jcZMSrHRoB3Gr1cLTNE7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+Bfyi/AIpUkLt6Cj3pnDluqhVbvN20s4bvWDOZE40lzv6sPuyH8DPT4tZSRhj1U1eo6BWC50Mx0ILXX3UCgSQ58RnX9DrU8uV/PZmOGtxyy9drC/nu3gZZ5J6M9dhD1znF5enQzdV6Ph8HCAQGZR07h20A3Z+n5hTJNQzgjH/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9VII3Qn; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8556adad825so164197639f.0
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 16:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739578606; x=1740183406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIYTQjEcR5Z/E9TAkt0SEMExY80Touo+m4xMxu98j5A=;
        b=B9VII3QnCbC2gynHU8+0KrielErll0FzQV4ZZHyiPfCX3VssP4H+mLF7C62sp55Vb4
         jstwwRpRjZBNsItB8cM/GpWzKfDgGESQJnrmoSUseCDHDFwy9oV4YQlfnGyZSjPJrby0
         RXuKLsN53gOeRVMg94g1ZOpWqHhbmVTHfdgeb1FDsTcS+NJjCGQnUdoFRS10v9Aj3008
         CfAqPHeFXxVUcjJ6pdRozlQN6GpyDbJQkY+GkHRkR/hf3vhdHoEEFA4BsrSOwBJKh1B2
         qfAJiNpsRWjsiAKspq7OedPUJUn9AG1P7Ji4ZFPrcfYw3yllTU8IZDPLECMCJ/WNK1OH
         Xr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739578606; x=1740183406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIYTQjEcR5Z/E9TAkt0SEMExY80Touo+m4xMxu98j5A=;
        b=JilXZejpux+3nn96jpoz2tjVPEtEFoynkbs8wVdbkdFvrtSEfm73HS6ylLD14GtAnI
         2Yh9t0gdIr6igQtCUZMJ1Hvp5gNP2DwdjlryELcQy4gZ6wBeMiUbjPvCnbIibV9XEa09
         tj7wfa6mGjZcUYhe94Y+UWcEg8s6RpnvLgAeOCqnUDUqzzIacFp0JESV7vTQAJ6l9pcJ
         9IcTQd+r4K02njwn2Xh6ALgJ5yXDCixZlprzg/sygi5MtOHfvF7X6rgDkmWdBZ9W0Ncc
         YmREZYi9FtcmECCcE9ibxkN7xtoSYCJNiOLpwYoKZ6LR0czX70g8iwaHkjGS90Lo/dM+
         5p9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVS0yZxTZ8ZVGxRFwvag0WsOy+N4zth/95skIVk+u0j3BiPfNzvlNdTdISBshwOrH/hsF05+mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWil3JqU9DLcU1H+wveDCTO4JmPpoxrxpuLOhrAWWl6gw5q+kx
	zVv/cCkzm+GeZw3bM/hp8+LWrtczh8L1LLf9mXaeJ+Z3/4BFwEG1o9nYFtNBqySBVj3RxSkV9Iy
	jLTwI4WII3JpMPBm0ERGHEjI6CURUQ3FjrFV09hs8
X-Gm-Gg: ASbGncsIoppwnjSNGqhgcCqKNpunh/nT3IN3PqVgDHXnzV4YslRfTNMkS/mFo0H5sGj
	8C8E6YwcQz8hiNA5Nd7pltWbVLbRV6SLSq3NKTtNkEvr0JMwEkCWLOdVdXgcWsxMwrEB0aRac
X-Google-Smtp-Source: AGHT+IG2noNYq659V19zM+dtMHeJqGdWWDxzDAUX52qPQ/ZPnEvPBPiddVQJG/dE2v9SFLYUwI2OQkjHW4pRwNwM3L4=
X-Received: by 2002:a05:6e02:3984:b0:3d0:f2ca:659a with SMTP id
 e9e14a558f8ab-3d2809b0cccmr10351255ab.15.1739578604652; Fri, 14 Feb 2025
 16:16:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPpvP8+0KftCR7WOFTf2DEOc1q_hszCHHb6pE2R-bhXMOub6Rw@mail.gmail.com>
 <20250214171219.GA8209@1wt.eu> <CAPpvP8JZL0zUg13kbMnkz=he93p87SBj+8K3ubRA=JheKT1p0Q@mail.gmail.com>
In-Reply-To: <CAPpvP8JZL0zUg13kbMnkz=he93p87SBj+8K3ubRA=JheKT1p0Q@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 15 Feb 2025 08:16:08 +0800
X-Gm-Features: AWEUYZkQtlybk0kXWcHwmT2WUZhwP_X1K9NLmQnWmdjd00S85o7KphpYQA-dBJI
Message-ID: <CAL+tcoD_DxWPFUiQaB8va=pw+g_Aku_4bhO+d7x9Cfgz6fHKig@mail.gmail.com>
Subject: Re: Question about TCP delayed-ack and PUSH flag behavior
To: =?UTF-8?B?7KCc7J6E7Iqk?= <jaymaacton@gmail.com>
Cc: Willy Tarreau <w@1wt.eu>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 2:00=E2=80=AFAM =EC=A0=9C=EC=9E=84=EC=8A=A4 <jaymaa=
cton@gmail.com> wrote:
>
> 2025=EB=85=84 2=EC=9B=94 14=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 12:12=
, Willy Tarreau <w@1wt.eu>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > On Fri, Feb 14, 2025 at 12:03:17PM -0500, ??? wrote:
> > > Hi netdev,
> > >
> > > When tcp stack receives a segment with PUSH flag set, does the stack
> > > immediately send out for the corresponding ACK with ignoring delay-ac=
k
> > > timer?
> > > Or regardless of the PUSH flag, delay-ack is always enforced?
> >
> > It depends, it's possible for the application to force a delayed ack
> > by setting TCP_QUICKACK to zero. This is convenient for web servers
> > that know they respond quickly and can merge this ack with the
> > response to save one packet.
>
> Thanks but my question is about the kernel's default behavior.
> It sounds like there is no interaction between PUSH and delayed-ack,
> and it should be handled by application scope.
> Can someone confirm my understanding?

I think there are two patches that may arouse your interests:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D4720852ed9afb1c5ab84e96135cb5b73d5afde6f
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D1ef9696c909060ccdae3ade245ca88692b49285b

As you may conclude from the above link, no direct interaction between
PSH flag and delayed-ack, but we do handle the !ping-pong case. I
guess that  you may compare the implementation with RFC 9293[1] and
find the difference?

[1]: https://datatracker.ietf.org/doc/html/rfc9293#section-3.9.1.3

Thanks,
Jason

