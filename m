Return-Path: <netdev+bounces-132428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CCE991B32
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 00:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEAC71F220ED
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 22:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31110158861;
	Sat,  5 Oct 2024 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deIiRLU+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A479F38DFC;
	Sat,  5 Oct 2024 22:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728167021; cv=none; b=Fa/NZPxrykM0Jd3Cr/grvArUdPh4xndvwNVYglklFkKA+n5BcK+rkEhfYsI3AitIJjz2w9FW+OzEqDhDUsbvW9bzoIAHHFiescsuNVjn65arEkzBj3paP9OOU2GkuNu4iS1M5CEcLD26fitv+yvr1KW5VuTQMO/HiIDCXfl6cxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728167021; c=relaxed/simple;
	bh=CDvMvKR5NsUghTucs0NBnB58VWXxSpQWiGJa60PhaJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BX8WYIEyeXPdmQ+l29z5gDg5xijodwdyWDxpGPafwCeP21IKQ7SKmGnWBAJ9tioQVDksYiMcmvu1wEWfwEf3svg0b2lHbcnYKojsP7M+viUtwRpSbc22hzvarpUsB9HFYdyYaVn4rcnB+51Jnmyc60UZqCTHZmNwLj33Ptmnqwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deIiRLU+; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cb3cbc28deso32754476d6.3;
        Sat, 05 Oct 2024 15:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728167018; x=1728771818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGEe+NY0fZ7idRHJ0JNrhCo327we1HY1LNfPxzR5fWM=;
        b=deIiRLU+4b06M4BX3f3WlN/UmGUKW0XiTs3o+WAwmPRB0/DyUuxYcQBtXG0jDFptRi
         HyE2qOnwtdjtqGvrnGQ8icc5ZleUprbetutQ9vIeheWLYTCDmPS8BZtyf+ixFT1Br0tv
         ERY9Pa12aghj9JoBibOVIyXSVjCEsS2uCDrIbRZ6R7YG/ylVINS/jy+eY2WNCatEcKSE
         DqX11R1qDTPC+as4ixm3vYnQCTCj9KCy/XiSaSJGF6rorZy4IqqUncXis0TgNoRjFoeS
         fsxwdHOLY1XLnCZEV7SfLSCXebID3pfvsQEdOmVOcZSTlGup/1/wkA7WEYqyq1KRMELz
         h5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728167018; x=1728771818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGEe+NY0fZ7idRHJ0JNrhCo327we1HY1LNfPxzR5fWM=;
        b=vqcWTNtu8yF56FeJCeVOkYG7+uyWRVR/EHAkjc6zxyyf11A+O/cVv64GKEw5tmX14S
         CxPv7T28QgYrVjtw8YJBrPdqR6SoFY7sN3gkr3bUL6IWS3IzZydki2BE1esDkcF6ssnH
         BNpdbhVYd2/D/ZbbkNm/ARh3/xBvwHKJfvVjetzFaVYE907VJW453AlCyorlT4VwVhra
         EYQxQU7aIZedsLATMGwn2Of2bJXyLF7RaHgp5QacXNZhLT+nQ8KM5Mn4hLxc9chNWLuQ
         F+S4q4BBVbmTkZMsbW8k5xIB0LMJYXhq25HXGXof2k95fehZ5hBM99WdCNiyls7mw0ax
         JPAg==
X-Forwarded-Encrypted: i=1; AJvYcCUHoqhWKvnR14t/secYNcNyehcXpSHO5Prx0Cow3/v5d7YKYgfBkb26VTVPJptJSXdrsSacvHCay+5OQ8A=@vger.kernel.org, AJvYcCVFvr8gsjdE8Cr2Z1KQjn9b3tnhBjgH/s0onBfBfiFBju0cNa1LvVYG7G77JYlFDb4+w9Cy2WjxtOiy1kFwvWQ=@vger.kernel.org, AJvYcCVrjPIprkHj12iRZbngiuhgjSvWgqXTQBJTaHKpwuoMOVaWDc6dbjXD82mv8f4Nt4veW9fdKuuw@vger.kernel.org
X-Gm-Message-State: AOJu0YxtgfE8os/sx6b7Ei+wdds8m3yBI3hshotbeMv/1B0aH/deHuCg
	j7u2Hy96YSxNrT/bDt3bpWswrrRh3FN2pKigIfhBV2hYhE707Igs
