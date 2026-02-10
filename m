Return-Path: <netdev+bounces-258151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qP+GCKaBi2m+UwAAu9opvQ
	(envelope-from <netdev+bounces-258151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 20:06:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5FD11E7F3
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 20:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 765073019929
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 19:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435732C11D3;
	Tue, 10 Feb 2026 19:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/82rMQo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73D02C0F72
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770750322; cv=none; b=EBfAfWjvnBPxxKVuga3sBYlYbbBEsglhurcQCfzdTrAujs+GDtNMsK7F3+Yy0bpJkHLkN3FHQJeoZnPIRiHU7/wUKGhdUTGx9QSzv3P7irfbFSUbo2RfonywNtRE1IeFPbImjwPoAag6RBTeE2O3rXM5sVl3HEQZMdjfw6a1qfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770750322; c=relaxed/simple;
	bh=axQV85hajszCb4aFRsyMcSU1+r4cix6VcUasse1t09c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdjmjZCI/8MFknQZ2ccQHRGOPgm1KbYB5AbPdCBwkuf51ElUmjhuGK6noW+QMz3tim4fYFklW59tzCq4cmMXGGse2BPZpZ6e770XDxMKPcRdGTo2H+su9AgUyix9z1wujsfQ6jlOYCWuwGXaTyJuyyJ6o9uRHq4quyLJzcniSCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/82rMQo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a102494058so704215ad.0
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 11:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770750320; x=1771355120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pqlhyNMD3TrdPiZIkkmjJ1QeEF5jwUDLF67Bm+Ws0PI=;
        b=F/82rMQolWgBZiaN0/jkEs/uXyLK6/MxnqtR68CqbduU4e9v+9k/Jx1Xemh3ukQ2DK
         ceJcATJ/8nZy5X2BzzkUd8V9UC3b35sEJN+ZIfZHRgw4wC+fjmyt0/7OvXYMWOfrWo2D
         TzS/Ajf/aBn2dXK6ELMeQp8l2oK6oyA8j1BRK5Tsoj8UlV6WDa9EDW3AGwujhJBLaY3o
         7moSL0xa6R5QA3Pr6PQgDDBb/m+hbxiw348A6h/KYOCsg6wQbzK+Q/MvverWb5TM9ZtI
         WbaXPFhba9h7gIHMAAvxQEf1I3hNcibYaeIuAY5173QBLWxTkLTckopJ5W9Ir/jRFD3f
         rjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770750320; x=1771355120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pqlhyNMD3TrdPiZIkkmjJ1QeEF5jwUDLF67Bm+Ws0PI=;
        b=mmjxh/kqmBVXG3yeP+j+X5XLgvnxSJtm5ImLpA2aB1yaH6TPmjCRKLeXimP86IcOZK
         OjVaijpTx8Cqj3cOyMHT4HwCBs2A7yKk4rYyZ4AgG+Ju59mM0ik1BJiBHDNZcDVH++2s
         CL7YuORtF7ePYnoRGXxsUM2yCOWfpLfScnWvZpGtOooLzyTV6OLNvXgrCTyVKpdoikEV
         mc8LN52U8Gl9osqYnppE8vr3K8U189Ty7z186gHVPUcLwwifrOqycYqgrkBXUVGguGLO
         qHVty8CCU8Wez6a6BBhlIMpNL++PT2opwlQh2v6jjrOM5alE8s7EpP/uSpE9i3230Wqk
         2lVg==
X-Forwarded-Encrypted: i=1; AJvYcCWgEMCCubAAvXw0fi2ABc2N3jtU2upzv0a8I7zsGkjhJs0oWvQWlU2se7ybTXuI0A6UJejUNhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU2ni0Qg0U55kklCRYI+veYNW/IQy68HgXxd1VPqIaZc/tvEJX
	gmVGrXx5k9KQPzJuHuk6/E8dAMH2ufNTdRcF5SsC07rCKXWUJN3nYd1NOw5yPm4M
X-Gm-Gg: AZuq6aIwA/wYEe5Q/xw1PHY5O3iWd845LFPBp/UT9JFJ9HeiR33aAduJM6SUqn5FNJ+
	5pyoGasVnoek5ARZbZxBiCelzFXvcLnvy18TSHlKGB7Of8otGLp4J7WCT59exowvbyG90+TEFFk
	+re9XkTFWwP8Oj2L5cXylQ/WC9r4eVQdQbsSOHdw7a9dMtPbwVKDViE6j4DhkRj5w6eh/H3EFE5
	tgXk+y3QvEK7Pvqf41jXNoSQfJc2UQDTHylN1X420C+n6uTYo9C2VwonwyJ+RNiZ8oDSngtD2V5
	Gy+iDYxzJMrTjGNNNwTqE8UWt4+GXvSws6vNHw5ErJVmmeFn7bRS5aSEgTJPWCxHw/rnLoDW8Rw
	9ZlfDg2rASkxsft9fh/rmN8fVIXX7VNRYwSHc88oaKJFI0G5QrEl563Kyoue3zg8yERa6DlI6j1
	30s8fUS6LkmMkTatYgYgWcqhiT5H3LY/k2z0ZW6MZ+N64deLItj8/RM9pYbW5TGOqL3A==
X-Received: by 2002:a17:903:380d:b0:2a7:aac1:7201 with SMTP id d9443c01a7336-2ab0fc5437cmr33668595ad.3.1770750320147;
        Tue, 10 Feb 2026 11:05:20 -0800 (PST)
Received: from [10.83.123.35] (100.201.64.37.rev.sfr.net. [37.64.201.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a952217ffdsm171355895ad.88.2026.02.10.11.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 11:05:19 -0800 (PST)
Message-ID: <d46668fa-6181-4d4a-ad63-0c1eb3577889@gmail.com>
Date: Tue, 10 Feb 2026 20:05:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: ioam: fix heap buffer overflow in
 __ioam6_fill_trace_data()
To: Qanux <qjx1298677004@gmail.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, dsahern@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net
References: <20260210032550.20219-1-qjx1298677004@gmail.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260210032550.20219-1-qjx1298677004@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258151-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F5FD11E7F3
X-Rspamd-Action: no action

On 2/10/26 04:25, Qanux wrote:
> The IPv6 IOAM Pre-allocated Trace receive path (ipv6_hop_ioam in
> net/ipv6/exthdrs.c) does not validate that the nodelen field in the
> trace header is consistent with the type bitmap.
> 
> When a crafted packet arrives with nodelen=0 but with type bits set,
> __ioam6_fill_trace_data() computes the write pointer at the end of
> the trace data buffer and then writes past it, overflowing into
> adjacent memory (skb_shared_info). This corrupts critical SKB metadata,
> leading to a kernel panic when the SKB is freed.
> 
> The send path properly validates the trace header via
> ioam6_validate_trace_hdr() which recomputes nodelen from the type
> bitmap. However, calling that function from the receive path would
> break forward compatibility, as it rejects packets with undefined
> type bits (bit 12-21) that the receive path intentionally accepts.
> 
> Fix by recomputing nodelen directly from the type bitmap inside
> ioam6_fill_trace_data() before using it, preserving the receive
> path's forward compatibility while preventing the overflow.

This is correct in theory. In practice, IOAM (just like SRv6, for 
example) is to be deployed in so-called limited domains, where 
ingress/egress filters MUST be configured. Therefore, an attacker from 
outside your domain is not supposed to be able to send crafted IOAM 
header/data.

That being said, I guess we could add a check in the data plane, as you 
suggested. The reason I did not add it in the first place was to avoid 
spending "useless" cycles for that. Note that you could theoretically be 
in a situation where the attacker is inside your domain (e.g., a 
compromised node). In that case, you would indeed have the 
aforementioned problem. However, if the attacker is already inside, then 
you're in much more trouble. If you're interested, we wrote this 
(hopefully, soon-to-be-RFC) document [1] to provide integrity protection 
of IOAM, for cases like that.

Some comments on the patch below.

  [1] https://datatracker.ietf.org/doc/draft-ietf-ippm-ioam-data-integrity/

> Fixes: 9ee11f0fff20 ("ipv6: ioam: Data plane support for Pre-allocated Trace")
> Cc: stable@vger.kernel.org
> Signed-off-by: Junxi Qian <qjx1298677004@gmail.com>
> ---
>   include/net/ioam6.h       |  4 ++++
>   net/ipv6/ioam6.c          | 10 +++++++++-
>   net/ipv6/ioam6_iptunnel.c |  3 ---
>   3 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/ioam6.h b/include/net/ioam6.h
> index abfa518cd917..a3f2a1e4fd19 100644
> --- a/include/net/ioam6.h
> +++ b/include/net/ioam6.h
> @@ -14,6 +14,10 @@
>   #include <linux/ioam6_genl.h>
>   #include <linux/rhashtable-types.h>
>   
> +#define IOAM6_MASK_SHORT_FIELDS 0xff100000
> +#define IOAM6_MASK_WIDE_FIELDS  0x00e00000
> +#define IOAM6_MASK_UNDEF_FIELDS 0x000ffc00
> +
>   struct ioam6_namespace {
>   	struct rhash_head head;
>   	struct rcu_head rcu;
> diff --git a/net/ipv6/ioam6.c b/net/ipv6/ioam6.c
> index 02aboriginal1..02bfixedcode 100644
> --- a/net/ipv6/ioam6.c
> +++ b/net/ipv6/ioam6.c
> @@ -929,12 +929,20 @@ void ioam6_fill_trace_data(struct sk_buff *skb,
>   			    bool is_input)
>   {
>   	struct ioam6_schema *sc;
> +	u32 fields;
>   	u8 sclen = 0;
>   
>   	/* Skip if Overflow flag is set
>   	 */
>   	if (trace->overflow)
>   		return;
>   
> +	trace->nodelen = 0;
> +	fields = be32_to_cpu(trace->type_be32);
> +	trace->nodelen += hweight32(fields & IOAM6_MASK_SHORT_FIELDS)
> +				* (sizeof(__be32) / 4);
> +	trace->nodelen += hweight32(fields & IOAM6_MASK_WIDE_FIELDS)
> +				* (sizeof(__be64) / 4);
> +	trace->nodelen += hweight32(fields & IOAM6_MASK_UNDEF_FIELDS)
> +				* (sizeof(__be32) / 4);
>   

Don't modify trace->nodelen. If trace->nodelen is incorrect, then we 
should just drop the packet. Also, please don't perform the checks here 
in the data plane, as it would unnecessarily penalize the encapsulating 
node (where checks were already performed once in the control plane). 
Move that inside ipv6_hop_ioam() instead.

While at it, let's pack the nodelen computation inside a new function, 
and call it from both situations. No need to add IOAM6_MASK_UNDEF_FIELDS 
for bits 12-21, they should be added to IOAM6_MASK_SHORT_FIELDS directly 
(from RFC9197: "Every future node data field corresponding to one of 
these bits MUST be 4 octets long"). For example (not tested):

In include/net/ioam6.h:

u8 ioam6_trace_compute_nodelen(u32 trace_type);

In net/ipv6/ioam6.c:

#define IOAM6_MASK_SHORT_FIELDS 0xff1ffc00
#define IOAM6_MASK_WIDE_FIELDS 0xe00000

u8 ioam6_trace_compute_nodelen(u32 trace_type)
{
	u8 nodelen = hweight32(trace_type & IOAM6_MASK_SHORT_FIELDS)
			* (sizeof(__be32) / 4);

	nodelen += hweight32(trace_type & IOAM6_MASK_WIDE_FIELDS)
			* (sizeof(__be64) / 4);

	return nodelen;
}

In net/ipv6/ioam6_iptunnel.c:

static bool ioam6_validate_trace_hdr(struct ioam6_trace_hdr *trace)
{
	u32 fields;

	if (!trace->type_be32 || !trace->remlen ||
	    trace->remlen > IOAM6_TRACE_DATA_SIZE_MAX / 4 ||
	    trace->type.bit12 | trace->type.bit13 | trace->type.bit14 |
	    trace->type.bit15 | trace->type.bit16 | trace->type.bit17 |
	    trace->type.bit18 | trace->type.bit19 | trace->type.bit20 |
	    trace->type.bit21 | trace->type.bit23)
		return false;

	fields = be32_to_cpu(trace->type_be32);
	trace->nodelen = ioam6_trace_compute_nodelen(fields);

	return true;
}

In net/ipv6/exthdrs.c:

static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
{
	u32 trace_type;
[...]
	/* after the check for "Malformed Pre-allocated Trace header" */

	trace_type = be32_to_cpu(trace->type_be32);
	if (trace->nodelen != ioam6_trace_compute_nodelen(trace_type))
		goto drop;
[...]
}

Thanks,
Justin

>   	/* NodeLen does not include Opaque State Snapshot length. We need to
>   	 * take it into account if the corresponding bit is set (bit 22) and
> diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
> index 7abcdef12345..7abcfixedcode 100644
> --- a/net/ipv6/ioam6_iptunnel.c
> +++ b/net/ipv6/ioam6_iptunnel.c
> @@ -23,9 +23,6 @@
>   #include <net/ip6_route.h>
>   #include <net/addrconf.h>
>   
> -#define IOAM6_MASK_SHORT_FIELDS 0xff100000
> -#define IOAM6_MASK_WIDE_FIELDS  0x00e00000
> -
>   struct ioam6_lwt_encap {
>   	struct ipv6_hopopt_hdr eh;
>   	u8 pad[2];			/* 2-octet padding for 4n-alignment */


