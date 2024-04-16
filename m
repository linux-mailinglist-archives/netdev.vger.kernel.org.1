Return-Path: <netdev+bounces-88340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0428A6C36
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 15:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5ED1F21402
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 13:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90E212C473;
	Tue, 16 Apr 2024 13:25:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7855F8594D
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713273938; cv=none; b=UovNR31maCYt6P7Le1ISXKSeAnmlOkX8qZQPsjqmRMFCabnqoj1u0dCEUOdZK/K74uQzmPhzIg8xyR08Uzu1TQXf8zM9lWHQxuF4Gwp9bTiEeKnJ0Phy5AAnebFcoDxIqtXDItG5PCSJ0MgVpswz54yKilJ1dAPvEbWjQL6brEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713273938; c=relaxed/simple;
	bh=7nidbYpb0tGozLwTJYYC4iIQm0/4yteJ/UjiXKd/Ulg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eSqb/kDjhUVQ9z81kvsmhtS+RgwIIg0eU1njEzx9XCkNUrrd27vN1zmvXsl05rd3ZY3b3+qjJLbDN+xymPVcZHsKxJpjq65Rt/58vTKcemgZ15zy+IIx689pKqGIDRE0UTGEjL0Byr7t0eb2uuCY7UZ4YIqOIsU32zdqiSMvt4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VJl8375kXz1RD9H;
	Tue, 16 Apr 2024 21:22:27 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E91F140120;
	Tue, 16 Apr 2024 21:25:25 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 16 Apr
 2024 21:25:25 +0800
Subject: Re: [net-next PATCH 13/15] eth: fbnic: add basic Rx handling
To: Jakub Kicinski <kuba@kernel.org>, Alexander Duyck
	<alexander.duyck@gmail.com>
CC: <netdev@vger.kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
	<davem@davemloft.net>, <pabeni@redhat.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217496013.1598374.10126180029382922588.stgit@ahduyck-xeon-server.home.arpa>
 <41a39896-480b-f08d-ba67-17e129e39c0f@huawei.com>
 <CAKgT0Uf6MdYX_1OuAFAXadh86zDX_w1a_cwpoPGMxpmC4hGyEA@mail.gmail.com>
 <53b80db6-f2bc-d824-ea42-4b2ac64625f2@huawei.com>
 <CAKgT0UeQS5q=Y2j3mmu9AhWyUMbey-iFL+sKES1UrBtoAXMdzw@mail.gmail.com>
 <0e5e3196-ca2f-b905-a6ba-7721e8586ed7@huawei.com>
 <CAKgT0UeRWsJ+NiniSKa7Z3Law=QrYZp3giLAigJf7EvuAbjkRA@mail.gmail.com>
 <bf070035-ba9c-d028-1b11-72af8651f979@huawei.com>
 <CAKgT0UccovDVS8-TPXxgGbrTAqpeVHRQuCwf7f2qkfcPaPOA-A@mail.gmail.com>
 <20240415101101.3dd207c4@kernel.org>
 <CAKgT0UcGN3-6R4pt8BQv2hD04oYk48GfFs1O_UGChvrrFT5eCw@mail.gmail.com>
 <20240415111918.340ebb98@kernel.org>
 <CAKgT0Ud366SsaLftQ6Gd4hg+MW9VixOhG9nA9pa4VKh0maozBg@mail.gmail.com>
 <20240415150136.337ada44@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <b725331c-ae88-b9dd-de12-e8e9b9fc020b@huawei.com>
Date: Tue, 16 Apr 2024 21:25:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240415150136.337ada44@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/16 6:01, Jakub Kicinski wrote:
> On Mon, 15 Apr 2024 11:55:37 -0700 Alexander Duyck wrote:
>> It would take a few more changes to make it all work. Basically we
>> would need to map the page into every descriptor entry since the worst
>> case scenario would be that somehow we end up with things getting so
>> tight that the page is only partially mapped and we are working
>> through it as a subset of 4K slices with some at the beginning being
>> unmapped from the descriptor ring while some are still waiting to be
>> assigned to a descriptor and used. What I would probably have to look
>> at doing is adding some sort of cache on the ring to hold onto it
>> while we dole it out 4K at a time to the descriptors. Either that or
>> enforce a hard 16 descriptor limit where we have to assign a full page
>> with every allocation meaning we are at a higher risk for starving the
>> device for memory.
> 
> Hm, that would be more work, indeed, but potentially beneficial. I was
> thinking of separating the page allocation and draining logic a bit
> from the fragment handling logic.
> 
> #define RXPAGE_IDX(idx)		((idx) >> PAGE_SHIFT - 12)
> 
> in fbnic_clean_bdq():
> 
> 	while (RXPAGE_IDX(head) != RXPAGE_IDX(hw_head))
> 
> refer to rx_buf as:
> 
> 	struct fbnic_rx_buf *rx_buf = &ring->rx_buf[idx >> LOSE_BITS];
> 
> Refill always works in batches of multiple of PAGE_SIZE / 4k.

Are we expecting drivers wanting best possible performance doing the
above duplicated trick?

"grep -rn '_reuse_' drivers/net/ethernet/" seems to suggest that we
already have similar trick to do the page spliting in a lot of drivers,
I would rather we do not duplicate the above trick again.

