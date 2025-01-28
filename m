Return-Path: <netdev+bounces-161250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A468DA2032F
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 03:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0322D162E72
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 02:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B84A18A959;
	Tue, 28 Jan 2025 02:41:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5292932C85;
	Tue, 28 Jan 2025 02:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738032091; cv=none; b=XIE8AFR3W0cQ5yYVf2BXPkHi5OPuhfstC+fzRDbI44faPfp0iuWqvbnYB6xyEONuDKP3APgV5qVLL1wOnlJMyYD7maHAL2g2g1KpYT/Ex1wSOwI9/gmhm/MYk66SIB83JPdOSALXotcCmbpop1UV4uZbYmEUGgBA4l//OoAWQsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738032091; c=relaxed/simple;
	bh=kaSu+ftVO6EfcsaGIaPTpc7LSPaoMBiPIDhi0bHVVoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjDvm+4I5dSPFK9X0j/auUFKRLVnL4BFVt/6+0MCRyZOGC8FX2wDSHk+yHHnxmXORYAVLad9Sar8orWSd7d++iMHDcNd2yQJ/HiHlsjSlRQfOlBYOvXd9WRz8ZANSSgmYYBDIc0CzR8vaZXHO20JNNRoJyYWyD+ZOElWQutzZ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 28 Jan 2025 11:41:20 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id C4C11200C4EA;
	Tue, 28 Jan 2025 11:41:20 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Tue, 28 Jan 2025 11:41:20 +0900
Received: from [10.212.246.222] (unknown [10.212.246.222])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id 665C8AB186;
	Tue, 28 Jan 2025 11:41:20 +0900 (JST)
Message-ID: <506cfa39-924e-479b-be2d-b032664958a9@socionext.com>
Date: Tue, 28 Jan 2025 11:41:20 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] net: stmmac: Fix usage of maximum queue number
 macros
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250127092450.2945611-1-hayashi.kunihiko@socionext.com>
 <Z5dXJ1EIUx8DAh6J@shell.armlinux.org.uk>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <Z5dXJ1EIUx8DAh6J@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Russell,

On 2025/01/27 18:51, Russell King (Oracle) wrote:
> On Mon, Jan 27, 2025 at 06:24:47PM +0900, Kunihiko Hayashi wrote:
>> The maximum number of Rx and Tx queues is defined by MTL_MAX_RX_QUEUES
> and
>> MTL_MAX_TX_QUEUES respectively.
>>
>> There are some places where Rx and Tx are used in reverse. Currently
> these
>> two values as the same and there is no impact, but need to fix the usage
>> to keep consistency.
> 
> I disagree that this should be targetting the net tree - I think it
> should be the net-next tree. Nothing is currently broken, this isn't
> fixing a regression, there is no urgent need to get it into mainline.
> It is merely a cleanup because both macros have the same value:
> 
> include/linux/stmmac.h:#define MTL_MAX_RX_QUEUES        8
> include/linux/stmmac.h:#define MTL_MAX_TX_QUEUES        8

I was a bit confused about how to choose net and net-next in this case,
but I understand what you are saying.

As I wrote:
>> Currently these two values as the same and there is no impact

this case isn't about fixing what is broken and also not required fixes
for the stable kernel, so I should post this series to net-next without
Fixes: tag.

> Please re-send for net-next after the merge window and net-next has
> re-opened.

I see. I'll take care and repost.

Thank you,

---
Best Regards
Kunihiko Hayashi

