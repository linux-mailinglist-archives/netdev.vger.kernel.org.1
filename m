Return-Path: <netdev+bounces-77385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F28BA87182F
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 09:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924F81F2232C
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 08:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5C17F474;
	Tue,  5 Mar 2024 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+iMs/Bv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522ECF9EB;
	Tue,  5 Mar 2024 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709627058; cv=none; b=Mbh82J9/+9pjDUJqzQQ4gt7uP7yOhFxQp1hGV5p8R/8mr23RAGkYCiH1NrrHIBYg3iJIyHifwejCDjb8T4sBP56fuF3gK8nHC+m2VRibkTbWl6iL3NwzdTRqfza6avuczryK8Ja8NQd5TPR271PFn/5aGOBYZ04beXjjH7vugaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709627058; c=relaxed/simple;
	bh=O7Y7q2oAk9k2IlcLywJmATxtkwXruEwwxr3rt5LH4mQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0YoWDf2VOLmZKy+rcYQfp1i1zb/E2q1VOx7040/BpXkmbxMWXBa5gRRg5iJ3cg58qMT2qUMWAjXY0a+dmz+axUsHV6xUmugI118h1suZKEMnYvnMPzZFrmuexvoHE8jJYX7/A4ZJR9nPZQshzWuhzmOybq/Ug6YeH+FUWSiAA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+iMs/Bv; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4532f84144so241916566b.3;
        Tue, 05 Mar 2024 00:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709627056; x=1710231856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pZnJxW6Wv6ACuYx0jG7D7zRptFSvhxbtlXcoFteFtbQ=;
        b=E+iMs/BvQ9htx0NDoAvk1hYYMby+NGaKU52JTkWsWEX4z2O4czzt0I1kn++PmmEqRH
         dVoTIkfMJX/70nXbvFgs098JIxyZm4PpnPO49y5Q/d+bV/jJxtiwhsk0dUEvdDXWAOFo
         klJjW3qjlMXfPKgVWkpTQxMxjmVq9wbPUtYXqKmuri7uKyBlcxFI/jK4OKMyli8H+sYo
         YOt5rG4QTEKX1DdvEQXMX92XxHLqgYhxWaASLVTn0jTdYguhLe1K/uNxbPT5ITGB/Nje
         +QkywZuJoI+HJauH/xL3yhS3Q/qpjwTVaJjqV9KMisp2wCMgWVAOlzkoRYWLWNj4lx3k
         PqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709627056; x=1710231856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZnJxW6Wv6ACuYx0jG7D7zRptFSvhxbtlXcoFteFtbQ=;
        b=nV/IYhTdbubmtdK7yVOJLOqdsrUgLevRBgckQVyLAm9hTmJfed3WshE9GsAXluEj5n
         RlAqaNKGa2o80VRXDk4uYjAyxS/tZF7vkF88Izd3WDifQ4FMhW1fWiNdAqrWh1Xd9REs
         7FNs6Zza3VjVt5uJmdg/jnPwNz4nTS5egRDt//4tihVpd7EuzCZwd5fZuEzzhxs2HtuJ
         AlpGxzKMAqsHPejL7iTvveZOYBRX2Dv7ecG5+AafhzdHi1X+Ew+nHLIIyU9gIdatn6Op
         FG24/VFP7psvLv+j+7w0w/F2853ECGYH9aleaiMmr1tg8qd9cBoQu6jPuzTrV/srC0/Y
         Ktbg==
X-Forwarded-Encrypted: i=1; AJvYcCVQyr/GdLCJ8vLQLSdQCpR4lKdVDVckzLmcMbvdDjCHfirGkS1wt2ty1VlP/AZJcoVqYagXp7IK2tO90xTPXHCpXlllmGSJJdfYcEsfFkN0HXnKjqEpElYNTdgCjdKK7WXFFg==
X-Gm-Message-State: AOJu0YyayxaLAycQUphvkD8uIRKng9zolfpm2r9EutnLS5fKQN8e9Gww
	/cc/9dHZ+PFxR7/2AwTrQ1iRCo8wOd0H+mQ2Hz+if1eAde2faa9m
X-Google-Smtp-Source: AGHT+IHylzklIp4P+4gDKKI2Llnxxwd/OdqQgT5BaYhEA89czvp1gxLJWUzumAHaFNv6pREu/toqhw==
X-Received: by 2002:a17:906:4a03:b0:a44:6e05:ea5 with SMTP id w3-20020a1709064a0300b00a446e050ea5mr7319375eju.1.1709627055649;
        Tue, 05 Mar 2024 00:24:15 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id tb5-20020a1709078b8500b00a4329670e9csm5728557ejc.126.2024.03.05.00.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 00:24:15 -0800 (PST)
Message-ID: <f94f98d9-983f-45a8-bf36-98a0c09fe4b1@gmail.com>
Date: Tue, 5 Mar 2024 09:24:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/2] net: phy: air_en8811h: Add the Airoha
 EN8811H PHY driver
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Lucien Jheng <lucien.jheng@airoha.com>, Zhi-Jun You
 <hujy652@protonmail.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org
References: <20240302183835.136036-1-ericwouds@gmail.com>
 <20240302183835.136036-3-ericwouds@gmail.com>
 <ZePicFOrsr5wTE_n@makrotopia.org>
From: Eric Woudstra <ericwouds@gmail.com>
In-Reply-To: <ZePicFOrsr5wTE_n@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 3/3/24 03:37, Daniel Golle wrote:

>> +/* u32 (DWORD) component macros */
>> +#define LOWORD(d) ((u16)(u32)(d))
>> +#define HIWORD(d) ((u16)(((u32)(d)) >> 16))
> 
> You could use the existing macros in wordpart.h instead.

I can already change it to this:

/* Replace with #include <linux/wordpart.h> when available */
#define lower_16_bits(n) ((u16)((n) & 0xffff))
#define upper_16_bits(n) ((u16)((n) >> 16))


> Suggestion:
> 	/* BUG in PHY firmware: EN8811H_2P5G_LPA_2P5G does not get set.
> 
> Or just skip that line entirely as the following two lines already
> perfectly explain the situation.

I'll just remove this line then.

Best regards,

Eric Woudstra

