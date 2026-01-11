Return-Path: <netdev+bounces-248823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 042C9D0F311
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 15:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D85023058A34
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 14:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318B834A78B;
	Sun, 11 Jan 2026 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="K9ADx+2q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A879334A3CE
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142711; cv=none; b=KN9yYlzdscxR2p0C1uNroCMrHkREHYSo4xd0eraX4qsQFsMBBsioZeMz1rccLLtZT/plavA/6EbyVLyC/mKs51Db78PNIgZ6ayxOmSqQDis+VSj63kYasYBu67ADO5qtagCarcIgTQYd1ZDWJmf30dMseoR7r+pFn0eq+mNnCUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142711; c=relaxed/simple;
	bh=gDiL7diPPllfiqdrICUaz2pklt2cpfwEzlq/42pPJS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6sbWRdwMSl8OrPv4yOuwuAiioTyWvljLJrfT6sArFUjqFm+NcdQX5FE1q5625lvb46BMN3Vpd8+ozAUhvIJHckCiv4gOZUqZEepuKXo94M4waSauixIB5FKGEfXhF9BpQQ4BgBi9xQFI70gh7XzejlwUzYrP9O+NSQlRzl2Z1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=K9ADx+2q; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b870732cce2so64072766b.3
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 06:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142707; x=1768747507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bR5pMB9Z21CNTk1B6+opWEfUH+WjtdKh40K9u7GvYSs=;
        b=K9ADx+2q85hi1Y4+enhphqyqyZpZ50jBbUQejVQ9+lAyuPt1J7eUMJcsTH5Bdu91+/
         8uKGBqR2SSjJrxX/lCcEn9SiYTF/WVBgYkIGEyzvckX0wje75OhEfcmjaMUigKJwIZRs
         e06XzNxpm7i19SZ0LSNbNWyN8H9SmAT8nuB4Q15uT1Uv8OpT/U/AiGflgqftkaUx04wS
         FC9tKAq3ltBYaTZkCdn5SXY0EGMBHqbdzuQwDPZYYV0jMRzS64ApUPcVOjXPvySqbrOy
         U8+WS76PxjSbXLX1BI4gqBrNFoWcvXvKZgA6KNPOhcW9KOI4VzIXbxSQNQP75cdKv3IF
         4osQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142707; x=1768747507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bR5pMB9Z21CNTk1B6+opWEfUH+WjtdKh40K9u7GvYSs=;
        b=MezygrnMeQ+hN2hFSSfelZinXcDK+rXpltD1DTaYf3X9H8+t63HE92v2LiAjFAcyj0
         RbGuhBburs/BXaoKtEdNe3xAeoM8DpsHyBb7ovMCZG1wGgC5HR8exkYm5SiRKAuPfFUS
         1hJC4qqoNZ9dvlZYIZf2rXUNjj3EWryecXzMx6ayC32EbZtU+e+fpqTUX4o/oRL+Nikq
         h9zZJlqAMmUdphZ8UAOTNaBS2wOnWFezK1DQ3lOeDuH7zNQECgFpVBX5LQUShFzaC9gQ
         B/INELHMPDhDPHX65Fm+cJz/z8DakakP01o/nksFZiSU094i57wMFstAZyVBwcrKjZDi
         7+jg==
X-Forwarded-Encrypted: i=1; AJvYcCVTbkCT3knh7r0qCu3F1tuU+cDYlDPz7rQQP+/wlEOtHJczzYrRAvqNPdNYZotfaiiejbK1/iw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Ma29ZRRLT37kBywmyKx8HjxmW3e2JQB2cnIbGrhz7Bbd4Xw7
	9r7DgUb94cyXhP4mvco8k5vUTNEJcHF1b7re9LK4XtuOu28tsjaAemVmk4O0ww1zask=
X-Gm-Gg: AY/fxX6mN27odwNQRrR3qeOYcNnE5zKEGVXv6WhiFUdndX7xAkW0gZnnoKzINF8k3cW
	SBbq2r4IhpbPV9FT7OLXoyuHmF5V7x0pjOf8t+fSbpuGCHkEDJZJFEXu7jx14WvhM7Ipu/p5/cb
	VKYOaWW/W8lvA/3U8tkxrK8ioqME6628AT9T3WQ72wBG6eTNQqlrurtKo5SK9AwtH2TjqPQlQs3
	m2O2Z8NlNO2slmzA7kIO9J9TUXtBFSSSV3gqwCwlDRXDgDfR5D0PDmnTwVDLOncXWnMMIjQxgjU
	do9ycushiHg/NEATnQusdkgPL+oqFAxGz9XhILEc/Z66qmzNuczFfqmDacl1qtJozY0reaeDz/m
	5PMtWYHO3UaEZ0qe+4rQlhTs0DaZ+sH8NGXZOpT6rXSStqp7saNtDMlvetXbz9hpvMr6BMHlWGa
	RIj+1MgeTELUERGOGb4M4ZH4smI50dcycXAA==
X-Google-Smtp-Source: AGHT+IEnRprofKW6iUFW+aOMnt2p1AYruny/NjK8tSS/dtcvBYVRc/tCV4eudi2xBk8lGr0c6zLI/A==
X-Received: by 2002:a17:906:dc94:b0:b87:b87:cdbf with SMTP id a640c23a62f3a-b870b880077mr194416066b.53.1768142707046;
        Sun, 11 Jan 2026 06:45:07 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a235c0fsm1673227466b.9.2026.01.11.06.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:45:06 -0800 (PST)
Message-ID: <19f25a94-fc90-4298-b3ea-58bd66cad11d@tuxon.dev>
Date: Sun, 11 Jan 2026 16:45:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/15] dt-bindings: crypto: atmel,at91sam9g46-sha: add
 microchip,lan9691-sha
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
 <20251229184004.571837-9-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-9-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Document Microchip LAN969x SHA compatible.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>
> Acked-by: Conor Dooley<conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

