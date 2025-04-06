Return-Path: <netdev+bounces-179451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E0FA7CC7E
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 03:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F2F3B545B
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 01:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C583595A;
	Sun,  6 Apr 2025 01:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDPbLhHO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075DC3209;
	Sun,  6 Apr 2025 01:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743903894; cv=none; b=lmmxGDZSMYijDfFY3k3PdmKYd/wVzRe/Wg/ZZUh5VON3vBMqk8g4k79M6DS70U+u7uH54g4Sjc4lBPHk5xtSe+LQ5cYCIQt0FpAHImetDbodkP06syzXDmYrwM3gcPZCfkr60/lsCsFp2e74sLIKBBUspnARByTZtZbzUzpLuzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743903894; c=relaxed/simple;
	bh=8RC7QwudAyzPGBGJQN7D8ZucYJPlh3FGVV7toCCmh28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHWEaQrEHmmizmicacgIetK9WRb2AAQDxexn5QBJ750WPxBJBOZSA19tsKcW6QmsV3PaFTFMXTivqqlKWbU1ySUtO/GOglS89lTdK0oG65TQHxWi+JPv8Fm2GSIam8MtEhVtV3in+r97pmMfVxB/NCqNW8N9kIq4Sy+h8nQZAUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDPbLhHO; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ecf0e07947so33115896d6.0;
        Sat, 05 Apr 2025 18:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743903892; x=1744508692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QACGbmtqg43G4pECaXD+iso0W8xk8gg2NY7DQvW93E=;
        b=YDPbLhHOFgSrGHo340dEKuLkyqne7ybqtjGO2Y5qjJ3hzcMBqL3hHiCNB8hiksGFQH
         40scaSXnL7LsZdHN5NS3Ji5MmgSpUelt598DdhOr2Cole5jnF0XG/U3VH2hhd2HlPloU
         hnR9xS1E80COf+8su4L+P3YRU9N2PhXubSHWQbndEjBLnVLXRKIrlv8hd685M3FeEDUr
         e00u1lU2LNG2yutWsZrEaQ+1W56+N7rKumjxMrpHOfFizudNqP+ZlVN817YVKmILsOR/
         aqAUuP8vU3zROQ+PB9ZrYVetO1YFIsZJH4Em7OoEYp5eBbHTB1/TYaym4YaJdG1fnAY3
         WhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743903892; x=1744508692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QACGbmtqg43G4pECaXD+iso0W8xk8gg2NY7DQvW93E=;
        b=wYQXO7+A0fCz/2dGBiuVOXJWq8fnSQd1AwhnmaoVBymEsvU0eyzFGPZlVyZ0RrfA/0
         YsJxDiKm2NlRs6gYZsV5FlKFD3/AE9gqleIvBNJSdC6N+LPDcKWZTgQsEppfm/51/ME2
         d75wxTw6HBUlO5Me9aWWmTUyCJGLRpBC/KtLp7eOJLYgtYYzthoEOMq/UF+VADzwP2Jq
         RYuKj6qJ0fxOiM/Sv+fGHONEuXJ+B+A+bU8IxJGodzXeWl9cvYRZRP7uXG6jfNxfOLgH
         5RbdmzSZ7IBv6yso3LvIoElg0pUhcMzuvO9ph/2yOWoJjhRUJTP4A3WAnw1KTkazGPVR
         QpjA==
X-Forwarded-Encrypted: i=1; AJvYcCVmTWkft8Elxhv83tJmS9C+fVPsWQQ/hqn6NuPq5nlWjr1ewXwVX0RfXa2cSsWrLhu6ZC/o5Kp4WDroeMI=@vger.kernel.org, AJvYcCX9bkPNZGRxwyu4+96cD1jkRcgDDMdzj/ZGYYweKP39mRLrq4GBOk782Xjm4ka0bETmix4CiIT2@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrao0wui7O8QY9/lwO3HM6iHfJbW7m4fYIzwVVfoNU8e6k9fdt
	DAbRWOmWYqPpBBT8NkBb0WQnA1XPWBtGiq4mvnZTeoRujtyUhG64
X-Gm-Gg: ASbGncuYe/fdIXLuxpLToxPZ36IIwtcvHEyag4AahcZ34JZ4QHr2hkgsiLx8scgy3LF
	j1qZlIPxqQ3vRXx0okjaonbHxx3/ZbUZPmYtmRTh9sHQ98kd/kFTcmX4DTk63Vt+YarX3U+elrO
	9HDAvKxLv1xoL1xeNcM7KL7CuyzlkPeuM8rtor3lFlzwpDhOrQBd6/u58NHqvpT3uzTFw7b1rj5
	jNnlOBQMCUUoK5LzpVOawbTASniPJhiPohBJOeNtx8cvcIupg138kV4u46SIBHb5fBgUzGSIhax
	9Z87bthl3y+fDNL6yCTx3VXuoSTmNnATN6ZgvX5S5HWPLGEe77hV4ryJEswxGhI0QatTribAi0V
	kT3oA3csLqm5hgwnkNkNMu32eLuKZrr1i0Jk=
