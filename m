Return-Path: <netdev+bounces-186696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0985AA06FE
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 11:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B432B7A1F05
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1CF1F8ADB;
	Tue, 29 Apr 2025 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QdVboiFC"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1832AEE1;
	Tue, 29 Apr 2025 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745918625; cv=none; b=ppJZ9dQEfXxO97d06ywxo4CVICr+VnG+EBduUpvjgTC/Zkanw526ca+AR892fSnjeh/Y9aFzCNnjeB7jSUV7m+wL/ritZ5G9s+PtJGrKZ8kj8u5tHDgA4bARNLQ6Ak0sk0507JjO8OBK7VkhT61ZdDyddEZxfdUXtSThWoi93L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745918625; c=relaxed/simple;
	bh=bxXi4bzflUGg0XRChcdu0vilXlrsAE9J350glGTXHc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnHj5vNdFwkJxznXKqWOJTszZcabmNxULuk5cN49LepS3a26+mXTmaRk+uPTQJ1wLW1lYl/rwPQ3BDhvZmmvZc17CdghlZCdELju9MGotqsM75KjCcni4ygmAOrhJJsbH8GtPWo5kfB6GEAS4MyqS0EpszG4CFSVMSswWDBGgZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QdVboiFC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x3bWo1ELL19pa+d0Sb967tWb6OV53ljAQpQ/pusGFUM=; b=QdVboiFCpHr/Orl+7h5UJxnfPZ
	hdLs16FtVQaFTKC1TP7KW15TTm63H7983/ASTjWHimV6khmEn9j/+UYMp2rNuZiLYITxq5egqkcrz
	/FUXDgPIokyVMnv+IIZuTRxhswRwyeZ3TlphFakhtwwtMvyYM0SsLFoaJptffjX0lAX5iSRMqx2EL
	ap9r3KHVXBk5UJmb88OCrfvg7VK/cqS+C0iMIqMJYpsa3pEYF+8QG2eDq010coHphPydf98uGDqr8
	gPxr3vgwFc2nKtp4xyZ55OdSz5XSYQZ6YcW9Fgfb24AfmJGq1iGFNC1q6ZU2w1+21iPoWcsj0fsqI
	8D1hn0zQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u9hBe-0000000DFRA-117H;
	Tue, 29 Apr 2025 09:23:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B12EF30035E; Tue, 29 Apr 2025 11:23:33 +0200 (CEST)
Date: Tue, 29 Apr 2025 11:23:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH net-next v2 06/18] netfilter: nf_dup{4, 6}: Move
 duplication check to task_struct
Message-ID: <20250429092333.GG4198@noisy.programming.kicks-ass.net>
References: <20250414160754.503321-1-bigeasy@linutronix.de>
 <20250414160754.503321-7-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414160754.503321-7-bigeasy@linutronix.de>

On Mon, Apr 14, 2025 at 06:07:42PM +0200, Sebastian Andrzej Siewior wrote:
> nf_skb_duplicated is a per-CPU variable and relies on disabled BH for its
> locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
> this data structure requires explicit locking.
> 
> Due to the recursion involved, the simplest change is to make it a
> per-task variable.
> 
> Move the per-CPU variable nf_skb_duplicated to task_struct and name it
> in_nf_duplicate. Add it to the existing bitfield so it doesn't use
> additional memory.
> 
> Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/netfilter.h        | 11 -----------
>  include/linux/sched.h            |  1 +
>  net/ipv4/netfilter/ip_tables.c   |  2 +-
>  net/ipv4/netfilter/nf_dup_ipv4.c |  6 +++---
>  net/ipv6/netfilter/ip6_tables.c  |  2 +-
>  net/ipv6/netfilter/nf_dup_ipv6.c |  6 +++---
>  net/netfilter/core.c             |  3 ---
>  7 files changed, 9 insertions(+), 22 deletions(-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>



