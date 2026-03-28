Return-Path: <netdev+bounces-272766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FVNHF2i6x2mfbQUAu9opvQ
	(envelope-from <netdev+bounces-272766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 12:24:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB8C34E2B7
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 12:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A8AC3022042
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 11:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39132E282B;
	Sat, 28 Mar 2026 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZK8fLAS/"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC6813DBA0;
	Sat, 28 Mar 2026 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774697058; cv=none; b=CXzKkExJ3kfg7KPFcrtNZWQyrdOQIQUYYIodj3vgQjbZ0yrE9B71MFlkkma1uobmRs4QCy8OCT03KNFAQSSH3tuWr1tNEov95axi+Sd2msJTQCND3bdS4eNEQCSIF64dRILwLNJ84xzxciJe5XpkOvUGHC1v274kPr8wVGr669Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774697058; c=relaxed/simple;
	bh=/RTUSRBEQO1I15pjsE+WveuZ5SBVnLu3/PT13TFmDF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTnIRubZovud82GM1/Bl6uBf9Lq9cI3c3N/IX5iQDssRUZM3ao5EnnI1VkXYpiH+ma4ZbJjG2j8ElSWI782TXZybjYx+xIIRslfkmW1KXqaZHKS834wzsOg+nd18HywIDrvrbQp9vZXZUugIrlkYL2qoSkGfoorQ3CqzBFy9OPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZK8fLAS/; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=4Iy2uWD6EdTkX0LR5V/PYn9bkVMswz2dyqbJDDHTxhQ=;
	b=ZK8fLAS/D3WCTVy6B8EE9CWRDMCYrNgr4hFxi9X0rq0CKn297Ij1Z/a+BoLyBx
	H/2Ly8tR9Wh28Q86nzjGOKKwNayf0WblSjffMK2R+6crHMuK+FGw9YYh4DdRQdCe
	PcrPvUuHM9o+2vCG5sBflajTXH4ZANy+9XvsEG+vjXwUE=
Received: from [10.54.26.11] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBXQ_MIusdpOpRiTA--.6241S2;
	Sat, 28 Mar 2026 19:22:50 +0800 (CST)
Message-ID: <7e8c45cb-b5dd-4694-80e9-7c8e5ad9ade7@163.com>
Date: Sat, 28 Mar 2026 19:22:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipv6: fix data race in fib6_metric_set() using
 cmpxchg
To: Hangbin Liu <liuhangbin@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fei Liu <feliu@redhat.com>
References: <20260327-b4-fib6_metric_set-kmemleak-v2-1-366b2c78b5c2@gmail.com>
From: Jiayuan Chen <mrpre@163.com>
In-Reply-To: <20260327-b4-fib6_metric_set-kmemleak-v2-1-366b2c78b5c2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBXQ_MIusdpOpRiTA--.6241S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr4UXw1xZrWUJFyxKFyUKFg_yoW5GFWrpF
	Z3G39rtanrtrW3uw1kC3Z7XFykJw4xAFy3GrWSywnI9Fy5Gw1aqayrK3y2gry5Ar4fX34a
	9F4qy34DZFyqqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UxnYwUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbC6wv8pGnHugsUwAAA3z
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,kernel.org,google.com,redhat.com,linux.dev];
	FREEMAIL_FROM(0.00)[163.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-272766-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[163.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrpre@163.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CB8C34E2B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/27/26 10:24 AM, Hangbin Liu wrote:
> fib6_metric_set() may be called concurrently from softirq context without
> holding the FIB table lock. A typical path is:
>
>    ndisc_router_discovery()
>      spin_unlock_bh(&table->tb6_lock)        <- lock released
>      fib6_metric_set(rt, RTAX_HOPLIMIT, ...) <- lockless call
>
> When two CPUs process Router Advertisement packets for the same router
> simultaneously, they can both arrive at fib6_metric_set() with the same
> fib6_info pointer whose fib6_metrics still points to dst_default_metrics.
>
>    if (f6i->fib6_metrics == &dst_default_metrics) {   /* both CPUs: true */
>        struct dst_metrics *p = kzalloc_obj(*p, GFP_ATOMIC);
>        refcount_set(&p->refcnt, 1);
>        f6i->fib6_metrics = p;   /* CPU1 overwrites CPU0's p -> p0 leaked */
>    }
>
> The dst_metrics allocated by the losing CPU has refcnt=1 but no pointer
> to it anywhere in memory, producing a kmemleak report:
>
>    unreferenced object 0xff1100025aca1400 (size 96):
>      comm "softirq", pid 0, jiffies 4299271239
>      backtrace:
>        kmalloc_trace+0x28a/0x380
>        fib6_metric_set+0xcd/0x180
>        ndisc_router_discovery+0x12dc/0x24b0
>        icmpv6_rcv+0xc16/0x1360
>
> Fix this by:
>   - Set val for p->metrics before published via cmpxchg() so the metrics
>     value is ready before the pointer becomes visible to other CPUs.
>   - Replace the plain pointer store with cmpxchg() and free the allocation
>     safely when competition failed.
>   - Add READ_ONCE()/WRITE_ONCE() for metrics[] setting in the non-default
>     metrics path to prevent compiler-based data races.
>
> Fixes: d4ead6b34b67 ("net/ipv6: move metrics from dst to rt6_info")
> Reported-by: Fei Liu <feliu@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

https://sashiko.dev/#/patchset/20260327-b4-fib6_metric_set-kmemleak-v2-1-366b2c78b5c2%40gmail.com


The concern about reader paths (e.g., ip_dst_init_metrics, fib6_pmtu) 
lacking READ_ONCE()
annotations is valid — if the compiler reloads from->fib6_metrics after 
inlining, it could produce
an inconsistent pointer/flags combination in dst->_metrics, potentially 
leading to a refcount_dec
on the read-only dst_default_metrics.

However, this is a pre-existing issue that exists before this patch.
The plain store f6i->fib6_metrics = p in the original code has the same 
read-side race.
This patch focuses on fixing the writer-side data race that causes 
kmemleak, and it
does so correctly.

BTW, please consider moving the declaration of m to the top of the 
function if you have a next version



