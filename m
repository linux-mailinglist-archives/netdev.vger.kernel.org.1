Return-Path: <netdev+bounces-61601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D75B18245F9
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759D61F2204A
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1EB249FF;
	Thu,  4 Jan 2024 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shI27WCY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BFB24B20
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 16:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E995C433C8;
	Thu,  4 Jan 2024 16:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704385017;
	bh=tOCRlpR55/X9W67B4wtDevokleKO8oqoYwStXC9ATS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=shI27WCY3zbJ5N0iBUxgdv8jKjNmw/VICY0QgWXxFRw3QcG/2/u7boUpWjXgiNx8Z
	 y+MYPcKsinphOqd8vYWbpMlEraEGiZYI3cPrQKWrlIhLvUJ8s5ZUwZos6Lq7N2K82J
	 g1J9Y2HNIh8PMkGLcradIdnZIs8swnyz79bD47ROja2cPbWww182NhkLJ2eWp84MYR
	 skI7SJGK4YnuMKqEylONZ6t/E3pdc6KWPleD4dx5OMFZhMsk5hHlP8QTM8l0aAcOEk
	 I3ELj4wtajdPW8r0giLmWW8/0rtHYNLML3anCwc5S7qcLNL90+8xMBiiVOMHlosZit
	 EI1nVoSyZbrsQ==
Date: Thu, 4 Jan 2024 08:16:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, Johannes Berg
 <johannes@sipsolutions.net>, netdev@vger.kernel.org, Johannes Berg
 <johannes.berg@intel.com>, Marc MERLIN <marc@merlins.org>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net v3] net: ethtool: do runtime PM outside RTNL
Message-ID: <20240104081656.67c6030c@kernel.org>
In-Reply-To: <9bcfb259-1249-4efc-b581-056fb0a1c144@gmail.com>
References: <20231206113934.8d7819857574.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
	<20231206084448.53b48c49@kernel.org>
	<ZZU3OaybyLfrAa/0@linux.intel.com>
	<20240103153405.6b19492a@kernel.org>
	<ZZZrbUPUCTtDcUFU@linux.intel.com>
	<9bcfb259-1249-4efc-b581-056fb0a1c144@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jan 2024 10:05:12 +0100 Heiner Kallweit wrote:
> > If device was not suspended, pm_runtime_get_sync() will increase
> > dev->power.usage_count counter and cancel pending rpm suspend
> > request if any. There is race condition though, more about that
> > below.
> > 
> > If device was suspended, we could not get to igc_open() since it
> > was marked as detached and fail netif_device_present() check in
> > __dev_open(). That was the behaviour before bd869245a3dc.

__dev_open() tries to resume as well, and is also under rtnl_lock.
So that resume call somehow must never happen or users would see
-ENODEV? Sorry for the basic questions, the flow is confusing :S

> > There is small race window between with igc_open() and scheduled
> > runtime suspend, if at the same time dev_open() is done and
> > dev->power.suspend_timer expire:
> > 
> > open:					pm_suspend_timer_fh:
> > 
> > rtnl_lock()
> > 					rpm_suspend()
> > 					  igc_runtime_suspend()
> > 					   __igc_shutdown()
> > 					     rtnl_lock()
> > 
> > __igc_open()
> >   pm_runtime_get_sync():
> >     waits for rpm suspend callback done
> > 
> > This needs to be addressed, but it's not that this can happen
> > all the time. To trigger this someone has to remove the
> > cable and exactly after 5 seconds do ip link set up. 

Or tries to up exactly 5 sec after probe?

> For me the main question is the following. In igc_resume() you have
> 
> 	rtnl_lock();
> 	if (!err && netif_running(netdev))
> 		err = __igc_open(netdev, true);
> 
> 	if (!err)
> 		netif_device_attach(netdev);
> 	rtnl_unlock();
> 
> Why is the global rtnl_lock() needed here? The netdev is in detached
> state what protects from e.g. userspace activity, see all the
> netif_device_present() checks in net core.

That'd assume there are no RPM calls outside networking in this driver.
Perhaps there aren't but that also sounds wobbly.

