Return-Path: <netdev+bounces-229636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E90BDF1B5
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBE0E4E3AF1
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 14:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CB62848AD;
	Wed, 15 Oct 2025 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeFdLECT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B57283FDF
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539043; cv=none; b=ZRjIu8LTE5SeNHzOPkP1/sqUYSrCicK2ZCz5dxALyOGbiuGD5iT3ONbx9WuuQHkA9X17EGrdbr1VkXRZ5xy4L/O9CF91zKwvYmfxclZDDM/kVyLfLNPiYiPUeQ9NMOYzL1Y6SdG6H+sP0r4l+206BuO7+wNept2mgWORAQEWnzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539043; c=relaxed/simple;
	bh=/2gI+636tBEBq7DiKIxWzRYsD1U4kAVIaDoBdFJ+3Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Llpk/1bF3htITkv10JJC2trZKyrJWql4DS1Vbli4oi9rxmXrg6huIDCKyRh7hC/qZt1QBmvOvxXiHDBRcHQ7SMtgY+ao0Id3OXn26plMXYnlaNvLxwL1h1JWgLnzk2QBMRj27k6THp/C/E+ZErfLs6vz2kAFWjMwswxhtpDomTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeFdLECT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C04C4CEF8;
	Wed, 15 Oct 2025 14:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760539042;
	bh=/2gI+636tBEBq7DiKIxWzRYsD1U4kAVIaDoBdFJ+3Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BeFdLECTeLiSOFkOLCVpIfe9JsF5ztywXHkt+0E6idregTEmhiGgogWA0X6QLL9q9
	 UpB4vDzo16G1rwN4HN1GKtXG0UWpth8wzKfT9ZDkqFqIZvxrRyS1XdxXYgD+IvEOuJ
	 WO0lktEQE/Tq3icY+JxmOk01fBt1Xp8fOzztSwTeSUXKye2n19qSbKxZCtrR4FVwM8
	 39Gu24g5GOWmuhZ5xXS0D03760TYzSyiBhipS9tjx0pTcTKAKCycfFU6+OX//xLDw2
	 4Hv6uQ1FtevLwW9vawsEivhj/K21wsLAhlHM3AiOiytYj+aF/rLFbyy+xoPuOLneH7
	 8YZORNoqATdNg==
Date: Wed, 15 Oct 2025 15:37:17 +0100
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Egor Pomozov <epomozov@marvell.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Dimitris Michailidis <dmichail@fungible.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/7] cxgb4: convert to ndo_hwtstamp API
Message-ID: <aO-xnXskSie2PKQq@horms.kernel.org>
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-6-vadim.fedorenko@linux.dev>
 <aO9x7EpgTMiBBfER@horms.kernel.org>
 <193627cf-a8c7-4428-a5d3-8813b1edc04d@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <193627cf-a8c7-4428-a5d3-8813b1edc04d@linux.dev>

On Wed, Oct 15, 2025 at 11:33:02AM +0100, Vadim Fedorenko wrote:
> On 15/10/2025 11:05, Simon Horman wrote:
> > On Tue, Oct 14, 2025 at 10:42:14PM +0000, Vadim Fedorenko wrote:
> > > Convert to use .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.
> > > 
> > > Though I'm not quite sure it worked properly before the conversion.
> > > 
> > > Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > 
> > Hi Vadim,
> > 
> > There is quite a lot of change here. Probably it's not worth "fixing"
> > the current code before migrating it. But I think it would be worth
> > expanding a bit on the statement about not being sure it worked?
> 
> Hi Simon!
> 
> Well, let me try to explain the statement about not being sure it
> worked. The original code was copying new configuration into netdev's
> private structure before validating that the values are acceptable by
> the hardware. In case of error, the driver was not restoring original
> values, and after the call:
> 
> ioctl(SIOCSHWTSTAMP, <unsupported_config>) = -ERANGE
> 
> the driver would have configuration which could not be reapplied and not
> synced to the actual hardware config:
> 
> ioctl(SIOCGHWTSTAMP) = <unsupported_config>
> 
> The logic change in the patch is to just keep original configuration in
> case of -ERANGE error. Otherwise the logic is not changed.

Thanks Vadim,

I see that now and it makes sense to me.
I do think it would be worth mentioning in the patch description.


