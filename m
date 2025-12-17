Return-Path: <netdev+bounces-245249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F08ADCC9A66
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 22:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADB4730399B8
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 21:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD3C30F95F;
	Wed, 17 Dec 2025 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bZo4Z866"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C63630DD12
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766008534; cv=none; b=aaRUo+YS4sg2E10zUHjlcvnwz8+vEOfEryqS3m/uIGYSFoWBzP7Pru1ndN5HLv3LMyTfJhkImLHDBpFNIklA3MNrBgtOVTfNaVm3pq+bOIcGHzTUIkxgvr4p9JF+JFVTv6IWRavYewmI7nIHQAwJqH7AZEiY4+d6w7X0kT1PrYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766008534; c=relaxed/simple;
	bh=8T8W96eTJCxhSN+CFeu2gxRyFM7jAiDwsLt+4C/rw6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7Ua02M90X8her5WEiwOZWNCI4cfe9ppm3Ym0HjcK++ldf39n46Lbn6+EHuGcfKwgVYL7yNJXk3PD9pz1NwnZty327tgZHhxI1e3sS9Nlla7SlKWEFyfIXwB9Kq/aak5d6YLPGgtxN3EvxSE57vmvZRFf5pC8Kai1g9HJlkr+5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bZo4Z866; arc=none smtp.client-ip=209.85.221.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-55b26332196so1857727e0c.3
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 13:55:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766008532; x=1766613332;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aveKwRCblTq+fpsGsYnFrsRpm0V+YPvEgKy0+wbVdM0=;
        b=lGbcuxOfFGUFWNOVEThViFN+/VdUBt+eX4l316DBzWNrZ93cdFzYYeqbA6MhmHvBAw
         Lm8Ro5nLQbtmYHeXeUfOW8pMYSbzTyWqseC7PHQWXtib9EUhrNq+tpHCFd0Hq8gYkM5n
         okB73h4lsH/rkRqsTLM6R9clrC4lR6hzya5Iy8jNiPcm5FbVNhSiB4zQ8kGuDWB/U3me
         vjvNA3++HS3BOYwlrn410urQPkMLrWRq8P0KtCLd9VTtOnOxLFZB0ZcaIMutFHUszXYQ
         2wA5Ne+kRyPxWK/E5WOrdpKOZBuk2HQtJbqTQfIpKOinlFiOgAhtd2/COh9XXH77S6tm
         JfFQ==
X-Gm-Message-State: AOJu0YzKSrUIvCg/jaEOauuTzpSCMyVrmmuHmuA7U4emREZmV8nwWmsf
	ukwHHTVkF+pY1iDj3YZTJobGhbV5qPYo8+3pA9hdxuAJN5Z+vBGHB2gydrptyr655AD3Vzflqaz
	1oO7D7MM4uzZ2aCmD5oIiDWrixYD6HRvcL9Fz2h2RdQwbrZGd9IzLDd9c2wKtlTQ9vsGM31VCWE
	oZX/ZibRzk0tbp9/MyFLjR+5S3y4W5c+npyB3ad2VtTLfSQ8OF7XREtbL0xIeXt5CqsIyPqgxv9
	n6kf8Qtc936G72P
X-Gm-Gg: AY/fxX5tbR3m4aIvyxSoXUdRH+2ERs1hG6BEh9ntgAOiR5ptaW8G1wCQK1sinmjpfqC
	MEIbZEtessxEnX5mw+kszzxw2htO+ZQIqAQpwni0v+eBeowciOOaH6jwp6U0fvRly+ly9wOyGYa
	gh+cFXQNJfvGkMU5ueajykO17jIQBVIvt0Jo6kdnUHRpyhC93onI2fOQzBqNZzAWH711Ds4u1HN
	iFqHony2GYPXsoJe+JMR0tGMSa2FR7iBAELO65fOIfg5PpJ0jlMuKRJanlnfKFWjFu9ue6bMFpb
	zeGTcnLQpovoWxw9J2NIglaE59y3N48XPZaae5k3J0kdtN8BWMDd4i5sY4AhkCV+Dgpck6aqJom
	qWXnQPbpetKaHatpRnZn531VsVVWM5yLqYbUOVrvF0efFuPrKPZkoTF5SQ+mbfArlhJG2RFx2G9
	nMqMFavx2DUNJSmy+SnQTzvgUNgTM8XRJYNfzxrS+n7ymnFIi7ug==
X-Google-Smtp-Source: AGHT+IHZSLHv8XGTjWcXOlBKirlVE0mpZZ+0Eaob4rUE3VC4LTJxCwCkytx15EuaoUy3lFm3GSny/lTOkVT3
X-Received: by 2002:a05:6122:d81:b0:559:7294:da85 with SMTP id 71dfb90a1353d-55fed626550mr5890162e0c.12.1766008531664;
        Wed, 17 Dec 2025 13:55:31 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5615102cae8sm54472e0c.6.2025.12.17.13.55.31
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Dec 2025 13:55:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ee3dfe072dso160357581cf.2
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 13:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1766008531; x=1766613331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aveKwRCblTq+fpsGsYnFrsRpm0V+YPvEgKy0+wbVdM0=;
        b=bZo4Z866EmsCgynSXObNzVW6Mjpu40GnapnJISkpN2bRxbxQ0A26YAZJE25I1CmYmx
         iGRJJHClJQcIgUGuT4oMIGSQEFuECbSscLvJscLJ1Z23v0ct73/LFCVxNOhQn1rcUQ/I
         7GvNkFjlklxF6Qufw97UoHI+dWZCcMEL535OU=
X-Received: by 2002:a05:622a:a11:b0:4eb:9df6:5d6f with SMTP id d75a77b69052e-4f1d065088amr271829991cf.74.1766008530723;
        Wed, 17 Dec 2025 13:55:30 -0800 (PST)
X-Received: by 2002:a05:622a:a11:b0:4eb:9df6:5d6f with SMTP id d75a77b69052e-4f1d065088amr271829821cf.74.1766008530331;
        Wed, 17 Dec 2025 13:55:30 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f35fca94e9sm3129351cf.11.2025.12.17.13.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 13:55:29 -0800 (PST)
Message-ID: <152b1e05-b330-4869-b69c-4d39c91a64d6@broadcom.com>
Date: Wed, 17 Dec 2025 13:55:27 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: b53: skip multicast entries for fdb_dump()
To: Jonas Gorski <jonas.gorski@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251217205756.172123-1-jonas.gorski@gmail.com>
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
In-Reply-To: <20251217205756.172123-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 12/17/25 12:57, Jonas Gorski wrote:
> port_fdb_dump() is supposed to only add fdb entries, but we iterate over
> the full ARL table, which also inludes multicast entries.
> 
> So check if the entry is a multicast entry before passing it on to the
> callback().
> 
> Additionally, the port of those entries is a bitmask, not a port number,
> so any included entries would have even be for the wrong port.
> 
> Fixes: 1da6df85c6fb ("net: dsa: b53: Implement ARL add/del/dump operations")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


