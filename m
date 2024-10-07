Return-Path: <netdev+bounces-132898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD665993AAB
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 01:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB5D1C22926
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 23:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7433B18C333;
	Mon,  7 Oct 2024 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPh7CTTp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F8917DFF7;
	Mon,  7 Oct 2024 23:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728342848; cv=none; b=eKWdMHPR5gkgccGoGv7xZzx/pQ5/ZsTo8WTz/T4axMN4opn6G7nErKhsgOZ8nmffPE9reJouj6GmfoEgxVbKz4w8Kktkd39FxrNVBPztL9bGxki0RvBJt0BR7gyaCIEWFDRnjsqaScGllF4qrEhQZRZIcOe4xRVGzQVxd58sbqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728342848; c=relaxed/simple;
	bh=0AIF3ULaOZP5ywMFjAOjrAHSRlFKos1R1CPdoyvj3jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTGeEvCw8WDZuak4r0ye3bt8n3V+0EpUcpFdetuhtudBofBYBhvC9BgBrRdTmeT4GQ4VZ+ESKHfrozhIQEleNiwUw490M2H1/hv0kxmrH8UcClekfEG+M1T506d5lylrn0Pb2OsuEIsrXkfKIq2I/iBTevBfok52S/EqTMNo92c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPh7CTTp; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7ae6f77f3a0so354090685a.1;
        Mon, 07 Oct 2024 16:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728342846; x=1728947646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJVPy1ShKEKA/LRD1c1fr7tzzJ2Qr9H3SAkL7CrlS9Q=;
        b=bPh7CTTpMJKRah3BYdEpI5l7jUVUfELtqxrDXtqFhEeZNr8O44ZwNPKbLasybGr2zD
         xP/+X4x9RYo/Uo7uMF4CpRSj2aVl1T612fNHFQjFfkifaN9EE1/oW7qJXSlz8NkiC2ZY
         /RSCl5+dempimIXsZdYXIziS5cooRZqCXFyELhpS4PfIaX3keewhU1xpqsOtDjVtxe51
         csCHejjK6c03GXr394P1RUVz4/Kd1QTBIS+tdy2bGq51YutkRE39EJI4EGjh0qVB5krv
         nrnt16IiLltpNRXAHDh2rKpHTQeRN/lHU9rknrWfNtmucEyv2vkNj21WC5cnhZgUAw5+
         k4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728342846; x=1728947646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJVPy1ShKEKA/LRD1c1fr7tzzJ2Qr9H3SAkL7CrlS9Q=;
        b=XsEh3PnEAgcDkP+oOEceUo1GwOgfYtIf4vIflmTlfF/ixOJZiS4AATgTwLdBYJJNwJ
         DSms6U4WDHn8V49dahu3+qNLp94VDMFMzztl9QOH/Rk4p47+B7x+45K2ao92vrrrlwwF
         6P51rzQRP0G3GMDmCGMi7HvY/ZUmXtMRW4HvOD4pVUb8rtVH/XsCK+HHLokk6ZPTA4pl
         OKUSeP5yb2nh4h2tySbArIS4A3U4VKrEMKNg1xSSwLhMGDVsMHwEW+zEFXi/890EidVk
         EkzOswqKiEAZYfZu9/M8/YdF3OX0uvcxOyZ2SPHAUSEuQXZ5dHOOEelSq6H64ri60zby
         eXrw==
X-Forwarded-Encrypted: i=1; AJvYcCVjUN4/8kVtAsNdUR6kXud1aUCBMB6FqHWWTLxkBZHH5BM/+gg0P1I3LpzSSxAyEx/PTFGoOuMUbwb+bZI+IEo=@vger.kernel.org, AJvYcCWkJNMf/pcxoz6PeenQSlAWJidBYz6LVGfjBAEUWCszvYY9UUX5+JGfCI9awYSYPImDmaliBeOi@vger.kernel.org, AJvYcCXyN2M004vGCODl85gtcUhKDj4asGt6ZqWAC34fDtg75k4iMm4LfdfHcwZ9rsM+EVVEVww0m2ikm9y/utg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI/Pm8hmhBOzSnbQWTHBCfl9LOHwf3IDpnJOCUueTlIFrMt58Z
	yJEv80L+tYKsDaciJXUpm0NUkCOllbA37cDhkMqsbL8bJGkIoNC+
X-Google-Smtp-Source: AGHT+IHmqyYpdfvoMjIamOL93vd5f2EVytwWntxMlitBH43vYlwBH2oFB2agTYHQuZWcaPE7L+4Pmw==
X-Received: by 2002:a05:620a:19a2:b0:7a4:d685:caa9 with SMTP id af79cd13be357-7ae6f488699mr2106721685a.48.1728342845676;
        Mon, 07 Oct 2024 16:14:05 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7afc59627eesm2096185a.53.2024.10.07.16.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 16:14:05 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7B3F51200071;
	Mon,  7 Oct 2024 19:14:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 07 Oct 2024 19:14:04 -0400
X-ME-Sender: <xms:PGsEZwLEzswepd5YIxHNRFlgeMh8KQMA-zHsCMQCXXskpWnfv650jQ>
    <xme:PGsEZwJd8a1ISG7fYwtfAASnAhn66mnY7ni6AqMDM7tIJCCjzE5W5dXqj7CwhC6Ht
    5I9Ysts-F74hVQQdA>
