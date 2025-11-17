Return-Path: <netdev+bounces-239246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A347CC66408
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 22:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E19BA4E7A4F
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 21:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ECB31A55E;
	Mon, 17 Nov 2025 21:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYjOMSOO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA0F265621;
	Mon, 17 Nov 2025 21:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763414304; cv=none; b=InY52UStShYepthTZggF9bTbAv2YlwJOfvCyk1ksQcy9AKaQ/1/JF8g9cY4PBWvmR0hyeQxdWylbWdct1Cw/URJzsCzcH05/DA4Fcet0KxtKl0bsfnwF3RL3CaPAxbjJEFyY9nWlOu3YfpKh0XhLkEDfvQti8Tmc3QelRb4srx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763414304; c=relaxed/simple;
	bh=s9NJSnnIjp3k6gOrnjt/F3iXufnlnMDqC8rDPNES57A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8epBob92awwDPRPr9mGThDF9LyOWYFYrR+Be9bNMmuylNe0dJ33nXWSBPf5cOPdZrTET9abr8icsNUe8eGVsIwiuTBRoSehThy8jtmcPBscyVxHxQ0ZvyzbxcPGjWLhJhRPew3iFINczBuRqVjLjSoc5h1c1bnCWjtyHU1ms0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYjOMSOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F99C4CEF5;
	Mon, 17 Nov 2025 21:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763414303;
	bh=s9NJSnnIjp3k6gOrnjt/F3iXufnlnMDqC8rDPNES57A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYjOMSOOO0Zo4vFEHP0j+f8ZhUv62zdlh7kbeemU0EyCg0OW/N+qIroVyYV0tNPJA
	 q4LCIKf3etWgUouF439HAQmduH4lDS9COnrduDOmnyzpXP+20EHoCnSnFvQk+Al16Z
	 OaqQcaEp5rxj0nIkghsCSd6JSNhpnikzSOWjwIzLpeZReNasQQkY6pWVG1TSVqCXv3
	 h6EoN7w6hXLjgv0MruTwDk0WW8yHGUk9Y/jwlcjTBqwIKIJPmKq0bgzDdfNShR94Hx
	 tkSa5Q0oVBc87DS9aW3f+5ZHJGER08fkeXRZDN8w5UmqczcJbNvctkqxADO/86AIaK
	 fWjeEYIElU7/w==
Date: Mon, 17 Nov 2025 21:18:16 +0000
From: Simon Horman <horms@kernel.org>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v10 05/12] virtio_net: Query and set flow filter
 caps
Message-ID: <aRuRGD-d7kImAKb3@horms.kernel.org>
References: <20251112193435.2096-2-danielj@nvidia.com>
 <20251112193435.2096-6-danielj@nvidia.com>
 <aRtYgplAuUnCxj2U@horms.kernel.org>
 <0483aaba-0b93-41d7-bf09-5430b5520395@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0483aaba-0b93-41d7-bf09-5430b5520395@nvidia.com>

On Mon, Nov 17, 2025 at 11:49:54AM -0600, Dan Jurgens wrote:
> On 11/17/25 11:16 AM, Simon Horman wrote:
> > On Wed, Nov 12, 2025 at 01:34:28PM -0600, Daniel Jurgens wrote:

...

> >> +	for (i = 0; i < ff->ff_mask->count; i++) {
> >> +		if (sel->length > MAX_SEL_LEN) {
> >> +			err = -EINVAL;
> >> +			goto err_ff_action;
> >> +		}
> >> +		real_ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
> >> +		sel = (void *)sel + sizeof(*sel) + sel->length;
> >> +	}
> > 
> > Hi Daniel,
> > 
> > I'm not sure that the bounds checking in the loop above is adequate.
> > For example, if ff->ff_mask->count is larger than expected.
> > Or sel->length returns MAX_SEL_LEN each time then it seems
> > than sel could overrun the space allocated for ff->ff_mask.
> > 
> > Flagged by Claude Code with https://github.com/masoncl/review-prompts/
> > 
> 
> I can also bound the loop by VIRTIO_NET_FF_MASK_TYPE_MAX. I'll also
> address your comments about classifier and rules limits on patch 7 here,
> by checking the rules and classifier limits are > 0.

Thanks.

I think that even if the loop is bounded there is still (a much smaller)
scope for an overflow. This is because selectors isn't large enough for
VIRTIO_NET_FF_MASK_TYPE_MAX entries if all of them have length ==
MAX_SEL_LEN.

> 
> I'll wait to push a new version until I hear back from Michael about the
> threading comment he made on the cover letter.
> 

