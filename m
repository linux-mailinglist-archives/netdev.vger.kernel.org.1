Return-Path: <netdev+bounces-125457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7C596D226
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C35CCB26CB9
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 08:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944011898F4;
	Thu,  5 Sep 2024 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Cnt9xcnS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF461487C0;
	Thu,  5 Sep 2024 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525060; cv=none; b=LIO16RSv5D+pJI7VFyhjCus2h0Ra+0nQXGv/pT0I8Qgd2L+1Dp2sET1Ub5iRklMR4LyAKaYUw1gHibW3Oh5GWad9Xw94m+blDVSoFrsDsNp/Tpy+LrMHZCAULxjd1uUtoW9IFQbxzp9d9TUUh3IH3+wQ1afDdpklfDYwvumxi6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525060; c=relaxed/simple;
	bh=GFQmAJ7LwBgXiX4oLPkVCZiWRzkgbAjLiWlilInxWiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dD/zcpQdxvMRC2sY7wR23ao8wVhCnm2z/s06ZprW2YB27KDZYaFapj8Goj6hdZ6kTJ+NdrmBlYnEXTNNCerciKDz5wzSHeLT9MihkdpVTckVOuRrwb7HQjMkwWe0d8pRqTFaYQaifUwPsb1zBo1sFJ7Tw//CYmK0AjJdLzcgPcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Cnt9xcnS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4857Bdbj019949;
	Thu, 5 Sep 2024 08:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p/Arojuv+aZUW1CzwI7eUyI52+jLShITOwGwze5uAPg=; b=Cnt9xcnS6aWsgPJy
	EgAXaK+fPYVReRghNh9Y6XLQEGbsHf/WpII9sEp8JADosXX9mo4cGrduOWmgIaeO
	6nCYBRgfcZmSN+8yVcLPbIork76tmRVZZ62xBl815s2JjQASVpILiUCOXcJGaBQL
	ctiLqa90Zj+Y8QN+1HiMYtwD6PtWU8+bQYUfR7FSLGDnZu6npEDMZ8DNTAoFsrig
	WjVS7Z7RXoC5BevoftpUu3PA6yPhpV76XnxtiKzw7fIkdASNuCqAxKrjXAYw1U5j
	lm2ZcaVAhUne36hkl2d4DnJ36rbYg6pOak7pVUW/BCXHmT3ioAqzLDmcVqe20u9c
	yM7zlw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41dxy26q6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 08:30:40 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4858Udsc010546
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 08:30:39 GMT
Received: from [10.253.33.121] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Sep 2024
 01:30:36 -0700
Message-ID: <1f5d984b-4182-4350-a4b6-a3c42bad88e6@quicinc.com>
Date: Thu, 5 Sep 2024 16:29:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] net: qcom/emac: Find sgmii_ops by
 device_for_each_child()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zijun Hu
	<zijun_hu@icloud.com>
CC: Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron
	<jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison
 Schofield <alison.schofield@intel.com>,
        Vishal Verma
	<vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams
	<dan.j.williams@intel.com>,
        Timur Tabi <timur@kernel.org>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com>
 <20240905-const_dfc_prepare-v4-2-4180e1d5a244@quicinc.com>
 <2024090521-finch-skinny-69bc@gregkh>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2024090521-finch-skinny-69bc@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cvOnQiV6Vq0n_znsn2VGexopBsiXkt4y
X-Proofpoint-ORIG-GUID: cvOnQiV6Vq0n_znsn2VGexopBsiXkt4y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_04,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409050061

On 9/5/2024 1:29 PM, Greg Kroah-Hartman wrote:
> On Thu, Sep 05, 2024 at 08:36:10AM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> To prepare for constifying the following old driver core API:
>>
>> struct device *device_find_child(struct device *dev, void *data,
>> 		int (*match)(struct device *dev, void *data));
>> to new:
>> struct device *device_find_child(struct device *dev, const void *data,
>> 		int (*match)(struct device *dev, const void *data));
>>
>> The new API does not allow its match function (*match)() to modify
>> caller's match data @*data, but emac_sgmii_acpi_match() as the old
>> API's match function indeed modifies relevant match data, so it is not
>> suitable for the new API any more, solved by using device_for_each_child()
>> to implement relevant finding sgmii_ops function.
>>
>> By the way, this commit does not change any existing logic.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/net/ethernet/qualcomm/emac/emac-sgmii.c | 22 +++++++++++++++++-----
>>  1 file changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
>> index e4bc18009d08..29392c63d115 100644
>> --- a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
>> +++ b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
>> @@ -293,6 +293,11 @@ static struct sgmii_ops qdf2400_ops = {
>>  };
>>  #endif
>>  
>> +struct emac_match_data {
>> +	struct sgmii_ops **sgmii_ops;
>> +	struct device *target_device;
>> +};
>> +
>>  static int emac_sgmii_acpi_match(struct device *dev, void *data)
>>  {
>>  #ifdef CONFIG_ACPI
>> @@ -303,7 +308,7 @@ static int emac_sgmii_acpi_match(struct device *dev, void *data)
>>  		{}
>>  	};
>>  	const struct acpi_device_id *id = acpi_match_device(match_table, dev);
>> -	struct sgmii_ops **ops = data;
>> +	struct emac_match_data *match_data = data;
>>  
>>  	if (id) {
>>  		acpi_handle handle = ACPI_HANDLE(dev);
>> @@ -324,10 +329,12 @@ static int emac_sgmii_acpi_match(struct device *dev, void *data)
>>  
>>  		switch (hrv) {
>>  		case 1:
>> -			*ops = &qdf2432_ops;
>> +			*match_data->sgmii_ops = &qdf2432_ops;
>> +			match_data->target_device = get_device(dev);
>>  			return 1;
>>  		case 2:
>> -			*ops = &qdf2400_ops;
>> +			*match_data->sgmii_ops = &qdf2400_ops;
>> +			match_data->target_device = get_device(dev);
> 
> Where is put_device() now called?
> 
>>  			return 1;
>>  		}
>>  	}
>> @@ -356,10 +363,15 @@ int emac_sgmii_config(struct platform_device *pdev, struct emac_adapter *adpt)
>>  	int ret;
>>  
>>  	if (has_acpi_companion(&pdev->dev)) {
>> +		struct emac_match_data match_data = {
>> +			.sgmii_ops = &phy->sgmii_ops,
>> +			.target_device = NULL,
>> +		};
>>  		struct device *dev;
>>  
>> -		dev = device_find_child(&pdev->dev, &phy->sgmii_ops,
>> -					emac_sgmii_acpi_match);
>> +		device_for_each_child(&pdev->dev, &match_data, emac_sgmii_acpi_match);
>> +		/* Need to put_device(@dev) after use */
>> +		dev = match_data.target_device;
> 
> 
> Why this new comment?  That's always required and happens down below in
> the function, right?  Otherwise, what changed?
> 

device_find_child() will get_device() by itself and that is obvious.

device_for_each_child() will not get_device() by itself, we get_device()
in its function parameter to make it equivalent with device_find_child()
this get_device() is not obvious, so add the inline comments to prompt
user put_device after use.

yes, and the relevant put_device() don't happen immediately.

> thanks,
> 
> greg k-h


