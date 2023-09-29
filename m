Return-Path: <netdev+bounces-36986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C91D87B2D1C
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 09:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id C87271C209B0
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 07:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E5FC2C6;
	Fri, 29 Sep 2023 07:36:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAE0386
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 07:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72742C433C8;
	Fri, 29 Sep 2023 07:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695972979;
	bh=V19YE08mTK7veuFJ0AY6X/RLmnFyUIo1UhkW7sDHHWM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=TO4K+fc3FAYN/7c3my3w5xJore020Kl1up3D64cmC04RqzfMrZ/yaIgrDtXuReozg
	 H9ZlYbjrgBg6GnBa1/rZRLSkmMrBCCb4ehcVXvLOIYh3C2p44ON0d98BCEJbtAwXxm
	 mIWFt367cAFjhgKKshRdsIz7IR8TR2MATsmP6wjeUytoUK70mFOq6BOxxs/tC1ACOM
	 vRyBqR7e5x3rO1FK6xmamaXnAei6AfYFzmXEj5alp6dFOVdHNmJXvxddvvy5sLd8K6
	 JyFMo6Q4K+hKJPKiNxb6RaRnbAf25HStida6heAutfEkOvJObwfKCTLqq8ks7cSKjq
	 0nL/tbCsiL1mA==
Message-ID: <daab44eb-73b0-f67d-b7ec-ed1ee49eff2d@kernel.org>
Date: Fri, 29 Sep 2023 09:36:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: thomas.petazzoni@bootlin.com, lorenzo@kernel.org,
 Paulo.DaSilva@kyberna.com, hawk@kernel.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Matteo Croce <mcroce@microsoft.com>
Subject: Re: [PATCH] net: mvneta: fix calls to page_pool_get_stats
To: Sven Auhagen <sven.auhagen@voleatech.de>, netdev@vger.kernel.org
References: <lagygwdvtqwndmqzx6bccs5wixyl2dvt4cdnkzbh7o5idt3lks@2ytjspavah6n>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <lagygwdvtqwndmqzx6bccs5wixyl2dvt4cdnkzbh7o5idt3lks@2ytjspavah6n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/09/2023 06.04, Sven Auhagen wrote:
> Calling page_pool_get_stats in the mvneta driver without checks
> leads to kernel crashes.
> First the page pool is only available if the bm is not used.
> The page pool is also not allocated when the port is stopped.
> It can also be not allocated in case of errors.
> 
> The current implementation leads to the following crash calling
> ethstats on a port that is down or when calling it at the wrong moment:
> 
> ble to handle kernel NULL pointer dereference at virtual address 00000070
> [00000070] *pgd=00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Hardware name: Marvell Armada 380/385 (Device Tree)
> PC is at page_pool_get_stats+0x18/0x1cc
> LR is at mvneta_ethtool_get_stats+0xa0/0xe0 [mvneta]
> pc : [<c0b413cc>]    lr : [<bf0a98d8>]    psr: a0000013
> sp : f1439d48  ip : f1439dc0  fp : 0000001d
> r10: 00000100  r9 : c4816b80  r8 : f0d75150
> r7 : bf0b400c  r6 : c238f000  r5 : 00000000  r4 : f1439d68
> r3 : c2091040  r2 : ffffffd8  r1 : f1439d68  r0 : 00000000
> Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 066b004a  DAC: 00000051
> Register r0 information: NULL pointer
> Register r1 information: 2-page vmalloc region starting at 0xf1438000 allocated at kernel_clone+0x9c/0x390
> Register r2 information: non-paged memory
> Register r3 information: slab kmalloc-2k start c2091000 pointer offset 64 size 2048
> Register r4 information: 2-page vmalloc region starting at 0xf1438000 allocated at kernel_clone+0x9c/0x390
> Register r5 information: NULL pointer
> Register r6 information: slab kmalloc-cg-4k start c238f000 pointer offset 0 size 4096
> Register r7 information: 15-page vmalloc region starting at 0xbf0a8000 allocated at load_module+0xa30/0x219c
> Register r8 information: 1-page vmalloc region starting at 0xf0d75000 allocated at ethtool_get_stats+0x138/0x208
> Register r9 information: slab task_struct start c4816b80 pointer offset 0
> Register r10 information: non-paged memory
> Register r11 information: non-paged memory
> Register r12 information: 2-page vmalloc region starting at 0xf1438000 allocated at kernel_clone+0x9c/0x390
> Process snmpd (pid: 733, stack limit = 0x38de3a88)
> Stack: (0xf1439d48 to 0xf143a000)
> 9d40:                   000000c0 00000001 c238f000 bf0b400c f0d75150 c4816b80
> 9d60: 00000100 bf0a98d8 00000000 00000000 00000000 00000000 00000000 00000000
> 9d80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 9da0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 9dc0: 00000dc0 5335509c 00000035 c238f000 bf0b2214 01067f50 f0d75000 c0b9b9c8
> 9de0: 0000001d 00000035 c2212094 5335509c c4816b80 c238f000 c5ad6e00 01067f50
> 9e00: c1b0be80 c4816b80 00014813 c0b9d7f0 00000000 00000000 0000001d 0000001d
> 9e20: 00000000 00001200 00000000 00000000 c216ed90 c73943b8 00000000 00000000
> 9e40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 9e60: 00000000 c0ad9034 00000000 00000000 00000000 00000000 00000000 00000000
> 9e80: 00000000 00000000 00000000 5335509c c1b0be80 f1439ee4 00008946 c1b0be80
> 9ea0: 01067f50 f1439ee3 00000000 00000046 b6d77ae0 c0b383f0 00008946 becc83e8
> 9ec0: c1b0be80 00000051 0000000b c68ca480 c7172d00 c0ad8ff0 f1439ee3 cf600e40
> 9ee0: 01600e40 32687465 00000000 00000000 00000000 01067f50 00000000 00000000
> 9f00: 00000000 5335509c 00008946 00008946 00000000 c68ca480 becc83e8 c05e2de0
> 9f20: f1439fb0 c03002f0 00000006 5ac3c35a c4816b80 00000006 b6d77ae0 c030caf0
> 9f40: c4817350 00000014 f1439e1c 0000000c 00000000 00000051 01000000 00000014
> 9f60: 00003fec f1439edc 00000001 c0372abc b6d77ae0 c0372abc cf600e40 5335509c
> 9f80: c21e6800 01015c9c 0000000b 00008946 00000036 c03002f0 c4816b80 00000036
> 9fa0: b6d77ae0 c03000c0 01015c9c 0000000b 0000000b 00008946 becc83e8 00000000
> 9fc0: 01015c9c 0000000b 00008946 00000036 00000035 010678a0 b6d797ec b6d77ae0
> 9fe0: b6dbf738 becc838c b6d186d7 b6baa858 40000030 0000000b 00000000 00000000
>   page_pool_get_stats from mvneta_ethtool_get_stats+0xa0/0xe0 [mvneta]
>   mvneta_ethtool_get_stats [mvneta] from ethtool_get_stats+0x154/0x208
>   ethtool_get_stats from dev_ethtool+0xf48/0x2480
>   dev_ethtool from dev_ioctl+0x538/0x63c
>   dev_ioctl from sock_ioctl+0x49c/0x53c
>   sock_ioctl from sys_ioctl+0x134/0xbd8
>   sys_ioctl from ret_fast_syscall+0x0/0x1c
> Exception stack(0xf1439fa8 to 0xf1439ff0)
> 9fa0:                   01015c9c 0000000b 0000000b 00008946 becc83e8 00000000
> 9fc0: 01015c9c 0000000b 00008946 00000036 00000035 010678a0 b6d797ec b6d77ae0
> 9fe0: b6dbf738 becc838c b6d186d7 b6baa858
> Code: e28dd004 e1a05000 e2514000 0a00006a (e5902070)
> 
> This commit adds the proper checks before calling page_pool_get_stats.
> 
> Fixes: b3fc792 ("net: mvneta: add support for page_pool_get_stats")
> Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
> Reported-by: Paulo Da Silva <paulo.dasilva@kyberna.com>
> 

