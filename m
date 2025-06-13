Return-Path: <netdev+bounces-197343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFC5AD82D5
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 07:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12AF18913E1
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 05:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB9625332E;
	Fri, 13 Jun 2025 05:59:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4272B1A5BA4;
	Fri, 13 Jun 2025 05:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749794367; cv=none; b=Z+pTFYDe1caSZV+yASGDc8V4NPbn5TjjBpKdg2r3vhc8ZYhbVjscLzWTRxNzRvgasposavXcJMT2wasuie+1FI9R66SrM+d9yhfZ4+L4N7HLb27h4DdwXisf5Ozn2L+o8/ZwNmH5lgRxrYfQfmxoGRgHWrlyM8xqH1nVVifd7X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749794367; c=relaxed/simple;
	bh=c++klCP8AZ/loVuqKuk7EumqOBjd7ibQCAuAkbaD1bQ=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YaJS9jauNca3YQFDL67/f4iTc18YfFS8usMkqBTBE8kU48QsdH/3s83Csz7FhbiJUqadi96qmmVSn9KsGWdOtH1p/1Kaw+VbupgnlTNYPXYPefzEDr9CcPjcG99tXWCietuGeeITL37DXJ7PuRjmf5Qqg+yZEwBH9u/ka8DLuKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bJTBz5GZ0z2Cf8J;
	Fri, 13 Jun 2025 13:55:23 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id CAFC1140275;
	Fri, 13 Jun 2025 13:59:15 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Jun 2025 13:59:14 +0800
Message-ID: <02b6bd18-6178-420b-90ab-54308c7504f7@huawei.com>
Date: Fri, 13 Jun 2025 13:59:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann
	<arnd@kernel.org>, Jian Shen <shenjian15@huawei.com>, Salil Mehta
	<salil.mehta@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
	<morbo@google.com>, Justin Stitt <justinstitt@google.com>, Hao Lan
	<lanhao@huawei.com>, Guangwei Zhang <zhangwangwei6@huawei.com>, Netdev
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>
Subject: Re: [PATCH] hns3: work around stack size warning
To: Jakub Kicinski <kuba@kernel.org>
References: <20250610092113.2639248-1-arnd@kernel.org>
 <41f14b66-f301-45cb-bdfd-0192afe588ec@huawei.com>
 <a029763b-6a5c-48ed-b135-daf1d359ac24@app.fastmail.com>
 <34d9d8f7-384e-4447-90e2-7c6694ecbb05@huawei.com>
 <20250612083309.7402a42e@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250612083309.7402a42e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/6/12 23:33, Jakub Kicinski wrote:
> On Thu, 12 Jun 2025 21:09:40 +0800 Jijie Shao wrote:
>> seq_file is good. But the change is quite big.
>> I need to discuss it internally, and it may not be completed so quickly.
>> I will also need consider the maintainer's suggestion.
> Please work on the seq_file conversion, given that the merge window
> just closed you have around 6 weeks to get it done, so hopefully plenty
> of time.

Ok

I will try to send patch as soon as possible to complete this conversion


Thanks
Jijie Shao



