Return-Path: <netdev+bounces-228667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6107BD178C
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 07:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F39F4E17F1
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 05:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905172DC333;
	Mon, 13 Oct 2025 05:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EmfYp2jX"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12512DBF73
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 05:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760333781; cv=none; b=koS1nzRoQVSthZLay11i1ZcKOy574zaOBgfyq5K6YbOlERqkpivM58w72ifV3nD9p5Qaymzt7D+dx95P5S+o42HNdO7anwqFJWrfar9HQedFFbbTIAimn4nhCF6T0Wgh3C+RMSOEjRUiv5U/lbkrQ4Z7V2j/sHL/6RFqw0NwMZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760333781; c=relaxed/simple;
	bh=IMe8Jxgs2e8KGH61XY8NojMRBORkF9qpaofbmepncM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMo/3gIEkdRsRUA2BZqNv7SEcAPCaxHwhVbrkog1XOmz9fuB0JwpClx0hbsaotZVWi9/JRoWeKb1QUKXt+wfGKledQ7e2KsTYOeQhE9yBI39biRExAZ2OkKSZNyLy8a6dhQGpbHS6Zp4kw4FPcgav8DXaC+u+qfCrFAHfY0RQWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EmfYp2jX; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 13 Oct 2025 13:36:06 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760333776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ns4/opumWWcjGw5wDB/MPPo8yAesUvJkVEnNTwCcyUg=;
	b=EmfYp2jX+LTRlXkDd972/+9gZO3+44HRfVPpOaj4AjC49meuejrtOX4XiJgnQ4blQyURUo
	kzeXiIjIHYyiLUkK3Gm2hRsrsaCb2L98Y2Lz5KZEjLq43bchshPTF/v1a3MqOQ6pqDKdn9
	lCFUh8ZK8nw3somSt+WZNgaj3HRjZ4c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org, edumazet@google.com, 
	davem@davemloft.net, horms@kernel.org, kuniyu@google.com
Cc: xuanqiang.luo@linux.dev, edumazet@google.com, kuniyu@google.com, 
	"Paul E. McKenney" <paulmck@kernel.org>, kerneljasonxing@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: Re: [PATCH net-next v7 1/3] rculist: Add hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
Message-ID: <zus4r4dgghmcyyj2bcjiprad4w666u4paqo3c5jgamr5apceje@zzdlbm75h5m5>
References: <20250926074033.1548675-1-xuanqiang.luo@linux.dev>
 <20250926074033.1548675-2-xuanqiang.luo@linux.dev>
 <f64b89b1-d01c-41d6-9158-e7c14d236d2d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f64b89b1-d01c-41d6-9158-e7c14d236d2d@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 30, 2025 at 11:16:00AM +0800, Paolo Abeni wrote:
> On 9/26/25 9:40 AM, xuanqiang.luo@linux.dev wrote:
> > From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> > 
> > Add two functions to atomically replace RCU-protected hlist_nulls entries.
[...]
> > 
> > Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> This deserves explicit ack from RCU maintainers.
> 
> Since we are finalizing the net-next PR, I suggest to defer this series
> to the next cycle, to avoid rushing such request.
> 
> Thanks,
> 
> Paolo

Hi maintainers,

This patch was previously held off due to the merge window.

Now that the merge net-next has open and no further changes are required,
could we please consider merging it directly?

Apologies for the slight push, but I'm hoping we can get a formal
commit backported to our production branch.

