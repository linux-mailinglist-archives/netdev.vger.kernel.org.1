Return-Path: <netdev+bounces-239472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AF0C68A3A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 625AA4EE228
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7952526FDBF;
	Tue, 18 Nov 2025 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HH8mv5Ae"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB8C25D216;
	Tue, 18 Nov 2025 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763459153; cv=none; b=H6VWcE6cJbOLIjLAG31/SbDfNZZtHker6AvX7GzOFPMCceZzY5HF4VJKv/Ro9UyLkBsWSgIbi8j5GjwUhRXIaQ4WVPHwiQMlUJGoaga6ZZvvaH6ybh5xWKef3KZ8+BlPkif2Nj8CXBiR24hDCaHi8UAFUjV491WfMh+UPCU5mWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763459153; c=relaxed/simple;
	bh=ZnIb+vqSEb7lTYH4cwtyQNe5tMNyAgxBs1z9v9LIcEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhOxr+fqS+CFZ800S53l/E9q0uUQ9u8theXcpdcX6KirtzD7K2V9wAykea994LR3PQNznoM/iUcB9xjmEj7ayMklc/Z8Igw0p9A9YcSqGaclB32eAL37UbT/MNl1oC0IA4oBiYSm+leA56FTugehSrzcl3BJhH7XNChnIBzJTgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HH8mv5Ae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2394EC19423;
	Tue, 18 Nov 2025 09:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763459152;
	bh=ZnIb+vqSEb7lTYH4cwtyQNe5tMNyAgxBs1z9v9LIcEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HH8mv5Ae1sJ31byHFmgoo7ZVA8jAGJh+6T65S3oBFkfsWKU3xv9d0dnXzQRvtckJv
	 F4JESZa2RZDzcYQLkftLyvQxDtP+6muYlnAoiUR9LzrCvrOfqJBizbrCqYOhlbMc0O
	 ll8MGiw5coI7U/ZHMvY7BQ0vQVjPEGP4BBiLFx9jeoEInyBDLlp9g/d99zkRF0wjaD
	 gl/cLYMorxLiuBoYXYtgFHG20TXgfuxpNwkETpJqQduAJr4mZHjLQX5N4chsfFfEv8
	 3J4DhdkHJWSB8RCnkTRVMZTZxGc16Cqz59S6+uRdfjDZgjChWVq/JnynyyrKzyxcoV
	 MbpuoSkwCzEAg==
Date: Tue, 18 Nov 2025 09:45:45 +0000
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
Message-ID: <aRxASQDUgfhKo6ki@horms.kernel.org>
References: <20251112193435.2096-2-danielj@nvidia.com>
 <20251112193435.2096-6-danielj@nvidia.com>
 <aRtYgplAuUnCxj2U@horms.kernel.org>
 <0483aaba-0b93-41d7-bf09-5430b5520395@nvidia.com>
 <aRuRGD-d7kImAKb3@horms.kernel.org>
 <8b4325db-4237-46fb-aa54-bda65168f016@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b4325db-4237-46fb-aa54-bda65168f016@nvidia.com>

On Mon, Nov 17, 2025 at 03:21:08PM -0600, Dan Jurgens wrote:
> On 11/17/25 3:18 PM, Simon Horman wrote:
> > On Mon, Nov 17, 2025 at 11:49:54AM -0600, Dan Jurgens wrote:
> >> On 11/17/25 11:16 AM, Simon Horman wrote:
> >>> On Wed, Nov 12, 2025 at 01:34:28PM -0600, Daniel Jurgens wrote:
> > 
> > ...
> > 
> >>>> +	for (i = 0; i < ff->ff_mask->count; i++) {
> >>>> +		if (sel->length > MAX_SEL_LEN) {
> >>>> +			err = -EINVAL;
> >>>> +			goto err_ff_action;
> >>>> +		}
> >>>> +		real_ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
> >>>> +		sel = (void *)sel + sizeof(*sel) + sel->length;
> >>>> +	}
> >>>
> >>> Hi Daniel,
> >>>
> >>> I'm not sure that the bounds checking in the loop above is adequate.
> >>> For example, if ff->ff_mask->count is larger than expected.
> >>> Or sel->length returns MAX_SEL_LEN each time then it seems
> >>> than sel could overrun the space allocated for ff->ff_mask.
> >>>
> >>> Flagged by Claude Code with https://github.com/masoncl/review-prompts/
> >>>
> >>
> >> I can also bound the loop by VIRTIO_NET_FF_MASK_TYPE_MAX. I'll also
> >> address your comments about classifier and rules limits on patch 7 here,
> >> by checking the rules and classifier limits are > 0.
> > 
> > Thanks.
> > 
> > I think that even if the loop is bounded there is still (a much smaller)
> > scope for an overflow. This is because selectors isn't large enough for
> > VIRTIO_NET_FF_MASK_TYPE_MAX entries if all of them have length ==
> > MAX_SEL_LEN.
> > 
> >>
> >> I'll wait to push a new version until I hear back from Michael about the
> >> threading comment he made on the cover letter.
> >>
> 
> I actually moved the if (real_ff_mask_size > ff_mask_size) check into
> the loop, before updating the selector pointer.

Sounds good, thanks.

