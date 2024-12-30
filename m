Return-Path: <netdev+bounces-154564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 948BA9FEA44
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 20:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E8A1608D2
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 19:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA2219ABB6;
	Mon, 30 Dec 2024 19:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UWvMK43D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3661632D3
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735586104; cv=none; b=RW0al7EePLBhnzWHkTNwJDSz4/nC1/tom/NF/yzzPK5n69ZQFLt09QlW2gDX8ZNmxI8VcnbQMbW7K/FMD3RUpAroROrP6RpE2dRAZjz5XMdNNV5vgmkO7L6xdnoE59PN9PkyFwlAmSi+aFZUyc8UnZ3i/Ym1oW7lRjaxNrr+Bn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735586104; c=relaxed/simple;
	bh=E7xxv/vz7qB/rYnuiDxw+yNsovsvxN/qhh7P/94mMzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MH6ZI9m5BwqXph+REHdzrx4I4mUqIm2+u4OMOI/Xkcg/Ki01nqaWjdihkQdx5J4gyzu9RPcGsjHKe0d1cM3e3IShKxp07FojyrZ7nqjjvrOJ8GvjtJ/P98iTUXYgqxLb14bevTiOQVE/aVj/fjzsphWyw5DtNmjefSHi3kGXMSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UWvMK43D; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b6f8524f23so1033883385a.2
        for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 11:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1735586101; x=1736190901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zm3EFGlcVZnoWV5O4DTN/k0dxpU/beXPAmj834H5Qsg=;
        b=UWvMK43D2tu9hAsW+xaNYyejXEZIRSbklTh7fuYsigEfUyO1Wh7V1fYtf3Uk8v8amo
         0kbAMqduY9+E7XsS+5R+MFAOmbWFuyGE/wLTyVX9gNNm77gp3XYfat3lyE7eKvf++SBb
         rArauDjwRd6LVVcytvJoqzbXj71GIqmQpp3WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735586101; x=1736190901;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zm3EFGlcVZnoWV5O4DTN/k0dxpU/beXPAmj834H5Qsg=;
        b=IvLQb4W0DpkozFaofFZyewCTzBl8buB4InEBFCEiUtiiS2l9Ktyr+LORHSInMVc697
         25UYZjbetoLWXhCRuXrobIeJSJCH4O90YK6tVRUsdgBjyXLydXTuNco3K5KIkMRY1BnK
         mKCPOs6dzUY6OEASBP/9Z/Rp38FQ9dZlnXvlqkXL3A63fATYvWLAbdmufFmo4Dccxv0d
         ObyVnkmbgxudMVjlCCQ8AbKuLjV0LgedvR17lYUw5ARJVM/4CEPMowIMYej/U4WPfZjS
         gRO7KGXiiGlCuexXU4k0lanLGpiF5UnwSHa1J4yETMX7CAhRcI0+Vt7yOW/SESAV2TOj
         33nA==
X-Forwarded-Encrypted: i=1; AJvYcCX9OwQ3ETmIOCCXCjoX3efx+AWnMVEuM6F9UP6rmFMmmmQiXenTCSSgxV6DITZLx/PShq0hosA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVTSJn5SlAaYQH+awaWGLZ+HrmwhfsJhXcsknNkTcxegKuGC47
	hdGyJaEODPq3xnc5j0LYtgbWSzwR9Kg4HYWW/7+NJ+5KD00heC/630mq7Tj+NA==
X-Gm-Gg: ASbGncuwxhN7yCuoSZNiVhBQK5coPEBAQmWRYLG7nSlpfFhzG1RvN80OP7zkj8+yXsA
	Rkes2VXw7TPwnrDQWaZLO8x9GP1wsc/SwkigHUsZZgllP2lnrqfpldTQJr2Gw62JGJH38dLei/H
	jJq/qbXPqCN6iIAh1yF0l7C+8cCWMjUV61Vk6JULcP87CXM0WXQVgoBe648bLDAxmaPRtByGLOc
	t/SNz/XBPcHc6aClh/jHj/0Yuynb+XjpKcsJup1lrgX/jDAkKvmfX1WpbYbZZFfcJXWqC3R6+py
	77KZpp6EArdmnl2UIUfV
X-Google-Smtp-Source: AGHT+IE0IcSsm2SyHAfU/YYYoK9D1FX6QPfeaWrQZciCcYAom2TZRVDGMZZ1f5WYgKBwCPFhQebD1A==
X-Received: by 2002:a05:620a:2447:b0:7b6:da21:7531 with SMTP id af79cd13be357-7b9ba717e7amr5595620785a.4.1735586101388;
        Mon, 30 Dec 2024 11:15:01 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2bc4b7sm945828485a.12.2024.12.30.11.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 11:15:00 -0800 (PST)
Message-ID: <629cb86f-0484-4ce3-8847-06abaa9c41ab@broadcom.com>
Date: Mon, 30 Dec 2024 11:14:57 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net]: bcmsysport: fix call balance of priv->clk handling
 routines
To: Vitalii Mordan <mordan@ispras.ru>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fedor Pchelkin <pchelkin@ispras.ru>,
 Alexey Khoroshilov <khoroshilov@ispras.ru>, Vadim Mutilin <mutilin@ispras.ru>
References: <20241227123007.2333397-1-mordan@ispras.ru>
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
In-Reply-To: <20241227123007.2333397-1-mordan@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/27/24 04:30, Vitalii Mordan wrote:
> Check the return value of clk_prepare_enable to ensure that priv->clk has
> been successfully enabled.
> 
> If priv->clk was not enabled during bcm_sysport_probe, bcm_sysport_resume,
> or bcm_sysport_open, it must not be disabled in any subsequent execution
> paths.
> 
> Found by Linux Verification Center (linuxtesting.org) with Klever.
> 
> Fixes: 31bc72d97656 ("net: systemport: fetch and use clock resources")
> Signed-off-by: Vitalii Mordan <mordan@ispras.ru>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

