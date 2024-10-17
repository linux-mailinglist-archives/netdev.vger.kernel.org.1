Return-Path: <netdev+bounces-136744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6419A2D71
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 21:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AC7E1F25D21
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7450F21D2B0;
	Thu, 17 Oct 2024 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpgFGlIO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20E71E0DC3;
	Thu, 17 Oct 2024 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192280; cv=none; b=ZHXjPkPAXCqT8i4O4E3fdovrOwDDeZyFNQFKfQMG9y/jTBON6WuN43HH9Fbe/ea26SqQPRq79Rc3m6xuaaBQ8EGZtj6TG4cVKCWhiFC8s025lwc45dG9QSVqY+pqc2PPsIBWyXMrFkDJgL0wWAxP/TvRLsLb3TXY1cPo5MtKqLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192280; c=relaxed/simple;
	bh=i0LCj33sTv80PVv1n+RWXeecCDYIyQk8xOI/PyH5KAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOfDgGELJLtgBl72538QOOwDgSEKr9CL04xMsUei48wt3uREooZUiT+0H6R+Ah8AtNWSRT8Uu8EyGJuisgGz94EUxAGPSSnAy++M5xWHaie2i4PzYfZjnejMoJxhUUrXvCVm04EIJCZeRQJGrMXbPQrmRqWTrq6bXF5QnSUKLjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpgFGlIO; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7180c7a4e02so763031a34.0;
        Thu, 17 Oct 2024 12:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729192278; x=1729797078; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0vdDCOsRi+VEULt5VWZ7IdYOYXmxgnEut9AuBf1wioY=;
        b=WpgFGlIOCWOmA9a1mYr++0vIKIOZrBPYIPX6WmUUR4EWvbUMgEBtEI4PCjUbUO7NNU
         T4eAdOjLMq6qCMz40hxZJ1Ziz1RLVXbxoGVLAsvD6wLCu/y06jTEn8ZwJQzLXpqLfOCE
         gQawO5EsaxyH4ID+cYuMoQZ1WQ5vf0/N5uExNqrTTgITWo5l6VR0hVsbG1rVCewLTcO2
         eqoTNxuS52+g7GDIwB+ngYvHKtG96MdjPTwZcXgcnqup6/X/iCWF3fxxlaVeyRkxlsbS
         a17GokAiaMAaPUQjRs/jYgBpnFvpYxkBrdHu5CgIgaV/5b0HXKLdgIKX7BRM3S3ngE9U
         7Fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729192278; x=1729797078;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0vdDCOsRi+VEULt5VWZ7IdYOYXmxgnEut9AuBf1wioY=;
        b=niBayN2RgJAbxFOlkBdzyTbmp58kB6iSDEnb7Ckmt0fN0dJ2mvrT9jUNn0yYksSfuC
         Rfkpri+t6oFEuQOU5ke0CKTjmHDbBA2Kzt4p3MNjUvRbaNe4CLCZ6YSj8PCRHDtbqYQw
         HRhcIlZT66MGWzOlVJ0i+41oyOJxoUPJc/zC10xEfDqBa3v9mCznjCSPpeU+ZiY7K/ZP
         BQVavudIsuu7MHSc+/fgtVsdAWPa/M72bnwnazsIPGNYvvD2YG6LgKz1J1ULb5Sh4Xgm
         Vw3Prm7hFYGJAFMXzaLIE2uJQqolpMDtaMkx4/4yIt1hmTcSpIjBqDygZmQPk6K/b4ey
         ahDw==
X-Forwarded-Encrypted: i=1; AJvYcCWAa0hvCxR6kBIwWQhHf52Nxhok9HOhQnvaqyER1MyEOaOEaE5cwKzjG8NaKbe+7nidNtOuWbtC0BAr+AETuPU=@vger.kernel.org, AJvYcCXPVrdFpWeVoFrf7myQapAxeex8rRFIr1WoByCD0xACnk4AnUcVzWg3p08Ju+TRRDSOCPd9t4RU@vger.kernel.org, AJvYcCXSCZ2LgqPzzDG1Acx/dHHel0MvRTGRZxRIFnP4DdQw2lBBEjKSNF9ye83Y8InkUOF2Ceo81xvqIC99Wc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxDZoREih1E9jI7ljleT4K3EOwh8jCTwR9i0OpWVOzDgu4EOLu
	z2HTg/Kc1Qwt0dLe8u5P6dSS8o3xYbbPKvrj9lYx2QtCpKlVAt2c
X-Google-Smtp-Source: AGHT+IFBdLNqy949zDHUStXk4qwoTIFrnoaGhDbhGXYo1lTaHPLsWGUsNk3U3i2g35PzdkHo1fADaw==
X-Received: by 2002:a05:6359:4ca5:b0:1c3:9552:6f46 with SMTP id e5c5f4694b2df-1c395527994mr193031955d.15.1729192277703;
        Thu, 17 Oct 2024 12:11:17 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2292e964sm30631486d6.59.2024.10.17.12.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 12:11:17 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8402B1200043;
	Thu, 17 Oct 2024 15:02:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 17 Oct 2024 15:02:34 -0400
