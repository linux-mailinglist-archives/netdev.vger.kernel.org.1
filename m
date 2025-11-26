Return-Path: <netdev+bounces-241992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46145C8B6F0
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E6E3AD6CD
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD323128B2;
	Wed, 26 Nov 2025 18:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ec8aQLAK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59CF31282F
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 18:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764181579; cv=none; b=PNq8TLHqTfu9YrE+5LWRtkrLSIelBk4LCOuz25aGeGwem/udV4Fd1CsgmUQuHiOREsRtvX3mYN0xy8x0Y7TqNCIzohE92aFF4HMIOMwsb5ewwhRTSVDp6xQm2r5gwI5IGSqkgQBblTQ2EPNHruLsejK8jnj+JZhm2V5O05DSTRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764181579; c=relaxed/simple;
	bh=j/Ly1tXrw33VIEzyL5/TVBCJhQ4MccXYSpDKd3mM/QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSk8R2f3bNPmlj56bh3mOIdfqUETkEWRbPoO66YIVdwSkf1wq8b3fofD6uhuzXUCDwMkiwZnd0V5TVOYfQBZgnQlADlszSXjbirB0/I/qvOdc8qBd5ADPXeEEtbK6pWMkQMdaotVVcGSGRonDoAQQlSTruqGGEIL3+ASt8cD4UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ec8aQLAK; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-640daf41b19so148193d50.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 10:26:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764181577; x=1764786377;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cy8AKiI7FbfC4e7RG9mzZPcfmwKd6ALYyfBgdGUTSMQ=;
        b=t3nzJ6X6z79XSvvVdxxsEwf/rvQlAs3PNN4JB6JKLLsFU9EcD7RYQqAGFppEnV5onY
         TOql9GncVbPa9/aDwK91spWYURS8YkFouQt4Fwp//SVuXCRuD9WC5FL961t6qPYY0Wc1
         7ASA98EXxigXA9Xwy54s2yiE+9k2fGitq+iyKgwOfs/fErB1Oe05BoPiyWA+ANipaF6R
         1qTc/p/Zb2pCsZDfthcMXKKDS2P629Oy7NMZuCTbmVE9XxDPAxO2lRZeOeZ98+ROsuA9
         8ZmjvmQQwfPXV2PITUPOyUVKkD0eG86638e9faMIWK3zgguObOpZZRr3GqjtemV647va
         X6fw==
X-Forwarded-Encrypted: i=1; AJvYcCUmQwT/np+dd21fIIDopkCYI+3NpV1uhqREqA33XzzxvPLN2PxBFnOC6uD/PdYRgga94FLCh38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTwJi/Ojy6haQIPZGGJw/hty/GS1iByHFigNfsHIJlmiElAjE0
	cbMFkI5H10Ocqn5zcPfSFUylYBTsjDxedBX3c59n+ALSwF0VLQWRbikxIayJOyDv4iOSUTAid6i
	BRo5fI6fWfcMQMZlMjZOllBxAVZFEjgb9H0bRJn2xe56wFFgXIj9FnAr4bAEkhV8H7pO/njaS65
	r8BNg9irEhJBId0lANH0QNRMOIwknhg/bwNlOOAeZU6fy56h+PAlXsRGstx4DIrQYalBiR1krgl
	iqoFlZ/o/zBi1Ls
X-Gm-Gg: ASbGnct6S8yQ96RNM2fUvlz7p4o7cTky//7F0mvB6ZkCxyE6vYzdRkLqMypLHxJMifu
	YLqT0exBuYXzzF17mTSav40M48kTf/F0cUZxIOwsC2hRXkaE00R0UIA/jPI2zwO4oU7T+C+wjZS
	Av2hyHbUk3SiJon8ihFdkhRCQ3UFzrNtyg/e3K8dIJ/5XhO++ADgDbUf9JKpBztDVMvBtostHf2
	6HJp87EqHb11NO0RkEcDc1WqH7xsscIjkGisznhGhcCt1uolQLngBqq1kQVPq4iTRZUW0N2aXzq
	CqqUlLOO+HMqMAzwgIN6Kbp0dU4T8jgrribKHpLn5v4Jkk2hhsMXn7okzSa5wu/r6/ozfaZxRuT
	uwcfq6prIyHyESqHAlZOuoWKoIeVd4niqotM5LNlngbnTt31AapxpX/lozPHZ/0IXFSTVL5UAKN
	vbkL2bYEzq68u2il/BCsQmmuS09gM7SXXoY7sZK8ShbcO0LrDdwQ==
