Return-Path: <netdev+bounces-186582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EF3A9FD0C
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 00:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D091189DCBF
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 22:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C881DF269;
	Mon, 28 Apr 2025 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikbm3dfh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9501DED7C
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745879528; cv=none; b=XdC0z+ksBZgZTzjmsX3h+YSDc/0Zb7YvuKaPu036HvdJM/VdJlKVaSYyfiC1ZgZIvLigXYu4dYe9+SX7qFDTIkuZYR66VskE4wv6xSBVKDF9B5nG6sjeZ3l4SYWW/UisNmbd8k7w9C4cwZT5gsSeRhyJfq66N4IAqALAjhMT9KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745879528; c=relaxed/simple;
	bh=BUkMEvDsX/tYP2wN6eLx0bnLsplyp0DlnfLHch38qOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GvN22lY+ZyMbiqeh2jJXjQj+JTjv/CDkXStqtOrDpo2UDTfLPTCMSYayqx4R0QW5iAjxYsQqk20/69+7eWPMKAJOZRgeST8qZL0nFWwFMSBOftoUkXagTCuniKN0YshltZWLgxfKbLSQm+/PIIv46mVYCJXYeA1fMxrHmga27aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikbm3dfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7E3C4CEE4;
	Mon, 28 Apr 2025 22:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745879528;
	bh=BUkMEvDsX/tYP2wN6eLx0bnLsplyp0DlnfLHch38qOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ikbm3dfh7jZ50caIDB4t4Go77Ff4Saf00dtvQ1hKa00Bx/LtPpSw70bLv5BKbyCnH
	 RMgSewAcRJHfwQd/Njc729TUDgaycJxOotXc7SOX7eaFFBFsmVn3Yln9ReZmx2ZJx3
	 KFCr7X7/7JN0Z7yfg/Vfna8IkYvZy+ZXf4kpLyrcVBNgwJ8wg9RM0BBCyZRH1ecyom
	 kzfpUS0cJOsEi1c3msuwQt7bDHXKKyd4RbxMGSHLtQ4YY5JImNS2LPWmvkrHfidUhd
	 MKaDxuD0unBgbzUevC+gFeYro5gXkCcVnKZp7eGEKFdciab6D8TLPPmtFxlP01UwyP
	 9PmDEob4jhAuQ==
Date: Mon, 28 Apr 2025 15:32:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Samiullah Khawaja
 <skhawaja@google.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5] Add support to set napi threaded for
 individual napi
Message-ID: <20250428153207.03c01f64@kernel.org>
In-Reply-To: <aA_zH52V-5qYku3M@LQ3V64L9R2>
References: <20250423201413.1564527-1-skhawaja@google.com>
	<20250425174251.59d7a45d@kernel.org>
	<aAxFmKo2cmLUmqAJ@LQ3V64L9R2>
	<680cf086aec78_193a062946c@willemb.c.googlers.com.notmuch>
	<aA_FErzTzz9BfDTc@LQ3V64L9R2>
	<20250428113845.543ca2b8@kernel.org>
	<aA_zH52V-5qYku3M@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 14:29:03 -0700 Joe Damato wrote:
> On Mon, Apr 28, 2025 at 11:38:45AM -0700, Jakub Kicinski wrote:
> > On Mon, 28 Apr 2025 11:12:34 -0700 Joe Damato wrote:  
> > > On Sat, Apr 26, 2025 at 10:41:10AM -0400, Willem de Bruijn wrote:  
> > > > This also reminds me of /proc/sys/net/ipv4/conf/{all, default, .. }
> > > > API. Which confuses me to this day.  
> > 
> > Indeed. That scheme has the additional burden of not being consistently 
> > enforced :/ So I'm trying to lay down some rules (in the doc linked
> > upthread).
> > 
> > The concern I have with the write all semantics is what happens when
> > we delegate the control over a queue / NAPI to some application or
> > container. Is the expectation that some user space component prevents
> > the global settings from being re-applied when applications using
> > dedicated queues / NAPIs are running?  
> 
> I think this is a good question and one I spent a lot of time
> thinking through while hacking on the per-NAPI config stuff.
> 
> One argument that came to my mind a few times was that to write to
> the global path requires admin and one might assume:
>   - an admin knows what they are doing and why they are doing a
>     global write
>   - there could be a case where the admin does really want to reset
>     every NAPIs setting on the system in one swoop
> 
> I suppose you could have the above (an admin override, so to speak)
> but still delegate queues/NAPIs to apps to configure as they like?
>  
> I think the admin override is kinda nice if an app starts doing
> something weird, but maybe that's too much complexity.

The way I see it - the traditional permission model doesn't extend 
in any meaningful way to network settings. All the settings are done 
by some sort of helper or intermediary which implements its own
privilege model.

My thinking is more that the "global" settings are basically "system"
settings. There is a high-perf app running which applied its own
settings to its own queues. The remaining queues belong to the "system".
Now if you for some reason want to modify the settings of the "system
queues" you really don't want to override the app specific settings.

The weakness in my argument is that you probably really shouldn't mess
with system level settings on a live system, according to devops.
But life happens, and visibility is not perfect so somethings you have
to poke to test a theory..

