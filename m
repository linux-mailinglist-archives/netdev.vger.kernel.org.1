Return-Path: <netdev+bounces-223399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459FCB59059
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00533521725
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 08:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB8D286426;
	Tue, 16 Sep 2025 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTjqz7u3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FC828934D
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758010997; cv=none; b=EhHCzjKCD+JesqYEgg1e3bF7r08rUAoqioW0RJ+WCHDaWBXN0/ais4cKgyWq7O/n+xBSd2d6d2yESrgEISVe8mtr4u+ozdisI/pHbTeiMMabDoxmw1jw6Fvm1Rh3qRHZWlxEdz4mj8UZvpLsUtZYn5k+bih1vZBS79NlakWwerU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758010997; c=relaxed/simple;
	bh=F6J3ecA3YU+xofnhmq52getbngCn5rpUmEv3zWGV3gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiWUu41kWfZiEr5r4c2qzIWGDr9z2PR27Ap51yotrt7hyNAf19rGca1NM0gwWmMaHTcmY8mfGeH1Dccaa2Y7dNGfbrS3Hl3IEPELUjAj3IrNitDNdNNd8njOu1T/ohOFjvjK53rc1NGqXQg8qNCS3tm/CAP3LY4rz/y8puPPNto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTjqz7u3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1668C4CEEB;
	Tue, 16 Sep 2025 08:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758010995;
	bh=F6J3ecA3YU+xofnhmq52getbngCn5rpUmEv3zWGV3gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LTjqz7u3YJoPgqTq4a3mG/24nDNTQUgi8A0GZQlsOJU28nHgAWshkZxZlvER7lYa4
	 rAbOvAcJIjfUgMXwxX6Atn8RLRuJDfNYQNky8BBXEr7vHXw4b4jMGZ+FwspgNnviIa
	 k8JeoliUSYDzmy9lBjsAPQUzWG9sTf7YDYXYNjG5g1Rv0CwXk0FBfcJUWPDWb/YYbv
	 X6bql3gbSlULYIRmXSTtKQlmQttGdAdcHVAj73iYEn9enilGK+qPSToUbhVosC75W3
	 ZnVRshUPTvs9pupXqeEay6VHGZz7xlHRLrAQ1P8vtz12OKP/VXl6+db+2n/7YC++8s
	 bt7GQs+ruvr4Q==
Date: Tue, 16 Sep 2025 10:23:11 +0200
From: Antoine Tenart <atenart@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Antoine Tenart <atenart@kernel.org>, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: ipv4: simplify drop reason handling in
 ip_rcv_finish_core
Message-ID: <xr5bpap2rxx2so5laibrpkpszdcboxqjclp3wovf347cqb4vcj@2rl5e7v2u6zv>
References: <20250915091958.15382-1-atenart@kernel.org>
 <20250915091958.15382-3-atenart@kernel.org>
 <4aa939a8-256e-4045-bb4a-01a380a1c519@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aa939a8-256e-4045-bb4a-01a380a1c519@kernel.org>

On Mon, Sep 15, 2025 at 09:49:38AM -0600, David Ahern wrote:
> On 9/15/25 3:19 AM, Antoine Tenart wrote:
> > diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
> > index 8878e865ddf6..93b8286e526a 100644
> > --- a/net/ipv4/ip_input.c
> > +++ b/net/ipv4/ip_input.c
> > @@ -335,7 +335,6 @@ static int ip_rcv_finish_core(struct net *net,
> >  			goto drop_error;
> >  	}
> >  
> > -	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
> 
> since you are touching this function for drop reason cleanups,
> drop_reason should be changed from `int` to `enum skb_drop_reason`
> 
> >  	if (READ_ONCE(net->ipv4.sysctl_ip_early_demux) &&
> >  	    !skb_dst(skb) &&
> >  	    !skb->sk &&
> > @@ -354,7 +353,6 @@ static int ip_rcv_finish_core(struct net *net,
> >  				drop_reason = udp_v4_early_demux(skb);
> >  				if (unlikely(drop_reason))
> 
> This should be `drop_reason != SKB_NOT_DROPPED_YET`

Makes sense, will do in v2. Thanks!

