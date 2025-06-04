Return-Path: <netdev+bounces-195017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9A2ACD7BD
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 08:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DCB1176B68
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 06:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78B12620F5;
	Wed,  4 Jun 2025 06:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FIemKoBN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3769827735;
	Wed,  4 Jun 2025 06:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749017418; cv=none; b=FE2iQ0+QGfV/dMVTN/7xTpcaq5jFyP1+ckjVH0p8yO8nMICmPNYW7dq1UHDxayaZCM6eWXfziN0gd+bjp6ysG2RTqSHFeEI4KytRMjZhTG0G+CWR50zAJNfML2+U1YrP80hnzbwwW5DPE/xZNT0O4Xg68x10bUPLaxV8fFdUERQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749017418; c=relaxed/simple;
	bh=RceHe43LrHdhUqUp0mi+MOmWNUvkxADp/Ff3ETAvVUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O9XGwmJUQS9tVpJrkNOp6UhaYflppK/mtrxkjMRxCXyCER8gct7SIpfoD1NEOjZn9hc9lgVmA2587I9PGRxvnOO5xmwyZ4EYORhoaFwcEA7Et4iDFQxm//OstSmaAnAODtszF6ZNmOMCtk5vPwY/SyANbghN2WpqtmjbSeYIuLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FIemKoBN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553KkbDR027442;
	Wed, 4 Jun 2025 06:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mKgtHm8ln/LZ8rgIcE9dG3qBi4cgFRPwa5/VptNj0oA=; b=FIemKoBNbe5yKUyW
	J144d5wed+ggJ7wR9J58h952F4O9EC1HAPkksaUSm83TssNp5yWapPHFIud8QDFq
	kXEHMRftLjBAkqM6cVKMT4pe11bxUjHo7+kMZ5958wDYdUq50GkL30g34kB1jkTh
	RfKu3XMIldyR59uyS5Y0wel75UIZdmS9LeiA256uJq+C/m1sWHGxkyiLLZpxc9Lm
	Q/kQW55UqmC5u7OO07f27RtCRkVYRGLcAAeQ0qBkFVKiFGmXdjm/TFbBSnVoBBSw
	y72BiEbOLDjz5SD5mDZyHkq5NqIENw95xyhKTfIX/OOiIO0tcQVGsyarjoC/iY9Z
	sSWi2g==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8t51kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 06:09:53 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55469qxV032737
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Jun 2025 06:09:52 GMT
Received: from [10.110.52.127] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Jun 2025
 23:09:51 -0700
Message-ID: <0b44c0f5-d922-4d89-8244-f114aedafa03@quicinc.com>
Date: Tue, 3 Jun 2025 23:09:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: phy: clear phydev->devlink when the link is
 deleted
To: Wei Fang <wei.fang@nxp.com>
CC: Florian Fainelli <f.fainelli@gmail.com>,
        "andrew@lunn.ch"
	<andrew@lunn.ch>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "xiaolei.wang@windriver.com" <xiaolei.wang@windriver.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Sarosh Hasan
	<quic_sarohasa@quicinc.com>
References: <20250523083759.3741168-1-wei.fang@nxp.com>
 <8b947cec-f559-40b4-a0e0-7a506fd89341@gmail.com>
 <d696a426-40bb-4c1a-b42d-990fb690de5e@quicinc.com>
 <PAXPR04MB85107D8AB628CC9814C9B230886CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <PAXPR04MB85107D8AB628CC9814C9B230886CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=eJQTjGp1 c=1 sm=1 tr=0 ts=683fe331 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=jZjJzmEmTJcjZ5Ws:21 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=8AirrxEcAAAA:8 a=n-XYdj9mKKn7M4t2rGkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: Y3Ecz_vAR2Qa2O__vdP1GUD1Pw-ZfK4v
X-Proofpoint-GUID: Y3Ecz_vAR2Qa2O__vdP1GUD1Pw-ZfK4v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA1MCBTYWx0ZWRfX2wfQnz2aFBoo
 /pXWdV1nU+K3BLv2FhBbK8yXx9undqu9K7yb9T8BoTkzJ2ZSKMQpL+b5hzdRBOY+PDZ5GdvoCxa
 u30OXjS+r4z1ogz5srfyMCZXxPHq2dNNppKj8hkQfVhru5qnzYKCNR4lphOliLjMwp8EN89zO55
 i1Yh2Z52UgjcdsaZhH/ZcFzEcc/xRNwN/QgeL2CERgdHzJPlXaE6MWjWxETrPj/bg47b+fUwf7D
 fvYqGOqOdaHpwt640v1ItIAr5pmZnTS+GPLpMdnO90zhpj+ToiM0pGO82R0gTUix0/1IXbRfwXd
 NK4S2c3MJY87Hh3Hvf8CrMxqFJjwv5j7zEO4ionG4XWRFYeGG9nzsjoZeq8+yT5xosYk+ztp1Rp
 ZNLgokv7LEjgCp6mkDtAu3QOcgF1r3wPsynv0B83JLXoWeNlcs+MshlXc3XTZHfVeRkkkQ5M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_01,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 phishscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040050



