Return-Path: <netdev+bounces-248821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2437ED0F2A0
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 15:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98EC6300EE53
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 14:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ACD349AEE;
	Sun, 11 Jan 2026 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="isTsJ1t8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FDF34889F
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142660; cv=none; b=MkCaz6SAb5YRp4AipMw1Oxm7HR7sRPOuVQtZbdZPAPrDbKtIcfHGH9GpIhm4UTpAOSWgZLKXA8sU9omBQhM9oFrJZIDcQhctQhw6r8IYs9nyKmxAeUbQTcTrbNtYow7KTZeGlyrkh+eyvayoubElBydzsAPG8xETY9Cub6uqkeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142660; c=relaxed/simple;
	bh=w4Acm3yPEzhNfgXHej8RhBm1qF1q4y2VgssP/5Zk1hM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3JWS/DZXBW9SzfmiAaAUiBmhElrHp15ezr39SG24pHVi8GtW6LBJQzv4rKHNkkhQe62Uwm1cErmj1j97kto5snhmClZ2G3liFIbhDkEigk83nJR2jrhdsMEoIMNXRUbm+c3AzshXyeobAgJWWmv/QApO2TEBKGaO0KxQieWhCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=isTsJ1t8; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b72b495aa81so1072717666b.2
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 06:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142657; x=1768747457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vh0+NaFNSqUUr0lRvi0qh/0gFpaLfgRir9e/Vu9U7W4=;
        b=isTsJ1t8ThUdJlPcckoMxmOQN5p6f/iPi1Qz4+ymaOaMGg0HLRsEsqSZm3KEyOWwaR
         ZyJVvDBUIjMFYRKBQWAAqUA2E8lh2ITkmYgecHewN41dPFpOps4j1iduS0RDablFZa6b
         HpMQqEuK2qHm4wLB8ElCKvNNwpBajX3awNIIukUBvuu/LJEu1PULd34b1y6SP3deF3w/
         ntQWAuPAxbyU1xlmVWz0zMWNGEeFBHz89/gZfq4/2h+F0xF4+AreQNuoFSvgXYEv2bpu
         Oy7HVBxdxvC5W0dQ4KZbQxmbi94FjFBo9OMaPT1Trz8YzH8aDwWO3B6X+slFxjvyAKcG
         eCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142657; x=1768747457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vh0+NaFNSqUUr0lRvi0qh/0gFpaLfgRir9e/Vu9U7W4=;
        b=PF8snN9N0eKP1HGzDGewD6wXT7UcoUB4wJhFbnzU3089dvA571coqcT8Ed7JXF9CEq
         aZaro2STS4U2gkGS7uSGeoe6ML2nPndzJtxD321UPuKO87veg2r6JuRyLmYUm5S4u/V3
         s7NrVIpL5i8+/XrXFh4bvL6Niiycw1aVQ2d4HxCdtL69XwvK5JG0rNaG82v1Mcn9Az5a
         z//DugZicwYqgI8svYc4t11aEetcleQExjkJohnAiFf3RZQs5IMnWupejeNRDc3WW1Ks
         yMvdx5QNJWBgUplqzuAUytgmqazTDIdfZ0EabGD8BOucg2M0jtOKPaHveyZ5WUDoGX70
         eygw==
X-Forwarded-Encrypted: i=1; AJvYcCW+r6ewQoQ4F0mfF0Gh6dNEOo5+GONgB/b1V4LDuZtMYqBxu1YmLSDnVYi9lxf6WiLToTcbMZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYlna+f+bY3vjA7EceBrAovCh1u3eFUgGT6kMStDQ/7vjs68lG
	ZpnwpIeD8qyUG00vURck05cZ9aBxY7nLioUwFry6K6vgPdLY2i4xbbURZiSCNfFEy1Y=
X-Gm-Gg: AY/fxX5UQjuAxXmKiMQbyBwp6CJ9F1WE8QmItI3M0C2RUXcQgsi9QQ5R/hIuKpgs82a
	NG8YdzSPZWAbWGsPb6YSCpzdMfqhQspwIkDKqP6kmJ6FUcrqGzMYcsfQIirgZUQtm3xLbTxBVpa
	YmyGUzRiOR2ESE7KqtN9j4Cx5pISXamreCYt8trSinQvI0wuIuRSiJJQXbdwPF9j20Nh6hmb3BW
	hSy4FkXpLL5rqQlhj5goHYQh4ndChcnqUKzlFqK2hiOdW6YYED4EKfYooJFipCaPGEToG5LK6RF
	QkI8M/C2io9GJRQ1iFeq+Qew7XSKsEscxB96+rtyljo2wE2KojE/O2zZCYATS1Hq9vtk6MTNoRC
	y9E7x3yZlFkEj0yaI3s8qmPudtEnftmv/zj06K8TwJNWI48F1qkqBj1IenxN1kaQsIAPMoFk7EC
	I7MdbUH1SBotkto62PqFljHrI=
X-Google-Smtp-Source: AGHT+IGSkgRdvFAJszoEIUVPnmxFKxpG81LZeaQDTCtjgK8/9NBkGo4UJCrHj8/qs3u8e7/Yxpu5vQ==
X-Received: by 2002:a17:907:96a1:b0:b80:6ddc:7dcd with SMTP id a640c23a62f3a-b84453a123amr1485279866b.31.1768142656775;
        Sun, 11 Jan 2026 06:44:16 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4d3831sm1727347466b.44.2026.01.11.06.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:44:16 -0800 (PST)
Message-ID: <bb0c473d-0a86-407b-9c4b-9a39f9985ab9@tuxon.dev>
Date: Sun, 11 Jan 2026 16:44:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/15] dt-bindings: serial: atmel,at91-usart: add
 microchip,lan9691-usart
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
 <20251229184004.571837-4-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-4-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Document Microchip LAN969x USART compatible.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>
> Acked-by: Conor Dooley<conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

