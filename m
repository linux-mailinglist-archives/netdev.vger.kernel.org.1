Return-Path: <netdev+bounces-279491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FOWFF/5u42lDGwEAu9opvQ
	(envelope-from <netdev+bounces-279491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 13:46:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FFD42103D
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 13:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEF973006979
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 11:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2566224AF9;
	Sat, 18 Apr 2026 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQqe4Z7R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EA1F513
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776512761; cv=none; b=I1gFdHh2Yi4gGL1mRtOx4400+Iz7/p4wW1hrQ0SbiQm34VIKBntUhmU1Pp7FvOicRRYhikUrn9qus7DlBY4aeygcEKB3lfbt7spFVHJClp29e/g+A5I5y1HEanFtMIWCsdbRcnBE/E0US9I0+7QZewJQEAdtejAc+PCnZuaD+LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776512761; c=relaxed/simple;
	bh=ZTn5xDu8Q0E4HBpqUCA3y8ssJXjf8K8LVsEsuKngX0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q705Xy1rQKfsvQlZGSV5cR4sBma/wKuvdgVt6Q4071eWVb4jZosZreAc26HuVIvWPgo9+FZ6/iA0A/4f2xpyc05qAVEWHZlJgcQ1JnaVu2vkxXiw4rPqbWG6A1kECAXHXmpYtwKD0Llojmmi9yVpNdpdFIa3gjsTpOIDzT6c6l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQqe4Z7R; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so9838035e9.1
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 04:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776512758; x=1777117558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zk1LutJN933vuJaPTvPBWtMb30ipdSzwTTcHyejSPJA=;
        b=UQqe4Z7RnMQ91/DiYcO9+DvxZM+CzTNL/53k3WXMgXAt6qKVW9S2UurN9DzCGiWPtU
         +NgKk9FRwKNMFQB0XdSbZKmDQfu/mV//jFFi+0OnM8aHRrlcFhLq4k59qx9TFJTBBuuM
         M+5v5Y3Rk6j7qEasEZN2jJP8BqpKXqC+2BpwXe/LYzzOj5Og4fXaYDQLw2UlA9kmjPut
         ZxV3gU1p3CudxW+XbVBNaAdEze5ThOwUPfdHvP3tqdXt8+UrLyL/1/V600htjzN2qGHZ
         0HA0TGPyL3B/JtayCW+W6KdUlWkFwW/bKpKW9RcBxkUziR3zYX9w0yTy8KnJupBKynMq
         LBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776512758; x=1777117558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zk1LutJN933vuJaPTvPBWtMb30ipdSzwTTcHyejSPJA=;
        b=O42iEN4YdJdZmBeVouh+sWW/IbRN0P/3pDflUtGa90LU3hcFsXWVtY35GDNPsy9R+U
         CwHfxSZ+iaeGzVOKbhj4SQFePo1qeKOFMqFsdhSrdy8iS4j5KNnRZ+lCYaZdc0+9kRl0
         mGx2KcNjEsRu+dzWrjxG6MFMSUdXg0tD82aW/kxJwKeX7JuwkDo/VXykI/uHefCy3WcL
         J7+ExT+3Esw6yF8Os2Paac+hwBojY5M6YCw2HJp+YxYYTGyqsxZ8w8CaLUogMyWNC6Kj
         smmu2R8LdxfvXncDxsciwVtqod939REoofBEcq7IZc7ybZDHljXKhu4Nypdp9s16AkIk
         O72A==
X-Forwarded-Encrypted: i=1; AFNElJ8JM507urktGHEW8ZX1y2yZYFFtojhjp/7y7ETC1CKDZg1ItI4O1lM8a/GT3yY64sgChthIiWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdn+t6LUp4GjbwoXe1DGljXSwcFgPGMbacdKNM+zTEdpLAoc/j
	uKXwkvSPxTbTd4AOEm7y6haeRmh7mXbcJpEfB3iCIrtuhO/4kRwnaJPF
X-Gm-Gg: AeBDievDZF3+MNHkFAg9PBR2o08hBs0DTNP/augDJ1fIzz39LJk233BnTNDgYn8dZpd
	bIKeHce0t1Mou0qIi8Vj4loZb68T1iYcZMlX1p+L/2EzgSvlXuFVk5ooQOMc2duOqbC7w8wwhos
	Vh9n3yFmG2pV9Z3iuRHnw45lZ0jR6aMCYS5BYgX9B6C7eJxgvrgJZ6+/7nlGtKK0yMUjmR7rTty
	kTS4XCUb3cLxUtwCKkm0TrD4G7wyN43XS8KOQ21KvZTmcDWY2iohziGvlAaJ8tRyCq+95tUP3Z9
	8dMEnutwDx692XklPSC9OF4Qgz5Q5Nw2Kr9/9cx/Pd8UjJ0ypGJlUU+I/b1SAwNlsmLT1JoYj5d
	87qVZQY0ws6gzsqhPoXxgTVXIW2t6HKTMDOC/LXXqp4sUoBhktM+WNKNRfmGxy9SiFXUrWEPj8W
	U8iPRpqd7Std8kZXctcHpfwy52r64itgerTLuA16BihiQymZ4wEPny8LhENmPShXHW6mqNwVk1B
	GRA3JOTvZa8pfzv
X-Received: by 2002:a05:600c:6286:b0:485:3f1c:d8a1 with SMTP id 5b1f17b1804b1-488fb74a677mr92637755e9.9.1776512758230;
        Sat, 18 Apr 2026 04:45:58 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:5273:4380:96ab:9087? ([2a02:a03f:a75e:9a00:5273:4380:96ab:9087])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb762f56sm40167775e9.15.2026.04.18.04.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 04:45:57 -0700 (PDT)
Message-ID: <60b47924-dae4-4a10-b977-75b92e1094c0@gmail.com>
Date: Sat, 18 Apr 2026 13:45:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: Implement limits on extension header parsing
To: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org
Cc: edumazet@google.com, dsahern@kernel.org, tom@herbertland.com,
 willemdebruijn.kernel@gmail.com, idosch@nvidia.com, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20260417171831.687053-1-daniel@iogearbox.net>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260417171831.687053-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279491-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:email,ietf.org:url]
