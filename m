Return-Path: <netdev+bounces-132732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8AA992E90
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF111C23093
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186391D5ABE;
	Mon,  7 Oct 2024 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxnPFsuo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700801D54FE;
	Mon,  7 Oct 2024 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310474; cv=none; b=J6PbvQqFkkGQr8245l3WjWdmRP69yZXYmtsRZrJgvTUGNQpzancSuLpfIzcpIXNygjgoFMunZuQHRvpJ2ze+Q092hgn+OvFTE+so2z+pVaWE+wqUlvqzCitgN5j+r+esIGZi36EM8A749zXoVCG72eR25DkpRdXwHv3jE/T48m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310474; c=relaxed/simple;
	bh=0biGH3EGNTyI7tqOdoKQ6K52PYT4J6yUhPzidq0qDJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kttg90nm39BCzFnGy1V0t8M8ncQL6wvVdE/lhQyflS+CjkJSuV8Fo6aIbHlHvE2rQ2milaPFsNwYovGwr7c+MXEz5/bF9btLl8BtMgxdck3gv158UF88AQL17QsZK2LqvXI0Sgr295uWunmnuQFh1Qu8/FXbzvjsYzdv4aRQm0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxnPFsuo; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a99e8ad977so352551085a.3;
        Mon, 07 Oct 2024 07:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728310470; x=1728915270; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v9YBQOUMUHP+dHvWDzTcw4FOX7H+N4Nuv5wIKgOl7ps=;
        b=MxnPFsuofDUXfAB8QgYE42hrrSupZw1KpgCE5GY/9RD70AN03df2rnmjX+gq98XqG+
         1NE2M6ZhJWVh0gmz1v7qWKlZAIKCe2puwl9ZGqdTLZkhDK/BoXakjdFL3+zSUxOxnk5b
         l0+oWV7SVNDksjJco3C7+WtFs0UrEuW6i79kGEs8pUsQxO479qEMWHID6xkQ47EjD2hT
         3+WEC+d1hJEZ4hc6hq5mcMQsjhp5NW7MsP1HbHeEkk21p/QIU0nkofCrHf4VZNRIcw6Q
         IZb1KeKAbnaIXobqkqqKcTZD+ggXc7Gqtpn1/CZqELXWghUYrUXE/BkFpN4mKt2fgR5x
         0a4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310470; x=1728915270;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9YBQOUMUHP+dHvWDzTcw4FOX7H+N4Nuv5wIKgOl7ps=;
        b=oNDOHZgMTDCY68qe9lS71oPSpr3vShG9Wn/1dx1x23IKDtD+O95DJZrIlrNk93pM6s
         l+Bpq44KvVfJlp8WsvdS1Yw51huIFmVn752H4UWtOgzZEUMkd2PKFQwqisJpHUiTzXok
         Xhf7i2TRg049MeuOlMANJSstce5ulNNJg2bJ3hemwv+bWVSPtQ1YYYPs397L0mYzFT2t
         b7fCPCj1lwXx+qORBKbIfS0MlMsNQal9toTKWj+dOoMv/R01KdJq4L61/47F47ogGNaa
         hHH7SKm9HMRS62t/f6DQJcfAwWG1NgqjY9gqBvGJdg0FnEfAVoN1LaBRc4KfsIFW3AmK
         5H8g==
X-Forwarded-Encrypted: i=1; AJvYcCUMUl9l0Z419Ay+f8eA2UhOBqBdK6mPStm4ycc2Nsg6gFYkfCvYc/t89i4uH/QJUSn+MhE69/GNEBFpOvGBRTI=@vger.kernel.org, AJvYcCUwBP56oqerPamDW/zR5tu4BjMK/ko1nA4jN/uAZssXsJwtfSuY2wVOx/ZVF4n4KXqf+vswh8vG@vger.kernel.org, AJvYcCVqDrVSOQroAGcylbYY6aKYNTxz+FOK9CeOfy1y9wdwILf8i9JmJb7X5/AOeIxJ+iLJZbfhehcr5hzeqSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUTaa2rYw5889n31q5zSP3vFTvj1peADPsGRHT0LOsAd7RGEvJ
	vFhtM5GRY18SB+8eIip9wAZuzTS0tvAPX+YrsqcPN9MxmqXh5WwY
X-Google-Smtp-Source: AGHT+IEucuMO3OEw1E+UsIrEHj+pX5JFcAb/J3/w48dDJThpPF1qLjSKd8LFjbW7mNSVoJopQ1nUKw==
X-Received: by 2002:a05:620a:4149:b0:795:5995:fc89 with SMTP id af79cd13be357-7ae6f43a84fmr1649985485a.18.1728310470281;
        Mon, 07 Oct 2024 07:14:30 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae757627fdsm257929785a.100.2024.10.07.07.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 07:14:30 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 82FC9120006B;
	Mon,  7 Oct 2024 10:14:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 07 Oct 2024 10:14:29 -0400
