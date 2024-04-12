Return-Path: <netdev+bounces-87426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A8C8A318A
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 16:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D867B1C20E80
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 14:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A57F1448E3;
	Fri, 12 Apr 2024 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UamirxC0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1A58615F
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712933541; cv=none; b=tU+nudzgCl9/hTSWVMK+QSA2xj7it5jDSITSA7dUBVkfgo7BsvQOgCw/XzMag8noFK8EAbhPx6ehntAl59WsWUuVVWIneDDx748IB5ics3R42lG78uMevhRv0AxR4fyLuWBdp8BitPsPhgslps7yNvZYMMwcQCPsSHQ15heyTNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712933541; c=relaxed/simple;
	bh=isE3EC46/XaI3gj53jYxOc4GGgMM47Z+EhFSuza1LVk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+9rS9FesQSeiCiKENMkrSU8GS+Rg9aqpJLqiM9dZMtXLpgQbYBQAZdsMPm4hDvHW++5Q+PoqU+su2ilh6YoebUCtNQut9SGT8/RkDoFbOZJf/+8WnBQ8zCmIwDuw2x9CVn1ww/xYMEAFuHZg93AQgy6f1osU+VydMU7zcdLbS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UamirxC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D30C113CC;
	Fri, 12 Apr 2024 14:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712933541;
	bh=isE3EC46/XaI3gj53jYxOc4GGgMM47Z+EhFSuza1LVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UamirxC0iJy4iFYf+o01I4sAeSYlsLjAbtbCmrdQ4RYlJ1xys0uavSfuRQ6Aj9bsP
	 k4JU1HMcVzSdk4+7NL6AJFeSZ329NzGgpfNrttdz1vPzU+TXf4TBSFda5keX1Ee4pE
	 kLi3whsL6wgQsYDS5bUvyyuogdv19NSWUpPO45XLsJqe0Zmc1y4fo0vb0LArpDeeKc
	 ISIkLglUe2bnzj9voiNLS46ozcsvej5OJfdr/KOhIg6G4BeS7ViW1MixD/UF0Djlz5
	 Ir9lRqse83u/wo6e1W3tO44Z/hDl3yZUYmfmI1s67BgyTFYJUAOVyhMZE0awHqMtT5
	 511IZCs+q/T+Q==
Date: Fri, 12 Apr 2024 07:52:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Mark Brown <broonie@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ratheesh
 Kannoth <rkannoth@marvell.com>, Ronald Wahl <ronald.wahl@raritan.com>,
 Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2 2/2] net: ks8851: Handle softirqs at the end of
 IRQ thread to fix hang
Message-ID: <20240412075220.17943537@kernel.org>
In-Reply-To: <a8e28385-5b92-4149-be0c-cfce6394fbc2@denx.de>
References: <20240405203204.82062-1-marex@denx.de>
	<20240405203204.82062-2-marex@denx.de>
	<ZhQEqizpGMrxe_wT@smile.fi.intel.com>
	<a8e28385-5b92-4149-be0c-cfce6394fbc2@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 13:29:04 +0200 Marek Vasut wrote:
> >> irq_thread_fn from irq_thread
> >> irq_thread from kthread
> >> kthread from ret_from_fork  
> > 
> > These lines are unneeded (in case you need a new version, you can drop them).  
> 
> I just got back and going through a mountain of email, I see Jakub 
> already picked the V2, so, noted for next time. Thank you !

Whether the stack trace is for a hard IRQ or threaded IRQ is the first
thing I looked for when reviewing. Change is about the calling context. 
So I figured while not strictly necessary, in this particular case,
these lines may be helpful for people eyeballing the change...
In general, yes, trimming the bottom of the stack is good hygiene.

