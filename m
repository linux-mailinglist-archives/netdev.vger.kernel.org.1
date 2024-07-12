Return-Path: <netdev+bounces-111057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE5B92F9A3
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 13:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B87A1C219FD
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 11:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0F215EFB6;
	Fri, 12 Jul 2024 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R663tXBD"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D926C4A3D;
	Fri, 12 Jul 2024 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720784477; cv=none; b=J80c+17i8pC2wwQmpVsAIpCIgCDgpsYo+22lk561IW67SLxm5gZ2ZVs/BX7wM8Sbo4FIrmwcqNDhpFhAoosbl6o+i99amwZRO7wTNHucCRNhkvFBNtLX6TbSAGVXi/0Pxd6HKuQnspO+PROJMd9U70jdEpZbQ4efZQBaEPpoBEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720784477; c=relaxed/simple;
	bh=/9KhqEJTypNqnFHIEeuXNVKbUv/lh5PoQ/8pTaDM/ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fOo0RUndmOdb6NfcJwKl8M79YNzbEcXvgnX7SuR1CAlmZrIjShdZ5N31gvxbin1fPY5IcmMtcWEZRikorxLP87ppWIqNqIAM9LLTppXJ24Z8bC9/KQqVG5rqMQQIhAx10tlfJQOuq9E+VnoS+j/DBFxLBJiYHY8lZqtl8bG9nFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R663tXBD; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46CBedxp062112;
	Fri, 12 Jul 2024 06:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720784439;
	bh=xx+IPyfid+GvirErrxib8ttv/veQTjav2d5pwS73HpI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=R663tXBD976lrswtz22sFImLlbecjARt5vZrIPiZGxV0xsKqjfN+F3jeajcFAbfgi
	 MCXb30BAUJrscR1is50rR0OxKn2wUIe7UCaOF/px8AboaH3+58ibOFZHQLyRRNDTGq
	 H6hRZHZeaddBXK2BESBzGhjr/uhTr9ywev4Xu9c8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46CBednV069325
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Jul 2024 06:40:39 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jul 2024 06:40:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jul 2024 06:40:38 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46CBeVwe046608;
	Fri, 12 Jul 2024 06:40:32 -0500
Message-ID: <4cdcf7af-fb0e-47a4-b38a-b8ad98c90188@ti.com>
Date: Fri, 12 Jul 2024 17:10:30 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: ti: icssg-prueth: Split out common
 object into module
To: Thorsten Leemhuis <linux@leemhuis.info>, Andrew Lunn <andrew@lunn.ch>
CC: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Diogo Ivo
	<diogo.ivo@siemens.com>, Roger Quadros <rogerq@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        kernel test robot <lkp@intel.com>
References: <20240606073639.3299252-1-danishanwar@ti.com>
 <66b917d6-3b72-41c5-9e30-e87cf5505729@lunn.ch>
 <c720c13d-de0e-440d-a10b-717f6012bf56@leemhuis.info>
 <ca53f2e2-6cc5-42ea-8faf-7d9b7d14421d@leemhuis.info>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <ca53f2e2-6cc5-42ea-8faf-7d9b7d14421d@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 12/07/24 4:42 pm, Thorsten Leemhuis wrote:
> On 26.06.24 09:19, Thorsten Leemhuis wrote:
>> On 06.06.24 17:54, Andrew Lunn wrote:
>>>> +EXPORT_SYMBOL_GPL(icssg_class_set_mac_addr);
>>>> +EXPORT_SYMBOL_GPL(icssg_class_disable);
>>>> +EXPORT_SYMBOL_GPL(icssg_class_default);
>>>> +EXPORT_SYMBOL_GPL(icssg_class_promiscuous_sr1);
>>> [...]
>>> Please could you clean up the namespace a little. icssg_ and prueth_
>>> are O.K, but we also have arc/emac_rockchip.c, allwinner/sun4i-emac.c,
>>> ibm/emac/, and qualcomm/emac/ using the emac_ prefix.
>>
>> Just wondering (not as a regression tracker, just as someone that ran
>> into this and carries the patch in his tree to avoid a build error for
>> next):
>>
>> What happened to this fix? After above feedback nearly 20 days ago
>> nothing happened afaics. Did this fall through the cracks? Or was some
>> other solution found and I just missed this (and thus can drop the fix
>> from my tree)?
> 
> That inquiry lead to a review from Roger (thx!) more than two weeks ago,
> but that was all afaics. Makes me wonder if this regression will hit
> mainline soon, as the merge window might open on Monday already.
> 
> Ciao, Thorsten


Andrew L has given comment to clean up the API names. I will rename the
APIs being exported from emac_ prefix to icssg_ prefix and re-spin this.

-- 
Thanks and Regards,
Danish

