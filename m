Return-Path: <netdev+bounces-99289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDD78D44A7
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 07:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508B41C2159A
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 05:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1DB25763;
	Thu, 30 May 2024 05:02:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F90143890
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 05:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717045320; cv=none; b=THVfnf1G3p/KIAqP4RVmLjlqjingCxDKgne6B1nDiJ5jkpO8ozYBB2O47hesjcq+88/EFRtZerPqVHjVR7bSgzgkfgJi7zYOT5WQEigbHxz16Gz1nT3DAiQw8LRjdxRlIykI2ldkvIyZohCWV2vcSR3vAPPB1HpPHMBxyTbUnSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717045320; c=relaxed/simple;
	bh=qaPEKkR463D8Ya4hKMN78j+/bcEqNz2Oh5Xa4SJEguA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fU2od1bdByznjtsTY3aXXHZV45rp9iW0YZie8PDjiXW3VLwrWoCpISOcdwrnn8o5VduWkmJD3aL8JBMpzgV/gPhpQhrLyXMzTPbGe3uUm0sKqMfIfno1LXykUdoAU6xbtqD5dbv4axV7h4+cyN+mUBRGIYjiOFtv4ZoW7++zMz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.3] (ip5f5af172.dynamic.kabel-deutschland.de [95.90.241.114])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D219D61E646E6;
	Thu, 30 May 2024 07:01:30 +0200 (CEST)
Message-ID: <ee16afbe-83a0-4149-a987-6895968e3720@molgen.mpg.de>
Date: Thu, 30 May 2024 07:01:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ice: Rebuild TC queues on
 VSI queue reconfiguration
To: Karen Ostrowska <karen.ostrowska@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Jan Sokolowski <jan.sokolowski@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>
References: <20240529071736.224973-1-karen.ostrowska@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240529071736.224973-1-karen.ostrowska@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Karen, dear Jan,


Thank you for the patch.

Am 29.05.24 um 09:17 schrieb Karen Ostrowska:
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> TC queues needs to be correctly updated when the number of queues on

need

> a VSI is reconfigured, so netdev's queue and TC settings will be
> dynamically adjusted and could accurately represent the underlying
> hardware state after changes to the VSI queue counts.

Please document the test configuration, and how to test/verify your change.

> Fixes: 0754d65bd4be ("ice: Add infrastructure for mqprio support via ndo_setup_tc")
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Signed-off-by: Karen Ostrowska <karen.ostrowska@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_main.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 1b61ca3a6eb6..a1798ec4d904 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -4136,7 +4136,7 @@ bool ice_is_wol_supported(struct ice_hw *hw)
>   int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
>   {
>   	struct ice_pf *pf = vsi->back;
> -	int err = 0, timeout = 50;
> +	int i, err = 0, timeout = 50;

unsigned int

>   	if (!new_rx && !new_tx)
>   		return -EINVAL;
> @@ -4162,6 +4162,14 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
>   
>   	ice_vsi_close(vsi);
>   	ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> +
> +	ice_for_each_traffic_class(i) {
> +		if (vsi->tc_cfg.ena_tc & BIT(i))
> +			netdev_set_tc_queue(vsi->netdev,
> +					    vsi->tc_cfg.tc_info[i].netdev_tc,
> +					    vsi->tc_cfg.tc_info[i].qcount_tx,
> +					    vsi->tc_cfg.tc_info[i].qoffset);
> +	}
>   	ice_pf_dcb_recfg(pf, locked);
>   	ice_vsi_open(vsi);
>   done:


Kind regards,

Paul

