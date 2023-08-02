Return-Path: <netdev+bounces-23747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FD876D593
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 19:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44592280E28
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B5AFBFF;
	Wed,  2 Aug 2023 17:38:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D31D100A2
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 17:38:27 +0000 (UTC)
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE29235BE
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 10:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1690997878; x=1722533878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BFSCvzwYqauw0G/92Wvr9SiHRNtMfLx3ILeJgzMUDgg=;
  b=LVJwXLwkRHdhaTx/EsH33LiDYk6jq3ypQfeJ6+dM86uLO/BDzZgdKc/n
   /MytzJ2j0ED7bYodrM6+j+xgIAkVq23/uokjqUI8e7QwZ8UTiok2scuNK
   XifgaLp93kD+fdb8hT6+Z31h8jhgCqE6FpBzZxj3HbyutMnBOFxH/8dvy
   Q=;
X-IronPort-AV: E=Sophos;i="6.01,249,1684800000"; 
   d="scan'208";a="1146476366"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 17:36:06 +0000
Received: from EX19MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com (Postfix) with ESMTPS id B192E80D94;
	Wed,  2 Aug 2023 17:36:02 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 17:35:46 +0000
Received: from 88665a182662.ant.amazon.com (10.142.140.92) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 17:35:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net 3/6] tcp_metrics: annotate data-races around tm->tcpm_lock
Date: Wed, 2 Aug 2023 10:35:35 -0700
Message-ID: <20230802173535.51811-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230802131500.1478140-4-edumazet@google.com>
References: <20230802131500.1478140-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.142.140.92]
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
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
Date: Wed,  2 Aug 2023 13:14:57 +0000
> tm->tcpm_lock can be read or written locklessly.
> 
> Add needed READ_ONCE()/WRITE_ONCE() to document this.
> 
> Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  net/ipv4/tcp_metrics.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
> index 83861658879638149d2746290a285a4f75fc3117..131fa300496914f78c682182f0db480ceb71b6a0 100644
> --- a/net/ipv4/tcp_metrics.c
> +++ b/net/ipv4/tcp_metrics.c
> @@ -59,7 +59,8 @@ static inline struct net *tm_net(struct tcp_metrics_block *tm)
>  static bool tcp_metric_locked(struct tcp_metrics_block *tm,
>  			      enum tcp_metric_index idx)
>  {
> -	return tm->tcpm_lock & (1 << idx);
> +	/* Paired with WRITE_ONCE() in tcpm_suck_dst() */
> +	return READ_ONCE(tm->tcpm_lock) & (1 << idx);
>  }
>  
>  static u32 tcp_metric_get(struct tcp_metrics_block *tm,
> @@ -110,7 +111,8 @@ static void tcpm_suck_dst(struct tcp_metrics_block *tm,
>  		val |= 1 << TCP_METRIC_CWND;
>  	if (dst_metric_locked(dst, RTAX_REORDERING))
>  		val |= 1 << TCP_METRIC_REORDERING;
> -	tm->tcpm_lock = val;
> +	/* Paired with READ_ONCE() in tcp_metric_locked() */
> +	WRITE_ONCE(tm->tcpm_lock, val);
>  
>  	msval = dst_metric_raw(dst, RTAX_RTT);
>  	tm->tcpm_vals[TCP_METRIC_RTT] = msval * USEC_PER_MSEC;
> -- 
> 2.41.0.640.ga95def55d0-goog

