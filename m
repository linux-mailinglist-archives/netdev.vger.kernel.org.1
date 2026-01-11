Return-Path: <netdev+bounces-248822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D03A8D0F2D6
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 15:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED4D53046FAF
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 14:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53846349B0E;
	Sun, 11 Jan 2026 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ookWjjOm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC864346AE3
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142689; cv=none; b=U/8iwdSXgVka0AmltFYxrwRFqnmDDiLQbTO4lPTfjo8n4eUIxbjJAE7z44hZLXKyLfVn3UTDVI7Z2n+lLch8GZ3CoQNqJjtf3lxmhp3m45Lk6elrjKk99H0G4fMpaOA7fhNidSTlvknlcWege7wl7OvBBKOlUmnmyeMBNwX7Dj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142689; c=relaxed/simple;
	bh=6nDyEm7V4aXX61sF6eUN6LhYpH2LhvalQYGjX/umKoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8HmbMRggV0IxuzWpjjOZTL86bdkZG+qW2ol8UnZfIYU7lFCuCmkl/zosBeJDZqEP2c+H2cqA1MC9vriSElR3LuVVqeh+olNQVgUu5+agzH6u351t68vBdJ7QuggssjFAL6wGx4WXT4FLOvtnNG2LY5VTJ8lN+KXsIGARwnjAGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ookWjjOm; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6505cbe47d8so9042167a12.1
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 06:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142685; x=1768747485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j5bvCXfrw0wJAyvC451z7sPKX85y6guKkf78mDKwHw0=;
        b=ookWjjOmWIYoGV8NQWvwlqznn4j8X/9cIu1N+sDUGIRZyYgwPku/XDBbuWd6K70V+Z
         P7HY/w/F6flzBr5IXDYHVEB3ltopxlY2WHQAhLaOCeZR/Hrc1OWjU/V0asR/RmmmcEc3
         tbjCh+t/BspEkplUHtFz+y05jDP3wSvjg3CpDLl8Q1Bh5+kq3Y2fFlpvC/a4tjSPRZgV
         /s9DK4NFB7cEl6zQXNMcpwOkQ/LYani5uYAJvLM+ZJjDPhc1ZKQqnqz5mjqsBNhxaSmo
         d4j1Vc6VbI8lJrz1ATl82rXlA+iKCYIQCQ//J+lmO8a7bTRC9QTjtYFdAUSJ22DHDbQg
         LgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142685; x=1768747485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5bvCXfrw0wJAyvC451z7sPKX85y6guKkf78mDKwHw0=;
        b=i4LdtpXh6FC5V7sTau2auGgqi5qC5PUiTAoKr7Ca4d1uuhU79Y0urFXfQLyNkNpzHt
         OotWqOlE1cTBTn9uNb8jXvbyQT1Fpbs+hzQ/Oa3/AOWUEgKFoI/mQbLfZ/in4nlsinDt
         y3epBkJaZtp0SHUOBeGfVIxne4ZIpdKx6qQ2fdgswmxRByeCdvbH+Mf9Wofo2QHi9jTD
         Iz9j88a6z0+MlGzD4C+JkX1gvEIeJUdc3RlGIThyc8HbqhqUNZO5NTx5+BEIn/4PzGnb
         r0c5wAKa2BZI5q/64Dw83cNsZFmJNu1uRCVbTHWRq9G4Fo0kA7vk1FdHMFTm5Cm2UuGD
         G/nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIeAwHJdvIbVZaDHY6UaBMDE0fAhEmYlRhyyfWeyX6FerblXBmRHFrIRsI7GZtFs+kpe7YSlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwjY/NXg/wl6iSD9ZpvIqhONSYihddFePYlDa9xStCgj8Ac9KH
	ASApJo0cdrt/pZqOJViCDkqtv13CiXUP6PzBhuZ3J6w8qTZ/Cad0/n7jBPuwJVNvvJs=
X-Gm-Gg: AY/fxX5KIekIVv7lLpq43AeDnsEzgK+4UbvETolfgmZwR0G4lco+QCJ6wcGq0SFJfS6
	CT6L95bFwQ/rGo88bO+S+sM2RDvgJYtnnG7kb8a9it3xJn99eUtj/UTs1ZTgfePMo7v0cNlpuLi
	gqsGvhFRsEelGyw+Ehhk9sOm27VhKvSUxKb7WNaaEfHKh4ekvmuRp3quNnMURazxF2w2XiTmrO2
	u5yUZBmT3lNiw0Kg/isaRq5OOoloaHD6wRm6Rioxwg80rJqSLmf2r2cgCru/ds6Uo9XL83tJ0Ne
	seth1U87avLgrT62DFWNqyo6U2xtoD8fWH+eKbnV4PkFM8y3sCir79RJyMorg3AdIr30aakI/VL
	Mjrb31M/Zx38Y2pXCCq8vo8Vy3ztygd/2DB9+ZFOrfCZfyOuBI5uAehuC9VAfzZ363mlWw2yYhn
	ocqjMWD2GR85sDJURCZmfhjaE=
X-Google-Smtp-Source: AGHT+IHGUu5OYQ17yt0Sks10puH6ECXvHmROUNTsHAGUEt843jNznhl0Fa7GBLD0pgo1znXFARhYGw==
X-Received: by 2002:a05:6402:146d:b0:64b:4540:6edb with SMTP id 4fb4d7f45d1cf-65097e4ce77mr13908239a12.22.1768142685334;
        Sun, 11 Jan 2026 06:44:45 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d44bfsm15272072a12.8.2026.01.11.06.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:44:44 -0800 (PST)
Message-ID: <ff941a66-cc09-4f57-a511-d253f48d7137@tuxon.dev>
Date: Sun, 11 Jan 2026 16:44:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/15] dt-bindings: crypto: atmel,at91sam9g46-aes: add
 microchip,lan9691-aes
To: Robert Marko <robert.marko@sartura.hr>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, vkoul@kernel.org, andi.shyti@kernel.org,
 lee@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linusw@kernel.org, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 olivia@selenic.com, radu_nicolae.pirea@upb.ro, richard.genoud@bootlin.com,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.org,
 lars.povlsen@microchip.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
Cc: luka.perkov@sartura.hr, Conor Dooley <conor.dooley@microchip.com>
References: <20251229184004.571837-1-robert.marko@sartura.hr>
 <20251229184004.571837-8-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-8-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Document Microchip LAN969x AES compatible.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>
> Acked-by: Conor Dooley<conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

