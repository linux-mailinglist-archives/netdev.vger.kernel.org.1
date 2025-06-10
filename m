Return-Path: <netdev+bounces-196230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B9BAD3F2D
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 18:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493A23A7A41
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36249242900;
	Tue, 10 Jun 2025 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VZJ55YOb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B6E24167A
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573511; cv=none; b=acymxHj9s/x4Kr+MBkBOy2Ct/SxbCu0AHZ10ywMM578m/sSzcr9ghcpjN6uggAO89FZViePHVTeRU0iHXRVsrQXnp1zkeH4ASW6LmC2IrRkAYUe6o/pif3oL200+UyFG98IK55rW38fHr2s2O3+CeYk5+0do1/JmQ8EzMO1Q628=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573511; c=relaxed/simple;
	bh=UTYAbYhoQ5I8eQ3oIsCWd15WzpkQDH0pbsPDuJMUmJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CZQ4MzY7PPiUmVgv8NQrG4ew+ODIKRs4tZfdasGH+weWCHbMyrnAOjHjfcpsy6aDo4Zd9TrE8/MQm13B+ib7WX43AOZj+JD3wqLrT1BcusDtyhSPE7pCWb/Ow0OtY1U3V3eOFEePiz4MWI8x+/TCFNbUoki0iVxgst9YYJvUkcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VZJ55YOb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23636167afeso13059125ad.3
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 09:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749573509; x=1750178309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IZmHDFRJgjoALTI9+QQgJgvyBqToRl7O295DxD9va/Q=;
        b=VZJ55YObFZDi5Ic1A5mvCUd+pOKXP6FYXt9pzSZnh4pF7Aly8W4D4sMbcR11mXMjLB
         V52ibnLqBk0SGaQNmFK98UkgG6rRkoGX/vRnpofesYFULdJrUjOUIdpYD3o4dYBT5I3A
         gIQbk/YMPTxoH5dFghddzXRB72tv+Q1DP7I+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749573509; x=1750178309;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZmHDFRJgjoALTI9+QQgJgvyBqToRl7O295DxD9va/Q=;
        b=O+6ulaemvaIo9dpvXwQbcz8d+1bgNdp7gmEMrVdZ/N/Q4NM/TW4PvxpCqx1nSF2nM2
         6Z43OPRMD47hFr0CfUxosW3+2XlYn3qixhu/pEbIwTi+0lBoGvPb1dTrU2GH2ufB5R3b
         Ea4jMozSNoiIaZqa0UsHEzx7AQ2cFmFMUT1/G/QQi+73h4YkyjsrOpO1sBolufd2QEde
         ozWcBFsqKKgWeNTR4asK38CFsKwhQ6iKfDMsdXCKnm8l6cI3ZrRdp4lDhxDM7KgLEhiD
         prmtJm8rxQMn+dZPBGThNk8HQ9h+u5lHNnT7L7n2/FrBqn9i0VcOxgLcroDxcx1tovYr
         2GZg==
X-Forwarded-Encrypted: i=1; AJvYcCWdvVYnY8EwsPeqazIAd3offgRb/97bOfRVUuKY5xHs6ogEKsPnS4SCv1Leh5gvXlzeNjUDMZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK1zMQWbo887hRoYgLtbFV+WvcC73YNX5ZD8Nvue3H9jqb/stK
	rG++IQi/HEv8FuNBWLMgMJMpNUIJEDnNLVtyl81XZv5C5cTbNuqOX1n/tXHnHsfdag==
X-Gm-Gg: ASbGncv/pKXpLMzJPcRJFuFDZ6d/MNiXRwcmzUUJd2BXCkSq7sZuf2L9sN7vJSY3u2s
	ByuDg2WNOcu1QP+1HfsJ0qO42YMpZpBT6TMW2XK8JTSD0D043yLKYfFKBWnGzeDoq2TL9UzkFcm
	2o/1r+L1ZMSQqnSLWw9ZiFIyUg7x7BnO4nTYZiwc0AtWykGlgTQzrdPDpVM7XDWMeGHUqV9nkDN
	r+WjoS7d/xuY/1hkblREgHuMTRxQdUlNjrhW1AThSX3hKRpVYiC14/mbEGQxJh+gYFhBhkeWOVm
	VIO+DNN/Omc1BleNyJ8+YJmBKjfvyC9RU8Odode7Dg3z1Tj4Iix6UblXv6UnQju79Ns/LjRYRhs
	KOvZDROhaLoaZnLyv/MsZv2UWbA==
X-Google-Smtp-Source: AGHT+IHUiRuGFGaYxyo/VmQe0/2GkK7iuLM/Rm7nqPetAGEmPYgHj3X+OaCUL4CWfrD7Ala5dBOpaw==
X-Received: by 2002:a17:902:e74e:b0:235:60e:3704 with SMTP id d9443c01a7336-23601cfd8aamr248720685ad.12.1749573509048;
        Tue, 10 Jun 2025 09:38:29 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5ee6f1ebsm5975984a12.20.2025.06.10.09.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 09:38:28 -0700 (PDT)
Message-ID: <48e3e2c9-3cb0-4097-af7e-98f67e7ac5ad@broadcom.com>
Date: Tue, 10 Jun 2025 09:38:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] net: dsa: tag_brcm: legacy: reorganize
 functions
To: =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dgcbueu@gmail.com
References: <20250610163154.281454-1-noltari@gmail.com>
 <20250610163154.281454-2-noltari@gmail.com>
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
In-Reply-To: <20250610163154.281454-2-noltari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/10/25 09:31, Álvaro Fernández Rojas wrote:
> Move brcm_leg_tag_rcv() definition to top.
> This function is going to be shared between two different tags.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

