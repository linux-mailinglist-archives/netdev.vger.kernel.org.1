Return-Path: <netdev+bounces-61391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A35B823940
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 00:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D18D81F25E8D
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 23:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFECA1F606;
	Wed,  3 Jan 2024 23:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtUkIk46"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71861F927
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 23:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF3AC433C8;
	Wed,  3 Jan 2024 23:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704324847;
	bh=wGcEJ+3kUwGlfjaqEeII9rOuQeWabYxdAJVio8woGEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MtUkIk466Pntiuabwyn96ywVi5wFbDkO2uM+iwDCVVnTIXa34sxfLrt9HdGUGTFyp
	 AbS+5gArpIGsilZb3RbPpuuc0INxt9L3C1vtpY6VIyhFdkIU+qXoly8LBzT5u2WhOG
	 7x0ZM3N2HsryVn7NMMI4upEpstB3IYw1Q9b2H1HJ/znfSwB7e1EiCLch5sNzo6EMRf
	 a6IK3tFqbrDp9/YARQoFkOvjvx80H0J1sXntAhW0LDNBPzC5dn2hRotmfQI8b/KZLW
	 n0R0HIUk964RWhseoQ7Sggwm7X/mdy0GLq2gfEMnrebUq2XoNHJXCOEAAmoNQwRsME
	 K9pF9DvQczeOQ==
Date: Wed, 3 Jan 2024 15:34:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
 Heiner Kallweit <hkallweit1@gmail.com>, Johannes Berg
 <johannes.berg@intel.com>, Marc MERLIN <marc@merlins.org>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net v3] net: ethtool: do runtime PM outside RTNL
Message-ID: <20240103153405.6b19492a@kernel.org>
In-Reply-To: <ZZU3OaybyLfrAa/0@linux.intel.com>
References: <20231206113934.8d7819857574.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
	<20231206084448.53b48c49@kernel.org>
	<ZZU3OaybyLfrAa/0@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jan 2024 11:30:17 +0100 Stanislaw Gruszka wrote:
> > I was really, really hoping that this would serve as a motivation
> > for Intel to sort out the igb/igc implementation. The flow AFAICT
> > is ndo_open() starts the NIC, the calls pm_sus, which shuts the NIC
> > back down immediately (!?) then it schedules a link check from a work  
> 
> It's not like that. pm_runtime_put() in igc_open() does not disable device.
> It calls runtime_idle callback which check if there is link and if is
> not, schedule device suspend in 5 second, otherwise device stays running.

Hm, I missed the 5 sec delay there. Next question for me is - how does
it not deadlock in the open?

igc_open()
  __igc_open(resuming=false)
    if (!resuming)
      pm_runtime_get_sync(&pdev->dev);

igc_resume()
  rtnl_lock()

