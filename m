Return-Path: <netdev+bounces-148938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAC39E3903
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 12:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49D11B334B6
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 11:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519FD1B395B;
	Wed,  4 Dec 2024 11:23:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18951B4158;
	Wed,  4 Dec 2024 11:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733311394; cv=none; b=qKyfr0nRe5WWj8zK8BJ1v+3Bp8a8RK9s9Fq4LMZdWebrKFUafAALIbEsFMdvNJQ0fE0oU6hnwKS8wv9YAENjlrWpv3qpq3QvWUZ7IGRjfaPpAJ/MGcu+4zKaQos9pze4enu2d380amie4qtdqEp7eeuHbK4bDVaPavJqNt+OCyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733311394; c=relaxed/simple;
	bh=qwjt/ECOTb9xxuzZ7OzMYz4iCEymLyzapY56BmcX4eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W7n106mAQHRVOwtW2GpjG5yyqUPhSAI4OVh4LeaGSN2lwG9Ef7EQKPXDw+YHbVFLOCn21exLBoqxKQatdFpC6XTLiMoshCZRQozlDPXx/jEA9NdUaftxCu+dw3tlcup+C/E8K74GwURHe/g9beot6O4dX9Pzcl5LfzqaJoaXSwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Y3FTR6Sygz21mW6;
	Wed,  4 Dec 2024 19:21:31 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E90D14011B;
	Wed,  4 Dec 2024 19:23:09 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Dec 2024 19:23:08 +0800
Message-ID: <18654cde-769c-4b44-9603-367299b693dd@huawei.com>
Date: Wed, 4 Dec 2024 19:23:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 00/10] Replace page_frag with page_frag_cache
 (Part-2)
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>, Alexander
 Duyck <alexander.duyck@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shuah Khan
	<skhan@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linux-MM <linux-mm@kvack.org>
References: <20241114121606.3434517-1-linyunsheng@huawei.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20241114121606.3434517-1-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/11/14 20:15, Yunsheng Lin wrote:
> This is part 2 of "Replace page_frag with page_frag_cache",
> which introduces the new API and replaces page_frag with
> page_frag_cache for sk_page_frag().

Hi, Alexander & Maintainers
As the part 1 merged in the last recycle seems to have not
caused any obvious regression except the testing one. Any
comment or idea for this version of part 2?
If not, I should probably repost based on the latest net-next.

