Return-Path: <netdev+bounces-99708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B6B8D5FCB
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 12:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857651C2280B
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 10:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EA7156243;
	Fri, 31 May 2024 10:37:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74281EAE9
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717151851; cv=none; b=Z/sezlA2iEabdLNBSZXByY8sxyC2p8X8QrvtvvN3LIFR/8nXDkP4D2hNAjA3ZdJzNn8grHB1PnY1thZQL6i67jJFyVGPPB4CtTbcdmlv4XgJYV5BuE7Uc9OHqHlIR3pGq2lK4wU9cwxWuWzSgTGgMwHysLfmTILgxDkaExNafJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717151851; c=relaxed/simple;
	bh=9VDukzVgUrg7sM/E8vsoRVgR7VGrV54s3vOQZaBm++k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHCH+hkaP3XTyqdla39llVeJ2i/pNHY9HO7R5u8FoC0dR62988+lVMWFxx20fo/7hWLVEI8TvtzJUSAUeO9WRAb0M51ewKp8ExKPdnOuNbtZcpWXcnofCVV855N06mX9P0nVDBYhxDxAWRzN84qykmitto7y0+0ZamDYLe82suQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.13.3] (g258.RadioFreeInternet.molgen.mpg.de [141.14.13.3])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4FD7461E5FE01;
	Fri, 31 May 2024 12:36:56 +0200 (CEST)
Message-ID: <40438f4d-d790-4921-ad6d-d69977747a57@molgen.mpg.de>
Date: Fri, 31 May 2024 12:36:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3] ice: implement AQ download
 pkg retry
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, jacob.e.keller@intel.com, kuba@kernel.org,
 intel-wired-lan@lists.osuosl.org
References: <20240531093206.714632-1-wojciech.drewek@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240531093206.714632-1-wojciech.drewek@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Wojciech,


Thank you for your patch.

Am 31.05.24 um 11:32 schrieb Wojciech Drewek:
> ice_aqc_opc_download_pkg (0x0C40) AQ sporadically returns error due
> to FW issue. Fix this by retrying five times before moving to
> Safe Mode.

Also mention the delay of 20 ms?

Please elaborate, what firmware version you tested with, and if there 
are plans to fix this in the firmware.

> Fixes: c76488109616 ("ice: Implement Dynamic Device Personalization (DDP) download")
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> ---
> v2: remove "failure" from log message
> v3: don't sleep in the last iteration of the wait loop
> ---
>   drivers/net/ethernet/intel/ice/ice_ddp.c | 23 +++++++++++++++++++++--
>   1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
> index ce5034ed2b24..f182179529b7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ddp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
> @@ -1339,6 +1339,7 @@ ice_dwnld_cfg_bufs_no_lock(struct ice_hw *hw, struct ice_buf *bufs, u32 start,
>   
>   	for (i = 0; i < count; i++) {
>   		bool last = false;
> +		int try_cnt = 0;
>   		int status;
>   
>   		bh = (struct ice_buf_hdr *)(bufs + start + i);
> @@ -1346,8 +1347,26 @@ ice_dwnld_cfg_bufs_no_lock(struct ice_hw *hw, struct ice_buf *bufs, u32 start,
>   		if (indicate_last)
>   			last = ice_is_last_download_buffer(bh, i, count);
>   
> -		status = ice_aq_download_pkg(hw, bh, ICE_PKG_BUF_SIZE, last,
> -					     &offset, &info, NULL);
> +		while (1) {
> +			status = ice_aq_download_pkg(hw, bh, ICE_PKG_BUF_SIZE,
> +						     last, &offset, &info,
> +						     NULL);
> +			if (hw->adminq.sq_last_status != ICE_AQ_RC_ENOSEC &&
> +			    hw->adminq.sq_last_status != ICE_AQ_RC_EBADSIG)
> +				break;
> +
> +			try_cnt++;
> +
> +			if (try_cnt == 5)
> +				break;
> +
> +			msleep(20);
> +		}
> +
> +		if (try_cnt)
> +			dev_dbg(ice_hw_to_dev(hw),
> +				"ice_aq_download_pkg number of retries: %d\n",
> +				try_cnt);

Should the firmware be fixed, a warning could be shown asking to update 
the firmware.

>   
>   		/* Save AQ status from download package */
>   		if (status) {


Kind regards,

Paul

