Return-Path: <netdev+bounces-52161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C037FDAAB
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D391F20F72
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 15:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DC236B12;
	Wed, 29 Nov 2023 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeMf9nWT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D1D36B05
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 15:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09283C433C7;
	Wed, 29 Nov 2023 15:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701270119;
	bh=pFKD+BBaxjpUYB01WZU0Nqblr+lAq6HW8bYlFoSIjTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aeMf9nWTUJXSqhwLMclh2RMNi3oFE0FlQNKN59TeqXZU7wOq4vJGG3Xo31gJ/JlyY
	 bsF5cKDK0Vf9BwQn2nTGfQgS2ARU6BYG4VGpRobaiT4chhakXVcWQAAiglIyGq6F08
	 5fvg4etV++5f4/lBGhsC5BHuGw/O17j/EY5Sl2gVIDOpVQMoPEp4OSE1U+SiHr5EbC
	 KIe/qI5zyHEZtPQYjXDYlOhEIICIMcQu90YBCjXR0L8OzaBPVOGKu3CSjJLRcb0JXO
	 dpAIbCA5b3msNpeCleI+q0Y2oz5+XH0dInong27ItxT6rOrdZXOlVL6/DQ4/DMb2yW
	 CK74TUmA2zf2A==
Date: Wed, 29 Nov 2023 07:01:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
 johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
 amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v4 5/9] genetlink: introduce per-sock family
 private pointer storage
Message-ID: <20231129070157.41d17b26@kernel.org>
In-Reply-To: <ZWdDw2EJJbv6ecJ5@nanopsycho>
References: <20231123181546.521488-1-jiri@resnulli.us>
	<20231123181546.521488-6-jiri@resnulli.us>
	<20231127144626.0abb7260@kernel.org>
	<ZWWj8VZF5Puww2gm@nanopsycho>
	<20231128071116.1b6aed13@kernel.org>
	<ZWYP3H0wtaWxwneR@nanopsycho>
	<20231128083605.0c8868cd@kernel.org>
	<ZWdDw2EJJbv6ecJ5@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 14:59:31 +0100 Jiri Pirko wrote:
> Tue, Nov 28, 2023 at 05:36:05PM CET, kuba@kernel.org wrote:
> >No, you can do exact same thing, just instead of putting the string
> >directly into the xarray you put a struct which points to the string.  
> 
> I'm lost. What "string" are you talking about exactly? I'm not putting
> any string to xarray.
> 
> In the existing implementation, I have following struct:
> struct devlink_obj_desc {
>         struct rcu_head rcu;
>         const char *bus_name;
>         const char *dev_name;
>         unsigned int port_index;
>         bool port_index_valid;
>         long data[];
> };
> 
> This is the struct put pointer to into the xarray. Pointer to this
> struct is dereferenced under rcu in notification code and the struct
> is freed by kfree_rcu().

Sorry I was looking at patch 8 which has only:

+struct devlink_obj_desc {
+	struct rcu_head rcu;
+	const char *bus_name;
+	const char *dev_name;
+	long data[];
+};

that's basically a string and an rcu_head, that's what I meant.

> >Core still does the kfree of the container (struct devlink_sk_priv).
> >But what's inside the container struct (string pointer) has to be
> >handled by the destructor.
> >
> >Feels like you focus on how to prove me wrong more than on
> >understanding what I'm saying :|  
> 
> Not at all, I have no reason for it. I just want to get my job done
> and I am having very hard time to understand what you want exactly.

Sockets may want to hold state for more than filtering.
Try to look past your singular use case.

