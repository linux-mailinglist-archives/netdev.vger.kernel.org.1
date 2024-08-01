Return-Path: <netdev+bounces-114901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4BD944A21
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C388282910
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3C518952D;
	Thu,  1 Aug 2024 11:10:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D33189510;
	Thu,  1 Aug 2024 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510651; cv=none; b=jAVvH4DCfLk7r6T9mWeeKOJO2ouEfZD3IG9xRaONbLWnJtsphvzsN2IedDRk/X7FJxAquATRk1WOKznEbWqmOaPlLFeUL7j7XVEtpi0BmRllJROzekCldgnaDcPOMDyhrFsOBhaALyIjU9RaoXDdTfQlSI/uYpcasqL9lAgfKCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510651; c=relaxed/simple;
	bh=N4s5LWv8nGjaVIohlEd3UbboA9+ABScP84cvlHk2MgI=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RbkfHNW/IIZwOxFB/o3xCvc1YSXTSmq576CDCWpynZwxtYTnJOzTgwWwf9CDt1iJHvLsRi58Mjc7bzCiNSMhVkRM5iCt/L2gUTj1u4hYyrcoBaWdINi0T5+Y4WDU05sy1CVr0VcqYK0vrG0FMIwzfmPJlm7lYQK7159h9OovIoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WZR8S6v9mz1L9Kv;
	Thu,  1 Aug 2024 19:10:32 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 955041402CD;
	Thu,  1 Aug 2024 19:10:45 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 19:10:44 +0800
Message-ID: <c44a5759-855a-4a8c-a4d3-d37e16fdebdc@huawei.com>
Date: Thu, 1 Aug 2024 19:10:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH net-next 08/10] net: hibmcge: Implement workqueue and
 some ethtool_ops functions
To: Andrew Lunn <andrew@lunn.ch>
References: <20240731094245.1967834-1-shaojijie@huawei.com>
 <20240731094245.1967834-9-shaojijie@huawei.com>
 <b20b5d68-2dab-403c-b37b-084218e001bc@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <b20b5d68-2dab-403c-b37b-084218e001bc@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/8/1 9:10, Andrew Lunn wrote:
>> +static void hbg_ethtool_get_drvinfo(struct net_device *netdev,
>> +				    struct ethtool_drvinfo *drvinfo)
>> +{
>> +	strscpy(drvinfo->version, HBG_MOD_VERSION, sizeof(drvinfo->version));
>> +	drvinfo->version[sizeof(drvinfo->version) - 1] = '\0';
> A version is pointless, it tells you nothing useful. If you don't
> touch version, the core will fill it with the uname, so you know
> exactly what kernel this is, which is useful.
>
>> +static u32 hbg_ethtool_get_link(struct net_device *netdev)
>> +{
>> +	struct hbg_priv *priv = netdev_priv(netdev);
>> +
>> +	return priv->mac.link_status;
>> +}
>> +
>> +static int hbg_ethtool_get_ksettings(struct net_device *netdev,
>> +				     struct ethtool_link_ksettings *ksettings)
>> +{
>> +	struct hbg_priv *priv = netdev_priv(netdev);
>> +
>> +	phy_ethtool_ksettings_get(priv->mac.phydev, ksettings);
> You can avoid this wrapper since phy_attach_direct sets netdev->phydev
> to phydev. You can then call phy_ethtool_get_link_ksettings() etc.

Yes, It`s ok

>
>> +static int hbg_ethtool_set_ksettings(struct net_device *netdev,
>> +				     const struct ethtool_link_ksettings *cmd)
>> +{
>> +	struct hbg_priv *priv = netdev_priv(netdev);
>> +
>> +	if (cmd->base.speed == SPEED_1000 && cmd->base.duplex == DUPLEX_HALF)
>> +		return -EINVAL;
> So long as you have told phylib about not supporting 1000Base/Half,
> phy_ethtool_set_link_ksettings() will return an error for you.

okay,

>
>> +static const struct ethtool_ops hbg_ethtool_ops = {
>> +	.get_drvinfo		= hbg_ethtool_get_drvinfo,
>> +	.get_link		= hbg_ethtool_get_link,
> Why not ethtool_op_get_link() ?

It`s a good idea

>
>> +	.get_link_ksettings	= hbg_ethtool_get_ksettings,
>> +	.set_link_ksettings	= hbg_ethtool_set_ksettings,
>> +};
>> +static void hbg_update_link_status(struct hbg_priv *priv)
>> +{
>> +	u32 link;
>> +
>> +	link = hbg_get_link_status(priv);
>> +	if (link == priv->mac.link_status)
>> +		return;
>> +
>> +	priv->mac.link_status = link;
>> +	if (link == HBG_LINK_DOWN) {
>> +		netif_carrier_off(priv->netdev);
>> +		netif_tx_stop_all_queues(priv->netdev);
>> +		dev_info(&priv->pdev->dev, "link down!");
>> +	} else {
>> +		netif_tx_wake_all_queues(priv->netdev);
>> +		netif_carrier_on(priv->netdev);
>> +		dev_info(&priv->pdev->dev, "link up!");
>> +	}
>> +}
> Why do you need this? phylib will poll the PHY once per second and
> call the adjust_link callback whenever the link changes state.

However, we hope that the network port can be linked only when
the PHY and MAC are linked.
The adjust_link callback can ensure that the PHY status is normal,
but cannot ensure that the MAC address is linked.

so, in hbg_get_link_status:
+/* include phy link and mac link */
+u32 hbg_get_link_status(struct hbg_priv *priv)
+{
+	struct phy_device *phydev = priv->mac.phydev;
+	int ret;
+
+	if (!phydev)
+		return HBG_LINK_DOWN;
+
+	phy_read_status(phydev);
+	if ((phydev->state != PHY_UP && phydev->state != PHY_RUNNING) ||
+	    !phydev->link)
+		return HBG_LINK_DOWN;
+
+	ret = hbg_hw_sgmii_autoneg(priv);
+	if (ret)
+		return HBG_LINK_DOWN;
+
+	return HBG_LINK_UP;
+}

>
>> @@ -177,12 +226,17 @@ static int hbg_init(struct net_device *netdev)
>>   	ret = hbg_irq_init(priv);
>>   	if (ret)
>>   		return ret;
>> -
>>   	ret = devm_add_action_or_reset(&priv->pdev->dev, hbg_irq_uninit, priv);
> This white space change does not belong here.

Yes, I'll fix that in V2

Thanks again,

Jijie Shao



