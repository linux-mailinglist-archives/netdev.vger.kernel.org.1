Return-Path: <netdev+bounces-278109-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHR4IH0D3Wk3YwkAu9opvQ
	(envelope-from <netdev+bounces-278109-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:53:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AE53ED96A
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF648301953F
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB0D3E0239;
	Mon, 13 Apr 2026 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQycd2Y3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079CD3E0222;
	Mon, 13 Apr 2026 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091600; cv=none; b=oI3Fx3CgnnAipF5XTt7BupM/9EyrP0SpbOF/JUHDCucq79RO2mf0dG4/ywQDOoFK5alMUbVyliEpkUUgdnJmq5Li9hB+6MD9vRACiynF/uYkPa16oF9rmZy5LzeqAApNywuoxJ1PerLlXdqEjuNd3WJipTruwqDj0dMPG19C48U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091600; c=relaxed/simple;
	bh=bhACCNWwYGbbsioUZ9lwrnNsFznu/fKcqluHk8miblo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUSH1vLUhznlBS0iReXz2dTqBFjdOXPiw8tLmrJg1XEH0cow18umecsy5ImyO0P9B8jN84dnXl3DykDdYbZfplrCKs2ZJ1XCYHx9dUYsp8hbYLnAUiWR62bcBskHiyONg5+7fhoqpf+FHv2cetVXHVtwQWo8gNT8kpyLEr8wLRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQycd2Y3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E351C2BCAF;
	Mon, 13 Apr 2026 14:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776091599;
	bh=bhACCNWwYGbbsioUZ9lwrnNsFznu/fKcqluHk8miblo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IQycd2Y3MOzE++hOSt40w85Jk5ozySGjdZeYUcuPg2afcoGAftYeQ3QsqHKr7jZi+
	 V6l/EOLDK/DIUXhTtAGniEckjBQUOASnfRHTCuoKHJ0V9LsfzWNhGly5ax+yfM6St4
	 7EY/Xz8XOd5ABoNq+GY5/1U0RpvA3ELODwj0Wj+b94O27e2yFRHaOVFnfEP0KCHaYn
	 zpUiehOGzBHFUXvkHKcIDluzDJMUtnMyCc2+mQZOTcOkvGSPn/L5EqiFZ0Bd4R1cfq
	 QwMhhAbuF5hhwrID9wfWs8YvCk1pKkTHGL3TwI1C5LZ71bYY82iUjC0n4YG3WV+W8u
	 X/5wDSDkJv5Yg==
Message-ID: <88046eb3-603c-4296-9a9f-616a6f37c610@kernel.org>
Date: Mon, 13 Apr 2026 08:46:38 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/2] nexthop: fix IPv6 route referencing IPv4
 nexthop
Content-Language: en-US
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260413114522.147784-1-jiayuan.chen@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260413114522.147784-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278109-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,linux.dev:email]
X-Rspamd-Queue-Id: D1AE53ED96A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 5:45 AM, Jiayuan Chen wrote:
> syzbot reported a panic [1] [2].
> 
> When an IPv6 nexthop is replaced with an IPv4 nexthop, the has_v4 flag
> of all groups containing this nexthop is not updated. This is because
> nh_group_v4_update is only called when replacing AF_INET to AF_INET6,
> but the reverse direction (AF_INET6 to AF_INET) is missed.
> 
> This allows a stale has_v4=false to bypass fib6_check_nexthop, causing
> IPv6 routes to be attached to groups that effectively contain only AF_INET
> members. Subsequent route lookups then call nexthop_fib6_nh() which
> returns NULL for the AF_INET member, leading to a NULL pointer
> dereference.
> 
> Fix by calling nh_group_v4_update whenever the family changes, not just
> AF_INET to AF_INET6.
> 
> Reproducer:
> 	# AF_INET6 blackhole
> 	ip -6 nexthop add id 1 blackhole
> 	# group with has_v4=false
> 	ip nexthop add id 100 group 1
> 	# replace with AF_INET (no -6), has_v4 stays false
> 	ip nexthop replace id 1 blackhole
> 	# pass stale has_v4 check
> 	ip -6 route add 2001:db8::/64 nhid 100
> 	# panic
> 	ping -6 2001:db8::1
> 
> [1] https://syzkaller.appspot.com/bug?id=e17283eb2f8dcf3dd9b47fe6f67a95f71faadad0
> [2] https://syzkaller.appspot.com/bug?id=8699b6ae54c9f35837d925686208402949e12ef3
> Fixes: 7bf4796dd099 ("nexthops: add support for replace")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/ipv4/nexthop.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>


