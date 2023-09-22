Return-Path: <netdev+bounces-35894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 317A97AB806
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 19:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D7DFA282379
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 17:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E208D436BA;
	Fri, 22 Sep 2023 17:47:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC1241E33
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 17:47:34 +0000 (UTC)
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA43B8F
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 10:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1695404853; x=1726940853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rcqAlqpRWjxQNWQL1tGoqpA1iLOlC6YxTjIgV6L6QbY=;
  b=tQy+Tfmkw7fUr8U7qdV83ZXEU+71x+uiyr3HUVJCWlg++bjcFNojmswT
   o+tHotQjUJcgcZRdFL4v4r+UxtlhruBg9wL4475RcWJKbYQK+x4CvrTnH
   SwGkRY3znNUW/wmkzrbgSB0z7S4lzVkV+VCZBIv7BO97IRz5fDFEDgkWA
   0=;
X-IronPort-AV: E=Sophos;i="6.03,169,1694736000"; 
   d="scan'208";a="240928917"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 17:47:30 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com (Postfix) with ESMTPS id BD222A0A85;
	Fri, 22 Sep 2023 17:47:29 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 22 Sep 2023 17:47:29 +0000
Received: from 88665a182662.ant.amazon.com.com (10.88.169.132) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 22 Sep 2023 17:47:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnault@redhat.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next] tcp: Dump bound-only sockets in inet_diag.
Date: Fri, 22 Sep 2023 10:47:18 -0700
Message-ID: <20230922174718.42473-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <099adf0eac09ba8227e18183a9fae6c046399e46.1695401891.git.gnault@redhat.com>
References: <099adf0eac09ba8227e18183a9fae6c046399e46.1695401891.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.88.169.132]
X-ClientProxiedBy: EX19D043UWC002.ant.amazon.com (10.13.139.222) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Guillaume Nault <gnault@redhat.com>
Date: Fri, 22 Sep 2023 18:59:57 +0200
> Walk the hashinfo->bhash table so that inet_diag can dump TCP sockets

I think we should use bhash2 as bhash could be long enough for reuseport
listeners.  That's why bhash2 is introduced.


> that are bound but haven't yet called connect() or listen().
> 
> This allows ss to dump bound-only TCP sockets, together with listening
> sockets (as there's no specific state for bound-only sockets). This is
> similar to the UDP behaviour for which bound-only sockets are already
> dumped by ss -lu.
> 
> The code is inspired by the ->lhash2 loop. However there's no manual
> test of the source port, since this kind of filtering is already
> handled by inet_diag_bc_sk().
> 
> No change is needed for ss. With an IPv4, an IPv6 and an IPv6-only
> socket, bound respectively to 40000, 64000, 60000, the result is:
> 
>   $ ss -lt
>   State  Recv-Q Send-Q Local Address:Port  Peer Address:PortProcess
>   UNCONN 0      0            0.0.0.0:40000      0.0.0.0:*
>   UNCONN 0      0               [::]:60000         [::]:*
>   UNCONN 0      0                  *:64000            *:*
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
>  net/ipv4/inet_diag.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
> index e13a84433413..de9c0c8cf42b 100644
> --- a/net/ipv4/inet_diag.c
> +++ b/net/ipv4/inet_diag.c
> @@ -1077,6 +1077,60 @@ void inet_diag_dump_icsk(struct inet_hashinfo *hashinfo, struct sk_buff *skb,
>  		s_i = num = s_num = 0;
>  	}
>  
> +	/* Dump bound-only sockets */
> +	if (cb->args[0] == 1) {
> +		if (!(idiag_states & TCPF_CLOSE))
> +			goto skip_bind_ht;
> +
> +		for (i = s_i; i <= hashinfo->bhash_size; i++) {
> +			struct inet_bind_hashbucket *ibb;
> +			struct inet_bind_bucket *tb;
> +
> +			num = 0;
> +			ibb = &hashinfo->bhash[i];
> +
> +			spin_lock_bh(&ibb->lock);
> +			inet_bind_bucket_for_each(tb, &ibb->chain) {
> +				if (!net_eq(ib_net(tb), net))
> +					continue;
> +
> +				sk_for_each_bound(sk, &tb->owners) {
> +					struct inet_sock *inet = inet_sk(sk);
> +
> +					if (num < s_num)
> +						goto next_bind;
> +
> +					if (sk->sk_state != TCP_CLOSE ||
> +					    !inet->inet_num)
> +						goto next_bind;
> +
> +					if (r->sdiag_family != AF_UNSPEC &&
> +					    r->sdiag_family != sk->sk_family)
> +						goto next_bind;
> +
> +					if (!inet_diag_bc_sk(bc, sk))
> +						goto next_bind;
> +
> +					if (inet_sk_diag_fill(sk, NULL, skb,
> +							      cb, r,
> +							      NLM_F_MULTI,
> +							      net_admin) < 0) {
> +						spin_unlock_bh(&ibb->lock);
> +						goto done;
> +					}
> +next_bind:
> +					num++;
> +				}
> +			}
> +			spin_unlock_bh(&ibb->lock);

Here we should add cond_resched(), otherwise syzbot could abuse this
and report hung task.


> +
> +			s_num = 0;
> +		}
> +skip_bind_ht:
> +		cb->args[0] = 2;
> +		s_i = num = s_num = 0;
> +	}
> +
>  	if (!(idiag_states & ~TCPF_LISTEN))
>  		goto out;
>  
> -- 
> 2.39.2

