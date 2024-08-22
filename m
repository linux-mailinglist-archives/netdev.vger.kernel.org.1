Return-Path: <netdev+bounces-120811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4594E95AD13
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 07:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6999F1C22790
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 05:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010B656B7C;
	Thu, 22 Aug 2024 05:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pR+/chO3"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B13923CB;
	Thu, 22 Aug 2024 05:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724305992; cv=none; b=l/MFb9YMpRAHqY3gzMondAd4DxO/wA5qbetG/nFDpIJysGjrt0Lx/O5uc5ltt20SKqUFr5CnIWj50vOP4+/P+E2xQAam1rVwWAT8V6wt2cMYA8bl7h5SBOlOmC75FcdHFYTV99PHNC/F1K0OI3fPXVcV/j3XyVm7C9a7iI65fMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724305992; c=relaxed/simple;
	bh=z9FV8p4TOVD9tra39TZJf+T6In97vrkN5wwzoLlmmRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tFWlh8fUWAJrOjd9zx/P64AwXjeBSlJyVKDSzC6scsvg4VD/i61hd4UWwvTleCFWscnIgaXqPyiGx/R66k7neqN0hIrg6Mnk5O1buLY6Xhhk2EUEqWaYOSpmHvpozSr93HVChXiheh5Uhj1iVG90AbmBBb0QW+I94ucXfTA+8pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pR+/chO3; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47M5qpa5073319;
	Thu, 22 Aug 2024 00:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724305971;
	bh=30i5OYDTCRCCEhF7zyorf95MkfQz3VtQxsm+cm9IOt8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=pR+/chO3F4yZjYEOMa3eH9uJ3bYd3eEJ5VnAWCmLMWc3L3/noW5d7dGFRgojPEB/z
	 qKkAx4b3TQSqpv+tRxBXjeo410pDmSDCPaAUS5xUHeD3lVVRivoY62o4x+m5+BgJ7v
	 ezsAl/BvKbzVIUrWrHAPSjXCdRJGvw9nmsSms0Rk=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47M5qpAD076041
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Aug 2024 00:52:51 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Aug 2024 00:52:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Aug 2024 00:52:50 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47M5qiRu059176;
	Thu, 22 Aug 2024 00:52:45 -0500
Message-ID: <070a6aea-bebe-42c8-85be-56eb5f2f3ace@ti.com>
Date: Thu, 22 Aug 2024 11:22:44 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/7] net: ti: icssg-prueth: Enable IEP1
To: Roger Quadros <rogerq@kernel.org>, "Anwar, Md Danish" <a0501179@ti.com>,
        Dan Carpenter <dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
        Jan
 Kiszka <jan.kiszka@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Jacob Keller
	<jacob.e.keller@intel.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman
	<horms@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <20240813074233.2473876-2-danishanwar@ti.com>
 <aee5b633-31ce-4db0-9014-90f877a33cf4@kernel.org>
 <9766c4f6-b687-49d6-8476-8414928a3a0e@ti.com>
 <ae36c591-3b26-44a7-98a4-a498ee507e27@kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <ae36c591-3b26-44a7-98a4-a498ee507e27@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 21/08/24 5:23 pm, Roger Quadros wrote:
> 
> 
> On 21/08/2024 14:33, Anwar, Md Danish wrote:
>> Hi Roger,
>>
>> On 8/21/2024 4:57 PM, Roger Quadros wrote:
>>> Hi,
>>>
>>> On 13/08/2024 10:42, MD Danish Anwar wrote:
>>>> IEP1 is needed by firmware to enable FDB learning and FDB ageing.
>>>
>>> Required by which firmware?
>>>
>>
>> IEP1 is needed by all ICSSG firmwares (Dual EMAC / Switch / HSR)
>>
>>> Does dual-emac firmware need this?
>>>
>>
>> Yes, Dual EMAC firmware needs IEP1 to enabled.
> 
> Then this need to be a bug fix?

Correct, this is in fact a bug. But IEP1 is also needed by HSR firmware
so I thought of keeping this patch with HSR series. As HSR will be
completely broken if IEP1 is not enabled.

I didn't want to post two patches one as bug fix to net and one part of
HSR to net-next thus I thought of keeping this patch in this series only.

> What is the impact if IEP1 is not enabled for dual emac.
> 

Without IEP1 enabled, Crash is seen on AM64x 10M link when connecting /
disconnecting multiple times. On AM65x IEP1 was always enabled because
`prueth->pdata.quirk_10m_link_issue` was true. FDB learning and FDB
ageing will also get impacted if IEP1 is not enabled.

>>
>>>> Always enable IEP1
>>>>
>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>> ---
> 

-- 
Thanks and Regards,
Danish

