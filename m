Return-Path: <netdev+bounces-201027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8EBAE7E64
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59C8161931
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D3C23C507;
	Wed, 25 Jun 2025 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GENmvSDG"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638EB2AE72;
	Wed, 25 Jun 2025 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845805; cv=none; b=NW66yffMCPG8s2DCeFwdQGJh6/0GbTRxZcYK5biduuHyEUWuI+sPNj2DGneAzlTXDat4h8TllhVAtmeLi387Hj2aUv5z1q05LDaeNG4IkdC2uFvZp4nhd8vN5JpoyqhkvInAgOzU8mzkeqAMJLuJFZyLh/MSKLLoaeUu+6MCp7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845805; c=relaxed/simple;
	bh=4iyRM1KL3R1XrbiVcsr04CUGQthdlkEBwMd8fw3p66Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+r9obd/v0DHhy2ry2bc6RUqnw/2vSPyiuNSgDfzDn9t96WyA0CpHKF4cVf9f95/DZMVosrl0ILN2GRxG4jen+lWpv7awHEx6Oa8HcX69TSAePajIdQ3U5scKGrRGcfqrUhV5OLGu8WrmHgwJDyA0wwzPrS2VlAamzmCEwtIy+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GENmvSDG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5dKkxzzfFIs6Vfm9GvDRJTyLxnNMUV5zWME351V4zJE=; b=GENmvSDGae3YEi4iIubEBTcVLL
	M8tU6b6Ny8stAsBObhm1+EMiR0vnO4k9rzZPJUJUmqXgmYETDLi+xO1Ke5oBTDSWbr5qwitBibPj7
	fpLCmRK3C0E6haAB8Md/Fzi+FcE5r7ndMn93XoGGAdtkROlrSWK1y+4VeA9zdyDIy9C2NLWDduGei
	sCmUcgqHGXqaTclRifLV0/e7bg7Zl+8BcrNNSz2OcffIm+TICvl+1fAjZAujjx0BDtlm0uYOAj28k
	QHuL4HbU7dDE8NPCiUCLfebY3JkjIQBZopvFrEdUtqyHMODzoU1Ikoujo5DWxroP2Rzm7JxKpFPMr
	wieAbvDw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUMyM-00000005lZK-2RJv;
	Wed, 25 Jun 2025 10:03:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E9967306158; Wed, 25 Jun 2025 12:03:17 +0200 (CEST)
Date: Wed, 25 Jun 2025 12:03:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, lkmm@lists.linux.dev,
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
Subject: Re: [PATCH 3/8] shazptr: Add refscale test for wildcard
Message-ID: <20250625100317.GC1613376@noisy.programming.kicks-ass.net>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
 <20250625031101.12555-4-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625031101.12555-4-boqun.feng@gmail.com>

On Tue, Jun 24, 2025 at 08:10:56PM -0700, Boqun Feng wrote:

> +static void ref_shazptr_wc_read_section(const int nloops)
> +{
> +	int i;
> +
> +	for (i = nloops; i >= 0; i--) {
> +		preempt_disable();
> +		{
> +			guard(shazptr)(ref_shazptr_read_section);
> +			/* Trigger wildcard logic */
> +			guard(shazptr)(ref_shazptr_wc_read_section);
> +		}
> +		preempt_enable();
> +	}
> +}
> +
> +static void ref_shazptr_wc_delay_section(const int nloops, const int udl, const int ndl)
> +{
> +	int i;
> +
> +	for (i = nloops; i >= 0; i--) {
> +		preempt_disable();
> +		{
> +			guard(shazptr)(ref_shazptr_delay_section);
> +			/* Trigger wildcard logic */
> +			guard(shazptr)(ref_shazptr_wc_delay_section);
> +			un_delay(udl, ndl);
> +		}
> +		preempt_enable();
> +	}
> +}

Same as the last one, scoped_guard (preempt) can replace the preempt
things and the scope.