On 6/3/2025 11:00 PM, Wei Fang wrote:
>>> On 5/23/2025 1:37 AM, Wei Fang wrote:
>>>> There is a potential crash issue when disabling and re-enabling the
>>>> network port. When disabling the network port, phy_detach() calls
>>>> device_link_del() to remove the device link, but it does not clear
>>>> phydev->devlink, so phydev->devlink is not a NULL pointer. Then the
>>>> network port is re-enabled, but if phy_attach_direct() fails before
>>>> calling device_link_add(), the code jumps to the "error" label and
>>>> calls phy_detach(). Since phydev->devlink retains the old value from
>>>> the previous attach/detach cycle, device_link_del() uses the old value,
>>>> which accesses a NULL pointer and causes a crash. The simplified crash
>>>> log is as follows.
>>>>
>>>> [   24.702421] Call trace:
>>>> [   24.704856]  device_link_put_kref+0x20/0x120
>>>> [   24.709124]  device_link_del+0x30/0x48
>>>> [   24.712864]  phy_detach+0x24/0x168
>>>> [   24.716261]  phy_attach_direct+0x168/0x3a4
>>>> [   24.720352]  phylink_fwnode_phy_connect+0xc8/0x14c
>>>> [   24.725140]  phylink_of_phy_connect+0x1c/0x34
>>>>
>>>> Therefore, phydev->devlink needs to be cleared when the device link is
>>>> deleted.
>>>>
>>>> Fixes: bc66fa87d4fd ("net: phy: Add link between phy dev and mac dev")
>>>> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>>>
>> @Wei
>> What happens in case of shared mdio ?
>>
>> 1. Device 23040000 has the mdio node of both the ethernet phy and device
>> 23000000 references the phy-handle present in the Device 23040000
>> 2. When rmmod of the driver happens
>> 3. the parent devlink is already deleted.
>> 4. This cause the child mdio to access an entry causing a corruption.
>> 5. Thought this fix would help but i see that its not helping the case.
>>
> 
> My patch is only to fix the potential crash issue when re-enabling
> the network interface. phy_detach() is not called when the MDIO
> controller driver is removed. So phydev->devlink is not cleared, but
> actually the device link has been removed by phy_device_remove()
> --> device_del(). Therefore, it will cause the crash when the MAC
> controller driver is removed.
> 
>> Wondering if this is a legacy issue with shared mdio framework.
>>
> 
> I think this issue is also introduced by the commit bc66fa87d4fd
> ("net: phy: Add link between phy dev and mac dev"). I suggested
> to change the DL_FLAG_STATELESS flag to
> DL_FLAG_AUTOREMOVE_SUPPLIER to solve this issue, so that
> the consumer (MAC controller) driver will be automatically removed
> when the link is removed. The changes are as follows.
> 

thanks a lot , Russell and Wei for your prompt response. 
I appreciate your help. let me test this change and get back. 

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 73f9cb2e2844..a6d7acd73391 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1515,6 +1515,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>         struct mii_bus *bus = phydev->mdio.bus;
>         struct device *d = &phydev->mdio.dev;
>         struct module *ndev_owner = NULL;
> +       struct device_link *devlink;
>         bool using_genphy = false;
>         int err;
> 
> @@ -1646,9 +1647,16 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>          * another mac interface, so we should create a device link between
>          * phy dev and mac dev.
>          */
> -       if (dev && phydev->mdio.bus->parent && dev->dev.parent != phydev->mdio.bus->parent)
> -               phydev->devlink = device_link_add(dev->dev.parent, &phydev->mdio.dev,
> -                                                 DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
> +       if (dev && phydev->mdio.bus->parent &&
> +           dev->dev.parent != phydev->mdio.bus->parent) {
> +               devlink = device_link_add(dev->dev.parent, &phydev->mdio.dev,
> +                                         DL_FLAG_PM_RUNTIME |
> +                                         DL_FLAG_AUTOREMOVE_SUPPLIER);
> +               if (!devlink) {
> +                       err = -ENOMEM;
> +                       goto error;
> +               }
> +       }
> 
>         return err;
> 
> @@ -1749,11 +1757,6 @@ void phy_detach(struct phy_device *phydev)
>         struct module *ndev_owner = NULL;
>         struct mii_bus *bus;
> 
> -       if (phydev->devlink) {
> -               device_link_del(phydev->devlink);
> -               phydev->devlink = NULL;
> -       }
> -
>         if (phydev->sysfs_links) {
>                 if (dev)
>                         sysfs_remove_link(&dev->dev.kobj, "phydev");
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index e194dad1623d..cc1f45c3ff21 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -505,8 +505,6 @@ struct macsec_ops;
>   *
>   * @mdio: MDIO bus this PHY is on
>   * @drv: Pointer to the driver for this PHY instance
> - * @devlink: Create a link between phy dev and mac dev, if the external phy
> - *           used by current mac interface is managed by another mac interface.
>   * @phyindex: Unique id across the phy's parent tree of phys to address the PHY
>   *           from userspace, similar to ifindex. A zero index means the PHY
>   *           wasn't assigned an id yet.
> @@ -610,8 +608,6 @@ struct phy_device {
>         /* And management functions */
>         const struct phy_driver *drv;
> 
> -       struct device_link *devlink;
> -
>         u32 phyindex;
>         u32 phy_id;
> 

