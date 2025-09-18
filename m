Return-Path: <netdev+bounces-224579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2D7B864E8
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A19163BDA
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681022459CF;
	Thu, 18 Sep 2025 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpGr4DRP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4289D21D59C
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217537; cv=none; b=lY5tzqmSbK433F8BSiYme1sKyiD5xowMRbSXnqR+xH+LLYt2kxjv3vUt1iEdi+8ARccp5JZYt6I0t5xBUAHW53HwZRpkyvugHB7BFgdCM8isho6RpaUomUCpdYmwyNPmrXYwdUdUe3i+RjhJ1YW/ep5+elxLlrWzmUaWLKczn10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217537; c=relaxed/simple;
	bh=zvISdH5xzXppGXrL6fXxzCOz51ahDUbBoQe9G6XcVJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoxBlgoFZOSOSJ+SN+TquRVjBnVCvyCHtuTtYK98V8uZFSz/7bovHMC9n8S0jdy5tVXS2zfWWHoOITljPjWitKSQ1xqj8fxl/7ubUgXIIw2QmxC6XtrdFsrD3IDplNgZ8xoO2J52RKMNjQ7iHtU3Ds6anbXeyGrBBBwWH2in0oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpGr4DRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E756BC4CEF0;
	Thu, 18 Sep 2025 17:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758217536;
	bh=zvISdH5xzXppGXrL6fXxzCOz51ahDUbBoQe9G6XcVJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SpGr4DRPlHKOFM3ZYAm2Y5HiV//NH3JTPABpVQ8LBDnJ333aDmloFpJbeFZSMJLcA
	 GcOo0GzK4Ek3LlEu0M2SADIspqIrPIxKg1DfdD0B7eud+H3lDItUcKiRErTxU3s8Pv
	 DpgJ7KbdJnURTDlIYIwGWbKuIdgVteFlM1i+N1DD+ucnjje//8l1cddD6HibJPYRoW
	 CqRupLR3RmBIgDNosxyXnIE6/YloyXXjGLtE2hcDxG++Zm1dzo2px0oUi6Lm2G+t2U
	 ogWrTEOXvoaGlPTHNoNgsriEr8LC+xni5OK323F37A26lvZXAAibiuTx0tH36BAxQg
	 ldGXx3fPiQYSg==
Date: Thu, 18 Sep 2025 19:45:32 +0200
From: Antoine Tenart <atenart@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Antoine Tenart <atenart@kernel.org>, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] net: ipv4: simplify drop reason handling
 in ip_rcv_finish_core
Message-ID: <kkdvcuweqelswndwq6ng445azhvsd4tmoqwu6cobqhbd5aqcqs@ct4jdy7ce22g>
References: <20250918083127.41147-1-atenart@kernel.org>
 <20250918083127.41147-3-atenart@kernel.org>
 <454978a6-41c1-46cc-a51f-0b068238a3f3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454978a6-41c1-46cc-a51f-0b068238a3f3@kernel.org>

On Thu, Sep 18, 2025 at 09:24:01AM -0600, David Ahern wrote:
> On 9/18/25 2:31 AM, Antoine Tenart wrote:
> > diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
> > index 8878e865ddf6..93b8286e526a 100644
> > --- a/net/ipv4/ip_input.c
> > +++ b/net/ipv4/ip_input.c
> > @@ -335,7 +335,6 @@ static int ip_rcv_finish_core(struct net *net,
> >  			goto drop_error;
> >  	}
> >  
> > -	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
> >  	if (READ_ONCE(net->ipv4.sysctl_ip_early_demux) &&
> >  	    !skb_dst(skb) &&
> >  	    !skb->sk &&
> > @@ -354,7 +353,6 @@ static int ip_rcv_finish_core(struct net *net,
> >  				drop_reason = udp_v4_early_demux(skb);
> >  				if (unlikely(drop_reason))
> >  					goto drop_error;
> > -				drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
> >  
> >  				/* must reload iph, skb->head might have changed */
> >  				iph = ip_hdr(skb);
> > @@ -372,7 +370,6 @@ static int ip_rcv_finish_core(struct net *net,
> >  						   ip4h_dscp(iph), dev);
> >  		if (unlikely(drop_reason))
> >  			goto drop_error;
> > -		drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
> >  	} else {
> >  		struct in_device *in_dev = __in_dev_get_rcu(dev);
> >  
> > @@ -391,8 +388,10 @@ static int ip_rcv_finish_core(struct net *net,
> >  	}
> >  #endif
> >  
> > -	if (iph->ihl > 5 && ip_rcv_options(skb, dev))
> > +	if (iph->ihl > 5 && ip_rcv_options(skb, dev)) {
> > +		drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
> >  		goto drop;
> > +	}
> >  
> >  	rt = skb_rtable(skb);
> >  	if (rt->rt_type == RTN_MULTICAST) {
> 
> I do not see any of the cleanup changes requested on v1.

They're all done in a new patch (3/4) in that series as that seemed more
logical, where I could also add a Suggested-by tag.

