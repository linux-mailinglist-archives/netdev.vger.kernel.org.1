Return-Path: <netdev+bounces-116444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A73D94A67F
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 13:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F96D1C208CC
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 11:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F571C9DDA;
	Wed,  7 Aug 2024 11:00:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FF713A3F0
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723028441; cv=none; b=rzA5fP+Ku/MBdk6vzqzEdATe60YIwPRhkmCQrvdO6ofEkELYrqfg4QsiUVGGZizDUdbd1haeV/Esb0gQnt6g9Ri7ECtPba3NVGJdR+hLDagkAkdeAt40bBoKSxTa6s+wlm+YLlgxBN1DspHgprxXshh3R11wqeU6ZL1faCJK074=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723028441; c=relaxed/simple;
	bh=axNJP5qiBgK+XS2ALwsBZvxAcJM36prJcR6hc5fVZKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CCjkCMJvb1U+aZBONYmQQnEWdoRrVct324P3SluEGoSpEuWEDZIkharBnrKv+LSbBSA8jtQzeRSa4XfIw5NwdWpVxnZaecYFMDBbF9i0EQ9I26oZhsL/VJHwOZHzAkaCRlUCp4hWk/68WlrLMEv+1YpUM9HAcdTMubcwl895LCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wf6Xm65wPz1j6Q2;
	Wed,  7 Aug 2024 18:55:52 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A777314010C;
	Wed,  7 Aug 2024 19:00:35 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 Aug 2024 19:00:35 +0800
Message-ID: <523894ab-2d38-415f-8306-c0d1abd911ec@huawei.com>
Date: Wed, 7 Aug 2024 19:00:35 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net] net: make page pool stall netdev unregistration to
 avoid IOMMU crashes
To: Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<ilias.apalodimas@linaro.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Alexander Duyck <alexander.duyck@gmail.com>, Yonglong Liu
	<liuyonglong@huawei.com>
References: <20240806151618.1373008-1-kuba@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20240806151618.1373008-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/8/6 23:16, Jakub Kicinski wrote:
> There appears to be no clean way to hold onto the IOMMU, so page pool
> cannot outlast the driver which created it. We have no way to stall
> the driver unregister, but we can use netdev unregistration as a proxy.
> 
> Note that page pool pages may last forever, we have seen it happen
> e.g. when application leaks a socket and page is stuck in its rcv queue.

We saw some page_pool pages might last forever too, but were not sure
if it was the same reason as above? Are there some cmds/ways to debug
if a application leaks a socket and page is stuck in its rcv queue?

> Hopefully this is fine in this particular case, as we will only stall
> unregistering of devices which want the page pool to manage the DMA
> mapping for them, i.e. HW backed netdevs. And obviously keeping
> the netdev around is preferable to a crash.
> 
> More work is needed for weird drivers which share one pool among
> multiple netdevs, as they are not allowed to set the pp->netdev
> pointer. We probably need to add a bit that says "don't expose
> to uAPI for them".
> 


