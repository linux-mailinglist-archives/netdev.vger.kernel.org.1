Return-Path: <netdev+bounces-126989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C829973865
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 15:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF428B26A2F
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 13:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C9D191F9F;
	Tue, 10 Sep 2024 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c9A89dcp"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E801922F3;
	Tue, 10 Sep 2024 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725974062; cv=none; b=a2jydbjcC6W4A86hRKfStmYSPRi95MnwuGpQ/R2u/qls+7g47rzQmq/IPYolqAsIKWBizQX2r/4k1JqVBHP2xzNkLPFDI/jhBVCwZBVY5Y4KVemHRmMpgMO8q1CFWgFwzJ9xt8VWA3YG6uxW3D+/DysB8MinETEG1aUGuE7i1Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725974062; c=relaxed/simple;
	bh=1pagGJlMligYKZyOj9tam/1hx/qdYKEwyfiKlbrh+Gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hz8AGxaidZ5jZByr+y+mPlRHD7IoZvV6YZWP0XFSbhgv1R6dufFMWufHIzEnU2lDwA3masaiDTQGf0Bljnin8hhk7od+hMPd4dQ/bedrEGoTz2TtVjaXuxUexs43EMLx3GvUvnGCPPkHK5mKZtZ7DkfNgASW6rHDcSPz9tOxGik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=c9A89dcp; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48ADDt8J016552;
	Tue, 10 Sep 2024 08:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725974035;
	bh=3QQnfOqsPdOz7QAodUe4yNHrei3gpQ5ULO/eL+FUblo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=c9A89dcpFekInS9FMb1dAXEH0PDAa9GCjUyh8WyFAH4z54SX20IDPSIjeZc6c3Ywt
	 TouREtliykiaFQ1343IUC9X0iEJbToOZC8bYRTW5KeAF7iaCPgf8F+CwAcTmmUN25a
	 HSyULQ3B8ikG+8QWnxZzXl/pGEul7SS46p0D2lic=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48ADDtos123525
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Sep 2024 08:13:55 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Sep 2024 08:13:55 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Sep 2024 08:13:55 -0500
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48ADDnum091514;
	Tue, 10 Sep 2024 08:13:49 -0500
Message-ID: <d1e114ca-aa81-4e7f-b5ab-38656b205a33@ti.com>
Date: Tue, 10 Sep 2024 18:43:48 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] net: ti: icssg-prueth: Add support for
 HSR frame forward offload
To: Roger Quadros <rogerq@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
        <robh@kernel.org>, <jan.kiszka@siemens.com>,
        <dan.carpenter@linaro.org>, <saikrishnag@marvell.com>,
        <andrew@lunn.ch>, <javier.carrasco.cruz@gmail.com>,
        <jacob.e.keller@intel.com>, <diogo.ivo@siemens.com>,
        <horms@kernel.org>, <richardcochran@gmail.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>
References: <20240906111538.1259418-1-danishanwar@ti.com>
 <20240906111538.1259418-4-danishanwar@ti.com>
 <cf462ca8-08bd-42bd-965a-88e28e63bb3f@kernel.org>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <cf462ca8-08bd-42bd-965a-88e28e63bb3f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Roger,

