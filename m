Return-Path: <netdev+bounces-160491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B495EA19EB2
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 08:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC063A1987
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 07:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC96420B212;
	Thu, 23 Jan 2025 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIkrjnoX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DC71B87EC;
	Thu, 23 Jan 2025 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737615833; cv=none; b=E9Z66TvDm553Vf1fHjWMLTz73YkdePs8z9cdllKlzd6R6Eurv7UG5V66rnY0ukPEIKMKjxiy+74iAGeLG9dQbd67etpFMsGPwwWKghfaVCIPkm+Aw1A9oCq67fEvocKtYpMl/YDP2Mhf3hmGFDkK/adcCDB6AeL4dKwdE2g1qvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737615833; c=relaxed/simple;
	bh=dCSmYt3BYXY8noSBtMY+kuzEcWjN4gQI9Ygx1/nTjoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seWJ/+o306pP0TV+p21GscKgdxALDOA2HL+C9PqfsFITYTPYbDndXLeZDXfuS/3U+mN5SEDzHJ2kuzXJQ6fbjfZEtdE8PT3plQ/QOb5oGQ7bfSSH868C7lkh4YUTD36aepnOA0TMNoUtZQc2mxvXThFqcidiSUHNCNfAShJn4b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIkrjnoX; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dd15d03eacso6771626d6.0;
        Wed, 22 Jan 2025 23:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737615831; x=1738220631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eFhWe8q3yYTO8W9XmUmaO2q+LFOqy8J1He/iGxFXVI=;
        b=AIkrjnoXWxq/fOtNzV7wdzLIqdux7+aEFYifDo8trz4hMzX0fZXxk2dQ/pRr91mTsH
         JZE40HQ0klFZrNTzHpbsISfNzGdEIjxmV1kItBhR8i4oIBgSWTQ1hjM6CP25feZwNVg7
         rIpFpbRzzY/l3zvQ+ibB8KgGoIuzBTp0jKLdjmqFum9FPv2sLQLBa69mZuVTNkMwnoxn
         VDnjjxEY8q4g0RUa2e++Bml68ZpMEiS/qZtNy42/cPtHELP0WpRgZM1ioU8udPbgKh/n
         S6Z4ciJ9y24Wf35q5aBimGnN7oN/6WlGIiJmun0qWQcVRhuPXt8Ne/RCezS2QL2bnyPM
         /CWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737615831; x=1738220631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+eFhWe8q3yYTO8W9XmUmaO2q+LFOqy8J1He/iGxFXVI=;
        b=qv8JFFCo17NMKYVjI1eNXJ3Rc8kbb9NisQdVps9nSoCqz2u1UnrxdoLQ4vyBvgSiEX
         7MwgEUP0FPPHMioIe5YvaKTvqfYWntknuF5K70o34qwJKeS94z4ihKRJyH49IwdF/nQR
         hzAQLhwK5pw4kmBEYKT9cF2F/PrkGmZ3UF7XKL5hnK/DbmTtB9uNZLTi5Pmf0i4M73PV
         Tl7mjpTbH3V+7qmXnTU2IwcmpBlbmjEN/9dMkxzDzVmq/G54BSD1qg5DhNNk593gt2wR
         CX+QIxSK5fwec5PT2tuveXCSZUhuDLnaU4ya4jJiqydwwag8yyXr1rkNy1BDsCZuGnMi
         tQKA==
X-Forwarded-Encrypted: i=1; AJvYcCVmrzU6NzAjH6Y1o0rFZHa+aumy+whisngJgCBTsITAlqYSODnisawHCGi8iwVPl/m59o3ctl5R@vger.kernel.org, AJvYcCWqh3oGLmDorOb6aJwlqM9GsBKfB/gWHq/6jTEJrPtRwopMJ5NR5zXDVTWTGnmB4+0lCDkoO8QPd1+S3zs=@vger.kernel.org, AJvYcCXWz/Yt0X4fEplQYJNbS16CukczXSj6cBqH8nUogASwf40gulu3MOSmC9r8WvH+z1NNctnjLY8PD4legDc5VkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRf0irnsWLkZlQTRLKeGTYGQIx8/YOhuL5mVG/JfBUhgk2gWBp
	kRF70m0vHRT10QV597bdGOaavlNrWDJS2dIyfnwd5UReyw7C3AJ6
X-Gm-Gg: ASbGncsaUowsTz2R2aiPL+NBfPFKb6gOMDfYX7Jxl8P4cVmNeTbkgp+O9cz1wo2Jn77
	t/jS/NYcf/g5XLscfk0z+Uvh2dogHi9c4UJQcQn7GvpGqN2L+OhPv2ZMSrcDEwbAjdC1M4uwwWC
	nu3vOoVLVlWQpiLWeeeNI4EWrYTOnxwpRcoHtTZ6v225gHjBNm9lKRHzUYfKoy1/IUfW7F0aWfB
	Cvoh22ncjRFC0fzZ3ktN1zDauBnyFNFTWM7vL/4/OfpX3rv4Tw1biHzKPvhw9h2eoAb4pO90mB/
	zvPNLnK0N4uEvUHQ6zhuW/RnLQTYeQdnxVGv31rArJ1A4W1U77L+ouDmEJ7rthtucVzgoYo=
