Return-Path: <netdev+bounces-108450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A7C923DD7
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 14:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593761C249DC
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 12:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6D616DC2C;
	Tue,  2 Jul 2024 12:27:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1339016C6A8;
	Tue,  2 Jul 2024 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923277; cv=none; b=BKhp7mWpQfxi1C/AoMBjnbAxqhmnvnS86oJeQBM4IOV793YLKCn7DRtiqPfyMfdnso5TcNVzCFPl0C/EH/Kjqw2PaI/aOel23qcvI+XYj6c/2wh1UE+xG0WI4aGjJ4qBc1ID6XgKBOof8AQ94zMaC+2mEGZNm1l3vN5IKRm8wvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923277; c=relaxed/simple;
	bh=XgRdsTsKnLkYsDUEKrD3xPL2FQ/EQXo97ANxIUdq+90=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=V4ylJOV4j3JQTReRJSWVzWBYouDEo9dG/peKLp7C+qtr6SLqclKefHdlLzekJ/c/IhffNs7xdq8o0BnOqEipArcc8kETqGw9iV107hcYhR4Xt8QB5kCIu1+svhZZXWRBFtB2LkuICkNva9PBR+vbVgrThdCwEU4JvdqhqwG2+UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WD2BJ4sjPz1T4lL;
	Tue,  2 Jul 2024 20:23:20 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id C4B64180AA6;
	Tue,  2 Jul 2024 20:27:52 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemf200006.china.huawei.com
 (7.185.36.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 2 Jul
 2024 20:27:52 +0800
Subject: Re: [PATCH net-next v9 02/13] mm: move the page fragment allocator
 from page_alloc into its own file
To: Alexander H Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Howells
	<dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <20240625135216.47007-3-linyunsheng@huawei.com>
 <86c56c9a88d07efbfe1e85bec678e86704588a15.camel@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <3ac9d5ef-50a4-286d-eeec-a8d9a846278f@huawei.com>
Date: Tue, 2 Jul 2024 20:27:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <86c56c9a88d07efbfe1e85bec678e86704588a15.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/7/2 7:10, Alexander H Duyck wrote:
> On Tue, 2024-06-25 at 21:52 +0800, Yunsheng Lin wrote:
>> Inspired by [1], move the page fragment allocator from page_alloc
>> into its own c file and header file, as we are about to make more
>> change for it to replace another page_frag implementation in
>> sock.c
>>
>> 1. https://lore.kernel.org/all/20230411160902.4134381-3-dhowells@redhat.com/
>>
>> CC: David Howells <dhowells@redhat.com>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> 
> So one thing that I think might have been overlooked in the previous
> reviews is the fact that the headers weren't necessarily self
> sufficient. You were introducing dependencies that had to be fulfilled
> by other headers.
> 
> One thing you might try doing as part of your testing would be to add a
> C file that just adds your header and calls your functions to verify
> that there aren't any unincluded dependencies.

Sure, will do.

> 

