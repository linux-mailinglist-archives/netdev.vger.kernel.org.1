Return-Path: <netdev+bounces-87946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DC28A513E
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 017CFB25330
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A929674BEB;
	Mon, 15 Apr 2024 13:19:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D422C745E1
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187196; cv=none; b=qjfDy4uL9h6ZBbksjD7An+kK7cSuODow0nXvt/SuXxmSmbSYMLlO83b03a6gCLbz+viU5hewhd6/2P2FDzbozV46AEdx0kb2TTueIAQr+x8dyux9HEDzl2hM5aFcdS+gxH4vUsPNwjKV/tHVtjnvB5GuV5AQtXgz6ER2kksj71E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187196; c=relaxed/simple;
	bh=qwIconWdrpxT4mkPUuU/0mVnRRmmfHALe4WM3GC12zY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=C0C+7u732RP4jUvwhXXNh8F63WXIqjJL6qqdnz3G7NB1HOlUx50Wc1+L4EltvGyDOC29tjbrGWm7ydRKskxV5keCIgedJbr1q5v/AVOegBIB1jRi7bEhfEa92SgHLYjJBW5rlr4zXgJDFUEh04X+J6cuXMy+X1NLDOG4vjOJ7fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VJ7412MvDz1fxb9;
	Mon, 15 Apr 2024 21:16:49 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 1821E18002D;
	Mon, 15 Apr 2024 21:19:46 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 15 Apr
 2024 21:19:45 +0800
Subject: Re: [net-next PATCH 13/15] eth: fbnic: add basic Rx handling
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <netdev@vger.kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
	<kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217496013.1598374.10126180029382922588.stgit@ahduyck-xeon-server.home.arpa>
 <41a39896-480b-f08d-ba67-17e129e39c0f@huawei.com>
 <CAKgT0Uf6MdYX_1OuAFAXadh86zDX_w1a_cwpoPGMxpmC4hGyEA@mail.gmail.com>
 <53b80db6-f2bc-d824-ea42-4b2ac64625f2@huawei.com>
 <CAKgT0UeQS5q=Y2j3mmu9AhWyUMbey-iFL+sKES1UrBtoAXMdzw@mail.gmail.com>
 <0e5e3196-ca2f-b905-a6ba-7721e8586ed7@huawei.com>
 <CAKgT0UeRWsJ+NiniSKa7Z3Law=QrYZp3giLAigJf7EvuAbjkRA@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <bf070035-ba9c-d028-1b11-72af8651f979@huawei.com>
Date: Mon, 15 Apr 2024 21:19:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKgT0UeRWsJ+NiniSKa7Z3Law=QrYZp3giLAigJf7EvuAbjkRA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/12 23:05, Alexander Duyck wrote:

...

>>
>> From the below macro, this hw seems to be only able to handle 4K memory for
>> each entry/desc in qt->sub0 and qt->sub1, so there seems to be a lot of memory
>> that is unused for PAGE_SIZE > 4K as it is allocating memory based on page
>> granularity for each rx_buf in qt->sub0 and qt->sub1.
>>
>> +#define FBNIC_RCD_AL_BUFF_OFF_MASK             DESC_GENMASK(43, 32)
> 
> The advantage of being a purpose built driver is that we aren't
> running on any architectures where the PAGE_SIZE > 4K. If it came to

I am not sure if 'being a purpose built driver' argument is strong enough
here, at least the Kconfig does not seems to be suggesting it is a purpose
built driver, perhaps add a 'depend on' to suggest that?

> that we could probably look at splitting the pages within the
> descriptors by simply having a single page span multiple descriptors.

My point is that we might be able to meet the above use case with a proper
API without driver manipulating the reference counting by calling
page_pool_fragment_page() directly.

