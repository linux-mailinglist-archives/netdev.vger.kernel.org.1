Return-Path: <netdev+bounces-41635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C0F7CB7FB
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 03:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1074E281410
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 01:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8612C17D8;
	Tue, 17 Oct 2023 01:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWRuXWUw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E28C15DA
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 01:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236D7C433C8;
	Tue, 17 Oct 2023 01:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697506299;
	bh=UR60mYADl5EHC1NoZ4GrAkpMSCrV5ZQb/hfA25cXCI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hWRuXWUwoKb/yom/A7F87AKYH4syC/l67lawzuKkTbxqZmoiVCVa/B0FON5NvEcGb
	 1mCXphpQRUs/J/qR0vXPq6E/6//hvzzUG52ZwQclfbnSlVj3jO6O1YXT9FXBrP4PQe
	 EImgT2p0map18oRROeMmWTmGOWqNgG4hMl2bATEvipIs8JRFjGMVFsmJEJE6jamAJP
	 zqP0jxpL9TKeyosrdyND0b3O/sePyDxv4tZg08LMSbywgW9JMuYm1cVng7A+9dD+b9
	 V99yj12zz6JxUcynopuGHEKfTWNhQgSzOTVl13itv1bBAQaCUW3U3sGFhrzH3HZWX2
	 iGzyxh5daMIVQ==
Date: Mon, 16 Oct 2023 18:31:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Alexander Duyck <alexander.duyck@gmail.com>, Liang Chen
 <liangchen.linux@gmail.com>, Guillaume Tucker
 <guillaume.tucker@collabora.com>, Matthew Wilcox <willy@infradead.org>,
 Linux-MM <linux-mm@kvack.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet
 <edumazet@google.com>
Subject: Re: [PATCH net-next v11 1/6] page_pool: fragment API support for
 32-bit arch with 64-bit DMA
Message-ID: <20231016183138.2c4366a7@kernel.org>
In-Reply-To: <20231013064827.61135-2-linyunsheng@huawei.com>
References: <20231013064827.61135-1-linyunsheng@huawei.com>
	<20231013064827.61135-2-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Oct 2023 14:48:21 +0800 Yunsheng Lin wrote:
> Currently page_pool_alloc_frag() is not supported in 32-bit
> arch with 64-bit DMA because of the overlap issue between
> pp_frag_count and dma_addr_upper in 'struct page' for those
> arches, which seems to be quite common, see [1], which means
> driver may need to handle it when using fragment API.
> 
> It is assumed that the combination of the above arch with an
> address space >16TB does not exist, as all those arches have
> 64b equivalent, it seems logical to use the 64b version for a
> system with a large address space. It is also assumed that dma
> address is page aligned when we are dma mapping a page aligned
> buffer, see [2].
> 
> That means we're storing 12 bits of 0 at the lower end for a
> dma address, we can reuse those bits for the above arches to
> support 32b+12b, which is 16TB of memory.
> 
> If we make a wrong assumption, a warning is emitted so that
> user can report to us.

Let me apply this one already, I think it should be uncontroversial
from review perspective. And the more time it gets in linux-next
the better..

