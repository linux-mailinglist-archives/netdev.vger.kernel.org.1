Return-Path: <netdev+bounces-122107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD88295FEDE
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 04:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A971F2225F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 02:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34039B666;
	Tue, 27 Aug 2024 02:11:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40045747F
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724724715; cv=none; b=Zi89Y6KtI0kPZRxwOsqo9hNnvBvU1GmrwoGVMKJtB9jP+KWDjlszqtu0ZR/Ju7jLvii9bm6/Kl4fup4ty+R+gvXBJH9V8+O0Jw7FrhElXLDjXt9V5kTBwyU3m3AeMS90pDlhx0Cf2v5LE9J99ddFTS5QIvWk0TynGRsIt77pLC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724724715; c=relaxed/simple;
	bh=J/3dY/NitXlS4mVtxi0KS/zNdhaLB8tmZ5rQXfhOZ+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ncPLkjUaugJiMt1sbPhwpbZ1NObRvyzoBx4qpkSvv+XRAY019uA+sU+AAGIFLG10zEX1EXNtZZS8YpwoGYL1mVrSXyqUFq7u7ciw+GIRIxKV71MYOlACF7EmstMrycTOwJpA5xdEYqI3hxArwrq9EFCmQRhme4iVhtuy8vxczY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wt9sL3QlNz20mrL;
	Tue, 27 Aug 2024 10:07:02 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 561D1140120;
	Tue, 27 Aug 2024 10:11:50 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 10:11:50 +0800
Message-ID: <566f7eb1-0b5d-444b-8d58-d5da21a86476@huawei.com>
Date: Tue, 27 Aug 2024 10:11:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 0/2] net/ncsi: Use str_up_down to simplify the code
To: Simon Horman <horms@kernel.org>
CC: <sam@mendozajonas.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20240823065259.3327201-1-lihongbo22@huawei.com>
 <20240823162144.GW2164@kernel.org>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240823162144.GW2164@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/8/24 0:21, Simon Horman wrote:
> On Fri, Aug 23, 2024 at 02:52:57PM +0800, Hongbo Li wrote:
>> In commit a98ae7f045b2, str_up_down() helper is introduced to
>> return "up" or "down" string literal, so we can use it to
>> simplify the code and fix the coccinelle warning.
> 
> Hi Hongbo Li,
> 
> That commit hasn't propagated into net-next.
> I guess these patches need to wait for that to happen.

Thank you for reminding, I will send the patch into net-next.

Thanks,
Hongbo

