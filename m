Return-Path: <netdev+bounces-53099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA8A801483
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 21:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78A95B20E06
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 20:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2779D4D137;
	Fri,  1 Dec 2023 20:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qvC8YCxQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACACFC
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 12:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701462899; x=1732998899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KmM7vO5nqtyyZAxKDKTsPPzEzMdKvgdFyGIhEnoFQzQ=;
  b=qvC8YCxQRpvTELQwrtXBjtVJvoqdorsl0LXKtqVlnGEXYDap84MZfA2H
   kHxN7lin1d6I9MhZOmXE43QK2Whnsgs4+y+z0r1Rw0l4FDpAzQa7JN/M6
   T/8M+NTpSUYOVP+HTyaHaJQnJ18nEDyQsLeahgObvRL8zhGim3IbSTga5
   4=;
X-IronPort-AV: E=Sophos;i="6.04,242,1695686400"; 
   d="scan'208";a="622835391"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1box-1dm6-7f722725.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 20:34:56 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1box-1dm6-7f722725.us-east-1.amazon.com (Postfix) with ESMTPS id D1FB486241;
	Fri,  1 Dec 2023 20:34:54 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:29670]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.242:2525] with esmtp (Farcaster)
 id 10db0d8b-acd1-4468-b52a-c23e97bcc7b1; Fri, 1 Dec 2023 20:34:53 +0000 (UTC)
