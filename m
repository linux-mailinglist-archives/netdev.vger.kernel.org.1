Return-Path: <netdev+bounces-149206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D85099E4BD4
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 02:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC935167B09
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 01:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985BF82899;
	Thu,  5 Dec 2024 01:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSI9yinM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB48391;
	Thu,  5 Dec 2024 01:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733362128; cv=none; b=a7OBaDi+phN2AqCHpth+BrYYgrnSdPbR0e9jfwWPlXUH3s45EB3uv7A3qlufy0Q5SXTYEP0sSaaPG1BqZE2j+pwE4DXths5sD3l9bMxGZBVm0xkBmHo/acW/NiDmCAwAXjUIwRsbS7BIr3IgIDr1JUMKAaPsmP9BlePu9xHmTFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733362128; c=relaxed/simple;
	bh=8m5seQgO/2uZQt1AKh3oiDjHbZyIZsBJNkf+0YVq8gs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nL1tjBuUJyufrb2VL/t76al4ypgtCAySBu6l4soOb/OolGgrmL/hK2Ba9cUXNbvJF4juem7tksKySOTNLIccJ1u7hMVEfuUdTvgVHj7d8IJuBCbYn5MQ2I2LYzG++4xUW4+MIy6k/M2/PVzhaemw6U6QKCQgTKosqyg8LdRLFms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSI9yinM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478DAC4CECD;
	Thu,  5 Dec 2024 01:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733362127;
	bh=8m5seQgO/2uZQt1AKh3oiDjHbZyIZsBJNkf+0YVq8gs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dSI9yinM3Zg1SoRDlA9GenyNXonJLONmjdGTprAdpl2Y7ZcReyYXdohYTSDrRK+XR
	 9WItEckPEPdxusKY+0fnlrQM/y7vLsvX0gwdfjvrDc4jAxsGrfN8+AiAihiB7iZwaI
	 yLnPCeaWOBMKz18NWZWt+xDejFmi7eGF1e7yHV3go3ySlTQXkZy4MfbiaOl2Wz8rnu
	 fT+kRQGNx4HfUBmIFmfGjqz3+80roY3aqbMQli9anvVtVVdk1Vvw+0a7eMCRmsWpoq
	 IE9qXIF6/QjxiuX/GWZIA6aqdfC2oibfVNHy1BYK8Hfwosa0nBVDZ76/xTZtpG1JEP
	 QnUr+NadR7bDQ==
Date: Wed, 4 Dec 2024 17:28:46 -0800
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
Message-ID: <20241204172846.5b360d32@kernel.org>
In-Reply-To: <e053e75a-bde1-4e69-9a8d-d1f54be06bdb@huawei.com>
References: <20241120103456.396577-1-linyunsheng@huawei.com>
	<20241120103456.396577-2-linyunsheng@huawei.com>
	<20241202184954.3a4095e3@kernel.org>
	<e053e75a-bde1-4e69-9a8d-d1f54be06bdb@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Dec 2024 19:01:14 +0800 Yunsheng Lin wrote:
> > I don't think this is in the right place.
> > Why not inside page_pool_disable_direct_recycling() ?  
> 
> It is in page_pool_destroy() mostly because:
> 1. Only call synchronize_rcu() when there is inflight pages, which should
>    be an unlikely case, and  synchronize_rcu() might need to be called at
>    least for the case of pool->p.napi not being NULL if it is called inside
>    page_pool_disable_direct_recycling().

Right, my point was that page_pool_disable_direct_recycling() 
is an exported function, its callers also need to be protected.

