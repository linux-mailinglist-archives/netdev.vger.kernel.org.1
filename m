Return-Path: <netdev+bounces-24228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7A276F5DB
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 00:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807552823C4
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 22:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4D2263A0;
	Thu,  3 Aug 2023 22:51:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D372EA0
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 22:51:01 +0000 (UTC)
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE862187
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 15:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691103060; x=1722639060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D2580sSYyJ8M+MEwEnOxmBF0SRHf2yAQfdi7Q2p9SbM=;
  b=tIQQ95PJLDLcrl45Pv26hDwdm8vdx9lHLJCGA3ArFzrRDbpiNRmasPi0
   MIKs3p+6+X8TLtxR/If7uJdCaRaKot03Wn8bKbLC4WVz7Xnn4HMi9zDks
   0Q4yR6jgqw99setSv6nyMoF0az0Qa91TbxkPJDfc9cryjug0eOUYKdmEm
   A=;
X-IronPort-AV: E=Sophos;i="6.01,253,1684800000"; 
   d="scan'208";a="596805454"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-7fa2de02.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 22:50:58 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2b-m6i4x-7fa2de02.us-west-2.amazon.com (Postfix) with ESMTPS id 2F79840DC9;
	Thu,  3 Aug 2023 22:50:55 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 3 Aug 2023 22:50:53 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 3 Aug 2023 22:50:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next] tcp_metrics: hash table allocation cleanup
Date: Thu, 3 Aug 2023 15:50:42 -0700
Message-ID: <20230803225042.70314-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230803135417.2716879-1-edumazet@google.com>
References: <20230803135417.2716879-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.14]
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Eric Dumazet <edumazet@google.com>
Date: Thu,  3 Aug 2023 13:54:16 +0000
> After commit 098a697b497e ("tcp_metrics: Use a single hash table
> for all network namespaces.") we can avoid calling tcp_net_metrics_init()
> for each new netns.
> 
> Instead, rename tcp_net_metrics_init() to tcp_metrics_hash_alloc(),
> and move it to __init section.
> 
> Also move tcpmhash_entries to __initdata section.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  net/ipv4/tcp_metrics.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
> index 82f4575f9cd90049a5ad4c7329ad1ddc28fc1aa0..96ab455063c57fd04c8d754ee623929d009ee716 100644
> --- a/net/ipv4/tcp_metrics.c
> +++ b/net/ipv4/tcp_metrics.c
> @@ -972,7 +972,7 @@ static struct genl_family tcp_metrics_nl_family __ro_after_init = {
>  	.resv_start_op	= TCP_METRICS_CMD_DEL + 1,
>  };
>  
> -static unsigned int tcpmhash_entries;
> +static unsigned int tcpmhash_entries __initdata;
>  static int __init set_tcpmhash_entries(char *str)
>  {
>  	ssize_t ret;
> @@ -988,15 +988,11 @@ static int __init set_tcpmhash_entries(char *str)
>  }
>  __setup("tcpmhash_entries=", set_tcpmhash_entries);
>  
> -static int __net_init tcp_net_metrics_init(struct net *net)
> +static void __init tcp_metrics_hash_alloc(void)
>  {
> +	unsigned int slots = tcpmhash_entries;
>  	size_t size;
> -	unsigned int slots;
>  
> -	if (!net_eq(net, &init_net))
> -		return 0;
> -
> -	slots = tcpmhash_entries;
>  	if (!slots) {
>  		if (totalram_pages() >= 128 * 1024)
>  			slots = 16 * 1024;
> @@ -1009,9 +1005,7 @@ static int __net_init tcp_net_metrics_init(struct net *net)
>  
>  	tcp_metrics_hash = kvzalloc(size, GFP_KERNEL);
>  	if (!tcp_metrics_hash)
> -		return -ENOMEM;
> -
> -	return 0;
> +		panic("Could not allocate the tcp_metrics hash table\n");
>  }
>  
>  static void __net_exit tcp_net_metrics_exit_batch(struct list_head *net_exit_list)
> @@ -1020,7 +1014,6 @@ static void __net_exit tcp_net_metrics_exit_batch(struct list_head *net_exit_lis
>  }
>  
>  static __net_initdata struct pernet_operations tcp_net_metrics_ops = {
> -	.init		=	tcp_net_metrics_init,
>  	.exit_batch	=	tcp_net_metrics_exit_batch,
>  };
>  
> @@ -1028,9 +1021,11 @@ void __init tcp_metrics_init(void)
>  {
>  	int ret;
>  
> +	tcp_metrics_hash_alloc();
> +
>  	ret = register_pernet_subsys(&tcp_net_metrics_ops);
>  	if (ret < 0)
> -		panic("Could not allocate the tcp_metrics hash table\n");
> +		panic("Could not register tcp_net_metrics_ops\n");
>  
>  	ret = genl_register_family(&tcp_metrics_nl_family);
>  	if (ret < 0)
> -- 
> 2.41.0.640.ga95def55d0-goog

