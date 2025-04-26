Return-Path: <netdev+bounces-186217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A78A6A9D750
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 04:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8DD5A323A
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 02:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A261FE44E;
	Sat, 26 Apr 2025 02:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WX4KTTsn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937511EDA22
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 02:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745635663; cv=none; b=hO8DLPHGZAqQBznnehjZ82fFfA5wzu90MYzj75+cbTbI6PGgIH0O33rUfG1UimfozSJgiGAtsKKtyODQZ/7Blv2FC20TbUmpwWLofmydusBCA2jBGUEWflsJX+3BWBpL7S3Axu+NHkxUZ+pOCDampzyBvkIioXnCd8YNdXcE38U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745635663; c=relaxed/simple;
	bh=DtaBssMnEGCXlBvHZcSP0y1ERe3BrVfDNxOK4U6uNTo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YK5lW2XUkfZ/esdc+fcCuL/RUDi5M5fLRJXxsKobl3zko2CXLLJrgWBR8RxIB+GH1wvJBLEHdzepjDY2X6Y+xJwPk+Um+sdLwsce+JOfm0Fx9+ofE/4EBaJAvtYBj1tHtydQUQMyQA4K8Syo4U2gL8uELXmKOEXhyFo34kU4qUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WX4KTTsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED59C4CEE4;
	Sat, 26 Apr 2025 02:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745635663;
	bh=DtaBssMnEGCXlBvHZcSP0y1ERe3BrVfDNxOK4U6uNTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WX4KTTsnL6UZXwzCJOrIYFCZzKEGNQX4kV5KOZeqjvDQi9Cuvve35y9+SF2+ilEP1
	 ZLshmUeF23y8esd6Q2hyRLW9KW17mjpHjkrIcrhQNYWGWhFp8gLqythae/RrPPuwhN
	 jIU5TYzhPj+Aab85FHMMfKPHzdSTY3yVW40Vea2E/5ulrjQYLMt1Zvphsnq3HTiBfK
	 f9t2xEOTGU2dPRe2bp0KOVdW1mTg/dRJuljHXDViA87KPpeIjcoMLsoBRAgj096+SG
	 +YHJ+9LSmRuB2re/Q8uKbYwNECwwWFbzp73yJvTH0dS2iZ1Oc8krNT34D2MYTFANj6
	 YmP1y+x8EkNKg==
Date: Fri, 25 Apr 2025 19:47:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com,
 mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5] Add support to set napi threaded for
 individual napi
Message-ID: <20250425194742.735890ac@kernel.org>
In-Reply-To: <aAxGTE2hRF-oMUGD@LQ3V64L9R2>
References: <20250423201413.1564527-1-skhawaja@google.com>
	<aArFm-TS3Ac0FOic@LQ3V64L9R2>
	<CAAywjhQhH5ctp_PSgDuw4aTQNKY8V5vbzk9pYd1UBXtDV4LFMA@mail.gmail.com>
	<aAwLq-G6qng7L2XX@LQ3V64L9R2>
	<CAAywjhTjBzU+6XqHWx=JjA89KxmaxPSuoQj7CrxQRTNGwE1vug@mail.gmail.com>
	<20250425173743.04effd75@kernel.org>
	<aAxGTE2hRF-oMUGD@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 19:34:52 -0700 Joe Damato wrote:
> On Fri, Apr 25, 2025 at 05:37:43PM -0700, Jakub Kicinski wrote:
> > On Fri, 25 Apr 2025 15:52:30 -0700 Samiullah Khawaja wrote:  
> > > I think the reason behind it not being killed is because the user
> > > might have already done some configuration using the PID and if the
> > > kthread was removed, the user would have to do that configuration
> > > again after enable/disable. But I am just speculating. I will let the
> > > maintainers weigh-in as you suggested.  
> > 
> > I haven't looked at the code, but I think it may be something more
> > trivial, namely that napi_enable() return void, so it can't fail.
> > Also it may be called under a spin lock.  
> 
> If you don't mind me asking: what do you think at a higher level
> on the discussion about threaded NAPI being disabled?
> 
> It seems like the current behavior is:
>   - If you write 1 to the threaded NAPI sysfs path, kthreads are
>     kicked off and start running.
> 
>   - If you write 0, the threads are not killed but don't do any
>     processing and their pids are still exported in netlink.
> 
> I was arguing in favor of disabling threading means the thread is
> killed and the pid is no longer exported (as a side effect) because
> it seemed weird to me that the netlink output would say:
> 
>    pid: 1234
>    threaded: 0
> 
> In the current implementation.

We should check the discussions we had when threaded NAPI was added.
I feel nothing was exposed in terms of observability so leaving the
thread running didn't seem all that bad back then. Stopping the NAPI
polling safely is not entirely trivial, we'd need to somehow grab
the SCHED bit like busy polling does, and then re-schedule.
Or have the thread figure out that it's done and exit.
Probably easier to hide the attr in netlink.

