Return-Path: <netdev+bounces-299800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BzkOLHokMWo3cgUAu9opvQ
	(envelope-from <netdev+bounces-299800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:24:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 462EE68E359
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:24:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=kCo5nJTh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299800-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299800-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC50A3172D0E
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 10:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B45E3B71B0;
	Tue, 16 Jun 2026 10:18:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D94D35504D
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 10:18:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605086; cv=none; b=QUueivOmATlv4ishIJEAgydsmilLMzWIvvxD8ADcOOpQqfe5b5v/A9T3e2XHooxwTXUAoAFtNfmSzQXBdPUIf7vyMq543Qtpw1MaEj7zOj0zu+axFLPMEBuCdGzTvMMTXMEXjnyiGMr1WeZEEz/JEvI2+MCCJ8a6kZjkD8zymjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605086; c=relaxed/simple;
	bh=3QBXNRR+lpk/cTHgy6WA5onJYnTv+CN3GKz98njmQr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AxzOXgpc5v+NCr3t2jaedfa4i8T1OJuruGPnd77PgQ7pD+3Bl2nDqc2iDKP1qAXBI1iRZ1IdyFrJ1uJ4SG0mpbXVfGpIFKH1ukzcaA5/97hllK+zTh50y6wiJ7kfKBWj01epSzPfAMaM8+h7sM6eNOpGL7iB+NmRG5WN7VKSRTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kCo5nJTh; arc=none smtp.client-ip=95.215.58.172
Message-ID: <575a878e-6d37-4337-a821-4883d3dd3a63@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781605081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//o9T+LjbxLcDoBTIq4I5DoHUWaRbI9D0OLgPAgmSYE=;
	b=kCo5nJTh/ptmf2R66/yT4SEqUf6cTJ5CThld/XxO9GFHiDUCVR/PVQnZBN41M45Q3n9CRM
	YQNqdpmQWWufWb7JEhP6TgsAUs8NznrRrF+7nCr3T2p0hoqiJe9wPmee8UXFiJcfHSJii1
	XmHggHbRWvHMGUZXiTVJMys1LDpgte4=
Date: Tue, 16 Jun 2026 18:17:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, sockmap: fix lock inversion between stab->lock
 and sk_callback_lock
To: Sechang Lim <rhkrqnwk98@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260616091153.2966617-1-rhkrqnwk98@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260616091153.2966617-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-299800-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 462EE68E359


On 6/16/26 5:11 PM, Sechang Lim wrote:
> sock_map_update_common() and __sock_map_delete() hold stab->lock and call
> sock_map_unref() -> sock_map_del_link() under it. sock_map_del_link() takes
> sk_callback_lock for write to stop the strparser and verdict, giving the
> lock order stab->lock -> sk_callback_lock.
>
> The opposite order comes from an SK_SKB stream parser. On RX,
> sk_psock_strp_data_ready() holds sk_callback_lock for read while running
> the parser. The verdict redirects the skb to egress, where a sched_cls


The commit message is wrong. A verdict does not redirect to egress
synchronously — sk_psock_skb_redirect() only queues the skb and
schedule_delayed_work()s sk_psock_backlog, so egress runs in workqueue
context, not under sk_callback_lock.


> program calls bpf_map_delete_elem() on a sockmap, which takes stab->lock:
>
>    WARNING: possible circular locking dependency detected
>    7.1.0-rc6 Not tainted
>    ------------------------------------------------------
>    syz.9.8824 is trying to acquire lock:
>    (&stab->lock){+.-.}-{3:3}, at: __sock_map_delete net/core/sock_map.c:421
>    but task is already holding lock:
>    (clock-AF_INET){++.-}-{3:3}, at: sk_psock_strp_data_ready net/core/skmsg.c:1173
>
>    -> #1 (clock-AF_INET){++.-}-{3:3}:
>           _raw_write_lock_bh
>           sock_map_del_link net/core/sock_map.c:167
>           sock_map_unref net/core/sock_map.c:184
>           sock_map_update_common net/core/sock_map.c:509
>           sock_map_update_elem_sys net/core/sock_map.c:588
>           map_update_elem kernel/bpf/syscall.c:1805
>
>    -> #0 (&stab->lock){+.-.}-{3:3}:
>           _raw_spin_lock_bh
>           __sock_map_delete net/core/sock_map.c:421
>           sock_map_delete_elem net/core/sock_map.c:452
>           bpf_prog_06044d24140080b6
>           tcx_run net/core/dev.c:4451
>           sch_handle_egress net/core/dev.c:4541
>           __dev_queue_xmit net/core/dev.c:4808
>           ...
>           tcp_bpf_strp_read_sock net/ipv4/tcp_bpf.c:701


I guess it is an ACK. What is the actual purpose of a sched_cls program 
calling

sockmap delete on the TX path of an ACK? If there is no real use case 
for it, this is

just broken BPF usage, not a kernel bug worth this change.



