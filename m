Return-Path: <netdev+bounces-134855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD3D99B5DC
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 17:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8761F22781
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 15:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C057C182A0;
	Sat, 12 Oct 2024 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6SgVh0O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179541B977;
	Sat, 12 Oct 2024 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728746961; cv=none; b=R7JD5gWRr7fuZMIbRpvALYC/zKjm6GSJPWHzwoHL/o55euQaJ6A3RQFYDrattLGE3R9g+W//pNCHasIGKxBAS31l9H8Vk0A4C5ojelSYDorxtUI2v3eWsmR+O/oZDRI957l0yazA4wEnvNoypD3P4IeST1RzK1E8MJ4SZSRq9Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728746961; c=relaxed/simple;
	bh=pk03R0PgeUhtt8tr3mq21IqEAPtVnj0vnrFMB2XqHaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgr2rLaMoEbrtaUY763xwg5+J9a3VAgOqX81J3GVyZCko1UDjJekRO+T0GoGrNZBuS4PFU+m8DWRjgUtPtHaTH9ZdRUFulWiL9DGJwrwYosOL2O7nMbxx5CEI2hEXdbgnmkn0n+dj2UOeulDonFUXbGecpQTzGn/ZiwlYmP5KRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6SgVh0O; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cbd005d0f9so27687666d6.3;
        Sat, 12 Oct 2024 08:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728746959; x=1729351759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6j+FVCgxZfKadKF+/f2Quoi7dAVKG0Z89u9PtWRfpKs=;
        b=h6SgVh0ONBf2VhjO1agutxSZ5/vv+pBAVuRtHxCTDgqsdlRYZb34XJthaiR7fUIZYW
         SHfV3CF7ir/mGBC6/v25di00foiVK9+IPGCHYY5yU6AsguEy0yZzU6QXWmjrAHM6q70/
         ONCqUVYdKTBWzey8Zwr7EcOl5lAsCHXtYo9T8BrG8+U2DloewNq8anDcMYLrLy+RzEK9
         dy9QMCvh6xwbaDYkw5zc3DlaffRRGwUcshznTOVgcJa0GBH96LxRyhsBESQrGwYmTyMJ
         WmVuQkKoP5QDeY1z29mU/jOKpk2UEKWOQlIIKCiuANiL83SivwZoN7bZQ5rXpLR4yP60
         kSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728746959; x=1729351759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6j+FVCgxZfKadKF+/f2Quoi7dAVKG0Z89u9PtWRfpKs=;
        b=lkSRCP4mgop8N64QdjuJ9AMHFjduEfpeZRZtSWrmIMfOWpjHZBTNuCMXkEd7Gwwqlc
         iOvYrocSt84t6ZeTk42IJgbLsjyd7jd2A9PLjJBJUk6+/zuPVKDbNu3yRMuC6UW7XAK7
         c6ZCMdm073RuelI9atfxKkh2tygTjGB/Ep/ORC6jQr2wv0btDWp3HzOS7FXFwNDC4qFl
         fwOy/CB3Fo01Oiu1cctQ9MfmvlgqBoj5xqskDsil9CoV/ICpmoUDUeaWJ0W1eF/fFIsk
         KNPHoLHXNxIL+IgJTxrb873pUBi4+133/OgRIKZYQosWMmiJayz7/hU5XK7U5qCmhbMj
         2njw==
X-Forwarded-Encrypted: i=1; AJvYcCUNL3np2SGoU5lTLWpNnbfUsLMNn8Tj9bF0B+vqTjTiITkZQXQG9vQH3FU5pSykYBaOBY0hnS3Lz2BmfNg=@vger.kernel.org, AJvYcCVDA9xKVktpZINKqLFGaX2cYovGyjNJ1dLV3abvW7Ikb1vlzO+M7Ei7uLNi4oJEYVbWQN6mBr0w7ZkaTQMvjYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpYf4uEd7wOdSBJkBOsBldWqcSGtTJ4K2MyK/hvoojy7mqGudc
	cm8nPSYyVJvEXG+gEL/lDesAveKDJCUQ8p1fH14a3AvIF7Q809J5
X-Google-Smtp-Source: AGHT+IF/EDW9cEkH4aC29lEw1icZ1Kdm7gfHx7mToMwD5a5W4EBJCgfi45RAjKeE4P04nb8zL8QY+Q==
X-Received: by 2002:a05:6214:4981:b0:6cb:f853:9eca with SMTP id 6a1803df08f44-6cbf9d10272mr54404586d6.25.1728746958840;
        Sat, 12 Oct 2024 08:29:18 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85b9545sm25873136d6.57.2024.10.12.08.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 08:29:18 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 099F81200066;
	Sat, 12 Oct 2024 11:29:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sat, 12 Oct 2024 11:29:18 -0400
