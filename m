Return-Path: <netdev+bounces-305406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dpwdMIfXTGrOqgEAu9opvQ
	(envelope-from <netdev+bounces-305406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 12:40:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0C871A815
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 12:40:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=GEk6exm+;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305406-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305406-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E93383020AAE
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 10:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BF63D904D;
	Tue,  7 Jul 2026 10:35:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B143D525F
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 10:35:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420550; cv=none; b=mSCPneA/GkfakO5OzQaZraF9T8mGlS5QxuPYsNp3PWRo9CsRCpHHhgLzxqnHVJ5Mr4noUdKLf6N2CokFZgLbeIYBXuIH8e0XScqiARsCuhYKaDdx7BYN6zIeuU/ftfOo5CB8zsn8lsOUw1vQSoI61UZ5wLiXcRmaRTyoWOZUx7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420550; c=relaxed/simple;
	bh=Kyy6rgLpT6LvNPAqsvSKZfw5BaBz9CJ9yo6aIdQIOJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/+l2/i2/2lcGKHSQWYKhpjC2JzF0AamnqjiK/SnIaUSCSy1oaiSaYZty3UyX/RVzHN9vVFxloTh7OTcQjSVkG78FWhyXgMkQu16aAHlhtPX5RiVTq/b7TQxyXxWI3QqCpo1pXfNBAw/pUjttV0hxHJnn+WcUR/g66vEjzaXF9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GEk6exm+; arc=none smtp.client-ip=95.215.58.180
Message-ID: <9e8f5dfe-d66b-47c9-b7d9-e57ed2aa6fef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783420536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T6vzNQRw4ILr+s7AjoW35AFUGlC7JS9tcgbR1XIH3Yg=;
	b=GEk6exm+kSPpYlc2eiLfoCVzopk8GT4pCSdOf6Xe09+8JQND66fS7khWrDLE1WjhST9Hel
	nxqTPkzjdwlGhzNw3rmAGAQmd2mhulsnYd33G1WHG1ZOhQkhhyBZ8U9L3qUIazYOqrZRtt
	J6uyE7Jb257MP85gfi5GhqPThE3R6u0=
Date: Tue, 7 Jul 2026 11:35:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] bonding: fix devconf_all NULL dereference when IPv6
 is disabled
To: zhangzl2013@126.com, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Qianheng Peng <pengqh1@chinatelecom.cn>,
 Zhaolong Zhang <zhangzl68@chinatelecom.cn>
References: <20260707010622.487333-1-zhangzl2013@126.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260707010622.487333-1-zhangzl2013@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:zhangzl2013@126.com,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:liuhangbin@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pengqh1@chinatelecom.cn,m:zhangzl68@chinatelecom.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305406-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[126.com,jvosburgh.net,lunn.ch,kernel.org];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org,chinatelecom.cn];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B0C871A815

On 07/07/2026 02:06, zhangzl2013@126.com wrote:
> From: Zhaolong Zhang <zhangzl68@chinatelecom.cn>
> 
> When booting with the 'ipv6.disable=1' parameter, the devconf_all is
> never initialized because inet6_init() exits before addrconf_init() is
> called which initializes it. bond_send_validate(), however, will still
> call bond_ns_send_all() even ipv6 is indeed disabled. It will lead to
> NULL derefence of net->ipv6.devconf_all in ip6_pol_route().
> 
>   BUG: kernel NULL pointer dereference, address: 000000000000000c
>   [...]
>   Workqueue: bond0 bond_arp_monitor [bonding]
>   RIP: 0010:ip6_pol_route+0x69/0x480
>   [...]
>   Call Trace:
>    <TASK>
>    ? srso_return_thunk+0x5/0x5f
>    ? __pfx_ip6_pol_route_output+0x10/0x10
>    fib6_rule_lookup+0xfe/0x260
>    ? wakeup_preempt+0x8a/0x90
>    ? srso_return_thunk+0x5/0x5f
>    ? srso_return_thunk+0x5/0x5f
>    ? sched_balance_rq+0x369/0x810
>    ip6_route_output_flags+0xd7/0x170
>    bond_ns_send_all+0xde/0x280 [bonding]
>    bond_ab_arp_probe+0x296/0x320 [bonding]
>    ? srso_return_thunk+0x5/0x5f
>    bond_activebackup_arp_mon+0xb4/0x2c0 [bonding]
>    process_one_work+0x196/0x370
>    worker_thread+0x1af/0x320
>    ? srso_return_thunk+0x5/0x5f
>    ? __pfx_worker_thread+0x10/0x10
>    kthread+0xe3/0x120
>    ? __pfx_kthread+0x10/0x10
>    ret_from_fork+0x199/0x260
>    ? __pfx_kthread+0x10/0x10
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
> 
> Fix this by adding ipv6_mod_enabled() condition check in the caller.
> 
> Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
> Signed-off-by: Qianheng Peng <pengqh1@chinatelecom.cn>
> Signed-off-by: Zhaolong Zhang <zhangzl68@chinatelecom.cn>
> ---
>   drivers/net/bonding/bond_main.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index e044fc733b8c..522eab060f9e 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -3455,7 +3455,8 @@ static void bond_send_validate(struct bonding *bond, struct slave *slave)
>   {
>   	bond_arp_send_all(bond, slave);
>   #if IS_ENABLED(CONFIG_IPV6)
> -	bond_ns_send_all(bond, slave);
> +	if (likely(ipv6_mod_enabled()))
> +		bond_ns_send_all(bond, slave);
>   #endif
>   }
>   

ipv6_mod_enabled() doesn't depend on CONFIG_IPV6, please, remove
#if IS_ENABLED as well



