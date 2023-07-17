Return-Path: <netdev+bounces-18407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A21756C97
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 20:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AEBF1C20B5D
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 18:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F26BE57;
	Mon, 17 Jul 2023 18:57:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C67A253CD
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 18:57:25 +0000 (UTC)
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6671EA6
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 11:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689620245; x=1721156245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wcozi+ee88OTAMYCtfzRmmZ5Z/wDFO4N+mOqrqvPr0M=;
  b=nvB29x3aofbUtr8VpU+2P110cOnkRoocilGHNqy7HgcvLCTjS9VjbvJb
   2mM+Pmih0JomhJFcIKctQoYKrYd4KYJK5K/hnwsdbCuHH8//Bl+zShrye
   nAmwIdFz/tdJcmpaH6EhItV/t4VKba68Tay4Itq7mxtUFz2D9UchSUp09
   c=;
X-IronPort-AV: E=Sophos;i="6.01,211,1684800000"; 
   d="scan'208";a="596740663"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d7759ebe.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 18:57:23 +0000
Received: from EX19MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1d-m6i4x-d7759ebe.us-east-1.amazon.com (Postfix) with ESMTPS id EE4F84718E;
	Mon, 17 Jul 2023 18:57:21 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 18:57:21 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.21) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 18:57:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ruc_gongyuanjun@163.com>
CC: <jmaloy@redhat.com>, <netdev@vger.kernel.org>, <ying.xue@windriver.com>,
	<kuniyu@amazon.com>
Subject: Re: [PATCH 1/1] net:tipc: check return value of pskb_trim()
Date: Mon, 17 Jul 2023 11:57:10 -0700
Message-ID: <20230717185710.93256-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230717145049.27642-1-ruc_gongyuanjun@163.com>
References: <20230717145049.27642-1-ruc_gongyuanjun@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.21]
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yuanjun Gong <ruc_gongyuanjun@163.com>
Date: Mon, 17 Jul 2023 22:50:49 +0800
> goto free_skb if an unexpected result is returned by pskb_tirm()
> in tipc_crypto_rcv_complete().
> 
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> ---
>  net/tipc/crypto.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
> index 577fa5af33ec..1b86cea261a5 100644
> --- a/net/tipc/crypto.c
> +++ b/net/tipc/crypto.c
> @@ -1894,6 +1894,7 @@ static void tipc_crypto_rcv_complete(struct net *net, struct tipc_aead *aead,
>  	struct tipc_aead *tmp = NULL;
>  	struct tipc_ehdr *ehdr;
>  	struct tipc_node *n;
> +	int ret;
>  
>  	/* Is this completed by TX? */
>  	if (unlikely(is_tx(aead->crypto))) {
> @@ -1960,7 +1961,9 @@ static void tipc_crypto_rcv_complete(struct net *net, struct tipc_aead *aead,
>  
>  	skb_reset_network_header(*skb);
>  	skb_pull(*skb, tipc_ehdr_size(ehdr));
> -	pskb_trim(*skb, (*skb)->len - aead->authsize);
> +	ret = pskb_trim(*skb, (*skb)->len - aead->authsize);
> +	if (ret)

No need to define ret.


> +		goto free_skb;
>  
>  	/* Validate TIPCv2 message */
>  	if (unlikely(!tipc_msg_validate(skb))) {
> -- 
> 2.17.1

