Return-Path: <netdev+bounces-136689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C0E9A2A48
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2341C21A8F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158461DFE25;
	Thu, 17 Oct 2024 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQqb42MD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BB91DFE20;
	Thu, 17 Oct 2024 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184632; cv=none; b=OUT/K5WX5Ne5ULYQ9Lwqp5SrRbDuzMM44GP1BTrAcjPSHPKAwl5pAHgCxun3I8dxnu4DFOIrxPxIWx9sAx9kArw9h+EZkGjLvQc5wcDHh5bNUO+BmdXeq8JNaLFX+ZaeepXj2PGsQvIYRf0lzbnheFn+V4zK7p8EgZOGJjcBfks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184632; c=relaxed/simple;
	bh=659KQMKuOOIeqnMNSnQAXBd2L5FO4DHcKQVH2/5WTe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3/w8+GB5bdNC0dSeu4sqZl7SHlNopupgomn6lQi6l4Y8JhoeshS1Uamky1jeF+wdvAi88+5PW00c4pnMJp/p+Aj34uS/Z+D+LrBQ1bAx+P/RHy6n5U8qsI8YD/Hae6aIlBY9uLl59SQx+r50DinM5KBdJhQHz5w4FDN8lxXqS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQqb42MD; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6c5acb785f2so6588646d6.0;
        Thu, 17 Oct 2024 10:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729184629; x=1729789429; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TzQHH2Yw/aL8qkINhkW0RDbgedwJUaLrecn8wJJjYK4=;
        b=YQqb42MDPuJFRF/nrQI2X4/xtHukMuuUkwXs+Wo1cJ1594x6E1bVJ0AMnV41TqFuRH
         ghuCv6sjXOF04WDQvnEIkVtFH04bczI26DAso1g4DZ9eQa5a52Rsc+66ZTzLP8C8Wnvx
         2hIrZyPpz1wat72kOuDfqEdDbLHawGab8bqfAf7jUOxcvO/WoGaS+xR1gPI4Qaq6cV0B
         Q+wkrrWVZBbJXhFDVPhkFG5l2fy/IIvOfw92f2j6jQ+yTJ7/Twa95W0CzXBXn23NmBTh
         00S3GeM4T/g4ZItmSzBCNJCGralr7yBF2C9L8FtodVpFQY4CCK8PYkrfhn+mtp2awcJe
         VE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729184629; x=1729789429;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TzQHH2Yw/aL8qkINhkW0RDbgedwJUaLrecn8wJJjYK4=;
        b=JecVwYk2kWObXyRDsC8iZ88skFIIB4YGur63mk4o+nDRmW6vc02dX3XfJD6swL/oHu
         aEtUuMRXzUO9c51QVADMQK/qiDNWkl4Q2gjDW3CKBX2cpf0B9ucE3fwzkEy/+mBr9xSz
         VT6MoZG+qpMXhczzOiCu9VFvFLM+WoKq2UaJxADemvkpr0YBHwBin4yMBe1P8BcuSsIq
         Afvc7hk/16aPB3sJEGAce4mtcZK5Mr1Uc8fUhpUKU3B9/HqrYZ3Gv6hbauAkfLl8bFnf
         xGiMHE6ozMlIvWHy3RDxD4kjPwUIAj3S8NM5XhsRBQjxn4sFEHRX1hfKs2smBPNJrW7H
         F40w==
X-Forwarded-Encrypted: i=1; AJvYcCUbu48GyBNEteiSjcmxaMjbPX76kZKtI8fRApNdBueYA7MZdsWvM+/m3YWgiWrBY7/ChKtTNn8iRvU7roM=@vger.kernel.org, AJvYcCUiPeW/dX+0y88Z+4uh2fXaGUxz1VTd9lxEya0KeiezJBf0YWH09OdcvJU5nOwjLpzgc1EYSYWMxGFmM+tzNps=@vger.kernel.org, AJvYcCVAgvW82scSF3Vpe1PsKPkdb5GgUbti+lwggerx90ffTvoH9U3jWFXFlGmXjugED5acGykba5D+@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg+EAINmEilmDXApnvbTjpR7PjEYjk++SYoDay/hYx8vmHdt3+
	dEaAAkh6YThTQe6akr4+e0ymaFsL5c/yzhPU2pSQyOk5ua33LhTR
X-Google-Smtp-Source: AGHT+IE6ouKkRtfltsbG6BF5iJKNzv06F0Hx1rzJ0doSBv3CXh2/sGrsMFPLFSF0aHEYPwgZ/gji8A==
X-Received: by 2002:a05:6214:418d:b0:6cb:c9bc:1a23 with SMTP id 6a1803df08f44-6cc2b8d6f3bmr91828426d6.24.1729184629172;
        Thu, 17 Oct 2024 10:03:49 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2295b919sm30025626d6.91.2024.10.17.10.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 10:03:48 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 140EE1200043;
	Thu, 17 Oct 2024 13:03:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 17 Oct 2024 13:03:48 -0400
