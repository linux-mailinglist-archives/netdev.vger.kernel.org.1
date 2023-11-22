Return-Path: <netdev+bounces-49886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 615C17F3B90
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 03:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910EC1C20ED3
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 02:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09E16FDA;
	Wed, 22 Nov 2023 02:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E03193
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 18:04:10 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SZkvJ4R9lzMnKJ;
	Wed, 22 Nov 2023 09:59:24 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 22 Nov 2023 10:04:07 +0800
Message-ID: <8fc84e79-f5c9-8fbe-1fe8-b23b059f03d0@huawei.com>
Date: Wed, 22 Nov 2023 10:04:06 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next,v5] bonding: return -ENOMEM instead of BUG in
 alb_upper_dev_walk
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <j.vosburgh@gmail.com>, <andy@greyhouse.net>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>
References: <20231121125805.949940-1-shaozhengchao@huawei.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <20231121125805.949940-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected



On 2023/11/21 20:58, Zhengchao Shao wrote:
> If failed to allocate "tags" or could not find the final upper device from
> start_dev's upper list in bond_verify_device_path(), only the loopback
> detection of the current upper device should be affected, and the system is
> no need to be panic.
> So just return -ENOMEM in alb_upper_dev_walk to stop walking.
> 
> I also think that the following function calls
> netdev_walk_all_upper_dev_rcu
> ---->>>alb_upper_dev_walk
> ---------->>>bond_verify_device_path
>>From this way, "end device" can eventually be obtained from "start device"
> in bond_verify_device_path, IS_ERR(tags) could be instead of
> IS_ERR_OR_NULL(tags) in alb_upper_dev_walk.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>
> ---
> v5: drop print information, if the memory allocation fails, the mm layer
>      will emit a lot warning comprising the backtrace
> v4: print information instead of warn
> v3: return -ENOMEM instead of zero to stop walk
> v2: use WARN_ON_ONCE instead of WARN_ON
> ---
>   drivers/net/bonding/bond_alb.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
> index dc2c7b979656..7edf0fd58c34 100644
> --- a/drivers/net/bonding/bond_alb.c
> +++ b/drivers/net/bonding/bond_alb.c
> @@ -985,7 +985,8 @@ static int alb_upper_dev_walk(struct net_device *upper,
>   	if (netif_is_macvlan(upper) && !strict_match) {
>   		tags = bond_verify_device_path(bond->dev, upper, 0);
>   		if (IS_ERR_OR_NULL(tags))
> -			BUG();
> +			return -ENOMEM;
> +
>   		alb_send_lp_vid(slave, upper->dev_addr,
>   				tags[0].vlan_proto, tags[0].vlan_id);
>   		kfree(tags);
Hi Paolo:
	I find that v4 has been merged into net-next. So v5 is not
needed. But should I send another patch to drop that print info?

Thanks

Zhengchao Shao


