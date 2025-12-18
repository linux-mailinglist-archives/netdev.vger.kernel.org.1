Return-Path: <netdev+bounces-245349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D720CCBD2A
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 13:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7A8B30133A3
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 12:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568FE332EAA;
	Thu, 18 Dec 2025 12:43:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CBD332EAE
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766061818; cv=none; b=sQ5Nav06YVZZtVNt9jLiI+x1GhhsvD5yqRY/C+wMSL7QjEfwzQLj6Tx9OAhqo5zQ7+2S4wmuZwGXAoEl+YB4MptpaH1FFyhjVpduiVGpUFbf8kEFOPh5WnrPUX9liNv25ytQbTYp3h5ue+A3qOTE8VM3RmNSJ7MmwoIkkANeQCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766061818; c=relaxed/simple;
	bh=CyWsAYtRberYWPLZGYgzcagZ6gMa3+8tytOYvNC6dj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQziTi2YkN+DjpIDrfhk1wU7fAazpgAhu5kgYGUiYSpwKTN86NATmnL8s23t+5/VjbpOtjFckI9eKyk+Fr4UQX0FQzUERsKRhZX3dIA86GU6f7SDsJAczGzToMspm5vKXugcNkhR+XSk7C5yatE6HezPLdHcJMyQ6SlCjUSLA0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5669D61E64852;
	Thu, 18 Dec 2025 13:42:55 +0100 (CET)
Message-ID: <981a3660-a853-4133-bf83-400ce513c3a6@molgen.mpg.de>
Date: Thu, 18 Dec 2025 13:42:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net v2 1/2] i40e: drop
 udp_tunnel_get_rx_info() call from i40e_open()
To: mheib@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, davem@davemloft.net, aduyck@mirantis.com,
 kuba@kernel.org, netdev@vger.kernel.org, jacob.e.keller@intel.com,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20251218121322.154014-1-mheib@redhat.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251218121322.154014-1-mheib@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Mohammad,


Thank you for your patch.

Am 18.12.25 um 13:13 schrieb mheib@redhat.com:
> From: Mohammad Heib <mheib@redhat.com>
> 
> The i40e driver calls udp_tunnel_get_rx_info() during i40e_open().
> This is redundant because UDP tunnel RX offload state is preserved
> across device down/up cycles. The udp_tunnel core handles
> synchronization automatically when required.
> 
> Furthermore, recent changes in the udp_tunnel infrastructure require
> querying RX info while holding the udp_tunnel lock. Calling it
> directly from the ndo_open path violates this requirement,
> triggering the following lockdep warning:
> 
>    Call Trace:
>     <TASK>
>     ? __udp_tunnel_nic_assert_locked+0x39/0x40 [udp_tunnel]
>     i40e_open+0x135/0x14f [i40e]
>     __dev_open+0x121/0x2e0
>     __dev_change_flags+0x227/0x270
>     dev_change_flags+0x3d/0xb0
>     devinet_ioctl+0x56f/0x860
>     sock_do_ioctl+0x7b/0x130
>     __x64_sys_ioctl+0x91/0xd0
>     do_syscall_64+0x90/0x170
>     ...
>     </TASK>
> 
> Remove the redundant and unsafe call to udp_tunnel_get_rx_info() from
> i40e_open() resolve the locking violation.
> 
> Fixes: 06a5f7f167c5 ("i40e: Move all UDP port notifiers to single function")
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 50be0a60ae13..72358a34438b 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -9029,7 +9029,6 @@ int i40e_open(struct net_device *netdev)
>   						       TCP_FLAG_FIN |
>   						       TCP_FLAG_CWR) >> 16);
>   	wr32(&pf->hw, I40E_GLLAN_TSOMSK_L, be32_to_cpu(TCP_FLAG_CWR) >> 16);
> -	udp_tunnel_get_rx_info(netdev);
>   
>   	return 0;
>   }

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

