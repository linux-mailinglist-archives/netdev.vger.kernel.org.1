Return-Path: <netdev+bounces-179360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF83A7C1A7
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 18:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46AB175E1B
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E7420CCDB;
	Fri,  4 Apr 2025 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D00Qoscq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FCE27702;
	Fri,  4 Apr 2025 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743784822; cv=none; b=O4jf5M1IRTzOPe6xts+t52cNkKAlHMsbLtG3x3QhgznK4LLSjiB3ZYiyyknD++BYCCOAY7GHK9A4SNkfqLFt7sCisFM+OsmxYqz3X+VIK3SXicjCk+G9SC9sybw0g8V6xevfYtpTwk/2j1b4jUvSQGv8NcQqx8p9qBrUK3HCE9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743784822; c=relaxed/simple;
	bh=NliqGKQBavmQ/UAIAWusnksO/6ItanviREC+SdQ4Go8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYQizyF9ARuDDGBh8oB+a7iG5zvaXWi83Mh0TU28Xf7DqjzABh39ToslxvMaak1RFX350u3v2DPT964YzqfC10+dKk1r6JRPq65bU2tHRSwbQyMWaMQ78pXcMaxx4zC+VmyTDtHf5TisTjFG0Q+gZJtpHlCISIASRlJVFiSU1tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D00Qoscq; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8f8657f29so17794096d6.3;
        Fri, 04 Apr 2025 09:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743784819; x=1744389619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6n9DYF24dQ6uMZmwgty1y+VxRnz9JV9/BeuY5w4KpoY=;
        b=D00QoscqB4tv2Uf10SsPmYV5HM3Y4rQnMajOx8bi2slOsr4sukJzW3zYTTnDcYTL93
         iGs5okTL3e3gx6GeASZ/ADVoub/GBX8W5nht4T4uabEwt4KA6ISvcj04TZjWNOFgRKcx
         hVqxtkqlgHixaRb40DcMeYyEtHcYK8NCc6ODkYxN4Nc3S6EiHqvosqrZv31JbkG4Mt7J
         1EqvCGsdKcarZT8xJd4Yug7TZBhVJf8rJcF/R2tbVUndkqzhlgz8ugZ40yKAd/sf7TOc
         FsU6da05iRxc1x8JpA5K37kQbof2jOMRGmu2/jFfO4Q8UX6N9pa1JKeBVZvBy3/ZWMiy
         u+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743784819; x=1744389619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6n9DYF24dQ6uMZmwgty1y+VxRnz9JV9/BeuY5w4KpoY=;
        b=LUiXkVJ2Tp/3kaYMDkcF0sZYGDI7fgjrnyo6JujxAECHqsDytobxzlJeUNWoKyIzPt
         6rhI7s1lxSmllsXWvOdcuUDrchFIg3knDDkmKTV7MljnIvHsYH8meEjTJVRCqpYU+9VB
         48dp0JZxmEHMURfQuSVoUSMqwtO8JHMPFNnO/24Gmts/0Pl1m9DrLtNEtaDLxwOKUB6H
         egkoZoDNnMuk0ewqJUkTEQ5162h+7VRBBO4TQ9czlTHr+kBmNUd9pzopQ59+6BkP+uMq
         DVoEY4X2eCeQzov+p5K5W141CR6y/GJHXK2+/bYHg+5f1mpS1tYatNxiHFca14vrOWAv
         +Oyg==
X-Forwarded-Encrypted: i=1; AJvYcCUW/8zmF0+19PjyZovvcYev/AQ//bKU3VDor+gyvIiQZi9tHscrPTdGtTz0PZfHmjm3yQWot5yF@vger.kernel.org, AJvYcCVJ1lgHX8kfMqkqFzjU/y9MeeFG62J1h+r+yMmWKIbeU2oFwr77nHMcAAsGgPCSUc+u+pErGFbvpeJNuTYt71k=@vger.kernel.org, AJvYcCWMtV7jFKslReXidZgUxeeGE4tLT687l3okH3O8RVBupcstezhyOX/39hRuOrZtDg0qCbYWjLd23Xm49Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtiEVeUZU/HsNJoznYgeZhgbr7BtRaOnolP/VHWXN/YuoZWzT9
	utddwIbakgnjd4/tm+ppazhW3ltq08Ex3prxwtGVe8gfQ4JyJ11F
X-Gm-Gg: ASbGncu789ydKxyxYNrAaEBUIqLgwUVa3CSiCdjnDE77dXdHd0beKE3Yspk9lNSGlOx
	s6ONWFqd495jL998quzV9MYEhh3L0wqnKAv8bmDXyY8j6H0/hkHDBULI2fEAgk92Idcqz/LswqB
	jgFaqUjVC/SyFh1BYbcEReHElGig0+/VgJUWgeNJKfVpyDcq0lHYY3lw46JBQOoHXFaA2hlfWKi
	C2EBVcCfM/cW800MFVY/4rAD8NDapDb+eQ+DOTFOrrCTRypH36mXN5BQRhG2CINqDnFspkgRDr1
	CDF/LpzJz8hIWNhGoJZ9IN4xQVyN/Jtyju/HSXpE2qRFv861HkwSAAdNBzt7D4yK/khNeeVuCH3
	te5KumBm25DaclvBJBaRHgqhWm22NRTqdqcw=
