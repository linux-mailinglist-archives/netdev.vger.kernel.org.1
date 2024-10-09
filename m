Return-Path: <netdev+bounces-133785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DA899703D
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBAE71F23194
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A031E22F4;
	Wed,  9 Oct 2024 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C44R8i64"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40DE1925A0
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488170; cv=none; b=LV95N9kwssdSieqoZnswa/kxt52jpuJT8qGRfAQPwiy9jKtH0dG4Yxkgo46kV0ujmrzCXwPok5oZAGa6cCcQ+bI/ad3IBpC3P9opU/hJWqH+v62iPUe3NpnEq4JCRPA9MI8y9BxKVtagP69TIwjvZjM9l8b7g+fUHhKqqk0auMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488170; c=relaxed/simple;
	bh=LkjNSgxNBTA7sMgbfSAynAbWGtGlBsydkM4let6PaCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKim/GxqH3zNSGTB3yHCoh7BwsEfxzxAP2bgKhsMht26fWcHtTJr+HjBpCOIn1MaqSmfZS367A9yFEnX2ZsLYhzLPOxWWmVWEPxxiv41BdKuBH+JfXnQbQpnqBa/VI86hYfFp+EXumqJqnYwmP+8BCV/p2YVa5+4YTEV3Jyc/Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C44R8i64; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <090a2144-b8f6-4393-881d-9977eec6b13d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728488165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sb/+0gloEsvf8MsYMVLvB+vIeLX2b5NI8mbh95sO1Tk=;
	b=C44R8i64ZhXtnbpxtu2GKq7+irhxUPujk6Yb20ZXI+TfUbq56s4vQdfBS2rfDwifCrybsZ
	6EhtG7GsEHDNnk3nnVd822FkRl/oSgWE95BizwBs7UsbQmVWv+7Beg2PLiFdtFfU4kOjJY
	43MYOqqL8kOloFdhOZiC7cOhOvYyqlU=
Date: Wed, 9 Oct 2024 16:35:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: tcp: add tracepoint skb_latency for latency
 monitor
To: Menglong Dong <menglong8.dong@gmail.com>, kuba@kernel.org,
 Jason Xing <kerneljasonxing@gmail.com>, Willem de Bruijn <willemb@google.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 dsahern@kernel.org, yan@cloudflare.com, dongml2@chinatelecom.cn,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20241009121705.850222-1-dongml2@chinatelecom.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241009121705.850222-1-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 09/10/2024 13:17, Menglong Dong wrote:
> In this commit, we introduce a new tracepoint "skb_latency", which is
> used to trace the latency on sending or receiving packet. For now, only
> TCP is supported. Maybe we should call it "tcp_latency"?
> 
> There are 6 stages are introduced in this commit to trace the networking
> latency.
> 
> The existing SO_TIMESTAMPING and MSG_TSTAMP_* can obtain the timestamping
> of sending and receiving packet, but it's not convenient.
> 
> First, most applications didn't use this function when implement, and we
> can't make them implement it right now when networking latency happens.
> 
> Second, it's inefficient, as it need to get the timestamping from the
> error queue with syscalls.
> 
> Third, the timestamping it offers is not enough to analyse the latency
> on sending or receiving packet.
> 
> As for me, the main usage of this tracepoint is to be hooked by my BPF
> program, and do some filter, and capture the latency that I interested
> in.

Hi Menglong,

Looks like you are trying to solve the problem similar to what Jason is
trying to solve in a different thread:

https://lore.kernel.org/netdev/20241008095109.99918-1-kerneljasonxing@gmail.com/

I also think it's good idea to add bpf@vger.kernel.org mailing list.

See one more comment below.

> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>   include/linux/skbuff.h     | 32 ++++++++++++++++++++++++++++++++
>   include/trace/events/skb.h | 30 ++++++++++++++++++++++++++++++
>   net/core/dev.c             |  2 ++
>   net/core/net-traces.c      |  1 +
>   net/core/skbuff.c          | 20 ++++++++++++++++++++
>   net/ipv4/tcp.c             |  5 +++++
>   net/ipv4/tcp_input.c       |  1 +
>   net/ipv4/tcp_ipv4.c        |  2 ++
>   net/ipv4/tcp_output.c      |  7 +++++++
>   9 files changed, 100 insertions(+)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 39f1d16f3628..77fcda96f1fd 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1104,6 +1104,35 @@ struct sk_buff {
>   #endif
>   #define SKB_BF_MONO_TC_OFFSET		offsetof(struct sk_buff, __mono_tc_offset)
>   
> +enum skb_latency_type {
> +	/* the latency from the skb being queued in the send buffer to the
> +	 * skb is passed to L3 from L4. The latency in this case can be
> +	 * caused by the nagle.
> +	 */
> +	SKB_LATENCY_SEND,
> +	/* the latency from L3 to the skb entering the paccket scheduler
> +	 * in output path.
> +	 */
> +	SKB_LATENCY_SCHED,
> +	/* the latency from L3 to the skb entering the driver in output path */
> +	SKB_LATENCY_NIC,
> +	/* the latency from L3 to the skb being acknowledged by peer. This
> +	 * including the latency caused by delay ack. If the skb is
> +	 * retransmitted, this imply the last retransmitted skb.
> +	 */
> +	SKB_LATENCY_ACK,
> +	/* the latency from the driver to the skb entering the L4 in input path */
> +	SKB_LATENCY_RECV,
> +	/* the latency from the driver to the skb being peeked from the
> +	 * recv queue by the user in input path.
> +	 */
> +	SKB_LATENCY_PICK,
> +	SKB_LATENCY_MAX,
> +};
> +
> +extern int skb_latency_regfunc(void);
> +extern void skb_latency_unregfunc(void);
> +
>   #ifdef __KERNEL__
>   /*
>    *	Handling routines are only of interest to the kernel
> @@ -4500,6 +4529,9 @@ static inline void skb_tx_timestamp(struct sk_buff *skb)
>   		skb_tstamp_tx(skb, NULL);
>   }
>   
> +void skb_latency_notify(struct sk_buff *skb, struct sock *sk,
> +			enum skb_latency_type type);
> +
>   /**
>    * skb_complete_wifi_ack - deliver skb with wifi status
>    *
> diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
> index b877133cd93a..26825dac4347 100644
> --- a/include/trace/events/skb.h
> +++ b/include/trace/events/skb.h
> @@ -92,6 +92,36 @@ TRACE_EVENT(skb_copy_datagram_iovec,
>   	TP_printk("skbaddr=%p len=%d", __entry->skbaddr, __entry->len)
>   );
>   
> +TRACE_EVENT_FN(skb_latency,
> +
> +	TP_PROTO(struct sk_buff *skb, struct sock *sk, enum skb_latency_type type),
> +
> +	TP_ARGS(skb, sk, type),
> +
> +	TP_STRUCT__entry(
> +		__field(void *,		skbaddr)
> +		__field(void *,		skaddr)
> +		__field(u64,		latency)
> +		__field(enum skb_latency_type,	type)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->skbaddr = skb;
> +		__entry->skaddr = sk;
> +		__entry->type = type;
> +		__entry->latency = skb->tstamp ?
> +			(skb->tstamp_type == SKB_CLOCK_REALTIME ?
> +				net_timedelta(skb->tstamp) :
> +				ktime_get_ns() - skb->tstamp) : 0;
> +	),
> +
> +	TP_printk("skbaddr=%p skaddr=%p type=%d latency=%lluns",
> +		  __entry->skbaddr, __entry->skaddr, __entry->type,
> +		  __entry->latency),
> +
> +	skb_latency_regfunc, skb_latency_unregfunc
> +);
> +
>   #endif /* _TRACE_SKB_H */
>   
>   /* This part must be outside protection */
> diff --git a/net/core/dev.c b/net/core/dev.c
> index ea5fbcd133ae..ab036bbadc9a 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4347,6 +4347,8 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
>   	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP))
>   		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SCHED);
>   
> +	skb_latency_notify(skb, NULL, SKB_LATENCY_SCHED);
> +
>   	/* Disable soft irqs for various locks below. Also
>   	 * stops preemption for RCU.
>   	 */
> diff --git a/net/core/net-traces.c b/net/core/net-traces.c
> index f2fa34b1d78d..a0c1e32a5928 100644
> --- a/net/core/net-traces.c
> +++ b/net/core/net-traces.c
> @@ -57,6 +57,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(neigh_event_send_dead);
>   EXPORT_TRACEPOINT_SYMBOL_GPL(neigh_cleanup_and_release);
>   
>   EXPORT_TRACEPOINT_SYMBOL_GPL(kfree_skb);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(skb_latency);
>   
>   EXPORT_TRACEPOINT_SYMBOL_GPL(napi_poll);
>   
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 00afeb90c23a..041947d7049c 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5521,6 +5521,7 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
>   {
>   	struct sock *sk = skb->sk;
>   
> +	skb_latency_notify(skb, sk, SKB_LATENCY_NIC);
>   	if (!skb_may_tx_timestamp(sk, false))
>   		goto err;
>   
> @@ -5539,6 +5540,24 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
>   }
>   EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
>   
> +void skb_latency_notify(struct sk_buff *skb, struct sock *sk,
> +			enum skb_latency_type type)
> +{
> +	trace_skb_latency(skb, sk, type);
> +}
> +EXPORT_SYMBOL_GPL(skb_latency_notify);
> +
> +int skb_latency_regfunc(void)
> +{
> +	net_enable_timestamp();
> +	return 0;
> +}
> +
> +void skb_latency_unregfunc(void)
> +{
> +	net_disable_timestamp();
> +}
> +
>   void __skb_tstamp_tx(struct sk_buff *orig_skb,
>   		     const struct sk_buff *ack_skb,
>   		     struct skb_shared_hwtstamps *hwtstamps,
> @@ -5599,6 +5618,7 @@ EXPORT_SYMBOL_GPL(__skb_tstamp_tx);
>   void skb_tstamp_tx(struct sk_buff *orig_skb,
>   		   struct skb_shared_hwtstamps *hwtstamps)
>   {
> +	skb_latency_notify(orig_skb, NULL, SKB_LATENCY_NIC);
>   	return __skb_tstamp_tx(orig_skb, NULL, hwtstamps, orig_skb->sk,
>   			       SCM_TSTAMP_SND);
>   }
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 82cc4a5633ce..b4e7bd9c4b6f 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -283,6 +283,7 @@
>   #include <net/busy_poll.h>
>   #include <net/hotdata.h>
>   #include <trace/events/tcp.h>
> +#include <trace/events/skb.h>
>   #include <net/rps.h>
>   
>   #include "../core/devmem.h"
> @@ -688,6 +689,7 @@ void tcp_skb_entail(struct sock *sk, struct sk_buff *skb)
>   		tp->nonagle &= ~TCP_NAGLE_PUSH;
>   
>   	tcp_slow_start_after_idle_check(sk);
> +	skb_set_delivery_time(skb, tp->tcp_clock_cache, SKB_CLOCK_MONOTONIC);
>   }
>   
>   static inline void tcp_mark_urg(struct tcp_sock *tp, int flags)
> @@ -1137,6 +1139,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>   
>   	/* Ok commence sending. */
>   	copied = 0;
> +	tcp_mstamp_refresh(tp);
>   
>   restart:
>   	mss_now = tcp_send_mss(sk, &size_goal, flags);
> @@ -1318,6 +1321,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>   			goto do_error;
>   
>   		mss_now = tcp_send_mss(sk, &size_goal, flags);
> +		tcp_mstamp_refresh(tp);
>   	}
>   
>   out:
> @@ -1519,6 +1523,7 @@ void tcp_cleanup_rbuf(struct sock *sk, int copied)
>   
>   static void tcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
>   {
> +	skb_latency_notify(skb, sk, SKB_LATENCY_PICK);
>   	__skb_unlink(skb, &sk->sk_receive_queue);
>   	if (likely(skb->destructor == sock_rfree)) {
>   		sock_rfree(skb);
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index cc05ec1faac8..99218ec5faa8 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3293,6 +3293,7 @@ static void tcp_ack_tstamp(struct sock *sk, struct sk_buff *skb,
>   {
>   	const struct skb_shared_info *shinfo;
>   
> +	skb_latency_notify(skb, sk, SKB_LATENCY_ACK);
>   	/* Avoid cache line misses to get skb_shinfo() and shinfo->tx_flags */
>   	if (likely(!TCP_SKB_CB(skb)->txstamp_ack))
>   		return;
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 985028434f64..de7a9fd7773a 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -85,6 +85,7 @@
>   #include <linux/scatterlist.h>
>   
>   #include <trace/events/tcp.h>
> +#include <trace/events/skb.h>
>   
>   #ifdef CONFIG_TCP_MD5SIG
>   static int tcp_v4_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig_key *key,
> @@ -2222,6 +2223,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
>   	if (!sk)
>   		goto no_tcp_socket;
>   
> +	skb_latency_notify(skb, sk, SKB_LATENCY_RECV);
>   	if (sk->sk_state == TCP_TIME_WAIT)
>   		goto do_time_wait;
>   

Why don't you do the same notify for TCP over IPv6?

> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 08772395690d..db4bae23986f 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -48,6 +48,7 @@
>   #include <linux/skbuff_ref.h>
>   
>   #include <trace/events/tcp.h>
> +#include <trace/events/skb.h>
>   
>   /* Refresh clocks of a TCP socket,
>    * ensuring monotically increasing values.
> @@ -2512,6 +2513,7 @@ static int tcp_mtu_probe(struct sock *sk)
>   	skb = tcp_send_head(sk);
>   	skb_copy_decrypted(nskb, skb);
>   	mptcp_skb_ext_copy(nskb, skb);
> +	nskb->tstamp = skb->tstamp;
>   
>   	TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(skb)->seq;
>   	TCP_SKB_CB(nskb)->end_seq = TCP_SKB_CB(skb)->seq + probe_size;
> @@ -2540,6 +2542,7 @@ static int tcp_mtu_probe(struct sock *sk)
>   			break;
>   	}
>   	tcp_init_tso_segs(nskb, nskb->len);
> +	skb_latency_notify(nskb, sk, SKB_LATENCY_SEND);
>   
>   	/* We're ready to send.  If this fails, the probe will
>   	 * be resegmented into mss-sized pieces by tcp_write_xmit().
> @@ -2827,6 +2830,7 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
>   		if (TCP_SKB_CB(skb)->end_seq == TCP_SKB_CB(skb)->seq)
>   			break;
>   
> +		skb_latency_notify(skb, sk, SKB_LATENCY_SEND);
>   		if (unlikely(tcp_transmit_skb(sk, skb, 1, gfp)))
>   			break;
>   
> @@ -3616,6 +3620,7 @@ void tcp_send_fin(struct sock *sk)
>   		/* FIN eats a sequence byte, write_seq advanced by tcp_queue_skb(). */
>   		tcp_init_nondata_skb(skb, tp->write_seq,
>   				     TCPHDR_ACK | TCPHDR_FIN);
> +		skb_set_delivery_time(skb, tcp_clock_ns(), SKB_CLOCK_MONOTONIC);
>   		tcp_queue_skb(sk, skb);
>   	}
>   	__tcp_push_pending_frames(sk, tcp_current_mss(sk), TCP_NAGLE_OFF);
> @@ -4048,6 +4053,7 @@ static int tcp_send_syn_data(struct sock *sk, struct sk_buff *syn)
>   		goto done;
>   	}
>   
> +	skb_set_delivery_time(syn_data, tp->tcp_clock_cache, SKB_CLOCK_MONOTONIC);
>   	/* data was not sent, put it in write_queue */
>   	__skb_queue_tail(&sk->sk_write_queue, syn_data);
>   	tp->packets_out -= tcp_skb_pcount(syn_data);
> @@ -4353,6 +4359,7 @@ int tcp_write_wakeup(struct sock *sk, int mib)
>   		} else if (!tcp_skb_pcount(skb))
>   			tcp_set_skb_tso_segs(skb, mss);
>   
> +		skb_latency_notify(skb, sk, SKB_LATENCY_SEND);
>   		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_PSH;
>   		err = tcp_transmit_skb(sk, skb, 1, GFP_ATOMIC);
>   		if (!err)


