Return-Path: <netdev+bounces-133316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7579799597D
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32897284DAB
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 21:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9F1215039;
	Tue,  8 Oct 2024 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZU6iqLAN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB13215024;
	Tue,  8 Oct 2024 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728424749; cv=none; b=pKHsL4hdRnSA9jRK91h9pSIVi6Y4ZlPBAwan9qsPfBhmkoRCNt5eb+7DJpgHdrQ4scl+1oIIpT+Mls0TBZo45B7bLPb1aJ0JzRcpthKirfLBkkxdXZcH/d0GABAHyJIXJ3W9Tv9+30v22ElWS8A9KOl/MFGvwOVPHQGUMkNb6dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728424749; c=relaxed/simple;
	bh=VoMl7LpDjDXr1VZaAh7ow87FifQ459wX0X4bZGdU9HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gv8w/g1x1pvXGY5u0C7uRvlLLoZA1kmMU0PJlNF7/ZOjM4Wh87a4/XrEyd6NHPuEyCG3BX5N5pWDRsdEe7Wz+Xii0aCKH3T8nO+Sb4DX/5sDZbNMM3d2nV4YtGwwysV7JHMH1TQrjORKk6ayO6Okd2lhPM47N8bHnrx7ZUyy3eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZU6iqLAN; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a99fd5beb6so22292285a.0;
        Tue, 08 Oct 2024 14:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728424747; x=1729029547; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6zzMoQ9GRFFQIfKm8Gy9DFstioAKOO5Mgjhl3aFl9IM=;
        b=ZU6iqLANroR8XSaJ3DhqkYPRbPEyiuzcc7Q7AXEHhx3UHNfj+sv3AyNBnNh6gGt7Ks
         zb/20gr2kLlNk4CMccrasWVbxtghrohUmy/QUPNNuWQtvWmgLWi5djMBNh5k7/MTKwDt
         +x+z4b1QyeWX+GmmLfzqEqf0GI9+/VNqH3Z5tbMbAAe1GXxzmNDTyi1Ed9jrv04Ag2RG
         ocZiTEXLJM8/VyjWwegMIx7g5ueQ/RUAkaff56tkkMZM4SKzmaSJ6PYGjqbMq2xzHJfF
         LEa1zshiuyhXcn421oYfsT2luu27fGPuBQH7/YDzkZdoZHPlwoH2sgOYodFG/v2kJT9+
         vxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728424747; x=1729029547;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6zzMoQ9GRFFQIfKm8Gy9DFstioAKOO5Mgjhl3aFl9IM=;
        b=KWdYpAvfqBJSGeVuQ5ettd067INTOFQer02IJE/LM4kwnryB/D80U52ML1udRx8djr
         t29dOmIUaEX1x7Bveo3Zv5skI2z403fTSrvd4p8AoC6TI18YLEehQxzC8YGiQy8jrshm
         0GHKpyFdr+Rh3PRRN9EXqkfIGtBlMKWULcEAmVMe+jfUZkd+NTnV1ULmYm/iTmTY02IF
         sC9XS7xc7kujxtjqu9xxUURUbAtBFXTWlfq8pVhfzPvcOcCabDzVbJOjL153neRDSYqf
         kTdprdfnNx1rLM3ANiiYSMRuusgzODzmIISU9pSaU3BMV4JAvNMke6q5OS8eABMJCPER
         hqvw==
X-Forwarded-Encrypted: i=1; AJvYcCUBSZEode1MzWVBX0SvtjK4dlXlkh0sO00TgrM8bDO/FzLGXq10bmbHZ+q+DFIXk2RP7m+32OLFUdjzUEc=@vger.kernel.org, AJvYcCWntzpOh7ogMQZzyafWXuheFKiakog4R0RRuWEPvJ6A5KnD/FaNjxHOhhNfssMqCWAGNxPt9Xd0@vger.kernel.org, AJvYcCXLyZSyhbl2wCTCRxVlLwKLzAmR6Fx3HcFlt5vxzZJ5mM66nvF/M69mKKzUCT/kZ6lCqUloTwcA+mlW2i2QI/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGWNygpx8gSk7/M7u/p9B5tmVvSB3EMvn/nZc2NAqlAJHnGPC8
	Du625zXjXl0aaphr1dY+mCJc+7OQeucBANqrKoUuRYBjvXpCi8y0
X-Google-Smtp-Source: AGHT+IElaBK06Rfr7LDkmiWS5ObaJrVEsHKgkBImGnsdOYipQ/6l2iH5PIfu9BNzl/v6kSNfFMdmJA==
X-Received: by 2002:a05:620a:24cd:b0:7ab:32a8:d61f with SMTP id af79cd13be357-7ae85f6faeemr815005685a.26.1728424747092;
        Tue, 08 Oct 2024 14:59:07 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7afcde42e20sm64074785a.2.2024.10.08.14.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 14:59:06 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2EA4E1200088;
	Tue,  8 Oct 2024 17:59:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 08 Oct 2024 17:59:06 -0400
