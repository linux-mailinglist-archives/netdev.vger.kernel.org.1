Return-Path: <netdev+bounces-182003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68E0A874EB
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 02:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F013B1AAC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 00:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2481936C;
	Mon, 14 Apr 2025 00:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRTer9PW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17142182;
	Mon, 14 Apr 2025 00:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744589184; cv=none; b=hZj0SD504V+/2KlGk9VKkIuJWaqjWaRTJuGigvYZC6NoLhBaEQpSSbbBnTc3iD4V551abX/HspdR0uaseZR+suxgKk8ePcStE3lFkVGhWAZ9d2WGUPpzrp7ssTL28DzazFMknCO7vNgQ+s03oQpiNgO0dCE+gPMlQJ/mzlcM3no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744589184; c=relaxed/simple;
	bh=nRZeEP6TMumsNzd2qlMpyDrzJQev2tDNunTeczL0w/U=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsLCOJsR1qE0aOY5eFTkGUHFT5gVzlzkwktrMm4DeszbQZacB6woDYIkpiU3TFfbBsaq1NGZyRphuz5RjCV0GRoh9JvVvaVghG35rIIkVy6g15cLhwD9lRL4403C0cX7HS9xgMPps9ZnZTixB2xe74xDA1Dhc+gM7QNqGv8yiaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRTer9PW; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476b4c9faa2so47436261cf.3;
        Sun, 13 Apr 2025 17:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744589181; x=1745193981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4C8xcXg1NpLb+plLT5ehdSAMxz+OEN1QsPQStjI01OU=;
        b=PRTer9PWnSCAiSQo/9ThWI7Z3CuGRwuT0EyIygSZk0ckvnNhOdpVRtsxzln3Nvx3G4
         XskgfT4EZh3TpDB/Bht6VpkMWQgSN2MGM4w8oSHWcEe16kEAfft2j4vMz3dtOtlSiS4+
         euT0LW/KMgcl0wA7TnKEKTFHdVdTRUZZwc4My53pkERSvMBS3NK4TN6pVFhiLnKcCRxc
         +1LgqfpXdymCeavXOm/EcX5KhW/7IOhf/RTvq/wNeUNQNtq+Zj8nFEiH4BzNrETNClfa
         yBGkGPJXZg+z51P5t0xzPuw45WY2Ft8ZG917cw6QNuwzjW5KKibZn3M1vr7KZmQsn1yC
         dg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744589181; x=1745193981;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4C8xcXg1NpLb+plLT5ehdSAMxz+OEN1QsPQStjI01OU=;
        b=wMtxZjU5GWnZTTNADh9h0gJJGTQQtzhwUyS6sQG5DsBDITMWMPj+0xezGPOYoPXcgF
         l06JG2M/EQkKrKbRkwnxpsYDAXOM7x1akQ5IF6uT+LyahfpQAIRltgLOJzgTGyVCMjSY
         4PTJJg6niODLhhtqQqxn2JOPyZlSn05NlmjrL1lY0porNX/mxkikNp030S2Qrnw9zZGw
         kNuIdxyYL0j+8RDUO7c0Ny3MGNIX6YoNKbW2Ul8vJ+AAOibYfaG07UgDQ3mVr7tAm5Rp
         6LLg8mg28DtoyIXkzxfgsrARwGD1sz4ViByXyktFUZWveyzuIWQyMr0D4YPohwn5pqRw
         Z4hA==
X-Forwarded-Encrypted: i=1; AJvYcCW01piImpp+ltz9xK65UvBE0PDWBNm/tmYkIGHijibLlV5YVPRzlU169s22hLJx5L2/9Bc1sCP2ifcW8O0=@vger.kernel.org, AJvYcCWDTFOom0Zkf+eCT8RaYLt33FrMNe+4ESWK4snClxtJ3tRawnXPxgtcI4CtnDOrZqS5JMvT4FMV@vger.kernel.org
X-Gm-Message-State: AOJu0YwMy92AxNHXyeMO3+TMM5nz7WKEWVF00l29WCXs9h6hyhYrF1iI
	p+a2GOjTiB/ehkvT0LZfenRJalRYN8h9tDcbEe4t/CWw8Fd7nOMJ
X-Gm-Gg: ASbGnct4dmZmybrjIPQALvAgnxlqFWrn6HFJMS4Np/0nB9OW/TSR9fpZXVm3hRlNsm1
	0meYH5Wgw/+HjycT8Uwevh6RSQCO5JmS7Kg2xq3Kt8lJT6OJQusYtkTJUIttu6GD+puehg+6E29
	DLCtsB2o2B+Xn/TzBVWjA60Fs4XZp6CEKN0K7rRwlXrjKnq9uAfIMGPvA7TdBbONUQZE0JzC1OP
	Z43X0eZdLOhwP9AxvRIADYM0GkT/byreevXYMjjkk+oFfdGyeGgqlV2Ec6VAyyTj9/6J9ImG4qs
	39sIaWTZV21C93GKVM5wW4gNgai2Kjzw99MQ/+GeSuocxCW30+2O7M70gaF00gMcchNqDlFj2fZ
	uXXdv6PWruiFh3zehv9MHlN7ORyPoe+o=
