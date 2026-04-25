Return-Path: <netdev+bounces-281110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEyfGC6V7Gl8aAAAu9opvQ
	(envelope-from <netdev+bounces-281110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 12:19:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D28465DED
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 12:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C82C530078C2
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 10:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5147A36D9F5;
	Sat, 25 Apr 2026 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDZsLLNg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F6F23AB87
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 10:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777112363; cv=none; b=Vg18eajWTkFBmEvXUdRjrCLnoFyGnhtWnIKQgTd90b7xbtKLiHneptgLLF9O452p6Go3grJxU0f2YGW905a8mVIbbYgdef6blC2votNkRk81yy2pfC4FEZWvDNM5lspAvbqcWV9e1OVwJYPMCx+4Avtkz9bZBjvxxF9dhCRNj6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777112363; c=relaxed/simple;
	bh=Pve6/3WfmAmsVStynnTLS68HmCRygojwKBJ+abENFQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ba1c1vX11OIbavESGbLGnkleDY66x6CFycxvsPx1g5FS8KIPNhhwZ3AfSHtABYl9O8Sk1bdZGpCQ4ibJXEWS8AS+WdTMWElmV79J5nWzDTITfNjLJMh5o5tVH/ouUxIsHaPuafJPKohi0vuShXAmt2c+6ixl+nyqq5n4OYRpyPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDZsLLNg; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d77f6092eso5982736f8f.2
        for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 03:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777112360; x=1777717160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P1vrVJbkSkpdjGz4a62tCYDSPc1M8nt/0lFWMWGAuv0=;
        b=FDZsLLNgpbtTcQMcpj+tgE9YbySjUsARHnX2uRwyUX+CRVdU1iXFLXz2I7BcRyogtJ
         g7QXz7CDL2soqB/toUFeBRm17FIFKf7juydrRJpEZSkjMOCMfz5qBUJUce6gsG1WlPf+
         1R8IQZxf6wGn38eceA1QoEYaNBOcb07SiqqY9jSiPtkphNkBhtbYmT7N33qa+OOx8d1o
         8GrdRH/jrfj/Ep484Lg1XrIkJbe57Z6PvevSMjYHj2dfBoK7khLaKgSyTstEh1hJLUW+
         Dhkgr/SxVlk3wzi7Bzcb7V0uw06XvV3foStmKxRVft9JtggeoVYOlpDEK6xp8lZ2qlyK
         L49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777112360; x=1777717160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1vrVJbkSkpdjGz4a62tCYDSPc1M8nt/0lFWMWGAuv0=;
        b=Kp0fJmD3HNi/CQZX/9XXSmJ/Ff6Quy37C/ZwfWRIx3Utz7B51OddCkBeNzhWV2hUmj
         Jsv8v+22P3DHWusTGMrHyU/o1M7xPdt1UcC48AM3lNLUyKDjAqDoyqs6MaOvXfEweDTW
         nIGIQSBhtYBQTZatX4f1URE3mD4Cyn4Q0tYLV3Kq+qph5Tjv/d931kIMNocTmCmjoGzd
         LglxyGoPv3cPAWiioMAtQN5E/coxP1bfnH6h2J+gT77bzXtLJib59ojaH5xPPPjGnU+U
         1GythxKLzwB3foCjJmnp3j4npU2mmvQMf/bqnReTLr5AqfppFdJs1cJgo3wEPckRlMP2
         ywCw==
X-Forwarded-Encrypted: i=1; AFNElJ+heviOVzgxOEQ29aC42nSgEcDsAO3kol8MasAPm7f4j20g6V2CsAgUjE5h1JLRNNrFYIISjjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YydGy47R0TMImao629ZmiP5o+Fg1hrfv7itL8Hhi4eDduxLhpbb
	DVPE+CZaWVQL4xYO606i859R5W99ORbIt4clI6pncC/+DtAk6zdfsL7J
X-Gm-Gg: AeBDies6KPkzh+5R5wUKuIPTPux4fp/nC10PsufKpmlr0IOobEJSEgEbKOp8BlcEQcR
	kDthlfaDYwX5um3H2o66UADg2aGbud1RCAjUyUmJk7H7SmdvCAdA7RxWen3F0BJYcwPQ2xL8Gdl
	WHz+4KzrqrKyoxKYjE56+DZo5HJUdj7vrFZIE2JiCx+i9zcDX+olpQG4chygVZONMQLl0W1kagn
	WJiK0azGjDu/MQfYde85Fmmxf2+6wuP5O2g31nxAE0FybLmCLIq1AIKOR5fKog7j67m3XQOdVu0
	4/CzDXR/xuAAiR0IirTjh8L0vaUPGkVsXNOLJgc/BH+ysVOsYLQDpnu5AKDHxkl5I7sHfQxImHw
	dGqin1KdUjOrKrLdOUSXc+pEThUN0qoEJzVeH32Tp1RCWDa/MsttIB6An8asYOTv7SJc0UnPXwF
	N+pL2CKw457evFZkAltbdlOJcA2T/2pGPdARPLJnnsy8rnIWKlptSyY+RgNMTu/AbRYTvkwa30r
	c6x2hqCe9jOIbFt
X-Received: by 2002:a05:6000:2510:b0:43d:7508:c9c9 with SMTP id ffacd0b85a97d-43fe3e0984bmr56715309f8f.27.1777112359613;
        Sat, 25 Apr 2026 03:19:19 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:e260:ac9e:635a:575d? ([2a02:a03f:a75e:9a00:e260:ac9e:635a:575d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1176sm67561640f8f.3.2026.04.25.03.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2026 03:19:19 -0700 (PDT)
Message-ID: <b50025ba-c59d-4575-a790-fdaf0a48961d@gmail.com>
Date: Sat, 25 Apr 2026 12:19:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipv6: Implement limits on extension header parsing
To: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org
Cc: edumazet@google.com, dsahern@kernel.org, tom@herbertland.com,
 willemdebruijn.kernel@gmail.com, idosch@nvidia.com, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20260425075521.736328-1-daniel@iogearbox.net>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260425075521.736328-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 64D28465DED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-281110-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]

On 4/25/26 09:55, Daniel Borkmann wrote:
> ipv6_{skip_exthdr,find_hdr}() and ip6_{tnl_parse_tlv_enc_lim,
> protocol_deliver_rcu}() iterate over IPv6 extension headers until they
> find a non-extension-header protocol or run out of packet data. The
> loops have no iteration counter, relying solely on the packet length
> to bound them. For a crafted packet with 8-byte extension headers
> filling a 64KB jumbogram, this means a worst case of up to ~8k
> iterations with a skb_header_pointer call each. ipv6_skip_exthdr(),
> for example, is used where it parses the inner quoted packet inside
> an incoming ICMPv6 error:
> 
>    - icmpv6_rcv
>      - checksum validation
>      - case ICMPV6_DEST_UNREACH
>        - icmpv6_notify
>          - pskb_may_pull()       <- pull inner IPv6 header
>          - ipv6_skip_exthdr()    <- iterates here
>          - pskb_may_pull()
>          - ipprot->err_handler() <- sk lookup
> 
> The per-iteration cost of ipv6_skip_exthdr itself is generally
> light, but skb_header_pointer becomes more costly on reassembled
> packets: the first ~1232 bytes of the inner packet are in the skb's
> linear area, but the remaining ~63KB are in the frag_list where
> skb_copy_bits is needed to read data.
> 
> Add a configurable limit via a new sysctl net.ipv6.max_ext_hdrs_number
> (default 8, minimum 1). All four extension header walking functions
> are bound by this limit. The sysctl is in line with commit 47d3d7ac656a
> ("ipv6: Implement limits on Hop-by-Hop and Destination options").
> As documented, init_net is used to derive max_ext_hdrs_number to
> be consistent given a net cannot always reliably be retrieved.
> 
> Note that the check in ip6_protocol_deliver_rcu() happens right
> before the goto resubmit, such that we don't have to have a test
> for ipv6_ext_hdr() in the fast-path.
> 
> There's an ongoing IETF draft-iurman-6man-eh-occurrences to enforce
> IPv6 extension headers ordering and occurrence. The latter also
> discusses security implications. As per RFC8200 section 4.1, the
> occurrence rules for extension headers provide a practical upper
> bound, thus 8 was used as the default.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   v1->v2:
>     - Set the default to 8 (Justin)
>     - Update IETF references (Justin)
>     - Add core path coverage as well (Justin)
> 
>   Documentation/networking/ip-sysctl.rst |  7 +++++++
>   include/net/dropreason-core.h          |  6 ++++++
>   include/net/ipv6.h                     |  2 ++
>   include/net/netns/ipv6.h               |  1 +
>   net/ipv6/af_inet6.c                    |  1 +
>   net/ipv6/exthdrs_core.c                | 11 +++++++++++
>   net/ipv6/ip6_input.c                   |  6 ++++++
>   net/ipv6/ip6_tunnel.c                  |  5 +++++
>   net/ipv6/sysctl_net_ipv6.c             |  8 ++++++++
>   9 files changed, 47 insertions(+)
> 

[snip]

> diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
> index 967b07aeb683..a5bbbc16e8d7 100644
> --- a/net/ipv6/ip6_input.c
> +++ b/net/ipv6/ip6_input.c
> @@ -403,8 +403,10 @@ INDIRECT_CALLABLE_DECLARE(int tcp_v6_rcv(struct sk_buff *));
>   void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
>   			      bool have_final)
>   {
> +	int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
>   	const struct inet6_protocol *ipprot;
>   	struct inet6_dev *idev;
> +	int exthdr_cnt = 0;
>   	unsigned int nhoff;
>   	SKB_DR(reason);
>   	bool raw;
> @@ -487,6 +489,10 @@ void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
>   				nexthdr = ret;
>   				goto resubmit_final;
>   			} else {
> +				if (unlikely(exthdr_cnt++ >= exthdr_max)) {
> +					SKB_DR_SET(reason, IPV6_TOO_MANY_EXTHDRS);
> +					goto discard;
> +				}
>   				goto resubmit;
>   			}
>   		} else if (ret == 0) {

The hop-by-hop options header (if present) is not taken into account 
based on the above. However, the max number of extension headers 
(implicitly 7***, as per RFC 8200 Section 4.1) must include it. I 
suggest adding this at the beginning of ip6_protocol_deliver_rcu():

struct inet6_skb_parm *opt = IP6CB(skb);

if (opt->flags & IP6SKB_HOPBYHOP)
	exthdr_cnt++;

*** FYI, rounding to 8 is fine for this fix

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

I've given it a lot of thought. I came to the conclusion that we should 
use a hard-coded value here as well (just like we did for 076b8cad77aa, 
with the same logic), not a sysctl. IMO, the main reason is that it 
provides as is a suitable security fix to be backported, i.e., the max 
value is the max number of EHs allowed by RFC 8200, Section 4.1. Also, 
we remain consistent with draft-iurman-6man-eh-occurrences (I think Tom 
is about to send a revision of the series soon for net-next). What this 
series does is not only enforcing ordering, but also verifying the 
specific number of occurrences for each type of Extension Header. Which 
is totally compatible with what this patch does, i.e., limiting the 
total number of Extension Headers (regardless of their types) to 8. I 
guess what I'm trying to say is that it seems like a good 
plan/compromise and that the aforementioned series would build perfectly 
on top of this fix.