X-Rspamd-Queue-Id: A9FFD42103D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/17/26 19:18, Daniel Borkmann wrote:
> ipv6_{skip_exthdr,find_hdr}() and ip6_tnl_parse_tlv_enc_lim() iterate
> over IPv6 extension headers until they find a non-extension-header
> protocol or run out of packet data. The loops have no iteration counter,
> relying solely on the packet length to bound them. For a crafted packet
> with 8-byte extension headers filling a 64KB jumbogram, this means a
> worst case of up to ~8k iterations with a skb_header_pointer call each.
> ipv6_skip_exthdr(), for example, is used where it parses the inner
> quoted packet inside an incoming ICMPv6 error:
> 
>    - icmpv6_rcv
>      - checksum validation
>      - case ICMPV6_DEST_UNREACH
>        - icmpv6_notify
>          - pskb_may_pull()       <- pull inner IPv6 header
>          - ipv6_skip_exthdr()    <- iterates here
>          - pskb_may_pull()
>          - ipprot->err_handler() <- sk lookup (matching sk not required)
> 
> The per-iteration cost of ipv6_skip_exthdr itself is generally light,
> but skb_header_pointer becomes more costly on reassembled packets: the
> first ~1KB of the inner packet are in the skb's linear area, but the
> remaining ~63KB are in the frag_list where skb_copy_bits is needed to
> read data.
> 
> Add a configurable limit via a new sysctl net.ipv6.max_ext_hdrs_number
> (default 32, minimum 1). All three extension header walking functions
> are bound by this limit. The sysctl is in line with commit 47d3d7ac656a
> ("ipv6: Implement limits on Hop-by-Hop and Destination options"). The
> init_net is used since plumbing a struct net * through all helpers
> would touch a lot of callsites.
> 
> There's an ongoing IETF draft-ietf-6man-eh-limits-18 that states that
> 8 extension headers before the transport header is the baseline which
> routers MUST handle; section 7 details also why limits are needed.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   Documentation/networking/ip-sysctl.rst |  7 +++++++
>   include/net/ipv6.h                     |  2 ++
>   include/net/netns/ipv6.h               |  1 +
>   net/ipv6/af_inet6.c                    |  1 +
>   net/ipv6/exthdrs_core.c                | 11 +++++++++++
>   net/ipv6/ip6_tunnel.c                  |  5 +++++
>   net/ipv6/sysctl_net_ipv6.c             |  8 ++++++++
>   7 files changed, 35 insertions(+)
> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 6921d8594b84..4559a956bbd9 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -2503,6 +2503,13 @@ max_hbh_length - INTEGER
>   
>   	Default: INT_MAX (unlimited)
>   
> +max_ext_hdrs_number - INTEGER
> +	Maximum number of IPv6 extension headers allowed in a packet.
> +	Limits how many extension headers will be traversed. The value
> +	is read from the initial netns.
> +
> +	Default: 32
> +
>   skip_notify_on_dev_down - BOOLEAN
>   	Controls whether an RTM_DELROUTE message is generated for routes
>   	removed when a device is taken down or deleted. IPv4 does not
> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> index 53c5056508be..d7f0d55e6918 100644
> --- a/include/net/ipv6.h
> +++ b/include/net/ipv6.h
> @@ -90,6 +90,8 @@ struct ip_tunnel_info;
>   #define IP6_DEFAULT_MAX_DST_OPTS_LEN	 INT_MAX /* No limit */
>   #define IP6_DEFAULT_MAX_HBH_OPTS_LEN	 INT_MAX /* No limit */
>   
> +#define IP6_DEFAULT_MAX_EXT_HDRS_CNT	 32
> +
>   /*
>    *	Addr type
>    *	
> diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
> index 34bdb1308e8f..5be4dd1c9ae8 100644
> --- a/include/net/netns/ipv6.h
> +++ b/include/net/netns/ipv6.h
> @@ -54,6 +54,7 @@ struct netns_sysctl_ipv6 {
>   	int max_hbh_opts_cnt;
>   	int max_dst_opts_len;
>   	int max_hbh_opts_len;
> +	int max_ext_hdrs_cnt;
>   	int seg6_flowlabel;
>   	u32 ioam6_id;
>   	u64 ioam6_id_wide;
> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index 4cbd45b68088..ed7fe6e4a6bd 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c
> @@ -965,6 +965,7 @@ static int __net_init inet6_net_init(struct net *net)
>   	net->ipv6.sysctl.flowlabel_state_ranges = 0;
>   	net->ipv6.sysctl.max_dst_opts_cnt = IP6_DEFAULT_MAX_DST_OPTS_CNT;
>   	net->ipv6.sysctl.max_hbh_opts_cnt = IP6_DEFAULT_MAX_HBH_OPTS_CNT;
> +	net->ipv6.sysctl.max_ext_hdrs_cnt = IP6_DEFAULT_MAX_EXT_HDRS_CNT;
>   	net->ipv6.sysctl.max_dst_opts_len = IP6_DEFAULT_MAX_DST_OPTS_LEN;
>   	net->ipv6.sysctl.max_hbh_opts_len = IP6_DEFAULT_MAX_HBH_OPTS_LEN;
>   	net->ipv6.sysctl.fib_notify_on_flag_change = 0;
> diff --git a/net/ipv6/exthdrs_core.c b/net/ipv6/exthdrs_core.c
> index 49e31e4ae7b7..917307877cbb 100644
> --- a/net/ipv6/exthdrs_core.c
> +++ b/net/ipv6/exthdrs_core.c
> @@ -4,6 +4,8 @@
>    * not configured or static.
>    */
>   #include <linux/export.h>
> +
> +#include <net/net_namespace.h>
>   #include <net/ipv6.h>
>   
>   /*
> @@ -72,7 +74,9 @@ EXPORT_SYMBOL(ipv6_ext_hdr);
>   int ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp,
>   		     __be16 *frag_offp)
>   {
> +	int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
>   	u8 nexthdr = *nexthdrp;
> +	int exthdr_cnt = 0;
>   
>   	*frag_offp = 0;
>   
> @@ -80,6 +84,8 @@ int ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp,
>   		struct ipv6_opt_hdr _hdr, *hp;
>   		int hdrlen;
>   
> +		if (unlikely(exthdr_cnt++ >= exthdr_max))
> +			return -1;
>   		if (nexthdr == NEXTHDR_NONE)
>   			return -1;
>   		hp = skb_header_pointer(skb, start, sizeof(_hdr), &_hdr);
> @@ -188,8 +194,10 @@ EXPORT_SYMBOL_GPL(ipv6_find_tlv);
>   int ipv6_find_hdr(const struct sk_buff *skb, unsigned int *offset,
>   		  int target, unsigned short *fragoff, int *flags)
>   {
> +	int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
>   	unsigned int start = skb_network_offset(skb) + sizeof(struct ipv6hdr);
>   	u8 nexthdr = ipv6_hdr(skb)->nexthdr;
> +	int exthdr_cnt = 0;
>   	bool found;
>   
>   	if (fragoff)
> @@ -216,6 +224,9 @@ int ipv6_find_hdr(const struct sk_buff *skb, unsigned int *offset,
>   			return -ENOENT;
>   		}
>   
> +		if (unlikely(exthdr_cnt++ >= exthdr_max))
> +			return -EBADMSG;
> +
>   		hp = skb_header_pointer(skb, start, sizeof(_hdr), &_hdr);
>   		if (!hp)
>   			return -EBADMSG;
> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index 0b53488a9229..78e849e167ca 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -396,15 +396,20 @@ ip6_tnl_dev_uninit(struct net_device *dev)
>   
>   __u16 ip6_tnl_parse_tlv_enc_lim(struct sk_buff *skb, __u8 *raw)
>   {
> +	int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
>   	const struct ipv6hdr *ipv6h = (const struct ipv6hdr *)raw;
>   	unsigned int nhoff = raw - skb->data;
>   	unsigned int off = nhoff + sizeof(*ipv6h);
>   	u8 nexthdr = ipv6h->nexthdr;
> +	int exthdr_cnt = 0;
>   
>   	while (ipv6_ext_hdr(nexthdr) && nexthdr != NEXTHDR_NONE) {
>   		struct ipv6_opt_hdr *hdr;
>   		u16 optlen;
>   
> +		if (unlikely(exthdr_cnt++ >= exthdr_max))
> +			break;
> +
>   		if (!pskb_may_pull(skb, off + sizeof(*hdr)))
>   			break;
>   
> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
> index d2cd33e2698d..93f865545a7c 100644
> --- a/net/ipv6/sysctl_net_ipv6.c
> +++ b/net/ipv6/sysctl_net_ipv6.c
> @@ -135,6 +135,14 @@ static struct ctl_table ipv6_table_template[] = {
>   		.extra1		= SYSCTL_ZERO,
>   		.extra2		= &flowlabel_reflect_max,
>   	},
> +	{
> +		.procname	= "max_ext_hdrs_number",
> +		.data		= &init_net.ipv6.sysctl.max_ext_hdrs_cnt,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ONE,
> +	},
>   	{
>   		.procname	= "max_dst_opts_number",
>   		.data		= &init_net.ipv6.sysctl.max_dst_opts_cnt,

NACKed-by: Justin Iurman <justin.iurman@gmail.com>

+1000 on the need, but NAK on the way it is done. IMO, we don't want 
yet-another-sysctl for that. Instead, we have (well, not yet, but it's 
about time) this series [1] to enforce ordering and occurrences of 
Extension Headers, which is based on an IETF draft [2] (FYI, 
draft-ietf-6man-eh-limits is dead). I think we should enforce ordering 
and occurrences in this code path too, instead of relying on a sysctl. 
Let's keep both code paths consistent.

  [1] 
https://lore.kernel.org/netdev/20260314175124.47010-1-tom@herbertland.com/#t
  [2] https://datatracker.ietf.org/doc/draft-iurman-6man-eh-occurrences/

