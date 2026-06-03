Return-Path: <netdev+bounces-294726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /nvpG7YVIGpuvgAAu9opvQ
	(envelope-from <netdev+bounces-294726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 13:53:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4C26373B7
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 13:53:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=C++OtVbj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294726-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294726-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0E883043FDA
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 11:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C1B3AD520;
	Wed,  3 Jun 2026 11:45:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA7146AF02
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 11:45:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487138; cv=none; b=eEbeLx276gV4o5PWkiz85YTHItVxnCWFfW4iWor8ARSJG20W0St50B+0njBBJagBd+PWO4qFbkUNPejBT/HaKUuf9o9EvTRwzKJ7jWDujQplYdbrAM3UlOjkFZQbIdh17bp+5BgXZ6eP6HOYPBqHwHtOIMDTf+k+YTtqKiw04i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487138; c=relaxed/simple;
	bh=1GxrKFudQVwMCsr/oJv4iBqvJYQRpCE0W4FhUIynvj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A5Zaj4i+io/zGUh4wwt3/CXdXdFj94GPeNYQQTZC+jhIv+2JZR0/Qa0eprGCGZdTowiWtMFKw1gT9rzdzv2Cl039oeZ6gNN6k8H8DF6fNFv0PvMXf2SYBZqTRvU3GQpbg/IOCeYhq3Gc3n+TX7Spit5ByhlunAioRNl8aoDqmss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C++OtVbj; arc=none smtp.client-ip=91.218.175.177
Message-ID: <e750f01e-e161-47ec-9527-8a7a0a999f45@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780487133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1GxrKFudQVwMCsr/oJv4iBqvJYQRpCE0W4FhUIynvj4=;
	b=C++OtVbj99YR79j9NxNhoZPl2eAczcpY0Jgza4k/Chd4j3G1m6vkXFEidj6z3Cb+7tE4XP
	fTR3G27zSrhxcRZwMsv4Xc12jyYrXbIxRc/xGcm7TrkuxotnMXYWtp0V890azBhOdN4PKh
	roMbrsgAMxJfkk0gyqNkTiKV2PMAWkk=
Date: Wed, 3 Jun 2026 19:45:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ipv6: mcast: Fix use-after-free when processing MLD
 queries
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, dsahern@kernel.org, leo@depthfirst.com
References: <20260603101811.612594-1-idosch@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260603101811.612594-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294726-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:horms@kernel.org,m:dsahern@kernel.org,m:leo@depthfirst.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,vger.kernel.org:from_smtp,depthfirst.com:email,linux.dev:mid,linux.dev:dkim,linux.dev:from_mime,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D4C26373B7


On 6/3/26 6:18 PM, Ido Schimmel wrote:
> When processing an MLD query, a pointer to the multicast group address
> is retrieved when initially parsing the packet. This pointer is later
> dereferenced without being reloaded despite the fact that the skb header
> might have been reallocated following the pskb_may_pull() calls, leading
> to a use-after-free [1].
>
> Fix by copying the multicast group address when the packet is initially
> parsed.
>
> [1]
> BUG: KASAN: slab-use-after-free in __mld_query_work (net/ipv6/mcast.c:1512)
> Read of size 8 at addr ffff8881154b8e90 by task kworker/4:1/118
>
> Workqueue: mld mld_query_work
> Call Trace:
> <TASK>
> dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
> print_address_description.constprop.0 (mm/kasan/report.c:378)
> print_report (mm/kasan/report.c:482)
> kasan_report (mm/kasan/report.c:595)
> __mld_query_work (net/ipv6/mcast.c:1512)
> mld_query_work (net/ipv6/mcast.c:1563)
> process_one_work (kernel/workqueue.c:3314)
> worker_thread (kernel/workqueue.c:3397 kernel/workqueue.c:3478)
> kthread (kernel/kthread.c:436)
> ret_from_fork (arch/x86/kernel/process.c:158)
> ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
> </TASK>
>
> [...]
>
> Freed by task 118:
> kasan_save_stack (mm/kasan/common.c:57)
> kasan_save_track (mm/kasan/common.c:78)
> kasan_save_free_info (mm/kasan/generic.c:584)
> __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
> kfree (./include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
> pskb_expand_head (net/core/skbuff.c:2335)
> __pskb_pull_tail (net/core/skbuff.c:2878 (discriminator 4))
> __mld_query_work (net/ipv6/mcast.c:1495 (discriminator 1))
> mld_query_work (net/ipv6/mcast.c:1563)
> process_one_work (kernel/workqueue.c:3314)
> worker_thread (kernel/workqueue.c:3397 kernel/workqueue.c:3478)
> kthread (kernel/kthread.c:436)
> ret_from_fork (arch/x86/kernel/process.c:158)
> ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>
> Fixes: 97300b5fdfe2 ("[MCAST] IPv6: Check packet size when process Multicast")
> Reported-by: Leo Lin <leo@depthfirst.com>
> Reviewed-by: David Ahern <dahern@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>



