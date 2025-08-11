Return-Path: <netdev+bounces-212545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C514B2130F
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 19:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C289626317
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B41529BDB8;
	Mon, 11 Aug 2025 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="at+27e7j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377702690D1
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933091; cv=none; b=CwN0RsPe90so1LzuZX7eWq6a/xk5ku4XEQ+dK7HOAFN5NCH4jmdSVKLqOHVF9j/veTmfhXXJcJkZRUdcaPDzNTQx7JuItxqyRGHQR/8+uh6d4pBBGRWjLVG24xZuCyAErJsu9v5Fwqfkrc+KLh91A30ULOqxrx0MUJrUr68WCaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933091; c=relaxed/simple;
	bh=dEeQo7VUqFuiey9ka40670HdBJK1WVPh0QbAB5Rknec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9QhQllDd/iAJ5EUCYfs/LJz7/iv/Dq7ydZoiDcGntZNrdK/lHM17530DWFmEtyJUnTllIdAp2DcztLjye2/0MYfVMAMzITvrBXmJpwtiaB7BvgqYu2FTEiP74Q2IYwLBYVQiQNp+kQAMY/aCb7FmA7Rm+kOhez8Iy7MCNvMXpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=at+27e7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E85C4CEF5;
	Mon, 11 Aug 2025 17:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754933090;
	bh=dEeQo7VUqFuiey9ka40670HdBJK1WVPh0QbAB5Rknec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=at+27e7jDB76eJ7205QrZu/hoLxvmSqSnKZlAbA5eBcPJ5TAMh9hg+ebF2wXuDAyz
	 7FtreHSALMahB3sW8PJ1E6H4SOQItFjzVu8AaUIAbSaYRUsx3cHjb9kDZavu1Gnk9F
	 YcTY+nXffbAtOYMvGS0e7CJYwm7OhaXgLEYBt65hSqBGaqYDwtlFiSVttdY0BMaAhN
	 BtcHUXmx/g3NjiJ2cjqcqvYCqLujckE6y0X6OWOMA8GwZ+AQHLW/N5ukFivon7dwAQ
	 4NoqHujLd19YaR+30P+gDv2ffzLFCTi7pzkrSD1k+khq0YFedXKwpgAwl4nwLlJO8G
	 vyz52dH1Ufi7g==
Date: Mon, 11 Aug 2025 10:24:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 pabeni@redhat.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io,
 victor@mojatatu.com
Subject: Re: [PATCH net v4 1/2] net/sched: Fix backlog accounting in
 qdisc_dequeue_internal
Message-ID: <20250811102449.50e5f416@kernel.org>
In-Reply-To: <-8f3jdd-5pxHr0GW-uu8VtTzqDKDOyJohJ-soIwzRyqJUub186VYIxqNoGOTh8Oxtu1U0CEDl5h3N1c1D1jbn7nIlXUrNo55CHK5KcT23c4=@willsroot.io>
References: <20250727235602.216450-1-will@willsroot.io>
	<20250808142746.6b76eae1@kernel.org>
	<n-GjVW0_1R1-ujkLgZIEgnaQKSsNtQ9-7UZiTmDCJsy1EutoUtiGOSahNSxpz2yANsp5olbxItT2X9apTC9btIRepMGAZZVBqWx6ueYE5O4=@willsroot.io>
	<20250811082958.489df3fa@kernel.org>
	<-8f3jdd-5pxHr0GW-uu8VtTzqDKDOyJohJ-soIwzRyqJUub186VYIxqNoGOTh8Oxtu1U0CEDl5h3N1c1D1jbn7nIlXUrNo55CHK5KcT23c4=@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 16:52:51 +0000 William Liu wrote:
> > > Can you elaborate on this?
> > > 
> > > I just moved the reset of two cstats fields from the dequeue handler
> > > epilogue to the prologue. Those specific cstats fields are not used
> > > elsewhere so they should be fine,  
> > 
> > 
> > That's the disconnect. AFAICT they are passed to codel_dequeue(),
> > and will be used during normal dequeue, as part of normal active
> > queue management under traffic..
> >   
> 
> Yes, that is the only place those values are used. From my
> understanding, codel_dequeue is only called in fq_codel_dequeue. So
> moving the reset from the dequeue epilogue to the dequeue prologue
> should be fine as the same behavior is kept - the same values should
> always be used by codel_dequeue.
> 
> Is there a case I am not seeing? If so, I can just add additional
> fields to the fq_codel_sched_data, but wanted to avoid doing that for
> this one edge case.

This sort of separation of logic is very error prone in general.
If you're asking for a specific bug that would exist with your 
patch - I believe that two subsequent fq_codel_change() calls,
first one reducing the limit, the other one _not_ reducing (and
therefore never invoking dequeue) will adjust the backlog twice.

As I commented in the previous message - wouldn't counting the
packets we actually dequeue not solve this problem? smth like:

	pkts = 0;
	bytes = 0;
 	while (sch->q.qlen > sch->limit ||
 	       q->memory_usage > q->memory_limit) {
 		struct sk_buff *skb = qdisc_dequeue_internal(sch, false);
 
		pkts++;
		bytes += qdisc_pkt_len(skb);
 		rtnl_kfree_skbs(skb, skb);
 	}
	qdisc_tree_reduce_backlog(sch, pkts, bytes);

? "Conceptually" we are only responsible for adjusting the backlog
for skbs we actually gave to kfree_skb(). 

