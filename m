Return-Path: <netdev+bounces-118334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC4C95147D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3B92862E1
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 06:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A129D7345B;
	Wed, 14 Aug 2024 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="USszB5Ee"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB811F94D;
	Wed, 14 Aug 2024 06:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723616795; cv=none; b=Z4et+mwe/ZeJen3LUQHrrDfkEnDLPEoviIO2J9IMDOebXt+bJLA9plC4j/JcnoWNpNJrK68p7MG32yANs2euQJ19UeQPtG6m0EpepQeJoND8UCjdSjDNoeEup453uDi4z4/mYWiOO2ym4mYE53AVaPK+1a2+rF/Y0+LiOy/Rrxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723616795; c=relaxed/simple;
	bh=c/B3zpodqQDg3Gm46P+OGE0a77kg/8gf/IGqyQqdCbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KsycB8MX6uzqfNrhY1rQlB3uOv5sIdDEx5IGNcJeqJYJ7/OJvlQ7SNvDj66iVKOi1+tumH92ouFtZKFYoB0+NTNLgeQmNbC0pbWLlwN5ioUHlKzxUqtohyTH7m2TEBrjQsG9HmL252izOIvOBtX+4OiPStoiCubq23PlvBIYChU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=USszB5Ee; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47E6Q55e083647;
	Wed, 14 Aug 2024 01:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723616765;
	bh=TV4YYPMGzdKwvmV4+H2ipDGrWg6oUeN1Y/HB2RJrHLU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=USszB5EerDqLAd8bKn+vrAU0auLqrZ2UsqL9IeLDcOvb+IrSUwxizd3ZRYj5eQL8M
	 CQCfCL52dd/tvD21aOBk/5ODt6eNpawGgTTeQVwgxV03L5Bkj3NnCIKCgVHYH1eNkD
	 yi+A8We0wmZUSceS4UVOh7HHscEQrBkp5RDeK52A=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47E6Q5wk003091
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 01:26:05 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 01:26:05 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 01:26:05 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47E6PvMF073293;
	Wed, 14 Aug 2024 01:25:58 -0500
Message-ID: <69043091-dd59-4b7a-aae0-34f9695b378d@ti.com>
Date: Wed, 14 Aug 2024 11:55:57 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/7] Introduce HSR offload support for ICSSG
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
 <d061bfb6-0ccc-4a41-adad-68a90a340475@lunn.ch>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <d061bfb6-0ccc-4a41-adad-68a90a340475@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

On 13/08/24 8:19 pm, Andrew Lunn wrote:
> On Tue, Aug 13, 2024 at 01:12:26PM +0530, MD Danish Anwar wrote:
>> Hi All,
>> This series introduces HSR offload support for ICSSG driver. To support HSR
>> offload to hardware, ICSSG HSR firmware is used.
> 
> Oh, no, not another firmware. How does this interact with using the
> switch firmware and switchdev? I see in your examples you talk about
> HSR to Dual EMAC, but what about HSR and Switchdev?
> 

HSR to Switch mode or switch mode to HSR is not supported by the firmware.

Only dual EMAC to Switch , dual EMAC to HSR, switch to dual EMAC and HSR
to dual EMAC is supported.

Software HSR, software Switch / bridging can be done only with dual EMAC
firmware.

To summarize,
Dual EMAC firmware - Supports normal Ethernet operations, Can do
software bridging, software HSR
Switch Firmware - Can do bridging in hardware. For software bridging
this firmware is not needed, DUAL EMAC firmware will be used.
HSR firmware - Can do HSR offloading in hardware. For software offload
this firmware is not needed, dual EMAC firmware will be used for that.

By default the firmware is Dual EMAC firmware. Firmware will only be
changed when offloading in hardware is needed.

> How many more different firmwares do you have?
> 

We have these 3 firmwares only for ICSSG.

> 	Andrew

-- 
Thanks and Regards,
Danish

