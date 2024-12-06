Return-Path: <netdev+bounces-149766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 993889E7524
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 17:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82FEE168330
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 16:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D71920D513;
	Fri,  6 Dec 2024 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5lrjQ+o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AE420D509;
	Fri,  6 Dec 2024 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501385; cv=none; b=n9r4faTVRrtJGaSs6ftqN2szgFAyHGmVmWhosEEQB+0zZsBzEiCwdqv59XQhtkdze0z5RagE44hzmU+4Zn1FYEBXOH0rwu6S5SZqVYOX6RG7bqs/0J/gxNY+J6xpuINSJizfsVp3sBLpOkyMdqa1DE3CtoFukpYbwxfJyuvSrfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501385; c=relaxed/simple;
	bh=z6DJ+uNuaZ6AHjUx1YiUgRPRfdKJ4aNb8jOjr0j8caM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/wJRgwn8zIHuZ4JpJ+lSyZM6lrc1D8PVZmAfue8sdb25N7GnjmYtW5Rjy0p5LIEEhwjAR4HVth+Bmtwp1l0f6KznLVSAR1cGk8dCVXHnwh/Wf16eviXVzXpWZXl7eNfegGs/UFuAQK8UOwYr3vrIXiJn1PXf1R+c5JcbEJXDZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5lrjQ+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E6FC4CED1;
	Fri,  6 Dec 2024 16:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733501384;
	bh=z6DJ+uNuaZ6AHjUx1YiUgRPRfdKJ4aNb8jOjr0j8caM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A5lrjQ+oilna3YNNkFNZzr4ATB6kdivBHo4RSCQ9iXo0OExG5VkgE3gPS2sqf36wD
	 lPkFf43dASrY6qoQA2VQV+m7DIqmfU5/7REYqtq2p/lfPw89hKmvN09e+db0bPUjY6
	 9PXZvhOnt61NRF/fg9Fd4bOZVKGfaI5PRQfSQ3DDvZW09Jrky51Q6Ucbx6E2tBkR+X
	 BHgvxkgCz1Tf3Bn4foqyRlCg7j5aGtTgeo1nV6hoLKgRfVTyXfgW1I3fZ4Pny0bHP3
	 0PiUycGJexVXBtTNBY4Jp5NQ/14fN3V7M/Bi28EtHItXQHW8sjnNRGnFA/5iuzdX/5
	 kR69pAPgL3ltw==
Date: Fri, 6 Dec 2024 08:09:43 -0800
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
Message-ID: <20241206080943.32da477c@kernel.org>
In-Reply-To: <c2b306af-4817-4169-814b-adbf25803919@huawei.com>
References: <20241120103456.396577-1-linyunsheng@huawei.com>
	<20241120103456.396577-2-linyunsheng@huawei.com>
	<20241202184954.3a4095e3@kernel.org>
	<e053e75a-bde1-4e69-9a8d-d1f54be06bdb@huawei.com>
	<20241204172846.5b360d32@kernel.org>
	<70aefeb1-6a78-494c-9d5b-e03696948d11@huawei.com>
	<20241205164233.64512141@kernel.org>
	<c2b306af-4817-4169-814b-adbf25803919@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Dec 2024 20:29:40 +0800 Yunsheng Lin wrote:
> On 2024/12/6 8:42, Jakub Kicinski wrote:
> > On Thu, 5 Dec 2024 19:43:25 +0800 Yunsheng Lin wrote:  
> >> It depends on what is the callers is trying to protect by calling
> >> page_pool_disable_direct_recycling().
> >>
> >> It seems the use case for the only user of the API in bnxt driver
> >> is about reuseing the same NAPI for different page_pool instances.
> >>
> >> According to the steps in netdev_rx_queue.c:
> >> 1. allocate new queue memory & create page_pool
> >> 2. stop old rx queue.
> >> 3. start new rx queue with new page_pool
> >> 4. free old queue memory + destroy page_pool.
> >>
> >> The page_pool_disable_direct_recycling() is called in step 2, I am
> >> not sure how napi_enable() & napi_disable() are called in the above
> >> flow, but it seems there is no use-after-free problem this patch is
> >> trying to fix for the above flow.
> >>
> >> It doesn't seems to have any concurrent access problem if napi->list_owner
> >> is set to -1 before napi_disable() returns and the napi_enable() for the
> >> new queue is called after page_pool_disable_direct_recycling() is called
> >> in step 2.  
> > 
> > The fix is presupposing there is long delay between fetching of
> > the NAPI pointer and its access. The concern is that NAPI gets
> > restarted in step 3 after we already READ_ONCE()'ed the pointer,
> > then we access it and judge it to be running on the same core.
> > Then we put the page into the fast cache which will never get
> > flushed.  
> 
> It seems the napi_disable() is called before netdev_rx_queue_restart()
> and napi_enable() and ____napi_schedule() are called after
> netdev_rx_queue_restart() as there is no napi API called in the
> implementation of 'netdev_queue_mgmt_ops' for bnxt driver?
> 
> If yes, napi->list_owner is set to -1 before step 1 and only set to
> a valid cpu in step 6 as below:
> 1. napi_disable()
> 2. allocate new queue memory & create new page_pool.
> 3. stop old rx queue.
> 4. start new rx queue with new page_pool.
> 5. free old queue memory + destroy old page_pool.
> 6. napi_enable() & ____napi_schedule()
> 
> And there are at least three flows involved here:
> flow 1: calling napi_complete_done() and set napi->list_owner to -1.
> flow 2: calling netdev_rx_queue_restart().
> flow 3: calling skb_defer_free_flush() with the page belonging to the old
>        page_pool.
> 
> The only case of page_pool_napi_local() returning true in flow 3 I can
> think of is that flow 1 and flow 3 might need to be called in the softirq
> of the same CPU and flow 3 might need to be called before flow 1.
> 
> It seems impossible that page_pool_napi_local() will return true between
> step 1 and step 6 as updated napi->list_owner is always seen by flow 3
> when they are both called in the softirq context of the same CPU or
> napi->list_owner != CPU that calling flow 3, which seems like an implicit
> assumption for the case of napi scheduling between different cpus too.
> 
> And old page_pool is destroyed in step 5, I am not sure if it is necessary
> to call page_pool_disable_direct_recycling() in step 3 if page_pool_destroy()
> already have the synchronize_rcu() in step 5 before enabling napi.
> 
> If not, maybe I am missing something here.

Yes, I believe you got the steps 5 and 6 backwards.

> It would be good to be more specific
> about the timing window that page_pool_napi_local() returning true for the old
> page_pool.

