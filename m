Return-Path: <netdev+bounces-258356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFMqD6/kjGmLuwAAu9opvQ
	(envelope-from <netdev+bounces-258356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 21:21:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 642E01275F5
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 21:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1581830160E5
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 20:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA9632ED37;
	Wed, 11 Feb 2026 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIwYpZ7M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD90632
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770841260; cv=none; b=sVjmerN1wKvGebt8xZlX3sTjW1OBO8GLEWw1AXtcLl0my8tZr6q+KGbnzzrCd4Yx8GdjsDnOVtiuh4SocG1JH3sP3n8a1SPxGfIK7TdC9zX71Mz1HcvERl/YULKxD89cCSaXrutpd5oRPFyn5P9wG6N/glDDfE93N3iuDDyFpIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770841260; c=relaxed/simple;
	bh=8bq5mgrIs0PIh6I9K5yA73O63TDOkBxk394XWlxd9pU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6Q/uuzFlfa4wWQM21+Elg8jsDdLmZAAKZNBVCGYZZsinR6jyNWNvAy6+9wEaF/BfX3Tm54UZoqI0k8pCJ7wGUbKVfg4vHvsSiyeCBQqVvQvppzbEDZSlgnyyqrRKus26ubtHzubExd+wfAJywwSFiONVreBNKjIwKYiYwFu6JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIwYpZ7M; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-481188b7760so52255615e9.0
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 12:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770841257; x=1771446057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTZXy+jJjEp/A8bOFn2rbqnKI1EhPCxiYQ8Oif3dzRw=;
        b=KIwYpZ7MI83lgCYqp44D03Ei/qJyqVVVkuxgL4lYnv90gwUm5Dz42ZWTURa+VJFpqG
         FN/yIoSoNylezW4ws6kNHIQ2xSjfeOdgJjC6RB7q8i89vwsXdUsqx4/kUgZW9Sk4UsTs
         jPleKOMRKNgtMXcHOF+Ap59MYhvJv++PXPzB8mClQzR2mljkqHwLh0DISevU70PEPQHz
         mPWGaJ9Iadmr58+Ub0DRxLtyG3Rf+BvzY4Tj2m9SMKB1sRtq60sTugI+WvwXodIKrDxG
         Z5izEXoMN3RmY6yU/L3HFZpAFc/oTO2lV6vdpB6wnyXQIaZSj5ICza5Ba6fomKi6NLkC
         Gl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770841257; x=1771446057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTZXy+jJjEp/A8bOFn2rbqnKI1EhPCxiYQ8Oif3dzRw=;
        b=vQ3aViu+J8Qz/izycVqNfng9tMoLCmReaGoWUCFd5iCvpyoP3Nvb2VMPsXnS89ijw7
         bN/Piasf8S9/4wiWEbfXqEyl0et1u4IM/PdhzOr7Oe9Ytqt0FRGO8EYvrV5GV1TP3x9+
         Q8+2mNoypC3UO+/2ja5rByP1OnHU56d34YKLWqhpR6fHrQjITqRS+pbc0oXaiEF38kA7
         KLfQV+T/YsQEvZklLP8eKlHTpb+g5bvZu6pBtEvvdBudM6fsGX2ZQQF0RPvmgKvJYdU/
         j3YmZIbHZoB1BHyDFpGWLdixS2+L/BvRDX8oEP5jVMT89bKUFrm9dcIa7Q3RGdl8QWRZ
         z6lg==
X-Forwarded-Encrypted: i=1; AJvYcCXbjbcmNhz5z1C6kh14Z7Idb2lnmViFelo4SypAlNVil4g+K7mHW0/r6F/WRY3VNg0ArL4gH1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx3jeGng5VROfmS5xYdhHkr9nzhTd3PhlOnOYAzmL1I+/zlYrq
	GOF/9c/I9x6UfGwVOAFArOrbX7TIvYhFXmDaU2Pmm6Trr5qj2BjxMpEe0bhPUM1v
X-Gm-Gg: AZuq6aK5ztNYf6eKPMRkcxDj05A9Q9RLt2BfeGHohzrMfq9iasIR9kp0EBGMLL+SzGC
	UbIBQEIof9EYl62x+cQmXz8OtSJmxEyTJYjD+5Oc7vG7mdSEmM2Yt32uXsj6bYcTxknS0VdRq23
	36B7wzAfWTMoh+XPfyf6b88FqYwJPFZHsLSJM5HR8aFDRN231gTbVoSc/gpPMPS5r+CXFSNOMgZ
	J2rMtGM2U9neXdZl5jgMxDRbcDdh87mK+9zRN4eiDZ3XdXJ0R0vbF5+2h7YKGScktTvpV6+JTes
	WReL0cD5/oWAeYQF4s2trHkvz6J23f62V5aVkDuSYL6eifErN0oNLfXpmxu5r/xPpUyFPWIuolM
	KdRWaxloVcNLP0liKTbWF2lqsjCmSsgEVOUpnrfAJa/NRDdKOjs8CYa+bvBB+Il9TnJWUuJe3AE
	Zn+duP+iofi9ApZqgWQP04nI3g5E4QRkxj6R3gt0LZrgEf0lnvOghzuVsooKRzh2p2Pg==
X-Received: by 2002:a05:600c:1d86:b0:480:1b1a:5526 with SMTP id 5b1f17b1804b1-483656de28cmr6235775e9.16.1770841257037;
        Wed, 11 Feb 2026 12:20:57 -0800 (PST)
Received: from [10.83.123.35] (100.201.64.37.rev.sfr.net. [37.64.201.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835b958b6csm79064365e9.1.2026.02.11.12.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 12:20:56 -0800 (PST)
Message-ID: <86f924da-c742-44eb-aea4-9ac00a872198@gmail.com>
Date: Wed, 11 Feb 2026 21:20:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipv6: ioam: fix heap buffer overflow in
 __ioam6_fill_trace_data()
To: Qanux <qjx1298677004@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org
References: <20260211040412.86195-1-qjx1298677004@gmail.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260211040412.86195-1-qjx1298677004@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258356-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 642E01275F5
X-Rspamd-Action: no action

On 2/11/26 05:04, Qanux wrote:
> On the receive path, __ioam6_fill_trace_data() uses trace->nodelen
> to decide how much data to write for each node. It trusts this field
> as-is from the incoming packet, with no consistency check against
> trace->type (the 24-bit field that tells which data items are
> present). A crafted packet can set nodelen=0 while setting type bits
> 0-21, causing the function to write ~100 bytes past the allocated
> region (into skb_shared_info), which corrupts adjacent heap memory
> and leads to a kernel panic.
> 
> Add a shared helper ioam6_trace_compute_nodelen() in ioam6.c to
> derive the expected nodelen from the type field, and use it:
> 
>    - in ioam6_iptunnel.c (send path, existing validation) to replace
>      the open-coded computation;
>    - in exthdrs.c (receive path, ipv6_hop_ioam) to drop packets whose
>      nodelen is inconsistent with the type field, before any data is
>      written.
> 
> Per RFC 9197, bits 12-21 are each short (4-octet) fields, so they
> are included in IOAM6_MASK_SHORT_FIELDS (changed from 0xff100000 to
> 0xff1ffc00).
> 
> Fixes: 9ee11f0fff20 ("ipv6: ioam: Data plane support for Pre-allocated Trace")
> Cc: stable@vger.kernel.org
> Signed-off-by: Junxi Qian <qjx1298677004@gmail.com>
> ---
> v1 -> v2:
>    - Don't recompute nodelen in the data plane; instead, validate
>      nodelen consistency in ipv6_hop_ioam() on the receive path and
>      drop inconsistent packets.
>    - Add shared helper ioam6_trace_compute_nodelen() in ioam6.c,
>      reuse it in both ioam6_iptunnel.c (send) and exthdrs.c (receive).
>    - Per RFC 9197, include bits 12-21 in IOAM6_MASK_SHORT_FIELDS
>      (0xff100000 -> 0xff1ffc00) instead of a separate UNDEF mask.
> 
> Thanks to Justin Iurman for the detailed review and suggestions.
> 
> The patch has been tested with the PoC that previously triggered the
> heap overflow. After applying this fix, the crafted packet is now
> correctly dropped at the receive path, and the kernel no longer panics.
> The patched kernel compiles and boots successfully.
> ---
>   include/net/ioam6.h       |  2 ++
>   net/ipv6/exthdrs.c        |  5 +++++
>   net/ipv6/ioam6.c          | 14 ++++++++++++++
>   net/ipv6/ioam6_iptunnel.c | 10 +---------
>   4 files changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/include/net/ioam6.h b/include/net/ioam6.h
> index 2cbbee6e8..a75912fe2 100644
> --- a/include/net/ioam6.h
> +++ b/include/net/ioam6.h
> @@ -60,6 +60,8 @@ void ioam6_fill_trace_data(struct sk_buff *skb,
>   			   struct ioam6_trace_hdr *trace,
>   			   bool is_input);
>   
> +u8 ioam6_trace_compute_nodelen(u32 trace_type);
> +
>   int ioam6_init(void);
>   void ioam6_exit(void);
>   
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index a23eb8734..50062f98d 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -930,6 +930,11 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
>   		if (hdr->opt_len < 2 + sizeof(*trace) + trace->remlen * 4)
>   			goto drop;
>   
> +		/* Inconsistent Pre-allocated Trace header */
> +		if (trace->nodelen !=
> +		    ioam6_trace_compute_nodelen(be32_to_cpu(trace->type_be32)))
> +			goto drop;
> +
>   		/* Ignore if the IOAM namespace is unknown */
>   		ns = ioam6_namespace(dev_net(skb->dev), trace->namespace_id);
>   		if (!ns)
> diff --git a/net/ipv6/ioam6.c b/net/ipv6/ioam6.c
> index 9553a3200..08b7ac8c9 100644
> --- a/net/ipv6/ioam6.c
> +++ b/net/ipv6/ioam6.c
> @@ -690,6 +690,20 @@ struct ioam6_namespace *ioam6_namespace(struct net *net, __be16 id)
>   	return rhashtable_lookup_fast(&nsdata->namespaces, &id, rht_ns_params);
>   }
>   
> +#define IOAM6_MASK_SHORT_FIELDS 0xff1ffc00
> +#define IOAM6_MASK_WIDE_FIELDS  0x00e00000
> +
> +u8 ioam6_trace_compute_nodelen(u32 trace_type)
> +{
> +	u8 nodelen = hweight32(trace_type & IOAM6_MASK_SHORT_FIELDS)
> +				* (sizeof(__be32) / 4);
> +
> +	nodelen += hweight32(trace_type & IOAM6_MASK_WIDE_FIELDS)
> +				* (sizeof(__be64) / 4);
> +
> +	return nodelen;
> +}
> +
>   static void __ioam6_fill_trace_data(struct sk_buff *skb,
>   				    struct ioam6_namespace *ns,
>   				    struct ioam6_trace_hdr *trace,
> diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
> index 1fe7894f1..b9f6d892a 100644
> --- a/net/ipv6/ioam6_iptunnel.c
> +++ b/net/ipv6/ioam6_iptunnel.c
> @@ -22,9 +22,6 @@
>   #include <net/ip6_route.h>
>   #include <net/addrconf.h>
>   
> -#define IOAM6_MASK_SHORT_FIELDS 0xff100000
> -#define IOAM6_MASK_WIDE_FIELDS 0xe00000
> -
>   struct ioam6_lwt_encap {
>   	struct ipv6_hopopt_hdr eh;
>   	u8 pad[2];			/* 2-octet padding for 4n-alignment */
> @@ -93,13 +90,8 @@ static bool ioam6_validate_trace_hdr(struct ioam6_trace_hdr *trace)
>   	    trace->type.bit21 | trace->type.bit23)
>   		return false;
>   
> -	trace->nodelen = 0;
>   	fields = be32_to_cpu(trace->type_be32);
> -
> -	trace->nodelen += hweight32(fields & IOAM6_MASK_SHORT_FIELDS)
> -				* (sizeof(__be32) / 4);
> -	trace->nodelen += hweight32(fields & IOAM6_MASK_WIDE_FIELDS)
> -				* (sizeof(__be64) / 4);
> +	trace->nodelen = ioam6_trace_compute_nodelen(fields);
>   
>   	return true;
>   }

LGTM, thanks.

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>

