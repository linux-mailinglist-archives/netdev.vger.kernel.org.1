Return-Path: <netdev+bounces-122197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0864960533
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 11:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D56528360D
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 09:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5600B19D06C;
	Tue, 27 Aug 2024 09:11:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B28319A29A
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 09:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724749881; cv=none; b=QaLBOBYxmnm37fXXYXREAs+FKsOqsvo45SpWO0Ar1Y+/u87waoBW73ALnXrD2jNZQacZvNxo1nI1CscHQPHSmg0bYNOfbc8mYQ68MaIeV593mEIDzozUkAGBepRZtLBcttgR1QWOFmXY/YFnnOwz/69vqJU3pwE/f5y9catOu38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724749881; c=relaxed/simple;
	bh=j7YTmgXdW/r57BTxi2p3kzo7o+pA0l7nf4ee8hxtHsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BJvbw7eTDskTPPqYDDLbRFlfnU2ijKyKRyEKg464BLEmnazYCQ2CmPD0Tp1yyGh/U6BW9pqEglH+9EfOZWp3tvU/e3HEYex+4EkjlRmCLU1dj5cbvEN3K5zDa/QU4Ofq3G7rX/yPoWcWoxAoSjpXjAm0keIPHNolYkJ5QJS9jlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WtM983LQTzQqt1;
	Tue, 27 Aug 2024 17:06:20 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 17611180064;
	Tue, 27 Aug 2024 17:11:09 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 17:11:08 +0800
Message-ID: <720ceec3-f47e-40b0-8931-c3ed92a2a6e9@huawei.com>
Date: Tue, 27 Aug 2024 17:11:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] net/ncsi: Use str_up_down to simplify the
 code
To: Simon Horman <horms@kernel.org>, <michal.swiatkowski@linux.intel.com>
CC: <sam@mendozajonas.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20240827025246.963115-1-lihongbo22@huawei.com>
 <20240827085248.GB1368797@kernel.org>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240827085248.GB1368797@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/8/27 16:52, Simon Horman wrote:
> On Tue, Aug 27, 2024 at 10:52:44AM +0800, Hongbo Li wrote:
>> In commit a98ae7f045b2, str_up_down() helper is introduced to
>> return "up" or "down" string literal, so we can use it to
>> simplify the code and fix the coccinelle warning.
>>
>> v2:
>>   - change subject into net-next
>>
>> v1: https://lore.kernel.org/netdev/20240823162144.GW2164@kernel.org/T/
> 
> Thanks, but another problem I raised wrt to v1 still stands.
> There is a dependency of this patch that is not present in net-next:
> commit a98ae7f045b2 ("lib/string_choices: Add str_up_down() helper").
> 
> So I think you will need to repost once that commit has
> made it into net-next.
> 
ok, I'll follow this. This also answer Michal's question.

Thanks,
hongbo

