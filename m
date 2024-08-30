Return-Path: <netdev+bounces-123747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A124F966671
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 18:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8FF2817EC
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F6C1B5833;
	Fri, 30 Aug 2024 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Ceyzy7XX"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BED1192D94;
	Fri, 30 Aug 2024 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033892; cv=none; b=czPo0TIPXCzoB8WqDd8Dhm4rVutaXS4UTKSVm0Wfn4oTPOcMiBtnKWpnBFXnekBhHuJmVwPil71wVykbDhsrIxcMogMtZ7m7wUJWbOhvmlaEG2UheoDM6XLuIl+pKR0u9REhCQa6es/J5gnW72M3GmvZkw4JCgurpOXXHJJj72k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033892; c=relaxed/simple;
	bh=tZPGX375hrHPLr/sCSsEXe8qXLuw2fMVtSvmTjhg2+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PSal8O05ubzcOAS+nlYaxnGF8KnFr+VdSOjpP8ZeIrp+9gHO0weZa64v0JoiObUrs0k/d8nSKP6WAEbRC6pblQIssIX+C+p2GQDyptgxlF4v2zIkNEzPkSoFWXxuxES7venzRXbcDg7RbNiPo8PCDr6GFX62kq2fiU5OYv74xj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Ceyzy7XX; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UC9P4e003064;
	Fri, 30 Aug 2024 18:04:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	XdUP22qiupn7VHmQeEXg1uHZc5JhTQw6VLVbjHWHSAA=; b=Ceyzy7XXvW2Y5JKO
	0Zw3oPGw9VBzZNNikFHAodvW7B3UyEbcrVIzE0IsECIJiXGVLkkhAk8TfkIjjdDk
	AiLPLZSeAly39Mbr4Jw+BsQGvy45mb3iWSIsZqiPxPPvGKJn4VvPM10Hvjd4+qX1
	/H8OncgKoBC4zZUQrNa5W7DDL6/H/T7TJUIE/jVBYYEc26C01NkDy4bV5R3zVvkv
	HiJ8JB+gK0cXi5aklnHlFnkKJJ/Kf0B8/kiMypMYZndLOTCnmsDxEFbDexgGxaqG
	Nr+8FOx/8Lyy9TgtBgSMvm9Q46O9CUEzVRWm6kdE7oOQvq8V6bvNaXCFD85qY1Hc
	V7SSzA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41b14uknss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 18:04:27 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 20CEE4002D;
	Fri, 30 Aug 2024 18:04:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5553D27C231;
	Fri, 30 Aug 2024 18:03:32 +0200 (CEST)
Received: from [10.252.12.18] (10.252.12.18) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 30 Aug
 2024 18:03:31 +0200
Message-ID: <60f38cec-1942-41a1-9d5e-0eeaaeed0667@foss.st.com>
Date: Fri, 30 Aug 2024 18:03:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm: dts: st: stm32mp151a-prtt1l: Fix QSPI
 configuration
To: Oleksij Rempel <o.rempel@pengutronix.de>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Ahmad Fatoum <a.fatoum@pengutronix.de>, <kernel@pengutronix.de>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>
References: <20240812104142.2123970-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240812104142.2123970-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01

Hi Oleksij,

On 8/12/24 12:41, Oleksij Rempel wrote:
> Rename 'pins1' to 'pins' in the qspi_bk1_pins_a node to correct the
> subnode name. The incorrect name caused the configuration to be
> applied to the wrong subnode, resulting in QSPI not working properly.
> 
> Some additional changes was made:
> - To avoid this kind of regression, all references to pin configuration
>    nodes are now referenced directly using the format &{label/subnode}.
> - /delete-property/ bias-disable; was added everywhere where bias-pull-up
>    is used
> - redundant properties like driver-push-pull are removed
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> changes v3:
> - extend comment message
> ---
>   arch/arm/boot/dts/st/stm32mp151a-prtt1a.dts  |  12 +-
>   arch/arm/boot/dts/st/stm32mp151a-prtt1c.dts  | 108 +++++++---------
>   arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi | 126 +++++++++----------
>   arch/arm/boot/dts/st/stm32mp151a-prtt1s.dts  |  16 +--
>   4 files changed, 116 insertions(+), 146 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp151a-prtt1a.dts b/arch/arm/boot/dts/st/stm32mp151a-prtt1a.dts
> index 75874eafde11e..8e1dd84e0c0a4 100644
> --- a/arch/arm/boot/dts/st/stm32mp151a-prtt1a.dts
> +++ b/arch/arm/boot/dts/st/stm32mp151a-prtt1a.dts
> @@ -28,16 +28,12 @@ phy0: ethernet-phy@0 {
>   	};
>   };
>
...

Applied on stm32-next.

Thanks
Alex

