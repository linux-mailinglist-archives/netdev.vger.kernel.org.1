Return-Path: <netdev+bounces-146206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3169B9D242C
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 11:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71F21F21389
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 10:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD57F1C6F71;
	Tue, 19 Nov 2024 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a/byO64M"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1441C68BE;
	Tue, 19 Nov 2024 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013694; cv=none; b=EIKZGlTgjvrL8ulrPSFMp/g3HCtAVvDVKu/XtdKz+N4MqCMHHMv6R67cvPsn/iHvTRfGO7CCNY4+E9f3dkkOzrOeerua5F1g5o80oqIOyMZiyoUDkMkROXery48lVe6G+V1vmiW9TaW11VQ1FPe5PCjF+N4PDz3WonYUpMW4Wxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013694; c=relaxed/simple;
	bh=6gQoT8/TLpzxFQtr4q4xynhJWVCAX993McBZckQUW+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MQ9tQhaPEEFhm73/YW+50iXjtdynTm4WEzvXd2Wvn5CDvBg3xvFwbW6LYSwJ7w25FJ2yr7mE7/oM7X2rxPi6ChVyGee4PxtwmWZkacOXyolmKOXjFX/RgdI5nZ6BGirgPb1jEazg2GYgBGKSFrVgLU2O99p8k4OLT7FD31xIgFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a/byO64M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJAjDS8003860;
	Tue, 19 Nov 2024 10:54:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lereNHPBQqwXXILcBETEFbas5Mk9L0De1Vw2tJ3965I=; b=a/byO64MNFF3olrW
	nM5QFIuvgpNZlEu7udiGVNx27+bhxRW8RYoY4zbd7Mm9XdNkrMxoBEpqsp+nI54F
	XVhQxLiljvIbyuWt5bXxWwEkeqIZzqfsp98HxaCqgufRtbkUfjEzfii0bOAuBh+k
	B3ah6J8KuddN2s5kNvFbHr/NypwPOg0bv78mQqD5pxuEjIBjl5BesMgtM6QFlHwg
	sUB1GC9z/aZd+WpgeiTlaR2rgBcKnfXQzFSAaMtQTVh0ENGMV0QCR9P2TEwSaJS6
	ORGzJlNNUsxU2SuhoHTB7P4vcPgf/n/hZEJMU2a5JLjHC0R7ZX/KCtXvsWsbdUhF
	IG1aOA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y929ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 10:54:38 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJAsSK7011994
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 10:54:36 GMT
Received: from [10.253.72.205] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 19 Nov
 2024 02:54:13 -0800
Message-ID: <b8beb23a-6e39-4534-b7a2-5b0627373fb6@quicinc.com>
Date: Tue, 19 Nov 2024 18:54:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: mdio-ipq4019: fix wrong NULL check
To: Rosen Penev <rosenp@gmail.com>,
        "Russell King (Oracle)"
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit
	<hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20241117212827.13763-1-rosenp@gmail.com>
 <5562cf54-d1bd-4235-b232-33f5cca40b85@quicinc.com>
 <ZzskoS2jwC6eLlmD@shell.armlinux.org.uk>
 <CAKxU2N_zcNB-0gBKPnPo3kjZ7mZpzbiB63JFGVZ5jd1U-LjxSA@mail.gmail.com>
Content-Language: en-US
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <CAKxU2N_zcNB-0gBKPnPo3kjZ7mZpzbiB63JFGVZ5jd1U-LjxSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RASfQEAbZ03XBjpaKBC5KkgJyHTaPpUh
X-Proofpoint-GUID: RASfQEAbZ03XBjpaKBC5KkgJyHTaPpUh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411190078



On 11/19/2024 5:12 AM, Rosen Penev wrote:
> On Mon, Nov 18, 2024 at 3:27 AM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
>>
>> On Mon, Nov 18, 2024 at 06:26:27PM +0800, Jie Luo wrote:
>>> On 11/18/2024 5:28 AM, Rosen Penev wrote:
>>>> devm_ioremap_resource returns a PTR_ERR when it fails, not NULL. OTOH
>>>> this is conditionally set to either a PTR_ERR or a valid pointer. Use
>>>> !IS_ERR_OR_NULL to check if we can use this.
>>>>
>>>> Fixes: 23a890d493 ("net: mdio: Add the reset function for IPQ MDIO driver")
>>>>
>>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>>> ---
>>>>    drivers/net/mdio/mdio-ipq4019.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
>>>> index dd3ed2d6430b..859302b0d38c 100644
>>>> --- a/drivers/net/mdio/mdio-ipq4019.c
>>>> +++ b/drivers/net/mdio/mdio-ipq4019.c
>>>> @@ -256,7 +256,7 @@ static int ipq_mdio_reset(struct mii_bus *bus)
>>>>      /* To indicate CMN_PLL that ethernet_ldo has been ready if platform resource 1
>>>>       * is specified in the device tree.
>>>>       */
>>>> -   if (priv->eth_ldo_rdy) {
>>>> +   if (!IS_ERR_OR_NULL(priv->eth_ldo_rdy)) {
>>>>              val = readl(priv->eth_ldo_rdy);
>>>>              val |= BIT(0);
>>>>              writel(val, priv->eth_ldo_rdy);
>>>
>>> Reviewed-by: Luo Jie <quic_luoj@quicinc.com>
>>
>> Looking at the setup of this:
>>
>>          /* The platform resource is provided on the chipset IPQ5018 */
>>          /* This resource is optional */
>>          res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>          if (res)
>>                  priv->eth_ldo_rdy = devm_ioremap_resource(&pdev->dev, res);
>>
>> While this is optional, surely the optional part is whether resource 1
>> is provided or not. If the resource is provided, but we fail to ioremap
>> it, isn't that an error which should be propagated? In that situation,
>> isn't the firmware saying "we have a second resource" but failing to
>> map it should be an error?

Agree. The fail to ioremap resource 1 needs to be captured and
propagated if the resource 1 is provided by DTS.

> 
> Another way to look at it is, if we convert this to
> 
> devm_platform_get_and_ioremap_resource(pdev, 1, &res);
> 
> it seems to only write to res if platform_get_resource succeeds and
> otherwise doesn't care. The only real way to check if found is
> !IS_ERR().
> 
> Actually the more appropriate function here is
> devm_platform_ioremap_resource , which doesn't write to a struct
> resource.
> 

The resource 1 is optional, so devm_platform_ioremap_resource can't
be used here, otherwise the error will be returned if the resource 1
is not provided.

>>
>> --
>> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
>> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


