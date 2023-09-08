Return-Path: <netdev+bounces-32671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0E87990EF
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 22:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975E2281C54
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 20:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C46930FA1;
	Fri,  8 Sep 2023 20:21:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4983830F9D
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 20:21:15 +0000 (UTC)
X-Greylist: delayed 392 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Sep 2023 13:21:06 PDT
Received: from novek.ru (unknown [213.148.174.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102A4B4
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 13:21:06 -0700 (PDT)
Received: from [172.17.1.100] (unknown [158.101.216.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by novek.ru (Postfix) with ESMTPSA id 03A75505F40;
	Fri,  8 Sep 2023 23:13:32 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 novek.ru 03A75505F40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=novek.ru; s=mail;
	t=1694204014; bh=W7m4xYxNe13IU0zNCOqB7BicJuK8qTUVGOMJ6YJepe8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pCIqUEMs3HeJ3FtAmFndR71f5bOgpHFn6w9xG7T7xljSHQ/rNzJvw6GnNx1t6lFvI
	 v/EpKStKKcCI+3aHN1/duuwrE1k7AYtzwAPFcBtKkMtd9N+NmP0VCXWY4JDDi2VTS0
	 g6G7oqSVgMI7cRgU8JppRj0RV2qQ5+2VqhDLpAJM=
Message-ID: <d011459b-2a0f-134b-0d26-afdf2cb36927@novek.ru>
Date: Fri, 8 Sep 2023 21:13:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net] fix null-deref in ipv4_link_failure
To: Kyle Zeng <zengyhkyle@gmail.com>, pabeni@redhat.com, dsahern@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, ssuryaextr@gmail.com
References: <ZPqSfGGAwa1I69Sm@westworld>
Content-Language: en-US
From: Vadim Fedorenko <vfedorenko@novek.ru>
In-Reply-To: <ZPqSfGGAwa1I69Sm@westworld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08.09.2023 04:18, Kyle Zeng wrote:
> Currently, we assume the skb is associated with a device before calling
> __ip_options_compile, which is not always the case if it is re-routed by
> ipvs.
> When skb->dev is NULL, dev_net(skb->dev) will become null-dereference.
> This patch adds a check for the edge case and switch to use the net_device
> from the rtable when skb->dev is NULL.
> 
> Suggested-by: Paolo Abeni<pabeni@redhat.com>
> Suggested-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Kyle Zeng <zengyhkyle@gmail.com>
> Cc: Stephen Suryaputra <ssuryaextr@gmail.com>
> ---
>   net/ipv4/route.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index d8c99bdc617..1be34e5eea1 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -1214,6 +1214,7 @@ EXPORT_INDIRECT_CALLABLE(ipv4_dst_check);
>   static void ipv4_send_dest_unreach(struct sk_buff *skb)
>   {
>   	struct ip_options opt;
> +	struct net_device *dev;

Please, use reverse x-mas tree order for local variables

>   	int res;
>   
>   	/* Recompile ip options since IPCB may not be valid anymore.
> @@ -1230,7 +1231,8 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
>   		opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
>   
>   		rcu_read_lock();
> -		res = __ip_options_compile(dev_net(skb->dev), &opt, skb, NULL);
> +		dev = skb->dev ? skb->dev : skb_rtable(skb)->dst.dev;
> +		res = __ip_options_compile(dev_net(dev), &opt, skb, NULL);
>   		rcu_read_unlock();
>   
>   		if (res)


