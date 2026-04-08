Return-Path: <netdev+bounces-276599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EN9pGn9z1mkWFggAu9opvQ
	(envelope-from <netdev+bounces-276599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:25:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3D93BE280
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4E8930156FC
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 15:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875CC3D667C;
	Wed,  8 Apr 2026 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdzXm6xa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3B93AF670
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661946; cv=none; b=o8Zt66mPwDWJC13dlkFvl54ZUbEEOp2gugfROttcRdom4r2Uh+Va04ikgIo1AFxbc+wD6fT2S91g2xgMFG+kn47CnQK9cUA8WKZUTAjAgYANCDiP2U8iKUzsA5AytIdt7+AGQ4jQVqEw8qH5HnKxP4c3t1xgt2UVUJqIvfPRSo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661946; c=relaxed/simple;
	bh=5uZQetOvevtL0mvlMj7KiFmCmHDYLkwGGitGi+quo4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p03JmMOivotIN9/teCAZxYvbzr2s9g9FQKTPRw7xauiwh7p4DTFHZnrq3SXqQcU3yYu/L2YLypGFW3yholzlw7858Vked165CGQWUQ2PFO3wHuOdTGbXZVBr51pw7Ji+aMHcPLB5ISqDp+RG/4JzZ6H6C4gZ06CG//+GFfYi0Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdzXm6xa; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso52743245e9.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 08:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775661944; x=1776266744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EC2v+Q/gnBLhwWmQlqWcd9BxtNoiH00jSXgAbXbWBps=;
        b=HdzXm6xaIgQTHUdWQkMXqt+5zsdXnafOQU8548jqgHOjj6TQgYOTrqjXlkKfK08RHu
         tSgIlDUN2jiP6x308CB0mIdK+rNED2+6SzlOCQ9SLRj2qw6k7vxCE8A0hIlPTVTwRtN/
         uIRDALUJbG6Xc15Qm3oFQq0zIUarcH6UTaIERI/0WhnjgiFqnzy/5jcdMOYrGDqpO3wv
         v1gOhAQqh8u8imkYwdZ9FR0K01/7mnvzyA3YobSUFq5iw6bi2ef1s/WiOrckIMMsaaWM
         3KxCvVvVeKkNCfwKcSewF6BMcXu9H5xFOZ0ytvBVdU1AvBIKLUl2T6SRMT47mTj4hkIm
         hzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661944; x=1776266744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EC2v+Q/gnBLhwWmQlqWcd9BxtNoiH00jSXgAbXbWBps=;
        b=l0c3QpHuTEVRmW2Jeh/sF5AM50SPppMdYPKnvbtJiwbBg6BdNZpfkK9Oh73+y7uhlL
         jUa+RCHhbHE7RYOJx2ObTZSu5oCR51rtcLK802EETbCas6SdMio3i4lV/ah6KF2DaveQ
         ScosRt6Ht9N2hdxTqFf+TRPJ1gcvTuh5F5KbFf3InldmNrSkdwq4VXqt2156vXYGjPO5
         JQHkxoH1PY62B8ZI9tY6uSSph/7Dj5IPtwJGg6B7EAtb9z0W+qESzvQqZFDfvASqg09Q
         49VfTxzQYeC2Gg/sOV6QwooffrZY4TyzJe9rhAk/hQpvMhrb9JgzhQ1xKz+P1BVN/5U8
         l7RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXITs6n332mMgIkgGlGyGJyIpodGdHjn0y9ZKezBp13dmRrablUDz/iINJCWdD3PstBAm61HfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHBeKEwu1iLriiABdaRC0wzD4vV77bXy+OL+utZfXBFfCz0B8Q
	7TU7E+y1R0RjAsy+9UzpyuYufrmz6cnfL3i0IJuJZ1nzhleHQGIeh8SZ
X-Gm-Gg: AeBDiesj+ETNZdBnC0W424l8zAtE6mwl+lsDQjj1USwEbBbuz/sIF5bwMgPnVZaNFGq
	PvvvN1LGM1IYHQrpMBkAEh/Vh2fpDYkENZvF3TH1v14mIeTfEnjpuuPWTWYEwqh1p/RftNLczlf
	iOdc4w/wfVRCLcs77bHXqlVM15Xi+y698+dPUzPv+G0HW9uS8woQQJ+EqE4xDJnT0juqW8i5GsK
	wZzwOqvXK0p7UH/8I88296C9W/E5AypunooWdyFFcqrnsLv1AVorC3Gk23Bmph74b50AcBGS9ed
	7Ez2nYFJ60GKMBWAZso/orBQNv/cbe/K/UfqT5N4phaYK5aSUYC7+BNgY35dhYcpBAmFMgEJZ33
	xT14GemJAKonglYQkPAjO1Ghinrw9JZHwxq7ciwV4ZrDmJr68yrQlT0nyIqfJoM4dNl4ravbH2D
	PbRvV/rDHVSMOkIcEozGH1Z3RKV+vQmEizxVseY2tcXS9VqxSj39X3VZi+2eu6dPCsTNxGWQkcJ
	zpAc2IRDw==
X-Received: by 2002:a05:600c:699b:b0:485:3ee1:eba5 with SMTP id 5b1f17b1804b1-488998f09dbmr360376005e9.27.1775661943426;
        Wed, 08 Apr 2026 08:25:43 -0700 (PDT)
Received: from [10.1.4.108] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd19a881sm300285e9.3.2026.04.08.08.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 08:25:43 -0700 (PDT)
Message-ID: <1040e6be-6223-4cfc-b603-e2dd90713bb7@gmail.com>
Date: Wed, 8 Apr 2026 17:25:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
To: Andrew Lunn <andrew@lunn.ch>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260408-ksz87xx_errata_low_loss_connections-v2-1-9cfe38691713@exotec.com>
 <a350c4b7-d816-455b-83c0-f4d98299c637@lunn.ch>
Content-Language: en-US
From: Fidelio LAWSON <lawson.fidelio@gmail.com>
In-Reply-To: <a350c4b7-d816-455b-83c0-f4d98299c637@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,vger.kernel.org,exotec.com];
	TAGGED_FROM(0.00)[bounces-276599-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DD3D93BE280
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/8/26 14:43, Andrew Lunn wrote:
>> The control register defines the following modes:
>>    bits [1:0]:
>>      00 = workaround disabled
>>      01 = workaround 1 (DSP EQ training adjustment, LinkMD reg 0x3c)
>>      10 = workaround 2 (receiver LPF bandwidth, LinkMD reg 0x4c)
> 
> There was a comment, which i only read after making the suggestion to
> use two bits, of exposing the different low pass filter bandwidths,
> rather than just picking one value. How useful is that?
> 
>         Andrew

Initially I limited the LPF setting to the single bandwidth explicitly 
recommended by the errata (62MHz).
But I’ll extend the implementation to expose all documented LPF 
bandwidth options so the interface is more flexible for users.

Best regards,
Fidelio


