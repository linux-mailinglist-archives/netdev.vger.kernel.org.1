Return-Path: <netdev+bounces-157443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AACA0A518
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 18:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E770C188A485
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 17:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6551B0F19;
	Sat, 11 Jan 2025 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiqRiK4m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E87A153803;
	Sat, 11 Jan 2025 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736616764; cv=none; b=jY+w1fm4D+wAOhXj77+K3Mmn2jNTFRS5N0cKiBiSTAlHSr96+fTQCg8ol2bbyCe62l45MTotXXjscreP5xFT5iDIR11byOr2Qtf87UbenPOxpUKc3dyZYZ8QuSgjEwJFePP7fQTc6UKN2oN3hLQuabvbU+vC6Mph9t9Q5/Q++Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736616764; c=relaxed/simple;
	bh=nppiaBl9/cn2ixhW1mVVwRtX6gT72NQbuTAmzxqk+Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awoeenpfDqBJ9FVLOSVMPR43QhRKoSXp7px6b3UjX2EsQPH375mW6eMHSTWvwatPM4G3uH3aGoBEZ5nyTspzJVCU7Mxxa15v/aKLso/CVSb1NuaB0z5piLRnGRdj5fjg6KCL4QpjDa2fjcOYKsj0xVIXekc1NxAIZGj+E3rRFkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiqRiK4m; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361f796586so31731975e9.3;
        Sat, 11 Jan 2025 09:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736616759; x=1737221559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WT5lxgWKfKuUNds0df6T6E2qudfAkVIjh0gIjNYsRjk=;
        b=YiqRiK4m251N0vlB8amdlxI9wvqTaFMR0kqfoCYgdOX6Lc+vjFbu37MctGTqyL5A1v
         1DPExcssxMSd+eAq97kl/fWNjea/LVLeF5P9vSOvZEFi7uGTUhoJ+I/cm/LcFoD2yI6L
         ehDAjL1sttGVzBCkEwBUy0kgmz9lTW8p5ENqlo60O79hm1nq+xqjLL/kTnkAYsOdnzVf
         0ia4NGp7tETEDxevx1NrV1GvO7Z7YqT2o8u/XU108rFrKTgLWOZAtV0wOk1U/mEzk7FJ
         jO634ea/Ngsulq/kXlj3gdbv43iLRPDpifHBWfe3ocE7cSjjbo+p8cgMUeHn0JR1bLGK
         +tWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736616759; x=1737221559;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WT5lxgWKfKuUNds0df6T6E2qudfAkVIjh0gIjNYsRjk=;
        b=OwX1J0jY82nZoQGcV2rROYxGjrqxwsjAAHG3Yz3NxaRxUsX0mYyi+My66pbvax5sub
         bP1tO06f03SsKnrR3AqKkiYbnEtRQvDbPWIn6zebYMyqYvsdIS6uIXcRs3v6pZ23LCsp
         oxeNYwVaPK5j80UuUXTYspFq8audoKkKKj1gHqX6rAlLOCd9QPduxrMRxamUrcXf8oos
         wTtcoPvkKd/uNl/BF5YpT3cBHXgF2btvnScUoRZQxK8Lo2zhrYbnXJH9Ke9z4CtNUi5S
         AWFcUf0UVrYyllwxXvaOc7Xz4HanxYFYDY5NwFznz8ZWr0mmwwCPHdy2npK0ejdnsWen
         gc3w==
X-Forwarded-Encrypted: i=1; AJvYcCVyU1dSU85BVRPYcW0ukgP+BLHRRPbC9Xb4eskRpzgdkEq/vNdWiBJi16wEJ57KgBFqYy4GoHkNqqRCsA==@vger.kernel.org, AJvYcCXi95mIC/Tb/470zedFTGKmMK0GJ+h8rWAuOg/SbER6Cn2UH504uvVmu/q9W26QHNGyDX7W8bG2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/FpRQh8aOhspPQqBKWPpQnxQ2ADeP0P7VMP8xVqsL5QBUd0IR
	3mZD/Xgia6qi2VDRRG9xf+wamCQGDSiNU4NuMlL3ft9C+ZbbV3lfRZ4pOw==
X-Gm-Gg: ASbGncsWnXL65SUTPCEAE1oQQVUMfKaOOdODROJ6MVQ4TMvzhSk63fZ62MRfEzBkNCn
	KN65F1ULRhkbykIvwozHWvYRb+CGwMfxRY+Uw+yRqvATdP1qA5rNlCCXT1ibc8RkJs6D1zFLJ1A
	TOfQ7FQmt7Kd1OkrFEMBXIXj5FeJNq20blNpcxuYq/jdn6NuN58Hoc9tm02Ny6VtewZov3AlO/w
	7I9HCOkDJkwDOuBbu5W9cqYLbL8lmNnJ5Cxm+7t+IlWrUj81yGGyhTtpwlVQ0MtU3Ry3Lv09Dvh
	lgkIPk1Q8ezXOli6BuiM98dnKxpzedwc3o6DKlBYIkgyVD+ghOJCf7bXhHPJ3dqti8OQGfbD2mq
	iAy4QMee6NiQfhZVoaaqNVnk8tSAS9iMNPn29S2H65PwbhDJX
