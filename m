Return-Path: <netdev+bounces-16891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA1C74F5A2
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 18:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F351C20DE5
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 16:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F275319BB6;
	Tue, 11 Jul 2023 16:37:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8530FA5C
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 16:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5455DC433C7;
	Tue, 11 Jul 2023 16:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689093427;
	bh=aHT875jqb7GCXnWc2Ry1gRBSKWwPBNo+nPkkwZHSA7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XZcDX6MuV+y8LxjpADtuxJN9kkfLBsqNkhqyXEa3psF4oOdOqc7RnUlVqRXrzujQx
	 U7z6hXEp3i1p7PnWWUws8u7XMruc5KZg+optBKJZs4J5sNj8goDRJpdSN+Z8iuVOOJ
	 QniYqPd7vbqZMUv4lnKK4zCM5yIDha1JSBvNLBWiwT2fZCTFpAW67TyYK8KWH5iF5H
	 qI6F9kT+t5g2omPrQcCHlRiBXiGKNucyuEDNHjmprkwPf13Zi+RUiU2PE1jLMRUVDd
	 Srz3L511P+Go6bRM1JShlUd6lZ9ESMqe3iOvNXbIP7bnTf3acQ4E5x+yUxgasMGKva
	 gfOsNkBSXpwbw==
Date: Tue, 11 Jul 2023 09:37:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Yunsheng Lin <yunshenglin0825@gmail.com>, Yunsheng Lin
 <linyunsheng@huawei.com>, <davem@davemloft.net>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, Liang
 Chen <liangchen.linux@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Eric Dumazet <edumazet@google.com>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch
 with 64-bit DMA
Message-ID: <20230711093705.45454e41@kernel.org>
In-Reply-To: <8639b838-8284-05a2-dbc3-7e4cb45f163a@intel.com>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
	<20230629120226.14854-2-linyunsheng@huawei.com>
	<20230707170157.12727e44@kernel.org>
	<3d973088-4881-0863-0207-36d61b4505ec@gmail.com>
	<20230710113841.482cbeac@kernel.org>
	<8639b838-8284-05a2-dbc3-7e4cb45f163a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jul 2023 12:59:00 +0200 Alexander Lobakin wrote:
> I'm fine with that, although ain't really able to work on this myself
> now :s (BTW I almost finished Netlink bigints, just some more libie/IAVF
> crap).

FWIW I was thinking about the bigints recently, and from ynl
perspective I think we may want two flavors :( One which is at
most the length of platform's long long, and another which is
always a bigint. The latter will be more work for user space
to handle, so given 99% of use cases don't need more than 64b
we should make its life easier?

> It just needs to be carefully designed, because if we want move ALL the
> inlines to a new header, we may end up including 2 PP's headers in each
> file. That's why I'd prefer "core/driver" separation. Let's say skbuff.c
> doesn't need page_pool_create(), page_pool_alloc(), and so on, while
> drivers don't need some of its internal functions.
> OTOH after my patch it's included in only around 20-30 files on
> allmodconfig. That is literally nothing comparing to e.g. kernel.h
> (w/includes) :D

Well, once you have to rebuilding 100+ files it gets pretty hard to
clean things up ;) 

I think I described the preferred setup, previously:

$path/page_pool.h:

#include <$path/page_pool/types.h>
#include <$path/page_pool/helpers.h>

$path/page_pool/types.h - has types
$path/page_pool/helpers.h - has all the inlines

C sources can include $path/page_pool.h, headers should generally only
include $path/page_pool/types.h.

