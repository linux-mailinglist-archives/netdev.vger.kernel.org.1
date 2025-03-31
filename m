Return-Path: <netdev+bounces-178302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 342D9A76755
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D7116891B
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC614213E66;
	Mon, 31 Mar 2025 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVJ2J1mm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6B22135CE;
	Mon, 31 Mar 2025 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743429802; cv=none; b=SzK80erkfS3sx0jr0bIWvjcC+L2JehLqwybp6L+7AModsYTjK7RmmfQ2Wy5WsUrpASkUdRqX79ZTQNWyOqcUcbKhyDG3u0xIFZ3gr1gJ108kOSunRgi82GW1h9iMbAYMXl8QkxioIidtS5LBC0UyN4uIVyJJP6MGb7Rh4I7WqV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743429802; c=relaxed/simple;
	bh=Vad6Bngms7LR/SnVaW/fBqPRddI72xsArTDQuo7o+yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+jEFnnQAw/LZkVJ9Ul0rE0tg59QDOwPcFLlon5lk1uiEjCqU9B7quqhbNI5Q19eLZw6paixVM42S68R9ZdU+UtOlsxeM+z8rW8160NCiEJOiZIcSfmTBXptF382YVQ8HtfCe/kGT1HyxdJjCQMEFS32MRiDsZ3d/O/7JPGMxug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVJ2J1mm; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6eb16dfa988so42503506d6.2;
        Mon, 31 Mar 2025 07:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743429800; x=1744034600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeVIRckOKHplZvokKLugkVq4VXYBWlOKbJnfEv8Is8M=;
        b=dVJ2J1mmT0DYRMyn2es8D8OfsV7cxTutTknMZCMoqIHvkY7lFeejQ9z5D00+LldRbT
         7vg6SVaEC+D29AHT2h02B0Xhbz/pPV/vhpYsIzGmwAvjhE6SeFGbhwaBOltG/13QIiqd
         UACVbNO0apCCPdgOyC2v9kSFICjLUDPu8Dk0PgULgMFiISLjA7IVJXJWyUd+pxrzHjyY
         8MoGEN/J7onHyxEtW9SaOn2vipjpHFUSjDZF8PtRIf0/+m3EUvJcBg2gSfBivBXWTACG
         Oa17JKSGhT6yif+4PpHHKaC6MMleiuWsEQMLQAiSAwUuipwtLpJXejaRD8rTbZBaSrRF
         ufTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743429800; x=1744034600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WeVIRckOKHplZvokKLugkVq4VXYBWlOKbJnfEv8Is8M=;
        b=PXDBNVx60eATMdbvLfMoIff9JfwW1AEBKbNf4WZY8TpoIEWAb4LUTKw1Prdot3ayFi
         VszoSniDL+5uMPO/gaPW1sEtaT89Wow2km3rgL5XwnZtL9Zkl9ht0KQ7FfkvFNTA7Jk+
         6nofpbuvEWqNEy79il4LaMVqaTxdWZzPeLJxqcZ5RlY3Zt0HO7nzuJcmXHolbL+m/i0A
         CJILQ1TuXiyjVkW+1KZkb0gKBpgrfDDzc1inOOextQmm7xRo+IA0Gz5/kjs8V43MF/+0
         zcWZdGCcxpzLQvr79bVl3FElBp2xQj7hTrfFAv48CR3W6A/jf0WJQamf0rTXPDhzrLMW
         Jj6w==
X-Forwarded-Encrypted: i=1; AJvYcCW3KDKTMQIedlJuCrh5wxpWeDnx1/B6cy+CgD5Ov5lcZUvizHykAXcdmPreMV0nq51/S/cw9rXRibMXoc0=@vger.kernel.org, AJvYcCWTLctxCTUsnzmm1bjWjw0dCBouYVbDgToAxU2kUhyLLPE+UuCrvaXH6Dm9YuZPVEHzhdnqWuHCCHYlBzauMwc=@vger.kernel.org, AJvYcCX/NWh+Zp70TMYhoWBIDEpS5HMwfdMMmcz+ehyt5GgbDXv2639is2Z2XZQO5RRAzhRpiRoFZJX/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9DL+Pakp9CVyRRgAsUK6ihnJnC0actne0heSfJ8gX/KYofZso
	gbMwKbgi0ifZKlMWCoBEKIbE3oE2DEGAXnse7/mrrNchamDvc8yX
X-Gm-Gg: ASbGncu3QR9nhzQKoLEHcVMY++OA+t/59jXmDjnaSlLr7vYe9r0HGQTsDA/0U8ZTRo6
	DGlrhsjl3YWNZTG03QxK9ZrFidjFFtwkaAPr1OjuYe7ilYNKURAezw5HZ3+ZrmFidvkpClNK/QT
	cp2roAL2Uy/wktl5nZdZkjLJHawoXQceYOO8T6ndmNf8SBLhI6jGe4YKmI/4FNeak6kXpxh8jwT
	S/Uxav13nrgL8t6peXwx8CnMBoG5RLDYp2dLVXXukBzSZ7cYJLLN2rRPqHEAQXH46u4geyacG3C
	9BYsZnr2WKMsKrweDu5q4JV8e8DKRMJ/exkAKccbzwgpS5E33YhQuturi5nRaYX2Fp5RweAcH+s
	5OEp2BEWdm91kWr4odQueDCAC8bA5mAYr1S8=
