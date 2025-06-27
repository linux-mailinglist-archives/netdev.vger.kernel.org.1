Return-Path: <netdev+bounces-202081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0176AEC2DF
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 01:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A17C1BC20F3
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 23:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966DA28BAA6;
	Fri, 27 Jun 2025 23:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bsUTvqle"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3EB26B756
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751065691; cv=none; b=bsea7gdDV976wY6ULPWiY+Qs5wwMrT+rDS7FDFRSpiqEVbQEmHxUgrmDMWd40fs7iZKCwMZo1JoBQUVftNQcqq0y763ggSuFzUZYHT7rd01tv2o4NA0b0Sp/08HLttyac/D0Z5yGOh/ohICPN2D4VOlQrBSN3jS0b3P6uuQ7Ras=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751065691; c=relaxed/simple;
	bh=+MHR3P+rgWKvsJl8Dr+njdhZKG4cwvmvL/+imvJxRxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4aOVKUT5MlL01kvVXhi5y6C0zlum/w1zRf2RVzxcSxMkVExAN8+4wVfDhTV/ZWWQS/pGfORQ8DKG3op07CKqClC5xGX9HUXpsJBpxdrjBDcii/9eCp6gQfaBp+CkkSPe0E6GfnCfCFmTG/QmDH86QwrarErbNeax/You2AB6p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bsUTvqle; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74931666cbcso3033907b3a.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 16:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751065689; x=1751670489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rx+DkWxUORnFAHBKMIRQ/YDScdVvTEMyH1ysFWC0iSo=;
        b=bsUTvqleOev8S41ASVI/adSCi7kLKl/tTLC7vj+sqpv/2RcYEKGKychKa6yfM0YKOe
         4vZPcyVlk11g5bNDqG2+NQjNLHQBjAdCvHFe0zKijjHDHuwr/9EwzPzkD58zyVmCx0fv
         oTIXun2ddeKAobF3fpFtL4glic7ND4WdjMDiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751065689; x=1751670489;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rx+DkWxUORnFAHBKMIRQ/YDScdVvTEMyH1ysFWC0iSo=;
        b=m+v+Sap/RbKZNndJ/yhBJuPvMgANAytltKFFt9eYuVP16k6G2jWmDN/H5cii6eKbcR
         H4yVYrX8wP2nRFmcmw12sXYKLog5863qS7iiEDR0xte3LbX3F3nob7nRg4+5LtO8Y9Pr
         eacWhYu0tG0V0q3ujJdkXGClqilbKUlFt3BG62mPVdndJP+r7JhxUmxVPniosfG/tPaW
         GMz4o/fnkfmohhkYcqDSknY1YE4izCYrrZBi3L47AWXCZgSTNmfx5ayq1v1rPxmrk+fY
         A/x+ophyicX08T3okoT8jz/iUwqxiyulehC51Z2TMfpaOCOp/1+IWL6bTALwT04TCNT+
         4p+w==
X-Forwarded-Encrypted: i=1; AJvYcCVAbynl8pbxlW5Kn3S8Bx5UkUhreC40tOCY8YA9x1XQy6403msM1+8QUMDmjuABKq0+XP7bCMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9K+RpVRvyDxsF37N+Dmdh/umafYTAenSKJX6Z782Hurvl61If
	zdrNn6VRHBQi1b1zKpsZRdSus6lOej36DipTFbPsdrvfi5vNL02x3tEAT9fuQhytYg==
X-Gm-Gg: ASbGncsVp0xSuNz6DY/87zZ8DKGWIr1/mPZ/kvmnTth4asZKZ406JJAD9q1JHTKjktb
	COKEqgIxsNN8Z6kYA1d/Ix/O4uIpoGkGd3CdggOTb4UJdYOHtKpXvzMSAjdWzJeJBzEAM1at0gs
	yITuXcel/9H9PiiMSE145rI002OEuTjQE8oMOSw95xexBYIsiuea2vKDvslkP//SeO4S366rOZv
	RO1XVnk1G4krsYgnsHOBKTM5ELtcEeXdGzb7Ik2NIF+4H7mIVWDzcuU4+F0RBXWCWHds72IjEyg
	vNLNP5DjLdroJgE6s0prDtYOPrPF2SwKz4zUA8TE6pBLKOCUJmW0reExxQZy3iRk2jQnqMvJ9HY
	A1I5CcjOkGtpkp2Mkswd7ajVbPxMsVSugetyR
X-Google-Smtp-Source: AGHT+IEmJFnvIQyaGe8snuurKxiaz9FSD9LcLtKohAtEMbsBYRoZ6w6EteCQBij/i7wuFHb1nT+wDQ==
X-Received: by 2002:a05:6a00:885:b0:749:464a:a77b with SMTP id d2e1a72fcca58-74af6f6f9d0mr7406755b3a.18.1751065689536;
        Fri, 27 Jun 2025 16:08:09 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af55c6c67sm3183896b3a.110.2025.06.27.16.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 16:08:08 -0700 (PDT)
Message-ID: <a4ee184b-f2f8-4c0b-97c3-c853ac375f63@broadcom.com>
Date: Fri, 27 Jun 2025 16:08:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 0/6] net: dsa: b53: mmap: Add bcm63xx EPHY
 power and reset control
To: Kyle Hendry <kylehendrydev@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: noltari@gmail.com, jonas.gorski@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250620134132.5195-1-kylehendrydev@gmail.com>
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
In-Reply-To: <20250620134132.5195-1-kylehendrydev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/20/25 06:41, Kyle Hendry wrote:
> Some bcm63268 bootloaders hold the fast ethernet phys in reset
> causing an error when they're probed. The resets are controlled
> by a register in the gpio controller, and would need a minimal
> driver to set. However, that register also controls the
> power states of the EPHYs. I'm trying to implement both
> functionalities at the same time to make sure that they don't
> interfere with eachother. These patches allow control of the
> ephy register from the b53 switch driver.
> 
> Is this the right place for this code, or should it be in a
> power domain? Should the resets be handled by a separate reset
> controller?

Good question, it seems like a reset controller might work with one 
reset per port being defined? Unfortunately the register in the GPIO 
controller is not logically part of a GPIO interface, it's just where it 
landed because that was convenient for the designer.
-- 
Florian


