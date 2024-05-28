Return-Path: <netdev+bounces-98396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCCE8D13DE
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 07:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7998CB2288A
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 05:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B684C622;
	Tue, 28 May 2024 05:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p3jyiMrs"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB59661FC5;
	Tue, 28 May 2024 05:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716874085; cv=none; b=D1M1/d8w4Y56pyZPUiimgyWviTLf3u/0itHDLBef/+4t9WRx7WwrkSVmCywZtA0Aex7UTN9lz3mz9WAl+N8DEE7XD7IuB5eQx8tTAopmtn1sME2WJfgER+YgiHCND89Umg0y6nCUN/qDKJdHjcE/A+2rKYqcu890W7Kah5pCLdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716874085; c=relaxed/simple;
	bh=vQuCQ35yXCs6hcRok3+RmXSxZqsl6J5tco0sBsH6438=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VKRgcl4RdsZOzRIM4YPItHchDzlnQ3/G5H0zqsf5YfS7QrePkYu1zSsrgVCPs5sfHVsO4zTyqsp3vksGfD1L53yyfKLXksoLGK/5gdobABeGZu9ofElhIJt/4untBRnZwVYfpX/jmpHeshPbQG64Nx5zjQmMRa2cBoxS+Os0bAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=p3jyiMrs; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S5Reep058660;
	Tue, 28 May 2024 00:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716874060;
	bh=T3TALpaDS0cEvHlhWZRF7Tn4VCwpSQzhTkj0dNYWvDc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=p3jyiMrsmKjifKYXTt/tJ4Md9/K/SPWPu/dOHaRIk8hmQqwaUHNt+BpUTNUeSDmhl
	 lCZ4MsWrQdahvpZtKvuKF0PLfYr0DwXeyCPBN/PbSA9REL8ZLmsRk1rvAupQtGMrHj
	 Z9TOIdrvaSfKeF7EYhYgexInHQ8mmj1LBBoxphik=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S5ReB4017579
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 May 2024 00:27:40 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 00:27:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 00:27:40 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44S5RXkB064234;
	Tue, 28 May 2024 00:27:34 -0500
Message-ID: <9b16c10c-a08a-4b37-8ffc-6ae19b1c70d2@ti.com>
Date: Tue, 28 May 2024 10:57:33 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/3] net: ti: icssg-prueth: Add helper
 functions to configure FDB
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka
	<jan.kiszka@siemens.com>, Simon Horman <horms@kernel.org>,
        Vladimir Oltean
	<vladimir.oltean@nxp.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Diogo Ivo <diogo.ivo@siemens.com>,
        Roger Quadros <rogerq@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>
References: <20240527052738.152821-1-danishanwar@ti.com>
 <20240527052738.152821-2-danishanwar@ti.com>
 <3cf97632-4d77-4f28-bed6-7d40d61d958f@lunn.ch>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <3cf97632-4d77-4f28-bed6-7d40d61d958f@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 28/05/24 3:34 am, Andrew Lunn wrote:
>> +struct mgmt_cmd {
>> +	u8 param;
>> +	u8 seqnum;
>> +	u8 type;
>> +	u8 header;
>> +	u32 cmd_args[3];
>> +} __packed;
> 
> There is a general dislike for __packed. Since your structures are
> naturally well aligned, it is probably not needed. You could be
> paranoid and add BUILD_BUG_ON(sizeof(struct mgmt_cmd) != 16);
> 

Sure, I will drop __packed as it's not needed and send next revision.

> 	 Andrew

-- 
Thanks and Regards,
Danish

