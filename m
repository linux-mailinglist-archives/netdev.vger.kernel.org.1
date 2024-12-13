Return-Path: <netdev+bounces-151773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9DD9F0D49
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76509168493
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81ED1E048A;
	Fri, 13 Dec 2024 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcWZgopb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20001E00A0
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734096556; cv=none; b=NMVUWz7DcF3j16/XGH2oc8j3Pks2zJ+gaMUcXE79G4XW2SYDc1w53xbhTrUMXYOZv5fJG3fMX9Z1xfu3QQCNYJxEaB4YLkvmTvhuKOLtf0ZnaUUWkUhhynjHWG8AWT/qhuaFWpSXz3xY1c84fnoGVNL0qTtoxEO8rs6p0F95zoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734096556; c=relaxed/simple;
	bh=1UH63vozAknb3lvv3ROg0lNUUI0xn9mnSMSJQ+BSD2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJlCRRvr3D2n3XXYvOEjEbw402Qrmi5Rx21r381JuRtFrBe3x11oZYWEchTxeNgFCFZpddydTCP/Zofdg+hBre9qsha3EmxWmJRDcAyQV4mqvYpXVKMkbJUubPVCoC6E+bWCHl/Z1LQ3tQatTfAH7VtFHHJWSGs9JgHqw1eoy5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcWZgopb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01543C4CEE1;
	Fri, 13 Dec 2024 13:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734096555;
	bh=1UH63vozAknb3lvv3ROg0lNUUI0xn9mnSMSJQ+BSD2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RcWZgopbSqs++Rx729/fWEa9e+zf+Gtx7TyJ/uRlyrtw38dBsqV3Zoekhf3YcLOPy
	 G4F1zv+cOi9R1HI1NZSBaOnlICcmvwrUW5D8+3UQeh2Alcbaun66XOufYT61MHx5DK
	 D89Nv92f1yYhEMsnIX8Mj47JAiXRB9MRdUhfk2wem089lldhC85HKlZMsbvV+AZhlg
	 rmPHZZx+P4MWZielu+BAzh18v9W7/3SJ4kQGHIA1A/zye1eJNxdJm561MDY51g5NxU
	 580ZO7biHwsO+pbvWVWMfxues1wq2I2egJrj6nDBHNT9cGmCbunAGXK9P9kfkYEcpc
	 VBFuSae8FsSXQ==
Date: Fri, 13 Dec 2024 13:29:10 +0000
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, rafal@milecki.pl,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: bgmac-platform: fix an OF node reference
 leak
Message-ID: <20241213132910.GA561418@kernel.org>
References: <20241212023256.3453396-1-joe@pf.is.s.u-tokyo.ac.jp>
 <20241213105508.GL2110@kernel.org>
 <b8604925-d3fb-4994-893c-d34e6185e950@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8604925-d3fb-4994-893c-d34e6185e950@lunn.ch>

On Fri, Dec 13, 2024 at 01:04:42PM +0100, Andrew Lunn wrote:
> > Hi Joe,
> > 
> > I agree this is a problem and that it was introduced by the
> > cited commit. But I wonder if we can consider a different approach.
> > 
> > I would suggest that rather than using __free the node is explicitly
> > released. Something like this (untested):
> > 
> > 	struct device_node *phy_node;
> > 
> > 	...
> > 
> > 	phy_node = of_parse_phandle(np, "phy-handle", 0);
> > 	if (phy_node) {
> > 		of_node_put(phy_node);
> > 		bgmac->phy_connect = platform_phy_connect;
> > 	} ...
> > 
> > That is, assuming that it is safe to release phy_node so early.
> > If not, some adjustment should be made to when of_node_put()
> > is called.
> > 
> > This is for several reasons;
> > 
> > 1. I could be wrong, but I believe your patch kfree's phy_node,
> >    but my understanding is that correct operation is to call
> >    of_node_put().
> 
> Hi Simon
> 
> I _think_ that is wrong. More of the magic which i don't really
> like. The cleanup subsystem has to be taught all the types, and what
> operation to perform for each type. Despite the name __free(), i think
> it does actually call of_node_put(). The magic would be more readable
> if it was actually __put(), not __free().

Thanks, TIL.

> > 2. More importantly, there is a preference in Newkorking code
> >    not to use __free and similar constructs.
> > 
> >      "Low level cleanup constructs (such as __free()) can be used when
> >       building APIs and helpers, especially scoped iterators. However,
> >       direct use of __free() within networking core and drivers is
> >       discouraged. Similar guidance applies to declaring variables
> >       mid-function.
> 
> And this is a good example of why.
> 
> 	Andrew
> 

