Return-Path: <netdev+bounces-162738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13219A27C80
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8664D160BD2
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 20:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7422066CB;
	Tue,  4 Feb 2025 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIB4SUiN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5072063DB
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699744; cv=none; b=E1wMpQHXZ5X+lTsltfv+HCRI1M44Rookm4DqZKfPfuOQVwjAmxsyfxPM8YJ7Xx2MTU8/hhcosqn2f9SHLhlQjHwL4IMoxaKe9XAtLKui0CS4vE6HN2dvPxdPez0Cq2dnTx+JufJ+tQc9ixvWxja88ZDSwpehSKw5bC31hFCj7ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699744; c=relaxed/simple;
	bh=j8WMMwH8T5XWzuLoFTNF44Zl9T2jicDXJwYmEbB86Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZvQIekZZhGsIQfCgWSlTg/oXSdwt2uAUTtP8n6OTBCLAidoYqTvUWIGip09CG3qvlGJa14Jm/uE9MZl48uVc2ipcNf/+b3bksXDYdRCu1NPPw+QRdRxGVdf9hwsBoBpHDDsSQ22jz1bN5/rxgD/K9RBKDBfnndQSRFHe32HjpgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIB4SUiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DA8C4CEDF;
	Tue,  4 Feb 2025 20:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699744;
	bh=j8WMMwH8T5XWzuLoFTNF44Zl9T2jicDXJwYmEbB86Xw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SIB4SUiN3OlZR1QcxASA3hlTZEsdO+kjXCZRmFS/y7oWC2CeWxodXKHC7r/T8p2Sj
	 GZAsOuj9qDuwMxB3B1rqZwziUO0jRDrb3rNp4Laoap+Iv45Ased0fSelhGo7YuBszc
	 QAL4qxlVOO9vYbxAXujGHu6b/6Gb3dPz/nRasQqUzFirJYOK2B2zr/rdBzTBPIe3Co
	 GuBfrP820IHbterN0NYmhPXIqAil2rC4GRj7wsTGoRSzhIcyMfekR+hAzjAFBnvUt5
	 zuPdL5IHuFcAEOXcF/r1QBSk19Uie/wi2rtV1qcG8XtWlVi41fbWJumCoerJusHjSp
	 hbXYmRZy+vZDQ==
Date: Tue, 4 Feb 2025 12:09:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Kuniyuki Iwashima
 <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>,
 eric.dumazet@gmail.com
Subject: Re: [PATCH v3 net 11/16] ipv6: input: convert to dev_net_rcu()
Message-ID: <20250204120903.6c616fc8@kernel.org>
In-Reply-To: <20250204132357.102354-12-edumazet@google.com>
References: <20250204132357.102354-1-edumazet@google.com>
	<20250204132357.102354-12-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Feb 2025 13:23:52 +0000 Eric Dumazet wrote:
> @@ -488,7 +488,7 @@ static int ip6_input_finish(struct net *net, struct sock *sk, struct sk_buff *sk
>  int ip6_input(struct sk_buff *skb)
>  {
>  	return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_IN,
> -		       dev_net(skb->dev), NULL, skb, skb->dev, NULL,
> +		       dev_net_rcu(skb->dev), NULL, skb, skb->dev, NULL,
>  		       ip6_input_finish);
>  }
>  EXPORT_SYMBOL_GPL(ip6_input);

One more here:

[ 4326.034939][   T50] =============================
[ 4326.035125][   T50] WARNING: suspicious RCU usage
[ 4326.035299][   T50] 6.13.0-virtme #1 Not tainted
[ 4326.035955][   T50] -----------------------------
[ 4326.036124][   T50] ./include/net/net_namespace.h:404 suspicious rcu_dereference_check() usage!
[ 4326.036398][   T50] 
[ 4326.036398][   T50] other info that might help us debug this:
[ 4326.036398][   T50] 
[ 4326.036684][   T50] 
[ 4326.036684][   T50] rcu_scheduler_active = 2, debug_locks = 1
[ 4326.036910][   T50] 2 locks held by kworker/2:1/50:
[ 4326.037111][   T50]  #0: ffff8880010a9548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x7ec/0x16d0
[ 4326.037439][   T50]  #1: ffffc9000036fd40 ((work_completion)(&trans->work)){+.+.}-{0:0}, at: process_one_work+0xe0b/0x16d0
[ 4326.037741][   T50] 
[ 4326.037741][   T50] stack backtrace:
[ 4326.037930][   T50] CPU: 2 UID: 0 PID: 50 Comm: kworker/2:1 Not tainted 6.13.0-virtme #1
[ 4326.037935][   T50] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[ 4326.037937][   T50] Workqueue: events xfrm_trans_reinject
[ 4326.037947][   T50] Call Trace:
[ 4326.037949][   T50]  <TASK>
[ 4326.037952][   T50]  dump_stack_lvl+0xb0/0xd0
[ 4326.037963][   T50]  lockdep_rcu_suspicious+0x1ea/0x280
[ 4326.037975][   T50]  ip6_input+0x262/0x3e0
[ 4326.038009][   T50]  xfrm_trans_reinject+0x2a2/0x460
[ 4326.038055][   T50]  process_one_work+0xe55/0x16d0
[ 4326.038098][   T50]  worker_thread+0x58c/0xce0
[ 4326.038121][   T50]  kthread+0x359/0x5d0
[ 4326.038141][   T50]  ret_from_fork+0x31/0x70
[ 4326.038150][   T50]  ret_from_fork_asm+0x1a/0x30

Test output:
https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/978202/61-l2tp-sh/
Decoded:
https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/978202/vm-crash-thr2-0

