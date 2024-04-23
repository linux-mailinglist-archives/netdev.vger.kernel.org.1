Return-Path: <netdev+bounces-90532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 728D38AE682
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 14:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30001F217E5
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1205F8528B;
	Tue, 23 Apr 2024 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="e+RKrM0k"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAAB84DE1
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876172; cv=none; b=FLbwFXWjq53I7Y6rQ80taaq9gw9knMTinJsFq+M+/2497w2CXGlwF3jNETpfLblgCEkTtGm7DEY9byEOvOATCQIlkMeEvra8VuHNRxJ7MifBrGEi4TkNnkbujYB7Tfq5TLpf6cns+XbKYFQCs5GiCUiBpwOibiSARKX9EHJDxHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876172; c=relaxed/simple;
	bh=UuDb+7BpQN/pV3AolBJpCJNk3sXISEAIsPO/vLG/ZX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjnwTT0V7w0jAAMbeCdXUu5Eo+4y1FU0SA7JNizL8hidAavimxs+EpxKAHEbp4AafxTmxubb4mgDIpjpk4F97shCISNYpNx8hzgNIA2Uiop1SM84YvZobVLoqDsMs4zAvi98MGPM14Obd/njd2K+4cGNjclmWYwnbal3w5uQXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=e+RKrM0k; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: c48390d4-016e-11ef-bfb8-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c48390d4-016e-11ef-bfb8-005056ab378f;
	Tue, 23 Apr 2024 14:41:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=ktvZ7FUrcjKbM13sHm/Ppn36oa3EPxYXGFr+XCYlgPo=;
	b=e+RKrM0ktiNQVLofzhXeBJFGZXiejjV+oN3BZlYgXYDfL4OhDmTwyl9omfYcFlBQmQSg0MkWLNYqQ
	 qyX2bTQ0YeHJrkqmvQtLZeg12Uoyt81Q0cN2RZzjon8T0LG6IhqvjnqkLR53+MJpMRX3qi3BhbYi0b
	 l+2Kfk7cl9RZI9XU=
X-KPN-MID: 33|OHSpMsPj0u4NAZVfAxCQVhlCV54eibU7Y8BphXZxEyq2c782L0xn/umCslHNmEE
 mVM/x8mZOmUm3H+cpwIltufF172q13Qxu1GLmczC+t+0=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|Pz9JZepgmW5nSIKHlJ/3nDwTadFe5u/qsYiD7tEzKX8ABtFLD1/IxzNMzry97tP
 SYRqohppFeo7knRcaoi+7xQ==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id f8933d7b-016e-11ef-8d59-005056ab7447;
	Tue, 23 Apr 2024 14:42:41 +0200 (CEST)
Date: Tue, 23 Apr 2024 14:42:39 +0200
From: Antony Antony <antony@phenome.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antony Antony <antony@phenome.org>,
	Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Leon Romanovsky <leon@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [PATCH ipsec-next v10 1/3] xfrm: Add Direction to the SA in or
 out
Message-ID: <Ziesv_sLWXqnZVoO@Antony2201.local>
References: <0e0d997e634261fcdf16cf9f07c97d97af7370b6.1712828282.git.antony.antony@secunet.com>
 <Zh0b3gfnr99ddaYM@hog>
 <Zh4kYUjvDtUq69-h@Antony2201.local>
 <Zh44gO885KtSjBHC@hog>
 <ZiWNh-Hz9TYWVofO@Antony2201.local>
 <ZiYq729Q1AF2Xq8M@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiYq729Q1AF2Xq8M@hog>

Hi Sabrina,
On Mon, Apr 22, 2024 at 11:16:31AM +0200, Sabrina Dubroca via Devel wrote:
> 2024-04-22, 00:04:55 +0200, Antony Antony wrote:
> > Hi Sabrina,
> > 
> > On Tue, Apr 16, 2024 at 10:36:16AM +0200, Sabrina Dubroca wrote:
> > > 2024-04-16, 09:10:25 +0200, Antony Antony wrote:
> > > > On Mon, Apr 15, 2024 at 02:21:50PM +0200, Sabrina Dubroca via Devel wrote:
> > > > > 2024-04-11, 11:40:59 +0200, Antony Antony wrote:
> > > > > > diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> > > > > > index 6346690d5c69..2455a76a1cff 100644
> > > > > > --- a/net/xfrm/xfrm_device.c
> > > > > > +++ b/net/xfrm/xfrm_device.c
> > > > > > @@ -253,6 +253,12 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
> > > > > >  		return -EINVAL;
> > > > > >  	}
> > > > > > 
> > > > > > +	if ((xuo->flags & XFRM_OFFLOAD_INBOUND && x->dir == XFRM_SA_DIR_OUT) ||
> > > > > > +	    (!(xuo->flags & XFRM_OFFLOAD_INBOUND) && x->dir == XFRM_SA_DIR_IN)) {
> > > > > > +		NL_SET_ERR_MSG(extack, "Mismatched SA and offload direction");
> > > > > > +		return -EINVAL;
> > > > > > +	}
> > > > > 
> > > > > It would be nice to set x->dir to match the flag, but then I guess the
> > > > > validation in xfrm_state_update would fail if userspaces tries an
> > > > > update without providing XFRMA_SA_DIR. (or not because we already went
> > > > > through this code by the time we get to xfrm_state_update?)
> > > > 
> > > > this code already executed from xfrm_state_construct.
> > > > We could set the in flag in xuo when x->dir == XFRM_SA_DIR_IN, let me think 
> > > > again.  May be we can do that later:)
> > > 
> > > I mean setting x->dir, not setting xuo, ie adding something like this
> > > to xfrm_dev_state_add:
> > > 
> > >     x->dir = xuo->flags & XFRM_OFFLOAD_INBOUND ? XFRM_SA_DIR_IN : XFRM_SA_DIR_OUT;
> > > 
> > > xuo will already be set correctly when we're using offload, and won't
> > > be present if we're not.
> > 
> > Updating with older tools may fail validation. For instance, if a user creates
> > an SA using an older iproute2 with offload and XFRM_OFFLOAD_INBOUND flag 
> > set, the kernel sets x->dir = XFRM_SA_DIR_IN. Then, if the user wants to 
> > update this SA using the same older iproute2, which doesn't allow setting 
> > dir, the update will fail.
> 
> I'm not sure it would, since as you said xfrm_state_construct would
> have set x->dir based on XFRM_OFFLOAD_INBOUND. But if that's the case,
> then that can be added later, because it would not change any behavior.
> 
> > However, as I proposed, if SA dir "in" and offload is enabled, the kernel
> > could set xuo->flags &= XFRM_OFFLOAD_INBOUND to avoid double typing.
> 
> Do you mean in iproute?

I was thinking kernel. Then the API would be simple iproute2 or *swans.

ip xfrm state .... dir in offload dev mlx0 dir in

notice  "dir in" twice.  this can be tweaked later:) However, this would 
work only with newer kernels.

> 
> On the kernel side, xuo has to be provided when offloading, and the
> meaning of (xuo->flags & XFRM_OFFLOAD_INBOUND) is well defined (0 =
> out, !0 = in). xuo->flags & XFRM_OFFLOAD_INBOUND == 0 with SA_DIR ==
> IN must remain an invalid config.

yes I agree.

