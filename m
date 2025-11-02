Return-Path: <netdev+bounces-234904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5ECC291AD
	for <lists+netdev@lfdr.de>; Sun, 02 Nov 2025 17:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 85DE1347612
	for <lists+netdev@lfdr.de>; Sun,  2 Nov 2025 16:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4939D1DF25C;
	Sun,  2 Nov 2025 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WZ/EhAIF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1AD34D3BD
	for <netdev@vger.kernel.org>; Sun,  2 Nov 2025 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762099981; cv=none; b=aUZGdR/ZWzsD8qtjy06Y31o2kSdV5bSukQJMpejNVXR5448r3c08cnwIjj3tXt644wuHV7gerrX8dnrkmZUXIp1TjbXRnj3wfcjRGZvNXNQnhDj+S1v63d7aPIw+wtfZsIwgC7NnhrMsNBo5Gf1Q+OwVCKD+KPtcnVrBmnwzZgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762099981; c=relaxed/simple;
	bh=BO/j7N0IDWYCOEC3h7SRnqnJC86TVXmlOFAlu09y82A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COcVv0uMYBjh9SPWgKveEN3PqlfQvWMmk5HsYNPOd8eMBngC/1K1Ff2BUksu+yGl3o87TGeHHuVicFW+PHE5p/GqUm57ujWUbQdJj9PAOyo1ovOheuNQP9yK8bPc7b6O8b0WeBCIDmKdQtTxDSjUPQZsaNk8u9rnZYkCvJ3Qxt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WZ/EhAIF; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-4331709968fso21602415ab.2
        for <netdev@vger.kernel.org>; Sun, 02 Nov 2025 08:12:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762099979; x=1762704779;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXWXoVbPyV5eU1syuugBzDzD0q+1nlVhslmOyClyUcE=;
        b=MqbPAU2tsrY5P4FiJ1BRwJXFJbFumLLS4x1ol1Yb57GPsI9goMJjP8EI56dqhdcjQu
         AoRmQ/iKHryskPwraSP1N0G1XrX78ZihEXxfdxSGyv3aXq8z1p5m7hnCHRNHp06LUBzW
         Iva4FRDBiczjuIW/IrIVoVp9pi88lVvSKGNAW+vkMFo6Iria8eFx/nmM4x5EKqex7WrR
         30KTH0DxVo6mHFqzLH1S/n4qMwHgtSr/76FExOw8lVTHFfyWFu3lqx0FNhTI+LeNtfPE
         dDS+cb9Fsd3HX2/GhMzkLsDiPcaj7YGy0m/sC+Re2N4be9zVawqMQqbZwZH9sAR14EdE
         iYYA==
X-Gm-Message-State: AOJu0YyRVOpbTvrwBwVj0WalvHvwOCXhMWajOsotbGv5WMrStZ967j8X
	W0apbrXD1LS5W9MPmySorK9mo4389A4qoYgjOXzhO1AHMY3/D+oUSXrz0FaQ2Qmc+wnYHufG3jg
	KGeE3OZtjlFE66rW3bFJNw2edadSwehykjTVpedTZj6zJsTF8Ga1p0KfDK+4qPIcJSzs+P5WgYW
	rBKxS780KTalC/1GeRGnoI3xzJ9OrCWgLPG7+OgKNJjQ0FDtyrzpnH9bci7bBO9O2+5XJxgXRgE
	cikktbVlPo0RIsz
X-Gm-Gg: ASbGncurfYyYiw6tuL1ytId6Rgir/8/SfoXmFC1rdneaPMC/ltwsvIpBYRuchMA+tff
	N9CWEFpadMNZQkhdgDBjQEJUsPc+XDVc9vcxPVXA5xwrhpm7cIfO3pAMSXeCGHaPcMESbpQjBTO
	k7flXfteuILqfDEGBjuBSH1griFKfS2PBGTfh5WRNTbx7muwrKyvYqP4KczXY3ZeBycoo5x9Ey0
	hDakYcHWd2qzfHlq+7A8jm8bOqR2fr+Z5wt3GcCVuMPEg1/AjtcYlencwEysPVZk8bSQ+x1gJke
	wAo8W2LUu7qe+3kTNHnmovWHK41tPLR/nML2cVbzWNFov1OA9WrsRDzIg82+4mrIw38krKM61MY
	zj7lXuXjid1QNegSHjMxsACTKK/G0mGyor8t5Ku3Nux2pCAXWx2NHnEVoXlZ/S6GVp9Nf5ivMpi
	2CUsDGFNr14lPjN+lsLeIhjqW/KrMhTS60BJp92AY=
X-Google-Smtp-Source: AGHT+IETFSmnJUQT3zi5huIaan8BY7CKRZs3nFCp45pu3r+Scngsu/oOtHVJZRpOXHyM/FNXEhnE00OSGuk7
X-Received: by 2002:a05:6e02:1606:b0:431:f7df:f026 with SMTP id e9e14a558f8ab-4330d125beamr138239395ab.2.1762099978843;
        Sun, 02 Nov 2025 08:12:58 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-4331025367asm6257855ab.5.2025.11.02.08.12.58
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Nov 2025 08:12:58 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-26e4fcc744dso26951735ad.3
        for <netdev@vger.kernel.org>; Sun, 02 Nov 2025 08:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762099977; x=1762704777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nXWXoVbPyV5eU1syuugBzDzD0q+1nlVhslmOyClyUcE=;
        b=WZ/EhAIFUdcCkvMJBrjYbQ9EqzOyV40/ddKbHVX8QZctDA9IRyTNkILt2gpM4dmKNz
         s8K6XMzCnvR/3AuAQ/GPVZCrGmYTZgb0Wl/PaZi7yN9p/y135C/1cMf6pX+qGOEUx+U0
         R0+eQZMEaysTFa9YzbPYb3jns/pYJfwr56E5w=
X-Received: by 2002:a17:902:ea0e:b0:269:a23e:9fd7 with SMTP id d9443c01a7336-2951a3c0348mr128650245ad.26.1762099977239;
        Sun, 02 Nov 2025 08:12:57 -0800 (PST)
X-Received: by 2002:a17:902:ea0e:b0:269:a23e:9fd7 with SMTP id d9443c01a7336-2951a3c0348mr128650015ad.26.1762099976810;
        Sun, 02 Nov 2025 08:12:56 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:ba1:a836:3070:f827:ce5b? ([2600:8802:b00:ba1:a836:3070:f827:ce5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295424bcc39sm70137005ad.17.2025.11.02.08.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 08:12:54 -0800 (PST)
Message-ID: <f39415a8-350d-4ceb-b36f-917f6f082454@broadcom.com>
Date: Sun, 2 Nov 2025 08:12:53 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] MAINTAINERS: add brcm tag driver to b53
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251101103954.29816-1-jonas.gorski@gmail.com>
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
In-Reply-To: <20251101103954.29816-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/1/2025 3:39 AM, Jonas Gorski wrote:
> The b53 entry was missing the brcm tag driver, so add it.
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Link: https://lore.kernel.org/netdev/20251029181216.3f35f8ba@kernel.org/
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


