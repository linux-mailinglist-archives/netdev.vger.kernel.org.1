Return-Path: <netdev+bounces-172589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4458EA5575C
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17E3E7A8849
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE351270EC3;
	Thu,  6 Mar 2025 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QjkCN2Bz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491201917D4
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741292246; cv=none; b=OAX18Fh6B3wH3B8O5jTbTra2MiP2nMG1YZPUI57ZLrckAzb7CmLrPji1Z4BS+bWZjdJwxoixK9Kz2WYDHpR7D4cmpMqIpI/SV2q6jpLrhSqjVEd6k5XZTHzeDlAaQH5q0WcTUjMRE7S5g4/6p4XPYJXuMG0CagZvKiaUpWM5CJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741292246; c=relaxed/simple;
	bh=bZJD28Zt6ckrz/EaCYxt0/rgRorBY+vrvI+fQJvI8cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hpNpiR2QGgxlRDj0AywO3Qq1SXR8JWsEkxBrzUAaWBQCZ08BwqNnvo/RiVCvNWWTtdJsP40QAZA5rTjDDRhU1xIPQBwdH2GRHXpTUi1WDlC9HVnceSQ2znVct71H6SSJwBhPH5Noms/FcgRJtQul5H6Unm/wPt6Z5OqM3u8J+W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QjkCN2Bz; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff04f36fd2so2086521a91.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 12:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741292244; x=1741897044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iX0wn5QCzVFoga/nZdHBQ1w4hpZt28dnfaWUfHO7hio=;
        b=QjkCN2BzubdjIByfz4v0eWYP9XkuM5MLHEKPyNOys1XV5xAP7aCqG3OWakzewSWCNO
         t+zKuOq7xMN7GnGgdJQ+oI6IDEApNSD/OGkfNa1Ri/r+3Znw8LUXQxVbKH1IsUjRnWZT
         4YvpUxIU6iED7iVNIvMt68lwy2HBt1X8kgdBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741292244; x=1741897044;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iX0wn5QCzVFoga/nZdHBQ1w4hpZt28dnfaWUfHO7hio=;
        b=CB/10sc6vSzMj693t/0dzt3lDHQHTVloJsWbCEHFX4Lo9P2Qhow94S6ToxU6fIc+r8
         +n/eT5XM6DwSTQ1iwq5N+LsMNRONll0IUPnIO8GxBeUJJ3BanF31IjggG7k3HX2r6o8v
         iko7F9HiEleI82LpXkPSqIxNbUFFNt3Ou4MHeUMN4TYsIjoVsvChJ2GjuNC01Pjpl9fw
         g4aOYfV94Djz2ugSG+sXvsq7ccW37hn5I51JJOPvdsoZTjpwNcAc5W7pSha2SFkt9LYR
         VDnQhBhtfnaA23zAV+9lsj19qQGE+es9DTse/SteomZ146yKDRj/VkWHzCCMoNujzp7f
         mbVg==
X-Forwarded-Encrypted: i=1; AJvYcCUi0Q0oWp6nzPfkgvu/swvMMYbsLgXxgShsUfJKXUMpftPxkfy2G6I/wXqmgmSl3HgNGcT6wPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/lr12fIQUJ0POnA5enLPRYwCMRQXo5SiGrIlw2Xv/k+LAqZ5x
	+Er5uJVMyOw3eVMYBqEWWBdtVtjVxllumqTpuiPYIwYhkLrbFDHsLZLKpnOben9622Gc/eKO5xY
	7/w==
X-Gm-Gg: ASbGncskNv/rMWbgiTVBapwWNK38jasABtN1V/o3Ms0Sma7Eyg9pGJS/J9AhGLO/Fzy
	fGP0xtqR5ieQMdKMfrq0fpr93oUs2FFvz1xUII4GIsZQ3Mgch8rf8d8IsFgA6VCJcoSQ5XgNUyr
	iM+DIQEh56Od5qB8RGSm4Q4o8T8SMiX/rRmZA3hrGFjD+KZDmng02f5pMDJvu1YPFMekjzTIxmv
	M1dF0ejoSWhGg5or3Wom+sAVbt/bXLAnd57FOtsHDOXI/cR2+ifIxSqza7ZzbIUNSEcN2jQLRGq
	DHJhvtd+FDpkgDTFPcwF9SdvLFawl6+SN74FP1COSAExDU9WjDIAO28wYjMscP/cmTIAEdq6Lmd
	5Ie+UO01h
X-Google-Smtp-Source: AGHT+IHhnVkKPeDtKg/1NvrxXfBJqsbq7xB40pX5aD7MHEunGsjbG47CbXtL4SZHPSEp/4IMBjTOVQ==
X-Received: by 2002:a17:90a:d2c6:b0:2ff:4f04:4266 with SMTP id 98e67ed59e1d1-2ff7cef5c11mr773286a91.23.1741292244460;
        Thu, 06 Mar 2025 12:17:24 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa8a86sm16511025ad.240.2025.03.06.12.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 12:17:22 -0800 (PST)
Message-ID: <e9ef0d6d-253d-4bc3-b10e-dca255f66ed5@broadcom.com>
Date: Thu, 6 Mar 2025 12:17:18 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/14] net: bcmgenet: remove dma_ctrl argument
To: Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250306192643.2383632-1-opendmb@gmail.com>
 <20250306192643.2383632-9-opendmb@gmail.com>
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
In-Reply-To: <20250306192643.2383632-9-opendmb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/25 11:26, Doug Berger wrote:
> Since the individual queues manage their own DMA enables there
> is no need to return dma_ctrl from bcmgenet_dma_disable() and
> pass it back to bcmgenet_enable_dma().
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

