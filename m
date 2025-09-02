Return-Path: <netdev+bounces-219019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42879B3F694
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 09:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16DE017ADA0
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 07:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A3B1FBC92;
	Tue,  2 Sep 2025 07:25:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C5332F74D;
	Tue,  2 Sep 2025 07:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797922; cv=none; b=pgzfhWU9HYZ1cUgRroFXDcYpImOSkYYHaZ5olsva1ksDO0K+znKSqJF9C4FZStKPezePC2PC2pImotOIcxBciNgMj5BEv+ev2tT0qad2P++eeTNePNHGcUiiNLz5cPtvAqYfuj5kVmNPTL+RBSvWMwC8fz1MHxEcLxh5Vn5VV7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797922; c=relaxed/simple;
	bh=Moyj5TcC9RHNgCT+wYqLEVDJYXrnohcgJQodjkzfmKU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=quTPD5PSIvflxx8N+/3ZficSK9W+XJZA9nwr8orBtFGegC8prAJeRnDo4jCp2DzvA5nJXakTyhVLKx/SyccFc1F/Ro4/aD6lbO3o5jzuHSz27bVCEO+/WclXg3b25rqWjbHPU51oGgjXG7JleooFR8WSH80Bt3yzFDG3K7+LhF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.12.217] (g217.RadioFreeInternet.molgen.mpg.de [141.14.12.217])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id F1F5360213ADA;
	Tue, 02 Sep 2025 09:24:49 +0200 (CEST)
Message-ID: <acf7a445-b58b-49dc-8d2c-1afe86805953@molgen.mpg.de>
Date: Tue, 2 Sep 2025 09:24:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2] ixgbe: fix too early devlink_free()
 in ixgbe_remove()
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Koichiro Den <den@valinux.co.jp>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
 jedrzej.jagielski@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250902003941.2561389-1-den@valinux.co.jp>
 <4f746e98-b81b-4632-a2f8-f14d66c71ced@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <4f746e98-b81b-4632-a2f8-f14d66c71ced@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: Remove mateusz.polchlopek@intel.com (address rejected)]

Am 02.09.25 um 07:08 schrieb Paul Menzel:
> Dear Koichiro,
> 
> 
> Thank you for your patch.
> 
> Am 02.09.25 um 02:39 schrieb Koichiro Den:
>> Since ixgbe_adapter is embedded in devlink, calling devlink_free()
>> prematurely in the ixgbe_remove() path can lead to UAF. Move devlink_free()
>> to the end.
>>
>> KASAN report:
>>
>>   BUG: KASAN: use-after-free in ixgbe_reset_interrupt_capability+0x140/0x180 [ixgbe]
>>   Read of size 8 at addr ffff0000adf813e0 by task bash/2095
>>   CPU: 1 UID: 0 PID: 2095 Comm: bash Tainted: G S  6.17.0-rc2-tnguy.net-queue+ #1 PREEMPT(full)
>>   [...]
>>   Call trace:
>>    show_stack+0x30/0x90 (C)
>>    dump_stack_lvl+0x9c/0xd0
>>    print_address_description.constprop.0+0x90/0x310
>>    print_report+0x104/0x1f0
>>    kasan_report+0x88/0x180
>>    __asan_report_load8_noabort+0x20/0x30
>>    ixgbe_reset_interrupt_capability+0x140/0x180 [ixgbe]
>>    ixgbe_clear_interrupt_scheme+0xf8/0x130 [ixgbe]
>>    ixgbe_remove+0x2d0/0x8c0 [ixgbe]
>>    pci_device_remove+0xa0/0x220
>>    device_remove+0xb8/0x170
>>    device_release_driver_internal+0x318/0x490
>>    device_driver_detach+0x40/0x68
>>    unbind_store+0xec/0x118
>>    drv_attr_store+0x64/0xb8
>>    sysfs_kf_write+0xcc/0x138
>>    kernfs_fop_write_iter+0x294/0x440
>>    new_sync_write+0x1fc/0x588
>>    vfs_write+0x480/0x6a0
>>    ksys_write+0xf0/0x1e0
>>    __arm64_sys_write+0x70/0xc0
>>    invoke_syscall.constprop.0+0xcc/0x280
>>    el0_svc_common.constprop.0+0xa8/0x248
>>    do_el0_svc+0x44/0x68
>>    el0_svc+0x54/0x160
>>    el0t_64_sync_handler+0xa0/0xe8
>>    el0t_64_sync+0x1b0/0x1b8
>>
>> Fixes: a0285236ab93 ("ixgbe: add initial devlink support")
>> Signed-off-by: Koichiro Den <den@valinux.co.jp>
>> ---
>> Changes in v2:
>> - Move only devlink_free()
>> ---
>>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/ 
>> net/ethernet/intel/ixgbe/ixgbe_main.c
>> index 80e6a2ef1350..b3822c229300 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> @@ -12092,7 +12092,6 @@ static void ixgbe_remove(struct pci_dev *pdev)
>>       devl_port_unregister(&adapter->devlink_port);
>>       devl_unlock(adapter->devlink);
>> -    devlink_free(adapter->devlink);
>>       ixgbe_stop_ipsec_offload(adapter);
>>       ixgbe_clear_interrupt_scheme(adapter);
>> @@ -12125,6 +12124,8 @@ static void ixgbe_remove(struct pci_dev *pdev)
>>       if (disable_dev)
>>           pci_disable_device(pdev);
>> +
>> +    devlink_free(adapter->devlink);
>>   }
>>   /**
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul

