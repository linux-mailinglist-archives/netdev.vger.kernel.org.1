Return-Path: <netdev+bounces-116554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A75794AE28
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 18:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6A3281B65
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6C312D1EA;
	Wed,  7 Aug 2024 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2swgCR/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456A87442F
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723048214; cv=none; b=pTOIHWn/1aFKSzIrecsrY5TwKDua/fnOJTa45wM8gA6Bd+Rix8En47bqnp0Csi5lRrpR0UWESJDBptl+NjbLhVeJN3mFd3aVY3SwsvN/hyksx3p94ggz/gLHB6HP3MIEYn0bM8TZTyhqWhGYYxDXhFMDNfpgw83bZhMCMTNVDYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723048214; c=relaxed/simple;
	bh=QSgIQNEux5z0gHLQanU6vW+VC42CzK4NN7XbXwOxr3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fo8k87FVfAjTz8cBo9Z0gnIPp61xvpO+Ja+m4SjffdcwHaUBTsm95fB/tC9M+aolBG9J35rfxsaE+0P7y2oyblr3+xUTzcr5c4AU1oi7S4VCAD6f1YHN3tB+oEwvieG+lxBinIueJq6gZfteDtkVqjowSj6FJIlnOyWOJDzNj0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2swgCR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D9BC4AF09;
	Wed,  7 Aug 2024 16:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723048213;
	bh=QSgIQNEux5z0gHLQanU6vW+VC42CzK4NN7XbXwOxr3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H2swgCR/ES/8yQXGtlOyWStZ+pbITL1DrSniqefrbfpuuNUSVqR7QTQO9O2st11mD
	 3JmaD8k7fE8Xqqui6hcMn2H9RTU2+6xVw3ry4YOr7hVl9hL/n9O/UcScJ1UlWWQCYo
	 uiLECr8o0urI/fVQR9UZJjm7LWneCyQyMPd/RXEwOgp/lbnrZv79OGsy2RB39EKJ+3
	 YRvVY++qMmGPt6jotjfFef8XkF0a8kvW+VjW2ycxBCCckRqZ0PG8AxSQC//PMT6xTY
	 zAwSsglhqKywxuJi9rAYE1NABf3xTyR7s4aL83vlJdlWdtIy6EKoAVJpAl+6Ir7jok
	 nbKIgsfAAsZKA==
Date: Wed, 7 Aug 2024 09:30:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [PATCH net] ethtool: Fix context creation with no parameters
Message-ID: <20240807093012.6bd154a7@kernel.org>
In-Reply-To: <e5a9000a-230e-4118-8628-b44b682c8d8d@nvidia.com>
References: <20240807132541.3460386-1-gal@nvidia.com>
	<e5a9000a-230e-4118-8628-b44b682c8d8d@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Aug 2024 19:14:57 +0300 Gal Pressman wrote:
> > @@ -1372,14 +1372,15 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
> >  	/* If either indir, hash key or function is valid, proceed further.  
> 
> This comment is wrong, the check doesn't really verify the hash function
> is valid. I'll remove it in my fix unless you have any objections.
> 
> Not verifying the hash function is probably another bug, but it's too
> late to fix it at this point?

Let's do that separately in net-next?
Old ethtool had a bit of a "forward compatibility" mindset,
so it may have been intentional.

