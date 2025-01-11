Return-Path: <netdev+bounces-157478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92608A0A63D
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 23:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616B51889D86
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 22:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9411D186E46;
	Sat, 11 Jan 2025 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U369lrPS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D970915383C
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736634662; cv=none; b=Snrrzr0yumuRNpco2VV+Wqd6geV35id7w71hFaZo2t5pITWSJo6MAe/s5Pe1lkTMfJsDxWb6nEj4TqhwsaF0LUu1GnQOee+1YF6cNbtltIZ7plylbiOJ0aGDp0fI4ZId0dVcJg/sJr+ArI0tFdlB3TA0V1llNK+7a7rwipPzFPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736634662; c=relaxed/simple;
	bh=sU2Tyl+fkQbQR6Sx5VJtHlGrVsLJdGqlJYakmbNCbqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0V2MfhjRb6EM5tY70xb/0DSw1po3QSxZTJD9MWptDtBZhOLb+RPiq7CNIk5pepJ6rbyqZCIAnTJrDR5+pihbT4If+pFIiG/cYeOD6UVGr1mZBDj8rpXum5foczdDTnUWFvzBdOUIXx4IuY9QFVd0CPUsoSw35KnxTuBU8Hd6pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U369lrPS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaec111762bso580416366b.2
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 14:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736634659; x=1737239459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vIkGXJLrrSJHjYhj+n3y+xYBjRSCeuI4HigBtwzeEXI=;
        b=U369lrPSoOF0Td0hz+qly2GT6Qcic3r8NTfTaZD2IYHPC0aWWmt13NlpC4P2PaLvx/
         vaaGoODGIeb9lac0Sr1DIlEqJ6xMeQcQjZrmFyH5772GBMWuRm5pVxk9lcYNcXi5UG5m
         LYzAY1zo2QT83aCJF0r7fWsOcfQWbjutR51s1ul2tVrlptR4dNozdL3kk+F6U7ZbBJD3
         h2YWo9Rka4bWVV3AmWTE8SgPnF7K5Z6VUJq3vyjoNK+uuR8h4yXDvIZ+Vvk8QOcho/IL
         xwNABbcUsd7mXYscnRcs7yxXw7/sFbN+mV/nRirsNxNlqcU53yxb6JxAW1dIMdtqDk30
         p9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736634659; x=1737239459;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIkGXJLrrSJHjYhj+n3y+xYBjRSCeuI4HigBtwzeEXI=;
        b=wNlNw3GbutsdsbqTA9krBM5O9DngXf83BQxP+0t6IXdapKpDjrB8dxAMT3bqDenzPE
         qWhaGNvsnoQeaYnuFNRy/aT5ayxtjQ6vcfhxT3OnJYAoh2MdA2JzxTSMnAuNDgIwH8Y5
         WH4qwWR/kQAUuP7QBvbaRPCcwzc7VG8CL+BYchg6EK1T/YjignbUscBNvwNTp50gou05
         vIU6yIhX5Mu15G5KdGxIPflfcr4slbZcS8p76rI8sm2f/lXk4Aw/TEdKXunoc3NxpWsD
         +vLYbxxViaFGSUuz3PoqfnKKCRWcqS/+y81Ofo9NHrfwy8kpqQrXPk8RyhlR8edHGcC9
         darg==
X-Forwarded-Encrypted: i=1; AJvYcCXPvf78sRuMbeDNHu5ke8KltETOieVhYlygVyJGhsn9ueikalcK1/Xm99OiiHtM6v+KnQdIUGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq+s9rgb7o3HNLYLVEPlEUYeyonFta1+HkamDHVha/pqoW0PpL
	0s0JBQp9tG88vFmzJqk6+xNfuzvvHOUTPbCz5Mvjr7/G6UgOAtRb
X-Gm-Gg: ASbGncvDp+2veGhPdzSTJt5//a7uxq6hVYoDAivh+DUppCo6XFeK8ArfGxsXHAp6dFt
	sQ5ptTqYFS1j9M9kbI0ndrNJhMxC4GijbRBU/WTmEomccwy4TVffBxruARoc3xhiQikkjERctHp
	jjm0Gc5EYJZWjd/rqHL+1fBjY7vQA6nAj8hMhDzwWOeewOY19JSbLfSpx0G8TKeBVXeU1Rp5X9P
	1UxRa9AGKgbn1kR2PkTEbaxUBS9Oh27xXb8VVB6mGOFoLCpJnUYg6wtEUAbn7SaH+tRmvHrSLWY
	oB4v4GglqYra155Pvfgp7Y7YEIT8L/XE5UYwl2ufxkUiPclI/jE5IWnpaTy0/fbY/onjRNEyzgQ
	bO1qMpHX4CcLQkMcZ03dUjPMQw4/7m4p53qUnu/i84q+31LbM
X-Google-Smtp-Source: AGHT+IEu9mfAzKPLvO0IDayYajXOXgz5uGBUGMxlO9FKZUVxOmjUDLcqTtpeALON4D3Q457G4n5BMw==
X-Received: by 2002:a17:907:3f95:b0:aae:b259:ef6c with SMTP id a640c23a62f3a-ab2aacfbb7cmr1508952266b.0.1736634658873;
        Sat, 11 Jan 2025 14:30:58 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c9564857sm315645766b.96.2025.01.11.14.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 14:30:57 -0800 (PST)
Message-ID: <10b72540-3642-4811-8691-9fbcc72d513d@gmail.com>
Date: Sat, 11 Jan 2025 23:30:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] net: phy: realtek: add hwmon support for
 temp sensor on RTL822x
To: Andrew Lunn <andrew@lunn.ch>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <7319d8f9-2d6f-4522-92e8-a8a4990042fb@gmail.com>
 <ad6bfe9f-6375-4a00-84b4-bfb38a21bd71@gmail.com>
 <0834047d-5eee-4d27-99c3-5f92460f78c3@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <0834047d-5eee-4d27-99c3-5f92460f78c3@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.01.2025 22:52, Andrew Lunn wrote:
>> +config REALTEK_PHY_HWMON
>> +	def_bool REALTEK_PHY && HWMON
>> +	depends on !(REALTEK_PHY=y && HWMON=m)
>> +	help
>> +	  Optional hwmon support for the temperature sensor
> 
> We frequently end up with build problems with HWMON. All the other
> PHYs use:
> 
>         depends on HWMON || HWMON=n
> 

The situation is different here. In the other cases HWMON is used from
the main source file. If HWMON=n, then the main source file can be
built as module or be built-in, and the stubs of the HWMON functions
are used.

In my case, if HWMON=n, I want REALTEK_PHY_HWMON to be n, because
then I omit building realtek_hwmon.c (see Makefile).

> We have not yet seen 0-day report issues with your earlier patchsets
> versions, but maybe we should keep it the same as all other PHYs? But
> maybe it is actually the same, if you apply De Morgan's Law?
> 
> 	Andrew

Heiner

