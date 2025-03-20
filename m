Return-Path: <netdev+bounces-176573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4B1A6AE2D
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 20:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C6B985AE2
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 19:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1902227E9B;
	Thu, 20 Mar 2025 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGY7EJDh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4951B227BB9;
	Thu, 20 Mar 2025 19:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497501; cv=none; b=Egiyd+NKnoN4/B+siqsGBLdhWp4VVDFU3Zouq4yMdwGW3CER2EqqPcM77fsRMwRNGQeHOFlpGR4Dr91cFOxw37qODf8uULscSPoceTTY+lppC69ZmxP5SF0iWJJryvmLxT5rpf2GKx13VEVb2qWlHwGzIGoYAEu6iA0oqljdd/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497501; c=relaxed/simple;
	bh=CVbbd+cYujo/HQFTA+yCNZUnKEdWS7yOFoI9/resuns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3w7Qkz7vaNbyEinhCzXA/74chXk7a6+FlFQRI8jGVHbJRjRcgUEw8AAPDSb+JYmfabPMCxnDLE3qMm3YeAJx5OZ/4IZQfSBfv4mHqQB8fp1+jz0jz3P0PlryIonOQs7Uds7CPYhUpGAe9eiGzzKUd12urJBkfxcWMxsXP2aIYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGY7EJDh; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e41e17645dso10830796d6.2;
        Thu, 20 Mar 2025 12:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742497499; x=1743102299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6236jTl6DuIp7A1JdgVx90Xr9cNxSpV50bUQ02Q8PM=;
        b=jGY7EJDh6Sw5fplFYgCi+NvAkSu0pL7QyvGCVE3SLKtQqlvpTYoA2UN5fvs0NmaJYa
         nbJk54Sqn3h1lg1/vHga0gSlazbVaBW88ThUzMV8KPAahxWqMxz26YSC1NDMhMPFi6TD
         UfMi8pfYd8t4WkxFFqkNil8gWsnAhy5Iao81Rsa1HcZaxvprhzy7k3J8yBt358ntiX09
         wBmmGl7yOXyY9UNW1JO4tHcSHdYXfPb1At4Fgmr3Eoon+Z0YHjStZFs65sfR21+M86pA
         VVEYctZfuL49oiBhiEnlp/lvYEsf+JFkSeQRfa7gvRvwEaS53G5oTRzs0PnBHlqdCb3s
         2oqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742497499; x=1743102299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6236jTl6DuIp7A1JdgVx90Xr9cNxSpV50bUQ02Q8PM=;
        b=nVNHov/Kpwh6WHnerDIpLnxlMZLccm4hY8yioIOLYZq8XrxTq0zvMFom8ieB0nAzvW
         OakgLIwTDPsBM/M50s/oosZkoSFpdpnHI4+y2kuTD/0sNQj91r4tdZiSfcRqr41gkTBW
         5A+AfH2v3//rlHOsfTUIVgiOgAmbdFbr7bEml9unaEk3yTwSvHzFuyD4/k/OhNMquv5k
         NOP/W8PNDx1lslm1VIiWIF4v7UwedI3Zw4bEt2Ti7hDakVVl2H260K0Qb9SN6KqU4dMD
         X7M7FEiHI/rrZ2sPhiizWR0x7mKAXRKOBKw1zvibZX294RT45fq7+nFXUD7S2r3VUVkf
         Xn0w==
X-Forwarded-Encrypted: i=1; AJvYcCWvZBTb5g4Xpn/Vj7m9hDlHn4OxAr7ZXQyDKIudvn9uF+BZsG4Jfr6P3/0m0DZkaf9fSQTp6/KP24nCKeke1DY=@vger.kernel.org, AJvYcCXwktwPpOnvmKnTCjhnJojUZ/RL64vfwo+CHzA0PtlC2oNBFPeZoKhEJnvf9VhtkrEO2QtVS5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZp7151FlOYSQ7Y6afxDH1kdKUQ/HlHmbqUaCzYrhwp9cEiD0Z
	TEbi+ZKyQ9f4jOayGHv5yhOrLzPHxW0fooAvUECPywHBUY3GJ1C2
