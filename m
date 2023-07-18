Return-Path: <netdev+bounces-18670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD237583F8
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5C91C20DA7
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 17:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDEE15AEE;
	Tue, 18 Jul 2023 17:59:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B19715AED
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 17:59:43 +0000 (UTC)
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A76C0
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689703183; x=1721239183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f+r0PAvuYLyQTrJaw8xK5oREpxk5+Ifcve0aKT4X3oI=;
  b=MDHtsq+JuQq3u8aWUziXbgvQ9P1I1lix6wslFP0VKNXjgHZdyI12SSA+
   hKzfaZqP7Z8E5xHNHblKV7H38fLDL1HxfzBuT0cCbu/wCYiLP/P38tHmi
   vFBukSMhgBmODWh1GzYv+jUwO7Wr9hKdhKB2bKLcTm+1TVBdI0+sGO9rZ
   8=;
X-IronPort-AV: E=Sophos;i="6.01,214,1684800000"; 
   d="scan'208";a="143357995"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 17:59:39 +0000
Received: from EX19MTAUWA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com (Postfix) with ESMTPS id D6F40A0EA6;
	Tue, 18 Jul 2023 17:59:31 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 17:59:31 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 17:59:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ruc_gongyuanjun@163.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	<timur@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH 1/1] drivers: net: fix return value check in emac_tso_csum()
Date: Tue, 18 Jul 2023 10:59:19 -0700
Message-ID: <20230718175919.59600-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230717144621.22870-1-ruc_gongyuanjun@163.com>
References: <20230717144621.22870-1-ruc_gongyuanjun@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.18]
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
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
Date: Mon, 17 Jul 2023 22:46:21 +0800
> in emac_tso_csum(), return an error code if an unexpected value
> is returned by pskb_trim().
> 
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>

Fixes: b9b17debc69d ("net: emac: emac gigabit ethernet controller driver")
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  drivers/net/ethernet/qualcomm/emac/emac-mac.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/emac/emac-mac.c b/drivers/net/ethernet/qualcomm/emac/emac-mac.c
> index 0d80447d4d3b..d5c688a8d7be 100644
> --- a/drivers/net/ethernet/qualcomm/emac/emac-mac.c
> +++ b/drivers/net/ethernet/qualcomm/emac/emac-mac.c
> @@ -1260,8 +1260,11 @@ static int emac_tso_csum(struct emac_adapter *adpt,
>  		if (skb->protocol == htons(ETH_P_IP)) {
>  			u32 pkt_len = ((unsigned char *)ip_hdr(skb) - skb->data)
>  				       + ntohs(ip_hdr(skb)->tot_len);
> -			if (skb->len > pkt_len)
> -				pskb_trim(skb, pkt_len);
> +			if (skb->len > pkt_len) {
> +				ret = pskb_trim(skb, pkt_len);
> +				if (unlikely(ret))
> +					return ret;
> +			}
>  		}
>  
>  		hdr_len = skb_tcp_all_headers(skb);
> -- 
> 2.17.1

