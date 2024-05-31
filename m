Return-Path: <netdev+bounces-99796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 424C58D68BD
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 20:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7555289922
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 18:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA2617C20E;
	Fri, 31 May 2024 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkNB/UYd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C69176258
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179123; cv=none; b=l7XgBb7GzGPKLpEWkIffWdSBhdfGTWiwXvOjElpiSKqEIVYRiH/viI4gqVZ0aK+rBhHk9nAe8LAhvFMa1iIsslcNUpHXA6qTn/Qxbt/1+z53ouxyBERNpB75txGCTZovpeSDxOh/RGDoU5MRzjVBsubVvYcVBHkxNfUkX0yZ9vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179123; c=relaxed/simple;
	bh=2W5a4FkyIWrmZpTDIuM0HNCBwfLq0NtYDbJGbW/qSwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rq78b/AfhGKnSZn+l99QXECEcfxDTx1KoP62WSwzcH8e/GGQs9EN/qirGevSbXhR/yULHvyKorxIqevMGw/AsaCPSHs0/YbqIwNTHG60nDryU61/iW5w6T4/l8cN+fWfLM2kuU87lYceYlP3j0ssiaDxrgfQN9DKGreL3ccmnRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkNB/UYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B49C116B1;
	Fri, 31 May 2024 18:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717179123;
	bh=2W5a4FkyIWrmZpTDIuM0HNCBwfLq0NtYDbJGbW/qSwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WkNB/UYde4Vf4gq7BXTPhxovzYDYIarLppMOLcp9q/QSxifA7WHFr0sIiqliUgEa/
	 X6OVdRZsBeCD4r7VLcUao9G8cCd9GO9ifbn1uzWws4yeeduNabTJuC471LZh/3tPri
	 pilBEin7I3FpXt6EuwrBmB8hezFfuWgCN9cIj6P8u5LbksJG+mqnRg8fz2Ojmm2eLR
	 OqPZ9OHMCqtE9e4BF41mPjLsxf/wIbrEHf2iq9UFvfKlCOdaFoAMrnjY6icuQNBSGW
	 y/QDgLXvFl0fAoDd0G5gUbnL4rKJiwHjyJYwwICtZgRSsUOQ8nuCM5NksjAVwt9n29
	 yX3Dzuahiuytw==
Date: Fri, 31 May 2024 19:11:59 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, anthony.l.nguyen@intel.com,
	Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-next v2 11/13] ice: enable FDIR filters from raw
 binary patterns for VFs
Message-ID: <20240531181159.GD491852@kernel.org>
References: <20240527185810.3077299-1-ahmed.zaki@intel.com>
 <20240527185810.3077299-12-ahmed.zaki@intel.com>
 <20240531131802.GG123401@kernel.org>
 <f2cf6650-a164-4d3c-a3d9-cc57c66069a5@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2cf6650-a164-4d3c-a3d9-cc57c66069a5@intel.com>

On Fri, May 31, 2024 at 09:47:47AM -0600, Ahmed Zaki wrote:
> 
> 
> On 2024-05-31 7:18 a.m., Simon Horman wrote:
> > On Mon, May 27, 2024 at 12:58:08PM -0600, Ahmed Zaki wrote:
> > > From: Junfeng Guo <junfeng.guo@intel.com>
> > > 
> > > Enable VFs to create FDIR filters from raw binary patterns.
> > > The corresponding processes for raw flow are added in the
> > > Parse / Create / Destroy stages.
> > > 
> > > Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> > > Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> > > Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> > > Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> > 
> > ...
> > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
> > 
> > ...
> > 
> > > +/**
> > > + * ice_flow_set_parser_prof - Set flow profile based on the parsed profile info
> > > + * @hw: pointer to the HW struct
> > > + * @dest_vsi: dest VSI
> > > + * @fdir_vsi: fdir programming VSI
> > > + * @prof: stores parsed profile info from raw flow
> > > + * @blk: classification blk
> > > + */
> > > +int
> > > +ice_flow_set_parser_prof(struct ice_hw *hw, u16 dest_vsi, u16 fdir_vsi,
> > > +			 struct ice_parser_profile *prof, enum ice_block blk)
> > > +{
> > > +	u64 id = find_first_bit(prof->ptypes, ICE_FLOW_PTYPE_MAX);
> > > +	struct ice_flow_prof_params *params __free(kfree);
> > > +	u8 fv_words = hw->blk[blk].es.fvw;
> > > +	int status;
> > > +	int i, idx;
> > > +
> > > +	params = kzalloc(sizeof(*params), GFP_KERNEL);
> > > +	if (!params)
> > > +		return -ENOMEM;
> > 
> > 
> > params seems to be leaked when this function returns below,
> > in both error and non-error cases.
> 
> Shouldn't the __free guard take care of this?

Yes, sorry for missing that.

...

> > > diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> > > index 5635e9da2212..9138f7783da0 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> > > @@ -1,8 +1,8 @@
> > >   // SPDX-License-Identifier: GPL-2.0
> > >   /* Copyright (C) 2022, Intel Corporation. */
> > > -#include "ice_vf_lib_private.h"
> > >   #include "ice.h"
> > > +#include "ice_vf_lib_private.h"
> > >   #include "ice_lib.h"
> > >   #include "ice_fltr.h"
> > >   #include "ice_virtchnl_allowlist.h"
> > 
> > To me tweaking the order of includes seems to indicate
> > that something isn't quite right. Is there some sort of
> > dependency loop being juggled here?
> 
> This was needed because of the changes in ice_flow.h, struct ice_vsi is now
> used. I will check if there is a better fix.

Thanks.

...

> > > +static int
> > > +ice_vc_fdir_parse_raw(struct ice_vf *vf,
> > > +		      struct virtchnl_proto_hdrs *proto,
> > > +		      struct virtchnl_fdir_fltr_conf *conf)
> > > +{
> > > +	u8 *pkt_buf, *msk_buf __free(kfree);
> > > +	struct ice_parser_result rslt;
> > > +	struct ice_pf *pf = vf->pf;
> > > +	struct ice_parser *psr;
> > > +	int status = -ENOMEM;
> > > +	struct ice_hw *hw;
> > > +	u16 udp_port = 0;
> > > +
> > > +	pkt_buf = kzalloc(proto->raw.pkt_len, GFP_KERNEL);
> > > +	msk_buf = kzalloc(proto->raw.pkt_len, GFP_KERNEL);
> > 
> > msk_buf appears to be leaked both in when this function
> > returns for both error and non-error cases.
> 
> Same, guarded by __free. I am new to these guards myself, pls let me know if
> I am missing something.

No, sorry. Somehow I missed the __free.
I think we are good here.

