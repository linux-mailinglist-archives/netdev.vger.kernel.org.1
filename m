Return-Path: <netdev+bounces-117998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F946950371
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22F91F23B4B
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917F21940AB;
	Tue, 13 Aug 2024 11:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RynpPxkD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4252233A;
	Tue, 13 Aug 2024 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723547782; cv=none; b=ONdWHl5qiQbryjj7OOjIm4Inaz9xb0PwE+/XGxeqWcRl6hHOsLKNfyWSZaxSAC+S1XnFxnyYxBHPuJz604LZmlRdh3jz+VbIUnN/CJjQOgpjP0ssUmGDxQ9xaGov5AiReJCcOgYngQvT7M87PIoy2OyKaHhlBiVP/UX+AVhYwOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723547782; c=relaxed/simple;
	bh=0pvmmClk/9etW+oQMaKMGdyOe2h/CS2zyoTRmUUjXMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nf07HxPqFpGyxwIv/i6bW4OG4MwZAGLwc5gxReuUGMhdO7a/r4eQkCBIL6tO/80NVAlsynt1X4picupkW0KI5qGa1j0BoKturyHvRWpsqF5M0l7Zur81MY78DKTQ0Za7NQ4nSqFitPvHhRF1oR0k8zYr0G5hI+SwsGA2pM3PYpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RynpPxkD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D4CoEB017529;
	Tue, 13 Aug 2024 11:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b7deeTtD7MN0s6d3k9imGFJKKj1a50GFHv1bAjq2O+k=; b=RynpPxkDKg6Ew/gQ
	CXDHGTCy1KmwTCYpjy7Oy762AKqh/b3lrLfUimuGEos82+sSmyVFa88AmnHz6IVZ
	+TSPtaCA/d629ThRMhp+kYAKK1QdWzAcyylpzCd17HnrAk/51P0pmAfplGhRBFAh
	kFTfU3oO4jD/z1E6+3tfRtJ0ku0SVwC/P+WEdVr8Jep8xBuB6vQO3PYtf/aXfWJK
	EpDLG7ptOJB52qCIv6j336iusSAlP9N91uj2Iua2sZmI9BMdgwQpbT0ZzuPfvH6o
	1AHckS4qFYSQ2fp9ufeX9lAIT1iXwu7fNQWawDLKlhiGdPRpiXUuE89aHqdzBJhn
	xmwIuw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x1d4f7x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 11:15:38 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47DBFaLt021630
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 11:15:36 GMT
Received: from [10.253.34.30] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 Aug
 2024 04:15:32 -0700
Message-ID: <96268791-4c32-4390-97bd-758e6525bd11@quicinc.com>
Date: Tue, 13 Aug 2024 19:15:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] driver core: Introduce an API
 constify_device_find_child_helper()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Zijun Hu <zijun_hu@icloud.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
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
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Timur
 Tabi <timur@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux1394-devel@lists.sourceforge.net>,
        <netdev@vger.kernel.org>
References: <20240811-const_dfc_prepare-v1-0-d67cc416b3d3@quicinc.com>
 <20240811-const_dfc_prepare-v1-2-d67cc416b3d3@quicinc.com>
 <2024081314-marbling-clasp-442a@gregkh>
 <3f7e9969-5285-4dba-b16e-65c6b10ee89a@quicinc.com>
 <2024081311-mortality-opal-cf0f@gregkh>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2024081311-mortality-opal-cf0f@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wqksSs9F8-wVIYgx7ZbItk2RkXWeUniP
X-Proofpoint-GUID: wqksSs9F8-wVIYgx7ZbItk2RkXWeUniP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_03,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130080

On 8/13/2024 6:57 PM, Greg Kroah-Hartman wrote:
> On Tue, Aug 13, 2024 at 06:50:04PM +0800, quic_zijuhu wrote:
>> On 8/13/2024 5:45 PM, Greg Kroah-Hartman wrote:
>>> On Sun, Aug 11, 2024 at 08:18:08AM +0800, Zijun Hu wrote:
>>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>
>>>> Introduce constify_device_find_child_helper() to replace existing
>>>> device_find_child()'s usages whose match functions will modify
>>>> caller's match data.
>>>
>>> Ick, that's not a good name, it should be "noun_verb" with the subsystem being on the prefix always.
>>>
>> okay, got it.
>>
>> is it okay to use device_find_child_mut() suggested by Przemek Kitszel ?
> 
> No, just switch all callers over to be const and keep the same name.
> 
>>> But why is this even needed?  Device pointers are NOT const for the
>>> obvious reason that they can be changed by loads of different things.
>>> Trying to force them to be const is going to be hard, if not impossible.
>>>
>>
>> [PATCH 3/5] have more discussion about these questions with below link:
>> https://lore.kernel.org/all/8b8ce122-f16b-4207-b03b-f74b15756ae7@icloud.com/
>>
>>
>> The ultimate goal is to make device_find_child() have below prototype:
>>
>> struct device *device_find_child(struct device *dev, const void *data,
>> 		int (*match)(struct device *dev, const void *data));
>>
>> Why ?
>>
>> (1) It does not make sense, also does not need to, for such device
>> finding operation to modify caller's match data which is mainly
>> used for comparison.
>>
>> (2) It will make the API's match function parameter have the same
>> signature as all other APIs (bus|class|driver)_find_device().
>>
>>
>> My idea is that:
>> use device_find_child() for READ only accessing caller's match data.
>>
>> use below API if need to Modify caller's data as
>> constify_device_find_child_helper() does.
>> int device_for_each_child(struct device *dev, void *data,
>>                     int (*fn)(struct device *dev, void *data));
>>
>> So the The ultimate goal is to protect caller's *match data* @*data  NOT
>> device @*dev.
> 
> Ok, sorry, I was confused.
> 

Current prototype of the API:
struct device *device_find_child(struct device *dev, void *data,
                                 int (*match)(struct device *dev, void
*data));								

prototype we want:

struct device *device_find_child(struct device *dev, const void *data,
                                 int (*match)(struct device *dev, const
void *data));

The only differences are shown below:
void *data -> const void *data  // as argument of paramter @data of
(*match)().
int (*match)(struct device *dev, void *data) -> int (*match)(struct
device *dev, const void *data).

We don't change type of @dev. we just make above two parameters have the
same types as below existing finding APIs.

struct device *bus_find_device(const struct bus_type *bus, struct device
*start,
                               const void *data,
                               int (*match)(struct device *dev, const
void *data));
struct device *driver_find_device(const struct device_driver *drv,
                                  struct device *start, const void *data,
                                  int (*match)(struct device *dev, const
void *data));
struct device *class_find_device(const struct class *class, const struct
device *start,
                                 const void *data, int (*match)(struct
device *, const void *));
> thanks,
> 
> greg k-h


