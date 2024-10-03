Return-Path: <netdev+bounces-131702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B6E98F4DB
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18CF0B22182
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB89D1A7265;
	Thu,  3 Oct 2024 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Gh175Lwm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D44519F46D;
	Thu,  3 Oct 2024 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727975417; cv=none; b=ar5RR5/fMt2RKKLmOwNuCqgoIcEs3YkpZYaS5uAZmSdGvBNU/gI8BTfY5XsQoHogaIWGvwykiCmrNyhEfiCdlcD2zsxR5B8cE/zXk7+4Wm6wvN06YwTz79ggfYAhG1qIPvXf2YqTyp3Bg3DNkcaRTo93zR1OMwElMfBzJJKg9f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727975417; c=relaxed/simple;
	bh=Sjv1xEVf/FAvhnc3fM3vWQWjKOsUsVCavyTXB+7oCJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FByaLXFhYi+WbE24kNFbjja12aAA5+gYDz2bmZkT9XXRLpCiWDZjz5iB1y4VLfs6/upt8rkBTRDjcoy7Waj99Dh6ZHIhuw6U7hQDk6qx01HXnJRR6X5S8khsXZQ/rskJJMFrueikCd7h5pjVoihllR9ik7LNeWb1vtEDjjYO4Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Gh175Lwm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4939P5K5009622;
	Thu, 3 Oct 2024 17:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y4hvU5P+woDSeTlahoTsEArwVfKIfXPFGF7CjwcCK4o=; b=Gh175LwmMPkkhWpT
	0wZWCriHrjnDNnoe9EOtfO/HsMPd/ySJgc07v8ALzpFmK8j9RGcRhC1EfUY26lap
	ghabPJehVEblu5Jx/qepz/ZPHPn3wJJhvtjEihUs0G8ljqeHt6VYGVzdr8jDxgbu
	Ln0dUjxFjtNPp5dwsOKv/EcPa/MnnASDvgDjfnsQDLmNjE1FP12AMMNEY3yTInum
	en9PBZF2269P75PC4g0aUZog+YYHjNdzMTRUjhks89/M6L7IhbAeweUoI/Il2UnU
	KSb90CCpQeBzR2ejlnBX6mD3XP15T+xo0adieuGNSCyUKOPLvDvliNS3b1I08dgJ
	T2Yvng==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xaymq273-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 17:09:22 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 493H9LXv008506
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 3 Oct 2024 17:09:21 GMT
Received: from [10.253.12.124] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 3 Oct 2024
 10:09:16 -0700
Message-ID: <9b45a39b-c747-4597-95cc-01c752328aea@quicinc.com>
Date: Fri, 4 Oct 2024 01:09:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RESEND v5] net: qcom/emac: Find sgmii_ops by
 device_for_each_child()
To: Paolo Abeni <pabeni@redhat.com>, Timur Tabi <timur@kernel.org>,
        "David S.
 Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zijun Hu
	<zijun_hu@icloud.com>
References: <20240930-qcom_emac_fix-v5-1-e59c0ddbc8b4@quicinc.com>
 <308126dc-1a5d-480c-b8a2-053f73865f86@redhat.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <308126dc-1a5d-480c-b8a2-053f73865f86@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8oWXDJjlz_Xzcn4jeJtO-jujaOeolFQj
X-Proofpoint-GUID: 8oWXDJjlz_Xzcn4jeJtO-jujaOeolFQj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxscore=0 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 mlxlogscore=911
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410030123

On 10/3/2024 9:39 PM, Paolo Abeni wrote:
>> @@ -356,10 +363,14 @@ int emac_sgmii_config(struct platform_device
>> *pdev, struct emac_adapter *adpt)
>>       int ret;
>>         if (has_acpi_companion(&pdev->dev)) {
>> +        struct emac_match_data match_data = {
>> +            .sgmii_ops = &phy->sgmii_ops,
>> +            .target_device = NULL,
>> +        };
>>           struct device *dev;
>>   -        dev = device_find_child(&pdev->dev, &phy->sgmii_ops,
>> -                    emac_sgmii_acpi_match);
>> +        device_for_each_child(&pdev->dev, &match_data,
>> emac_sgmii_acpi_match);
>> +        dev = match_data.target_device;
>>             if (!dev) {
>>               dev_warn(&pdev->dev, "cannot find internal phy node\n");
> 
> 
> I'm sorry for the late feedback. I agree with Greg, I think it would
> more clear removing the get_device() from the match function and add it
> here, after the 'if (!dev) {' statement.
> 

Thank you for helping me understand those good suggestions.
will correct it within next revision.

> Thanks,
> 
> Paolo


