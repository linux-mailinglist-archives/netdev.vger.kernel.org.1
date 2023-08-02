Return-Path: <netdev+bounces-23748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBA176D59B
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 19:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686B228131D
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977F1100A7;
	Wed,  2 Aug 2023 17:38:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBAC100A2
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 17:38:53 +0000 (UTC)
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AEE1723
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 10:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1690997907; x=1722533907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=huq1H7OjGjaI+lz0pMPa/2kj3IfM4PSbdtQUq9CIPv0=;
  b=hl8Tppv+0vGXgIt9EsmwO4Zjp+qEy7Xs8tSDLjBEdp2WOOZLkbX1CJP9
   MtbFE8VMLc7RS98gDksgA0Y4NEf6cZK2ZDK/tLHqS3uaioKAqQwfd5liO
   dAFdLA26l6p87AswghUNoMzhH/JDQ6P1HTr//SKzG1Ra7o6t1/e7a0cN6
   8=;
X-IronPort-AV: E=Sophos;i="6.01,249,1684800000"; 
   d="scan'208";a="1146476769"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 17:38:13 +0000
Received: from EX19MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com (Postfix) with ESMTPS id A72EA45D0E;
	Wed,  2 Aug 2023 17:38:10 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 17:38:04 +0000
Received: from 88665a182662.ant.amazon.com (10.142.140.92) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 17:38:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net 4/6] tcp_metrics: annotate data-races around tm->tcpm_vals[]
Date: Wed, 2 Aug 2023 10:37:52 -0700
Message-ID: <20230802173752.52164-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230802131500.1478140-5-edumazet@google.com>
References: <20230802131500.1478140-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.142.140.92]
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
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
Date: Wed,  2 Aug 2023 13:14:58 +0000
> tm->tcpm_vals[] values can be read or written locklessly.
> 
> Add needed READ_ONCE()/WRITE_ONCE() to document this,
> and force use of tcp_metric_get() and tcp_metric_set()
> 
> Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  net/ipv4/tcp_metrics.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
> index 131fa300496914f78c682182f0db480ceb71b6a0..fd4ab7a51cef210005146dfbc3235a2db717a44f 100644
> --- a/net/ipv4/tcp_metrics.c
> +++ b/net/ipv4/tcp_metrics.c
> @@ -63,17 +63,19 @@ static bool tcp_metric_locked(struct tcp_metrics_block *tm,
>  	return READ_ONCE(tm->tcpm_lock) & (1 << idx);
>  }
>  
> -static u32 tcp_metric_get(struct tcp_metrics_block *tm,
> +static u32 tcp_metric_get(const struct tcp_metrics_block *tm,
>  			  enum tcp_metric_index idx)
>  {
> -	return tm->tcpm_vals[idx];
> +	/* Paired with WRITE_ONCE() in tcp_metric_set() */
> +	return READ_ONCE(tm->tcpm_vals[idx]);
>  }
>  
>  static void tcp_metric_set(struct tcp_metrics_block *tm,
>  			   enum tcp_metric_index idx,
>  			   u32 val)
>  {
> -	tm->tcpm_vals[idx] = val;
> +	/* Paired with READ_ONCE() in tcp_metric_get() */
> +	WRITE_ONCE(tm->tcpm_vals[idx], val);
>  }
>  
>  static bool addr_same(const struct inetpeer_addr *a,
> @@ -115,13 +117,16 @@ static void tcpm_suck_dst(struct tcp_metrics_block *tm,
>  	WRITE_ONCE(tm->tcpm_lock, val);
>  
>  	msval = dst_metric_raw(dst, RTAX_RTT);
> -	tm->tcpm_vals[TCP_METRIC_RTT] = msval * USEC_PER_MSEC;
> +	tcp_metric_set(tm, TCP_METRIC_RTT, msval * USEC_PER_MSEC);
>  
>  	msval = dst_metric_raw(dst, RTAX_RTTVAR);
> -	tm->tcpm_vals[TCP_METRIC_RTTVAR] = msval * USEC_PER_MSEC;
> -	tm->tcpm_vals[TCP_METRIC_SSTHRESH] = dst_metric_raw(dst, RTAX_SSTHRESH);
> -	tm->tcpm_vals[TCP_METRIC_CWND] = dst_metric_raw(dst, RTAX_CWND);
> -	tm->tcpm_vals[TCP_METRIC_REORDERING] = dst_metric_raw(dst, RTAX_REORDERING);
> +	tcp_metric_set(tm, TCP_METRIC_RTTVAR, msval * USEC_PER_MSEC);
> +	tcp_metric_set(tm, TCP_METRIC_SSTHRESH,
> +		       dst_metric_raw(dst, RTAX_SSTHRESH));
> +	tcp_metric_set(tm, TCP_METRIC_CWND,
> +		       dst_metric_raw(dst, RTAX_CWND));
> +	tcp_metric_set(tm, TCP_METRIC_REORDERING,
> +		       dst_metric_raw(dst, RTAX_REORDERING));
>  	if (fastopen_clear) {
>  		tm->tcpm_fastopen.mss = 0;
>  		tm->tcpm_fastopen.syn_loss = 0;
> @@ -667,7 +672,7 @@ static int tcp_metrics_fill_info(struct sk_buff *msg,
>  		if (!nest)
>  			goto nla_put_failure;
>  		for (i = 0; i < TCP_METRIC_MAX_KERNEL + 1; i++) {
> -			u32 val = tm->tcpm_vals[i];
> +			u32 val = tcp_metric_get(tm, i);
>  
>  			if (!val)
>  				continue;
> -- 
> 2.41.0.640.ga95def55d0-goog

