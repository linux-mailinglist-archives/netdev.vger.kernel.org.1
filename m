Return-Path: <netdev+bounces-236913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ABAC4222F
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 01:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 656144E6429
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 00:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501442797B5;
	Sat,  8 Nov 2025 00:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IHvjXRky"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1E420299B
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 00:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762562449; cv=none; b=LBOTUeEHmQjIvdOkHTs4iUFexhl5iiWZxQ1IcyYqcyPswG0p8h22FW1Yv0eOL8og32YK3VWXS2D60awXr3zSOyBciED9uVGE3+vN8Rb7u9Sew/dTjpuAd+0k0jYIyKm96/88A3gM562xOYyHze3z8ON7nTPH5k/61aK3Hk2CWyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762562449; c=relaxed/simple;
	bh=J0nKaDci/bf56DMGdOeTGV1xrKeBDLFY2AUNA2ijRGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6+xdzmPyO/6RVncxwQ71L5I28BpxMKHLcWVTh+WsPM1Uz2aIkCpTnQS7vFv6JAnVU+sHcQ7YSlfSQPw6hGcTngNWosenDJg/lFrtL2g5Levh+n3dhfHIxWZ8g4d/Ab0k3j8DHmaLz3CIl7BMfnQ1YpauVi6UTfKtR7hQP97GXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IHvjXRky; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-b62e7221351so1078283a12.1
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 16:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762562447; x=1763167247;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uWIFqiPHB1GXpGnBv9lxX4c884/HCddM3puiF8clPJU=;
        b=ThX7VEV6n33lmhMq7IgV515yz8L/RhSfrh0NGwz9SfXoyCtPecjjc9JG9TbRJI5Iy3
         4TdHiEnLIdI7JodRHkw0jJGFYZ6Zt1PFxz6yNlQTFZGIfYJYN46ZPxbftfvx92fKV4Aq
         mg339U3P1TMHe4tgFzuDcGv9as3hUxjvtnV88B/WpUpnENlyw6M2hy+YlNR1qOuzOiJV
         bcOTPOzP7/8pMhOrb9VFB3tTQS8+0AP+z/NyhaLUZcMNfkQN4NZUx6l9EPVpfO+/5Tf8
         KOW9I4bDWKDLavgCvBzk87W8b0ix7wmOVpPPiEMvu2DRkz0bSMPxX5Y3wnmBo3XwzIZi
         Y4Zg==
X-Gm-Message-State: AOJu0YwJTbiOekxJyrr/4lU+QcSQ9TJ6aA5jIxHXmzxBMbSA+T0bDS8l
	LRHUh3+dQONcDqweY8WbHZHuD9z9r95mjMhzV4BZ1Pybeodwk+5idSHgRCNjhJWXNDfO4Vr85fc
	ALx1wbpOLOz6GU97TgNLPYGuJkPr3U9ty/weSehlh3mhsKsN3BVKlioMtSmbe5ddIMtxDRy66ie
	ukq7VbLkg0yURxMDUWGJ0Tw3/1fOHbcjOdcUUzzMIKsdx0ne3z9dojOCennNrlgUL3gFVzPzZH3
	gAUJ0NqlO9VF8nK
X-Gm-Gg: ASbGncs0xkvGn56ZAicbpktGnP33RviYQYIKItokN87iaMLA+Y+tHOaNFnLJ20hT02q
	3qRwqKewJW2yday46kA3IllLPHgSlAAssjM/y1oKmK5CKugsAVxax/QRpH6xwR+I+FnUaTAt+SP
	4Acw8+tdXsZon1/3i1tK9l2V74qt8wtHugH+dXSKXOqhhSGOj7yENZAAMDXX2UxJX0ia8KGZEKy
	R2RyUiiVbakrWEqgO5BE9yfj2f/2rYlX1B2kHWBmB04jI4Pw8D8+YALz8FMPlQ6veYEUhgtZ72h
	RElDhWPeRdJ/D0437x1mzG/rSAAJuzz6B+8qusV1zMz4gE3ANTWhhmmIZDtRT5MxRQ5I2l2/Lt/
	nEyoH8mG39lYm1TrAsNIDQvKdtnEZwblpzqbjIj8OIM+yVpVbcMFWHPzCIg+Aa1vopPoVKpmYIU
	vIoRl4gORnPKCR0YYvUXMDQ5Qu+aEHzRhqIDluFH03XQ==
X-Google-Smtp-Source: AGHT+IEMyS4hNmoIRfrDxbAbacXbmfsmjTLGd2lw0k8X192f9A+xve9rmZnvaLtHAtw+iKryZhD2YCvqSavz
X-Received: by 2002:a17:903:94e:b0:297:d6c0:90b3 with SMTP id d9443c01a7336-297e564e7b0mr11159515ad.23.1762562447223;
        Fri, 07 Nov 2025 16:40:47 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29651cbf99esm6065855ad.56.2025.11.07.16.40.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2025 16:40:47 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7c2916aced0so2681669a34.0
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 16:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762562446; x=1763167246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uWIFqiPHB1GXpGnBv9lxX4c884/HCddM3puiF8clPJU=;
        b=IHvjXRkyH/OZhsrciY23wdMYF2vJsD1wE4N1wOJ4v6XgH1AFe5fKkN+f7Z5/sqq733
         vm3rJ8Zw+ag12MauCgsJMCSQbN4gxhsl9b9Bh01wzdGT1zY7uYEgmMXWCOJIwgvfhF6x
         jphHUM69otToz9ruGqCw2JceXJokXsfVMo/SA=
X-Received: by 2002:a05:6830:926:b0:7c5:2dbf:4a83 with SMTP id 46e09a7af769-7c6fd710e94mr918626a34.2.1762562445869;
        Fri, 07 Nov 2025 16:40:45 -0800 (PST)
X-Received: by 2002:a05:6830:926:b0:7c5:2dbf:4a83 with SMTP id 46e09a7af769-7c6fd710e94mr918614a34.2.1762562445596;
        Fri, 07 Nov 2025 16:40:45 -0800 (PST)
Received: from [172.16.2.19] (syn-076-080-012-046.biz.spectrum.com. [76.80.12.46])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6f0f5ea9bsm2277541a34.10.2025.11.07.16.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 16:40:44 -0800 (PST)
Message-ID: <c407e447-1361-478a-84ee-68d1d1e9ae22@broadcom.com>
Date: Fri, 7 Nov 2025 16:40:42 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/8] net: dsa: b53: move reading ARL entries into
 their own function
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251107080749.26936-1-jonas.gorski@gmail.com>
 <20251107080749.26936-3-jonas.gorski@gmail.com>
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
In-Reply-To: <20251107080749.26936-3-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/7/2025 12:07 AM, Jonas Gorski wrote:
> Instead of duplicating the whole code iterating over all bins for
> BCM5325, factor out reading and parsing the entry into its own
> functions, and name it the modern one after the first chip with that ARL
> format, (BCM53)95.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


