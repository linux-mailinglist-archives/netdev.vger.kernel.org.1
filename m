Return-Path: <netdev+bounces-132415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1207099195A
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 20:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8062AB20B7F
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 18:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEF4154BE2;
	Sat,  5 Oct 2024 18:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvIXf4vR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F6A1798C;
	Sat,  5 Oct 2024 18:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728152206; cv=none; b=s183V+f4kn5H0+jFBDeGvCiWF04rtSH0j5XFE2HNCMqDw3vGdVVAk8QOeHFUStscc/pYc0k8A58H20Q9NRjErV552jD4vaug8USqbSoL3Hq2aykSdmsnEG7rP4Sc+avgxllOh58zX0rBytYIM4YJ2AOX0bd75O91haLoZ7GHpHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728152206; c=relaxed/simple;
	bh=C6LH3PKRZDefh/r5IILGNE6gt1xYxderuWzCzcfsT+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kv1e5ZvxvCvrjmOqL74Xr3tHTWXZIhbLXa+Do8QKlCca2w/w8pADX5DqntXc3yTn2cGTRxuyA/2plRPqz/3aGuOUzKT9fgOV6l5BS1oi7CNjnlABm7rXE4TpOSdgEMz9AhaaHAnZ4zCtxAhui7lM+mqeC4fB8aUE5cUyfZ289vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvIXf4vR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71927b62fa1so496209b3a.2;
        Sat, 05 Oct 2024 11:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728152205; x=1728757005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6LH3PKRZDefh/r5IILGNE6gt1xYxderuWzCzcfsT+4=;
        b=EvIXf4vRNnjiAGKxb9QItKPMPlDXnR+pIMMZEBpohfGTrJ6VqWpe4jSHxNcUh8hoDA
         EfbAQ4v6Ic1Vf/hcL4krEb3nLCGJ0cW/VJO7+yJrPkdnr4u8PiycrQqICp1JZhUxM1rf
         Gk38lGR/+74p+w7W/aMf/4bBXyRx4c2vwhsjDCZBSGyT5/LUrTAuYWV8ZK37FJQ7Pyyl
         gFE2NTdrmSvxQOzikWWi39y92vLJaek5QfVCvXdb/O+DvCfbgbwNFFBGHxHcP23gq/Fj
         qBxVHTx/UHEmJLmyr3HcsUAzBxy4KJNlOHSlvxtd4LSPFqGSnPUp44JF18G4Dcw73ImZ
         wfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728152205; x=1728757005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6LH3PKRZDefh/r5IILGNE6gt1xYxderuWzCzcfsT+4=;
        b=Z+7lk32kOZ6BzKcM5EBSOhhT/qDsfQf8LATOA3zBDIF5xOoA707LLC1HwyiJD5KJzk
         tkInamagQYyqW6QnbICweDw4cRkSCqtx+fVmE6RtJjBqqLrimiUav7p0BKAifmMvcuxC
         PM5UR9DPrrvJLUeAMBT+4X5cGaKjTOP/ZATbtt8B2yiK+9iOyUOIybkKzpsv+sK/jZ75
         ev1C3r21sSTfa9IiCjBwkPCiQuperJamDSIQlDRc7kQLtu4UPqOKJv+jY+h22JaP8tpd
         KCOlh1IgiblfMPEqzyvdplfqYOKXk4TtRvxdctJ6mfJ/ZXuD06PEr1/aQxavyt9YHqIs
         A2DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUPCvXiG4XJQPobPEnBoxBYBOzph+gu6asvS54nGdeZDSUTy+ewxsnSpZcqua5vH1zugADTYxp@vger.kernel.org, AJvYcCV9zZsWRR1rIQLqjZszLyhd1cQgB3eksqajIMXD3X6l5jQls6aRNimGXdT7T2qVtdtG4ZyJvwgu2K957F+Us0o=@vger.kernel.org, AJvYcCWlR0ahXcWeInSHOVaw2jOTTrUElTBuYx8rP95u1Pgl8TizoivitzuvlfBzZmuz7J/H3rqzF7v7h55kFXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwffKUJ+ivL1LfD1QcE9uYx1bJK8a3ZTwKQwRXM0K+cUNmS/7bQ
	MuhHUcDgXPUMTlS9Wue43VyWvcC8l/XRpUAmi4OJozoYQi7ghIfZd51357eN4pCtFYvpr03jll8
	H0eCj8/vBtwFg+VL//Jw4jom441w=
X-Google-Smtp-Source: AGHT+IEDNW1jrqHKnZBfYHj2ne2ZIFZS6obcuIN4vY9dMzIseY/fQUMkMNRk9p6U9QUqJgmh2CMKUmMT+y/u63RB9fc=
X-Received: by 2002:a05:6a20:12c5:b0:1cf:3a64:cd5c with SMTP id
 adf61e73a8af0-1d6dfa24167mr4911185637.1.1728152204933; Sat, 05 Oct 2024
 11:16:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-3-fujita.tomonori@gmail.com> <3848736d-7cc8-44f4-9386-c30f0658ed9b@lunn.ch>
In-Reply-To: <3848736d-7cc8-44f4-9386-c30f0658ed9b@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 5 Oct 2024 20:16:32 +0200
Message-ID: <CANiq72muSdubtAD03SdrbXT4H6ujUba+1YDCtGWA_ERpX35aiA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/6] rust: time: Introduce Delta type
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu, 
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org, 
	tglx@linutronix.de, arnd@arndb.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 8:03=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> But why limit it to u16, when the base value is a 63 bits? 65535 nS is
> not very long.

Agreed, for these constructors we should use (at the very least) the
biggest possible type that fits without possible wrapping.

> Dumb question. What does Rust in the kernel do if there is an
> overflow?

It is controlled by `CONFIG_RUST_OVERFLOW_CHECKS` -- it defaults to a
Rust panic, but otherwise it wraps. Either way, it is not UB and
regardless of the setting, it is considered a bug to be fixed.

(I requested upstream Rust a third mode that would allow us to report
the issue (e.g. map it to `WARN_ONCE`) and then continue with wrap.)

Cheers,
Miguel

