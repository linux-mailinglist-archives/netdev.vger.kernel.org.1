Return-Path: <netdev+bounces-220121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B99D3B44817
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 23:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FC41C82F8D
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E452989BA;
	Thu,  4 Sep 2025 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xtng+lnX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com [209.85.210.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02298296BC9
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020065; cv=none; b=JZBn7yaNi7hp58NilmLkikpvAOwcWTTAjc6rh0klloJG05YdiuG9FOicGAKrGsDTdGjFi5WyQl4dF8egDwD4B1y9RzE6xLZ68ebXu6t084zzkM9XYKxYXc/us1AjbSyfRDHlHToK8A54QBxK9EM8b/uQsjp9KL+DbsbTTnOBdo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020065; c=relaxed/simple;
	bh=L4hVOmcud+TACfKx+N1gr2mDrKeV80TY7/5nxXaQ2zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQVdLBeanZZqpNuH1s6pbwuEQMjMoTBeNKQ2VbiC6dHyAZMs+FbjajnDo6fu6baQABNOmdB22AJsQIXSnpjNYboGoIsDCcgwmgvhrQMp0zZOGreau0rMJKxIfY8q25WteTs7ZMzzeL17vF81PahOm2c0tkV9VTGkjTM0Ihk4oFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Xtng+lnX; arc=none smtp.client-ip=209.85.210.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f99.google.com with SMTP id 46e09a7af769-743814bcca2so1077678a34.0
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 14:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757020063; x=1757624863;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByPLAhnppoP8CNiz/fVGR4JNCX8K97yEjrDCLtVL03I=;
        b=nPpgPAQqlIMCZTDqkqNQSvPbbLb795kESXUp+IlJbTIgTAETwJCHzDdU+QqrvggrsD
         98PcjuwS3/8UlZyssYlXWr3/lueUZUMDLlW+hkwp2NT++qs7owS6CUDcTeSLVwPa+ozz
         NVaG5lZEntGlPPI7NMnkLwCfhFfXrwfkKfffTv9nZ1FMNTt5MHJa3hAIVlL58hdB9duv
         iKyLSllsLTSPZM78tMXlZbrdu0GAlAdcCBd9OJZDa7IV9y4yWnkvx7e9EIjNUpL+mVKH
         NRVP/sUNMDYTxxXjzBNxc46NhKuXBdLuh4Sv5oCDRj8EFgkDiB3ugiA3Qj9Q7o/TO0N7
         9ksQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUUGCZUy7fn/Ui7Bi1FGBpgG3TTlv1imKoK3Akz2B0x+zF1xm9ApDeG65lPX/IZS0dkE69Xv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8bd76AAeIeWO/8Q56G/k2hnjQf8oU690wN4PghW/hu0iO9x7a
	0aZCuJzmUeZgtG+B+UvQzYy3abtz4WYcK9Y7axshzhVlDn1BG1AJcU3OxaiWXscp+IRoLVgLAXo
	hEfLflgSBWjtQ1roB5LTe/2tnYdT3eT6kMarritI04IR15nq0xzDG7Js99VVTUPpt5ATlYe1KT1
	APAWAWBzyxMagXvhOS5974XG7vXzjRGzwjnRRIuq+TxFe+86HCu7YSazbIfV6QWoET6327ZYu2N
	NLHkdkzkiShLDKQ
X-Gm-Gg: ASbGncuNr0V2mmNNvuTrDAxM+POz2I8i7oTxk2edjw3ZXEwtBvee1ZLGMUYf3ragTke
	yxvMCLXi5sF7G6fx2NsCo/DmqRyUlQwSqOt3wQXr1SEznbXgl1WiFfQi/B9omXGT5Ps4Vs945z/
	OxywPGWj98V+QNAgMBFDm/hRtSCtzELBL2TCiI9kRvdAw9hwITzwVbJZB7HTyoy4OlL5Yll9www
	/wm2ofYCJNxAg6jMVWzVeAWzT4vAD6fATwMWLoFlvHIIUTlRKyqkM3nO0BRYoyMCwxEw2xmT0+Q
	athTYnVWHhjJ7mNhc1GG+YeLN1hGrMU9x0Br1yORHAe437UfL+reGEO5gUAUHzWPChIUNtr5MWJ
	2sXsG7fGV2taMluhEGAt0YCCI+ORC63Dz8xB/aIT2Ag8+qBQ+zsUup6fV4cAmzJam+sOn3DYfGg
	5eB4PD0/M=
X-Google-Smtp-Source: AGHT+IGaq87ROQvLDctNo+jmIMbwB2ZbZr1lUu2zWhmQIcIwfqRipRhIBjViR7j4oTo9apt5K/70zFzuR2T2
X-Received: by 2002:a05:6830:641c:b0:745:99e3:80 with SMTP id 46e09a7af769-746d920ed57mr645440a34.6.1757020062956;
        Thu, 04 Sep 2025 14:07:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-61e644cc753sm382582eaf.9.2025.09.04.14.07.42
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Sep 2025 14:07:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7222232866aso25766666d6.0
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 14:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757020062; x=1757624862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ByPLAhnppoP8CNiz/fVGR4JNCX8K97yEjrDCLtVL03I=;
        b=Xtng+lnXKU2dXjM1wv6KtQNdNT0OEZp/sGJkJ4pvDXAtqOpJpFx3MWtd7HaB73goGE
         Pbtf8sC360OBJCGBSCo01XWbHqPU4Np4Sn1CDRSJdV1/sV1AuB/Tp5rNI2WdZjxCJLRx
         hVMfxnKDKmSCTG/ROMr5Fv+w6psJFqWDHxdfI=
X-Forwarded-Encrypted: i=1; AJvYcCWlaaSsSnZgtfxpZ1/S8eBT8omWFvzpmzC2d+V47AfYXqyEcNCxDiGh1aKlNPtHb8q7ysTxHus=@vger.kernel.org
X-Received: by 2002:ad4:5cee:0:b0:72a:54bf:1f04 with SMTP id 6a1803df08f44-72bbdfc8ff7mr15622046d6.7.1757020061620;
        Thu, 04 Sep 2025 14:07:41 -0700 (PDT)
X-Received: by 2002:ad4:5cee:0:b0:72a:54bf:1f04 with SMTP id 6a1803df08f44-72bbdfc8ff7mr15621476d6.7.1757020060999;
        Thu, 04 Sep 2025 14:07:40 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7220f78b9bfsm43245116d6.64.2025.09.04.14.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 14:07:40 -0700 (PDT)
Message-ID: <06017779-f03b-4006-8902-f0eb66a1b1a1@broadcom.com>
Date: Thu, 4 Sep 2025 14:07:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 0/5] dd ethernet support for RPi5
To: Stanimir Varbanov <svarbanov@suse.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andrea della Porta <andrea.porta@suse.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Phil Elwell
 <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250822093440.53941-1-svarbanov@suse.de>
Content-Language: en-US, fr-FR
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
In-Reply-To: <20250822093440.53941-1-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/22/25 02:34, Stanimir Varbanov wrote:
> Hello,
> 
> Changes in v2:
>   - In 1/5 updates according to review comments (Nicolas)
>   - In 1/5 added Fixes tag (Nicolas)
>   - Added Reviewed-by and Acked-by tags.
> 
> v1 can found at [1].
> 
> Comments are welcome!

netdev maintainers, I took patches 4 and 5 through the Broadcom ARM SoC 
tree, please take patches 1 through 3 inclusive, or let me know if I 
should take patch 2 as well.

Thanks!

-- 
Florian

