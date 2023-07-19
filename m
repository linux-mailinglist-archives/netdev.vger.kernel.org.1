Return-Path: <netdev+bounces-18773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3EE758A29
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 02:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420712817ED
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 00:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDE615A7;
	Wed, 19 Jul 2023 00:40:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917C0ECA
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B230EC433C8;
	Wed, 19 Jul 2023 00:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689727244;
	bh=OObyhr4FvtnpD48DJkziD/tIkyd9HmMhKTkALpnmvec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QBtDVeiPgdEoT2uTqA6emOA+x0jK9PKcfrZuJy3nLjvMfdFOE7CfJDEG3debe2H4J
	 YSYkReYKOXc10kUA4TVcUqsqTCXNzwRpQJh9CUqIfdOKtbqjC1zdv5lMC1ta33TKkl
	 9I6B0KnH7S2w36qS/1+Z+M4ELdiUtuflEtk0H6BksIPhKmpSDS3cqWazs+T1zGnp7I
	 b0XnBUeZnOQvqpxxhSsSMZxFj90D5cfO/INTprfjYHfKoQqY45vFeZTFdDX2V7rSKk
	 5MgEMTiP1hXae16iMLPf/Gbky0rLUKWAkdCILHRI3VMDkdPdi/Sieoh5v9LLTOnDk2
	 bijVdfja0kbGw==
Date: Tue, 18 Jul 2023 17:40:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Alexander Duyck
 <alexanderduyck@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 7/7] net: skbuff: always try to recycle
 PP pages directly when in softirq
Message-ID: <20230718174042.67c02449@kernel.org>
In-Reply-To: <20230714170853.866018-10-aleksander.lobakin@intel.com>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
	<20230714170853.866018-10-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jul 2023 19:08:52 +0200 Alexander Lobakin wrote:
> Suggested-by: Jakub Kicinski <kuba@kernel.org> # in_softirq()

I thought I said something along the lines as "if this is safe you can
as well" which falls short of a suggestion, cause I don't think it is
safe :)

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index fc1470aab5cf..1c22fd33be6c 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -902,7 +902,7 @@ bool page_pool_return_skb_page(struct page *page, bool napi_safe)
>  	 * in the same context as the consumer would run, so there's
>  	 * no possible race.
>  	 */
> -	if (napi_safe) {
> +	if (napi_safe || in_softirq()) {
>  		const struct napi_struct *napi = READ_ONCE(pp->p.napi);
>  
>  		allow_direct = napi &&

What if we got here from netpoll? napi budget was 0, so napi_safe is
false, but in_softirq() can be true or false.

XDP SKB is a toy, I really don't think 3-4% in XDP SKB warrants the
risk here.

