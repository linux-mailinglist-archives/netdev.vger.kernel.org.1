Return-Path: <netdev+bounces-120512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E7C959AB7
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA454281A85
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 11:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F9816CD00;
	Wed, 21 Aug 2024 11:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S2TUaoPY"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700251531DB;
	Wed, 21 Aug 2024 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724240054; cv=none; b=kS+9WJbO48Uvh+oDUDKNo1X/RFcyCPR3JgUFfRN14x6rqScDhNy00fWUjW4aRTr6oe9CRJX6CHW2Jjy503/6rZktxI8ACzaMjVgQfS3maQzWoDG2LOcaT3S9Q0E3gJpTEUeGAEFriAOyNWpkS6pI808Tx1h7ZUYuT7/dvpyyMtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724240054; c=relaxed/simple;
	bh=Pp1LZ3tImd9xlZ6eeyUteihn1b2SVzIzXjOOlIH8eNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Tm/AIjzLV9EcIcQIIMgGHk9ZFBHS8M6uMoCdOu5gqX9EohFIE5PbZwyG0jJVBBpOcTNpI3m9ddHiMfRYgqV46Pf8zpR6KIbBusvYa+OSmnRwm3bSfkcjGQZNyuLpOyI/nVjAmJ1W9PQWNSUhct78ICmYGen+7e5GUuG6Rr64gIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=S2TUaoPY; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47LBXq6g105163;
	Wed, 21 Aug 2024 06:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724240033;
	bh=s5YJ2+cOlNuKYaNlDixXfNUEYuWd3904OImKzjMXfTU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=S2TUaoPYcHX3zmHMcu3B6vscrbiaynqvJuw6t9YsZKjoyTgImNx4N+lLrdOOnUHC4
	 qSn0NhW8FNPadt43tf/NEHR+1V/nWVuoQy/A81nn5rqnzU5Xn9O14qYQzsFKi+pFyQ
	 86jMWrjuTyUNkgKB44F/jZQ9QCMfWNGfJFijnRBs=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47LBXqE2094050
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Aug 2024 06:33:52 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Aug 2024 06:33:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Aug 2024 06:33:52 -0500
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47LBXlRf025573;
	Wed, 21 Aug 2024 06:33:47 -0500
Message-ID: <9766c4f6-b687-49d6-8476-8414928a3a0e@ti.com>
Date: Wed, 21 Aug 2024 17:03:46 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/7] net: ti: icssg-prueth: Enable IEP1
To: Roger Quadros <rogerq@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
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
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <aee5b633-31ce-4db0-9014-90f877a33cf4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Roger,

On 8/21/2024 4:57 PM, Roger Quadros wrote:
> Hi,
> 
> On 13/08/2024 10:42, MD Danish Anwar wrote:
>> IEP1 is needed by firmware to enable FDB learning and FDB ageing.
> 
> Required by which firmware?
> 

IEP1 is needed by all ICSSG firmwares (Dual EMAC / Switch / HSR)

> Does dual-emac firmware need this?
> 

Yes, Dual EMAC firmware needs IEP1 to enabled.

>> Always enable IEP1
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 14 ++++----------
>>  1 file changed, 4 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> index 53a3e44b99a2..613bd8de6eb8 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> @@ -1256,12 +1256,8 @@ static int prueth_probe(struct platform_device *pdev)
>>  		goto put_iep0;
>>  	}
>>  
>> -	if (prueth->pdata.quirk_10m_link_issue) {
>> -		/* Enable IEP1 for FW in 64bit mode as W/A for 10M FD link detect issue under TX
>> -		 * traffic.
>> -		 */
>> -		icss_iep_init_fw(prueth->iep1);
>> -	}
>> +	/* Enable IEP1 for FW as it's needed by FW for FDB Learning and FDB ageing */
>> +	icss_iep_init_fw(prueth->iep1);
>>  
>>  	/* setup netdev interfaces */
>>  	if (eth0_node) {
>> @@ -1366,8 +1362,7 @@ static int prueth_probe(struct platform_device *pdev)
>>  	}
>>  
>>  exit_iep:
>> -	if (prueth->pdata.quirk_10m_link_issue)
>> -		icss_iep_exit_fw(prueth->iep1);
>> +	icss_iep_exit_fw(prueth->iep1);
>>  	icss_iep_put(prueth->iep1);
>>  
>>  put_iep0:
>> @@ -1424,8 +1419,7 @@ static void prueth_remove(struct platform_device *pdev)
>>  		prueth_netdev_exit(prueth, eth_node);
>>  	}
>>  
>> -	if (prueth->pdata.quirk_10m_link_issue)
>> -		icss_iep_exit_fw(prueth->iep1);
>> +	icss_iep_exit_fw(prueth->iep1);
>>  
>>  	icss_iep_put(prueth->iep1);
>>  	icss_iep_put(prueth->iep0);
> 

-- 
Thanks and Regards,
Md Danish Anwar

