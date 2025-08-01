Return-Path: <netdev+bounces-211400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2796BB18892
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 23:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA0C1884BB3
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 21:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F016928A724;
	Fri,  1 Aug 2025 21:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcQQ4o1S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C872221CC5B
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 21:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754082865; cv=none; b=GP15SK5W0EiiVl4kVBeFVrZcS+KYKayiW57q5M3IZeZ+NwaAWAVM6wh2phmAwM8z0K2D7JE8m+trEVdWb5gdz/sDmgVLGKP3wi8o4FlhDO+H5jaqxJvNbQLS7KBHC6N/x+8LBeL35kqhqvcoU7nFqhYIgN1XmILYvaHxCltDPZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754082865; c=relaxed/simple;
	bh=y1AEVjbsL2BS+WnEoouveeKQFBU8EqTaIaPX7iArLTo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7XkUHL7AT574b76ZqVhH0qyiVPDv4SIKLBzo6ouEP9X1d2ds/R+IkBPzS+PuX0fPv9EfBGsdrNlMMmwZfuN1zaL6WoqdKjzdj8GOAZIBAG+/IvSM7/06FLOaXSPdLA3seTPS4KU0H/gGJCeDXILdkhBWu6PpM9bYbOkZVN/W1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcQQ4o1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2681C4CEE7;
	Fri,  1 Aug 2025 21:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754082865;
	bh=y1AEVjbsL2BS+WnEoouveeKQFBU8EqTaIaPX7iArLTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kcQQ4o1SI9hAapXtV3G0UtZLWUl0cQU5LoCmvmz5oUxJTiAZNJM2fIpJeMEd7SFLw
	 E1fI6r1u0jguQ0hXOsss/0CWi+6UJK2EnS6mUAdsT8h9wns/SrTpe4UsjX21dMHEu7
	 YYSwnYyDIjDvG0RIr1nJiksIvhiJubyi8EPhu1tt5oyCS/0j4E7RO85H5bLZLLIN64
	 RyWllaCKPR2T0zLLW+8eSBzeJy0GU5ybtU7+PrGDjOj8f/bM9Ra71SINTj0IMxs1ZB
	 uf7DcS3HRptkZMsb9+lVsdYnr96ipuLwp4xI27Zhf5Uxbc12hsdIC2ZY7opq0U80wb
	 tujSEOGJQ353g==
Date: Fri, 1 Aug 2025 14:14:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Breno Leitao <leitao@debian.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org,
 syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 net] netdevsim: Fix wild pointer access in
 nsim_queue_free().
Message-ID: <20250801141424.4531c205@kernel.org>
In-Reply-To: <CAAVpQUCDNGxtk2Hu0P6f0Ec2-2bOdn9H=uq_hpZ3_P-zcxoiLw@mail.gmail.com>
References: <20250731184829.1433735-1-kuniyu@google.com>
	<CANn89iJKYPAMR+ofaJLsQpew2E-0DH4eLh5-QF7tB56-8BfWxg@mail.gmail.com>
	<CAAVpQUCDNGxtk2Hu0P6f0Ec2-2bOdn9H=uq_hpZ3_P-zcxoiLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Aug 2025 09:29:49 -0700 Kuniyuki Iwashima wrote:
> > >         hrtimer_cancel(&rq->napi_timer);
> > > -       local_bh_disable();
> > > -       dev_dstats_rx_dropped_add(dev, rq->skb_queue.qlen);
> > > -       local_bh_enable();
> > > +
> > > +       if (likely(dev->reg_state != NETREG_UNINITIALIZED)) {  
> >
> > I find this test about reg_state a bit fragile...
> >
> > I probably would have made dev_dstats_rx_dropped_add() a bit stronger,
> > it is not used in a fast path.  
> 
> I thought I should avoid local_bh_disable() too, but yes,
> it's unlikely and in the slow path.
> 
> I'll use the blow diff in v2.

Option 2 :

	if (rq->skb_queue.qlen)
		dev_dstats_rx_dropped_add(dev, rq->skb_queue.qlen);

since there can't be any packets, yet. Up to you.

