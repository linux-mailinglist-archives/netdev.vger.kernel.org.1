Return-Path: <netdev+bounces-159685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD410A16654
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 06:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDED03AA4B2
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 05:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A6B76026;
	Mon, 20 Jan 2025 05:20:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7DF10E9;
	Mon, 20 Jan 2025 05:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737350434; cv=none; b=JqhiFpsVH9pl7an61PDknRsR92YdJ/UCC4FI5RSEswV1s1zqEGsYymsC7liJUH54JLQx//1ZgAcQ+YEo6egGPbpqXr8/22FRFxRwO8/hwN6fErjvGqfNEmf2Sn2ELW8wuLkOwLBCRIxHuTPscou/3Xkehqk/QbdB/IU+7hEtzlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737350434; c=relaxed/simple;
	bh=iHx2e3ApLxuDJDf+lCHDkBNMUO2RXdoz2ZUqy+x5ExQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNUMEfN1BJsobekBsoh6r4APfXLVauC5JZvuQ2EXrDd8FLeGWlDy9K2WWBZb8aaBcK3zoF8jUDlNaQinFuFb0Va+l9WXJjJKhvRTn+ERkQ1ew73+7bNb5Vr7fxtJrDGcNsRMBWqD8a3S762K/bIATwvZMXc9/I8vbX3MpDopcF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 20 Jan 2025 14:20:24 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 60E8D201A2CD;
	Mon, 20 Jan 2025 14:20:24 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Mon, 20 Jan 2025 14:20:24 +0900
Received: from [10.212.247.50] (unknown [10.212.247.50])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id ECA05AB184;
	Mon, 20 Jan 2025 14:20:23 +0900 (JST)
Message-ID: <6aa0671d-beb2-429b-a34e-cb35651e1c12@socionext.com>
Date: Mon, 20 Jan 2025 14:20:23 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: stmmac: Limit FIFO size by hardware feature
 value
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250116020853.2835521-1-hayashi.kunihiko@socionext.com>
 <636bad71-8da8-4fda-a433-1586d93683a5@lunn.ch>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <636bad71-8da8-4fda-a433-1586d93683a5@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 2025/01/17 5:16, Andrew Lunn wrote:
> On Thu, Jan 16, 2025 at 11:08:52AM +0900, Kunihiko Hayashi wrote:
>> Tx/Rx FIFO size is specified by the parameter "{tx,rx}-fifo-depth" from
>> the platform layer.
>>
>> However, these values are constrained by upper limits determined by the
>> capabilities of each hardware feature. There is a risk that the upper
>> bits will be truncated due to the calculation, so it's appropriate to
>> limit them to the upper limit values.
> 
> Are these values hard coded in the platform layer? Or can they come
> from userspace?

My explanation is insufficient and misleading.
"From the platform layer" means the common layer of stmmac described in
"stmmac_platform.c".

> If they are hard coded, we should also fix them. So maybe add a
> netdev_warn(), and encourage the platform maintainers to fix their
> platform. If they are coming from userspace, we should consider
> failing the ethtool call with an -EINVAL, and maybe an extack with the
> valid range?

These values are derived from the devicetree and stored in the stmmac
private structure. They are hardware-specific values, so I think this
fix is sufficient.

Thank you,

---
Best Regards
Kunihiko Hayashi

