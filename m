Return-Path: <netdev+bounces-196398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09071AD478C
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 02:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7761D189E5CC
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 00:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F07C8CE;
	Wed, 11 Jun 2025 00:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tB4tsyrl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1C75695
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 00:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749602752; cv=none; b=Yz7Bm9lWpMTJgcomcILyt02Rfy1lZIYOZK3MiifACSOlcHZeKu0ISKCAtIqF2txld5dHoEfdxK4TAmdpC/FGKiQK6G2k67YxUwvNmw93DfQ7JaInmZt5SV4ifsiEpIZiTvVKuVPTNtEmRAqgxzGRNrUlfo6Z56P3F8MGIfabUAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749602752; c=relaxed/simple;
	bh=ko/c9xMCIxvHYGJiPQ7QkhsRo70tGbmCN3R8LmOuYj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxod0lrY7TXV+K1QfeZXh/oFUDMlzvflp3iY1kUS2g1B4dr0M6WGTltHPnmR5ldGptn4lkfbbs9Xai4yw/gfYEWDLHu3OUXRGBQ2hsZ9KaAUe2HLCTQxLPq9Isief7CetP5MJx4AYjdgrmKS2xGTxLgtemppcmGHEmKOILBjkmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tB4tsyrl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94C2C4CEED;
	Wed, 11 Jun 2025 00:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749602752;
	bh=ko/c9xMCIxvHYGJiPQ7QkhsRo70tGbmCN3R8LmOuYj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tB4tsyrljIXMV6CyCfA/Q0CdeqRTTrZinlPICVBrZll06bf2j2R5Jq0U7WxqWCuW6
	 0WpYOTBDt8ypfh4SG/nD4wlwiaXrp1NfQVPNAWWQUfR7fgzsp4hXpwHHjPPBHc/Ly3
	 VbAc7KPMB0eZxYs+lYbXSC1nkpJRIGDNtgs6UugE4U9fATGSdzAMHqUzUw4LCshugA
	 qGHxJuLPjexS2Hk3++DE5u2mtF1jG8XAeJNiiVAakx3Dy8BK1EePe401Sp5mK/jY+i
	 3oYiadFlAknHXzltCMysJD+zTD31NzAAcEkpRDREt6xelT7wIqbYkRycZwDNRJtg5p
	 vFD2CXetFfc0A==
Date: Tue, 10 Jun 2025 17:45:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Baron <jbaron@akamai.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, kuniyu@amazon.com
Subject: Re: [PATCH net-next] netlink: Fix wraparounds of sk->sk_rmem_alloc
Message-ID: <20250610174550.54c0d594@kernel.org>
In-Reply-To: <f7c398f4-ea06-495c-b310-cae3c731cb4b@akamai.com>
References: <20250609161244.3591029-1-jbaron@akamai.com>
	<20250610160946.10b5fb7d@kernel.org>
	<f7c398f4-ea06-495c-b310-cae3c731cb4b@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 19:36:00 -0400 Jason Baron wrote:
> >>   	nlk = nlk_sk(sk);
> >> +	rmem = atomic_read(&sk->sk_rmem_alloc);
> >> +	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
> >> +	size = skb->truesize;  
> > 
> > I don't see a reason to store skb->truesize to a temp variable, is
> > there one?  
> 
> 
> I only stored skb->truesize to 'size' in the first bit of the patch 
> where skb->truesize is not re-read and used a 2nd time. The other cases 
> I did use skb->truesize. So if you'd prefer skb->truesize twice even in 
> this first case, let me know and I can update it.

Weak preference towards not using a temp variable.
Fewer indirections make the code easier to grok IMHO.

> > Actually rcvbuf gets re-read every time, we probably don't need a temp
> > for it either. Just rmem to shorten the lines.
> >   
> >> -	if ((atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
> >> -	     test_bit(NETLINK_S_CONGESTED, &nlk->state))) {
> >> +	if (((rmem + size) > rcvbuf) ||  
> > 
> > too many brackets:
> > 
> > 	if (rmem + skb->truesize > READ_ONCE(sk->sk_rcvbuf) ||
> >  
> 
> So the local variables function to type cast sk->sk_rmem_alloc and 
> sk->sk_rcvbuf to 'unsigned int' instead of their native type of 'int'. I 
> did that so that the comparison was all among the same types and didn't 
> have messy explicit casts to avoid potential compiler warnings. It 
> seemed more consistent with the style of the below patch I referenced in 
> the commit:
> 
> 5a465a0da13e ("udp: Fix multiple wraparounds of sk->sk_rmem_alloc.")

Ah, I see. Missed that when looking at the quoted commit as the temp
variables already existed there. Maybe add a comment like:

	/* READ_ONCE() and implicitly cast to unsigned int */

? Up to you.

