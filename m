Return-Path: <netdev+bounces-23753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B1076D5F7
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 19:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B771C2130D
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D73100C6;
	Wed,  2 Aug 2023 17:48:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88350DF58
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 17:48:27 +0000 (UTC)
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95001A7
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 10:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1690998499; x=1722534499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LjGdhKnSEpz7GuoPqgGksur3IehHzd+SOqJE7JZW4eQ=;
  b=qgWAUVd6OWNBxtIYk/K8eUxstPq61OMDdFV31v47xb3FPeSbWaLseiYH
   RuDDOhuRgVp4lIU3QpCkg3I32zVwWNwE3jeWz0PuzSsPyQwj8Fq9OFllI
   4/y/OpJC1Y/q2ElgFNYyrvd8shBgcTca+tKjDGqCHsyqBtwcSTc0kSdnq
   A=;
X-IronPort-AV: E=Sophos;i="6.01,249,1684800000"; 
   d="scan'208";a="575717688"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-245b69b1.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 17:48:18 +0000
Received: from EX19MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1e-m6i4x-245b69b1.us-east-1.amazon.com (Postfix) with ESMTPS id 3981434016F;
	Wed,  2 Aug 2023 17:48:15 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 17:48:02 +0000
Received: from 88665a182662.ant.amazon.com (10.142.140.92) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 17:48:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <ycheng@google.com>
Subject: Re: [PATCH net 6/6] tcp_metrics: fix data-race in tcpm_suck_dst() vs fastopen
Date: Wed, 2 Aug 2023 10:47:51 -0700
Message-ID: <20230802174751.54502-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230802131500.1478140-7-edumazet@google.com>
References: <20230802131500.1478140-7-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.142.140.92]
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Eric Dumazet <edumazet@google.com>
Date: Wed,  2 Aug 2023 13:15:00 +0000
> Whenever tcpm_new() reclaims an old entry, tcpm_suck_dst()
> would overwrite data that could be read from tcp_fastopen_cache_get()
> or tcp_metrics_fill_info().
> 
> We need to acquire fastopen_seqlock to maintain consistency.
> 
> For newly allocated objects, tcpm_new() can switch to kzalloc()
> to avoid an extra fastopen_seqlock acquisition.
> 
> Fixes: 1fe4c481ba63 ("net-tcp: Fast Open client - cookie cache")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Yuchung Cheng <ycheng@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  net/ipv4/tcp_metrics.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
> index 4fd274836a48f73d0b1206adfa14c17c3b28bc30..99ac5efe244d3c654deaa8f8c0fffeeb5d5597b1 100644
> --- a/net/ipv4/tcp_metrics.c
> +++ b/net/ipv4/tcp_metrics.c
> @@ -93,6 +93,7 @@ static struct tcpm_hash_bucket	*tcp_metrics_hash __read_mostly;
>  static unsigned int		tcp_metrics_hash_log __read_mostly;
>  
>  static DEFINE_SPINLOCK(tcp_metrics_lock);
> +static DEFINE_SEQLOCK(fastopen_seqlock);
>  
>  static void tcpm_suck_dst(struct tcp_metrics_block *tm,
>  			  const struct dst_entry *dst,
> @@ -129,11 +130,13 @@ static void tcpm_suck_dst(struct tcp_metrics_block *tm,
>  	tcp_metric_set(tm, TCP_METRIC_REORDERING,
>  		       dst_metric_raw(dst, RTAX_REORDERING));
>  	if (fastopen_clear) {
> +		write_seqlock(&fastopen_seqlock);
>  		tm->tcpm_fastopen.mss = 0;
>  		tm->tcpm_fastopen.syn_loss = 0;
>  		tm->tcpm_fastopen.try_exp = 0;
>  		tm->tcpm_fastopen.cookie.exp = false;
>  		tm->tcpm_fastopen.cookie.len = 0;
> +		write_sequnlock(&fastopen_seqlock);
>  	}
>  }
>  
> @@ -194,7 +197,7 @@ static struct tcp_metrics_block *tcpm_new(struct dst_entry *dst,
>  		}
>  		tm = oldest;
>  	} else {
> -		tm = kmalloc(sizeof(*tm), GFP_ATOMIC);
> +		tm = kzalloc(sizeof(*tm), GFP_ATOMIC);
>  		if (!tm)
>  			goto out_unlock;
>  	}
> @@ -204,7 +207,7 @@ static struct tcp_metrics_block *tcpm_new(struct dst_entry *dst,
>  	tm->tcpm_saddr = *saddr;
>  	tm->tcpm_daddr = *daddr;
>  
> -	tcpm_suck_dst(tm, dst, true);
> +	tcpm_suck_dst(tm, dst, reclaim);
>  
>  	if (likely(!reclaim)) {
>  		tm->tcpm_next = tcp_metrics_hash[hash].chain;
> @@ -556,8 +559,6 @@ bool tcp_peer_is_proven(struct request_sock *req, struct dst_entry *dst)
>  	return ret;
>  }
>  
> -static DEFINE_SEQLOCK(fastopen_seqlock);
> -
>  void tcp_fastopen_cache_get(struct sock *sk, u16 *mss,
>  			    struct tcp_fastopen_cookie *cookie)
>  {
> -- 
> 2.41.0.640.ga95def55d0-goog

