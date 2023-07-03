Return-Path: <netdev+bounces-15236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F269B74641F
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 22:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304D81C20A79
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 20:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3752E100D8;
	Mon,  3 Jul 2023 20:32:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64392F23
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 20:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCA1C433C9;
	Mon,  3 Jul 2023 20:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688416328;
	bh=wwufjRtciEQ+b3u9cVB2o8qsKDTUrArMhXbZClwa5UU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rLwRCuL1fq6Cp/DK2ssr3/nP0PjTiQMy1CCd3S1byEHStDm6J7ziM3yVUpE3H30/o
	 r88tbR3l9pJeK1B0b0gbN1nsqMW27tMaqNCmoQGlXeHafOac6ZimGx6fEq4hmpP2pp
	 U9GzUp2900BxE/RTfphqPKlGPXq7z4cEj1OKKkuMyHCAh3rEyTnE967y5q7iKhcmIX
	 sG56B1VlIiGNEvaNaq+Eg7c1EJtnijXF85rFCkMZEn5hlAyWNW0+UEnZ84eepEbIVa
	 8BXpZDlb2f499+Hsh4R3UmXVMSyhVWkb4bd5w8NMYq1kxR3q4epW3XAUHs6suppIUB
	 22oSbFCIDAyyQ==
Date: Mon, 3 Jul 2023 13:32:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>, Yunsheng Lin
 <linyunsheng@huawei.com>, Alexander Duyck <alexanderduyck@fb.com>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC net-next 2/4] net: page_pool: avoid calling no-op
 externals when possible
Message-ID: <20230703133207.4f0c54ce@kernel.org>
In-Reply-To: <413e3e21-e941-46d0-bc36-fd9715a55fc4@intel.com>
References: <20230629152305.905962-1-aleksander.lobakin@intel.com>
	<20230629152305.905962-3-aleksander.lobakin@intel.com>
	<69e827e239dab9fd7986ee43cef599d024c8535f.camel@gmail.com>
	<ac4a8761-410e-e8cc-d6b2-d56b820a7888@intel.com>
	<CAKgT0UfZCGnWgOH96E4GV3ZP6LLbROHM7SHE8NKwq+exX+Gk_Q@mail.gmail.com>
	<413e3e21-e941-46d0-bc36-fd9715a55fc4@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jun 2023 17:34:02 +0200 Alexander Lobakin wrote:
> > I am not a fan of having the page pool force the syncing either. Last
> > I knew I thought the PP_FLAG_DMA_SYNC_DEV was meant to be set by the  
> 
> Please follow the logics of the patch.
> 
> 1. The driver sets DMA_SYNC_DEV.
> 2. PP tries to shortcut and replaces it with MAYBE_SYNC.
> 3. If dma_need_sync() returns true for some page, it gets replaced back
>    to DMA_SYNC_DEV, no further dma_need_sync() calls for that pool.
> 
> OR
> 
> 1. The driver doesn't set DMA_SYNC_DEV.
> 2. PP doesn't turn on MAYBE_SYNC.
> 3. No dma_need_sync() tests.
> 
> Where does PP force syncs for drivers which don't need them?

I think both Alex and I got confused about what's going on here.

Could you reshuffle the code somehow to make it more obvious?
Rename the flag, perhaps put it in a different field than 
the driver-set PP flags?

