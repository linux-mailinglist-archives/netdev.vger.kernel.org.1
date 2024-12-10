Return-Path: <netdev+bounces-150771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6E39EB840
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15339284F07
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CCF23ED58;
	Tue, 10 Dec 2024 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Mwauqwsb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2B623ED4A
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851791; cv=none; b=DlNJTL+TDfrDyfFw7rYAyOiCBVJOxy+tKszy/+XBTO82Bvie8EbSik3PiXwlSxuBSk3FhIr1sevmosxtFuXsd6wwGzGegdN1rAA1oc3tpO4e3F5zrEhIKpsDQxu+MqX9oUrgXtaiDW7R0Myy7xcqZkuDUwo1ijCjXYC9fBJyiTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851791; c=relaxed/simple;
	bh=vJMDRTnv7YNdnR/mhN0UgLZJ1Bc0HZ9PMLORHMqqpwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXK199FHTwMCdQwgCRRWdW1/h5T3F8YxmO+j1oR8RdjSWZArAj9uM9V0Pq27qYpkdXv50hP8MUoF/BdN2lDyKKdDchnZjdyy9QCb5KZ3oNoUIDgdAgx8momwvDY6oLy+nfXqsoP1HddYP2lv6pvisOmx998n46xrYx/JSjAL/oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Mwauqwsb; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d896be3992so30115326d6.1
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 09:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733851788; x=1734456588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pO+MGwpeAVge5dgHTV4frWGf+UqwapLJVzEqTcAPuqs=;
        b=MwauqwsbtAf8ng1cwX49crztyFsMLjGW+fntou9IwUTrPLTkKslQ6ugb4jp/vK3tcw
         85VeVnJwR2Dhx2JYfDS29+3xNVBhSSKE6wwm7qm1c0qPwE/BKGCZdDn6TA9k8Aujnfca
         fk8o+KU7VGF8HtGUq4J0q/iuD6whqhq7riw5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733851788; x=1734456588;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pO+MGwpeAVge5dgHTV4frWGf+UqwapLJVzEqTcAPuqs=;
        b=GdrPQv9Ia7Kv4x1s4Wh2hRsGkR9oR0nFX165O3U/lOugb1SKNrlbpmvGKmpqwR45x+
         lI7wqjMX8gRKsT/jqhWSQOVYTp2TBO4ZYi0/omC7+V++TrC9kyVIYHC+oONhJahWB1dy
         +By3tFRqO4UlYmiJpgQFzSMJ5ucA2a/ADQOWwTqQtoTGHya028iXnCeiRlDzL54Yss07
         vcmwtyqscaLz6wY5CLasfvlaDcncfd28N5XyIotyetMh5gLoK9X5+BS+V6optqbFDfKL
         RjDWAKjfQ1nGLZf/2vcpkSYAPq3e4lTqlUOkCMKF2qsYhTHC9oc89VcPIkJNGMBEpQZl
         uAjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAWz5S5cdgjrLclTntfIWvNdS8TUGo1pQE5o56mLPTxFPIGQNL1u9okFaIuOCXC15F8SvNQcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdWAERgpLBsQ+z4ktfydribU+M5/q72XLqO96uu+EEaEH130aj
	3bouGRrtnHft7lwQTNBw7ia5YTRALUfIliRqhlgWJtHhsgIvDF48pHDtnHoTCg==
X-Gm-Gg: ASbGnctnlpHoTvrpIDO6ZBEzIuR32fqlK26z27p9Qgi3p+QIpTZym8eXJLCdkc77u3F
	yj67ony9NzNCAMu0w/Edg8tj1keV06Fdh35XuyU2g/Da5hjLPvTDcimbF2pt0bl9Jfn1dwJ421T
	a4N1fquyjMWH78mgK6pgmcQW+Cprt31c+VvYY2F8tjUEynACCta7BB6FnWAdf5n9e/hDB0Ay2Fx
	KuSofq77qHVm6bv4yRTGdNGlttm5cdU/KfCp+uce79dkq1/sUFGimo7EdEZmN5G/d6pUjvhmuP2
	w5PalZaFoHEjEumaBA==
X-Google-Smtp-Source: AGHT+IHYW16q6sKxZxQ2s76au6BvsH9mlgt3o6j1zViiWttw+FsxPXhlL5JgqnbkA5PMSrtUja4vnA==
X-Received: by 2002:a05:6214:194a:b0:6d8:8667:c6ca with SMTP id 6a1803df08f44-6d91e415bc6mr71627646d6.32.1733851788248;
        Tue, 10 Dec 2024 09:29:48 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8dabfec80sm61624956d6.98.2024.12.10.09.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 09:29:47 -0800 (PST)
Message-ID: <fafda63f-687a-4a3e-99f9-2a6abfbb5d59@broadcom.com>
Date: Tue, 10 Dec 2024 09:29:39 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/9] net: dsa: provide implementation of
 .support_eee()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ar__n__ __NAL <arinc.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>,
 "David S. Miller" <davem@davemloft.net>, DENG Qingfang <dqfext@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
 Simon Horman <horms@kernel.org>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>, Woojung Huh <woojung.huh@microchip.com>
References: <Z1hNkEb13FMuDQiY@shell.armlinux.org.uk>
 <E1tL149-006cZJ-JJ@rmk-PC.armlinux.org.uk>
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
In-Reply-To: <E1tL149-006cZJ-JJ@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/24 06:18, Russell King (Oracle) wrote:
> Provide a trivial implementation for the .support_eee() method which
> switch drivers can use to simply indicate that they support EEE on
> all their user ports.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

