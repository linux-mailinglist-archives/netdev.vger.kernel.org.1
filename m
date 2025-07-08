Return-Path: <netdev+bounces-205005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB1BAFCD97
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F333A34A5
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335AE2F85B;
	Tue,  8 Jul 2025 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4aM3dRx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080562AF07;
	Tue,  8 Jul 2025 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985020; cv=none; b=uBLuwwuTxh4KcZ7GlTD9Gpn+HYvU/DnGsEAH95/NYMwt8QOuFQpbRJaHpFJE3owLMO+alnPO75PL3lR8k+Rgc2uT8P+WQdvQozYSFSiDjIzU+B+gcT75bFi/s0fpn/JYLNFwmmS2nysrlsJGDjIiBzW9fKjD9ibe4Zdo/woBegk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985020; c=relaxed/simple;
	bh=hfmPIOfoH2uX5MA2q6bOJzGVVd9u6N6tqlc0WmZuRQY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vc5Kftqdkk8PH3EulhNEdRYi0BCAhWIqZJYhka547xFdNf/veoVWH+mywagmFqi0jUShNQh2Qazvpc2nrMnqkYQjChRl0WZh5E88QCyb0QskiJWiaWvN+AK58Y4A83vgXcPcHkcpDk1ToakMw215S6ZpKlqVa/gijBNR6ALyylM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4aM3dRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16B2C4CEED;
	Tue,  8 Jul 2025 14:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751985019;
	bh=hfmPIOfoH2uX5MA2q6bOJzGVVd9u6N6tqlc0WmZuRQY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n4aM3dRxK69iFJdv7joPgNvlfgeuNYJNJoKgtkfgmvhrwZ5PaVzbTUKUXfbxg9ctP
	 7G/J6cfL4jounNhRIWaricFpFRmDKdD7kCGqOH+RsTl0HOAPsf1/UDjsnxL17YJ///
	 rSQh2+Swd2whDd+cHPjFdrdSGjCglvc9LijEB/mOHLW/X7w1RdKv32ScVEj4cDJThL
	 qPhhuWYWH6nckHuVaJmajpMQM61riTQja266a/Exj97lBb8UNwV+l8IjsLIm1jIaHn
	 V02i2tH47gJCoEnSZRsMgBcE4qo8tvF0GlGHsI/cGHRyNzVO++2AXOoTDDRe490BZO
	 egkoQ3eOyD7dg==
Date: Tue, 8 Jul 2025 07:30:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, mrpre@163.com,
 syzbot+de6565462ab540f50e47@syzkaller.appspotmail.com, Eric Dumazet
 <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Howells <dhowells@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] tcp: Correct signedness in skb remaining
 space calculation
Message-ID: <20250708073017.27ab068f@kernel.org>
In-Reply-To: <20250707054112.101081-1-jiayuan.chen@linux.dev>
References: <20250707054112.101081-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Jul 2025 13:41:11 +0800 Jiayuan Chen wrote:
> Reported-by: syzbot+de6565462ab540f50e47@syzkaller.appspotmail.com
> Fixes: 270a1c3de47e ("tcp: Support MSG_SPLICE_PAGES")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 8a3c99246d2e..803a419f4ea0 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1176,7 +1176,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  		goto do_error;
>  
>  	while (msg_data_left(msg)) {
> -		ssize_t copy = 0;
> +		int copy = 0;

nice! FWIW I think we started hitting something like this in prod, 
not sure what the actual repro is but recently some workloads here
moved to 6.9 kernels and I see spikes in warnings in copy from iter
that the size is > INT_MAX:

WARNING: CPU: 26 PID: 3504902 at include/linux/thread_info.h:249 tcp_sendmsg+0xefd/0x1450
RIP: 0010:tcp_sendmsg (./include/linux/thread_info.h:249 ./include/linux/uio.h:203 ./include/linux/uio.h:221 ./include/net/sock.h:2176 ./include/net/sock.h:2202 net/ipv4/tcp.c:1219 net/ipv4/tcp.c:1355)

I'll take this fix via net.

