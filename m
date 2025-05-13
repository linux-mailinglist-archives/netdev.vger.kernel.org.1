Return-Path: <netdev+bounces-189924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 833DCAB4853
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 02:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19985165B25
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 00:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F5D17D2;
	Tue, 13 May 2025 00:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eB4y8s6G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EF01548C
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 00:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747095414; cv=none; b=BlarRW256cDOSpalEFpeE7Zjpc3QKOOnLiFH0vFW0gbaKNF4uaHwy3Pzgyw5d+PGPEmFBfgJFIlfqVPMNvX+3PfOxxld7d2kq7CJ+tDWJVtEBLngqf0dJ8UeymL5wsHngGvS7iSMsrRyI1GBVRvnfALpwGpwlcNT9MoxTrY93bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747095414; c=relaxed/simple;
	bh=0a9pTj1I0zcSvnLmyKAPHKJMfHoygCQQ1nfT1wpHaAI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erYhxUcf07LI18N8HInFiAT7QU3QqV5+09TM8/z9eyio0tQcULtjNtCV9xtHFcwAGINWzg6kwYZYX+F/bcY7nf+QP/+o6wP18XLV+e+5WbPz6ZUqns7h5hXA4xxSBQt3ZbrpqZwl+QPppX11AMnn1ZczCHPRBT72xg49xt7d6kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eB4y8s6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A19C4CEE7;
	Tue, 13 May 2025 00:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747095413;
	bh=0a9pTj1I0zcSvnLmyKAPHKJMfHoygCQQ1nfT1wpHaAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eB4y8s6GhftRo+ddYXKh8wKqPmBN0NSbZyciPYW3/TFanHbeISvDqT4xdvS6mmA/8
	 zvTUNusOStizHghPPvhIGpcAyJjT+V1B5PuDR/fdDtgGEPBhEQP4JnbDS5tsHaGJ+w
	 W6nyua+q2SN6tj4ZkOuzRu20LcDKtwmy9Qs+pth3908S4j26KpfxhKCWAe9KrkHxOc
	 CyfFDA1UwlGes4pyHhUs4oeKWZAKpeg1nPynsCzX9HBF4NZW6G1oSWZH4InL2pPhs4
	 2CvugoGP4QwqQz1c+niyTBTIbNYtvQlAWpc1OW3l5nlKZz3C7zckIVDusWLkpXSQxq
	 uONvRMqqPD7ZA==
Date: Mon, 12 May 2025 17:16:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, <netdev@vger.kernel.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, <intel-wired-lan@lists.osuosl.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next] ice: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Message-ID: <20250512171652.5bb0b0ee@kernel.org>
In-Reply-To: <6984e594-b5eb-43d7-9783-fca106f79d8a@intel.com>
References: <20250512160036.909434-1-vladimir.oltean@nxp.com>
	<f557afc2-32f5-4758-9c68-dd319ce508ba@intel.com>
	<20250512185346.zxy2nk3kexhqf2px@skbuf>
	<6984e594-b5eb-43d7-9783-fca106f79d8a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 May 2025 12:06:56 -0700 Jacob Keller wrote:
> > Ok. I have 3 more Intel conversions pending (igb, ixgbe, i40e), but I've
> > put a stop for today. I assume it's fine to post these to net-next and
> > not to the iwl-next tree, or would you prefer otherwise?  
> 
> I think we typically prefer to go through iwl-next because that lets us
> run a validation test pass. I have no personal objection if the netdev
> maintainers want to take these directly.

The real question is whether you can get these back to the list before
Vladimir is done converting all drivers :) If yes - let's follow the
usual path and take these via iwl. If Vladimir can convert faster than
you can validate then we should take these direct..

