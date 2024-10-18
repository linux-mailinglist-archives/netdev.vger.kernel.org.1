Return-Path: <netdev+bounces-137133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 189509A47E0
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 22:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BEBB1F2124F
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 20:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A79A1DA0EB;
	Fri, 18 Oct 2024 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWhee3dy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9CF18C35F
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283129; cv=none; b=cEl/f7fXtuqkQDMg9QcNkF4enPYItUAygYjzlJwxAgs4Rz5NcWpf7vNw6JpA25ssa7WqgzESc2A1M147HiQGTJXWIiOMr+p4hWT9+ZEvJKcC4fyvt/dFrINRljTIReTtN9bK41noX7ra0tNy0/EDwq4U/gANQ+Dw1LCQHuDCH9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283129; c=relaxed/simple;
	bh=OUnvg0wD5PJrKQJNYvFgcNTAiqsb76J4fRDN4ePuGb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+VniX9w+uxQW+b7LOqhSq66u3356JEghLgSPrhHmwVPky1HVpLaHasmCwWe2Dke3/ItnLB4ekYxEZnnA+Ho9VGDxKB+cFIIc8r3RuDaumehMBrIkudpANjYCh+o89YoU99HZvGGXM4uqMFiL3hcahzCMaoVEvENbEmXY8qtkWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWhee3dy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75772C4CEC3;
	Fri, 18 Oct 2024 20:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729283129;
	bh=OUnvg0wD5PJrKQJNYvFgcNTAiqsb76J4fRDN4ePuGb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SWhee3dyCY0qWZs3bHXl5eDS1cbC3RbJI6lFQJGoSmDCO3lOzucBPfJM+wkITeZMn
	 BJdQ7/F9JKAZvLv/S8ILBirL9+OUSxSYhpSx+KC5oyVXzYZfOfNxABDkdihlpd5ocD
	 Ux+sxCP0fc5MU4hh9HwXnnjwfux8GXedrsmg2jb+mJb3dMfIPLY+6DmXiTLaEV6l93
	 adPLOJxlUvJS+VAWsoCW+ubx06Diwthok2cuCQ7OpNoz1JDw8BuKj38YNCu7azywxY
	 pt3TpbWx3yr1V6TcIgFgcYhuRbKU/3iE2vAlsZheo7XmSL8V3OS92bRh/kZbPu9hw5
	 0b0V/H8feWZzw==
Date: Fri, 18 Oct 2024 21:25:25 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Dan Nowlin <dan.nowlin@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH iwl-next v2 1/2] ice: refactor "last" segment of DDP pkg
Message-ID: <20241018202525.GE1697@kernel.org>
References: <20241003001433.11211-4-przemyslaw.kitszel@intel.com>
 <20241003001433.11211-5-przemyslaw.kitszel@intel.com>
 <20241017100659.GD1697@kernel.org>
 <f902994c-6f8d-42b5-84d5-c9b277cd2b3a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f902994c-6f8d-42b5-84d5-c9b277cd2b3a@intel.com>

On Fri, Oct 18, 2024 at 02:06:27PM +0200, Przemek Kitszel wrote:
> On 10/17/24 12:06, Simon Horman wrote:
> > On Thu, Oct 03, 2024 at 02:10:31AM +0200, Przemek Kitszel wrote:
> > > Add ice_ddp_send_hunk() that buffers "sent FW hunk" calls to AQ in order
> > > to mark the "last" one in more elegant way. Next commit will add even
> > > more complicated "sent FW" flow, so it's better to untangle a bit before.
> > > 
> > > Note that metadata buffers were not skipped for NOT-@indicate_last
> > > segments, this is fixed now.
> > > 
> > > Minor:
> > >   + use ice_is_buffer_metadata() instead of open coding it in
> > >     ice_dwnld_cfg_bufs();
> > >   + ice_dwnld_cfg_bufs_no_lock() + dependencies were moved up a bit to have
> > >     better git-diff, as this function was rewritten (in terms of git-blame)
> > > 
> > > CC: Paul Greenwalt <paul.greenwalt@intel.com>
> > > CC: Dan Nowlin <dan.nowlin@intel.com>
> > > CC: Ahmed Zaki <ahmed.zaki@intel.com>
> > > Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > > Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > 
> > Hi Przemek,
> > 
> > Some minor feedback from my side.
> 
> Thank you for reaching out!
> 
> > > +static bool ice_is_buffer_metadata(struct ice_buf_hdr *buf)
> > > +{
> > > +	return le32_to_cpu(buf->section_entry[0].type) & ICE_METADATA_BUF;
> > 
> > I see this is moving existing logic around.
> > And I see that this is a no-op on LE systems.
> > But it might be nicer to perform the byte-order conversion on the constant.
> 
> As far as I remember, for this driver we always do have binary-arith
> constants (flags, masks, etc) in CPU-order, so do as I did.
> 
> I could imagine keeping all such constants in HW-order, and such
> approach could potentially set the boundary for byte-order conversions
> to be better expressed/illustrated.
> 
> For new drivers, I will still think more about unit-test-abilty instead,
> and those will be easiest with as much constants expressed in CPU-order.
> 
> No strong opinion here anyway, and I think we agree that it's most
> important to be consistent within the driver/component. I manually
> sampled that for ice, but I don't have a proof.

Yes, we agree. And I also have no strong opinion on this.
So lets leave things as you have them.

...

> > > @@ -1454,17 +1459,16 @@ ice_dwnld_sign_and_cfg_segs(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr,
> > >   	}
> > >   	count = le32_to_cpu(seg->signed_buf_count);
> > > -	state = ice_download_pkg_sig_seg(hw, seg);
> > > +	state = ice_download_pkg_sig_seg(ctx, seg);
> > >   	if (state || !count)
> > >   		goto exit;
> > >   	conf_idx = le32_to_cpu(seg->signed_seg_idx);
> > >   	start = le32_to_cpu(seg->signed_buf_start);
> > > -	state = ice_download_pkg_config_seg(hw, pkg_hdr, conf_idx, start,
> > > -					    count);
> > > -
> > > +	return ice_download_pkg_config_seg(ctx, pkg_hdr, conf_idx, start, count);
> > 
> > This changes the conditions under which this function sets
> > ctx->err, which is then changed again by the following patch.
> > Is that intentional?
> > 
> > >   exit:
> > > +	ctx->err = state;
> 
> This line is unusual as it changes ctx->err from ctx user code.
> ctx itself updates @err only on new error, it uses "retained error"
> style of API (that I'm clearly a fan of ;))
> 
> Next commit replaces the last (successful) write (via ctx) of ddp,
> and error return from new path would result in
> "ctx->err = ctx->err" update. Not clear, not intentional, not harmful.
> I will update code to leave less space for confusion.

Thanks for the clarification, much appreciated.

...

