Return-Path: <netdev+bounces-187578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A87EAA7DFF
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 04:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CADF89A042E
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 02:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931DD70814;
	Sat,  3 May 2025 02:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzKjY7Fp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3F944C77
	for <netdev@vger.kernel.org>; Sat,  3 May 2025 02:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746238213; cv=none; b=Ez5VEMQkj5eH0+jQq8f2ccOfFb3R2L1VIw9Ri47tsQpLU8WTHQairOU8016FmpCnvBMJ5Yfnf2wTAwZGOQuffpj/5vEZ167LnYNS99DqwgNnw5dIMhpNZXEFN5ImrYNnYvQziIQjwmpUtWQY6Ymh3LLBSd71AmKsB6QP4++pHZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746238213; c=relaxed/simple;
	bh=JWMGhmgjn1Fh+H249rYpNdEhRHCiEumVZZws0qAWwDo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GKtrZFFi0UzjX37Hvi06QZT+OcjoWjTOUFU+31UBKehBqkF6+m2/YNbUiKYOJBnBfdBGelbRaCMWCVLKCybCcos2Z63W+OSd+I7Fc9OsmphvpFXTuLaKyLn7kV4W1gFwKsuIcVaB3YtEhcsQIW5e2bUTJp0qm8r/ATLKH0QUJkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzKjY7Fp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9357AC4CEE4;
	Sat,  3 May 2025 02:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746238212;
	bh=JWMGhmgjn1Fh+H249rYpNdEhRHCiEumVZZws0qAWwDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HzKjY7FpG/TCmn5gLChVPmQ2gsCPa2EtGkNkGjHxquPdTDzyjjeTEuHhlFikuEQSP
	 ouqAn3i2GaZpOuBgVIXxDM/ADllU1Y+WuRtcG8SSdvjHnP5MfzCDhSleU8aonqzu9e
	 wGayFN9iW6hqpj5h5/f3tkZg2dDenu8+0N3t3w746zJiot2bhHDZOcpWPgHwt+eoRl
	 6Ly3jx+2NudmAMSeJpT1YM7sNzwpSkQUTAQWIEzEr/jcDiS3l4zCIeta3lR8vUFTGc
	 3edRkjJ1PikthXoHvzIly2peQt+5wrA/as7x+gPyrIDCgilK7FZGX8kUUZZpaZekWY
	 bGDZBox85XmPQ==
Date: Fri, 2 May 2025 19:10:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Samiullah Khawaja
 <skhawaja@google.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5] Add support to set napi threaded for
 individual napi
Message-ID: <20250502191011.68ccfdfe@kernel.org>
In-Reply-To: <aBFrwyxWzLle6B03@LQ3V64L9R2>
References: <20250423201413.1564527-1-skhawaja@google.com>
	<20250425174251.59d7a45d@kernel.org>
	<aAxFmKo2cmLUmqAJ@LQ3V64L9R2>
	<680cf086aec78_193a062946c@willemb.c.googlers.com.notmuch>
	<aA_FErzTzz9BfDTc@LQ3V64L9R2>
	<20250428113845.543ca2b8@kernel.org>
	<aA_zH52V-5qYku3M@LQ3V64L9R2>
	<20250428153207.03c01f64@kernel.org>
	<aBFrwyxWzLle6B03@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Apr 2025 17:16:03 -0700 Joe Damato wrote:
> > The way I see it - the traditional permission model doesn't extend 
> > in any meaningful way to network settings. All the settings are done 
> > by some sort of helper or intermediary which implements its own
> > privilege model.  
> 
> I agree that is how it is today, but maybe we are misunderstanding
> each other? In my mind, today, the intermediary is something like a
> script that runs a bunch of ethtool commands.
> 
> In my mind with the movement of more stuff to core and the existence
> of YNL, it seems like the future is an app uses YNL and is able to
> configure (for example) an RSS context and ntuple rules to steer
> flows to queues it cares about... which in my mind is moving toward
> eliminating the intermediary ?

Yes, AFAIU.

> > My thinking is more that the "global" settings are basically "system"
> > settings. There is a high-perf app running which applied its own
> > settings to its own queues. The remaining queues belong to the "system".
> > Now if you for some reason want to modify the settings of the "system
> > queues" you really don't want to override the app specific settings.  
> 
> Yea, I see what you are saying, I think.
> 
> Can I rephrase it to make sure I'm following?
> 
> An app uses YNL to set defer-hard-irqs to 100 for napis 2-4. napis 0
> and 1 belong to the "system."
> 
> You are saying that writing to the NIC-wide sysfs path for
> defer-hard-irqs wouldn't affect napis 0 and 1 because they don't
> belong to the system anymore.
> 
> Is that right?

Typo - napis 2-4, right? If so - yes, exactly. 

> If so... I think that's fairly interesting and maybe it implies a
> tighter coupling of apps to queues than is possible with the API
> that exists today? For example say an app does a bunch of config to
> a few NAPIs and then suddenly crashes. I suppose core would need to
> "know" about this so it can "release" those queues ?

Exactly, Stan also pointed out the config lifetime problem.
My plan was to add the ability to tie the config to a netlink socket.
App dies, socket goes away, clears the config. Same thing as we do for
clean up of DEVMEM bindings. But I don't have full details.

The thing I did add (in the rx-buf-len series) was a hook to the queue
count changing code which wipes the configuration for queues which are
explicitly disabled.
So if you do some random reconfig (eg attach XDP) and driver recreates
all NAPIs - the config should stay around. Same if you do ifdown ifup.
But if you set NAPI count from 8 to 4 - the NAPIs 4..7 should get wiped.

