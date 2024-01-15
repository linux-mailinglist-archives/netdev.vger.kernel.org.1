Return-Path: <netdev+bounces-63497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255AA82D76C
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 11:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01892821AE
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 10:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C635BEAFE;
	Mon, 15 Jan 2024 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daCnLaQX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF8E1426A
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 10:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA597C433F1;
	Mon, 15 Jan 2024 10:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705314764;
	bh=3KeBNlQG85wu86o1172m7DM1lMr/QxGKxX/LSwGRrmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=daCnLaQXkmIEfVvDXe4+QoHLM6XOF+t6qMVxQ1uJwSLZqtg/+GGJETaUDQ9bmzzJd
	 Gb+NHmUxsWxsFgeBUJnUl4e+GvCCbZXQCVhNT1HwAYXyH4fpLdpuEPQZuEwcXVqr0K
	 XCV2HDK2joCzQCngRKgnvvFfmaIgWJCjpRm5DZujzlA9lxQ2wTMw2JN9Xt6J6g4Ttz
	 mrFiMOi0PEg/RR9t4SMPZHcKWaieQZStayYlsT5oWAd7LOOb7JTyTGY8y4cn+uryh/
	 AIkuC5t72f9DJlQRODfmzvos018U6U902KzK5tKH1BRrA2PLiKXhSka/oe/yfDJ1mV
	 wz/wKX7Xel+pw==
Date: Mon, 15 Jan 2024 10:32:40 +0000
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v5 iwl-next 1/6] ice: introduce PTP state machine
Message-ID: <20240115103240.GL392144@kernel.org>
References: <20240108124717.1845481-1-karol.kolacinski@intel.com>
 <20240108124717.1845481-2-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108124717.1845481-2-karol.kolacinski@intel.com>

On Mon, Jan 08, 2024 at 01:47:12PM +0100, Karol Kolacinski wrote:

Should there be a "From: Jacob" line here to
match the Signed-off-by below?

> Add PTP state machine so that the driver can correctly identify PTP
> state around resets.
> When the driver got information about ungraceful reset, PTP was not
> prepared for reset and it returned error. When this situation occurs,
> prepare PTP before rebuilding its structures.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Hi Karol and Jacob,

FWIIW, The combination of both a Signed-off-by and Reviewed-by tag from
Jacob seems a little odd to me. If he authored the patch then I would have
gone with the following (along with the From line mentioned above):

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

Otherwise, if he reviewed the patch I would have gone with:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c

...

> @@ -2640,6 +2676,16 @@ void ice_ptp_reset(struct ice_pf *pf)
>  	int err, itr = 1;
>  	u64 time_diff;
>  
> +	if (ptp->state != ICE_PTP_RESETTING) {
> +		if (ptp->state == ICE_PTP_READY) {
> +			ice_ptp_prepare_for_reset(pf);
> +		} else {
> +			err = -EINVAL;
> +			dev_err(ice_pf_to_dev(pf), "PTP was not initialized\n");
> +			goto err;
> +		}
> +	}

nit: perhaps this following is slightly nicer?
     (completely untested!)

	if (ptp->state == ICE_PTP_READY) {
		ice_ptp_prepare_for_reset(pf);
	} else if (ptp->state != ICE_PTP_RESETTING) {
		err = -EINVAL;
		dev_err(ice_pf_to_dev(pf), "PTP was not initialized\n");
		goto err;
	}

> +
>  	if (test_bit(ICE_PFR_REQ, pf->state) ||
>  	    !ice_pf_src_tmr_owned(pf))
>  		goto pfr;

...

