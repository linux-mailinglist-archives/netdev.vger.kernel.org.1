Return-Path: <netdev+bounces-155978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5C4A047BB
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 18:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37723A1393
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065911F63D3;
	Tue,  7 Jan 2025 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="vsq4rlK4"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945FA1F428B
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269860; cv=none; b=QWh5HIz/AZDj0YAZ84OaDEy+Ycb8Bda2sD5EyUaWSnadGLtWOrTBW8ceIGSNnJCAsSs07KC6p7HhtLOxUgkD+CB2WN71+gvUXQTQ4V7DwdNX5V2yp+Lz6wzz7AKdHl5A96nfYugFg2uRBhM7SUsQrCWgUMem8mVs3DVHdgmUdmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269860; c=relaxed/simple;
	bh=q3UANQ8A4Yeqhon6yjz6ypm3i/1amOShP0IMQJfnLLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E7MkVhJz1mR4joNLIWQJckjlrHtZrHAVFAW78IqFI3kld84/peOJQlk8FBHkjHu15ls9eTqWd+y37dSuCG1i9tXaXc0oCiYPjO0meYdBy+imb7YjbfFn+L67YWIvx9Us1HzmzvKJfYo8ZRw8TEH9kN5ijmEloTfyIeI9kPjK+CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=vsq4rlK4; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507EhhGB006755;
	Tue, 7 Jan 2025 18:10:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	9RK7Q3k8KADciZn8KOeU02DDuhao8EJG7oeAMoPMBlY=; b=vsq4rlK4xBKE7+nM
	ABGsHC9OEMO8kj1ZfZRKD6w5J+adajNygBw/Ke060LpD6Yjz7JTOWDyRoST9rqk8
	ePAEHns7SFY96lJDGDtCQjOGBV525mMKROFg0P+nRuGqAhdck25eCZ24p6DZ4f4H
	UEZuS2iqf5/6zCGonoRUbuWJPhKWhJVUvj/QcgH/xthpWWKvBhF94YvAX0AA413j
	6Xi/NY75gPQuD3e8OOPBIT/9R2CD7K0NK47kCbpIRAsI24HqCTzLfreHZxTd6oIc
	buXFuQBa7l3IGlBtw72Bo+Uqrw6AONtJWyz0qpS/O2Nza3dalAsJEs50SOJTbZmL
	m0IxFQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4411xu9xwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 18:10:27 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 56D054006D;
	Tue,  7 Jan 2025 18:09:14 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 03FF228C435;
	Tue,  7 Jan 2025 18:06:47 +0100 (CET)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 7 Jan
 2025 18:06:46 +0100
Message-ID: <f7512560-69d6-41b6-a85e-70e25b17153c@foss.st.com>
Date: Tue, 7 Jan 2025 18:06:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/8] MAINTAINERS: mark stmmac ethernet as an Orphan
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <joabreu@synopsys.com>
References: <20250106165404.1832481-1-kuba@kernel.org>
 <20250106165404.1832481-5-kuba@kernel.org>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20250106165404.1832481-5-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi Jakub

On 1/6/25 17:54, Jakub Kicinski wrote:
> I tried a couple of things to reinvigorate the stmmac maintainers
> over the last few years but with little effect. The maintainers
> are not active, let the MAINTAINERS file reflect reality.
> The Synopsys IP this driver supports is very popular we need
> a solid maintainer to deal with the complexity of the driver.
> 
> gitdm missingmaints says:
> 
> Subsystem STMMAC ETHERNET DRIVER
>    Changes 344 / 978 (35%)
>    Last activity: 2020-05-01
>    Alexandre Torgue <alexandre.torgue@foss.st.com>:
>      Tags 1bb694e20839 2020-05-01 00:00:00 1
>    Jose Abreu <joabreu@synopsys.com>:
>    Top reviewers:
>      [75]: horms@kernel.org
>      [49]: andrew@lunn.ch
>      [46]: fancer.lancer@gmail.com
>    INACTIVE MAINTAINER Jose Abreu <joabreu@synopsys.com>
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> --

Unfortunately no time to ramp up on it and driver has changed 
significantly since I worked on it. Hoping someone will raise their hand
to take this activity.

Acked-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

> We could add an entry to AUTHORS, but a quick git log doesn't show
> huge number of patches or LoC. I could be looking wrong..
> 
> CC: joabreu@synopsys.com
> CC: alexandre.torgue@foss.st.com
> ---
>   MAINTAINERS | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7f22da12284c..613f15747b6b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22509,11 +22509,8 @@ F:	Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml
>   F:	drivers/phy/st/phy-stm32-combophy.c
>   
>   STMMAC ETHERNET DRIVER
> -M:	Alexandre Torgue <alexandre.torgue@foss.st.com>
> -M:	Jose Abreu <joabreu@synopsys.com>
>   L:	netdev@vger.kernel.org
> -S:	Supported
> -W:	http://www.stlinux.com
> +S:	Orphan
>   F:	Documentation/networking/device_drivers/ethernet/stmicro/
>   F:	drivers/net/ethernet/stmicro/stmmac/
>   

