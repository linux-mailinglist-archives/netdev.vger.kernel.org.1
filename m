Return-Path: <netdev+bounces-145788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A589D0E76
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 11:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592C31F22598
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 10:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F43484A4E;
	Mon, 18 Nov 2024 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QGRQZkb+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5EF25760;
	Mon, 18 Nov 2024 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925612; cv=none; b=AEIbIq13shhZfLQBkeMe/7v2ebaOqYGAzXaaLbNxuNvOAun2XTNb5qprZ/QQmT+IRTiaF6WgtIVyQCW7bXiEhql4eSHiRcxhcDFyj6+MMFcZsTRCnEHU0HaOcKsP65p0DE0oz92B24aoOteQrzmla7o+G7SkOm+ReP3MhyWqH68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925612; c=relaxed/simple;
	bh=LWZvSbmjhtb9PIfHH6jroAsSYkECJDQu4NnYqPno9I0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PfTXsDWmYEqO/iGG3J7S+bs2FZS40P4uu8uEqgLdbQcYXSYEUb+zuG7JtloBvoLwmeIR6vGl+sb9wKdOSAF47yIucjETM/Z0w9DhSuzaB+U9ldX9TantNV6Fw7i9jdU0MGM0wpkWzGip83evVJi+EwIIW5pq64dkslxbWYAwEak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QGRQZkb+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI5RkI6020353;
	Mon, 18 Nov 2024 10:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tFoF13E01L7YOnf/WRspLN3v9ApYLBkTTeLNxNlciGg=; b=QGRQZkb+Ska8IUh8
	M8/BM3qM+U6PvlxmYna0yDqIe/vF33Ep4SqtSzr6WCEyD3TLxt4PXmvitP0tlWWR
	l46hR9sXwDZt5OspzS1hNAcXybnrg6MLzU+L0ur1+/dy3UmU+8FPCYGfvTkJJi+q
	LpOG8cIUINAyxp6yaJvy1oTAqX9uHykURKUifMPA9zm3ISBmBO+Qv85ZrTOxo6Qk
	Oqf+IAZvoBtwScCc6nyuoKMpzfuuLRQFhiFSJT5UsscuUUEDm/dE3uErBViDG7S1
	dtw5AH4e0xeMvMDicjLPU66ANHwRn9noT0mJjbe6GyKY6P+emTQmJsSl2PkfEuZR
	69qD/A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42xksqm7p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 10:26:33 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AIAQWgk004188
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 10:26:32 GMT
Received: from [10.253.72.205] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 18 Nov
 2024 02:26:29 -0800
Message-ID: <5562cf54-d1bd-4235-b232-33f5cca40b85@quicinc.com>
Date: Mon, 18 Nov 2024 18:26:27 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: mdio-ipq4019: fix wrong NULL check
To: Rosen Penev <rosenp@gmail.com>, <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        open list
	<linux-kernel@vger.kernel.org>
References: <20241117212827.13763-1-rosenp@gmail.com>
Content-Language: en-US
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <20241117212827.13763-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: haAI17kODBlh_BRp5Yvm_vOH09g8Ie4m
X-Proofpoint-ORIG-GUID: haAI17kODBlh_BRp5Yvm_vOH09g8Ie4m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411180086



On 11/18/2024 5:28 AM, Rosen Penev wrote:
> devm_ioremap_resource returns a PTR_ERR when it fails, not NULL. OTOH
> this is conditionally set to either a PTR_ERR or a valid pointer. Use
> !IS_ERR_OR_NULL to check if we can use this.
> 
> Fixes: 23a890d493 ("net: mdio: Add the reset function for IPQ MDIO driver")
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/net/mdio/mdio-ipq4019.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
> index dd3ed2d6430b..859302b0d38c 100644
> --- a/drivers/net/mdio/mdio-ipq4019.c
> +++ b/drivers/net/mdio/mdio-ipq4019.c
> @@ -256,7 +256,7 @@ static int ipq_mdio_reset(struct mii_bus *bus)
>   	/* To indicate CMN_PLL that ethernet_ldo has been ready if platform resource 1
>   	 * is specified in the device tree.
>   	 */
> -	if (priv->eth_ldo_rdy) {
> +	if (!IS_ERR_OR_NULL(priv->eth_ldo_rdy)) {
>   		val = readl(priv->eth_ldo_rdy);
>   		val |= BIT(0);
>   		writel(val, priv->eth_ldo_rdy);

Reviewed-by: Luo Jie <quic_luoj@quicinc.com>

Thanks,
Jie

