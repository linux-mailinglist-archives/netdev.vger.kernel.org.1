Return-Path: <netdev+bounces-136080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7130F9A0418
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 10:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31281281000
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 08:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250B51C2DAE;
	Wed, 16 Oct 2024 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gA6Io4dD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8DA1B21AE
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066941; cv=none; b=XjJoY8CYJDwedNZLBwu1OvVX5omAR4SE1fR9XaHPUiO/KLWKvcP7Bo3WmWYh/2l1vz/2Re/pDcV3jxJE7ZAfXBazB7z3XhyqnFGyvxBt5caSbNMm/97jW8pgpWB4Q8rAqdr5BSR6rM5bc4uiowWC6pD65WSb+9fn3kV4UbJHUXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066941; c=relaxed/simple;
	bh=K0d18THzbfUB6LwAU1/WojMFGE73LSJivrI3N2f3R8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j12IDov5NoUmnqfzkYuK6MpaVmxSoWViUPuBGlnU/P5UB27cpVg4sCCxQcCZUlhMEx45fHyC17fcml43965r4syyPJZ8SKGmsgYE/mstHTnef7brhD7szJGtpM3mDT/TOocZ8vSjd+6frQcEIHB6JFxoaM90ITUHeGemo1y/qAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gA6Io4dD; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d461162b8so4180946f8f.1
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 01:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729066938; x=1729671738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0d18THzbfUB6LwAU1/WojMFGE73LSJivrI3N2f3R8Y=;
        b=gA6Io4dDXIGUWESIL+pPZJM9oFaXSBXdm8/QhkTbkaCwt5+xc9zsPcEx8Lifk3+B2g
         SFomvBdmlvN6O/3KCKiH3W/lhWnKlaQyZd0optgGWenOXDPDPWrMab8322yYoHac/2+J
         xsdM3vZQfliWGnW8V3WI3zE3gQq9hT2dxPtbDDDgDcoWJ971Hb+97vND+v1ULIlF0fJt
         8AzDfUG0OP7zv8OhQVZVKoA28Ji3rBCdTETYhShkcTna6vA9TrBEgcJtOQ54ZbCeW5KS
         s7HjJe3Ofxyw896YqbkJVrIeKQR7/kT+YLSY+O1aouJDVnSpnKSre7JnhtjIXQsMqasV
         tZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729066938; x=1729671738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0d18THzbfUB6LwAU1/WojMFGE73LSJivrI3N2f3R8Y=;
        b=MQp6FqjjtAL6In7HBEWMnqN1BhHS/31DqBCGPhg8v2No6zuZMkSQtP8uQelcE+szU6
         ROoYCTph+15aWvjG60u5gieFyNj+X+YwgSAIjj/1zVDgqwk9juDsglgou49TBIpNxopI
         xbP4znSy2vHwc+YpN7u+IrVyiRmndWzn1R1ypEpm3buxJ4aMHe9WWu/R/H5D9qGw5+0x
         TAgOapoeysUFc3FTVfn+ItxZdWw0wtb5FRZvgA+v39F0WIML6mxrj9sXDnqXS+ELtBZT
         FWOLihxAsBQBtTH/8+nzfHCa4UMu9au+dbMixFWfXyUY05umpfBicHCJ+x+CA2HAnMWk
         ISBA==
X-Gm-Message-State: AOJu0YyTD7FufXnmPECKDYkmhMlWtzUOibPATfhyIu0t03mdp5LpYJDI
	YtiqJnA0lr62Jl+YNMCS76QQ3W+ewvZrz+pTtzMoVgASndkGKgc0Lw1/08hAduuOzEwHyG8un/9
	bfqYFcfYzTvHU18IqhwfOZpD6yz9WxnujVgzOk9tIw8fRP12W5Edx
X-Google-Smtp-Source: AGHT+IE7/jkWnCvaXDH4bpwieZj+PapXKebg3i0C/PdKAq14Yf4znUUh+mfI0Es0gbzWdaKd9zJxMPPQltY4iL4gTLY=
X-Received: by 2002:adf:e64b:0:b0:37d:5274:7878 with SMTP id
 ffacd0b85a97d-37d5ff6ce4amr9292585f8f.38.1729066937877; Wed, 16 Oct 2024
 01:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com> <20241016035214.2229-2-fujita.tomonori@gmail.com>
In-Reply-To: <20241016035214.2229-2-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 16 Oct 2024 10:22:06 +0200
Message-ID: <CAH5fLgiz51z-9oqSM9vOAKUDTireJnRsvQkqh=1hOuBi4M9wxA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/8] rust: time: Add PartialEq/Eq/PartialOrd/Ord
 trait to Ktime
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de, 
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, 
	sboyd@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 5:53=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Add PartialEq/Eq/PartialOrd/Ord trait to Ktime so two Ktime instances
> can be compared to determine whether a timeout is met or not.
>
> Use the derive implements; we directly touch C's ktime_t rather than
> using the C's accessors because more efficient and we already do in
> the existing code (Ktime::sub).
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

