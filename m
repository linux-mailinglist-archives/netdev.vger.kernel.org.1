Return-Path: <netdev+bounces-133734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982BB996D1E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96A11C20F58
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B8619CC3E;
	Wed,  9 Oct 2024 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CZPrXMov"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D6F19CC34
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482500; cv=none; b=c+z1R04nUMeV0DApNRQ+CaEghkmiNjlRev++2P7f/QUlZUBWmK80kjkZZnwW2z/BtdRiXeO93lOqCN+N2KAnp3mpVNsokXrCl2yr59PbvratA2SoAQ9cV9qzS4jKIn5Z1WBmJsWMrCowWImsNufbmAaPWiLw02PlJ2fKk9sa7n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482500; c=relaxed/simple;
	bh=xuA9fUHFtoQblXYKldwTdTtapCWeMBROK2X3/1kWnbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udYRHExQZU5TEwuMHB6m+qFPtPKe9i9ZpPjRaojCxn/qZmZYVTrKTC2sjFFFgmvFiO/K3Xa+JnUt+W7USlia4PFPsqmCm8Slytxql5othE/857derJHf40Sue0tZO33DQgQvpzqMl4eO1B7FNokpS5uDxSxrRzo5UX4690nTEpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CZPrXMov; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728482498; x=1760018498;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xuA9fUHFtoQblXYKldwTdTtapCWeMBROK2X3/1kWnbE=;
  b=CZPrXMov16YvebH/DknVyR/cOFu6rQPDR4kbJMdaDzQsVqbTIUPygFJP
   hV/amEwsMTgtqiA25rA//nqTobxpyF3Pj79T4JKWUadF5tBdxlIIZPZrK
   AgKdG1K9lGCwJaatwA45vaDrGRj15MDgeIBtZpdhirv3ImV/M/VR1Amvg
   D47fz11XqZuwbj+IDFgHNXL7H2oqqJ2dMHeN9zb95VuZsgqzhg+++Ysr6
   ci0Ogo40Age1vm5pw2W7TXCw/OjNu+lO6QFG9sAxx311GMaLJahneOUc/
   075w8xb/1xKLAyHe2dtBiBlhFCbpcp47qBsaDjW37R5kWSlInQjRHDeSA
   w==;
X-CSE-ConnectionGUID: YitLpPOgRM6O3vwzuqn4Rg==
X-CSE-MsgGUID: NlzbfIQzTJK6V/cKu1unAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31678204"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="31678204"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 07:01:38 -0700
X-CSE-ConnectionGUID: OUkyTY60Tp+7rz+utcNmuQ==
X-CSE-MsgGUID: uEZbFkRFSy6pIODMto7p/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="81281274"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.245.120.122]) ([10.245.120.122])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 07:01:36 -0700
Message-ID: <4bd4eca1-91d7-4ffb-92d9-ad708d83248c@linux.intel.com>
Date: Wed, 9 Oct 2024 16:01:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: Fix use after free during
 unload with ports in bridge
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
References: <20241009124912.9774-2-marcin.szycik@linux.intel.com>
 <3a5591f9-a8fe-4557-b6c4-ea393dd28913@molgen.mpg.de>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <3a5591f9-a8fe-4557-b6c4-ea393dd28913@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 09.10.2024 15:12, Paul Menzel wrote:
> Dear Marcin,
> 
> 
> Thank you for the patch, and the reproducer and detailed commit message.
> 
> Am 09.10.24 um 14:49 schrieb Marcin Szycik:
>> Unloading the ice driver while switchdev port representors are added to
>> a bridge can lead to kernel panic. Reproducer:
>>
>>    modprobe ice
>>
>>    devlink dev eswitch set $PF1_PCI mode switchdev
>>
>>    ip link add $BR type bridge
>>    ip link set $BR up
>>
>>    echo 2 > /sys/class/net/$PF1/device/sriov_numvfs
>>    sleep 2
>>
>>    ip link set $PF1 master $BR
>>    ip link set $VF1_PR master $BR
>>    ip link set $VF2_PR master $BR
>>    ip link set $PF1 up
>>    ip link set $VF1_PR up
>>    ip link set $VF2_PR up
>>    ip link set $VF1 up
>>
>>    rmmod irdma ice
> 
> For people hitting the issue, an excerpt from the panic would also be nice, so it can be found more easily.

Will add in v2, thanks.
Marcin

>> When unloading the driver, ice_eswitch_detach() is eventually called as
>> part of VF freeing. First, it removes a port representor from xarray,
>> then unregister_netdev() is called (via repr->ops.rem()), finally
>> representor is deallocated. The problem comes from the bridge doing its
>> own deinit at the same time. unregister_netdev() triggers a notifier
>> chain, resulting in ice_eswitch_br_port_deinit() being called. It should
>> set repr->br_port = NULL, but this does not happen since repr has
>> already been removed from xarray and is not found. Regardless, it
>> finishes up deallocating br_port. At this point, repr is still not freed
>> and an fdb event can happen, in which ice_eswitch_br_fdb_event_work()
>> takes repr->br_port and tries to use it, which causes a panic (use after
>> free).
>>
>> Note that this only happens with 2 or more port representors added to
>> the bridge, since with only one representor port, the bridge deinit is
>> slightly different (ice_eswitch_br_port_deinit() is called via
>> ice_eswitch_br_ports_flush(), not ice_eswitch_br_port_unlink()).
>>
>> A workaround is available: brctl setageing $BR 0, which stops the bridge
>> from adding fdb entries altogether.
>>
>> Change the order of operations in ice_eswitch_detach(): move the call to
>> unregister_netdev() before removing repr from xarray. This way
>> repr->br_port will be correctly set to NULL in
>> ice_eswitch_br_port_deinit(), preventing a panic.
>>
>> Fixes: fff292b47ac1 ("ice: add VF representors one by one")
>> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_eswitch.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
>> index c0b3e70a7ea3..fb527434b58b 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
>> @@ -552,13 +552,14 @@ int ice_eswitch_attach_sf(struct ice_pf *pf, struct ice_dynamic_port *sf)
>>   static void ice_eswitch_detach(struct ice_pf *pf, struct ice_repr *repr)
>>   {
>>       ice_eswitch_stop_reprs(pf);
>> +    repr->ops.rem(repr);
>> +
>>       xa_erase(&pf->eswitch.reprs, repr->id);
>>         if (xa_empty(&pf->eswitch.reprs))
>>           ice_eswitch_disable_switchdev(pf);
>>         ice_eswitch_release_repr(pf, repr);
>> -    repr->ops.rem(repr);
>>       ice_repr_destroy(repr);
>>         if (xa_empty(&pf->eswitch.reprs)) {
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul


