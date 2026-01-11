Return-Path: <netdev+bounces-248816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EFED0F0B8
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 15:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FCE930155E3
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 14:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0218E33F8C5;
	Sun, 11 Jan 2026 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="A5h3J93L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F412833DEF7
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768140343; cv=none; b=UzrNJRkFBfxeRKA2gm7jv9sHehXmzBzsXIhjHvKZGXPETcmXxfjkNA/8ZueEgN7eN4td7KI3rm+Aw012QJ1xTSiLgUlZ05n9hvb1zh3DjVCJhWXYWi2p3bFWUsV+Idq22ofcurTRehKnetKEgwKPIJQObDeS9IFL7vUgQqeZUmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768140343; c=relaxed/simple;
	bh=La7kZA2oSwRqBuL7cT5ghruILrR4PN0GG8fEmUQohxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwUX4v2sPZAh7448fKBe7l4eVISnrodM/R/PfqDLd7cqFQnyjgFBwbvfFD2CxIHdeyGPi+Adp4lg3dMK9pOSrnEGIKOkS+94rHf7OZtHhshez8Dh0e97HKn/TYDr32bz8OZOSVrDcB5To9J1kkOeCsXLbvlWMik9V2VRZWTJp+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=A5h3J93L; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7ce5d6627dso1223472666b.2
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 06:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768140340; x=1768745140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXunsOKck5NLaqPP1pj13fhYNQN15zYs+l2jwEoFO8U=;
        b=A5h3J93LIBKbImOKSk/PuMD1cA9Z5C6EZEowbXbuQQWRqoIAibYcsoDlQw3TBJfR+T
         u0BiOjCEJXktgpsZjOdLv3j4NKLAL6vWzf02hINhGw9gtNLdyMqKWd3DOyEcZSvo3jYX
         8ZK4HrP0vXDrFAoG6NVNSCZ3YaSVLqWlNr0VD2t95cLlw4Jh61dPCSWNeQ6oulesS2tN
         wj79fRG7ILgJ3A7li2jIzTbZtZZjrXs2jKlLHtMo0WNwEe++CfnFmumACmX2K4HiMsrY
         hZYR2bZ1STtKcGYBa3SuMqw2+bwsgdTMBUMyBFpULbdi1sES9VrFIvs1UBE/wqWbzzwP
         APAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768140340; x=1768745140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXunsOKck5NLaqPP1pj13fhYNQN15zYs+l2jwEoFO8U=;
        b=MsEaaFZjRaS0N8ba1RAveSt1ahwR91Ju5tfU0gz7w8igC/ASoG1LtIPbcy6T6mXONm
         jEa6SHwWJ0ZtZWHxvIaJFzoc6Sj9mrj6Xb6Jyf5n9Ckp92gKsm8vm2bifrgi8jJS18Kf
         quqWSrgytiO3fcODhMRejKxLtrIan/g36ujUwpnUSI03JDUpiuNhNrVwwah4jEKu/JD4
         DxjOeNMFr7xA7vJBYRW95CqbBL3hFNBqaPmSl0ErCf18pO2sC6KQc39dPZTLglEP+PgF
         QvTI0lFxEUzRFqvwuSegrATHA3t4t2GOwEXA6GiUxz5z/q01u8MKVgHDpLhClgLE899F
         /Kpg==
X-Forwarded-Encrypted: i=1; AJvYcCVmDKIZ1V6soLBNIT7yxGwFA3e1G2mf1jwnpvHIlRcwjOFXVjdcp4jHR0mJHrOkfTUQS4PUkzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/J/LLW5FJEfrFRaUhaIJDiJGpT8YimgkFTw0ZQfCQCMQs7m7u
	DrbIF09PIYBGK5OHRttl8YTVTjK964ryxcByBlKhkmwwd2D/Im1PcBOFm37bfBiTgW8=
X-Gm-Gg: AY/fxX6UsE0YKr+NBI2yWUxmYy3kjoLaTr3J+xOVG1hJzMP20KUQPW5Zyi3HhmQFFtt
	a+iIAFq9+ohLLAIjowTd+NLoahde3PdPuriObIb3OrdQQ2lZSTgqkGAWkftm+Qt9ZnhRBvzyzUh
	WK7P/yIb0PpQd9t6MJuED/M0+jBpoJd4wq1H8jF1O6F7qowWjLWAwOQMrHL6OBRc2Vv0wQojSGT
	8iWJPjA75hYPFizhvmE8leXcSddOHe6djFokqJ46ZvQd1HCqAcsfXLamKZMNzrVA1P4+DpRUFhp
	0DVNhBeLFj2adQ7hMV9PPCu4SD2/6Ts5i+6WYnwA69NGjHNABFF1s1mZG7YkfUwGm1+5epezJ2Y
	+QiJNjkseg66cPhMRnEF+8JUmwUTqie87Wi6UZFJ0NHfeXjXu3tpnz2pj5jnfLodwLTt7NzhF78
	G4DFS6ssYFckwuCtFMUMOPv/4OMqYG1Ztd3g==
X-Google-Smtp-Source: AGHT+IGAomJOik8MqjiZHm7eirNShLlujIRGUrfTNhxgz3sez9ZGd+euk5Raj7DyHYRFF75x4SXADw==
X-Received: by 2002:a17:907:3fa1:b0:b87:908:9aca with SMTP id a640c23a62f3a-b870908b37bmr200612566b.9.1768140340256;
        Sun, 11 Jan 2026 06:05:40 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86f1e95273sm439916866b.62.2026.01.11.06.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:05:39 -0800 (PST)
Message-ID: <05184245-9767-45ef-a4a6-d221f90fd20b@tuxon.dev>
Date: Sun, 11 Jan 2026 16:05:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] arm64: dts: microchip: add LAN969x support
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
Cc: luka.perkov@sartura.hr
References: <20251229184004.571837-1-robert.marko@sartura.hr>
 <20251229184004.571837-14-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-14-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Add support for Microchip LAN969x switch SoC series by adding the SoC DTSI.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

