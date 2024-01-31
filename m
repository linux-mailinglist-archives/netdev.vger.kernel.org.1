Return-Path: <netdev+bounces-67481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83728843A15
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 10:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A27D1F2F7EC
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 09:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E650B5813B;
	Wed, 31 Jan 2024 08:56:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A180D60DDB
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691400; cv=none; b=O6cMG/DFvr+uNqqohMJRotj0td0LiuPH8mRe4anSgzw5VpqEgI01oekns7quqjwsHphxIX6nPBPjyBnDTe30B5/Qfol/IilYQjRrSp/eGDzARJ22N2AHAoej1PC8UfNXuS0zXUlv0zqgUcg0oqKeFeQzTWdr8TCrehUjHGkFwko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691400; c=relaxed/simple;
	bh=FaT6l/jRCUfMdvrVm4nWD6OBhIASXq3Hifc77Tl0q4I=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sOi8zZE18JSipvIR+wWJz1yhQtTMzQFpR5E/9dDXiJNN+1P5xGrlu8jKzJp4lBrWqJEYSWM7LK3d9epTF1naj3HcHAu4V7haIer13GDcU61f4B82IJGi0fMhNVoUrT4/R7NJ4AzaVblLOe3DlbnsGtJSI/VgJKJdm/Xi3hrqU5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TPwqh70mjzLqCc;
	Wed, 31 Jan 2024 16:56:00 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D13A18005E;
	Wed, 31 Jan 2024 16:56:27 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 31 Jan
 2024 16:56:27 +0800
Subject: Re: Report on abnormal behavior of "page_pool" API
To: Justin Lai <justinlai0215@realtek.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
References: <305a3c3dfc854be6bbd058e2d54c855c@realtek.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <e9beff86-ba0e-ad3c-1972-16cdc3b29ab3@huawei.com>
Date: Wed, 31 Jan 2024 16:56:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <305a3c3dfc854be6bbd058e2d54c855c@realtek.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/1/31 15:31, Justin Lai wrote:
> To whom it may concern,
> 
> I hope this email finds you well. I am writing to report a behavior
> which seems to be abnormal.
> 
> When I remove the module, I call page_pool_destroy() to release the

Which module?

> page_pool, but this message appears, page_pool_release_retry() stalled 
> pool shutdown 1024 inflight 120 sec. Then I tried to return the page to
> page_pool before calling page_pool_destroy(), so I called
> page_pool_put_full_page() first, but after doing so, this message was
> printed, page_pool_empty_ring() page_pool refcnt 0 violation, and the

As we have "page_ref_count(page) == 1" checking to allow recycling page
in pool->ring:
https://elixir.bootlin.com/linux/v6.8-rc2/source/net/core/page_pool.c#L654

It seems somebody is still using the page and manipulating _refcount while
the page is sitting in the pool->ring?


> computer crashed.
> 
> I would like to ask what could be causing this and how I should fix it.

Not sure if you read the below doc for page_pool, understanding the internal
detail and the API usages may help you debuging the problem:
Documentation/networking/page_pool.rst

> 
> The information on my working environment is: Ubuntu23.10,
> linux kernel 6.4, 6.5, 6.6
> 
> Thank you for your time and efforts, I am looking forward to your reply.
> 
> Best regards,
> Justin
> 
> .
> 

