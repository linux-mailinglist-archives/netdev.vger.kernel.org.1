Return-Path: <netdev+bounces-119571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8333F956437
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B461C212E6
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB73B155C83;
	Mon, 19 Aug 2024 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MyNYVoIq"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B717813BC1E;
	Mon, 19 Aug 2024 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724051810; cv=none; b=YyV/pJfU5muZPuSsNJLjWymVvyAn9UhFXsJ2hBJDC0oZqA96MlWsTCt4GwWwXf5ORcpxtCfTcLlnHVwgSBF+mPa3KB2OAg7H84Pr/mzuGHykBy8SVrVW51D0ar4Xt64bMX6M/loC2uxtND1vitTSAMzsdWfTfVRYU83NeveZ3v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724051810; c=relaxed/simple;
	bh=gbqRb8eqdOhl9QnV30s4P2pDnpCPKAOf7zpii/ldhAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HPM4cY1O/9cdV2MZWwrHhJiC6S9wFzaKl9nxEjeLJPpybLTkQgOvNMg0rmaxdOQ3KKloZksPHwjg2ksHjbufQvC35ngCARoWCfUzYcYgvt+FeXDBCUQSOSIXRHWhwu2RGuhvxutak0y+iHl0QZHMHY0ylksKZE+ZcuIuV18xp48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MyNYVoIq; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47J7GIhR018652;
	Mon, 19 Aug 2024 02:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724051778;
	bh=TmM2Jr4Uss+zQnpejCEuiHwcaQEhi9LieP76+lIBa+4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=MyNYVoIqgPfXLvWySFVyE+eRtkuyCOsFq2l1pJvgGcuB0fwCC0PDFNwSUu84MmwcZ
	 rn2QQ4+NXaSJMURLgHK2iiAWAdFKTzKzvZ1yIsuxA/hFvLxjACeysykE4bsVh2FGi+
	 hF9/UsacKPb6wG9NT83rXuomKyTxPg8+m8abzYdo=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47J7GIeV115793
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Aug 2024 02:16:18 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Aug 2024 02:16:18 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Aug 2024 02:16:18 -0500
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47J7G8fG056945;
	Mon, 19 Aug 2024 02:16:09 -0500
Message-ID: <d28ddf04-9b31-4920-92f8-23f11e4476b4@ti.com>
Date: Mon, 19 Aug 2024 12:46:07 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/7] net: ti: icssg-prueth: Add support for
 HSR frame forward offload
To: Simon Horman <horms@kernel.org>, MD Danish Anwar <danishanwar@ti.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Jacob Keller
	<jacob.e.keller@intel.com>,
        Diogo Ivo <diogo.ivo@siemens.com>,
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
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <20240813074233.2473876-5-danishanwar@ti.com>
 <20240815151415.GK632411@kernel.org>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <20240815151415.GK632411@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 8/15/2024 8:44 PM, Simon Horman wrote:
> On Tue, Aug 13, 2024 at 01:12:30PM +0530, MD Danish Anwar wrote:
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> index f678d656a3ed..40bc3912b6ae 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> @@ -239,6 +239,7 @@ struct icssg_firmwares {
>>   * @iep1: pointer to IEP1 device
>>   * @vlan_tbl: VLAN-FID table pointer
>>   * @hw_bridge_dev: pointer to HW bridge net device
>> + * @hsr_dev: pointer to the HSR net device
>>   * @br_members: bitmask of bridge member ports
>>   * @prueth_netdevice_nb: netdevice notifier block
>>   * @prueth_switchdev_nb: switchdev notifier block
> 
> I think you also need to add Kernel doc entries for @hsr_members and
> @is_hsr_offload_mode.
> 
> Flagged by W=1 builds and ./scripts/kernel-doc -none

Sure Simon, I'll do that.

> 
>> @@ -274,11 +275,14 @@ struct prueth {
>>  	struct prueth_vlan_tbl *vlan_tbl;
>>  
>>  	struct net_device *hw_bridge_dev;
>> +	struct net_device *hsr_dev;
>>  	u8 br_members;
>> +	u8 hsr_members;
>>  	struct notifier_block prueth_netdevice_nb;
>>  	struct notifier_block prueth_switchdev_nb;
>>  	struct notifier_block prueth_switchdev_bl_nb;
>>  	bool is_switch_mode;
>> +	bool is_hsr_offload_mode;
>>  	bool is_switchmode_supported;
>>  	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
>>  	int default_vlan;
>> -- 
>> 2.34.1
>>

-- 
Thanks and Regards,
Md Danish Anwar

