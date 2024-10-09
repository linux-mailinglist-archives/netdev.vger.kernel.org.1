Return-Path: <netdev+bounces-133695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C34996B6F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1841B2832E9
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3108192B70;
	Wed,  9 Oct 2024 13:13:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C94022EEF
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728479607; cv=none; b=sKJLTFfcI/bTmxs3wanc3ocurVTC+ZJt8KSC214w8exFohnVuRnaiUvGMtTcJ9SeYqBk3ZU3VvG03wO1thCluT7eCBwBQOWGMk86mNzEwp7P1iA2SpmQlBBFrDfE5ZVE+hD8sM72r58OJzw4ExUKt1BEpCmXiBQQAUrvmfOmVMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728479607; c=relaxed/simple;
	bh=NQUyS3dmETQuC3MXADOj5mnivYwyMk0ZbjZP3QZeNhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5a8DTZ6Ob8rkajGD0JPdJ6/fH7FIR1qWGBTq6W2crlC2GZH0pGuO/inNpv4KpxFhkZLzIq6nY3i8X+V8ufdqkkXG1Q6lAdY6bobRjCC8tIErQx/8TZ+nMUmriPM1qNTG0xqB4NL4tte0udY4y7tGUt029dB0ihJGhluCyExRnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3335A61E5FE05;
	Wed,  9 Oct 2024 15:12:59 +0200 (CEST)
Message-ID: <3a5591f9-a8fe-4557-b6c4-ea393dd28913@molgen.mpg.de>
Date: Wed, 9 Oct 2024 15:12:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: Fix use after free during
 unload with ports in bridge
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
References: <20241009124912.9774-2-marcin.szycik@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241009124912.9774-2-marcin.szycik@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Marcin,


Thank you for the patch, and the reproducer and detailed commit message.

Am 09.10.24 um 14:49 schrieb Marcin Szycik:
> Unloading the ice driver while switchdev port representors are added to
> a bridge can lead to kernel panic. Reproducer:
> 
>    modprobe ice
> 
>    devlink dev eswitch set $PF1_PCI mode switchdev
> 
>    ip link add $BR type bridge
>    ip link set $BR up
> 
>    echo 2 > /sys/class/net/$PF1/device/sriov_numvfs
>    sleep 2
> 
>    ip link set $PF1 master $BR
>    ip link set $VF1_PR master $BR
>    ip link set $VF2_PR master $BR
>    ip link set $PF1 up
>    ip link set $VF1_PR up
>    ip link set $VF2_PR up
>    ip link set $VF1 up
> 
>    rmmod irdma ice

For people hitting the issue, an excerpt from the panic would also be 
nice, so it can be found more easily.

> When unloading the driver, ice_eswitch_detach() is eventually called as
> part of VF freeing. First, it removes a port representor from xarray,
> then unregister_netdev() is called (via repr->ops.rem()), finally
> representor is deallocated. The problem comes from the bridge doing its
> own deinit at the same time. unregister_netdev() triggers a notifier
> chain, resulting in ice_eswitch_br_port_deinit() being called. It should
> set repr->br_port = NULL, but this does not happen since repr has
> already been removed from xarray and is not found. Regardless, it
> finishes up deallocating br_port. At this point, repr is still not freed
> and an fdb event can happen, in which ice_eswitch_br_fdb_event_work()
> takes repr->br_port and tries to use it, which causes a panic (use after
> free).
> 
> Note that this only happens with 2 or more port representors added to
> the bridge, since with only one representor port, the bridge deinit is
> slightly different (ice_eswitch_br_port_deinit() is called via
> ice_eswitch_br_ports_flush(), not ice_eswitch_br_port_unlink()).
> 
> A workaround is available: brctl setageing $BR 0, which stops the bridge
> from adding fdb entries altogether.
> 
> Change the order of operations in ice_eswitch_detach(): move the call to
> unregister_netdev() before removing repr from xarray. This way
> repr->br_port will be correctly set to NULL in
> ice_eswitch_br_port_deinit(), preventing a panic.
> 
> Fixes: fff292b47ac1 ("ice: add VF representors one by one")
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_eswitch.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index c0b3e70a7ea3..fb527434b58b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -552,13 +552,14 @@ int ice_eswitch_attach_sf(struct ice_pf *pf, struct ice_dynamic_port *sf)
>   static void ice_eswitch_detach(struct ice_pf *pf, struct ice_repr *repr)
>   {
>   	ice_eswitch_stop_reprs(pf);
> +	repr->ops.rem(repr);
> +
>   	xa_erase(&pf->eswitch.reprs, repr->id);
>   
>   	if (xa_empty(&pf->eswitch.reprs))
>   		ice_eswitch_disable_switchdev(pf);
>   
>   	ice_eswitch_release_repr(pf, repr);
> -	repr->ops.rem(repr);
>   	ice_repr_destroy(repr);
>   
>   	if (xa_empty(&pf->eswitch.reprs)) {

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

