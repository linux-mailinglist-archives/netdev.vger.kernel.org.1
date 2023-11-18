Return-Path: <netdev+bounces-48935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED74D7F0138
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 17:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281471C20621
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 16:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360D4134D6;
	Sat, 18 Nov 2023 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2YIPmx3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE0E13AC0
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 16:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C4CC433C7;
	Sat, 18 Nov 2023 16:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700326125;
	bh=xLfVPVYs3IoAhH1xZoZKLq66qwEnEdYvEXxeOi9SulY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W2YIPmx3NSZ0gmgghABBQFxchX5ZCZ1L7ZXw33F1ntm/FevkIDWsby44/yKBExJjV
	 wEqF6rdoNRT7PmhxsoGccMnxeGXbccDjnm4yXV1/yysoUnW3jIkEUdg4nQcNJmHTTv
	 5jfG8uLmH7zgUQm6IQP+Qgl8K9tkJtXCQI+3dDZf9up+p4ko/9cQbVZguSfJp76+Lk
	 3+472ZxGq1eYpr7bcRrG4+VXu6sF+A90nDg79KaaE42e7h8+3OPqIn6+Hf2WrQnIuI
	 Ozecj8XzJQAsrXxSlEKIZLMmnttJB5NEYw0AzTCMFz5bvLyl0+auxQ7F/eP0XqhJqK
	 G2+8VjjSr4hmw==
Date: Sat, 18 Nov 2023 08:48:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Zhang, Xuejun" <xuejun.zhang@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>,
 <anthony.l.nguyen@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 <qi.z.zhang@intel.com>, Wenjun Wu <wenjun1.wu@intel.com>,
 <maxtram95@gmail.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
 "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, <pabeni@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/5] iavf: Add devlink and
 devlink rate support'
Message-ID: <20231118084843.70c344d9@kernel.org>
In-Reply-To: <bdb0137a-b735-41d9-9fea-38b238db0305@intel.com>
References: <20230727021021.961119-1-wenjun1.wu@intel.com>
	<20230822034003.31628-1-wenjun1.wu@intel.com>
	<ZORRzEBcUDEjMniz@nanopsycho>
	<20230822081255.7a36fa4d@kernel.org>
	<ZOTVkXWCLY88YfjV@nanopsycho>
	<0893327b-1c84-7c25-d10c-1cc93595825a@intel.com>
	<ZOcBEt59zHW9qHhT@nanopsycho>
	<5aed9b87-28f8-f0b0-67c4-346e1d8f762c@intel.com>
	<bdb0137a-b735-41d9-9fea-38b238db0305@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Nov 2023 21:52:49 -0800 Zhang, Xuejun wrote:
> Thanks for looking into our last patch with devlink API. Really 
> appreciate your candid review.
> 
> Following your suggestion, we have looked into 3 tc offload options to 
> support queue rate limiting
> 
> #1 mq + matchall + police
> 
> #2 mq + tbf

You can extend mqprio, too, if you wanted.

> #3 htb
> 
> all 3 tc offload options require some level of tc extensions to support 
> VF tx queue rate limiting (tx_maxrate & tx_minrate)
> 
> htb offload requires minimal tc changes or no change with similar change 
> done @ driver (we can share patch for review).
> 
> After discussing with Maxim Mikityanskiy( 
> https://lore.kernel.org/netdev/54a7dd27-a612-46f1-80dd-b43e28f8e4ce@intel.com/ 
> ), looks like sysfs interface with tx_minrate extension could be the 
> option we can take.
> 
> Look forward your opinion & guidance. Thanks for your time!

My least favorite thing to do is to configure the same piece of silicon
with 4 different SW interfaces. It's okay if we have 4 different uAPIs
(user level APIs) but the driver should not be exposed to all these
options.

I'm saying 4 but really I can think of 6 ways of setting maxrate :(

IMHO we need to be a bit more realistic about the notion of "offloading
the SW thing" for qdiscs specifically. Normally we offload SW constructs
to have a fallback and have a clear definition of functionality.
I bet most data-centers will use BPF+FQ these days, so the "fallback"
argument does not apply. And the "clear definition" when it comes to
basic rate limiting is.. moot.

Besides we already have mqprio, sysfs maxrate, sriov ndo, devlink rate,
none of which have SW fallback.

So since you asked for my opinion - my opinion is that step 1 is to
create a common representation of what we already have and feed it
to the drivers via a single interface. I could just be taking sysfs
maxrate and feeding it to the driver via the devlink rate interface.
If we have the right internals I give 0 cares about what uAPI you pick.

