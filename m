Return-Path: <netdev+bounces-243258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D3CC9C53D
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 18:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 47A8E342C30
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 17:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2891296BD8;
	Tue,  2 Dec 2025 17:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtoQZk7G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24695220687
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764695063; cv=none; b=k8Q7GIIzmj3ahNiCWUtsP0whOhiI3Gme1bpWpasyn08tPNHflQmTRv/L4mUvv6R2Owd8d8H790mTKX9dSceoo1FvkWLw4cWmApveLCiY0a6TXq4kSBYz7/ormYSHxcnmJx2KvbSYMsk5Odjs1EDYtEkTDWVA8dAxLcpNP4ifWbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764695063; c=relaxed/simple;
	bh=oc7idk3qiKFq4WHjsNbF5/Rlte2F3mBY7QaAFMfto4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ldrx3MdFK6pivLxiylB1KDzIS8eeq83oC8nmXMQ0pXwZh+KA9BaGt1oNbp9wwv7eei6DgsmUQ/pbU1m16CpbQjMETZxe7nKlmJVv4eNuBnRzYas5xtH80nrppIZnUAQw58f/0VUEeOkqhWntbddyiTBdzCImI0QdP3R06QBayg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtoQZk7G; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so41890565e9.0
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 09:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764695060; x=1765299860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=70rrKubDcTUIlxI3SNgGw2ECwsw2wsync51U+B+IYI0=;
        b=JtoQZk7GfGAiCzYuh1LBfTD4a0rAvImkwEi6fevO7NCfyKmVYw7sJ5SOIkSqTDRYJK
         r/7+CdhXLFx44ZoEZnfajVU9U0kt1g508FPLaA4HL6tLohx3ZNhiPsxxr8oxu5gcBOs3
         3JWIjoO4t8FRwxIjvyx5yK+a4fmB6VVMr9MbVejw6AdDPZaefacjkv4RdiH230e/UoAM
         NVFSTgAQ2YAOrNq9a/oW456I3yANE1uCCr7u/4BoY0/JkxNj9XU1OdU+z+PKCTtW4g2o
         t1OF3BAhAHx3H+ZzlaxVzRK3LDBocTynvuYH7XRbwfYgnChEB3vCpxZKerhKVmjzucdC
         UIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764695060; x=1765299860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=70rrKubDcTUIlxI3SNgGw2ECwsw2wsync51U+B+IYI0=;
        b=O1cKzObSD16UBMYYwOuk4p9iW4gz9Dg4+uh10QJ2CJ+YBtppRmEjJwJAMD1EyctBnE
         8VWEHdQd/WKfu/qMF5RFWbFRm+dRMiBs9qeUpC/sHhm71CJ+7mPpiV//oRFoYTcOE3tX
         dk2W4eiF9rhx49txbHXbEIp38ow+4SDEspCke46iWyk5zI6MQ9zWqFhMcF037KlPQGeC
         43foS4mdhJxyAlTMUzLyptvBKQUz9WKem1RNQyOc8G12D5OAgL/dt++DxFiofzTiaUNA
         G+X/lKyrpKeuGTM7ZpOQlq79nfF8/RUsJKce+l6GUylN6EDs+Yc1fbQ+mJmu6pZtEqrI
         ypBg==
X-Gm-Message-State: AOJu0YyQ2pMDixJWKwlxiHaig896LoCSJ4sC1g7pthu+wl5DKMROGpQv
	lGkWmFQcm5qIS0GkfHn19v1PseJX1Q7nyYGGZib6t/8vwdjKKxgBW7Ci
