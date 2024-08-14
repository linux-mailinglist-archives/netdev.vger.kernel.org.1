Return-Path: <netdev+bounces-118343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901709514EE
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E97B3286F18
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 07:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0170113A40F;
	Wed, 14 Aug 2024 07:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JI0IQoGB"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BBE4430;
	Wed, 14 Aug 2024 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618824; cv=none; b=gEtSVB1e+azNNymCI+UMWRQtEO8lm1x4+xnrZWx6E3Zoq52HMJKoFIoermZEZhnzdXZ1ZicFBWte/cjlyALnY2S5u7rJXb8e7mRouP8+4+Olg6rlCvAwObxIu/cyXxfmMKcu4v1wuTXOB/JcTPnWvoRVkpX5K4LvHzEUhKRCMKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618824; c=relaxed/simple;
	bh=agXKvTGqcbVl0AO82nYajf2iv0a+bZqfuBZ7G8muERM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j4ELYfDp6PFAfQoK5K2IUJNIyY9V4aGINL6bLbDE3SN+wd732JWXogNfB4+hxjZV8Z2r6Rp4xPTLJq2GEO92MwwbW5seGcyqVJAHlkU5NdLb1h8wHoLMnMt3eYtO+ZDGkYf2Gh5NYtIvAfc0mZbO+5UF81Il7lxFdAqZ/ZceqT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JI0IQoGB; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47E7049u077100;
	Wed, 14 Aug 2024 02:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723618804;
	bh=CxcVLR4ikaetQ3RvBYVPolo87g/ZqHTQeL/mdneoG78=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=JI0IQoGBObL7j0Br5F+M13PnTwXtHXPKKSlly2gIJX8b7p7xpi99WXrP6/sbEQVL+
	 1MAFD5JfrB/oqPvQDRnGlyu5lxPniWVGd6aaHKczCiqZAU41DFBIvCQ2R4fr5f64wf
	 bKNeoyZGphM+P49UxpdKl7GJtZfpVXMWFuZR/HUc=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47E703g4087963
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 02:00:03 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 02:00:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 02:00:03 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47E6xvsr120228;
	Wed, 14 Aug 2024 01:59:58 -0500
Message-ID: <6a7ac999-2b77-4d7e-8a34-ca101ddc2a58@ti.com>
Date: Wed, 14 Aug 2024 12:29:57 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/7] net: ti: icssg-prueth: Enable HSR Tx
 Packet duplication offload
To: Andrew Lunn <andrew@lunn.ch>
CC: Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka
	<jan.kiszka@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Javier
 Carrasco <javier.carrasco.cruz@gmail.com>,
        Jacob Keller
	<jacob.e.keller@intel.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman
	<horms@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <20240813074233.2473876-6-danishanwar@ti.com>
 <985e10e4-49df-46d8-b9c2-d385dab569a9@lunn.ch>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <985e10e4-49df-46d8-b9c2-d385dab569a9@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 13/08/24 8:53 pm, Andrew Lunn wrote:
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> @@ -41,7 +41,8 @@
>>  #define DEFAULT_PORT_MASK	1
>>  #define DEFAULT_UNTAG_MASK	1
>>  
>> -#define NETIF_PRUETH_HSR_OFFLOAD	NETIF_F_HW_HSR_FWD
>> +#define NETIF_PRUETH_HSR_OFFLOAD	(NETIF_F_HW_HSR_FWD | \
>> +					 NETIF_F_HW_HSR_DUP)
> 
> Ah! Now i see why you added the alias. This is O.K. then.
> 
> Maybe NETIF_PRUETH_HSR_OFFLOAD_FEATURES, although that is a bit long,
> but it makes it clear it is a collection of features, not an alias for
> one feature.
> 

Sure. I will change this. Thanks for reviewing this series.

> 
> 	Andrew

-- 
Thanks and Regards,
Danish