X-Farcaster-Flow-ID: 10db0d8b-acd1-4468-b52a-c23e97bcc7b1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 1 Dec 2023 20:34:53 +0000
Received: from 88665a182662.ant.amazon.com (10.118.249.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Fri, 1 Dec 2023 20:34:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnault@redhat.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <mkubecek@suse.cz>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4] tcp: Dump bound-only sockets in inet_diag.
Date: Fri, 1 Dec 2023 12:34:34 -0800
Message-ID: <20231201203434.22931-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <b3a84ae61e19c06806eea9c602b3b66e8f0cfc81.1701362867.git.gnault@redhat.com>
References: <b3a84ae61e19c06806eea9c602b3b66e8f0cfc81.1701362867.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Guillaume Nault <gnault@redhat.com>
Date: Fri, 1 Dec 2023 15:49:52 +0100
> Walk the hashinfo->bhash2 table so that inet_diag can dump TCP sockets
> that are bound but haven't yet called connect() or listen().
> 
> The code is inspired by the ->lhash2 loop. However there's no manual
> test of the source port, since this kind of filtering is already
> handled by inet_diag_bc_sk(). Also, a maximum of 16 sockets are dumped
> at a time, to avoid running with bh disabled for too long.
> 
> There's no TCP state for bound but otherwise inactive sockets. Such
> sockets normally map to TCP_CLOSE. However, "ss -l", which is supposed
> to only dump listening sockets, actually requests the kernel to dump
> sockets in either the TCP_LISTEN or TCP_CLOSE states. To avoid dumping
> bound-only sockets with "ss -l", we therefore need to define a new
> pseudo-state (TCP_BOUND_INACTIVE) that user space will be able to set
> explicitly.
> 
> With an IPv4, an IPv6 and an IPv6-only socket, bound respectively to
> 40000, 64000, 60000, an updated version of iproute2 could work as
> follow:
> 
>   $ ss -t state bound-inactive
>   Recv-Q   Send-Q     Local Address:Port       Peer Address:Port   Process
>   0        0                0.0.0.0:40000           0.0.0.0:*
>   0        0                   [::]:60000              [::]:*
>   0        0                      *:64000                 *:*
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
> 
> v4:
>   * Use plain sock_put() instead of sock_gen_put() (Eric Dumazet).
> 
> v3:
>   * Grab sockets with sock_hold(), instead of refcount_inc_not_zero()
>     (Kuniyuki Iwashima).
>   * Use a new TCP pseudo-state (TCP_BOUND_INACTIVE), to dump bound-only
>     sockets, so that "ss -l" won't print them (Eric Dumazet).
> 
> v2:
>   * Use ->bhash2 instead of ->bhash (Kuniyuki Iwashima).
>   * Process no more than 16 sockets at a time (Kuniyuki Iwashima).
> 
>  include/net/tcp_states.h |  2 +
>  include/uapi/linux/bpf.h |  1 +
>  net/ipv4/inet_diag.c     | 86 +++++++++++++++++++++++++++++++++++++++-
>  net/ipv4/tcp.c           |  1 +
>  4 files changed, 89 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/tcp_states.h b/include/net/tcp_states.h
> index cc00118acca1..d60e8148ff4c 100644
> --- a/include/net/tcp_states.h
> +++ b/include/net/tcp_states.h
> @@ -22,6 +22,7 @@ enum {
>  	TCP_LISTEN,
>  	TCP_CLOSING,	/* Now a valid state */
>  	TCP_NEW_SYN_RECV,
> +	TCP_BOUND_INACTIVE, /* Pseudo-state for inet_diag */
>  
>  	TCP_MAX_STATES	/* Leave at the end! */
>  };
> @@ -43,6 +44,7 @@ enum {
>  	TCPF_LISTEN	 = (1 << TCP_LISTEN),
>  	TCPF_CLOSING	 = (1 << TCP_CLOSING),
>  	TCPF_NEW_SYN_RECV = (1 << TCP_NEW_SYN_RECV),
> +	TCPF_BOUND_INACTIVE = (1 << TCP_BOUND_INACTIVE),
>  };
>  
>  #endif	/* _LINUX_TCP_STATES_H */
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 7a5498242eaa..8ee2404d077c 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6892,6 +6892,7 @@ enum {
>  	BPF_TCP_LISTEN,
>  	BPF_TCP_CLOSING,	/* Now a valid state */
>  	BPF_TCP_NEW_SYN_RECV,
> +	BPF_TCP_BOUND_INACTIVE,
>  
>  	BPF_TCP_MAX_STATES	/* Leave at the end! */
>  };
> diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
> index 7d0e7aaa71e0..46b13962ad02 100644
> --- a/net/ipv4/inet_diag.c
> +++ b/net/ipv4/inet_diag.c
> @@ -1077,10 +1077,94 @@ void inet_diag_dump_icsk(struct inet_hashinfo *hashinfo, struct sk_buff *skb,
>  		s_i = num = s_num = 0;
>  	}
>  
> +/* Process a maximum of SKARR_SZ sockets at a time when walking hash buckets
> + * with bh disabled.
> + */
> +#define SKARR_SZ 16
> +
> +	/* Dump bound but inactive (not listening, connecting, etc.) sockets */
> +	if (cb->args[0] == 1) {
> +		if (!(idiag_states & TCPF_BOUND_INACTIVE))
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

Sorry for missing this in the previous version, but I think
inet_num is always non-zero because 0 selects a port automatically
and the min of ipv4_local_port_range is 1.

Otherwise, looks good to me.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> +						goto next_bind;
> +
> +					if (r->sdiag_family != AF_UNSPEC &&
> +					    r->sdiag_family != sk->sk_family)
> +						goto next_bind;
> +
> +					if (!inet_diag_bc_sk(bc, sk))
> +						goto next_bind;
> +
> +					sock_hold(sk);
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
> +				sock_put(sk_arr[idx]);
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
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 53bcc17c91e4..a100df07d34a 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2605,6 +2605,7 @@ void tcp_set_state(struct sock *sk, int state)
>  	BUILD_BUG_ON((int)BPF_TCP_LISTEN != (int)TCP_LISTEN);
>  	BUILD_BUG_ON((int)BPF_TCP_CLOSING != (int)TCP_CLOSING);
>  	BUILD_BUG_ON((int)BPF_TCP_NEW_SYN_RECV != (int)TCP_NEW_SYN_RECV);
> +	BUILD_BUG_ON((int)BPF_TCP_BOUND_INACTIVE != (int)TCP_BOUND_INACTIVE);
>  	BUILD_BUG_ON((int)BPF_TCP_MAX_STATES != (int)TCP_MAX_STATES);
>  
>  	/* bpf uapi header bpf.h defines an anonymous enum with values
> -- 
> 2.39.2

