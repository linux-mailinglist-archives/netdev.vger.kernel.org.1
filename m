Return-Path: <netdev+bounces-75065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7D18680B1
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 20:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6161D1C27BB1
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 19:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80772130E2A;
	Mon, 26 Feb 2024 19:15:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.rmail.be (mail.rmail.be [85.234.218.189])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CC612F583
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.234.218.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974907; cv=none; b=m/Drg25a9a+Q2azUmx9kx+LQ/Qg9HfVZloLehjjEncccPb+s3R843z9lDhygn+cTjxaZ7mar3qEJMsk76xZE/M/9+WTghlE+A/CnWB9/Gx88VpScFTimLP9Xejz8aRI4lFKXjW4zppMLEQrmkFtycN4JqhZ6WMcbA5Q9SCVUvHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974907; c=relaxed/simple;
	bh=rVJzeL0Cnk7tB5HsXAqTDFQ2XSB2X6f0OPgXmd9uCb4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cxeqG8+3hVWjgTYtn5TJuh5bkSRfWChQxRwtMaN+7DLSKypMcnBTicGwK4aHtHvFw7iRKz6a3Q6yDjq4FH4C6c9fJfCUpUQRsnu2dTIbRwOi9j504iLMsEacmMdfS34OObEakRVke3wf0F4Au7Jz/ItEziDRkq5S9QkAQnQ/ApY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rmail.be; spf=pass smtp.mailfrom=rmail.be; arc=none smtp.client-ip=85.234.218.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rmail.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rmail.be
Received: from mail.rmail.be (domotica.rmail.be [10.238.9.4])
	by mail.rmail.be (Postfix) with ESMTP id 83D4D4B0B4;
	Mon, 26 Feb 2024 20:14:54 +0100 (CET)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 26 Feb 2024 20:14:54 +0100
From: Maarten <maarten@rmail.be>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Doug Berger <opendmb@gmail.com>, netdev@vger.kernel.org, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Phil
 Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH] net: bcmgenet: Reset RBUF on first open
In-Reply-To: <bc73b1e2-d99d-4ac2-9ae0-a55a8b271747@broadcom.com>
References: <20240224000025.2078580-1-maarten@rmail.be>
 <bc73b1e2-d99d-4ac2-9ae0-a55a8b271747@broadcom.com>
Message-ID: <47ba4ef5a42fe7412d7e3432a0995464@rmail.be>
X-Sender: maarten@rmail.be
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Florian Fainelli schreef op 2024-02-26 18:34:
> On 2/23/24 15:53, Maarten Vanraes wrote:
>> From: Phil Elwell <phil@raspberrypi.com>
>> 
>> If the RBUF logic is not reset when the kernel starts then there
>> may be some data left over from any network boot loader. If the
>> 64-byte packet headers are enabled then this can be fatal.
>> 
>> Extend bcmgenet_dma_disable to do perform the reset, but not when
>> called from bcmgenet_resume in order to preserve a wake packet.
>> 
>> N.B. This different handling of resume is just based on a hunch -
>> why else wouldn't one reset the RBUF as well as the TBUF? If this
>> isn't the case then it's easy to change the patch to make the RBUF
>> reset unconditional.
> 
> The real question is why is not the boot loader putting the GENET core
> into a quasi power-on-reset state, since this is what Linux expects,
> and also it seems the most conservative and prudent approach. Assuming
> the RDMA and Unimac RX are disabled, otherwise we would happily
> continuing to accept packets in DRAM, then the question is why is not
> the RBUF flushed too, or is it flushed, but this is insufficient, if
> so, have we determined why?

I can only say that when I was testing upstream kernels (6.7, 6.8) I had 
a lot of issue rebooting the RPI4B, and after some searched, I found 
this patch in the raspberrypi kernel (from 2020) and since I've used it, 
I do not have this issue anymore for at least 10 boots. Not sure if I 
should've added a Tested-By with myself?

>> 
>> See: https://github.com/raspberrypi/linux/issues/3850
>> 
>> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
>> Signed-off-by: Maarten Vanraes <maarten@rmail.be>
>> ---
>>   drivers/net/ethernet/broadcom/genet/bcmgenet.c | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>> 
>> This patch fixes a problem on RPI 4B where in ~2/3 cases (if you're 
>> using
>> nfsroot), you fail to boot; or at least the boot takes longer than
>> 30 minutes.
> 
> This makes me wonder whether this also fixes the issues that Maxime
> reported a long time ago, which I can reproduce too, but have not been
> able to track down the source of:
> 
> https://lore.kernel.org/linux-kernel/20210706081651.diwks5meyaighx3e@gilmour/
> 
>> 
>> Doing a simple ping revealed that when the ping starts working again
>> (during the boot process), you have ping timings of ~1000ms, 2000ms or
>> even 3000ms; while in normal cases it would be around 0.2ms.
> 
> I would prefer that we find a way to better qualify whether a RBUF
> reset is needed or not, but I suppose there is not any other way,
> since there is an "RBUF enabled" bit that we can key off.
> 
> Doug, what do you think?

