Return-Path: <netdev+bounces-79646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669B487A5F0
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 11:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A2D282192
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 10:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BF03B299;
	Wed, 13 Mar 2024 10:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBYuKTvc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708341B298
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 10:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325963; cv=none; b=VVQtZvYWt+CYJA+Libq2B3ugLoDrX3zsxIEsUJ/Sr14ony/mw6f0kKjXZWXwh4EUpmjfpoEn4J0hy/ODXrtwkzWjHDj/qtZSem08jJFJgIL9CynK9vu16vynfgowqWeFdj5AN+y+ZlWp0FoJV+HV5GVU1gP4QhPlo2XTY2rK94Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325963; c=relaxed/simple;
	bh=820ZHoXzuLaboM5PK8MjSP3EKOAlDtuGMQouEyuY76Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+dCPsXZf6dFxCtrlknY8Y5IC42L0lrY1/y2sGPF2gFmzHQ/oV082kpEE0cT97hfAcoAd/76XlDuZuqyFoEyycIcsGdOepdbg3cbbNa5Tb0Hx+y8atwY8thdo+Qg/gbUW8Rhguo8FAQJ0sa0YQZSMGjc7IRHNxewOlSziHk2LJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBYuKTvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B28CC433F1;
	Wed, 13 Mar 2024 10:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710325962;
	bh=820ZHoXzuLaboM5PK8MjSP3EKOAlDtuGMQouEyuY76Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GBYuKTvchAyh+oq5MZKIJvt3N3oCMo0ca4ooCmPySnNAIBl1gqgawZ4XNTHhmfi8N
	 rF8ftXsVnpNqrx6wPnm2oP+gplbO/ixCy6CcMJqyYCHy99MguzjqEvOdd6EuAvE8vR
	 1WT9QmeU4dJLwTrax5YC4ypla7mOgMu9YAa/wMqiS7yVQBpscXh0HwUxnMCrP5CPSV
	 qNfUyE8qHb6mYxmxmJFO3ECTtfhB9YVE9PNJmjbIwTNvpp5YZUcv47c5u2GroetENb
	 Az2y9pIIuxTLgMF1uZcQhf0xlMnUYWiFkslZsqTmkH3VXTkdaDzCCSmQD2zT1BRQ+/
	 v/Ejh7tfWYGrQ==
Date: Wed, 13 Mar 2024 12:32:38 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH xfrm] xfrm: Allow UDP encapsulation only in offload modes
Message-ID: <20240313103238.GY12921@unreal>
References: <3d3a34ffce4f66b8242791d1e6b3091aec8a2c25.1710244420.git.leonro@nvidia.com>
 <37a7a9fb76f295cf8babb8251dea0033add4c40b.camel@redhat.com>
 <ZfF7M7C/EAu8Umb0@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfF7M7C/EAu8Umb0@gauss3.secunet.de>

On Wed, Mar 13, 2024 at 11:08:51AM +0100, Steffen Klassert wrote:
> On Tue, Mar 12, 2024 at 01:24:31PM +0100, Paolo Abeni wrote:
> > On Tue, 2024-03-12 at 13:55 +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > The missing check of x->encap caused to the situation where GSO packets
> > > were created with UDP encapsulation.
> > > 
> > > As a solution return the encap check for non-offloaded SA.
> > > 
> > > Fixes: 9f2b55961a80 ("xfrm: Pass UDP encapsulation in TX packet offload")
> > 
> > Should be:
> > 
> > Fixes: 983a73da1f99 ("xfrm: Pass UDP encapsulation in TX packet offload")
> > 
> > @Steffen: I guess you want to apply it first in your tree and send it later as PR?
> > In such case, could you please adjust the fixes hash while at it?
> 
> Yes, I'll adjust the fixes tag.
> 

Thanks

