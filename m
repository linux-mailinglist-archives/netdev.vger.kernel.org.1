Return-Path: <netdev+bounces-170807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D75CEA4A018
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 18:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08B7189622B
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40BC1F4C8E;
	Fri, 28 Feb 2025 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwWsI0uc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8361F4C81
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763077; cv=none; b=gvgR4SsV5K+kdaa0lEr7MFhAy4nrPBlO2KusmdvqZzdNe1/M7M4thPe9P9MUi4Ks2znQqWn1A+xoLt6+N2NIcSKk8xQnnOcDbPEPeamf77m4I11FADf23mUjTbeHDPk3exbqlpm8igrZ5xoSQ+cc4Zcqpjp35wkWCmZz4rE4nnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763077; c=relaxed/simple;
	bh=L5qKmW9g5UE+AbZtglGmdI2i5mIH089oEROsqANpXdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZNuEDuK2rz7y7yAibWLLdL7yoX9/RD+7d4JYUjiKF2CjDkgJp7WQ7jVfvFy/mgPYYZZfSu1JlZgJNAyxrxUIe7eCNegZOhKot4wxUNRuktcW3wCyhgCdtCOtti6Dq4Zm44XjUMBSRMyS5M3xo5zqBaIXYaLEDXdlIURjPlMF5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwWsI0uc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E48FC4CED6;
	Fri, 28 Feb 2025 17:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740763077;
	bh=L5qKmW9g5UE+AbZtglGmdI2i5mIH089oEROsqANpXdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PwWsI0ucRfx9BGYJa0tTEXgMIenITKpMGN896F4GhZH8T/JDflhvsfXM++C4XXeCn
	 XghQqY/Ki232i7gmubV4auCpnUzX1y+tYgU6fG7FQGk+N3zNCWY0E0/0A4Q3zNCvWX
	 01OWwqaW63i+w6FfVxBRKEzn1LbKIWwpSEgLBCq32sNGvlddYV05FwDas0en4fsYfC
	 /sOYlDyx5ozyq0vr/dodCD9vtgrP3j+0Z8EdQ+aoT7nBZY87/0kv6vYZiQybzjcEf5
	 hAzHQ+ySLaBVpcWSIVkM7BHZJQMRnGkIGAuNdknh+tGpAuQ+EfCVtVIiHLkZ74bhbj
	 R+excFWex/xMw==
Date: Fri, 28 Feb 2025 17:17:53 +0000
From: Simon Horman <horms@kernel.org>
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: Re: [iwl-net v2 5/5] ice: fix using untrusted value of pkt_len in
 ice_vc_fdir_parse_raw()
Message-ID: <20250228171753.GL1615191@kernel.org>
References: <20250225090847.513849-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250225090847.513849-8-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225090847.513849-8-martyna.szapar-mudlaw@linux.intel.com>

On Tue, Feb 25, 2025 at 10:08:49AM +0100, Martyna Szapar-Mudlaw wrote:
> From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> 
> Fix using the untrusted value of proto->raw.pkt_len in function
> ice_vc_fdir_parse_raw() by verifying if it does not exceed the
> VIRTCHNL_MAX_SIZE_RAW_PACKET value.
> 
> Fixes: 99f419df8a5c ("ice: enable FDIR filters from raw binary patterns for VFs")
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
> ---
>  .../ethernet/intel/ice/ice_virtchnl_fdir.c    | 25 +++++++++++++------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> index 14e3f0f89c78..6250629ee8f9 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> @@ -835,18 +835,27 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
>  	u8 *pkt_buf, *msk_buf __free(kfree);
>  	struct ice_parser_result rslt;
>  	struct ice_pf *pf = vf->pf;
> +	u16 pkt_len, udp_port = 0;
>  	struct ice_parser *psr;
>  	int status = -ENOMEM;
>  	struct ice_hw *hw;
> -	u16 udp_port = 0;
>  
> -	pkt_buf = kzalloc(proto->raw.pkt_len, GFP_KERNEL);
> -	msk_buf = kzalloc(proto->raw.pkt_len, GFP_KERNEL);
> +	if (!proto->raw.pkt_len)
> +		return -EINVAL;

Hi Martyna,

It seems to me that the use of __free() above will result in
kfree(msk_buf) being called here. But msk_buf is not initialised at this
point.

My suggest would be to drop the use of __free().
But if not, I think that in order to be safe it would be best to do this
(completely untested;

	u8 *pkt_buf, *msk_buf __free(kfree) = NULL;

...

