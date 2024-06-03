Return-Path: <netdev+bounces-100054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 529458D7B7A
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 08:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D751F216BA
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 06:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E6422094;
	Mon,  3 Jun 2024 06:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iZ1bS3v6"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666221862;
	Mon,  3 Jun 2024 06:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717395442; cv=none; b=uQVT767bd+NeT2hzedxLYcSdw/stLTTGDsC0a2H1cG/5Zv6UIZE5LEuDO7noQRubQzzbqhBOcKl7mqWSwB7w7Lky5SP3lGoC3pUBF+xwMiIkW5HXlsWt8RNY/fQZxiL3AnL5PMhmTOcbtF5WTuWttfeaQGmiS2kbRIDB9u+KK3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717395442; c=relaxed/simple;
	bh=+OIrHNz0AajsxeSP6vAxqcIqVhsqMUTZ3wg1DMQkyk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZsR/kIZgeadpwSX86yNTuAd14Rq60V165BtEoaWJPG56HWkLZ/eYB384h4NnJ+uLjDRtqg/PMGW1z3AGW3AW2m3t3LammR4kQVWWVkUsVRgyMelASWqk+VD2hP7Lf+Dv97pEiEu3zANG9l/gehsT9WqIagh4pi10N77yb7O1IGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iZ1bS3v6; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4536GpAk023607;
	Mon, 3 Jun 2024 01:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717395411;
	bh=wq6ldKfefDDO6VjHb1eaLgPU/SA77amif7dpZA3xt+o=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=iZ1bS3v6V3YQD0ghl8j9rnYF0Rp1NtcaFfu1tpS/zGYWJHIlKzGmfUgZVfCoeO4ZI
	 LsSrfwfYs2yCn0UxWevHl6RWk2b44wG0SJus7q7UXWqEYXDeeQNdBTbTgGkjrsEyRA
	 2iQ/DX2KnbSQH2iJQckGtJIZYeATkgoMKDi6zc74=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4536GpxH113657
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Jun 2024 01:16:51 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Jun 2024 01:16:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Jun 2024 01:16:51 -0500
Received: from [172.24.227.57] (linux-team-01.dhcp.ti.com [172.24.227.57])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4536Gj9n047204;
	Mon, 3 Jun 2024 01:16:46 -0500
Message-ID: <d0fffc06-cc00-43ab-af16-947392732e1b@ti.com>
Date: Mon, 3 Jun 2024 11:46:45 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] net: ethernet: ti: RPMsg based shared
 memory ethernet driver
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: <schnelle@linux.ibm.com>, <wsa+renesas@sang-engineering.com>,
        <diogo.ivo@siemens.com>, <rdunlap@infradead.org>, <horms@kernel.org>,
        <vigneshr@ti.com>, <rogerq@ti.com>, <danishanwar@ti.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <rogerq@kernel.org>,
        <y-mallik@ti.com>
References: <20240531064006.1223417-1-y-mallik@ti.com>
 <20240531064006.1223417-2-y-mallik@ti.com>
 <f13bf55e-9cc6-42dc-a32d-41bbbd8358e7@ti.com>
Content-Language: en-US
From: Yojana Mallik <y-mallik@ti.com>
In-Reply-To: <f13bf55e-9cc6-42dc-a32d-41bbbd8358e7@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 6/2/24 12:31, Siddharth Vadapalli wrote:
> On Fri, May 31, 2024 at 12:10:04PM +0530, Yojana Mallik wrote:
>> From: Ravi Gunasekaran <r-gunasekaran@ti.com>
>>
>> TI's K3 SoCs comprises heterogeneous processors (Cortex A, Cortex R).
>> When the ethernet controller is completely managed by a core (Cortex R)
>> running a flavor of RTOS, in a non virtualized environment, network traffic
>> tunnelling between heterogeneous processors can be realized by means of
>> RPMsg based shared memory ethernet driver. With the shared memory used
>> for the data plane and the RPMsg end point channel used for control plane.
>>
>> inter-core-virt-eth driver is modelled as a RPMsg based shared
>> memory ethernet driver for such an use case.
>>
>> As a first step, register the inter-core-virt-eth as a RPMsg driver.
>> And introduce basic control messages for querying and responding.
>>
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> My "Signed-off-by" tag was present in the RFC patch at:
> https://lore.kernel.org/r/20240130110944.26771-2-r-gunasekaran@ti.com/
> 

Sorry for the mistake. I will add it.

> Any reason for dropping it? Also, I was in the Cc list of the RFC series.
> Please ensure that you don't drop emails which were present in earlier
> versions of the series (unless the email is no longer valid), and also
> ensure that you Cc all individuals who have commented on the series when
> you post a new version of the series.
> 

Sorry for the mistake. I will ensure that I Cc all the necessary individuals.

>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> Signed-off-by: Yojana Mallik <y-mallik@ti.com>
>> ---
>>  drivers/net/ethernet/ti/Kconfig               |  9 +++
>>  drivers/net/ethernet/ti/Makefile              |  1 +
>>  drivers/net/ethernet/ti/icve_rpmsg_common.h   | 47 +++++++++++
>>  drivers/net/ethernet/ti/inter_core_virt_eth.c | 81 +++++++++++++++++++
> 
> [...]
> 
> Regards,
> Siddharth.

