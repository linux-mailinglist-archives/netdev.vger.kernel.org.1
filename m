Return-Path: <netdev+bounces-185018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6471CA983D2
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 10:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B080F3B9145
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 08:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B3827C178;
	Wed, 23 Apr 2025 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6r9JzMD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8812E265CBC;
	Wed, 23 Apr 2025 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745397278; cv=none; b=kqlfD6nXtosf4Z40p0CfciDUNz716q+JettfV18tdrRYerLj2qsQ3XjYH9QsnPYpxNtlzCEV58wizAfBmW9uGSFqWWweiAjbX308tN76LU1Q78rFrFNbFSvk9Gfs5xmVOGuqbXmpW78GUw2B0bKvZnY6IdzPLghFFmGwbdDKpqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745397278; c=relaxed/simple;
	bh=f1x+ftMPRdcn0aPedNNc/tdTLstPKeUh6hNNmacMbwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S8sCp7Yxrxsh1KGG850s2iYI04/T7kmjiVbw72wWlVphKsDJSy8wRPQtF3/GHotZdbig6B8mbVrNGk4KgfCZRBgkd0ZWVNWZp0OaBxoSuJTVlIextfhGXEecJ3VyA0ZlLNjlGk6w+V8as7rVB4836UqmsBh98KgyNsiah1pfkns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6r9JzMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7DDC2BCB7;
	Wed, 23 Apr 2025 08:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745397278;
	bh=f1x+ftMPRdcn0aPedNNc/tdTLstPKeUh6hNNmacMbwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=P6r9JzMDcuKFbO590uKnJZndjTdi9gn91fKrO0tTJx5PhqMnaXz9u/mAD/4Onp7nf
	 WVItAG07msVfJVy6oncR4Z5Dj+FgsiUPJL2D9zjxUWKoCC5nyqffTWthe0zI0mqs0z
	 Ht4D7iObBpIqLlar5g+tQ+68HBGH+qF7+qDgsrMF9hTHKBIsY6scXu2nxdVyY8Fubb
	 IwR/wlbvD/vw2WqrP5BgmjAjcoSDhJnw+9HdeenXOHq/67lCqbBogZxww6YrM3H5Su
	 B6fvu0dPNjIdSAsKQupCquDwrMAHnMvV4U6EJJAoGrfSeA4X3oGRwSCsEX8eB7sxJw
	 4w9aOtk1CpnZw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: boqun.feng@gmail.com,  a.hindborg@samsung.com,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  andrew@lunn.ch,  hkallweit1@gmail.com,
  tmgross@umich.edu,  ojeda@kernel.org,  alex.gaynor@gmail.com,
  gary@garyguo.net,  bjorn3_gh@protonmail.com,  benno.lossin@proton.me,
  aliceryhl@google.com,  anna-maria@linutronix.de,  frederic@kernel.org,
  tglx@linutronix.de,  arnd@arndb.de,  jstultz@google.com,
  sboyd@kernel.org,  mingo@redhat.com,  peterz@infradead.org,
  juri.lelli@redhat.com,  vincent.guittot@linaro.org,
  dietmar.eggemann@arm.com,  rostedt@goodmis.org,  bsegall@google.com,
  mgorman@suse.de,  vschneid@redhat.com,  tgunders@redhat.com,
  me@kloenk.dev,  david.laight.linux@gmail.com
Subject: Re: [PATCH v14 1/6] rust: hrtimer: Add Ktime temporarily
In-Reply-To: <20250422.233132.892973714799206364.fujita.tomonori@gmail.com>
	(FUJITA Tomonori's message of "Tue, 22 Apr 2025 23:31:32 +0900 (JST)")
References: <20250422135336.194579-1-fujita.tomonori@gmail.com>
	<20250422135336.194579-2-fujita.tomonori@gmail.com>
	<aAelbeiWVZgL-kMh@Mac.home>
	<20250422.233132.892973714799206364.fujita.tomonori@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Wed, 23 Apr 2025 10:34:21 +0200
Message-ID: <87wmbbmg36.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

FUJITA Tomonori <fujita.tomonori@gmail.com> writes:

> On Tue, 22 Apr 2025 07:19:25 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
>
>> On Tue, Apr 22, 2025 at 10:53:30PM +0900, FUJITA Tomonori wrote:
>>> Add Ktime temporarily until hrtimer is refactored to use Instant and
>>> Duration types.
>
> s/Duration/Delta/
>
> It would also be better to fix the comment on Ktime in the same way.
>
> Andreas, can you fix them when merging the patch? Or would you prefer
> that I send v15?

Either way is fine for me - you decide.


Best regards,
Andreas Hindborg



