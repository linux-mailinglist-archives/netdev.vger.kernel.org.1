Return-Path: <netdev+bounces-196557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFB6AD5444
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6060A3A6F74
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802DC26B2D5;
	Wed, 11 Jun 2025 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1+fRgEjw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D873D21FF2B
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 11:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749642147; cv=none; b=usjMBv3tMgxJGyAIN+5I8f3YnT3vF6B8mOX+be9J3eHLaIu6qtKYLN4xRQsn7mEUtoEINdmbx0NbV+bPgNLq60Qzr+Y64hKhQ3JSs+8G6+7jO0CgW0IaZ0XgPyYIHplKLDuW11WTSLSAvvQVK5Ix1TlnJkNlX2TOwZyqq0mouVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749642147; c=relaxed/simple;
	bh=FUStS5c3S65wbp+fBe9+etII96TDwKJ+V/CIWybxzdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wo+Ywh18kp7GE738tQzihseqexou9vWGF9qlcwaomsXnqDc6TOL8IVC53ZsArZTFEBdMf6NP1BbBLyLfl2LfpAgWSXVnHr3YE0CmvQnvRzBz2a/GPggeEZp+O1J5RJcCqrIhijNdEwAR2IEXNLq60c9opHfMk9dTzqQJ8dDTtK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1+fRgEjw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-442e9c00bf4so54583065e9.3
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 04:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749642144; x=1750246944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkdBvM+Fb7Q1QR2EpzlOjG7jKFxnJ+dE1eIZu+8hsIw=;
        b=1+fRgEjwIu7wrploo/zU+xvh34Uq7pvkznfXdYPXCfhXc3ff9/X04wBCJUdLzkLpcE
         8ihcOwT/3+esM8Hm2DJxmZ0qP31oa7+tFQXBkL8Lrz4THM+7kqvlYMPrZxWxQJbaEuYI
         Esy6zjEojcPhug82yoXXeDYuSRH75YKvc70g+Yy3BMFpx7eNGbSwaiz2/4vVKZuNbWHT
         mZFsseLaIH5ek5++wZsLTCNrYeeJhH7eRfDdu60LkMitCzyTKCCez3zEECi1AtebecBp
         mN6AwC++JbZBztiNOp73RGje1MySwRusyzXfxgefOv8pJmUF6+piaBkN+9E8EYEQd2Q2
         F7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749642144; x=1750246944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkdBvM+Fb7Q1QR2EpzlOjG7jKFxnJ+dE1eIZu+8hsIw=;
        b=fkY/417g/9dCFpCJe5DDOSsYwtRwg6JjkOl8JWe1F62pnXqt7s85j0wjtvDnIMuUr5
         6VwODCQW8588pWfbc8wV3CtRtaIE8YCRirABy5KKrENgwxY+IRVPhnpFT1R2Tb/xynRE
         NnSv42H0i51NRYL8L9yByEoq7p15VAN3qPeY+xF+p3t56o9gkFus5DQW3Eg8W/WKemjY
         ySSgQyiAIfHnP+Tv5x9Sf1nFAMuW9SO6MJLRhrsadYgg0/+rqg51bu+HPa5UHPlFBTB/
         Vx0eJldCtmxmjIc8qa4DSDZCX5rxRJ/vPQNq/HG3J8uML/YFkvKtyRmASwn+aQV7u2y9
         qmzA==
X-Forwarded-Encrypted: i=1; AJvYcCVp3B7+gyzU2lgKqIyyS7dIls8Y4ePFJ22r/kuwW/JRA+c6m3g5khKMEU2km8wkjwi+510mrrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5UvSAg8mJyyZXtZib/XStNUjRIrhQ9b0x2LjxLxnlhl37bqEt
	aGKLzOL7zVqvlKT24FAOmPAL5JoOsGYFn9PgqjMhA8XAg0AMjxS65vFEbfGVZCOEWSgjM7HW11z
	B7K89XDtto/BAlzcpYOUOEyOwVlZmiXzT9k5zsc1i
X-Gm-Gg: ASbGncvm8v5AU22coVq8iH/0WhI6CXtdvyE6C80bm45Mr+7Z6+IDJ3hWgFhTNIS2oYl
	7LXa0l4i5WeZe2zSwZ0/VnJYU9N7m4ksLfxEVyx0fZRD/TZqObADOqtjJ5cWYPEKEOfP5u53z/a
	2FCnAri6wkUTF9Ka5fsO2NNQLbGAyeSXxiyqMV9dUBP1q2u/KON3mhUY7+JeHnn1axdJERGKLaB
	Q==
X-Google-Smtp-Source: AGHT+IHWnc6SnzYf5mCJ2L3k+/PpxAJt0+Ab4vhOBcR5j5AmdvMvBATf9J2AGm9g8sffFijJPWPxsb9hnwgMMAouVKw=
X-Received: by 2002:a5d:64c3:0:b0:3a5:3b15:ef52 with SMTP id
 ffacd0b85a97d-3a558a9248emr2046677f8f.8.1749642144124; Wed, 11 Jun 2025
 04:42:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-correct-type-cast-v1-1-06c1cf970727@gmail.com>
In-Reply-To: <20250611-correct-type-cast-v1-1-06c1cf970727@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 11 Jun 2025 13:42:10 +0200
X-Gm-Features: AX0GCFtbudxgpt1gl3GgxMZalwn9053z-4e3UEi2jcJlC65c2iByUhUylvF5NLo
Message-ID: <CAH5fLghomO3znaj14ZSR9FeJSTAtJhLjR=fNdmSQ0MJdO+NfjQ@mail.gmail.com>
Subject: Re: [PATCH] rust: cast to the proper type
To: Tamir Duberstein <tamird@gmail.com>
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

On Wed, Jun 11, 2025 at 12:28=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> Use the ffi type rather than the resolved underlying type.
>
> Fixes: f20fd5449ada ("rust: core abstractions for network PHY drivers")

Does this need to be backported? If not, I wouldn't include a Fixes tag.

> +            DuplexMode::Full =3D> bindings::DUPLEX_FULL,
> +            DuplexMode::Half =3D> bindings::DUPLEX_HALF,
> +            DuplexMode::Unknown =3D> bindings::DUPLEX_UNKNOWN,
> +        } as crate::ffi::c_int;

This file imports the prelude, so this can just be c_int without the
crate::ffI:: path.

Alice

