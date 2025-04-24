Return-Path: <netdev+bounces-185338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6743BA99CE7
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA42E5A5B37
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 00:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCB717F7;
	Thu, 24 Apr 2025 00:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFiCSBBs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4747518EB0
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 00:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745454258; cv=none; b=saVlrvg1vEowm4lWM0b3/xoTZ12GD5wZa2/9eBiXgpZ3F+sScCFr1qMwIFpPHRwz+VI/WVdetFgVnsitcdizM46J3oBTg4u69MgLfl1qF/3iiH4u9IV+fjskZdnuqrZIbepFwaTE6s8iKChc2nGHNB2+uBOU2a1CNSrrUgprRLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745454258; c=relaxed/simple;
	bh=0adNhVNAvzGwmhhhADHeeaPsZ17QbMi3WE20NHqbDaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUsiAwvYA0ek/0J6ImRegfbb6QVxRWVTNLLQk7S+YqTJhXB6+eQGPA7ggwH4bxOkNQYWjfqD/AnUJW9BX1hxPfdE0bIXamaYiR4YKd1Z4olJewpGOWNGfXKESeYSQ2Nt21LZBzwTPbNQwU/IK4yTmGYG36NgKBwMV+yAtcn8mYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFiCSBBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBCEC4CEE2;
	Thu, 24 Apr 2025 00:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745454257;
	bh=0adNhVNAvzGwmhhhADHeeaPsZ17QbMi3WE20NHqbDaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZFiCSBBsdwkXpH/QgD7Taj83EsURH5TWqb5d9Ivl/Sn0fkkLdDxLtcDrpe1cbpxY0
	 E2Rl4IH5/3hMMDA8bj95sLj0BYLRmbFVMD+i2Kga+RKofwmH9IfzskUE2om18v/DbP
	 yzYTHnVYgRkEPLf9wIcA/36p9bipH30hszTIfmBC5L/8203MXiW0QjeRQ+ximGdYlb
	 9WHhk466h3z7mGHhldk0tzTeyzNhXHTBIXeIYCxcrcHFpo8QTWg/v24rz7/xoEKmu1
	 uhQXGfpZ42ELXPwzLLVMglCQmCCPt7Z9KOEdXw928B/3HZngA2cgdmgTPrpM0M4VlR
	 wdgXG8NphI9qg==
Date: Wed, 23 Apr 2025 17:24:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Victor Nogueira <victor@mojatatu.com>,
 netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, toke@redhat.com,
 gerrard.tai@starlabs.sg, pctammela@mojatatu.com
Subject: Re: [PATCH net v2 0/5] net_sched: Adapt qdiscs for reentrant
 enqueue cases
Message-ID: <20250423172416.4ee6378d@kernel.org>
In-Reply-To: <aAl34pi75s8ItSme@pop-os.localdomain>
References: <20250416102427.3219655-1-victor@mojatatu.com>
	<aAFVHqypw/snAOwu@pop-os.localdomain>
	<4295ec79-035c-4858-9ec4-eb639767d12b@redhat.com>
	<aAlSqk9UBMNu6JnJ@pop-os.localdomain>
	<aAl34pi75s8ItSme@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 16:29:38 -0700 Cong Wang wrote:
> > +	/*
> > +	 * If doing duplication then re-insert at top of the
> > +	 * qdisc tree, since parent queuer expects that only one
> > +	 * skb will be queued.
> > +	 */
> > +	if (skb2) {
> > +		struct Qdisc *rootq = qdisc_root_bh(sch);
> > +		u32 dupsave = q->duplicate; /* prevent duplicating a dup... */
> > +
> > +		q->duplicate = 0;
> > +		rootq->enqueue(skb2, rootq, to_free);
> > +		q->duplicate = dupsave;
> > +		skb2 = NULL;
> > +	}
> > +
> >  finish_segs:
> >  	if (skb2)
> >  		__qdisc_drop(skb2, to_free);
> >   
> 
> Just FYI: I tested this patch, netem duplication still worked, I didn't
> see any issue.

Does it still work if you have another layer of qdiscs in the middle?
It works if say DRR is looking at the netem directly as its child when
it does:

	first = cl->qdisc->q.qlen

but there may be another layer, the cl->qdisc may be something that
hasn't incremented its qlen, and something that has netem as its child.

