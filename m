Return-Path: <netdev+bounces-300343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gnr+Jq6kM2psEgYAu9opvQ
	(envelope-from <netdev+bounces-300343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:56:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 389D069E421
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:56:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Ds97PlqO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300343-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300343-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABFC7302161C
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 07:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E903B6BF4;
	Thu, 18 Jun 2026 07:53:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4257E3BBFCF
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 07:53:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769226; cv=none; b=JNPbrTaU3qKZUff55kqtgaI3QkhZ5AriLhcaHloCj4PNbs59DLZam9n+MWHzG3QzIGGZJVpw1C92MWXseBxZ3BWQhyltvAzgCu/QhND3+GLoDfu/sBkrhNXa7ChUd4uyKRLCjYEnx8syorvXzUv+7/YKG1H6mq2GaXds0SciHT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769226; c=relaxed/simple;
	bh=4Vq75HnajPwjZT+E5ilkdim8fezO3/kV2H48M9+bCAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4ekrxEFGHJ3l2wjPsg94EDGRNk3McbytVxHPTDTFz1cSQKPmr/ckMkpubDx/+8SbuU9pNxV2cJ2+BwRdxuwJ1ch78VRo03DvPk/XcSNm8VKEtPRi+pyVx0+Qb+wAqgocMaS78v2IJ8n2oKejlcGavR6yLq+2LDw4pDXcWHSNxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ds97PlqO; arc=none smtp.client-ip=91.218.175.186
Message-ID: <7a0b9050-2f46-4beb-85e3-2361dcf57068@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781769212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HaUWfID3UMJ27+hUZRVu3hLTs/JiBXlp4fSXsq2lxz4=;
	b=Ds97PlqORj3GIFXKFcfCjghuRnP20n1v9sjJqXWzEbej0TSkzYJsQcY7LGzZHrpyZS6Xqw
	4+OmlpyG7pvOoWAE4uM08aE/SVToEiubVXRfgpuPOzlfeRpwLXJhUBgINLlMWMRVLr0LrN
	lYBYmeg9R+qnK03xl76ewHKd15k1e5g=
Date: Thu, 18 Jun 2026 15:53:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [BUG REPORT] KCSAN: data-race in __ip6_datagram_connect /
 udpv6_sendmsg
To: xietangxin <xietangxin@yeah.net>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, kuniyu@google.com, willemb@google.com,
 linux-kernel@vger.kernel.org
References: <c953e09f-9bd5-43c8-b2e4-7305bb435229@yeah.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <c953e09f-9bd5-43c8-b2e4-7305bb435229@yeah.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-300343-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[yeah.net,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:xietangxin@yeah.net,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:willemb@google.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,syzkaller.appspot.com:url,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 389D069E421


On 6/18/26 3:28 PM, xietangxin wrote:
> Hi all,
>
> We detected a data-race with syzkaller on master branch (commit 95e56f0f293e).
>
> The data-race occurs on `sk->sk_v6_daddr`. When a UDP socket is already in
> the ESTABLISHED state, calling sendmsg() with read `sk->sk_v6_daddr`.
> Concurrently, another thread call connect() on the same UDP socket to update
> the remote address, which writes to `sk->sk_v6_daddr`.
>
> Should we implement READ_ONCE/WRITE_ONCE helpers for `sk->sk_v6_daddr`
> to prevent torn reads? Or acquire the socket lock inside udpv6_sendmsg()
> to serialize with connect()?
>
> # KCSAN Report
> BUG: KCSAN: data-race in __ip6_datagram_connect / udpv6_sendmsg
> read to 0xffff0000084dbc38 of 8 bytes by task 16916 on cpu 2:
>   udpv6_sendmsg+0x1264/0x1a20 (/include/net/ipv6.h:593 net/ipv6/udp.c:1579)
>   inet6_sendmsg+0x80/0xc0
>   __sock_sendmsg+0xb0/0x138
>   ____sys_sendmsg+0x41c/0x4f8
>   ___sys_sendmsg+0xcc/0x150
>   __sys_sendmsg+0xe8/0x190
>   __arm64_sys_sendmsg+0x58/0x78
>   invoke_syscall+0x84/0x218
>   el0_svc_common.constprop.0+0x1a4/0x1f8
>   do_el0_svc+0x3c/0x58
>   el0_svc+0x38/0x100
>   el0t_64_sync_handler+0xa0/0xe8
>   el0t_64_sync+0x190/0x198
>
> write to 0xffff0000084dbc38 of 16 bytes by task 16901 on cpu 1:
>   __ip6_datagram_connect+0x348/0x888 (/net/ipv6/datagram.c:247)
>   udpv6_connect+0x48/0x178
>   inet_dgram_connect+0xe0/0x1e0
>   __sys_connect_file+0xd4/0x128
>   __sys_connect+0xf0/0x130
>   __arm64_sys_connect+0x54/0x78
>   invoke_syscall+0x84/0x218
>   el0_svc_common.constprop.0+0x1a4/0x1f8
>   do_el0_svc+0x3c/0x58
>   el0_svc+0x38/0x100
>   el0t_64_sync_handler+0xa0/0xe8
>   el0t_64_sync+0x190/0x198
>
> # Syzkaller Reproducer
> r0 = bpf$PROG_LOAD(0x5, &(0x7f00000001c0)={0x6, 0x4, &(0x7f0000000100)=ANY=[@ANYBLOB="18000000000000000000000000000000070000000200000095"], &(0x7f0000000040)='GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x9, '\x00', 0x0, @xdp=0x25, 0xffffffffffffffff, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x3}, 0x94)
> bpf$BPF_PROG_TEST_RUN(0xa, &(0x7f00000002c0)={r0, 0x0, 0xe, 0x0, &(0x7f00000005c0)="d9d96e34a80e31f03a049a9e0000", 0x0, 0xb4, 0x0, 0x0, 0x0, 0x0, 0x0, 0x2, 0x0, 0x39}, 0x50) (async, rerun: 32)
> r1 = socket$inet6(0xa, 0x2, 0x0) (rerun: 32)
> connect$inet6(r1, &(0x7f0000000040)={0xa, 0x4e23, 0x100200a, @loopback, 0x7f}, 0x1c) (async, rerun: 32)
> sendmsg$inet6(r1, &(0x7f00000002c0)={&(0x7f0000000140)={0xa, 0x4e22, 0x4, @remote, 0x2}, 0x1c, 0x0}, 0x4000001) (rerun: 32)


Already exist in syzbot with 11 similar reports.

https://syzkaller.appspot.com/bug?id=e3ef1f59aa88bf20425f0726337b0f6931416ff8

maybe data_race annotation should be used.


