Return-Path: <netdev+bounces-227457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20674BAFDB9
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 11:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA4214E271F
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 09:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74402D9ED1;
	Wed,  1 Oct 2025 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TVBaEkyI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE052D7DFC
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759310965; cv=none; b=hfyZGYYUpOUtPk5DZaKr66EkybNAS1h/vYEq/qvcndEXhUrEGl4+R//IrXyQ5QgbveWi0mJta6vbyR6VGYApvu/6e918aIyJ9Er/J6U6baOAHws4Ic/6JAhdlrJH7TerS8TU/PoRnO71SCbLGLChEMKSpu+ELMorN3w/0bh5ZTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759310965; c=relaxed/simple;
	bh=eWhaWIh1Ch5W+HrhvE/7nWxIJ4BqD2s5kUI/3gBmyEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7Nc2LknkDmr0r0SnDQu8Q8w4LeoFid3GrfFBxQ2v2PO+7q3018QL237wvIWl/DJrqQofA7V8O7hiwJD/ysFiKoPQeD4+hY51b8HekjbbijyS8Smm/BAsA4Tz1xTI8xaS0g+5fxvSB3jjQ0WtTzJfYQNk5imG1bYoR9y3IemjHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TVBaEkyI; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-414f48bd785so3911615f8f.1
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 02:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759310961; x=1759915761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWhaWIh1Ch5W+HrhvE/7nWxIJ4BqD2s5kUI/3gBmyEA=;
        b=TVBaEkyIVsWpPgc25PthN0dgMizQ6ejHVgbgY4cBzyNmtAMFUxALL2/XSvvKJkBJsb
         nDMVrtUeFd3OpEfW3EoEcn7zKGgKwSzKK6TBOSXbDglCX4YaAdh419jxyWs9gSIew1u7
         br3pPtBGPK+11HqzUpIOPf0//hSkV2Qmie5YLPhJ5K/5BYBVZH17YsA1yhe0dQRlNJti
         Rp26I6LcqZUn5saUboAhSALCKrU0y0bvtQl3gk/xIzSlF6laY9r6Y6+h2zODmLkxIDEm
         Yul6SYPIAC96/iUa230+xFVkC1Ne7w6ghfm0lj7XZyxe0v7vCRrHZWnlBDr0k3Plu8Ci
         C4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759310961; x=1759915761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWhaWIh1Ch5W+HrhvE/7nWxIJ4BqD2s5kUI/3gBmyEA=;
        b=leb24IOm0fBszK8qmr3jHRBjmoTBYt+BA/P9P7jN1WRxbY9BKFrgNl4DkPbFPpAgE7
         e3OY01j4GrHOnQBs4r01aTWZVM4/lnW0Z9dT0+7oOIIlbj9HacRZxeHrmCO9jfuVL9KN
         NBGgs9xrVoK3SjsfS8gcBoNivNMM9298zOvHxRwbQeBNAD3/Dc4GL6k0+Je24cm7L8UD
         wZ3goqZmNP3mK8Q/x0Va48YZX2UjZk3B1sqQb7/2jfbqOoKHf8tiCUC4bC2hnFT12CKC
         V8ZNYy5UucbdgOFKhNbLqEJ9Js7BHs+L4KfOL89Nv5r1XSMENFjFUPuDQQOpemANZa1S
         +Tpw==
X-Forwarded-Encrypted: i=1; AJvYcCXIa1iqgh+cXGTDHBIQ2PmpvmFPCFUctDYS62indlvSa8kJBDp/x4l2dGYxoM1iKPjTU8+r948=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8dvicGMRmSnzX/N4MOzyKbHfepSVGI0kfijaW4m+zuNaMGJbe
	4mQdwVEXpUBFGqb6hFlNF6qVOig8xT2SSGkIoJJi+azdfUlZ45mWmoT7IG0sOBGrQextvo8CFqL
	ZmDuBlfxNzglHiLsS6Az9xjf7w/rl+DqguHyBdeAl
X-Gm-Gg: ASbGncsTg5vrc8vO4rvkGOHN9kQponkNFsNLLSImNI99/IrwMvyNJhJlEouoS9wcKMs
	zyTL0o0N7+IOAC70LzMr6qrohaCNl+uK3fb10HE2ib5k0zu6ASVjonOiT2ZyynS3JjQT/okYTUj
	mQDrLFk1hFZcQXWB6OnKnL7DHOfD3HsvgRmHx427v8yvWsKr12WjymJA0RxOSzRTrZIIP+0OWY/
	VQxlQCkHC2Hn6eQ814FHF4sVDsmMUgYABiPdMg9u1n7t/20XmqueLQtPJ1rq6OzxlJj
X-Google-Smtp-Source: AGHT+IEGTvzQBJ51h7EDzxRa/Kisf+BfY+7cpvTrlEhl/iMUN4+q2HPEwsb4ysW4cM34kR4mPUadGwVDBMTe2U90ivY=
X-Received: by 2002:a05:6000:610:b0:408:9c48:e27b with SMTP id
 ffacd0b85a97d-42557820c81mr2042096f8f.62.1759310960773; Wed, 01 Oct 2025
 02:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com> <20250925-core-cstr-cstrings-v2-19-78e0aaace1cd@gmail.com>
In-Reply-To: <20250925-core-cstr-cstrings-v2-19-78e0aaace1cd@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 1 Oct 2025 11:29:08 +0200
X-Gm-Features: AS18NWCOfBcX2Vbfhr-fnk5GPcApSeOL4C5SAm45sMYmzlcHM8gTiQQ5VZSiyfk
Message-ID: <CAH5fLggd09hodiDAdNRy6aXK9ANCP==YSJwy-GMbhNAAMm731A@mail.gmail.com>
Subject: Re: [PATCH v2 19/19] rust: regulator: replace `kernel::c_str!` with C-Strings
To: Tamir Duberstein <tamird@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Alexandre Courbot <acourbot@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 3:56=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

