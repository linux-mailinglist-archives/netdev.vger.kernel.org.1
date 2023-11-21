Return-Path: <netdev+bounces-49783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEF67F3797
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 21:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9F23B219E3
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 20:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A803755799;
	Tue, 21 Nov 2023 20:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUMgAAwO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C01A55796
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 20:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEEBC433C8;
	Tue, 21 Nov 2023 20:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700599043;
	bh=ZymyDZd+iiaZum8vU8h1JUPzZr800dq5HiA5ewTdlY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EUMgAAwOAPwdWz+Y5joqGJb/Jt0MWUxLUlXnZWLny2/BlvqDrSmCHh+B38xr+py/i
	 KTaStytpxkLQp4JnE+SZKCzh3g284dUJ8JMjVWnQXobac57PBTQUR5vOuFFwuS8ukl
	 RuXVlNNGfBFl0bBfSVP+leDEveSvEAIlOtSaT2P5I6lRv5CpL+pxVYKcIJNzwSMJcY
	 aDHcRoxHzzCRgLEQ4r05VtGfPw/jlRJR9j3zm6M0SGnhPu/BV1uhd5t2MEDY9NCLpT
	 RHVYWGnH/gz+ctuCKp5cTO+O2UzXhPtTxsAg+erk4DD9SgbGR8NkaD0fGqRn8cH00u
	 NJmeqKMfQ84PQ==
Date: Tue, 21 Nov 2023 12:37:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, almasrymina@google.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, dsahern@gmail.com, dtatulea@nvidia.com
Subject: Re: [PATCH net-next v2 08/15] net: page_pool: add nlspec for basic
 access to page pools
Message-ID: <20231121123721.03511a3d@kernel.org>
In-Reply-To: <655cf5c7874bd_378cc9294f4@willemb.c.googlers.com.notmuch>
References: <20231121000048.789613-1-kuba@kernel.org>
	<20231121000048.789613-9-kuba@kernel.org>
	<655cf5c7874bd_378cc9294f4@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 13:24:07 -0500 Willem de Bruijn wrote:
> Do you want to introduce a separate ID for page pools? That brings some
> issues regarding network namespace isolation.
> 
> As a user API, it is also possible (and intuitive?) to refer to a
> page_pool by (namespacified) ifindex plus netdev_rx_queue index,
> or napi_id.

That does not work for "destroyed" pools. In general, there is
no natural key for a page pool I can think of.

> In fairness, napi_id is also global, not per netns.
> 
> By iterating over "for_each_netdev(net, ..", dump already limits
> output to pools in the same netns and get only reports pools that
> match the netns.
> 
> So it's only a minor matter of visible numbering, and perhaps
> superfluous new id.

The IDs are not stable. Any reconfiguration of a device will create
a new page pool and therefore assign a new ID. So applications can't
hold onto the ID long term.

That said the only use case for exposing the ID right now is to
implement do/GET (since there is no other unique key). And manual debug
with drgn, but that doesn't require uAPI. So if you prefer strongly
I can drop the ID from the uAPI and do/GET support.

