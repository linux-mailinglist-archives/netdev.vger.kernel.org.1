Return-Path: <netdev+bounces-26107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D4B776D00
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 02:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8407281E73
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 00:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C765336C;
	Thu, 10 Aug 2023 00:18:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9299366
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 00:18:00 +0000 (UTC)
Received: from out-99.mta0.migadu.com (out-99.mta0.migadu.com [91.218.175.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB656E5F
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 17:17:58 -0700 (PDT)
Message-ID: <b5ccef63-4c16-0371-6dda-b3d1f9dfa5d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691626677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ts5SY8qk9Yq+pW7ZHsFRhPsLHZDjCr/E+wM22tgKlnw=;
	b=EOvNLDwuWWRWWmaMqT7Z9PGYK18AMMiSMLAV6Q+/cDGSlig/1T1UDWS+VwDoU415OhtjrI
	8xTnimGfbxyujakHK05KWyfDZuHnBkbnWsKZYTSywYYCaJ1LyHpS6IcjGSrypEdHfixmO/
	2A8FlFgQSrH4HeBF0NGzef4nh9JDJZk=
Date: Thu, 10 Aug 2023 01:17:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 4/5] bonding: use bond_set_slave_arr to simplify
 code
Content-Language: en-US
To: Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: j.vosburgh@gmail.com, andy@greyhouse.net, weiyongjun1@huawei.com,
 yuehaibing@huawei.com
References: <20230809124107.360574-1-shaozhengchao@huawei.com>
 <20230809124107.360574-5-shaozhengchao@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230809124107.360574-5-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 09/08/2023 13:41, Zhengchao Shao wrote:
> In bond_reset_slave_arr(), values are assigned and memory is released only
> when the variables "usable" and "all" are not NULL. But even if the
> "usable" and "all" variables are NULL, they can still work, because value
> will be checked in kfree_rcu. Therefore, use bond_set_slave_arr() and set
> the input parameters "usable_slaves" and "all_slaves" to NULL to simplify
> the code in bond_reset_slave_arr(). And the same to bond_uninit().
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>   drivers/net/bonding/bond_main.c | 29 +++--------------------------
>   1 file changed, 3 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 6636638f5d97..dcc67bd4d5cf 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -5044,21 +5044,9 @@ static void bond_set_slave_arr(struct bonding *bond,
>   	kfree_rcu(all, rcu);
>   }
>   
> -static void bond_reset_slave_arr(struct bonding *bond)
> +static inline void bond_reset_slave_arr(struct bonding *bond)

No explicit inline in c files. Remove it and let the compiler decide.

>   {
> -	struct bond_up_slave *usable, *all;
> -
> -	usable = rtnl_dereference(bond->usable_slaves);
> -	if (usable) {
> -		RCU_INIT_POINTER(bond->usable_slaves, NULL);
> -		kfree_rcu(usable, rcu);
> -	}
> -
> -	all = rtnl_dereference(bond->all_slaves);
> -	if (all) {
> -		RCU_INIT_POINTER(bond->all_slaves, NULL);
> -		kfree_rcu(all, rcu);
> -	}
> +	bond_set_slave_arr(bond, NULL, NULL);
>   }
>   
>   /* Build the usable slaves array in control path for modes that use xmit-hash
> @@ -5951,7 +5939,6 @@ void bond_setup(struct net_device *bond_dev)
>   static void bond_uninit(struct net_device *bond_dev)
>   {
>   	struct bonding *bond = netdev_priv(bond_dev);
> -	struct bond_up_slave *usable, *all;
>   	struct list_head *iter;
>   	struct slave *slave;
>   
> @@ -5962,17 +5949,7 @@ static void bond_uninit(struct net_device *bond_dev)
>   		__bond_release_one(bond_dev, slave->dev, true, true);
>   	netdev_info(bond_dev, "Released all slaves\n");
>   
> -	usable = rtnl_dereference(bond->usable_slaves);
> -	if (usable) {
> -		RCU_INIT_POINTER(bond->usable_slaves, NULL);
> -		kfree_rcu(usable, rcu);
> -	}
> -
> -	all = rtnl_dereference(bond->all_slaves);
> -	if (all) {
> -		RCU_INIT_POINTER(bond->all_slaves, NULL);
> -		kfree_rcu(all, rcu);
> -	}
> +	bond_set_slave_arr(bond, NULL, NULL);
>   
>   	list_del(&bond->bond_list);
>   
-- 
pw-bot: cr


