Return-Path: <netdev+bounces-51773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2F57FBF44
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 17:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408FE1C20C2E
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AAA4D127;
	Tue, 28 Nov 2023 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKE+2zha"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BED5D4BC
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 16:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F25C433C7;
	Tue, 28 Nov 2023 16:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701189366;
	bh=fbGEUxTUkqmvv+OMMM7Eyr0nurSpa+txjinO7jy8g48=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LKE+2zhaFgBMGLfjrY6BRT5gE8fETyNmHKTPaeKJaDpVGr/PzxyjGVssiEbTprAcl
	 gDR6y5ZdDi6ifVWb+5E1SuyshWP0oYTXlwsq7DsoQ4hX7kiDKY4YWzUF7GVI6lHSka
	 ouJG/rXTSH0+wFKQVPLyq9Mx74TS6MCRFXyWxfd2VrY1lp5cMpBLoHoTT0yBdcR5AG
	 TNrFJEaFVScLFfbJvub0QbdEr+P6sLd7HwBzeCpwuKNmPyowbqoDJbV1EiNKKrsTFK
	 XABNb1k3lvnwIJaPbe+MFdAYUANnQ9h+mq1TPy+m3PTGzH6cCEEwlvWkzF194Xy4O9
	 /8cR2CFVoE4yw==
Date: Tue, 28 Nov 2023 08:36:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
 johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
 amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v4 5/9] genetlink: introduce per-sock family
 private pointer storage
Message-ID: <20231128083605.0c8868cd@kernel.org>
In-Reply-To: <ZWYP3H0wtaWxwneR@nanopsycho>
References: <20231123181546.521488-1-jiri@resnulli.us>
	<20231123181546.521488-6-jiri@resnulli.us>
	<20231127144626.0abb7260@kernel.org>
	<ZWWj8VZF5Puww2gm@nanopsycho>
	<20231128071116.1b6aed13@kernel.org>
	<ZWYP3H0wtaWxwneR@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Nov 2023 17:05:48 +0100 Jiri Pirko wrote:
> >Not necessarily, you can have a helper which doesn't allocate, too.
> >What I'm saying is that the common case for ops will be to access
> >the state and allocate if it doesn't exist.
> >
> >How about genl_sk_family_priv() and genl_sk_has_family_priv() ?  
> 
> My point is, with what you suggest, it will look something like this:
> 
> 1) user does DEVLINK_CMD_NOTIFY_FILTER_SET
> 2) devlink calls into genetlink code for a sk_priv and inserts in xa_array
> 3) genetlink allocates sk_priv and returns back
> 4) devlink fills-up the sk_priv
> 
> 5) user does DEVLINK_CMD_NOTIFY_FILTER_SET, again
> 6) devlink calls into genetlink code for a sk_priv
> 7) genetlink returns already exising sk_priv found in xa_array
> 8) devlink fills-up the sk_priv
> 
> Now the notification thread, sees sk_priv zeroed between 3) and 4)
> and inconsistent during 4) and 8)
> 
> I originally solved that by rcu, DEVLINK_CMD_NOTIFY_FILTER_SET
> code always allocates and flips the rcu pointer. Notification thread
> always sees sk_priv consistent.
> 
> If you want to allocate sk_priv in genetlink code once, hard to use
> the rcu mechanism and have to protect the sk_priv memory by a lock.

No, you can do exact same thing, just instead of putting the string
directly into the xarray you put a struct which points to the string.

> What am I missing?

The fact that someone in the future may want to add another devlink
priv field, and if the state is basically a pointer to a string,
with complicated lifetime, they will have to suffer undoing that.

> >> If it is alloceted automatically, why is it needed?  
> >
> >Because priv may be a complex type which has member that need
> >individual fields to be destroyed (in fullness of time we also
> >need a constructor which can init things like list_head, but
> >we can defer that).
> >
> >I'm guessing in your case the priv will look like this:
> >
> >struct devlink_sk_priv {
> >	const char *nft_fltr_instance_name;
> >};
> >
> >static void devlink_sk_priv_free(void *ptr)
> >{
> >	struct devlink_sk_priv *priv = ptr;
> >
> >	kfree(priv->nft_fltr_instance_name);
> >}  
> 
> If genetlink code does the allocation, it should know how to free.
> Does not make sense to pass destructor to genetlink code to free memory
> it actually allocated :/
> 
> If devlink does the allocation, this callback makes sense. I was
> thinking about having it, but decided kfree is okay for now and
> destructor could be always introduced if needed.

Did you read the code snippet above?

Core still does the kfree of the container (struct devlink_sk_priv).
But what's inside the container struct (string pointer) has to be
handled by the destructor.

Feels like you focus on how to prove me wrong more than on
understanding what I'm saying :|

