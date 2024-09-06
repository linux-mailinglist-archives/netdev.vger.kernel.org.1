Return-Path: <netdev+bounces-125753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4032B96E745
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 03:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D802812FC
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 01:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D90DDC1;
	Fri,  6 Sep 2024 01:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHFyVXFP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D478D1799F
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 01:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725585923; cv=none; b=uXVycRERAIfufAVQURjVRORNSFRppe0+Y/FBMnX7EW7FCgDws8wA49k2nQR6MbPKT+YzZXioL+AkryfVDg9ponBduklQmwemXER+H9D3zSA8JBPHMYWt/tyI53lDpCjFpnlHDZH3YvU/VCNTuau1DbUI/Xqf2daJthlwctgtC+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725585923; c=relaxed/simple;
	bh=P6bXWKTaCR/pN+LWeUeLyDHVBJzI92h7jxSDlvKveRg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PqFFefRLUxgVJW6UuM4iZopqcJaOSmZeqVpdVcgI4C9sOgetlzq/BPVCdv4EG4xvdl3ciq/mghDoaXYMI8l8lIbhoglCJBAID8L6+oTyDI/zOMw61UiGvJQQSiBMTvOunFY40Emm1OzxNxv7U9aV0QfmuNolGICi+N/L+sMUMTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHFyVXFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C30C4CEC3;
	Fri,  6 Sep 2024 01:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725585923;
	bh=P6bXWKTaCR/pN+LWeUeLyDHVBJzI92h7jxSDlvKveRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SHFyVXFPMvi5IWC8kQmNeTEDvYiGsi6+8v5zJkRC4i2X2qZUrbJob4Bd6BuvALjIc
	 DQaO7cb2WcmEEDrizwKEDCnzLYAVQ6kbb6IsfYjoFx7CcGSSIbGjo61c9siOlV3fDb
	 J9XfasikF8adixh6EIetrqadgC9WVTlF6n9nNBTQ/B8tVDZRlr0tqJgvyeYUvVLIdH
	 HMLgPN7iY4A35TXxYYtZfGCq6JhvwNfWr3pyH4be1q5O/xF/bQUhCqrL+AdUnqqRkA
	 ad7I8dCuqHG3YNGJuB7zPDQA39yqExr+0KkhH8rtcysIg0P+oELUFpq0fJJbF3Jdxf
	 q/uHaUIUBVStA==
Date: Thu, 5 Sep 2024 18:25:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com
Subject: Re: [PATCH v6 net-next 07/15] net-shapers: implement shaper cleanup
 on queue deletion
Message-ID: <20240905182521.2f9f4c1c@kernel.org>
In-Reply-To: <8fba5626-f4e0-47c3-b022-a7ca9ca1a93f@redhat.com>
References: <cover.1725457317.git.pabeni@redhat.com>
	<160421ccd6deedfd4d531f0239e80077f19db1d0.1725457317.git.pabeni@redhat.com>
	<20240904183329.5c186909@kernel.org>
	<8fba5626-f4e0-47c3-b022-a7ca9ca1a93f@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Sep 2024 20:02:38 +0200 Paolo Abeni wrote:
> > The dev->lock has to be taken here, around those three lines,
> > and then set / group must check QUEUE ids against
> > dev->real_num_tx_queues, no? Otherwise the work
> > net_shaper_set_real_num_tx_queues() does is prone to races?  
> 
> Yes, I think such race exists, but I'm unsure that tacking the lock 
> around the above code will be enough.

I think "enough" will be subjective. Right now patch 7 provides no real
guarantee.

> i.e. if the relevant devices has 16 channel queues the set() races with 
> a channel reconf on different CPUs:
> 
> CPU 1						CPU 2
> 
> set_channels(8)
> 
> driver_set_channel()
> // actually change the number of queues to
> // 8, dev->real_num_tx_queues is still 16
> // dev->lock is not held yet because the
> // driver still has to call
> // netif_set_real_num_tx_queues()
> 						set(QUEUE_15,...)
> 						// will pass validation
> 						// but queue 15 does not
> 						// exist anymore

That may be true - in my proposal the driver can only expect that once
netif_set_real_num_tx_queues() returns core will not issue rate limit
ops on disabled queues. Driver has to make sure rate limit ops for old
queues are accepted all the way up to the call to set_real and ops for
new queues are accepted immediately after.

Importantly, the core's state is always consistent - given both the
flushing inside net_shaper_set_real_num_tx_queues() and proposed check
would be under netdev->lock.

For the driver -- let me flip the question around -- what do you expect
the locking scheme to be in case of channel count change? Alternatively
we could just expect the driver to take netdev->lock around the
appropriate section of code and we'd do:

void net_shaper_set_real_num_tx_queues(struct net_device *dev, ...)
{
	...
	if (!READ_ONCE(dev->net_shaper_hierarchy))
		return;

	lockdep_assert_held(dev->lock);
	...
}

I had a look at iavf, and there is no relevant locking around the queue
count check at all, so that doesn't help..

> Acquiring dev->lock around set_channel() will not be enough: some driver 
> change the channels number i.e. when enabling XDP.

Indeed, trying to lock before calling the driver would be both a huge
job and destined to fail.

> I think/fear we need to replace the dev->lock with the rtnl lock to 
> solve the race for good.

Maybe :( I think we need *an* answer for:
 - how we expect the driver to protect itself (assuming that the racy
   check in iavf_verify_handle() actually serves some purpose, which
   may not be true);
 - how we ensure consistency of core state (no shapers for queues which
   don't exist, assuming we agree having shapers for queues which
   don't exist is counter productive).

Reverting back to rtnl_lock for all would be sad, the scheme of
expecting the driver to take netdev->lock could work?
It's the model we effectively settled on in devlink.
Core->driver callbacks are always locked by the core,
for driver->core calls driver should explicitly take the lock
(some wrappers for lock+op+unlock are provided).

