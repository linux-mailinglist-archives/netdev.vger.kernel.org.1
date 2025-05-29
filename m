Return-Path: <netdev+bounces-194271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BE5AC83B1
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 23:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A25C4A7958
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 21:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D6F293479;
	Thu, 29 May 2025 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FaOFK8hN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F58335C7
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 21:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748555181; cv=none; b=Wb5KYXHqHVisEXTAyFkmdE2ZwvW+G3E8Knv5S8ww3V2tHX+XNcSk9jJnUW/krQfMsd9tktgRkvqwIYiad3cHE+IC3n++JK80K3prs7xkVRT8RflRuWncnjfQ9s9U9BIybj0YRByGxSK7NGm4vlUGFaQRrJ5oJRaU+qYWQ0TrhOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748555181; c=relaxed/simple;
	bh=3FbM/5b/f6R7ql+h6I/ET3q5rvjJXKdSarztikH9TWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HBb53+9dKAmFXjxyIPPPiLFLM6ryhMhG6wyEbx0ByGkRTsztFprYd6CorFfJL3ixkHh69SrKkkCbr3Rre9ulKRAnrqxWT6fYX6Md+4AqfUJpXdPgeLHMqLlaZCZK1wDkeRVui3L8DJh5ng6xBp4ppF9qR6TputmWfd9oqrIRm4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FaOFK8hN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234ade5a819so13886665ad.1
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 14:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748555178; x=1749159978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EnXkwa2sU7C5+9WFcS6JOR66fh1+6TmCOrRHRKwjJuE=;
        b=FaOFK8hNB6E/wUdoqjwn2q9DKSqGqxNBfPe/XAGF4OhKwL47ulGajzhiWBX4uCl+BB
         kTteH2tHQqmHD5crb+bwmTFcedo8x/jnxehe+kqqW18ejo7TvRCtVf06++bS+U51CVc/
         XI9yup5ycHL8fpGaUU7VKZ+jMG2DrOyModbIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748555178; x=1749159978;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnXkwa2sU7C5+9WFcS6JOR66fh1+6TmCOrRHRKwjJuE=;
        b=aPlgi2JVnIAg/6PAWBL5rjinBlSEEYVShTI2xOSNqEPJJkYCGCLXBKbxyyxCjyXSBN
         mou1Yo5cxNF6TboZ1x/I5R13yO3Akd+IH4cKVJWOfHNxR7LImOzF0cjl7r1jL/UVly7i
         u1a+qsAoT7vMVHT+CJ1clA6vLNG5pDmJm/xgdamsgsjJJ27bbO2X5O34p4NFWvGJWtyg
         vcep+GQUDyBMrWQJcXUEIRRTD8oqZixEhpP+SD48l2zNXN2xmkEySarqY73+uPHCBFQ8
         q0FH6woJ9rVf8sQdayBQi2iJYI2kF2uD9abeyiqhKibjG/ltfrFQ9wWRvrWrdeEZay1X
         d6Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVMhwjdqV1Fu7oEf8gejDCdpAl2n6od731gXXEILD6BJJ77x7WLXuqAHIuktLj+tNvSgA2qnYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6zIzeQHshMEsUXO+jHD21cTFRYKywADXudc4SEfmrxzYlD6+2
	keEZKcu3RUkkKIQQ7mgSwHc6Ewxxn5Qko+84J8IL9w3JOwCKwENoHHV/9sBo4qHkyA==
X-Gm-Gg: ASbGncvsdu9vxqT70uBmJrvl/PfpOvr6nTPJ2su0cOfNgBma7aKdIwYaSC0sjkOSwKw
	s9FIu1txWZJevLRK1NO1OtqFjRkj4Wp87uvHTmsxPtlo3ArnpY9YbBzgybM/AyM75r+ItrMv2TT
	HfgXG36i7IG1ro+ErhONyuXWr4LHnSng7RRSI/qXE7TsiUObVhu8dDlmuOshHYUXsWwrfpgbcdx
	eU1u6tfT1B/2md8KNq2gBAClbt657URsj4JULh1Aerv3TLjKUP4jbY2M3oFxlgS+wo80sQv0G/Z
	YSkOD5n+J0W+6Ba1EVuP0R3pgyUexzmp2+OTrCAgZkVdpPlNjUYSwdCDftElmsCePu3JmsmfyJ5
	rhfODgw==
X-Google-Smtp-Source: AGHT+IFH4yiLjc7+rYpcNKeGFb0X58Lt8uVD7icqkiOq9jNa+l2IJnQL44ftXB+axaOdZQB+DLu65g==
X-Received: by 2002:a17:902:f788:b0:234:bc9f:82f2 with SMTP id d9443c01a7336-2352a089905mr14711675ad.46.1748555178460;
        Thu, 29 May 2025 14:46:18 -0700 (PDT)
Received: from [10.69.40.38] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb28c98sm446643a12.19.2025.05.29.14.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 14:46:17 -0700 (PDT)
Message-ID: <90e91a4f-56de-421d-8e4d-1e641a2ad430@broadcom.com>
Date: Thu, 29 May 2025 14:46:16 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: tag_brcm: legacy: fix pskb_may_pull length
To: =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 florian.fainelli@broadcom.com, jonas.gorski@gmail.com, dgcbueu@gmail.com,
 andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250529124406.2513779-1-noltari@gmail.com>
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
In-Reply-To: <20250529124406.2513779-1-noltari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/29/2025 5:44 AM, Álvaro Fernández Rojas wrote:
> BRCM_LEG_PORT_ID was incorrectly used for pskb_may_pull length.
> The correct check is BRCM_LEG_TAG_LEN + VLAN_HLEN, or 10 bytes.
> 
> Fixes: 964dbf186eaa ("net: dsa: tag_brcm: add support for legacy tags")
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


