Return-Path: <netdev+bounces-246049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D035CDD97C
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 10:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF6A33002D35
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 09:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EAB2F530A;
	Thu, 25 Dec 2025 09:36:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42709239562;
	Thu, 25 Dec 2025 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766655400; cv=none; b=S+0wXohA+jXAZB+bZPRuvCESmWpN4fzSnFWaxdkrK9+yiUfvxGJL20dvuLpzBOX029sE7qVOrE2iz/YFT+ctgM5iS6Y9rpugD7skIlUsbtZJaz0ufMkhSDlRt0nr1zmtHVUlHnAT3roPaVXWDQuI+rZlzI67jM32SqCMH3E0CDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766655400; c=relaxed/simple;
	bh=5zd9Xzr7uJ6VJVmaLqK49UxwmmNkyq8IF88zoZYhPWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=bdn7XdpM9tDhkkzQpDuurP/eR0gopNKdGGDS0SNuCH88Ro8+cI1geLA0UZC2UpykQX9jZKQ0tjjRlcrguQUUSvFON64s9wchj7lFo07iiCjVwOI9PbOuYODW3tMBUmpyopz5qVPRuwZSpXNebz11mJbKvgLEROL6IjsSNNGPTfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.128.41.173] (unknown [103.50.105.82])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C799C61CC3FCE;
	Thu, 25 Dec 2025 10:26:34 +0100 (CET)
Message-ID: <14a86654-7bcd-48ba-bda6-0205b07877f9@molgen.mpg.de>
Date: Thu, 25 Dec 2025 14:26:14 +0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v3 1/2] ice: Fix NULL pointer
 dereference in ice_vsi_set_napi_queues
To: Aaron Ma <aaron.ma@canonical.com>
References: <20251225062122.736308-1-aaron.ma@canonical.com>
Content-Language: en-US
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251225062122.736308-1-aaron.ma@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Aaron,


Thank you for the patch.

Am 25.12.25 um 11:21 schrieb Aaron Ma via Intel-wired-lan:
> Add NULL pointer checks in ice_vsi_set_napi_queues() to prevent crashes
> during resume from suspend when rings[q_idx]->q_vector is NULL.
> 
> Tested adaptor:
> 60:00.0 Ethernet controller [0200]: Intel Corporation Ethernet Controller E810-XXV for SFP [8086:159b] (rev 02)
>          Subsystem: Intel Corporation Ethernet Network Adapter E810-XXV-2 [8086:4003]
> 
> SR-IOV state: both disabled and enabled can reproduce this issue.
> 
> kernel version: v6.18
> 
> Reproduce steps:
> Bootup and execute suspend like systemctl suspend or rtcwake.
> 
> Log:
> <1>[  231.443607] BUG: kernel NULL pointer dereference, address: 0000000000000040
> <1>[  231.444052] #PF: supervisor read access in kernel mode
> <1>[  231.444484] #PF: error_code(0x0000) - not-present page
> <6>[  231.444913] PGD 0 P4D 0
> <4>[  231.445342] Oops: Oops: 0000 [#1] SMP NOPTI
> <4>[  231.446635] RIP: 0010:netif_queue_set_napi+0xa/0x170
> <4>[  231.447067] Code: 31 f6 31 ff c3 cc cc cc cc 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 85 c9 74 0b <48> 83 79 30 00 0f 84 39 01 00 00 55 41 89 d1 49 89 f8 89 f2 48 89
> <4>[  231.447513] RSP: 0018:ffffcc780fc078c0 EFLAGS: 00010202
> <4>[  231.447961] RAX: ffff8b848ca30400 RBX: ffff8b848caf2028 RCX: 0000000000000010
> <4>[  231.448443] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8b848dbd4000
> <4>[  231.448896] RBP: ffffcc780fc078e8 R08: 0000000000000000 R09: 0000000000000000
> <4>[  231.449345] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> <4>[  231.449817] R13: ffff8b848dbd4000 R14: ffff8b84833390c8 R15: 0000000000000000
> <4>[  231.450265] FS:  00007c7b29e9d740(0000) GS:ffff8b8c068e2000(0000) knlGS:0000000000000000
> <4>[  231.450715] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[  231.451179] CR2: 0000000000000040 CR3: 000000030626f004 CR4: 0000000000f72ef0
> <4>[  231.451629] PKRU: 55555554
> <4>[  231.452076] Call Trace:
> <4>[  231.452549]  <TASK>
> <4>[  231.452996]  ? ice_vsi_set_napi_queues+0x4d/0x110 [ice]
> <4>[  231.453482]  ice_resume+0xfd/0x220 [ice]
> <4>[  231.453977]  ? __pfx_pci_pm_resume+0x10/0x10
> <4>[  231.454425]  pci_pm_resume+0x8c/0x140
> <4>[  231.454872]  ? __pfx_pci_pm_resume+0x10/0x10
> <4>[  231.455347]  dpm_run_callback+0x5f/0x160
> <4>[  231.455796]  ? dpm_wait_for_superior+0x107/0x170
> <4>[  231.456244]  device_resume+0x177/0x270
> <4>[  231.456708]  dpm_resume+0x209/0x2f0
> <4>[  231.457151]  dpm_resume_end+0x15/0x30
> <4>[  231.457596]  suspend_devices_and_enter+0x1da/0x2b0
> <4>[  231.458054]  enter_state+0x10e/0x570
> 
> Add defensive checks for both the ring pointer and its q_vector
> before dereferencing, allowing the system to resume successfully even when
> q_vectors are unmapped.
> 
> Fixes: 2a5dc090b92cf ("ice: move netif_queue_set_napi to rtnl-protected sections")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
> V1 -> V2: add test device info.
> V2 -> V3: no changes.
> 
>   drivers/net/ethernet/intel/ice/ice_lib.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 15621707fbf81..9d1178bde4495 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -2779,11 +2779,13 @@ void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
>   
>   	ASSERT_RTNL();
>   	ice_for_each_rxq(vsi, q_idx)
> -		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_RX,
> +		if (vsi->rx_rings[q_idx] && vsi->rx_rings[q_idx]->q_vector)
> +			netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_RX,
>   				     &vsi->rx_rings[q_idx]->q_vector->napi);
>   
>   	ice_for_each_txq(vsi, q_idx)
> -		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_TX,
> +		if (vsi->tx_rings[q_idx] && vsi->tx_rings[q_idx]->q_vector)
> +			netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_TX,
>   				     &vsi->tx_rings[q_idx]->q_vector->napi);
>   	/* Also set the interrupt number for the NAPI */
>   	ice_for_each_q_vector(vsi, v_idx) {

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Pa

