Return-Path: <netdev+bounces-172576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755DFA556FB
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8D5177181
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE79B275604;
	Thu,  6 Mar 2025 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c+N9fIU3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D2227293A
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 19:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741290090; cv=none; b=ZPzajLbkDo3YVX0A9HmY2QbRo+5syuenQb8S5F32S5BHC873Pb+arzTeQ2eK+xyDcMCQOd1P4tX9ozZomaw9wBtHLe8dTZwh3w4cfc/ILiTYU1jNxCVMfJ8/ZqZ/m+x78zlkGVFrTYfYI6v+0/RF6E14sbeouI5puZ/soR7NY8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741290090; c=relaxed/simple;
	bh=y/V/CLMeFMS/FTObR2hEcghnDfS4RineyBdZ5y45icA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DzSIN/Ayz+5zhbVXJNA5gJLI9ybqWYDMq9G+F8L3s7v7GttGxSiVk4dLbKAgIszkoPEMis8W0WHMDJ/uXBPy0ABHiZA8u768U4Ab0n8vGmMjSQzxywaiubrPn9zjcOaEX12PltQtuO+ACHKJGIH5tPXDdzdjz0HsjkMNT3sd3DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c+N9fIU3; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2feb96064e4so2357385a91.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 11:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741290088; x=1741894888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pQ2wcbuRBX8hsDA1tTTJQAirz+O88OiwaMT/AYU5i2I=;
        b=c+N9fIU3b1UsgjDLNytx7xNkCjjeKork4T8VheTnVCGFMrOYq4L6qSa3+1NaPmssv3
         kIUO3w6qcW/e/sccMUhwthxWlt8JqbJnk131A24D2SHt9trbyvXFTR+GWu3pGxhnOkzq
         LKJQrWSgoVcSNoD1AJoKUk7qD8R+GrHw4SfQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741290088; x=1741894888;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQ2wcbuRBX8hsDA1tTTJQAirz+O88OiwaMT/AYU5i2I=;
        b=pmrgRnGkyBpH7gzhY+7lSiNbqwtYs2Jog7nBCgFiTmnJioldoDXBSecPVL3dUBHXrA
         L5J4BP+xvtdcCsHUgRoZqgKhx6Xd1QpzPfpDeRkqSdG/5bShIdydqsX+5n3IhZzoFiyC
         ++ocma91/WpW8+hJ5OTPFf8iCRa34oM/j/oyTPfUshq/rVtH2ak360rW32xn/pgo+xeU
         IjQmMF2VAqSWpoamDqmAjUyXi7vjz+WBLLuHRXf9nltQAQDT/jKzHXuvDFd2KIvfBj+j
         7QDlF3GoLo0uApb7F+/+InswKJXFHZAYlqp98YmEQNBhsEfS1K+lswGx5xhT9erz1OHc
         EdCA==
X-Forwarded-Encrypted: i=1; AJvYcCWB4E8CxSo+5JXTR2Y1I21pdgvo2uYO4cfHawJwxu5D5MXAUIwKrUukZ/9UccGiXyc7+Psja8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYmunJuCb1l5AVblRoS2rHc3hhSc3oRztBxWXy7aJSISoeR3vm
	fumWovj/mv/OAWha+8z6WmC8BFyBTkRVA6TT40WzXBUKI+1D8PyPyN7wFUUukw==
X-Gm-Gg: ASbGncuW1xB6Y79kiVCwDKpdguwiayI9eCaH5fIAYD1rWWVnJ1cK6YcnDAiKx9JCm3q
	wjDtx2mFe3RJicxZQ18Jh/5//psMOjFxD8oRwhqnN1HrfYl9PRr03h4uwl84o2p0hPcq2KprV7W
	UuNT+Or045tqTk7VpKQecpzWbbx4SzZ1VmwiqqFC/mxh/XpoYK5+uXHSY1lUVwnlr48L7uPM6jV
	p2RoQEdiST4gC7j3gSPSH4yzWXMojBj4A+KCESGxR6XuI5My7sBrhapgh55QLfqzHlQcn4Lflxw
	cjs470M9y48BiCMUaJH21oMb6pY+R52PHNmGNhbER4qEYLRC8/YiSpLg5v3XeuY3C4IXlz12HJ2
	zdh7iGVsx
X-Google-Smtp-Source: AGHT+IGQUwafRVoZnqWeYj72Jh4uvn/J3l/GMn0S9sYQsdMjTSddIwSEC12Wlbn1p/nFklP9FQnQow==
X-Received: by 2002:a17:90a:e70d:b0:2f5:88bb:12f with SMTP id 98e67ed59e1d1-2ff7ce84cf7mr766261a91.21.1741290088583;
        Thu, 06 Mar 2025 11:41:28 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693746b9sm1643765a91.27.2025.03.06.11.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 11:41:27 -0800 (PST)
Message-ID: <e5085f66-b2d9-4acf-91bf-22ab8f9c055e@broadcom.com>
Date: Thu, 6 Mar 2025 11:41:24 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/14] net: bcmgenet: move feature flags to
 bcmgenet_priv
To: Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250306192643.2383632-1-opendmb@gmail.com>
 <20250306192643.2383632-4-opendmb@gmail.com>
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
In-Reply-To: <20250306192643.2383632-4-opendmb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/25 11:26, Doug Berger wrote:
> The feature flags are moved and consolidated to the primary
> private driver structure and are now initialized from the
> platform device data rather than the hardware parameters to
> allow finer control over which platforms use which features.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

