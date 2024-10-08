Return-Path: <netdev+bounces-133111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7388D994E3F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 15:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56FF1C23E80
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C911DEFC9;
	Tue,  8 Oct 2024 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fT18YtRT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90E116FF26;
	Tue,  8 Oct 2024 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393260; cv=none; b=DctJgiNnDHyc/I3d9CSIgPvIdf2FrT6Bk02zXKM3VnhqIEIOWpTzh2IZXpz4LF0SAB988dYEvNQujUoObLn0aWNReWTJih7mvuaWzirjvdYrCoewstMfqoc5t6fR66Nv0eLxRdWpuh6j6l8AENj1lBXYwi6ayntUu/lnw+wIqrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393260; c=relaxed/simple;
	bh=NMxQjc2T8csseIw5lnqI5Gms21LeoC5nw88NrOvZtiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/feyX7Hmy0jvxgBC4km9KiT662xDyCisD+0+R9G5IdI/iWV1JDvYnBy9Y0me/rdK6c7/6uQr6T0HK2M6W3nbfUFRmcc2izgLZ7CrEx4yepMchFL/V9uvsRVeTty2peUlnYizZdx3knxYO3UnDxBxnpDGtBNKkUO56QMF+N+U1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fT18YtRT; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-717839f9eb6so673843b3a.3;
        Tue, 08 Oct 2024 06:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728393258; x=1728998058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMxQjc2T8csseIw5lnqI5Gms21LeoC5nw88NrOvZtiQ=;
        b=fT18YtRTM/GauX11FhWrJ7wxYEDZLmebbrKa3XstyDMT3mUg1TcjUd/FsHwXezWpVG
         7r1R3bNkS5y5uT0do6wiSNRqs/gdqtziC3zYcomO/tCd2z8nPn7+Of7xVgO3PLqCe5uY
         KTe9PrzuDhzz/xQdiUxaPOpiC3lkt3ntmwIHkDj/GlYNLbVCMlnyHXEFvionoM/Ldspm
         chsfgK1x6/MPRRt4OW8NfkmU4TjbS0/+gzZBPRMNzJVEtOXMIm3TNesCBQhmFv6VgX/F
         73/1cBrwIVi9lGIgPd9cfrcuWbhICEzsWnogPhub40c8w1CL6y1kERmA/j9EdJfTxBVZ
         GKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728393258; x=1728998058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMxQjc2T8csseIw5lnqI5Gms21LeoC5nw88NrOvZtiQ=;
        b=Zkc11njBE3fYR5COe+lPHMZ2QgzuA7pbY58Pa8DvXySPwkS3P7pyB/jvWj23I7Iqr8
         PNNtezteY6nbFjrYTIa3aE446vvGEm2y9CafkdGxvYn7i1lT8EdMUAYzDeLNep1YEcwC
         zg5RtsTM7PJJwSaNFDyHLjtBVvWT57KY4Ah8+xBSI0G5Qkhavs8ltPFf+4xNertKJwjh
         oKmEmj5JakqeJtOIL2MokN0frA/lpYZU1vnTHXSIb1Au2M7L2VQw5iVboSTH6NJ0MPpt
         Q7Awe1xuVrUNj+ACjsCh9WgOO0f/1RKH5SY4d4SVJYMQL5Qw/JKkWKgqQDRU+g1cIV7D
         DiFw==
X-Forwarded-Encrypted: i=1; AJvYcCV2Npxic0tYEDpdG2jf1DSgH4dNNV5llJ1Pe8H6PYEN/Xyy+L+V2R05KQbjC3sKoURRQb/RCXbDohFmzqKNzDU=@vger.kernel.org, AJvYcCVHsuKqeX09qMOpzwBt1rRwemwQt0/P81fMEfKSZgqiMuGYkKY/8SwydjRtQiOf3WgrU+Ui4M0t@vger.kernel.org, AJvYcCX9hP2gs9B5EGLybJ3nYwkgQaccjKOti512DwO20lGT29kr5X6DObMyWtNSxz6VtniFhtUDqLoGvJAakzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YweUS6024j0+Ae1XiIvASJEFVIeYiWa0GlIfMi69n90sR3yysdD
	Z8+qJSWpW8itNm21maEk0acK9TCinmpNN2Zyhn1+3uGT/roZO6DLJL1FVCZb28t+bg0l72lzXTV
	CyISdxcqIuHxvmEyUCoWYcWIrxHg=
X-Google-Smtp-Source: AGHT+IFIuvyES4s9VElGPqNkC2xj2m2K4rPwfHrrItKyso51Yi8CEyESeZiYUdAkjVNkI+7vvtUAuf75lShL5tVVHd0=
X-Received: by 2002:a05:6a00:84f:b0:71e:1225:77f0 with SMTP id
 d2e1a72fcca58-71e12257b7fmr1664544b3a.6.1728393258158; Tue, 08 Oct 2024
 06:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005122531.20298-6-fujita.tomonori@gmail.com>
 <06cbea6a-d03e-4c89-9c05-4dc51b38738e@lunn.ch> <ZwG8H7u3ddYH6gRx@boqun-archlinux>
 <e17c0b80-7518-4487-8278-f0d96fce9d8c@lunn.ch> <ZwPT7HZvG1aYONkQ@boqun-archlinux>
 <0555e97b-86aa-44e0-b75b-0a976f73adc0@lunn.ch> <CAH5fLgjL9DA7+NFetJGDdi_yW=8YZCYYa_5Ps_bkhBTYwNCgMQ@mail.gmail.com>
 <ZwPsdvzxQVsD7wHm@boqun-archlinux> <5368483b-679a-4283-8ce2-f30064d07cad@lunn.ch>
 <ZwRq7PzAPzCAIBVv@boqun-archlinux> <c3955011-e131-45c9-bf74-da944e336842@lunn.ch>
In-Reply-To: <c3955011-e131-45c9-bf74-da944e336842@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 8 Oct 2024 15:14:05 +0200
Message-ID: <CANiq72m3WFj9Eb2iRUM3mLFibWW+cupAoNQt+cqtNa4O9=jq7Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/6] rust: Add read_poll_timeout function
To: Andrew Lunn <andrew@lunn.ch>
Cc: Boqun Feng <boqun.feng@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu, 
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	arnd@arndb.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 2:13=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> As far as i see, might_sleep() will cause UAF where there is going to
> be a UAF anyway. If you are using it correctly, it does not cause UAF.

This already implies that it is an unsafe function (in general, i.e.
modulo klint, or a way to force the user to have to write `unsafe`
somewhere else, or what I call ASHes -- "acknowledged soundness
holes").

If we consider as safe functions that, if used correctly, do not cause
UB, then all functions would be safe.

Cheers,
Miguel

