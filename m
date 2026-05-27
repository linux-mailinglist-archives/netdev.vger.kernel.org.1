Return-Path: <netdev+bounces-292172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KoMMjOpFmrEoAcAu9opvQ
	(envelope-from <netdev+bounces-292172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:20:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB9E5E0FE7
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E574B300DDDC
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F6E3BB10A;
	Wed, 27 May 2026 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uQ8t2BhS"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE683644B3;
	Wed, 27 May 2026 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870001; cv=none; b=HzVSIOQwOHBLXk65FtCCmaYqeWZG7UrRI474mU843du6oQv6wEuitm+Op+EPsc2dizwgVSJzSgzLcWyvPqw02ossrDZK6JuOqMI3p0BJPUjnKIvoXVBrTDcaUyJ01IRP9o9SjQY+2DmQa7h0+Wpn8EXzSqcnUZ6uRodqZHoCSyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870001; c=relaxed/simple;
	bh=JegEjHe48WRmOKZAF1bCyynbXeobMYCLLSusSWyJMNs=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=efsC7zAHbdhUcBQdRQRjQv8403A9toqXfUtAK8ESYqUVM+M3c6RsGUzxBE66F30n6OBJkpW4kPvvdsZMB2i6CS5fAoo35WTRtCxHsIAqHOWRaSfO+LVcZtsp4gyypPyvURHd/kHINlERhOBm/AWtPEHKhY8451f4Mtnn3qog34U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uQ8t2BhS; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779869995; h=Message-ID:Subject:Date:From:To;
	bh=qmaJ8BMGI8HQ+7PBXYA0ky38UkMLL8bmrU/mqVfnv+0=;
	b=uQ8t2BhSDRVv+2hInhfpdHU7clBAtxyCr8gcuwufgfH8EehrVlmQ6JrM079l0Enirs0LeWv+bjGTMyJkDivzqOZu2kFcART4nZMl57dMUFnI6vunD+Bn+dlAvNWe7cDwob6gX5H7wT1X4RQO9ZuS/3GnSDVetwaoN0dflb2kMws=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X3ipLsJ_1779869994;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X3ipLsJ_1779869994 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 May 2026 16:19:54 +0800
Message-ID: <1779869860.2796278-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5] net: reduce RFS/ARFS flow updates by checking LLC affinity
Date: Wed, 27 May 2026 16:17:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Chuang Wang <nashuiliang@gmail.com>
Cc: Chuang Wang <nashuiliang@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Samiullah Khawaja <skhawaja@google.com>,
 Hangbin Liu <liuhangbin@gmail.com>,
 Neal Cardwell <ncardwell@google.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260525025854.13982-1-nashuiliang@gmail.com>
