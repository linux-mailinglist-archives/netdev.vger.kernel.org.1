Return-Path: <netdev+bounces-23746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 076FC76D583
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 19:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A1D1C208E0
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC900FC1E;
	Wed,  2 Aug 2023 17:33:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E5F6FD9
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 17:33:04 +0000 (UTC)
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15668526E
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 10:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1690997557; x=1722533557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r9XtTQ5bkvaU6psRClS3J5vAKga52nL6NQIY/Yn8GLE=;
  b=EOwqWzXBCekAtuJ8FMAzfnAmrH0Y+899Qw5yc4PAotd8VmNes4Gm6+Cd
   /CQCxegQHIniAs/PwfKEyelTYiQ39rsN+SeQ4li80fbPjwspBgY2IFhXG
   jnVMh52gj2OFStiRnxxabC5tjSwhW7KWlwjIU6mPcBo1GXhvBYpunB3W7
   8=;
X-IronPort-AV: E=Sophos;i="6.01,249,1684800000"; 
   d="scan'208";a="575714228"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 17:31:13 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com (Postfix) with ESMTPS id 7916F40DA6;
	Wed,  2 Aug 2023 17:31:10 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 17:31:09 +0000
Received: from 88665a182662.ant.amazon.com (10.142.140.92) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 17:31:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net 2/6] tcp_metrics: annotate data-races around tm->tcpm_stamp
Date: Wed, 2 Aug 2023 10:30:58 -0700
Message-ID: <20230802173058.50855-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230802131500.1478140-3-edumazet@google.com>
References: <20230802131500.1478140-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.142.140.92]
X-ClientProxiedBy: EX19D043UWC003.ant.amazon.com (10.13.139.240) To
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
Date: Wed,  2 Aug 2023 13:14:56 +0000
> tm->tcpm_stamp can be read or written locklessly.
> 
> Add needed READ_ONCE()/WRITE_ONCE() to document this.
> 
> Also constify tcpm_check_stamp() dst argument.
> 
> Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  net/ipv4/tcp_metrics.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
> index c4daf0aa2d4d9695e128b67df571d91d647a254d..83861658879638149d2746290a285a4f75fc3117 100644
> --- a/net/ipv4/tcp_metrics.c
> +++ b/net/ipv4/tcp_metrics.c
> @@ -97,7 +97,7 @@ static void tcpm_suck_dst(struct tcp_metrics_block *tm,
>  	u32 msval;
>  	u32 val;
>  
> -	tm->tcpm_stamp = jiffies;
> +	WRITE_ONCE(tm->tcpm_stamp, jiffies);
>  
>  	val = 0;
>  	if (dst_metric_locked(dst, RTAX_RTT))
> @@ -131,9 +131,15 @@ static void tcpm_suck_dst(struct tcp_metrics_block *tm,
>  
>  #define TCP_METRICS_TIMEOUT		(60 * 60 * HZ)
>  
> -static void tcpm_check_stamp(struct tcp_metrics_block *tm, struct dst_entry *dst)
> +static void tcpm_check_stamp(struct tcp_metrics_block *tm,
> +			     const struct dst_entry *dst)
>  {
> -	if (tm && unlikely(time_after(jiffies, tm->tcpm_stamp + TCP_METRICS_TIMEOUT)))
> +	unsigned long limit;
> +
> +	if (!tm)
> +		return;
> +	limit = READ_ONCE(tm->tcpm_stamp) + TCP_METRICS_TIMEOUT;
> +	if (unlikely(time_after(jiffies, limit)))
>  		tcpm_suck_dst(tm, dst, false);
>  }
>  
> @@ -174,7 +180,8 @@ static struct tcp_metrics_block *tcpm_new(struct dst_entry *dst,
>  		oldest = deref_locked(tcp_metrics_hash[hash].chain);
>  		for (tm = deref_locked(oldest->tcpm_next); tm;
>  		     tm = deref_locked(tm->tcpm_next)) {
> -			if (time_before(tm->tcpm_stamp, oldest->tcpm_stamp))
> +			if (time_before(READ_ONCE(tm->tcpm_stamp),
> +					READ_ONCE(oldest->tcpm_stamp)))
>  				oldest = tm;
>  		}
>  		tm = oldest;
> @@ -434,7 +441,7 @@ void tcp_update_metrics(struct sock *sk)
>  					       tp->reordering);
>  		}
>  	}
> -	tm->tcpm_stamp = jiffies;
> +	WRITE_ONCE(tm->tcpm_stamp, jiffies);
>  out_unlock:
>  	rcu_read_unlock();
>  }
> @@ -647,7 +654,7 @@ static int tcp_metrics_fill_info(struct sk_buff *msg,
>  	}
>  
>  	if (nla_put_msecs(msg, TCP_METRICS_ATTR_AGE,
> -			  jiffies - tm->tcpm_stamp,
> +			  jiffies - READ_ONCE(tm->tcpm_stamp),
>  			  TCP_METRICS_ATTR_PAD) < 0)
>  		goto nla_put_failure;
>  
> -- 
> 2.41.0.640.ga95def55d0-goog


