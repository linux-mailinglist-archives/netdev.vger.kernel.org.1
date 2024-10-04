Return-Path: <netdev+bounces-132134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFE79908B8
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437B01F21546
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0943A1AA7BD;
	Fri,  4 Oct 2024 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bn9NoN7w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7316F1AA794
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058173; cv=none; b=FxrnCBg0Dc23AI+RcVRnUe3NaB+mkXWJEqKjgRARAqqA/nlYn+wSww85sq+XdQ9iCSmVnLcyP05aQqUsPa8tPh/TgT7ZVjT0/fh+NTcEFXNQdqyCbc+lPb1ExnRG4wofzVisgzr7nQTEhIrcuau9Rd46WVBinJ2hsdJOoZQU9jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058173; c=relaxed/simple;
	bh=eoaWatCnhBU62iXtHmx39mSv9OQWXaKw4pJX9ho+iJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIJys/0R+6fResdrNmVKyFXyDFdtGVbUGbOL01zLXxI5c/b997+QsKiBlRUKSUCG/AB1167Y5rfNU5h6vBt1z0qMbhhiK8GaJtlSBqewCRwiv6fj6D6V/HXY7ODAEbQY9UeKrPDGHhE0Ynr6EkGbBzfWWHwoYrH1hhguJpcAfqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bn9NoN7w; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a9aa913442so187354685a.1
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 09:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728058171; x=1728662971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5h8wpPh30s6KF37peScNelcNl3ZFS3xlRdD1aJCpMMs=;
        b=bn9NoN7wvaqsVKOpRoKBYsxzISiRpBSmr1TXhlV+uNOhsZmeffXquUUomILkUmWQ9t
         0/M19NiUAvJcICOcxxVewDrxDPXYptUzNRN6xBpE3l7BaRk1VWpAQvG4qbG3rK/1sOOj
         xSp5F/wNWnwM7Xq/9+2Xdvnqwvrag0dBJzisI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728058171; x=1728662971;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5h8wpPh30s6KF37peScNelcNl3ZFS3xlRdD1aJCpMMs=;
        b=wrshOmq75u5D0ZYoEgLlbGII5aSgHK3xIZ8M9jypGpO0iN9THZkxdB765ShOFT6WZy
         Ima+s4RRqgDUStEtspQFApA85AMUUY5Nxt7O/DK0F0cO6T+8d0OORzlqDmEcL5cpHbhy
         ZxVGn7VyQl2+IdJx5fFwc9U9Qd+AdDdJTUFJfCn1cUrWqRbJMxgINoaattMIcfk86fdr
         iJdbh6gLZ1SwtPoB+YvzNFQuVa/17JD9Q2rGNYVMGTUysyXpHoIy9YXD2mUtGfPvgPFz
         A/ymBlrl43iTDM47YCjvAztRqOjOc2VNGvRontcpwrThIf8IUrG7jU69PGU4HbIhPsff
         bwlw==
X-Forwarded-Encrypted: i=1; AJvYcCX3d5nSzOilKJP2nIPfdCsI+P9nA2+KtXO0pTmC/uBUUJpIptEkU+AzyuUws6Jf3X7djU6ZFqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcqRhiwsapGrXYLETvV8t9JoOBKLbSFG5D0JPR34WuXtZdfwJp
	TUZo9UCdNBGomcAiiJ5c1+yfZMFy0VQCV2fCbIgfXMiNMnLAzxjMoM0n+m3UsQ==
X-Google-Smtp-Source: AGHT+IGtCk7ebsbdtPTQyF7KwUl+f/hTvdermQbklRaY7Diuv4J09nixlWJsdMN8MEXs3rPHxFGdUQ==
X-Received: by 2002:a05:620a:4108:b0:7a9:beaf:ce61 with SMTP id af79cd13be357-7ae6f486860mr569681385a.45.1728058170895;
        Fri, 04 Oct 2024 09:09:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b29f0dbsm150110485a.24.2024.10.04.09.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 09:09:29 -0700 (PDT)
Message-ID: <64c13754-79b2-4480-9f97-7987fe097d8c@broadcom.com>
Date: Fri, 4 Oct 2024 09:09:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: bcm_sf2: fix crossbar port bitwidth logic
To: Sam Edwards <cfsworks@gmail.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241003212301.1339647-1-CFSworks@gmail.com>
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
In-Reply-To: <20241003212301.1339647-1-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 14:23, Sam Edwards wrote:
> The SF2 crossbar register is a packed bitfield, giving the index of the
> external port selected for each of the internal ports. On BCM4908 (the
> only currently-supported switch family with a crossbar), there are 2
> internal ports and 3 external ports, so there are 2 bits per internal
> port.
> 
> The driver currently conflates the "bits per port" and "number of ports"
> concepts, lumping both into the `num_crossbar_int_ports` field. Since it
> is currently only possible for either of these counts to have a value of
> 2, there is no behavioral error resulting from this situation for now.
> 
> Make the code more readable (and support the future possibility of
> larger crossbars) by adding a `num_crossbar_ext_bits` field to represent
> the "bits per port" count and relying on this where appropriate instead.
> 
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