X-Google-Smtp-Source: AGHT+IEOvKwJBp6J4+qpH0k5xktEEnNscPYWCzCN1PUWX48juY0yS7t3z19gndIog8r5yNGM/UsoDQ==
X-Received: by 2002:a05:6214:d63:b0:6e8:f6d2:e074 with SMTP id 6a1803df08f44-6f01e7aad09mr67340936d6.28.1743784818708;
        Fri, 04 Apr 2025 09:40:18 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0efc12besm23495456d6.16.2025.04.04.09.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 09:40:18 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1EF34120007C;
	Fri,  4 Apr 2025 12:40:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 04 Apr 2025 12:40:17 -0400
X-ME-Sender: <xms:cQvwZ87LTyCuZJkuQeRmsvxMlLGeiY1c0nWzN3xAxVhvtM9R0uRTSg>
    <xme:cQvwZ9728kAnWKobnl0P9LrQio2VljoMLr8du4wNRonXO4N7qj0TptcfSebUPGASe
    ocFCjLqLAIzCOVLWw>
X-ME-Received: <xmr:cQvwZ7foRgGIIzaC6ZSYsCHG5bw-boxjAz5HMI0n7m_b6sbxsr7bcvAEcuo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleduleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepfeegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehfuhhjihhtrgdrthhomhhonhhorhhise
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesgh
    hmrghilhdrtghomhdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:cQvwZxLs3L9k4yddAiGi-NXW7qFyw-N4lCdO__DOGIxjvvFDyZdu2Q>
    <xmx:cQvwZwJ0BKYZZEq_UcgXJ7MG82KxpH_oKF5XJSEilVrK0lthK8lj5w>
    <xmx:cQvwZyzN3d7fj5gZQBIm6wBf78WPhAyRWsUNjDo_LfTqkuTYlF-eIQ>
    <xmx:cQvwZ0J18-m6tYEvXk8AoHB7CGG8b74Amo2P9RY3hKgSgd0fkliWSQ>
    <xmx:cQvwZ_YFi7WzDwEHOMkKJgyIJrrG6CPMWH2O8L1NszZxTwL3L1yPpOMn>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Apr 2025 12:40:16 -0400 (EDT)
Date: Fri, 4 Apr 2025 09:40:06 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: a.hindborg@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	anna-maria@linutronix.de, frederic@kernel.org, arnd@arndb.de,
	jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev,
	david.laight.linux@gmail.com
Subject: Re: [PATCH v11 6/8] MAINTAINERS: rust: Add new sections for
 DELAY/SLEEP and TIMEKEEPING API
Message-ID: <Z_ALZsnwN53ZPBrB@boqun-archlinux>
References: <RK_ErPB4YECyHEkLg8UNaclPYHIV40KuRFSNkYGroL8uT39vud-G3iRgR2a7c11Sb7mXgU6oeb_pukIeTOk9sQ==@protonmail.internalid>
 <20250403.171809.1101736852312477056.fujita.tomonori@gmail.com>
 <877c41v7kf.fsf@kernel.org>
 <20250403.215745.2138534529135480572.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403.215745.2138534529135480572.fujita.tomonori@gmail.com>

On Thu, Apr 03, 2025 at 09:57:45PM +0900, FUJITA Tomonori wrote:
> On Thu, 03 Apr 2025 12:54:40 +0200
> Andreas Hindborg <a.hindborg@kernel.org> wrote:
> 
> >>>> You will need to fix something because patch 2-6 removes `Ktime` ;-)
> >>>
> >>> Yea, but `Instant` is almost a direct substitution, right? Anyway, Tomo
> >>> can send a new spin and change all the uses of Ktime, or I can do it. It
> >>> should be straight forward. Either way is fine with me.
> >>
> >> `Delta`? Not `Instant`.
> > 
> > It depends. Current hrtimer takes `Ktime` and supports
> > `HrTimerMode::Absolute` and `HrTimerMode::Relative`. With `Delta` and
> > `Instant` we should take `Instant` for `HrTimerMode::Absolute` and
> > `Delta` for `HrTimerMode::Relative`. The API needs to be modified a bit
> > to make that work though. Probably we need to make the start function
> > generic over the expiration type or something.
> > 

If we make `HrTimerMode` a trait:

    pub trait HrTimerMode {
        type Expires; /* either Delta or Instant */
    }

and `HrTimerPointer` generic over `HrTimerMode`:

    pub trait HrTimerPointer<Mode: HrTimerMode> {
        fn start(self, expires: Mode::Expires) -> HrTimerHandler<Mode>
    }

then we can disallow that a Relative timer accidentally uses an Instant
or an Absolute timer accidentally uses an Delta. Of course a few other
places need to be generic, but the end result looks pretty good to me.

Regards,
Boqun

> > If you want to, you can fix that. If not, you can use `Instant` for the
> > relative case as well, and we shall interpret it as duration. Then I
> > will fix it up later. Your decision.
> > 
> >> All Ktime in hrtimer are passed to hrtimer_start_range_ns(), right?
> > 
> > Yes, that is where they end up.
> 
> Ah, I found that __hrtimer_start_range_ns() handles ktime_t
> differently in HRTIMER_MODE_REL mode.
> 
> As you said, looks like the API needs to be updated and I think that
> it's best to leave that to you. I'll just use `Instant` for all cases.
> 
> 

