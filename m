Return-Path: <netdev+bounces-105832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9718591318D
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 04:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7FBA1C20F49
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 02:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68DC5382;
	Sat, 22 Jun 2024 02:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUoSYj3G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F722441D;
	Sat, 22 Jun 2024 02:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719022366; cv=none; b=HiVCHk3sW9rCDsh3BnpmH3bMlVWW7ydxE/cuM6neiPS3EClvyV4XjrOEExk+wVIkm6Wgduakfjh++ptQDAD03oreha9Gi0rqmjPtCWKwzzh/hsuZCQ1H0xQQ2A3mLxA9c1Tx0PjW6SvjyXWtqCJIj/86kvzhFGrj/p0rm1LZm6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719022366; c=relaxed/simple;
	bh=VH0FuuCqSbUxTLpEFhI/fZ0TfV+w/kam9ttGlxxMPO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5wUzt9UBjimMbe6BTu2Ar6NpTJMoAP2uWvIcEor/r9OBc7FqkWa4Q1YdU/nWL8p1Qh8N19OBIIc6s5Cx2jK5U5d3qnrqPn+LR+t15gLIqNRdVUKK22ScqqtHvlsfUpvDFkH4zQMCVkPkNvbACJGxfsdCqDE9zTZw8liyzgXF1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUoSYj3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B469BC2BBFC;
	Sat, 22 Jun 2024 02:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719022366;
	bh=VH0FuuCqSbUxTLpEFhI/fZ0TfV+w/kam9ttGlxxMPO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CUoSYj3G315iFvtC0ER1M4FU9oeGexN/kOWw08JWOnYHPkntFGwAYfrKHx2zo4tJj
	 daqdxCJsNk8eOGnmszafwJy9W/u9CyH9dvt+Zc3ZWwbORg4ydKfsVDeJY5OZT3uAiK
	 UY3b2vryS6VlW8LJEfuGD8uJiYowd7wWYj0pzsaNdUkUeAVssjEiZLrcSd6vdZiONU
	 U35ei/Mm3/kG+0vzjGV0R9fSK5F6vpi/kjF6pe6k1XGezadgNOjVyB66khIQYIwSu/
	 LcQk4HlS2liniJLqlNw+lBOvoWghymtxT10AsG23HCxX6GsaH7wfkuf1nPmPWBQ2Em
	 h3Poqh1wzCltA==
Date: Fri, 21 Jun 2024 19:12:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Daniel Bristot de Oliveira <bristot@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Eric Dumazet <edumazet@google.com>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Paolo Abeni
 <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Waiman Long <longman@redhat.com>, Will Deacon
 <will@kernel.org>, Ben Segall <bsegall@google.com>, Daniel Bristot de
 Oliveira <bristot@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, Steven
 Rostedt <rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v9 net-next 08/15] net: softnet_data: Make xmit per
 task.
Message-ID: <20240621191245.1016a5d6@kernel.org>
In-Reply-To: <20240620132727.660738-9-bigeasy@linutronix.de>
References: <20240620132727.660738-1-bigeasy@linutronix.de>
	<20240620132727.660738-9-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 15:21:58 +0200 Sebastian Andrzej Siewior wrote:
> +static inline void netdev_xmit_set_more(bool more)
> +{
> +	current->net_xmit.more = more;
> +}
> +
> +static inline bool netdev_xmit_more(void)
> +{
> +	return current->net_xmit.more;
> +}
> +#endif
> +
> +static inline netdev_tx_t __netdev_start_xmit(const struct net_device_ops *ops,
> +					      struct sk_buff *skb, struct net_device *dev,
> +					      bool more)
> +{
> +	netdev_xmit_set_more(more);
> +	return ops->ndo_start_xmit(skb, dev);
> +}

The series looks clean, I'm happy for it to be applied as is.

But I'm curious whether similar helper organization as with the BPF
code would work. By which I mean - instead of read / write helpers
for each member can we not have one helper which returns the struct?
It would be a per-CPU struct on !RT and pointer from current on RT.
Does it change the generated code? Or stripping the __percpu annotation
is a PITA?

