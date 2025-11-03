Return-Path: <netdev+bounces-235037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DD6C2B782
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 12:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09C8F4EE589
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 11:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1D52E7F0A;
	Mon,  3 Nov 2025 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWNOFYa+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C822FDC24
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169847; cv=none; b=gpoxCLnlNfP8e4lbCrd2uGFO0/uXXJAW+nmv2ERLOajBLGmQubZuw9yN7zenO0e99VbbDq38H/tKqtjE4ggYI7RQl86v/LOlqFvn3YjjsPesyrvs3TeI1PjHpGRwS1o2wdBaezidlUVvCn2dm3+n74IR1MXdsxAeBhRdrMzJRd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169847; c=relaxed/simple;
	bh=kY/iJi4arkXXy2nTH5wjSvZwGRn/TfwF4M2TFlLuMwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UY5puCefBQzXN2uvhTPMz+u2uS9jrNJwx1cHuyeklw3VE8rEjnrRDv3bRnRwA29vFACM4xlK49I4gLGA9qy7HO2lXWALepJ3pWX4APbKHkIoAdbQQ2pi8m8/dEzCYfHRioVm+4+aYpuHHf0/Q7ciwXjVw8Die36hPw0A7GqXiVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWNOFYa+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4298b865f84so1890535f8f.3
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 03:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762169844; x=1762774644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fGf2wbf0uI2U/GiDROPiXJePkoI1lOzS1fiBoz8P3ts=;
        b=lWNOFYa+WwI1o0ppUZXcbhWqGJjmZojvYsvtXZyo8lvTuxUqvqMgrhE3xqosvrLLFv
         2T1sfRtydRsZ4xabguD1H7503IHmyb9DQFsYyVOB5Z58/ikEgLaUXjl7xeTWNF23uUOW
         qQpLAda57/NBNNDAYx9DlKtrhLtM81Q/EqXo0uwthfHt+Z+xpBiksAjdySo0o4eJKYOG
         BdxXq8X2V8TOBxQAvH5SKuDoxT1NMxxEP03HXgiv5Nq2xlLIhSGe44ky0ZgBHirAmaMB
         jG4o+nD9HI2Gqj457njrJ2b3dLoOwrk56OVn9knyjEIFx+n91qH+BdGt7UwKJUjKM3R/
         UZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762169844; x=1762774644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fGf2wbf0uI2U/GiDROPiXJePkoI1lOzS1fiBoz8P3ts=;
        b=JA7Lo8vZJQgSGAWisVV1lHYL4JhEyrDP5ux50V5hO64kS6biYNDKhLpUYGffeR3cgK
         1TULVH6xLct4826L0j4K0y3nLfr1P0gsp9/lGyn9X8lUOYy/xSsr/olhOmHbLw8lI9/D
         Sr/STJs492ZgeaWx18Cw0bMkh+FHxRhcKTfe82XC+Q5XWWCKTY61I5bnFRHRKHfvmxi+
         eBXYm7i3X5Y7gqxQF9TCaRNTR98zoYDNjnFU4+TwwjS3d9v5MOZiNq6w3gqwncC+qvEw
         BS+FdGVH3cUanNwq3ZKqnKPXLyJatq/rePpEM/A6vXCs1xS2t07qFnuch+f8e4YDmdla
         yIyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNtljULC75U9psihZvQHG2MwHIV5Msa4pHhrWSFKMcy1EVYMcknfnYt+YGELxd9y82K5mMGOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy4WZR7gxz+WVFw3HmOIJ1oGKjzqT7ZtxLJQWxeb4F6Jxp+9C0
	ui5q8lZrJy3o9gcd17pyXxKyzjWfl1gMlwiZEJopHOJzni3Hd6yaUFj9
