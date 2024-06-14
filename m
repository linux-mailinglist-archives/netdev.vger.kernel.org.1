Return-Path: <netdev+bounces-103664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C94E908F9A
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 18:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6851C20E90
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94AB146A9D;
	Fri, 14 Jun 2024 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="URq1dqzn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+ETc5Tgr"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8A32B9A5;
	Fri, 14 Jun 2024 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381090; cv=none; b=UvI/9sXprpbfj8FQevdWAK7kLBsSVjPQQ+PZJBApGOTU6H/vxwrcWrRz6gXIWVkEW0z0sbbJdCnw0jrM739th274YJYjYBRlvKdHxUW7rP3c6GOTG0Si3oXtolN0Z1fc1RVSBgM2QKl5bHLHTn2cZ35xVoBSgY28m2Jy5UZuf+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381090; c=relaxed/simple;
	bh=4WF6JZsC3Ht/Gfaa311jklZxD5KElK3svrdFuhozFhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgiJzRrekbIXJ3Mz8ge/OAc9htAh/CEg6xLTSmvxkdzdw3NkBRaJcdWckb/1hJschgyqNa4QZnChhRU+xHWPrIop5JqKCmTdddVU4GQc/5zf6h+b6bvTadAWgOl+F7tP1PPTtK0RnRjRwOX5qpvdgkD/Nn2luhvPTNNgcC8JfdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=URq1dqzn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+ETc5Tgr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Jun 2024 18:04:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718381086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gi0Ctfyyc/5laoLje+Jfda9IFf+g17QR1+NTWKKpkzY=;
	b=URq1dqznDFEyKvue5WWUyghEYBMGpwkh7txsThmmwcrVQ9KyJWpXdEkMBaPnXU5plEZaWE
	UpwgjyiI0tqjui61steL9vafHgl3QziQRHIa/xdOJHmSBFk5Jq8XJcoG6k1gXZiT2sTBJJ
	8J6QQzVlYhQhq6CvfWr+WF9xfnMFjWM/KNhu6uJFwf0pyjeVVQvw7QEPCLVuIK6h4zWYkx
	q+7akQ0MnhrQZuIotH+00OP5cc5fnGfUeNf9e+FRquJryXwpnjfGiBY7i1IE98w2wSKq5h
	WIP8Q5y/jFuQRoPt0Exoo13e/oH8HQ448JKvBIKf6w1nVLjDMmweSjv/gQu38A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718381086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gi0Ctfyyc/5laoLje+Jfda9IFf+g17QR1+NTWKKpkzY=;
	b=+ETc5Tgr4yxAnUx+RKxcPxbLMEHt1UG8hPckBJGyZivqlVqKpBe0CffC3DZfuhDoqTQ1kO
	5QXSf3GHBEIa6RDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v6 net-next 08/15] net: softnet_data: Make xmit.recursion
 per task.
Message-ID: <20240614160445.UdPsIOTW@linutronix.de>
References: <20240612170303.3896084-1-bigeasy@linutronix.de>
 <20240612170303.3896084-9-bigeasy@linutronix.de>
 <20240612131829.2e33ca71@rorschach.local.home>
 <20240614082758.6pSMV3aq@linutronix.de>
 <CANn89i+YfdmKSMgHni4ogMDq0BpFQtjubA0RxXcfZ8fpgV5_fw@mail.gmail.com>
 <20240614094809.gvOugqZT@linutronix.de>
 <834b61b93df3cbf5053e459f337e622e2c510fbd.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <834b61b93df3cbf5053e459f337e622e2c510fbd.camel@redhat.com>

On 2024-06-14 16:08:42 [+0200], Paolo Abeni wrote:
> 
> I personally think (fear mostly) there is still the potential for some
> (performance) regression. I think it would be safer to introduce this
> change under a compiler conditional and eventually follow-up with a
> patch making the code generic.
> 
> Should such later change prove to be problematic, we could revert it
> without impacting the series as a whole. 

Sounds reasonable. In that case let me stick with "v6.5" of this patch
(as just posted due the `more' member) and then I could introduce an
option for !RT to use this optionally so it can be tested widely.

> Thanks!
> 
> Paolo

Sebastian