X-ME-Sender: <xms:Sl8RZ23ynvKruSP1V-wk9XfKI_RiLWgYMmg30lb0ZtjCRYVxZ7i9bQ>
    <xme:Sl8RZ5FC7WVdYZl62k0OcPPMTSVXo4Y5RU-Sz1nMyASFq2ADNggKYTQ7Y5upCwpYs
    t_bndMkdO-EoH8KOA>
X-ME-Received: <xmr:Sl8RZ-7136LdopFH2Eo7w-HbbvgCFWI0NiDBGzgdMYmBvhvgjhfWmDhetbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehuddgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledt
    hffgheegkeekiefgudekhffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehmihhguhgvlhdrohhjvggurgdrshgrnh
    guohhnihhssehgmhgrihhlrdgtohhmpdhrtghpthhtohepfhhujhhithgrrdhtohhmohhn
    ohhrihesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprh
    gtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopeht
    mhhgrhhoshhssehumhhitghhrdgvughupdhrtghpthhtohepohhjvggurgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Sl8RZ332mvADykkOvEEfIOz1yTashpuRiTRmdE2zOKhLWuECsjk2yA>
    <xmx:Sl8RZ5EF74jzcQZPxPNAAF0zEkj0ORt0fYqLcpC12NmgnG8Sg85w-w>
    <xmx:Sl8RZw9BWG1IB-G70dB259LAvIydkgKjG7oLmr_kXQETIHN5lvCifg>
    <xmx:Sl8RZ-m-eEcp4Bu9E2usrYyj07becHmFoouGljhouZo2KFcsvM7hrw>
    <xmx:Sl8RZxFsa_96GuPo_MWsWxx96783vhyK0lvNeSRr_TNidcz4mEYHFa_g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 15:02:33 -0400 (EDT)
Date: Thu, 17 Oct 2024 12:02:07 -0700
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
Message-ID: <ZxFfLyXiDqOva5jN@boqun-archlinux>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-5-fujita.tomonori@gmail.com>
 <ZxAZ36EUKapnp-Fk@Boquns-Mac-mini.local>
 <20241017.183141.1257175603297746364.fujita.tomonori@gmail.com>
 <CANiq72mbWVVCA_EjV_7DtMYHH_RF9P9Br=sRdyLtPFkythST1w@mail.gmail.com>
 <ZxFDWRIrgkuneX7_@boqun-archlinux>
 <CANiq72kAL8OWCerpXYOeJDcHZNdT+QRj6Vw3YUBYiQG+hgYcVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kAL8OWCerpXYOeJDcHZNdT+QRj6Vw3YUBYiQG+hgYcVA@mail.gmail.com>

On Thu, Oct 17, 2024 at 08:10:17PM +0200, Miguel Ojeda wrote:
> On Thu, Oct 17, 2024 at 7:03 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > The point I tried to make is that `+` operator of Ktime can cause
> > overflow because of *user inputs*, unlike the `-` operator of Ktime,
> > which cannot cause overflow as long as Ktime is implemented correctly
> > (as a timestamp). Because the overflow possiblity is exposed to users,
> > then we need to 1) document it and 2) provide saturating_add() (maybe
> > also checked_add() and overflowing_add()) so that users won't need to do
> > the saturating themselves:
> 
> Generally, operators are expected to possibly wrap/panic, so that
> would be fine, no?
> 

Yes, but I guess I need to make it clear: the current `+` operator
implemention is fine for me. What I'm trying to say is: since we have a
`+` that expects users to not provide inputs that causes overflow, then
it makes sense to provide a saturating_add() at the same time for the
API completeness.

> It may be surprising to `ktime_t` users, and that is bad. It is one
> more reason to avoid using the same name for the type, too.
> 
> My only concern is that people may expect this sort of thing (timing
> related) to "usually/just work" and not expect panics. That is bad,
> but if we remain consistent, it may be best to pay the cost now. In
> other words, when someone sees an operator, it is saying it is never
> supposed to wrap, and that is easy to remember. Perhaps some types
> could avoid providing the operators if it is too dangerous to use
> them.
> 

Sounds reasonable to me.

> The other option is be inconsistent in our use of operators, and
> instead give operators the "best" semantics for each type. That can
> definitely provide better ergonomics in some cases, but there is a
> high risk of forgetting what each operator does for each type --
> operator overloading can be quite risky.
> 

Agreed.

> So that is why I think it may be best/easier to generally say "we
> don't do operator overloading in general unless the operator really
> behaves like a core one", especially early on.
> 
> >         kt = kt.saturating_add(d);
> 
> Yeah, that is what we want (I may be missing something in your argument though).
> 
> > but one thing I'm not sure is since it looks like saturating to
> > KTIME_SEC_MAX is the current C choice, if we want to do the same, should
> > we use the name `add_safe()` instead of `saturating_add()`? FWIW, it
> > seems harmless to saturate at KTIME_MAX to me. So personally, I like
> > what Alice suggested.
> 
> Do you mean it would be confusing to not saturate to the highest the
> lower/inner level type can hold?
> 

Yes.

> I mean, nothing says we need to saturate to the highest -- we could
> have a type invariant. (One more reason to avoid the same name).
> 
> Worst case, we can have two saturating methods, or two types, if really needed.
> 
> Thomas can probably tell us what are the most important use cases
> needed, and whether it is a good opportunity to clean/redesign this in
> Rust differently.
> 

Works for me!

Regards,
Boqun

> Cheers,
> Miguel