X-Gm-Gg: ASbGnctkkBxRR055kM1YY564q+vS51AC7V6T/ESpvSQNnCWISRqfx/6ckbBtwJhuQ0h
	HEb/Rb/Q/HtNiTnpnS9HQZ7mQSRUlD3S05X1vWYrus+w1A4Le7BYzxwe9Db7mbAZrt+1+SyffsL
	RBJYbCZ/NTsR6LVieFjP4T5XpS3V13OuoTW2Ik8DY6DaLWweYSXe54zhUtSL9NrBoNrWo1Bw9sU
	+gwHjwJ8Iru8Qjgsg1qE0qAFc8MUxUTfnFGWTw6/wkj6LpHfVqH/VoETdPMPZ+hXxa/1TOHEs58
	+PRIVBHQmvxWijdwHBgdkLle7zgnFJ1QeuzCo2HwGuUal3Q+DitfpQavJIFCWRhkvTbkaexTaQH
	arQWKwjL0DDeIx+Yzk6O34L9WaE9Odk5n1yD9kgHhbqGHOX6Y+/JA8O++DPh2vlXt6LWwG2o/4Q
	aI83ebRCu5GwQKenEko9OMlhpAcek=
X-Google-Smtp-Source: AGHT+IHCBg7sLqG2LWpIo+1eoVST1UzS7i7WGN4zqkMamfsDvo+5Px//qioswY1awkExN0gLGrqz1Q==
X-Received: by 2002:a05:6000:2887:b0:429:b9bc:e810 with SMTP id ffacd0b85a97d-429bd6e16eemr11588120f8f.45.1762169843347;
        Mon, 03 Nov 2025 03:37:23 -0800 (PST)
