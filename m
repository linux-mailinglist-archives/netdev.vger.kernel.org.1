Return-Path: <netdev+bounces-91170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8038B192D
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 05:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614FB1C211C6
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 03:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E602F17578;
	Thu, 25 Apr 2024 03:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQB9weRe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1795629
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 03:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014540; cv=none; b=CYn3mUU7fyfhEuv5dX7bIUnt7yp8jLeWMjUEGggPmv9e7XLxBR2RRmjsGOB2lGL4yo2COxAGGR4X82xvC+mH8u80YFo2Q9IiHB182OIsvdOraz+5tjJEraoOdBuSjT2ttYYYc/keNvMR4i5PjZa8dzb3aCRtXoIKqei5PsZrldo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014540; c=relaxed/simple;
	bh=4o7WCAAF43+pArz7zT8w8IDBOYjPyyeP8m6d4/V/qGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rstUPIK2IbclFgw6AAQiSIHLXi24FNcn9mhMMiDn1iJF1Sf5eACzUrKShbYyBxLrY5lKtA02bCofDLX86Zw8svjs++MgQHGPclJXyOyEwrS7BHj9JxQWtlT4FOZwKkrM+nuyTzv9nMaZ2RV0l9sKAfxFNVHWOIbzAzHBJ3UBrgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQB9weRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3CDC113CD;
	Thu, 25 Apr 2024 03:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714014540;
	bh=4o7WCAAF43+pArz7zT8w8IDBOYjPyyeP8m6d4/V/qGo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QQB9weResXSIglwsw4ytQm0w7d5Vi8Bdc79dF1kqrqg9RRVlyQQrdeRyOXjg/8Wgd
	 678roeVarHHYVfcBDHx834Huh7yN9YW+vy4sL6kiyE5qjjN4h7ODDr9rbonNMOLUQd
	 3nDBVBtx/DZORFlNso/7ts341WBk4U+NN+FQstO2iLY4sy/H0gMaeVG5urqCKWQDvg
	 uK5YpnI54zJl08VPfcmt//zmC5TIiuNad2j15DlvzKw24PfxUl8KyMBdKSzSt9EubR
	 0ovz9I9MpknPvRbS4xEFi+pAMIoWOon55OrKvTVguyNclCokZ2g79tGVWDkoLXdDHp
	 jL2hPKHJ52lKg==
Date: Wed, 24 Apr 2024 20:08:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <pabeni@redhat.com>,
 <edumazet@google.com>, <netdev@vger.kernel.org>, Jiri Pirko
 <jiri@nvidia.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next 1/6] devlink: extend devlink_param *set pointer
Message-ID: <20240424200858.1d0740a4@kernel.org>
In-Reply-To: <cdd3d9d7-1b21-4dc2-be21-ef137682b1ea@intel.com>
References: <20240422203913.225151-1-anthony.l.nguyen@intel.com>
	<20240422203913.225151-2-anthony.l.nguyen@intel.com>
	<cdd3d9d7-1b21-4dc2-be21-ef137682b1ea@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Apr 2024 11:05:58 +0200 Alexander Lobakin wrote:
> >  	int (*set)(struct devlink *devlink, u32 id,
> > -		   struct devlink_param_gset_ctx *ctx);
> > +		   struct devlink_param_gset_ctx *ctx,
> > +		   struct netlink_ext_ack *extack);  
> 
> Sorry for the late comment. Can't we embed extack to
> devlink_param_gset_ctx instead? It would take much less lines.

I think the way Mateusz wrote this is more prevalent today.
Also feels a tiny bit cleaner to me, because if we embed
extack why is devlink and id not embedded?

We've seen this series enough times, let me apply this as is..
Please follow up with the doc adjustments if you'd like, separately.

