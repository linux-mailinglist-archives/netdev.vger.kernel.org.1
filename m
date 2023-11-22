Return-Path: <netdev+bounces-49852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F6E7F3B16
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 02:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BADCB21583
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 01:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9A6138D;
	Wed, 22 Nov 2023 01:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhjQaDiI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038C417CB
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30469C433C7;
	Wed, 22 Nov 2023 01:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700615701;
	bh=G82EVP9DV/Qqumn1DqaDYrguXwErpv6mwFl1p0/IK+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NhjQaDiIVDH/xIVggDIvwgGF4q23YDimbFX16YRqaVqwzXzQX5WpZc4aiKzmMKGxc
	 iGhTCpkZLV1JyLonwm0ydIDL5BWZ7D0pryMo73svwAU7it0O3lwklq8HIzqBYMbkuc
	 wvPkwHAScjeu46ZaH6c5bagvo6tfvVCozKY9gAaZpXsV891muiH7nJQ04tu2Ce/Rur
	 +0CvxYIMPgswSuHTCn9DDKu4my2QVKCVrE/oNJD015OxrrA5brtyJcWF97+Zl7G+MI
	 QdZQwgZmRnFzsIVF6d6jwjt6OiNMCGiaIQS5CITwcFTimwUw4601yb+qsioTTW60PZ
	 8f3Gc9xfCeRKQ==
Date: Tue, 21 Nov 2023 17:15:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>, Willem de Bruijn
 <willemb@google.com>
Cc: <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <sridhar.samudrala@intel.com>
Subject: Re: [net-next PATCH v8 02/10] net: Add queue and napi association
Message-ID: <20231121171500.0068a5bb@kernel.org>
In-Reply-To: <d696c18b-c129-41c1-8a8a-f9273da1f215@intel.com>
References: <170018355327.3767.5169918029687620348.stgit@anambiarhost.jf.intel.com>
	<170018380870.3767.15478317180336448511.stgit@anambiarhost.jf.intel.com>
	<20231120155436.32ae11c6@kernel.org>
	<68d2b08c-27ae-498e-9ce9-09e88796cd35@intel.com>
	<20231121142207.18ed9f6a@kernel.org>
	<d696c18b-c129-41c1-8a8a-f9273da1f215@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 16:08:07 -0800 Nambiar, Amritha wrote:
> > To reiterate - the thing I find odd about the current situation is that
> > we hide the queues if they get disabled by lowering ethtool -L, but we
> > don't hide them when the entire interface is down. When the entire
> > interface is down there should be no queues, right?
> 
> "When the entire interface is down there should be no queues" - 
> currently, 'ethtool --show-channels' reports all the available queues 
> when interface is DOWN

That's not the same. ethtool -l shows the configuration not 
the instantiated objects. ethtool -a will also show you the
pause settings even when cable is not plugged in.
sysfs objects of the queues are still exposed for devices which 
are down, that's true. But again, that's to expose the config.

> > Differently put - what logic that'd make sense to the user do we apply
> > when trying to decide if the queue is visible? < real_num_queues is
> > an implementation detail.
> > 
> > We can list all the queues, always, too. No preference. I just want to
> > make sure that the rules are clear and not very dependent on current
> > implementation and not different driver to driver.  
> 
> I think currently, the queue dump results when the device is down aligns 
> for both APIs (netdev-genl queue-get and ethtool show-channels) for all 
> the drivers. If we decide to NOT show queues/NAPIs (with netdev-genl) 
> when the device is down, the user would see conflicting results, the 
> dump results with netdev-genl APIs would be different from what 'ethtool 
> --show-channels' and 'ps -aef | grep napi' reports.

We should make the distinction between configuration and state of
instantiated objects clear before we get too far. Say we support
setting ring length for a specific queue. Global setting is 512,
queue X wants 256. How do we remove the override for queue X?
By setting it to 512? What if we want 512, and the default shifts
to something else? We'll need an explicit "reset" command.

I think it may be cleaner to keep queue-get as state of queues,
and configuration / settings / rules completely separate.

Am I wrong? Willem?

