Return-Path: <netdev+bounces-96588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A29748C6900
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 16:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540B51F232AE
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 14:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23CB15572A;
	Wed, 15 May 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMyAtTgP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFE357CA1
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715784631; cv=none; b=doCFpa+Hn6dWHSq2zuoDi3uyivZrod47OnwPR4APGkzY+9mQMKKABPYNbi3raf39nKDyt3aPpwJc2YwTUx3kgD4YabUC9X+M+NL9gUUEGRoJYGPHQJn5FPqCnP1/ndybAY/VSv6rC36uuOAlCGievq6i1msFvwB51Gx6N/ecka8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715784631; c=relaxed/simple;
	bh=5pVDRYcEGwTDyJtqBQHfEEe8J0j0socGcFI/5Zmfqjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfXUUq1PfAcDSyqypXvDDJr4J23zAzjA0cYrD0XJ6+NpaV0V/E1ii2nlFVpEeDlk6xPGiuIFOWTmyG+dmGS11BTZEGHCrRJpXnQQ5+tzRf84bHSjCtzRBBnJQbSsaOoE8c+EOl3f9pi2eUma+xK/t2kDu5GL7Rs4n7Vg7bcCoOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMyAtTgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5DFC116B1;
	Wed, 15 May 2024 14:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715784631;
	bh=5pVDRYcEGwTDyJtqBQHfEEe8J0j0socGcFI/5Zmfqjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AMyAtTgP8qpGMgHh0Oz+MHhxjgxPwm1hrtVoRVnCYOGeV8egl+t9bRAU/KE7gg9Iz
	 jpQxJhCyYUaL2YvK4rXKuxXgGcIiZo1+1oFNXqGu/44ZanWRaAdjsNCEqLSmOrAGaV
	 ngz6sT3RXfB5kDPpty9j9RI9jo2jwrPqHgexO6oe/iktSH4WiPVwuzY9hOssy8/QFl
	 TlX4QMgTHAY+94+ZpMkXXM04ew+MOau0DaVWK8xJ5LnEfGm8SaqrPEWeD/7rF7IboV
	 a+328sy8/QdkkrTDwOmUG30qC1mXtv1cyRtXu+F+OoS67cGVGNsZspqrK9q9SL5SUN
	 WSa4Tq+kXHbWg==
Date: Wed, 15 May 2024 15:50:27 +0100
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
Message-ID: <20240515145027.GK154012@kernel.org>
References: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
 <3130d582-a04c-4db5-b4a6-c02f213851be@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3130d582-a04c-4db5-b4a6-c02f213851be@lunn.ch>

On Wed, May 15, 2024 at 04:41:09PM +0200, Andrew Lunn wrote:
> > + * struct net_shaper_info - represents a shaping node on the NIC H/W
> > + * @metric: Specify if the bw limits refers to PPS or BPS
> > + * @bw_min: Minimum guaranteed rate for this shaper
> > + * @bw_max: Maximum peak bw allowed for this shaper
> > + * @burst: Maximum burst for the peek rate of this shaper
> > + * @priority: Scheduling priority for this shaper
> > + * @weight: Scheduling weight for this shaper
> > + */
> > +struct net_shaper_info {
> > +	enum net_shaper_metric metric;
> > +	u64 bw_min;	/* minimum guaranteed bandwidth, according to metric */
> > +	u64 bw_max;	/* maximum allowed bandwidth */
> > +	u32 burst;	/* maximum burst in bytes for bw_max */
> > +	u32 priority;	/* scheduling strict priority */
> > +	u32 weight;	/* scheduling WRR weight*/
> > +};
> 
> ...
> 
> > +	/** set - Update the specified shaper, if it exists
> > +	 * @dev: Netdevice to operate on.
> > +	 * @handle: the shaper identifier
> > +	 * @shaper: Configuration of shaper.
> > +	 * @extack: Netlink extended ACK for reporting errors.
> > +	 *
> > +	 * Return:
> > +	 * * %0 - Success
> > +	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
> > +	 *                  or core for any reason. @extack should be set to
> > +	 *                  text describing the reason.
> > +	 * * Other negative error values on failure.
> > +	 */
> > +	int (*set)(struct net_device *dev, u32 handle,
> > +		   const struct net_shaper_info *shaper,
> > +		   struct netlink_ext_ack *extack);
> 
> > + * net_shaper_make_handle - creates an unique shaper identifier
> > + * @scope: the shaper scope
> > + * @vf: virtual function number
> > + * @id: queue group or queue id
> > + *
> > + * Return: an unique identifier for the shaper
> > + *
> > + * Combines the specified arguments to create an unique identifier for
> > + * the shaper.
> > + * The virtual function number is only used within @NET_SHAPER_SCOPE_VF,
> > + * @NET_SHAPER_SCOPE_QUEUE_GROUP and @NET_SHAPER_SCOPE_QUEUE.
> > + * The @id number is only used for @NET_SHAPER_SCOPE_QUEUE_GROUP and
> > + * @NET_SHAPER_SCOPE_QUEUE, and must be, respectively, the queue group
> > + * identifier or the queue number.
> > + */
> > +u32 net_shaper_make_handle(enum net_shaper_scope scope, int vf, int id);
> 
> One thing i'm missing here is a function which does the opposite of
> net_shaper_make_handle(). Given a handle, it returns the scope, vf and
> the id.
> 
> When the set() op is called, i somehow need to find the software
> instance representing the hardware block. If i know the id, it is just
> an array access. Otherwise i need additional bookkeeping, maybe a
> linked list of handles and pointers to structures etc.
> 
> Or net_shaper_make_handle() could maybe take an addition void * priv,
> and provide a function void * net_shape_priv(u32 handle);

Hi Andrew,

I think that, initially at least, the implementation of
net_shaper_make_handle() can be fairly simple, involving packing
fields into an integer in a static manner.

As such I think implementing a helper or helpers to an to extract fields
should be trivial.

In other words, yes, I think that can be added.

