Return-Path: <netdev+bounces-23755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 134A776D619
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 19:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6381C281D96
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437A2100D3;
	Wed,  2 Aug 2023 17:51:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F8B6D22
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 17:51:21 +0000 (UTC)
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B7F4493
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 10:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1690998660; x=1722534660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e12M020t2vjtAELGmRLks74iLY0NL+L0KXl0O3TCzvI=;
  b=vpanVQzdPxgvPR1C/zou0LAqqiLyiJ5Yx3lcS8XUn1PvEnXvcwS35V3y
   oEPTJSoEin+z4PAdv9ZTnu9f/y84NIgcKrfUMgeTAKFyQzYJyqAFiu+oX
   pjZdqlZV1VqOevcfnxcKHvFsRbR+bmJOK4219WFPn7DySHhvAtohFqtCq
   Y=;
X-IronPort-AV: E=Sophos;i="6.01,249,1684800000"; 
   d="scan'208";a="20230333"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 17:43:06 +0000
Received: from EX19MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id 147C146DDC;
	Wed,  2 Aug 2023 17:43:03 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 17:42:57 +0000
Received: from 88665a182662.ant.amazon.com (10.142.140.92) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 17:42:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net 5/6] tcp_metrics: annotate data-races around tm->tcpm_net
Date: Wed, 2 Aug 2023 10:42:45 -0700
Message-ID: <20230802174245.53590-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230802131500.1478140-6-edumazet@google.com>
References: <20230802131500.1478140-6-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.142.140.92]
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Eric Dumazet <edumazet@google.com>
Date: Wed,  2 Aug 2023 13:14:59 +0000
> tm->tcpm_net can be read or written locklessly.
> 
> Instead of changing write_pnet() and read_pnet() and potentially
> hurt performance, add the needed READ_ONCE()/WRITE_ONCE()
> in tm_net() and tcpm_new().
> 
> Fixes: 849e8a0ca8d5 ("tcp_metrics: Add a field tcpm_net and verify it matches on lookup")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  net/ipv4/tcp_metrics.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
> index fd4ab7a51cef210005146dfbc3235a2db717a44f..4fd274836a48f73d0b1206adfa14c17c3b28bc30 100644
> --- a/net/ipv4/tcp_metrics.c
> +++ b/net/ipv4/tcp_metrics.c
> @@ -40,7 +40,7 @@ struct tcp_fastopen_metrics {
>  
>  struct tcp_metrics_block {
>  	struct tcp_metrics_block __rcu	*tcpm_next;
> -	possible_net_t			tcpm_net;
> +	struct net			*tcpm_net;
>  	struct inetpeer_addr		tcpm_saddr;
>  	struct inetpeer_addr		tcpm_daddr;
>  	unsigned long			tcpm_stamp;
> @@ -51,9 +51,10 @@ struct tcp_metrics_block {
>  	struct rcu_head			rcu_head;
>  };
>  
> -static inline struct net *tm_net(struct tcp_metrics_block *tm)
> +static inline struct net *tm_net(const struct tcp_metrics_block *tm)
>  {
> -	return read_pnet(&tm->tcpm_net);
> +	/* Paired with the WRITE_ONCE() in tcpm_new() */
> +	return READ_ONCE(tm->tcpm_net);
>  }
>  
>  static bool tcp_metric_locked(struct tcp_metrics_block *tm,
> @@ -197,7 +198,9 @@ static struct tcp_metrics_block *tcpm_new(struct dst_entry *dst,
>  		if (!tm)
>  			goto out_unlock;
>  	}
> -	write_pnet(&tm->tcpm_net, net);
> +	/* Paired with the READ_ONCE() in tm_net() */
> +	WRITE_ONCE(tm->tcpm_net, net);
> +
>  	tm->tcpm_saddr = *saddr;
>  	tm->tcpm_daddr = *daddr;
>  
> -- 
> 2.41.0.640.ga95def55d0-goog

