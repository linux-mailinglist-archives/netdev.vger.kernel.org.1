Return-Path: <netdev+bounces-194640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF08ACBAC7
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 20:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75EF3BED28
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 18:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C89224B05;
	Mon,  2 Jun 2025 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LtRnSrFM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136711925AB
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748887645; cv=none; b=ePhEDKkgf8idhGGhEhAf98aZN/7QAQFu9c/YnYcOaNlu0j/kE27M9qOM2DGOxLPVSuL9sbMwNgV4Ll0c362OWifDZC7SfRxE+/RuLUVudQhJLZ9lgN+/K3RfJpotu6wZo5DbJ464CbPm3Cnd2pADLdImoKb/8z4HK8aYKEuq4yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748887645; c=relaxed/simple;
	bh=B1IT92nzoDwlJgHyhF/M8EqdbkoWldClYQt+fdBC7O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SGQo2vx2XE2Kp/uY00Gl+Li4STOTQ9LIVGslf12QMYVJMX4d0Xk+ky9KPfWHg04ITJPDKprIBGSS7lQqFKMPWGy+Xw/LocFfuzx4NzDZjz6D4/2rXan/MBF0H2USimBMxlUI/knYP0ePfJLm7JTrpaVVyt+wByMwn7eZDE2yyKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LtRnSrFM; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7406c6dd2b1so4627802b3a.0
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 11:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748887643; x=1749492443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f75Fmd2HmTOxmb3ydCTXDBO0VW57Rha9LIEst3+i6PQ=;
        b=LtRnSrFMIAfdFf8vnbe73IBT+DMTAY1UA5AxZ0JatLJGWRh4aKat8/gVYz8LFGRbM4
         XA6caG9u4+BDYTItgDWd9lF24OVRaLksgvVUIxXhcbbthHMsL78VYF5x4YkOapbZIDHo
         jAN0aEvWOdcybdUimk3SJ+MFDHpT57BP9m7sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748887643; x=1749492443;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f75Fmd2HmTOxmb3ydCTXDBO0VW57Rha9LIEst3+i6PQ=;
        b=ovxaUsbiVMVOdf3E7oxuF4Y9pXpu9aDyPmRZb3hfBzB8552KKCrpgM9rn+BacZJZ+B
         fZkIES3sGK3hZLvDtEQboKvQg3UbhmKevzpCi7eGCrnQIqVkYU06mPSHxmp16/Y4VqbS
         8PTsNzp1x+4QmNrvRRfh+TR8d1mni/p3JvKKii0YaNtvJQ8tjlZYWV7D4R3HAbwrsFby
         mXZNDlO4WwoD46LtCXleoEMdTOcTRVuyAaT3WmvW89fAzbsQTQG7t0VLnyDMBf21tftJ
         ANNxGG0t6aGad+UZ+8jVWQCopNdfvrgQfbkkvh3gnhu6AU07bMS2meetX2Fx34qPwZil
         qvcw==
X-Forwarded-Encrypted: i=1; AJvYcCXVi995z1oA6vGH2tKEWeDt0EazZCW6XQdg2IXbqDUoSawPMD8jpButL9jq7dfGjCCnWxapT+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAZPX2S8FDNdmYrren8mHyGp2Uw7VhHyvF7AgDk7hhz8ic5c8X
	jfKXnSl0UYabin+LT/2U+w/uj4QN+gVlsoTtHmqKasOCf21mRESW+lV7HcrgujXhMA==
X-Gm-Gg: ASbGncsgMsurLnXvyfLUoOi81M4/m646sldVApPVw5fi9Zr0tPdXLNyTJJGRaT94xzL
	Ms8EAW+/BL4VlDL0d9H20s9o4euLl07LBHIXVLQY24I9Ija7KXinm0bTR5t6rusAMaQIl61ypLv
	UTEWGrAjAp9F1dt/0+eQsbO0Fn0MMQbXlG7/nznKF4zueSGOIliLXbHl4Yj0E9g2F7cw4P9Nfr4
	tkDqQ6m8qrq5bU5iiD/K55dVfD7lZWK4Ni3dSF+2/Yg+Cih2PhGiMxp8imKzgjmMfKVmWN2wM47
	+NuJCpC2bpvhqlk3a39JA/tdtVKFgLJuyrs+eMWPnGMm/bDrmMGoDPLTTk5/72ggnLI+FtzP66f
	Fv1i4SmPqZG8yHfA=
X-Google-Smtp-Source: AGHT+IFW1A8jX6Iq5Uxnn5p/4m0wDsnzCLGnjep/xHiKvfLONgy5Zls2kW93VR4nae5axXvqgzGsiw==
X-Received: by 2002:a05:6a20:748c:b0:218:d024:11f5 with SMTP id adf61e73a8af0-21d0a014e05mr656981637.3.1748887643322;
        Mon, 02 Jun 2025 11:07:23 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb368d5sm5862201a12.39.2025.06.02.11.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 11:07:22 -0700 (PDT)
Message-ID: <0f26cda5-8269-484c-b5d0-2b627e92776c@broadcom.com>
Date: Mon, 2 Jun 2025 11:07:20 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/10] net: dsa: b53: prevent BRCM_HDR access on
 BCM5325
To: =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vivien.didelot@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dgcbueu@gmail.com
References: <20250531101308.155757-1-noltari@gmail.com>
 <20250531101308.155757-7-noltari@gmail.com>
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
In-Reply-To: <20250531101308.155757-7-noltari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/31/25 03:13, Álvaro Fernández Rojas wrote:
> BCM5325 doesn't implement BRCM_HDR register so we should avoid reading or
> writing it.
> 
> Fixes: b409a9efa183 ("net: dsa: b53: Move Broadcom header setup to b53")
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

