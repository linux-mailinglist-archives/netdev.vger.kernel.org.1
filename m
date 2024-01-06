Return-Path: <netdev+bounces-62139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1497F825E02
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 04:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB44284A19
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 03:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD0F10E5;
	Sat,  6 Jan 2024 03:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OklnS2U+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E555B15A5
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 03:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126EEC433C7;
	Sat,  6 Jan 2024 03:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704510140;
	bh=g1rLgRvaqXRKG22LlCTKSDbvy1zRhtLZC88vhhYsc5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OklnS2U+UUKxuqRxg8JiIL0/FIQy67Bhv8RyL4Ce55mKXLB78hzRdgyh+hrLCkqdA
	 2ypVtUUxxJxgHCVxtNHxY2dNmoIQ428H49Ycd/rEBKrfOSOMCN0Dsk1ihtE7hHqbkK
	 2hbOlJcR6osYCdHk7iw9NNBu+p80RT9LBhlPRRs5ZyxFMYpDo9slAXLsdO7ElJVopn
	 wbd8rhSJkDUObbuz8q6UsTUV1+0Tu4OFhTcVPTLfpF/1ssk5u2UckdsTH3jeQQEz+b
	 XV5S5xm93+S6DFcQax5nWuSVm0NhCupTFdVK7fiLQ8eAzsOBcMEIfinrY4WR+3Q84V
	 h+pPGh3rB6Kgw==
Date: Fri, 5 Jan 2024 19:02:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Johannes Berg
 <johannes@sipsolutions.net>, netdev@vger.kernel.org, Johannes Berg
 <johannes.berg@intel.com>, Marc MERLIN <marc@merlins.org>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net v3] net: ethtool: do runtime PM outside RTNL
Message-ID: <20240105190218.5b69b9f5@kernel.org>
In-Reply-To: <ZZguXLO3DAX/2Y0/@linux.intel.com>
References: <20231206113934.8d7819857574.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
	<20231206084448.53b48c49@kernel.org>
	<ZZU3OaybyLfrAa/0@linux.intel.com>
	<20240103153405.6b19492a@kernel.org>
	<ZZZrbUPUCTtDcUFU@linux.intel.com>
	<9bcfb259-1249-4efc-b581-056fb0a1c144@gmail.com>
	<20240104081656.67c6030c@kernel.org>
	<ZZftxhXzQykx8j6b@linux.intel.com>
	<20240105073001.15f2f3cb@kernel.org>
	<ZZguXLO3DAX/2Y0/@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jan 2024 17:29:16 +0100 Stanislaw Gruszka wrote:
> > Removing the rpm calls from the core is just going to lead to a
> > whack-a-mole of bugs in the drivers themselves.
> >
> > IOW I look at the RPM calls in the core as a canary for people
> > doing the wrong thing :(  
> 
> Hmm, this one I don't understand, what other bugs could pop up
> after reverting bd869245a3dcc and others that added rpm calls
> for the net core?

IDK what igc powers down, but if there's any ndo or ethtool
callback which needs to access a register that requires power 
to be resumed - it will deadlock on rtnl exactly the same.

Looking at igc_ethtool I see:

static int igc_ethtool_begin(struct net_device *netdev)
{
	struct igc_adapter *adapter = netdev_priv(netdev);

	pm_runtime_get_sync(&adapter->pdev->dev);
	return 0;
}

static void igc_ethtool_complete(struct net_device *netdev)
{
	struct igc_adapter *adapter = netdev_priv(netdev);

	pm_runtime_put(&adapter->pdev->dev);
}

so unless we think that returning -ENODEV from all ethtool calls
when cable is not plugged in is okay - removing the PM resume
from the core doesn't buy us much :(

