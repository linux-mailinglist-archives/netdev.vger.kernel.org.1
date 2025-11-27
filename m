Return-Path: <netdev+bounces-242246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFF1C8E155
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0907F3AB9C5
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 11:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39E032D0D8;
	Thu, 27 Nov 2025 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCLe2OIu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0D632C31C
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764243882; cv=none; b=SQHcMOb0Fd/BAfL/LJkXp6QUcGqRh87ZMT1dx4N1Z4UA7Toz7vjln/gtOwHpZhXRDfavoTlHPJTI5sz7KaaoOQflWlD9z+p/dXPZdZtcHoqXUhY5Udz2fAeoqYWQHai1gQDUD3wkq5YPtkmjMPxgUdhxrGQp2a0DbFY3N37gu9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764243882; c=relaxed/simple;
	bh=8B3PWkcneEp8j4f+naDD6Gjqui7eqqG/efW5UvE2XH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUce50ugJ2u3F7cE76YUbR7VmZPPHEh/oe+t89Xnht0U2IP5H2YPaAXmIwCKA1p7OUcSfayKZCejBgGBE5PLS6kePcG1BGu34mhDuJ7so5yVMqe/z5YBY0E2D7u2kbc2ZXb/rmd/hov1gAgHZa6nSmuLPE95xv2z+/OszYsAKtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCLe2OIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D691CC4CEF8;
	Thu, 27 Nov 2025 11:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764243882;
	bh=8B3PWkcneEp8j4f+naDD6Gjqui7eqqG/efW5UvE2XH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCLe2OIuIK9wjKClO/r9uyaeQ15V7N/qN6sDhYFWeDI2Z4Zp4gK4FPsONwLX2rwcH
	 tfzYe44SX9LSCUgFA2ov2A6XZkPitg2cUqReAIFJTKI4A0miQkv0MvTki1qmW589xU
	 VI2y2WMVHhOdmyEvY/IiTPxKxJRQvVaxWP6g417Yxuila1C5k6D4KfdGBGm6mcLU5C
	 WuIG38jrSYsix3D1s3TXIcupJ1xXainImFuTwRLcD/xXwKUG7vTL24qOIHF58NWwM3
	 MqtfMovzdV99mCiWKOg1zJIlWcLzS51EHBRLzV+Kyb85OQWObyeG+kZ7PoftguOMHx
	 9Zb/34wrUnRRQ==
Date: Thu, 27 Nov 2025 11:44:38 +0000
From: Simon Horman <horms@kernel.org>
To: Sreedevi Joshi <sreedevi.joshi@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>
Subject: Re: [PATCH iwl-net v2 2/3] idpf: Fix RSS LUT configuration on down
 interfaces
Message-ID: <aSg5pg9aLwmiVR6G@horms.kernel.org>
References: <20251124184750.3625097-1-sreedevi.joshi@intel.com>
 <20251124184750.3625097-3-sreedevi.joshi@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124184750.3625097-3-sreedevi.joshi@intel.com>

On Mon, Nov 24, 2025 at 12:47:49PM -0600, Sreedevi Joshi wrote:
> RSS LUT provisioning and queries on a down interface currently return
> silently without effect. Users should be able to configure RSS settings
> even when the interface is down.
> 
> Fix by maintaining RSS configuration changes in the driver's soft copy and
> deferring HW programming until the interface comes up.
> 
> Fixes: 02cbfba1add5 ("idpf: add ethtool callbacks")
> Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c

...

> @@ -424,7 +429,7 @@ static int idpf_get_rxfh(struct net_device *netdev,
>  
>  	if (rxfh->indir) {
>  		for (i = 0; i < rss_data->rss_lut_size; i++)
> -			rxfh->indir[i] = rss_data->rss_lut[i];
> +			rxfh->indir[i] = rxhash_ena ? rss_data->rss_lut[i] : 0;

Hi,

I feel that I am missing something here.
But I would have expected rxfh->indir to be populated by rss_data->rss_lut
regardless of the port is up or down. IOW, I'm unclear on why
0 is reported for the indirection table if the interface is down.

>  	}
>  
>  unlock_mutex:

...