X-Google-Smtp-Source: AGHT+IFwCbN4ZT1DJ9RQAyQzjQJYVN33ZAs5lsoHUiBQzlqkd3qDExB6DW7eCbQ1fNjMQawjwJkzzA==
X-Received: by 2002:ac8:5fd2:0:b0:476:71d2:61e6 with SMTP id d75a77b69052e-479775e2b1fmr149686371cf.45.1744589180697;
        Sun, 13 Apr 2025 17:06:20 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4796eb15c24sm64035891cf.21.2025.04.13.17.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 17:06:19 -0700 (PDT)
Message-ID: <67fc517b.050a0220.301460.dfe7@mx.google.com>
X-Google-Original-Message-ID: <Z_xRdyoukN8wkmNM@winterfell.>
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id C00801200043;
	Sun, 13 Apr 2025 20:06:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 13 Apr 2025 20:06:18 -0400
X-ME-Sender: <xms:elH8Z9r1-P3tjUh0yf1ZdvTSBMvzr52cibP-MepNpnSDJsfTwrhy1A>
    <xme:elH8Z_ql0Mgj6PC1OAI9ilkdBk2CXGEplLSD3ldoEd-XbKnoFRJqee6Wi-FyU5-JV
    oDWt6f-EGGMiJK61A>
X-ME-Received: <xmr:elH8Z6OfzbvCRJcQkqtd9ArWNWjerAVPezgQmWmCMFxngam_3PzyTjKF1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudeltdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedv
    teehuddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeefhedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepfhhujhhithgrrdhtohhmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtthho
    pehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopehmvgeskhhlohgv
    nhhkrdguvghvpdhrtghpthhtohepuggrnhhivghlrdgrlhhmvghiuggrsegtohhllhgrsg
    horhgrrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrnhgurhgvfieslhhunhhnrdgthh
X-ME-Proxy: <xmx:elH8Z47WIH1AhHHmWD-Ol5kyhgfBxigOKvYXd43PeSjXi1hwlynS9Q>
    <xmx:elH8Z86y6vIyZX1ljU-3DAiNcjqeI67f0TESDze_QWwv-SdJ9ZvDuw>
    <xmx:elH8ZwjSYUWhQp4W-VQ879WH1fnkCbNJVacTUExRAYtGBzStSxOvPA>
    <xmx:elH8Z-4uV28d0pwGixJH1qcDdDR9qk9e0wOAvmWhtZAuExViAgvJ-Q>
    <xmx:elH8ZzKcYWw6d8mhrg6tE2qIbaRG_f4t9CnpD6Ri9QyGXrCITBlS36z5>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Apr 2025 20:06:18 -0400 (EDT)
Date: Sun, 13 Apr 2025 17:06:15 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Gary Guo <gary@garyguo.net>,
	Fiona Behrens <me@kloenk.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, alex.gaynor@gmail.com, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
	tglx@linutronix.de, arnd@arndb.de, jstultz@google.com,
	sboyd@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com,
	david.laight.linux@gmail.com
Subject: Re: [PATCH v13 3/5] rust: time: Introduce Instant type
References: <20250413104310.162045-1-fujita.tomonori@gmail.com>
 <20250413104310.162045-4-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250413104310.162045-4-fujita.tomonori@gmail.com>

On Sun, Apr 13, 2025 at 07:43:08PM +0900, FUJITA Tomonori wrote:
> Introduce a type representing a specific point in time. We could use
> the Ktime type but C's ktime_t is used for both timestamp and
> timedelta. To avoid confusion, introduce a new Instant type for
> timestamp.
> 
> Rename Ktime to Instant and modify their methods for timestamp.
> 
> Implement the subtraction operator for Instant:
> 
> Delta = Instant A - Instant B
> 
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

I probably need to drop my Reviewed-by because of something below:

> Reviewed-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
[...]
> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> index ce53f8579d18..27243eaaf8ed 100644
> --- a/rust/kernel/time/hrtimer.rs
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -68,7 +68,7 @@
>  //! `start` operation.
>  
>  use super::ClockId;
> -use crate::{prelude::*, time::Ktime, types::Opaque};
> +use crate::{prelude::*, time::Instant, types::Opaque};
>  use core::marker::PhantomData;
>  use pin_init::PinInit;
>  
> @@ -189,7 +189,7 @@ pub trait HrTimerPointer: Sync + Sized {
>  
>      /// Start the timer with expiry after `expires` time units. If the timer was
>      /// already running, it is restarted with the new expiry time.
> -    fn start(self, expires: Ktime) -> Self::TimerHandle;
> +    fn start(self, expires: Instant) -> Self::TimerHandle;

We should be able to use what I suggested:

	https://lore.kernel.org/rust-for-linux/Z_ALZsnwN53ZPBrB@boqun-archlinux/	

to make different timer modes (rel or abs) choose different expire type.

I don't think we can merge this patch as it is, unfortunately, because
it doesn't make sense for a relative timer to take an Instant as expires
value.

Regards,
Boqun

>  }
>  
[...]

