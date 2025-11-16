Return-Path: <netdev+bounces-238997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F180C61EC5
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 00:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F103B52DE
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 23:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA892459DC;
	Sun, 16 Nov 2025 23:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUWoJVO0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FDF219A8A
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 23:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763334573; cv=none; b=RYXiGDEjidArOXwV2XptalZUKtG/HkSwQjOhi/W/dh4nE/FFyTf+Rh4plx7SXfjbeashQ//dpH8AioAhWYjze63zNP/9Oi0BaIiTFQjB8OaPHAzno+r5BHU5om4jEK0GfoAlMd44pXaN3xQwTJ19mR6NO4dLk9RprpymN2w8pVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763334573; c=relaxed/simple;
	bh=8L19nC4j5OvDmSIEYO56ledximukYDfE3QcjgrcWoQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVxBOkZG6kqw4tf9KkdHiTZ8Bc8CtJZsxj5zOjZ3v7f/h0+4QzRyxoqH/B70tnWGrR8q64O6yjan/PW4Yc972CMAoomRs8Ek/wbInwlTFct0yROqXjWtIhUQdwmJJtQPtwfw71Zjfl3RTHmzqCWhgBCDhAcXm1l30bjAP/JQguY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUWoJVO0; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b63e5da0fdeso327441a12.0
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 15:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763334571; x=1763939371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpJufKQWhLvX936aimvnWD0Vs3rgof89qVToz11DHRc=;
        b=gUWoJVO0Q/YsaDlFQiv4+g2NQ8+Jvfojui2eJM1+a+ldg0br053QLHnzbtinGW2yCl
         og3HNgsfkj+DJEv5RO0NZzcLvz9WcJijVtZqoDv7ylphghjRSwH2b5mGEc/tHuNUsAzD
         XIHUL3coAECOFVJ5nSjp8YHMo7De4ugZFEbSmqnoNAumWoGd9myAqm4rfG2BioGcKbvS
         oIOPwmAeF++wFK0vS0RwjS2BU6EOWMFKNxpwf2uG9BdetBvsuK/jksDFJdBcx8iyVt2r
         XKcqzm42GxU18kq9Gru662F7Rw3F4ZYz62qSYIGTGPo50PlIOQx/NXddEXNNaE0hAFiB
         y8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763334571; x=1763939371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HpJufKQWhLvX936aimvnWD0Vs3rgof89qVToz11DHRc=;
        b=ascSa9d58aqWniJQtzGhEB+ZEh9/sY8BpUS4qKO1wUBWutitdWx963GKADvF//+TSJ
         kvu51lDb5mSkiQALBYv+GozuOHhUu2koSQdqxXLwwI0mJI0zwA42T/rZYBxQIy/tlhO0
         jWQvBlroMm8OMUzjGv58AsPdFJpK/Jgj9a5FERsEUI6Q8d1Z6ywGD1jeku3Q/HF2GZPC
         toGKfEutwKwcHWVM8R6wMJBaWJc3hm07qGNM4rXMuqkwgp5lJA3w3RLBvCFZYOZh2OEL
         N17RNTRHnd3J0QHdW9wC/wI6Q3OLykQaUxkW2AOMLBYYhAAyQjutaD+qkVIH/h1lUA/i
         U5lA==
X-Forwarded-Encrypted: i=1; AJvYcCWV0ovV8j5N77Uv5R4/t7J8oJ3tOh6BrbZJvL+9rooFid8qx6wYGtBwNMYPu9XpJYBSzNeoYVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOlfkLmgjjjr5AEmxD+dRQMnqP1Kg7AZEMpZTb0oj8Fyld7aYY
	k7ogHwQLN9ViWKt4ZuPkVI8gucgDa2MQJEeTgx5AOJ3mFvHY50AaFJCWY3LASreO8f53XqKyL2U
	fcLjtJLrxpbJ1YCAB5KwY3Sk04eV2Nb8=
X-Gm-Gg: ASbGnctCIXe+wudfXMzVTHZIUc3AhMFg0KYdojBdF6a8LJyno6+Xs9PGpGOJsyRfqEH
	+CDcBSQimFkqM27io33hKnr9eHcP1okluSivvxDPeelzewEuY8MvHe5SO/jsX2aKwltAVIJb9gs
	oowLhXy15MaNSoi3+IFp6AtVjRKflkbDLzgyWoIihAQMsT8SJCJC5mMLBqmdho6PztsxhpiqjVT
	nt/RojGVQ2taw6jvJ8acrl0bd44a/Z2PzWXoGSciYX/ZiTGaOxpApX3O96bORQ/e1AfbsLKWJlz
	IjtlWL+WfB3uArygzMb1TCxr+ttxcb/ZgQxz/6VDoYbkmHdU2gW7yiL1ckltM1bACR+75kVj2M4
	YRcrEINWiQa6aMw==
X-Google-Smtp-Source: AGHT+IH70UQ325wYVXkclC/7sKQgcKkGkeILQCo0Z7/+Sn1+4zhN3sg5WPzWxUEu+sbOfLyp678rfQ6h7RHY/mXLYpc=
X-Received: by 2002:a05:7022:e0d:b0:119:e55a:95a1 with SMTP id
 a92af1059eb24-11b493dbc02mr3494096c88.3.1763334571481; Sun, 16 Nov 2025
 15:09:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-core-cstr-cstrings-v3-0-411b34002774@gmail.com> <20251113-core-cstr-cstrings-v3-4-411b34002774@gmail.com>
In-Reply-To: <20251113-core-cstr-cstrings-v3-4-411b34002774@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 17 Nov 2025 00:09:18 +0100
X-Gm-Features: AWmQ_bnE2iEbMtFxFYydJhY-FPvC2L9BY1C0PQs1FD5DIKtlL5Y3Tpw0Rk2k8A8
Message-ID: <CANiq72mBfKwXEbyaw=pBAw37d7gCLVJqHcLcd6H7vNKey1UXfA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] rust: sync: replace `kernel::c_str!` with C-Strings
To: Tamir Duberstein <tamird@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, 
	Tamir Duberstein <tamird@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 11:58=E2=80=AFPM Tamir Duberstein <tamird@kernel.or=
g> wrote:
>
> @@ -119,6 +118,6 @@ macro_rules! optional_name {
>          $crate::c_str!(::core::concat!(::core::file!(), ":", ::core::lin=
e!()))
>      };
>      ($name:literal) =3D> {
> -        $crate::c_str!($name)
> +        $name
>      };
>  }

This requires the next commit plus it needs callers of `new_spinlock!`
in Binder to be fixed at the same time.

Cheers,
Miguel