X-Google-Smtp-Source: AGHT+IHXqzcftAv6HNxk9EWOvJ3PsD03Y3I8+jeVWm2EtHfv5hdgWZbBXlnwjHk2Wi/sSmvCLlV1Yw==
X-Received: by 2002:a05:6214:3ca1:b0:6c7:c650:90dc with SMTP id 6a1803df08f44-6cb9a466299mr113243116d6.34.1728167018406;
        Sat, 05 Oct 2024 15:23:38 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba47535a2sm11826496d6.77.2024.10.05.15.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 15:23:38 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 582721200068;
	Sat,  5 Oct 2024 18:23:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 05 Oct 2024 18:23:37 -0400
X-ME-Sender: <xms:abwBZxfhv0rF4XN7f_JUER2SMObmqaWp3-lYJXgC8bAHFcPTsnHAOA>
    <xme:abwBZ_OcF_MNXhQuRNADZ1ChJioa6VbUeaSfovNu5fowFJuL9ZSKRqQoZ1A_jyyGc
    4tpd2lEYgiCHaF8oA>
X-ME-Received: <xmr:abwBZ6h9dBmA3fFMujYhekFHK10_UsIE4fsMuPiUtrznWPKmJ3ZER6P3mnqc1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddviedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeejiefhtdeuvdegvddtudffgfegfeehgfdtiedv
    veevleevhfekhefftdekieehvdenucffohhmrghinheprhhushhtqdhlrghnghdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhq
    uhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqud
    ejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgv
    rdhnrghmvgdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehfuhhjihhtrgdrthho
    mhhonhhorhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhkrghllhifvghithdusehgmh
    grihhlrdgtohhmpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuhdprhgt
    phhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrgh
    grhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhho
    rdhnvght
X-ME-Proxy: <xmx:abwBZ6_cQUvWNYW-3gWznvHBbHf44X9Qo35imeVmsxqUpjnM-S5ftQ>
    <xmx:abwBZ9v056bWfnPXc861yaJUXMm2r5WCDeJfPb-nxOILqY3dqqhPUg>
    <xmx:abwBZ5GfipvItzhcyTp3Ofyh8I3A5yIpFqYdD0uBfKr2jPTZzzVAhg>
    <xmx:abwBZ0PIqw8nlV-g64PUpA3FMu9DjYd_ri52Wtmbr-chJZ0GK8xufA>
    <xmx:abwBZ2NDhcIjzyiT9Xf2wUYR_Jsing4BiLuvboNmsqZfWnZzwODWLoua>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Oct 2024 18:23:36 -0400 (EDT)
Date: Sat, 5 Oct 2024 15:22:23 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] rust: Add read_poll_timeout function
Message-ID: <ZwG8H7u3ddYH6gRx@boqun-archlinux>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-6-fujita.tomonori@gmail.com>
 <06cbea6a-d03e-4c89-9c05-4dc51b38738e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06cbea6a-d03e-4c89-9c05-4dc51b38738e@lunn.ch>

On Sat, Oct 05, 2024 at 08:32:01PM +0200, Andrew Lunn wrote:
> > might_sleep() is called via a wrapper so the __FILE__ and __LINE__
> > debug info with CONFIG_DEBUG_ATOMIC_SLEEP enabled isn't what we
> > expect; the wrapper instead of the caller.
> 
> So not very useful. All we know is that somewhere in Rust something is
> sleeping in atomic context. Is it possible to do better? Does __FILE__
> and __LINE__ exist in Rust?
> 

Sure, you can use: 

	https://doc.rust-lang.org/core/macro.line.html

> > +    if sleep {
> > +        // SAFETY: FFI call.
> > +        unsafe { bindings::might_sleep() }
> > +    }
> 
> What is actually unsafe about might_sleep()? It is a void foo(void)

Every extern "C" function is by default unsafe, because C doesn't have
the concept of safe/unsafe. If you want to avoid unsafe, you could
introduce a Rust's might_sleep() which calls into
`bindings::might_sleep()`:

	pub fn might_sleep() {
	    // SAFETY: ??
	    unsafe { bindings::might_sleep() }
	}

however, if you call a might_sleep() in a preemption disabled context
when CONFIG_DEBUG_ATOMIC_SLEEP=n and PREEMPT=VOLUNTERY, it could means
an unexpected RCU quiescent state, which results an early RCU grace
period, and that may mean a use-after-free. So it's not that safe as you
may expected.

Regards,
Boqun

> function, so takes no parameters, returns no results. It cannot affect
> anything which Rust is managing.
> 
> > +        // SAFETY: FFI call.
> > +        unsafe { bindings::cpu_relax() }
> 
> Same here.
> 
> 	Andrew
> 

