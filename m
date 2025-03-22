Return-Path: <netdev+bounces-176868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47246A6CA30
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 13:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF9317E728
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 12:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519BC21D3DC;
	Sat, 22 Mar 2025 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVgeE528"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A924204689;
	Sat, 22 Mar 2025 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742648249; cv=none; b=Q618vDTXfQ+otJSS/WjLEwnAUPhOWgdzSEGNtOEpKfYpqibnJqTRnc8uDhS4UFvHkBWl6F9lEMa5njVx4N/wy+oxhMW6IkuP+SPFjdsVbXa5KJiVrsPfx0uu4hvi6ywDM9SW8iIlZXxAs6izK7C8p0Sbx1FViqeH9pBlHfnWsNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742648249; c=relaxed/simple;
	bh=zBv3GiXxCSrILOpo+hN/N6jm0KQzj9CRX0mJr0ntr74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWvCX5Cnpsz/Cu/KWir1QwLCisgMZ/PPNZPObz6o2WxL+4lVTy1VW0xK/e5z5O9Coe2DZ3akYYEYiWuy06V6UvPVsz4884uRiycNH0KZ6+Nz186eP/2LI83rGao2uq1yxp0GhUn8tpUg9dwI7XK2kCnTLlpQqm3CFVbdpdKosuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVgeE528; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e8f94c2698so15037556d6.0;
        Sat, 22 Mar 2025 05:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742648246; x=1743253046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LO5yWJDnTKmH5byFruuki997nS964zCMJ3bX0Tw9G4E=;
        b=OVgeE528Pf7NiCI1G2ZoWGkMNnuY4eox3TO3LSJRkOo4ZkQ80iCZQATJOW5eDiKYgB
         Cq+ac1tSJ8XQWwUWnrnvUtFf4cRXFV7RqLOdPPGmy13ou4jvHRtCDwH+6OfGL/skh0Et
         zY8G0NCKyiQe6two7av+a8+VIYA8HwWUrXfOle7mtPZtsyJ3OmaH7ac2c6d9mRhQRgSW
         V1wmCD4mPoK+QHukQJp3/MFodJQyZi+dckrvwq46zG2pc3DIw7XnddiBYgb98Q7WL4OA
         /gR7O0EqVYJS7GnsjJMkWKfEu0/zoMksmeIDAz9pvgwq+e94VNYAFqnEYvUaMqpS28YY
         FwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742648246; x=1743253046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LO5yWJDnTKmH5byFruuki997nS964zCMJ3bX0Tw9G4E=;
        b=ooIRIHpbvKqxAU258i4NXNUylpIG7y+PDn/RIlrbDKeSrV/qerAe+K0DTsp2mrbElh
         odZp760vziQQZ171MBbzTqrqZTErwzXBV8XAkt/Q9ejxx2pdtE9Du5Q64+4zvWodqsFT
         deL4/m37Xkbscy2CvkH+Mq3Lo/Vvr9ihWhq027RbR7K3kPy19VTFpwraTyxgEsoecZ59
         X+Th6cdBJRWzZYeUl5hKQNI19HqC+mQB+KOLhaJbUt3peET4+QbUUYTShVxpdYqLw1Y+
         P3gtlC7ofnLIimTK/ep6THEWQa0VtmXv5EvJCYavv90I0EGONKh83vrFxxovUQsud77+
         z/7g==
X-Forwarded-Encrypted: i=1; AJvYcCUCN/E/lecwzkDMPkTgMDQMqldnQsccIv3klIm33PjfIg37O4qYiqsUi8LetMfne/U238F2x2dq3zE9hAw=@vger.kernel.org, AJvYcCUff5aSfl1ldZkimSRzNAIcno5peGzR20ZaqwERfm09GeoJmZXXAWwPcOnuDXnj7NwJGhFSeczk@vger.kernel.org, AJvYcCWA99vbUqnb3Tt0DtIc7VHd/94W9S7NA6BjVXR+91fhG8ZvbnE/KPuRPiS56erZQ+PtciKYGjAJnL8h3GH/oto=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDJdoN87M3iKMxkOnV8JisddJIfzurboMH09yKnXfuDm1zgcnK
	c3qEdDR11SlC9DZGshWCTXsXR8s/LAOK7Snd4P3e77SsoYCl0d7b
