Return-Path: <netdev+bounces-194671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A50DACBCBE
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 23:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39221892462
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 21:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79D61C3306;
	Mon,  2 Jun 2025 21:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Csmb1jTJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484EF19F48D
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748900325; cv=none; b=S+rBfpeIFekNdV6+m/0jJPcAtLnpwIQDg7DjrhoQfMm/5l3UNMojGEdaQ8xEKkG3TOSGyhangcCsycwOVaeLw974BtGWeRzbbs2VFhZMnxtdDUSN/GstWipAS2YoXP0zOySc+JngZZvUeH2/QIxwskLK5STNzM9yWgaOSZc+9+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748900325; c=relaxed/simple;
	bh=J0nMDIGKlKo0iWPfp0kpzAv5ygWRQAk3a0ClANRei1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPUiemJbdZpXIBaCIgKV9bdBQWbQpze4gG5jmo32fSSHFoUxH0vTb7SVWRv8YhWh+kZ6l1MzPrEIt9XzipvB4ubv1ELINQuyezZUynpO6g7zBLbMRh2dOwrnANZIZQgH/EiLdXvYYWutt99bbzZRSpc0zfxeSEgbkj63J/A8xLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Csmb1jTJ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-747fba9f962so298543b3a.0
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 14:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748900323; x=1749505123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KfXCLvlviHl6xGWseYI36giiCVOqhY5KSAt+/5G8sGs=;
        b=Csmb1jTJP41W8y52BNwROTfEvD7xMouhM86cFu9GG950AQiYbQH9hjZqBNwt3R0Up4
         LEjHYKOHCG+EK5zAD79yGTsq1V+5M/3mGr3bFXIKCFVkoF/OG02lBq4XetyaIgE5xEK2
         uxIT1cZ7kTo8483TuXc0mBxNotM7hwMJpH+CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748900323; x=1749505123;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfXCLvlviHl6xGWseYI36giiCVOqhY5KSAt+/5G8sGs=;
        b=KskSrvhNQtnhUsixWrdgGvK0GkjBqAm7DiogT7F8XJQoRvV3Z1sV/wosRVJ/WcjpO/
         +gZXgfgxxnjEoni047wIWZYR8DhwhvmkdEcv0JxKc9nROrdbksARpoi28CTb00Ln6n15
         YDv4yTgC8KHeZ+oqKvbBt9Td8AoWupKS3pFue7yxA1o48o76ejcmVk3VPml1EX51/rmL
         WiSR8UD+hgPOVQ3rSPt63315ujm5DR6w4aien/QTxwhjaMIaJrN7fClNK5IiWFpjta1u
         CQ+1jO17T/Ul8JGGs9+ZmXyej0WdDUZ3DAkVRoWb3i7pyDg61KRJZhyfyzerw4T91ir1
         hu7w==
X-Gm-Message-State: AOJu0YwOFTvoIkbFrkL/iPOMij6phlMOWvjn73tcCcZsHhb7zYuCAU0u
	dlUrZn/7qTYLRVIE2iacrSSIKViQP5XUP5P3oXE8X4shIRKQuDRsigJ45y8Rv3oVVw==
X-Gm-Gg: ASbGnctDi9+e814c83PArn2tJQoqlXM+FKPVhvZivEuOoLAX/UArpCiB7/UTZjvUkzl
	8OmLPnfL1XPfSnFE5hYQMIcEHAdF5yuTg/HiZo7idWCPJrTjfHMCHrMN8S3kDLdWjxkiAeE0L56
	LTPqjPyfvZtUylTvVrfzS6NMpK2bND9js01n8tCd2jsQEr0b2gWiEsIzz5K0409OwivPNnJC/Uf
	v+JlB9plx0/qMOvrR/gCuSEEdJ92oOhBzulhma9Sbmd0EBtGAbS522uftyKauVuRpP0Yf1lhnpV
	A4ToIA/wOOIEY7/w4A37fuw+3CziTBwpMMJfHDSrwf54Ls8gVVYoTFK8BLgdbc+CeOS0GNHXs4P
	pDQUUi57KCSkrseI=
X-Google-Smtp-Source: AGHT+IGpo04Fbfn1jf1pyDVdq0VVH9uqgwwDcZZGkEKM6DLiSINLk4oW+JZZBiIRSov0vFGZ0y3AZA==
X-Received: by 2002:a05:6a00:198a:b0:744:a240:fb1b with SMTP id d2e1a72fcca58-747fe26f390mr178921b3a.5.1748900323333;
        Mon, 02 Jun 2025 14:38:43 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affd54fbsm8096865b3a.154.2025.06.02.14.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 14:38:42 -0700 (PDT)
Message-ID: <a6afc16d-7d64-4bb5-abd4-b130f6260d45@broadcom.com>
Date: Mon, 2 Jun 2025 14:38:40 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/5] net: dsa: b53: do not configure bcm63xx's IMP
 port interface
To: Jonas Gorski <jonas.gorski@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250602193953.1010487-1-jonas.gorski@gmail.com>
 <20250602193953.1010487-4-jonas.gorski@gmail.com>
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
In-Reply-To: <20250602193953.1010487-4-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/25 12:39, Jonas Gorski wrote:
> The IMP port is not a valid RGMII interface, but hard wired to internal,
> so we shouldn't touch the undefined register B53_RGMII_CTRL_IMP.
> 
> While this does not seem to have any side effects, let's not touch it at
> all, so limit RGMII configuration on bcm63xx to the actual RGMII ports.
> 
> Fixes: ce3bf94871f7 ("net: dsa: b53: add support for BCM63xx RGMIIs")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


