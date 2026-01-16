Return-Path: <netdev+bounces-250393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E0BD29FA8
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9513830ECAB5
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E0A337BBA;
	Fri, 16 Jan 2026 02:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SvzKoWpN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F4F339857
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 02:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768529426; cv=none; b=Y/fA1KUC7dGNb17eA4CSyZBqOuLOjmY4mRb/6iEWGsCLI4M321YcPDrBZ5etKg9nRGcE272nftEGoH6bnH57FXjTslXeE0xiidqNGZlwnS2pNEnrDrXY69Hd9G0y9CJ1+EVmGTU7yf0/Q4f7EJ2eCIgIRLI5wd5RoQBtqbFzcEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768529426; c=relaxed/simple;
	bh=g929HMVklkNHoTFAy2IOIxAy3DG5hqNYM/CxdyJ1yRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9kz2Mkh3hUOItFkDx3nz91nhGzODkXVObMjXcbQ763CS/NMNS54g5Ie9m8jDFKWfQElFZT8bTNjguyE3RglpIfA92q1QOMqY8Dn79J8g2IQfe8U/r53RgWVV+rDwIGaap9OeNFsvTCsLRYQ7aJ3X+HeZT8UXg3VpPCPBGrEK18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SvzKoWpN; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a07fac8aa1so10771135ad.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 18:10:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768529424; x=1769134224;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pkVYpE0K9JGX58iBRudRy/owMWV7i4R8EBkTdtQjzuI=;
        b=jkV0QgAN/mhgjc0wqzId2jSxQGI6p5k6Qg5VxlvCwUgelQB5sLA6sv9BeFvBGMiwDl
         Qp+1Spfjt1ASsiGdftQXh4pTa4gN9MR0ScvupmLoXh7Fm1xD+1Al8ICg6EHvBVK01OVE
         zPRz5/DVQq+kOpD4dQ2+vEy4qe00SelN9pWcAgi1X34mNcu/1G7cMrBg0dtrNhtHKMzr
         XpGs5nxR9dngIGWnIVRv72vXmgKzGs8LUbLOipi3iCrB4wtUqfGFO72adpDnjC6+0SXJ
         iU6iRjzy4fnDna2zseQ94y9tt4XOS/E8W54LdQ8MFXJNJWN+Y4+B43NjIEvBlcVI/wpz
         Ajgg==
X-Forwarded-Encrypted: i=1; AJvYcCUjlJp68K4VFXJnZ3lGtpPu7PmZJhxqxJGGSNM8Okt1RlhprKriD2fRvNVmAg+4O397yJ5aeZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMmUi30Fo396n2fuZZxTyvHYt58TefS94shp6tl5x7JBOrMUaS
	l0oTNDlxlpgNg36PUz8wJ/Dj/CTOZ1dplHq5NCf3Qt3i1wVPhP5yf5FRGd+xOfXCoqs14mi0olv
	KgZCl4OnA2y3kqKu4/TkcGcxgzSC1HaKBrfKA60OnBQyOBgk7duQ4vvV+ixcokqtHv4Mq9ASFyI
	ZIRfkRyQYgEyblATpT8E+Dn7wesM0F5vQ1hMm06RvCPax+tFYwxjlaxSN/7dFao7BxyXRe+sLLH
	sBubdoT8L1gfaXp
X-Gm-Gg: AY/fxX7AohAV5mRzbDeVu/4m3he8LUEC0aBRGUIdh/1pYB6TUROTohP21ejNOcfDSsv
	YXnW5EIruseeeD21mZ28x0NTVKjwUkN+W2ncBxP9FYc8Yk0ShHzH8NsaIkwKH0JK+MRZy5816Er
	fITdSVTvt+Bg6HDLgZ8VQQZKAFRN/6aoss1mWpsUbOsgy1bNWgmn1ik6uUkex5oHcIqQmTpVJzJ
	4Jd0R4mK2W4RhadyErccdJ+4YvnkPK9VASe92egJKtQ3YVQ7qkDQejB2lrkALXMuHEbfy5cV+vv
	z3R26B1cUb0pkdhMA31WGcv5+0hHb7KNH1vefeCoGWNKsOp+f8xvLtufGW46TEzFhowYvCQEeMe
	qytP9Ad7dd5nFvuZJrG5Xcim+TE6hNgURWYba8H3wJLlimXcgVbr6z6u2amdDUJoy8EafxI4xXs
	2SVniUgpam1EmnJpDxJX/DE++ADc2mF9nW7LCrtGyTctX0Piuuwg==
X-Received: by 2002:a17:902:ea03:b0:29e:c283:39fb with SMTP id d9443c01a7336-2a7177cf550mr13410125ad.52.1768529424493;
        Thu, 15 Jan 2026 18:10:24 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a7193ac321sm1303535ad.60.2026.01.15.18.10.24
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jan 2026 18:10:24 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-122008d48e5so2849498c88.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 18:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768529423; x=1769134223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pkVYpE0K9JGX58iBRudRy/owMWV7i4R8EBkTdtQjzuI=;
        b=SvzKoWpNlrsQ4ZPjlQ1H/MxSGI8r+5f/FbIXjT0KJnbWV9ujBEWjAK1zixQrKBSiB/
         F6aVkTGpfi12O/E039ObSSB3MyNSosdNo/2xZ0/dAMHEg+DdzB3K5y82gQU8qcQai6h4
         Rqfq9xWP2Y3bwhFtThGLxpip7BvHrl3flI0ec=
X-Forwarded-Encrypted: i=1; AJvYcCXqOFFQ86VGNqdtloEA+GBqmqQqqMaWbSmMcAKbf+o9fwWjzZsg8x2kRqwzrmCKHPOm0wusSac=@vger.kernel.org
X-Received: by 2002:a05:7022:128e:b0:11f:3483:bbb2 with SMTP id a92af1059eb24-1244a72e2c6mr1704241c88.12.1768529422856;
        Thu, 15 Jan 2026 18:10:22 -0800 (PST)
X-Received: by 2002:a05:7022:128e:b0:11f:3483:bbb2 with SMTP id a92af1059eb24-1244a72e2c6mr1704221c88.12.1768529422352;
        Thu, 15 Jan 2026 18:10:22 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244af22aaasm911271c88.17.2026.01.15.18.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 18:10:21 -0800 (PST)
Message-ID: <c6451fc3-27c7-4ee6-b2b0-932faae050d8@broadcom.com>
Date: Thu, 15 Jan 2026 18:10:19 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: bcmasp: Fix network filter wake for
 asp-3.0
To: justin.chen@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com
Cc: bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260116005037.540490-1-justin.chen@broadcom.com>
 <20260116005037.540490-2-justin.chen@broadcom.com>
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
In-Reply-To: <20260116005037.540490-2-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 1/15/2026 4:50 PM, justin.chen@broadcom.com wrote:
> From: Justin Chen <justin.chen@broadcom.com>
> 
> We need to apply the tx_chan_offset to the netfilter cfg channel or the
> output channel will be incorrect for asp-3.0 and newer.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


