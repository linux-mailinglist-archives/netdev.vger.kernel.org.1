Return-Path: <netdev+bounces-28527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CE977FC07
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 18:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764482820A4
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 16:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611A61643F;
	Thu, 17 Aug 2023 16:25:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3835C14011
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 16:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB31C433C7;
	Thu, 17 Aug 2023 16:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692289557;
	bh=lmQSRl2ecpKWB9QZvFcd923USRehLmJ02RhuJ69i9qw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VGMp/EkNK5HBHi4Zsh6ck7jE9O9X/RHG2IQ6ryibfhc12p7N2/VSB8w+NR1XLTlUi
	 CEFN5Ri7OTQxRIOCjy9NcXyZSNsIXcyag/t+E/dd+r0wtJHbiCBTwsXjJ3IAc3ECKM
	 BpxcH8mw5wX+Y8qZX7UP1feErTbnxfYwz0RADgm7tuyR0yLmYMs8pIbp/BEN/9sGEg
	 CETVoh7GhEGwXdocRLnWjGuTCRROReAd+9+B9NP+iMlydYuOnNA38yNIRwdufyPICy
	 fCKv/8TTOLVhqwH13beWhFoK2EyCXdn9IhmNm3fMSENPbzD8c5Y/3LDJMVJBXZHLII
	 B1Dkybl46QRsg==
Date: Thu, 17 Aug 2023 09:25:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: netdev@vger.kernel.org, hawk@kernel.org, aleksander.lobakin@intel.com,
 linyunsheng@huawei.com, almasrymina@google.com
Subject: Re: [RFC net-next 03/13] net: page_pool: factor out uninit
Message-ID: <20230817092556.57a7e82e@kernel.org>
In-Reply-To: <CAC_iWjLRR3sEZNDTAtD2sZ4UY3aZxGZSyA8y9mOB3SkZsVp7ZA@mail.gmail.com>
References: <20230816234303.3786178-1-kuba@kernel.org>
	<20230816234303.3786178-4-kuba@kernel.org>
	<CAC_iWjLRR3sEZNDTAtD2sZ4UY3aZxGZSyA8y9mOB3SkZsVp7ZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Aug 2023 10:40:09 +0300 Ilias Apalodimas wrote:
> > +static void page_pool_uninit(struct page_pool *pool)
> > +{
> > +       ptr_ring_cleanup(&pool->ring, NULL);
> > +
> > +       if (pool->p.flags & PP_FLAG_DMA_MAP)
> > +               put_device(pool->p.dev);
> > +
> > +#ifdef CONFIG_PAGE_POOL_STATS
> > +       free_percpu(pool->recycle_stats);
> > +#endif
> > +}  
> 
> I am not sure I am following the reasoning here.  The only extra thing
> page_pool_free() does is disconnect the pool. So I assume no one will
> call page_pool_uninit() directly.  Do you expect page_pool_free() to
> grow in the future, so factoring out the uninit makes the code easier
> to read?

I'm calling it from the unwind patch of page_pool_create() in the next
patch, because I'm adding another setup state after page_pool_init().
I can't put the free into _uninit() because on the unwind path of
_create() that's an individual step.

