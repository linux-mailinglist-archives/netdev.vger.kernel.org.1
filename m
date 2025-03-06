Return-Path: <netdev+bounces-172591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E2BA55761
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA201749DC
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEEB214A61;
	Thu,  6 Mar 2025 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DMUuoxbG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7A442A8C
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741292520; cv=none; b=kdSdZhnXRVLukGrf+OXEkxNtIemAPDosKTuF4ftKRzsvKYHOKFgmq5aHVXa1L2nArCLyRuBdixyP4F9ucxGpag1wuetHgvMIQOMsEVOGq3a5HBzsSyg4d5Esas9blIoQB5b2MHDV92dluppD+3XYRGPRh1cij7xOC8xIuTpbREM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741292520; c=relaxed/simple;
	bh=2VBd/zOJ2XdcIZrA7YFIi2LRzrpj2tn9lgvafsi2Mtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGGGECwkB01x3DZvNoyNBkuANjNwQ5luhs9aBBDTXlnZY42/p0BbGUzwNdV/96kzAiL7YcHLBEZv2/PsoQ5Rj+PpNfRrWP/l7g0Nn1OXciXJ+0XmL96hiyGTMrV4dbusUJaGDeZNJ4c/MSR/APrYBuDnVXeVkMM0FuvqlO38bsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DMUuoxbG; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3f6818bec2dso618607b6e.3
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 12:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741292518; x=1741897318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0I6ZAzFQiKIMiN6FpQnZXDpm6LT/UC8GICDUZSyRC7A=;
        b=DMUuoxbGdGk0Hi+1COixB4OQ9A7ibF4guSfPCTp7OiXCNokmg8IdZjb4w8uLlY6A+v
         PBWQoAKxCtJJX+U1Dy/gQMU71/64iucwB9JMkLfohGmC+u2x5gzklW8fQvhX/YTgW8pi
         xJcWukmH62di5wmLa2+PLmL4LQiKW2eIySoWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741292518; x=1741897318;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0I6ZAzFQiKIMiN6FpQnZXDpm6LT/UC8GICDUZSyRC7A=;
        b=XYZoClSCcRcgXU5DJL6erZ3PPYvTKF6cmInBI/1npfBpJgvIAXOKOdo1MuPGsPSApj
         DTnC9Zt6io5qddeYqCt+5DJPkRF2OYt+y5Xva13L6BhOchy/qXwRIvFTM8fWluuBm7eK
         rFOIFM+z4p02fECQoSnndb+ufRsQyR5DPQTCy8bJdhmljeMmeDy0/+pHtrulbashK129
         iSWoCamEHLbs0f6d7HgdiX6klrV1J3N+eWAMEKyGVTK339uaJTUFGMqEZ5d+bjQZExuQ
         SzWFhCQlq0R3SYQQXEEzvcDWoR3zdM6f70QfIgUKx/h6am85PRXPcr8hE3dKzNMiyhkN
         vF1g==
X-Forwarded-Encrypted: i=1; AJvYcCV/Exc0kcNLi/QuawdKJPD5O1zWA0aLkQC+e2XqnIZ5ROdyIHhFoQqlOD+KcfvwqtdoLbXsozo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3DTKP/UyFV/3JRztcD+lTNm2ZTkgyCaH9zB8OOQDH6Y9mgzDf
	o+GzB3mTHLO1aaRFXyFPNegIzqzgkyN048wYLXiuRfwDL1GjmHbHFEKwmR5Uiw==
X-Gm-Gg: ASbGncsaygsA0IQTkuG3ii0FXZW+OrdPH2R0N6tSqxP+ZRcnUwlQgH7rhGpYcnaV+Wx
	zb+LnL7re/QcKp5SghLh42yud2/mkaMaCXgtRlvm5n3RvW+FY3EtOijNFPtBQ+zzuRzoiX1szMv
	syNe5tQySb3HU/MJWmFzeswEB+6Fz2f2VSAF7kwsdpft0x09r76us2M6UD7YZgSNVx3UISK6Cne
	0wjOrrgByG57PLMjifl22aYeRArC1YAnwJ6ZijT8fSrdZGZgzC3QjCkhCYbWXc3vD3WTAvYcvS2
	TSbKPhPuQvEnNTP7NlhZoEO04EMAXl/04TVMa+eLtU4Xy9bM8TY8v7iPrr6+mO/XohH1mlW0Lo8
	9jqPkhgni
X-Google-Smtp-Source: AGHT+IFXR7B7N4mLArY9Ygzzid9PoIdr4iYXV4Nnl9a7SskgK9QfJbLBFdZMRIi0ZfULxmRmIdGzPQ==
X-Received: by 2002:a05:6808:15aa:b0:3f3:e3ad:f5bc with SMTP id 5614622812f47-3f697b643camr582557b6e.9.1741292518676;
        Thu, 06 Mar 2025 12:21:58 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f68efbcc4csm385309b6e.13.2025.03.06.12.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 12:21:56 -0800 (PST)
Message-ID: <25b342f3-1a41-4c48-9f5e-6e00f3e3c425@broadcom.com>
Date: Thu, 6 Mar 2025 12:21:52 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/14] net: bcmgenet: introduce
 bcmgenet_[r|t]dma_disable
To: Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250306192643.2383632-1-opendmb@gmail.com>
 <20250306192643.2383632-11-opendmb@gmail.com>
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
In-Reply-To: <20250306192643.2383632-11-opendmb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/25 11:26, Doug Berger wrote:
> The bcmgenet_rdma_disable and bcmgenet_tdma_disable functions
> are introduced to provide a common method for disabling each
> dma and the code is simplified.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

