Return-Path: <netdev+bounces-171365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688B2A4CAA0
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 19:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8877163A12
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67786216E1D;
	Mon,  3 Mar 2025 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2JJEhUy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A93A20CCD9;
	Mon,  3 Mar 2025 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024786; cv=none; b=DM969lsmqW9eeZgP4WYgNAIw+RuvOQWUQ8UpcFM8PVtJ75N0TmWNQr1vpzWW9rNCbk9cuO6eEk+inD7AW+c8GC5vsDIqtQgUFYDO6EWcbFV8KLWe30d3D4/Z9DcRPyaxu7nQFLdIfNBUEh9Za8fD14pGtVTYb/L2QvPL+JSnYBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024786; c=relaxed/simple;
	bh=+FQX0q0weYu81jM7HMT5Vyg2FBtOmHwFPUOmeRcK4po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTYfGRAI6mJdyYN5Pt7e0IcF5xOBE4QXoaPv2sewWCmbZVLH3Mr2pvFMwojyC7ptbnzoW6vB0wDMlmr/cFagr/2DJCD/bsZLJ4f36W5L+Ccx0+L/IlPhmSnFQC9Zl9SbtON0NM6duUL80BA4l8SbbsBV9KhBjtgNNycd4mTtkVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2JJEhUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12DDC4CED6;
	Mon,  3 Mar 2025 17:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741024786;
	bh=+FQX0q0weYu81jM7HMT5Vyg2FBtOmHwFPUOmeRcK4po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u2JJEhUyYSmUf6JuixdvVWaTt/HTkoBVUOavWvu+jc4/rjY0q3vggh1ER9na+BzZk
	 bxRyntmUDLLoysKWslchQclWA4XlP6Y980xXUjbIK5gJvyphQ3fcpBeB1IGGepRei9
	 JClAvLLiifsVNFd/8+J7+bhoSXupNjjBsUuO4IsiZ1wELMPa0aGUsqvSfnzVTOJR0w
	 5V2Sx+JzjjXSJzJ+H3NOhWXNFJ1vtOSVVltY7Y3BM4yUMCwFcICPYraNPNomHk3rfI
	 Rkw8ZvnaNtrPt9Mw9Mxnw6jqdS1m1gS/L8XcmF4Zx4U9UTdz/VouU9jlTc47NnZj5X
	 c/g0zrb/wvHYg==
Date: Mon, 3 Mar 2025 17:59:40 +0000
From: Simon Horman <horms@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	zhangkun09@huawei.com, liuyonglong@huawei.com,
	fanghaiqing@huawei.com, Robin Murphy <robin.murphy@arm.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	IOMMU <iommu@lists.linux.dev>, Eric Dumazet <edumazet@google.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 3/4] page_pool: support unlimited number of
 inflight pages
Message-ID: <20250303175940.GW1615191@kernel.org>
References: <20250226110340.2671366-1-linyunsheng@huawei.com>
 <20250226110340.2671366-4-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226110340.2671366-4-linyunsheng@huawei.com>

On Wed, Feb 26, 2025 at 07:03:38PM +0800, Yunsheng Lin wrote:
> Currently a fixed size of pre-allocated memory is used to
> keep track of the inflight pages, in order to use the DMA
> API correctly.
> 
> As mentioned [1], the number of inflight pages can be up to
> 73203 depending on the use cases. Allocate memory dynamically
> to keep track of the inflight pages when pre-allocated memory
> runs out.
> 
> The overhead of using dynamic memory allocation is about 10ns~
> 20ns, which causes 5%~10% performance degradation for the test
> case of time_bench_page_pool03_slow() in [2].
> 
> 1. https://lore.kernel.org/all/b8b7818a-e44b-45f5-91c2-d5eceaa5dd5b@kernel.org/
> 2. https://github.com/netoptimizer/prototype-kernel
> CC: Robin Murphy <robin.murphy@arm.com>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> CC: IOMMU <iommu@lists.linux.dev>
> Fixes: f71fec47c2df ("page_pool: make sure struct device is stable")
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  Documentation/netlink/specs/netdev.yaml | 16 +++++
>  include/net/page_pool/types.h           | 10 ++++
>  include/uapi/linux/netdev.h             |  2 +
>  net/core/page_pool.c                    | 79 ++++++++++++++++++++++++-
>  net/core/page_pool_priv.h               |  2 +
>  net/core/page_pool_user.c               | 39 ++++++++++--
>  tools/net/ynl/samples/page-pool.c       | 11 ++++
>  7 files changed, 154 insertions(+), 5 deletions(-)

Hi,

It looks like the header changes in this patch don't quite
correspond to the spec changes.

But if so, perhaps the spec update needs to change,
because adding values to an enum, other than at the end,
feels like UAPI breakage to me.

I see this:

$ ./tools/net/ynl/ynl-regen.sh -f
$ git diff
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 9309cbfeb8d2..9e02f6190b07 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -100,11 +100,11 @@ enum {
 	NETDEV_A_PAGE_POOL_NAPI_ID,
 	NETDEV_A_PAGE_POOL_INFLIGHT,
 	NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
+	NETDEV_A_PAGE_POOL_ITEM_MEM_RESIDENT,
+	NETDEV_A_PAGE_POOL_ITEM_MEM_USED,
 	NETDEV_A_PAGE_POOL_DETACH_TIME,
 	NETDEV_A_PAGE_POOL_DMABUF,
 	NETDEV_A_PAGE_POOL_IO_URING,
-	NETDEV_A_PAGE_POOL_ITEM_MEM_RESIDENT,
-	NETDEV_A_PAGE_POOL_ITEM_MEM_USED,
 
 	__NETDEV_A_PAGE_POOL_MAX,
 	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 7600bf62dbdf..9e02f6190b07 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -100,6 +100,8 @@ enum {
 	NETDEV_A_PAGE_POOL_NAPI_ID,
 	NETDEV_A_PAGE_POOL_INFLIGHT,
 	NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
+	NETDEV_A_PAGE_POOL_ITEM_MEM_RESIDENT,
+	NETDEV_A_PAGE_POOL_ITEM_MEM_USED,
 	NETDEV_A_PAGE_POOL_DETACH_TIME,
 	NETDEV_A_PAGE_POOL_DMABUF,
 	NETDEV_A_PAGE_POOL_IO_URING,


