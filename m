Return-Path: <netdev+bounces-200253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4768AE3E1F
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 13:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF353ADC82
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 11:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E4824293F;
	Mon, 23 Jun 2025 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="akXXosn5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0F22253FE
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750678786; cv=none; b=iiOaP2nWYetlK6oAiYAee8RpG+8fsRXoqyXNvMzB8kxNnwEjSgWB0RSEfQoHJbaXybWod/IIZ3USMBCCR1KocWql6DFTFd019m6a9HLd4Gry8WJiCCVeKWIrwmOUqlrMscSk/dEsmo4sC4XXSj/bC425z9u6A63HGk9vazJ4XC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750678786; c=relaxed/simple;
	bh=WLxkC7V19D77AzPdWZubB6l8aqMizd+u3nLpk+F8nkc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kVkw2aQaeBNDl48cp4/fjVAeBkimqlVwu1ZuA1zBvmRRUPtVP/Ki6T1P50Yd1EM8bmRm3ln5mk9m+70MrWzr6ajOwIeaWB3vJ1fioBpxQWvA586gvb/tDduoDFxa05/VdKiKK1x/daYCphcpLUbxqNn4cgjRINyvkZFxpCEn/QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=akXXosn5; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so1735543f8f.2
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 04:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750678782; x=1751283582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jBTUKpx0ZNKYHazA3t/A7/vG1k1Wn2pxBHruJSDnkA0=;
        b=akXXosn5JeWGX1uWfbF59wVWWkNdaoc1dSFu/HSATKRwPT3yXzan4jljbJ2Y0Mvb37
         6sTUBwjBHxW6wqt7KUz/4XazOtA65+N1879Mv4Nh/WEssXji0XvGKnJ8/GwadjwBO1HX
         onzTNLlqM4mRKeye2bT1e3shC5jCWOMRD0oLdWUKnpAjpX60AfL6ILNxGwBEyeMSQgKs
         MhBNK6cKpx/8UdJZW/K/1n5Q/FrfsDUVqBQlAoy0vaBRNj1nDva36/NgN+zkpBLDRU0G
         WuR43EPf60KBN0fZFISoauCF/EKLrbuIoQ3rzzTmAwNKBQRn1JOGihifeTLeH1LwGEPt
         SMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750678782; x=1751283582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jBTUKpx0ZNKYHazA3t/A7/vG1k1Wn2pxBHruJSDnkA0=;
        b=aIC3kNgqPa5mARM2Ilvg1Tdsat0je5O7yJTWnIl8IbBGl0PF5tWJ70DIUubM5Ss5YG
         3OfonMBAZMQXKqzyAioUggsg2FPXmQQ7dXYNs1v3cNRGJOso4F+JcnoPmMpbzHvOPdkJ
         SLYHhWuYqwyzOMIc8uJnUJp0j2piUlLkFIRONaUWsOxVQCDmMChlpGxVRBks9kfV4Toc
         OrYjCEtB7sTXPij6aZ9udhUfZPqOO6Seo+dUtfrE8TpXeUOFKlK4MHc6LNJWt8AIuSjp
         RYmw8Neziefw1Pd/IR7qMrEvaSv9QIXs14MaQAgC7eY7c0FDVlbRKlZ6QGOHE2u2r6Fh
         Kleg==
X-Forwarded-Encrypted: i=1; AJvYcCXn+BRL+aWiIudiZCehhtujKANdcaot1jqc5tZTE7KYUdPfSt/0bz6b8b6xnWr9S1EiZQru/JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFhCTd3DOiw8W1q34zLstViNnyOA4r2Qlt9Hm34FKuPVktcr1e
	dtEnasvH/k4TcfLj1HuW67/9vhX1P7n2esweBH/TKS8A+Dnwrx0s2vaAF9BrdWJIUNtA0596Ybr
	/9IPRw5vk8kCoMCo1Hg==
X-Google-Smtp-Source: AGHT+IHOfkmOn/iFDpfwri/R3bnIweVDsVpN6vKnfwZl34PHvpa36cU93NoZdwYN5nFotAGyPMw/l9yziseyIAA=
X-Received: from wmbji4.prod.google.com ([2002:a05:600c:a344:b0:451:4d6b:5b7e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1ac8:b0:3a4:ee40:715c with SMTP id ffacd0b85a97d-3a6d130168fmr11662811f8f.14.1750678782136;
 Mon, 23 Jun 2025 04:39:42 -0700 (PDT)
Date: Mon, 23 Jun 2025 11:39:39 +0000
In-Reply-To: <20250611-correct-type-cast-v1-1-06c1cf970727@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611-correct-type-cast-v1-1-06c1cf970727@gmail.com>
Message-ID: <aFk8-_TNeV51v2OA@google.com>
Subject: Re: [PATCH] rust: cast to the proper type
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Jun 11, 2025 at 06:28:47AM -0400, Tamir Duberstein wrote:
> Use the ffi type rather than the resolved underlying type.
> 
> Fixes: f20fd5449ada ("rust: core abstractions for network PHY drivers")
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Please use unqualified imports.

>  rust/kernel/net/phy.rs | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index 32ea43ece646..905e6534c083 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -163,17 +163,17 @@ pub fn set_speed(&mut self, speed: u32) {
>          let phydev = self.0.get();
>          // SAFETY: The struct invariant ensures that we may access
>          // this field without additional synchronization.
> -        unsafe { (*phydev).speed = speed as i32 };
> +        unsafe { (*phydev).speed = speed as crate::ffi::c_int };

unsafe { (*phydev).speed = speed as c_int };

>      }
>  
>      /// Sets duplex mode.
>      pub fn set_duplex(&mut self, mode: DuplexMode) {
>          let phydev = self.0.get();
>          let v = match mode {
> -            DuplexMode::Full => bindings::DUPLEX_FULL as i32,
> -            DuplexMode::Half => bindings::DUPLEX_HALF as i32,
> -            DuplexMode::Unknown => bindings::DUPLEX_UNKNOWN as i32,
> -        };
> +            DuplexMode::Full => bindings::DUPLEX_FULL,
> +            DuplexMode::Half => bindings::DUPLEX_HALF,
> +            DuplexMode::Unknown => bindings::DUPLEX_UNKNOWN,
> +        } as crate::ffi::c_int;

I would keep the imports on each line.

let v = match mode {
    DuplexMode::Full => bindings::DUPLEX_FULL as c_int,
    DuplexMode::Half => bindings::DUPLEX_HALF as c_int,
    DuplexMode::Unknown => bindings::DUPLEX_UNKNOWN as c_int,
};

Alice

>          // SAFETY: The struct invariant ensures that we may access
>          // this field without additional synchronization.
>          unsafe { (*phydev).duplex = v };
> 
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> change-id: 20250611-correct-type-cast-1de8876ddfc1
> 
> Best regards,
> --  
> Tamir Duberstein <tamird@gmail.com>
> 

