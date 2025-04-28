Return-Path: <netdev+bounces-186488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC81A9F611
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA141894E34
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 16:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5535226461D;
	Mon, 28 Apr 2025 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="K9W5vj48"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A5E7082D
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745858604; cv=none; b=O216mGkDPGbO3QVx43cirSuj+cGzdW/BuuZhp3/T6dDktpzur9gv4S1RDpQ6vDz2FQdwG+mZJMrYA1lx8VsM6mHLlzRzYDsc9ylBzd3uBNmcYFzdA9rhGKdd/J8MyM/K3EzWAXqw02FK9W/f6BRbaqtG5H32pRjw1SfrqHFisKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745858604; c=relaxed/simple;
	bh=zD7sx+OuhL+WAheWmPauk2ahQJDp/HK74ySKXA17O3g=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=l7++wZoCLraPkB5hBXIiT6tLrnQourw9t54OUpUYNF2+fKoADjNd5bxeSqqWasNAww4upkGLKfZCeLoEWp2hjgMQcbBcdOTQa/rBSFF0gzwpjuXtKcPKlnCQW0MERusLMvcJSq6F8KMDVAPjK7MHSosLbu/BODMWf2l4871AkQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=K9W5vj48; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39c0dfba946so3670448f8f.3
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 09:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1745858600; x=1746463400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ngL9FqKM7D7y0OuHdGq66gueiX0sm6vhAO6erZg3jDI=;
        b=K9W5vj48VfTh/SCd6hpO1BTMOr3F3YZqoHGvTxE2hbpP4kefLUIegwysfQxyTWixts
         Q6CTfw9iYeax2Fbo89V4V+j/fF7IWHnpBZzBKLJncy16Vl8hW79hmaR+KnjkbjL3FXgZ
         4/2R7wuFPi28QkCMnjyu7JsHAhsnWPruff1rgBpUYMSoqq6rsxxHTV+RvepTXUWh5BE8
         9qXcgjWbgz7l9cJlQGo1sWtiIRZ0hT5jxq589vqrrXr3PgziGTfdC9ROi09u1QMkoyb1
         u0TAaOqKbw6uwHG841Pmrbt23ZLsQ29lFce18Kse1K9xBYJeoHo6pLyvjVde+9xqIZXz
         oRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745858600; x=1746463400;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ngL9FqKM7D7y0OuHdGq66gueiX0sm6vhAO6erZg3jDI=;
        b=AYNltEpRmkXpBeyjr0bkkvP9GQ4IkjZ576+rWbZWDNqvfLN+t18n0EqFGh0+2Qdk09
         xZTknY7Hlo/3ovdTBf4q6fGMlWHa+ZDO+7h/9qYDkCV9HJxBxV0aM9crDUcTPcxsHTZQ
         bJ9pRXpjnOWV9bIhBtKzT0vxlZaKNunSWNHh7Bp0LN4pPZC53WyoGYTu1BZ8p1Gk0iNR
         cnyM+rLgGPy29B0NqJHUB3jEsGELnXrbfaRRmVTWaNQFWFI6uW9MMuClj6a6Tx9ztZPX
         8LKRQJPxOozpr0TYyvDLT181fI/XaIY/Huiwo+Qkq6oCBcTm6bGM0O2d3z8RlhH4LOG4
         grPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7QggmnqayoX9s2irUNlH/Ju9g4E5vAOP1rmHGhAvr/6Sjk7DqqLws1RxWccHzk3Ux+xTp9ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBLzzgZzrXR14nXKcf4wTXZbrBwkpVMUocGUSkMibfxUyQIym0
	OqxXzWGqmvVq3bgBrR4IHmEQb2Zxa6c7W4OTMbmeQITX3puzMP1pueiSIAbg6w==
X-Gm-Gg: ASbGnctDRZ2q1zNMykxqDwiKzTpuvA0yv1pL0tznbuPavFUXBpSjLq11Q6PelCcRHYX
	u4Y8VK7vWnL35LWglGU4VcWvZweIGpW4vmlWylXiXDCVIA1uILCLPzaNehFP5b6I6A01L7hSqxO
	AKg+0/fZjRc16XVPIVsHwZnGiOvbKQyxQa9DHtH0GP1bq9UY6XNWv+UjA+m6KfXJcIR2WRZK7d4
	4RFI2KwTrdqmntutoW4rmeL6b2jme4ZhiBbSJNAo4jgSjLei4sugn5YEKeazzJaR5p9DPKSeb+u
	9BIjiPVOX8hMEsvnIF+xKVwEOqCACycU4FEWiF9hHME=
X-Google-Smtp-Source: AGHT+IGFjWI+lVIy6EA1Bqgdb51QjF8leLF2CGAMRsmOB2lGxbngUneKH6NHv056PQkZdlWc6qwEdQ==
X-Received: by 2002:adf:f78a:0:b0:390:e158:a1b8 with SMTP id ffacd0b85a97d-3a07aba1590mr6610525f8f.43.1745858600210;
        Mon, 28 Apr 2025 09:43:20 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5e345sm11763147f8f.94.2025.04.28.09.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 09:43:19 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <a0069d48-38b9-4bf0-979f-7051f8e906f4@jacekk.info>
Date: Mon, 28 Apr 2025 18:43:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: disregard NVM checksum on tgp
 when valid checksum mask is not set
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>,
 Simon Horman <horms@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <5555d3bd-44f6-45c1-9413-c29fe28e79eb@jacekk.info>
 <20250424162444.GH3042781@horms.kernel.org>
 <879abd6b-d44b-5a3d-0df6-9de8d0b472a3@intel.com>
 <e6899d87-9ec4-42aa-9952-11653bc27092@jacekk.info>
 <0530ea8e-eb81-74cd-5056-4ee6db8feb9e@intel.com>
Content-Language: en-US
In-Reply-To: <0530ea8e-eb81-74cd-5056-4ee6db8feb9e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Anyway, I think that the commit message should be precise.
> How about this?
> 
> Starting from Tiger Lake, LAN NVM is locked for writes by SW, so the 
> driver cannot perform checksum validation and correction. This means 
> that all NVM images must leave the factory with correct checksum and 
> checksum valid bit set. Since Tiger Lake devices were the first to have 
> this lock, some systems in the field did not meet this requirement. 
> Therefore, for these transitional devices we skip checksum update and 
> verification, if the valid bit is not set.

Should I prepare v2 with this description?

-- 
Best regards,
   Jacek Kowalski


