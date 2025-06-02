Return-Path: <netdev+bounces-194645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3D9ACBB0E
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 20:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B10168413
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 18:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CFE227574;
	Mon,  2 Jun 2025 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gETvjFfN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB701DE881
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748888527; cv=none; b=LC1iMRTAMwCkN/AQtdAx+mYZfBMnAFsesM0Z3UHLqe/A4Vog6QGRjulZvWkMEcx0LDvb+Qv3E+uKaVQzS4UCFgqY8B/ihnHFbtWo/mrgviJu4zwD3PKWzdatFaQ9pJkn+90CuozJNl4oK9cZ3NO6kMSepm0HePygzSfIUiez+vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748888527; c=relaxed/simple;
	bh=C7zOKNuv+/pWisWAp5ezHG8l2YUZ/F/bXf6WhACvC+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aRy0QfcfCC/AoQlTxFUQHOWPsG62uSVnR6+wVFlMwAhDnCw79uLqGWdsBZxBWg+jUIS9gv8wywybhPrCsUqXNSbpUbBps8l3wRnU96YKd5GemmXY7GSxjmn64uoMbgUq7w/7wRXuyZAwjroEQz8YZRfHEFN0yVvktWBcdi6WlL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gETvjFfN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23539a1a421so22807675ad.0
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 11:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748888525; x=1749493325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DWdyHJiJ3ZXArA9dkhWhB28yR6o1uekhigLk9PlqB54=;
        b=gETvjFfNYvGXuBJmAVaavbklvYPYB67HQ7Ejj/YCX4MT8NPClI+bVg3FgU4x76Nm2N
         /xY7NBpEJK0pvuPzf6RZaJsI4HViMsayQSgWvAr6sMf2m2BNPnFCJ94VV90daGgit2B+
         KY/AisnbGyZobMFPdlstDQg1LS0JyW9xXa0+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748888525; x=1749493325;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWdyHJiJ3ZXArA9dkhWhB28yR6o1uekhigLk9PlqB54=;
        b=hIc7AnLA+R82d7LlhH6q4VGu48IfK1sS0qMrqvDD/jt2NSfcDRmtPK5tNjZU03bc0l
         OUYKPtNekbmN6b6aROADBN03XaqsHigK95NXAIYqhhKEvjx9vTZK/wn/B8YC2ZXwvKn9
         QD0ee5kdNPSuyqp8BzShnVIXU//CJG4m6+mvjpoFcIUc+1h62EtJel8K3noRL5CY3qEv
         y/gcT+lGZ+LC1LQYQjDQuGqd5hP4ttVJKGexGAWwngPn6eTAb718LDmR9Of6miensvNV
         VwBhHmxfNSBIKxdZRXByiDkCXrpd6xv2XnQ8op9pn0LCt+rkDJfCU25G3duR+/1RBb7x
         oOlw==
X-Forwarded-Encrypted: i=1; AJvYcCW/G3aefC9L0cxor5qyOwK3jQ4YBbWWkPWMWLmqYpUzS3wdNe2FbJ267PnjabK9yPoi2NvkAi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6KujxDJ6IK7obtaHKF30+L5hVQTQqv2Zuu8viTU7bwzCCN7vc
	w5+NNbVOSHxvzMVK0/grHE0x4V5KC8BBCdBDPb8qdojT/zriJRMVZ5T0cIsLFMcliw==
X-Gm-Gg: ASbGncsUAaIzVEc2BEoiPeov1tI3n/mcae3szIUD5JBEb6ViudLN6ZU4V1kQSq9c06W
	sseVEjtvlByP4UvZsunCDDIJDeZ8yrn+6r/077G5NyDCdeg8Xfpi8SjWj1DKnWOiDcK76CQmXch
	fEKXXr3ACGrN4hfGXKPjVTVHdZaIMoPZhHBFW13O7x0HKmxnS7CNr8lz4uFq2cLcFz+gS8/RPlt
	9Un4e+FZIGKRMsGqeJWxnzQA28FxXiIu4y0NXeOZ6IRWbscFV5lWazveCHi5xsZBbv4wFFVh6Sc
	fr/RSEdBbKlUA0uohY0NThwxhN7gmllg7oqkISweijSnEJ3gSM2n29cFkighasfdyIPSgvZkBO/
	JmJ8FfV4B2P4pO+A=
X-Google-Smtp-Source: AGHT+IH0zqHfndykLqKua5b375RnTZ06yA7IdjiSQ1ZsXxG1O25kaLn+u1WDj5/rJ+wjtmQxByz6/g==
X-Received: by 2002:a17:903:98f:b0:234:8f5d:e3a1 with SMTP id d9443c01a7336-2355f6cb5a4mr153012365ad.11.1748888525621;
        Mon, 02 Jun 2025 11:22:05 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bdd06fsm73968325ad.101.2025.06.02.11.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 11:22:04 -0700 (PDT)
Message-ID: <b5a88452-f10d-4893-87a5-5bb001d4be3a@broadcom.com>
Date: Mon, 2 Jun 2025 11:22:02 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/10] net: dsa: b53: add support for FDB operations
 on 5325/5365
To: =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vivien.didelot@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Cc: Florian Fainelli <f.fainelli@gmail.com>
References: <20250531101308.155757-1-noltari@gmail.com>
 <20250531101308.155757-2-noltari@gmail.com>
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
In-Reply-To: <20250531101308.155757-2-noltari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/31/25 03:12, Álvaro Fernández Rojas wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> 
> BCM5325 and BCM5365 are part of a much older generation of switches which,
> due to their limited number of ports and VLAN entries (up to 256) allowed
> a single 64-bit register to hold a full ARL entry.
> This requires a little bit of massaging when reading, writing and
> converting ARL entries in both directions.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Regarding your error in the cover letter which are mostly -ENOSPC, I 
believe the problem is that b53_arl_read() is still looking for 
ARLTBL_VALID rather than ARLTBL_VALID_25.

Given there is no VID returned upon an ARL ready with the 5325, I don't 
know how to also reconcile that line:

                 if (dev->vlan_enabled &&
                     ((mac_vid >> ARLTBL_VID_S) & ARLTBL_VID_MASK) != vid)
                         continue;


-- 
Florian

