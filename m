Return-Path: <netdev+bounces-170806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C45A49FF8
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 18:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826E2176F32
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0CA1A8F9E;
	Fri, 28 Feb 2025 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4hukd2V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6301607AC
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762583; cv=none; b=i1UUE8i+MOXDRl3RQiB5xTa/D5H9p08b5P2qIQGhp65/TtgexN/vtlKDQ8Mybvt4c6s+EcA+97o+7JFH8+azFvlKRZk/9zfGYxf0fUIi3eUT/BQ36edItAAVIqiTxa5tnPYPay5vthGygsBHVRX+vQEDmB1TnXcw8rl17wkHuak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762583; c=relaxed/simple;
	bh=S9zzy7A7bNCFlFQ9EkUF9Yue0Nn9SL09FASYNBH3ceg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dq54ghFxnqzxKh7W234BxCwi+nyiDVha4ROvHojLmlvNVrY/7EpsdYkydCH2xFczFNHYg8WTOdyC+Qi6nd2e026wjLrS7REjyDUO5bRYprwwd5cf2VGfA6Cc6ro9zBFDi9JMR6PbolLgmsiB32iaLMK9K6LnjHsoOeAkcLpQbGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4hukd2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235BEC4CED6;
	Fri, 28 Feb 2025 17:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740762583;
	bh=S9zzy7A7bNCFlFQ9EkUF9Yue0Nn9SL09FASYNBH3ceg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n4hukd2VmiE1dayEMU6q9Ah/OuSfy21KtM0dx1l1XCYTS32ikeHNUa1xLtPl1c7Nb
	 5ULoNmMkI4OJfdtX5vUIO2U8LGLyLWkAbtjwu2ZZKZLaRp5h0I5oKnC3rbuzj1Ri7v
	 iPKF4hutb2V8H+ajOGPmKOst69/Ikc2K+5Xel7ijQLUI7oH6XtB0wK6z39HQBhzQR5
	 JHmFVCuep1eMSkQcLu3DjrOphWUyJDKWCKIk/U0+gA45TBuycy2cgKTmdGVmv52SEM
	 ebbOKwl5K8/BTQRV9SJiBVo6DEty66EEa5vrZ/QtwOBvEumqz7XaE5m/giHTU6xmOz
	 BE5N6GjAyRNzw==
Date: Fri, 28 Feb 2025 17:09:39 +0000
From: Simon Horman <horms@kernel.org>
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: Re: [iwl-net v2 5/5] ice: fix using untrusted value of pkt_len in
 ice_vc_fdir_parse_raw()
Message-ID: <20250228170939.GK1615191@kernel.org>
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
> +
> +	pkt_len = proto->raw.pkt_len;

Hi Martyna,

A check is made for !proto->raw.pkt_len above.
And a check is made for !pkt_len below.

This seems redundant.

> +
> +	if (!pkt_len || pkt_len > VIRTCHNL_MAX_SIZE_RAW_PACKET)
> +		return -EINVAL;

...

