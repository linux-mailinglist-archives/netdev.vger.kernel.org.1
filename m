Return-Path: <netdev+bounces-200599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E705AE63F1
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 13:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65BEF3B0032
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 11:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF64E28ECD7;
	Tue, 24 Jun 2025 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tcp9b2Cb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8FC2868B2;
	Tue, 24 Jun 2025 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750766210; cv=none; b=kzMLEuVpWMeyTe8QKXXM0Z6T5grMiauyLJbNRs4hDf4M1gm3OYfEKoiSsNTadYZr6+20RWhaSW9FpII7YvmujsGQDcEpbjstDVwiXNvNMC1dpGxN3s6EclwakcXNxp+TXw3cd7upjvc5PytEu7Y/1uF41ObJoOXi5gJIl+Ha3NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750766210; c=relaxed/simple;
	bh=KtW1i2V2kg/cYDLAU9F/MnvVyp3btDwEoBN7+vmgFR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzpsF69GaX1QPmot54uanPcR3Vje1eQTYsOhj2YbHHcEVMrl0aJBSioPB8+aPWJraWQNFregdUTfggBLWGZEf/OtRuNYl7nSGSqSKD4PymAlVPSGstsA45J1ef/EjlFRKzG34UGFxIByTQ40u/JQdeYv8gKDXD1Dyq0rCTVHVD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tcp9b2Cb; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32b4876dfecso62323421fa.1;
        Tue, 24 Jun 2025 04:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750766207; x=1751371007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFeNxL6o7rovHjVJ3x+dZzZqwBMWzp7CPxUvhXDuIQU=;
        b=Tcp9b2CbgnUTry3T7VFetKI9DKpeGxFyjjHDC2Ze+0x6PvkBtqAM3kurU/8Xb6vp8u
         NO7s5RnCA5ujAXz2uFaY2OFXeJ6uwkLxwl8fH3fapwhFgWqwDrTPZ3rGKablhRMXd2Rb
         Yj0vgM4zph0bexVA1Bo7xWO3pdFEMyd9ezVTkQvUSwFUD1C5Vito4E68cB9JqGFoHYtR
         Jkcjj++afpJAq6M4J9NIFKhPzzOJpU1P44Pf8gx9ta0GIdp+nQ1ICbsi3qUyKvl3EAwt
         sevGvqX+a4dDavHQGukn4elMa5BPJc+2JLcwVom7cTSsCLDbYt5LvHMX4XtP7aDG4Vro
         ssXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750766207; x=1751371007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFeNxL6o7rovHjVJ3x+dZzZqwBMWzp7CPxUvhXDuIQU=;
        b=STTsa0uKN4ixkLQZ/ONK/vdthvf743ZX7BgLCeUpfaKHd4Iml6Ey5r1cBytxYxJkUw
         9O/8wRmojKZjmoxO58HImz+HTmKbS3AjPfGzwczbR6kR+P2858ttTa4UIoMLwylxeKLP
         pTus8gn895Ci9mqsJzWfXHn8aoM9XqlIlZEuB/M2+SFPQHLvjHSHEsbsOxyysqahHV6V
         CnqzMjltwccbPQeboXZOSF/mKjF5ZSUD36cYdrEwwvE342tvVvyOJOEMUJqMCRmOjN4f
         QFq3rqdRWN+du2vB5Xn6TZvZqa03L9e20IO08w56H7QbtqinoMPz0eWJcHm+nyTrdOfu
         rtrg==
X-Forwarded-Encrypted: i=1; AJvYcCUo1i90FXYX337sYuTC+BTNRHIY9L2n18Gjjtg9Dh5aoB5VuKMQOrVoipZf3ivbyk4L8tcOTuQf@vger.kernel.org, AJvYcCW8f+c14/FF/MVVzdfVymZqewgGFZzd+OqNjuG0xbp/frW4BqScoWXJGLCDp1pllabwGhYv2gJixW8XQJg=@vger.kernel.org, AJvYcCXyWjXervYc1M2mgWdQ8CDGy1VFY3vwRZ5nyhG2OrJj/O6lACR+4mTtGGkOwaqU1e1F2GHC/7ZqABpsb+lrMMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzc+HawXuUXpm/rI9ZT2KtqkmH1tEMFaxfauzflqYlJFsWIzKV
	eOXytPnJ2XyS7dJmzXbj9EKVu7GZHNJ/u68XJHw+ZF3O+KuYIpYaMhGNUstRxrWUqKIjiWGDV7M
	GEug/QafYNnTJLODVFJwHCNemolsfg/xAyqdH
