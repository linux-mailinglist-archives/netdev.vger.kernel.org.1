Return-Path: <netdev+bounces-233490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DC3C144E4
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 12:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA0F4008B6
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 11:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC29F3043DC;
	Tue, 28 Oct 2025 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0OZqRxO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135072FFDCE
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 11:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761650063; cv=none; b=scHsfVfKqb/xYka5muAYP3xOMga2IPgs7+LpU+3De/s+FJYSctAbHmuTByOoU5Q4Pk5TJbtsJzuoDTJUZRfBFip34dluP8N6w6tPGpZjv8Xea1q+Frszh3EXw9FCqgrcXZj8+Ss+uHuYpStzgXzD5y1OqrbrIa35iQA05WSjF+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761650063; c=relaxed/simple;
	bh=UvfI+0Dexvqi89jOuSdlxco1E27i3zPPumESPPyhntQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3tnh25OXW8lgDNgZIkmhC9dTzFeQHPeRPxuvb/ekfdiY1ZYUqoPYLm1xS+DOxxzJxYVSpPA99GOvHgHfv12cbv/fulOe8f+UKN1PcZ13GxLn4x1r2bW49dHG55X9wcJcoAG9A5WaZEom5zwUGeMS9pPzbuyTH3LPz8yJvTd3nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0OZqRxO; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so913594366b.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 04:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761650060; x=1762254860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YjFpI9BYeJIGawQior8vsJoD7SmwJll5ZNIMlbkQNe0=;
        b=R0OZqRxOtBqxX/rZBL4S2C3y3U3RNMl6iz0/8oIqXKU28NYDvTmLrqGxYShitik6MK
         VAPqJiZFBjuDjj9f9zlX5DkBXo8nscRRtYYNnHTeHO8825Ypcd0Y0W2KvHLiMrNYw+AL
         9kmWhZ9K7qpj/mOCKh/lyDJg1MNNLapfnFeMmNSRFLMK6BYKQV0Hwjocg3p/FV16BNlu
         a+4fz630T6RaGNUF7jLe1QCGdCnsIgurM/D3uU0rtstzJ7tHjcDiUtq9Y79At3lkmaHc
         PzRTa56pXXPgmBSJ65ev5DJwY4cSK+MMLNH8+i3Wmk6122maSf1jnSvPS1tQFpwhCBw6
         za4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761650060; x=1762254860;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YjFpI9BYeJIGawQior8vsJoD7SmwJll5ZNIMlbkQNe0=;
        b=Hdc2ngMCycGfXqJ8EvRMbAen2MPjqI1vcWUQP0n10yZh1kr+Vp3I1cdHBQ8PEtDBdK
         f3Y2/W5wbxC16g2/HrlG80doMY4KaigvQdrZoxLG3xqxYucmxSEOZYIJGBz/m/j0up40
         UQAcud59TtS+5JfvG3Hp6qG5YzlkI1GjV4nKp97nmbql81eH+5s5+M0jKN99QvNkP8bU
         XimbKdIAS/iI3mlMGndDDNLR8rR6StVeiG6E2bEU+YKMNvBQjnQDtPPEHDiuA6yI3r2F
         U8MdfPrUGzJ7d9LyHgHEUCF3KGc5NxfggMgVp+hYJq1mLyaCXVlSXxeIQ+4FF8V0ftQd
         V/SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBX6xpnuWjh9xW77EPCxA9m5KIIHB3/ptuOeULdbx1gKjqEQrCOd6QlLl3JOtmAvZRq1KfEDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjQKD25TQNvmeD6cbLd3vfFHPBPDpN+nJVlajkKtgz9N8yMDsC
	dqoRGgWIpO5LN7YZgM0ZXO8u0hpJ3Lgfoqj81nnWxskniu4uiuRZJME+
X-Gm-Gg: ASbGncsEza5iodzoLYF/e8b4upcUx7CKDAnUfoKi9G2TUbfiNdgradaAWIlr2+otvX2
	j6ymnSlkFGVZ5GGJ/5dExvo/6aIiEitmSCqxPfJpPen/+D0xQX1zZLgZxSLzSra2hCCf+xb0Gfx
	uksQn82/OrnMew9irNywyul6D7N/bJxdjIGlWX6yJmvfH4K3o1OFTEPPq5CLmcSe7Q0bbQSr74A
	0YayC342t6u+U5/PZEr/1iwE1H/WUS1yQBsgec9gLJQ+19eGeKnxgI50DXW/rvOJkXpL1lKM0Kp
	k1Wl+kk2TpJOfn9tcunFBB1MfrHfYYOswRZncNvYaHPHDjxGi9NSpUBUGqo/x1qChJatfTY8Jcj
	pm894W3ifvUBGsYg5TcyEYT0ELVtJvUl7yqJzU4cfyHHWyvCWSYUGntxsW5ylx7VSAkbp2eta3L
	6UzbqmVyHW6ShiqyMNHM+sE1oLM23+t/6Y2D1N0erSzXRU+HVoFInF+C1a4rIiKPbArMg0KM0IF
	5hhbi1QjhyKaQmMV85SNOKerUF65rgzdGOh+i0novUW1MaOx9CltQ==
X-Google-Smtp-Source: AGHT+IGFhB1uFC3jfUFSa2Q1GaChneZzYP9rrCvUKq1g/2kn74sMQ9tiDca6CquKILqpFbpXF/Q/Kg==
X-Received: by 2002:a17:907:7f0a:b0:b4a:ed12:ce51 with SMTP id a640c23a62f3a-b6dba498fe6mr339684266b.23.1761650059938;
        Tue, 28 Oct 2025 04:14:19 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853077ddsm1052436566b.11.2025.10.28.04.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:14:19 -0700 (PDT)
Message-ID: <05610ae5-4a8a-47e9-808b-7ff98fade78e@gmail.com>
Date: Tue, 28 Oct 2025 12:14:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] arm64: dts: mediatek: mt7981b-openwrt-one: Enable
 Ethernet
To: Sjoerd Simons <sjoerd@collabora.com>, Andrew Lunn <andrew@lunn.ch>,
 "Lucien.Jheng" <lucienzx159@gmail.com>
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
 Daniel Golle <daniel@makrotopia.org>, Bryan Hinton <bryan@bryanhinton.com>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
 <20251016-openwrt-one-network-v1-12-de259719b6f2@collabora.com>
 <4f82aa17-1bf8-4d72-bc1f-b32f364e1cf6@lunn.ch>
 <8f5335a703905dea9d8d0c1840862a3478da1ca7.camel@collabora.com>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <8f5335a703905dea9d8d0c1840862a3478da1ca7.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/21/25 10:21 PM, Sjoerd Simons wrote:
> On Fri, 2025-10-17 at 19:31 +0200, Andrew Lunn wrote:
>>> +&mdio_bus {
>>> +	phy15: ethernet-phy@f {
>>> +		compatible = "ethernet-phy-id03a2.a411";
>>> +		reg = <0xf>;
>>> +		interrupt-parent = <&pio>;
>>> +		interrupts = <38 IRQ_TYPE_EDGE_FALLING>;
>>
>> This is probably wrong. PHY interrupts are generally level, not edge.
> 
> Sadly i can't find a datasheet for the PHY, so can't really validate that easily. Maybe Eric can
> comment here as the author of the relevant PHY driver.
> 
> I'd note that the mt7986a-bananapi-bpi-r3-mini dts has the same setup for this PHY, however that's
> ofcourse not authoritative.
> 

Lucien would have access to the correct information about the interrupt.


