Return-Path: <netdev+bounces-139244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 942F89B1205
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 23:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65351C212D8
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 21:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D37206502;
	Fri, 25 Oct 2024 21:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g5WaWa5c"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874CE213146
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729893214; cv=none; b=jtbnWFy0QK3siMVHEV1uwtYEr/tdff67O8vsz/ce1RakIPOgSn7QGKAWCv5g2jERg2r/91gb6RaPZa8iiqg1dk2yNzYrKM942fM3IzMZ3SG2sZbKx0XH3qKGGOJRhuMw2ugFCoYYy0rdN/BxtSv1H1xm/f5/vX2JHZVIqAKh8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729893214; c=relaxed/simple;
	bh=WjeWLfG1ODrAemKgrl8T+K3IxDdzzBumoPRSMLxIacA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wlfuj8zVqj9UcxasqLkhVS102kBlKa2dTFBKT1EjTxB1QkkLT6CQa+hFCW43XLmKIBFqoI5hqzk9dJmJubQJIEfB3G08v28gWmyPr9M+ypyUqXCvZ2BZ3WUNMpu5pGs2ETAaV47zTWn8ozPYGAQNA12EGzDjVN6YtE2I3WousQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g5WaWa5c; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e89385ae-7d77-4890-8c80-b5904ac394b4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729893209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wEh9dmgEmH7hn9nG0BYkMtsy8vfxjKowNparHuP4pBU=;
	b=g5WaWa5csX4Wtr0X8tnCmXwh956Cv6J4TCLPie1EvapHoEtkIgMJRT8uV7r/4II0hOZgW9
	Ex5YmVuzFDCrMnRHtazMHlJXWJX8ZKP9Y2+jOwjd3c9n9Me8VKC7FRTztS6jsWZ6t2+1jL
	aolnD719vG5r0E4LmuZi6TbvnXoGS28=
Date: Fri, 25 Oct 2024 22:53:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 1/2] bnxt_en: cache only 24 bits of hw counter
To: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Jakub Kicinski
 <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>
References: <20241025194753.3070604-1-vadfed@meta.com>
 <CACKFLikgQxsYQxkMZdXDusS=0=rZi8g9Fn6-nEnVw+g-hgzf4g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CACKFLikgQxsYQxkMZdXDusS=0=rZi8g9Fn6-nEnVw+g-hgzf4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 25/10/2024 22:31, Michael Chan wrote:
> On Fri, Oct 25, 2024 at 12:48 PM Vadim Fedorenko <vadfed@meta.com> wrote:
>>
>> This hardware can provide only 48 bits of cycle counter. We can leave
>> only 24 bits in the cache to extend RX timestamps from 32 bits to 48
>> bits. This make cache writes atomic even on 32 bit platforms and we can
>> simply use READ_ONCE()/WRITE_ONCE() pair and remove spinlock. The
>> configuration structure will be also reduced by 4 bytes.
> 
> ptp->old_time serves 2 purposes: to cache the upper 16 bits of the HW
> counter and for rollover check.  With this patch reducing
> ptp->old_time to 24 bits, we now use the upper 16 bits for the cache
> and the next 8 bits for the rollover check.  I think this will work.
> But since the field is now 32-bit, why not use the full 32 bits
> instead of 24 bits?  Thanks.

As you confirmed that the HW has 48 bits of cycle counter, we have to
cache 16 bits only. The other 8 bits are used for the rollover check. We 
can even use less bits for it. What is the use for another 8 bits? With
this patch the rollover will happen every ~16 ms, but will be caught
even till ~4s. If we will cache upper 32 bits, the rollover will happen
every 64us and we will have to update cache value more often. But at the
same time it will not bring any value, because the upper limit will 
still be ~4s. That's why I don't see any benefits of using all 32 bits.