X-Gm-Gg: ASbGncvpCgvO1skc5GNekCZIF/lDZmenh4q03idFc+vqIy03Hg79stXB/N+M8VrSCOY
	yJGWzDSXid7WABJsL9/a5v/aF2kDjEPozyGgglfAN+JSnGgCBvqVLIRVuTp7yoLyY15yAJRRCIl
	ZsTtnwV/b1yhtOfxQo8+KdnuY7QUBG7oINTSREI4vhR/G17EtIKFGJu2Qk0tKQb1Qz4HBESq6Qo
	JTorq7rsgRqwZJb3DVlzEmuLu/WwEAB8lrwNHeYt4cA1O6pIJw+K5cbayMaCISQHCotOds32cRW
	AX7+/MeO072rKWz3AOfjA1EFp39HEowjLlDSh5m6x8Ime0zmp7B9tXNmpBmZlngwpUTjr1SFfPJ
	OdBoxGpPWkKgoZrzvBeeD6jLQ0SNA8S3oBC8=
X-Google-Smtp-Source: AGHT+IG4hDMaXvGrwZrlWKwMWBhVv38rTo7D7ZJoPKycn9E2N9eBslynixjxVjpdJwjV2gah2WLLLg==
X-Received: by 2002:a05:6214:258f:b0:6e6:6a6e:7596 with SMTP id 6a1803df08f44-6eb3f34eda5mr5594226d6.39.1742497498824;
        Thu, 20 Mar 2025 12:04:58 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3f0005a1sm1600756d6.121.2025.03.20.12.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 12:04:58 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 93F251200068;
	Thu, 20 Mar 2025 15:04:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 20 Mar 2025 15:04:57 -0400
X-ME-Sender: <xms:2WbcZ0ZXOC43MKEYfKHh6xaI7C7xr_CuFQpX9BUzYd3-zBWdthT31g>
    <xme:2WbcZ_Yo5LwwJnJJO6ZnAdvrFPrUiMvAbtIP1LuX3a7QtmIBxV8W1OVuTXsN5a91Z
    VbM8r1CEORW8uyVyA>
X-ME-Received: <xmr:2WbcZ-_MGngpsMCQ4eExE7gJ3MNBYqduxoKQrC3iLuCIMUooYq7wkg69zh8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeeltddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepfeefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehfuhhjihhtrgdrthhomhhonhhorhhise
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpth
    htohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhmghhr
    ohhsshesuhhmihgthhdrvgguuhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:2WbcZ-pnv6pYGsXx5ihY_wDmEJ752y-25l9eK0CXZo2O_jXauBJqnw>
    <xmx:2WbcZ_o-1543d9PaUSfUbT1c-VX-udKPclBpubA5xRwF0cCTuHTOYA>
    <xmx:2WbcZ8QImV8nCPlxX-4MzszRX_nEXC5xirF-VomC5x0l6WIyrOdR_Q>
    <xmx:2WbcZ_pkVrGyWODqYW3bsoc3gkkZFnmyVCQo_xGaARLoRHhMRQAEUA>
    <xmx:2WbcZ05nqgub6RWDluvSHPh2pOZqytAXWRCS6003FVJdCm3Fk2D-EYzM>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 15:04:56 -0400 (EDT)
Date: Thu, 20 Mar 2025 12:04:30 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev,
	david.laight.linux@gmail.com
Subject: Re: [PATCH v11 0/8] rust: Add IO polling
Message-ID: <Z9xmvjIZgkYUAU1a@boqun-archlinux>
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220070611.214262-1-fujita.tomonori@gmail.com>

On Thu, Feb 20, 2025 at 04:06:02PM +0900, FUJITA Tomonori wrote:
> Add a helper function to poll periodically until a condition is met or
> a timeout is reached. By using the function, the 8th patch fixes
> QT2025 PHY driver to sleep until the hardware becomes ready.
> 
> The first patch is for sched/core, which adds
> __might_sleep_precision(), rust friendly version of __might_sleep(),
> which takes a pointer to a string with the length instead of a
> null-terminated string. Rust's core::panic::Location::file(), which
> gives the file name of a caller, doesn't provide a null-terminated
> string. __might_sleep_precision() uses a precision specifier in the
> printk format, which specifies the length of a string; a string
> doesn't need to be a null-terminated.
> 
> The remaining patches are for the Rust portion and updates to the
> MAINTAINERS file.
> 
> This introduces two new types, Instant and Delta, which represent a
> specific point in time and a span of time, respectively.
> 

I propose we should make forward-progress by merging patch #2 to #6 in
mainline first. These are relatively trivial and only affect Rust side,
and the whole patchest does show that they have potential users.

Thomas, John, Stephen, Anna-Maria and Frederic, does this sound good to
you? If so, could any of you provide Acked-by/Reviewed-by and suggest
how should we route these patches? Thanks a lot!

Regards,
Boqun

> Unlike the old rust branch, This adds a wrapper for fsleep() instead
> of msleep(). fsleep() automatically chooses the best sleep method
> based on a duration.

[...]

