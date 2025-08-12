Return-Path: <netdev+bounces-212908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D583B2278B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 14:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF9F561F64
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DF027F001;
	Tue, 12 Aug 2025 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TzJal2wn"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1FA26CE3F
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003169; cv=none; b=jFujdbMaZlo6nlUo4oL++PV/FprwH8so0iGBZeuZwE1k66UG9Hw3RByMaqHtNLJmE4nc2fIjMIw/LyplolF056o831MEbKrP1dR6hXquDTBfgSHowH9JRLmLNB3SrZpe6E4pmoVqA6iEaZWOP3EVoV0AOiOScVl8AcavDPzwaTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003169; c=relaxed/simple;
	bh=LY6TE3eSb/UCrGTWwdjBrq+DuIBlRT0CrdmcNdVhQQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lznxkFPYTbmKwrqx8yg6ZZcP7/iaogJ230Bg7B9GwtZkxIT1e5ZIB538Bi7WMr5Up4DykrL53cjZ7jZSnGSbODXzUAd4q/cUoGaSnVLD9HocHuiG1VM7ZSBqBrk8IxLn41pGUYqgj8Sf+9bX1OrxaZcG/yoqR5jvC8PtoEC6m2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TzJal2wn; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f7633d68-ca3c-4320-ba2a-88156ea541cd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755003163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OADf1V7pXBJRW3RatMG6VLc4sAh6ZF5rnQ5uc0wW3Sw=;
	b=TzJal2wnVUXPxRjdszXMzZQwENHSZhGb/ost45bM2hgetbPy+CSkLnQyh5mmbHcpggkmjB
	/GTTawYSrS5HUDSxHfpxWn/mSsGU/1nFlbDDmiQw3xxA9vfB28Q6dS0gPDRcy0M0WxJwEW
	QPBI1ZaeirIWzo3UzbSeV0GPKj4FUSg=
Date: Tue, 12 Aug 2025 13:52:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Intel-wired-lan][PATCH iwl-net] idpf: fix UAF in RDMA core aux
 dev deinitialization
To: Joshua Hay <joshua.a.hay@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, larysa.zaremba@intel.com,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20250812001921.4076454-1-joshua.a.hay@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250812001921.4076454-1-joshua.a.hay@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/08/2025 01:19, Joshua Hay wrote:
> Free the adev->id before auxiliary_device_uninit. The call to uninit
> triggers the release callback, which frees the iadev memory containing the
> adev. The previous flow results in a UAF during rmmod due to the adev->id
> access.
> 
> [264939.604077] ==================================================================
> [264939.604093] BUG: KASAN: slab-use-after-free in idpf_idc_deinit_core_aux_device+0xe4/0x100 [idpf]
> [264939.604134] Read of size 4 at addr ff1100109eb6eaf8 by task rmmod/17842
> 
> ...
> 
> [264939.604635] Allocated by task 17597:
> [264939.604643]  kasan_save_stack+0x20/0x40
> [264939.604654]  kasan_save_track+0x14/0x30
> [264939.604663]  __kasan_kmalloc+0x8f/0xa0
> [264939.604672]  idpf_idc_init_aux_core_dev+0x4bd/0xb60 [idpf]
> [264939.604700]  idpf_idc_init+0x55/0xd0 [idpf]
> [264939.604726]  process_one_work+0x658/0xfe0
> [264939.604742]  worker_thread+0x6e1/0xf10
> [264939.604750]  kthread+0x382/0x740
> [264939.604762]  ret_from_fork+0x23a/0x310
> [264939.604772]  ret_from_fork_asm+0x1a/0x30
> 
> [264939.604785] Freed by task 17842:
> [264939.604790]  kasan_save_stack+0x20/0x40
> [264939.604799]  kasan_save_track+0x14/0x30
> [264939.604808]  kasan_save_free_info+0x3b/0x60
> [264939.604820]  __kasan_slab_free+0x37/0x50
> [264939.604830]  kfree+0xf1/0x420
> [264939.604840]  device_release+0x9c/0x210
> [264939.604850]  kobject_put+0x17c/0x4b0
> [264939.604860]  idpf_idc_deinit_core_aux_device+0x4f/0x100 [idpf]
> [264939.604886]  idpf_vc_core_deinit+0xba/0x3a0 [idpf]
> [264939.604915]  idpf_remove+0xb0/0x7c0 [idpf]
> [264939.604944]  pci_device_remove+0xab/0x1e0
> [264939.604955]  device_release_driver_internal+0x371/0x530
> [264939.604969]  driver_detach+0xbf/0x180
> [264939.604981]  bus_remove_driver+0x11b/0x2a0
> [264939.604991]  pci_unregister_driver+0x2a/0x250
> [264939.605005]  __do_sys_delete_module.constprop.0+0x2eb/0x540
> [264939.605014]  do_syscall_64+0x64/0x2c0
> [264939.605024]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Fixes: f4312e6bfa2a ("idpf: implement core RDMA auxiliary dev create, init, and destroy")
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_idc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> index 4d2905103215..7e20a07e98e5 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> @@ -247,10 +247,10 @@ static void idpf_unplug_aux_dev(struct auxiliary_device *adev)
>   	if (!adev)
>   		return;
>   
> +	ida_free(&idpf_idc_ida, adev->id);
> +
>   	auxiliary_device_delete(adev);
>   	auxiliary_device_uninit(adev);
> -
> -	ida_free(&idpf_idc_ida, adev->id);
>   }
>   
>   /**

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

