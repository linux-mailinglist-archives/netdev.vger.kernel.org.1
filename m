Return-Path: <netdev+bounces-51002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0666F7F8794
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 02:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880D228139D
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 01:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAD5819;
	Sat, 25 Nov 2023 01:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GSmACCYE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83961193
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 17:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700876405; x=1732412405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HdrI7TZhA/F7inN/lSRZS80cVGpRzEyDt5Tpu6W4afo=;
  b=GSmACCYEnAyu8H/OKQgkfjnJhVFqChxtYfcU/qSAvtQaJjiCRGidWo2F
   I/TkNZfLjfwYPIT7bqrpEvhcN/GfvpxyGxRRuH6b3NOE6lnkwPHYdFhNB
   p1SbCATeVNPgMvddcrrDxmR1IyszyuxXDjaLXZiGmn3EoAgbuFnovYrxG
   Y=;
X-IronPort-AV: E=Sophos;i="6.04,224,1695686400"; 
   d="scan'208";a="378677991"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2023 01:39:58 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com (Postfix) with ESMTPS id 05F048076A;
	Sat, 25 Nov 2023 01:39:54 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:19411]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.6:2525] with esmtp (Farcaster)
 id a53e1eeb-c625-44b1-9fd7-ad15522abc19; Sat, 25 Nov 2023 01:39:54 +0000 (UTC)
X-Farcaster-Flow-ID: a53e1eeb-c625-44b1-9fd7-ad15522abc19
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Sat, 25 Nov 2023 01:39:54 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Sat, 25 Nov 2023 01:39:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnault@redhat.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <mkubecek@suse.cz>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] tcp: Dump bound-only sockets in inet_diag.
Date: Fri, 24 Nov 2023 17:39:42 -0800
Message-ID: <20231125013942.80997-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <bfb52b5103de808cda022e2d16bac6cf3ef747d6.1700780828.git.gnault@redhat.com>
References: <bfb52b5103de808cda022e2d16bac6cf3ef747d6.1700780828.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Guillaume Nault <gnault@redhat.com>
Date: Fri, 24 Nov 2023 00:11:42 +0100
> Walk the hashinfo->bhash2 table so that inet_diag can dump TCP sockets
> that are bound but haven't yet called connect() or listen().
> 
> This allows ss to dump bound-only TCP sockets, together with listening
> sockets (as there's no specific state for bound-only sockets). This is
> similar to the UDP behaviour for which bound-only sockets are already
> dumped by ss -lu.
> 
> The code is inspired by the ->lhash2 loop. However there's no manual
> test of the source port, since this kind of filtering is already
> handled by inet_diag_bc_sk(). Also, a maximum of 16 sockets are dumped
> at a time, to avoid running with bh disabled for too long.
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
> 
> v2:
>   * Use ->bhash2 instead of ->bhash (Kuniyuki Iwashima).
>   * Process no more than 16 sockets at a time (Kuniyuki Iwashima).
> 
>  net/ipv4/inet_diag.c | 88 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 87 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
> index 7d0e7aaa71e0..d7fb6a625cb7 100644
> --- a/net/ipv4/inet_diag.c
> +++ b/net/ipv4/inet_diag.c
> @@ -1077,10 +1077,96 @@ void inet_diag_dump_icsk(struct inet_hashinfo *hashinfo, struct sk_buff *skb,
>  		s_i = num = s_num = 0;
>  	}
>  
> +/* Process a maximum of SKARR_SZ sockets at a time when walking hash buckets
> + * with bh disabled.
> + */
> +#define SKARR_SZ 16
> +
> +	/* Dump bound-only sockets */
> +	if (cb->args[0] == 1) {
> +		if (!(idiag_states & TCPF_CLOSE))
> +			goto skip_bind_ht;
> +
> +		for (i = s_i; i < hashinfo->bhash_size; i++) {
> +			struct inet_bind_hashbucket *ibb;
> +			struct inet_bind2_bucket *tb2;
> +			struct sock *sk_arr[SKARR_SZ];
> +			int num_arr[SKARR_SZ];
> +			int idx, accum, res;
> +
> +resume_bind_walk:
> +			num = 0;
> +			accum = 0;
> +			ibb = &hashinfo->bhash2[i];
> +
> +			spin_lock_bh(&ibb->lock);
> +			inet_bind_bucket_for_each(tb2, &ibb->chain) {
> +				if (!net_eq(ib2_net(tb2), net))
> +					continue;
> +
> +				sk_for_each_bound_bhash2(sk, &tb2->owners) {
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
> +					if (!refcount_inc_not_zero(&sk->sk_refcnt))
> +						goto next_bind;

I guess this is copied from the ehash code below, but could
refcount_inc_not_zero() fail for bhash2 under spin_lock_bh() ?


> +
> +					num_arr[accum] = num;
> +					sk_arr[accum] = sk;
> +					if (++accum == SKARR_SZ)
> +						goto pause_bind_walk;
> +next_bind:
> +					num++;
> +				}
> +			}
> +pause_bind_walk:
> +			spin_unlock_bh(&ibb->lock);
> +
> +			res = 0;
> +			for (idx = 0; idx < accum; idx++) {
> +				if (res >= 0) {
> +					res = inet_sk_diag_fill(sk_arr[idx],
> +								NULL, skb, cb,
> +								r, NLM_F_MULTI,
> +								net_admin);
> +					if (res < 0)
> +						num = num_arr[idx];
> +				}
> +				sock_gen_put(sk_arr[idx]);
> +			}
> +			if (res < 0)
> +				goto done;
> +
> +			cond_resched();
> +
> +			if (accum == SKARR_SZ) {
> +				s_num = num + 1;
> +				goto resume_bind_walk;
> +			}
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
> -#define SKARR_SZ 16
>  	for (i = s_i; i <= hashinfo->ehash_mask; i++) {
>  		struct inet_ehash_bucket *head = &hashinfo->ehash[i];
>  		spinlock_t *lock = inet_ehash_lockp(hashinfo, i);
> -- 
> 2.39.2

