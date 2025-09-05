Return-Path: <netdev+bounces-220410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830CEB45E23
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 18:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467DD5C81B2
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 16:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9682C0274;
	Fri,  5 Sep 2025 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="W1+hgJzt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE79731D750
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089764; cv=none; b=Z49xdY04kkLltGqLhGmg/PxsQpp64qIToyco9G/y0FEluiW6hT2SuG6ZE37ocQ+LKFf+6bTd8FEJO9qoY0hpzoI4k0xZUZ+lDfyMnXYlPtB/xtJQsqLmXKgcyZrkfSFMOhwJiO0JMbgPHYGxykwgo8nMte17O5Eq0NnGk9iC9yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089764; c=relaxed/simple;
	bh=VCRprQuG3eJRVmXySnm1RY2bxZG15OWhzU4Qo2J1MAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rOCSNZU3vUuY9jyX5fuburmqbO1oPpIGZJnQFcCgftypfUHNj6xW/+0slFK1YIwcP9MCh3bwIeY7M/u65QWFesOaCuD8EWNVHchJsLWg8KOqDLmDlLlDtoEgUJbNNbvCcvhHikaXJDISzGQ6p6Kwou8npm1CxZkJsvNDJxyDP4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=W1+hgJzt; arc=none smtp.client-ip=209.85.160.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-4b340966720so15873901cf.2
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 09:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757089761; x=1757694561;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDcBS9ZQf09+Sv5HM5XXuVUarA2h0FYbmVQTBGicKGE=;
        b=RTk2OnggPFJeebtAnCMOCDCt5P0AI7dSlFBlBYbY/gVKi32S1ISNARCgJLnioRlxay
         hhCcbyZzSQ9JX/VF9PyCJcg/xb35WoORzVH39AUB4IYdfHLXBEJimjB/YZ5FcLBSmquL
         hl0TnhJDg5OGI1ba+cnu7Zn+NhCCTzU9opiyxS+Hg7vD7wfuZ7ZF/24DpJFKHAFEPDhh
         ugB79WdJfR1wOviQnZJU+WR6KK74TAoXC4H7FIUfBg4YkGNqmTMdovCx/4RZAW+qxpGG
         NKfV6DOloRcNsXxG8bp/Wepr7u2/0aTQa2vyHkDAyz5kbTe0NTdH2e4U8testKzOhnWj
         kaWg==
X-Gm-Message-State: AOJu0Yw2vZVvGePLmZOuAMNY1tSyvoDiw4JouzRwwd/cIsw3iOsoRBzf
	8Cm+yMKxi8aneLiiDqSfwSNA46FATkWyXKEMLuL0C8M4MODPx18PTiirQgtzkltgTO5pzdrgm3V
	5aBIA8IxlI4xh3TbHbCHoiRdtG0AYi/K7HwZ4MvfJquwNosZdphLGcoLVX2iXDwGSgIpB5rhCD7
	qWL7WAS5RBY50MTJvjfHPQmgUCA0hfZDW9/+ncQugUFtavJ3qrc+/+w05jSKmLtyMIlT3tgBQfA
	MtTv/Lgo6dFBNxA
X-Gm-Gg: ASbGncta9Vx0JKf+awH8Y7QawQmSJ7pMwubUdjr2leaMyyMgZCHiKqg8P5nmoEvFbif
	0lWwrCFbpLz7VqOnPRT0aveKqgDi/O4Aaa4ndckFh3QHQIwr7iC2uyRY1JTtfftVYNUZ7Iv3zoF
	HiUFJazjOsPyHxFSjGBE7DT6u5fZ+8peMvWRnay5QchAQVZ5OBWjSqVNPHVdTgHHGn7tDNKx70X
	6A1qu/Hr1d691bDjRhI5keXI8eLzfymjYJfRszJGQg1ubBY7/r2OKGWyZ2CxEztH0fmryvqih3Q
	v7G0i7gBRTq8LcbESkxkMmny/KeMRWvtA7QMenTg0wgj2dD97EME9Xd5G5nvowBrDFLleogioD5
	4/WcVf4hyhhGkHNtSuJmq/dcKtpiNo1qPea47saAbIdJjLY4CCm0VZcrKAx4iywZqPWMHv6hGWy
	Wp4hVQeis=