X-ME-Received: <xmr:PGsEZwu-jFrC_aoDE90d8_gCUNC1FI7LgECIoI29PbPLoTR4bAYAylFOyl9afQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeftddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtoheprghlihgtvghrhihhlhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepfhhujhhithgrrdhtohhmohhnohhrihesghhmrg
    hilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgt
    phhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughupdhrtghpthhtohepohhjvggurg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:PGsEZ9Y4sgHSHIzPoUVddkhodcZLG_gEHwgDH4kUB4fSaXrRx-9dSQ>
    <xmx:PGsEZ3Y7fg3ALo24zfV-XzZiMbCqt8SvIMTh8S3POz1_4d3ZtrB6fg>
    <xmx:PGsEZ5Dx2c0U_hDglMHw2A7C8jNaNdFtNNsj7y02rF0HLsEMj5LiSg>
    <xmx:PGsEZ9bLMHgvsiG1Za9h2dVJdFDnnt_2F0c0DyttSx0TNtXnzVhEqA>
    <xmx:PGsEZ_ra4Ym8QIYONV-kFQEICIiTEhbgK-ogcEEZYT2xElpqzGhFvwnz>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 19:14:04 -0400 (EDT)
Date: Mon, 7 Oct 2024 16:12:44 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alice Ryhl <aliceryhl@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] rust: Add read_poll_timeout function
Message-ID: <ZwRq7PzAPzCAIBVv@boqun-archlinux>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-6-fujita.tomonori@gmail.com>
 <06cbea6a-d03e-4c89-9c05-4dc51b38738e@lunn.ch>
 <ZwG8H7u3ddYH6gRx@boqun-archlinux>
 <e17c0b80-7518-4487-8278-f0d96fce9d8c@lunn.ch>
 <ZwPT7HZvG1aYONkQ@boqun-archlinux>
 <0555e97b-86aa-44e0-b75b-0a976f73adc0@lunn.ch>
 <CAH5fLgjL9DA7+NFetJGDdi_yW=8YZCYYa_5Ps_bkhBTYwNCgMQ@mail.gmail.com>
 <ZwPsdvzxQVsD7wHm@boqun-archlinux>
 <5368483b-679a-4283-8ce2-f30064d07cad@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5368483b-679a-4283-8ce2-f30064d07cad@lunn.ch>

On Mon, Oct 07, 2024 at 07:13:40PM +0200, Andrew Lunn wrote:
> > > pub fn might_sleep() {
> > >     // SAFETY: Always safe to call.
> > >     unsafe { bindings::might_sleep() };
> > 
> > It's not always safe to call, because might_sleep() has a
> > might_resched() and in preempt=voluntary kernel, that's a
> > cond_resched(), which may eventually call __schedule() and report a
> > quiescent state of RCU. This could means an unexpected early grace
> > period, and that means a potential use-afer-free.
> 
> How does C handle this?
> 
> I'm not an RCU person...
> 
> But if you have called might_sleep() you are about to do something
> which could sleep. If it does sleep, the scheduler is going to be
> called, the grace period has ended, and RCU is going to do its
> thing. If that results in a use-after-free, your code is
> broken. might_sleep makes no difference here, the code is still
> broken, it just happens to light the fuse for the explosion a bit
> earlier.
> 

Because of the might_resched() in might_sleep(), it will report the
quiescent state of the current CPU, and RCU will pass a grace period if
all CPUs have passed a quiescent state. So for example if someone writes
the following:

    <reader>			<updater>
    rcu_read_lock();
    p = rcu_dereference(gp);
    might_sleep():
      might_resched():
				todo = gp;
				rcu_assign_pointer(gp, NULL);
				synchronize_rcu();

        rcu_all_qs(); // report a quiescent state inside RCU read-side
	              // critical section, which may make a grace period
		      // pass even there is an active RCU reader

				kfree(todo);

    a = READ_ONCE(p->a); // UAF
    rcu_read_unlock();

We probably call the reader side code a "wrong annotation", however,
it's still unsafe code because of the UAF. Also you seems to assume that
might_sleep() is always attached to a sleepable function, which is not
an invalid assumption, but we couldn't use it for reasoning the
safe/unsafe property of Rust functions unless we can encode this in the
type system. For Rust code, without klint rule, might_sleep() needs to
be unsafe. So we have two options for might_sleep().

* Since we rely on klint for atomic context detection, we can mark the
  trivial wrapper (as what Alice presented in the other email) as safe,
  but we need to begin to add klint annotation for that function, unless
  Gary finds a smart way to auto-annotate functions.

* Instead of might_sleep(), we provide the wrapper of __might_sleep(),
  since it doesn't have might_resched() in it, it should be safe. And
  all we care about here is the debugging rather than voluntary context
  switch. (Besides I think preempt=volunatry is eventually going to be
  gone because of PREEMPT_AUTO [1], if that happens I think the
  might_resched() might be dropped entirely).

Does this make sense?

[1]: https://lore.kernel.org/lkml/20240528003521.979836-1-ankur.a.arora@oracle.com/

Regards,
Boqun

> Or, i'm missing something, not being an RCU person.
> 
> 	Andrew

