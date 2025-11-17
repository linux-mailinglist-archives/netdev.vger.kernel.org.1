Return-Path: <netdev+bounces-239161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E49E1C64B71
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 15:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8325C4E8B07
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 14:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E0033556F;
	Mon, 17 Nov 2025 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2JU3Zkuj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6384E334C01
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763390973; cv=none; b=Xt3uX6GLEEU1nMqFsQPJbH5fBI2/D646YfeSAYKeqFkaV6TgrI3n52Sz1AIvGIkk72wp35GmvnQQbJ79Lgistu3fNsAlS7K7BBUrxDEZm6ec8zTLcI2ehlfcpyra5eB5G9V326T5niA/8c6eDHiLOaWWoQmURU3wrpFXpaLoTuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763390973; c=relaxed/simple;
	bh=WW4x1JtHJo1lgO8ectKyoMM+RyxVl9yZ6KIMMuM1jpk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XdVbwIkgP2XHRIObp03sZVuFmUD3+z58SLvryYf/HFeCHCBHTFc6+253tJGNa/TaWZ3pf1OsiLiIKFu0ottUX0gHiLaXoaizQRo0hTl7bMxWKyqLVkc6SLCogshP4t/GFprf2E3TWicKHte1nDe8D67q5VqbfE/IiaH6Yb3QJg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2JU3Zkuj; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47106a388cfso28417075e9.0
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 06:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763390970; x=1763995770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJT6gufnoNQkAg8VpeeSoHr9N3KPlTAXTRkK2kDfIcg=;
        b=2JU3ZkujQtp7VM1B6xeQrWXBO5TB3YN5mQiKDnHmRuvQFpZ+cgTmuI4EwDxjaL6PHn
         A0Ay1UkDMcREl64r2/lIy0wN+TfuSfXUv+KeBv1uJAVO3MjmyjXVd3YbFfqZDdCqLdRN
         JZ7hz3gCoqcDB85D5UAwRn0OL1PjvA6Bujq4h2KZejkljSAZluZnXbCgXw4a1+ruZ3GA
         voyhNuGu2CZFJmip2fS7Pue+ZwldAHpevdSYELxin/vHCinjS3AKwE5ziWEWYpxKC4bq
         8juVRnO+x4vMmxU/apLXQ4OTBWz26xVqBSNyNgCx2qobXfdxTW4edjRE94RbsO1vRqzN
         SUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763390970; x=1763995770;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HJT6gufnoNQkAg8VpeeSoHr9N3KPlTAXTRkK2kDfIcg=;
        b=RB+m3cLUXAUutn/Ow91+DkE6BYBN2pG4HxXLCzKDSBmhHpacGH9ozuKfksq5XXCsQ0
         8REnbo58WssyEykq8ruset3F2GHNygsLGdioUIOj/EaLSsWCW6xbhGt31gInWj5+e1kG
         B/9RSAX36BRgkMZyuy/jGEr6PxXwBXcurAp/UuVaCV87sn7Wr7jlw6JgQTgiyLVIc3hD
         v80UKo+3aV96+MoEXmuMZ2FWTTGXQFkDfNyvvEEmMMnozsHupg1kSLOGv3jkIvGlAZG/
         889SnZq1UmQ7+A3/f1REyphfdsfz4PuREArdYIa2w+MD6WjeJ0ZfDRBS7NWvkZxDgeMS
         Wibw==
X-Forwarded-Encrypted: i=1; AJvYcCXyI7a4HDHuJ5YK0NowGqp5BfbymG/RuKUXh2Uy/CG8EIDdF2eKrC6az6DSyK63RuFueAO/MfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEZWFA7tposHk+ciamfTciT3V1Ap2pCQ4FgEQIqQt9jviqwuP2
	X/WM7/mxDL2WOkBW0IQy4u670MDhxAxaIjAe8ySNPeUSlDSzvxewTXjJbXGv9YJ+d6+vCFaKtoo
	WmIh6XGvQYXFL4UejBw==
X-Google-Smtp-Source: AGHT+IHMENTXXYlxXLfwcYy8RcVFiUBg7t9OZFby+7TKyA3x8awUKOzv1yWPmfR5rSilH8vJnzWv/VNZTQODmKU=
X-Received: from wraj7.prod.google.com ([2002:a5d:4527:0:b0:42b:2aa2:e459])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:178c:b0:42b:3b8a:3090 with SMTP id ffacd0b85a97d-42b59367af2mr11730970f8f.23.1763390969752;
 Mon, 17 Nov 2025 06:49:29 -0800 (PST)
Date: Mon, 17 Nov 2025 14:49:28 +0000
In-Reply-To: <CANiq72nQhR2iToP8ZauwAjM2p1OWEK1G5cjsEXqs=91s7jOxMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113-core-cstr-cstrings-v3-0-411b34002774@gmail.com>
 <20251113-core-cstr-cstrings-v3-4-411b34002774@gmail.com> <CANiq72mBfKwXEbyaw=pBAw37d7gCLVJqHcLcd6H7vNKey1UXfA@mail.gmail.com>
 <CANiq72nQhR2iToP8ZauwAjM2p1OWEK1G5cjsEXqs=91s7jOxMQ@mail.gmail.com>
Message-ID: <aRs1-KshwnBjIIuQ@google.com>
Subject: Re: [PATCH v3 4/6] rust: sync: replace `kernel::c_str!` with C-Strings
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Tamir Duberstein <tamird@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, 
	Tamir Duberstein <tamird@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 12:52:22AM +0100, Miguel Ojeda wrote:
> On Mon, Nov 17, 2025 at 12:09=E2=80=AFAM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > This requires the next commit plus it needs callers of `new_spinlock!`
> > in Binder to be fixed at the same time.
>=20
> Actually, do we even want callers to have to specify `c`?
>=20
> For instance, in the `module!` macro we originally had `b`, and
> removed it for simplicity of callers:
>=20
>     b13c9880f909 ("rust: macros: take string literals in `module!`")

Yeah I think ideally the new_spinlock! macro invokes c_str! on the
provided string literal to avoid users of the macro from needing the
c prefix.

Alice