X-Gm-Gg: ASbGncuQH4cXZRS5Ws4RJJ6aHkyYCYfX57O+Lf8Yv6rzrw4V1fkYmTSN9n6LSAhaU3l
	g2vwRw1iaoqxe0tbAWSU5OBu9mBT2p3Xuc8h25JOCkqYySXb3nnVaVnBMJAYldIkErtvYxoibpP
	F3YJOH3fE9Jg1u+MhUzO9Zj/dAGi7I1LTt80KpYaILafZEtZtIv9oT+2MCAO1Jf3JG2zsx1Jh9h
	FCm1zfoe0A2ACm9LQcj84F5ULNicy9GD7VYSor6h4QT+aw1fzd8GAUXYNp+ikx57rHTWDfdVadE
	VdotxV717sWkmH9KhUxLITx94px4ZKLbOshsbbeyegdbm6gVXZoJ1RYRriBU2uWIagmdSRz/QVo
	llSaYJ+Z3VeE8hsx7hZ9NfUfXYHbzGzToqro=
X-Google-Smtp-Source: AGHT+IFDvaDNHIXNfc+HBIazWgv0eiT6rQM1AvCdqMnFU4gJguGS1JJT8BU2GYV2GoJmgYLQWoPc/Q==
X-Received: by 2002:ad4:5cc3:0:b0:6e4:442c:288b with SMTP id 6a1803df08f44-6eb3f2862b7mr81745756d6.11.1742648245876;
        Sat, 22 Mar 2025 05:57:25 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efda764sm21866246d6.114.2025.03.22.05.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 05:57:25 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6B45B1200043;
	Sat, 22 Mar 2025 08:57:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sat, 22 Mar 2025 08:57:24 -0400
X-ME-Sender: <xms:tLPeZ1wh4r06an2cgDId3tB4eJenya7B31TCmsqk2o9X1rtqp-uA3Q>
    <xme:tLPeZ1T4BtQDMi4GLzMmVVAv3TC0mefCuIyxrUv4dFASPZLQA3hZwxG4USMTm927f
    kkAg7z81rfB-hv6Xw>
X-ME-Received: <xmr:tLPeZ_WL40b-WgsVg6C4xZO5QI-GJCVCiCo0BVjJi3i1SGMnbloxNWZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheegtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeffleejleehveelteeltedugffhhedvkefg
    vdehfeeiffeihfeigfdvtdeuhfdtteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpd
    hgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepfeegpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehfuhhjihhtrgdrthhomhhonhhorhhisehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpth
    htoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruh
    hsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurh
    gvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdr
    tghomhdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:tLPeZ3ghYF-_-AIKV0wAYTDYVuJOUrS2NjN2Ey2eDOHZU5QywYcheQ>
    <xmx:tLPeZ3DU4yDIph8JJL5jnnCik9SyKR4aVFFt4vGuG0MR8ysyFr0yRA>
    <xmx:tLPeZwKwBCpl0GzRUQnWNzg7X1uqtQHgXmUbM-ta3fR1AHmmsqiVqQ>
    <xmx:tLPeZ2BOlopalkAN7bCvLA54ggBSSEBTw662RnSMGwXjDuhNc90TMA>
    <xmx:tLPeZ7xrmpXZ2q-OO0O9HjrLjtX0jfFjAkXYCb59ousydkAGosvzNGo9>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Mar 2025 08:57:23 -0400 (EDT)
