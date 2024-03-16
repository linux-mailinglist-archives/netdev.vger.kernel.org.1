Return-Path: <netdev+bounces-80218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA77D87DA06
	for <lists+netdev@lfdr.de>; Sat, 16 Mar 2024 12:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCEB1F21814
	for <lists+netdev@lfdr.de>; Sat, 16 Mar 2024 11:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4983F171AD;
	Sat, 16 Mar 2024 11:54:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.rmail.be (mail.rmail.be [85.234.218.189])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA5412B93
	for <netdev@vger.kernel.org>; Sat, 16 Mar 2024 11:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.234.218.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710590047; cv=none; b=YAq8qxwIjZEl5NponAf1cnmZOf9N5yYPYtrm7JWdiWl+TPqSZE/OE5mPr8Xr8Y7j7lBdq08YOvnBbw2V3c4wvFdErovZKgNbWUvnRBLSHle/k4MAoqs6GDgY3F/sfjpAK3/aoK13slHX96BoXu2SCVfcnuNToafBg5HiC2Qv7wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710590047; c=relaxed/simple;
	bh=iNBbl6JhZYu60cPGVvFx2L204OQhi/CybZ4uuPWOD74=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=M3n+mQKwQp8e83Rce//XykICxyGj801ic9VWHH60GI8irxnvoor7phrPEOdQCB1OLz8AsBUoV7oVV152ScSLvNkFZMgZXMQyqQlS4V1l4Ar/LA/ut8zuc0bjyEVigtZcVaYpB51t/palR8ONsR8jnIBToTx9GJHjXxhjRvHMg/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rmail.be; spf=pass smtp.mailfrom=rmail.be; arc=none smtp.client-ip=85.234.218.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rmail.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rmail.be
Received: from mail.rmail.be (domotica.rmail.be [10.238.9.4])
	by mail.rmail.be (Postfix) with ESMTP id E628B4DED4;
	Sat, 16 Mar 2024 12:53:52 +0100 (CET)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 16 Mar 2024 12:53:52 +0100
From: Maarten <maarten@rmail.be>
To: Doug Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, netdev@vger.kernel.org, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH] net: bcmgenet: Reset RBUF on first open
In-Reply-To: <f189f3c9-0ea7-4863-aba7-1c7d0fe11ee2@gmail.com>
References: <20240224000025.2078580-1-maarten@rmail.be>
 <bc73b1e2-d99d-4ac2-9ae0-a55a8b271747@broadcom.com>
 <f189f3c9-0ea7-4863-aba7-1c7d0fe11ee2@gmail.com>
Message-ID: <16eca789cf7b513b74de03832bd4cbf3@rmail.be>
X-Sender: maarten@rmail.be
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Doug Berger schreef op 2024-02-27 00:13:
> On 2/26/2024 9:34 AM, Florian Fainelli wrote:
>> On 2/23/24 15:53, Maarten Vanraes wrote:
>>> From: Phil Elwell <phil@raspberrypi.com>
>>> 
>>> If the RBUF logic is not reset when the kernel starts then there
>>> may be some data left over from any network boot loader. If the
>>> 64-byte packet headers are enabled then this can be fatal.
>>> 
>>> Extend bcmgenet_dma_disable to do perform the reset, but not when
>>> called from bcmgenet_resume in order to preserve a wake packet.
>>> 
>>> N.B. This different handling of resume is just based on a hunch -
>>> why else wouldn't one reset the RBUF as well as the TBUF? If this
>>> isn't the case then it's easy to change the patch to make the RBUF
>>> reset unconditional.
>> 
>> The real question is why is not the boot loader putting the GENET core 
>> into a quasi power-on-reset state, since this is what Linux expects, 
>> and also it seems the most conservative and prudent approach. Assuming 
>> the RDMA and Unimac RX are disabled, otherwise we would happily 
>> continuing to accept packets in DRAM, then the question is why is not 
>> the RBUF flushed too, or is it flushed, but this is insufficient, if 
>> so, have we determined why?
>> 
>>> 
>>> See: https://github.com/raspberrypi/linux/issues/3850
>>> 
>>> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
>>> Signed-off-by: Maarten Vanraes <maarten@rmail.be>
>>> ---
>>>   drivers/net/ethernet/broadcom/genet/bcmgenet.c | 16 
>>> ++++++++++++----
>>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>> 
>>> This patch fixes a problem on RPI 4B where in ~2/3 cases (if you're 
>>> using
>>> nfsroot), you fail to boot; or at least the boot takes longer than
>>> 30 minutes.
>> 
>> This makes me wonder whether this also fixes the issues that Maxime 
>> reported a long time ago, which I can reproduce too, but have not been 
>> able to track down the source of:
>> 
>> https://lore.kernel.org/linux-kernel/20210706081651.diwks5meyaighx3e@gilmour/
>> 
>>> 
>>> Doing a simple ping revealed that when the ping starts working again
>>> (during the boot process), you have ping timings of ~1000ms, 2000ms 
>>> or
>>> even 3000ms; while in normal cases it would be around 0.2ms.
>> 
>> I would prefer that we find a way to better qualify whether a RBUF 
>> reset is needed or not, but I suppose there is not any other way, 
>> since there is an "RBUF enabled" bit that we can key off.
>> 
>> Doug, what do you think?
> I agree that the Linux driver expects the GENET core to be in a "quasi
> power-on-reset state" and it seems likely that in both Maxime's case
> and the one identified here that is not the case. It would appear that
> the Raspberry Pi bootloader and/or "firmware" are likely not disabling
> the GENET receiver after loading the kernel image and before invoking
> the kernel. They may be disabling the DMA, but that is insufficient
> since any received data would likely overflow the RBUF leaving it in a
> "bad" state which this patch apparently improves.
> 
> So it seems likely these issues are caused by improper
> bootloader/firmware behavior.
> 
> That said, I suppose it would be nice if the driver were more robust.
> However, we both know how finicky the receive path of the GENET core
> can be about its initialization. Therefore, I am unwilling to "bless"
> this change for upstream without more due diligence on our side.

Hey, did you guys have any chance to check this stuff out? any thoughts 
on it?

Regards,

Maarten