X-ME-Sender: <xms:xewDZzxZFWFLRsMoHsnqNrGUigmi7XgeS2hbdtlh2nVWRhE9SpNaSw>
    <xme:xewDZ7QCiRf63AzFahei1frjab4iyrWZTfRsQ0yXTNaAMBPf1adqAdcDqB7mAcMJH
    BsRMGw78G3WTUsH2Q>
X-ME-Received: <xmr:xewDZ9U2FKuiBMNcs-i_otPr9vMs3nyytsffQ1slE6Jkc_TIzoG9BWCCHD6Tdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfh
    gfehgeekkeeigfdukefhgfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduledpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrd
    gtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepfhhu
    jhhithgrrdhtohhmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtug
    gvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorhdq
    lhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhkhgrlhhlfi
    gvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghh
    rdgvughupdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:xewDZ9giHogl_I4XYK9dbJfrLhVV-MjFx9BdlukHRrmOt3VityVLNQ>
    <xmx:xewDZ1CqhrOvzfI6gy4iE-OrEZb7YqVUoSGwvs0hGS4k2dZ8EOxGNg>
    <xmx:xewDZ2IAAVAznMCuS_ub2voWiII2Sg-1G3RsDbyDiDPz7KwzgMgs-Q>
    <xmx:xewDZ0DHur88HIaX1goTvhYeyMa6-8mLnhr-cOVY8VDCpnAudZS1lQ>
    <xmx:xewDZxwjO6l1TAaDpJMvtCD15bYqV3XOfbm-gL-uQtAAy9PGGbWjN2HD>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 10:14:29 -0400 (EDT)
Date: Mon, 7 Oct 2024 07:13:10 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] rust: Add read_poll_timeout function
Message-ID: <ZwPsdvzxQVsD7wHm@boqun-archlinux>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-6-fujita.tomonori@gmail.com>
 <06cbea6a-d03e-4c89-9c05-4dc51b38738e@lunn.ch>
 <ZwG8H7u3ddYH6gRx@boqun-archlinux>
 <e17c0b80-7518-4487-8278-f0d96fce9d8c@lunn.ch>
 <ZwPT7HZvG1aYONkQ@boqun-archlinux>
 <0555e97b-86aa-44e0-b75b-0a976f73adc0@lunn.ch>
 <CAH5fLgjL9DA7+NFetJGDdi_yW=8YZCYYa_5Ps_bkhBTYwNCgMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjL9DA7+NFetJGDdi_yW=8YZCYYa_5Ps_bkhBTYwNCgMQ@mail.gmail.com>

On Mon, Oct 07, 2024 at 04:08:48PM +0200, Alice Ryhl wrote:
> On Mon, Oct 7, 2024 at 3:48 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Mon, Oct 07, 2024 at 05:28:28AM -0700, Boqun Feng wrote:
> > > On Sun, Oct 06, 2024 at 04:45:21PM +0200, Andrew Lunn wrote:
> > > However, this is actually a special case: currently we want to use klint
> > > [1] to detect all context mis-matches at compile time. So the above rule
> > > extends for kernel: any type-checked *and klint-checked* code that only
> > > calls safe Rust functions cannot be unsafe. I.e. we add additional
> > > compile time checking for unsafe code. So if might_sleep() has the
> > > proper klint annotation, and we actually enable klint for kernel code,
> > > then we can make it safe (along with preemption disable functions being
> > > safe).
> > >
> > > > where you use a sleeping function in atomic context. Depending on why
> > > > you are in atomic context, it might appear to work, until it does not
> > > > actually work, and bad things happen. So it is not might_sleep() which
> > > > is unsafe, it is the Rust code calling it.
> > >
> > > The whole point of unsafe functions is that calling it may result into
> > > unsafe code, so that's why all extern "C" functions are unsafe, so are
> > > might_sleep() (without klint in the picture).
> >
> > There is a psychological part to this. might_sleep() is a good debug
> > tool, which costs very little in normal builds, but finds logic bugs
> > when enabled in debug builds. What we don't want is Rust developers
> > not scattering it though their code because it adds unsafe code, and
> > the aim is not to have any unsafe code.
> 
> We can add a safe wrapper for it:
> 
> pub fn might_sleep() {
>     // SAFETY: Always safe to call.
>     unsafe { bindings::might_sleep() };

It's not always safe to call, because might_sleep() has a
might_resched() and in preempt=voluntary kernel, that's a
cond_resched(), which may eventually call __schedule() and report a
quiescent state of RCU. This could means an unexpected early grace
period, and that means a potential use-afer-free.

Regards,
Boqun

> }
> 
> Alice