X-Google-Smtp-Source: AGHT+IE+zWJGYdRqT964R+A3g76viDz3/9XlyB7kXVU1WThi9tWa+K5h2Ss+IQGfVD0+7zsiyb1ez1839EO4
X-Received: by 2002:a05:690e:1443:b0:63f:a4ca:dc21 with SMTP id 956f58d0204a3-642f8e2e343mr15995331d50.19.1764181576614;
        Wed, 26 Nov 2025 10:26:16 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-642f7188142sm1548112d50.9.2025.11.26.10.26.16
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2025 10:26:16 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-11bd7a827fdso1536241c88.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 10:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764181575; x=1764786375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Cy8AKiI7FbfC4e7RG9mzZPcfmwKd6ALYyfBgdGUTSMQ=;
        b=Ec8aQLAKDLWAl9yBEkE1sv3uWphfNhiYJ13teo8WPDQOWZ6+kI0Uq1P+rfFRf9kBx8
         g3MG0M1HtmE9nFYUyPHqLogBhrUgksoFbA+/rQVNd5FDQjKkknzNjEGWHkUSMv99LLTK
         gtMZAbipvR7IsmEJ1MvWH/kRsRlACJOqUFJI4=
X-Forwarded-Encrypted: i=1; AJvYcCVRLNI5aGoQdGhwE0RKQEqOls+UKkzEqMxkSOvG/a+Fbm9OkHbcxKPF+2PiA9t8Bt2kKgPXeWU=@vger.kernel.org
X-Received: by 2002:a05:7022:fb0b:b0:119:e569:f85d with SMTP id a92af1059eb24-11c94b90cb3mr13324834c88.20.1764181575161;
        Wed, 26 Nov 2025 10:26:15 -0800 (PST)
X-Received: by 2002:a05:7022:fb0b:b0:119:e569:f85d with SMTP id a92af1059eb24-11c94b90cb3mr13324814c88.20.1764181574647;
        Wed, 26 Nov 2025 10:26:14 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e6dbc8sm100132165c88.10.2025.11.26.10.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 10:26:13 -0800 (PST)
Message-ID: <9efdfd06-60d5-48db-b1d9-6d134cc39732@broadcom.com>
Date: Wed, 26 Nov 2025 10:26:12 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/7] net: dsa: b53: fix BCM5325/65 ARL entry
 multicast port masks
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251125075150.13879-1-jonas.gorski@gmail.com>
 <20251125075150.13879-6-jonas.gorski@gmail.com>
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
In-Reply-To: <20251125075150.13879-6-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/24/2025 11:51 PM, Jonas Gorski wrote:
> We currently use the mask 0xf for writing and reading b53_entry::port,
> but this is only correct for unicast ARL entries. Multicast ARL entries
> use a bitmask, and 0xf is not enough space for ports > 3, which includes
> the CPU port.
> 
> So extend the mask accordingly to also fit port 4 (bit 4) and MII (bit
> 5). According to the datasheet the multicast port mask is [60:48],
> making it 12 bit wide, but bits 60-55 are reserved anyway, and collide
> with the priority field at [60:59], so I am not sure if this is valid.
> Therefore leave it at the actual used range, [53:48].
> 
> The ARL search result register differs a bit, and there the mask is only
> [52:48], so only spanning the user ports. The MII port bit is
> contained in the Search Result Extension register. So create a separate
> search result parse function that properly handles this.
> 
> Fixes: c45655386e53 ("net: dsa: b53: add support for FDB operations on 5325/5365")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


