Return-Path: <netdev+bounces-247586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C29CFC110
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 06:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B13E302A94C
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 05:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F786261B71;
	Wed,  7 Jan 2026 05:30:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150C7261B83;
	Wed,  7 Jan 2026 05:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767763857; cv=none; b=XsrKq6MVd9DewA7YpFDjFGyBAdBbP7oMum0qqdYNbIF4bNN0YZELzUNH3Bb7Lz5OVr+PQnYNISSYiP6O5fjp/x5o4i4pYN1+SPqxiYnJV5FbZ7to0QunkoH2zzGGcNJmIja0/crmFt43vjpTV8fZAdReXSAcpuwsBu4XaEBIXbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767763857; c=relaxed/simple;
	bh=GSuUQv1BfbWC3+m/80sLZ4ZbSnqGPWg1OzsKxZ8b3CY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DImqOR3bilSfTE132R9U3rUnElr7o4k2TR6i0+HNQtqPwnKxNSKbD/WcGQs8HEvuGmThXC1rbHcGNgEKHvgAps2oR2kLXUM0OhXLSMMOt70qhP282J888odQ7vC+9ozpwAZRGSwM8ezcZeCnJ0GR4FnZr2RouFGFFW8nEF+xOiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af77e.dynamic.kabel-deutschland.de [95.90.247.126])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2E1DB61EB9DD0;
	Wed, 07 Jan 2026 06:30:10 +0100 (CET)
Message-ID: <fba866fa-5ed7-4321-8776-e1585b4c417b@molgen.mpg.de>
Date: Wed, 7 Jan 2026 06:30:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 1/5] idpf: skip getting/setting ring
 params if vport is NULL during HW reset
To: Li Li <boolli@google.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Decotigny <decot@google.com>, Anjali Singhai
 <anjali.singhai@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Brian Vazquez <brianvv@google.com>, emil.s.tantilov@intel.com
References: <20260107010503.2242163-1-boolli@google.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260107010503.2242163-1-boolli@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Li,


Thank you for your patch.

Am 07.01.26 um 02:04 schrieb Li Li via Intel-wired-lan:
> When an idpf HW reset is triggered, it clears the vport but does
> not clear the netdev held by vport:
> 
>      // In idpf_vport_dealloc() called by idpf_init_hard_reset(),
>      // idpf_init_hard_reset() sets IDPF_HR_RESET_IN_PROG, so
>      // idpf_decfg_netdev() doesn't get called.

No need to format this as code comments. At least it confused me a little.

>      if (!test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags))
>          idpf_decfg_netdev(vport);
>      // idpf_decfg_netdev() would clear netdev but it isn't called:
>      unregister_netdev(vport->netdev);
>      free_netdev(vport->netdev);
>      vport->netdev = NULL;
>      // Later in idpf_init_hard_reset(), the vport is cleared:
>      kfree(adapter->vports);
>      adapter->vports = NULL;
> 
> During an idpf HW reset, when "ethtool -g/-G" is called on the netdev,
> the vport associated with the netdev is NULL, and so a kernel panic
> would happen:
> 
> [  513.185327] BUG: kernel NULL pointer dereference, address: 0000000000000038
> ...
> [  513.232756] RIP: 0010:idpf_get_ringparam+0x45/0x80
> 
> This can be reproduced reliably by injecting a TX timeout to cause
> an idpf HW reset, and injecting a virtchnl error to cause the HW
> reset to fail and retry, while calling "ethtool -g/-G" on the netdev
> at the same time.

If you shared the commands, how to do that, it would make reproducing 
the issue easier.

> With this patch applied, we see the following error but no kernel
> panics anymore:
> 
> [  476.323630] idpf 0000:05:00.0 eth1: failed to get ring params due to no vport in netdev
> 
> Signed-off-by: Li Li <boolli@google.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> index d5711be0b8e69..6a4b630b786c2 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> @@ -639,6 +638,10 @@ static void idpf_get_ringparam(struct net_device *netdev,
>   
>   	idpf_vport_ctrl_lock(netdev);
>   	vport = idpf_netdev_to_vport(netdev);
> +	if (!vport) {
> +		netdev_err(netdev, "failed to get ring params due to no vport in netdev\n");

If vport == NULL is expected, why log it as an error. What should the 
user do? Wait until reset is done?

> +		goto unlock;
> +	}
>   
>   	ring->rx_max_pending = IDPF_MAX_RXQ_DESC;
>   	ring->tx_max_pending = IDPF_MAX_TXQ_DESC;
> @@ -647,6 +651,7 @@ static void idpf_get_ringparam(struct net_device *netdev,
>   
>   	kring->tcp_data_split = idpf_vport_get_hsplit(vport);
>   
> +unlock:
>   	idpf_vport_ctrl_unlock(netdev);
>   }
>   
> @@ -673,6 +674,11 @@ static int idpf_set_ringparam(struct net_device *netdev,
>   
>   	idpf_vport_ctrl_lock(netdev);
>   	vport = idpf_netdev_to_vport(netdev);
> +	if (!vport) {
> +		netdev_err(netdev, "ring params not changed due to no vport in netdev\n");
> +		err = -EFAULT;
> +		goto unlock_mutex;
> +	}
>   
>   	idx = vport->idx;
>   

Is there another – possible more involved – solution possible to wait 
until the hardware reset finished?


Kind regards,

Paul

