Return-Path: <netdev+bounces-158218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1316A11195
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 20:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E66E188620A
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 19:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6FE209F47;
	Tue, 14 Jan 2025 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O0/CnCRY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA44520897A
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736884680; cv=none; b=shMZGI9XDsbRZTaqjqDoJ1TCBhKPyB8Rsv1tbSLdyHSuC7RQ8kbVhxXiOl2QhEkkZOEsVDXB2y95t5iuZTrOk8PeTZQrJw1xfoc+TfzGVr1TcmL0kFD9vZv77flON4aSLlgqADWrXlxcUjInBwn6f1wEWpONHr3gA6BPLZkDj9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736884680; c=relaxed/simple;
	bh=uco4gRvl6hckKgik3zD9mvT2NME/IBz66VtRV835Qqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WmA5fQ6OEo44VIt6aEEdu0E/W2vc4SPPuuyngrIAdmlk7Rirj6yIz/qdrAcmBkh5XzzKlM/yjP3zZ1O4SDgOmAQJCVmbdc+0D12HNMmfLAPg2f/f8lxfvBD7zYw1xGiOGiCJ1MwTHeJ6eYHA/7xFVP1TXAVWz9Bz7Z94b9nqmLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O0/CnCRY; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f42992f608so8155465a91.0
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 11:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736884678; x=1737489478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=svbXrpuyJBvyn4dVwoV9M3Gunk6nY/2vQhuIYBlRsgw=;
        b=O0/CnCRYUTwD6rnANdy2826ogLMZX4sLjQrzR07CZ4U1U7WPFlFqcuCuyd6XFZCPlG
         zIL20WZAUjLFf/RPsPKViT005RzVGC5PPWwxC1GyDiQEBxkO+TIKD4jlPB+LLm6OIOft
         fovORnMkivyQpMLyRusmX8wlm3iacn0ZuE2qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736884678; x=1737489478;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svbXrpuyJBvyn4dVwoV9M3Gunk6nY/2vQhuIYBlRsgw=;
        b=KmrTI65hy8sJ5aH0omqHvKdPF4b2EWEHYi8OA++xjLkrbaC6E/eGZnwTjo4ESLT3Gc
         IhQ+lLTw93XA/VzvJm6XvzWXOVUDg2PtUSL5MwBa8NVlegRkaZhXfhcJVyUWvqr9RaYf
         kmaAK1NBcDw3PZDez3qaflQ9O69GMTS27MjJ1NSIvQ6eWEhDcyf/OJc2e8S2EjzAuyeV
         Y2K1aaLC5ujXlXGpupElKdrkpvClb/9Qp6agSHbS7w9slQej1hMiEg7OPh1KaSmKf5Yr
         rCDfxJgT0wjSVLdr0npFGR2nDNWLosjeJU0EF6eLHu0huMznvI2UMce4MCrcr0AAY/6t
         9jKg==
X-Forwarded-Encrypted: i=1; AJvYcCW7oMbbp3xSutKf89Vr+dDN0MmWrnTFpWZF0+LXZqeWe8tZE/9PgfyEgUu1tIFiZ+Eggn9PVvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6F5ypXUO2ynKq2u2nkX2r38SbGsAzXdpIlj2sgko0MqBbwk38
	q50edlSV8U3odHOoyzy+U67osaDdihhkHReme02DUUivLnNvOqhTlEiX5m0t5Q==
X-Gm-Gg: ASbGnct3iMCD2ZcmSfmR+FyQVBU70XwW1SVBQLoFYMg78q+6dx9dtoL0p2rFIbjA8iP
	KCoMGAgWIWspWbDDU6w0DwQz6rvEO7SpXgAoRlUlwMRZwEl2PWt29hnpX0uUhVF7rHLRqJZGORP
	IdNxhIzJipM5Ps3/26KgH2Ooy9IPMLvQUjvUq11SPIQJ3G/g2HiILBkndb6n6yalDw6zQuGIvla
	fuZZMOR2ETv9PRCNeBl71tqq24muPueNmbS3V2q9AmwZhb69iEtZ/q/i+wVw/4wwPjh6y9RIJD4
	aM9q9UbRR9/Lm7XZ4XwC
X-Google-Smtp-Source: AGHT+IHcVnNyLHl81ex069oyW70/LBA/yH2Xd2v4EMnmMQgQfQNQGmk0xRHY4r6ootVpyr9PtUSVYg==
X-Received: by 2002:a17:90b:1f92:b0:2ee:693e:ed7a with SMTP id 98e67ed59e1d1-2f548f429e3mr36547314a91.35.1736884677952;
        Tue, 14 Jan 2025 11:57:57 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f5594697d1sm9855771a91.42.2025.01.14.11.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 11:57:55 -0800 (PST)
Message-ID: <2ae4824b-ee7e-47d4-9a6a-b46988f58cd4@broadcom.com>
Date: Tue, 14 Jan 2025 11:57:53 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: bcm: asp2: fix LPI timer handling
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 bcm-kernel-feedback-list@broadcom.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Justin Chen <justin.chen@broadcom.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
References: <Z4aV3RmSZJ1WS3oR@shell.armlinux.org.uk>
 <E1tXk7r-000r4l-Li@rmk-PC.armlinux.org.uk>
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
In-Reply-To: <E1tXk7r-000r4l-Li@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/25 08:50, Russell King (Oracle) wrote:
> Fix the LPI timer handling in Broadcom ASP2 driver after the phylib
> managed EEE patches were merged.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

