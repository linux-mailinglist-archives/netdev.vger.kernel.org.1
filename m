Return-Path: <netdev+bounces-193941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 511BDAC671D
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 12:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29814189768C
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 10:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9912527A11B;
	Wed, 28 May 2025 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VWBoXXg2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DC02749C9
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 10:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748428687; cv=none; b=Ievr/YrZYx1xG8koasR6hxrZjmgYoERYwGsWzX7UXLBVvVYV0+7ZHvNcrB+V7PCYRPZNtsPDg+VXf0yZwb3hoKPNLA3nonVmbkh09x9IBU82K7FuGWhuOanQnN7PNXRyS0ei1bCZr7K/Pb32fTq07FFDudv+NnfEUZx5ezW04bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748428687; c=relaxed/simple;
	bh=f88538q2yu07+QCvEaeEz9oVquJwFySRVSt/ENxM+xU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MqnPO76f8UuVV6bvIZs4/hMrzqbVbUrbCTyewKNaCn3toke0QmVgLQM2nsGj5Kh91djV8NaoVvc68NcofFzYDrfN1gcHa3FrsahurZBZnHc0bZeHdXXPPIwiqH7cozWvng4+n4RicmvKbKUMAW7qxFfVM1W8H5vswKSEq+W6iww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VWBoXXg2; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4e1c6c68bso1293878f8f.0
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 03:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748428684; x=1749033484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IeeR9yH0GpAyOFZydrFxToBZKNrKT1e0eUyjOqJKqG0=;
        b=VWBoXXg2NKCUo1b0ZAwDu3yGggmSYzpOOrmhru6hwShEWwN5g+N2vaIJ76si/ovTlU
         fb6bOkDkEQIitJr0XlnJCaBoxuOrx2WMrFhhZ7tU488N5eEBAdq3Yqr3gVBrYctdinbK
         EmCD7KeZXxCX9abK4O8wJjqm0svYkdKy2CtsGqYRejSzDEJtFLRuEOl9aFrTuYJqkL1G
         B9F+SS+snvFhYk1pSRIoek5V1cNSDCkCV0U0mecx/gisAaD138LbyTcDsiuSUQ8A88GT
         riNA01LSgnqAhVnGkcrzl0JDzSBB/t9hjPr7P87MoYvOxtuiCC9O1Fxezph5bJF2m0lu
         niFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748428684; x=1749033484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IeeR9yH0GpAyOFZydrFxToBZKNrKT1e0eUyjOqJKqG0=;
        b=BODs/Dn0F0/elRsE1P3CVhIpKNeIfJ1elYdWBM0dpUGKd7eBU8QtQRquCAR75gGVje
         5BSP1ubNnnqQB+IUuQfSYqIO+wIHs0KnclksCM3iuoi6E2qigm89H04rV6m8Ilfv9YuJ
         ggG5MLmW+JrvdUKVMP1+yXXViFWfLMsakJfGi1+w/5QKm1UMqDv2G3vOC8QgKEkaKbeb
         Bdmd33JdTxSPNn8eMnbilqRqMSVa3hawPFssaRahXBgsXwQcjI7JbN0ZdYrzKOdyl49r
         Q+Scky9SoTLIKyVEAWgPvqg/T5rqbKydKfgUwiBxXWpcfwYtXz5hIZLuwVh5tiLAcw6v
         l9OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQFb0gnaiYWIAMTWk93AabPTaJw1gNRFJroCbBmxgBmduVgNqpm5d0Hq0c9E781z+gPcSkwd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZnGa780TG9tPoyFfiucpGBGN9D1LgWd7U42tYwc5nhSFRHu8u
	Oo0M6eREAeXf2578G7nqO48Mjqu0s04bip4MyRVGYkiLVShnmd7AFHZcPyyBCVoFVq13CUMhhMe
	s/Q3YpM/E8vyB2hjZwQ==
X-Google-Smtp-Source: AGHT+IEQyiB/rjNjbMrROAYgPHAOQltkjwgoUsDbxSNhCEmiFFBD4KxkcRnm6cL1n1mzqucg+R5Lc+Nr+C90dyo=
X-Received: from wmbdv21.prod.google.com ([2002:a05:600c:6215:b0:450:5dbe:5f11])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f8b:0:b0:3a4:c95f:c1d1 with SMTP id ffacd0b85a97d-3a4cb428313mr13345804f8f.4.1748428683991;
 Wed, 28 May 2025 03:38:03 -0700 (PDT)
Date: Wed, 28 May 2025 10:38:01 +0000
In-Reply-To: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
Message-ID: <aDbniZzL1ZOSnfVi@google.com>
Subject: Re: [PATCH v10 0/5] rust: replace kernel::str::CStr w/ core::ffi::CStr
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Michal Rostecki <vadorovsky@protonmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>, Benno Lossin <lossin@kernel.org>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, llvm@lists.linux.dev, 
	linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, May 24, 2025 at 04:33:00PM -0400, Tamir Duberstein wrote:
> This picks up from Michal Rostecki's work[0]. Per Michal's guidance I
> have omitted Co-authored tags, as the end result is quite different.
> 
> Link: https://lore.kernel.org/rust-for-linux/20240819153656.28807-2-vadorovsky@protonmail.com/t/#u [0]
> Closes: https://github.com/Rust-for-Linux/linux/issues/1075
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Overall LGTM, thanks! Left a few comments on individual patches, but I
can probably give a RB when those a fixed. :)

Alice

