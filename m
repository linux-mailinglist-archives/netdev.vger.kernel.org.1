Return-Path: <netdev+bounces-16171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1518874BB1E
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 03:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C211C21113
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 01:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE31B10F6;
	Sat,  8 Jul 2023 01:35:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34007F
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 01:35:33 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FFEC9
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 18:35:30 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QyXnY44tXztQSZ;
	Sat,  8 Jul 2023 09:32:33 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 8 Jul 2023 09:35:27 +0800
Subject: Re: [PATCH v2 net] icmp6: Fix null-ptr-deref of
 ip6_null_entry->rt6i_idev in icmp6_dev().
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, Wang
 Yufen <wangyufen@huawei.com>
References: <20230708002145.64069-1-kuniyu@amazon.com>
From: YueHaibing <yuehaibing@huawei.com>
Message-ID: <8ae0ccf3-0e88-f968-037d-f7f2a1d7ba9a@huawei.com>
Date: Sat, 8 Jul 2023 09:35:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230708002145.64069-1-kuniyu@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/7/8 8:21, Kuniyuki Iwashima wrote:
> With some IPv6 Ext Hdr (RPL, SRv6, etc.), we can send a packet that
> has the link-local address as src and dst IP and will be forwarded to
> an external IP in the IPv6 Ext Hdr.
> 
> For example, the script below generates a SRv6 packet whose src IP is
> the link-local address and dst is updated to 11::.
> 
>   # for f in $(find /proc/sys/net/ -name *seg6_enabled*); do echo 1 > $f; done
>   # python3
>   >>> from socket import *
>   >>> from scapy.all import *
>   >>>
>   >>> SRC_ADDR = DST_ADDR = "fe80::5054:ff:fe12:3456"
>   >>>
>   >>> pkt = IPv6(src=SRC_ADDR, dst=DST_ADDR)
>   >>> pkt /= IPv6ExtHdrSegmentRouting(type=4, addresses=["11::", "22::"], segleft=1)
>   >>>
>   >>> sk = socket(AF_INET6, SOCK_RAW, IPPROTO_RAW)
>   >>> sk.sendto(bytes(pkt), (DST_ADDR, 0))
> 
> For such a packet, we call ip6_route_input() to look up a route for the
> next destination in these three functions depending on the header type.
> 
>   * ipv6_rthdr_rcv()
>   * ipv6_rpl_srh_rcv()
>   * ipv6_srh_rcv()
> 
> If no route is found, ip6_null_entry is set to skb, and the following
> dst_input(skb) calls ip6_pkt_drop().
> 
> Finally, in icmp6_dev(), we dereference skb_rt6_info(skb)->rt6i_idev->dev
> as the input device is the loopback interface.  Then, we have to check if
> skb_rt6_info(skb)->rt6i_idev is NULL or not to avoid NULL pointer deref
> for ip6_null_entry.
> 
...

> Fixes: 4832c30d5458 ("net: ipv6: put host and anycast routes on device with address")
> Reported-by: Wang Yufen <wangyufen@huawei.com>

> Closes: https://lore.kernel.org/netdev/1ddf7fc8-bcb3-ab48-4894-24158e8a9d0f@huawei.com/

This link seems not right.

> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> ---
> v2:
>   * Add Reviewed-by
>   * s/fib6_null_entry/ip6_null_entry/
> 
> v1: https://lore.kernel.org/netdev/20230706233024.63730-1-kuniyu@amazon.com/
> ---
>  net/ipv6/icmp.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
> index 9edf1f45b1ed..65fa5014bc85 100644
> --- a/net/ipv6/icmp.c
> +++ b/net/ipv6/icmp.c
> @@ -424,7 +424,10 @@ static struct net_device *icmp6_dev(const struct sk_buff *skb)
>  	if (unlikely(dev->ifindex == LOOPBACK_IFINDEX || netif_is_l3_master(skb->dev))) {
>  		const struct rt6_info *rt6 = skb_rt6_info(skb);
>  
> -		if (rt6)
> +		/* The destination could be an external IP in Ext Hdr (SRv6, RPL, etc.),
> +		 * and ip6_null_entry could be set to skb if no route is found.
> +		 */
> +		if (rt6 && rt6->rt6i_idev)
>  			dev = rt6->rt6i_idev->dev;
>  	}
>  
> 

