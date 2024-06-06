Return-Path: <netdev+bounces-101287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32938FE056
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 09:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D22D286490
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 07:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD6113C663;
	Thu,  6 Jun 2024 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qG7OKZtk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/vlEsE7K"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337981327E5;
	Thu,  6 Jun 2024 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660756; cv=none; b=C/9PAeD6Bhl3whbLNdMogXfwXn4raHwe1Qernv0+XRdxPMqKfNxsgrY0Clj5cw4hxq9n8LL5CmfNnXAkWBZtIZ81sjnC6Xvg7wIxcS06g4Z8jcprbrGCRZCKrJAo0NK5ja6gmgnz+qVfra7Tf8d4YQhsxEnJ2Jwt4BJgQkvl59w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660756; c=relaxed/simple;
	bh=ATccA5r9ES5LDi1RDOSSs0f1rgaAZyIufvadcuOLeFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUusVI166KnElkTJOzF/Bg80ZWMDUP7O2UqmTmcK8w8Z3tAyHSD8v9zWWGIzxibPH+hxI8grOZZe6YZQJymhy5qs5DTMGYJYhezGvtwlIt6zw/DwWY7Y/Mr94M8aLbituSSo6h0qOXZ2HtqPRivUjxWm5hjzpF1crsGS5AsZB5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qG7OKZtk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/vlEsE7K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 6 Jun 2024 09:59:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717660753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=30vocsfTuBFpsGaciPogg95G00+g0UfUEX+ZmA5rlwg=;
	b=qG7OKZtkHJpbqIHTP6vxfQj8V7scoSssLhudVwaoRNmMxuNqyDVz0iYt59zlvq1xEQyViX
	pAo0nsfe/fWaTjkiYBg09yUpxkocdAxbBNXvd4WZGqPxnYoJ9OrVoqt+io2e7GWHeZZiRo
	nOuv538ixF+g7vr8BmdDzbx+xbldmjBq/7iq9AwHdPqvVGi/KCn/u10wSgcgLfUiTTgyRQ
	Hd4TJseY++Ezq60frsHLNVxP8nR1hSmioXrsp53+nKKaQz0JnHZZ3lK8JYabVeZ4gOoKTj
	K4PSPXcupatjR3JRZYyux/bM8JpPE1I7o8GZMex6tHDxLdbq9yk0RWdFgOdHiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717660753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=30vocsfTuBFpsGaciPogg95G00+g0UfUEX+ZmA5rlwg=;
	b=/vlEsE7KNVIsQeYT9HKWZ40jdf2xffBPU3Ix94pTZGc2VwmA1ydkvnSgKFpmSc6namZ0nr
	SXN0zwMGrKiR5uCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 net-next 01/14] locking/local_lock: Add local nested
 BH locking infrastructure.
Message-ID: <20240606075911.4eE4DdNS@linutronix.de>
References: <20240604154425.878636-1-bigeasy@linutronix.de>
 <20240604154425.878636-2-bigeasy@linutronix.de>
 <20240606075244.GB8774@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240606075244.GB8774@noisy.programming.kicks-ass.net>

On 2024-06-06 09:52:44 [+0200], Peter Zijlstra wrote:
> On Tue, Jun 04, 2024 at 05:24:08PM +0200, Sebastian Andrzej Siewior wrote:
> > Add local_lock_nested_bh() locking. It is based on local_lock_t and the
> > naming follows the preempt_disable_nested() example.
> > 
> > For !PREEMPT_RT + !LOCKDEP it is a per-CPU annotation for locking
> > assumptions based on local_bh_disable(). The macro is optimized away
> > during compilation.
> > For !PREEMPT_RT + LOCKDEP the local_lock_nested_bh() is reduced to
> > the usual lock-acquire plus lockdep_assert_in_softirq() - ensuring that
> > BH is disabled.
> > 
> > For PREEMPT_RT local_lock_nested_bh() acquires the specified per-CPU
> > lock. It does not disable CPU migration because it relies on
> > local_bh_disable() disabling CPU migration.
> 
> should we assert this? lockdep_assert(current->migration_disabled) or
> somesuch should do, rite?

local_lock_nested_bh() has lockdep_assert_in_softirq(). You want the
migration check additionally or should that softirq assert work?

> > With LOCKDEP it performans the usual lockdep checks as with !PREEMPT_RT.
> > Due to include hell the softirq check has been moved spinlock.c.
> > 
> > The intention is to use this locking in places where locking of a per-CPU
> > variable relies on BH being disabled. Instead of treating disabled
> > bottom halves as a big per-CPU lock, PREEMPT_RT can use this to reduce
> > the locking scope to what actually needs protecting.
> > A side effect is that it also documents the protection scope of the
> > per-CPU variables.
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Otherwise I suppose sp.. not a fan of the whole nested thing, but I
> don't really have an alternative proposal so yeah, whatever :-)

Cool.

Sebastian

