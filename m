Return-Path: <netdev+bounces-226841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB366BA5856
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 04:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6588517EAC9
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 02:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2303B198E91;
	Sat, 27 Sep 2025 02:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OPA2hyMX"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B213717A2E8
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 02:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758941784; cv=none; b=qpbZ1trwhgck096wxopV2XvqsgemkuY9t3sUia3S3lnFeVBXkBNjapvWYs9D94B5H9G1cBacudb1EF2jZGn4yohPK0Ra8N6ydTttsOXQhg/d4wA2bIP10EFCLEb+8ZKh4Xht8aevZIenM/S4mDCUVZmHxXnYbFYU3jHAWg2l4EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758941784; c=relaxed/simple;
	bh=d1eXs6DWaOfhXjpv9XtWRxiJ2KNPGTul1rvBiot4JYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsB5EBy1L+xXPMLbY56yVEuvEiMl9EJyJTa9nzNk4R8trnrFS+tyJoIh/TprNNgr+xJWB4Yj8Tao4QJ9c0jFCaMNdk2/+U/8w3T87Qp8Gl/97+M+pvgFAe80u97kyHK70qYAOL15K1FznGhrGItBvQHN7ODtzg4Isyjg6ST9rPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OPA2hyMX; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 27 Sep 2025 10:56:12 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758941779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hNFL4NCddwMxex4KSolxmj2AxCnBFQXRhkkV1fhjuAk=;
	b=OPA2hyMXvel1wb75RMOrB6hSIxC1dVOeqrSUJdhw5ZMzhbtdl5zjm10q7ijqY3gPIGqSVW
	LqBHUz01pA2QDPdVJ1yz7qkyFQvrLlLFZmIyzH0R/LE+xzsshn/YbbVcOXJyy2gV2GDcUW
	/JBA3WE/K1nlWrx5QcmwmV36gEIrP/0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: xuanqiang.luo@linux.dev
Cc: edumazet@google.com, kuniyu@google.com, 
	"Paul E. McKenney" <paulmck@kernel.org>, kerneljasonxing@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: Re: [PATCH net-next v7 0/3] net: Avoid ehash lookup races
Message-ID: <osfubz5wloxmthq5kcvzrpcszmpself2lijlc6duw57tbyh565@7cbkpapsmokb>
References: <20250926074033.1548675-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926074033.1548675-1-xuanqiang.luo@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 26, 2025 at 03:40:30PM +0800, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> After replacing R/W locks with RCU in commit 3ab5aee7fe84 ("net: Convert
> TCP & DCCP hash tables to use RCU / hlist_nulls"), a race window emerged
> during the switch from reqsk/sk to sk/tw.
> 
> Now that both timewait sock (tw) and full sock (sk) reside on the same
> ehash chain, it is appropriate to introduce hlist_nulls replace
> operations, to eliminate the race conditions caused by this window.
> 
> Before this series of patches, I previously sent another version of the
> patch, attempting to avoid the issue using a lock mechanism. However, it
> seems there are some problems with that approach now, so I've switched to
> the "replace" method in the current patches to resolve the issue.
> For details, refer to:
> https://lore.kernel.org/netdev/20250903024406.2418362-1-xuanqiang.luo@linux.dev/
> 
> Before I encountered this type of issue recently, I found there had been
> several historical discussions about it. Therefore, I'm adding this
> background information for those interested to reference:
> 1. https://lore.kernel.org/lkml/20230118015941.1313-1-kerneljasonxing@gmail.com/
> 2. https://lore.kernel.org/netdev/20230606064306.9192-1-duanmuquan@baidu.com/


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---

Thank you Xuanqiang and Kuniyuki. This issue appears to have existed for a
long time. Under normal circumstances, it can be avoided when RSS or RPS is
enabled.

However, we have recently been experiencing it frequently in our production
environment. The root cause is that TCP traffic is encapsulated using VXLAN,
but the same TCP flow does not use the same UDP 4-tuple. This leads to
concurrency when the host processes the VXLAN encapsulation.

I tested this patch and it fixed this issue.

