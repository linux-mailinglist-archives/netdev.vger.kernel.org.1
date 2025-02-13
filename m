Return-Path: <netdev+bounces-165997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DD1A33E33
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 12:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3471689C0
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5736227E8D;
	Thu, 13 Feb 2025 11:35:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54456227E90
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446533; cv=none; b=gY/Q1jL2JwJzuH8GSPW+q0la40FI+QaUwcPhyrv6TodCXiuV6etaTQFYMnxsuddgDF/Wcib5v/OuAsVhJalHrg5AfLWF3kBMlv9zVl8EcMl41xR5Rbp5fOC6rxBbm2u6MX1/yqK/l33QSqfhLFC9XeK+r2wiVBWxnLy1XwDQpZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446533; c=relaxed/simple;
	bh=bBgzI0bBR+CSlfugwIsa84If6g5xbrHc4BNEJfjmEwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hPYmfq0lHAjLtNGbaALIMePteheupt9Eas7e7fgcrj2FQ6rni09GH5un4kiwcYFtnbgJjtD6iMsz8nDjzosqcfzK2uuZdBb+a6xM4hBAQOriKgVRAd7HnCwmVUtkyJrJG5IP1u5qKfxlH8J7D5mnSaHIaS0YT8CHfAxCz1wPu4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YttLn58lmz16KF9;
	Thu, 13 Feb 2025 19:32:01 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id B1538180087;
	Thu, 13 Feb 2025 19:35:22 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Feb 2025 19:35:22 +0800
Message-ID: <1a779ee7-e776-416d-88f2-3080d33adbb9@huawei.com>
Date: Thu, 13 Feb 2025 19:35:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Q] page_pool stats and 32bit architectures.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	<netdev@vger.kernel.org>
CC: Joe Damato <jdamato@fastly.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Thomas Gleixner
	<tglx@linutronix.de>
References: <20250213093925.x_ggH1aj@linutronix.de>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20250213093925.x_ggH1aj@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/2/13 17:39, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> The statistics counter (page_pool_{alloc|recycle}_stats) use u64 and
> this_cpu_inc() + regular read.
> This is okay on 64bit architectures but on 32bit architectures inc +
> read is split into two operations. So the 32bit arch might observe a
> wrong value if the lower 32bit part of the counter overflows before the
> upper part is updated.
> We can ignore this or switch to u64_stats_t.
> Suggestions?

u64_stats_t seems like the right direction.

