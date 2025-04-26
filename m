Return-Path: <netdev+bounces-186218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3451FA9D75D
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 05:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3874E02F0
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 03:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09011FE444;
	Sat, 26 Apr 2025 03:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ta4Bt20k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFF715A864
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 03:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745637146; cv=none; b=goibA+lpGSf/VaYU5j1sAEo7xFJSWDffXZn4EH5ndvgFsegM4DKDQnP9dGAipqpoQdiuUNlznjJ20P4eB6YuFun4G47B3w6OnNOc0xzJzGwbYbP4HvRaYi4FYf5mUjdXMevMW0OpChWdtTHU0LrCWsLrdm4Rd53IaDhtxdLneNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745637146; c=relaxed/simple;
	bh=POFDkfXV21iIu+a3RSNgPgWPsSSCitDhiRU5WHEPWYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBZsccK+llQj2aqFaDyBP/wQRH+e4KWo58oV2yiHlTCRvBS6KElASJh0OLmmrN90IEtktZtDtYWFc5zHzpWwY8xcwLFmFdkbw3IAvdGX3//DkdmZHiVgrCkBkvFYmxbi1rNyfuUX5+9GwqmDR68/Pt36RRuZbEBgGAxXPOSWR70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ta4Bt20k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A2BC4CEE4;
	Sat, 26 Apr 2025 03:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745637146;
	bh=POFDkfXV21iIu+a3RSNgPgWPsSSCitDhiRU5WHEPWYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ta4Bt20kGwxxT3Pkc/e0sEIHkAZkkTL09uzzMSs2TohkEQOM234bd6foXHgXQbZg9
	 ErdZQMHlpCxjqzRPHrE5AcLGjVjGuw95G2oFhvFP3kWkdhMudjByMmC07WCP4Gb0Vq
	 xs+OqdK4ZrhTBcOLvmD4Oun1gaBxz1utflbBYdJx3aONyxEUVfSkPX7XRNDwX/QCnr
	 l1iu5hlnTy6DjzaEy/eXFxQiahPStiUAOjuFDg/D5jEcx3p2X3m8mFeT0pHCB0KwLu
	 LMPgqJUeyfzVlRb6PQFF6eECb5kWOgWqtD0ZaDqd/UqpNZQX3rsVt8xdxWawyu8FB6
	 H+PNps7LN6WCw==
Date: Fri, 25 Apr 2025 20:12:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com,
 mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5] Add support to set napi threaded for
 individual napi
Message-ID: <20250425201220.58bf25d7@kernel.org>
In-Reply-To: <20250425194742.735890ac@kernel.org>
References: <20250423201413.1564527-1-skhawaja@google.com>
	<aArFm-TS3Ac0FOic@LQ3V64L9R2>
	<CAAywjhQhH5ctp_PSgDuw4aTQNKY8V5vbzk9pYd1UBXtDV4LFMA@mail.gmail.com>
	<aAwLq-G6qng7L2XX@LQ3V64L9R2>
	<CAAywjhTjBzU+6XqHWx=JjA89KxmaxPSuoQj7CrxQRTNGwE1vug@mail.gmail.com>
	<20250425173743.04effd75@kernel.org>
	<aAxGTE2hRF-oMUGD@LQ3V64L9R2>
	<20250425194742.735890ac@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 19:47:42 -0700 Jakub Kicinski wrote:
> > > I haven't looked at the code, but I think it may be something more
> > > trivial, namely that napi_enable() return void, so it can't fail.
> > > Also it may be called under a spin lock.    
> > 
> > If you don't mind me asking: what do you think at a higher level
> > on the discussion about threaded NAPI being disabled?
> > 
> > It seems like the current behavior is:
> >   - If you write 1 to the threaded NAPI sysfs path, kthreads are
> >     kicked off and start running.
> > 
> >   - If you write 0, the threads are not killed but don't do any
> >     processing and their pids are still exported in netlink.
> > 
> > I was arguing in favor of disabling threading means the thread is
> > killed and the pid is no longer exported (as a side effect) because
> > it seemed weird to me that the netlink output would say:
> > 
> >    pid: 1234
> >    threaded: 0
> > 
> > In the current implementation.  
> 
> We should check the discussions we had when threaded NAPI was added.
> I feel nothing was exposed in terms of observability so leaving the
> thread running didn't seem all that bad back then. Stopping the NAPI
> polling safely is not entirely trivial, we'd need to somehow grab
> the SCHED bit like busy polling does, and then re-schedule.
> Or have the thread figure out that it's done and exit.

Actually, we ended up adding the explicit ownership bits so it may not
be all that hard any more.. Worth trying.

