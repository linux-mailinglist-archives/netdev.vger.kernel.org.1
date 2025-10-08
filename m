Return-Path: <netdev+bounces-228229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA677BC53E1
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 15:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A99E4E6010
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 13:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF518285C82;
	Wed,  8 Oct 2025 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qszkx2pa"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CC7224B15
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930756; cv=none; b=RqMwr/nDIuFYsB7dBboIN7p/iyawd8TR1KbYPFNvalRifK+ZYPTdHI7eLdl40DAzPVv9yhgkzl4nTmuSm2HZKk3EO8My9qEpJDy/ACvLQ8YH+iPODg7Lu3c/ykTyM+VrrVtNMmUmdapvxGioonDugIZ7TrTlioPavtpz/skld1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930756; c=relaxed/simple;
	bh=uoZJouBg+QYQ13n81A6tW+PtmWDlDMHJayJc4vq5IzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONWgVifQKn5Hz2xOB5MPbfTP7nmdfLdAq6Z40znqhALa9HcWlD30azmnU6bmaE51YXoX4IvmzT2qXuJfB2UfsybhacSGy1fO1IwGmw1kuoG/p1WLknv9LgrQsugttF0zPGcdan80hX2DTjaDI7cfDahsRK+ghfmEgJDhdBkmmw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qszkx2pa; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4c3f7f4e-a77e-4862-843e-4f96afd406e0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759930748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WbFuK/4oiB1Zs+o79HnjX8bWNB1wUj6a043KWopg/Rk=;
	b=qszkx2paVl9iZQhaBFKHpqZ87U6pLV9VlO4knoXxBY9OQDTfrSuccqi7JHovD13huP2RvQ
	RoHZJQ+kpYNceIM/B2ZtDlf3cnd5JV15xlzk/JaKdYBVd9h49CnGUZG9LsUi0/sg6KUnXR
	EDZGBq0O4pNPBXthrIZx9KApG2q8k3Q=
Date: Wed, 8 Oct 2025 14:38:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH iwl-net] ice: fix PTP cleanup on driver removal in error
 path
To: Grzegorz Nitka <grzegorz.nitka@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20251008115811.1578695-1-grzegorz.nitka@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251008115811.1578695-1-grzegorz.nitka@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/10/2025 12:58, Grzegorz Nitka wrote:
> Improve PTP feature cleanup in error path by adding explicit call to
> ice_ptp_cleanup_pf in the case in which PTP feature is not fully
> operational at the time of driver removal (which is indicated by
> ptp->state flag).
> At the driver probe, if PTP feature is supported, each PF adds its own
> port to the list of ports controlled by ice_adapter object.
> Analogously, at the driver remove, it's expected each PF is
> responsible for removing previously added port from the list.
> If for some reason (like errors in reset handling, NVM update etc.), PTP
> feature has not rebuilt successfully, the driver is still responsible for
> proper clearing ice_adapter port list. It's done by calling
> ice_ptp_cleanup_pf function.
> Otherwise, the following call trace is observed when ice_adapter object
> is freed (port list is not empty, as it is expected at this stage):
> 
> [  T93022] ------------[ cut here ]------------
> [  T93022] WARNING: CPU: 10 PID: 93022 at
> ice/ice_adapter.c:67 ice_adapter_put+0xef/0x100 [ice]
> ...
> [  T93022] RIP: 0010:ice_adapter_put+0xef/0x100 [ice]
> ...
> [  T93022] Call Trace:
> [  T93022]  <TASK>
> [  T93022]  ? ice_adapter_put+0xef/0x100 [ice
> 33d2647ad4f6d866d41eefff1806df37c68aef0c]
> [  T93022]  ? __warn.cold+0xb0/0x10e
> [  T93022]  ? ice_adapter_put+0xef/0x100 [ice
> 33d2647ad4f6d866d41eefff1806df37c68aef0c]
> [  T93022]  ? report_bug+0xd8/0x150
> [  T93022]  ? handle_bug+0xe9/0x110
> [  T93022]  ? exc_invalid_op+0x17/0x70
> [  T93022]  ? asm_exc_invalid_op+0x1a/0x20
> [  T93022]  ? ice_adapter_put+0xef/0x100 [ice
> 33d2647ad4f6d866d41eefff1806df37c68aef0c]
> [  T93022]  pci_device_remove+0x42/0xb0
> [  T93022]  device_release_driver_internal+0x19f/0x200
> [  T93022]  driver_detach+0x48/0x90
> [  T93022]  bus_remove_driver+0x70/0xf0
> [  T93022]  pci_unregister_driver+0x42/0xb0
> [  T93022]  ice_module_exit+0x10/0xdb0 [ice
> 33d2647ad4f6d866d41eefff1806df37c68aef0c]
> ...
> [  T93022] ---[ end trace 0000000000000000 ]---
> [  T93022] ice: module unloaded
> 
> Fixes: e800654e85b5 ("ice: Use ice_adapter for PTP shared data instead of auxdev")
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ptp.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index fb0f6365a6d6..c43a7973d70f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -3282,8 +3282,10 @@ void ice_ptp_init(struct ice_pf *pf)
>    */
>   void ice_ptp_release(struct ice_pf *pf)
>   {
> -	if (pf->ptp.state != ICE_PTP_READY)
> +	if (pf->ptp.state != ICE_PTP_READY) {
> +		ice_ptp_cleanup_pf(pf);
>   		return;
> +	}
>   
>   	pf->ptp.state = ICE_PTP_UNINIT;
>   

ice_ptp_cleanup_pf() removes ptp->port.list_node, which is inited in
ice_ptp_setup_pf(), but ice_ptp_init() may fail before
ice_ptp_setup_pf() is called, and it will keep pf->ptp.state = 
ICE_PTP_ERROR. the cleanup then will work on uninitialized data.

It looks like it's better to make proper clean up in ice_ptp_setup_pf()
on error path rather then modify ice_ptp_cleanup_pf().

