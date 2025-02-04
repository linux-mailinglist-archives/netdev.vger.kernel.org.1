Return-Path: <netdev+bounces-162479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D40A27043
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 12:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC4B1886708
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 11:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2391820C035;
	Tue,  4 Feb 2025 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBt7wMBl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F306A20C02B
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668732; cv=none; b=UEurbKBFp/rxd5tkPi/WpHkyKc2Yu31OXQ+U+5vZo9Nk/iHwghD/T18CSo7gZnrm5WkjwX8m0nlghrxNuV8GtnvwBXTAM4tFlZH72Ju0Iwwz0ieV3N6McRe0Todqbv2pi2Azs/OhIkw+RDmDqSK1MqWQPo9DBO5yC8gB8gHWxMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668732; c=relaxed/simple;
	bh=nfM1cYdFkH3bGzfl0ES6FJkuSE880Z4AbeBVJTDWx1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKHTlwxTJPc59wu0uX4wl/1urCZnQ8f/jQyu78Ef55VYIN8dIls++9IMee59/cRzq/ITMxy7iSXsd9ooyM47aQFQR9LEswQPNzIO7QBJ4/nDqtRKQzBDbau+QxBFZ85vlaMy3a9eTt1VQUToav/1gVs1cPKmQyyKaCYiAb9wGYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBt7wMBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF36C4CEDF;
	Tue,  4 Feb 2025 11:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738668731;
	bh=nfM1cYdFkH3bGzfl0ES6FJkuSE880Z4AbeBVJTDWx1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UBt7wMBl1AxhUQGp5u+fWRM3E/Bhe26qK1LiNmIV1Fd24ibwZcEmo1E9v29osBQzR
	 z/01t9OYbcN3FegyjkUAeGOwL2gZIxdlGCuZVNU6rri9gCvWjmFU+FfYH4gHV0TKu5
	 TcYV4LL/ejwnjaQrYyckF1OnK62aklBfa1sMkCTGclODbFak4J9fR5Pfow19mF0jpD
	 9o1rEIlcyutbp4bSYliMzSoeRT849JoRZPVRBIUAy/m34mFnBzDOtQkDlb2lJ3tUYm
	 uj9JIUUVk6Vcd5wRWS1TFCht2GUIUSJk9tUpgS2z+Z2Uu49wcAtwSR8yxLNiUUFOhy
	 qxTcpsNHvHuUw==
Date: Tue, 4 Feb 2025 11:32:07 +0000
From: Simon Horman <horms@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	pctammela@mojatatu.com, mincho@theori.io, quanglex97@gmail.com,
	Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch net v3 1/4] pfifo_tail_enqueue: Drop new packet when
 sch->limit == 0
Message-ID: <20250204113207.GU234677@kernel.org>
References: <20250204005841.223511-1-xiyou.wangcong@gmail.com>
 <20250204005841.223511-2-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204005841.223511-2-xiyou.wangcong@gmail.com>

On Mon, Feb 03, 2025 at 04:58:38PM -0800, Cong Wang wrote:
> From: Quang Le <quanglex97@gmail.com>
> 
> Expected behaviour:
> In case we reach scheduler's limit, pfifo_tail_enqueue() will drop a
> packet in scheduler's queue and decrease scheduler's qlen by one.
> Then, pfifo_tail_enqueue() enqueue new packet and increase
> scheduler's qlen by one. Finally, pfifo_tail_enqueue() return
> `NET_XMIT_CN` status code.
> 
> Weird behaviour:
> In case we set `sch->limit == 0` and trigger pfifo_tail_enqueue() on a
> scheduler that has no packet, the 'drop a packet' step will do nothing.
> This means the scheduler's qlen still has value equal 0.
> Then, we continue to enqueue new packet and increase scheduler's qlen by
> one. In summary, we can leverage pfifo_tail_enqueue() to increase qlen by
> one and return `NET_XMIT_CN` status code.
> 
> The problem is:
> Let's say we have two qdiscs: Qdisc_A and Qdisc_B.
>  - Qdisc_A's type must have '->graft()' function to create parent/child relationship.
>    Let's say Qdisc_A's type is `hfsc`. Enqueue packet to this qdisc will trigger `hfsc_enqueue`.
>  - Qdisc_B's type is pfifo_head_drop. Enqueue packet to this qdisc will trigger `pfifo_tail_enqueue`.
>  - Qdisc_B is configured to have `sch->limit == 0`.
>  - Qdisc_A is configured to route the enqueued's packet to Qdisc_B.
> 
> Enqueue packet through Qdisc_A will lead to:
>  - hfsc_enqueue(Qdisc_A) -> pfifo_tail_enqueue(Qdisc_B)
>  - Qdisc_B->q.qlen += 1
>  - pfifo_tail_enqueue() return `NET_XMIT_CN`
>  - hfsc_enqueue() check for `NET_XMIT_SUCCESS` and see `NET_XMIT_CN` => hfsc_enqueue() don't increase qlen of Qdisc_A.
> 
> The whole process lead to a situation where Qdisc_A->q.qlen == 0 and Qdisc_B->q.qlen == 1.
> Replace 'hfsc' with other type (for example: 'drr') still lead to the same problem.
> This violate the design where parent's qlen should equal to the sum of its childrens'qlen.
> 
> Bug impact: This issue can be used for user->kernel privilege escalation when it is reachable.
> 
> Fixes: f70f90672a2c ("sched: add head drop fifo queue")

Hi Cong,

Not a proper review, but I believe the hash in mainline for the cited
commit is 57dbb2d83d100ea.

> Reported-by: Quang Le <quanglex97@gmail.com>
> Signed-off-by: Quang Le <quanglex97@gmail.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>

...