X-Google-Smtp-Source: AGHT+IEDlEMGN6Y4UOiJurFexdK8lqE3yLdBlGqLJ0B32vylkCFGY21A6PxaVo7GzxXzrVRSyGSlLQ==
X-Received: by 2002:a05:6214:408:b0:6eb:28e4:8516 with SMTP id 6a1803df08f44-6eed6210e02mr137625586d6.33.1743429799321;
        Mon, 31 Mar 2025 07:03:19 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec9771b63sm46984486d6.85.2025.03.31.07.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 07:03:18 -0700 (PDT)
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfauth.phl.internal (Postfix) with ESMTP id B4DB0120007C;
	Mon, 31 Mar 2025 10:03:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Mon, 31 Mar 2025 10:03:17 -0400
X-ME-Sender: <xms:paDqZ1WmUHDn8KYoEyGyxluVxQOfPkMCMs3Bwv748hxXqB7sBX9nXA>
    <xme:paDqZ1lMGZy-468fiwH6f-JvSFBNbNYuDHo9ukcKu1lfK6tdRjb7lXWXBFOgawPIq
    _XBQvVWBASFnwM03w>
X-ME-Received: <xmr:paDqZxbQybjNBvaaNM90eHs_3vYXJzU1EmGSZHXyfzmCQyNStkpMEAg0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeelhfehhfelhefgvddtheejleejledvleel
    geffleelkeeutdeikeevffffteefheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpd
    hgihhthhhusgdrtghomhdprhhushhtqdhfohhrqdhlihhnuhigrdgtohhmpdduiedrhiho
    uhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepfeegpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfh
    hujhhithgrrdhtohhmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtthhopehtghhl
    gieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhi
    nhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgt
    hhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtth
    hopehtmhhgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:paDqZ4XJDCyVDshfxzc6AUdnSEei20UIM9yvC2HQ6wxIEhRn1ODQdg>
    <xmx:paDqZ_kPX5ekefWznYk7mrrWDjkLEB13wbiJ3Jq4QXpUXdZshbqHcQ>
    <xmx:paDqZ1cfRgSUUUfw61jTfxxHP6E5yd4nNsGIU85C1uxumcOQcxkQOA>
    <xmx:paDqZ5ET1ZrRzDoM6YZaYKsfEqwskSmWR3JL2p4JJn7tAquiklIrGw>
    <xmx:paDqZ5lnqixO2fHtluENiEMSxVpZotDtw6ObuFX26eY94tVoq128AfzE>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 10:03:16 -0400 (EDT)
Date: Mon, 31 Mar 2025 07:03:15 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
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
Message-ID: <Z-qgo5gl6Qly-Wur@Mac.home>
References: <87jz8ichv5.fsf@kernel.org>
 <87o6xu15m1.ffs@tglx>
 <67ddd387.050a0220.3229ca.921c@mx.google.com>
 <20250322.110703.1794086613370193338.fujita.tomonori@gmail.com>
 <8n9Iwb8Z00ljHvj7jIWUybn9zwN_JLhLSWrljBKG9RE7qQx4MTMqUkTJeVeBZtexynIlqH1Lgt6g0ofLLwnoyQ==@protonmail.internalid>
 <Z96zstZIiPsP4mSF@Mac.home>
 <871puoelnj.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871puoelnj.fsf@kernel.org>

