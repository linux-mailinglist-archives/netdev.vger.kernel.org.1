Return-Path: <netdev+bounces-30678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE76C788837
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 15:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FC6281809
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 13:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90133D529;
	Fri, 25 Aug 2023 13:16:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44361AD5C
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 13:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE85C433C7;
	Fri, 25 Aug 2023 13:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692969373;
	bh=rc6EOAIAqN+MG5yLa2BM8K075X9y9wYSgScNSMQ//Rs=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=SwIoIzKn8+DIepzA0Y6ZfEuhkKbHxLFPztwBiBVNnrQ1VQ/IP+pi9GrT+7BrUwRtY
	 2rQkV86WSH3Dy1n4j4Cc9B8UJzAm0tqeeLL6lcyu2H4/SZh1yv0V/BNazmDoUOhV96
	 L3/8ZDxvxSBigyNkYxyZpQWAIReVOtxdK2rmNFnuQn5rOdiw7vZbpGn9gmjILY4Wfx
	 pJLwfQ12QOlXZzQF5TzhI3XCueD98kpvWBTPgpY5xo+dmUTHvBWQiKpv7kng8p3XNA
	 x0FXLrQz4M4m12ZLZpadQMiKndgkPvs7xyX2xBgsfYcvhmgu/F1HgOL5DJxCB7Pgb7
	 nSR3YZej8ZJkg==
Message-ID: <55079677-9139-2f68-fe4c-053020b6f33f@kernel.org>
Date: Fri, 25 Aug 2023 15:16:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: hawk@kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Geetha sowjanya <gakula@marvell.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, Sunil Goutham
 <sgoutham@marvell.com>, Thomas Gleixner <tglx@linutronix.de>,
 hariprasad <hkelam@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Qingfang DENG <qingfang.deng@siflower.com.cn>
Subject: Re: [BUG] Possible unsafe page_pool usage in octeontx2
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, Ratheesh Kannoth <rkannoth@marvell.com>
References: <20230823094757.gxvCEOBi@linutronix.de>
 <d34d4c1c-2436-3d4c-268c-b971c9cc473f@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <d34d4c1c-2436-3d4c-268c-b971c9cc473f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23/08/2023 21.45, Jesper Dangaard Brouer wrote:
> On 23/08/2023 11.47, Sebastian Andrzej Siewior wrote:
[...]
>>
>> This breaks in octeontx2 where a worker is used to fill the buffer:
>>    otx2_pool_refill_task() -> otx2_alloc_rbuf() -> __otx2_alloc_rbuf() ->
>>    otx2_alloc_pool_buf() -> page_pool_alloc_frag().
>>
> 
> This seems problematic! - this is NOT allowed.
> 
> But otx2_pool_refill_task() is a work-queue, and I though it runs in
> process-context.  This WQ process is not allowed to use the lockless PP
> cache.  This seems to be a bug!
> 
> The problematic part is otx2_alloc_rbuf() that disables BH:
> 
>   int otx2_alloc_rbuf(struct otx2_nic *pfvf, struct otx2_pool *pool,
>              dma_addr_t *dma)
>   {
>      int ret;
> 
>      local_bh_disable();
>      ret = __otx2_alloc_rbuf(pfvf, pool, dma);
>      local_bh_enable();
>      return ret;
>   }
> 
> The fix, can be to not do this local_bh_disable() in this driver?

Correcting myself. It is not a fix to remove this local_bh_disable().
(which is obvious now I read the code again).

This WQ process is not allowed to use the page_pool_alloc() API this way
(from a work-queue).  The PP alloc-side API must only be used under NAPI
protection.  Thanks for spotting this Sebastian!

Will/can any of the Cc'ed Marvell people work on a fix?

--Jesper

