Return-Path: <netdev+bounces-46883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C3C7E6E87
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 17:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12071280F9E
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 16:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBC2210EE;
	Thu,  9 Nov 2023 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7iE0oBL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ACF20B10
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 16:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF13C433C8;
	Thu,  9 Nov 2023 16:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699546940;
	bh=HB39JJnsADjYSZnkPlJ2ckhwmu+WRchYIulUzkip/YQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F7iE0oBLRT191eUNizvNeYPEyc4W8lQMpSNM0kjK2KKwMWgHulP7t1noZ0kKbg41F
	 eIgnrCdBL7VX6le9beCT0TStuxk53hGO7KqcTyRkTZE7qI5D9C8q1UBcaZH8SwWoKR
	 G97UlzyJ0IXHhe+xgMkDFG8m4c17OqjireIR/kIZ9xCFbdT6x7eDByywS9P4BX8dQ3
	 MsiS6V9gRp9NhvfAp8bfe4AlSSyVwDGa9gCZaesZJ4gVPvIQK/1zbZnDkKxgnNACUK
	 SQ2DedtmMJduFHDJDNo/REZfMG21byFneqwASW+DLE6qbCdP6OxrsaM+PdAOLDjYOh
	 gYM/zqQT6pqug==
Date: Thu, 9 Nov 2023 08:22:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, almasrymina@google.com, hawk@kernel.org
Subject: Re: [PATCH net-next 04/15] net: page_pool: id the page pools
Message-ID: <20231109082219.5ee1d0cf@kernel.org>
In-Reply-To: <CAC_iWj+gdrsyumk77mR60o6rw=pUmnXgrkmwJXK_04KPJCMhAw@mail.gmail.com>
References: <20231024160220.3973311-1-kuba@kernel.org>
	<20231024160220.3973311-5-kuba@kernel.org>
	<CAC_iWj+gdrsyumk77mR60o6rw=pUmnXgrkmwJXK_04KPJCMhAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Nov 2023 11:21:32 +0200 Ilias Apalodimas wrote:
> > +       mutex_lock(&page_pools_lock);
> > +       err = xa_alloc_cyclic(&page_pools, &pool->user.id, pool, xa_limit_32b,
> > +                             &id_alloc_next, GFP_KERNEL);
> > +       if (err < 0)
> > +               goto err_unlock;  
> 
> A nit really, but get rid of the if/goto and just let this return err; ?

There's more stuff added here by a subsequent patch. It ends up like
this:

int page_pool_list(struct page_pool *pool)
{
	static u32 id_alloc_next;
	int err;

	mutex_lock(&page_pools_lock);
	err = xa_alloc_cyclic(&page_pools, &pool->user.id, pool, xa_limit_32b,
			      &id_alloc_next, GFP_KERNEL);
	if (err < 0)
		goto err_unlock;

	if (pool->slow.netdev) {
		hlist_add_head(&pool->user.list,
			       &pool->slow.netdev->page_pools);
		pool->user.napi_id = pool->p.napi ? pool->p.napi->napi_id : 0;

		netdev_nl_page_pool_event(pool, NETDEV_CMD_PAGE_POOL_ADD_NTF);
	}

	mutex_unlock(&page_pools_lock);
	return 0;

err_unlock:
	mutex_unlock(&page_pools_lock);
	return err;
}

Do you want me to combine the error and non-error paths?
I have a weak preference for not mixing, sometimes err gets set 
to a positive value and that starts to propagate, unlikely to
happen here tho.

