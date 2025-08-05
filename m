Return-Path: <netdev+bounces-211648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC73B1ADBA
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 07:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85CA18A03B3
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 05:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3512045B7;
	Tue,  5 Aug 2025 05:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JTWjNN8t"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91AF2904;
	Tue,  5 Aug 2025 05:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754373022; cv=none; b=R213eYUtPKwdtbSg4s5WMMe5q1ZOEV3KAKEdqyZ1gDcHjhe69HM9sMmMaF5HEygmLWT1G11iwLIbCSXh5aaJ78UwW1RP9Q5hYY00fWZj1CIKAj5a6Y+mnDapC1FIvWixMwvA6J9BfVxPFmnsDCLsGEQpx1mfT2MZ1+u2sphTKig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754373022; c=relaxed/simple;
	bh=9UrC8R6/cHhzNeVb7PXG4J7LIKNuc9JI6bEz10hJXQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Lj4Od+l3+0HUkby0eup8r9+wIy+7qPpVMrb5F9q5O4EKmnwNNYl6nhqpDFkkFwkN9ezs8G3pGhZmjUdOU0uCdsTDlcAmDfyhfCkPwCqXzPlidvQW2YqJ7A8JdgvnlGl7/Gv7Z7r9VJPiwuDrUNI7XsiMAIJ9vPTqS3Aq+Hvy2xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JTWjNN8t; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5755o3L6269191;
	Tue, 5 Aug 2025 00:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754373003;
	bh=+VTpc+4yMWsn0h4j0qC+icyeqYURleBo3nXl9IU2OF4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=JTWjNN8tga4OF9jxDBbqtfN4ilgOhDzSsip3w7+sS7Yvkvqeh/bpgVzTDvtwO5kZV
	 FDif0DZ/CKOZLV0ztlSlMYHviTN7Swc7RZVtVDGnBohuugZpgILAVQsJje2M0gQwLD
	 VoUAjQFcNXAnWshIUXG+5lpBnmIViv3CIKJNjnRw=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5755o2lR2071154
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 5 Aug 2025 00:50:02 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 5
 Aug 2025 00:50:02 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 5 Aug 2025 00:50:02 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5755nvfM1325571;
	Tue, 5 Aug 2025 00:49:58 -0500
Message-ID: <40a7cc6c-363e-4516-847d-9ac6164203ef@ti.com>
Date: Tue, 5 Aug 2025 11:19:57 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix emac link speed
 handling
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Meghana Malladi
	<m-malladi@ti.com>,
        Himanshu Mittal <h-mittal1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20250801121948.1492261-1-danishanwar@ti.com>
 <be848373-4b7f-4205-b1e4-b08fe161d689@lunn.ch>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <be848373-4b7f-4205-b1e4-b08fe161d689@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Andrew,

On 04/08/25 10:19 pm, Andrew Lunn wrote:
> On Fri, Aug 01, 2025 at 05:49:48PM +0530, MD Danish Anwar wrote:
>> When link settings are changed emac->speed is populated by
>> emac_adjust_link(). The link speed and other settings are then written into
>> the DRAM. However if both ports are brought down after this and brought up
>> again or if the operating mode is changed and a firmware reload is needed,
>> the DRAM is cleared by icssg_config(). As a result the link settings are
>> lost.
>>
>> Fix this by calling emac_adjust_link() after icssg_config(). This re
>> populates the settings in the DRAM after a new firmware load.
>>
>> Fixes: 9facce84f406 ("net: ti: icssg-prueth: Fix firmware load sequence.")
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>> v1 - v2: Added phydev lock before calling emac_adjust_link() as suggested
>> by Andrew Lunn <andrew@lunn.ch>
>> v1 https://lore.kernel.org/all/20250731120812.1606839-1-danishanwar@ti.com/
>>
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> index 2b973d6e2341..58aec94b7771 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> @@ -50,6 +50,8 @@
>>  /* CTRLMMR_ICSSG_RGMII_CTRL register bits */
>>  #define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
>>  
>> +static void emac_adjust_link(struct net_device *ndev);
>> +
>>  static int emac_get_tx_ts(struct prueth_emac *emac,
>>  			  struct emac_tx_ts_response *rsp)
>>  {
>> @@ -229,6 +231,12 @@ static int prueth_emac_common_start(struct prueth *prueth)
>>  		ret = icssg_config(prueth, emac, slice);
>>  		if (ret)
>>  			goto disable_class;
>> +
>> +		if (emac->ndev->phydev) {
>> +			mutex_lock(&emac->ndev->phydev->lock);
>> +			emac_adjust_link(emac->ndev);
>> +			mutex_unlock(&emac->ndev->phydev->lock);
>> +		}
> 
> What about the else case? The link settings are lost, and the MAC does
> not work?
> 

Actually this if else is not needed at all. If phydev == NULL, the
driver would have already returned -ENODEV in emac_phy_connect() and the
device's probe would have failed.

If we have reached this point that means phydev is not null and there is
no need for this check.

I will drop this if check and send a v3.

> 	Andrew

-- 
Thanks and Regards,
Danish


