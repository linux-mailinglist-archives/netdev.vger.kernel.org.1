Return-Path: <netdev+bounces-131658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FD398F2A6
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C342CB20D85
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201101A4E91;
	Thu,  3 Oct 2024 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ccJ1/wKN"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB09D1A38D9;
	Thu,  3 Oct 2024 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727969561; cv=none; b=NNsl3C5LoNE7iEoxFsId22LG8ey44Y7cwvgopUjy/DXJtHaSa95g5tzbxvvpgI6T0UR472iLXQydSYy9CvzPMSgssIQu+jky3wK9v7E1WDuCjZTB0lOmYJguiGL6pBgb0LKp3krwXsJZl2jFcoMZrZ93oNjXSHJ9UuhcKGnBrK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727969561; c=relaxed/simple;
	bh=9krKfD2PPE4Bo0Oxq5l3JAozLfSecSk+reEbBJesV8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnKkCaHcdCVbruNT7e+HA/fCi99GhAAzRMcBeLwY6DBynsTfoshLR4CZgKDfBsgqWbmkN+ALZrLxO+bFC+FdngJnwoXkZHbzCv9mQCPiZD3P3DG5yZaZYuu71QySqw3g22XuhxNzHmbZ01l90AqaW769i5COEEmVgI+OtsB06Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ccJ1/wKN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gwLKYGbX8kM5rFaC+/BTnEzd1qTUuvtYb4wOOvMU0n4=; b=ccJ1/wKNEyJiwkrzQVvGKBTQPK
	QLWmqMcu8NOVBTbshrR6uF4MOd76489SBKFz2VcAT7BAj2RJtUaArZ/c+CGyg2CpMeA77BlTcadkC
	XDtOy8IqwKq6lEzHXtWFzApu4tEXvSO/IAJX0O9jQZJ/YMKuGtSIbX+kFs8JAQqgTCgYRunDiKYZ7
	dagD07u/itdHwSXq5gQWYYUS4VIKHrYMI2b+Op0K89m+coTECYuPeqsVChvvgxBTAeljRxXu3FWn9
	8mk7xsXxhMxMqs4Qae9x+UsKDYE2Hz/AobF465Ouowmv2fnig/8pZBRpEAlxbaO5xHDzExWwXqObw
	5KSLEZyw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1swNoe-00000003iIp-0LWh;
	Thu, 03 Oct 2024 15:32:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1AC4130083E; Thu,  3 Oct 2024 17:32:31 +0200 (CEST)
Date: Thu, 3 Oct 2024 17:32:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Breno Leitao <leitao@debian.org>
Cc: gregkh@linuxfoundation.org, pmladek@suse.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, kuba@kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, vschneid@redhat.com, axboe@kernel.dk
Subject: Re: 6.12-rc1: Lockdep regression bissected
 (virtio-net/console/scheduler)
Message-ID: <20241003153231.GV5594@noisy.programming.kicks-ass.net>
References: <20241003-savvy-efficient-locust-ae7bbc@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003-savvy-efficient-locust-ae7bbc@leitao>

On Thu, Oct 03, 2024 at 07:51:20AM -0700, Breno Leitao wrote:
> Upstream kernel (6.12-rc1) has a new lockdep splat, that I am sharing to
> get more visibility:
> 
> 	WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
> 
> This is happening because the HARDIRQ-irq-unsafe "_xmit_ETHER#2" lock is
> acquired in virtnet_poll_tx() while holding the HARDIRQ-irq-safe, and
> lockdep doesn't like it much.
> 
> I've bisected the problem, and weirdly enough, this problem started to
> show up after a unrelated(?) change in the scheduler:
> 
> 	52e11f6df293e816a ("sched/fair: Implement delayed dequeue")
> 
> At this time, I have the impression that the commit above exposed the
> problem that was there already.
> 
> Here is the full log, based on commit 7ec462100ef91 ("Merge tag
> 'pull-work.unaligned' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs")

This looks like the normal lockdep splat you get when the scheduler does
printk. I suspect you tripped a WARN, but since you only provided the
lockdep output and not the whole log, I cannot tell.

There is a fix in:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/urgent

that might, or might not help. I can't tell.

