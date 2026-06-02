Return-Path: <netdev+bounces-293982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOlzH/xFHmomiQkAu9opvQ
	(envelope-from <netdev+bounces-293982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:54:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D42596276EA
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3024830038DF
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA852356772;
	Tue,  2 Jun 2026 02:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ns7gRxrm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE20C2DEA89
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 02:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780368683; cv=none; b=d8TabXvePKsEOQnR4pexz3Uf1gDEW4LsewSTV/dfvqlZypgiASR/ejBkij3Z8PfQum+DZiQHcAgAhinOVEgOON8BTUUiS5anwU1s6XLTxa5MH+PMwT0whpnQQxBXvZDHne/65jgULxjnfIPBChZ6QnUea+YzepQdrX7JjJbMz0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780368683; c=relaxed/simple;
	bh=KHl05+TnRVzLY0HoLjC7pVAik3WLP1//SVbshw5PzP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cw1abzahFRnNFYZIhpocc0IDqAHN6gBaa10MchUdpvgE4oXqTbmR+ddkdccvsWFlZT/isP7rK/ZX4AJi7zjkhYS8Kj6kLc28iXe4YcV9kxRCAEbOk1GW4kDg5FCq43m8ojeT6vfRuAFYbgRJUtQBm1YxYAYM3Fc1UXyqn6BLtew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ns7gRxrm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBD71F00893;
	Tue,  2 Jun 2026 02:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780368682;
	bh=hep6+mzXg0ceuS4JtRCvCPZQ1c7dxXVHngtbuakwjhQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ns7gRxrmbZjsPBmEm+EMBISIq31T9wl8yCu7BzcJPc05HV1c5z1ozck9sJIGMC+t4
	 KHQRSPUDwyVJslNC5IQFk23Y2265YCL9zahr7M5jR3Lxw0OWVsudp6ew2SOjjmu9JC
	 DkKNWN1nF4+LFOaJ8SspWxp/ZedfM4QOzvPURd6WoiuXgBmJGJyM7hOhxmEp5tWteK
	 +JcAyjIyCQ2Ugz2bj31b6am11U1SlucEHvp5RjoC49D1cVpUCvyjU2Xgps9X+PJ+SW
	 bsMV7zR4Gkt13nyghidFoKqWS2kfeGOmV68YAuWhc5qlmpSDHJsJwwHWUffmd/Rb+A
	 kWQwRMZ4cl5DA==
Message-ID: <d6bf3a67-3629-42ce-b2b3-74482c46fe01@kernel.org>
Date: Mon, 1 Jun 2026 20:51:21 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] ipv6: Honor oif when choosing nexthop for
 locally generated traffic
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, willemb@google.com
References: <20260601065300.267960-1-idosch@nvidia.com>
 <20260601065300.267960-2-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260601065300.267960-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293982-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: D42596276EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 6/1/26 12:52 AM, Ido Schimmel wrote:
> Commit 741a11d9e410 ("net: ipv6: Add RT6_LOOKUP_F_IFACE flag if oif is
> set") made the kernel honor the oif parameter when specified as part of
> output route lookup:
> 
>  # ip route add 2001:db8:1::/64 dev dummy1
>  # ip route add ::/0 dev dummy2
>  # ip route get 2001:db8:1::1 oif dummy2 fibmatch
>  default dev dummy2 metric 1024 pref medium
> 
> Due to regression reports, the behavior was partially reverted in commit
> d46a9d678e4c ("net: ipv6: Dont add RT6_LOOKUP_F_IFACE flag if saddr
> set") to only honor the oif if source address is not specified:
> 
>  # ip route get 2001:db8:1::1 from 2001:db8:2::1 oif dummy2 fibmatch
>  2001:db8:1::/64 dev dummy1 metric 1024 pref medium
> 
> That is, when source address is specified, the kernel will choose the
> most specific route even if its nexthop device does not match the
> specified oif.
> 
> This creates a problem for multipath routes. After looking up a route,
> when source address is not specified, the kernel will choose a nexthop
> whose nexthop device matches the specified oif:
> 
>  # sysctl -wq net.ipv6.conf.all.forwarding=1
>  # ip route add 2001:db8:10::/64 nexthop via fe80::1 dev dummy1 nexthop via fe80::2 dev dummy2
>  # for i in {1..100}; do ip route get 2001:db8:10::${i} oif dummy2; done | grep -o dummy[0-9] | sort | uniq -c
>       100 dummy2
> 
> But will disregard the oif when source address is specified despite the
> fact that a matching nexthop exists:
> 
>  # for i in {1..100}; do ip route get 2001:db8:10::${i} from 2001:db8:2::1 oif dummy2; done | grep -o dummy[0-9] | sort | uniq -c
>       53 dummy1
>       47 dummy2
> 
> This behavior differs from IPv4:
> 
>  # ip address add 192.0.2.1/32 dev lo
>  # ip route add 198.51.100.0/24 nexthop via inet6 fe80::1 dev dummy1 nexthop via inet6 fe80::2 dev dummy2
>  # for i in {1..100}; do ip route get 198.51.100.${i} from 192.0.2.1 oif dummy2; done | grep -o dummy[0-9] | sort | uniq -c
>      100 dummy2
> 
> What happens is that fib6_table_lookup() returns a route with a matching
> nexthop device (assuming it exists):
> 
>  # perf record -e fib6:fib6_table_lookup -- bash -c "for i in {1..100}; do ip route get 2001:db8:10::${i} from 2001:db8:2::1 oif dummy2; done > /dev/null"
>  # perf script | grep -o dummy[0-9] | sort | uniq -c
>       100 dummy2
> 
> But it is later overwritten during path selection in fib6_select_path()
> which instead chooses a nexthop according to the calculated hash.
> 
> Solve this by telling fib6_select_path() to skip path selection if we
> have an oif match during output route lookup (iif being
> LOOPBACK_IFINDEX).
> 
> Behavior after the change:
> 
>  # sysctl -wq net.ipv6.conf.all.forwarding=1
>  # ip route add 2001:db8:10::/64 nexthop via fe80::1 dev dummy1 nexthop via fe80::2 dev dummy2
>  # for i in {1..100}; do ip route get 2001:db8:10::${i} from 2001:db8:2::1 oif dummy2; done | grep -o dummy[0-9] | sort | uniq -c
>      100 dummy2
> 
> Note that enabling forwarding is only needed because we did not add
> neighbor entries for the gateway addresses. When forwarding is disabled
> and CONFIG_IPV6_ROUTER_PREF is not enabled in kernel config, the kernel
> will treat non-existing neighbor entries as errors and perform
> round-robin between the nexthops:
> 
>  # sysctl -wq net.ipv6.conf.all.forwarding=0
>  # for i in {1..100}; do ip route get 2001:db8:10::${i} from 2001:db8:2::1 oif dummy2; done | grep -o dummy[0-9] | sort | uniq -c
>       50 dummy1
>       50 dummy2
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv6/route.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



