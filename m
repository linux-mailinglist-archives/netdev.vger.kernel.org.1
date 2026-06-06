Return-Path: <netdev+bounces-296097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gKYbEPv/I2o81QEAu9opvQ
	(envelope-from <netdev+bounces-296097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 13:09:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC1C64D266
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 13:09:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yeah.net header.s=s110527 header.b=AdKnHzaq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296097-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296097-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=yeah.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83E093019F26
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 11:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D54430C63A;
	Sat,  6 Jun 2026 11:09:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFF61D9A5F
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 11:09:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780744183; cv=none; b=nFPl8Y+GkBEqBAMQQMPQsOvNZzb+EgYSn7wpNfAsLpInO8vBurZLBmPCq8hKjzjwvHsrxfO7AmUbkWf8j2qn2AhdpHkB/8FGvfg7pRBJtRkqusRQ40wGXN6a+PyMnRj/yrXMFxeJMIr1ek5fpYnBtpDu86DqXPr8/G2IsCDgDRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780744183; c=relaxed/simple;
	bh=dh9igelg836az/IVn8wESN9bBustg5UCL5KUIn2e+ZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBOFtliiXqaKtYT8/tS7ktKHSicVAudCVabfebYJitSJpt/4e8NMfwuOKrQzfkfNY3yt+eNrvVRGjJyyaX05p2s/WcKHpcxLXM1p6svLyOGV7f/g4E+jkE4D+xvOxxJpgmUxp7JdvcEdn3MFA8Q4hVOtOio9BfCpP+910dsKpRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=AdKnHzaq; arc=none smtp.client-ip=220.197.32.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=r4RHCTLof2VW08KiazDOQce2cjLcGT4EQ+sFu6atOdk=;
	b=AdKnHzaqYS8ZOzfrVnoXFAaWW7ZfaNt1KW6R4XaURRXvuGbpuoVzVtSxIPmsQI
	H4vWwkTel/nk0q9zGDwFZLEzXQTilIqWnxeu2UkR24O8cagGi2UrdoSkfWJkeSly
	y+3igd6hVlMfR+37EGdj5Hhfw5Zuxnn6pXPAGj/A6v4yE=
Received: from [100.70.220.18] (unknown [])
	by gzsmtp2 (Coremail) with UTF8SMTPA id Ms8vCgA3d8fY_iNqcrTDAQ--.17312S2;
	Sat, 06 Jun 2026 19:04:57 +0800 (CST)
Message-ID: <99caeafd-edf5-44a4-8742-4eada5d0f5d1@yeah.net>
Date: Sat, 6 Jun 2026 19:04:54 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: secure_seq: add back ports to TS offset
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willy Tarreau <w@1wt.eu>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Zhouyan Deng <dengzhouyan_nwpu@163.com>, Florian Westphal <fw@strlen.de>
References: <20260302205527.1982836-1-edumazet@google.com>
From: xietangxin <xietangxin@yeah.net>
In-Reply-To: <20260302205527.1982836-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Ms8vCgA3d8fY_iNqcrTDAQ--.17312S2
X-Coremail-Antispam: 1Uf129KBjvAXoWfJw4rAFyUKrWkJw1DWFyDZFb_yoW8Ar13Ko
	Wxt3WFyr1rtr13Jay2kr1fJa90vws5KF4Yqr4kKrsxuanFv345Ar4fKa1rAa12qw4rtFs5
	uFy8J3y0vw4IvFWfn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUUUUUUU
X-CM-SenderInfo: x0lh3tpqj0x0o61htxgoqh3/1tbiORpZjWoj-toG+gAA3m
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URL_NUMERIC_IP(1.50)[10.0.0.1];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yeah.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[yeah.net:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[xietangxin@yeah.net,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-296097-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[yeah.net];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:w@1wt.eu,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:dengzhouyan_nwpu@163.com,m:fw@strlen.de,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yeah.net:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xietangxin@yeah.net,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,1wt.eu,vger.kernel.org,gmail.com,163.com,strlen.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,yeah.net:mid,yeah.net:from_mime,yeah.net:dkim,strlen.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECC1C64D266



On 3/3/2026 4:55 AM, Eric Dumazet wrote:
> This reverts 28ee1b746f49 ("secure_seq: downgrade to per-host timestamp offsets")
> 
> tcp_tw_recycle went away in 2017.
> 
> Zhouyan Deng reported off-path TCP source port leakage via
> SYN cookie side-channel that can be fixed in multiple ways.
> 
> One of them is to bring back TCP ports in TS offset randomization.
> 
> As a bonus, we perform a single siphash() computation
> to provide both an ISN and a TS offset.
> 
> Fixes: 28ee1b746f49 ("secure_seq: downgrade to per-host timestamp offsets")
> Reported-by: Zhouyan Deng <dengzhouyan_nwpu@163.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Florian Westphal <fw@strlen.de>
> ---
>  include/net/secure_seq.h | 45 ++++++++++++++++++----
>  include/net/tcp.h        |  6 ++-
>  net/core/secure_seq.c    | 80 +++++++++++++++-------------------------
>  net/ipv4/syncookies.c    | 11 ++++--
>  net/ipv4/tcp_input.c     |  8 +++-
>  net/ipv4/tcp_ipv4.c      | 37 +++++++++----------
>  net/ipv6/syncookies.c    | 11 ++++--
>  net/ipv6/tcp_ipv6.c      | 37 +++++++++----------
>  8 files changed, 127 insertions(+), 108 deletions(-)
> 
> diff --git a/include/net/secure_seq.h b/include/net/secure_seq.h
> index cddebafb9f779ebd5d9c02e8ff26c13b5697c7d1..6f996229167b3c3f7861b2d5693ef81b5eed0d74 100644
> --- a/include/net/secure_seq.h
> +++ b/include/net/secure_seq.h
> @@ -5,16 +5,47 @@
>  #include <linux/types.h>
>  
>  struct net;
> +extern struct net init_net;
> +
> +union tcp_seq_and_ts_off {
> +	struct {
> +		u32 seq;
> +		u32 ts_off;
> +	};
> +	u64 hash64;
> +};
>  
>  u64 secure_ipv4_port_ephemeral(__be32 saddr, __be32 daddr, __be16 dport);
>  u64 secure_ipv6_port_ephemeral(const __be32 *saddr, const __be32 *daddr,
>  			       __be16 dport);
> -u32 secure_tcp_seq(__be32 saddr, __be32 daddr,
> -		   __be16 sport, __be16 dport);
> -u32 secure_tcp_ts_off(const struct net *net, __be32 saddr, __be32 daddr);
> -u32 secure_tcpv6_seq(const __be32 *saddr, const __be32 *daddr,
> -		     __be16 sport, __be16 dport);
> -u32 secure_tcpv6_ts_off(const struct net *net,
> -			const __be32 *saddr, const __be32 *daddr);
> +union tcp_seq_and_ts_off
> +secure_tcp_seq_and_ts_off(const struct net *net, __be32 saddr, __be32 daddr,
> +			  __be16 sport, __be16 dport);
> +
> +static inline u32 secure_tcp_seq(__be32 saddr, __be32 daddr,
> +				 __be16 sport, __be16 dport)
> +{
> +	union tcp_seq_and_ts_off ts;
> +
> +	ts = secure_tcp_seq_and_ts_off(&init_net, saddr, daddr,
> +				       sport, dport);
> +
> +	return ts.seq;
> +}
> +
> +union tcp_seq_and_ts_off
> +secure_tcpv6_seq_and_ts_off(const struct net *net, const __be32 *saddr,
> +			    const __be32 *daddr,
> +			    __be16 sport, __be16 dport);
> +
> +static inline u32 secure_tcpv6_seq(const __be32 *saddr, const __be32 *daddr,
> +				   __be16 sport, __be16 dport)
> +{
> +	union tcp_seq_and_ts_off ts;
> +
> +	ts = secure_tcpv6_seq_and_ts_off(&init_net, saddr, daddr,
> +					 sport, dport);
>  
> +	return ts.seq;
> +}
>  #endif /* _NET_SECURE_SEQ */
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index eb8bf63fdafc3243469f293fd06aef0ce086c5a4..978eea2d5df04f378dceb251025bee3101120f69 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -43,6 +43,7 @@
>  #include <net/dst.h>
>  #include <net/mptcp.h>
>  #include <net/xfrm.h>
> +#include <net/secure_seq.h>
>  
>  #include <linux/seq_file.h>
>  #include <linux/memcontrol.h>
> @@ -2464,8 +2465,9 @@ struct tcp_request_sock_ops {
>  				       struct flowi *fl,
>  				       struct request_sock *req,
>  				       u32 tw_isn);
> -	u32 (*init_seq)(const struct sk_buff *skb);
> -	u32 (*init_ts_off)(const struct net *net, const struct sk_buff *skb);
> +	union tcp_seq_and_ts_off (*init_seq_and_ts_off)(
> +					const struct net *net,
> +					const struct sk_buff *skb);
>  	int (*send_synack)(const struct sock *sk, struct dst_entry *dst,
>  			   struct flowi *fl, struct request_sock *req,
>  			   struct tcp_fastopen_cookie *foc,
> diff --git a/net/core/secure_seq.c b/net/core/secure_seq.c
> index 9a39656804513dcef0888d280d8289913ef27eea..6a6f2cda5aaef82074718439920c75a75592e967 100644
> --- a/net/core/secure_seq.c
> +++ b/net/core/secure_seq.c
> @@ -20,7 +20,6 @@
>  #include <net/tcp.h>
>  
>  static siphash_aligned_key_t net_secret;
> -static siphash_aligned_key_t ts_secret;
>  
>  #define EPHEMERAL_PORT_SHUFFLE_PERIOD (10 * HZ)
>  
> @@ -28,11 +27,6 @@ static __always_inline void net_secret_init(void)
>  {
>  	net_get_random_once(&net_secret, sizeof(net_secret));
>  }
> -
> -static __always_inline void ts_secret_init(void)
> -{
> -	net_get_random_once(&ts_secret, sizeof(ts_secret));
> -}
>  #endif
>  
>  #ifdef CONFIG_INET
> @@ -53,28 +47,9 @@ static u32 seq_scale(u32 seq)
>  #endif
>  
>  #if IS_ENABLED(CONFIG_IPV6)
> -u32 secure_tcpv6_ts_off(const struct net *net,
> -			const __be32 *saddr, const __be32 *daddr)
> -{
> -	const struct {
> -		struct in6_addr saddr;
> -		struct in6_addr daddr;
> -	} __aligned(SIPHASH_ALIGNMENT) combined = {
> -		.saddr = *(struct in6_addr *)saddr,
> -		.daddr = *(struct in6_addr *)daddr,
> -	};
> -
> -	if (READ_ONCE(net->ipv4.sysctl_tcp_timestamps) != 1)
> -		return 0;
> -
> -	ts_secret_init();
> -	return siphash(&combined, offsetofend(typeof(combined), daddr),
> -		       &ts_secret);
> -}
> -EXPORT_IPV6_MOD(secure_tcpv6_ts_off);
> -
> -u32 secure_tcpv6_seq(const __be32 *saddr, const __be32 *daddr,
> -		     __be16 sport, __be16 dport)
> +union tcp_seq_and_ts_off
> +secure_tcpv6_seq_and_ts_off(const struct net *net, const __be32 *saddr,
> +			    const __be32 *daddr, __be16 sport, __be16 dport)
>  {
>  	const struct {
>  		struct in6_addr saddr;
> @@ -87,14 +62,20 @@ u32 secure_tcpv6_seq(const __be32 *saddr, const __be32 *daddr,
>  		.sport = sport,
>  		.dport = dport
>  	};
> -	u32 hash;
> +	union tcp_seq_and_ts_off st;
>  
>  	net_secret_init();
> -	hash = siphash(&combined, offsetofend(typeof(combined), dport),
> -		       &net_secret);
> -	return seq_scale(hash);
> +
> +	st.hash64 = siphash(&combined, offsetofend(typeof(combined), dport),
> +			    &net_secret);
> +
> +	if (READ_ONCE(net->ipv4.sysctl_tcp_timestamps) != 1)
> +		st.ts_off = 0;
> +
> +	st.seq = seq_scale(st.seq);
> +	return st;
>  }
> -EXPORT_SYMBOL(secure_tcpv6_seq);
> +EXPORT_SYMBOL(secure_tcpv6_seq_and_ts_off);
>  
>  u64 secure_ipv6_port_ephemeral(const __be32 *saddr, const __be32 *daddr,
>  			       __be16 dport)
> @@ -118,33 +99,30 @@ EXPORT_SYMBOL(secure_ipv6_port_ephemeral);
>  #endif
>  
>  #ifdef CONFIG_INET
> -u32 secure_tcp_ts_off(const struct net *net, __be32 saddr, __be32 daddr)
> -{
> -	if (READ_ONCE(net->ipv4.sysctl_tcp_timestamps) != 1)
> -		return 0;
> -
> -	ts_secret_init();
> -	return siphash_2u32((__force u32)saddr, (__force u32)daddr,
> -			    &ts_secret);
> -}
> -
>  /* secure_tcp_seq_and_tsoff(a, b, 0, d) == secure_ipv4_port_ephemeral(a, b, d),
>   * but fortunately, `sport' cannot be 0 in any circumstances. If this changes,
>   * it would be easy enough to have the former function use siphash_4u32, passing
>   * the arguments as separate u32.
>   */
> -u32 secure_tcp_seq(__be32 saddr, __be32 daddr,
> -		   __be16 sport, __be16 dport)
> +union tcp_seq_and_ts_off
> +secure_tcp_seq_and_ts_off(const struct net *net, __be32 saddr, __be32 daddr,
> +			  __be16 sport, __be16 dport)
>  {
> -	u32 hash;
> +	u32 ports = (__force u32)sport << 16 | (__force u32)dport;
> +	union tcp_seq_and_ts_off st;
>  
>  	net_secret_init();
> -	hash = siphash_3u32((__force u32)saddr, (__force u32)daddr,
> -			    (__force u32)sport << 16 | (__force u32)dport,
> -			    &net_secret);
> -	return seq_scale(hash);
> +
> +	st.hash64 = siphash_3u32((__force u32)saddr, (__force u32)daddr,
> +				 ports, &net_secret);
> +
> +	if (READ_ONCE(net->ipv4.sysctl_tcp_timestamps) != 1)
> +		st.ts_off = 0;
> +
> +	st.seq = seq_scale(st.seq);
> +	return st;
>  }
> -EXPORT_SYMBOL_GPL(secure_tcp_seq);
> +EXPORT_SYMBOL_GPL(secure_tcp_seq_and_ts_off);
>  
>  u64 secure_ipv4_port_ephemeral(__be32 saddr, __be32 daddr, __be16 dport)
>  {
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 061751aabc8e16c5d536a19f7b920d1bca2b0f4f..fc3affd9c8014b1d4e9f161421a7753717cdcd73 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -378,9 +378,14 @@ static struct request_sock *cookie_tcp_check(struct net *net, struct sock *sk,
>  	tcp_parse_options(net, skb, &tcp_opt, 0, NULL);
>  
>  	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
> -		tsoff = secure_tcp_ts_off(net,
> -					  ip_hdr(skb)->daddr,
> -					  ip_hdr(skb)->saddr);
> +		union tcp_seq_and_ts_off st;
> +
> +		st = secure_tcp_seq_and_ts_off(net,
> +					       ip_hdr(skb)->daddr,
> +					       ip_hdr(skb)->saddr,
> +					       tcp_hdr(skb)->dest,
> +					       tcp_hdr(skb)->source);
> +		tsoff = st.ts_off;
>  		tcp_opt.rcv_tsecr -= tsoff;
>  	}
>  
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 7b03f2460751f366dd6cf15505e49ae26cd6466e..cba89733d1216bc2663758b4bda21984835e6055 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -7646,6 +7646,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
>  	const struct tcp_sock *tp = tcp_sk(sk);
>  	struct net *net = sock_net(sk);
>  	struct sock *fastopen_sk = NULL;
> +	union tcp_seq_and_ts_off st;
>  	struct request_sock *req;
>  	bool want_cookie = false;
>  	struct dst_entry *dst;
> @@ -7715,9 +7716,12 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
>  	if (!dst)
>  		goto drop_and_free;
>  
> +	if (tmp_opt.tstamp_ok || (!want_cookie && !isn))
> +		st = af_ops->init_seq_and_ts_off(net, skb);
> +
>  	if (tmp_opt.tstamp_ok) {
>  		tcp_rsk(req)->req_usec_ts = dst_tcp_usec_ts(dst);
> -		tcp_rsk(req)->ts_off = af_ops->init_ts_off(net, skb);
> +		tcp_rsk(req)->ts_off = st.ts_off;
>  	}
>  	if (!want_cookie && !isn) {
>  		int max_syn_backlog = READ_ONCE(net->ipv4.sysctl_max_syn_backlog);
> @@ -7739,7 +7743,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
>  			goto drop_and_release;
>  		}
>  
> -		isn = af_ops->init_seq(skb);
> +		isn = st.seq;
>  	}
>  
>  	tcp_ecn_create_request(req, skb, sk, dst);
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index d53d39be291a5750af3ab2a160b35f0f8a28ff9d..56c0db955177edd3fdd04d26d6cd07b5e379e7bc 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -104,17 +104,14 @@ static DEFINE_PER_CPU(struct sock_bh_locked, ipv4_tcp_sk) = {
>  
>  static DEFINE_MUTEX(tcp_exit_batch_mutex);
>  
> -static u32 tcp_v4_init_seq(const struct sk_buff *skb)
> +static union tcp_seq_and_ts_off
> +tcp_v4_init_seq_and_ts_off(const struct net *net, const struct sk_buff *skb)
>  {
> -	return secure_tcp_seq(ip_hdr(skb)->daddr,
> -			      ip_hdr(skb)->saddr,
> -			      tcp_hdr(skb)->dest,
> -			      tcp_hdr(skb)->source);
> -}
> -
> -static u32 tcp_v4_init_ts_off(const struct net *net, const struct sk_buff *skb)
> -{
> -	return secure_tcp_ts_off(net, ip_hdr(skb)->daddr, ip_hdr(skb)->saddr);
> +	return secure_tcp_seq_and_ts_off(net,
> +					 ip_hdr(skb)->daddr,
> +					 ip_hdr(skb)->saddr,
> +					 tcp_hdr(skb)->dest,
> +					 tcp_hdr(skb)->source);
>  }
>  
>  int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
> @@ -326,15 +323,16 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len
>  	rt = NULL;
>  
>  	if (likely(!tp->repair)) {
> +		union tcp_seq_and_ts_off st;
> +
> +		st = secure_tcp_seq_and_ts_off(net,
> +					       inet->inet_saddr,
> +					       inet->inet_daddr,
> +					       inet->inet_sport,
> +					       usin->sin_port);
>  		if (!tp->write_seq)
> -			WRITE_ONCE(tp->write_seq,
> -				   secure_tcp_seq(inet->inet_saddr,
> -						  inet->inet_daddr,
> -						  inet->inet_sport,
> -						  usin->sin_port));
> -		WRITE_ONCE(tp->tsoffset,
> -			   secure_tcp_ts_off(net, inet->inet_saddr,
> -					     inet->inet_daddr));
> +			WRITE_ONCE(tp->write_seq, st.seq);
> +		WRITE_ONCE(tp->tsoffset, st.ts_off);
>  	}
>  
>  	atomic_set(&inet->inet_id, get_random_u16());
> @@ -1676,8 +1674,7 @@ const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops = {
>  	.cookie_init_seq =	cookie_v4_init_sequence,
>  #endif
>  	.route_req	=	tcp_v4_route_req,
> -	.init_seq	=	tcp_v4_init_seq,
> -	.init_ts_off	=	tcp_v4_init_ts_off,
> +	.init_seq_and_ts_off	=	tcp_v4_init_seq_and_ts_off,
>  	.send_synack	=	tcp_v4_send_synack,
>  };
>  
> diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
> index 7e007f013ec827c99bcab4ceb85eb35e9242b439..4f6f0d751d6c533231ca0397319935dc90ba4dba 100644
> --- a/net/ipv6/syncookies.c
> +++ b/net/ipv6/syncookies.c
> @@ -151,9 +151,14 @@ static struct request_sock *cookie_tcp_check(struct net *net, struct sock *sk,
>  	tcp_parse_options(net, skb, &tcp_opt, 0, NULL);
>  
>  	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
> -		tsoff = secure_tcpv6_ts_off(net,
> -					    ipv6_hdr(skb)->daddr.s6_addr32,
> -					    ipv6_hdr(skb)->saddr.s6_addr32);
> +		union tcp_seq_and_ts_off st;
> +
> +		st = secure_tcpv6_seq_and_ts_off(net,
> +						 ipv6_hdr(skb)->daddr.s6_addr32,
> +						 ipv6_hdr(skb)->saddr.s6_addr32,
> +						 tcp_hdr(skb)->dest,
> +						 tcp_hdr(skb)->source);
> +		tsoff = st.ts_off;
>  		tcp_opt.rcv_tsecr -= tsoff;
>  	}
>  
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index e46a0efae01235ae7430ed268b92cb47309b8d28..5d95f9ab86973777c29399348adcc4b07e98d2b4 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -104,18 +104,14 @@ static void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb)
>  	}
>  }
>  
> -static u32 tcp_v6_init_seq(const struct sk_buff *skb)
> +static union tcp_seq_and_ts_off
> +tcp_v6_init_seq_and_ts_off(const struct net *net, const struct sk_buff *skb)
>  {
> -	return secure_tcpv6_seq(ipv6_hdr(skb)->daddr.s6_addr32,
> -				ipv6_hdr(skb)->saddr.s6_addr32,
> -				tcp_hdr(skb)->dest,
> -				tcp_hdr(skb)->source);
> -}
> -
> -static u32 tcp_v6_init_ts_off(const struct net *net, const struct sk_buff *skb)
> -{
> -	return secure_tcpv6_ts_off(net, ipv6_hdr(skb)->daddr.s6_addr32,
> -				   ipv6_hdr(skb)->saddr.s6_addr32);
> +	return secure_tcpv6_seq_and_ts_off(net,
> +					   ipv6_hdr(skb)->daddr.s6_addr32,
> +					   ipv6_hdr(skb)->saddr.s6_addr32,
> +					   tcp_hdr(skb)->dest,
> +					   tcp_hdr(skb)->source);
>  }
>  
>  static int tcp_v6_pre_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
> @@ -319,14 +315,16 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
>  	sk_set_txhash(sk);
>  
>  	if (likely(!tp->repair)) {
> +		union tcp_seq_and_ts_off st;
> +
> +		st = secure_tcpv6_seq_and_ts_off(net,
> +						 np->saddr.s6_addr32,
> +						 sk->sk_v6_daddr.s6_addr32,
> +						 inet->inet_sport,
> +						 inet->inet_dport);
>  		if (!tp->write_seq)
> -			WRITE_ONCE(tp->write_seq,
> -				   secure_tcpv6_seq(np->saddr.s6_addr32,
> -						    sk->sk_v6_daddr.s6_addr32,
> -						    inet->inet_sport,
> -						    inet->inet_dport));
> -		tp->tsoffset = secure_tcpv6_ts_off(net, np->saddr.s6_addr32,
> -						   sk->sk_v6_daddr.s6_addr32);
> +			WRITE_ONCE(tp->write_seq, st.seq);
> +		tp->tsoffset = st.ts_off;
>  	}
>  
>  	if (tcp_fastopen_defer_connect(sk, &err))
> @@ -816,8 +814,7 @@ const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops = {
>  	.cookie_init_seq =	cookie_v6_init_sequence,
>  #endif
>  	.route_req	=	tcp_v6_route_req,
> -	.init_seq	=	tcp_v6_init_seq,
> -	.init_ts_off	=	tcp_v6_init_ts_off,
> +	.init_seq_and_ts_off	= tcp_v6_init_seq_and_ts_off,
>  	.send_synack	=	tcp_v6_send_synack,
>  };
>  
Hi Eric and netdev,

I noticed a significant TCP performance regression (QPS drop) when using
iptables MASQUERADE with the `--random-fully` option, and I have bisected
it down to commit 165573e41f2f66ef98940cf65f838b2cb575d9d1
(tcp: secure_seq: add back ports to TS offset).

Here is the benchmark environment and test results.
Environment:
- Client & Server: 2 VMs
- Server: Nginx listening on port 80 (HTTP), and ip 10.0.0.1
- Benchmark tool: wrk (short-lived connections with "Connection: close")

Test Commands
1. With random-fully:
   # iptables -t nat -A POSTROUTING -d 10.0.0.1 -p tcp --dport 80 -j MASQUERADE --random-fully
   # wrk -t8 -c200 -H "Connection: close" -d10s --latency http://10.0.0.1:80
2. Without random-fully:
   # iptables -t nat -A POSTROUTING -d 10.0.0.1 -p tcp --dport 80 -j MASQUERADE
   # wrk -t8 -c200 -H "Connection: close" -d10s --latency http://10.0.0.1:80

Test Results (QPS):
1. Parent Commit (7f083faf59d14c04e01ec05a7507f036c965acf8):
   - with random-fully:    18145.74, 15006.39, 15716.67
   - without random-fully: 18556.36, 16339.22, 21506.02

2. Bad Commit (165573e41f2f66ef98940cf65f838b2cb575d9d1):
   - with random-fully:    11074.76, 10383.20, 10164.81  <-- (~35% drop)
   - without random-fully: 17310.75, 20279.85, 18399.48

Is this performance degradation an expected side-effect of the security fix,
or is there any sysctl param we should tune when `--random-fully` is
required for high-concurrency short connections?

Looking forward to your insights.


-- 
Best regards,
Tangxin Xie