In-Reply-To: <20260525025854.13982-1-nashuiliang@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-292172-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3CB9E5E0FE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 10:58:42 +0800, Chuang Wang <nashuiliang@gmail.com> wrote:
> The current implementation of rps_record_sock_flow() updates the flow
> table every time a socket is processed on a different CPU. In high-load
> scenarios, especially with Accelerated RFS (ARFS), this triggers
> frequent flow steering updates via ndo_rx_flow_steer.
>
> For drivers like mlx5 that implement hardware flow steering, these
> constant updates lead to significant contention on internal driver locks
> (e.g., arfs_lock). This contention often becomes a performance
> bottleneck that outweighs the steering benefits.
>
> This patch introduces a cache-aware update strategy: the flow record is
> only updated if the flow migrates across Last Level Cache (LLC)
> boundaries. This minimizes expensive hardware reconfigurations while
> preserving cache locality for the application. A new sysctl,
> net.core.rps_feat_llc_affinity, is added to toggle this feature.
>
> Additionally, export sock_rps_record_flow_hash() and
> sock_rps_record_flow(). This resolves a symbol visibility compilation
> error triggered by 'tun' using sock_rps_record_flow_hash() in
> tun_flow_update() when CONFIG_TUN is built as a module. The same logic
> is applied to SCTP, allowing it to use sock_rps_record_flow() safely
> when built as a module.
>
> Performance Test Results:
> The patch was tested in a K8s environment (AMD CPU 128*2, 16-core Pod
> with CPU pinning, mlx5 NIC) using brpc[1] echo_server and rpc_press.
>
> rpc_press Commands:
>
>   for i in {1..8}; do
>     ./rpc_press -proto=./echo.proto -method=example.EchoService.Echo
>     -server=<IP>:8000 -input='{"message":"hello"}'
>     -qps=0 -thread_num=512 -connection_type=pooled &
>   done
>
> Monitor mlx5e_rx_flow_steer frequency:
>
>   /usr/share/bcc/tools/funccount -i 1 mlx5e_rx_flow_steer
>
> Frequency of mlx5e_rx_flow_steer (via funccount[2]):
>
>   Before: ~335,000 counts/sec
>   After:   ~23,000 counts/sec (reduced by ~93%)
>
> System Metrics (after enabling rps_feat_llc_affinity):
>
>   CPU Utilization: 38% -> 32%
>   CPU PSI (Pressure Stall Information): 20% -> 10%
>
> These results demonstrate that filtering updates by LLC affinity
> significantly reduces driver lock contention and improves overall
> CPU efficiency under heavy network load.
>
> [1] https://github.com/apache/brpc/
> [2] https://github.com/iovisor/bcc/blob/master/tools/funccount.py
>
> Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
> ---
> v4 -> v5: fix 'modpost: "rps_llc_check" [net/sctp/sctp.ko] undefined!' by kernel test robot
> v3 -> v4: add rps_llc_check by Eric Dumazet
> v2 -> v3: patch net -> net-next by Jakub Kicinski
> v1 -> v2: add rps_feat_llc_affinity; add brpc tests
>
>  include/net/rps.h          | 28 ++++----------
>  net/core/dev.c             | 76 ++++++++++++++++++++++++++++++++++++++
>  net/core/sysctl_net_core.c | 35 ++++++++++++++++++
>  3 files changed, 119 insertions(+), 20 deletions(-)
>
> diff --git a/include/net/rps.h b/include/net/rps.h
> index e33c6a2fa8bb..6dacf0888a6c 100644
> --- a/include/net/rps.h
> +++ b/include/net/rps.h
> @@ -12,6 +12,7 @@
>
>  extern struct static_key_false rps_needed;
>  extern struct static_key_false rfs_needed;
> +extern struct static_key_false rps_feat_llc_affinity;
>
>  /*
>   * This structure holds an RPS map which can be of variable length.  The
> @@ -55,11 +56,14 @@ struct rps_sock_flow_table {
>
>  #define RPS_NO_CPU 0xffff
>
> +bool rps_llc_check(u32 old_val, u32 new_val);
> +
>  static inline void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash)
>  {
>  	unsigned int index = hash & rps_tag_to_mask(tag_ptr);
>  	u32 val = hash & ~net_hotdata.rps_cpu_mask;
>  	struct rps_sock_flow_table *table;
> +	u32 old_val;
>
>  	/* We only give a hint, preemption can change CPU under us */
>  	val |= raw_smp_processor_id();
> @@ -68,7 +72,8 @@ static inline void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash)
>  	/* The following WRITE_ONCE() is paired with the READ_ONCE()
>  	 * here, and another one in get_rps_cpu().
>  	 */
> -	if (READ_ONCE(table[index].ent) != val)
> +	old_val = READ_ONCE(table[index].ent);
> +	if (old_val != val && rps_llc_check(old_val, val))
>  		WRITE_ONCE(table[index].ent, val);


	bool rps_llc_check(u32 old_val, u32 new_val)
	{
		u32 old_cpu = old_val & ~net_hotdata.rps_cpu_mask;
		u32 new_cpu = new_val & ~net_hotdata.rps_cpu_mask;

		if (old_val == new_val)
			return false;

It seems old_val == new_val is checked twice.

How about removing the check from here?

Thanks.



>  }
>
> @@ -136,25 +141,8 @@ static inline bool rfs_is_needed(void)
>  #endif
>  }
>
> -static inline void sock_rps_record_flow_hash(__u32 hash)
> -{
> -#ifdef CONFIG_RPS
> -	if (!rfs_is_needed())
> -		return;
> -
> -	_sock_rps_record_flow_hash(hash);
> -#endif
> -}
> -
> -static inline void sock_rps_record_flow(const struct sock *sk)
> -{
> -#ifdef CONFIG_RPS
> -	if (!rfs_is_needed())
> -		return;
> -
> -	_sock_rps_record_flow(sk);
> -#endif
> -}
> +void sock_rps_record_flow_hash(__u32 hash);
> +void sock_rps_record_flow(const struct sock *sk);
>
>  static inline void sock_rps_delete_flow(const struct sock *sk)
>  {
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 26ac8eb9b259..f98216ddaec1 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4997,6 +4997,8 @@ struct static_key_false rps_needed __read_mostly;
>  EXPORT_SYMBOL(rps_needed);
>  struct static_key_false rfs_needed __read_mostly;
>  EXPORT_SYMBOL(rfs_needed);
> +struct static_key_false rps_feat_llc_affinity __read_mostly;
> +EXPORT_SYMBOL(rps_feat_llc_affinity);
>
>  static u32 rfs_slot(u32 hash, rps_tag_ptr tag_ptr)
>  {
> @@ -5208,6 +5210,58 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
>  	return cpu;
>  }
>
> +/**
> + * rps_llc_check - Determine if RPS flow table should be updated
> + * @old_val: Previous flow record value
> + * @new_val: Target flow record value
> + *
> + * Returns true if the record needs an update.
> + */
> +bool rps_llc_check(u32 old_val, u32 new_val)
> +{
> +	u32 old_cpu = old_val & ~net_hotdata.rps_cpu_mask;
> +	u32 new_cpu = new_val & ~net_hotdata.rps_cpu_mask;
> +
> +	if (old_val == new_val)
> +		return false;
> +
> +	/*
> +	 * RPS LLC Affinity Feature:
> +	 * Reduce RFS/ARFS flow updates by checking LLC affinity.
> +	 *
> +	 * Frequent flow table updates can trigger constant hardware steering
> +	 * reconfigurations (e.g., ndo_rx_flow_steer), leading to significant
> +	 * contention on driver internal locks (like mlx5's arfs_lock).
> +	 *
> +	 * This strategy only updates the flow record if it migrates across LLC
> +	 * boundaries. This minimizes expensive hardware updates while preserving
> +	 * cache locality for the application.
> +	 */
> +	if (static_branch_unlikely(&rps_feat_llc_affinity)) {
> +		/* Force update if the recorded CPU is invalid or has gone offline */
> +		if (old_cpu >= nr_cpu_ids || !cpu_active(old_cpu))
> +			return true;
> +
> +		/*
> +		 * Force an update if the current task is no longer permitted
> +		 * to run on the old_cpu.
> +		 */
> +		if (!cpumask_test_cpu(old_cpu, current->cpus_ptr))
> +			return true;
> +
> +		/*
> +		 * If CPUs do not share a cache, allow the update to prevent
> +		 * expensive remote memory accesses and cache misses.
> +		 */
> +		if (!cpus_share_cache(old_cpu, new_cpu))
> +			return true;
> +
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  #ifdef CONFIG_RFS_ACCEL
>
>  /**
> @@ -5249,6 +5303,28 @@ bool rps_may_expire_flow(struct net_device *dev, u16 rxq_index,
>  }
>  EXPORT_SYMBOL(rps_may_expire_flow);
>
> +void sock_rps_record_flow_hash(__u32 hash)
> +{
> +#ifdef CONFIG_RPS
> +	if (!rfs_is_needed())
> +		return;
> +
> +	_sock_rps_record_flow_hash(hash);
> +#endif
> +}
> +EXPORT_SYMBOL(sock_rps_record_flow_hash);
> +
> +void sock_rps_record_flow(const struct sock *sk)
> +{
> +#ifdef CONFIG_RPS
> +	if (!rfs_is_needed())
> +		return;
> +
> +	_sock_rps_record_flow(sk);
> +#endif
> +}
> +EXPORT_SYMBOL(sock_rps_record_flow);
> +
>  #endif /* CONFIG_RFS_ACCEL */
>
>  /* Called from hardirq (IPI) context */
> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index b508618bfc12..b6d4ebcbb6a6 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -210,6 +210,33 @@ static int rps_sock_flow_sysctl(const struct ctl_table *table, int write,
>  	kvfree_rcu_mightsleep(tofree);
>  	return ret;
>  }
> +
> +static int rps_feat_llc_affinity_sysctl(const struct ctl_table *table, int write,
> +					void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	u8 curr_state;
> +	int ret;
> +	const struct ctl_table tmp = {
> +		.data = &curr_state,
> +		.maxlen = sizeof(curr_state),
> +		.mode = table->mode,
> +		.extra1 = table->extra1,
> +		.extra2 = table->extra2
> +	};
> +
> +	curr_state = static_branch_unlikely(&rps_feat_llc_affinity) ? 1 : 0;
> +
> +	ret = proc_dou8vec_minmax(&tmp, write, buffer, lenp, ppos);
> +	if (write && ret == 0) {
> +		if (curr_state && !static_branch_unlikely(&rps_feat_llc_affinity))
> +			static_branch_enable(&rps_feat_llc_affinity);
> +		else if (!curr_state && static_branch_unlikely(&rps_feat_llc_affinity))
> +			static_branch_disable(&rps_feat_llc_affinity);
> +	}
> +
> +	return ret;
> +}
> +
>  #endif /* CONFIG_RPS */
>
>  #ifdef CONFIG_NET_FLOW_LIMIT
> @@ -554,6 +581,14 @@ static struct ctl_table net_core_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= rps_sock_flow_sysctl
>  	},
> +	{
> +		.procname   = "rps_feat_llc_affinity",
> +		.maxlen     = sizeof(u8),
> +		.mode       = 0644,
> +		.proc_handler   = rps_feat_llc_affinity_sysctl,
> +		.extra1     = SYSCTL_ZERO,
> +		.extra2     = SYSCTL_ONE
> +	},
>  #endif
>  #ifdef CONFIG_NET_FLOW_LIMIT
>  	{
> --
> 2.47.3
>
>

