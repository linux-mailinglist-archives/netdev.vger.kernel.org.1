Return-Path: <netdev+bounces-172006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082B1A4FD70
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 12:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0F5E7AA4C1
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 11:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0439D207E04;
	Wed,  5 Mar 2025 11:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uA7J1/yO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B1F1FBC94
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173497; cv=none; b=isF3Qad+w/dgYRg+WNDCCPcDugRSAnn1upgEHhvw87qAHhH2peZGT0MCbbUJVZh/TonsM7PagsJrPPSrm32cRDx61EXs5Co6e8omwoX7OlErlc9byROdn4q2/rWYJyXbc8CbUezu1Ag7Y9ZyMv2plAkdrvl3riTg/dRd+1iBbyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173497; c=relaxed/simple;
	bh=AMj0T5cjbneiIK87/JwlTZphSCgrwEa5xD0C7q8jdB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbJ+PXkutlxb7Rs9ply0Z/y7SRk32NJh5s6Vxju4vPq4C2baIXWEQdIWwz2YNoyEI+jBOMMsiLStFc0vw7zf7SCGRX73qjwBT9ag1C2a7OsOJOS729zD2Kexk/cpMyRD3xtsvPGNzb0oV03aEPMDl6GVTi5/rg9cPOSMsdlkXjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uA7J1/yO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B52BC4CEE8;
	Wed,  5 Mar 2025 11:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741173497;
	bh=AMj0T5cjbneiIK87/JwlTZphSCgrwEa5xD0C7q8jdB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uA7J1/yOxXvwwe6wJsQwf4Ewwx1aMg0LInGJab0UOxx8Skuod61OXmP+gpN97CUoR
	 OirujzcP9sgTw25TCPe5sg5KaLr2MfRVBCZ/aBUXIOQF67l9AJRKUAR0/qezkLCZw5
	 wsPfaPu8moX9RDk2HB0okM70dS3OKwxP5VBZgKet4hkKoKmpzmg2G8/7deAqIJV2Za
	 ffQCp1ElcAZXl/iCUIpjRInkPfF3Zxs/wS6eipED8MWd/N1lK5sPGuYSGSMH4Vf0/q
	 q4q1BHAd17QYALdfpd6H1vQhj9jHwb95YKojpzzhDw2T33MVaAdQ2TxIyDJdaGLxOR
	 OU2KaVlV2961w==
Date: Wed, 5 Mar 2025 11:18:14 +0000
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: Re: [iwl-net v2 5/5] ice: fix using untrusted value of pkt_len in
 ice_vc_fdir_parse_raw()
Message-ID: <20250305111814.GN3666230@kernel.org>
References: <20250225090847.513849-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250225090847.513849-8-martyna.szapar-mudlaw@linux.intel.com>
 <20250228171753.GL1615191@kernel.org>
 <68c841b7-fb5b-4c52-bd55-b98c80ad8667@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68c841b7-fb5b-4c52-bd55-b98c80ad8667@intel.com>

On Mon, Mar 03, 2025 at 11:00:35AM +0100, Przemek Kitszel wrote:
> On 2/28/25 18:17, Simon Horman wrote:
> > On Tue, Feb 25, 2025 at 10:08:49AM +0100, Martyna Szapar-Mudlaw wrote:
> > > From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> > > 
> > > Fix using the untrusted value of proto->raw.pkt_len in function
> > > ice_vc_fdir_parse_raw() by verifying if it does not exceed the
> > > VIRTCHNL_MAX_SIZE_RAW_PACKET value.
> > > 
> > > Fixes: 99f419df8a5c ("ice: enable FDIR filters from raw binary patterns for VFs")
> > > Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> > > Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
> > > ---
> > >   .../ethernet/intel/ice/ice_virtchnl_fdir.c    | 25 +++++++++++++------
> > >   1 file changed, 17 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> > > index 14e3f0f89c78..6250629ee8f9 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> > > @@ -835,18 +835,27 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
> > >   	u8 *pkt_buf, *msk_buf __free(kfree);
> > >   	struct ice_parser_result rslt;
> > >   	struct ice_pf *pf = vf->pf;
> > > +	u16 pkt_len, udp_port = 0;
> > >   	struct ice_parser *psr;
> > >   	int status = -ENOMEM;
> > >   	struct ice_hw *hw;
> > > -	u16 udp_port = 0;
> > > -	pkt_buf = kzalloc(proto->raw.pkt_len, GFP_KERNEL);
> > > -	msk_buf = kzalloc(proto->raw.pkt_len, GFP_KERNEL);
> > > +	if (!proto->raw.pkt_len)
> > > +		return -EINVAL;
> > 
> > Hi Martyna,
> > 
> > It seems to me that the use of __free() above will result in
> > kfree(msk_buf) being called here. But msk_buf is not initialised at this
> > point.
> > 
> > My suggest would be to drop the use of __free().
> > But if not, I think that in order to be safe it would be best to do this
> > (completely untested;
> > 
> > 	u8 *pkt_buf, *msk_buf __free(kfree) = NULL;
> 
> Oh yeah!, thank you Simon for catching that.
> 
> I would say "naked __free()" was harmful here.

Yes, quite.

