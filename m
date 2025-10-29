Return-Path: <netdev+bounces-234047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BE3C1BE6B
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5F66E4559
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 15:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B243451CD;
	Wed, 29 Oct 2025 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZggzqpc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9BA33F364
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752485; cv=none; b=ZxgGAp5PzHMJHDZ3HKpfRgRxsQhUjDSWB1MfbTkRP6iXV/OEJMIOcAnabjI9AX5Vu85tA/SQA0u20DydDXfWC13lAX4AtGnpEWTElSloDm5toDZwIGeVrT8FGPSoVA8QutZbaOAXPGpJbA5DtB1xvjGnsO+yoqGHCP6I/HJh75g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752485; c=relaxed/simple;
	bh=Izt/M1eD7EaLetgRtHuStb92+B0cyCwMxO3AAqo27H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thwkJup5gaweglMqxicv1ijkCLUCi/lDc/pW02SRN7fHAR2fH2TOdo298JHykvgJ5NHJpNwUPAanYFu/9jmw2tJaW/B8BDKZbmw19qHTO8/q+rJ3nMtxYHkz3NpwrvRds49AO60jgQH3cVAvf0xxLPHG6ux8XSX8YQI6cGVSA8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZggzqpc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29488933a91so76348555ad.2
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 08:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761752483; x=1762357283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l/v0zo/mXJp1eqDSZs81X2kYmENmq+DmgWPaQLy4E3g=;
        b=WZggzqpcAWDvPttiimXniEUgKPzxz34FtlGNM02/8BUX6kepdca3JyirJ2NdoKKujN
         tNgXGkxJ8MzcgPqRU6VoZnNP8AzxdDhuYwaajcY+HEuhEGLMUvoJAbf1J7cLJbCYRWJi
         qolx8zRfrpXz02/fQePBVAqZxPW+aFVY7H7Ylp2zKNxalTquK+e9Jx1hei0bTpkaF7CU
         H3ojd/gKsAor2igN8WDtmenjTF8tyvKPHKHeLdM7Z87MtiiHz0mbn0ekPNoYf6o7J/Z/
         wl9qeSy/1kuFHxPFifRrXYlJcVvatqjDx9hSnzIAWnADyIp0+xIHX4OQ8+lLiDNBa0Mz
         kAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752483; x=1762357283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l/v0zo/mXJp1eqDSZs81X2kYmENmq+DmgWPaQLy4E3g=;
        b=UhLjB5GyVyjLXILy0HmEDtSek8x45aHZ9tGDGUhtxcsrQWbosMGDwMjVFQ+c0LnuKs
         EEvSiguJfR7rJ4fZbwvUYYw/EeXXwnsu4iRZLT1WuvrFNFpTIqA+V4e+RpR9u+DrwADC
         0qGJoKsr247txxtzEFEy6ejttnY63+AIF+cVNE+KRHvFUA5rI44hkguSe9gUyF6U7y26
         +/Dr1juCl8yFbv4/W/hZ532YhPV8LJwlOgLfIRwkhnZLujc0Dp3Bs7Yy4itEKhHjRgrs
         ge5GD5ef4+1K2p/dnnnY9wyBqtbwB2j7RWnNcWQf17EuBeWXIH1wqVqS0Mafzjij+aLx
         3stQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfNQ075UBX78r+/SSDCSKPhGO2K3lscB+RbW7T9UEjMSqzfXUborNIbk7EYn7VbNh7lsPt2Xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcANCA0VP07+L2onQ2cgAjO6PG38r/UWHbXuND4XoA3weDPw9a
	cd0Vxpf0l+pASejmo+KCrM/Qc6DrONexkW9moKwIgMkrZxF/0Elpx8hz
X-Gm-Gg: ASbGnctAHcW0DiAmqdzGE/YVnEmmLucaOdb7LfxtY0DFrrB12TGQrLWSEo1B6mood9b
	iGv6cnH5LrHIxzV/qx0Z2Su4kgaLpre0ihpw5evJ0MksaVqVzyE3pzvxeJ2p/uVFcZ4aYWCGLph
	PUNtwL1rHnXRofoHD986Wus2WY1o/WvlDipuJHAX72gxcLAOqLEekO1IRPPH93d6KmnSzMlzWK5
	6cJulTVFkMqY/8zOe2qxEYxhtsZ9gfTcE0ErLUUFpkFwrZowsj4ZYfvHLRPzVAolVbhAUiw4Zj+
	y6VE06La38qhrIyBEQoKhJI/AM0lJuOhobQRZG6joDXC35mtdcp8Ku3Lig2NbHfuchpx/Zcj2lt
	MdMlE4Tdu0UyA/hsK7JKhhM0ogu+Howeb7ZOnGc7Cb1SWyOMRB2CniKne5KNYdJqtwPHGQcyUa3
	kvIxeARg4ifEy1up4BJ5nM+w55W1q/e1Oy+BNQCKsjuVS49PnGkMtF7BQ9N61H
X-Google-Smtp-Source: AGHT+IHTX+Ow2y8Hi8c0rRLKMQlmI+u7C/NGkFheWrGjKnKPUoBmwC8nhsbP1FbgqylJ1UJ/aCLp7g==
X-Received: by 2002:a17:903:234c:b0:28e:7841:d437 with SMTP id d9443c01a7336-294deea30e2mr37900855ad.38.1761752482989;
        Wed, 29 Oct 2025 08:41:22 -0700 (PDT)
Received: from [192.168.0.3] (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf359asm153773295ad.12.2025.10.29.08.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 08:41:22 -0700 (PDT)
Message-ID: <d2d031ab-6a88-4c7e-bf61-29ad95d8ecaa@gmail.com>
Date: Wed, 29 Oct 2025 23:41:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] arm64: dts: mediatek: mt7981b-openwrt-one: Enable
 Ethernet
To: Sjoerd Simons <sjoerd@collabora.com>, Eric Woudstra
 <ericwouds@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Lee Jones <lee@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, netdev@vger.kernel.org,
 Daniel Golle <daniel@makrotopia.org>, Bryan Hinton <bryan@bryanhinton.com>,
 albert-al.lee@airoha.com
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
 <20251016-openwrt-one-network-v1-12-de259719b6f2@collabora.com>
 <4f82aa17-1bf8-4d72-bc1f-b32f364e1cf6@lunn.ch>
 <8f5335a703905dea9d8d0c1840862a3478da1ca7.camel@collabora.com>
 <05610ae5-4a8a-47e9-808b-7ff98fade78e@gmail.com>
 <408842eda1caa53247ff759cd9ea75dcab624594.camel@collabora.com>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <408842eda1caa53247ff759cd9ea75dcab624594.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi

Sjoerd Simons 於 2025/10/28 下午 09:24 寫道:
> On Tue, 2025-10-28 at 12:14 +0100, Eric Woudstra wrote:
>>
>> On 10/21/25 10:21 PM, Sjoerd Simons wrote:
>>> On Fri, 2025-10-17 at 19:31 +0200, Andrew Lunn wrote:
>>>>> +&mdio_bus {
>>>>> +	phy15: ethernet-phy@f {
>>>>> +		compatible = "ethernet-phy-id03a2.a411";
>>>>> +		reg = <0xf>;
>>>>> +		interrupt-parent = <&pio>;
>>>>> +		interrupts = <38 IRQ_TYPE_EDGE_FALLING>;
>>>> This is probably wrong. PHY interrupts are generally level, not edge.
>>> Sadly i can't find a datasheet for the PHY, so can't really validate that
>>> easily. Maybe Eric can
>>> comment here as the author of the relevant PHY driver.
>>>
>>> I'd note that the mt7986a-bananapi-bpi-r3-mini dts has the same setup for
>>> this PHY, however that's
>>> ofcourse not authoritative.
>>>
>> Lucien would have access to the correct information about the interrupt.
> Thanks! For what it's worth i got around to putting a scope on the line last
> night. It looks like the interrupt line is pulled down until cleared, so it
> appears it's indeed a Level interrupt as Andrew guessed. But would be great to
> have this confirmed based on the documentation :)

The Airoha EN8811H Interrupt behavior is as follows:

When the line side link changes (up→ down or down → up), GPIO 8 will 
output low.

After you clear the interrupt, GPIO 8 will go high. Regarding the 
documentation, let me check where I can put it.

If you have any questions about the EN8811H, please feel free to discuss 
with me.



