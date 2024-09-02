Return-Path: <netdev+bounces-124163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBAE9685A5
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 13:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CC7286664
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 11:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9A41D54D7;
	Mon,  2 Sep 2024 11:02:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9111D54D3;
	Mon,  2 Sep 2024 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274968; cv=none; b=YLU7/sgWFjQzsQvncDpR4zJod/n3i/i/HB3dCkBYI3LCmav76PVFwPzBtHopJGNccLyce+AJ+igGlYYroBFVrGJI0DCz2uI467AeRAek7A5Wbr7FbvuorSpHGNSPqmlsgeQ0NNMgAienR6frQ5J4yNOjDhot2VXRLfpgh/KQwDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274968; c=relaxed/simple;
	bh=thDwlJ5EuftKkTVlDoch8NaZKnpDf7MQJBGoxTWIEJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mipI23fjmFy1KSAJasslfV+DuiZfb0pQNVvmacNRoxuD7gZDfn6KSzll+xf79mHJYA3B0pWDbb8lKLAI0Hmu3e3STyAlKYmYEC65n1G3T5NMHGAZDMA1dCBoXPPMjuZb4ycrRCRWOX4sS5HbDedHongPELlc80tvjoYHd5q0t6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Wy5QM4W61z1xwXS;
	Mon,  2 Sep 2024 19:00:43 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 838AC18002B;
	Mon,  2 Sep 2024 19:02:43 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Sep 2024 19:02:43 +0800
Message-ID: <65efb50a-a8c9-40c3-8db7-7a41b88f973f@huawei.com>
Date: Mon, 2 Sep 2024 19:02:36 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v16 00/14] Replace page_frag with page_frag_cache
 for sk_page_frag()
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alexander Duyck
	<alexander.duyck@gmail.com>
References: <20240830111845.1593542-1-linyunsheng@huawei.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20240830111845.1593542-1-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/8/30 19:18, Yunsheng Lin wrote:

...

> Change log:
> V16:
>    1. Add test_page_frag.sh to handle page_frag_test.ko and add testing
>       for prepare API.

It seems I missed to add the below in Makefile to copy test_page_frag.sh
when doing a 'make install'.

TEST_FILES += test_page_frag.sh

Will send a new version shortly when workers are not busy in netdev CI.

>    2. Move inline helper unneeded outside of the page_frag_cache.c to
>       page_frag_cache.c.
>    3. Reset nc->offset when reusing an old page.
> 
> 

