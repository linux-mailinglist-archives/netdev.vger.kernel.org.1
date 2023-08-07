Return-Path: <netdev+bounces-25115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858BA773003
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5923F1C20C97
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C561B174D9;
	Mon,  7 Aug 2023 19:59:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72EB15ACD
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 19:59:08 +0000 (UTC)
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182EDB1
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 12:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691438348; x=1722974348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KEwoikW7N6924/M/SdohnuwOWBj/lx6wTWicF2DDoBU=;
  b=a1ZYvPKzWIhN8/H4AYiPGVaRerlLUEFObAujBy65oLoHhv3qHZvsTGkW
   AKhTv7qmXKcLUebgxD9IqG1zlI1D+jjstVaqF1SVzrKlcZlBuKxFA1kMm
   JMyiadIA96upOZRd+LZhPdk0Mgl4z4z2OqGoXRAKQEIKN8XFfHbNnIa+J
   w=;
X-IronPort-AV: E=Sophos;i="6.01,262,1684800000"; 
   d="scan'208";a="356013438"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 19:59:02 +0000
Received: from EX19MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com (Postfix) with ESMTPS id E450340D52;
	Mon,  7 Aug 2023 19:59:00 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 7 Aug 2023 19:59:00 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 7 Aug 2023 19:58:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <william.xuanziyang@huawei.com>
CC: <adobriyan@gmail.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH net-next] ipv6: exthdrs: Replace opencoded swap() implementation
Date: Mon, 7 Aug 2023 12:58:48 -0700
Message-ID: <20230807195848.43547-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230807020947.1991716-1-william.xuanziyang@huawei.com>
References: <20230807020947.1991716-1-william.xuanziyang@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.12]
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ziyang Xuan <william.xuanziyang@huawei.com>
Date: Mon, 7 Aug 2023 10:09:47 +0800
> Get a coccinelle warning as follows:
> net/ipv6/exthdrs.c:800:29-30: WARNING opportunity for swap()
> 
> Use swap() to replace opencoded implementation.
> 
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  net/ipv6/exthdrs.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index f4bfccae003c..4952ae792450 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -648,7 +648,6 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
>  	struct inet6_dev *idev = __in6_dev_get(skb->dev);
>  	struct inet6_skb_parm *opt = IP6CB(skb);
>  	struct in6_addr *addr = NULL;
> -	struct in6_addr daddr;
>  	int n, i;
>  	struct ipv6_rt_hdr *hdr;
>  	struct rt0_hdr *rthdr;
> @@ -796,9 +795,7 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
>  		return -1;
>  	}
>  
> -	daddr = *addr;
> -	*addr = ipv6_hdr(skb)->daddr;
> -	ipv6_hdr(skb)->daddr = daddr;
> +	swap(*addr, ipv6_hdr(skb)->daddr);
>  
>  	ip6_route_input(skb);
>  	if (skb_dst(skb)->error) {
> -- 
> 2.25.1

