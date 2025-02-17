Return-Path: <netdev+bounces-167007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBA8A384F8
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C643A851D
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A8521CA0E;
	Mon, 17 Feb 2025 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nT6bAF9+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA56A21A44D;
	Mon, 17 Feb 2025 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799587; cv=none; b=sV6wk6U2vk65ka15H/6MiKqVsHqNhf6BX9Y468yapBZh0yvM6XPFVeOckeOk3Z8iYtOmC/+vIjVPZQ0x3ruDamID/egAkZ6Z/Lf5fr7zJU/VJ0VF9IHy9vsO9Qpgd1duB4Fg7IW1GBy9puxuXnpc9j/sjmaK9/1Jtjv1n7P+gnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799587; c=relaxed/simple;
	bh=3tet+bNClnYznOPy0FtmvKL+eOAqldSfcdXv8GyJpIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+3wUdx3OCSVA5cUuw288uqngYijHYj5uPn8d1+NsIQZ70azWBho6AshTb2FuCYsyQg6kEiZKaetVPp7KMnBKH4a30lgR2P/0p/QrNOFnU4PGy1DxS4cCzI7KJPiFANrupV50sAxMFyF0d9MPX4LORXU7jY4+iNh2UISu/DhEz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nT6bAF9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D28AC4CED1;
	Mon, 17 Feb 2025 13:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739799587;
	bh=3tet+bNClnYznOPy0FtmvKL+eOAqldSfcdXv8GyJpIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nT6bAF9+c8lOKdOOyHWLXjR9cwYCAqXugmR2F9fLh+kw+4OWzDU4qBcTu1kL3zynV
	 hC5qv026/frON/Idc0Lul0lJUgiMXGt0Cdv3DrNJhGQW0/9wvKtyxv3cu7Io/Fqj97
	 FfXnJprpgHZfFOQxdtG0gW0aVAnIelHLlsEJOncGUTHD/TlxcW19C8+y01tG93ILel
	 clWh31SHQ1FFjv4unowr8YJuEW9LyUOybvLX6I+1EbuopTD+wb7IONWfP1qysSzXAD
	 scmrtGZJyb6+efRrU5Is/OcAnPOAGkufGZ6W3EReZMHdpSI5ph94/QTU96qmYmdGP9
	 UirzHYPU1iSdg==
Date: Mon, 17 Feb 2025 14:39:44 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: anna-maria@linutronix.de, tglx@linutronix.de, jstultz@google.com,
	sboyd@kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, arnd@arndb.de,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev
Subject: Re: [PATCH v10 6/8] MAINTAINERS: rust: Add TIMEKEEPING and TIMER
 abstractions
Message-ID: <Z7M8IDI_caXqBvMp@localhost.localdomain>
References: <20250207132623.168854-1-fujita.tomonori@gmail.com>
 <20250207132623.168854-7-fujita.tomonori@gmail.com>
 <20250217.091008.1729482605084144345.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250217.091008.1729482605084144345.fujita.tomonori@gmail.com>

Le Mon, Feb 17, 2025 at 09:10:08AM +0900, FUJITA Tomonori a écrit :
> On Fri,  7 Feb 2025 22:26:21 +0900
> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
> 
> > Add Rust TIMEKEEPING and TIMER abstractions to the maintainers entry
> > respectively.
> > 
> > Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > ---
> >  MAINTAINERS | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c8d9e8187eb0..987a25550853 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10353,6 +10353,7 @@ F:	kernel/time/sleep_timeout.c
> >  F:	kernel/time/timer.c
> >  F:	kernel/time/timer_list.c
> >  F:	kernel/time/timer_migration.*
> > +F:	rust/kernel/time/delay.rs
> >  F:	tools/testing/selftests/timers/
> >  
> >  HIGH-SPEED SCC DRIVER FOR AX.25
> > @@ -23852,6 +23853,7 @@ F:	kernel/time/timeconv.c
> >  F:	kernel/time/timecounter.c
> >  F:	kernel/time/timekeeping*
> >  F:	kernel/time/time_test.c
> > +F:	rust/kernel/time.rs
> >  F:	tools/testing/selftests/timers/
> 
> TIMERS and TIMEKEEPING maintainers,
> 
> You would prefer to add rust files to a separate entry for Rust? Or
> you prefer a different option?

It's probably a better idea to keep those rust entries to their own sections.
This code will be better handled into your more capable hands.

Thanks.

