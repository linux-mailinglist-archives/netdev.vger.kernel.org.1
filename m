Return-Path: <netdev+bounces-180017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13EFA7F1F3
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 03:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C521791F2
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 01:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2282158545;
	Tue,  8 Apr 2025 01:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vBze/HkM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86178BE7;
	Tue,  8 Apr 2025 01:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744074123; cv=none; b=Ewg+AG+iDbjAvMXQSHFfLN5iWQK0AsEbqoUMD7cY96sop4wXEyC8eD38V1pKj30m0sEEQs2aRDYzjWzFayktjzeElLMXakA++7E6hBAs3WYjvjmzaugbw76Q5Pea2qIVu7+mQ0npcionfjL9HUjQLtNzX9jZ3AWOvMungslQXAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744074123; c=relaxed/simple;
	bh=xthHPC7SRWEOtbq9bg+gsGajUW9yHOxjdMU7Vtz7yJM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRW2C4pgNY0Cg15lulTImYz0xo0p/+zNq8fzReesJV3dUPhsMDzdGIz+IN5DOLRu1uFwpzafRIxZXBhHspjQNBywxgHEuHyD4DkwRA7MCaD6ufLg3jcbTsB8iTJ+3pbOp2I89AmWAzu6+rBVWELhfaUCUP1NPxwbVIPca1hTHaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vBze/HkM; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744074122; x=1775610122;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Q70fFtFs3+YdS6ursyNJrgOZLIsKzA94oTFp4aZASk=;
  b=vBze/HkMi7tOtU7s2iTw5fCbKDnF32qgyZ5Z9luSRs0vDH81iZJkggks
   6wAKoc59r6DfgfxOZ9GfYjTO0Pj5UVStPq1dsLeqFqlH1RT1zEa8jQO6O
   oDJkH2Ct1g+U5z+k1oG1217OcliYzkuV3KYds6yywEYMAqJqeC1vPU5SE
   E=;
X-IronPort-AV: E=Sophos;i="6.15,196,1739836800"; 
   d="scan'208";a="733684599"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 01:01:56 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:7433]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.63:2525] with esmtp (Farcaster)
 id 3cfa9373-684f-4a17-aabf-b3c076aa83ec; Tue, 8 Apr 2025 01:01:56 +0000 (UTC)
X-Farcaster-Flow-ID: 3cfa9373-684f-4a17-aabf-b3c076aa83ec
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 01:01:55 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 01:01:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kernel-team@meta.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <mathieu.desnoyers@efficios.com>,
	<mhiramat@kernel.org>, <ncardwell@google.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <rostedt@goodmis.org>, <song@kernel.org>,
	<yonghong.song@linux.dev>
Subject: Re: [PATCH net-next v2 2/2] trace: tcp: Add tracepoint for tcp_sendmsg_locked()
Date: Mon, 7 Apr 2025 18:00:35 -0700
Message-ID: <20250408010143.11193-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407-tcpsendmsg-v2-2-9f0ea843ef99@debian.org>
References: <20250407-tcpsendmsg-v2-2-9f0ea843ef99@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Mon, 07 Apr 2025 06:40:44 -0700
> Add a tracepoint to monitor TCP send operations, enabling detailed
> visibility into TCP message transmission.
> 
> Create a new tracepoint within the tcp_sendmsg_locked function,
> capturing traditional fields along with size_goal, which indicates the
> optimal data size for a single TCP segment. Additionally, a reference to
> the struct sock sk is passed, allowing direct access for BPF programs.
> The implementation is largely based on David's patch and suggestions.
> 
> The implementation is largely based on David's patch[1] and suggestions.

nit: duplicate sentences.


> 
> Link: https://lore.kernel.org/all/70168c8f-bf52-4279-b4c4-be64527aa1ac@kernel.org/ [1]
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/trace/events/tcp.h | 24 ++++++++++++++++++++++++
>  net/ipv4/tcp.c             |  2 ++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index 1a40c41ff8c30..cab25504c4f9d 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -259,6 +259,30 @@ TRACE_EVENT(tcp_retransmit_synack,
>  		  __entry->saddr_v6, __entry->daddr_v6)
>  );
>  
> +TRACE_EVENT(tcp_sendmsg_locked,
> +	TP_PROTO(const struct sock *sk, const struct msghdr *msg,
> +		 const struct sk_buff *skb, int size_goal),
> +
> +	TP_ARGS(sk, msg, skb, size_goal),
> +
> +	TP_STRUCT__entry(
> +		__field(const void *, skb_addr)
> +		__field(int, skb_len)
> +		__field(int, msg_left)
> +		__field(int, size_goal)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->skb_addr = skb;
> +		__entry->skb_len = skb ? skb->len : 0;
> +		__entry->msg_left = msg_data_left(msg);
> +		__entry->size_goal = size_goal;
> +	),
> +
> +	TP_printk("skb_addr %p skb_len %d msg_left %d size_goal %d",
> +		__entry->skb_addr, __entry->skb_len, __entry->msg_left,
> +		__entry->size_goal));
> +
>  DECLARE_TRACE(tcp_cwnd_reduction_tp,
>  	TP_PROTO(const struct sock *sk, int newly_acked_sacked,
>  		 int newly_lost, int flag),
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index ea8de00f669d0..270ce2c8c2d54 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1160,6 +1160,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  		if (skb)
>  			copy = size_goal - skb->len;
>  
> +		trace_tcp_sendmsg_locked(sk, msg, skb, size_goal);

skb could be NULL, so I think raw_tp_null_args[] needs to be updated.

Maybe try attaching a bpf prog that dereferences skb unconditionally
and see if the bpf verifier rejects it.

See this commit for the similar issue:

commit 5da7e15fb5a12e78de974d8908f348e279922ce9
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Fri Jan 31 19:01:42 2025 -0800

    net: Add rx_skb of kfree_skb to raw_tp_null_args[].


> +
>  		if (copy <= 0 || !tcp_skb_can_collapse_to(skb)) {
>  			bool first_skb;
>  
> 
> -- 
> 2.47.1

