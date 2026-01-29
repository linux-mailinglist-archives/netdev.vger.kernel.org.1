Return-Path: <netdev+bounces-254883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLQEDNmhe2nOGAIAu9opvQ
	(envelope-from <netdev+bounces-254883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:07:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A350DB35FB
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A4CD3009170
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D713563C9;
	Thu, 29 Jan 2026 18:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7OvPZu4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECCF291C10
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 18:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710038; cv=none; b=e559rfXi3RzRkdUmMWxhmZm4rCBhNdHOPiE9qc/Xv0WkhlpAvHT6DG13HmsKuVPBF8Vey8rQs6dnW0ddGNf/Ja4QdGPyxvtht9o/fuTafJzjL6reaSh5s2KBjI2rBBoFSm9LNW1czVikTErRGXhyZr8Y0n5Vqt69irU+ngn479k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710038; c=relaxed/simple;
	bh=GtWg93Fe2GlUbRzQAo3C9tpoWISwC4aoY7/wAlpZel8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=epcCyTSTrbAHe2thDT5soypYYYp1JZ1pMfAn/1Yh5c/yQoIn+X5s8WZEDez+0kSVrD82a1Ze1YoGIvlnGXMJpKePsClj3xJgC8cOVtvnkFSqS2+kPV7t7JfnPD33TNsN16CausPprlcspugX35RvlqlM0s5VZjZQTEmninNoKLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7OvPZu4; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65819e75691so2281850a12.3
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 10:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769710035; x=1770314835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v4b2rixvFQnWg475nXyfn++Gt13cEgR+M9hrhuvHWAw=;
        b=E7OvPZu4DuCdo0QfrIubRvOuxwpE3KWxzKjltVpFNdaECxg0YYnBUq/n8+RqFDgMP5
         NWUHG7n8SbVw0vFbmmQkC4oPBFFuITpodpX7JgA9Vfbe0YGq3M35cV7JAH7Llz9ChovW
         VVuAIr6guJl/RO/Fn5jyVATdisDjLDsiPFq9IaZj6nJbCM7GIUAfrV4tcE0PNRpCfpCL
         QsyCcPw8a8WDOeOe3q6ITz8MR5RPMuHe+zTgym7xMGW7t0XiyiOfi+Qjw90Q/r+BzoAw
         PVSydc+7tmt2KJXLzbSvr8dL5H7qd77Ymx9ggol2h9ipyxT7YC17y9DjetkB+6Ow/tsb
         4y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769710035; x=1770314835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4b2rixvFQnWg475nXyfn++Gt13cEgR+M9hrhuvHWAw=;
        b=QINL1CWZEfFbDbhW6hiqcvKsrXWV6A9WIZArYNbTKYhtnu99N0qzCtyWMIqapHklbt
         z1droqf+NGDsyogg6i0mJEIt3t3tiPymgTSfFAMEmEskGGojiEId0rqPxxY1BXMuSW+L
         LdR3TSF5izWGFv9LksqW/qPbCcxxmaA7Roi8lGGJr+DCohSg4QOT3yOZwQyEnY2JgyEy
         XxzbChzZDAJxdxyVlN4RWH7i1c+t+O6hoFFGMvojZhetW5Js2avhMKALfxn0RkxHDqZt
         MpCvtzKDsXyjdPQ5iNNwmdakRs90+v8pHUXdcAlM3T4KiZ3MMdNlrnutwVzfCh8H3+Q6
         Nufg==
X-Forwarded-Encrypted: i=1; AJvYcCUtKQh4eUrTzcsPOgCUEdFsm639w+Xi3kkdhHJR/Dvwu7NlRCcWEHkomGiCFGJzXDb2gu+H4DE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb6P4yPtFCsCc6g7avCMs4jMt6BiRoATm8MJurM3IzhD7zqmJx
	PxntkV2wmwvRRgBUT2ScU0GWC1FrRizOVoViZV3BKDWxzpRDVfkQioFJ
X-Gm-Gg: AZuq6aJ5mpWHGcTuTueR3YcmRZG5agAjuNkiq/Rx62S6vqD9qq4OcQXdobORoaVL4rT
	Gtf6c6JAUOf8E8VV/YpKjE4PPbDH52LvJIS1IygMcAida3fPPMSq59YECOHXXd13gXfDokMFPNn
	rHzzpKYKwIB0gV9BsxsWforEJRViKF2VHSaU7X6jXDjLl95NUprmsGyM0C60CcbtsVWV8emsHzk
	m5YpPUr66muCgCt70mPbtsUXVWThMrNxAw6HZ0w6H+Ac3KF+R6I0PRPlezxlTjlNMfWnqpvwylK
	jsYR/I1VmvR8jwRW7N5hU5ge/gEqGP3kAK1W1wBGvLm5K6HPZnETQbLrE47Yy7gqSsx1aaHBQx0
	Zh6Thb6pbk+deBKZLbdff3PP7Q9axnVthvmoeoouwRLwqQqxZTp+WQyT8f8oWNApcNG929+k+mT
	WXj+1uXl8SOomdfPjPPHPUYuT575SBrapSLPOhylYKgYVVcY3TOaWaGsNdjeUw4BfTRA==
X-Received: by 2002:a05:6402:5c8:b0:658:b8de:179d with SMTP id 4fb4d7f45d1cf-658de5944demr188537a12.25.1769710034887;
        Thu, 29 Jan 2026 10:07:14 -0800 (PST)
Received: from ?IPV6:2a02:a03f:a75e:9a00:8ea7:1ca8:fcdb:48b3? ([2a02:a03f:a75e:9a00:8ea7:1ca8:fcdb:48b3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b4691e78sm3079697a12.17.2026.01.29.10.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 10:07:14 -0800 (PST)
Message-ID: <31232399-4cf4-49ea-b769-84aceca61dc9@gmail.com>
Date: Thu, 29 Jan 2026 19:07:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 6/7] ipv6: Enforce Extension Header ordering
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Tom Herbert <tom@herbertland.com>, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org
References: <20260126194826.236075-1-tom@herbertland.com>
 <20260126194826.236075-7-tom@herbertland.com>
 <willemdebruijn.kernel.19061eebdb902@gmail.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <willemdebruijn.kernel.19061eebdb902@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254883-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,herbertland.com,davemloft.net,kernel.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,herbertland.com:email]
X-Rspamd-Queue-Id: A350DB35FB
X-Rspamd-Action: no action

On 1/29/26 06:18, Willem de Bruijn wrote:
> Tom Herbert wrote:
>> RFC8200 highly recommends that different Extension Headers be send in
>> a prescibed order and all Extension Header types occur at most once
>> in a packet with the exception of Destination Options that may
>> occur twice. This patch enforces the ordering be folowed in received
>> packets.
>>
>> The allowed order of Extension Headers is:
>>
>>      IPv6 header
>>      Hop-by-Hop Options header
>>      Destination Options before the Routing Header
>>      Routing header
>>      Fragment header
>>      Authentication header
>>      Encapsulating Security Payload header
>>      Destination Options header
>>      Upper-Layer header
>>
>> Each Extension Header may be present only once in a packet.
>>
>> net.ipv6.enforce_ext_hdr_order is a sysctl to enable or disable
>> enforcement of xtension Header order. If it is set to zero then
> 
> [e]xtension. There are a few more typos in the various commit
> messages.
> 
>> Extension Header order and number of occurences is not checked
>> in receive processeing (except for Hop-by-Hop Options that
>> must be the first Extension Header and can only occur once in
>> a packet.
> 
> RFC 8200 also states
> 
>     "IPv6 nodes must accept and attempt to process extension headers in
>     any order and occurring any number of times in the same packet,
>     except for the Hop-by-Hop Options header, which is restricted to
>     appear immediately after an IPv6 header only. Nonetheless, it is
>     strongly advised that sources of IPv6 packets adhere to the above
>     recommended order until and unless subsequent specifications revise
>     that recommendation."
> 
> A case of be strict in what you send, liberal in what you accept.
> 
> This new sysctl has a chance of breaking existing users.

Willem,

Note that RFC8200 does not use normative language, which is part of the 
problem. It could theoretically break existing users, but I don't think 
it will in reality. For that, you would need users to beginning with 
(joke aside, I like EHs). Anyway, if the order is enforced at sending, 
why would any receiver accept a different order? In this case, being 
liberal in what we accept might be a security risk (see below).

> The series as a whole is framed as a security improvement. Does
> enforcing order help with that?

IMHO, any packet with EHs in a different order than the one specified in 
RFC8200 looks suspicious. So, yes.

Justin

>> Signed-off-by: Tom Herbert <tom@herbertland.com>
>> ---
>>   include/net/netns/ipv6.h   |  1 +
>>   include/net/protocol.h     | 14 +++++++++++++
>>   net/ipv6/af_inet6.c        |  1 +
>>   net/ipv6/exthdrs.c         |  2 ++
>>   net/ipv6/ip6_input.c       | 42 ++++++++++++++++++++++++++++++++++++++
>>   net/ipv6/reassembly.c      |  1 +
>>   net/ipv6/sysctl_net_ipv6.c |  7 +++++++
>>   net/ipv6/xfrm6_protocol.c  |  2 ++
>>   8 files changed, 70 insertions(+)
>>
>> diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
>> index 34bdb1308e8f..2db56718ea60 100644
>> --- a/include/net/netns/ipv6.h
>> +++ b/include/net/netns/ipv6.h
>> @@ -61,6 +61,7 @@ struct netns_sysctl_ipv6 {
>>   	u8 fib_notify_on_flag_change;
>>   	u8 icmpv6_error_anycast_as_unicast;
>>   	u8 icmpv6_errors_extension_mask;
>> +	u8 enforce_ext_hdr_order;
>>   };
>>   
>>   struct netns_ipv6 {
>> diff --git a/include/net/protocol.h b/include/net/protocol.h
>> index b2499f88f8f8..0f1676625570 100644
>> --- a/include/net/protocol.h
>> +++ b/include/net/protocol.h
>> @@ -50,6 +50,19 @@ struct net_protocol {
>>   };
>>   
>>   #if IS_ENABLED(CONFIG_IPV6)
>> +
>> +/* Order of extension headers as prescribed in RFC8200. The ordering and
>> + * number of extension headers in a packet can be enforced in IPv6 receive
>> + * processing.
>> + */
>> +#define IPV6_EXT_HDR_ORDER_HOP			BIT(0)
>> +#define IPV6_EXT_HDR_ORDER_DEST_BEFORE_RH	BIT(1)
>> +#define IPV6_EXT_HDR_ORDER_ROUTING		BIT(2)
>> +#define IPV6_EXT_HDR_ORDER_FRAGMENT		BIT(3)
>> +#define IPV6_EXT_HDR_ORDER_AUTH			BIT(4)
>> +#define IPV6_EXT_HDR_ORDER_ESP			BIT(5)
>> +#define IPV6_EXT_HDR_ORDER_DEST			BIT(6)
>> +
>>   struct inet6_protocol {
>>   	int	(*handler)(struct sk_buff *skb);
>>   
>> @@ -61,6 +74,7 @@ struct inet6_protocol {
>>   
>>   	unsigned int	flags;	/* INET6_PROTO_xxx */
>>   	u32		secret;
>> +	u32		ext_hdr_order;
>>   };
>>   
>>   #define INET6_PROTO_NOPOLICY	0x1
>> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
>> index bd29840659f3..43097360ce64 100644
>> --- a/net/ipv6/af_inet6.c
>> +++ b/net/ipv6/af_inet6.c
>> @@ -980,6 +980,7 @@ static int __net_init inet6_net_init(struct net *net)
>>   	net->ipv6.sysctl.max_dst_opts_len = IP6_DEFAULT_MAX_DST_OPTS_LEN;
>>   	net->ipv6.sysctl.max_hbh_opts_len = IP6_DEFAULT_MAX_HBH_OPTS_LEN;
>>   	net->ipv6.sysctl.fib_notify_on_flag_change = 0;
>> +	net->ipv6.sysctl.enforce_ext_hdr_order = 1;
>>   	atomic_set(&net->ipv6.fib6_sernum, 1);
>>   
>>   	net->ipv6.sysctl.ioam6_id = IOAM6_DEFAULT_ID;
>> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
>> index 6925cfad94d2..4ab94c8cddb9 100644
>> --- a/net/ipv6/exthdrs.c
>> +++ b/net/ipv6/exthdrs.c
>> @@ -845,11 +845,13 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
>>   static const struct inet6_protocol rthdr_protocol = {
>>   	.handler	=	ipv6_rthdr_rcv,
>>   	.flags		=	INET6_PROTO_NOPOLICY,
>> +	.ext_hdr_order	=	IPV6_EXT_HDR_ORDER_ROUTING,
>>   };
>>   
>>   static const struct inet6_protocol destopt_protocol = {
>>   	.handler	=	ipv6_destopt_rcv,
>>   	.flags		=	INET6_PROTO_NOPOLICY,
>> +	.ext_hdr_order	=	IPV6_EXT_HDR_ORDER_DEST,
>>   };
>>   
>>   static const struct inet6_protocol nodata_protocol = {
>> diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
>> index 168ec07e31cc..ab921c0a94af 100644
>> --- a/net/ipv6/ip6_input.c
>> +++ b/net/ipv6/ip6_input.c
>> @@ -355,6 +355,27 @@ void ipv6_list_rcv(struct list_head *head, struct packet_type *pt,
>>   		ip6_sublist_rcv(&sublist, curr_dev, curr_net);
>>   }
>>   
>> +static u32 check_dst_opts_before_rh(const struct inet6_protocol *ipprot,
>> +				    u32 ext_hdrs)
>> +{
>> +	/* Check if Destination Options before the Routing Header are
>> +	 * present.
>> +	 */
>> +	if (ipprot->ext_hdr_order != IPV6_EXT_HDR_ORDER_ROUTING ||
>> +	    !(ext_hdrs | IPV6_EXT_HDR_ORDER_DEST))
>> +		return ext_hdrs;
>> +
>> +	/* We have Destination Options before the Routing Header. Set
>> +	 * the mask of recived extension headers to reflect that. We promote
>> +	 * the bit from indicating just Destination Options present to
>> +	 * Destination Options before the Routing Header being present
>> +	 */
>> +	ext_hdrs = (ext_hdrs & ~IPV6_EXT_HDR_ORDER_DEST) |
>> +		IPV6_EXT_HDR_ORDER_DEST_BEFORE_RH;
>> +
>> +	return ext_hdrs;
>> +}
>> +
>>   INDIRECT_CALLABLE_DECLARE(int tcp_v6_rcv(struct sk_buff *));
>>   
>>   /*
>> @@ -366,6 +387,7 @@ void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
>>   	const struct inet6_protocol *ipprot;
>>   	struct inet6_dev *idev;
>>   	unsigned int nhoff;
>> +	u32 ext_hdrs = 0;
>>   	SKB_DR(reason);
>>   	bool raw;
>>   
>> @@ -427,6 +449,26 @@ void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
>>   				goto discard;
>>   			}
>>   		}
>> +
>> +		if (ipprot->ext_hdr_order &&
>> +		    READ_ONCE(net->ipv6.sysctl.enforce_ext_hdr_order)) {
>> +			/* The protocol is an extension header and EH ordering
>> +			 * is being enforced. Discard packet if we've already
>> +			 * seen this EH or one that is lower in the order list
>> +			 */
>> +			if (ipprot->ext_hdr_order <= ext_hdrs) {
>> +				/* Check if there's Destination Options
>> +				 * before the Routing Header
>> +				 */
>> +				ext_hdrs = check_dst_opts_before_rh(ipprot,
>> +								    ext_hdrs);
>> +				if (ipprot->ext_hdr_order <= ext_hdrs)
>> +					goto discard;
>> +			}
>> +
>> +			ext_hdrs |= ipprot->ext_hdr_order;
>> +		}
>> +
>>   		if (!(ipprot->flags & INET6_PROTO_NOPOLICY)) {
>>   			if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb)) {
>>   				SKB_DR_SET(reason, XFRM_POLICY);
>> diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
>> index 25ec8001898d..91dba72c5a3c 100644
>> --- a/net/ipv6/reassembly.c
>> +++ b/net/ipv6/reassembly.c
>> @@ -414,6 +414,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
>>   static const struct inet6_protocol frag_protocol = {
>>   	.handler	=	ipv6_frag_rcv,
>>   	.flags		=	INET6_PROTO_NOPOLICY,
>> +	.ext_hdr_order	=	IPV6_EXT_HDR_ORDER_FRAGMENT,
>>   };
>>   
>>   #ifdef CONFIG_SYSCTL
>> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
>> index d2cd33e2698d..543b6acdb11d 100644
>> --- a/net/ipv6/sysctl_net_ipv6.c
>> +++ b/net/ipv6/sysctl_net_ipv6.c
>> @@ -213,6 +213,13 @@ static struct ctl_table ipv6_table_template[] = {
>>   		.proc_handler	= proc_doulongvec_minmax,
>>   		.extra2		= &ioam6_id_wide_max,
>>   	},
>> +	{
>> +		.procname	= "enforce_ext_hdr_order",
>> +		.data		= &init_net.ipv6.sysctl.enforce_ext_hdr_order,
>> +		.maxlen		= sizeof(u8),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dou8vec_minmax,
>> +	},
>>   };
>>   
>>   static struct ctl_table ipv6_rotable[] = {
>> diff --git a/net/ipv6/xfrm6_protocol.c b/net/ipv6/xfrm6_protocol.c
>> index ea2f805d3b01..5826edf67f64 100644
>> --- a/net/ipv6/xfrm6_protocol.c
>> +++ b/net/ipv6/xfrm6_protocol.c
>> @@ -197,12 +197,14 @@ static const struct inet6_protocol esp6_protocol = {
>>   	.handler	=	xfrm6_esp_rcv,
>>   	.err_handler	=	xfrm6_esp_err,
>>   	.flags		=	INET6_PROTO_NOPOLICY,
>> +	.ext_hdr_order	=	IPV6_EXT_HDR_ORDER_ESP,
>>   };
>>   
>>   static const struct inet6_protocol ah6_protocol = {
>>   	.handler	=	xfrm6_ah_rcv,
>>   	.err_handler	=	xfrm6_ah_err,
>>   	.flags		=	INET6_PROTO_NOPOLICY,
>> +	.ext_hdr_order	=	IPV6_EXT_HDR_ORDER_AUTH
>>   };
>>   
>>   static const struct inet6_protocol ipcomp6_protocol = {
>> -- 
>> 2.43.0
>>
> 
> 


