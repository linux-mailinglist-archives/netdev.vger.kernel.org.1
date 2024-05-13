Return-Path: <netdev+bounces-95868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA54A8C3B45
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 08:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FFEB1C20EC8
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 06:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D7914659C;
	Mon, 13 May 2024 06:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ayQV59t3"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD6D4C81;
	Mon, 13 May 2024 06:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715581636; cv=none; b=JhB1tHetnls8jM4rezDLG6zt8qJ9r+Z5qzDMdLEqkuqf4wZT0K7dIaXZANKCFetIze8H5JdPio22fwzIwywy5bxexv6ELCKVogRH4Duye7n5dgmPee4HHu8V04C/2SVznV2fhDIDJKmyz5sD/TbCy0QDPLsxHhUT7zk2bRkNXSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715581636; c=relaxed/simple;
	bh=UJ8u1P/0powQExzTZ7qC5TrAfTmjb24w0U2OTkahp8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aFfX152/2Wf3qFX3nsWMdAWyC044naUqXENxkgl9UmFO0Xd6HlnQh4ZJjD+bIntGOQR2tgXCnQPoX+vyiacusIU5rjoSyAWhwlGGvSLQ4Ju37bDSYWYiQwvil2fY7I3/gxXrJP7Fh0pE79Hxu+GFIp0/XrTbsqt/6KoPnstn7bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ayQV59t3; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44D6QPtI036976;
	Mon, 13 May 2024 01:26:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715581585;
	bh=e74PeFwbuX5U2n4ShRWkGGibNdGSScWO2TR29iGBNQs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ayQV59t3BgELYDJR0Zz3Cvi3RHrU6wi/hoSbemuIMPHZ9RfZ8DOpXISo7EAT8HZoY
	 PyTS9CcBpzT/Rxvw22i/uOM0QcvFSj54z2vBjfZsJxlodacp+0lvpx6oizqaS2DKqd
	 Z795cXcOQSQiCoud53kqj+bH9L5G1AwBVUiwVJsQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44D6QPXo011521
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 May 2024 01:26:25 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 May 2024 01:26:24 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 May 2024 01:26:24 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44D6QH63026776;
	Mon, 13 May 2024 01:26:18 -0500
Message-ID: <55eeec88-63ea-4838-865a-17493dfb847d@ti.com>
Date: Mon, 13 May 2024 11:56:17 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5] net: ti: icssg_prueth: add TAPRIO offload
 support
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, Jan Kiszka <jan.kiszka@siemens.com>,
        Simon
 Horman <horms@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Randy
 Dunlap <rdunlap@infradead.org>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Wolfram
 Sang <wsa+renesas@sang-engineering.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Roger Quadros
	<rogerq@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>,
        Roger
 Quadros <rogerq@ti.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20240429103022.808161-1-danishanwar@ti.com>
 <74be4e2e25644e0b65ac1894ccb9c2d0971bb643.camel@redhat.com>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <74be4e2e25644e0b65ac1894ccb9c2d0971bb643.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Paolo,

On 02/05/24 5:29 pm, Paolo Abeni wrote:
> On Mon, 2024-04-29 at 16:00 +0530, MD Danish Anwar wrote:
>> +static int emac_taprio_replace(struct net_device *ndev,
>> +			       struct tc_taprio_qopt_offload *taprio)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +	struct tc_taprio_qopt_offload *est_new;
>> +	int ret;
>> +
>> +	if (taprio->cycle_time_extension) {
>> +		NL_SET_ERR_MSG_MOD(taprio->extack, "Cycle time extension not supported");
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	if (taprio->cycle_time < TAS_MIN_CYCLE_TIME) {
>> +		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "cycle_time %llu is less than min supported cycle_time %d",
>> +				       taprio->cycle_time, TAS_MIN_CYCLE_TIME);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (taprio->num_entries > TAS_MAX_CMD_LISTS) {
>> +		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "num_entries %lu is more than max supported entries %d",
>> +				       taprio->num_entries, TAS_MAX_CMD_LISTS);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (emac->qos.tas.taprio_admin)
>> +		devm_kfree(&ndev->dev, emac->qos.tas.taprio_admin);
> 
> it looks like 'qos.tas.taprio_admin' is initialized from
> taprio_offload_get(), so it should be free with taprio_offload_free(),
> right?
> 

'qos.tas.taprio_admin' is assigned by "emac->qos.tas.taprio_admin =
taprio_offload_get(taprio);". Here I will free it with taprio_offload_free()

>> +
>> +	est_new = devm_kzalloc(&ndev->dev,
>> +			       struct_size(est_new, entries, taprio->num_entries),
>> +			       GFP_KERNEL);
>> +	if (!est_new)
>> +		return -ENOMEM;
> 
> Why are you allocating 'est_new'? it looks like it's not used
> anywhere?!? 
> 

Sorry my bad. Forgot to remove est_new. I will remove it.

>> +
>> +	emac->qos.tas.taprio_admin = taprio_offload_get(taprio);
>> +	ret = tas_update_oper_list(emac);
>> +	if (ret)
>> +		return ret;
> 
> Should the above clear 'taprio_admin' on error, as well? 
> 

Yes here also we should clear taprio_admin and taprio on error. I will
add a goto label and clear taprio on both errors.

Below is the diff to address handling of taprio and taprio_admin.

diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c
b/drivers/net/ethernet/ti/icssg/icssg_qos.c
index 459463ea6c20..c7cadab0edec 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_qos.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
@@ -210,7 +210,7 @@ static int emac_taprio_replace(struct net_device *ndev,
 	}

 	if (emac->qos.tas.taprio_admin)
-		devm_kfree(&ndev->dev, emac->qos.tas.taprio_admin);
+		taprio_offload_free(emac->qos.tas.taprio_admin);

 	est_new = devm_kzalloc(&ndev->dev,
 			       struct_size(est_new, entries, taprio->num_entries),
@@ -221,13 +221,15 @@ static int emac_taprio_replace(struct net_device
*ndev,
 	emac->qos.tas.taprio_admin = taprio_offload_get(taprio);
 	ret = tas_update_oper_list(emac);
 	if (ret)
-		return ret;
+		goto clear_taprio;

 	ret = tas_set_state(emac, TAS_STATE_ENABLE);
-	if (ret) {
-		emac->qos.tas.taprio_admin = NULL;
-		taprio_offload_free(taprio);
-	}
+	if (ret)
+		goto clear_taprio;
+
+clear_taprio:
+	emac->qos.tas.taprio_admin = NULL;
+	taprio_offload_free(taprio);

 	return ret;
 }

Please have a look and let me know if this looks ok to you.


>>
> Thanks,
> 
> Paolo
> 

-- 
Thanks and Regards,
Danish

