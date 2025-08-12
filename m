Return-Path: <netdev+bounces-212696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3165BB219F0
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 02:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2EFA42567E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 00:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6214D2D6607;
	Tue, 12 Aug 2025 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+KHWTL6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2ABB67F
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754959882; cv=none; b=MoVRRxl2LkdMEnL7++vTK5w4nFCj1/znczbTP+aWmkaEAFhE7Dxl2fmiT7TMlA6aMlxmYbYJSCmM57m4bO7J/t2ztKoPVLCQo11AYULqV2j5jEFexlGHUtHz9Hk0JJb19lyt/l9K6qrTayybyJajvO8HT+X0C6GxHPT+PQ5gz1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754959882; c=relaxed/simple;
	bh=t45teGXSVXE5lI+H6F3+dyNBqhh1sp9Ehy3V50xPZrk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZrQblmOHBfQ9oN3tjttRXxE29+zTkmK64l6OuiNzHzIrnZ4H8f3x9Fhd7qe9G+6U8N3+TDmtNOxZK2i2Jj2Jfy6W1ZC0pSRvzKjrJgp6kHhiv8T3ufewOqRzKkYNg6P4g4c76QsvRFnVyth0Lnsj74S1J5auobI8ZxjFYCUMSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+KHWTL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63286C4CEED;
	Tue, 12 Aug 2025 00:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754959881;
	bh=t45teGXSVXE5lI+H6F3+dyNBqhh1sp9Ehy3V50xPZrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T+KHWTL6tJq3g60Ok7Gq2t9JLlO2HhlHJCmhlYEhV3YVLeGbWScgCydgnovboB9lO
	 4AizhI3OF/sVrQwCZHZt3tmC/KDI/5mVkbAnN6YznAFdddTTt7oNp8ioAtXW9vqQnu
	 HHdlN8GEfyauviYjzGVZD7nfRwZjReq0LRKkVfJ1enV2GO650xFZfnlvESCO83rAcl
	 Vy3TaZCFwLVAqbFSFAUwNWaOOAjXHyw2yYwlMtEwsfe6eoxkITr0N5KWuwsvYnyK+1
	 Fd7LXvoG/fMDOL6Np4mEspJIgX07T2bVOi6UVhpJXYkoxQBWEskGLvfhbPLHm5Oxgv
	 +HGULVaKwwkYA==
Date: Mon, 11 Aug 2025 17:51:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 pabeni@redhat.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io,
 victor@mojatatu.com
Subject: Re: [PATCH net v4 1/2] net/sched: Fix backlog accounting in
 qdisc_dequeue_internal
Message-ID: <20250811175120.7dd5b362@kernel.org>
In-Reply-To: <Xd_A9IO0dh4NAVigE2yIDk9ZbCEz4XRcUO1PBNl2G6kEZF6TEAeXtDR85R_P-zIMdSL17cULM_GdmijrKs84RdMewdZswMDCBu5G7oBrajY=@willsroot.io>
References: <20250727235602.216450-1-will@willsroot.io>
	<20250808142746.6b76eae1@kernel.org>
	<n-GjVW0_1R1-ujkLgZIEgnaQKSsNtQ9-7UZiTmDCJsy1EutoUtiGOSahNSxpz2yANsp5olbxItT2X9apTC9btIRepMGAZZVBqWx6ueYE5O4=@willsroot.io>
	<20250811082958.489df3fa@kernel.org>
	<-8f3jdd-5pxHr0GW-uu8VtTzqDKDOyJohJ-soIwzRyqJUub186VYIxqNoGOTh8Oxtu1U0CEDl5h3N1c1D1jbn7nIlXUrNo55CHK5KcT23c4=@willsroot.io>
	<20250811102449.50e5f416@kernel.org>
	<Xd_A9IO0dh4NAVigE2yIDk9ZbCEz4XRcUO1PBNl2G6kEZF6TEAeXtDR85R_P-zIMdSL17cULM_GdmijrKs84RdMewdZswMDCBu5G7oBrajY=@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 17:51:39 +0000 William Liu wrote:
> > This sort of separation of logic is very error prone in general.
> > If you're asking for a specific bug that would exist with your
> > patch - I believe that two subsequent fq_codel_change() calls,
> > first one reducing the limit, the other one not reducing (and
> > therefore never invoking dequeue) will adjust the backlog twice.
> 
> In that case, I think the code in the limit adjustment while loop
> never run, so the backlog reduction would only happen with arguments
> of 0.

True.

> But yes, I agree that this approach is not ideal.
> > As I commented in the previous message - wouldn't counting the
> > packets we actually dequeue not solve this problem? smth like:
> > 
> > pkts = 0;
> > bytes = 0;
> > while (sch->q.qlen > sch->limit ||
> > 
> > q->memory_usage > q->memory_limit) {
> > 
> > struct sk_buff *skb = qdisc_dequeue_internal(sch, false);
> > 
> > pkts++;
> > bytes += qdisc_pkt_len(skb);
> > rtnl_kfree_skbs(skb, skb);
> > }
> > qdisc_tree_reduce_backlog(sch, pkts, bytes);
> > 
> > ? "Conceptually" we are only responsible for adjusting the backlog
> > for skbs we actually gave to kfree_skb().  
> 
> I think the issue here is qdisc_dequeue_internal can call the actual
> dequeue handler, and fq_codel_dequeue would have already made a
> qdisc_tree_reduce_backlog call [1] when cstats.drop_count is
> non-zero. Wouldn't we be double counting packets and bytes for
> qdisc_tree_reduce_backlog after the limit adjustment loop with this
> approach?

AFAICT only if the backlog adjustment is using the prev_qlen,
prev_backlog approach, which snapshots the backlog. In that case,
yes, the "internal drops" will mess up the count. 

My naive mental model is that we're only responsible for adjusting
the backlog for skbs we actually dequeued. IOW the skbs that
qdisc_dequeue_internal() returned to the "limit trimming loop".
Because we are "deleting" them, potentially in the middle of
a qdisc hierarchy. If the qdisc decides to delete some more, 
its on the hook for adjusting for those portions.

I can't find any bugs in your prev_* snapshot approach, but it does
feel like a layering violation to me.

