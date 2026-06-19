Return-Path: <netdev+bounces-300608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /3ZCJMvgNGqRjAYAu9opvQ
	(envelope-from <netdev+bounces-300608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 08:25:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E40A36A417B
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 08:25:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=baDOwNaZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300608-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300608-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 878553040A86
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 06:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E182F8EAF;
	Fri, 19 Jun 2026 06:24:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC1E2EA151
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 06:24:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781850270; cv=none; b=sqFkTtKWcMeX0Irn+N5/t5L8vuVv+6vq/3dT7Z/BK5T7bMl1fc/ZaJuJuYzZJEcwPFJ2AQ3ydfDe8qQfTb9i4dN0wzLHfLIBc3DMxRkPXKoLlqSwXJiAXFxzwKEI+QmWHVRcc5aUEX2evA2Gl+jSzYOrIYkQ7v+noy6JlSZXUoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781850270; c=relaxed/simple;
	bh=OoZCrcak6gnkvRgb2aPXGG5PzjptNHK/O7HUPMUPIaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqlI0MVFNaUBih1INKDA9L4ITOF0NGzSpUVebJhWrOvcrJgOOOoDl6RVzw/1Oos1t+vpyz1F2mVrH4c4AHQ6qw+sbx6kQl4UxBMJDvDEEfHXi/0ReEco4gzmj1wf5jXkApXEL77uEoItLiHKNMQEmtsIIIAKPb/aitDqey4mUw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=baDOwNaZ; arc=none smtp.client-ip=95.215.58.174
Message-ID: <3d21c10c-3ac5-48eb-9954-ac35c83e1495@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781850256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0WB5NKj40pwLNTx/NSVulZ0Mdm91bCb7Hsm/xNTiXc=;
	b=baDOwNaZ7C3G1K4mUAvB1/Fa9saA67VcATCbJ+L60a/ZmDEq73bTvi6MJkFmYwhTlq2r8v
	NehRtn+QmxZfgfxLY3ScIpX3S29v4pMJ+K8DI8pMFdtlxxkIcW6nrPArRd9JhTxGSjofw8
	I9/a7W8kLGfrVP4+uO7FEU6tnWqIwk0=
Date: Fri, 19 Jun 2026 14:24:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ipv6: ndisc: fix NULL deref in accept_untracked_na()
To: Weiming Shi <bestswngs@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
References: <20260617065512.2529757-2-bestswngs@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260617065512.2529757-2-bestswngs@gmail.com>
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-300608-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,kernel.org,google.com,redhat.com];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E40A36A417B


On 6/17/26 2:55 PM, Weiming Shi wrote:
> accept_untracked_na() re-fetches the inet6_dev with __in6_dev_get(dev)
> and dereferences idev->cnf.accept_untracked_na without a NULL check,
> even though its only caller ndisc_recv_na() already fetched and
> NULL-checked idev for the same device.
>
> Both reads of dev->ip6_ptr run in the same RCU read-side critical
> section, but a concurrent addrconf_ifdown() can clear dev->ip6_ptr
> between them: lowering the MTU below IPV6_MIN_MTU calls addrconf_ifdown()
> without the synchronize_net() that orders the unregister path, so the
> re-fetch returns NULL and oopses:
>
>   BUG: KASAN: null-ptr-deref in ndisc_recv_na (net/ipv6/ndisc.c:974)
>   Read of size 4 at addr 0000000000000364
>   Call Trace:
>    <IRQ>
>    ndisc_recv_na (net/ipv6/ndisc.c:974)
>    icmpv6_rcv (net/ipv6/icmp.c:1193)
>    ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:479)
>    ip6_input_finish (net/ipv6/ip6_input.c:534)
>    ip6_input (net/ipv6/ip6_input.c:545)
>    ip6_mc_input (net/ipv6/ip6_input.c:635)
>    ipv6_rcv (net/ipv6/ip6_input.c:351)
>    </IRQ>
>
> It is reachable by an unprivileged user via a network namespace.
>
> Pass the caller's already validated idev instead of re-fetching it; the
> idev stays alive for the whole RCU critical section, so it is safe even
> after dev->ip6_ptr has been cleared.
>
> Fixes: aaa5f515b16b ("net: ipv6: new accept_untracked_na option to accept na only if in-network")
> Assisted-by: Claude:claude-opus-4-8
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


