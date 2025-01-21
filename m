Return-Path: <netdev+bounces-159886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B208A17530
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 01:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317DF166FD5
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 00:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FC43FF1;
	Tue, 21 Jan 2025 00:17:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CD7EBE;
	Tue, 21 Jan 2025 00:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737418643; cv=none; b=BadLNfUoVTb0pRWrQritDZX8cD4yV+XcufIzFEJzEgvGMxmQgrzZtojmCIndyia2QNlsLuB42ao2Oul6ejatKKFo4IPodd6D8Bp2kzztQfH7TcK4lNms7SoJ2d5RNAvsU0NHWLSI6WoeOdmYPb8YPve3LWmDUUYsmp6xd5UrSHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737418643; c=relaxed/simple;
	bh=4CVvHd1qXUxigaAGEMAVq5s7GLCc+FCx3V6lleex/os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VY7RbqNceIuU/AFe928ZZmTHMNin5kr+VmvWZAjoF3h3ktcXGnRiNW1KcC7e9/cK3oXSVhzJrqU0sqsdJUVg6uFzrjUcuKbACwEau25GCGlPWBk8pbJPrVB03bDSimsHKQIknuEWKvv4CAolavRYTahTIFxlYlA9IuY3CJyplQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 21 Jan 2025 09:17:19 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 3E39B201548B;
	Tue, 21 Jan 2025 09:17:19 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Tue, 21 Jan 2025 09:17:19 +0900
Received: from [10.212.246.222] (unknown [10.212.246.222])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id B36CFAB184;
	Tue, 21 Jan 2025 09:17:18 +0900 (JST)
Message-ID: <c0fc9c74-1ea6-463a-85c1-be9152c41009@socionext.com>
Date: Tue, 21 Jan 2025 09:17:18 +0900
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
 <6aa0671d-beb2-429b-a34e-cb35651e1c12@socionext.com>
 <0c54a6ef-83ab-4739-bf2e-414c4d4621dc@lunn.ch>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <0c54a6ef-83ab-4739-bf2e-414c4d4621dc@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 2025/01/21 1:29, Andrew Lunn wrote:
> On Mon, Jan 20, 2025 at 02:20:23PM +0900, Kunihiko Hayashi wrote:
>> Hi Andrew,
>>
>> On 2025/01/17 5:16, Andrew Lunn wrote:
>>> On Thu, Jan 16, 2025 at 11:08:52AM +0900, Kunihiko Hayashi wrote:
>>>> Tx/Rx FIFO size is specified by the parameter "{tx,rx}-fifo-depth"
> from
>>>> the platform layer.
>>>>
>>>> However, these values are constrained by upper limits determined by
> the
>>>> capabilities of each hardware feature. There is a risk that the
> upper
>>>> bits will be truncated due to the calculation, so it's appropriate
> to
>>>> limit them to the upper limit values.
>>>
>>> Are these values hard coded in the platform layer? Or can they come
>>> from userspace?
>>
>> My explanation is insufficient and misleading.
>> "From the platform layer" means the common layer of stmmac described in
>> "stmmac_platform.c".
>>
>>> If they are hard coded, we should also fix them. So maybe add a
>>> netdev_warn(), and encourage the platform maintainers to fix their
>>> platform. If they are coming from userspace, we should consider
>>> failing the ethtool call with an -EINVAL, and maybe an extack with the
>>> valid range?
>>
>> These values are derived from the devicetree and stored in the stmmac
>> private structure. They are hardware-specific values, so I think this
>> fix is sufficient.
> 
> But if they are coming from device tree, the device tree developer has
> made an error, which has been silently ignored. Do we want to leave
> the device tree broken? Or should we encourage developers to fix them?
> Printing a warning would facilitate that.

I think that developers should fix the devicetree, so I'll add a warning
message if the specified value exceeds the hardware capability.

Thank you,

---
Best Regards
Kunihiko Hayashi

