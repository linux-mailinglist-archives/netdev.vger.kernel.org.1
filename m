Return-Path: <netdev+bounces-140518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 786929B6B25
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 18:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3831F21DF5
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980FF1FEFA1;
	Wed, 30 Oct 2024 17:36:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBA11F4FCE
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730309762; cv=none; b=ksI97S+SgSW0+IajA/0OTC1TVaStCaYtvqq2U71FotqcEz4wzBDDd3gwtGhyFUW7fzT5H1R98X5CB+3xyTInho3ttf1Klr2oxYxxwEX/gkpe22cquT/2IVSipxcOo7QjM73vu4MvGGkjE4WheXCmcjZvpDqL7y75s+D3wpXtlug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730309762; c=relaxed/simple;
	bh=IrBiUW993Sdm1olxCvWxk4r70UKx2wgvGA5vqxuvA7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FE1mvkfBJyrXUB/qYckHgPGACkiZ+zvqn9LO80DDjTpbwwN/OT36ZqCfiYmsFpFpReak76VKjsY3inAQY1B0UGCgI7wPg5xZfMNOENqydMs87lIVavTqk/tF4ALCCVWcL00hM07tTnnF9zbW1reIgACGT+MgmzQUyb+x75DBueU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1E8F161E5FE05;
	Wed, 30 Oct 2024 18:35:36 +0100 (CET)
Message-ID: <03b7d4ef-1e1e-4b9e-84b6-1ff4a5b92b29@molgen.mpg.de>
Date: Wed, 30 Oct 2024 18:35:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2] i40e: Fix handling changed priv flags
To: =?UTF-8?Q?Peter_Gro=C3=9Fe?= <pegro@friiks.de>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
References: <cf6dd743-759e-4db9-8811-fd1520262412@molgen.mpg.de>
 <20241030172224.30548-1-pegro@friiks.de>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241030172224.30548-1-pegro@friiks.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Peter,


Am 30.10.24 um 18:22 schrieb pegro@friiks.de:
> From: Peter Große <pegro@friiks.de>
> 
> After assembling the new private flags on a PF, the operation to determine
> the changed flags uses the wrong bitmaps. Instead of xor-ing orig_flags
> with new_flags, it uses the still unchanged pf->flags, thus changed_flags
> is always 0.
> 
> Fix it by using the correct bitmaps.
> 
> The issue was discovered while debugging why disabling source pruning
> stopped working with release 6.7. Although the new flags will be copied to
> pf->flags later on in that function, disabling source pruning requires
> a reset of the PF, which was skipped due to this bug.
> 
> Disabling source pruning:
> $ sudo ethtool --set-priv-flags eno1 disable-source-pruning on
> $ sudo ethtool --show-priv-flags eno1
> Private flags for eno1:
> MFP                   : off
> total-port-shutdown   : off
> LinkPolling           : off
> flow-director-atr     : on
> veb-stats             : off
> hw-atr-eviction       : off
> link-down-on-close    : off
> legacy-rx             : off
> disable-source-pruning: on
> disable-fw-lldp       : off
> rs-fec                : off
> base-r-fec            : off
> vf-vlan-pruning       : off
> 
> Regarding reproducing:
> 
> I observed the issue with a rather complicated lab setup, where
>   * two VLAN interfaces are created on eno1
>   * each with a different MAC address assigned
>   * each moved into a separate namespace
>   * both VLANs are bridged externally, so they form a single layer 2 network
> 
> The external bridge is done via a channel emulator adding packet loss and
> delay and the application in the namespaces tries to send/receive traffic
> and measure the performance. Sender and receiver are separated by
> namespaces, yet the network card "sees its own traffic" send back to it.
> To make that work, source pruning has to be disabled.

Thank you for taking the time to write this up.

> Fixes: 70756d0a4727 ("i40e: Use DECLARE_BITMAP for flags and hw_features fields in i40e_pf")
> Signed-off-by: Peter Große <pegro@friiks.de>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index c841779713f6..016c0ae6b36f 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -5306,7 +5306,7 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
>   	}
>   
>   flags_complete:
> -	bitmap_xor(changed_flags, pf->flags, orig_flags, I40E_PF_FLAGS_NBITS);
> +	bitmap_xor(changed_flags, new_flags, orig_flags, I40E_PF_FLAGS_NBITS);
>   
>   	if (test_bit(I40E_FLAG_FW_LLDP_DIS, changed_flags))
>   		reset_needed = I40E_PF_RESET_AND_REBUILD_FLAG;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