X-Gm-Gg: ASbGncv1ZkLI2xxg/ovqX64ICuNHi5o11O4625HmIbVsODst5S7TaE6ddj1y5vPOV+X
	EQCYe2ktrdrsLETbO+9itJq5CsdVSLNoMz0/JrDdjpmnR6b1Fb6oaa33ETiFZ7vAUpThZITuNZm
	1Me7EgfNFtDF+j/p91mkLyOurFkKO9aTPBU/astyeQ0UM2Hv64dfC1uUaWzqT/osgDy593gsRvr
	EIB2OF4r//5BkpJFfUaWSfoMRpmtUYsUKcmT12bNbmAWotGdXXCeXjoTpUaR/h+GP6HzxmCbFVY
	f5RDp+gCUqZev9mUoEgzOVqLoLjYfK0b9s7sNLXNVJXsTlzxPALayy7gV0FUc8U3lwhoAq2zqI3
	xTxiA663TJr78PFf5vbbdgUfJ8Wx+HwirSttDkmM8KEIy6QeNpEmyaHoZ/L706WB65bCm6WKCkg
	5AZN+GEUYtTV+xDmjIwAoiGHqyYkb5UeDstl4djBKsM5shKL0NkOYaiGtuHDjXIZFr4ou8nlYiN
	mdtRWgp3/fxHbtvtc71x4lPBCSXqYrVIfN51hRcq6I7//Dt0p6T/w==
X-Google-Smtp-Source: AGHT+IFlMbzh8IMc6Ivx9WsQxMA54hO8wFwKmb1ESQ5lisQsADueESXcoE8752j7Hj83IrUC+G8mwQ==
X-Received: by 2002:a05:600c:3516:b0:475:de14:db1e with SMTP id 5b1f17b1804b1-4792a617ea7mr2406495e9.24.1764695060092;
        Tue, 02 Dec 2025 09:04:20 -0800 (PST)
Received: from ?IPV6:2003:ea:8f22:cb00:61e9:ed14:30da:92bc? (p200300ea8f22cb0061e9ed1430da92bc.dip0.t-ipconnect.de. [2003:ea:8f22:cb00:61e9:ed14:30da:92bc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a3f1sm34174782f8f.28.2025.12.02.09.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 09:04:19 -0800 (PST)
Message-ID: <91791699-e362-4e45-af48-f59fc6d31f53@gmail.com>
Date: Tue, 2 Dec 2025 18:04:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: fix RTL8117 Wake-on-Lan in DASH mode
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>, andrew@lunn.ch
Cc: netdev@vger.kernel.org, nic_swsd@realtek.com
References: <679e6016-64f7-4a50-8497-936db038467e@gmail.com>
 <89595AAE-8A92-4D8B-A40C-E5437B750B42@exactco.de>
 <2d6a68c7-cad7-4a0d-9c73-03d3c217bfce@lunn.ch>
 <20251202.165654.1809368281930091194.rene@exactco.de>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20251202.165654.1809368281930091194.rene@exactco.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/2/2025 4:56 PM, René Rebe wrote:
> On Tue, 2 Dec 2025 16:52:42 +0100, Andrew Lunn <andrew@lunn.ch> wrote:
> 
>>> Well, the argument is for wakeup to “just work”. There also
>>> should be some consistency in Linux. Either all drivers should
>>> enable it or disable it by default. That is why I have thrown in
>>> the idea of a new kconfig options for downstream distros to
>>> make a conscious global choice. E.g. we would ship it it
>>> enabled.
>>
>> You might need to separate out, what is Linux doing, and what is the
>> bootloader doing before Linux takes over the machine.
> 
> By Grub2 boot loader is not enabling WoL.
> 
>> Linux drivers sometimes don't reset WoL back to nothing enabled. They
>> just take over how the hardware was configured. So if the bootloader
>> has enabled Magic packet, Linux might inherit that.
>>
>> I _think_ Linux enabling Magic packet by default does not
>> happen. Which is why it would be good if you give links to 5 to 10
>> drivers, from the over 200 in the kernel, which do enable WoL by
>> default.
> 
> I'm sure supporting WoL requires active code in each driver. The next
> time I have free time I'll go compile a list with grep for you.
> 
> Best,
> 

How I see it:
At least on consumer mainboards you have to enable WoL also in the BIOS,
doing it just in Linux typically isn't sufficient. So it takes a user
activity anyway. Common network managers allow to specify WoL as part
of the interface configuration which is needed anyway, releasing users
from the burden to use e.g. ethtool to configure WoL.
And as stated before, WoL results in higher power consumption if system
is suspended / shut down. What apparently is less of a concern for
"professional-grade" NIC's, whilst basically every consumer system comes
with Realtek NIC's (apart from few systems with Intel i225/i226).

