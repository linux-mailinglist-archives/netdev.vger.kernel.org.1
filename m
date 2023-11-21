Return-Path: <netdev+bounces-49817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B0E7F3915
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 23:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A051C20B2A
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 22:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C131C56476;
	Tue, 21 Nov 2023 22:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sn4mnfBG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A587E56468
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 22:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF55EC433C7;
	Tue, 21 Nov 2023 22:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700605329;
	bh=i/oGBK0tb0U2aQAU2t6My4r6tkiAtcqcvm5qwvYgd3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sn4mnfBGAb4/g81hyE+0YFaKMPZRFxdKHx1bZTvCnUw5dtPMMr6CrsQny2HRld1X0
	 B3dJJj/Fx5OMNzVgMJfxJPR2c/FPJdRPG60b/lZ2+16texi7W/Pc20Up1P0kmv0ylo
	 6iPZuEtbFoGwEabzcc+16TL1tKOu5bhtX0CPDjYVWFYMf4gmieD3KieNvY5GJo/+Gy
	 7nPTJNlDO0m/WWs9b4Iojier2V/cjhcbuMIVFnrRqvaMWUdl4I4pgap8RQPtj24Sd6
	 wkNbuUTSk7iAJEmeQbrAMiljx0vZV23/d0Bl+yF/+1hsRlqzVTrBvlAZuv+0Mr42SB
	 qqn2SWKGM2O5A==
Date: Tue, 21 Nov 2023 14:22:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <sridhar.samudrala@intel.com>
Subject: Re: [net-next PATCH v8 02/10] net: Add queue and napi association
Message-ID: <20231121142207.18ed9f6a@kernel.org>
In-Reply-To: <68d2b08c-27ae-498e-9ce9-09e88796cd35@intel.com>
References: <170018355327.3767.5169918029687620348.stgit@anambiarhost.jf.intel.com>
	<170018380870.3767.15478317180336448511.stgit@anambiarhost.jf.intel.com>
	<20231120155436.32ae11c6@kernel.org>
	<68d2b08c-27ae-498e-9ce9-09e88796cd35@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 13:26:27 -0800 Nambiar, Amritha wrote:
> So, currently, 'ethtool --show-channels' and 'ps -aef | grep napi' would 
> list all the queues and NAPIs if the device is DOWN. I think what you 
> are pointing at is:
> <ifdown and ./get-queues> should show something similar to <ethtool -L 
> eth0 combined 0 (0 is not valid... but almost to that effect) and 
> ./get-queues>.
> 
> But, 'ethtool -L' actually deletes the queues vs 'device DOWN' which 
> only disables or makes the queues inactive.
> 
> Maybe as a follow-up patch, would it be better to have an additional 
> parameter called 'state' for 'queues-get' and 'napi-get' that indicates 
> the queues or NAPIs as active/inactive. The queue/NAPI state would be 
> inherited from the device state. This way we can still list the 
> queues/NAPIs when the device is down, set/update parameter 
> configurations and then bring UP the device (in case where we stop 
> traffic and tune parameters).
> 
> Also, if in future, we have the interface to tune parameters per-queue 
> without full reset (of all queues or the device itself, as the hardware 
> supports this), the 'state' would report this for specific queue as 
> active/inactive. Maybe:
> 'queue-set' can set 'state = active' for a single queue '{"ifindex": 12, 
> "id": 0, "type": 0}' and start a queue.

To reiterate - the thing I find odd about the current situation is that
we hide the queues if they get disabled by lowering ethtool -L, but we
don't hide them when the entire interface is down. When the entire
interface is down there should be no queues, right?

Differently put - what logic that'd make sense to the user do we apply
when trying to decide if the queue is visible? < real_num_queues is
an implementation detail.

We can list all the queues, always, too. No preference. I just want to
make sure that the rules are clear and not very dependent on current
implementation and not different driver to driver.

