Return-Path: <netdev+bounces-172794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09408A56092
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 07:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D3A3B2149
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 06:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DB718DB3A;
	Fri,  7 Mar 2025 06:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hz9wN5iY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2048B1624F8
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 06:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741327335; cv=none; b=gIgZB3jWbnQWOrhZ8mqVfxON2DyFsZ4SbIqZ81OJOT9M8x4pxzrrCMg6cV6r7ulmqnE+g82RKdgaK1bVL0D/3uNltuhTzjzYX/3j7DzjLdnCFO2cdrIdLZe78Nm4jqQxPuAXdxUpZiDff83YTXzlLymgNgHGx5jQPor2oa6bgaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741327335; c=relaxed/simple;
	bh=ssS2yLuyvtoLCM/MENPJQ5W4+oovXZms8MTFYP3JgBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9olYZxr5CQPhwoJ8vfvSHn2JCWW4DQSgwnt5cxln9sD5lBarVXLQJt0fHxyZ1b6PlhHcLGRY1rmBoWKI5vYc4QLSKO5d0Wj/8aOtgy9E18JW06V2hQU8xoQqWIHiax52DR3PJqzxkGzvvwXaXoeDA5FrgR5nWq4ETVlzYVzogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hz9wN5iY; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741327333; x=1772863333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ssS2yLuyvtoLCM/MENPJQ5W4+oovXZms8MTFYP3JgBI=;
  b=hz9wN5iYTTtDCnyzDaOxm+IO6xpF/7Nox884t7z3BIYe/oMyLNXpzpYy
   3bdRpBklFJtanVhmPrDsOnedqJZH3/RQzBvxnTi0A4jt4OGeAS5h1oOQb
   unVebAo6Eda+WQIKVqwnMlvyAHzl06Z9F7ozAwBWR0TPFGo5RqFW7j85D
   fWLiwfeo/6nTmzsLRgyXsOUNDxwu94RlL932LwRvvLsICvnVPQX6CfC/m
   /mMTskRHkN0KP//ymPHPDmgi2SUoVtzjxwdRGb0Ia41gRFJjx+XpIJXi0
   7jSTk6wDI/23cyPfYiJhqUoK1ebR/VVMtpAs915e4fExYo2z7MZevgTw0
   A==;
X-CSE-ConnectionGUID: G83hnTAKSh6VR8U1oXO63A==
X-CSE-MsgGUID: t2Lb8ndqSl6YuYKePVQh+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="59773283"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="59773283"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 22:02:12 -0800
X-CSE-ConnectionGUID: +Qv+ViwPSiqObnDp32HgIg==
X-CSE-MsgGUID: Kdz37tCaRWaUHQp3t9pPYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150181763"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 22:02:09 -0800
Date: Fri, 7 Mar 2025 06:58:21 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	decot@google.com, willemb@google.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, madhu.chittim@intel.com,
	Aleksandr.Loktionov@intel.com, yuma@redhat.com, mschmidt@redhat.com
Subject: Re: [PATCH iwl-net] idpf: fix adapter NULL pointer dereference on
 reboot
Message-ID: <Z8qK/Z/8lYtdR2UM@mev-dev.igk.intel.com>
References: <20250307003956.22018-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307003956.22018-1-emil.s.tantilov@intel.com>

On Thu, Mar 06, 2025 at 04:39:56PM -0800, Emil Tantilov wrote:
> Driver calls idpf_remove() from idpf_shutdown(), which can end up
> calling idpf_remove() again when disabling SRIOV.
> 

The same is done in other drivers (ice, iavf). Why here it is a problem?
I am asking because heaving one function to remove is pretty handy.
Maybe the problem can be fixed by some changes in idpf_remove() instead?

> echo 1 > /sys/class/net/<netif>/device/sriov_numvfs
> reboot
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000020
> ...
> RIP: 0010:idpf_remove+0x22/0x1f0 [idpf]
> ...
> ? idpf_remove+0x22/0x1f0 [idpf]
> ? idpf_remove+0x1e4/0x1f0 [idpf]
> pci_device_remove+0x3f/0xb0
> device_release_driver_internal+0x19f/0x200
> pci_stop_bus_device+0x6d/0x90
> pci_stop_and_remove_bus_device+0x12/0x20
> pci_iov_remove_virtfn+0xbe/0x120
> sriov_disable+0x34/0xe0
> idpf_sriov_configure+0x58/0x140 [idpf]
> idpf_remove+0x1b9/0x1f0 [idpf]
> idpf_shutdown+0x12/0x30 [idpf]
> pci_device_shutdown+0x35/0x60
> device_shutdown+0x156/0x200
> ...
> 
> Replace the direct idpf_remove() call in idpf_shutdown() with
> idpf_vc_core_deinit() and idpf_deinit_dflt_mbx(), which perform
> the bulk of the cleanup, such as stopping the init task, freeing IRQs,
> destroying the vports and freeing the mailbox.
> 
> Reported-by: Yuying Ma <yuma@redhat.com>
> Fixes: e850efed5e15 ("idpf: add module register and probe functionality")
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
> index b6c515d14cbf..bec4a02c5373 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> @@ -87,7 +87,11 @@ static void idpf_remove(struct pci_dev *pdev)
>   */
>  static void idpf_shutdown(struct pci_dev *pdev)
>  {
> -	idpf_remove(pdev);
> +	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
> +
> +	cancel_delayed_work_sync(&adapter->vc_event_task);
> +	idpf_vc_core_deinit(adapter);
> +	idpf_deinit_dflt_mbx(adapter);
>  
>  	if (system_state == SYSTEM_POWER_OFF)
>  		pci_set_power_state(pdev, PCI_D3hot);
> -- 
> 2.17.2

