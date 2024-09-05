Return-Path: <netdev+bounces-125464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8922796D27C
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83B61C224D2
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 08:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0B5194C62;
	Thu,  5 Sep 2024 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YL9rOZaB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAD8194A42;
	Thu,  5 Sep 2024 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725526289; cv=none; b=nWl785XZQL2rZtPH6sTf7DxooCsAerv1ZSqlXD9maxwoqnmFqPo1md8cRjQtbwhXHiQcXLlRqnaxQy+0AZkvpifB1GWANF7ZbhauvLJPd/cOrZDFhZVyrmkWVIDW4lMeopJ6P7xwvKRMLJf365PLUpQ/wNyDsBI6f1ZL4y11wwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725526289; c=relaxed/simple;
	bh=80/WkKy4+58WhxyVhe0GJYSeVYKLmPwl64dVAgD2T+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bBfCIMbgX9EgRYAKX/FKBZuqIfhzatTMb8K29kgPZ80rjytv6v692L1Xn2hfEgOz1vuXnu6atx/hgkdPsyfm/ganxFDYtvsYRTRkmOMWiWTS7oVE/77kFkfZZyMUD0wLbLC5czcZz8g7ZD6x5qGf34/BUWFolCntlJExfwuCkBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YL9rOZaB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4850VJva026179;
	Thu, 5 Sep 2024 08:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OEmwguPbSMR4OI/fouKPP2ZikTsz+zMzR7xDWEb6e2g=; b=YL9rOZaBpRfq8Ye0
	OM2yGdXE9f3rm8QnlTLEko1oT8qF7E08mDFvgf4gnLu8Vuqtz3y7s8l2b1WERtw7
	7zIxUnBdYkAvDyL9wH5wgi8ja9waRdY95o3/dIHiIofqudeVa53OGvKaDVxGJS9h
	htBbP31LU4u1N83RT+eMQL/wusrn1F2xGaiVJOMLkCTvpU6BcOBYsdCXw5vdLU8R
	ac/7I1I86EYbJCddA6jC/RWIZ2xiroSu9uCiexGMn2go1sSYJxbSgsNcmQaO5fh3
	+8nXhiiaHN2gHIUQYlCg6zdh+GBPU7o3AxFNoH21nDUWXLOUfBUH3B57LZHezyRY
	U9/NqQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bt675fcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 08:48:54 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4858mruc019913
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 08:48:53 GMT
Received: from [10.253.33.121] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Sep 2024
 01:48:50 -0700
Message-ID: <c95932bf-4d11-4952-8835-b212fdb490a7@quicinc.com>
Date: Thu, 5 Sep 2024 16:48:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] cxl/region: Find free cxl decoder by
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
 <20240905-const_dfc_prepare-v4-1-4180e1d5a244@quicinc.com>
 <2024090531-mustang-scheming-3066@gregkh>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2024090531-mustang-scheming-3066@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eFnkto18Mdva7Bh7Q04G4bjkLY1Iz_5P
X-Proofpoint-GUID: eFnkto18Mdva7Bh7Q04G4bjkLY1Iz_5P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_04,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409050064

On 9/5/2024 1:32 PM, Greg Kroah-Hartman wrote:
> On Thu, Sep 05, 2024 at 08:36:09AM +0800, Zijun Hu wrote:
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
>> caller's match data @*data, but match_free_decoder() as the old API's
>> match function indeed modifies relevant match data, so it is not suitable
>> for the new API any more, solved by using device_for_each_child() to
>> implement relevant finding free cxl decoder function.
>>
>> By the way, this commit does not change any existing logic.
>>
>> Suggested-by: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/cxl/core/region.c | 30 ++++++++++++++++++++++++------
>>  1 file changed, 24 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 21ad5f242875..c2068e90bf2f 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -794,10 +794,15 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>>  	return rc;
>>  }
>>  
>> +struct cxld_match_data {
>> +	int id;
>> +	struct device *target_device;
>> +};
>> +
>>  static int match_free_decoder(struct device *dev, void *data)
>>  {
>> +	struct cxld_match_data *match_data = data;
>>  	struct cxl_decoder *cxld;
>> -	int *id = data;
>>  
>>  	if (!is_switch_decoder(dev))
>>  		return 0;
>> @@ -805,17 +810,31 @@ static int match_free_decoder(struct device *dev, void *data)
>>  	cxld = to_cxl_decoder(dev);
>>  
>>  	/* enforce ordered allocation */
>> -	if (cxld->id != *id)
>> +	if (cxld->id != match_data->id)
>>  		return 0;
>>  
>> -	if (!cxld->region)
>> +	if (!cxld->region) {
>> +		match_data->target_device = get_device(dev);
> 
> Where is put_device() called?
>

it is called within cxl_region_find_decoder()

> Ah, it's on the drop later on after find_free_decoder(), right?

yes, it shares the same put_device() which is used for original
device_find_child().

> 
>>  		return 1;
>> +	}
>>  
>> -	(*id)++;
>> +	match_data->id++;
>>  
>>  	return 0;
>>  }
>>  
>> +/* NOTE: need to drop the reference with put_device() after use. */
>> +static struct device *find_free_decoder(struct device *parent)
>> +{
>> +	struct cxld_match_data match_data = {
>> +		.id = 0,
>> +		.target_device = NULL,
>> +	};
>> +
>> +	device_for_each_child(parent, &match_data, match_free_decoder);
>> +	return match_data.target_device;
>> +}
>> +
>>  static int match_auto_decoder(struct device *dev, void *data)
>>  {
>>  	struct cxl_region_params *p = data;
>> @@ -840,7 +859,6 @@ cxl_region_find_decoder(struct cxl_port *port,
>>  			struct cxl_region *cxlr)
>>  {
>>  	struct device *dev;
>> -	int id = 0;
>>  
>>  	if (port == cxled_to_port(cxled))
>>  		return &cxled->cxld;
>> @@ -849,7 +867,7 @@ cxl_region_find_decoder(struct cxl_port *port,
>>  		dev = device_find_child(&port->dev, &cxlr->params,
>>  					match_auto_decoder);
>>  	else
>> -		dev = device_find_child(&port->dev, &id, match_free_decoder);
>> +		dev = find_free_decoder(&port->dev);
> 
> This still feels more complex that I think it should be.  Why not just
> modify the needed device information after the device is found?  What
> exactly is being changed in the match_free_decoder that needs to keep
> "state"?  This feels odd.
> 

for match_auto_decoder() original logic, nothing of aim device is
modified, it just need to modifies state or @id to find the aim device.


> thanks,
> 
> greg k-h


