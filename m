Return-Path: <netdev+bounces-51723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5E27FBDC7
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9E51C20C65
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CDB5CD1B;
	Tue, 28 Nov 2023 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA/jJP2I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DA718E03
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 15:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605E1C433C7;
	Tue, 28 Nov 2023 15:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701184278;
	bh=5LW7XIDzN7NVZS51eMgraP8hszpDd/GWJ0WQsnN+r9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RA/jJP2IDKGm6jGhvcQfzN5tYlVn9OR5dfaZXKGTbcTMBpp97Tjjdmu/TSObCopGy
	 Vzfrbv22mHqtg7mOcq2AAyI+/OBF6o3elXu0he8CtA6J3jVkzSmCaD7kcBqYfGWitT
	 KWYqz0Uzley4PmeNQvjukMWEQ9uCq9Gx38bmZT7BijNikHm+9ZzwvSbUBhj9nomoWf
	 Be/aH8UpJTODw0elWEhR+Nfcs4r5QpdIj9Al+cqCRojKlqorEgBZjqM8A+lBEYQDln
	 Yy1gDMV7mvZoSDYNLl13RJQbCHk3npcn0V2b9IyR3lTX2M3rveinRjaJHC08vvSsme
	 u1QwIpSaQer3A==
Date: Tue, 28 Nov 2023 07:11:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
 johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
 amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v4 5/9] genetlink: introduce per-sock family
 private pointer storage
Message-ID: <20231128071116.1b6aed13@kernel.org>
In-Reply-To: <ZWWj8VZF5Puww2gm@nanopsycho>
References: <20231123181546.521488-1-jiri@resnulli.us>
	<20231123181546.521488-6-jiri@resnulli.us>
	<20231127144626.0abb7260@kernel.org>
	<ZWWj8VZF5Puww2gm@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Nov 2023 09:25:21 +0100 Jiri Pirko wrote:
> >Put the xarray pointer here directly. Plus a lock to protect the init.  
> 
> Okay, just to make this clear. You want me to have:
> 	struct xarray __rcu		*family_privs;
> 
> in struct netlink_sock, correct?
> 
> 
> Why I need a lock? If I read things correctly, skbs are processed in
> serial over one sock. Since this is per-sock, should be safe.

Okay, then add an assertion that the socket lock is held, at least.
Also, is the socket lock not held yet when the filtering happens?
Maybe the __rcu annotation isn't necessary then either?

> >The size of the per-family struct should be in family definition,
> >allocation should happen on first get automatically. Family definition  
> 
> Yes, I thought about that. But I decided to do this lockless, allocating
> new priv every time the user sets the filter and replace the xarray item
> so it could be accessed in rcu read section during notification
> processing.
> 
> What you suggest requires some lock to protect the memory being changed
> during filter set and suring accessing in in notify. But okay,
> if you insist.

Not necessarily, you can have a helper which doesn't allocate, too.
What I'm saying is that the common case for ops will be to access
the state and allocate if it doesn't exist.

How about genl_sk_family_priv() and genl_sk_has_family_priv() ?

> >should also hold a callback to how the data is going to be freed.  
> 
> If it is alloceted automatically, why is it needed?

Because priv may be a complex type which has member that need
individual fields to be destroyed (in fullness of time we also
need a constructor which can init things like list_head, but
we can defer that).

I'm guessing in your case the priv will look like this:

struct devlink_sk_priv {
	const char *nft_fltr_instance_name;
};

static void devlink_sk_priv_free(void *ptr)
{
	struct devlink_sk_priv *priv = ptr;

	kfree(priv->nft_fltr_instance_name);
}

