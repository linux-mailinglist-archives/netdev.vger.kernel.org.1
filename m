Return-Path: <netdev+bounces-52336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67477FE67D
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 03:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E035B20DF7
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 02:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A43882B;
	Thu, 30 Nov 2023 02:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16619BD
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 18:09:33 -0800 (PST)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1r8WUR-0002Ut-1F;
	Thu, 30 Nov 2023 02:09:20 +0000
Date: Thu, 30 Nov 2023 02:09:13 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Eric Dumazet <edumazet@google.com>
Cc: patchwork-bot+netdevbpf@kernel.org, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com,
	hawk@kernel.org, ilias.apalodimas@linaro.org, dsahern@gmail.com,
	dtatulea@nvidia.com, willemb@google.com, almasrymina@google.com,
	shakeelb@google.com, john@phrozen.org
Subject: Re: [PATCH net-next v4 00/13] net: page_pool: add netlink-based
 introspection
Message-ID: <ZWfuyc13oEkp583C@makrotopia.org>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+srqtEAqaKv=b9xrevL7xPk8MwoMwmudzOshjf0nDxfw@mail.gmail.com>

Hi Eric,

On Wed, Nov 29, 2023 at 10:12:49PM +0100, Eric Dumazet wrote:
> On Wed, Nov 29, 2023 at 9:10 PM Daniel Golle <daniel@makrotopia.org> wrote:
> > Hi Paolo,
> >
> > after the merge of this series to linux-next I'm seeing a new crash
> > during boot.
> > It can absolutely be that this is a bug in the Ethernet driver I'm
> > working on though which only got exposed now. While I'm figuring it
> > out I thought it'd still be good to let you know.
> > [...]
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
> 

Confirming that the above patch fixes the issue.

Tested-by: Daniel Golle <daniel@makrotopia.org>