Received: from [10.80.3.86] ([72.25.96.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c85ad188sm13790999f8f.20.2025.11.03.03.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 03:37:23 -0800 (PST)
Message-ID: <9e402ff9-906d-4b27-bc6c-7431dd38de67@gmail.com>
Date: Mon, 3 Nov 2025 13:37:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/1] net/mlx5: Clean up only new IRQ glue on
 request_irq() failure
To: Pradyumn Rahar <pradyumn.rahar@oracle.com>, shayd@nvidia.com
Cc: anand.a.khoje@oracle.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, elic@nvidia.com, jacob.e.keller@intel.com,
 kuba@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, manjunath.b.patil@oracle.com, mbloch@nvidia.com,
 moshe@nvidia.com, netdev@vger.kernel.org, pabeni@redhat.com,
 qing.huang@oracle.com, rajesh.sivaramasubramaniom@oracle.com,
 rama.nichanamatlu@oracle.com, rohit.sajan.kumar@oracle.com,
 saeedm@nvidia.com, tariqt@nvidia.com
References: <d9bea817-279c-4024-9bff-c258371b3de7@nvidia.com>
 <20250923062823.89874-1-pradyumn.rahar@oracle.com>
 <f4975aab-8fe5-4247-8fbc-919345a970d7@oracle.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <f4975aab-8fe5-4247-8fbc-919345a970d7@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27/10/2025 16:29, Pradyumn Rahar wrote:
> 
> On 23-09-2025 11:58, Pradyumn Rahar wrote:
>> The mlx5_irq_alloc() function can inadvertently free the entire rmap
>> and end up in a crash[1] when the other threads tries to access this,
>> when request_irq() fails due to exhausted IRQ vectors. This commit
>> modifies the cleanup to remove only the specific IRQ mapping that was
>> just added.
>>
>> This prevents removal of other valid mappings and ensures precise
>> cleanup of the failed IRQ allocation's associated glue object.
>>
>> Note: This error is observed when both fwctl and rds configs are enabled.
>>
>> [1]
>> mlx5_core 0000:05:00.0: Successfully registered panic handler for port 1
>> mlx5_core 0000:05:00.0: mlx5_irq_alloc:293:(pid 66740): Failed to
>> request irq. err = -28
>> infiniband mlx5_0: mlx5_ib_test_wc:290:(pid 66740): Error -28 while
>> trying to test write-combining support
>> mlx5_core 0000:05:00.0: Successfully unregistered panic handler for 
>> port 1
>> mlx5_core 0000:06:00.0: Successfully registered panic handler for port 1
>> mlx5_core 0000:06:00.0: mlx5_irq_alloc:293:(pid 66740): Failed to
>> request irq. err = -28
>> infiniband mlx5_0: mlx5_ib_test_wc:290:(pid 66740): Error -28 while
>> trying to test write-combining support
>> mlx5_core 0000:06:00.0: Successfully unregistered panic handler for 
>> port 1
>> mlx5_core 0000:03:00.0: mlx5_irq_alloc:293:(pid 28895): Failed to
>> request irq. err = -28
>> mlx5_core 0000:05:00.0: mlx5_irq_alloc:293:(pid 28895): Failed to
>> request irq. err = -28
>> general protection fault, probably for non-canonical address
>> 0xe277a58fde16f291: 0000 [#1] SMP NOPTI
>>
>> RIP: 0010:free_irq_cpu_rmap+0x23/0x7d
>> Call Trace:
>>     <TASK>
>>     ? show_trace_log_lvl+0x1d6/0x2f9
>>     ? show_trace_log_lvl+0x1d6/0x2f9
>>     ? mlx5_irq_alloc.cold+0x5d/0xf3 [mlx5_core]
>>     ? __die_body.cold+0x8/0xa
>>     ? die_addr+0x39/0x53
>>     ? exc_general_protection+0x1c4/0x3e9
>>     ? dev_vprintk_emit+0x5f/0x90
>>     ? asm_exc_general_protection+0x22/0x27
>>     ? free_irq_cpu_rmap+0x23/0x7d
>>     mlx5_irq_alloc.cold+0x5d/0xf3 [mlx5_core]
>>     irq_pool_request_vector+0x7d/0x90 [mlx5_core]
>>     mlx5_irq_request+0x2e/0xe0 [mlx5_core]
>>     mlx5_irq_request_vector+0xad/0xf7 [mlx5_core]
>>     comp_irq_request_pci+0x64/0xf0 [mlx5_core]
>>     create_comp_eq+0x71/0x385 [mlx5_core]
>>     ? mlx5e_open_xdpsq+0x11c/0x230 [mlx5_core]
>>     mlx5_comp_eqn_get+0x72/0x90 [mlx5_core]
>>     ? xas_load+0x8/0x91
>>     mlx5_comp_irqn_get+0x40/0x90 [mlx5_core]
>>     mlx5e_open_channel+0x7d/0x3c7 [mlx5_core]
>>     mlx5e_open_channels+0xad/0x250 [mlx5_core]
>>     mlx5e_open_locked+0x3e/0x110 [mlx5_core]
>>     mlx5e_open+0x23/0x70 [mlx5_core]
>>     __dev_open+0xf1/0x1a5
>>     __dev_change_flags+0x1e1/0x249
>>     dev_change_flags+0x21/0x5c
>>     do_setlink+0x28b/0xcc4
>>     ? __nla_parse+0x22/0x3d
>>     ? inet6_validate_link_af+0x6b/0x108
>>     ? cpumask_next+0x1f/0x35
>>     ? __snmp6_fill_stats64.constprop.0+0x66/0x107
>>     ? __nla_validate_parse+0x48/0x1e6
>>     __rtnl_newlink+0x5ff/0xa57
>>     ? kmem_cache_alloc_trace+0x164/0x2ce
>>     rtnl_newlink+0x44/0x6e
>>     rtnetlink_rcv_msg+0x2bb/0x362
>>     ? __netlink_sendskb+0x4c/0x6c
>>     ? netlink_unicast+0x28f/0x2ce
>>     ? rtnl_calcit.isra.0+0x150/0x146
>>     netlink_rcv_skb+0x5f/0x112
>>     netlink_unicast+0x213/0x2ce
>>     netlink_sendmsg+0x24f/0x4d9
>>     __sock_sendmsg+0x65/0x6a
>>     ____sys_sendmsg+0x28f/0x2c9
>>     ? import_iovec+0x17/0x2b
>>     ___sys_sendmsg+0x97/0xe0
>>     __sys_sendmsg+0x81/0xd8
>>     do_syscall_64+0x35/0x87
>>     entry_SYSCALL_64_after_hwframe+0x6e/0x0
>> RIP: 0033:0x7fc328603727
>> Code: c3 66 90 41 54 41 89 d4 55 48 89 f5 53 89 fb 48 83 ec 10 e8 0b ed
>> ff ff 44 89 e2 48 89 ee 89 df 41 89 c0 b8 2e 00 00 00 0f 05 <48> 3d 00
>> f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 44 ed ff ff 48
>> RSP: 002b:00007ffe8eb3f1a0 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
>> RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007fc328603727
>> RDX: 0000000000000000 RSI: 00007ffe8eb3f1f0 RDI: 000000000000000d
>> RBP: 00007ffe8eb3f1f0 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
>> R13: 0000000000000000 R14: 00007ffe8eb3f3c8 R15: 00007ffe8eb3f3bc
>>     </TASK>
>> ---[ end trace f43ce73c3c2b13a2 ]---
>> RIP: 0010:free_irq_cpu_rmap+0x23/0x7d
>> Code: 0f 1f 80 00 00 00 00 48 85 ff 74 6b 55 48 89 fd 53 66 83 7f 06 00
>> 74 24 31 db 48 8b 55 08 0f b7 c3 48 8b 04 c2 48 85 c0 74 09 <8b> 38 31
>> f6 e8 c4 0a b8 ff 83 c3 01 66 3b 5d 06 72 de b8 ff ff ff
>> RSP: 0018:ff384881640eaca0 EFLAGS: 00010282
>> RAX: e277a58fde16f291 RBX: 0000000000000000 RCX: 0000000000000000
>> RDX: ff2335e2e20b3600 RSI: 0000000000000000 RDI: ff2335e2e20b3400
>> RBP: ff2335e2e20b3400 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 00000000ffffffe4 R12: ff384881640ead88
>> R13: ff2335c3760751e0 R14: ff2335e2e1672200 R15: ff2335c3760751f8
>> FS:  00007fc32ac22480(0000) GS:ff2335e2d6e00000(0000)
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f651ab54000 CR3: 00000029f1206003 CR4: 0000000000771ef0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> PKRU: 55555554
>> Kernel panic - not syncing: Fatal exception
>> Kernel Offset: 0x1dc00000 from 0xffffffff81000000 (relocation range:
>> 0xffffffff80000000-0xffffffffbfffffff)
>> kvm-guest: disable async PF for cpu 0
>>
>> Fixes: 3354822cde5a ("net/mlx5: Use dynamic msix vectors allocation")
>> Signed-off-by: Mohith Kumar 
>> Thummaluru<mohith.k.kumar.thummaluru@oracle.com>
>> Tested-by: Mohith Kumar Thummaluru<mohith.k.kumar.thummaluru@oracle.com>
>> Reviewed-by: Moshe Shemesh<moshe@nvidia.com>
>> Signed-off-by: Pradyumn Rahar <pradyumn.rahar@oracle.com>
>> ---
>> v1->v2: removed unnecessary braces from if conditon.
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/ 
>> drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
>> index 692ef9c2f729..82ada674f8e2 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
>> @@ -324,10 +324,8 @@ struct mlx5_irq *mlx5_irq_alloc(struct 
>> mlx5_irq_pool *pool, int i,
>>       free_irq(irq->map.virq, &irq->nh);
>>   err_req_irq:
>>   #ifdef CONFIG_RFS_ACCEL
>> -    if (i && rmap && *rmap) {
>> -        free_irq_cpu_rmap(*rmap);
>> -        *rmap = NULL;
>> -    }
>> +    if (i && rmap && *rmap)
>> +        irq_cpu_rmap_remove(*rmap, irq->map.virq);
>>   err_irq_rmap:
>>   #endif
>>       if (i && pci_msix_can_alloc_dyn(dev->pdev))
> 
> Hi, this patch has been reviewed but hasn't been applied yet. Could you 
> please look into it?
> 
> Thanks.
> 
> 

I'll re-send it.

Thanks.

