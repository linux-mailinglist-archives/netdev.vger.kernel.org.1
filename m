Return-Path: <netdev+bounces-210896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A66DFB1556C
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 00:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DFB018A7902
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 22:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB43525F97E;
	Tue, 29 Jul 2025 22:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CoHV7Dx/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314861D54F7
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 22:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753829411; cv=none; b=jYLfV9idQGMHqr+eaApn4aQnPPTjBPXh4q0IdqKvocUBM+26VaUw/euguHK6BksEZi5mUlcPMZY+vbEsXJUuNrz99ZZWYjcAFUzPwiAZafx8/SVtcxzajUEFB8VndB9zZisUbPZXq3R27x/Neuc491XO+sLRdFEM0rFkTh3u6Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753829411; c=relaxed/simple;
	bh=5Oag2AcCVjPkzeOGGI4/I3ST02oJJLJcTeMruEDNa08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYjyx9BzJMXKfvS/xVayKIRJCGsYG1RlPYt64SWLqsVBMwlPvkMIm2qxETtzuVlNmA0nG9DK/ppM0JF6PrB39ziRq+PWrDnLhzxRxokciUc7RZbWc21qKWwz/ZRTPr/6T5uCb2V+tu+XfZBtXXJ4PTMcigrRmWEkIBJKJEE8r6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CoHV7Dx/; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4abac5b1f28so66819551cf.0
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 15:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753829409; x=1754434209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T9Rx1n2VPjWEd5IieDrbsmiYNsbFkiLS70sRs9a6cAM=;
        b=CoHV7Dx/FeYqva7jmgXH+KGuZQhVwAm7GeVpCjmpL6sTglBUoTyRvdI45an7Q/Jca0
         i+d+kJY219x0ggWOkCBTLckX+6B3TAVgoVGcqX+5zWZ66mMo968cikNMUer/dxeFytlZ
         AQeGp8nz9zci7b1Enx4Z0NtadoREBXR2yZ7wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753829409; x=1754434209;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9Rx1n2VPjWEd5IieDrbsmiYNsbFkiLS70sRs9a6cAM=;
        b=sJus1xqp63BbPCWm8YIYMzMbhwi9aSwF1xu4goDGx0VzM0NZ6dTLGXRHBj2l1dXmS7
         6EQhNIR76MakyQV89UWL6OS9m/cucaemAFH2+WxXeN+kw5naLhczSrX8UrD0yFOcHyVV
         +7QA9PZZ7Q5N1AYUhIU5SVyTuaVX7PcsAHUpJ9VVJ7c/wIQG0Q55qSoVJhmtSjyhEyTT
         s9q2VW8WkaCrAMZ0xfiUheS+7HBZ0GMdMsGVELOczf2vQhOCxFGsMFpY0ZaLx8lXWVqm
         QuzdVmX6uA4RikFiVIaplEa6IBzB6+v8ryqpBGWWTEwx0o1YkSbIY+YiUBUE+oysb/aJ
         FpBw==
X-Gm-Message-State: AOJu0YwmF98JCxMZv8wEz5ta8ZJUk2TYohSLKmYeTgecb2JUyai41wND
	qrQnSWjzERbDbGlLJqa4/je4dgk7j4lqKrM95sEFGuEQ07pvNmziqNOxg4sgJ/1Q+A==
X-Gm-Gg: ASbGncsTv9DZGOyY7aB0U4u4dBZVxj3IDi5IRUutErVGNaSVhL6iEPqE1H+up0fnpd3
	n/QxY+IedtzD+sh3E4h3niazWKd/Izwhvro6uNPQK9WM/pyBACIV0yAMdFe6rIyHS7M6bOTVK2Q
	RlgMXgjz0IX4G0a/BVI9SlxuoJptuGFVRJAR612uSLnLpNN773jjOKbuUjLPJ9kN7vltLTLABGb
	RORHYaaZF3uNPHup/BBbxyB0Ec63Qmf8WldVfmXm3fdE57FD3oV97yzZR/2IigxranOvWAtfW7b
	Xtik1hn7WEgKP5fDv7Nne4EXP8IgfUA/CkfzYUW6RI8jqIkrNKVSeFzXlid359clhMOloxGIBdN
	dniRQW09CzhaU1cZIJMVZqTIBNuh1K/vlkpWvX4NheKJgv+u454NF5DcIURFHFQ==
X-Google-Smtp-Source: AGHT+IF2wx21LXiuL01GtnF+7h1KfKCmUDdkpqqReZvm+ZkOom6O8hWfC+d1EYVqQKfzAfhxJW4UZQ==
X-Received: by 2002:a05:622a:118e:b0:4ab:651b:5f17 with SMTP id d75a77b69052e-4aedb99c9a0mr24608101cf.18.1753829409039;
        Tue, 29 Jul 2025 15:50:09 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aea7d724d0sm44488141cf.23.2025.07.29.15.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 15:50:08 -0700 (PDT)
Message-ID: <c2e08821-c9e4-4b35-bc09-94dc38fb6012@broadcom.com>
Date: Tue, 29 Jul 2025 15:50:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: mdio: mdio-bcm-unimac: Correct rate fallback
 logic
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20250729213148.3403882-1-florian.fainelli@broadcom.com>
 <11482de4-2a37-48b5-a98e-ba8a51a355cd@lunn.ch>
 <9c10c78b-3818-4b97-8d10-bc038ec97947@broadcom.com>
 <775f7ae3-9705-4003-a7e8-aac3c418e48f@lunn.ch>
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
In-Reply-To: <775f7ae3-9705-4003-a7e8-aac3c418e48f@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/25 15:44, Andrew Lunn wrote:
> On Tue, Jul 29, 2025 at 03:22:57PM -0700, Florian Fainelli wrote:
>> On 7/29/25 15:20, Andrew Lunn wrote:
>>> On Tue, Jul 29, 2025 at 02:31:48PM -0700, Florian Fainelli wrote:
>>>> In case the rate for the parent clock is zero,
>>>
>>> Is there a legitimate reason the parent clock would be zero?
>>
>> Yes there is, the parent clock might be a gated clock that aggregates
>> multiple sub-clocks and therefore has multiple "parents" technically.
>> Because it has multiple parents, we can't really return a particular rate
>> (clock provider is SCMI/firmware).
> 
> O.K. Maybe add this to the commit message?

That makes sense, v2 tomorrow, thanks!
-- 
Florian

