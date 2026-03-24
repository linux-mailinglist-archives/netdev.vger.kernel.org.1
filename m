Return-Path: <netdev+bounces-271176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNKnLaC/wmmjlQQAu9opvQ
	(envelope-from <netdev+bounces-271176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:45:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBE83194AE
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A7523027DB1
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121B13E2746;
	Tue, 24 Mar 2026 16:37:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158B3355F4E
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370247; cv=none; b=FHRFY0AxoJCMeTDOgUEx88lcg3iw40ohQA/emcX39kTpYOYa9Q3ru9pDhfflfk3IMCcyw9VGrQzm/+by2hzkg7iudH2jQ+4CbrWhG0rY9aDCNHp8XgkTFmYLJsrQ9VPp2Gh6agojwEEIivqYdz9wSbR72141DChKdIBN0kYvkHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370247; c=relaxed/simple;
	bh=SbNzD+59ATzZijDyEWjVtUVR5VhkAAce5/Wg4TcX0Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiH2qW8nbJ978Ebqy62LMkldvT0ZoFxwfRNKtAQKR5WQDmsHiMMnKCI3dcXU6U+XKAhIwLJz7An9tfGq43UaeE8DEx+izk/kJRs4X6tWCtXV865SA80xm8pFHv0d9lSCrG6HX9c/pnPKOq1Xb9K8g3Z5umGdwG0t17mCapwcyBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id A67126078E; Tue, 24 Mar 2026 17:37:22 +0100 (CET)
Date: Tue, 24 Mar 2026 17:37:01 +0100
From: Florian Westphal <fw@strlen.de>
To: David Carlier <devnexen@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] netfilter: conntrack: clamp TCP window scale to
 TCP_MAX_WSCALE via ctnetlink
Message-ID: <acK9rdPQNqwejye9@strlen.de>
References: <20260324163033.310087-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324163033.310087-1-devnexen@gmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271176-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3BBE83194AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

David Carlier <devnexen@gmail.com> wrote:
> The normal TCP option parsing path clamps td_scale to TCP_MAX_WSCALE
> (14), but the ctnetlink path (nlattr_to_tcp) accepts any u8 value
> (0-255). This td_scale is then used as a shift count for u32 values,
> causing undefined behavior when >= 32.
> 
> Use NLA_POLICY_MAX in the netlink policy to reject values exceeding
> TCP_MAX_WSCALE at parse time, consistent with how commit f900e1d77ee0
> ("netfilter: conntrack: add missing validation of SCTP netlink
> attributes") addressed similar missing validations.
> 
> Fixes: c8e2078cfe41 ("[NETFILTER]: ctnetlink: add support for internal tcp connection tracking flags handling")
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  net/netfilter/nf_conntrack_proto_tcp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
> index 0c1d086e96cb..7d364337d71e 100644
> --- a/net/netfilter/nf_conntrack_proto_tcp.c
> +++ b/net/netfilter/nf_conntrack_proto_tcp.c
> @@ -1386,8 +1386,8 @@ static int tcp_to_nlattr(struct sk_buff *skb, struct nlattr *nla,
>  
>  static const struct nla_policy tcp_nla_policy[CTA_PROTOINFO_TCP_MAX+1] = {
>  	[CTA_PROTOINFO_TCP_STATE]	    = { .type = NLA_U8 },
> -	[CTA_PROTOINFO_TCP_WSCALE_ORIGINAL] = { .type = NLA_U8 },
> -	[CTA_PROTOINFO_TCP_WSCALE_REPLY]    = { .type = NLA_U8 },
> +	[CTA_PROTOINFO_TCP_WSCALE_ORIGINAL] = NLA_POLICY_MAX(NLA_U8, TCP_MAX_WSCALE),
> +	[CTA_PROTOINFO_TCP_WSCALE_REPLY]    = NLA_POLICY_MAX(NLA_U8, TCP_MAX_WSCALE),
>  	[CTA_PROTOINFO_TCP_FLAGS_ORIGINAL]  = { .len = sizeof(struct nf_ct_tcp_flags) },
>  	[CTA_PROTOINFO_TCP_FLAGS_REPLY]	    = { .len = sizeof(struct nf_ct_tcp_flags) },

Makes sense, but I would prefer to update everything in one go, as in
this pending patch:

https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git/commit/?h=testing&id=3b77a876d9b980daf27f0fd70eaa7344db7c36a7

