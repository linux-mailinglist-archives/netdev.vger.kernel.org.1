Return-Path: <netdev+bounces-172592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3279A55763
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CB31899422
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB1B270EB8;
	Thu,  6 Mar 2025 20:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZYvLAvog"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD64442A8C
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741292568; cv=none; b=KwdO+WkunYsBoRKYfNKgFrEHN6V3YSz3+ibz3h6a8jf84LwBbRrgTabqblfyUAKOhvzzUX018jIjXvnbKggrbWfT06N2xoh2NtC9u/Y6jIq6dSPQsuEaRm6N4UbN9Z7pLyJx+2nNPUsa/QLsNvKkIb39GKqGoPNbt8DtdN601YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741292568; c=relaxed/simple;
	bh=ON414bEsmI7Kzbpf1j1OeEbswytZMtapoqrVk7J1nB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UU6LavKHlXnTp1rDgV4xpicEFowLMrEX6G/ZGTo49D0eGSMvkAg9OjXEfOx8fSQezzjDFxhdpEDTDSCYHnSjbVs422EKu35y37sknmLUj7LIzEGqOREh4txLzKioX9TZiWumiZQgcxjmH1i6Obd3zEU7Oy9Xp1SU4T80xQupcTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZYvLAvog; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3f681654a31so370114b6e.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 12:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741292566; x=1741897366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0fV4C6ZTzhDt2XWuqBlLp9/cnCQnehn6IMh+DJqT+0Y=;
        b=ZYvLAvogb13GhgT2YyspWBvg+waX3hxFwCu2UWqfhmXmXi27CpvDQfpwyno4I5Vojn
         fODERS6ZApEiAkp5k163bl7xIzVdxAoQqV17zBjjVAw0SPaa3HUfOT0npD2iwbCYI2ui
         318FFX+IAXL9UZ9JA1VhQKP0L/WSrnofWwkaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741292566; x=1741897366;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fV4C6ZTzhDt2XWuqBlLp9/cnCQnehn6IMh+DJqT+0Y=;
        b=PCLYxmjg9YEvXYeVLNlKsixHEKzxBxwMNMVBCjC+3oiRC6mVNLiTmffGQ8f1TB8d1a
         Jd0TZUyk/UwcaQk9jrtiVdt2B3+ojx4y8/c1IB2OaGi2CRQ613zltMEPsTDluqHYnzzM
         GeAQkni8kvLZnOCdWcFZvKU5L4BDxxJnLqyUdPcWoOWDwxqe8/fd2ARu0yVuJuGL87gg
         ToWkPZRvTwYv633XSWL2+A+LbparU5yU5Dl7IQTvUSPEpL/kBQKDyMD5pxcI8qxEoA+P
         aWAHWRR0o4CCO+Zl8saWAJm2OBAwq6vr3BmBw5APLnpxduONnq6tX1XOixQBgnsySYw2
         TyHg==
X-Forwarded-Encrypted: i=1; AJvYcCUBj/dovgtHbz/PoVoQX7HmAE9YvlmDuh8w1DlJW2ZcCWLQ46dW4kp6+zfr0EVE3xBwzXG6BpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKNT+1gwf7oIqxyghBHUnHRKxsAriYPUjCwnlk2TzxRMOPyOWB
	tWUHnSSi0xfyZPKWzeBvoO+zJ0keehsKjTlzlYTuV/qbYslbiUEttGUwGoMq3Q==
X-Gm-Gg: ASbGncuXJ7aqKJR2KSdkC2QnFzVPeXlz0zsvPb8bostBC0dN7L/wkoL4IJm0a93Sa1G
	AkFVOtpjuuxOtdK0/+jcPpEMUU3AKnuQRb3vPmdLO7Zr1tvHTxJR+WxtXLSfwjciamy6ZbO/ATw
	9RV5SrMkCrOpgZxWSmuFqPHT30TtTd45tZPQEh5P2L/dbWB4nPvDmadhGzhjzN6CyOHxGiO3kfJ
	AGePOEXtk/sAx0eK5iiheRerFxIwzqQRvfZWh0GDDGpg3SeBhp91PcppgaXfCvB6Xz+gnuqk9hG
	sOX0UeILv2N0yct90XRwt5viciLsSFdMuFSBCUXvySp1dc8+HO0i9RilUtxskATBTys3yXtCTSS
	XRcKAjqFO
X-Google-Smtp-Source: AGHT+IEdLSMTM+U1dxEzVQjeAw8cYaR617NV4bb1dBf2bLmJ2qMuhMkOJTz+bmv/KTdq+0eV6JjHpg==
X-Received: by 2002:a05:6808:1409:b0:3f4:7be:818c with SMTP id 5614622812f47-3f697bee1f9mr476916b6e.35.1741292565899;
        Thu, 06 Mar 2025 12:22:45 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f68f044f24sm388851b6e.32.2025.03.06.12.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 12:22:44 -0800 (PST)
Message-ID: <043c3b07-499d-4929-b8ef-fc4dfedb3f84@broadcom.com>
Date: Thu, 6 Mar 2025 12:22:41 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 11/14] net: bcmgenet: support reclaiming unsent
 Tx packets
To: Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250306192643.2383632-1-opendmb@gmail.com>
 <20250306192643.2383632-12-opendmb@gmail.com>
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
In-Reply-To: <20250306192643.2383632-12-opendmb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/25 11:26, Doug Berger wrote:
> When disabling the transmitter any outstanding packets can now
> be reclaimed by bcmgenet_tx_reclaim_all() rather than by the
> bcmgenet_fini_dma() function.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

