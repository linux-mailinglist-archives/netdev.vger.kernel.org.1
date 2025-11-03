Return-Path: <netdev+bounces-235186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F7FC2D490
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 17:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28DB046309A
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 16:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E19189F43;
	Mon,  3 Nov 2025 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E0jtBi4C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C531727FB0E
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188535; cv=none; b=DVpn7tdASZCDgHcrLZkYi1k3S6HXpixMZ4wY9cleCIgStGYfBJnz1JlafVu+rNJ8z8UT9T3ek6/fqA1/lXTd9rmNWujMsHjLcotO/gjSrIx2OU3q/LaAhFAvy7ZiUYqJMp4kNa6qZgjedjn5GUMHLWHqGyz8zhy362UczaW1d4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188535; c=relaxed/simple;
	bh=Kx/3UK2ATvOwLdoxaPKJfnie65Cy3XdnBCgcPNE6Nlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMCBorbbEQJv/+eGU9INVr2ezBYT1GeBn1t/7FSfBvfU4E9CxUO5vRg1GFqaO0NsvDFciTdHvaYVn1UGa+N1x7wAhULn1cx5AqtIyuG8i022lBMMGgB7m8+KY7lIEmTLkR9S/JrohT9ormJhcyhxJ3i62cGHAhmNAzX/Y5fE/bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E0jtBi4C; arc=none smtp.client-ip=209.85.166.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-93e7d3648a8so187865839f.2
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 08:48:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188533; x=1762793333;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqnmc5hjtvFiB5sik2+Li461LIA6YCCGre95K3wVVkc=;
        b=AWC/YyjQQnuMQU3gauWIfvbMuYQeF6SW06oXj2SjxE9J82iCA1fJCzGHKlUERHb+iX
         lW5S2iHSQ2RkCUMNW9rhXi4JyV6lT0E7W3dS6xRQiUEAlEYCtAhZ1C3812Y8nXR7KMww
         rERTzTu+vY/Su+iri19hlpnKRcvLPd9l7nqO0ZkSY+gQmPMYnv6UPFera9NhSkNFW6aB
         Jz0UpOjI2A6wl4EvbX3/WNA21ES+grHkzBBTw6jzPJNwVL2dleSGVQXYZQzpI6ISk0hT
         vhcwQ1qCJOYTFvL9GtEC4gsZoN3PnYLyuCoVwW0u97k3+6RanUUig9YRb56kW4dFWYNQ
         UDyA==
X-Gm-Message-State: AOJu0Yw3Qs+hoxhhdV7ZujZIu7v5QKlQeYhAXPFgXDMv1lD5ksFx3jhh
	PvB9sYZEU+YfF7SvPQD9hOhQxJfX4rjrOcHsfIrrwl4Zf+3pL5yQSiQVvfklQzE8W8pn4cu0gtL
	/VJeITwxaAS4eUaTWH/NAFZcTJlaupFQDktjcyoHwEbDPHt1p8BfMKeLqm+fSjn5+a5lcbqkKWT
	vUPmjULqO5/28q/ZGtapJwfAYXBagZRJpNlFUgF+GIAzubbXkiMknyKdMqbqt5Qj5XN54jQiGyI
	Z0nOwrYD1FkZemV
X-Gm-Gg: ASbGnct+qepYrvlnirWMqXfg0XXvnTT3NzPs4yMjRMyiAEAcUgS8RzBKZskY/8oMPuy
	6LsMBcoCGwevHFqP3qW+mkkPK9W6OrDZG/twsCE39+qWMjshwK56ZD3rGtQ01/AQqRodEsV0GDI
	cfTaqZDDuuQFM4b2vM+EfALqTYy8uH+JiRoDdUqVhKkWg8wFR3OXVqBn+ckkJvaFuQgM45xYW0H
	ZwimpcSCBect1JVn36ValNk0hHRVKVFu79wvW5xNZ2xYOC13Q1+I1FGISB3ouGjmX5sxBNJn60G
	1jwxDTM4/lwRvUzGdWbOcxoG0sk2BGQYKk+p6JjebfHzTFlN3cCjZIrzl8Nk1MeKTsseCnQuags
	FiJRskM6QxB7Pt4iHy1bbcLgrI3NorB7+9sOG5Uiv5J6cxMOKMEJxJ5u+37BNgeV71yoGQ+zJMK
	/ML6Fc5wd8FR4UYpFJv/MOAQ15jVw+rfZCUEeJX/nPHQ==
X-Google-Smtp-Source: AGHT+IHrvxCIQxzt+sOaI2nmHc2Q2m7245T4xya+9ZYEygMu6ankdbfDmliqD6rXWKpvk0DlVNRH2mMGjkeT
X-Received: by 2002:a05:6e02:1a28:b0:430:ad98:981f with SMTP id e9e14a558f8ab-4330d14382cmr200149075ab.4.1762188532661;
        Mon, 03 Nov 2025 08:48:52 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5b7226f55ccsm98602173.27.2025.11.03.08.48.52
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:48:52 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-89f80890618so1976837685a.2
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 08:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762188531; x=1762793331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pqnmc5hjtvFiB5sik2+Li461LIA6YCCGre95K3wVVkc=;
        b=E0jtBi4CO/wGjNUsFCNFS4FVXa4YCihDBWmDm/MiulebVLiMHxHe5w9K8Ru9O3Fsnf
         R24NYn1eVHnlta+T/ylpUhjo0Wi43aFmrerDZd/O9NUsaxkWFJYG/zXl7bZlGn8N30Bo
         dZRybjjae+oiivCRV5PAO1FXzdhZI0H5EvPq0=
X-Received: by 2002:a05:620a:1922:b0:8a1:c120:4617 with SMTP id af79cd13be357-8ab9ade562emr1585795685a.51.1762188531398;
        Mon, 03 Nov 2025 08:48:51 -0800 (PST)
X-Received: by 2002:a05:620a:1922:b0:8a1:c120:4617 with SMTP id af79cd13be357-8ab9ade562emr1585782585a.51.1762188529424;
        Mon, 03 Nov 2025 08:48:49 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f75d7cc7sm16533085a.27.2025.11.03.08.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:48:48 -0800 (PST)
Message-ID: <8655d193-2eb2-4bd3-96ad-c7615ffc7ed1@broadcom.com>
Date: Mon, 3 Nov 2025 08:48:45 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: dsa: b53: fix resetting speed and pause on
 forced link
To: Jonas Gorski <jonas.gorski@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251101132807.50419-1-jonas.gorski@gmail.com>
 <20251101132807.50419-2-jonas.gorski@gmail.com>
Content-Language: en-US, fr-FR
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
In-Reply-To: <20251101132807.50419-2-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/1/25 06:28, Jonas Gorski wrote:
> There is no guarantee that the port state override registers have their
> default values, as not all switches support being reset via register or
> have a reset GPIO.
> 
> So when forcing port config, we need to make sure to clear all fields,
> which we currently do not do for the speed and flow control
> configuration. This can cause flow control stay enabled, or in the case
> of speed becoming an illegal value, e.g. configured for 1G (0x2), then
> setting 100M (0x1), results in 0x3 which is invalid.
> 
> For PORT_OVERRIDE_SPEED_2000M we need to make sure to only clear it on
> supported chips, as the bit can have different meanings on other chips,
> e.g. for BCM5389 this controls scanning PHYs for link/speed
> configuration.
> 
> Fixes: 5e004460f874 ("net: dsa: b53: Add helper to set link parameters")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


