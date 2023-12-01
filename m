Return-Path: <netdev+bounces-52769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEF580026A
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 05:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3562815C3
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 04:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E2C6FDA;
	Fri,  1 Dec 2023 04:13:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AAE170D
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 20:13:29 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ShKLq40N4zNmTg;
	Fri,  1 Dec 2023 12:09:07 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Dec 2023 12:13:26 +0800
Message-ID: <81b8bca0-6c61-966a-bac8-fecb0ad60f57@huawei.com>
Date: Fri, 1 Dec 2023 12:13:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net,v2] ipvlan: implement .parse_protocol hook function in
 ipvlan_header_ops
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <luwei32@huawei.com>, <fw@strlen.de>, <maheshb@google.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20231201025528.2216489-1-shaozhengchao@huawei.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <20231201025528.2216489-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected



On 2023/12/1 10:55, Zhengchao Shao wrote:
> The .parse_protocol hook function in the ipvlan_header_ops structure is
> not implemented. As a result, when the AF_PACKET family is used to send
> packets, skb->protocol will be set to 0.
> Ipvlan is a device of type ARPHRD_ETHER (ether_setup). Therefore, use
> eth_header_parse_protocol function to obtain the protocol.
> 
> Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")

Maybe Fixes should be: 75c65772c3d1 ("net/packet: Ask driver for
protocol if not provided by user")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
> v2: modify commit info and add Fixes tag
> ---
>   drivers/net/ipvlan/ipvlan_main.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
> index 57c79f5f2991..f28fd7b6b708 100644
> --- a/drivers/net/ipvlan/ipvlan_main.c
> +++ b/drivers/net/ipvlan/ipvlan_main.c
> @@ -387,6 +387,7 @@ static const struct header_ops ipvlan_header_ops = {
>   	.parse		= eth_header_parse,
>   	.cache		= eth_header_cache,
>   	.cache_update	= eth_header_cache_update,
> +	.parse_protocol	= eth_header_parse_protocol,
>   };
>   
>   static void ipvlan_adjust_mtu(struct ipvl_dev *ipvlan, struct net_device *dev)

