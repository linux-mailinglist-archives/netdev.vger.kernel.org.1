Return-Path: <netdev+bounces-241391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BADC83527
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 05:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F55C34BC79
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11E427FD6E;
	Tue, 25 Nov 2025 04:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpyPrASc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D7F223DD6;
	Tue, 25 Nov 2025 04:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764044439; cv=none; b=q03wKOa7FGNWpu/zrBKLe6AnSHCAmpVc2JbEyDILwW6Sdc3mJLWcRWYgBLMZRl2Qzz1taHoEirBoHciP3wCSIMueyCWMxWhgcpEDHqD7pW4kndOA8NTWjknzG7mFN2wBo6OOmiYPnlpKjYIRnAeD3x4DjwbrCERPQn/DAVbq2rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764044439; c=relaxed/simple;
	bh=BDSrckJ3UfUZqTApBCiSao8zii4mXtC3O6umW5EtUcw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WosYBKAlNdLJN2TpPWtSB6adr0DSSNNiTvSH4n8nDLwVV3INdUWm3SFX/3NV165NIWilYcaXilYJ41uSwwW1+T7B4hhMDDgnnaDyHwfY/f1XkAURcmzXLNM6Fe3v3L5YGvEiy224t7E1iesEMuCS2I0bzQ5Fh9mDa52a9bvxzVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpyPrASc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C043CC4CEF1;
	Tue, 25 Nov 2025 04:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764044439;
	bh=BDSrckJ3UfUZqTApBCiSao8zii4mXtC3O6umW5EtUcw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gpyPrAScvMMk92xDTb+xWZpRFT2SDeCd4rlMFTiUfI0+7bQ7rUKWJlseXmjnnLD/K
	 ZpO4dtptFV+hada6upss1Pvm6uNaDDpoBwz1vKTfgoxV69j2MVlS/cFYSUjXXbJzya
	 OJgQU7YsUuE2xDDfIW8mM8LSQUW02VwtcaTY+XE7zWEaxBr9Pf+OUYvrkIgcEjKwFy
	 hGixeU/IS5kfPE4+8If+ffuNvJKidKgdtU9JaSVZGW6VueHbuL+9A5mYzNlHyUy3iS
	 BSmgdbckwsroRlkV+XlGp1rMH3m77m3X1/dmARH4w17P9ygYj6Jh0fcdIy7a6ZdcVs
	 Sm7NZ8Cxen30A==
Date: Mon, 24 Nov 2025 20:20:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: azey <me@azey.net>
Cc: "David Ahern" <dsahern@kernel.org>, "nicolasdichtel"
 <nicolas.dichtel@6wind.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "netdev" <netdev@vger.kernel.org>,
 "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net/ipv6: allow device-only routes via the multipath
 API
Message-ID: <20251124202037.2ffdc42a@kernel.org>
In-Reply-To: <19ab92bfcaa.fc063ed1450036.1152663278874953682@azey.net>
References: <3k3facg5fiajqlpntjqf76cfc6vlijytmhblau2f2rdstiez2o@um2qmvus4a6b>
	<20251124190044.22959874@kernel.org>
	<19ab902473c.cef7bda2449598.3788324713972830782@azey.net>
	<20251124192550.09866129@kernel.org>
	<19ab92bfcaa.fc063ed1450036.1152663278874953682@azey.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Nov 2025 05:00:59 +0100 azey wrote:
> > My understanding is that if I know you, I can apply your patch even 
> > if you use your nick name (rather than what you have in your passport
> > letter for letter).
> > 
> > I don't know you.
> > 
> > If you're saying that I can do some research and find out who you are
> > please be aware that we deal with 700 individual per release just
> > in networking.  
> 
> My main concern is that I keep my on/offline identities very separated,
> so you couldn't find me by my real name anywhere online. And offline,
> my legal name is common enough that you couldn't single me out by it
> alone either.
> 
> My understanding is that the sign-off name should be what you can
> identify and contact me by in case of any problems, which my legal
> name is not. As per Linus' commit I linked:
> 
> > the sign-off needed to be something we could check back with.  

Feel free to appeal to Linus or Greg KH if you think it's worth their
time (I don't).

I hope I don't regret saying this. But my understanding is that the
real reason the wording was changed was that there are surprisingly
many countries in the world which have legal requirements on the name.
For instance, in the past(!) Greece forced Macedonians to use a
Greekified spelling of their name. IDK the details but IIUC Lithuania
requires certain spelling of Polish names too (I could be wrong). etc.

The rule was loosened because someone may culturally want to spell
their name one way, but their "legal" name is forced to be localized.

It does not mean we will entertain people who "want to be anonymous
online".

This is my final comment on this.

