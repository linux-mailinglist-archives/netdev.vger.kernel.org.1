Return-Path: <netdev+bounces-259867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCnhCefRmmnTkAMAu9opvQ
	(envelope-from <netdev+bounces-259867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 10:52:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCBA16ECC2
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 10:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73ABA300CCBA
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 09:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD49201278;
	Sun, 22 Feb 2026 09:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbkMeWqL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0581A5B84
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 09:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771753953; cv=none; b=UOwWz0lU0hQuI1K3jTwq65MAvOaazPuknOsn2H7goAGIjTvhmK6lgwOCe5rPAuO2EevLPdmFb0aTisbE4SN9AAvSDQ8FJwBmgCrl8QwVsiwtGY5q5jlYjVrS7yIRs2aPUB85nMl0UQeUHhM2xYyGBBzhmk6hIuLqGCrI6cqexcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771753953; c=relaxed/simple;
	bh=ju8rgkEZ7gc4XGBM4l4hAOgRRcp9M4mxJZIPFycKSDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFfSH1kkFDvzqCO0wQytfIw8+r7ybTjpmaaxxGsyXJAJqciePYjFFQFFQCidYbMDC3os6Z2p8c6KmsPtiZTTzFFEe5cVi2imowDep5ncKeMD8gRkkoEMW3jZI5/bpto8EBy0VMysnZt44SvsYW4FQWJ+spWCAkUxhq8VR+MZaTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbkMeWqL; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-436356740e6so3666393f8f.2
        for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 01:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771753951; x=1772358751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0maBnJmKEymwKdDc0DBPC6NLeLVs1LHgfi7QbouBhO8=;
        b=jbkMeWqLN+rQF3DdBBdqDC36GTVQ0SMRHu/+kH2t3fvfEmH2Rqd2hObFjJyGQT8OpF
         1WF36ZSO6wUCv+6pl/hGTTCh+DHyrFn5dt8R140XcTD0e53kMru7Dp9zdSycL0bTfGMy
         B1MErzcJ+YVQRXcel4IwXC2eyODjcZxWDak+FvEbwHwWf01+hYfqS6eZE/vZVZzFw5pB
         sZZainLb62Rgu29fKpKtb8kegpTWYo0138UyzmDX1g/oO6m7JTwmbDiXSpLsFnXbkAwa
         UhBsCe5OtCribVsUkmQ0QgVWrqOcBh739IW6nN3x5MjeiIlPed8ouTxY0IWZ0l/8v3/V
         JokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771753951; x=1772358751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0maBnJmKEymwKdDc0DBPC6NLeLVs1LHgfi7QbouBhO8=;
        b=q+UC9qPVQl+D1oNpZMtwYi5rqASxECFS9zubCeUlZAVxv9hlTgEnziqA6ODgHvFPVw
         3R2ZewygAJiSJXFOqtQCjrPXMxMOmF5L8Tm+4gbzvlI2uSV05tDot3oCk6sCTRMCXVJq
         O8DeSFX/8opHvdo2umFHmRMGcTFU9xjkkYx511+wAtsRPYmlrjO4XUKjVf1HBSmGHvP5
         225jFNV3cFAPTa2UFGajoKaMU575lCUhUnvMMfijZqzjDxaCMzgtIVCFiO5pJxtHX+TR
         zqtZ+X71TvmEQkPI+b9n5Yj7f2bLizZo7AYMNveaWG/Z8UGM4qjxwQO/LyqisQ44Fgu0
         oP2w==
X-Forwarded-Encrypted: i=1; AJvYcCVPpW9WBz/cZl/gsMGhk2B8ZkirQ+REWhctvybCJgSGk1dMIxdVGA+WOjFVS2P/KcFvipnlXA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYR4KOIz241k96GFFUIjTG83XYEo7q1rPuILXuA2Em2PFSTfZv
	ilgOTqw1sH3Q5HFxCE7Teuy13c4q/Qoq82fWu3BJX2KYVzeoxzkidhxH
X-Gm-Gg: AZuq6aJcmEy8DIErNnL7U0TxEZHUeVsYR4mnizZk7GBbVQ8tkSXNiKQynHG61aCAtTo
	MihxylIbPrQ4Ybp8IKrxpjSLMmOqpALVl2o+yvxRLCyzViXh5s4A0jOfvYOJIIJWC/lGcTTEkjP
	0OeY9RR3pyVVdg0cwVSul1q4fBwy/JFVyop9WVtmofHCJsa5tBrYrPiN8EJZziJn5tt75lLIoT4
	Z3UV25J9HJjMQZlTeDJcQiRInpHv50Tp1FmuMfpP3xHWyH/ow78767x5CdWRseR8pBmXStUwA+X
	Z7k4j7/BtljtpE143DSvlhtFwicvmc34iKeGt768NzeHH435SdUZgdVtrkDuaH3uQAPAuS1lzjm
	jrlMzn+G3FQfKALyPAylTWOI7Y5G5Fv5uieQ4pauUdy3Tgk21CiSYydpNnQyvhtnvT7m74XQQd2
	SPoJqTKcNLSnpk0xB2sxuGJbABfLLN0yDEfPboedTNwIVAoSvbCB2MABqoOzQQnf+Ra8/KEW02r
	zds51fS//MFXnA=
X-Received: by 2002:a05:6000:184d:b0:436:3563:49a2 with SMTP id ffacd0b85a97d-4396f17a6b8mr9232277f8f.37.1771753950660;
        Sun, 22 Feb 2026 01:52:30 -0800 (PST)
Received: from [10.0.0.98] (snat-2.cgn.sat-an.net. [176.222.226.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c96csm12160766f8f.30.2026.02.22.01.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 01:52:30 -0800 (PST)
Message-ID: <6d248bec-cb87-4238-9ccc-e901926e3226@gmail.com>
Date: Sun, 22 Feb 2026 10:52:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: phy: motorcomm: yt8821: disable MDIO
 broadcast address 0
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Daniel Golle <daniel@makrotopia.org>,
 Qingfang Deng <dqfext@gmail.com>, SkyLake Huang
 <SkyLake.Huang@mediatek.com>, Frank <Frank.Sae@motor-comm.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sai Krishna <saikrishnag@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <d3bb9c36-5a0e-4339-901d-2dd21bdba395@gmail.com>
 <0308e736-c3e7-45d2-86f7-e729af9cb487@gmail.com>
 <3e64d8d1-87c1-45e0-9556-0ca844a90f73@lunn.ch>
 <740e8351-d8a5-4f4c-91e4-c278e4b7d248@gmail.com>
 <aZq-SbHC0eU9OenG@shell.armlinux.org.uk>
Content-Language: en-US
From: =?UTF-8?Q?Jakub_Van=C4=9Bk?= <linuxtardis@gmail.com>
In-Reply-To: <aZq-SbHC0eU9OenG@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,makrotopia.org,gmail.com,mediatek.com,motor-comm.com,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259867-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxtardis@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8FCBA16ECC2
X-Rspamd-Action: no action

On 2/22/26 09:28, Russell King (Oracle) wrote:
> On Sun, Feb 22, 2026 at 05:22:55AM +0100, Jakub Vaněk wrote:
>> I had hoped this would not happen on the Cudy router. The MediaTek
>> Ethernet subsystem driver uses of_mdiobus_register(), so PHY address 0
>> should not be probed unless it is explicitly described in the device
>> tree. That said, I agree that with mdiobus_register() this would still
>> be an issue.
>>
>> I was also hoping that moving the internal PHY would provide more
>> flexibility in the device tree description of the YT8821. If the
>> workaround were implemented in U-Boot by writing YT8821 MDIO registers
>> at boot time, Linux would not be able to assert the YT8821 reset pin
>> without losing that workaround.
> 
> Why would you want to assert the reset pin?
> 

I don't currently have a solid reason to assert the reset pin.
The two reasons I had in mind were mostly precautionary:

- I saw that the Qualcomm Atheros AR803x PHY driver relies on the
  hardware reset pin to work around a hardware errata. While the
  YT8821 appears to work just fine without asserting the reset,
  I wanted to keep the option open in case a similar need arises
  in the future.

- In the OpenWrt device trees for Cudy routers, PHY reset GPIOs
  are/were* often described on the PHY node itself. I observed that
  when the reset GPIO is associated with the PHY, the PHY core asserts
  the reset pin in response to "ip link set dev eth0 down". Moving the
  reset pin definition elsewhere changed that behavior. So far it
  appeared to be fine, but I wasn't yet entirely sure that I didn't
  subtly break something.

Jakub

* I recently moved some of the reset GPIO definitions from the PHY
  level to the MDIO bus level to make the automatic PHY type detection
  work. Doing this in U-Boot would work equally well.


