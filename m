Return-Path: <netdev+bounces-91007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A2D8B0F1C
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 17:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87DDA1F217CA
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97FF1607A2;
	Wed, 24 Apr 2024 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kjy12Kar"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E97C16079C;
	Wed, 24 Apr 2024 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973971; cv=none; b=CJ9EE+9vU9hXVbMOJ8iCIC8V+Y8o4PPsCJ5I+5Jj4VnYJsvgXEL8OI1G9m3tfHLXFxTLYm935KD4xkwek5aB3YF5iRikbQOfbGdibA+MUSxdUWQZ933FBvPZKdN7IUBfIurDxY000H64Wy3XISZhHBD/jf+fq+erzmRHaCF7B10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973971; c=relaxed/simple;
	bh=NMNO+e0grFGj/Q+x2O81Y6xcTdzYQaELAi7w0CoWizo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4Xbo5FvAOW2Dz/jp7UeYDvUaamqNQhn+TGJiTvA7vUMdLj6oSkFzF0LeVjcRUvZSB8PO7DnXu+zYdoGpKLZIEnt9z//IRKTOSxN+8P9/NUUoh5rFE6pggIpU7J+OAOlnv8ot0Lnizy2keH3IR/gtPhMHYeoYi0h3V4L1Nqien8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kjy12Kar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66689C113CD;
	Wed, 24 Apr 2024 15:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713973971;
	bh=NMNO+e0grFGj/Q+x2O81Y6xcTdzYQaELAi7w0CoWizo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kjy12Kar1wvr+8bc/ZCUaiX63Vn+sNMs5+IpzzoWHkwAbfzA0J4oR0iip2ldQalsx
	 ZLiNJONbhjuUuIc1llh195a/twQGCn7IiCDjWK6/u3xkFqkTX9jiDPz4BJcsKYPqs9
	 CXtNGLhk3JjUWIdOJ8sAIQLZl1WE6ubTN3kBns9JYMsSdW0qpQNurRwgx13LEN7nPx
	 TyvXwLt8SIcDoJBf4wZJsq54kUAuASXvYKqeLb9AC6BavOJ3okiu/nDCthxHxSQ+Do
	 XbihOjHmVmlqBrnW411qgZTME3rHvx7Gdy34dX99yL1DvTacCQEWR3erjUkgUpv1Ba
	 dFV2sk1+amIUg==
Date: Wed, 24 Apr 2024 08:52:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Brett Creeley <bcreeley@amd.com>, Ratheesh
 Kannoth <rkannoth@marvell.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Tal
 Gilboa <talgi@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Jiri Pirko <jiri@resnulli.us>, Paul
 Greenwalt <paul.greenwalt@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 "justinstitt@google.com" <justinstitt@google.com>
Subject: Re: [PATCH net-next v9 2/4] ethtool: provide customized dim profile
 management
Message-ID: <20240424085249.6d67882b@kernel.org>
In-Reply-To: <76b75fcc-aa2f-4c75-b28f-7f7a513a2cf1@linux.alibaba.com>
References: <20240417155546.25691-1-hengqi@linux.alibaba.com>
	<20240417155546.25691-3-hengqi@linux.alibaba.com>
	<20240418174843.492078d5@kernel.org>
	<96b59800-85e6-4a9e-ad9b-7ad3fa56fff4@linux.alibaba.com>
	<20240422113943.736861fc@kernel.org>
	<76b75fcc-aa2f-4c75-b28f-7f7a513a2cf1@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Apr 2024 21:10:55 +0800 Heng Qi wrote:
> >> This doesn't work because the first level of sub-nesting of
> >> ETHTOOL_A_COALESCE_RX_CQE_PROFILE is ETHTOOL_A_PROFILE_IRQ_MODERATION.  
> > So declare a policy for IRQ_MODERATION which has one entry -> nested
> > profile policy?  
> 
> Still doesn't work because one profile corresponds to 5 IRQ_MODERATION sub-nests.

I don't get it. Can you show the code you used and the failure / error
you get?

> In the same example, strset also uses NLA_NESTED.

Likely just because it's older code.

