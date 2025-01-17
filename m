Return-Path: <netdev+bounces-159390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB12A15656
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4ED188C09D
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FAE1A2630;
	Fri, 17 Jan 2025 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMwUEUdb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080831A0BED;
	Fri, 17 Jan 2025 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737137389; cv=none; b=Nw5BJkzJkwaUPamvCT6fLaropGZEqxZnFOpHQuDaKwdMBu9KchYo+ljVKw1QjO7uQ7BgLekpAMZAC21lxCuEt/7X5IkFwyqjN2glgAqXJl165ZrPMQeDPLIqg35gonHuwG4x77pxmYsZUdS1DGgqLt74BOzITd0IjuA2SgWK2t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737137389; c=relaxed/simple;
	bh=dRX2pNbw1PNaq1oqbndws4A+VHEbP22T4MdAdAJq4Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V78JUtRYWFy7pu4+cGqEf5XP17UtJDa6k8xjn6Oi4Rt1h+w9jUvYWG7Yn0NNYbJGXyRCdHZN2n8I5KeNIKy1zeE2xSGpoEcoJvzG7rr+DtoJbWGDGqL97csbsS94SXTHquypXhp0rp3P0McEsK+njEGgUAPTwSj8VVeu++RZoPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMwUEUdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B455C4CEDD;
	Fri, 17 Jan 2025 18:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737137388;
	bh=dRX2pNbw1PNaq1oqbndws4A+VHEbP22T4MdAdAJq4Gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UMwUEUdb/oXv+XgGXtUncYQzxoMCOIR35I/vTqOfK/aOFGFvkDpdihtpxn8GYmMxM
	 fmookhl0/WwzdsAixh8dMP5b6O2BRRc+FfgnN0HvoZstMsA637EI9r9JvAjuYHtB7b
	 MCPAl84fGKkSOF5dQd8SNjMCbFAN70Xywf6RpsrdsRulHYejl25xS2DzDkjctO14qz
	 W/TzCZvcJeMReeADT01MYuCpegjH7pq1RjwtAsg+x5C8Q5osp+Xq3KA4HXfmAhxWjI
	 j/8Uw859aXDqjM+iYt60bWmWi1k4cJ9P4O+vHlhh2DHJ2jKc5qMHjOBCy+aL2PlKkT
	 qPnaarytJGPyA==
Date: Fri, 17 Jan 2025 18:09:44 +0000
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: anthony.l.nguyen@intel.com, piotr.kwapulinski@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	michal.swiatkowski@linux.intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: Re: [PATCH v2 net-next] ixgbe: Fix endian handling for ACI
 descriptor registers
Message-ID: <20250117180944.GS6206@kernel.org>
References: <20250115034117.172999-1-dheeraj.linuxdev@gmail.com>
 <20250116162157.GC6206@kernel.org>
 <fe142f22-caff-4cab-9f6f-56d55e63f210@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe142f22-caff-4cab-9f6f-56d55e63f210@intel.com>

On Fri, Jan 17, 2025 at 11:01:22AM +0100, Przemek Kitszel wrote:
> On 1/16/25 17:21, Simon Horman wrote:
> > On Wed, Jan 15, 2025 at 09:11:17AM +0530, Dheeraj Reddy Jonnalagadda wrote:
> > > The ixgbe driver was missing proper endian conversion for ACI descriptor
> > > register operations. Add the necessary conversions when reading and
> > > writing to the registers.
> > > 
> > > Fixes: 46761fd52a88 ("ixgbe: Add support for E610 FW Admin Command Interface")
> > > Closes: https://scan7.scan.coverity.com/#/project-view/52337/11354?selectedIssue=1602757
> > > Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> > 
> > Hi Dheeraj,
> > 
> > It seems that Sparse is not very happy about __le32 values appearing
> > where u32 ones are expected. I wonder if something like what is below
> > (compile tested only!) would both address the problem at hand and
> > keep Sparse happy (even if negting much of it's usefulness by using casts).
> > 
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
> > index 6639069ad528..8b3787837128 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
> > @@ -150,6 +150,9 @@ static inline void ixgbe_write_reg(struct ixgbe_hw *hw, u32 reg, u32 value)
> >   }
> >   #define IXGBE_WRITE_REG(a, reg, value) ixgbe_write_reg((a), (reg), (value))
> 
> Simon,
> 
> As all ixgbe registers are LE, it would be beneficial to change
> ixgbe_write_reg(), as @value should be __le32, (perhaps @reg too).
> Similar for 64b.

Understood, sounds good to me.

> This clearly would not be a "fix" material, as all call sites should be
> examined to check if they conform.

Sure, that also seems reasonable.
But do you also think a more minimal fix is in order?

> 
> > +#define IXGBE_WRITE_REG_LE32(a, reg, value) \
> > +	ixgbe_write_reg((a), (reg), (u32 __force)cpu_to_le32(value))
> > +
> 

