Return-Path: <netdev+bounces-96591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB1F8C6911
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 16:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 136B8B211CD
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 14:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077721553A8;
	Wed, 15 May 2024 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqrGtocc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D480C1E480
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785008; cv=none; b=HtsKDPJDSPnliFagf7i3TuURuy1JIW6bfgPk/RLy9BD1XUUoHi7k7c73j6eNuws6mnF7/vUj9kB/ZuXAGdTNpJy5j0yqjuuKQaYMM2ygI9/mMPQeAtcgoRoVjfyosIRHetMbc3AWVXIaQCjTfL/U0eRDjjW6xLdNo1zfiH/XhGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785008; c=relaxed/simple;
	bh=RFkL11pfTPku1nR02FTH7pW7etzGfiQ7u8dwNZ670wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mE1cI9nGAevXhzqZZ9jbf1fUBpqE4VhrOksgGThvoXeC/8PyMkzh9VzshorPfPc5lKpL2YxhOYeoRa6wRDh1FEr6GEDP+pAxXsFtcJBDSj/08mIMg50WlARs+Iym4Zvlm+SuJ7GAp/ToSaObdrVWCiIl6EglDiaBFrmOaHGjLgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqrGtocc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B77C116B1;
	Wed, 15 May 2024 14:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715785008;
	bh=RFkL11pfTPku1nR02FTH7pW7etzGfiQ7u8dwNZ670wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qqrGtoccr6IEhIBwR/cQtt8+jCh93yPQ2KDBcq8O5rTyVC6GTFSLPlQ3ZQlE9bWXV
	 UexPthtKuQrJt6IGIvsOyC7Hd+fO7mVaWfxFjSS5lo3VTmCZ+yUZERkhIkVydkyI29
	 8uO8OdFRF6jOIZfiPAR+fyQAMGxJhHbnzQEMLIiXg4WrzvhBwOJDz5f9HHxwBdAAg8
	 4piWMB4ryEi4NdXLlz09bhDt4MQD3pq+hoqDQ8/lmZwZpfpuMjlwDZ1XHx+yoQJ/TE
	 ziRb/LGmrkBUsh483gd6wqKsgoctu4HGMR0LS1K7EdSCqe4MeS6c3YwHKw/a17V1q3
	 gLblT57zdbVIQ==
Date: Wed, 15 May 2024 15:56:44 +0100
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
Message-ID: <20240515145644.GL154012@kernel.org>
References: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
 <f6d15624-cd25-4484-9a25-86f08b5efd51@lunn.ch>
 <e2cbbbc416700486e0b4dd5bc9d80374b53aaf79.camel@redhat.com>
 <9dd818dc-1fef-4633-b388-6ce7272f9cb4@lunn.ch>
 <f7fa91a89f16e45de56c1aa8d2c533c6f94648ba.camel@redhat.com>
 <a0ada382-105a-4994-ad0f-1a485cef12c4@lunn.ch>
 <db51b7ccff835dd5a96293fb84d527be081de062.camel@redhat.com>
 <20240515095147.GB154012@kernel.org>
 <79767d80-4f9c-4eec-8e9d-32ea94d0e06a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79767d80-4f9c-4eec-8e9d-32ea94d0e06a@lunn.ch>

On Wed, May 15, 2024 at 04:19:57PM +0200, Andrew Lunn wrote:
> > > If I read correctly, allowing each NIC to expose it's own different
> > > starting configuration still will not solve the problem for this H/W to
> > > switch from WRR to SP (and vice versa).
> 
> I also suspect this is not unique to this hardware. I've not looked at
> other SOHO switches, but it is reasonably common to have different
> queues for different priority classes, and then one shaper for the
> overall port rate.

Yes, understood. It's about creating a sufficiently general solution.
And the HW you have in mind has lead us to see some shortcomings
of the proposed API in that area. Because it drew a bit too much on
understanding of a different category of HW.

> > > AFAICS, what would be needed there is an atomic set of operations:
> > > 'set_many' (and e.v. 'delete_many', 'create_many') that will allow
> > > changing all the shapers at once. 
> 
> Yep.
> 
> > > With such operations, that H/W could still fit the expected 'no-op'
> > > default, as WRR on the queue shapers is what we expect. I agree with
> > > Jakub, handling the complexity of arbitrary starting configuration
> > > would pose a lot of trouble to the user/admin.
> > > 
> > > If all the above stands together, I think we have a few options (in
> > > random order):
> > > 
> > > - add both set of operations: the ones operating on a single shaper and
> > > the ones operating on multiple shapers
> > > - use only the multiple shapers ops.
> > > 
> > > And the latter looks IMHO the simple/better.
> 
> I would agree, start with only multiple shaper opps. If we find that
> many implementation end up just iterating the list and dealing with
> them individually, would could pull that iterator into the core, and
> expand the ops to either/or, multiple or single.

FWIIW, this was my thinking too.

> > > int (*set)(struct net_device *dev, int how_many, const u32 *handles,
> > > 	   const struct net_shaper_info *shapers,
> > >            struct netlink_ext_ack *extack);
> > > int (*reset)(struct net_device *dev, int how_many, const u32 *handles,
> > >              struct netlink_ext_ack *extack);
> > > int (*move)(struct net_device *dev, int how_many, const u32 *handles,
> > >             const u32 *new_parent_handles,
> > > 	    struct netlink_ext_ack *extack);
> > > 
> > > An NIC with 'static' shapers can implement a dummy move always
> > > returning EOPNOTSUPP and eventually filling a detailed extack.
> 
> The extack is going to be important here, we are going to need
> meaningful error messages.

Always :)

> Overall, i think this can be made to work with the hardware i have.

Great, I think the next step is for us to propose a revised API
with multiple shaper ops in place of single shaper ops.


