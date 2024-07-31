Return-Path: <netdev+bounces-114433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C15FF94294E
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 10:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7891C1F24CDD
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 08:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858FB1A8BEB;
	Wed, 31 Jul 2024 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0mkEreAa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BAA1A8C0B
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722415107; cv=none; b=LSwZUy3tLdLMmOYpjqoAp6oPjA622md86AR6JTvJtkmuZnGsleaqWIUB6i8dV8BBV+FI1Crwq9J2TWOXH2mb3Mq442GpSk+rb1H5wvT91xre6tHeoAcgTjNg3ew/rywDRe3epyrVV7XHDArKwEhJt7plRvyF2cdbJcgmf4gSI/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722415107; c=relaxed/simple;
	bh=KrkpRLGXwMPeTnO1cuoTX0YZtM8hhHfKx6+M/35Ial4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FwKaRhaLsGxJ3ZGGndqa77ISuRo78BwVc08z9ReAM/VZMfjKa6Rh/7KX44jdUl5Vqcl0r7t2EV/BHjVJhrr4VRsbD66ZB6vx605d+32dmdXqB6ZNSjlLAJTSMHjEXbKNUmIdptEzNwC6IHFLH8U9E0OzlIJGcEeYTpkVppEVdJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0mkEreAa; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-36858357bb7so2669221f8f.2
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 01:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722415104; x=1723019904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUr6yy+lOaLgq535LzHGwe4Ax/hcPJ1PxEP3Uha7baM=;
        b=0mkEreAaIEFHgYP0RXe47woAqT3gB3P2J5j0sUGw0Wt2YhrwWH8ksfIb1bqWGiKL7A
         dmBTEX13rGS8wfVCK+fe+3F15p1UJIra3ZWlx09efJtpqlzwJ03n9HaxrKqAZdXRxWsi
         TsPe1dACwIG9gzdzTAmTGF97QLNjTtxSF2MlT+eBW/8AfDsemOZ37IBlXUNWqB6tbpH3
         /R+TEmTjK7FiEZ69HuY99/mDIek0kqXba5VFdtuxUjXLhJtm+F5z9B7NDdpTgys5maDY
         sxDQ0yBe5DMkbGioeXXEj0yzuyeDEh9ZmOq8HryBCeQBhLEzo9O1hU6dvvN4G0R7Mso1
         lgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722415104; x=1723019904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUr6yy+lOaLgq535LzHGwe4Ax/hcPJ1PxEP3Uha7baM=;
        b=NRB0otZ1GWvhyDj/4+5VBFC5quHThTcDgCUIL4w3aZK4nDa9I3ZlM9JbHHLOCYdhUy
         X6KyDc3b0g//T+tHEkjtwvSBXtOAMp/sxMnPyfGHHiTBBNMfOsb5vch3EfvFKggEOMLr
         34Ai2msnxM7kLgHqxCYKZelY0PC+ZI+YBO6mVT91NtEr1YelE49xxoMeZOuEgKayemcF
         b/FpYcB2473reD3w8oC2TcSMEhR3MHRNxFLEF1+MJYjq0z1rp6LSJ19Y08yvIB9uWN/6
         aUG/lWqzzf+QQBWYpWBTk9lvkCXXXCbR0FewtJqV0Dr71X9L4DqtOeVGgUnJnxCRvE1M
         fLKA==
X-Gm-Message-State: AOJu0YyH92dvcVfzdlTJKvlubiYYWkOJB/qv5HRAn+svUGxakt+EX4hP
	Q7B4XXtm42CFt3q3QB2dvjXuf2cO44Y577WsRgp6PND5h+akbqBxYdyWWmkgBMT1+sa4AoKUeHR
	3fUJlJ3E5mWRUqQabQHIYoRa0NZcXfC8N78CI
X-Google-Smtp-Source: AGHT+IFdKritOWJtOHZT8CahFthL/8Ped33LgmAWGrwbVmaPgY4BVDnzGXk/rxwUjPs4MMHbLSRnzC1M4JVS1hi9WA0=
X-Received: by 2002:adf:fc8f:0:b0:368:3ef6:f049 with SMTP id
 ffacd0b85a97d-36b5cee2e36mr7709805f8f.2.1722415103716; Wed, 31 Jul 2024
 01:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731042136.201327-1-fujita.tomonori@gmail.com> <20240731042136.201327-4-fujita.tomonori@gmail.com>
In-Reply-To: <20240731042136.201327-4-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 31 Jul 2024 10:38:11 +0200
Message-ID: <CAH5fLggMWrDU2U81e4Cs5dV82VFdWC8+02sR8RTZisQGnFgNow@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/6] rust: net::phy implement
 AsRef<kernel::device::Device> trait
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 6:22=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Implement AsRef<kernel::device::Device> trait for Device. A PHY driver
> needs a reference to device::Device to call the firmware API.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/net/phy.rs | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index 99a142348a34..561f0e357f31 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -302,6 +302,15 @@ pub fn genphy_read_abilities(&mut self) -> Result {
>      }
>  }
>
> +impl AsRef<kernel::device::Device> for Device {
> +    fn as_ref(&self) -> &kernel::device::Device {
> +        let phydev =3D self.0.get();
> +        // SAFETY: The struct invariant ensures that we may access
> +        // this field without additional synchronization.
> +        unsafe { kernel::device::Device::as_ref(&mut (*phydev).mdio.dev)=
 }

This is a case where I would recommend use of the `addr_of_mut!`
macro. The type of the mutable reference will be `&mut
bindings::device` without a `Opaque` wrapper around the referent, and
the lack of `Opaque` raises questions about uniqueness guarantees.
Using `addr_of_mut!` sidesteps those questions.

With `addr_of_mut!` and no intermediate mutable reference you may add:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice

