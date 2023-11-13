Return-Path: <netdev+bounces-47496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CBD7EA6AD
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5852B20980
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA45D3C08A;
	Mon, 13 Nov 2023 23:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAF7N6Xb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6362D63C
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68507C433C8;
	Mon, 13 Nov 2023 23:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699916759;
	bh=KIbg7WSXtun715GyZV7F9AzyWxN0+AZgQG21Rel54vE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lAF7N6XbdGowJElZh0Qpcpm1mQ8RILmUNzGFr9fu3JccuyDj0m2XKcSyMz4ukLBR5
	 SQy0QCW9oecl/BFfCp1O4+40xnUJO2YYCckLGGLcxR4dABVz0emOSiP02Nc/ehr9uj
	 mfLlyB/h4oafSQOp+qKwVz0eCy/D5d3jA71cLvJlBsOHv/OfPEK+gV/itm6+5AGLu+
	 K1GTQfXaZbAHNCnOLXg1ou7Bl/vuhGOalboG1CSEX1A29PO9x9mIN6kx/szK3JVRz+
	 M+6PmL08K0CZcO/mU3lcoZ08JWATpETmcwtI8x2tnm/nT0h2SMcaTmZraYlBaM26qc
	 41cd/lYa1NVkw==
Date: Mon, 13 Nov 2023 18:05:54 -0500
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>, Yunsheng Lin
 <linyunsheng@huawei.com>
Cc: davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
Message-ID: <20231113180554.1d1c6b1a@kernel.org>
In-Reply-To: <CAHS8izMjmj0DRT_vjzVq5HMQyXtZdVK=o4OP0gzbaN=aJdQ3ig@mail.gmail.com>
References: <20231113130041.58124-1-linyunsheng@huawei.com>
	<20231113130041.58124-4-linyunsheng@huawei.com>
	<CAHS8izMjmj0DRT_vjzVq5HMQyXtZdVK=o4OP0gzbaN=aJdQ3ig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Nov 2023 05:42:16 -0800 Mina Almasry wrote:
> You're doing exactly what I think you're doing, and what was nacked in RFC v1.
> 
> You've converted 'struct page_pool_iov' to essentially become a
> duplicate of 'struct page'. Then, you're casting page_pool_iov* into
> struct page* in mp_dmabuf_devmem_alloc_pages(), then, you're calling
> mm APIs like page_ref_*() on the page_pool_iov* because you've fooled
> the mm stack into thinking dma-buf memory is a struct page.
> 
> RFC v1 was almost exactly the same, except instead of creating a
> duplicate definition of struct page, it just allocated 'struct page'
> instead of allocating another struct that is identical to struct page
> and casting it into struct page.
> 
> I don't think what you're doing here reverses the nacks I got in RFC
> v1. You also did not CC any dma-buf or mm people on this proposal that
> would bring up these concerns again.

Right, but the mirror struct has some appeal to a non-mm person like
myself. The problem IIUC is that this patch is the wrong way around, we
should be converting everyone who can deal with non-host mem to struct
page_pool_iov. Using page_address() on ppiov which hns3 seems to do in
this series does not compute for me.

Then we can turn the existing non-iov helpers to be a thin wrapper with
just a cast from struct page to struct page_pool_iov, and a call of the
iov helper. Again - never cast the other way around.

Also I think this conversion can be done completely separately from the
mem provider changes. Just add struct page_pool_iov and start using it.

Does that make more sense?

