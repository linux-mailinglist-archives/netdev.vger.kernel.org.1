Return-Path: <netdev+bounces-201118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C9DAE8253
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87AD16CAE4
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DC2225792;
	Wed, 25 Jun 2025 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tsZbP2Xh"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C6C442C;
	Wed, 25 Jun 2025 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750853114; cv=none; b=I5vqJPA02uweUB8zYz/qjI0+YPce3IiKt8qab591UusTZ7aw/8EORPGSDesjwxnyCcuIVwahHXyugKymof9yIIonZbmc7H50vCQAjB6i4VztfQpDNNTA69Ky1IhvSN91PV1E9bxvo0thF1nVcAd0AL8o1Ipaio0C0Tnnb9FqPqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750853114; c=relaxed/simple;
	bh=fwcRi+ZkHAhx7UHAd4kPdJTxKXzxnAoBAbgfC9mVftc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/VWVZg+8vGoiV4ohXBqgxx/T6QLgaVKa0BAvWIqTd0U3NN2J/CNeNqmPIxzfgUp37ZRKm0Yvof37vYq8Wew6bswFI4gIby06q48munRnZchMRgbHsu9ikuwa4vrEYdoRmrkmUMV+ln5ieWOsgzr/B7iubU3FA4mVtE6oB6i7+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tsZbP2Xh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wFJPClX6BBDuRa0nuCbDQPz4R2wlEYaUQyO9/NZGEMk=; b=tsZbP2Xh6jfZ+y2gNkiPxi0V9q
	j8rATG5/6nM7+LZE+pOS0cXFzbyUwhZB1AjIJgAOC3UY9aJKSUZZRV76cf9tit77k+ugdtknuxsZe
	D0ac3zNF3KpRHK8+2h9KBnriREaNE9fYryUHGzgoxXHaS0ePR6RVFv0HSFxx+skQETXUi9xKVEO4r
	98hwaXIZjHwTbPGX5krt4JH5C9NHRiY/smAyGx0CRVm1otQPVkm3kZ/pDDpYwHcIU0EgOn+zFmqSX
	iFJ2ZqKKaHtmctKpAel3yCHByAkiJhTpV673O4Obk8aY7NJSk/zzyeLOY5uupt18BI+1J0Nfhz24o
	S0xrMIDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUOsJ-00000008Zop-3PN8;
	Wed, 25 Jun 2025 12:05:11 +0000
Date: Wed, 25 Jun 2025 05:05:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, lkmm@lists.linux.dev,
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
Message-ID: <aFvl96hO03K1gd2m@infradead.org>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625031101.12555-1-boqun.feng@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 24, 2025 at 08:10:53PM -0700, Boqun Feng wrote:
> Hi,
> 
> This is the official first version of simple hazard pointers following
> the RFC:

Can you please put an explanation of what hazard pointers are
prominently into this cover letter?


