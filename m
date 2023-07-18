Return-Path: <netdev+bounces-18666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766B17583E2
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9363E1C20D9D
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 17:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391CA15AE5;
	Tue, 18 Jul 2023 17:52:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C673134D6
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 17:52:36 +0000 (UTC)
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7FD10FF
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689702755; x=1721238755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+FNIa0CXgAvRu4jBRrb8Q4d12DS1miM81elFvB8NTzY=;
  b=FjxsmQWfjaqtyN0c8mg0BxI9fRGJmjEvMS+e8/3cdFNTpqq6t7diKdgb
   62DuZ8BJvAOnsHTx3DJEp5p7RzPbWEJ9iNTeL6oVyjNdw3vinkBjY/rHo
   kdxElitu+Zk7zpvFHQdRk4dUBnoWdizsOiVz0qhiMww3HPTJtrc6KGxhv
   g=;
X-IronPort-AV: E=Sophos;i="6.01,214,1684800000"; 
   d="scan'208";a="661261482"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 17:52:29 +0000
Received: from EX19MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com (Postfix) with ESMTPS id 28C7980463;
	Tue, 18 Jul 2023 17:52:26 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 17:52:24 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Tue, 18 Jul 2023 17:52:22 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ruc_gongyuanjun@163.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH 1/1] ipv4: ip_gre: fix return value check in erspan_xmit()
Date: Tue, 18 Jul 2023 10:52:13 -0700
Message-ID: <20230718175213.58653-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230717144918.25961-1-ruc_gongyuanjun@163.com>
References: <20230717144918.25961-1-ruc_gongyuanjun@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.18]
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yuanjun Gong <ruc_gongyuanjun@163.com>
Date: Mon, 17 Jul 2023 22:49:18 +0800
> goto free_skb if an unexpected result is returned by pskb_tirm()
> in erspan_xmit().
> 
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>

Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  net/ipv4/ip_gre.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 81a1cce1a7d1..cb2182144dd5 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -689,7 +689,8 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
>  		goto free_skb;
>  
>  	if (skb->len > dev->mtu + dev->hard_header_len) {
> -		pskb_trim(skb, dev->mtu + dev->hard_header_len);
> +		if (pskb_trim(skb, dev->mtu + dev->hard_header_len))
> +			goto free_skb;
>  		truncate = true;
>  	}
>  
> -- 
> 2.17.1

