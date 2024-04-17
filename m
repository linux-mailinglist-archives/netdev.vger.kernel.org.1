Return-Path: <netdev+bounces-88825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 087218A8A07
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 19:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10BC1F24F6E
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 17:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70C817165E;
	Wed, 17 Apr 2024 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OleMFJWy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938A0171099
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374034; cv=none; b=OMurV9xOE1eySQCuzAdyGpqPvb/nWjkw7o7vrpWKV+aQeD7iN/Pwwr0g8+LWGDWRCy3A0c3xfNklpheM/26jgyr8ERDB7JHVm/59DVlkD7LLfI+84ojU4ObiE/PBkrEIZF+9B66cxYcP3smGXOlV5YeoxZFVT5hxt6AaaXMGu1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374034; c=relaxed/simple;
	bh=bGn7JFaAa0NqjNKgy5/xx9u+SB5xZbwf+YSrAK5+T9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRpppZeQhlDP30znFpk1QMqZRdg9Fe1vKXwseMz9h26EMyLtETTkT24FrSGj90+fYDmE/LpI8qfktMj2G11fOnGk5KHZJ1IcxT7I7gcOZObneiDRw512ywusrz+EBIZBle+2bRegnAMwrSJzktQ+0SvsvJKtndjyo5QvbVc/Za4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OleMFJWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AD7C072AA;
	Wed, 17 Apr 2024 17:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713374034;
	bh=bGn7JFaAa0NqjNKgy5/xx9u+SB5xZbwf+YSrAK5+T9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OleMFJWy9AzB9EgdcjG3rG6OJrN9yFqLFGr8R1wQVBplxUobCb58VMw9NliTntuKu
	 J85+6l/yG6qbraxVEW+gJKu+HfTo32X1ev5OgU12htrjQ+66NM1G6tofVxgKBNBVC/
	 unJXfW9C+hXsgQ1Tnr3Ha3cvzt4MBixi2RtaOKJH/37KPAVFq+TFA/ZO6OIHLXcssm
	 PkXZEAEINT5kmuvZ/QP7MYpg1tChdn0niSbwCbHkL7nVxwAYZhC8V7MTmAjyHfvvUs
	 Rnkuk254trPUgvVa97MCU5AxRxxe4cMMhj4wt2aBy8BvAHi/ownCD3RU2i6LlCsibl
	 x34zpTa2Rl9vA==
Date: Wed, 17 Apr 2024 18:13:49 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 10/14] net_sched: sch_fq_pie: implement lockless
 fq_pie_dump()
Message-ID: <20240417171349.GF2320920@kernel.org>
References: <20240415132054.3822230-1-edumazet@google.com>
 <20240415132054.3822230-11-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415132054.3822230-11-edumazet@google.com>

On Mon, Apr 15, 2024 at 01:20:50PM +0000, Eric Dumazet wrote:
> Instead of relying on RTNL, fq_pie_dump() can use READ_ONCE()
> annotations, paired with WRITE_ONCE() ones in fq_pie_change().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/sched/sch_fq_pie.c | 61 +++++++++++++++++++++++-------------------
>  1 file changed, 34 insertions(+), 27 deletions(-)
> 
> diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c

...

> @@ -471,22 +477,23 @@ static int fq_pie_dump(struct Qdisc *sch, struct sk_buff *skb)
>  		return -EMSGSIZE;
>  
>  	/* convert target from pschedtime to us */
> -	if (nla_put_u32(skb, TCA_FQ_PIE_LIMIT, sch->limit) ||
> -	    nla_put_u32(skb, TCA_FQ_PIE_FLOWS, q->flows_cnt) ||

Hi Eric,

I think you missed the corresponding change for q->flows_cnt
in fq_pie_change().

...