On 9/10/2024 5:42 PM, Roger Quadros wrote:
> Hi,
> 
> On 06/09/2024 14:15, MD Danish Anwar wrote:
>> Add support for offloading HSR port-to-port frame forward to hardware.
>> When the slave interfaces are added to the HSR interface, the PRU cores
>> will be stopped and ICSSG HSR firmwares will be loaded to them.
>>
>> Similarly, when HSR interface is deleted, the PRU cores will be
>> restarted and the last used firmwares will be reloaded. PRUeth
>> interfaces will be back to the last used mode.
>>
>> This commit also renames some APIs that are common between switch and
>> hsr mode with '_fw_offload' suffix.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  .../net/ethernet/ti/icssg/icssg_classifier.c  |   1 +
>>  drivers/net/ethernet/ti/icssg/icssg_config.c  |  18 +--
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 132 +++++++++++++++++-
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   6 +
>>  4 files changed, 145 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_classifier.c b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
>> index 9ec504d976d6..833ca86d0b71 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> 
> <snip>
> 
>> +static void emac_change_hsr_feature(struct net_device *ndev,
>> +				    netdev_features_t features,
>> +				    u64 hsr_feature)
>> +{
>> +	netdev_features_t changed = ndev->features ^ features;
>> +
>> +	if (changed & hsr_feature) {
>> +		if (features & hsr_feature)
>> +			ndev->features |= hsr_feature;
>> +		else
>> +			ndev->features &= ~hsr_feature;
> 
> You are not supposed to change ndev->features here.
> 
> From
> "https://www.kernel.org/doc/Documentation/networking/netdev-features.txt"
> "
>  * ndo_set_features:
> 
> Hardware should be reconfigured to match passed feature set. The set
> should not be altered unless some error condition happens that can't
> be reliably detected in ndo_fix_features. In this case, the callback
> should update netdev->features to match resulting hardware state.
> Errors returned are not (and cannot be) propagated anywhere except dmesg.
> (Note: successful return is zero, >0 means silent error.)"
> 
> This means only in 
> 
>> +	}
>> +}
>> +
>> +static int emac_ndo_set_features(struct net_device *ndev,
>> +				 netdev_features_t features)
>> +{
>> +	emac_change_hsr_feature(ndev, features, NETIF_F_HW_HSR_FWD);
>> +	emac_change_hsr_feature(ndev, features, NETIF_F_HW_HSR_DUP);
>> +	emac_change_hsr_feature(ndev, features, NETIF_F_HW_HSR_TAG_INS);
>> +	emac_change_hsr_feature(ndev, features, NETIF_F_HW_HSR_TAG_RM);
> 
> I don't understand this part. 
> 
> As you are not changing hardware state in ndo_set_features, I'm not sure why
> you even need ndo_set_features callback.
> 

We don't need to do any hardware configuration when the feature is
changed. Instead certain APIs will do certain actions based on which HSR
related feature is set in ndev->features. I agree this makes the whole
API redundant. Previously in v3
(https://lore.kernel.org/all/20240828091901.3120935-4-danishanwar@ti.com/)
also this API was essentially just changing ndev->features when hsr
change was requested.

+static int emac_ndo_set_features(struct net_device *ndev,
+				 netdev_features_t features)
+{
...

+
+	if (hsr_change_request)
+		ndev->features = features;
+
+	return 0;
+}

I think it would be better to drop this call back in the driver as no
action is needed in the hardware based on what feature is set here.

> You didn't take my feedback about using ndo_fix_features().
> 

Roger, I have taken your feedback regarding ndo_fix_features() and
implemented it in the next patch (patch 4/5
https://lore.kernel.org/all/20240906111538.1259418-5-danishanwar@ti.com/).
Please have a look at that patch also. The features that have
dependencies that can be addressed in ndo_fix_features, are not
introduced in this patch so I have not introduced the function here. It
is getting introduced in the next patch.

> Please read this.
> https://www.kernel.org/doc/Documentation/networking/netdev-features.txt
> "Part II: Controlling enabled features"
> "Part III: Implementation hints"
> 
> Also look at how _netdev_update_features() works and calls ndo_fix_features()
> and ndo_set_features()
> 

Thanks for this. I checked that. Based on how _netdev_update_features()
is implemented, I don't think there is any need of ndo_set_features.
Whatever hardware dependencies are related to these HSR features, can be
taken care by ndo_fix_features.

Please let me know how does this look to you.

> https://elixir.bootlin.com/linux/v6.11-rc7/source/net/core/dev.c#L10023
> 
>> +
>> +	return 0;
>> +}
>> +
>>  static const struct net_device_ops emac_netdev_ops = {
>>  	.ndo_open = emac_ndo_open,
>>  	.ndo_stop = emac_ndo_stop,
>> @@ -737,6 +780,7 @@ static const struct net_device_ops emac_netdev_ops = {
>>  	.ndo_eth_ioctl = icssg_ndo_ioctl,
>>  	.ndo_get_stats64 = icssg_ndo_get_stats64,
>>  	.ndo_get_phys_port_name = icssg_ndo_get_phys_port_name,
>> +	.ndo_set_features = emac_ndo_set_features,
>>  };
> 
> <snip>
> 

-- 
Thanks and Regards,
Md Danish Anwar

