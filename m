Return-Path: <netdev+bounces-52316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D20797FE46F
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 01:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B451EB20F11
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 00:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763E0633;
	Thu, 30 Nov 2023 00:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHWLEvxI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B80C388
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 00:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E390C433CC;
	Thu, 30 Nov 2023 00:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701302582;
	bh=baBxOXx5e4SFHObfzZFMRaDCx6pbYijIk6IXjyLR3tA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aHWLEvxI31COFQ/AS58uybLMRcGH3NH7SgeZUXX8n9hbwXDDgXuStYGmRajd0lxYf
	 uyDxUc8q1r2n3H6LH5Hi96nX+8CpDp4pP1GM1KDCvNZ604SQxJb9hio5fk3+KVfX3T
	 jLZC6JhIouAXhxx6MEVe0+oY9cUWQ//77FHNmFuoKkTW673gWTbIc7BwdhmgB2B5BL
	 dVUB7gPskozK5B480P0LGsWhCsJhsPKZ7wlwWklDpqOcTHEtVfef2i3hSDVSLzcwKl
	 wzoR2z1azR500B7NM2+KPNKBGynuZzFWi4Zw1iCifH+C4tCsi5fTfXfznb1j3jisNI
	 mTUnACX0/hbkQ==
Date: Wed, 29 Nov 2023 16:03:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
 patchwork-bot+netdevbpf@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, pabeni@redhat.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, dsahern@gmail.com, dtatulea@nvidia.com,
 willemb@google.com, almasrymina@google.com, shakeelb@google.com
Subject: Re: [PATCH net-next v4 00/13] net: page_pool: add netlink-based
 introspection
Message-ID: <20231129160301.4520dbe0@kernel.org>
In-Reply-To: <CANn89i+srqtEAqaKv=b9xrevL7xPk8MwoMwmudzOshjf0nDxfw@mail.gmail.com>
References: <20231126230740.2148636-1-kuba@kernel.org>
	<170118422773.21698.10391322196700008288.git-patchwork-notify@kernel.org>
	<ZWeamcTq9kv0oGd4@makrotopia.org>
	<CANn89i+srqtEAqaKv=b9xrevL7xPk8MwoMwmudzOshjf0nDxfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 22:12:49 +0100 Eric Dumazet wrote:
> Please look at the syzbot report
> 
> Proposed patch was :
> 
> diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
> index 1426434a7e1587797da92f3199c0012559b51271..07becd4eceddcd4be9e5bea6479f8ffd16dac851
> 100644
> --- a/net/core/page_pool_user.c
> +++ b/net/core/page_pool_user.c
> @@ -339,7 +339,8 @@ void page_pool_unlist(struct page_pool *pool)
>         mutex_lock(&page_pools_lock);
>         netdev_nl_page_pool_event(pool, NETDEV_CMD_PAGE_POOL_DEL_NTF);
>         xa_erase(&page_pools, pool->user.id);
> -       hlist_del(&pool->user.list);
> +       if (!hlist_unhashed(&pool->user.list))
> +               hlist_del(&pool->user.list);
>         mutex_unlock(&page_pools_lock);
>  }


Any reason not to post this fix?

