Return-Path: <netdev+bounces-186315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE00A9E359
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 15:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C60189AA38
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 13:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0713D14885D;
	Sun, 27 Apr 2025 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NoabVIaX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535F32AE89
	for <netdev@vger.kernel.org>; Sun, 27 Apr 2025 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745761400; cv=none; b=Nca+DcQGhOZxtleThvcZ4SYAgMipPTGh46AkjzZk40D4LAgsayqBG1vziIR7uxZz7fAFlbHjald9AFzxnqhgXwr5y5A/dyR6SGVJzgX3Euqf+g2BfguZdqnhI8PaYizB/N15WuwxoRCahnbggYcdSBbhC49VnAAXQnVg2ECPCdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745761400; c=relaxed/simple;
	bh=REZ0z+XUzHW/ptwizPeESYAMDlgEamrUX13FRsJPeO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u53ey1eCYF5IJViGB6853GWqa96pug0aZQZmtBQ4lcyzlyCu1Ixn7zbaEVmhZpVKM2VqqzXbVexpNX5qHV+XSoVETjjBgCAr/3lDB6u6CKJ7hzB/wdhUffP8bK09pbkF+qTu5MN2qUu/xTC4DElcp//rBHPC7Jp0HlMaqtnem2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NoabVIaX; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac289147833so681962666b.2
        for <netdev@vger.kernel.org>; Sun, 27 Apr 2025 06:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745761398; x=1746366198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z4+/5/aJ00yUVo743NQIajtPIPLeDpfyWDZMv+sSR0I=;
        b=NoabVIaX/mUUlaXpXXTOxHW6OsMQf+NouNsY2/GwxWZZc7hbDnucB1DuatPnBJOd0d
         9OoFs3OsZ91n2tha3E2YCuPptq8Jyk2UEw1WMbKqC83T2Qu892v4cM0fp6qAYmg5M6Jx
         DwsvuZHqU7g5YgDsahiu2W6zWrSNnqyQJld2YX6ZvxtqfbHA+yia2MO64fvTskKmewR2
         /AFZ3kOUW1MqFQnXh6AsceEU9zw1xCgif0yiZm358IFJI/pr973HF8tpPh5RipoeUUbq
         nbLVhTDdlar8DW5KnzhYjVLJX9bw5ZDLCP/tJAJ/3ooonWLot2QSazFRKGAduaI364J3
         1QHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745761398; x=1746366198;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z4+/5/aJ00yUVo743NQIajtPIPLeDpfyWDZMv+sSR0I=;
        b=LlHs3ZH1whQjvbu7dh3kOvtK08C+GkbW436PegNI36dYqt3QrjZUhdlSeExx+TPJ6Q
         55QjJ0DpyGHiP/tgsF9jdgCk9jIOLPe83dzJrQFPLZgFQXo2uLvjvCgShYoms+I9elaA
         oHJWh2oChXS+70k/b6adPlVOf1ZQcc4iwZq2KRC9rGYT9f/yevE7RsxnHgz+pgsF9FjX
         0Dohw/gdQ9QFze9fuO0EZ1MeLCmKxj74CJmsTcfjB2f+tAK+wjAUgImcFLM8LkyUnXVR
         mrFnY5+J9RckzuqbuFUG1NRJSyHqv7dp+Wvk0/Cs+yvPPKGo4iwKzxwHMkEQ9n2L3x8I
         Jm9w==
X-Forwarded-Encrypted: i=1; AJvYcCUTDA1EQ364joNZ0fR7kr+BocKvYD7IoRUzr7m/g0s0BPMxdhmrl2Pppybvz77I0WsYUx8OUzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw96yd8+Te/pkmnXERzK6QqH+/iR7tz1kF9v1lW7kcbbbd37yml
	lyI+0FsZhRmA2078N16qDItuqZ85ZnrnRwFkOgDzQ6Ppr+7XEytpsazltQVTxTc=
X-Gm-Gg: ASbGncsB/F0Cu3VoYB0oEoHmF7NNEk15kycRGj3iPGhX3Rbo+iONDPM7i7mqtVz7ooP
	jasmyTd0m8xgVRJKnVzrUindSbz+09KmanWFPYx03VEYZd550c/xQ5g9TVAVXcL6z00jLBr5Pks
	0Vy6YVYdhyyHs6tCVUU0dYmHEfRt/4yZAFEQvfz3uyAs/d0eVzVsfU2U6CbaK8bEekcZww7phFP
	Q5zSb/CyY74CADOuSZAJSpc3VFGLyOt43M0N00c9KUO1PLqGgz9eJCwP9/xfo7ZVWW12WdAO3DE
	bCGBtA6ibyoGDJFV0J1Wdx8XQ6E0l/zaEZdLC7hX/00tJHyW/a3V8vaZCCK/
X-Google-Smtp-Source: AGHT+IGRwUVwOyuzymMCwS+0qn15iMV9FUUdCVvXLMQI1GdB2QpaBU0EsMQ7nsFAnRwnHK8jvuB1mg==
X-Received: by 2002:a17:906:1548:b0:ace:3f00:25f5 with SMTP id a640c23a62f3a-ace848c23f1mr395019466b.2.1745761397537;
        Sun, 27 Apr 2025 06:43:17 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ecf82f9sm442101266b.88.2025.04.27.06.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Apr 2025 06:43:16 -0700 (PDT)
Message-ID: <33e56253-32ee-4eff-a7cd-fcf91ca4f37a@tuxon.dev>
Date: Sun, 27 Apr 2025 16:43:15 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] ARM: dts: microchip: sama7d65: Add MCP16502 to
 sama7d65 curiosity
To: Ryan.Wanner@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, onor+dt@kernel.org, alexandre.belloni@bootlin.com
Cc: Nicolas.Ferre@microchip.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1743523114.git.Ryan.Wanner@microchip.com>
 <60f6b7764227bb42c74404e8ca1388477183b7b5.1743523114.git.Ryan.Wanner@microchip.com>
 <6e52883b-2811-4ac2-9763-5974ca463274@tuxon.dev>
 <af92ffff-f900-4f29-8d26-2516a3c91805@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <af92ffff-f900-4f29-8d26-2516a3c91805@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 14.04.2025 18:38, Ryan.Wanner@microchip.com wrote:
>>> +                     vldo2: LDO2 {
>>> +                             regulator-name = "LDO2";
>>> +                             regulator-min-microvolt = <1200000>;
>>> +                             regulator-max-microvolt = <3700000>;
>>> +
>>> +                             regulator-state-standby {
>>> +                                     regulator-suspend-microvolt = <1800000>;
>> I can't find the schematics for this board. Is there a reason for keeping
>> this @1.8V in suspend?
> Sorry this was an error on my part, there is no reason to have this
> @1.8V in suspend mode.

OK, I'll drop it while applying, thank you!

