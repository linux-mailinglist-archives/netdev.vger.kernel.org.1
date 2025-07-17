Return-Path: <netdev+bounces-208000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E68B09442
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 20:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B2E1C483AA
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 18:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB1F301128;
	Thu, 17 Jul 2025 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RjOMbHJu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7772FE314
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777911; cv=none; b=SvrOYlUbGbpv5f+oW7sQy1NT9j0KFr0meuFnufBaUeIeww5oOxSNp71Ap9pl31gyrq7HrsTWTbfadCGKJU3yK4PW5ojXytm4bxlqSdbZYa1IV1y0BCROo4gdXkb3erio1pkBoBZhQnALD/HQwOV5uR/9uC/7URsV3CyDBUblnXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777911; c=relaxed/simple;
	bh=OcRfQACT/vVB5TmdTOaZFYKdiqRVgYtGkeC4JOi2jRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TYNvI4Unv00LVURH7xfBQIwwHDaalzYHp9DmCFJ0xFP2F+BCpiPrDgo2KcFT8Kkn3nQJ95z82PP9KLoaE0QGc9hpUREWDCDJu1u3XFM3XqzZ3at1S//ypg93VYtdHijBkl/9KDpFjSPYN4rTaSVCXJyWjHH8fYjTjdIvcQT5BGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RjOMbHJu; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73972a54919so1408771b3a.3
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752777909; x=1753382709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vuCmHePdpvWPRfNwBDSOXeTfDTCQqAuGF8eiT++Ehtg=;
        b=RjOMbHJutc7lfxl3W+6lWUKQk/dkjcsQKeVcZHfeB8DH6852OJbO7m7o5LE05XcEie
         atETTdqj9a09IgYWo6fAS3ceTqiaQ22OVuA/tH9jXUUdBQ2RWMdR+V73QQGRh9E1sGBD
         1dOGfh9urQZzv051HDWYuPAdBnd1qw5fYooQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752777909; x=1753382709;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuCmHePdpvWPRfNwBDSOXeTfDTCQqAuGF8eiT++Ehtg=;
        b=MMoMBqeNVnx/iU5yhGOsRjOiCXCQmb6QP0wRpx6VTpgBU81zsuzDAFoRa3MEHeiHm4
         L96A4VfDTXkh8h5ntOowCUN0nOY7Vi+4YROfDO1N8RMXSSAUsL8Oq9epezO7WjjR+JNI
         lCx4Pml14bBYC6GikJAZneJtykVk028LaZXDx5uRW7mWEIKiKPSSwfUbIk/QWBjymQah
         0NY1KFDt/DhrfGRKbbvBRTsTKTodqy/KaAqFSibdmuO9WziQFVVO88va2RIuEQUe8WHN
         AvqX0AOSalxpt0uQTiCZs+oDEM5LklORbB5rStQiu2FFGGvNfBTrbQ3UWFlnyv2t5fcT
         5Xfg==
X-Forwarded-Encrypted: i=1; AJvYcCWM8TsD8Smta7HjgZ2vvTWwkH6nGsHvlEZWZeht5+sqT6hVzfFlyuGBJmnVOrquMAHZKorpEes=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQVpJhOGJLPH9sWftTk8SyVkuqqpq/loNZ0CZ0+4eH8Z1r72W4
	4UN4hnzITtoKi+UjDqGXhQn+kGQZu/44ETvjAT5X/KSpqgZpy6Awvrk7WQ0rk7xNfA==
X-Gm-Gg: ASbGncsHanq3EBrtr1GpVfHT05GZnG2wn7cWN/fF/viQXIC3RqoJiRP/5IlW6doJOX+
	88aXY4vzixeP7VfYlkbTwzazl8oR2/Ze68l//qM2o5TMNNsFkwK08UmY9CrwPgc85olnSIsVSbn
	cqRVDTKaRZOW0WrjEMsikpIPOAiGuCvJxzeHqdYjpMHOrFceo1JA1gYCpSx5TIZknaLGZ39F4uh
	B4p9GT4FxWotT+OX7S/NZ389Y33NXHQCRpGhGsjwg/BrYIIU4wCO3cwdV0G3u5eLhjUGqIyor7t
	x86/mAyTZT+t75DaxeQNTnsH/rq5uwgybDZcFFaiO/i2Y/VtuilvxRN1HKtVa4NziQQSH1TOsjv
	xxOnzYDku288j2nqCX+kWKut2s595QmXKJUV3r5rsmh8ET9lnYI1hP4QhhwN6NySY7Y3BLE24
X-Google-Smtp-Source: AGHT+IHow5sAuxaLQCdxeUSnZelFKpxHC9p3Dm5z+r2fCQPnJR3rUBdFjF5johkDwaGYwEmx5hVZPA==
X-Received: by 2002:a05:6a21:6da1:b0:232:87d1:fac8 with SMTP id adf61e73a8af0-23813861e26mr12388598637.40.1752777909344;
        Thu, 17 Jul 2025 11:45:09 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b6fbsm16368473b3a.84.2025.07.17.11.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 11:45:08 -0700 (PDT)
Message-ID: <58eb6968-c0dc-497a-9a44-bce9844cbbc6@broadcom.com>
Date: Thu, 17 Jul 2025 11:45:02 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/8] dt-bindings: net: dsa: b53: Document
 brcm,gpio-ctrl property
To: Kyle Hendry <kylehendrydev@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: noltari@gmail.com, jonas.gorski@gmail.com,
 Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716002922.230807-1-kylehendrydev@gmail.com>
 <20250716002922.230807-4-kylehendrydev@gmail.com>
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
In-Reply-To: <20250716002922.230807-4-kylehendrydev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 17:29, Kyle Hendry wrote:
> Add description for bcm63xx gpio-ctrl phandle
> 
> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

