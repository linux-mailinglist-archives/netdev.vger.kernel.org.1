Return-Path: <netdev+bounces-68198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB4B8461BA
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 21:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111E9283991
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 20:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C118185626;
	Thu,  1 Feb 2024 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="SdhvkOni"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831738528E
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706817737; cv=none; b=Wqfoc1m+ClP3RakZ1bTrncUvzh9KLSWjlldbpybOv9jx7YPrwuzf9szdz30IvBr4Ph6XHrAFQ493nRy4QwjVBa3CwaQj4/JUnj51VALmXKUlx/FKMtcDrUS87H7IAgZPdOBHSUlWA1tXFwGmh2aShcwShkD71XUKsF7Oa+zoA+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706817737; c=relaxed/simple;
	bh=tvy6mSud+tO0FW2Ix++bq0Yqn3nq8l29ZBq1/shnleU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SGP/c448mGEKWEFHWic+5CgcRU85d9ChvXYU/uEvkNrsVoD9c7UJNk8htK7Nbdu1LjQKL+hNYc6PSASv+5s0sSmRdDc7nOnRZMbKZOs2iWFpekB/rT4ucvLY4n0oyB/1RqEyINgs+SRjuLFphdRtQupxtTHRPYE+ZQoRdr544as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=SdhvkOni; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3be6b977516so913908b6e.2
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 12:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1706817734; x=1707422534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKtKU9ec/rsz7HBSzIU5uqFOSZbUdu+2rlARf46Czpw=;
        b=SdhvkOnie1LRW6jS1+B8/uSuT6goBwPJ5Ysv4a0WhSxROFWET7z6lXc6zDSsNw3lfT
         l4pUCQ13wLkl+D0Rkxcb7xsaI3ncktvMANX2AqlxF6jM/6uRS31Wvn62Pw/u0AXPEU3C
         lUD20nZY+iDBO5RWhY3sLWc1PkOtFQMIaBHGO6wuzhuZL8XK3WwNEvRzKLJPXv4eVnYN
         CH+7SkmGsNySP4rt8hM3f8M14PaRW78PVEpA/s+kEawiyY8uD7kznYhDlQ5IwBSpWWI2
         Uxkac9x/ZCcnpWh3ZwwJyfMhYqJ/Xsmv8hYUFMqecMSIheVkdkBpPUSt1YT8bM2p1NY/
         L6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706817734; x=1707422534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKtKU9ec/rsz7HBSzIU5uqFOSZbUdu+2rlARf46Czpw=;
        b=K5X6byvTj7AnYEFefHEF0yIiaDLPMHi+shb3qUZN3TpM0gH39gokVHSbEO/pV5GI3r
         1+gJuklb/urzjT9PhNiBIFv1+RAlzwlf2zgHgQifaM+YUGoRm+s9QohRuK45Ck00QlPj
         U6uTs6kO85sbuDN2SyoXmJXOfmlYTAV7vXKfKUDgWQor5xsRgxnzA8EcXE0ENWE0pIw7
         KYtsNH06mPucXwbVyyvmaOS8tGMJ+A3n8HcAMu9SU6DdqMZIxh2I+bh0ktgoMPU7AjVv
         xHmFwhFlOBTLoB6Cs4sO7cIFaS2r5cT7D880ozmdJ870o1PRZU8GTqZifyreOMOdOipg
         KxNA==
X-Gm-Message-State: AOJu0YwxCb7Ri0PieUYzB0H2riVpIZNdMX2Eg48VVRt5X/d1oB0GSlET
	pSRTHBNSQpKkwZ0f/y3blioe8X8aaxTtlFnZXaThAGvM+tpjPlWb7gGje3Tz4mo+4YkrFosDvOf
	qTNpwXmfvweCYkCCZimj7+O78lhI/7+COKTnyOg==
