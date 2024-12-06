Return-Path: <netdev+bounces-149537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D13A9E625C
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 01:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B6B1884F0A
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 00:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B93200CD;
	Fri,  6 Dec 2024 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/FK0n/C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A08193;
	Fri,  6 Dec 2024 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445755; cv=none; b=l/vK3ij3djrQH7svZZC0I7K8AKFtFd8K0U9zKmv+GKD2F5DpwFpmu2FC6KHvpkwxcVfxS2jVSP1mhn9adw1kna5Pk7qnz4sGrFW0OAvK0D2xO6PtnsVHpSo+JYb6n9TRKIsJX4Mh1Qtrq2ayYMkxTbPXydnfWyT4bZa0D3Ry4JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445755; c=relaxed/simple;
	bh=ebDKrFwx+yHkQE3pyL+n7vEbgNtRfc461Tr2UF/oeiw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9bwEZLZt8FZwhTWqiTFCA/gIE9JQ+W/eWeUMoLPBlbNXtTMvw74Ycnr92Is0GcPJnlyRNTqeKGwo5jBottiSQyaem9UmJ44XbdRuVZlfsPPLU6TRtSLCk5+5bKCmkN4zNldwKzIkTvgknkLyvaNcTgzyp9DR3VZu10dCLGy1hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/FK0n/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2113CC4CED1;
	Fri,  6 Dec 2024 00:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733445754;
	bh=ebDKrFwx+yHkQE3pyL+n7vEbgNtRfc461Tr2UF/oeiw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h/FK0n/CGdMDINIfU/69TQKcb2RW+ajRcI0oxeiJ5CDs2fXE9dBRopsOcj6LElqf9
	 +NnIDB0GefkECEkIPYIw7kSGzCJpYTZb0hYa2eRrLO5j2h8Fmp1AHbhMeYvKW+aN1d
	 Z98HSPLYxAj81hSixw1zanDcgVrpKG5OZCiqR+7C/m5XedxhKlMSykzICodjm4y+jw
	 4Ialgv0GrGIMiyKHDfm9j8FTvltu6/4Kpimv3inmlP6uMCa1A652TQadJELD6+6RV7
	 OltoQMeifwofHNCe9zHhWfYk7s4ARS45aAFCYMh3IgfJkzMoxeEUPLYsigR6gkMu18
	 36bKmkSyST8jA==
Date: Thu, 5 Dec 2024 16:42:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <liuyonglong@huawei.com>,
 <fanghaiqing@huawei.com>, <zhangkun09@huawei.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v4 1/3] page_pool: fix timing for checking and
 disabling napi_local
Message-ID: <20241205164233.64512141@kernel.org>
In-Reply-To: <70aefeb1-6a78-494c-9d5b-e03696948d11@huawei.com>
References: <20241120103456.396577-1-linyunsheng@huawei.com>
	<20241120103456.396577-2-linyunsheng@huawei.com>
	<20241202184954.3a4095e3@kernel.org>
	<e053e75a-bde1-4e69-9a8d-d1f54be06bdb@huawei.com>
	<20241204172846.5b360d32@kernel.org>
	<70aefeb1-6a78-494c-9d5b-e03696948d11@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Dec 2024 19:43:25 +0800 Yunsheng Lin wrote:
> It depends on what is the callers is trying to protect by calling
> page_pool_disable_direct_recycling().
> 
> It seems the use case for the only user of the API in bnxt driver
> is about reuseing the same NAPI for different page_pool instances.
> 
> According to the steps in netdev_rx_queue.c:
> 1. allocate new queue memory & create page_pool
> 2. stop old rx queue.
> 3. start new rx queue with new page_pool
> 4. free old queue memory + destroy page_pool.
> 
> The page_pool_disable_direct_recycling() is called in step 2, I am
> not sure how napi_enable() & napi_disable() are called in the above
> flow, but it seems there is no use-after-free problem this patch is
> trying to fix for the above flow.
> 
> It doesn't seems to have any concurrent access problem if napi->list_owner
> is set to -1 before napi_disable() returns and the napi_enable() for the
> new queue is called after page_pool_disable_direct_recycling() is called
> in step 2.

The fix is presupposing there is long delay between fetching of
the NAPI pointer and its access. The concern is that NAPI gets
restarted in step 3 after we already READ_ONCE()'ed the pointer,
then we access it and judge it to be running on the same core.
Then we put the page into the fast cache which will never get
flushed.

