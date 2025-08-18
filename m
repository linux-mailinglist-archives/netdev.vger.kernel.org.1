Return-Path: <netdev+bounces-214712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BC6B2AFE4
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 20:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA38D624E3D
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1111026F443;
	Mon, 18 Aug 2025 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RIKyLLZS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966511FDD
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755540149; cv=none; b=hkky3wSUSZ17Cm+ywQgPnvVdL4O819lCP6+Ur8uRZNSPldBJ+Ma6bmhECR6J3BEmsQ+uPG6k8mOSk9y4LWbyn60qj12hyiG6K20IKMAZ3fTdMSqqX7SnX1zgFWMyvQqT1CQepX79UWZJjhDrVObymUiGLgDb6YwIvqutdq+lw30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755540149; c=relaxed/simple;
	bh=A83rVwE+E37WuuoawwVfOZ/BQosRnUFciBwS/1+bCyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0CopR9WjFDnrUcl36NgMLdOGfmVBIWp3FFn8uxtyeAX50PRSO5I+dt+UwqOJF40DCVa2HSsEdDEYoBIkYG6A8Um0Y5E4PwVPxZM5V5G6hudvjCzGlOm4CyzUKtNrXDYF8vXw7GIVM8W1+QP2C6/+yTS3rGtx7COnECvMcRlBS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RIKyLLZS; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-71d60501806so38428097b3.2
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 11:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755540146; x=1756144946;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Igvk6AvqPGpyFLK199vT9ThDTTRRAoLheaWbPVeRxBM=;
        b=f4HxPZ5mCmAebThMIa3uqOiJbgZxgrNcVyZSH8IjaQ/wnEguxYoms+qR3ST0H+UBeB
         CaX3TLX4cCE9uH0r6kgc5Rc/oTcjeLs5Imb1AAv8kTIZ7e/H5kp+cennD0jRzJYPpgZG
         RjJA9lVa25lQY54UEU3kfNyeuGGSVgoGB02Mch+fWXWosk4HQTkTTKz++GUFUahYZVpn
         mQP6wZl5bcDIsZHmbMb8Xmnmuhk3p7cTD5kUpsknKvgVCKocOa9s9AY7WLeh+23UxiWZ
         FvJDg/5rZGRoxxTnily7Oj0M7aheGfDPgOv3O5EfMr1LmgCa3dyk3SKr68s0o43PWfuI
         nQBg==
X-Forwarded-Encrypted: i=1; AJvYcCU1H3/RyVmy2DUcqsP8sCE+yEQj/ITvG0g15COydyurbFBAWYAkKgW5BsgUPS1gtBdphZlrDMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf4LEmVQUvnhhb9vHKOIfOuqTKUwN91ju7z1d3Il0H4+kC93e9
	vSsCz2XgtQE355AbVHVLLK5PH34hoVdF0vqfsrAUbcI5IZHgBUB4f+gMEAH1w6et28+gzvsTXEE
	gopCudZMKIJ9Yuw6Lh0ZfewI5mlPa1L+6mL/PBizezkYYOpZQnsoYRHg5rLJjWPNO+M8bfSdUez
	rAN4OdY+dPvfwIcBUjc/sT9YWGJmnqEbon3DpjaDrQYXdZqQaRIkphVK9gb7bZHaC5osdkLprK6
	ofZm4Ppu29tfrkv
X-Gm-Gg: ASbGncv0VEEzmVQaLy4WBZQ9uyvTzw5YgoGG6d8ZeakfwvXiBzqOy4rjJgdLezSmUOm
	8MTQpyh8RuIbW2/zlaVnDjP1ib4g9GmrSoy6eW1pcH03ogPQHTAw2syrNv36+Es+29wEw9yKTtn
	9RFKw00VdM346wxO44/PWPUOQHaRRVK1UyxdruH5ycBwUjiYli580PT9YJmEqu5iGU+iRh6GO+I
	A31ZGK6XXUyUqrgmKi97Z2mYU3g4UyWTHootlpQX1ElowCoUS1r3zuB8eoUru1qLQDzsSF8MjP5
	zXXOik/4eUD3uslTGup7bpKYU8NLmVh9r5mUYxXql/csDlehuZOI1RfNQbE1ryGcczbrVcgufwn
	FVD9mR8n26bnw1mMFWGf1jIZ7cuYO+qOT7m7mJcqBPNoFLcK1aQWUMMs4v3SXv4NBn9ppNRH0rB
	EazW0ugUA=
X-Google-Smtp-Source: AGHT+IGDHPnEuB3BKB3dItfLQTFGRvEFXpMdwHW8hKDBFGY/a/bfbvhQYLmF90PAkLHLzYmGxHPqDAUntvhy
X-Received: by 2002:a05:690c:7307:b0:71a:1234:3529 with SMTP id 00721157ae682-71e774f5485mr118222407b3.21.1755540142626;
        Mon, 18 Aug 2025 11:02:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-70ba921d6dfsm5457046d6.30.2025.08.18.11.02.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Aug 2025 11:02:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b10992cfedso102584291cf.0
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755540141; x=1756144941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Igvk6AvqPGpyFLK199vT9ThDTTRRAoLheaWbPVeRxBM=;
        b=RIKyLLZSi8oQ2YK50pMto/Up7euZABmQPbZVh2j3kA6CqTad7s+QfKnMt5J0E9q7Ys
         +a8A3qwyyiGF7XiskJud2Vm7LoCh2ione9q3wiBGFNs09tFPaBSuB8Wq4jniEHzg6cYo
         S3GIeihH9+X1lpPW6Ro+8k/IMqPvihrF9kehM=
X-Forwarded-Encrypted: i=1; AJvYcCXkqKGCwKx8IVySOmALSFU9JQaqABRNeMgSPZPpBaV89AcFnfhirNhqr9hiKXLUdi4Z/FvFFbU=@vger.kernel.org
X-Received: by 2002:a05:622a:d0:b0:4b0:6965:dd97 with SMTP id d75a77b69052e-4b12a75d90bmr125817731cf.44.1755540140301;
        Mon, 18 Aug 2025 11:02:20 -0700 (PDT)
X-Received: by 2002:a05:622a:d0:b0:4b0:6965:dd97 with SMTP id d75a77b69052e-4b12a75d90bmr125816951cf.44.1755540139671;
        Mon, 18 Aug 2025 11:02:19 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b120b96b1asm52522561cf.26.2025.08.18.11.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 11:02:18 -0700 (PDT)
Message-ID: <4c454b3c-f62c-4086-a665-282aa2f4a0e1@broadcom.com>
Date: Mon, 18 Aug 2025 11:02:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add ethernet support for RPi5
To: Stanimir Varbanov <svarbanov@suse.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrea della Porta <andrea.porta@suse.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Phil Elwell
 <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250815135911.1383385-1-svarbanov@suse.de>
Content-Language: en-US
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
In-Reply-To: <20250815135911.1383385-1-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/15/25 06:59, Stanimir Varbanov wrote:
> Hello,
> 
> Few patches to enable support of ethernet on RPi5.
> 
>   - first patch is setting upper 32bits of DMA RX ring buffer in case of
>     RX queue corruption.
>   - second patch is adding a new compatible in cdns,macb yaml document
>   - third patch adds compatible and configuration for raspberrypi,rp1-gem
>   - forth and fifth patches are adding and enabling ethernet DT node on
>     RPi5.
> 
> Comments are welcome!

netdev maintainers, do you mind if I take patches 2, 4 and 5 via the 
Broadcom ARM SoC tree to avoid generating conflicts down the road? You 
can take patches 1 and 3. Thanks
-- 
Florian


