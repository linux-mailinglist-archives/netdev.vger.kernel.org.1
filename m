Return-Path: <netdev+bounces-119585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D36956483
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B298D282E29
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5F415ADB3;
	Mon, 19 Aug 2024 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="iaODfeWq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2280A1586F6
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 07:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724052077; cv=none; b=FpzhEJ+SyTxSKtlfFSYdAOYcmrL232Sf2i8Kt1n1ZQlK2lW3b2wfsLrUHjdBQdmebc6tfu1liIRvnYZunoFBI7YYv5vPnNwki5KNrpb+BhRyJzvJQbXo/oEMO6eaEmEIWR4dMFZnRk+XQ1intHaEvb1+R1anQz19lDZ6TKBb0Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724052077; c=relaxed/simple;
	bh=+4yVrBXqRyZn+p0Lfs6mh5yjgyKNLQndI4t3znQWL80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxSpr201YxE+4zeJxD6nj2GTPZxWJnTkJS4YX0qWRS9n2H5optLhZgbfgZehg9KINVfu/5XvJMFUjX5jJqmSiWy4QjNzGEs/vJww7VYrCNe5xSoOd0CHjF57PnbFXgrlit4rxD/vpveS/oeQNGPGAiChmCSwNGeqj2lDnD5o6rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=iaODfeWq; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e1171e57a0dso2603103276.0
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 00:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1724052074; x=1724656874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cH6fxmDB43HdtvDVAfM22RpRfY3QBW48IQCvIoSlAv0=;
        b=iaODfeWqULUHVxurNVapH2rAimrAzTZhxUsR8pCACXnQ4t5UxP7RIve0blFyv0FwHO
         vbgEGPaTnlTrjC8YdWbBrecukx4VZtmZjusQ+Nj5sqKRdME7w03SSijDMeqdv87UfQIa
         s/9u3zqDmoUy3LrKMasbmUeqIvb+FLnkQcQlo7eJkVR1cS0f9R9RLaqvnGNzCwNB/gZ3
         SyNodjs6e6G0SEXfmnOlgOJylbkHJnitF8ftnpbwfCSZ/ofeMT2xX4phMS11ivESqjCo
         tLGPmHO/uv+P3oynzJRHvzb89yX8EO4BJGVZWzuAodufMPHl8LVJ0/Seu/9VqZ6Xfzda
         gwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724052074; x=1724656874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cH6fxmDB43HdtvDVAfM22RpRfY3QBW48IQCvIoSlAv0=;
        b=rz7MSCwOaDMRJqFonsL6I/hulzhCN85QySxZayCjckCh9uRX6r+m4IIYg24LUYp0JO
         kcmjXIn5Y3qhl60wbW8MJjZ+QL1Fvcux/ZFzBvn+V34yrj0exqZwmzDlpEQxLHwpBTtI
         SLn2vlYeEsT9VZ4cAZUKrMDD3j3OG9ZzgOxaNLM/6X8Q67F0agXqyooGlIkBHd3kZ/cE
         AdOGZXiM8es9yFpytdivUZOzmdho9CTYDfxHMt94zYf/hZ2DPep2j7ORAl8POEVHHvcF
         Q4L9wGl30vYJQwZx4gIeAjxtTvMWqnZi4viEzKIwrV+C9ouF4mTkmW+nR/aIwHWfjjLj
         tPEQ==
X-Gm-Message-State: AOJu0YzpiOOUXek1NAVaBWwUqaemGcOjJQ2ND3ce50JQL+tiXyW2rPwt
	lrQuFWbwimxmHq9OmpB/yFWBOKodFqpIH9+hIHL4oIawPEUpHJH1hyWYUFl0yx4BeWcR9Fb4Cyt
	1g+sfIfwysdx5TtEypNfXkGdHAicCEwJxwSWTuA==
X-Google-Smtp-Source: AGHT+IHZ7u4Hnv/z1U3bjN/RD/UUN3yN0Qf5+xjS5QHUahme4ZkL0mZBuJwVfFgFy97j33e7AovzfL5Je482F4mvZIM=
X-Received: by 2002:a05:690c:6f8a:b0:65c:8dfb:fa04 with SMTP id
 00721157ae682-6b1efc1a0c2mr79707337b3.14.1724052074205; Mon, 19 Aug 2024
 00:21:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819005345.84255-1-fujita.tomonori@gmail.com> <20240819005345.84255-4-fujita.tomonori@gmail.com>
In-Reply-To: <20240819005345.84255-4-fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Mon, 19 Aug 2024 02:21:03 -0500
Message-ID: <CALNs47s6oscYosRT-xgdTtC_4SG7W2iwEzrB+7w0Bc=P4G6tPw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/6] rust: net::phy implement
 AsRef<kernel::device::Device> trait
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me, aliceryhl@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 8:00=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Implement AsRef<kernel::device::Device> trait for Device. A PHY driver
> needs a reference to device::Device to call the firmware API.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/net/phy.rs | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index 5e8137a1972f..ec337cbd391b 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs

> @@ -76,9 +76,11 @@ impl Device {
>      ///
>      /// # Safety
>      ///
> -    /// For the duration of 'a, the pointer must point at a valid `phy_d=
evice`,
> -    /// and the caller must be in a context where all methods defined on=
 this struct
> -    /// are safe to call.
> +    /// For the duration of 'a,

Nit, backticks around `'a`

> +    /// - the pointer must point at a valid `phy_device`, and the caller
> +    ///   must be in a context where all methods defined on this struct
> +    ///   are safe to call.
> +    /// - `(*ptr).mdio.dev` must be a valid.
>      unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Se=
lf {
>          // CAST: `Self` is a `repr(transparent)` wrapper around `binding=
s::phy_device`.
>          let ptr =3D ptr.cast::<Self>();

Reviewed-by: Trevor Gross <tmgross@umich.edu>