X-Google-Smtp-Source: AGHT+IFfEFeLh+crN4i6bkp1VhALfpSSl6XUzLYqSSbmUR8EbBIu01VtE/Wd2jfQs5cWIZ19w33Vzg==
X-Received: by 2002:a05:6214:dc6:b0:6e6:5b8e:7604 with SMTP id 6a1803df08f44-6eff55136d3mr149062256d6.12.1743903891778;
        Sat, 05 Apr 2025 18:44:51 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f14cf41sm41196026d6.105.2025.04.05.18.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 18:44:51 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5FB2E1200043;
	Sat,  5 Apr 2025 21:44:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 05 Apr 2025 21:44:50 -0400
X-ME-Sender: <xms:ktzxZ24UDty0S3Nw2Qtv3Rpqg4wFnnAdZKy2ALiug-KDBWg_Be-6pg>
    <xme:ktzxZ_6it9nINOF12f3cMSApqRmD3EoYopTeZHIz7sLEOxVFsrRFqNYsGShVBOKv5
    bxQVzO0D2X4k853BA>
X-ME-Received: <xmr:ktzxZ1fyKC08q784YHtAS3qVHbcoqxvmHJ6ZJuDFj9R_FGv_e0vm9jyzm9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleehleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeejteffieehudffvdejtddugeefvdeftdek
    gfegtddutddtkeefleeihfekteefieenucffohhmrghinheprhhushhtqdhfohhrqdhlih
    hnuhigrdgtohhmpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrsh
    honhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghn
    gheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepfe
    efpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfuhhjihhtrgdrthhomhhonhho
    rhhisehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhr
    tghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepth
    hmghhrohhsshesuhhmihgthhdrvgguuhdprhgtphhtthhopehojhgvuggrsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ktzxZzLFQCO4FNOwGmwyrIcbDC6pCQCA_x2LLFsXLjNB0JMxUI4VTg>
    <xmx:ktzxZ6KmGpaGhZGwxCI-B3XymUstD_e5ePOTMyRz5SLUEccCI8NMiA>
    <xmx:ktzxZ0wbTXUXKRImnleC1SFahZ2CYH0urimP3A2QM4SvGgDXsfh3KQ>
    <xmx:ktzxZ-J4CL350Izwtkfbf-EbHQWrSj3UH9SskoSs5yA-2bnsHFzQLA>
    <xmx:ktzxZxZRP4624vTRS2qlLPtTUBJW50ZE22UJBgg2UjbQ29YA2Ryui7V8>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Apr 2025 21:44:49 -0400 (EDT)
Date: Sat, 5 Apr 2025 18:44:35 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev,
	david.laight.linux@gmail.com
Subject: Re: [PATCH v12 5/5] MAINTAINERS: rust: Add a new section for all of
 the time stuff
Message-ID: <Z_Hcg32LhKjqFkVG@boqun-archlinux>
References: <20250406013445.124688-1-fujita.tomonori@gmail.com>
 <20250406013445.124688-6-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406013445.124688-6-fujita.tomonori@gmail.com>

On Sun, Apr 06, 2025 at 10:34:45AM +0900, FUJITA Tomonori wrote:
> Add a new section for all of the time stuff to MAINTAINERS file, with
> the existing hrtimer entry fold.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

> ---
>  MAINTAINERS | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d32ce85c5c66..fafb79c42ac3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10581,20 +10581,23 @@ F:	kernel/time/timer_list.c
>  F:	kernel/time/timer_migration.*
>  F:	tools/testing/selftests/timers/
>  
> -HIGH-RESOLUTION TIMERS [RUST]
> +DELAY, SLEEP, TIMEKEEPING, TIMERS [RUST]
>  M:	Andreas Hindborg <a.hindborg@kernel.org>
>  R:	Boqun Feng <boqun.feng@gmail.com>
> +R:	FUJITA Tomonori <fujita.tomonori@gmail.com>
>  R:	Frederic Weisbecker <frederic@kernel.org>
>  R:	Lyude Paul <lyude@redhat.com>
>  R:	Thomas Gleixner <tglx@linutronix.de>
>  R:	Anna-Maria Behnsen <anna-maria@linutronix.de>
> +R:	John Stultz <jstultz@google.com>
> +R:	Stephen Boyd <sboyd@kernel.org>
>  L:	rust-for-linux@vger.kernel.org
>  S:	Supported
>  W:	https://rust-for-linux.com
>  B:	https://github.com/Rust-for-Linux/linux/issues
> -T:	git https://github.com/Rust-for-Linux/linux.git hrtimer-next
> -F:	rust/kernel/time/hrtimer.rs
> -F:	rust/kernel/time/hrtimer/
> +T:	git https://github.com/Rust-for-Linux/linux.git rust-timekeeping-next

@Andreas, this branch is currently missing, right?

Regards,
Boqun

> +F:	rust/kernel/time/
> +F:	rust/kernel/time/time.rs
>  
>  HIGH-SPEED SCC DRIVER FOR AX.25
>  L:	linux-hams@vger.kernel.org
> -- 
> 2.43.0
> 
> 

