Return-Path: <netdev+bounces-56062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A513880DAEF
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 20:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46060B21488
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 19:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C75152F8D;
	Mon, 11 Dec 2023 19:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwB9x+sO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5198551C37
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 19:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2D7C433C7;
	Mon, 11 Dec 2023 19:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702323124;
	bh=LPLfUWNHRirQ2vRL7AGp6B484wCdzz0S+UFQPz/KsoA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VwB9x+sOUVbTtmBWRUy+VcMJJhSqr4uK6nArQznkfV64srs/Xvp9Ds4x+F+t9zTMh
	 JteyfGFGQNd5t/MoOlYbcgqwDqRwSDzPEL5u+Gsjj4hWd5hp+xGSo2utrDbK0kBher
	 P+qiZ2DsTpKJT74b3N8q5CVqWIoWC4NZljasrOQFhFRY7gjeFSSkdHsXlkIqVwU+z2
	 cCjYkas+BvKCp4czZu3zoGcaABpP+MqW0SE1q4mVmT5Dpe7P5ZRFFjNE6uveDcnk3+
	 ihorlEMBdWet1+6NYcy78JuZSIR3dBp6kyumCPsxLREgsHItvGslBNtzb6/fcWoDEA
	 zQDht5IpGuymg==
Date: Mon, 11 Dec 2023 11:32:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Liang Chen <liangchen.linux@gmail.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, linyunsheng@huawei.com,
 netdev@vger.kernel.org, linux-mm@kvack.org, jasowang@redhat.com
Subject: Re: [PATCH net-next v7 4/4] skbuff: Optimization of SKB coalescing
 for page pool
Message-ID: <20231211113203.2ae8bccf@kernel.org>
In-Reply-To: <CAHS8izPpWZvOSswHP0n-_nBiUMw8Ay2iM4yFE-HZenHv51iBHA@mail.gmail.com>
References: <20231206105419.27952-1-liangchen.linux@gmail.com>
	<20231206105419.27952-5-liangchen.linux@gmail.com>
	<CAHS8izNQeSwWQ9NwiDUcPoSX1WONG4JYu2rfpqF3+4xkxE=Wyw@mail.gmail.com>
	<CAKhg4t+LpF=G0DBhbuRYtxKyTrMiR3pSc15sY42kc57iGQfPmw@mail.gmail.com>
	<CAHS8izPpWZvOSswHP0n-_nBiUMw8Ay2iM4yFE-HZenHv51iBHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Dec 2023 20:21:21 -0800 Mina Almasry wrote:
> Is it possible/desirable to add a comment to skb_frag_ref() that it
> should not be used with skb->pp_recycle? At least I was tripped by
> this, but maybe it's considered obvious somehow.
> 
> But I feel like this maybe needs to be fixed. Why does the page_pool
> need a separate page->pp_ref_count? Why not use page->_refcount like
> the rest of the code? Is there a history here behind this decision
> that you can point me to? It seems to me that
> incrementing/decrementing page->pp_ref_count may be equivalent to
> doing the same on page->_refcount.

Does reading the contents of the comment I proposed here:
https://lore.kernel.org/all/20231208173816.2f32ad0f@kernel.org/
elucidate it? The pp_ref_count means the holder is aware that 
they can't release the reference by calling put_page().
Because (a) we may need to clean up the pp state, unmap DMA etc.
and (b) one day it may not even be a real page (your work).

TBH I'm partial to the rename from patch 1, so I wouldn't delay this
work any more :) But you have a point that we should inspect the code
and consider making the semantics of skb_frag_ref() stronger all by
itself, without the need to add a new flavor of the helper..
Are you okay with leaving that as a follow up or do you reckon it's
easy enough we should push for it now?

