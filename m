Return-Path: <netdev+bounces-306511-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M6ogCO3MUGr+5AIAu9opvQ
	(envelope-from <netdev+bounces-306511-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:43:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D29739CDC
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:43:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=aX6EezCr;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306511-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306511-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3CD9302DB67
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 10:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8607D40BCAF;
	Fri, 10 Jul 2026 10:41:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F8F3CC337
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 10:41:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680106; cv=none; b=pUyfZlCUoYtWQU8bGj0dFyjTmoNzbw2GjHb6NOFFa0KMJ0FFqURkKXcQjfdR9QftweyCXpZJ+5d0jOOsR6FeILa4UM9p55l5Z1q4GCrv4r0hzXtZgVPpi3YV6/+6Sy5o+piAOSDwJsJSjes83kfZ2YSVNqV924zgHEzcX/zPM6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680106; c=relaxed/simple;
	bh=LfhlL2W6j2hA8eOrwNmMvbP+CJ2GYmxEkNjEaH7zcYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EsmDM0qPlkhcU+TE/7O8CjnIG2iOC0Gr1XeMjZeUJqxRU4RuEpiq/77bJR5VrYtGxNYsxrbHsdyHCEYzsTSuGp9T9F03tvj9JRO0gZ80yNQLEP8A6u6UrpG9UX5VRim5t9rDG+rdSjXVGbG4pR1wdmTgYEv91mDh8nWg/fh/5TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aX6EezCr; arc=none smtp.client-ip=95.215.58.173
Message-ID: <e64ac867-71bb-4068-955e-bf3e41a00497@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783680092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIen9J+HiKMTSP8zdU+4TxCJxWFnr4znTXA41zOFZ2E=;
	b=aX6EezCrvR9grtaeAQkf5pCPN5DQ4LTPoMDag5wukubszdwnMo3zbjNdVI0Xg4tl1f05H5
	VI3xi4t1eR0h9Bv/UGZN7kKPs+mKRZTYp8Bz/wmryfNxH1/ANk2+HjgRd9M7GEWbhe1pZj
	sVrDDLQtke0mVRownXvenTIzlVUqjIU=
Date: Fri, 10 Jul 2026 11:41:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3] tipc: fix u16 MTU truncation in media and bearer
 MTU validation
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, jmaloy@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, tung.quang.nguyen@est.tech,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
 kys@microsoft.com
References: <20260708180212.2898-1-blbllhy@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260708180212.2898-1-blbllhy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:blbllhy@gmail.com,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:tung.quang.nguyen@est.tech,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306511-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,davemloft.net,google.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81D29739CDC

On 08/07/2026 19:02, Cen Zhang (Microsoft) wrote:
> Both TIPC_NL_MEDIA_SET and TIPC_NL_BEARER_SET accept user-supplied
> MTU values but only enforce a minimum bound, not a maximum. When a user
> sets the MTU to a value exceeding U16_MAX (65535), it passes validation
> but is silently truncated when assigned to u16 fields l->mtu and
> l->advertised_mtu in tipc_link_create(). Values like 65536 (0x10000)
> truncate to 0, causing a division by zero in tipc_link_set_queue_limits()
> which computes TIPC_MAX_PUBL / (l->mtu / ITEM_SIZE). Other overflowing
> values (e.g. 65537-131071) produce small incorrect MTU values, resulting
> in link malfunction behaviors.
> 
> Crash stack (triggered as unprivileged user via user namespace):
> 
>    tipc_link_set_queue_limits  net/tipc/link.c:2531
>    tipc_link_create            net/tipc/link.c:520
>    tipc_node_check_dest        net/tipc/node.c:1279
>    tipc_disc_rcv               net/tipc/discover.c:252
>    tipc_rcv                    net/tipc/node.c:2129
>    tipc_udp_recv               net/tipc/udp_media.c:392
> 
> Two independent paths lack the upper bound check:
> 1. tipc_udp_mtu_bad() -- called from __tipc_nl_media_set() (MEDIA_SET)
> 2. inline check in __tipc_nl_bearer_set() at bearer.c:1160 (BEARER_SET)
> 
> Fix both by rejecting MTU values above U16_MAX.
> 
> Fixes: 901271e0403a ("tipc: implement configuration of UDP media MTU")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Closes: https://lore.kernel.org/all/CAB8m9WgETt0AjmFwE=F-CKjGXsK6_WDv0=kbYRcC8-noo+amnA@mail.gmail.com
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
> v3: Use nla_policy check to limit MTU max value as suggested by Vadim
> v2: Solved format issue
> Link: https://lore.kernel.org/all/CAB8m9WgETt0AjmFwE=F-CKjGXsK6_WDv0=kbYRcC8-noo+amnA@mail.gmail.com
> 
>   net/tipc/netlink.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/tipc/netlink.c b/net/tipc/netlink.c
> index 8336a9664703..1307dd1a9613 100644
> --- a/net/tipc/netlink.c
> +++ b/net/tipc/netlink.c
> @@ -113,12 +113,16 @@ const struct nla_policy tipc_nl_node_policy[TIPC_NLA_NODE_MAX + 1] = {
>   };
>   
>   /* Properties valid for media, bearer and link */
> +static const struct netlink_range_validation tipc_nl_mtu_range = {
> +	.max = U16_MAX,
> +};
> +
>   const struct nla_policy tipc_nl_prop_policy[TIPC_NLA_PROP_MAX + 1] = {
>   	[TIPC_NLA_PROP_UNSPEC]		= { .type = NLA_UNSPEC },
>   	[TIPC_NLA_PROP_PRIO]		= { .type = NLA_U32 },
>   	[TIPC_NLA_PROP_TOL]		= { .type = NLA_U32 },
>   	[TIPC_NLA_PROP_WIN]		= { .type = NLA_U32 },
> -	[TIPC_NLA_PROP_MTU]		= { .type = NLA_U32 },
> +	[TIPC_NLA_PROP_MTU]		= NLA_POLICY_FULL_RANGE(NLA_U32, &tipc_nl_mtu_range),
>   	[TIPC_NLA_PROP_BROADCAST]	= { .type = NLA_U32 },
>   	[TIPC_NLA_PROP_BROADCAST_RATIO]	= { .type = NLA_U32 }
>   };

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

