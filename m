Return-Path: <netdev+bounces-185728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9404A9B8FF
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 22:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24114C4029
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 20:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8BA1FECBD;
	Thu, 24 Apr 2025 20:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FzSTFY9f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6421FECD3
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745525948; cv=none; b=uvKTHUGrAnmmQbfml55h6nyVTA4fwHDNsdBXVaEyHYevPEXbqFjE1S4PaG/iVHnai0Y6qS7uh+z80VWtRR/tHJ+siNyeD4YUjvwYkH+n0cNv9SP4/bl9qPl39Q+OrVNLoJRx5tAYSF5AXQczUNbrhrEkhEQ5xRliqOGhe8MRDfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745525948; c=relaxed/simple;
	bh=wXtt3O6QR0SBtm6JBBM/8SyfsD/cxOGQ/lU0OsnQlXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EOHWIs8bJix0LnIyvZ9fMKzp4odOtpjo/7N1ZJiDY7t++RPWKQ7SPO8j3RxmpM2sAXIhAbgr9KP/l2tyceSmOb063sUvqjjoDp976JOMgIgxQI1z7qkNk2VfxVMATxDYPwk5HAlhc4wUN0IvN3g18Ll6FX94vOb9fdWHVblzK4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FzSTFY9f; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72c173211feso463379a34.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 13:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745525946; x=1746130746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fqpCmm/9ps6ojnKQ5WNeOaRI3x7j1foxwoVLfKtNdk0=;
        b=FzSTFY9fG5hY3YHZQtsfEwjUpuxHQPsoEIEyMFZ4wQrDbRYURtHEuUIG7KsWewiz5E
         shrNvIeTJN8WtzHFxwctPsg6BMECAzlV0GEsrVy0za+78FZr79Wq2Gr9PFKxc8ba+MD/
         IlTzE/QL0ze3Xy2bm2KH4pHdmhZhKuh2Bh5mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745525946; x=1746130746;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqpCmm/9ps6ojnKQ5WNeOaRI3x7j1foxwoVLfKtNdk0=;
        b=a7r3kSaBXHce6CHuZI+qDbQ5AD3rl67U1uauKF0qzfUUA+IrmdJMjcsocABTona7an
         ++V9jCoKLpdbLyGNV2Rm888HdX64+06+1t7pLKUdfoKw377qsaDwo/CSf86Qdn/cCQ7O
         sJfTJ1PULqnuyyHVpFbt8F7T0eB2La4cJ9pjhbCTnhO0vTCXTGgTn7qjbdJbQAPRKK66
         01lfnrb2wGArwNsdwsZWbRxFz8EOyVMD8HtbqkSmcCiNGBaXxIqPNPCwdWwb7zx0jBh4
         cwDHpQQXggioIzNsILjC8P8mnhLtMaZjsVOXJu/k9J1mAdWc/B+kUS0gKfCngCC/AQcY
         ecOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPb1oIl7JGBb8I6GTtKsA7iUySSizYesyIwAbIG6GAM2CKzasPjdc1ilp20dUr5I58mAHVyZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKuzNZVuaKiwnGv4oFH8hE3WeYo0drEeAyvA/UW0iKY6Jm+4BJ
	BSzfxEQpXNUkPL5CXM5pCzpEX484oxLnAIs2MGHHSSaQgXGXHanqjWPMgURxVw==
X-Gm-Gg: ASbGncsCKVntneOvj6YibaUWpV87UTmIftOcZhma9/OrnL5AbnI7fYr6tLc4w5rTrZq
	5+0hFSDI7zYitkzywh7c8dRX/pSwplyWmohRDcLMSU6SfcZ1CQTT41on38koEW31Ekz+8QiqbX9
	U12EA+T5JRd4q6BrLOr64xqQlxTiC71UrUT2ZQDoXt2wbqX1xEyu2kgzIcv1u5Qe7LCnE8Fau7X
	JwZPuuwCbgPKUxzE7tbGijCbtUj37Auh4jb12XIqV2RZsict5ytjhcFBdO1vEHdLzKslKTwzreL
	02Vg6PFz6UfF0m5jml1UE9ecEftQNeRjd37Z4vLd9ekXRhiREg4GKs358jZzEkoYJ2tkXWmIMax
	BShb66jZ2/QVBE3Sw2on5wRpBbrv3YRB3qQ==
X-Google-Smtp-Source: AGHT+IG6Zmz2sFvChlWMDoH7pTDFaR1Uux4d3RWMHcXZbIqfP6Es8O8XHkxJz+V9Fp3SVlkL6sqntQ==
X-Received: by 2002:a05:6830:2a8f:b0:72c:320c:d960 with SMTP id 46e09a7af769-73059c6b3efmr842016a34.15.1745525946160;
        Thu, 24 Apr 2025 13:19:06 -0700 (PDT)
Received: from [192.168.1.105] (88-187-52-200.subs.proxad.net. [88.187.52.200])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f2ac2besm363165a34.30.2025.04.24.13.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 13:19:05 -0700 (PDT)
Message-ID: <9f2ebcc4-69b6-454d-a5cc-72e51d5fdff2@broadcom.com>
Date: Thu, 24 Apr 2025 22:19:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/8] net: phy: mdio-bcm-unimac: Remove
 asp-v2.0
To: Justin Chen <justin.chen@broadcom.com>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
Cc: rafal@milecki.pl, linux@armlinux.org.uk, hkallweit1@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, opendmb@gmail.com,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
References: <20250422233645.1931036-1-justin.chen@broadcom.com>
 <20250422233645.1931036-5-justin.chen@broadcom.com>
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
In-Reply-To: <20250422233645.1931036-5-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/23/2025 1:36 AM, Justin Chen wrote:
> Remove asp-v2.0 which will no longer be supported.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


