Return-Path: <netdev+bounces-107128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4604F919F87
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 08:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2B22855D3
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 06:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3148538DE8;
	Thu, 27 Jun 2024 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="LiVHopGC"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3171720323;
	Thu, 27 Jun 2024 06:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719470860; cv=none; b=fba043KbeuFgeash/ZiacY7j5RqvoyIyjwEQgMWku52ePmePDNdVTbVFvnYO668XadOfbfuJS1IKsfMbq3H1LezksDt2pF9YIWBV0x4TuBMX/Hwm4UD5ahIkHF6NEhRwThM/hgtNjeBhK0pwDoNA0RBCgJlbPBy/SalDWwrbSrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719470860; c=relaxed/simple;
	bh=B9O9jGT1Ussfkps7YXut5xQ+RhX3knK+hzENBGYoF18=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OTxg6MdaVWyuTmF9up7V6cS3MvqEpsgf4aZ/oUM+5hf473hh3QnfRD9ah9kNl4qbQpKhy8dL2OW+OjWAj+/FQesvZSFRes7Ifysg4ptoKZ3q1j71XmuxkB2e9cqMcPr7Bg9ueGIQMJEWWYzxcCpFmKKlkFcrtmXszXpLhnqqawY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=LiVHopGC; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R0Wjnm010481;
	Thu, 27 Jun 2024 08:47:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	MlmSx7OBvuKIe5Rtv99hWsLybZ5aGRu/rNbbqX9lBlQ=; b=LiVHopGCnWujb4kT
	BXQclmlyCdbqzsUnR3LhPCkGE671CPgTqMAlKBA2vnm5IjytlPoVp35rxYz1Z43y
	vp2YzNwkJsWybg1cOZIj7G6YMm6j/UwsxHpqbRwKA9vxLNKCPq8ZdoOTSTxEiHBS
	yOSsizfYvZ9W9FIBTHS1c2Y8zMW/a9jDToLMVJ3dxAOiCqShQEjjH7zd2cYZdvAX
	RauMI6xfLEBwYfWAvDuKzJcsvULumE5Acm7cqDfx9oIaXnaKBCumufx51cI9j902
	SBRbGLlhoCrgabSHMCaTR4HTKCwNCPEJA9Dw7Hh181Hyb5Mx+taxGsPijRwOLX56
	gedjuw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yx9jjgsgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 08:47:00 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8FF8C40045;
	Thu, 27 Jun 2024 08:46:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D0E10210F85;
	Thu, 27 Jun 2024 08:45:40 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 27 Jun
 2024 08:45:39 +0200
Message-ID: <4d5cfb6b-0cf5-46f1-b725-acfe995d4482@foss.st.com>
Date: Thu, 27 Jun 2024 08:45:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v7 2/8] net: stmmac: dwmac-stm32: Separate out
 external clock rate validation
To: Mark Brown <broonie@kernel.org>
CC: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Marek
 Vasut <marex@denx.de>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240611083606.733453-1-christophe.roullier@foss.st.com>
 <20240611083606.733453-3-christophe.roullier@foss.st.com>
 <755275e3-b95a-44c0-941e-beb5dde65982@sirena.org.uk>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <755275e3-b95a-44c0-941e-beb5dde65982@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_03,2024-06-25_01,2024-05-17_01

Hi Mark,

Sorry, issue found, I will push fix this morning.

Regards.

Christophe.

On 6/26/24 12:38, Mark Brown wrote:
> On Tue, Jun 11, 2024 at 10:36:00AM +0200, Christophe Roullier wrote:
>> From: Marek Vasut <marex@denx.de>
>>
>> Pull the external clock frequency validation into a separate function,
>> to avoid conflating it with external clock DT property decoding and
>> clock mux register configuration. This should make the code easier to
>> read and understand.
> For the past few days networking has been broken on the Avenger 96, a
> stm32mp157a based platform.  The stm32-dwmac driver fails to probe:
>
> <6>[    1.894271] stm32-dwmac 5800a000.ethernet: IRQ eth_wake_irq not found
> <6>[    1.899694] stm32-dwmac 5800a000.ethernet: IRQ eth_lpi not found
> <6>[    1.905849] stm32-dwmac 5800a000.ethernet: IRQ sfty not found
> <3>[    1.912304] stm32-dwmac 5800a000.ethernet: Unable to parse OF data
> <3>[    1.918393] stm32-dwmac 5800a000.ethernet: probe with driver stm32-dwmac failed with error -75
>
> which looks a bit odd given the commit contents but I didn't look at the
> driver code at all.
>
> Full boot log here:
>
>     https://lava.sirena.org.uk/scheduler/job/467150
>
> A working equivalent is here:
>
>     https://lava.sirena.org.uk/scheduler/job/466518
>
> A bisection identified this commit as being responsible, log below:
>
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [0fc4bfab2cd45f9acb86c4f04b5191e114e901ed] Add linux-next specific files for 20240625
> git bisect bad 0fc4bfab2cd45f9acb86c4f04b5191e114e901ed
> # status: waiting for good commit(s), bad commit known
> # good: [3d9217c41c07b72af3a5c147cb82c75f757f4200] Merge branch 'for-linux-next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
> git bisect good 3d9217c41c07b72af3a5c147cb82c75f757f4200
> # bad: [5699faecf4e2347f81eea62db0455feb4d794537] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> git bisect bad 5699faecf4e2347f81eea62db0455feb4d794537
> # good: [ba73da675606373565868962ad8c615f175662ed] Merge branch 'fs-next' of linux-next
> git bisect good ba73da675606373565868962ad8c615f175662ed
> # bad: [7e7c714a36a5b10e391168e7e8145060e041ea12] Merge branch 'af_unix-remove-spin_lock_nested-and-convert-to-lock_cmp_fn'
> git bisect bad 7e7c714a36a5b10e391168e7e8145060e041ea12
> # good: [93d4e8bb3f137e8037a65ea96f175f81c25c50e5] Merge tag 'wireless-next-2024-06-07' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
> git bisect good 93d4e8bb3f137e8037a65ea96f175f81c25c50e5
> # bad: [4314175af49668ab20c0d60d7d7657986e1d0c7c] Merge branch 'net-smc-IPPROTO_SMC'
> git bisect bad 4314175af49668ab20c0d60d7d7657986e1d0c7c
> # good: [811efc06e5f30a57030451b2d1998aa81273baf8] net/tcp: Move tcp_inbound_hash() from headers
> git bisect good 811efc06e5f30a57030451b2d1998aa81273baf8
> # good: [5f703ce5c981ee02c00e210d5b155bbbfbf11263] net: hsr: Send supervisory frames to HSR network with ProxyNodeTable data
> git bisect good 5f703ce5c981ee02c00e210d5b155bbbfbf11263
> # bad: [6c3282a6b296385bee2c383442c39f507b0d51dd] net: stmmac: add select_pcs() platform method
> git bisect bad 6c3282a6b296385bee2c383442c39f507b0d51dd
> # bad: [404dbd26322f50c8123bf5bff9a409356889035f] net: qrtr: ns: Ignore ENODEV failures in ns
> git bisect bad 404dbd26322f50c8123bf5bff9a409356889035f
> # bad: [c60a54b52026bd2c9a88ae00f2aac7a67fed8e38] net: stmmac: dwmac-stm32: Clean up the debug prints
> git bisect bad c60a54b52026bd2c9a88ae00f2aac7a67fed8e38
> # bad: [582ac134963e2d5cf6c45db027e156fcfb7f7678] net: stmmac: dwmac-stm32: Separate out external clock rate validation
> git bisect bad 582ac134963e2d5cf6c45db027e156fcfb7f7678
> # good: [8a9044e5169bab7a8edadb4ceb748391657f0d7f] dt-bindings: net: add STM32MP13 compatible in documentation for stm32
> git bisect good 8a9044e5169bab7a8edadb4ceb748391657f0d7f
> # first bad commit: [582ac134963e2d5cf6c45db027e156fcfb7f7678] net: stmmac: dwmac-stm32: Separate out external clock rate validation

