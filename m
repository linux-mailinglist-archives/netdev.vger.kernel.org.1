Return-Path: <netdev+bounces-96018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81868C4013
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 13:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A881C22BA2
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920B314D2A2;
	Mon, 13 May 2024 11:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="6BayJbT6"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BD643AAB;
	Mon, 13 May 2024 11:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715600823; cv=none; b=irQ/MGRUrAVZNIXPMOzbYxNNflfK0QIhcvlmDQTGc63Ss5mGF4MCBXp1jhHISHmkYZtbeCZ0BKgbvIcb5WusHydD/Mw20x/xpzfiRbwdJLA8D7cti3OT/uhscCru220YZNkYs8Csjf0b8RnNKBGnZkcsF/KY29lAJorMYltlxyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715600823; c=relaxed/simple;
	bh=bkl5mIpaXX5R+0JYXYWav244dyOdyvV/LK6ynmQSRXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ca1Gl33QOYwDrCTOBF7HkYATzUhkYAEOlH9gty1HoAYNXTMRAS7FSYwTaZDunY+Fwf4NzHs2ZHWpZpSOxO9+ZpspqNdw8OKc+hH7AKBtuN/ohyd6TfHgkCo99c/YdcVDykB5lgXwzBvbZub69nII+XZv2yEGQtCSyBcCceWHmzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=6BayJbT6; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44D8Jhwq004753;
	Mon, 13 May 2024 13:46:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=+Ud1oJct5YusRDi0DBo0DqaYGoRY5+vpKVG6u0z0jyM=; b=6B
	ayJbT6RGR5CsoE/qdXQJIeTFJXL2WOSwoC7ERbRYG1NszkOkgLMeZHDAqrA1lHqi
	JTrKRQeXbQBdfxnrcfrfAnvw6LME4ex7/x1jiXRXsTM4kjXH8lT9jp89TgEczHOp
	fpmh9++24iKg0yt0fwe4fot+uRkgmZqz70d87x8nu3z/J+St3LgNgFOHqnhfbp1g
	Cea/ZC0oGPS7jBq3QLh1je8D49/zGVvJMGtjjraC1M4lBSfeM9l0uSINqN2HcBLz
	q08k+PflE3/HAhWgLxNOjzzQZ6bnGRD4mCGGQ0jVcpcPpLrZmtxnMTSohnu0J4qp
	e9V/APaAKpF+Kus9QkQA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y2kmhm4k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 13:46:27 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 89A9940044;
	Mon, 13 May 2024 13:46:21 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CFB90217B95;
	Mon, 13 May 2024 13:45:06 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 13:45:05 +0200
Message-ID: <0ef43ed5-24f5-4889-abb2-d01ee445a02d@foss.st.com>
Date: Mon, 13 May 2024 13:45:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] dt-bindings: net: add phy-supply property for
 stm32
To: Marek Vasut <marex@denx.de>, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
 <20240426125707.585269-3-christophe.roullier@foss.st.com>
 <4e03e7a4-c52b-4c68-b7e5-a03721401cdf@denx.de>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <4e03e7a4-c52b-4c68-b7e5-a03721401cdf@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_08,2024-05-10_02,2023-05-22_02

Hi,

On 4/26/24 16:47, Marek Vasut wrote:
> On 4/26/24 2:56 PM, Christophe Roullier wrote:
>> Phandle to a regulator that provides power to the PHY. This
>> regulator will be managed during the PHY power on/off sequence.
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
>
> Maybe this entire regulator business should be separate series from 
> the MP13 DWMAC ethernet series ?
I prefer push it with MP13 Ethernet series if possible.

