Return-Path: <netdev+bounces-302041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ebr8NoBWPWpK1ggAu9opvQ
	(envelope-from <netdev+bounces-302041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:25:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8206A6C7763
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:25:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=b9d2RK0s;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302041-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302041-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 342D6302E438
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D973E92A9;
	Thu, 25 Jun 2026 16:25:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6751B3E8C64
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 16:25:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404708; cv=none; b=se4MN2pNsvqCU/BT0PNdIGOsxBrcf9BECl6f/+38xlCDX5vkMyoKYwIUWTnOhlbo6PusM4hS3jP5Psmrb6MvqByxwFlkSi20jiveHvda9OB0sQ1I1jplF3UOJkq7ANlUrJhyeKUMQSG/K9tfXWaSLb7qkXyVH+Gjx/VZS35eo7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404708; c=relaxed/simple;
	bh=30HqNndan/Z6kMjzyIR6FKO5AjUePnfZas+E41oEMCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJqcTrzJk44H27sxVlEJO8CGanFex9V8pOvObRHpJzYS5r9fwnXoRdCrdu4tPuKramKQAWlV3JZjscZ77XgDQfctg5M4NPR0zeyhRBNfIVsqXOPtxEo8yHHgY39iQwtBGL4vwrgqHheel6uzha6ACenvXC5cEut9V7R4oqFYoSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9d2RK0s; arc=none smtp.client-ip=209.85.214.194
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2c7cfa17fedso1112045ad.3
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 09:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782404705; x=1783009505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5fQOLivGFsefV0WUnhB5GWS7A9M0rAkZDGfbL+NmjNg=;
        b=b9d2RK0sy+ouuRjv3aqin7za3DkBRsNTQ7bLhe5WHrTuHr3rilmg2u5CT0+QXLZyE2
         rFeRTtDyXHKPojw4CShXmGA36fcKMVbU3uMzZayZfgrxu0SHdJB9gHsM3B7zIWrrH5s2
         pdTPaNtrdNLgAGPzo7gckjlM4HV0Mp0q0rwbJTUwTQmE1KZ9N9xZaXmlNlPBWKGumgv+
         Bk35/BpLIc1vD3bXYKun80oJnbH3Jtu+33bi/Y3K/DSk3w1th0a3Qwt7CO/Skq/+GtME
         +Nxm2rqUsu0WTQdMA64I6W1UgQfSsN8icwDi4yk9G0d83i44K6xSI7AQAruspjrOStk4
         03vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782404705; x=1783009505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fQOLivGFsefV0WUnhB5GWS7A9M0rAkZDGfbL+NmjNg=;
        b=VXLByT7MHkCE/spBDvijxV66oimUQkT31ou4cdYENh4NRNcYcv/OdwTSNrpy875f1G
         JyDXs2vJJyDdgKFCfP1ny5OOsfil9iqMwUFoA4dYrqSigFCd/oGvdgt1VpXt3bTZzfY5
         jakkCmsTXgiUnGxA7tUY+1CRhosmlU2awi4XpG4YqJeLvxnUfs/o2VAmwUVmKUeGj+WI
         OFblJmHPPoJgKckVwDJYgaUPHDQTFZ6cDy3kaV4wF9IThgN8Ait1Q3T4ea84Z/PVBWn6
         fnQtEAinn2DwW8h17+5mnt25GC6fXl5gonTcGRdrkRwSupxxxSkPAScPjvymxS06Soc7
         xplA==
X-Forwarded-Encrypted: i=1; AHgh+Ro1q7YPJjYCxJRto6MKN3B9PYqoM6LciXmUL61MpKwGt1fIcMHCan3LLdV4gz+fU82HynuzbjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx20nXlLHY3yvq+lJ/ek+oH/oHGzWBZjhjta7vlTS3zliAeVaUr
	WVACReL1pcd0dwJ3CM1VdnJaRKCRFpVsMpgksUCSvQqwWRKOFdTfkt7k
X-Gm-Gg: AfdE7cnpx+kG0Mvv7en9ffJfQtewjkeSUjUmT92xdA6r6yIksDvEDlc4wIQJFPtlkiF
	T+IHN8pD2ZMyh0ci2K3KWAPJGpKYPTgI1uhHqC+cpsqGadUmd/LzjKuSouUdg/nZ9G3qoiRyHgy
	bpgeLaZVMgaNqm5fq6EaPU8+0JUb12INy1qyDIrwUJfTAci3EGO+6pjjDhRx9fqcdyyE/Sav2ui
	H6g0B2IWLF0TLHn1fIqYMVn96zACJOmN6E+j5ioK7BVV5I/wFZ4t+LvXKgClX6et90a0M996Kre
	ZBHcq7OkIIS4x1rZjjuqrPph77opfIsbawIfZAKveYRuFGFZinecHSgFg2VeRLI7x/FVaOykR2n
	XQqsqDsCXZtIYEl5dQurfvNfOhoa3t+ip8BnQMr8MtrnTE3+8pEWFNkFcnHrZAdZEEEVvZdl52j
	nYu/gsLw==
X-Received: by 2002:a17:902:d484:b0:2be:3850:297e with SMTP id d9443c01a7336-2c7fc792f8emr31282125ad.31.1782404704363;
        Thu, 25 Jun 2026 09:25:04 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5ac8ac4sm24159485ad.14.2026.06.25.09.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:25:03 -0700 (PDT)
Date: Thu, 25 Jun 2026 09:24:59 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, jordan@jrife.io, martin.lau@linux.dev, 
	yonghong.song@linux.dev, emil@etsalapatis.com, netdev@vger.kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	horms@kernel.org
Subject: Re: [PATCH bpf-next v10 1/5] bpf: add bpf_icmp_send kfunc
Message-ID: <aj1V2ZdzY1EGtsma@devvm7509.cco0.facebook.com>
References: <20260625110321.28236-1-mahe.tardy@gmail.com>
 <20260625110321.28236-2-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260625110321.28236-2-mahe.tardy@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302041-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mahe.tardy@gmail.com,m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:martin.lau@linux.dev,m:yonghong.song@linux.dev,m:emil@etsalapatis.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:horms@kernel.org,m:mahetardy@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,jrife.io,linux.dev,etsalapatis.com,google.com,redhat.com,davemloft.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm7509.cco0.facebook.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,etsalapatis.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8206A6C7763

On 06/25, Mahe Tardy wrote:
> This is needed in the context of Tetragon to provide improved feedback
> (in contrast to just dropping packets) to east-west traffic when blocked
> by policies using cgroup_skb programs.
> 
> This reuses concepts from netfilter reject target codepath with the
> differences that:
> * Packets are cloned since the BPF user can still let the packet pass
>   (SK_PASS from the cgroup_skb progs for example) and the current skb
>   need to stay untouched (cgroup_skb hooks only allow read-only skb
>   payload).
> * We protect against recursion since the kfunc, by generating an ICMP
>   error message, could retrigger the BPF prog that invoked it.
> 
> Only ICMP_DEST_UNREACH and ICMPV6_DEST_UNREACH are currently supported.
> The interface accepts a type parameter to facilitate future extension to
> other ICMP control message types.
> 
> For normal cgroup_skb paths, the skb dst route should already be set.
> However, bpf_prog_test_run_skb can create synthetic IPv4 skbs without an
> attached route. In that case, icmp_send returns early, and the kfunc
> would otherwise report success despite no ICMP reply being sent. The
> check also rejects metadata dsts, which are not valid struct rtable
> instances. For IPv6, reject metadata dsts only: icmpv6_send can reach
> icmp6_dev, where skb_rt6_info treats any non-NULL skb dst as a struct
> rt6_info, which is not valid for metadata_dst.
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Reviewed-by: Jordan Rife <jordan@jrife.io>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  net/core/filter.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2e96b4b847ce..0a0191586b44 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -84,6 +84,9 @@
>  #include <linux/un.h>
>  #include <net/xdp_sock_drv.h>
>  #include <net/inet_dscp.h>
> +#include <linux/icmpv6.h>
> +#include <net/icmp.h>
> +#include <net/ip6_route.h>
> 
>  #include "dev.h"
> 
> @@ -12546,6 +12549,88 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
>  	return 0;
>  }
> 
> +/**
> + * bpf_icmp_send - Send an ICMP control message
> + * @skb_ctx: Packet that triggered the control message
> + * @type: ICMP type (only ICMP_DEST_UNREACH/ICMPV6_DEST_UNREACH supported)
> + * @code: ICMP code (0-15 except ICMP_FRAG_NEEDED for IPv4, 0-6 for IPv6)
> + *
> + * Sends an ICMP control message in response to the packet. The original packet
> + * is cloned before sending the ICMP message, so the BPF program can still let
> + * the packet pass if desired.
> + *
> + * Currently only ICMP_DEST_UNREACH (IPv4) and ICMPV6_DEST_UNREACH (IPv6) are
> + * supported.
> + *
> + * Return: 0 on success (send attempt), negative error code on failure:
> + *         -EBUSY: Recursion detected
> + *         -EPROTONOSUPPORT: Non-IP protocol
> + *         -EOPNOTSUPP: Unsupported ICMP type
> + *         -EINVAL: Invalid code parameter
> + *         -ENETUNREACH: No usable route/dst for the ICMP reply
> + *         -ENOMEM: Memory allocation failed
> + */
> +__bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
> +{
> +	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
> +	struct sk_buff *nskb;
> +	struct sock *sk;
> +
> +	sk = skb_to_full_sk(skb);
> +	if (sk && sk->sk_kern_sock &&
> +	    (sk->sk_protocol == IPPROTO_ICMP || sk->sk_protocol == IPPROTO_ICMPV6))
> +		return -EBUSY;
> +
> +	switch (skb->protocol) {
> +#if IS_ENABLED(CONFIG_INET)
> +	case htons(ETH_P_IP): {
> +		if (type != ICMP_DEST_UNREACH)
> +			return -EOPNOTSUPP;
> +		if (code < 0 || code > NR_ICMP_UNREACH ||
> +		    code == ICMP_FRAG_NEEDED) /* needs a valid next-hop MTU */
> +			return -EINVAL;
> +
> +		/* icmp_send expects skb_dst to be a real rtable. */
> +		if (!skb_valid_dst(skb))
> +			return -ENETUNREACH;
> +
> +		nskb = skb_clone(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		memset(IPCB(nskb), 0, sizeof(*IPCB(nskb)));
> +		icmp_send(nskb, type, code, 0);
> +		consume_skb(nskb);
> +		break;
> +	}
> +#endif
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case htons(ETH_P_IPV6):
> +		if (type != ICMPV6_DEST_UNREACH)
> +			return -EOPNOTSUPP;
> +		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
> +			return -EINVAL;

[..]

> +		/* icmpv6_send may treat skb_dst as rt6_info. */
> +		if (skb_metadata_dst(skb))
> +			return -ENETUNREACH;

A bit confused about this. Which part of icmpv6_send treats skb_dst as rt6_info?
(I see the original sashiko report about dst, but icmp6 seems to be not
requiring it)

