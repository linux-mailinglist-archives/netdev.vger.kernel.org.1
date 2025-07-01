Return-Path: <netdev+bounces-202846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35735AEF562
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F873A8208
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 10:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7AA270552;
	Tue,  1 Jul 2025 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yAXGl2UE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B214526FDA4
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751366655; cv=none; b=bpJQmjMtWf5kvym1x+BvnBXn7Wpi4tBw1Ctp/8aYZ5czT/IYhjp+868T72zNviavp2oUQP+tVkiCYly63tVb+jo9HDQGb4VMU+RVIG0xfouRK1Bx53jg2gG7d14XpnbycAc4C05ZUh9FEOyYyJP9T9a9qpjSTdQlETkXV5bCi6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751366655; c=relaxed/simple;
	bh=FjNNJQuNFHz/e6yt6+QF01AIHDz6pY4OvsUX2LurgSk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hLvlMJZW263sCPYgCtVJVUoR1sugUqc+sfxVJBUDgL1yH30VwjnUtgnySH/y5IYcn8IDwZytt10ZgJRxzFh3EIzZSJ+VOcyjc4ikwUfTWws/ZA7DJGLiS7P0sC6XihwCK12IQtryEZKgyCE1F7uFkrauBi4zQWqoPx7jZjISGsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yAXGl2UE; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-607c239c7f0so2926891a12.3
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 03:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751366652; x=1751971452; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KkP3Q/mrHcTXpi5jFAQSRZZTttwkOM8RfBay5zssxDs=;
        b=yAXGl2UE0qGFLEXo8I/Q2Me+hvVbD7mps4Qv0pBulP64GzRp969FW+u0lywERoqpQ1
         ZjN7Z+eLDoqa7yoDrhFaRojz57rhL6Rir/zpwzCWKuPEEyGre87w/lCKpfuIR13kFpKf
         yCy6wzZ6QgkBK/ptREQ02Xm5pvimoCLIT3982qRqrBRkaoOSTgjddPD2/M0krisx/I70
         x0/3GmhDt3zFn+6ov2RP3FHOBkSbhkVi2tlA2nKgBkQh2lw7FMQ85VQvaFylCsDlB98p
         buq6+GFlh7eDHsEvqV3s+Q8LCNNNGNncnj2SKXdG6kY62ZswTAKQnbbWL2vwc+JqJ/ZV
         lw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751366652; x=1751971452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KkP3Q/mrHcTXpi5jFAQSRZZTttwkOM8RfBay5zssxDs=;
        b=j77btZ7CkAqD0s/3MwS/C9JeAPKUF8O5vc8+A7z1+9R0ZR+kF1delEz5IXsB+hdaDt
         SG5lVgNgpPXBhwtoGp+oBKs1xkx0gWwKXHKKAocULuIXjaXlutGZTY4ipMYGUDjxZC7n
         IJeWGaXePpFS3G2D8Moxk8nb/lEqohWLpxW0wiXKc1Kctvh5nLmyqeQiAFOykO3A4VX2
         KPh8jd+n591zXRe07Z8CiRxAL6zpkXxJn6GxiJfh+/C7tSexOUYsqM5/3n+oZxEcAZLG
         XzBjnQu12yNRSUJoKSxXNRTe5s/M82dDzlJ2c4QNZA7b2fBaJyS6CvM52sUy65lvTiPA
         kr4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLk/2uqz1madCyAUqjLCQ++nOtul80AXz5aHeE94RZ3XuT60ZrOuDQzJVrN4Eq+stzOsoCr88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBfik3n1l4f72oTHwnN0rL2lpw8LEZNwEEW9qWPdwzW07m4D6M
	RBA9qqC2OFBdgyHnnjUjWea30td4ItGv5uJLRJDmcqnm8HOclhlUhEUtZui55keG9Oy77qr9jBb
	0ZeZAMeetg5fJ3MVQ0g==
X-Google-Smtp-Source: AGHT+IFVVYwcwXIW2+rs+LXCKTLno19A5yuxBI/UefmvL0JcGML1UYLUePmSmcmNLPYFZsBsDSZ4dtmzcyM66Ug=
X-Received: from edwf17.prod.google.com ([2002:a05:6402:1511:b0:60c:3b8e:c3eb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:26d4:b0:607:f431:33fb with SMTP id 4fb4d7f45d1cf-60c88b26b30mr16470283a12.3.1751366650570;
 Tue, 01 Jul 2025 03:44:10 -0700 (PDT)
Date: Tue, 1 Jul 2025 10:44:09 +0000
In-Reply-To: <20250619-cstr-core-v12-0-80c9c7b45900@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250619-cstr-core-v12-0-80c9c7b45900@gmail.com>
Message-ID: <aGO7-SQUUgg6kSVU@google.com>
Subject: Re: [PATCH v12 0/5] rust: replace kernel::str::CStr w/ core::ffi::CStr
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
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, llvm@lists.linux.dev, 
	linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org, 
	linux-block@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Jun 19, 2025 at 11:06:24AM -0400, Tamir Duberstein wrote:
> This picks up from Michal Rostecki's work[0]. Per Michal's guidance I
> have omitted Co-authored tags, as the end result is quite different.
> 
> Link: https://lore.kernel.org/rust-for-linux/20240819153656.28807-2-vadorovsky@protonmail.com/t/#u [0]
> Closes: https://github.com/Rust-for-Linux/linux/issues/1075
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Overall LGTM. Only question is whether we should re-export
core::ffi::CStr from kernel::ffi. Reason being that right now we are
telling people to never use core::ffi as the integer types are wrong,
and I think it would be nice if we can continue to tell people "never
use core::ffi".

Either way, for the whole series:
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice

