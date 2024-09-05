Return-Path: <netdev+bounces-125467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D632196D2CF
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 11:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929862833A5
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 09:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF0D19258A;
	Thu,  5 Sep 2024 09:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jPVfYtHX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D058F66;
	Thu,  5 Sep 2024 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527410; cv=none; b=CHF95UsS9UrEP/AoWD9Akr4uJhAjHFvGzOE5Hi8CNb8hTuP/Tr1OtUiaKOjzIpBR1OxJsStLFyWuV+qtUUHZ9+Nf16IgE/JDxP3qAANkMJetauCe849Nq0CtTC/z3UoYf23FZiP8o8QntOdjrCBWzOt0wDbe/Dm0uoSPiJL0Hro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527410; c=relaxed/simple;
	bh=4NtntbVRtNy24ist+ijLY7xWZ3UYBIIHIQU+etJbVTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QIRJ1YHc9oEfoBsvshxS943OndEMC1brZoqp3uIijWrntZGuWQ3BNqhOaHzfeDO1pwOPpuFqVtyamPzYzC34HEmLcXiDxAC4EZZhxT7VBMt+TA5QXooh/8Iw3eEQrkUlpUR3jA6I6L2SIc3Eo7lqErRSTaMQ8wM+m0rboPJlRAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jPVfYtHX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48596ubs001482;
	Thu, 5 Sep 2024 09:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wPwJp2fyLqlQ/lBeuaA4xALfiX2USm3cuiazcj0NQwg=; b=jPVfYtHXElTHDrIv
	TxfVN+mG5xuS4pyfW78BeFh81klBNcroUM2OnSQ2xfY3mc2SOzlFPPnMzrwOSGoa
	5v2vaxjLQ6Sq/j1ePiqeHVJ283otrNmb+EIJfiZyQBTt50R+eMefFcYqOcwpQyjP
	es0+GDvd881/lk5HX375+EINJ8AWPMzSWN9ZsvgTXU4wgG0+KPI2fhdE/9MuESdA
	c7YYttmvtIrgeVHS5qBEiAy9nHtHuXzUJ7wI3RaDvOTI7oEyLU8rNVM8HGATi8Bg
	81eH5GZ8WXFhpivaGy5RbnvTX/YAFh2m3ztds1d2oD/XSfptfHxC3Yi3XLSf+98J
	KmiqXQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41dxy26tha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 09:09:49 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48599nHS032594
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 09:09:49 GMT
Received: from [10.253.33.121] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Sep 2024
 02:09:45 -0700
Message-ID: <58106753-389a-42a1-88df-0cf006b2faac@quicinc.com>
Date: Thu, 5 Sep 2024 17:09:43 +0800
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
 <2024090548-riverbank-resemble-6590@gregkh>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2024090548-riverbank-resemble-6590@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: z2_O7lNyZQX-gDUywCeyy-0K9EPrpBls
X-Proofpoint-ORIG-GUID: z2_O7lNyZQX-gDUywCeyy-0K9EPrpBls
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_04,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409050067

On 9/5/2024 1:33 PM, Greg Kroah-Hartman wrote:
> On Thu, Sep 05, 2024 at 07:29:10AM +0200, Greg Kroah-Hartman wrote:
>> On Thu, Sep 05, 2024 at 08:36:10AM +0800, Zijun Hu wrote:
>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>>
>>> To prepare for constifying the following old driver core API:
>>>
>>> struct device *device_find_child(struct device *dev, void *data,
>>> 		int (*match)(struct device *dev, void *data));
>>> to new:
>>> struct device *device_find_child(struct device *dev, const void *data,
>>> 		int (*match)(struct device *dev, const void *data));
>>>
>>> The new API does not allow its match function (*match)() to modify
>>> caller's match data @*data, but emac_sgmii_acpi_match() as the old
>>> API's match function indeed modifies relevant match data, so it is not
>>> suitable for the new API any more, solved by using device_for_each_child()
>>> to implement relevant finding sgmii_ops function.
>>>
>>> By the way, this commit does not change any existing logic.
>>>
>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>> ---
>>>  drivers/net/ethernet/qualcomm/emac/emac-sgmii.c | 22 +++++++++++++++++-----
>>>  1 file changed, 17 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
>>> index e4bc18009d08..29392c63d115 100644
>>> --- a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
>>> +++ b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
>>> @@ -293,6 +293,11 @@ static struct sgmii_ops qdf2400_ops = {
>>>  };
>>>  #endif
>>>  
>>> +struct emac_match_data {
>>> +	struct sgmii_ops **sgmii_ops;
>>> +	struct device *target_device;
>>> +};
>>> +
>>>  static int emac_sgmii_acpi_match(struct device *dev, void *data)
>>>  {
>>>  #ifdef CONFIG_ACPI
>>> @@ -303,7 +308,7 @@ static int emac_sgmii_acpi_match(struct device *dev, void *data)
>>>  		{}
>>>  	};
>>>  	const struct acpi_device_id *id = acpi_match_device(match_table, dev);
>>> -	struct sgmii_ops **ops = data;
>>> +	struct emac_match_data *match_data = data;
>>>  
>>>  	if (id) {
>>>  		acpi_handle handle = ACPI_HANDLE(dev);
>>> @@ -324,10 +329,12 @@ static int emac_sgmii_acpi_match(struct device *dev, void *data)
>>>  
>>>  		switch (hrv) {
>>>  		case 1:
>>> -			*ops = &qdf2432_ops;
>>> +			*match_data->sgmii_ops = &qdf2432_ops;
>>> +			match_data->target_device = get_device(dev);
>>>  			return 1;
>>>  		case 2:
>>> -			*ops = &qdf2400_ops;
>>> +			*match_data->sgmii_ops = &qdf2400_ops;
>>> +			match_data->target_device = get_device(dev);
>>
>> Where is put_device() now called?
> 
> Nevermind, I see it now.
> 
> That being said, this feels wrong still, why not just do this "set up
> the ops" logic _after_ you find the device and not here in the match
> function?
> 

that will become more complex since

1) it need to change match_data->sgmii_ops type from struct sgmii_ops **
to struct sgmii_ops * which is not same as type of original @data

2) it also needs to implement a extra finding function find_xyz()
similar as cxl/region find_free_decoder()

3) it need to extra condition assignment after find aim device.


actually, this scenario is a bit different with cxl/region as shown below:
for cxl/region, we only need to get aim device
for this scenario, we need to get both aim device and relevant sgmii_ops

> thanks,
> 
> greg k-h