Date: Sat, 22 Mar 2025 05:57:22 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: tglx@linutronix.de, a.hindborg@kernel.org, linux-kernel@vger.kernel.org,
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
Message-ID: <Z96zstZIiPsP4mSF@Mac.home>
References: <87jz8ichv5.fsf@kernel.org>
 <87o6xu15m1.ffs@tglx>
 <67ddd387.050a0220.3229ca.921c@mx.google.com>
 <20250322.110703.1794086613370193338.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322.110703.1794086613370193338.fujita.tomonori@gmail.com>

On Sat, Mar 22, 2025 at 11:07:03AM +0900, FUJITA Tomonori wrote:
> Thank you all!
> 
> On Fri, 21 Mar 2025 14:00:52 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > On Fri, Mar 21, 2025 at 09:38:46PM +0100, Thomas Gleixner wrote:
> >> On Fri, Mar 21 2025 at 20:18, Andreas Hindborg wrote:
> >> >> Could you add me as a reviewer in these entries?
> >> >>
> >> >
> >> > I would like to be added as well.
> >> 
> >> Please add the relevant core code maintainers (Anna-Maria, Frederic,
> >> John Stultz and myself) as well to the reviewers list, so that this does
> >> not end up with changes going in opposite directions.
> >> 
> > 
> > Make sense, I assume you want this to go via rust then (althought we
> > would like it to go via your tree if possible ;-))?
> 

Given Andreas is already preparing the pull request of the hrtimer
abstraction to Miguel, and delay, timekeeping and hrtimer are related,
these timekeeping/delay patches should go via Andreas (i.e.
rust/hrtimer-next into rust/rust-next) if Thomas and Miguel are OK with
it. Works for you, Andreas? If so...

> Once the following review regarding fsleep() is complete, I will submit
> patches #2 through #6 as v12 for rust-next:
> 
> https://lore.kernel.org/linux-kernel/20250322.102449.895174336060649075.fujita.tomonori@gmail.com/
> 
> The updated MAINTAINERS file will look like the following.
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cbf84690c495..858e0b34422f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10370,6 +10370,18 @@ F:	kernel/time/timer_list.c
>  F:	kernel/time/timer_migration.*
>  F:	tools/testing/selftests/timers/
>  
> +DELAY AND SLEEP API [RUST]
> +M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
> +R:	Boqun Feng <boqun.feng@gmail.com>
> +R:	Andreas Hindborg <a.hindborg@kernel.org>

... this "R:" entry would be "M:",

> +R:	Anna-Maria Behnsen <anna-maria@linutronix.de>
> +R:	Frederic Weisbecker <frederic@kernel.org>
> +R:	Thomas Gleixner <tglx@linutronix.de>
> +L:	rust-for-linux@vger.kernel.org
> +L:	linux-kernel@vger.kernel.org

+T:	git https://github.com/Rust-for-Linux/linux.git hrtimer-next

> +S:	Maintained

I will let Andreas decide whether this is a "Supported" entry ;-)

> +F:	rust/kernel/time/delay.rs
> +
>  HIGH-SPEED SCC DRIVER FOR AX.25
>  L:	linux-hams@vger.kernel.org
>  S:	Orphan
> @@ -23944,6 +23956,17 @@ F:	kernel/time/timekeeping*
>  F:	kernel/time/time_test.c
>  F:	tools/testing/selftests/timers/
>  
> +TIMEKEEPING API [RUST]

and similar things for this entry as well.

> +M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
> +R:	Boqun Feng <boqun.feng@gmail.com>
> +R:	Andreas Hindborg <a.hindborg@kernel.org>
> +R:	John Stultz <jstultz@google.com>
> +R:	Thomas Gleixner <tglx@linutronix.de>

+R:      Stephen Boyd <sboyd@kernel.org>

?

> +L:	rust-for-linux@vger.kernel.org
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	rust/kernel/time.rs
> +

Tomo, let's wait for Andreas' rely and decide how to change these
entries. Thanks!

Regards,
Boqun

>  TIPC NETWORK LAYER
>  M:	Jon Maloy <jmaloy@redhat.com>
>  L:	netdev@vger.kernel.org (core kernel code)

