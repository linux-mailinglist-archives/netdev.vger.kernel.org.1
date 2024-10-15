Return-Path: <netdev+bounces-135812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF9999F422
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2326F1C21768
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8D71FAEFE;
	Tue, 15 Oct 2024 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q8GBbYOA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55F11FAEE0
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729013549; cv=none; b=dQV9ymZf9j2cYdJOSH/03HUSac0/dUXBFss0NuAiN2MTyAGYHkiJ+4EiEoAtu4hp6RfHTcTXot6gpl1dzKDjHs+VIDr6Vxm24BriP8/1ffB40eVygQoMCcfmoI8QoAVKXsjPPzuHMemAcULZuL9fmuZhKpiH3hrLzp0rTMraYuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729013549; c=relaxed/simple;
	bh=fTfBdMc8mV3YGlFlTznYH31fTmJnZUAYfBaH2x6vF+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P75gjt1KOLMGVuqPYEamz8I6aTyJfORmvY9zo6yg2MLW1Sk2oee0StxkkKC65XeFuPtMMrmjZiKJAbl/ResTzlrCON8WYMcsC3w1bz53fL0qqL2Xxtjf24xrSDvWr15Oy2WeeUH01RNhvADtHO/QZacLecSGy33MVOZZGgkssjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q8GBbYOA; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b11692cbcfso419414785a.0
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729013545; x=1729618345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GilTLlSelffODZfy/8XZJDTdiEXOfg2qNC/dNLqoj2k=;
        b=Q8GBbYOA4xFXke82eI5vTrnMy2IAxYFhEEa+YUj+4IeO96SbEKptrSmCNbQzpmhMSH
         Syejp3B6dJ5buVvKDxCujbvCovzp9OJkVkLDdRzHKEMbamg0NNc5QAGBClphu+Z/1gNq
         UXtvzvMTyb5WXpAMyavFGnLr1/JGctsD+XNJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729013545; x=1729618345;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GilTLlSelffODZfy/8XZJDTdiEXOfg2qNC/dNLqoj2k=;
        b=iNLqJaQcQZEb7O4nSjDrHvJz5wPDLVSLoADmQWZpkDDxdUxHXo/+HN5T7Uv8i1YRoc
         OvUsUzAydQ0SGo60lRWERJXaf+eXFn8MSi24iiIhF3FYQIuVs4e5pey3GNjeeR4scZ5V
         kHVADOqh0bGseBEsLu2npcKdCtEp3iEjicCijkgc315arFNpFA+6NByDMsZjlKca6D83
         K907TRsugQ6F57J4W2c86l1K3eHfP3l3Ong4Ai76ZCSQnN/18RbClXOt+zKToYZUCqi3
         t3sGawXE48QZmMuEcmXiV2J1AVVnA2TsEZXoUdEYUteCKjDZLU6J8H6iOz7J2m6ysvC8
         JaMA==
X-Gm-Message-State: AOJu0YyFTmJouyHtwWsb9GPi1eeHWbziHs0XRYE7uidz+VIpoiBByAIO
	9rZs+y7RUwkcJcdlsPQgcMPlAIpmlhGmX7PmEM5gCrGDZX++5ISQwqm3QcgpWw==
X-Google-Smtp-Source: AGHT+IE+p6sXakMFFEi3I6QANbpqcIEHh9LYBD/R1eicX1H7w+X+vVfS2BnU6GXMLEtPTrVvmRqsOg==
X-Received: by 2002:a05:6214:4a93:b0:6cc:567:d595 with SMTP id 6a1803df08f44-6cc2b8bb6efmr18165446d6.7.1729013545447;
        Tue, 15 Oct 2024 10:32:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2290f918sm8979686d6.7.2024.10.15.10.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 10:32:24 -0700 (PDT)
Message-ID: <25cb1dfb-a0dd-44d9-ac35-bfbc66a82d1f@broadcom.com>
Date: Tue, 15 Oct 2024 10:32:21 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: systemport: Remove unused txchk accessors
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:" <llvm@lists.linux.dev>
References: <20241015172458.673241-1-florian.fainelli@broadcom.com>
 <20241015172458.673241-1-florian.fainelli@broadcom.com>
 <20241015172458.673241-2-florian.fainelli@broadcom.com>
 <20241015172458.673241-2-florian.fainelli@broadcom.com>
 <20241015172948.xvb3xoed52zhaqtm@skbuf>
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
In-Reply-To: <20241015172948.xvb3xoed52zhaqtm@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 10:29, Vladimir Oltean wrote:
> On Tue, Oct 15, 2024 at 10:24:57AM -0700, Florian Fainelli wrote:
>> Vladimir reported the following warning with clang-16 and W=1:
>>
>> warning: unused function 'txchk_readl' [-Wunused-function]
>> BCM_SYSPORT_IO_MACRO(txchk, SYS_PORT_TXCHK_OFFSET);
>> note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
>>
>> warning: unused function 'txchk_writel' [-Wunused-function]
>> note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
>>
>> warning: unused function 'tbuf_readl' [-Wunused-function]
>> BCM_SYSPORT_IO_MACRO(tbuf, SYS_PORT_TBUF_OFFSET);
>> note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
>>
>> warning: unused function 'tbuf_writel' [-Wunused-function]
>> note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
> 
> I mean the warnings do say that the tbuf macros are unused too, yet you
> only remove txchk? I did ask yesterday if that should also be deleted,
> and with it the other unused transmit buffer macros?
> https://lore.kernel.org/netdev/20241014174056.sxcgikf4hhw2olp7@skbuf/

See my response to my own posting.
--
Florian