Thanks for fixing this.

I cc'ed Ilias (+Matteo) as I'm still in Paris and only skimmed the patch 
from my hotel room.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index d50ac1fc288a..6331f284dc97 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -4734,13 +4734,16 @@ static void mvneta_ethtool_get_strings(struct net_device *netdev, u32 sset,
>   {
>   	if (sset == ETH_SS_STATS) {
>   		int i;
> +		struct mvneta_port *pp = netdev_priv(netdev);
>   
>   		for (i = 0; i < ARRAY_SIZE(mvneta_statistics); i++)
>   			memcpy(data + i * ETH_GSTRING_LEN,
>   			       mvneta_statistics[i].name, ETH_GSTRING_LEN);
>   
> -		data += ETH_GSTRING_LEN * ARRAY_SIZE(mvneta_statistics);
> -		page_pool_ethtool_stats_get_strings(data);
> +		if (!pp->bm_priv) {
> +			data += ETH_GSTRING_LEN * ARRAY_SIZE(mvneta_statistics);
> +			page_pool_ethtool_stats_get_strings(data);
> +		}
>   	}
>   }
>   
> @@ -4858,8 +4861,10 @@ static void mvneta_ethtool_pp_stats(struct mvneta_port *pp, u64 *data)
>   	struct page_pool_stats stats = {};
>   	int i;
>   
> -	for (i = 0; i < rxq_number; i++)
> -		page_pool_get_stats(pp->rxqs[i].page_pool, &stats);
> +	for (i = 0; i < rxq_number; i++) {
> +		if (pp->rxqs[i].page_pool)
> +			page_pool_get_stats(pp->rxqs[i].page_pool, &stats);
> +	}
>   
>   	page_pool_ethtool_stats_get(data, &stats);
>   }
> @@ -4875,14 +4880,21 @@ static void mvneta_ethtool_get_stats(struct net_device *dev,
>   	for (i = 0; i < ARRAY_SIZE(mvneta_statistics); i++)
>   		*data++ = pp->ethtool_stats[i];
>   
> -	mvneta_ethtool_pp_stats(pp, data);
> +	if (!pp->bm_priv && !pp->is_stopped)
> +		mvneta_ethtool_pp_stats(pp, data);
>   }
>   
>   static int mvneta_ethtool_get_sset_count(struct net_device *dev, int sset)
>   {
> -	if (sset == ETH_SS_STATS)
> -		return ARRAY_SIZE(mvneta_statistics) +
> -		       page_pool_ethtool_stats_get_count();
> +	if (sset == ETH_SS_STATS) {
> +		int count = ARRAY_SIZE(mvneta_statistics);
> +		struct mvneta_port *pp = netdev_priv(dev);
> +
> +		if (!pp->bm_priv)
> +			count += page_pool_ethtool_stats_get_count();
> +
> +		return count;
> +	}
>   
>   	return -EOPNOTSUPP;
>   }

