Return-Path: <netdev+bounces-126789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2589F972796
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 05:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A8C91C219E1
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 03:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37FA13A40C;
	Tue, 10 Sep 2024 03:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XhQcwLfs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E2B22638;
	Tue, 10 Sep 2024 03:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725938276; cv=none; b=o4fvVObv8xBUXz8s/J8GIxtinuge5AGL8KaMUEz0JFkHoypLmncIjXqS/j6a0blDEN4VZitMQjvrkDujPlKdiA+qfGRbk/N6nVaKhdlb/lqLiuYJ3ozjSzJ+AhykR64wfFge+/KV0OMh5ctoIdhOPlTrYxgMUlN0boR2RFZfVd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725938276; c=relaxed/simple;
	bh=iUTxCdx07s5iDrT2eQFjApU0gtJkyIlv9BZ8+8ZZoN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X0ZJ5PG81SDd4TcHbY9EzkvaVj31K0QyOn1lmHr/DhO8AUvzW1uVGiCqo2ORZqYh6AIIjdPTzMQFmpfoMMLqu1aUI0zXJe7N1MW5L68nbg2B9kTXgT75IGziL9VPZCQQcCsH83QWaA3jLQZWvgY3wvlWXERYbspPuyAXLTgb4Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XhQcwLfs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489DRPkc019858;
	Tue, 10 Sep 2024 03:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AOTX1QFiEHYqHWitSH/dUa3C50p/+sMoor2mkiDwUqw=; b=XhQcwLfszd7fhrJ5
	rLiyDLagvkiwyJSJIN9zVHdXIXcrAwYA9mX0YL6wRa8hVbrf3JQZvdpIeV50OeI+
	A5Oz7e5pwlzi6IGjFatXLkTyzCEDn94B2URLm0/OX4HsOvaYD9eSiM8hJ71Lv/Di
	oZxpmzBEYz8JhRKg0v/LVkV05qGJpBZ442gMRPPV8OJk5+5SGvGSCIB0BFf4k/9H
	Afs7sg9q6IAlPoHn7uNygb7zHLE73fjIDAtsgsFvMMoljSdhIENJWpOPpQz2OAVY
	y5LrLsOH2FzFIS3nSipxaytS+wXBh1zuJyWEft6AfkXvTdaHroqLhUGDXn3kSVgj
	/1LU6g==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy59vnnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 03:17:30 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48A3HT5Q029954
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 03:17:29 GMT
Received: from [10.253.72.41] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 9 Sep 2024
 20:17:25 -0700
Message-ID: <a6dae308-ff34-4479-a638-8c12ff2e8d32@quicinc.com>
Date: Tue, 10 Sep 2024 11:17:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] cxl/region: Find free cxl decoder by
 device_for_each_child()
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 <66df52d15129a_2cba232943d@iweiny-mobl.notmuch>
 <66df9692e324d_ae21294ad@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <66df9692e324d_ae21294ad@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S4z4BPUg50j9G3eZ9MM6lx9cgVZrn11V
X-Proofpoint-ORIG-GUID: S4z4BPUg50j9G3eZ9MM6lx9cgVZrn11V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=825 phishscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409100023

On 9/10/2024 8:45 AM, Dan Williams wrote:
> Ira Weiny wrote:
> [..]
>>> This still feels more complex that I think it should be.  Why not just
>>> modify the needed device information after the device is found?  What
>>> exactly is being changed in the match_free_decoder that needs to keep
>>> "state"?  This feels odd.
>>
>> Agreed it is odd.
>>
>> How about adding?
> 
> I would prefer just dropping usage of device_find_ or device_for_each_
> with storing an array decoders in the port directly. The port already
> has arrays for dports , endpoints, and regions. Using the "device" APIs
> to iterate children was a bit lazy, and if the id is used as the array
> key then a direct lookup makes some cases simpler.

it seems Ira and Dan have corrected original logic to ensure
that all child decoders are sorted by ID in ascending order as shown
by below link.

https://lore.kernel.org/all/66df666ded3f7_3c80f229439@iweiny-mobl.notmuch/

based on above correction, as shown by my another exclusive fix
https://lore.kernel.org/all/20240905-fix_cxld-v2-1-51a520a709e4@quicinc.com/
there are a very simple change to solve the remaining original concern
that device_find_child() modifies caller's match data.

here is the simple change.

--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -797,23 +797,13 @@ static size_t show_targetN(struct cxl_region
*cxlr, char *buf, int pos)
 static int match_free_decoder(struct device *dev, void *data)
 {
        struct cxl_decoder *cxld;
-       int *id = data;

        if (!is_switch_decoder(dev))
                return 0;

        cxld = to_cxl_decoder(dev);

-       /* enforce ordered allocation */
-       if (cxld->id != *id)
-               return 0;
-
-       if (!cxld->region)
-               return 1;
-
-       (*id)++;
-
-       return 0;
+       return cxld->region ? 0 : 1;
 }

 static int match_auto_decoder(struct device *dev, void *data)
@@ -840,7 +830,6 @@ cxl_region_find_decoder(struct cxl_port *port,
                        struct cxl_region *cxlr)
 {
        struct device *dev;
-       int id = 0;

        if (port == cxled_to_port(cxled))
                return &cxled->cxld;
@@ -849,7 +838,7 @@ cxl_region_find_decoder(struct cxl_port *port,
                dev = device_find_child(&port->dev, &cxlr->params,
                                        match_auto_decoder);
        else
-               dev = device_find_child(&port->dev, &id,
match_free_decoder);
+               dev = device_find_child(&port->dev, NULL,
match_free_decoder);
        if (!dev)
                return NULL;



