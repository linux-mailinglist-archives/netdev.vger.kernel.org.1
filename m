Return-Path: <netdev+bounces-192463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C0DABFF62
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 00:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417813AB342
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 22:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278D02397BE;
	Wed, 21 May 2025 22:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7Axwh1z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020AF1754B
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866109; cv=none; b=Lf5YOAvd54zZXm2eX8wfrS7rYkJ4ToDRv5FDf4TefT41qknXQ5eneNNQaAQjLa36GkYm7TeEk3oBF2KJ7itQmzGe0K42AyyfA5zCCXIR8lIdGZO+4+4YPbImt4W5Me3+icmL1/r92D4Di/dCBR5IgNMdBsUM/DcY06RGMt+P3vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866109; c=relaxed/simple;
	bh=L9jqBe7WeGUMjBl8bfXNlFqbpsL7fdO6E4F4Xa18Sxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0BESMeBIcbHAyh/Gv/3Z1eD3GQ5maYbh1gd8c3+hug9hXG8x8cXTG7jEWCI8v7nOTiRfjxRrD6JXO+Bm0TgyDykjfUYDLz0UVb8zFpnaDqgdqI/LLk7ogrJP/qAdPecSom3DxW0zpUEoIWnHR7uo5ky0z9G3sTYx+te3HDz9FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7Axwh1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2756DC4CEE4;
	Wed, 21 May 2025 22:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747866108;
	bh=L9jqBe7WeGUMjBl8bfXNlFqbpsL7fdO6E4F4Xa18Sxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b7Axwh1zBu2r1TrU4rgm7PCbUWDJ4jT+KRP7USx8/kDPZBNrC3Lzj2xMtiid6GMQw
	 kzNPP2OeYw4sruyIAi9lF9qG3SEUUO7nCGhULM37ZtS37aOQ5AdDgkHfaAwAfYjTOd
	 yi5M84NzxiNiyfYWT7mfw1rC7qvM4l1NCJ4rji7d4HzVvDbQ0YbVhURbhMH0ZxZbkl
	 UZJ+X71hZ8ipGay7gcEMqc8jpdn7yJg36LjcE5ERHoIu5DGaYtgW70s1r305uPmCYx
	 EFk/K+dxNW7LUU55WX5WGq5dfplWw4bh53fkAqRpWVusfYAr55jbm/1TDRMcEwx09e
	 1vaeK6wsleY2w==
Date: Wed, 21 May 2025 15:21:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Wei Wang <weiwan@google.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, jdamato@fastly.com,
 mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: stop napi kthreads when THREADED napi
 is disabled
Message-ID: <20250521152147.077f1cb0@kernel.org>
In-Reply-To: <CAAywjhTjdgjz=oD0NUtp-k7Lccek-4e9wCJfMG-p0AGpDHwJiQ@mail.gmail.com>
References: <20250519224325.3117279-1-skhawaja@google.com>
	<20250520190941.56523ded@kernel.org>
	<CAEA6p_BxSA16cMXr5NaJCLZ+KWD2YVVwEdvVX_QG=_gyvNCP=w@mail.gmail.com>
	<CAAywjhR4znr9fsAdBKmYAwcyP8JgoesLkuS8p9D0goJBFFePWg@mail.gmail.com>
	<CAAywjhTjdgjz=oD0NUtp-k7Lccek-4e9wCJfMG-p0AGpDHwJiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 May 2025 12:51:33 -0700 Samiullah Khawaja wrote:
> > This might suffer from the problem you highlighted earlier,
> > CPU 0 (IRQ)             CPU 1 (NAPI thr)          CPU 2 (config)
> >
> >   ____napi_schedule()
> >     if (test_bit(NAPI_STATE_THREADED))
> >     if (thread) {
> >
> >  kthread_stop()
> >                               if (state & SCHED_THREADED || !(state & SCHED)) {
> >                                    state &= ~THREADED;
> >                               if (try_cmp_xchg())
> >                                    break
> >
> >        set_bit(NAPI_STATE_SCHED_THREADED)
> >        wake_up_process(thread);

This got a bit line wrapped for me so can't judge :(

> > This would happen without the try_cmp_xchg logic that I added in my
> > patch in the __napi_schedule (in the fast path). __napi_schedule would
> > have to make sure that the kthread is not stopping while it is trying
> > to do SCHED. This is similar to the logic we have in
> > napi_schedule_prep that handles the STATE_DISABLE, STATE_SCHED and
> > STATE_MISSED scenarios. Also if it falls back to normal softirq, it
> > needs to make sure that the kthread is not polling at the same time.  
> Discard this as the SCHED would be set in napi_schedule_prepare before
> __napi_schedule is called in IRQ, so try_cmp_xchg would return false.
> I think if the thread stops if the napi is idle(SCHED is not) set then
> it should do. This should make sure any pending SCHED_THREADED are
> also done. The existing logic in napi_schedulle_prep should handle all
> the cases.

I think we're on the same page. We're clearing the THREADED bit 
(not SCHED_THREADED). Only napi_schedule() path looks at that bit, 
after setting SCHED. So if we cmpxchg on a state where SCHED was 
clear - we can't race with anything that cares about THREADED bit.

Just to be clear - the stopping of the thread has to be after the
proposed loop, so kthread_should_stop() does not come into play.

And FWIW my understanding is that we don't need any barriers on the
fast path (SCHED vs checking THREADED) because memory ordering is
a thing which exists only between distinct memory words.

