Return-Path: <netdev+bounces-30030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C93785B11
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 16:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200282812F9
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 14:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1356AC122;
	Wed, 23 Aug 2023 14:49:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA19BA3B
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 14:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF13EC433C7;
	Wed, 23 Aug 2023 14:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692802170;
	bh=/ugSX4Mt9OlW3sVG5qCZTbGWFgYqH2OKMHdoSEj62aE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k3J+nXG5e/fN1bZvmnTPYf07VLzmLeYzaYqQrJA6/1w2MOIc5IlLZXONMy0CdpxkE
	 fiEokTlADJpwl6tH04cA5UmAt1zhkGSRyyFJ1Le6mxbSlYqArJKoQUqkxwnzrvSc5z
	 Ju2wAcmviPNe2PG89qOuFBHXofamWAgjGbtrUb+wQ+B8zFBuGc97lPCqCGQKwCIOL7
	 rBRVenid+/iIHYYXvx2owRkU32ZCXao7AKlxmA2RgQhxvxzxfwcwMLncbkpmSbBSvl
	 pxcblb2rsjBfS4Kt2belKgNLl/7V60yvZK5U6ZY+fcNPH0FfZ6dmqfjXre6isNIEiX
	 +ksFgxvnaUwag==
Date: Wed, 23 Aug 2023 07:49:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, Ratheesh Kannoth <rkannoth@marvell.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Geetha sowjanya <gakula@marvell.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Sunil Goutham <sgoutham@marvell.com>, Thomas Gleixner <tglx@linutronix.de>,
 hariprasad <hkelam@marvell.com>
Subject: Re: [BUG] Possible unsafe page_pool usage in octeontx2
Message-ID: <20230823074928.264b946f@kernel.org>
In-Reply-To: <20230823094757.gxvCEOBi@linutronix.de>
References: <20230823094757.gxvCEOBi@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Aug 2023 11:47:57 +0200 Sebastian Andrzej Siewior wrote:
> The pool can be filled in the same context (within allocation if the
> pool is empty). There is also page_pool_recycle_in_cache() which fills
> the pool from within skb free, for instance:
>  napi_consume_skb() -> skb_release_all() -> skb_release_data() ->
>  napi_frag_unref() -> page_pool_return_skb_page().
> 
> The last one has the following check here:
> |         napi = READ_ONCE(pp->p.napi);
> |         allow_direct = napi_safe && napi &&
> |                 READ_ONCE(napi->list_owner) == smp_processor_id();
> 
> This eventually ends in page_pool_recycle_in_cache() where it adds the
> page to the cache buffer if the check above is true (and BH is disabled). 
> 
> napi->list_owner is set once NAPI is scheduled until the poll callback
> completed. It is safe to add items to list because only one of the two
> can run on a single CPU and the completion of them ensured by having BH
> disabled the whole time.

One clarification - .napi will be NULL for otx2, it's an opt-in for
drivers which allocate from NAPI, and AFAICT otx2 does not opt in.

