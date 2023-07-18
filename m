Return-Path: <netdev+bounces-18668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5837583EB
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F69B2815E0
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 17:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CC015AEC;
	Tue, 18 Jul 2023 17:55:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFFB134BD
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 17:55:32 +0000 (UTC)
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433D0F7
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689702932; x=1721238932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mm9my8+jTTFldSLXSMSvtgzU7L+Bsipbl5dfcXH2xxY=;
  b=hC8pMZSt8WrFEDvz9b1SavVfdLMUv6Ut5C7gCI5qscau9f7K7Qon61a4
   2y1e2JLj4P1IV3OA1h2J53OvUFTKWxftN1Ff9iUZ+mG73QFqMb8Ci/BjL
   jlW3ggCF6x8B6LQduiOkeCFi6SqowRR2Hoswy2zQ7xaiymRy0HZ6EvTMq
   c=;
X-IronPort-AV: E=Sophos;i="6.01,214,1684800000"; 
   d="scan'208";a="593617782"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-5eae960a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 17:55:29 +0000
Received: from EX19MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2c-m6i4x-5eae960a.us-west-2.amazon.com (Postfix) with ESMTPS id 9A20D40DB5;
	Tue, 18 Jul 2023 17:55:27 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 17:55:26 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Tue, 18 Jul 2023 17:55:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ruc_gongyuanjun@163.com>
CC: <alexandre.belloni@bootlin.com>, <claudiu.manoil@nxp.com>,
	<netdev@vger.kernel.org>, <vladimir.oltean@nxp.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>
Subject: [PATCH 1/1] drivers:net: fix return value check in ocelot_fdma_receive_skb
Date: Tue, 18 Jul 2023 10:55:15 -0700
Message-ID: <20230718175515.58952-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230717144652.23408-1-ruc_gongyuanjun@163.com>
References: <20230717144652.23408-1-ruc_gongyuanjun@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.18]
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
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
Date: Mon, 17 Jul 2023 22:46:52 +0800
> ocelot_fdma_receive_skb should return false if an unexpected
> value is returned by pskb_trim.
> 
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>

Fixes: 753a026cfec1 ("net: ocelot: add FDMA support")
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  drivers/net/ethernet/mscc/ocelot_fdma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mscc/ocelot_fdma.c b/drivers/net/ethernet/mscc/ocelot_fdma.c
> index 8e3894cf5f7c..83a3ce0c568e 100644
> --- a/drivers/net/ethernet/mscc/ocelot_fdma.c
> +++ b/drivers/net/ethernet/mscc/ocelot_fdma.c
> @@ -368,7 +368,8 @@ static bool ocelot_fdma_receive_skb(struct ocelot *ocelot, struct sk_buff *skb)
>  	if (unlikely(!ndev))
>  		return false;
>  
> -	pskb_trim(skb, skb->len - ETH_FCS_LEN);
> +	if (pskb_trim(skb, skb->len - ETH_FCS_LEN))
> +		return false;
>  
>  	skb->dev = ndev;
>  	skb->protocol = eth_type_trans(skb, skb->dev);
> -- 
> 2.17.1

