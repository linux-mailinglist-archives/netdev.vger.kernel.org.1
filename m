Return-Path: <netdev+bounces-262426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFcUEkV2pGlthwUAu9opvQ
	(envelope-from <netdev+bounces-262426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 18:24:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D22CF1D0D1F
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 18:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F94D300A316
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 17:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1F62C0F6F;
	Sun,  1 Mar 2026 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yk5fWI+Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2071F1534
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772385859; cv=none; b=MF2gKVRHxmOBab3X+jczvEXdS+Bmj0PP2KI8uXH8cQRl00db+LFmllbOKVAi93Y6AbYAhXcGpRM4PDFAivt2KCqlFzk73b+DlIdxgdvAMYV9hrHEceOjUw54spWJLSEBYHfWvcs7QoAHGVGC/394Glotj1xCyki94px1Jf9f088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772385859; c=relaxed/simple;
	bh=OpQNspzThVXFBYLAhmiU3FFkWbIeijCa27H9TPxDfpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sjnJbwnPkKpv1yglEF+DV5cY9j7R31xCVtwFHg0xFH/Td8LLQhr0Ido2qejw3sqkvEsj1GqE8ffiwlA+HCa+ua8uKplNNB27YtaSCej9R4g4QgSRTsbeV3CCQrhEp85C0bFVOaQ5BuxAD9oU/snBqjK3MVTr90/38ItyJiBVLJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yk5fWI+Y; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso31073195e9.3
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 09:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772385856; x=1772990656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eMEfvLnIcHCLj6kvqTL40Dsk5YrJgXj7C+hdkrACjMw=;
        b=Yk5fWI+YKm2Ydr6ArQwUW/+uFZPZ4WwwapJqbqnPnjBFm45YO2RVKW5GJYdwVmQbR4
         YHst3tBxNWNUybn7+Qy79pTuoC0ZCMKhfnHoAnJJI9cl+ly7NFPOEpkR4AKuPCGgGuFT
         W/2ya31wRWAqGqTCt9jPo1ShDfYHu3GahUMgRGGE3krkhT2Z/sTo66wk2ZYhkQIobTBo
         AC34E9pXmdoIyfIoGUy+gx21T9UOWMG9VxE7B0dyRD92wW6MWseORByIpLkH+azvZ8cl
         ApUc84LgSqNfTDyT8ECdc6udvl2DyVvEaZXk9AOl4oBImBscE60Vg1MfLZVhdsxZZp03
         1pBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772385856; x=1772990656;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMEfvLnIcHCLj6kvqTL40Dsk5YrJgXj7C+hdkrACjMw=;
        b=Vj6foRsRyWFtEEJVwwOolxF04W6VJEJROmxfrjN5Lifrk5W9DP3pK0YSBZdYJIgCqA
         qjvuBH0qFNFjm/fibgENqbkP1xe0/iaJTIeRrQ68w66KLuimjWrrDYsKneJz+y34X/CW
         LFUCh+FJsWWqznx6wr35PIdXwRlgVigmRC/4eM+SXbbq3QW9yGGPyCg4XlFmCnml44oe
         GwiQxdNufBZBvhn7KSrD5Bgj1Jqjg3bVz+EQejBvdFp/ouu6KkR8tm8prv+zgoa+H3zk
         RAj/p/B0jKgwZeKgvkdA4W+ALwndpS6/LmORGESEbLG2IqWnoCFVAzTm76I3AQhh9W55
         y2PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUfpeUY9OcDTd2nighxL/VTEBDC80XBzh25ozDVNseOW3L95Ufh3XV3QqqG43J5Kna5eLst+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm2O0AIU5yXG8lwoeFm6fPpvYN6yEfiDonVUEKj1trEL7HIy5M
	vv7FXTi11q63n2ZM5Gm9noTQHME0RlrSrjH3UnrMShCbe+4JZJTYxiSi
X-Gm-Gg: ATEYQzzXqf1BlfhkHDuV1R5sLQWUMGc4WsGmxNiX6BuakKeOCiPHyo4pt/T9KCs8dEy
	TPkL+/e+7H0MUhU+7Gx+so6MUUB99D5/SrfvQPHMBtASG0fd1ph6dssQc+iRcrlXHIYJKD9YU2x
	JM1BNRtKzme1r6RJgCYFQh3pIkPg16e30lIb6NT+spU3Cjjj//mzLq7bcU8UHwKrnC9xO0TMj6i
	zeLSpDSrljiwza2VpIsGmbI3AAoLBECb0FGXLM68RWxCHoLfoVC9lofvy+mNGrReZP3tvWzIpkr
	8imUCQPKVEakMrcOm5g5BvEYd70rpF4BEgZrZzLsHhwo2FrGmeVphWLJBO+232/q78BpO8ZUaml
	ivrqVrUXHZMnBDKMF+u97dIu5XzJK/4df5HUQ4FXVnUR8Y/NEhCf1zkY8INhZOIR3LzUHAt1jY2
	R8pxyp83cC7949CfP/ZAdAQ2OjJfLfJDUk6NLbBJ/pQs3mAx+d4+3J77e/SnCkIpdQMvQFzWXaM
	E6w
X-Received: by 2002:a05:600c:46c4:b0:483:7783:5373 with SMTP id 5b1f17b1804b1-483c9c0f20dmr164527665e9.23.1772385855922;
        Sun, 01 Mar 2026 09:24:15 -0800 (PST)
Received: from [10.0.0.98] (snat-2.cgn.sat-an.net. [176.222.226.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcbf673sm137894315e9.19.2026.03.01.09.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 09:24:15 -0800 (PST)
Message-ID: <37e855bc-cac9-48c7-863e-714abe866ae6@gmail.com>
Date: Sun, 1 Mar 2026 18:24:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/5] net: mdiobus: Scan buses in reverse order
 (31 -> 0)
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Frank <Frank.Sae@motor-comm.com>, Sai Krishna <saikrishnag@marvell.com>,
 Daniel Golle <daniel@makrotopia.org>
References: <20260228232241.1274236-1-linuxtardis@gmail.com>
 <20260228232241.1274236-2-linuxtardis@gmail.com>
 <aaRxee0mf4WJlxUU@shell.armlinux.org.uk>
Content-Language: en-US
From: =?UTF-8?Q?Jakub_Van=C4=9Bk?= <linuxtardis@gmail.com>
In-Reply-To: <aaRxee0mf4WJlxUU@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,motor-comm.com,marvell.com,makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262426-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxtardis@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D22CF1D0D1F
X-Rspamd-Action: no action

On 3/1/26 18:03, Russell King (Oracle) wrote:
> On Sun, Mar 01, 2026 at 12:22:37AM +0100, Jakub Vaněk wrote:
>> Some PHY devices incorrectly treat address 0 as a broadcast address.
>> As a result, accesses to address 0 may cause multiple PHYs to respond,
>> making one or both PHYs work unreliably. In other cases, the PHY may be
>> detected twice by Linux: once at address 0 and once at its actual
>> address).
>>
>> On several PHYs (e.g. Motorcomm YT8821 and Realtek RTL8221B), this
>> behavior can be disabled via a vendor-specific internal register.
>> However, for that to be useful, that register would have to be
>> programmed before address 0 is accessed for the first time.
>>
>> On non-Device Tree systems, MDIO buses are typically scanned in
>> mdiobus_register(). Change the address scan order from 0->31 to 31->0
>> so that PHY fixups are applied to addresses 1-31 before address 0
>> is probed. This way the address collision can be avoided.
> 
> I've said no to this before.
> 
> The order of scanning may affect the order in which devices are added.
> However, that doesn't really have that much bearing in the order in
> which devices are bound to their drivers.
> 
> If the drivers are already registered, then as each device is
> registered with the driver model, it will be offered to drivers. So
> in this case, the order in which devices are proed will be the order
> in which they are scanned.
> 
> However, if a driver is loaded after scanning is complete, then the
> order in which devices are presented to the driver is not under the
> control of phylib, but is down to the driver model code. The driver
> model scans the bus_type's devices in some order, and attempts to
> match each with the new driver.
> 
> If the driver is not present, then even if you scan in reverse order,
> the "ghost" at address 0 will be found, because the driver hasn't had
> the opportunity to reprogram the PHY to disable that.
> 
> In both cases, things get worse if -EPROBE_DEFER happens.
> 
> So, you can't definitively control the order in which devices are
> probed, which means that anything that depends on that will be fragile.
> 

I have observed something similar -- when the YT8821 driver was
built as a module, the .probe callback was indeed not called early
enough. This is why I rewrote the patch to use a PHY fixup --
the fixups are called synchronously from phy_device_register() and
don't depend on the driver in any way. I thus agree that it is
not feasible to handle this inside the YT8821 kernel driver.

Jakub