X-Google-Smtp-Source: AGHT+IHB7FOIX80TBSs1WOyYLHhmfQ4n3zVBUpXyrWUO7M+60yZ2sPg7cKn/QqdRAnZVnJmaqM33Le8dZ6IO
X-Received: by 2002:a05:622a:2614:b0:4b4:9062:69a4 with SMTP id d75a77b69052e-4b490626bf6mr125490191cf.35.1757089761352;
        Fri, 05 Sep 2025 09:29:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-122.dlp.protect.broadcom.com. [144.49.247.122])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-4b48f77ac67sm1130131cf.9.2025.09.05.09.29.21
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Sep 2025 09:29:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b32fe42b83so39151581cf.0
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 09:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757089760; x=1757694560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YDcBS9ZQf09+Sv5HM5XXuVUarA2h0FYbmVQTBGicKGE=;
        b=W1+hgJztqAnGhaHn/LPEep7dcf+0orggz2AJ4qQOXgHMXHX6REvqw0Ie0+7Myj1HL3
         UY2uNLrZVfQ6NAdSJRx5Fe8yC87Cv/HOMOp6hHH83mj9MKHJC42eCfrFG6yOhqtt8qLb
         DJiN21VkrovWeZrxdabUs9lCQDCTuwFkXb59o=
X-Received: by 2002:ac8:584c:0:b0:4b5:edd3:ddde with SMTP id d75a77b69052e-4b5edd3ebd2mr29216651cf.81.1757089760530;
        Fri, 05 Sep 2025 09:29:20 -0700 (PDT)
X-Received: by 2002:ac8:584c:0:b0:4b5:edd3:ddde with SMTP id d75a77b69052e-4b5edd3ebd2mr29216131cf.81.1757089759779;
        Fri, 05 Sep 2025 09:29:19 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aabb8288dsm497299885a.58.2025.09.05.09.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 09:29:18 -0700 (PDT)
Message-ID: <5e97121a-01c2-4a5b-a7bb-0034dc344768@broadcom.com>
Date: Fri, 5 Sep 2025 09:29:16 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v2] net: dsa: b53: fix ageing time for BCM53101
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250905124507.59186-1-jonas.gorski@gmail.com>
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
In-Reply-To: <20250905124507.59186-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/5/25 05:45, Jonas Gorski wrote:
> For some reason Broadcom decided that BCM53101 uses 0.5s increments for
> the ageing time register, but kept the field width the same [1]. Due to
> this, the actual ageing time was always half of what was configured.
> 
> Fix this by adapting the limits and value calculation for BCM53101.
> 
> So far it looks like this is the only chip with the increased tick
> speed:
> 
> $ grep -l -r "Specifies the aging time in 0.5 seconds" cdk/PKG/chip | sort
> cdk/PKG/chip/bcm53101/bcm53101_a0_defs.h
> 
> $ grep -l -r "Specifies the aging time in seconds" cdk/PKG/chip | sort
> cdk/PKG/chip/bcm53010/bcm53010_a0_defs.h
> cdk/PKG/chip/bcm53020/bcm53020_a0_defs.h
> cdk/PKG/chip/bcm53084/bcm53084_a0_defs.h
> cdk/PKG/chip/bcm53115/bcm53115_a0_defs.h
> cdk/PKG/chip/bcm53118/bcm53118_a0_defs.h
> cdk/PKG/chip/bcm53125/bcm53125_a0_defs.h
> cdk/PKG/chip/bcm53128/bcm53128_a0_defs.h
> cdk/PKG/chip/bcm53134/bcm53134_a0_defs.h
> cdk/PKG/chip/bcm53242/bcm53242_a0_defs.h
> cdk/PKG/chip/bcm53262/bcm53262_a0_defs.h
> cdk/PKG/chip/bcm53280/bcm53280_a0_defs.h
> cdk/PKG/chip/bcm53280/bcm53280_b0_defs.h
> cdk/PKG/chip/bcm53600/bcm53600_a0_defs.h
> cdk/PKG/chip/bcm89500/bcm89500_a0_defs.h
> 
> [1] https://github.com/Broadcom/OpenMDK/blob/a5d3fc9b12af3eeb68f2ca0ce7ec4056cd14d6c2/cdk/PKG/chip/bcm53101/bcm53101_a0_defs.h#L28966
> 
> Fixes: e39d14a760c0 ("net: dsa: b53: implement setting ageing time")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

