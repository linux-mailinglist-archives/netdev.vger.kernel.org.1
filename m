Return-Path: <netdev+bounces-231355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB67BF7BBA
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 18:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A258C480C88
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C252FD676;
	Tue, 21 Oct 2025 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L3dV9kPq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f230.google.com (mail-qk1-f230.google.com [209.85.222.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F842FD663
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064570; cv=none; b=miBun6Gjm+pMKMt2FcHZ0WlvNuDpevEkSsZoyRblayEplLWUgH7D+D7yDa8YmVEBLVWNXXzzmCMneKnvo47yW5LVpzaeAvtJ+93n572mrVPrG0REtZR8mHeZpJ4Zc2ujk9nSantlLVtElUerdFt+SJVSqX3brjCxxg1W5UFUiiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064570; c=relaxed/simple;
	bh=RJWWmxDqTL/DNcsSQy19tTZJ37KdEDjK/Pm9xuYJXjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J/5FJQSJZ9vLPJzzAX+IojhnoXW4H4Gu49Xibj8YyU3oWre5CTPplF+CbF/3wuM0vscm7QNaDhHJtIm37oNG1i7Fr9M85+EGYuNoG4A9uyG+tsHcEX5gSvxByKvGDS+LKJOK//QNzTPY5XdxdfuDirMxEzRtxNJRTPGRQJsGfH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=L3dV9kPq; arc=none smtp.client-ip=209.85.222.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f230.google.com with SMTP id af79cd13be357-8901a7d171bso726707385a.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 09:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761064567; x=1761669367;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b3biXi1AQBo+SW2vlwfSLIfx+ACLE08h5MiQFwzx3wQ=;
        b=GWgQIm2XL17TlDBjSRgZT+HlGJwq8Nr3PQeosWkIi11crtm5voGsp5mFFjQmhNdocn
         LyF1nZAreSeNShen4w6y/KP0E1JKXrU2oRQkcraloEPAo4KWQEm5HHILMnbWLR0FvPHc
         gzhwvs7z+qL/pDz9M0HVRxBSpjuYjYVZLAgOIJneQYgJcwHZBTPE+O6G1m8aP8lIh8Mp
         8G5SzYxvIatpLbvSX42UZYbfuofXYIZ+PZZaloJTd5GBrWqJvV4cEZ3sha81Z5DNrWsz
         4JPiAoSgv4twm1PufotIQtkLAYpX92jrIIXlGLsLrl2/yhWjKDqQszJJqbBKRLzNu8KP
         Yy/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFE7S05DZYjYur/o2p97YTCsP27NJbT918hPzX80fwkdBSRprLjT1wk0/wk8x1PKL0VPbGSEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg7yiknXDPPytpUUctiGeob9rXuhikI4KU0aNCOJkpdtOIiEEb
	D2FBmqYclbtth1ccDnZH6U5DmYoIMPyt5DEhIETz+UKDqY3EzFLjJ5tSIirIxHz31Fc/OMm4DcQ
	mqgE5Scid1ZjH4BXYN7FPDtBjaGA96yFRrRuUs+FWQ6RTu/t+sEJmf+wQfjAGjI69qiRCxleL+D
	AJ+bQf3X9Pw2P/axkH/O97fc8xUEjnHyED55DWB6uTLYCebpfsUqd84lEjNjjb0iBAEobuhztQz
	5RWokfQFUiY6xgmxSc=
X-Gm-Gg: ASbGnctMQVy949BdFvBlcvg2EHfXgzZ4cVz5dI4Cpw85rTHepgnJCKMIwHhIjo0nZp6
	nWBv4B6VuzxxBewXmt51xBcW9x40ad7UxlIzqWBKVxh6oAECTirxLG3grHXxqUoUr6+hkhCNbCe
	I+AxdGO8/bsQlX5xGELFY7+5Iqrg7urJFIsCyt0L4pD6zZAYSbdebVnOItJTT3sUvn2udlps5dM
	+i41M1SQMIeWekUJAO43xNu+jfBF1NdYdDl7ZTENcBxbWC6NaEChz9ZZ7i0lyw2wZF+qkGRAKp3
	j7NF5mdJMEiam9PRRxVZz4WjWbF5NNRTIuauRCGMqOXjxKvYYfUZ6+kSALQ1muj5VU7VrDRY4M8
	xQMupal0vPLGO50Ac4BbXEvlSyVWBHVTGTCsgEKdmdrY6MQI3ZQZS/9zeqSZP+3Dq0cieYraROU
	bO/Nc4ilMVtoIbZLO9t0ZHq7Wb6E5+IBUQdN0h++8=
X-Google-Smtp-Source: AGHT+IFFNamj2En2J+hLFSaRZmaXwEDTab8oExOuF04FV934fSZ4Aib+54eK3fL3rOocSAO8xxRGxLNxTOLZ
X-Received: by 2002:a05:620a:4152:b0:892:eb85:53cf with SMTP id af79cd13be357-892eb855690mr1236616585a.54.1761064567027;
        Tue, 21 Oct 2025 09:36:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-891cfb58f23sm133157685a.7.2025.10.21.09.36.06
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2025 09:36:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-780fb254938so4949812b3a.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 09:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761064566; x=1761669366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b3biXi1AQBo+SW2vlwfSLIfx+ACLE08h5MiQFwzx3wQ=;
        b=L3dV9kPqKx6pSwIOFen5vwzPXmI3JUQ8nRldVjNVCiOeRfdTvsU4AL2omN82NsZQuC
         Dmivl7qkcMl2PLRvdjHjMEBdSiN+W22BVtHGN0St91K+quKk8SBI/Tnmb5lJ2d+j4BbY
         f/pI40pFW294DiMD5cGcFX09vwU0m1aoTuhTo=
X-Forwarded-Encrypted: i=1; AJvYcCVf6WqQW5BOFMs6tGfwPP0ctnS8q71pEz/T6jILNfml/LhFN5F5B4EL/FgTdtpwVr0ZR1DYix8=@vger.kernel.org
X-Received: by 2002:a05:6a21:798b:b0:338:c1c0:130 with SMTP id adf61e73a8af0-338c1c00179mr4792639637.37.1761064565620;
        Tue, 21 Oct 2025 09:36:05 -0700 (PDT)
X-Received: by 2002:a05:6a21:798b:b0:338:c1c0:130 with SMTP id adf61e73a8af0-338c1c00179mr4792613637.37.1761064565159;
        Tue, 21 Oct 2025 09:36:05 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b77bf6sm10772837a12.41.2025.10.21.09.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 09:36:04 -0700 (PDT)
Message-ID: <7039d3f0-8102-4d0d-afec-1b96e3709aa6@broadcom.com>
Date: Tue, 21 Oct 2025 09:36:02 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net-phy-bcm84881: add support for other 2.5G / 5G / 10G
 phys
To: =?UTF-8?Q?Bal=C3=A1zs_Triszka?= <info@balika011.hu>,
 bcm-kernel-feedback-list@broadcom.com, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org
References: <20251020222721.2800678-1-info@balika011.hu>
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
In-Reply-To: <20251020222721.2800678-1-info@balika011.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hello,

On 10/20/2025 3:25 PM, 'Balázs Triszka' via BCM-KERNEL-FEEDBACK-LIST,PDL 
wrote:
> This patch add support for mako, orca, blackfin, shortfin and
> longfin phys to bcm84881 driver.
> 
> Signed-off-by: Balázs Triszka <info@balika011.hu>
> Cc:florian.fainelli@broadcom.com
> Cc:andrew@lunn.ch

You need to run ./scripts/get_maintainer.pl to get the proper 
recipients, right now this patch has not been sent to all of them, 
specifically the driver author, Russell, is critically missing from the 
recipients list.

> ---
>   drivers/net/phy/bcm84881.c | 1127 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 1110 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/phy/bcm84881.c b/drivers/net/phy/bcm84881.c
> index d7f7cc44c532..d8dc32aa4ada 100644
> --- a/drivers/net/phy/bcm84881.c
> +++ b/drivers/net/phy/bcm84881.c
> @@ -16,6 +16,106 @@
>   #include <linux/module.h>
>   #include <linux/phy.h>
>   
> +#define PHYID_BCM4912			0x359050cd
> +#define PHYID_BCM4912M			0x359051cd
> +#define PHYID_BCM50991EL_A0		0x359050c8
> +#define PHYID_BCM50991EL_B0		0x359050c9
> +#define PHYID_BCM50991ELM_B0	0x3590518d
> +#define PHYID_BCM50994E_A0		0x359050f8
> +#define PHYID_BCM50994E_B0		0x359050f9
> +#define PHYID_BCM54991E_A0		0x35905098
> +#define PHYID_BCM54991E_B0		0x35905099
> +#define PHYID_BCM54991EL_A0		0x35905088
> +#define PHYID_BCM54991EL_B0		0x35905089
> +#define PHYID_BCM54991ELM_A0	0x35905188
> +#define PHYID_BCM54991ELM_B0	0x35905189
> +#define PHYID_BCM54991EM_A0		0x35905198
> +#define PHYID_BCM54991EM_B0		0x35905199
> +#define PHYID_BCM54992E_A0		0x359050a8
> +#define PHYID_BCM54992E_B0		0x359050a9
> +#define PHYID_BCM54992EM_A0		0x359051a8
> +#define PHYID_BCM54992EM_B0		0x359051a9
> +#define PHYID_BCM54994E_A0		0x359050b8
> +#define PHYID_BCM54994E_B0		0x359050b9
> +#define PHYID_BCM54994EM_A0		0x359051b8
> +#define PHYID_BCM54994EM_B0		0x359051b9
> +
> +#define PHYID_BCM49418			0x359050c1
> +#define PHYID_BCM49418M			0x359051c1
> +#define PHYID_BCM54991_A0		0x35905094
> +#define PHYID_BCM54991_B0		0x35905095
> +#define PHYID_BCM54991L_A0		0x35905084
> +#define PHYID_BCM54991L_B0		0x35905085
> +#define PHYID_BCM54991M_A0		0x35905194
> +#define PHYID_BCM54991M_B0		0x35905195
> +#define PHYID_BCM54992_A0		0x359050a4
> +#define PHYID_BCM54992_B0		0x359050a5
> +#define PHYID_BCM54992M_A0		0x359051a4
> +#define PHYID_BCM54992M_B0		0x359051a5
> +#define PHYID_BCM54994_A0		0x359050b4
> +#define PHYID_BCM54994_B0		0x359050b5
> +#define PHYID_BCM54994M_A0		0x359051b4
> +#define PHYID_BCM54994M_B0		0x359051b5
> +#define PHYID_BCM84860_A0		0xae025048
> +#define PHYID_BCM84861_A0		0xae025040
> +#define PHYID_BCM84880_A0		0xae025158
> +#define PHYID_BCM84880_B0		0xae025159
> +#define PHYID_BCM84884_A0		0xae025148
> +#define PHYID_BCM84884_B0		0xae025149
> +#define PHYID_BCM84884E_A0		0xae025168
> +#define PHYID_BCM84884E_B0		0xae025169
> +#define PHYID_BCM84885_A0		0xae025178
> +#define PHYID_BCM84885_B0		0xae025179
> +
> +#define PHYID_BCM54991H_A0		0x359050d0
> +#define PHYID_BCM54991H_A1		0x359051d0
> +#define PHYID_BCM54991H_B0		0x359050d1
> +#define PHYID_BCM54991H_B1		0x359051d1
> +#define PHYID_BCM54991LM_A0		0x35905184
> +#define PHYID_BCM54991LM_B0		0x35905185
> +#define PHYID_BCM54991SK_B0		0x359051d5
> +#define PHYID_BCM54994EL_B0		0x3590501d
> +#define PHYID_BCM54994H_A0		0x359050f0
> +#define PHYID_BCM54994H_A1		0x359051f0
> +#define PHYID_BCM54994H_B0		0x359050f1
> +#define PHYID_BCM54994H_B1		0x359051f1
> +#define PHYID_BCM54994L_B0		0x35905019
> +#define PHYID_BCM54994SK_B0		0x359051f5
> +#define PHYID_BCM54998_B0		0x35905011
> +#define PHYID_BCM54998E_B0		0x35905015
> +#define PHYID_BCM54998ES_B0		0x3590500d
> +#define PHYID_BCM54998S_B0		0x35905009
> +#define PHYID_BCM84881_A0		0xae025150
> +#define PHYID_BCM84881_B0		0xae025151
> +#define PHYID_BCM84886_A0		0xae025170
> +#define PHYID_BCM84886_B0		0xae025171
> +#define PHYID_BCM84887_A0		0xae025144
> +#define PHYID_BCM84887_B0		0xae025145
> +#define PHYID_BCM84888_A0		0xae025140
> +#define PHYID_BCM84888_B0		0xae025141
> +#define PHYID_BCM84888E_A0		0xae025160
> +#define PHYID_BCM84888E_B0		0xae025161
> +#define PHYID_BCM84888S_A0		0xae025174
> +#define PHYID_BCM84888S_B0		0xae025175
> +#define PHYID_BCM84891_A0		0x35905090
> +#define PHYID_BCM84891_B0		0x35905091
> +#define PHYID_BCM84891L_A0		0x35905080
> +#define PHYID_BCM84891L_B0		0x35905081
> +#define PHYID_BCM84891LM_A0		0x35905180
> +#define PHYID_BCM84891LM_B0		0x35905181
> +#define PHYID_BCM84891M_A0		0x35905190
> +#define PHYID_BCM84891M_B0		0x35905191
> +#define PHYID_BCM84892_A0		0x359050a0
> +#define PHYID_BCM84892_B0		0x359050a1
> +#define PHYID_BCM84892M_A0		0x359051a0
> +#define PHYID_BCM84892M_B0		0x359051a1
> +#define PHYID_BCM84894_A0		0x359050b0
> +#define PHYID_BCM84894_B0		0x359050b1
> +#define PHYID_BCM84894M_A0		0x359051b0
> +#define PHYID_BCM84894M_B0		0x359051b1
> +#define PHYID_BCM84896_B0		0x35905005
> +#define PHYID_BCM84898_B0		0x35905001

PHY identifiers are all maintained in include/linux/brcmphy.h, also 
there is no need to be maintaining per-revision PHY identifiers, just 
the main chip identifiers are enough.

> +
>   enum {
>   	MDIO_AN_C22 = 0xffe0,
>   };
> @@ -29,22 +129,57 @@ static int bcm84881_wait_init(struct phy_device *phydev)
>   					 100000, 2000000, false);
>   }
>   
> -static void bcm84881_fill_possible_interfaces(struct phy_device *phydev)
> +static int bcm84881_config_init_2500(struct phy_device *phydev)
>   {
>   	unsigned long *possible = phydev->possible_interfaces;
>   
>   	__set_bit(PHY_INTERFACE_MODE_SGMII, possible);
>   	__set_bit(PHY_INTERFACE_MODE_2500BASEX, possible);
> -	__set_bit(PHY_INTERFACE_MODE_10GBASER, possible);
> +
> +	switch (phydev->interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bcm84881_config_init_5G(struct phy_device *phydev)

Why not bcm84881_config_init_5000() for consistenty with 
bcm84881_config_init_2500()?

> +{
> +	unsigned long *possible = phydev->possible_interfaces;
> +
> +	__set_bit(PHY_INTERFACE_MODE_SGMII, possible);
> +	__set_bit(PHY_INTERFACE_MODE_2500BASEX, possible);
> +	__set_bit(PHY_INTERFACE_MODE_5GBASER, possible);
> +
> +	switch (phydev->interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +	case PHY_INTERFACE_MODE_5GBASER:
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
> +
> +	return 0;
>   }
>   
> -static int bcm84881_config_init(struct phy_device *phydev)
> +static int bcm84881_config_init_10G(struct phy_device *phydev)

Likewise.

>   {
> -	bcm84881_fill_possible_interfaces(phydev);
> +	unsigned long *possible = phydev->possible_interfaces;
> +
> +	__set_bit(PHY_INTERFACE_MODE_SGMII, possible);
> +	__set_bit(PHY_INTERFACE_MODE_2500BASEX, possible);
> +	__set_bit(PHY_INTERFACE_MODE_5GBASER, possible);
> +	__set_bit(PHY_INTERFACE_MODE_10GBASER, possible);
>   
>   	switch (phydev->interface) {
>   	case PHY_INTERFACE_MODE_SGMII:
>   	case PHY_INTERFACE_MODE_2500BASEX:
> +	case PHY_INTERFACE_MODE_5GBASER:
>   	case PHY_INTERFACE_MODE_10GBASER:
>   		break;
>   	default:
> @@ -208,26 +343,25 @@ static int bcm84881_read_status(struct phy_device *phydev)
>   	 */
>   	val = phy_read_mmd(phydev, MDIO_MMD_VEND1, 0x4011);
>   	mode = (val & 0x1e) >> 1;
> -	if (mode == 1 || mode == 2)
> -		phydev->interface = PHY_INTERFACE_MODE_SGMII;
> -	else if (mode == 3)
> -		phydev->interface = PHY_INTERFACE_MODE_10GBASER;
> -	else if (mode == 4)
> -		phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
>   	switch (mode & 7) {
>   	case 1:

It would be a good idea to get some defines for these numbers.

> +		phydev->interface = PHY_INTERFACE_MODE_SGMII;
>   		phydev->speed = SPEED_100;
>   		break;
>   	case 2:
> +		phydev->interface = PHY_INTERFACE_MODE_SGMII;
>   		phydev->speed = SPEED_1000;
>   		break;
>   	case 3:
> +		phydev->interface = PHY_INTERFACE_MODE_10GBASER;
>   		phydev->speed = SPEED_10000;
>   		break;
>   	case 4:
> +		phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
>   		phydev->speed = SPEED_2500;
>   		break;
>   	case 5:
> +		phydev->interface = PHY_INTERFACE_MODE_5GBASER;
>   		phydev->speed = SPEED_5000;
>   		break;
>   	}
> @@ -246,11 +380,970 @@ static unsigned int bcm84881_inband_caps(struct phy_device *phydev,
>   
>   static struct phy_driver bcm84881_drivers[] = {
>   	{
> -		.phy_id		= 0xae025150,
> -		.phy_id_mask	= 0xfffffff0,
> -		.name		= "Broadcom BCM84881",
> +		PHY_ID_MATCH_EXACT(PHYID_BCM4912),
> +		.name		= "Broadcom BCM4912",
> +		.inband_caps	= bcm84881_inband_caps,
> +		.config_init	= bcm84881_config_init_2500,
> +		.probe		= bcm84881_probe,
> +		.get_features	= bcm84881_get_features,
> +		.config_aneg	= bcm84881_config_aneg,
> +		.aneg_done	= bcm84881_aneg_done,
> +		.read_status	= bcm84881_read_status,

Please create a macro that simplifies the creation of such entries:

#define BCM84881_PHY_ENTRY(id, speed)			\
{							\
	PHY_ID_MATCH_EXACT(PHYID_##id),			\
	.name	= "Broadcom BCM" # __stringify(id),	\
	.inband_caps	= bcm84881_inband_caps,		\
	.config_init	= bcm84881_config_init_## speed, \
	.probe		= bcm84881_probe,		\
	.get_Features	= bcm84881_get_features,	\
	.aneg_done	= bcm84881_aneg_done,		\
	.read_status	= bcm84881_read_status,		\
}

And then it just becomes:

	BCM84881_PHY_ENTRY(4912, 2500),
	BCM84881_PHY_ENTRY(4912M, 2500),

etc.
-- 
Florian


