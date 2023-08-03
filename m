Return-Path: <netdev+bounces-24138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1368576EEE9
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 18:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0EBD28226A
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 16:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EE92416A;
	Thu,  3 Aug 2023 16:00:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8650F182C8
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 16:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84288C433C7;
	Thu,  3 Aug 2023 16:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691078431;
	bh=4Kh3ibsHIzFJJq0/G/F3KHIgajbiAH5Vz1Bxyj9o3Vk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aHcukMK9r4SsEvRHz5MB3JYRd9vv2nzO2Dhx15gcmTQYg7K5ElnS+h6qO4o+Aaxxf
	 F1+fKsZxAbCJSNfd+x5YLgUTPwYDzF1cH4b5hoXLYIE/TNhRRfwRPi/JyQzg5oRwIJ
	 7o5++3UksN4s9nxdAEUcOSnE9d+utZvJgseu3t9NWr0GPI0WhuZurHyN3WpVFDhqmx
	 g/5hKrabvXUQyxOsYA7lPAyTQpOgJMlAeLLkKXBpdo34MDFacaoBpvO1i+VAMooFQG
	 x4T7YYwvvrf6qXmzcbuvVvdLG31a9OUSp1I6kFdI1J6QmrrAJSgEnmzdKiqStNckTL
	 1mkytn4qKWhEg==
Date: Thu, 3 Aug 2023 09:00:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>, Alexander Duyck
 <alexanderduyck@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Simon Horman
 <simon.horman@corigine.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 5/9] page_pool: don't use driver-set flags
 field directly
Message-ID: <20230803090029.16a6798d@kernel.org>
In-Reply-To: <7b77dd3a-fd03-884a-8b8a-f76ab6de5691@intel.com>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
	<20230727144336.1646454-6-aleksander.lobakin@intel.com>
	<a0be882e-558a-9b1d-7514-0aad0080e08c@huawei.com>
	<6f8147ec-b8ad-3905-5279-16817ed6f5ae@intel.com>
	<a7782cf1-e04a-e274-6a87-4952008bcc0c@huawei.com>
	<0fe906a2-5ba1-f24a-efd8-7804ef0683b6@intel.com>
	<20230802142920.4a777079@kernel.org>
	<7b77dd3a-fd03-884a-8b8a-f76ab6de5691@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Aug 2023 16:56:22 +0200 Alexander Lobakin wrote:
> > FWIW I'm tempted to do something like the patch below (an obvious move,
> > I suspect). I want to add another pointer (netdev) to the params and   
> 
> Just take napi->dev as I do in libie :)

:) The fields have extra semantics, like napi implies that recycling 
is allowed, and netdev implies that there is only _one_ netdev eating
from the PP. There's also a way to get the pp <> netdev from the memory
model registration. But I feel like explicit field is cleanest.

Anyone, conversation for a later time :)

> > I don't want it to eat up bytes in the first cache line.
> > The patch is incomplete, we need to stash a one-bit indication in 
> > the first cache line to know init_callback is not present without
> > having to look at @slow. I'll defer doing that cleanly until your
> > patches land.  
> 
> I would propose to include it in the series, but it has grown a bunch
> already and it's better to do that later separately :s

Yeah.. I'd be trying to split your series up a little to make progress
rather than add more things :( I was going to suggest that you post
just the first 3 patches for instance. Should be an easy merge.

