Return-Path: <netdev+bounces-196953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B46CAD713D
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6CA172829
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 13:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5533023C8A2;
	Thu, 12 Jun 2025 13:09:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE58C2F430C;
	Thu, 12 Jun 2025 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749733787; cv=none; b=uMQDPEgc0hu1Yd/ibAAWyb0z6stduU1EdOycVpVDFzjV6VUiR0ZR4a2IUuPiXlZUgE66donJJqSdLAUClgpKbqzwhaO1p4q1kYmxdSbwVnrKNQcI0T02gRfJ+AQvT1cODy0qScqL+Zp+wqbOgRptp3UvMbnZLOGQiHbfATTHdvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749733787; c=relaxed/simple;
	bh=DNd41N3FOFnvelD0wpL5VGYshR/FFAfzJM3V9VuwB+U=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AJLk2L3ZpaHn0lvK8V3ZsVYukgf5umRXOqjXWz8uaxpqbJbyDybYPT9MpcFClPIN9yZDTD4K7xEIxn2AjUxCN8iIL/goShB0jiVkHt9N7aeyh12NWDS2ga5cwstC5sj1hOj7feBR6JNccwpftHLSuO0wU40Bj+wvx7omASR1o8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bJ2s13Q1gz2TS1V;
	Thu, 12 Jun 2025 21:08:21 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 408081A0188;
	Thu, 12 Jun 2025 21:09:42 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Jun 2025 21:09:41 +0800
Message-ID: <34d9d8f7-384e-4447-90e2-7c6694ecbb05@huawei.com>
Date: Thu, 12 Jun 2025 21:09:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>, Hao Lan <lanhao@huawei.com>, Guangwei Zhang
	<zhangwangwei6@huawei.com>, Netdev <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
Subject: Re: [PATCH] hns3: work around stack size warning
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, Jian Shen
	<shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Nathan Chancellor <nathan@kernel.org>
References: <20250610092113.2639248-1-arnd@kernel.org>
 <41f14b66-f301-45cb-bdfd-0192afe588ec@huawei.com>
 <a029763b-6a5c-48ed-b135-daf1d359ac24@app.fastmail.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <a029763b-6a5c-48ed-b135-daf1d359ac24@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/6/12 0:36, Arnd Bergmann wrote:
> On Wed, Jun 11, 2025, at 04:10, Jijie Shao wrote:
>> on 2025/6/10 17:21, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>> Annotate hns3_dbg_tx_spare_info() as noinline_for_stack to force the
>>> behavior that gcc has, regardless of the compiler.
>>>
>>> Ideally all the functions in here would be changed to avoid on-stack
>>> output buffers.
>> Would you please help test whether the following changes have solved
>> your problem,
>> And I'm not sure if this patch should be sent to net or net-next...
> Your patch arrived with whitespace corruption here, so I could not
> try it, but I'm sure it would help avoid the warning.
>
> However, this is not what meant with my suggestion: you already
> allocate a temporary buffer in hns3_dbg_open() and I would
> expect it to be possible to read into that buffer directly
> without a second temporary buffer (on stack or kmalloc).
>
> The normal way of doing this would be to use the infrastructure
> from seq_file and then seq_printf() and not have any extra buffers
> on top of that.
>
>        Arnd


Hi,

seq_file is good. But the change is quite big.
I need to discuss it internally, and it may not be completed so quickly.
I will also need consider the maintainer's suggestion.

Thanks,
Jijie Shao