X-Google-Smtp-Source: AGHT+IE9gx3bpSKR3WpK1DTab0MwtlYHqXZbdfWjqI1QfPki0sFoXOikrNRbbF/ukJ0PZC0aNAiZnA==
X-Received: by 2002:ad4:5cc7:0:b0:6d8:99cf:d2d0 with SMTP id 6a1803df08f44-6e1f9fd7877mr31900066d6.19.1737615830853;
        Wed, 22 Jan 2025 23:03:50 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afbf5e2dsm68549156d6.21.2025.01.22.23.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 23:03:50 -0800 (PST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 969A91200068;
	Thu, 23 Jan 2025 02:03:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 23 Jan 2025 02:03:49 -0500
X-ME-Sender: <xms:1emRZ0S77dHiOGEuoYxguydukR1d_RXJSuBGMRZCZZR-7KXTjEM2Tg>
    <xme:1emRZxzwHdtnL9Jq6HtiaCf55rY9DodBRtcwboslVqLNbYEmUCTzBKmAHEcI-0xYL
    KIV52gnIQ8U2M4CHg>
X-ME-Received: <xmr:1emRZx28qMrfr2nHqjLp4ufXTUX4JjGoJuxir0WSQxrijVnF4iPhuLzEXNI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeefuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhujhhithgrrdhtohhmohhnohhrihesgh
    hmrghilhdrtghomhdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehmihhguhgvlhdrohhjvggurgdrshgrnhguohhnihhssehgmhgrih
    hlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephh
    hkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhmghhrohhsshes
    uhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:1emRZ4CSebjF_T8yd6VVQ3ssKN3qr3_TSzbi6Y-XTknIsSissksY2g>
    <xmx:1emRZ9gkpg92GYhib4mg45WUkj_N2_9d6Xf_BqpbZEON7Wi22RzqTA>
    <xmx:1emRZ0pc3rbMWC5wAjEwFJWjfkr4K3eL2t_IFTZWtlJqldV2_iU8DA>
    <xmx:1emRZwhZbVZVPW5pe4J1PON5Qh7O5gnNrejlPnkGZN6vpaU2psOdtw>
    <xmx:1emRZ0TlnBZFGIPB9qSLTwtj2tOSHRUOBCg31OQvQgcQCDUJDe8yiqTs>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jan 2025 02:03:49 -0500 (EST)
Date: Wed, 22 Jan 2025 23:03:24 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: aliceryhl@google.com, miguel.ojeda.sandonis@gmail.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
	jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com
Subject: Re: [PATCH v8 4/7] rust: time: Add wrapper for fsleep function
Message-ID: <Z5HpvAMd6mr-6d9k@boqun-archlinux>
References: <CANiq72kqu7U6CR30T5q=PvRam919eMTXNOfJHKXKJ0Z60U0=uw@mail.gmail.com>
 <20250122.155702.1385101290715452078.fujita.tomonori@gmail.com>
 <CAH5fLghgcJV6gLvPxJVvn8mq4ZN0jGF16L5w-7nDo9TGNAA86w@mail.gmail.com>
 <20250122.194405.1742941306708932313.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122.194405.1742941306708932313.fujita.tomonori@gmail.com>

On Wed, Jan 22, 2025 at 07:44:05PM +0900, FUJITA Tomonori wrote:
> On Wed, 22 Jan 2025 09:23:33 +0100
> Alice Ryhl <aliceryhl@google.com> wrote:
> 
> >> > I would also say "the C side [`fsleep()`] or similar"; in other words,
> >> > both are "kernel's" at this point.
> >>
> >> Agreed that "the C side" is better and updated the comment. I copied
> >> that expression from the existing code; there are many "kernel's" in
> >> rust/kernel/. "good first issues" for them?
> >>
> >> You prefer "[`fsleep()`]" rather than "[`fsleep`]"? I can't find any
> >> precedent for the C side functions.
> > 
> > I think that's a matter of taste. In the Rust ecosystem, fsleep is
> > more common, in the kernel ecosystem, fsleep() is more common. I've
> > seen both in Rust code at this point.
> 
> Understood, I'll go with [`fsleep`].
> 

I would suggest using [`fsleep()`], in the same spirit of this paragraph
in Documentation/process/maintainer-tip.rst:

"""
When a function is mentioned in the changelog, either the text body or the
subject line, please use the format 'function_name()'. Omitting the
brackets after the function name can be ambiguous::

  Subject: subsys/component: Make reservation_count static

  reservation_count is only used in reservation_stats. Make it static.

The variant with brackets is more precise::

  Subject: subsys/component: Make reservation_count() static

  reservation_count() is only called from reservation_stats(). Make it
  static.
"""

, since fsleep() falls into the areas of tip tree.

Regards,
Boqun

[...]

