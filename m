Return-Path: <netdev+bounces-179635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 795A4A7DE98
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 15:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42FF16EA70
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE53125290E;
	Mon,  7 Apr 2025 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/yiDtbP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37F22356D4;
	Mon,  7 Apr 2025 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031518; cv=none; b=Sx/1fz7sjrToir2Kxmq4Lr+4YjpDTmb3OpqlU2NuJuUxw9RLJ54tcSQ6ndRztBuC/9E6kczZCBsYw0gB0sATiVtorbBzK3+Q+68dZ/xOltMfjk5p2C7gEZC/Mghu9QKCcGXwaJD7j5Sn4AngjjXppJzU+CBMINviU80ed1HjMog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031518; c=relaxed/simple;
	bh=9RTE6GZFHtGCxccvwtzxwrgeH86aK7UcCNbpZ1d3o2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C0xi9Q1GE9ynWX65JfVEoEl6a32+QAsaOhfcJxZD130aIsdNuZuCfOCglNPxvy4yVO4GuRrTTE5DBwRygV39TiUvoO8s/pko2EhU4tEOGyTrueY9Fmd6HCLW1eYM48bbY4hErkzwbK+ovPak1CZ1zzPr31nfb36kLyp5DZ8fql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/yiDtbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD75C4CEE7;
	Mon,  7 Apr 2025 13:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744031517;
	bh=9RTE6GZFHtGCxccvwtzxwrgeH86aK7UcCNbpZ1d3o2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=A/yiDtbPopNu2zs1c2ynBpjI20TjuAIXeM3WvFq08r2EdCLHlisMvAJJTZur9LFq5
	 Nfse6o7IODzaetg6vVPa5qarj6qenz+xX7zkqdOEtB/W0L1zz3CDQ40SRiYhL8FiyW
	 O4OXw6zBP4XfG0wTKrClQBws9JUtL//XSxjIZBHRK81c/6qzYvmJRCIjdC0/sjztAG
	 ZOGVyJne768UflKZVZI9FSxD+EoVC2bjc15aXW0KZwTjMgWY5D7rynFMLb+kH7d4R8
	 SLV90h4mg+xgSroSfe24S4GV/LPrjHiPjeOztUV1bia4+ZoQk4pcOAOt+xtN6PFUIM
	 ACshBt/r6/Ktg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  andrew@lunn.ch,  hkallweit1@gmail.com,
  tmgross@umich.edu,  ojeda@kernel.org,  alex.gaynor@gmail.com,
  gary@garyguo.net,  bjorn3_gh@protonmail.com,  benno.lossin@proton.me,
  a.hindborg@samsung.com,  aliceryhl@google.com,  anna-maria@linutronix.de,
  frederic@kernel.org,  tglx@linutronix.de,  arnd@arndb.de,
  jstultz@google.com,  sboyd@kernel.org,  mingo@redhat.com,
  peterz@infradead.org,  juri.lelli@redhat.com,
  vincent.guittot@linaro.org,  dietmar.eggemann@arm.com,
  rostedt@goodmis.org,  bsegall@google.com,  mgorman@suse.de,
  vschneid@redhat.com,  tgunders@redhat.com,  me@kloenk.dev,
  david.laight.linux@gmail.com
Subject: Re: [PATCH v12 5/5] MAINTAINERS: rust: Add a new section for all of
 the time stuff
In-Reply-To: <20250406013445.124688-6-fujita.tomonori@gmail.com> (FUJITA
	Tomonori's message of "Sun, 6 Apr 2025 10:34:45 +0900")
References: <20250406013445.124688-1-fujita.tomonori@gmail.com>
	<20250406013445.124688-6-fujita.tomonori@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 07 Apr 2025 15:11:40 +0200
Message-ID: <871pu4jeur.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

FUJITA Tomonori <fujita.tomonori@gmail.com> writes:

> Add a new section for all of the time stuff to MAINTAINERS file, with
> the existing hrtimer entry fold.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
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
> +F:	rust/kernel/time/
> +F:	rust/kernel/time/time.rs
>  
>  HIGH-SPEED SCC DRIVER FOR AX.25
>  L:	linux-hams@vger.kernel.org


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



