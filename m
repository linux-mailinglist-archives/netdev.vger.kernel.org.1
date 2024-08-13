Return-Path: <netdev+bounces-117969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4B49501D9
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 12:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9C21C21E69
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 10:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD6313BADF;
	Tue, 13 Aug 2024 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AvChRrV/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BDE19470;
	Tue, 13 Aug 2024 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543279; cv=none; b=m+38gWKTuhICrVdRzUYF8/MECQzk1yciBNLi+NqjbGIvD4pVM/NNq0w8HOvQSLPdAwFtJY9c4KlaFK8L+FcgIlIjWZkmdg2LKI+87uVBdCwR2naoUW7aqFJv+oUs0pL1DQVp4Pym8+CD0DsAujm1ud9ZkIiof4IDtkeF1IWSelc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543279; c=relaxed/simple;
	bh=Z1oVe7T8LHuIdU/LiTOlXSqGr4WUrp3gsiY+G3UVEGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OVggngoVAkBcM70k49TRbAyLFaENwguoGyaM84KuTOAAJgpKoGvPSSPFz8M8TNg8ojC4iZU6icrkTXV4jsKbanbPwU9eFkyRdXGLMrvvFpIMXegzV9aD+oKjSC3EnXgIPZnPbZOyOnO+DY01L/J1ZaSFhvIbGbc7p0ssYquk2Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AvChRrV/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D8MOWR004626;
	Tue, 13 Aug 2024 10:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VsvtXm/v428aOkoWR84mCKI/dm4EvDwjowuajS7NOkc=; b=AvChRrV/+7aOZ4QR
	32J2jiBV4MF01U/GiZyaFMvtn88xdh1QgVyP2VaTgco9m3QncMtKuopuWcLi98JI
	VIxaKdOLUm0GIZAp2vS54gTedHQCFJB4n20u7MrP9Cx/QJ7DJnJdEyw3kU4JTzMB
	zmU5d7R+gFPDRePhgPULVlxxh5jRGR2voC9t7IGCCz1iUAydlDSw369zk8nK69GA
	qTyqh0tAubBkD6ttM54jANm5nGMJxo7OUjI3K1FvymbvAHLrd5e+XwKNCd4J28E7
	cjGXv1l17o+62hg37X30pxup9XpCdrf9zWjXclG3NhkAekJURh26F4C1YI4WTVoh
	2MTq+w==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4103ws09ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 10:00:38 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47DA0bMm014849
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 10:00:37 GMT
Received: from [10.253.34.30] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 Aug
 2024 03:00:32 -0700
Message-ID: <4f4095a7-2fd1-48df-b3c9-cdb9f7da0e79@quicinc.com>
Date: Tue, 13 Aug 2024 18:00:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] driver core: Add simple parameter checks for APIs
 device_(for_each|find)_child()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
        <netdev@vger.kernel.org>, Zijun Hu
	<zijun_hu@icloud.com>
References: <20240811-const_dfc_prepare-v1-0-d67cc416b3d3@quicinc.com>
 <20240811-const_dfc_prepare-v1-1-d67cc416b3d3@quicinc.com>
 <2024081328-blanching-deduce-5cee@gregkh>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2024081328-blanching-deduce-5cee@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QGwAKjM9GrkdGWPWKYU_bqjwKEOf2Hz8
X-Proofpoint-ORIG-GUID: QGwAKjM9GrkdGWPWKYU_bqjwKEOf2Hz8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_02,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=807 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130071

On 8/13/2024 5:44 PM, Greg Kroah-Hartman wrote:
> On Sun, Aug 11, 2024 at 08:18:07AM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> Add simple parameter checks for APIs device_(for_each|find)_child() and
>> device_for_each_child_reverse().
> 
> Ok, but why?  Who is calling this with NULL as a parent pointer?
> 
> Remember, changelog text describes _why_ not just _what_ you are doing.
> 

For question why ?

The main purpose of this change is to make these APIs have *CONSISTENT*
parameter checking (!parent || !parent->p)

currently, 2 of them have checking (!parent->p), the other have checking
(!parent), the are INCONSISTENT.


For question who ?
device_find_child() have had such checking (!parent), that maybe mean
original author has concern that parent may be NULL.

Moreover, these are core driver APIs, it is worthy checking input
parameter strictly.


will correct commit message with v2.

> thanks,
> 
> greg k-h


