Return-Path: <netdev+bounces-101743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691E38FFE69
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 10:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1FAFB22127
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 08:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D91015B577;
	Fri,  7 Jun 2024 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JMZRRWwQ"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDD2525D;
	Fri,  7 Jun 2024 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717750273; cv=none; b=G1h1Xla38vTLOE3Ju1pwfrNf4b4xBG8dtePeWdAuUeP1FIbwsrjVJILqnldPiDQteHto/5cMfP7L5v1ni11eeDL7GyiOq7QXcpTQCCARi5zefwmjoMSHxzhuHtfvr4TwCQPuuykDp4FLIB75sKzbhHmayLf/vtpSyg64/C+g1fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717750273; c=relaxed/simple;
	bh=vpgHYf4KNjaS10gM3AzhCsI3g/sQUs9BDH6puuuj7JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7i4ji7/jUclxZ02MQ58F6ggt8AF7qR9LVKLcxvmIeUFGqu3S8oKTmxPDzsoJ0gnjZOQEEDiCMzbPN6MS3nZZV8TEu3mEqNLiIlGqCBzgnFkq3FANEEdApDoL826tbxYIGE2MIlKUv9yQsDvFlN2fB80ZkayJL/Ko3yJVzmCQLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JMZRRWwQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N3eKsRnAYRK1h7qu28YJgeAnWFt3S0skQfE4J69qFxk=; b=JMZRRWwQsTsU7BtGunXVqRfkhz
	g6GjdKkVdNPkfyyOgBHxQDvAbn53C5lPynN2rJmPjJxftVNVQK3fMNOTYToo6HvtaAcXLFY5RyK78
	HzSoxn9hnUMO03n3P0C5cUCCaRu12lTzPglLuZvuMiW0kqtj/rBqxFOZrlM4+0pZHXdeyehFgarn9
	eug3hruCLSbgbQVdGH39JQ5gpzqEt8hqFjrfvkpvKyM58VF/TuvWiMAPqjkip1b8WU5Nn7VF3/SQi
	i+KEBDGLJwZRQWhIT7DHXJL8/uzObc/m5upJT9jgulskyH/IsPfXGUuS1Onpgfe5mmRud/234bjDz
	Cg4OS8vQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFVJP-00000004f73-0aAS;
	Fri, 07 Jun 2024 08:51:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8EDDE30058E; Fri,  7 Jun 2024 10:50:55 +0200 (CEST)
Date: Fri, 7 Jun 2024 10:50:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 net-next 01/15] locking/local_lock: Introduce guard
 definition for local_lock.
Message-ID: <20240607085055.GL8774@noisy.programming.kicks-ass.net>
References: <20240607070427.1379327-1-bigeasy@linutronix.de>
 <20240607070427.1379327-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607070427.1379327-2-bigeasy@linutronix.de>

On Fri, Jun 07, 2024 at 08:53:04AM +0200, Sebastian Andrzej Siewior wrote:
> Introduce lock guard definition for local_lock_t. There are no users
> yet.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  include/linux/local_lock.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
> index e55010fa73296..82366a37f4474 100644
> --- a/include/linux/local_lock.h
> +++ b/include/linux/local_lock.h
> @@ -51,4 +51,15 @@
>  #define local_unlock_irqrestore(lock, flags)			\
>  	__local_unlock_irqrestore(lock, flags)
>  
> +DEFINE_GUARD(local_lock, local_lock_t __percpu*,
> +	     local_lock(_T),
> +	     local_unlock(_T))
> +DEFINE_GUARD(local_lock_irq, local_lock_t __percpu*,
> +	     local_lock_irq(_T),
> +	     local_unlock_irq(_T))
> +DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_lock_t __percpu,
> +		    local_lock_irqsave(_T->lock, _T->flags),
> +		    local_unlock_irqrestore(_T->lock, _T->flags),
> +		    unsigned long flags)
> +
>  #endif
> -- 
> 2.45.1
> 