X-Google-Smtp-Source: AGHT+IGkopw9KI9BmtHxGeMn+uc0bvHsWIA3VKpCBS/bF9G1Oq6uAmfg6Qe9qX+sxvKiL3uBS6W453i2/9uWDYwy3Dw=
X-Received: by 2002:a05:6808:640e:b0:3be:aafd:cc6 with SMTP id
 fg14-20020a056808640e00b003beaafd0cc6mr3387394oib.17.1706817734567; Thu, 01
 Feb 2024 12:02:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201-rockchip-rust-phy_depend-v2-0-c5fa4faab924@christina-quast.de>
 <20240201-rockchip-rust-phy_depend-v2-2-c5fa4faab924@christina-quast.de>
In-Reply-To: <20240201-rockchip-rust-phy_depend-v2-2-c5fa4faab924@christina-quast.de>
From: Trevor Gross <tmgross@umich.edu>
Date: Thu, 1 Feb 2024 14:02:03 -0600
Message-ID: <CALNs47tWNNi2GXHAwwT=A1LP=xWwXvrPy4xVapqMQOeyeN0+9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rust: phy: add some phy_driver and genphy_ functions
To: Christina Quast <contact@christina-quast.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiko Stuebner <heiko@sntech.de>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 12:07=E2=80=AFPM Christina Quast
<contact@christina-quast.de> wrote:
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index e457b3c7cb2f..373a4d358e9f 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -95,6 +95,22 @@ pub fn phy_id(&self) -> u32 {
>          unsafe { (*phydev).phy_id }
>      }
>
> +    /// Gets the current crossover of the PHY.
> +    pub fn mdix(&self) -> u8 {

Are possible values for mdix always ETH_TP_MDI{,_INVALID,_X,_AUTO}? If
so, this would be better as an enum.

> +        let phydev =3D self.0.get();
> +        // SAFETY: The struct invariant ensures that we may access
> +        // this field without additional synchronization.
> +        unsafe { (*phydev).mdix }
> +    }

> +
>      /// Gets the state of PHY state machine states.
>      pub fn state(&self) -> DeviceState {
>          let phydev =3D self.0.get();
> @@ -300,6 +316,15 @@ pub fn genphy_read_abilities(&mut self) -> Result {
>          // So it's just an FFI call.
>          to_result(unsafe { bindings::genphy_read_abilities(phydev) })
>      }
> +
> +    /// Writes BMCR
> +    pub fn genphy_config_aneg(&mut self) -> Result {

The docs need an update here

> +        let phydev =3D self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type in=
variant of `Self`.
> +        // So it's just an FFI call.
> +        // second param =3D false =3D> autoneg not requested
> +        to_result(unsafe { bindings::__genphy_config_aneg(phydev, false)=
 })

I assume you did this since the non-dunder `genphy_config_aneg` is
inline. I think that is ok since the implementation is so minimal, but
you could also add a binding helper and call that (rust/helpers.c).

> +    }
>  }
>
>  /// Defines certain other features this PHY supports (like interrupts).
> @@ -583,6 +608,12 @@ fn soft_reset(_dev: &mut Device) -> Result {
>          Err(code::ENOTSUPP)
>      }
>
> +    /// Called to initialize the PHY,
> +    /// including after a reset

Docs wrapping

> +    fn config_init(_dev: &mut Device) -> Result {
> +        Err(code::ENOTSUPP)
> +    }

These have been changed to raise a build error rather than ENOTSUPP in
recent , see [1]. That patch is in net-next so you should see it next
time you rebase.

Also - these functions are meant for the vtable and don't do anything
if they are not wired up. See the create_phy_driver function, you will
need to add the field.

>      /// Probes the hardware to determine what abilities it has.
>      fn get_features(_dev: &mut Device) -> Result {
>          Err(code::ENOTSUPP)
>
> --
> 2.43.0
>

[1]: https://lore.kernel.org/rust-for-linux/20240125014502.3527275-2-fujita=
.tomonori@gmail.com/

