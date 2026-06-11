Return-Path: <netdev+bounces-298102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VU0jGLygKmq6twMAu9opvQ
	(envelope-from <netdev+bounces-298102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:49:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F7767185A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:49:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=RORblfg7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298102-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298102-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38513329D660
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F6E3AE1A3;
	Thu, 11 Jun 2026 11:48:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD36F38C40E
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:48:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178489; cv=none; b=Y10Q7/Piy+kPdn84Ml7e7xv6FzxWADvH03UCybN5QQTiRnqOakuvG6SfxYillAW5MEEVWhx1TKBOqVc/d7k6uj9OqNv7sYoUVOKoq/geNkJuhH7npPcD50iDoD7Y97+HK4PBhcAPR/bAiiVzTTkXezQxOTP2+sO0rz4oLUudkf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178489; c=relaxed/simple;
	bh=XoJJqz/Vzlhe5uQ13vjg3VCYz0+nnya2oNA5rEu2MFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EyMrvMThX5Afpp/BAZ89ibduaVe88fDweSCq85pb5eleKrOYeJk4z2cB/IR5LY+U+5YpNF7kdSoHWmNsoy3tcYzO99dEVk/E/pwvl1bWHaOZ+gsMBg8s5sDke+rjcz8WX6FiSaefTxg7uOCF1oYXUAfpxgmiR76E58uL44aafsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RORblfg7; arc=none smtp.client-ip=95.215.58.177
Message-ID: <ee8eb9dc-3692-44eb-b807-3699201ddc49@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781178475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KQnWBNAsCzAJ3HZFLh8gKD/BTcTn+ZltOUCQYwic1XA=;
	b=RORblfg7meoiuNtp/4rapSWxIbyQ3GSD56k+VHAHqBL8MYQlHZlZ8AwsPmqEN/U1lUg5xC
	2TkMpkl7U1+iTVWyuEPZSZNb6SJAm00yHNu1vXY1DlG/NXb3xMs4wKQHraPF7QMXm8y1S3
	pxg1RJ3/urOmVLrfdS3obkRRcKbX5Hs=
Date: Thu, 11 Jun 2026 19:47:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3] tcp: clear sock_ops cb flags before force-closing
 a child socket
To: Sechang Lim <rhkrqnwk98@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>,
 Lawrence Brakmo <brakmo@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260611092923.1895982-1-rhkrqnwk98@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260611092923.1895982-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:edumazet@google.com,m:ncardwell@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:kuniyu@google.com,m:horms@kernel.org,m:brakmo@fb.com,m:ast@kernel.org,m:jiayuan.chen@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,google.com,davemloft.net,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298102-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3F7767185A


On 6/11/26 5:29 PM, Sechang Lim wrote:
> A child socket inherits the listener's bpf_sock_ops_cb_flags via
> sk_clone_lock(). If its setup fails in tcp_v4_syn_recv_sock() /
> tcp_v6_syn_recv_sock(), the child is freed through put_and_exit, where
> inet_csk_prepare_forced_close() drops the socket lock and tcp_done() runs
> without it.
>
> If BPF_SOCK_OPS_STATE_CB_FLAG was inherited, tcp_done() -> tcp_set_state()
> calls tcp_call_bpf(), which expects the lock and trips sock_owned_by_me():
>
>    WARNING: include/net/sock.h:1799 at tcp_set_state+0x433/0x550
>    RIP: 0010:tcp_set_state+0x433/0x550 include/net/sock.h:1799
>    Call Trace:
>     <IRQ>
>     tcp_done+0xba/0x250 net/ipv4/tcp.c:5095
>     tcp_v4_syn_recv_sock+0x850/0xa50 net/ipv4/tcp_ipv4.c:1787
>     tcp_check_req+0xf30/0x1360 net/ipv4/tcp_minisocks.c:926
>     tcp_v4_rcv+0x1047/0x1b50 net/ipv4/tcp_ipv4.c:2164
>     </IRQ>
>
> The child is freed before it is ever established, so it should run no
> sock_ops callback. Clear its cb flags in inet_csk_prepare_for_destroy_sock(),
> the common point for the IPv4, IPv6 and chtls forced-close paths and for the
> MPTCP ->syn_recv_sock() failure path (dispose_child), which reaches tcp_done()
> on a child that was never established too.
>
> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Fixes: d44874910a26 ("bpf: Add BPF_SOCK_OPS_STATE_CB")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>



