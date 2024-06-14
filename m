Return-Path: <netdev+bounces-103650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B01908EB7
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 17:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6767B2D6B1
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 15:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944CA15885F;
	Fri, 14 Jun 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="x+VgFU4q"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25AD25601
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378101; cv=none; b=uiQYJKnqR4LMfs95usOmJWQCBZqxzaKVgiAgrplCYnAAvLBpsZ+DQPdkBAXmMn/1CLV1VUpd/E4qGhnBQ+86O1kiOzp9iT/yjiMhHoqPERpvQEJKEqH4C35MTe/OSjS6o0U0mpwI/Aw8UgaJNovUuTq5aHRnl9mOjOdG54zfhCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378101; c=relaxed/simple;
	bh=ada4TsjGd10tj143Xr2OyoQwcj3AHHd9q4dHYwRu33s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M0eoOr69KrYApmVLx7894hqDl9ko5SRtQj85hPnJ0ueBIEUsjValrk46PdHXLSNbiZJRInoDO/mEo00c5rKKgZKlaiRn37y8Vr3CfsiYovjoNgPKgSHoFw90xn+BDnnX18wVFkhAPwyim108u3khAwfv0RTlEPm+VhymEUFvAmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=x+VgFU4q; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E045E9C5B5E;
	Fri, 14 Jun 2024 11:14:51 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id AmDFZljwd0Wv; Fri, 14 Jun 2024 11:14:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CD60C9C5B61;
	Fri, 14 Jun 2024 11:14:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com CD60C9C5B61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1718378090; bh=cQ6xA7R/ncKxvCXmbLQEuyMXa8ra+KTUdNxF7MZTw+Y=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=x+VgFU4qlQ3+cq8BOmEw4wZTG62SdCB2dH3Tt0pBrtyU6LVbwrF3kqCZ87Kl81mqB
	 +JFfqdUardBtM+rxh7yxbJDpMppqGeAlLIFsLKt68Ug4tIXhWsDJZeVwfAq42esU+u
	 FQdrR6ylVV8FbWSAYJ7wAlXv7N6XUIAZfYPhSpdUELVtz+30feg49BhRbU9Qq2Al11
	 qsc2vshkgS2v0XauMcPl/RyYHLW77xTMLf8lgOfAe9BINZguUOvjlJPSe+YahZj+Ki
	 P37ZCe5o9LRQGJTdaG0y6VNPqJ3Oq83v0qmbjl8/r9sfAiuuhWY6GuJYd6qZAv4wvu
	 +IEmAnN+AatVA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 7ye69gkd8faC; Fri, 14 Jun 2024 11:14:50 -0400 (EDT)
Received: from [192.168.216.123] (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id AE8789C5B5E;
	Fri, 14 Jun 2024 11:14:49 -0400 (EDT)
Message-ID: <3d5e9b4d-d87c-4376-b698-4cccdbfb81ff@savoirfairelinux.com>
Date: Fri, 14 Jun 2024 17:14:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6 3/3] net: dsa: microchip: monitor potential faults
 in half-duplex mode
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, horms@kernel.org,
 Tristram.Ha@microchip.com, Arun.Ramadoss@microchip.com
References: <20240614094642.122464-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240614094642.122464-4-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <28b58ff0-599f-4157-9ccf-730c53217cf7@lunn.ch>
Content-Language: en-US
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <28b58ff0-599f-4157-9ccf-730c53217cf7@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/06/2024 15:37, Andrew Lunn wrote:
> On Fri, Jun 14, 2024 at 09:46:42AM +0000, Enguerrand de Ribaucourt wrote:
>> The errata DS80000754 recommends monitoring potential faults in
>> half-duplex mode for the KSZ9477 family.
>>
>> half-duplex is not very common so I just added a critical message
>> when the fault conditions are detected. The switch can be expected
>> to be unable to communicate anymore in these states and a software
>> reset of the switch would be required which I did not implement.
> 
> If i'm reading this code correctly, every 30 seconds it will test to
> see if the link is half duplex, and is so, log onetime this could lead
> to problems. Also, every 30 seconds, if the statistics counts indicate
> there has been a late collision, it will log a rate limited
> message. Given the 30 second poll interval, rate limiting is probably
> pointless, and every one will get logged. The last print, i have no
> idea what resource you are talking about. Will it also likely print
> once every 30 seconds?

The MIB statistics are read every 5 seconds. It is defined in:
	dev->mib_read_interval = msecs_to_jiffies(5000);
So indeed, _ratelimit having a 5 second back-off, it is redundant.

The second print is about two resources:
  - Packet Memory Available Block Count (PMAVBC)
  - TX Queue Blocks Used Count (TXQBU/QM_TX_CNT)
According to the errata, they are leaky in half duplex mode. Once 
depleted, packets can't be exchanged.

Like the late collision counter, these are not going to go back to 
normal values without a reset. So yes, the critical message will keeping 
being displayed. Do you think a dev_crit_once would be more appropriate?

> 
> Is the idea here, we want to notice when this is happening, and get an
> idea if it is worth implementing the software reset? Do we want to add
> a "Please report if you see this" to the commit message or the log
> messages themselves?

I'm fine with just monitoring and printing in my use case. My devices 
are unlikely to encounter half-duplex peers and the app can recover. I 
simply need to guarantee I can detect this condition. For my use case, 
implementing the software reset wasn't worth the effort. One of the main 
obstacles is that the VLAN table would need to be reconfigured, so it 
would require remembering it from the driver. Also transmission would 
inevitably be stopped for a few seconds.

For generic users, I think the warning is necessary since it indicates 
the switch will stop functioning after prolonged use in half-duplex. We 
could elaborate the warning message to point to the datasheet. That way 
users could understand why their configuration is affected, what are the 
risks, and possible avoidance or recovery mechanisms. If this errata is 
critical to someone who can't avoid it, then we could implement the 
software reset.

Proposal for a v7:
  - dev_crit_ratelimit -> dev_crit_once
  - dev_warn_once -> point to datasheet + add "report if needed"

What is your opinion on this?

Thanks,

> 
> 	Andrew

-- 
Savoir-faire Linux
Enguerrand de Ribaucourt

