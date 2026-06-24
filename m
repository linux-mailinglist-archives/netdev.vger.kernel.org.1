Return-Path: <netdev+bounces-301523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ncpuBKM0O2quSggAu9opvQ
	(envelope-from <netdev+bounces-301523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 03:36:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A018A6BACE2
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 03:36:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=XeGxuCQ8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301523-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301523-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1CD6930267A7
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 01:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EC2256C8B;
	Wed, 24 Jun 2026 01:36:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A3022A80D
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 01:36:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782264992; cv=none; b=C57md/UknvF3ORkuJ/HGiy3ZLhp9oLO/3n+2EzrRROfTAquqpqHRn2sGzPhr7h4bH7CsvuVSGF5c1I1MXJnu4kYU7WdGrGvrmfKHtiZ72PMvoeFgCt/aEM+5z9fEFDd92FIrmJ2xxlVSUSf1KLmzufCiWq6+3KiB4HDsMSwk9dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782264992; c=relaxed/simple;
	bh=KnvIe/6h4mSuOk3n1VB0XXJmDIZJDvKAcuC47OaLoDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CpWmtLFyJpW+OOtbYXGyinMwfqKyZxxxSkDdz7Gsem/nkDrXfR3QABHiW7LwWVxKJesdW9148saIWBWUSVgsxbAG3BhjN6NQ7UYoBU9fV/aJCs0mZqtKFl3luqsiVr0/0zBpRuQR/+tgY4icnRQWUJS2mWoE7D2oImekUkRU6Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XeGxuCQ8; arc=none smtp.client-ip=91.218.175.188
Message-ID: <73c05543-f6d6-4df2-9a32-8ee30343a670@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782264989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mQ383rsH80JLkIrPgbME6Yh35rwqkpod5OXpoJUyEWs=;
	b=XeGxuCQ8QJuQO5wU9io6bNXNxpJIh+XYA0LfZ2zQoFem4dH3rK+i7ezLIZaZm6ijeTnEvv
	9F9BTcls54kU2XYgVx9q4Keq1ZGDFgmBLwKAjORALF1hQ8nlJBPaT40ErxnFcolGTkyaIk
	o5z4hWmN7txErnZ8BcpkpLEpZRPcHVU=
Date: Wed, 24 Jun 2026 09:36:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf, sockmap: Don't leak UDP socks on
 lookup-bind-release
To: Michal Luczaj <mhal@rbox.co>, John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Cong Wang <cong.wang@bytedance.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co>
 <20260623-sockmap-lookup-udp-leak-v1-1-05804f9308e4@rbox.co>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260623-sockmap-lookup-udp-leak-v1-1-05804f9308e4@rbox.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mhal@rbox.co,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301523-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[rbox.co,gmail.com,cloudflare.com,linux.dev,davemloft.net,google.com,kernel.org,redhat.com,bytedance.com,iogearbox.net,etsalapatis.com];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,rbox.co:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A018A6BACE2


On 6/24/26 2:03 AM, Michal Luczaj wrote:
> UDP sockets get SOCK_RCU_FREE set when (auto-)bound. This means
> sk_is_refcounted(unbound) = true, while sk_is_refcounted(bound) = false.
>
> Because sockmap accepts unbound UDP sockets, a BPF program can increment a
> socket's refcount via lookup. If the socket is subsequently bound, the
> transition from unbound to bound causes bpf_sk_release() to skip the
> decrement of the refcount, causing a memory leak.
>
> unreferenced object 0xffff88810bc2eb40 (size 1984):
>    comm "test_progs", pid 2451, jiffies 4295320596
>    hex dump (first 32 bytes):
>      7f 00 00 01 7f 00 00 01 d2 04 1b b7 04 d2 00 00  ................
>      02 00 01 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
>    backtrace (crc bdee079d):
>      kmem_cache_alloc_noprof+0x557/0x660
>      sk_prot_alloc+0x69/0x240
>      sk_alloc+0x30/0x460
>      inet_create+0x2ce/0xf80
>      __sock_create+0x25b/0x5c0
>      __sys_socket+0x119/0x1d0
>      __x64_sys_socket+0x72/0xd0
>      do_syscall_64+0xa1/0x5f0
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Maintain balanced refcounts across sk lookup/release: (re-)set
> SOCK_RCU_FREE on proto update to treat the socket (whether bound or
> unbound) as not requiring a refcount increment on (a RCU protected) lookup.
>
> Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


