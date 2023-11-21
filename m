Return-Path: <netdev+bounces-49814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0877F3886
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 23:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D9B2826C3
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 22:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C54487BC;
	Tue, 21 Nov 2023 22:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzdYeXzP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6E9584FC
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 22:00:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A308FC433C7;
	Tue, 21 Nov 2023 22:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700604051;
	bh=FOEggjBGYrVJ+mepxI31RIOKRYlkG/eLPWNxEZsGqnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UzdYeXzP6eNhMz8NTBhcPzz/DQFE5fQUm4pLfOlRx6UkmTn+kleI0US24xNgDuvp1
	 i+Vo++bdrC4YwRqLVVA7Uzf8g47lhGC1b6tPWWUeYhUnZ17aM6h2MrWZcKn5sQB4HF
	 piuyiar2f0R+bhaIRTR9i9Xn748YAoh+bNWzFQHX/pgzRUogPkQ0Mj/OlDGyOYHTsM
	 Yy8qfDawmvzPhj9T5TU/VPHOuOBuray6TPrdAvVHpliUKwi3CstcxEJJSVvzcsZLq0
	 VBRnZnsYAKUog42ETmRAXqQ6LW0ERaGIru/8dMZk0rH6Y+X5XEBLQBSJ3NMCKkWEnA
	 ijwjjZM1p4tww==
Date: Tue, 21 Nov 2023 14:00:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, almasrymina@google.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, dsahern@gmail.com, dtatulea@nvidia.com
Subject: Re: [PATCH net-next v2 08/15] net: page_pool: add nlspec for basic
 access to page pools
Message-ID: <20231121140049.045b8305@kernel.org>
In-Reply-To: <655d22256ba8e_37e85c294c8@willemb.c.googlers.com.notmuch>
References: <20231121000048.789613-1-kuba@kernel.org>
	<20231121000048.789613-9-kuba@kernel.org>
	<655cf5c7874bd_378cc9294f4@willemb.c.googlers.com.notmuch>
	<20231121123721.03511a3d@kernel.org>
	<655d22256ba8e_37e85c294c8@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 16:33:25 -0500 Willem de Bruijn wrote:
> > That does not work for "destroyed" pools. In general, there is
> > no natural key for a page pool I can think of.  
> 
> Pools for destroyed devices are attached to the loopback device.
> If the netns is also destroyed, would it make sense to attach
> them to the loopback device in the init namespace?

I remember discussing this somewhere in person... netconf?
I opted for only exposing the cases which are obvious now,
we can extend the API later, once we get some production experience.

> > The IDs are not stable. Any reconfiguration of a device will create
> > a new page pool and therefore assign a new ID. So applications can't
> > hold onto the ID long term.
> > 
> > That said the only use case for exposing the ID right now is to
> > implement do/GET (since there is no other unique key). And manual debug
> > with drgn, but that doesn't require uAPI. So if you prefer strongly
> > I can drop the ID from the uAPI and do/GET support.  
> 
> No, this is fine. I just wanted to make sure that the alternative api
> and netns details were considered beforehand, since it's uapi.

Okay, let me ditch it for now, in the interest of making progress..
It's easily added later.