X-Gm-Gg: ASbGncv8cYPPZwBV4lDTucfj/MnekVxrYg1SSQXm6C1idhrOZ2Zd++ljJRmEgvxgAtl
	stm1vdi+Q1scGpxTsKvy3b5R/01/F9XCGbHpcUEAlYBcgIQmf6vNv9K308vxEZS/pEubjJWIw/1
	kWXP+9QtDtK4adQWdxhZnnHR3xpI90rw9RmOjLIx4CJ2IShG2Tw7aMFw==
X-Google-Smtp-Source: AGHT+IEj9s4F0ahzMjJ0Hf3Bz6S35/B/DG+wfdAm7F1HuJfjumlwP99TcCQkTXEH81704n7fM0jf6yFaY10IQJM8qQA=
X-Received: by 2002:a05:651c:2221:b0:32b:7811:d451 with SMTP id
 38308e7fff4ca-32cb966df25mr7216351fa.16.1750766206695; Tue, 24 Jun 2025
 04:56:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-correct-type-cast-v1-1-06c1cf970727@gmail.com> <aFk8-_TNeV51v2OA@google.com>
In-Reply-To: <aFk8-_TNeV51v2OA@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 24 Jun 2025 04:56:08 -0700
X-Gm-Features: AX0GCFvYFe-WDZ7ND52DmG8rRUjBbsH8xIg-zyKPEWgjGwePyEOsya6C5IxsScA
Message-ID: <CAJ-ks9nsjSOBE8LQtWpC5r98WAekXwzC9yDZxHdsJ=p1BX5ZYw@mail.gmail.com>
Subject: Re: [PATCH] rust: cast to the proper type
To: Alice Ryhl <aliceryhl@google.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 4:39=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Wed, Jun 11, 2025 at 06:28:47AM -0400, Tamir Duberstein wrote:
> > Use the ffi type rather than the resolved underlying type.
> >
> > Fixes: f20fd5449ada ("rust: core abstractions for network PHY drivers")
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> Please use unqualified imports.

OK, I will change this to two patches in v2; the first will change all
ffi references in this file to unqualified, the second will be this
with unqualified references.

>
> >  rust/kernel/net/phy.rs | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> > index 32ea43ece646..905e6534c083 100644
> > --- a/rust/kernel/net/phy.rs
> > +++ b/rust/kernel/net/phy.rs
> > @@ -163,17 +163,17 @@ pub fn set_speed(&mut self, speed: u32) {
> >          let phydev =3D self.0.get();
> >          // SAFETY: The struct invariant ensures that we may access
> >          // this field without additional synchronization.
> > -        unsafe { (*phydev).speed =3D speed as i32 };
> > +        unsafe { (*phydev).speed =3D speed as crate::ffi::c_int };
>
> unsafe { (*phydev).speed =3D speed as c_int };
>
> >      }
> >
> >      /// Sets duplex mode.
> >      pub fn set_duplex(&mut self, mode: DuplexMode) {
> >          let phydev =3D self.0.get();
> >          let v =3D match mode {
> > -            DuplexMode::Full =3D> bindings::DUPLEX_FULL as i32,
> > -            DuplexMode::Half =3D> bindings::DUPLEX_HALF as i32,
> > -            DuplexMode::Unknown =3D> bindings::DUPLEX_UNKNOWN as i32,
> > -        };
> > +            DuplexMode::Full =3D> bindings::DUPLEX_FULL,
> > +            DuplexMode::Half =3D> bindings::DUPLEX_HALF,
> > +            DuplexMode::Unknown =3D> bindings::DUPLEX_UNKNOWN,
> > +        } as crate::ffi::c_int;
>
> I would keep the imports on each line.
>
> let v =3D match mode {
>     DuplexMode::Full =3D> bindings::DUPLEX_FULL as c_int,
>     DuplexMode::Half =3D> bindings::DUPLEX_HALF as c_int,
>     DuplexMode::Unknown =3D> bindings::DUPLEX_UNKNOWN as c_int,
> };

Could you help me understand why that's better?

