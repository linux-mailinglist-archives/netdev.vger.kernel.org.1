Return-Path: <netdev+bounces-158837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904CCA1373D
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 11:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83E7164294
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBDA1991CF;
	Thu, 16 Jan 2025 10:02:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D85D1B4F0C;
	Thu, 16 Jan 2025 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021730; cv=none; b=LH5RoShHSLju24MRsRt0EswDzmtuVXdrbxDUjObJomPXu9OIgbs98vywosI9TMWhExF8TBPRrmg/Z+TQYSl061k1dEn0VPSlk0U7q9pyfmDMT1HfDBuwgehrGEhQsXNlw1gBHa4azwhFcj2sktujgeVHnoOpDNqxpExJImA+CyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021730; c=relaxed/simple;
	bh=ypwLAxWkuMKVh4yjPNZcAh7ScXUTDEACewpSDTlzEuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+TnGaWQjPNasL1GDEmMiyLtLoCMBAST7+ocLUck/M5WD2Zi6p3ixU48ICk0vigsofirPK2FhZMJ1B00tMxGhtAP8OnAn7O1V+txTF1q/fVpKcDOBc5hUmWLPsij22cZ+zNCH6sjRcHWVOoErOcz76+BUmT+jJ+YjJTkKEROcfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 16 Jan 2025 19:02:06 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id E0FA42006E93;
	Thu, 16 Jan 2025 19:02:05 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Thu, 16 Jan 2025 19:02:05 +0900
Received: from [10.212.247.91] (unknown [10.212.247.91])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id CBDDE1A8;
	Thu, 16 Jan 2025 19:02:04 +0900 (JST)
Message-ID: <da65b8e2-bbc9-4d9b-9d78-4a32775c465b@socionext.com>
Date: Thu, 16 Jan 2025 19:02:03 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: stmmac: Limit FIFO size by hardware feature
 value
To: Furong Xu <0x1207@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250116020853.2835521-1-hayashi.kunihiko@socionext.com>
 <20250116105011.00003206@gmail.com>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20250116105011.00003206@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Furong,

Thank you for your comment.

On 2025/01/16 12:04, Furong Xu wrote:
> On Thu, 16 Jan 2025 11:08:52 +0900, Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com> wrote:
> 
>> Tx/Rx FIFO size is specified by the parameter "{tx,rx}-fifo-depth" from
>> the platform layer.
>>
>> However, these values are constrained by upper limits determined by the
>> capabilities of each hardware feature. There is a risk that the upper
>> bits will be truncated due to the calculation, so it's appropriate to
>> limit them to the upper limit values.
>>
> 
> Patch is fine, but the Fixes: tag is required here.

I see. I'll find original commit and send the patch with Fixes:
tag next.

> And if you like to group this patch and the another patch into one series,
> it is better to add a cover letter.

Yes, I omitted to add a cover letter.
However, this patch has no dependency on the other one and
needs some consideration, so I'll send it separately.

Thank you,

---
Best Regards
Kunihiko Hayashi

