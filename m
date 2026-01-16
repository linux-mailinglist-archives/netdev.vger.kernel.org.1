Return-Path: <netdev+bounces-250458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD995D2D19A
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 08:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44C38300FED4
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 07:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455A031A046;
	Fri, 16 Jan 2026 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="DOz03dJJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817EE30B52E
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 07:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768548144; cv=none; b=hINkm7dwdvj8Uvs+vcmyA57rXkzJXt46gd3UYb9uGh4Ty3fiwTzKjlI0j8a99o5ZWguux/+zY74kGkJ27qzMZwh3BYmxWELIVWW2mwp5lfOEQjQa4DACt/YXSxL9XGezTir2u5zCo1PZ+oQI+IGtA9AAzJJ9tpY4cORK47cruuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768548144; c=relaxed/simple;
	bh=ZoZCxIZIxuNG7iiq7ouEpN8AOaGaswIYZVOM5BEKY0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwDk8AkHLOOuykulfFO5fr3wJc6mjZxZjx7ygecI9XvNVFpulSLNndPkHSlauElE3fjEaEd4jP/PLm3h2OnW1+6ZhDF9PtZA+PGP/BQ/N3cT0WhbCzLENaIEAZgR6H7alzlM6M5uFNCoMOS0wGbflu5LdqgzQgFyGpcSbXVlMco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=DOz03dJJ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-432755545fcso1010962f8f.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 23:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768548141; x=1769152941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W95GN1V+oZI3tCyhJrWoqvfYp2X9bfUg8CvoDb5FSAs=;
        b=DOz03dJJJrHhANTzRWfRIwG4CLx0lVlmsIjqaVXIAMhwfUkQMzxluDIvnt6G5tZvZr
         4c0dlJQT35H7vKeQ2kACS7kFyjHOCBRMDhEqHMGjvAHO3J/KXmEMGQKVzcuA8Tkh5u4v
         iSdLnjY0HoFbhIx7+jU9y4jcsGD5y9+L4A9Rbbfwe9Oajkr9Uy/QAO6wftMa4FTKMWiv
         Xr2onvXDgcKQNOVRRMi3T/uSAL+HyazSQJuk5cqWgDP+C85At8mPoVxlZUnJY2INJNn6
         NZOLFZwP31nUoRTSEM/hLvbT2rEi9re57qBnGAEmHczkC9DApHPsTcrZS0p+KjQiDy4r
         ffNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768548141; x=1769152941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W95GN1V+oZI3tCyhJrWoqvfYp2X9bfUg8CvoDb5FSAs=;
        b=mjlPrqhBuaiJ2hJ+YPOotYFh0aKZ1eib+Qm/w7LvzZvGdC+auzNAJAqVpVU6PffqbH
         sSEndDCvJWO8IFaM6tEeOuTLAIyderRaa2XbaBUD3i64xZU9Z8ufs61oYV1Tn3nCSNol
         zVMBJUuAoJ8YUiyn1MlzrcjUGbqGX+7wIVDU/7fZAuYv0M3cupBS3tRu7dzaJ2cyXfM9
         qMho5P03qb37pxPfDZc+T7NN5KwluGgh7cV1W0MU5/Jou9TjhAoLtdP5iCDO06WIly8x
         yGh4dSToGEzsKtn0CxIJM239ARsxfdf4Hbz0/hEUCMxsYsCuooC6HjoJxv3EBHU4vskp
         qwKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1ytWohEp3Q1t/W3MCLPdDnBZ7NxKi1W2+4Qx/ce7Y1r6pR4Qd5ek2Tz80Zz6CMQ7RBnT4nT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsNisM1/XDcdJ2cvuDKXILWtGbSe6Sa+Z9J7kCdWXoW9UNcvQ/
	ec0aoAYvSt0NoSza83IRuzVsiWz20zgGFQL2XGZbopmPas3FktJ/3juTfEXTaRul7QU=
X-Gm-Gg: AY/fxX7youo8zNGDhGcLwpbUiXb7HuxMJER8xZi1iS5kN797SYJMBJpHIsFLuy67PcV
	n6bMxwGDARF4E4RpHU9ZvT4uTmejo/MMj2wTANPLvBRQknziCQePP9QmiHXHbCYlfKJPsIZlhMO
	lNADpx3K/izyA+6AnOpPttxNna/Aqc3tSDCeTI0OcQIwnKZgJfab1kNPytl3UNbYOKzzRd0sebH
	C6/sEXHu+9RmOfjU3UwrrTgSso3EXfa3sKjIonYFk3ViUe6h1rwNY5/f75AP0wzCm4f4+I/B+Ah
	wZiXkCtDaev2I2eflcfatUxlRPMnG2dTCoJy0QdlBU1NfGGNv//FF2zrmtEA8eZKgA+8/iOc284
	bND9nAa2YDUtuCQeLIuTUU9cPIvJJnIXDR8x9x83CTSjFpv5IsiIIs7WQqqt60Pe+rG2E8Jje7H
	RooSfdL0vboy3FA5a+mw==
X-Received: by 2002:a5d:5d81:0:b0:431:752:672b with SMTP id ffacd0b85a97d-4356998a823mr1864994f8f.14.1768548140696;
        Thu, 15 Jan 2026 23:22:20 -0800 (PST)
Received: from [10.31.13.216] ([82.77.28.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699982aasm3496749f8f.42.2026.01.15.23.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 23:22:20 -0800 (PST)
Message-ID: <40b636b3-b1d3-4c67-bbfd-6f41a5b0b290@tuxon.dev>
Date: Fri, 16 Jan 2026 09:22:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/11] arm64: dts: microchip: add LAN969x clock header
 file
To: Robert Marko <robert.marko@sartura.hr>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, lee@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 UNGLinuxDriver@microchip.com, linusw@kernel.org, olivia@selenic.com,
 richard.genoud@bootlin.com, radu_nicolae.pirea@upb.ro,
 gregkh@linuxfoundation.org, richardcochran@gmail.com,
 horatiu.vultur@microchip.com, Ryan.Wanner@microchip.com,
 tudor.ambarus@linaro.org, kavyasree.kotagiri@microchip.com,
 lars.povlsen@microchip.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr
References: <20260115114021.111324-1-robert.marko@sartura.hr>
 <20260115114021.111324-8-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260115114021.111324-8-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/15/26 13:37, Robert Marko wrote:
> LAN969x uses hardware clock indexes, so document theses in a header to make
> them humanly readable.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>


