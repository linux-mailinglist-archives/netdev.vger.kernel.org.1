Return-Path: <netdev+bounces-201517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D01AE9B03
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 12:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB21D1C40D49
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D4922424C;
	Thu, 26 Jun 2025 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hA6stHRW"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984EF223316;
	Thu, 26 Jun 2025 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933013; cv=none; b=g11/a9cDX8AF4s9NpgDE3MS7Y3W+raDJ6GKqAePbHPhU6my03DuZtKIQHlmEd0+6BnZpsbEjLEquq8/MK/pW6UQKvFqJ1iDBOvaVyrn69FAKRsH8y6aQTpD5DLppRYfZFACOOdkBLv0XV1HsBktVOVvmpjTeeVBHU/aww8yEocI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933013; c=relaxed/simple;
	bh=GBSozoWWKRKZJrCGFCdZ43CXvJAlMWvl9OaRxXSMWT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLzKK607dnsbTD/VFd3Wc2O35Nhc4tCw9mQJPoN0uf1jVUod7toqnSbZnXbnLgJ2dM5O4wYL8Nn83vV+kIWhUOkv9z+DUPOZ0q6pTZlVzwpcDqFzRYDgyW7b32CdeVSxMWDigDO8RkjO5yg9Oh2u6t17oTgFlf5eMNF9iiBrqpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hA6stHRW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GBSozoWWKRKZJrCGFCdZ43CXvJAlMWvl9OaRxXSMWT8=; b=hA6stHRWbGabrP0nAwAWoTMcZF
	eJOUeXz1a9oYFVsu9p03reHpmUahcEb40hbN/qsZv+k52oDDha4kjJdu61MiUH818eOSH8OHc7/5/
	cWxShLIQFXB/Z8pPjuztsw4GaEgx0agBB+WieYS/W6ADB8yP40kuOLXAMcfKuy2sA4gcTbyNIEIri
	KQZPZ/NLpNDKi73asapwljVb7QC+WdEFzA6N/Uat2EoEGVt/64eGG35YJxlfa/oLu98AKMEi+Je1G
	VXh0BBLVJEcW8YM1i05rbuQshuh/esiB/zuKCvCgkBg20bZZp66+ffAp0ghWTUtlk1quPilRKcIjh
	mvTtxtUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUjez-0000000BG9H-1fW8;
	Thu, 26 Jun 2025 10:16:49 +0000
Date: Thu, 26 Jun 2025 03:16:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, lkmm@lists.linux.dev,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Breno Leitao <leitao@debian.org>,
	aeh@meta.com, netdev@vger.kernel.org, edumazet@google.com,
	jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>
Subject: Re: [PATCH 0/8] Introduce simple hazard pointers for lockdep
Message-ID: <aF0eEfoWVCyoIAgx@infradead.org>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
 <aFvl96hO03K1gd2m@infradead.org>
 <aFwC-dvuyYRYSWpY@Mac.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFwC-dvuyYRYSWpY@Mac.home>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 25, 2025 at 07:08:57AM -0700, Boqun Feng wrote:
> Sure, I will put one for the future version, here is the gist:

Thanks a lot!

> The updater's wait can finish immediately if no one is accessing 'a', in
> other words it doesn't need to wait for reader 2.

So basically it is the RCU concept, but limited to protecting exactly
one pointer update per critical section with no ability for the read
to e.g. acquire a refcount on the objected pointed to by that pointer?

