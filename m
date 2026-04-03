Return-Path: <netdev+bounces-274939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAOoCrN7z2mvwgYAu9opvQ
	(envelope-from <netdev+bounces-274939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 10:34:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DD039220B
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 10:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A326306A903
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 08:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED2C37188D;
	Fri,  3 Apr 2026 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnaVtn+1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFDC332EBD
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775204892; cv=none; b=Jna4j7GSX3c9bMys1/Dk9/NTriHtGNAm1Uf4ftD4ii+wBKnxyictwRaRcWEmBAg2ElEmQZF/rYsY+bf+dTAQoCzveAjRjIL45F5et8jJ9iU+Ox+ZyCB+cNX1+0D8jPIpJCKO6oJBHfmf6ATsLcApZVw9bYhIdQLCPQfYobmkcNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775204892; c=relaxed/simple;
	bh=P6tV/NSJ8+hcqtrJ1A4O5Qb4o4cfCFtJU4ZhtKEtKlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=luUKWIcU4AA24QXiC1X7k+kPmw59QzaGxiBtNnOLltHO7M5lYWLG2PJ/MeKmuj9LV4KfyeXPrYkW1i3oWjX0qWzN3s8MO6vhhLM8eBX/2vZnDryAxazDv93Sq9lQHyEZfiT9KoEvxRfFcoWcoZC/5GqahB2A0fspAzHcJKZ14LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnaVtn+1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48374014a77so20893785e9.3
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 01:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775204889; x=1775809689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BbH7f0R2O6m5QabRfcMy7zKu4Ni2chMwcIYJDUdBZQs=;
        b=UnaVtn+137YiMT9e8E+q4C7cn7LiL/AbYE5ApJMFzZg9Rrx6GXW+wyfJw8yENzmIYW
         pMO5G6BrDOhTpc9Z9MhdqL1yn+6HVZ4D+OEQid+RUdUwU+lUuQbplyWLfEPSWn2ggzK8
         auSOfYmgBJV/QD2xrL8HFqLZbtSaSrIWstxCz9tCX3KHofCoGFKZq1k7s8CT/wa1cNNs
         6NMQp1J4B5H2/1dQKM/K+fEXX9SEzFaBaCPFlh+vlxtTAt9NB3VR9VZrjgsZ1rTqSCxN
         3NJXq8JrcRP02z78Ohh1LDvAtqDz4UBDD24kuFPIQ9pmSc8IQOAS8LI2VUb2I9baxorf
         YpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775204889; x=1775809689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BbH7f0R2O6m5QabRfcMy7zKu4Ni2chMwcIYJDUdBZQs=;
        b=KmG1qnCsp/SQlDeuwueQYhqlNMQkYCrlYN8XG4nikfk2VK/q96LnSDj7tHQOhO6UFp
         isyueOKUsINO09la8+paokluFRmRV+0C33ChSXLGwPT6YLLgTomXouLEzPbm+b0pXG4b
         WdfMvxe8lMP4LQGE71giTfacUZowtA7IwSvceIIH5yeZiSasBdRhPOrspYxw/AXuLcbF
         sqXvahY/+SdZSOCnsyO0gXF6bFK0dTHpwSFf99qav0K1PJLOYJp18QKP/tQbkbrLDH9V
         3bkcXX6Fk18pGJ84besj0VhJykwKiQBuEI45ZYNniQDWRwoxeEH/SjsiaojMce4t7IZI
         +ezA==
X-Forwarded-Encrypted: i=1; AJvYcCUFWvPN/VTB0FpjSURLq8Ga+JqrqK8MmiZ6wbvQXuY3MM997ZjsaeJn7cB+YU3iBBylhAHCcb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWHLajMB9c6/fZRaCkiKczcwgIT3RlvUFy/4PTrVOJoOdc8GUb
	To45bPOhidVLj62g83Ws5X5I4axNybdiNdf04WuISkIN8KbxGzr/skw3zNL9vASWZo0=
X-Gm-Gg: ATEYQzyK4X97p3JwK3uoN+sZcfxolDqTNmHoEb5ECBM+PhbbUtJZvloDpHiPMya5qnO
	/XqEAMBFeU7oiXb9lOZR0PeS0M7cZIn0d81uBEKTfs5cpcAhhzfHLwLwsFD6V2KyRHHD6sFXTRQ
	KimaZc8GkuJs1remo1u2d52NbBlIJ1hZzqi9hxr2BSdSvmYDN4XBWSc8Fk7C20lSWEX2dox0c04
	G9vdPsdTLHzgsyohgBsA4CgiVBwvvc2/072VIQ4YhSlFvdwtwfyomowhBXAa+FO/rq/7INg6OdH
	M9sKL4JUA8FQDbOsC+XBMXVWvImTtvCEwa87VpwNxzwT8idsRJ0ZX3pNYbgvvH3swEAKau5wnfb
	3mewTbXyLFCTxoRPPtn/e+h/+6ie5WBtmq/E8MERox620b3a5m+1TFMZbBT9RjL6Edyb5ZQNTt6
	6QnXn92G6+u1dGU3QZ9R+Zk2L0Cdrl6CF2qeuwOgwhNrVnRkE6v8tAJ7sD5uYEL96ZjstmmrU0D
	XHy/KZrjA==
X-Received: by 2002:a05:600c:4688:b0:485:2c61:9457 with SMTP id 5b1f17b1804b1-4889970ea7bmr33974195e9.10.1775204889311;
        Fri, 03 Apr 2026 01:28:09 -0700 (PDT)
Received: from [10.1.4.108] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488982e3244sm14946025e9.12.2026.04.03.01.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 01:28:09 -0700 (PDT)
Message-ID: <72c9a165-74bb-42a5-b5fe-67bfa2c8ce2e@gmail.com>
Date: Fri, 3 Apr 2026 10:28:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: dsa: microchip: add KSZ low-loss cable
 errata properties
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
References: <20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com>
 <20260326-ksz87xx_errata_low_loss_connections-v1-1-79a698f43626@exotec.com>
 <521cf729-50d2-44c1-8c96-c1fba2127b9d@lunn.ch>
Content-Language: en-US
From: Fidelio LAWSON <lawson.fidelio@gmail.com>
In-Reply-To: <521cf729-50d2-44c1-8c96-c1fba2127b9d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,vger.kernel.org,exotec.com];
	TAGGED_FROM(0.00)[bounces-274939-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C4DD039220B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 13:14, Andrew Lunn wrote:
> On Thu, Mar 26, 2026 at 10:10:21AM +0100, Fidelio Lawson wrote:
>> Microchip KSZ87xx switches are affected by the "Module 3: Equalizer fix
>> for short cables" erratum described in DS80000687C.
>> The embedded PHY receivers are tuned for long, high-loss cables,
>> which may cause signal distortion when operated with short or low-loss
>> cabling such as CAT5e or CAT6. In these cases,
>> the PHY may fail to establish a link due to internal over-amplification.
>>
>> Two workarounds are provided by Microchip, each configuring a different
>> indirect register value to adjust the PHY equalizer settings.
>>
>> This patch introduces two new device tree properties to enable and
>> select the appropriate workaround:
>>
>>    - microchip,low-loss-errata-enable: boolean enabling the feature
>>    - microchip,low-loss-errata: selects workaround 1 or 2 (default: 1)
>>
>> These properties allow board designers to opt into the errata fix
>> according to the targeted cable characteristics of their platform.
> 
> Does the errata give any indication how the two different workarounds
> differ? How would a user decided which to use?
> 
> I also question if this should be a DT property. The length of the
> cables is not a property of the board.
> 
> A PHY tunable would better reflect the same board can be used with
> different cables, with different lengths/quality.
> 
> 	  Andrew

Hi Andrew,
Thanks for the review.
Regarding the difference between the two workarounds:
Microchip’s errata does provide some insight into how they behave and 
when each should be used.
Workaround 1 modifies the PHY equalizer settings by adjusting an 
indirect register (0x3c).
According to Microchip’s support article:

“The above register change makes the equalizer’s compensation range 
wider, and therefore cables with various characteristics can be 
tolerated. Adjust equalizer EQ training algorithm to cover a few type of 
short cables issue. Also is appropriate for board‑to‑board connection 
and port‑to‑port connection with the capacitor AC coupling mode.”

Microchip also explains that although the default value in register 0x3c 
handles standard short Ethernet cables (CAT‑5/CAT‑5e), a more optimized 
value (0x15) provides better tolerance for corner cases, especially very 
short or board‑to‑board links:

“Based on tests, a more optimized equalizer adjustment value 0x15 is 
better for all corner cases of the short cable and short distance 
connection for port‑to‑port or board‑to‑board cases.”

So Workaround 1 primarily widens and optimizes the DSP equalizer EQ 
compensation range, and is expected to solve most short/low‑loss cable 
issues.
Workaround 2 is intended for the cases where Workaround 1 is not sufficient.
This one adjusts the receiver low‑pass filter bandwidth, effectively 
reducing the high‑frequency component of the received signal:

“Based on the root cause above, adjust the receiver low pass filter to 
reduce the high frequency component to keep the receive signal within a 
reasonable range when using CAT‑5E and CAT‑6 cable.”

So Workaround 2 is a more aggressive filtering approach, applied only 
when the EQ adjustment alone does not stabilize the link on CAT‑5e/CAT‑6 
short cable scenarios.


Regarding the question of whether this should be exposed through a PHY 
tunable:
I understand your concern. The erratum is indeed linked to cable 
characteristics, not the board itself.
Since this patch modifies registers that belong to the DSA switch 
itself, and not the PHY driver, I’m not entirely sure it would be 
architecturally correct to expose these adjustments as PHY tunables. The 
workarounds target internal receiver/equalizer settings inside the 
KSZ87xx switch block, accessed via the switch’s indirect register 
mechanism, not via a standard phy_device.
Given that, I’m unsure whether mapping these switch‑level registers into 
the PHY tunables framework would be appropriate or even feasible.
What do you think?

Best regards,
Fidelio