X-ME-Sender: <xms:zZUKZ7CLprxm149-YkF2JgUbk7-fDvwOFj7h8AYkIa0JvF7THn1rSQ>
    <xme:zZUKZxi2n6JmyaSZQd3wGAF7pf9k7KT1Su_ExMenoC4h6VfmZXHJ0eQeOdRHn7yGO
    7WwLVxptO4gnK6ZGQ>
X-ME-Received: <xmr:zZUKZ2lwGmEWOnZqU-gSvDbYUWYFdGdz6djLdnsgzlTan1ZOeAe2gAV2Jd3sgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeguddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeejffegieejvddtgfekkefhjeegjeevuedugfeh
    fedtkeffjedtleeiuefhvdefgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epfhhujhhithgrrdhtohhmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfh
    horhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgu
    rhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilh
    drtghomhdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughupdhrtghpthht
    ohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnh
    horhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgv
    th
X-ME-Proxy: <xmx:zZUKZ9ye7wzfjjbtI7BsyR9KxGs3_T4Ht33FE_ediU4aOGU1JzSPkQ>
    <xmx:zZUKZwQQ1EFfrzOAJnJbiy4LKSTVdjJk04sYujc7cn9MmOkB376L5Q>
    <xmx:zZUKZwYGRUrXA0NOrYqm5XSK1AhVkeVK6b7lwVOMI6CZvAsWjfLL3w>
    <xmx:zZUKZxSG8tYAgGZaA_F-UxjQZ637Y1diI_l4Ux6aT6LfvkKxA1P9eQ>
    <xmx:zpUKZ2Db2WS0_vWL9cME5BP42GU2Rs5VY-tzIxo_FE_zGGVFFFAF83Lb>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Oct 2024 11:29:17 -0400 (EDT)
Date: Sat, 12 Oct 2024 08:29:06 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
	tglx@linutronix.de, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/6] rust: Add IO polling
Message-ID: <ZwqVwktWNMrxFvGH@boqun-archlinux>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005122531.20298-1-fujita.tomonori@gmail.com>

Hi Tomo,

On Sat, Oct 05, 2024 at 09:25:25PM +0900, FUJITA Tomonori wrote:
> Add Rust version of read_poll_timeout (include/linux/iopoll.h), which
> polls periodically until a condition is met or a timeout is reached.
> By using the function, the 6th patch fixes QT2025 PHY driver to sleep
> until the hardware becomes ready.
> 
> As a result of the past discussion, this introduces a new type
> representing a span of time instead of using core::time::Duration or
> time::Ktime.
> 

While, we are at it, I want to suggest that we also add
rust/kernel/time{.rs, /} into the "F:" entries of TIME subsystem like:

diff --git a/MAINTAINERS b/MAINTAINERS
index b77f4495dcf4..09e46a214333 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23376,6 +23376,8 @@ F:      kernel/time/timeconv.c
 F:     kernel/time/timecounter.c
 F:     kernel/time/timekeeping*
 F:     kernel/time/time_test.c
+F:     rust/kernel/time.rs
+F:     rust/kernel/time/
 F:     tools/testing/selftests/timers/

 TIPC NETWORK LAYER

This will help future contributers copy the correct people while
submission. Could you maybe add a patch of this in your series if this
sounds reasonable to you? Thanks!

Regards,
Boqun

> Unlike the old rust branch, This adds a wrapper for fsleep() instead
> of msleep(). fsleep() automatically chooses the best sleep method
> based on a duration.
> 
> v2:
> - Introduce time::Delta instead of core::time::Duration
> - Add some trait to Ktime for calculating timeout
> - Use read_poll_timeout in QT2025 driver instead of using fsleep directly
> v1: https://lore.kernel.org/netdev/20241001112512.4861-1-fujita.tomonori@gmail.com/
> 
> 
> FUJITA Tomonori (6):
>   rust: time: Implement PartialEq and PartialOrd for Ktime
>   rust: time: Introduce Delta type
>   rust: time: Implement addition of Ktime and Delta
>   rust: time: add wrapper for fsleep function
>   rust: Add read_poll_timeout function
>   net: phy: qt2025: wait until PHY becomes ready
> 
>  drivers/net/phy/qt2025.rs |  11 +++-
>  rust/helpers/helpers.c    |   2 +
>  rust/helpers/kernel.c     |  13 +++++
>  rust/helpers/time.c       |  19 +++++++
>  rust/kernel/error.rs      |   1 +
>  rust/kernel/io.rs         |   5 ++
>  rust/kernel/io/poll.rs    |  70 +++++++++++++++++++++++
>  rust/kernel/lib.rs        |   1 +
>  rust/kernel/time.rs       | 113 ++++++++++++++++++++++++++++++++++++++
>  9 files changed, 234 insertions(+), 1 deletion(-)
>  create mode 100644 rust/helpers/kernel.c
>  create mode 100644 rust/helpers/time.c
>  create mode 100644 rust/kernel/io.rs
>  create mode 100644 rust/kernel/io/poll.rs
> 
> 
> base-commit: d521db38f339709ccd23c5deb7663904e626c3a6
> -- 
> 2.34.1
> 
> 

