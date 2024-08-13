Return-Path: <netdev+bounces-117991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAF1950313
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 12:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185C01F21DA4
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 10:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CB619AD4F;
	Tue, 13 Aug 2024 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Et9rKDfQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FA819AA58;
	Tue, 13 Aug 2024 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546567; cv=none; b=iPUKsvNjFqwztL593TVs2XGwyxVP7ZIXL8iBVPagBmEtbEZdRm7UanL7AmEpcDerXgoAvvKY28HNSTUvlqWbHdM92P/fWlZNKcgS6QfKLRSeGOp26+ahMTgy597C8Lj6UDmOlMS0U8XaYhl+EEd450ABf9+jAXAhN3Ewbmu7dEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546567; c=relaxed/simple;
	bh=KSgLvCgukm7SuRr8aIh2efSvJWw2ykWte/os8g56hB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JencHeUbqOka9xQ12cTEaQqxVpMLkCrLqdA3R6Ky1J2Lpfz11bTKKsGHrbowa68OJSSrNqSfZzyKVCUo12sspfmwGqX3N0FIYCrBHmiB/MmoN0Ffg/lAjtOR01AHGzGK21jBWgM48LA/d0GXZ0U38XYeCp/n3CG3/CPt3i48WOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Et9rKDfQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D9abWb031286;
	Tue, 13 Aug 2024 10:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WhlZuS6gpJmDBfj7tUVk06rz347a2fbx1nf1hh7blm4=; b=Et9rKDfQSSidGydp
	cuoi0XNprRrzTHf+Jczq4U1SRuoncOaYZMD9Pak6MyQblYfqwv+0bA9wgq5jTlaK
	swWwUsZMvlps3EUVx02KLf9701hH6dFpnEeQ5A7rM/IjMeznH8lyUdCWV+FXLZ/i
	bQ3uLVdZWd4tI64Z2v8jYs4257v4WHqoBLSRwEIgjYRMlRHtQb2Ue8FUxrutXuAu
	KmjOXFu7uejJ4kQJfzioyWpHPpTHmZMTEhKkWugatAkjZTcWO5sDy+oued2ZW/q1
	YQRwUe8OwYahzI0Fq4ENwvaJx9iCbiUNkU5HA2DrDNVmZjwT8bDE2vMShn7fGVTh
	RTL+nA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x15e79fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 10:50:25 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47DAoBqU013789
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 10:50:11 GMT
Received: from [10.253.34.30] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 Aug
 2024 03:50:07 -0700
Message-ID: <3f7e9969-5285-4dba-b16e-65c6b10ee89a@quicinc.com>
Date: Tue, 13 Aug 2024 18:50:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] driver core: Introduce an API
 constify_device_find_child_helper()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zijun Hu
	<zijun_hu@icloud.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
        Davidlohr Bueso
	<dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave
 Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan
 Williams <dan.j.williams@intel.com>,
        Takashi Sakamoto
	<o-takashi@sakamocchi.jp>,
        Timur Tabi <timur@kernel.org>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux1394-devel@lists.sourceforge.net>,
        <netdev@vger.kernel.org>
References: <20240811-const_dfc_prepare-v1-0-d67cc416b3d3@quicinc.com>
 <20240811-const_dfc_prepare-v1-2-d67cc416b3d3@quicinc.com>
 <2024081314-marbling-clasp-442a@gregkh>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2024081314-marbling-clasp-442a@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BwLEZ1fydPE7qZsoyL-lqd11wCChzbl4
X-Proofpoint-ORIG-GUID: BwLEZ1fydPE7qZsoyL-lqd11wCChzbl4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_02,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130078

On 8/13/2024 5:45 PM, Greg Kroah-Hartman wrote:
> On Sun, Aug 11, 2024 at 08:18:08AM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> Introduce constify_device_find_child_helper() to replace existing
>> device_find_child()'s usages whose match functions will modify
>> caller's match data.
> 
> Ick, that's not a good name, it should be "noun_verb" with the subsystem being on the prefix always.
> 
okay, got it.

is it okay to use device_find_child_mut() suggested by Przemek Kitszel ?

> But why is this even needed?  Device pointers are NOT const for the
> obvious reason that they can be changed by loads of different things.
> Trying to force them to be const is going to be hard, if not impossible.
> 

[PATCH 3/5] have more discussion about these questions with below link:
https://lore.kernel.org/all/8b8ce122-f16b-4207-b03b-f74b15756ae7@icloud.com/


The ultimate goal is to make device_find_child() have below prototype:

struct device *device_find_child(struct device *dev, const void *data,
		int (*match)(struct device *dev, const void *data));

Why ?

(1) It does not make sense, also does not need to, for such device
finding operation to modify caller's match data which is mainly
used for comparison.

(2) It will make the API's match function parameter have the same
signature as all other APIs (bus|class|driver)_find_device().


My idea is that:
use device_find_child() for READ only accessing caller's match data.

use below API if need to Modify caller's data as
constify_device_find_child_helper() does.
int device_for_each_child(struct device *dev, void *data,
                    int (*fn)(struct device *dev, void *data));

So the The ultimate goal is to protect caller's *match data* @*data  NOT
device @*dev.

> thanks,
> 
> greg k-h


