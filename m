Return-Path: <netdev+bounces-146441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6779D36C9
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 10:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0A71F25DBA
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 09:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341B21A3A8D;
	Wed, 20 Nov 2024 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mm5PEFGZ"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE1A1A38C4;
	Wed, 20 Nov 2024 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732094193; cv=none; b=bjvlHWPcwZgXvYlPSRN1jgxFVTPCcDzZGcx3TGd354wTLEzgt/SLnFx/SFbAbCwXefl5OdsZmmtxwaTwuemcxg8AsA1IwVLcvbbmniTFFWGw4cW/3F3T5G6fnaFuQ44S+JfWZPnOVK8jU3RIWrKNdimnckKAT50MzyxGlL1BUZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732094193; c=relaxed/simple;
	bh=8rkAk6517qJEPINzF88RnP6yO3yUFF8kqGgo301aGEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlFaPNPJ/j/HS9ZATWNWBZNewSg9ihLzyrvht8jlsYk9/C+1BrP9j1JCBktdAFEAmPNnU6yK4YtSAbw9S3ScC4e/tCaeVbP+yqUh9Sso0YmJtANWyfQ18Q7BsIt4OK9nzuPLV3tizWDORx9nhT3S60pKKVm57zr6MBHhQNoGYiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Mm5PEFGZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UDm71AFXSdTff/t8s7y05X99dVFpiReRtYTVywv5MPk=; b=Mm5PEFGZDwqjzN3Qgn95E1oG2m
	F53CDaKKhifYOhXO3gAfXQP4272WwkoUiYufHaiSyAug6dTltQMEFXRWc6ySj/0f/LEVl3FmmZxxS
	POC0mST34oim0dhaCYHpuMr0M7pw4nzEWhoDWNiYOFqRKOpLjTHGmF0C4jHXnixr5xfXBFoCadzBb
	wwGPN6VGYdsmF72BaEibC9TI8iAmHpcwLLzeZsND+fzAk8QGQ3M+HbNKvDMzJ6d9u+eC0NrO2xE0I
	524Qt4pORkwLb888WHoPJidC8vOABONKuNObAtNnJ/W4ecZvRZmIlwLnb3KhFbnf72o5PQZTEdPYy
	Af8lLePA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDgov-000000054H4-34Kx;
	Wed, 20 Nov 2024 09:16:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 95311300230; Wed, 20 Nov 2024 10:16:22 +0100 (CET)
Date: Wed, 20 Nov 2024 10:16:22 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ran Xiaokai <ranxiaokai627@163.com>
Cc: juri.lelli@redhat.com, vincent.guittot@linaro.org, mingo@redhat.com,
	pshelar@ovn.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
	ran.xiaokai@zte.com.cn, linux-perf-users@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/4] perf/core: convert call_rcu(free_ctx) to kfree_rcu()
Message-ID: <20241120091622.GK38972@noisy.programming.kicks-ass.net>
References: <20241120064716.3361211-1-ranxiaokai627@163.com>
 <20241120064716.3361211-3-ranxiaokai627@163.com>
 <20241120091215.GK39245@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120091215.GK39245@noisy.programming.kicks-ass.net>

On Wed, Nov 20, 2024 at 10:12:15AM +0100, Peter Zijlstra wrote:
> On Wed, Nov 20, 2024 at 06:47:14AM +0000, Ran Xiaokai wrote:
> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > 
> > The rcu callback free_ctx() simply calls kfree().
> > It's better to directly call kfree_rcu().
> 
> Why is it better? 

*sigh*, also please don't cross post with a moderated list :-(

