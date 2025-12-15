Return-Path: <netdev+bounces-244854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 022C1CBFF64
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 22:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6C34301AB14
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 21:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FB2325701;
	Mon, 15 Dec 2025 21:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HcikFx8Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438EE2494FF
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834651; cv=none; b=s01SpSnoz6DexlFgu/NyOvjmma7ixHCq/EM33tjo3+3tlVD/Rowf/jAWxs3JUAgEoGUe7ju9Pgg4NVAAlMKk1Cy5cN2hKCIsL8GuHfQ4u0HXk7MK67SlDfolQz6XjF9FztzV8V+yFjPm9QOU9Td1+leLQe7IYszFA1qlK4jN/SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834651; c=relaxed/simple;
	bh=sd68QLFvyFQ/JuzLorP+hpKlItFpHSco9yQI8JEckL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t3/6+II9i5lL5Pvrhp77zyuC09hI0rq4/Myv7hs1Y+4Z1Y74AQZX27/QBGTzHctkhztAbUWjZ7cWVgRBUwwgVjpkBFMWJPvdlosdxpPa1dc+mEp0d4SVFWxpmMYCmhtVUZzGJmSuhVrDPwssnDf2XRCIVjXhpXHGNRjs2jQWTXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HcikFx8Q; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a0bae9aca3so25017705ad.3
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 13:37:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765834649; x=1766439449;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IciMt2ZnUq8oXS0IaO7fKLSgGJlrLaCCmsmagqu8OYs=;
        b=SbVXQpLlFCHkxGzlOFVWOhoKXfLjJ1wUR9ewJ4+g8zhc/Y7T/3M83cOCpzL9+GCVNl
         R3eQs/4csqJDwU2oO+RWnmC6WZy9IyUJc6fvhMTjuAESW/u9apkIGp8eRHzMtSFodQjj
         aEB0bZ8rxDP6VjGqNeAXyhygF2XQQyNNnWysfIVoF1KxCjoyxQ3cnN+FxYirdwrabu2h
         sq/5116sE3rKLmcNE4cmjrUjqjjFncGlpBx/jMRUEJPiDCU18OJUKxuMAntyiOoB0gpr
         TVRTzOJYLuSZr5VuRW3Qx+udg8H5l2O/weceqbcryqccHksfVSZth/NCICHWjJDMCrEx
         loWA==
X-Gm-Message-State: AOJu0Yxa7lwLwliDNCnBpfYU1R4nI0a2Xp274sQBOKeK55QyCiD04ZmQ
	JF99jd8p/KoQDtvzZkHVJ9iF0iGkqY6ib4pci12GAsuUlimK2BaxCCGVwDsN8KdZTdJKRgr4vgL
	vzxyoaBQ6I8/7RAXyTGIESLx/N0wcnbqm4wMvj9UyXSW22RWZrrDpZXH491iYtLNDkhXJEM47Qs
	kNJX1NIElhmy9MBZhwy2OonTqIa6TdK51tUj+tCkrA51IMhYAdiA7qr7pHDO4Zq002RD/FOFjop
	AqHi5p1twJ/7oWy
X-Gm-Gg: AY/fxX5nZQ5copjUV1YNR7PlMBzG4dTcZIHkxeFyxA7QkOwXICvdFvBlhFKgQuOs++Z
	OJCefXwEQmm5AE9vmO3nA1LLNpbNRP+Ou3MEjKQYLtgwILIUA2dblZ5MnlBwo+9deexJGGknhvC
	7ItBsg+Uxl/389jRM2uObaDuNcxztWyfp8nzSlrKtmU81bKGj/zGnqjTR6VaMvE1D2j5GRvaHZX
	ZiNhGySasF7MtHe+oS9jb14MLUVDmUWIsl9COHmW6bB5shwj/gVsOom35WyUe2zTGTFA17BtdKE
	bbFDrGaSKIIMXzqxHWFmdwACQE8IQE3zb9uEg6rdawqNlt4yu9bLlTT4zXtghbYaVZDnXlZW+om
	r/SGyxMU0FU07ZwmOVopyE6aHCx6CF6F2nrrY37XS912TeLZrQn2aGzAavh03qV3AReNgMTMnvr
	8pOXIj0Xd4WAlJhdAPM1pJg1hLJu6IvF2YQvoNhoclv/Cvv4A=
X-Google-Smtp-Source: AGHT+IHIRMoUj3RiyHHs4QEV0bXYgYz/NmK5klT1U7SKj8zr0+Xi0GpgnEojMHYfmlgOwWG6dkDIaIpbyQdB
X-Received: by 2002:a17:903:22c4:b0:298:4ee2:19f3 with SMTP id d9443c01a7336-29f26ed3a62mr119335795ad.49.1765834649315;
        Mon, 15 Dec 2025 13:37:29 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a07f80092dsm14668975ad.9.2025.12.15.13.37.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Dec 2025 13:37:29 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee21a0d326so45299901cf.3
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 13:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1765834647; x=1766439447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IciMt2ZnUq8oXS0IaO7fKLSgGJlrLaCCmsmagqu8OYs=;
        b=HcikFx8QDyIFUWJAVobBdNAym09nZlOtmA3bZB7rCCzObSvgSjsfbYSlBjqQnNolLn
         +NvSUC6huLB2RwMCAeA2QG4Yz0ciokyD+sA1RS8klQ/rFLsl3ywSD3DQx9qVmdmYoTp4
         vORhRuQal5EjdrrneAysuM6s/Ak8w/wTltN78=
X-Received: by 2002:a05:622a:46c4:b0:4f1:dd49:c8ee with SMTP id d75a77b69052e-4f1e16a70d3mr92845301cf.28.1765834647714;
        Mon, 15 Dec 2025 13:37:27 -0800 (PST)
X-Received: by 2002:a05:622a:46c4:b0:4f1:dd49:c8ee with SMTP id d75a77b69052e-4f1e16a70d3mr92845121cf.28.1765834647300;
        Mon, 15 Dec 2025 13:37:27 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be31b52abbsm38900985a.35.2025.12.15.13.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 13:37:26 -0800 (PST)
Message-ID: <6102176d-6116-474a-b228-ebf0d46d99ed@broadcom.com>
Date: Mon, 15 Dec 2025 13:37:23 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: net: brcm,amac: Allow "dma-coherent"
 property
To: "Rob Herring (Arm)" <robh@kernel.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251215212709.3320889-1-robh@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20251215212709.3320889-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 12/15/25 13:27, 'Rob Herring (Arm)' via BCM-KERNEL-FEEDBACK-LIST,PDL 
wrote:
> The Broadcom AMAC controller is DMA coherent on some platforms, so allow
> the dma-coherent property.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

