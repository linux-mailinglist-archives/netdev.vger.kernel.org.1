Return-Path: <netdev+bounces-173782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC8CA5BAB9
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 09:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AAFB3AFE92
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 08:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3C92248BD;
	Tue, 11 Mar 2025 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="0Fjsb0yB"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ADD22423D;
	Tue, 11 Mar 2025 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741681259; cv=none; b=max9Fjv8Ai54P2iTCzQEteXeJ2ZiJWAKZRMPSYzApymEb60n9ea0t76Iw6oBE1kyjeOo2ylk2RdBRwE9VXI8xQRycQwmIDIgtP3ETJAEd+0zoKRmkILAXexPqzEKxfJoorpckzL4a27BmOav4F55brbMrChNBVzMG1ptE22hPXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741681259; c=relaxed/simple;
	bh=/krpf4mC7s6O3K1gfP6n3jIaWEpoHX0fgaocmRijhkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DeIv5+CXdUDPT2pKq7poKWxhPOj37KEqOKJU9glc93FjOUX0+AH6JHsKpJGclKoiGu8J0XLaxkmDJkch9C667KjaF0BVqOnnkekULTAM6CsELpJm3csalLKxVjzWe7UUBilkMlaLWCyQisShdtlrm3X314v+dY1Z2thV1+VplQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=0Fjsb0yB; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B81kWr016929;
	Tue, 11 Mar 2025 09:20:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	mgvPHrj9w39QFxaBaXFSsD+ID+KMNA0Jvstg1hsdw/Y=; b=0Fjsb0yBbTOx9kv7
	0vWPYYqspDp8ROlPr288Q5Gqu0hCBFOW+w90Q/aT2JRbvXBMEz6ieEzQTaDnciFP
	pwWSQiqbdeJVgXIbaU5xl6cew2PqduOVCnLlNoboEHdwpOcq6bMsoZ0iaGB+iP9t
	VBN+pm9N9ULZLU42297zPLfCLHrjStHtCjfbXBLX/IFXZu+WXUNtkSLtoXT8xwLj
	n/k/cT4y4OBH/zs7KeP1YuCSwulJfRgjdbzJmjFTYYUEMqRkVOTVRn89COBdLFhI
	B396eO+w0acQ7V08h3rewGqZSPYnYUcPqUutv15sMi2k/jjmyX/zRbUwITDFLYej
	D5Bgnw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4590b95gfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 09:20:36 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 37DF040063;
	Tue, 11 Mar 2025 09:18:42 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 08650544BDE;
	Tue, 11 Mar 2025 09:16:33 +0100 (CET)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 09:16:32 +0100
Message-ID: <face80e3-36be-42a0-8d31-bb74e413e397@foss.st.com>
Date: Tue, 11 Mar 2025 09:16:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] Add support for Plymovent AQM board
To: Oleksij Rempel <o.rempel@pengutronix.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh
	<woojung.huh@microchip.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20250305131425.1491769-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20250305131425.1491769-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-11_01,2024-11-22_01

Hi Oleksij

On 3/5/25 14:14, Oleksij Rempel wrote:
> This patch series adds support for the Plymovent AQM board based on the
> STM32MP151C SoC. Additionally, the ICS-43432 device tree binding is
> converted to YAML to address a validation warning.
> 
> The ICS-43432 patch resolves one of the devicetree validation warnings.
> However, the false-positive warning:
> 
>    "audio-controller@44004000: port:endpoint: Unevaluated properties are
>     not allowed ('format' was unexpected)"
> 
> remains unresolved. The "format" property is required for proper
> functionality of this device.
> 
> Best regards,
> 
> Oleksij Rempel (4):
>    dt-bindings: sound: convert ICS-43432 binding to YAML
>    dt-bindings: arm: stm32: Add Plymovent AQM board
>    ARM: dts: stm32: Add pinmux groups for Plymovent AQM board
>    arm: dts: stm32: Add Plymovent AQM devicetree
> 
>   .../devicetree/bindings/arm/stm32/stm32.yaml  |   1 +
>   .../devicetree/bindings/sound/ics43432.txt    |  19 -
>   .../bindings/sound/invensense,ics43432.yaml   |  51 +++
>   arch/arm/boot/dts/st/Makefile                 |   1 +
>   arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi   | 292 ++++++++++++++
>   arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts   | 376 ++++++++++++++++++
>   6 files changed, 721 insertions(+), 19 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/sound/ics43432.txt
>   create mode 100644 Documentation/devicetree/bindings/sound/invensense,ics43432.yaml
>   create mode 100644 arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts
> 
> --
> 2.39.5
> 

Series applied on stm32-next.

Thanks
Alex