On Sat, Mar 22, 2025 at 11:40:21PM +0100, Andreas Hindborg wrote:
> Hi All,
> 
> "Boqun Feng" <boqun.feng@gmail.com> writes:
> 
> > On Sat, Mar 22, 2025 at 11:07:03AM +0900, FUJITA Tomonori wrote:
> >> Thank you all!
> >>
> >> On Fri, 21 Mar 2025 14:00:52 -0700
> >> Boqun Feng <boqun.feng@gmail.com> wrote:
> >>
> >> > On Fri, Mar 21, 2025 at 09:38:46PM +0100, Thomas Gleixner wrote:
> >> >> On Fri, Mar 21 2025 at 20:18, Andreas Hindborg wrote:
> >> >> >> Could you add me as a reviewer in these entries?
> >> >> >>
> >> >> >
> >> >> > I would like to be added as well.
> >> >>
> >> >> Please add the relevant core code maintainers (Anna-Maria, Frederic,
> >> >> John Stultz and myself) as well to the reviewers list, so that this does
> >> >> not end up with changes going in opposite directions.
> >> >>
> >> >
> >> > Make sense, I assume you want this to go via rust then (althought we
> >> > would like it to go via your tree if possible ;-))?
> >>
> >
> > Given Andreas is already preparing the pull request of the hrtimer
> > abstraction to Miguel, and delay, timekeeping and hrtimer are related,
> > these timekeeping/delay patches should go via Andreas (i.e.
> > rust/hrtimer-next into rust/rust-next) if Thomas and Miguel are OK with
> > it. Works for you, Andreas? If so...
> >
> >> Once the following review regarding fsleep() is complete, I will submit
> >> patches #2 through #6 as v12 for rust-next:
> >>
> >> https://lore.kernel.org/linux-kernel/20250322.102449.895174336060649075.fujita.tomonori@gmail.com/
> >>
> >> The updated MAINTAINERS file will look like the following.
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index cbf84690c495..858e0b34422f 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -10370,6 +10370,18 @@ F:	kernel/time/timer_list.c
> >>  F:	kernel/time/timer_migration.*
> >>  F:	tools/testing/selftests/timers/
> >>
> >> +DELAY AND SLEEP API [RUST]
> >> +M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
> >> +R:	Boqun Feng <boqun.feng@gmail.com>
> >> +R:	Andreas Hindborg <a.hindborg@kernel.org>
> >
> > ... this "R:" entry would be "M:",
> >
> >> +R:	Anna-Maria Behnsen <anna-maria@linutronix.de>
> >> +R:	Frederic Weisbecker <frederic@kernel.org>
> >> +R:	Thomas Gleixner <tglx@linutronix.de>
> >> +L:	rust-for-linux@vger.kernel.org
> >> +L:	linux-kernel@vger.kernel.org
> >
> > +T:	git https://github.com/Rust-for-Linux/linux.git hrtimer-next
> >
> >> +S:	Maintained
> >
> > I will let Andreas decide whether this is a "Supported" entry ;-)
> >
> >> +F:	rust/kernel/time/delay.rs
> >> +
> >>  HIGH-SPEED SCC DRIVER FOR AX.25
> >>  L:	linux-hams@vger.kernel.org
> >>  S:	Orphan
> >> @@ -23944,6 +23956,17 @@ F:	kernel/time/timekeeping*
> >>  F:	kernel/time/time_test.c
> >>  F:	tools/testing/selftests/timers/
> >>
> >> +TIMEKEEPING API [RUST]
> >
> > and similar things for this entry as well.
> >
> >> +M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
> >> +R:	Boqun Feng <boqun.feng@gmail.com>
> >> +R:	Andreas Hindborg <a.hindborg@kernel.org>
> >> +R:	John Stultz <jstultz@google.com>
> >> +R:	Thomas Gleixner <tglx@linutronix.de>
> >
> > +R:      Stephen Boyd <sboyd@kernel.org>
> >
> > ?
> >
> >> +L:	rust-for-linux@vger.kernel.org
> >> +L:	linux-kernel@vger.kernel.org
> >> +S:	Maintained
> >> +F:	rust/kernel/time.rs
> >> +
> >
> > Tomo, let's wait for Andreas' rely and decide how to change these
> > entries. Thanks!
> 
> My recommendation would be to take all of `rust/kernel/time` under one
> entry for now. I suggest the following, folding in the hrtimer entry as
> well:
> 
> DELAY, SLEEP, TIMEKEEPING, TIMERS [RUST]
> M:	Andreas Hindborg <a.hindborg@kernel.org>

Given you're the one who would handle the patches, I think this make
more sense.

> R:	Boqun Feng <boqun.feng@gmail.com>
> R:	FUJITA Tomonori <fujita.tomonori@gmail.com>

Tomo, does this look good to you?

> R:	Lyude Paul <lyude@redhat.com>
> R:	Frederic Weisbecker <frederic@kernel.org>
> R:	Thomas Gleixner <tglx@linutronix.de>
> R:	Anna-Maria Behnsen <anna-maria@linutronix.de>
> R:	John Stultz <jstultz@google.com>

We should add:

R:      Stephen Boyd <sboyd@kernel.org>

If Stephen is not against it.

> L:	rust-for-linux@vger.kernel.org
> S:	Supported
> W:	https://rust-for-linux.com
> B:	https://github.com/Rust-for-Linux/linux/issues
> T:	git https://github.com/Rust-for-Linux/linux.git rust-timekeeping-next
> F:	rust/kernel/time.rs
> F:	rust/kernel/time/
> 
> If that is acceptable to everyone, it is very likely that I can pick 2-6
> for v6.16.
> 

You will need to fix something because patch 2-6 removes `Ktime` ;-)

> I assume patch 1 will go through the sched/core tree, and then Miguel
> can pick 7.
> 

Patch 1 & 7 probably should go together, but we can decide it later.

Regards,
Boqun

> Best regards,
> Andreas Hindborg
> 
> 
> 

