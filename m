Return-Path: <netdev+bounces-306543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YqYENJPkUGrl7wIAu9opvQ
	(envelope-from <netdev+bounces-306543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:24:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E54E73ABDF
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:24:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=mhAZDJUG;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306543-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306543-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B6E630D1419
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DCE412274;
	Fri, 10 Jul 2026 12:12:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24302413D66
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 12:12:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783685563; cv=none; b=oj4kN9Sr1/yJNaVABWsYD2WUB+ylXe09k086M0PGgnHPSGpUUFTyxWX1g4YSMYOuqLg97c0Fmqt+KToiOyyL0TQCkVTICSOs4LVJ1ENAKahrJjp7WcJrdE4hgktpbVQzdoEV/ezf3P7FCOq5nyJxotvEF5RUAmyK0/+BxI3jYD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783685563; c=relaxed/simple;
	bh=kncPPJU7oSZrwqQQ6+MJyVMpyjDMZZKMch5+HSdqPOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgVUvx6Divd17PCHSGg7D7yY8lMuXOs2WEmbpx8xvMKAhDy9TYTcXIi20Xzy4HMrhhuwApP2aHuRkmvTcRlCyD6iZMSxtLv9StsyzPQvDnc4yIgfDeasE3IMUVnttyflyADO4kCeEYnSJqd3ifC8pemaWGssYVsMRW8JvkWthTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mhAZDJUG; arc=none smtp.client-ip=95.215.58.180
Message-ID: <50cb9ea4-2bbb-4cfd-a036-a57bcf3b49fc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783685548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FF7GVP6cib1+yqqgVU49xl+8QepM561jHpnXA6AG2A=;
	b=mhAZDJUGNH6BGKTdRuOasWPdBYy3JzF1+Xj8G3aS9Or8AldA6HWDYqHQSCynLH7ls89RrW
	TaIWF5RemXR+xViur/E34aThorcbSfzz1bHCYVckmFvbbIqh9SJ04WNkE4yBpugSv/Rdkb
	NxlKWZzktOVzXjhr7XS6YcuyLJdR/9Q=
Date: Fri, 10 Jul 2026 13:12:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v4] tipc: fix u16 MTU truncation in media and bearer
 MTU validation
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, jmaloy@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, tung.quang.nguyen@est.tech,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
 kys@microsoft.com
References: <20260709211649.15623-1-blbllhy@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260709211649.15623-1-blbllhy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:blbllhy@gmail.com,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:tung.quang.nguyen@est.tech,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306543-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E54E73ABDF

On 09/07/2026 22:16, Cen Zhang (Microsoft) wrote:
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
> v4: Add .min check value
> v3: Use nla_policy check to limit MTU max value as suggested by Vadim
> v2: Solved format issue
> Link: https://lore.kernel.org/all/CAB8m9WgETt0AjmFwE=F-CKjGXsK6_WDv0=kbYRcC8-noo+amnA@mail.gmail.com
> 
>   net/tipc/netlink.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/tipc/netlink.c b/net/tipc/netlink.c
> index 8336a9664703..811438c44542 100644
> --- a/net/tipc/netlink.c
> +++ b/net/tipc/netlink.c
> @@ -113,12 +113,17 @@ const struct nla_policy tipc_nl_node_policy[TIPC_NLA_NODE_MAX + 1] = {
>   };
>   
>   /* Properties valid for media, bearer and link */
> +static const struct netlink_range_validation tipc_nl_mtu_range = {
> +	.min = TIPC_MIN_BEARER_MTU,
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

