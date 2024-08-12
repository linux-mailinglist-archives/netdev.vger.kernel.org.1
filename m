Return-Path: <netdev+bounces-117577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE69E94E634
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 07:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA9F1C21056
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 05:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C5214D2A4;
	Mon, 12 Aug 2024 05:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yj2qClw6"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567743C0B;
	Mon, 12 Aug 2024 05:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723441316; cv=none; b=B8x2NovQ0R+INgz8rR2pEhQh3Z+RkOsGKJjDbw5RLnyO4h+uaOD7RVsIgblTKUvxHRwcTUKMnw6zOzKErlg+aH+bvN8+gWIWk0ycrErCHC8MNccJ+FORh/yzcFon+Azlu0GYGjqux5p56SW/YnFbpFwvWaxl4/4l9chV6QPkfzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723441316; c=relaxed/simple;
	bh=Iacvar3iFBxePydCl7Gqh1UgF1fVeJOOc1Bb7GnvNFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gXKeNnCvHs/qhsOIp1tUQvOlDTUwhD+KcXp5azv6REEbezk0BT2xy5atRHrj/T+OUXz+Oc8X61C6sDYh5zL6P/2r8+8aIA4jXAzrnRMfbmEaX0pWoX/XIoKTZUtutHPoMpl5hieWrmHI2qTvCj6ySxq3jlXsupD/kdgdEW/dMco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yj2qClw6; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47C5fTrh033207;
	Mon, 12 Aug 2024 00:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723441289;
	bh=fX2sT+fujKXhtcrZbhOSpfai/+GnliWHwU6DT8LKr/E=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=yj2qClw6EiDOrOvgyUDTHQJ1KbI7qcMay7ksiUN9l6Cqks9UV4jmxr1PNonGPvbCg
	 VFNAxXjaOMJOqpSRg58uJ/csVDl9A7fDE/G4ykyZpPr2fR5UwlxB8D6ghNsW9E+hel
	 hUy5taLf/zS+UxFZbbDQYV8Z3IwOTkXQUdCPUsO0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47C5fT9F006353
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Aug 2024 00:41:29 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Aug 2024 00:41:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Aug 2024 00:41:28 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47C5fLb8086750;
	Mon, 12 Aug 2024 00:41:22 -0500
Message-ID: <3397a020-195c-4ca3-a524-520171db794b@ti.com>
Date: Mon, 12 Aug 2024 11:11:21 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/6] net: ti: icss-iep: Move icss_iep structure
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Jan Kiszka <jan.kiszka@siemens.com>, Andrew Lunn <andrew@lunn.ch>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Javier Carrasco
	<javier.carrasco.cruz@gmail.com>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Jacob
 Keller <jacob.e.keller@intel.com>,
        Simon Horman <horms@kernel.org>,
        Richard
 Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20240808110800.1281716-1-danishanwar@ti.com>
 <20240808110800.1281716-6-danishanwar@ti.com>
 <6eb3c922-a8c6-4df4-a9ee-ba879e323385@stanley.mountain>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <6eb3c922-a8c6-4df4-a9ee-ba879e323385@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Dan,

On 10/08/24 1:40 am, Dan Carpenter wrote:
> On Thu, Aug 08, 2024 at 04:37:59PM +0530, MD Danish Anwar wrote:
>> -	struct ptp_clock *ptp_clock;
>> -	struct mutex ptp_clk_mutex;	/* PHC access serializer */
>> -	u32 def_inc;
>> -	s16 slow_cmp_inc;
> 
> [ cut ]
> 
>> +	struct ptp_clock *ptp_clock;
>> +	struct mutex ptp_clk_mutex;	/* PHC access serializer */
>> +	spinlock_t irq_lock; /* CMP IRQ vs icss_iep_ptp_enable access */
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> The patch adds this new struct member.  When you're moving code around, please
> just move the code.  Don't fix checkpatch warnings or do any other cleanups.
> 

My bad. I didn't notice this new struct member was introduced. I will
take care of it.

Also apart from doing the code movement, this patch also does the
following change. Instead of hardcoding the value 4, the patch uses
emac->iep->def_inc. Since the iep->def_inc is now accessible from
drivers/net/ethernet/ti/icssg/icssg_prueth.c

@@ -384,7 +384,8 @@ static void prueth_iep_settime(void *clockops_data,
u64 ns)
 	sc_desc.cyclecounter0_set = cyclecount & GENMASK(31, 0);
 	sc_desc.cyclecounter1_set = (cyclecount & GENMASK(63, 32)) >> 32;
 	sc_desc.iepcount_set = ns % cycletime;
-	sc_desc.CMP0_current = cycletime - 4; //Count from 0 to (cycle time)-4
+	/* Count from 0 to (cycle time) - emac->iep->def_inc */
+	sc_desc.CMP0_current = cycletime - emac->iep->def_inc;

 	memcpy_toio(sc_descp, &sc_desc, sizeof(sc_desc));


Should I keep the above change as it is or should I split it into a
separate patch and make this patch strictly for code movement. I kept
the above change as part of this patch because it is related with the
code movement. Moving the iep structure from icss_iep.c to icss_iep.h
makes it accessible to icssg_prueth.c so I thought keeping them together
will be a better idea.

Please let me know if this is okay.

>> +	u32 def_inc;
>> +	s16 slow_cmp_inc;
>> +	u32 slow_cmp_count;
> 
> regards,
> dan carpenter

-- 
Thanks and Regards,
Danish