X-Google-Smtp-Source: AGHT+IFAD/22yZCRX4JJv2dp2GB1o4i/ankoIh3Rqz8N0gi+rMKEohWs+21GdDZwbDZCWmizAaO1Vw==
X-Received: by 2002:a05:600c:1d03:b0:434:a781:f5d9 with SMTP id 5b1f17b1804b1-436e2697b32mr94172085e9.11.1736616758616;
        Sat, 11 Jan 2025 09:32:38 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-436e9e37c2esm87758705e9.28.2025.01.11.09.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 09:32:37 -0800 (PST)
Message-ID: <e8bd6c18-1c71-49b0-a513-e38bacac90e7@gmail.com>
Date: Sat, 11 Jan 2025 18:32:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: phy: realtek: add hwmon support for
 temp sensor on RTL822x
To: Andrew Lunn <andrew@lunn.ch>
Cc: Guenter Roeck <linux@roeck-us.net>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 Jean Delvare <jdelvare@suse.com>
References: <3e2784e3-4670-4d54-932f-b25440747b65@gmail.com>
 <dbfeb139-808f-4345-afe8-830b7f4da26a@gmail.com>
 <8d052f8f-d539-45ba-ba21-0a459057f313@lunn.ch>
 <a0ddf522-e4d0-47c9-b4c0-9fc127c74f11@gmail.com>
 <0adfb0e4-72b2-48c1-bf65-da75213a5f18@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <0adfb0e4-72b2-48c1-bf65-da75213a5f18@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11.01.2025 18:00, Andrew Lunn wrote:
>> According to Guenters feedback the alarm attribute must not be written
>> and is expected to be self-clearing on read.
>> If we would clear the alarm in the chip on alarm attribute read, then
>> we can have the following ugly scenario:
>>
>> 1. Temperature threshold is exceeded and chip reduces speed to 1Gbps
>> 2. Temperature is falling below alarm threshold
>> 3. User uses "sensors" to check the current temperature
>> 4. The implicit alarm attribute read causes the chip to clear the
>>    alarm and re-enable 2.5Gbps speed, resulting in the temperature
>>    alarm threshold being exceeded very soon again.
>>
>> What isn't nice here is that it's not transparent to the user that
>> a read-only command from his perspective causes the protective measure
>> of the chip to be cancelled.
>>
>> There's no existing hwmon attribute meant to be used by the user
>> to clear a hw alarm once he took measures to protect the chip
>> from overheating.
> 
> It is generally not the kernels job to implement policy. User space
> should be doing that.
> 
> I see two different possible policies, and there are maybe others:
> 
> 1) The user is happy with one second outages every so often as the
> chip cycles between too hot and down shifting, and cool enough to
> upshift back to the higher speeds.
> 
> 2) The user prefers to have reliable, slower connectivity and needs to
> explicitly do something like down/up the interface to get it back to
> the higher speed.
> 
This seems to be exactly how I do it currently.

> I personally would say, from a user support view, 2) is better. A one
> time 1 second break in connectivity and a kernel message is going to
> cause less issues.
> 
> Maybe the solution is that the hwmon alarm attribute is not directly
> the hardware bit, but a software interpretation of the system state.
> When the alarm fires, copy it into a software alarm state, but leave
> the hardware alarm alone. A hwmon read clears the software state, but
> leaves the hardware alone. A down/up of the interface will then clear
> both the software and hardware alarm state.
> 
Not clearing the alarm on read is better from a user perspective IMO
(at least for this specific PHY).
As long as the alarm is active, the chip forces a downshift. 

> Anybody wanting policy 1) would then need a daemon polling the state
> and taking action. 2) would be the default.
> 
> How easy is it for you to get into the alarm state? Did you need an
> environment chamber/oven, or is it happening for you with just lots of
> continuous traffic at typical room temperature? Are we talking about
> cheap USB dangles in a sealed plastic case with poor thermal design
> are going to be doing this all the time?
> 
I have a M.2 card with RTL8126 (w/o heat sink) and an external RJ45 port.
This card sits in a slot underneath the mainboard of a mini PC. At 2.5Gbps
it makes a big difference whether EEE is active. With EEE it reaches 54°C,
w/o EEE temperature quickly goes over 70°C. For tests I add a PHY write
to the code which sets the over-temp threshold to 60°C. Then I can
easily trigger overheating by disabling EEE.

On my system the over-temp threshold set by the BIOS (?) is 120°C.
Even w/o heat sink I can hardly imagine that this threshold is ever
reached.

> 	Andrew

Heiner

