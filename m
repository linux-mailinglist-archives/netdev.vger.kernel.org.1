Return-Path: <netdev+bounces-18409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E96756CB6
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 21:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7981C20B70
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D32EC12C;
	Mon, 17 Jul 2023 19:05:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52490253B8
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 19:05:14 +0000 (UTC)
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB1B116
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689620714; x=1721156714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BPfETvMqjcpKvtC5+S9YtSyK/FaQ+JqrO3jHiDP1nrE=;
  b=EZ9H6s3KPy+9DF/DPcgfiOynx5g26i45jbz/o12nC+SY+kCTfqZ3a/Pm
   p/RUd/zCPilaMGlEBy8qrt3/bVB9k+rlb4it2jywvPQ5VlIZQwMFjJVFU
   O6m4Nq/n6Fu6pLUdkcbbuBzTTmDBSb2F6OREs6PXSTYwGj7FMuCdorDMh
   Q=;
X-IronPort-AV: E=Sophos;i="6.01,211,1684800000"; 
   d="scan'208";a="340146454"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 19:05:09 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com (Postfix) with ESMTPS id 1DFF8BAFB0;
	Mon, 17 Jul 2023 19:05:08 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 19:05:07 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.21) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Mon, 17 Jul 2023 19:05:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ruc_gongyuanjun@163.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <netdev@vger.kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v2 1/1] net:ipv6: check return value of pskb_trim()
Date: Mon, 17 Jul 2023 12:04:54 -0700
Message-ID: <20230717190454.94209-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230717144519.21740-1-ruc_gongyuanjun@163.com>
References: <20230717144519.21740-1-ruc_gongyuanjun@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.21]
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yuanjun Gong <ruc_gongyuanjun@163.com>
Date: Mon, 17 Jul 2023 22:45:19 +0800
> goto tx_err if an unexpected result is returned by pskb_tirm()
> in ip6erspan_tunnel_xmit().
> 
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>

Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Please keep these in mind for an acutual fix from next time.

  * Add Fixes: tag in changelog
  * Specify target tree as net in mail subject

See also Documentation/process/maintainer-netdev.rst

Thanks!


> ---
>  net/ipv6/ip6_gre.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index da80974ad23a..070d87abf7c0 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -955,7 +955,8 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
>  		goto tx_err;
>  
>  	if (skb->len > dev->mtu + dev->hard_header_len) {
> -		pskb_trim(skb, dev->mtu + dev->hard_header_len);
> +		if (pskb_trim(skb, dev->mtu + dev->hard_header_len))
> +			goto tx_err;
>  		truncate = true;
>  	}
>  
> -- 
> 2.17.1

