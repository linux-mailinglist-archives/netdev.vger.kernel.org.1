Return-Path: <netdev+bounces-248825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8B3D0F2EA
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 15:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A67F3033FBA
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 14:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E1834A765;
	Sun, 11 Jan 2026 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="g58+wShN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC6A3491C9
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142744; cv=none; b=cVzcsSRoLUO/etTBh6N6FhvtsSEqkVizY4bjY4HEJn6RcxwUODrGbc4z4mFlaZY6heUtz1gsMklKrRqrfxmwMs+kJuLQlTEPLNG8CQxrz0JIF8mLWaBXAYVbsaDp0DVaAvAsyOeZ8F79lZFe2vDyDfwJmHT8HX2uYbG4e84sc8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142744; c=relaxed/simple;
	bh=8+o9CrQDP9rR7vhYrkmBD4TEK1Ah1Um118V33OBjIn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cvm9QT8QFNqfK61QhH0cf5WYyI3UewY+UPgjslpazPxFCdhoF9BeKjGviBSLcb/CB9o/IQjJm5kuMEOGrYphqejnrbMCCsPexerVNemr8uEx51UVUR4H6UVvA78tHIXWTQTXZL6ksJUyiWIluQNCmGgg4fVWc3LiT0Batu9yfIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=g58+wShN; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64b608ffca7so8692928a12.3
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 06:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142741; x=1768747541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lfDtjbPnZQpFER+nbClQWcn44IBaDvTgM6H9iNz+Pz0=;
        b=g58+wShNUGm4cSq/cIFs5BcjtBtziWlVwOnRIYJ0JBVThU79/8vxkDEUyOzt7AzJBB
         cTZ9e0Q9nDikPkEBLmzCCkAYBMC9A64/OO6AU4Ed+EOGygTBTQEKuknv7Bvpc0Hq4pfW
         tWuCEazhna5tzsEGgmV/QS1mDV7AI8F7irWQCIvLFAdd6UBceXKAjkUon+m8Sp9IuWPs
         p2XYZJYaezhBjl4awlNqxLX5lYDftU2jHR0SSz7JmKdP4CM//mkBYchNBUXZFooCPe+6
         dp21GWl3JMqXh5qWiJlPzG2nBfXylKpA9kssFDHJxDnXDPKiHgK0Z6Kpaw+F7SivT7OY
         h9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142741; x=1768747541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfDtjbPnZQpFER+nbClQWcn44IBaDvTgM6H9iNz+Pz0=;
        b=F0iF3jMCP7kEgParum5Zg9jPee5xZJn7sFuJ9p3wop+bfvRkuIuSvYSNctAP12Doxf
         wMNFKqoL9K65XONYtAPItXsB5srmGLZta2xnGrPJWwn/4ZFZMt9/8udqLWaewC1wCRAg
         nkoTt6XB+pFHYZlGPGokCVDWS1uFGNlsamoovmxjHPPDelL1eCBUNuoX3MZsD8i6MobA
         QgyARBLrlv/5Bc2Yjo4Vw5VumZVf82XV+079hzJcF/lxjFjvZCpmQiuFDbnuHnuytqky
         TZJt52nuyKaR4YXKf1jK6pxKNz+ArAT88W6cPmBUs/TkTjdOAls3NYqbc8rWAbeRFqcF
         OvcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW8/Tb+JDRht1Ai/6UZMgBqOH0VYCxC68E0dSm+rdZgm9Flkf3ED6+8x9vpv6aMqD0uJpycRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTLsDnHd1X5oF1KkW80wawzYvkw3ZYa40eu9BdBaks0MCVgL1x
	vMhZ33/YGm/5nNu0DdyL0lFEBDfRZz9VAaMA/99cP3bYkWF8inOyQ9eRf7444oCqjjE=
X-Gm-Gg: AY/fxX6YSj8cO6rdKEOb9elZ1m8UmCunFwQpfM93VHLxDxnqygadQIB8dIDECjqbnWO
	l46mq7QXahF4NMG32CqXupaArWg2in/mda8UX7RyHDgflLDkjLHIJXt4UFNVTwAqzxTFGjewjKw
	S3nh7JFZ2HsocV9VKw8WnnnSPvKjfHMQqySZA6yN6GookNpVaUQVso/ssZOESJMndeMTMVywDb3
	/74AYMPQbOgrxyn5ZbOEtTp7Wxee7bJ+2Suxkbxb0yoX1931DYicFrgOJfjfUFUjLD/Ahkf91IM
	JG7EFOpLbc/hLE0v53d44EtE9V5JXjhYkZxhnQMyXYlmmM5DZswQ642oCM5/yQm0QwO+mmrzfiK
	Ziz5lplJcMZZx4KZy7ddRo0Y/eZh3zzfY2x2y9oAdA56CVgu9ARzSgvUooMWVruwAj0kCEdThuR
	bD9Z1don+Wcw+AOVaZ60nw/FE=
X-Google-Smtp-Source: AGHT+IGzzRSG9JPiSsYLBto386guzGNBLdjrzZm8+JQDEKUQ0tWs5J3FidjE880cd/bBYxLZJrvW2A==
X-Received: by 2002:a17:907:9455:b0:b3b:5fe6:577a with SMTP id a640c23a62f3a-b8445169517mr1585237766b.8.1768142741298;
        Sun, 11 Jan 2026 06:45:41 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8706c2604bsm260020066b.16.2026.01.11.06.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:45:40 -0800 (PST)
Message-ID: <555883af-66da-43a0-a4d6-bd3bc52581b6@tuxon.dev>
Date: Sun, 11 Jan 2026 16:45:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] dt-bindings: net: mscc-miim: add
 microchip,lan9691-miim
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
 <20251229184004.571837-11-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-11-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Document Microchip LAN969x MIIM compatible.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>
> Acked-by: Conor Dooley<conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