X-ME-Sender: <xms:KqsFZw7aSvKrzJPeYoDvRdPQBiSiCrS7ib1zW_SUwtvOh1BlVsgW3Q>
    <xme:KqsFZx6Ipdp13Jx8UJwEH1YBXrN6XqpyExauI-68cbiLm8w--jHoBVJE63FXJH_3d
    8kyzZ7zxV-ZmsKH0g>
X-ME-Received: <xmr:KqsFZ_dAzkdFCrNREmXHmTwXUk1e1zceTlU0vZMtUf5YFHU3U0hOd9iixH8PVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefvddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfh
    gfehgeekkeeigfdukefhgfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvtddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtg
    hpthhtohepmhhighhuvghlrdhojhgvuggrrdhsrghnughonhhishesghhmrghilhdrtgho
    mhdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehfuhhjihhtrgdrthhomhhonhhorhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    nhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqd
    hfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhk
    rghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhmghhrohhsshesuh
    hmihgthhdrvgguuhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KqsFZ1L_xjvEysHZXQj1J5IsMrAt9wJW9oz0q49RYx9QbrmA_ISygg>
    <xmx:KqsFZ0Im-vSMe-r7eK25vaJN3QJ7nQW8BdKivccOHrQrioRsVdkRmg>
    <xmx:KqsFZ2wyoA5lCzgkg-9FJ6UhyryDWzAdQBD5vkz9K0oUhHWQewRfvA>
    <xmx:KqsFZ4IRsL3t_3elIhD1RgLYKrXLK_yTfwC7GZGkzalLkLHRhZzCIQ>
    <xmx:KqsFZzYNO9zY80RPdMdV6cEZ2CZnoVQ6toGMGOfaVOj2YMQVZ8HG01Ez>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 17:59:05 -0400 (EDT)
Date: Tue, 8 Oct 2024 14:57:43 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] rust: Add read_poll_timeout function
Message-ID: <ZwWq1yDK9Y7ee1pJ@boqun-archlinux>
References: <ZwPT7HZvG1aYONkQ@boqun-archlinux>
 <0555e97b-86aa-44e0-b75b-0a976f73adc0@lunn.ch>
 <CAH5fLgjL9DA7+NFetJGDdi_yW=8YZCYYa_5Ps_bkhBTYwNCgMQ@mail.gmail.com>
 <ZwPsdvzxQVsD7wHm@boqun-archlinux>
 <5368483b-679a-4283-8ce2-f30064d07cad@lunn.ch>
 <ZwRq7PzAPzCAIBVv@boqun-archlinux>
 <c3955011-e131-45c9-bf74-da944e336842@lunn.ch>
 <CANiq72m3WFj9Eb2iRUM3mLFibWW+cupAoNQt+cqtNa4O9=jq7Q@mail.gmail.com>
 <df2c9ea8-fa3a-416e-affd-b3891b2ab3f7@lunn.ch>
 <ZwWp9C2X_QIrTJEq@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwWp9C2X_QIrTJEq@boqun-archlinux>

On Tue, Oct 08, 2024 at 02:53:56PM -0700, Boqun Feng wrote:
> On Tue, Oct 08, 2024 at 07:16:42PM +0200, Andrew Lunn wrote:
> > On Tue, Oct 08, 2024 at 03:14:05PM +0200, Miguel Ojeda wrote:
> > > On Tue, Oct 8, 2024 at 2:13 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > > >
> > > > As far as i see, might_sleep() will cause UAF where there is going to
> > > > be a UAF anyway. If you are using it correctly, it does not cause UAF.
> > > 
> > > This already implies that it is an unsafe function (in general, i.e.
> > > modulo klint, or a way to force the user to have to write `unsafe`
> > > somewhere else, or what I call ASHes -- "acknowledged soundness
> > > holes").
> > > 
> > > If we consider as safe functions that, if used correctly, do not cause
> > > UB, then all functions would be safe.
> > 
> > From what i hear, klint is still WIP. So we have to accept there will
> > be bad code out there, which will UAF. We want to find such bad code,
> 
> If you don't believe in klint, then we need to mark might_sleep() as
> unsafe, as I already explain a million times, might_sleep() is unsafe
> without the klint compile time check. You have to accept that an unsafe
> function should really be marked as unsafe. And yes, in this way, all
> sleep functions would be marked as unsafe as well (or we could mark all
> preemption disable function as unsafe), but still an unsafe function is
> unsafe.
> 
> Again, as Miguel mentioned, we can only mark might_sleep() because sleep
> in atomic context is an ASH, not because it's really safe.
> 
> > and the easiest way to find it at the moment is to make it UAF as
> > fast as possible. might_sleep() does that, __might_sleep() does not,
> > and using neither is the slowest way.
> > 
> 
> might_sleep() is useful because it checks preemption count and task
> state, which is provided by __might_sleep() as well. I don't think
> causing UAF helps we detect atomic context violation faster than what
> __might_sleep() already have. Again, could you provide an example that
> help me understand your reasoning here?
> 

Another advantage of __might_sleep() is that it's already an exported
symbol, so we don't need to introduce a rust helper.

Regards,
Boqun

> Regards,
> Boqun
> 
> > 	Andrew

