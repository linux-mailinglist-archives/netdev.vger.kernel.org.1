Return-Path: <netdev+bounces-168217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF51A3E27B
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4559D3A6CB7
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 17:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9A2213243;
	Thu, 20 Feb 2025 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XcMOk1fK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3D1212FB8
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072201; cv=none; b=ttvTLbIUzg7x1IZcQJEU4sTiUyJ04ZE3/LYJlSfxkaC5d+Ac2bJtKt76DC/nL/5lqa5XQk3hXxiarx2gdhmvlipTIHgWnpPXEK3VEtapSch1WoHjScGaYVaZiQebIVsk//Z9Mz5U8y4Axc5cINHM9WxtaaiW7VVN3XSBC7ZRhu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072201; c=relaxed/simple;
	bh=Hw97JhtnKXny8SYR4ztJSphSmBHJYnbnmdgEdROhDAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kzxub6y0fTVwASTqXhj43UAlvjOIbh//IZhzyKgnVpswdrmDRDmzaD6AEk4ELnYo86DdCZlPJ6XKJKJTGuyB8hZV1Ae1JrLFEMCuX2Ev7qI0JsqX0eJsAbQv1noqu0/SDkB15/TXvolpy8qwV7j2+lwxw+kqBAp+p6XC05lnqpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XcMOk1fK; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f422d6e3b0so105779b6e.1
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 09:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740072199; x=1740676999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KO7H4VHs+QczF3CD8h6LeuqD7FLc0DNQxeiDRPSrHIA=;
        b=XcMOk1fKSFwtiOhq9Sk0y4dPiOkwB8x5ekbD/BlfQzUW0t1wUVUOTKqhwDv17/Cr4S
         egij/t8pRz98rARva+h5SZfiwjgM2czJovP5dKrG7Vbu2U94UnibqDccQDQ+fc+DbgkN
         3nrJ4t4LIZqRBqjWPkB/nNPIB6ZckCliO/ZRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740072199; x=1740676999;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KO7H4VHs+QczF3CD8h6LeuqD7FLc0DNQxeiDRPSrHIA=;
        b=epS2ZvRu2yDlYMUa/HA/ub57Ywj7MLPRzPc417/Ih0UP1a0i/E93PTAgykSGb9u92Z
         y1A9l8edCKORHGAeGgWfH+ciCz2YKdgW8g5d4o6FM+d5r1RaLJ6Ahly2R08r9MH4EavE
         HnAYvRAdDEEHEHVPMst8tbMb0jXXn5orFzV3quOK/2kLc/5NmVkLJIO7YXVCWd/uezVV
         Cy7RzgvD08WTK4Wz+BSwn54MRFcI7ogsVAXiqO5pI7vBSYYfnVveSC3ZVJ8Z9pDi6fLC
         SnFkPldPkOX9QUsNMeFEWrWe9aZVI0/bkeYuALq7kDoSu2s0Os/XT2PiMflnLIkxY3XZ
         TSHA==
X-Forwarded-Encrypted: i=1; AJvYcCVKk587J8JXdJuP6EL2bLvM7Fecfhgtu911FR7VJnN+2bCZqkkaUJOD63RZV9NXnefafKGyG0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5/cHeonXncyczsb0JllPAn/gU9rY0F0Lqa9oX+gdHSeyqz1qg
	1+GFIQ2x8ivhSbuEkaoBrpRcy+ZJMQoBZKK0aOGfXLjHfQg5EW2MjaaLRlpjPA==
X-Gm-Gg: ASbGncuap7iBMhBtnyBM9/UEGsisivlgaHUffXsTf2Ivd1wgYivrf2kjfeOg1NaWiUp
	Nl6jvJU7hr6xTYa3iP/4u5vsMMltnm05qBKmSiXdIMTy0GtS3Mx2rxiQ+hIzSSIlARh71hmXjBl
	SuHy9smU1Z1Oz9YycT6uv2YuxG/58qTlCiLICHf8bAXSqGIp+J279iCC9q+JxZo6j84ejHZ8UOd
	fCiv/yIZpwNHQGa0ptTl7Dd9/oGP3PSSKtOyt53bu9T86lKvUqyJ2NJfoWSkgdGDTRTBFx+fp4F
	03D/O0BW+RpJBgnHhATyP0q3TFnUUsVgxc3WcPUeiuIqMFyIDilQrwuBAFdxrArllZviDl3ZgOk
	DpKkh
X-Google-Smtp-Source: AGHT+IFNMmfpJyIfAe5dEZJG05M/SHFALg3tklMXrjbHlFxkP4JFLXWaPkYg6R+CYIbTkwyziA3SlA==
X-Received: by 2002:a05:6808:14d0:b0:3f3:f90b:f1b3 with SMTP id 5614622812f47-3f42469d77bmr204952b6e.5.1740072199073;
        Thu, 20 Feb 2025 09:23:19 -0800 (PST)
Received: from [10.171.122.29] (wsip-98-189-219-228.oc.oc.cox.net. [98.189.219.228])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f40b027906sm1450746b6e.42.2025.02.20.09.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 09:23:18 -0800 (PST)
Message-ID: <89e74137-c3cb-4318-969c-81e5f4a3a778@broadcom.com>
Date: Thu, 20 Feb 2025 09:23:15 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] net: phy: enable bcm63xx on bmips
To: Kyle Hendry <kylehendrydev@gmail.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, =?UTF-8?Q?Fern=C3=A1ndez_Rojas?=
 <noltari@gmail.com>, Jonas Gorski <jonas.gorski@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250218013653.229234-1-kylehendrydev@gmail.com>
 <20250218013653.229234-3-kylehendrydev@gmail.com>
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
In-Reply-To: <20250218013653.229234-3-kylehendrydev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/17/2025 5:36 PM, Kyle Hendry wrote:
> Allow the bcm63xx PHY driver to be built on bmips machines
> 
> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


