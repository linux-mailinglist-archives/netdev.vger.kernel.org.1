Return-Path: <netdev+bounces-180399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229E8A81349
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA951BA6D31
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EEF2356C2;
	Tue,  8 Apr 2025 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JG3m4znX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0875223024C;
	Tue,  8 Apr 2025 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744132372; cv=none; b=YJu8OccKPFGAMMn+J5VmxTVioEX5M58SMEPNohlu3qd0PTnmHDBn08S2Ep1znB1GphZouEBW0ebJxuy6w5OsqyVUuO+vQhy00CSgx/4z4q4tTSN1Cd+UcuB8IDSk8oKs1L3ngzcxM9DzVWkBzi1Jc+UEZ5kc0TOzPYRdU5GDtWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744132372; c=relaxed/simple;
	bh=Pj34+P8socyPgDvsKTOjkxt1ShfPBwPzx2cS+bfx3+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spciSKqeLq7nJ0FC0P2hnuvwLkfcTRlsy33yQrB7+7pLQlKPMMrQSnEeSW3WKwkjCj+PeLVtaG6uCAKQewRmN1phfkQ1pSUKmJTbn6AHQoO+UtJj5jqLnjt55YYyHlHZ2jvvE0Ie5CDrP2krUiFsHI8gNIMFjUUpPG6i649G4rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JG3m4znX; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744132372; x=1775668372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KiccT77guSl05qwq/f8E1x1Iwhvgdns3YBbXrIazhCo=;
  b=JG3m4znXJR1B+uHXHOaXqgN2TtbUD2mGflo29pSaSmCARhyqY/o1ct2o
   /Zb/eKaQ7TGbfi8BjKmpKMubfU0/vtPRH6yR3qLio/EDucwAgWM2Jh6Cy
   Pca6g20R1p6DN7xfCpt4ksRz4WJVb6ziE6K+ypsJQigynLdMyguWU8MUO
   s=;
X-IronPort-AV: E=Sophos;i="6.15,198,1739836800"; 
   d="scan'208";a="487678219"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 17:12:48 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:13538]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.159:2525] with esmtp (Farcaster)
 id c75f37ee-019c-4161-b594-54f7ed1f0739; Tue, 8 Apr 2025 17:12:47 +0000 (UTC)
X-Farcaster-Flow-ID: c75f37ee-019c-4161-b594-54f7ed1f0739
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 17:12:45 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 17:12:40 +0000
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
Date: Tue, 8 Apr 2025 10:12:14 -0700
Message-ID: <20250408171231.35951-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <Z/VWUVk+mHXTENms@gmail.com>
References: <Z/VWUVk+mHXTENms@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Tue, 8 Apr 2025 10:01:05 -0700
> On Tue, Apr 08, 2025 at 09:16:51AM -0600, David Ahern wrote:
> > On 4/8/25 8:27 AM, Breno Leitao wrote:
> > > 
> > > 	SEC("tracepoint/tcp/tcp_sendmsg_locked")
> > 
> > Try `raw_tracepoint/tcp/tcp_sendmsg_locked`.
> > 
> > This is the form I use for my tracepoint based packet capture (not tied
> > to this tracepoint, but traces inside our driver) and it works fine.
> 
> Thanks. I was not able to get this crashing as well. In fact, the
> following program fails to be loaded:
> 
> 	SEC("raw_tracepoint/tcp/tcp_sendmsg_locked")

Try SEC("tp_btf/tcp_sendmsg_locked") and access the raw argument
(struct sk_buff *skb) instead of bpf_raw_tracepoint_args.

The original report used it and I was able to reproduce it
at that time.

https://lore.kernel.org/netdev/Z50zebTRzI962e6X@debian.debian/


> 	int bpf_tcp_sendmsg_locked(struct bpf_raw_tracepoint_args *ctx)
> 	{
> 		void *skb_addr = (void *) ctx->args[0];
> 
> 		bpf_printk("deref %d\n", *(int *) skb_addr);
> 
> 		return 0;
> 	}
> 
> libbpf refuses to load it, and drumps:
> 
> 	libbpf: prog 'bpf_tcp_sendmsg_locked': BPF program load failed: Permission denied
> 	libbpf: prog 'bpf_tcp_sendmsg_locked': -- BEGIN PROG LOAD LOG --
> 	0: R1=ctx() R10=fp0
> 	; void *skb_addr = (void *) ctx->args[0]; @ tcp_sendmsg_locked_bpf.c:18
> 	0: (79) r1 = *(u64 *)(r1 +0)          ; R1_w=scalar()
> 	; bpf_printk("deref %d\n", *(int *) skb_addr); @ tcp_sendmsg_locked_bpf.c:20
> 	1: (61) r3 = *(u32 *)(r1 +0)
> 	R1 invalid mem access 'scalar'
> 	processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
> 	-- END PROG LOAD LOG --
> 	libbpf: prog 'bpf_tcp_sendmsg_locked': failed to load: -13
> 	libbpf: failed to load object 'tcp_sendmsg_locked_bpf.o'
> 	Failed to load BPF object: -13
> 
> > As suggested, you might need to update raw_tp_null_args
> 
> Thanks for confirming it. I will update raw_tp_null_args, assuming that
> the problem exists but I am failing to reproduce it.
> 
> I will send an updated version soon.