X-ME-Sender: <xms:c0MRZzHubmasZynuDCp-jGRLWQa6GoCxIs9WHOTONRrt1fFs74j8Sg>
    <xme:c0MRZwWNXaIoR99GXkAqkMZ54XmMojkP9H-QLmNQYW3v6Rf6DLG6AZMsYqidJFRPH
    p2kgNCbSqxw1n6h3g>
X-ME-Received: <xmr:c0MRZ1Lhg3zpVVMLarEPZMCV6itoW_xkbI0wLv4dalwXCnqr9V1eakLPzew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehuddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeejhfeikeekffejgeegueevffdtgeefudet
    leegjeelvdffteeihfelfeehvdegkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedvvddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhhighhuvghlrdhojhgvuggrrdhsrghnughonhhishesghhmrghilhdrtghomhdp
    rhgtphhtthhopehfuhhjihhtrgdrthhomhhonhhorhhisehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdu
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuh
    dprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgv
    gidrghgrhihnohhrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:c0MRZxEIEpkuTwbYs6QjdY7D099lSqXsKFh8S3uSXqnWo4PNCNVd6g>
    <xmx:dEMRZ5V53MkDau1UvfoxQfeAaw1eAazF8HKrVMukde1IvVf4oFEOwg>
    <xmx:dEMRZ8M-XtTzAKQUtGh9mOFlCjL73BlIAyA5A35n6zJLdghNra5eUA>
    <xmx:dEMRZ4185YADTs8w4Qj3Qw4_ptjRTKBja63YBA6sdGH_3ozCTUm_Rw>
    <xmx:dEMRZ-WCSTCjoqEprEQTjKApJmqzwb6m7dgKlkpoCPbbaQ2bYoqkPq-J>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 13:03:47 -0400 (EDT)
Date: Thu, 17 Oct 2024 10:03:21 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
	tglx@linutronix.de, arnd@arndb.de, jstultz@google.com,
	sboyd@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/8] rust: time: Implement addition of Ktime
 and Delta
Message-ID: <ZxFDWRIrgkuneX7_@boqun-archlinux>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-5-fujita.tomonori@gmail.com>
 <ZxAZ36EUKapnp-Fk@Boquns-Mac-mini.local>
 <20241017.183141.1257175603297746364.fujita.tomonori@gmail.com>
 <CANiq72mbWVVCA_EjV_7DtMYHH_RF9P9Br=sRdyLtPFkythST1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mbWVVCA_EjV_7DtMYHH_RF9P9Br=sRdyLtPFkythST1w@mail.gmail.com>

On Thu, Oct 17, 2024 at 06:33:23PM +0200, Miguel Ojeda wrote:
> On Thu, Oct 17, 2024 at 11:31 AM FUJITA Tomonori
> <fujita.tomonori@gmail.com> wrote:
> >
> > We could add the Rust version of add_safe method. But looks like
> > ktime_add_safe() is used by only some core systems so we don't need to
> > add it now?
> 
> There was some discussion in the past about this -- I wrote there a
> summary of the `add` variants:
> 
>     https://lore.kernel.org/rust-for-linux/CANiq72ka4UvJzb4dN12fpA1WirgDHXcvPurvc7B9t+iPUfWnew@mail.gmail.com/
> 
> I think this is a case where following the naming of the C side would
> be worse, i.e. where it is worth not applying our usual guideline.
> Calling something `_safe`/`_unsafe` like the C macros would be quite
> confusing for Rust.
> 
> Personally, I would prefer that we stay consistent, which will help
> when dealing with more code. That is (from the message above):
> 
>   - No suffix: not supposed to wrap. So, in Rust, map it to operators.
>   - `_unsafe()`: wraps. So, in Rust, map it to `wrapping` methods.
>   - `_safe()`: saturates. So, in Rust, map it to `saturating` methods.
> 
> (assuming I read the C code correctly back then.)
> 
> And if there are any others that are Rust-unsafe, then map it to
> `unchecked` methods, of course.
> 

The point I tried to make is that `+` operator of Ktime can cause
overflow because of *user inputs*, unlike the `-` operator of Ktime,
which cannot cause overflow as long as Ktime is implemented correctly
(as a timestamp). Because the overflow possiblity is exposed to users,
then we need to 1) document it and 2) provide saturating_add() (maybe
also checked_add() and overflowing_add()) so that users won't need to do
the saturating themselves:

	let mut kt = Ktime::ktime_get();
	let d: Delta = <maybe a userspace input>;

	// kt + d may overflow, so checking
	if let Some(_) = kt.as_ns().checked_add(d.as_nanos()) {
	    // not overflow, can add
	    kt = kt + d;
	} else {
	    // set kt to KTIME_SEC_MAX
	}

instead, they can do:

	let kt = Ktime::ktime_get();
	let d: Delta = <maybe a userspace input>;

	kt = kt.saturating_add(d);

but one thing I'm not sure is since it looks like saturating to
KTIME_SEC_MAX is the current C choice, if we want to do the same, should
we use the name `add_safe()` instead of `saturating_add()`? FWIW, it
seems harmless to saturate at KTIME_MAX to me. So personally, I like
what Alice suggested.

Hope these make sense.

Regards,
Boqun

> Cheers,
> Miguel

