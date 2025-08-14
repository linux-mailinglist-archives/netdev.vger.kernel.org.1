Return-Path: <netdev+bounces-213623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B36AAB25EB0
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 10:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5F49E3A91
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 08:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B87B2E8DF5;
	Thu, 14 Aug 2025 08:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v1YV6rWN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBAF2E7BD4
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755159886; cv=none; b=WcJHWMe4mCmNwgBoTjK7G2/kErk4qCaxB/tuAXwqTMbMpaxnkEXDL8O5Q+uX/dAlvxB3krO3u012FbQ41E4bTbrB3PeBC8qDb92ayaqkOj/FYJw0EgcUZvjhZxzsYkFDgs2aTFC76/POGJJ0jB+0CbIerXJtw2IC77VmMYBXT94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755159886; c=relaxed/simple;
	bh=01JJlSModoqysW+sRDKwyF6wO+ZTlR4O5R5WhdmWmU8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oyVYLvMzqpUYj9TDDxqLKBNiS9aG2zGZhn0PYw0fnQfR2kpDoMVQwqNfhtAB7g0qJBHpV3dZ7HBT7q4ThxCiddrEzbqz5AQTR4Scy+ZWlsqRn+bMk0PFLriKPF+CTuZlkcaemwufXN+I90DOj+ItgA66NV6WuILny/4hv7rqGJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v1YV6rWN; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b097120so2287125e9.2
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 01:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755159882; x=1755764682; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XjZ/eR6SQYjR+SXWKMp+2N2e/5Kxjm09W05WAM7WjMU=;
        b=v1YV6rWNmU6fsaHjl4Aai9kCoub56MSu6ji+yAqRobOgvUtCVokLnu/7FVpgK43Ax5
         VVTst6wVaTIjTD/1Dw9t+CzUf3AyOwIg5515ucymvGnfx28L/uIOGSQRS5cwKUA4csna
         Jy2EP47cb/GBaEAA86liWMLeXlajFf2WBYhZSbbBj2Yk6GGyTyUxWoTjHI6gJC6DsLNb
         Qg1nd5QPetY17WeE4yUUEXKSXo3V5khlF2xGZmc1qjnUrc0ctrREG8Zi9/jhAbbuCgjt
         KSKKA7Knd9IQqfKV9AuX0icnKtdAKSnlQisnyVxIov4/yiM4Jxk3f/z9qp0CzY9kq15+
         IqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755159882; x=1755764682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjZ/eR6SQYjR+SXWKMp+2N2e/5Kxjm09W05WAM7WjMU=;
        b=UOYndo6AxpdDHH/mcXApeezbcL2iF2gBkTdOhzyNtLuINbLbvducx0s/aArU7gTh5+
         Jnrx5wQJBahaSzUclIkou7QT9lnG9z8Cdx0gzxU/0CYwVApLhJOrUyTfKKuA8e0onBco
         o0w7kDWryLdGb7JTCjttqun+lFsS/PjHeesKNWWU2SQ4kkMyy7teeZrUMV3sfx1Y2r2Z
         +5qQqpN7OWlgpPPQn3X32ZUrDC8DQa9RRpysnBJKJcaK0rS6FPSysz/v5mCs76mu02UF
         Ix4HMb73NwF1JjF6uu5Yy0wtikI+w3/v8a5SquQ9vCP44kZQOaH+l3TExatgpsrfm4zs
         VzYA==
X-Forwarded-Encrypted: i=1; AJvYcCVKZHwTUA40YY6NdxgMiwIy+lH65/p09tOkCb9xFBHTq+IjhH8FFlebJxaCG+5sglo68uRjn3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH5G3Q2xZgZ0xz+6rpf7CAKrpgyocjL+HnCg86bwHIBcAl6RxB
	9d0uH80isN98r8GtvQ7PjFH5cr0B5mJBfHvHxQffmFaoKVA8YrUDYY68ZQa4EXX1fk7+9k/CtrV
	HOXpp5ok5ax1RWvPVgw==
X-Google-Smtp-Source: AGHT+IEGivgrzos4CoGDHY7uH0CTjOvIWOyqPK2uMv3U+POUyDq1mhFpmt0OotkxsQj2w6KHcsTz1JVeOL0tM4c=
X-Received: from wmbjg12.prod.google.com ([2002:a05:600c:a00c:b0:458:a7ae:4acf])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:190a:b0:459:d6a6:792 with SMTP id 5b1f17b1804b1-45a1b67a1ddmr13345765e9.29.1755159881981;
 Thu, 14 Aug 2025 01:24:41 -0700 (PDT)
Date: Thu, 14 Aug 2025 08:24:41 +0000
In-Reply-To: <34d384af-6123-4602-bde0-85ca3d14fe09@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250813-core-cstr-cstrings-v2-0-00be80fc541b@gmail.com> <34d384af-6123-4602-bde0-85ca3d14fe09@sirena.org.uk>
Message-ID: <aJ2dST9C8QLUcftA@google.com>
Subject: Re: [PATCH v2 00/19] rust: replace `kernel::c_str!` with C-Strings
From: Alice Ryhl <aliceryhl@google.com>
To: Mark Brown <broonie@debian.org>
Cc: Tamir Duberstein <tamird@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Alexandre Courbot <acourbot@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Liam Girdwood <lgirdwood@gmail.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Aug 13, 2025 at 09:11:51PM +0100, Mark Brown wrote:
> On Wed, Aug 13, 2025 at 11:59:10AM -0400, Tamir Duberstein wrote:
> > This series depends on step 3[0] which depends on steps 2a[1] and 2b[2]
> > which both depend on step 1[3].
> > 
> > This series also has a minor merge conflict with a small change[4] that
> > was taken through driver-core-testing. This series is marked as
> > depending on that change; as such it contains the post-conflict patch.
> > 
> > Subsystem maintainers: I would appreciate your `Acked-by`s so that this
> > can be taken through Miguel's tree (where the previous series must go).
> 
> Something seems to have gone wrong with your posting, both my mail
> server and the mail archives stop at patch 15.  If it were just rate
> limiting or greylisting I'd have expected things to have sorted
> themselves out by now for one or the other.

Tamir mentioned to me that he ran into a daily limit on the number of
emails he could send.

Alice

