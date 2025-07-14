Return-Path: <netdev+bounces-206777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D8BB04589
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 836FA7A3286
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94A225F96B;
	Mon, 14 Jul 2025 16:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUq5DjSb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DFA2494D8
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 16:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510938; cv=none; b=Ub3liZGhaBPP07EXsLszL2HFzkZ6RU1COZcmEueJA9IXRlzrsNvplRm7VwBhp4g93vX2C7OC1xFdyn4uOyniM/NcHPq+BUnx2bKHIwauaV/t7eq9M6x2cYuBMetg2COBW3tg5DElFcF5BCCuRPOpbQQnJmbNlt+5Ly+tlbN4ovE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510938; c=relaxed/simple;
	bh=siedBw14IjHAG5Km5NqlYKxhEciet2Qsxj/ZxZ9Zz3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOgb0S52Pv5nwvRWxzjlaRR5oWEqw4JR1i2jKepFP8oYhC8lyCNhyl6jj0rjR+oXVtjlRHFd1KLBEHxL6nfnfERwjToD08aAAHi+fjZmloci95XWyCGT5HRHVBgenfoV6jKtckejEjYm61EmIK+3W1F5AkQN9Qa47FTbR7Q62bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUq5DjSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABCEC4CEED;
	Mon, 14 Jul 2025 16:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752510938;
	bh=siedBw14IjHAG5Km5NqlYKxhEciet2Qsxj/ZxZ9Zz3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jUq5DjSbqJD72qVVEEZwcaKhXQ1sQZM6frs1UGZYHTF3WX2zjKg5Ch++H8QcF1Ii8
	 Ohe+qwbbzWqXcfDs2ea6Zdw/Nb60GzZzsSCBCavppySUSTX/w3zDF5saUEpFXiyKvM
	 CdsSSLuO02ubA1VExpFEKUL1bZV0c9Ogz344hUndZ9NSAEHOFkAwCMJs59tj7ijJCS
	 PUAgcoCQd9gcHBT0EPD7LuPHMpCD6pr1ciunNQYXLfxOotIFFeumgDYEyBwK0rzqj2
	 61qT0Z/KdCToHHcVyTOXrCgtnxOGctvQffmxdjMr8z5POKLYX3QrM8CrsPN4h0oPjl
	 DSpBqc/1nbiPg==
Date: Mon, 14 Jul 2025 09:35:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, shuah@kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, sdf@fomichev.me, ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 00/11] ethtool: rss: support RSS_SET via
 Netlink
Message-ID: <20250714093537.438fc6fa@kernel.org>
In-Reply-To: <24aa8c69-89bb-440c-8d63-79d630800c88@nvidia.com>
References: <20250711015303.3688717-1-kuba@kernel.org>
	<24aa8c69-89bb-440c-8d63-79d630800c88@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Jul 2025 14:06:25 +0300 Gal Pressman wrote:
> On 11/07/2025 4:52, Jakub Kicinski wrote:
> > Support configuring RSS settings via Netlink.
> > Creating and removing contexts remains for the following series.  
> 
> I was also working on this, but admittedly your version looks better.

Oh, sorry :S

> Given the fact that this is not "feature complete" compared to the ioctl
> interface, isn't it considered a degradation from the user's perspective?
> 
> New userspace ethtool will choose the netlink path and some of the
> functionality will be lost. I assume rss_ctx.py fails?

I'm planning / hoping to get all of the functionality implemented
before the merge window.

