Return-Path: <netdev+bounces-25121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 069F6773037
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 22:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DA2281515
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 20:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630CD174EA;
	Mon,  7 Aug 2023 20:18:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F6D174DF
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 20:18:02 +0000 (UTC)
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE7F10E9;
	Mon,  7 Aug 2023 13:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691439480; x=1722975480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OjaD1kiL3NKu3sqnMgGz4vBVLZs1JplbyeNEYGhZYI8=;
  b=Z2vb0LJ596ZAnbGP67PRzpe7SM22pChumwTNCejhb8A8T2RWGKWEW0q5
   B46Gf/l5ig+E+sfv5952UYhX5EBnXZXI9u7hqTlvlEdRRJK8tQ5PE6FWY
   /AeyqdwL9y5FHjHUBwsp1XSGxpPmE0cSYwA543P+6Jfz2tDh7EDxbGcJm
   E=;
X-IronPort-AV: E=Sophos;i="6.01,262,1684800000"; 
   d="scan'208";a="1147272346"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 20:17:54 +0000
Received: from EX19MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com (Postfix) with ESMTPS id D6A6540D59;
	Mon,  7 Aug 2023 20:17:53 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 7 Aug 2023 20:17:46 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 7 Aug 2023 20:17:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <xu.xin.sc@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <si.hao@zte.com.cn>, <xu.xin16@zte.com.cn>,
	<yang.yang29@zte.com.cn>, <kuniyu@amazon.com>
Subject: Re: [PATCH linux-next v2] net/ipv4: return the real errno instead of -EINVAL
Date: Mon, 7 Aug 2023 13:17:33 -0700
Message-ID: <20230807201733.45450-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230807015408.248237-1-xu.xin16@zte.com.cn>
References: <20230807015408.248237-1-xu.xin16@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.12]
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From:   xu.xin.sc@gmail.com
Date:   Mon,  7 Aug 2023 01:54:08 +0000
> From: xu xin <xu.xin16@zte.com.cn>
> 
> For now, No matter what error pointer ip_neigh_for_gw() returns,
> ip_finish_output2() always return -EINVAL, which may mislead the upper
> users.
> 
> For exemple, an application uses sendto to send an UDP packet, but when the
> neighbor table overflows, sendto() will get a value of -EINVAL, and it will
> cause users to waste a lot of time checking parameters for errors.
> 
> Return the real errno instead of -EINVAL.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>

Recently I was also investigating a similar issue that ip_finish_output2()
returned the fixed -EINVAL.  But in my case, arp_constructor() failed with
-EINVAL, and ___neigh_create() returned ERR_PTR(-EINVAL);

So, there are still confusing paths even with this patch though, the change
would be useful.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!


> Cc: Si Hao <si.hao@zte.com.cn>
> ---
>  net/ipv4/ip_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 6ba1a0fafbaa..f28c87533a46 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -236,7 +236,7 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
>  	net_dbg_ratelimited("%s: No header cache and no neighbour!\n",
>  			    __func__);
>  	kfree_skb_reason(skb, SKB_DROP_REASON_NEIGH_CREATEFAIL);
> -	return -EINVAL;
> +	return PTR_ERR(neigh);
>  }
>  
>  static int ip_finish_output_gso(struct net *net, struct sock *sk,
> -- 
> 2.15.2

