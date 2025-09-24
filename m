Return-Path: <netdev+bounces-226022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3521DB9AEAB
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 18:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B0AD7A1ABC
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 16:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8EB313522;
	Wed, 24 Sep 2025 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FFJtn1To"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F12313545;
	Wed, 24 Sep 2025 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758732601; cv=none; b=NuXdcHmp0WkJlqg+zPbtPE6By674oG/d3E79zLKkYpRXBGX+LvfiqbmIPhkW9A0yhHqohLsi575rIdnuVUpcVfP/WNy8ar+Y0A6LnJUbazMhLeuv93FCH4c1FmnZn1xorMIa8nJF0WGknH+Heurd1upuJ+x+OAgxUjUqxMn98uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758732601; c=relaxed/simple;
	bh=7Lyty3eSS3v2XcMQmmN8XPr/4x8fIWolfrzPFMBQiTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4F40OHxT6xvmroTxrDa+gaRtsias1usHc7FXOVAtL5aKEfimbvc5A2D4cU7NZbItMvkOEJzqn9DV0pQtZZu+0SZ586IfLPZeSnXvTla2gSWmCQ8xsh+4hwW0crPd/PCcOrSfLg8EWZdzTSD36YEDH5pzpmPz7hszHfjGwAGI4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FFJtn1To; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OGDDHS023754;
	Wed, 24 Sep 2025 16:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oJepJD
	alpCjrUn6GNqQSp8g9NaMeJS/cdDEkwUGlS6g=; b=FFJtn1ToPw2Nij5TGmBuiL
	S7oCeAPUD3jAmexqsq1tbFyKrmpxv13bJjvGR3RUdRKqyvnouxs2cVOSyuT22TwY
	whSRqAQrgms2tUSvA4vDmIW7zdlKlA/BnkbaaIhdiHEXzpaiHJSsoezcCBr0iiD5
	G0io+BOi3GLpkrLtoDDYS1JM4sG2/76aDsgi+Ongc9hp7v9fXazwfX/YbuZt42Rm
	mJj9wriyusRGclnlhs7ic9y8NCUB/BG9+OjfMJ60XJLwR07pBIvKTVpywOk97fKI
	ywNP9HI18owRUP+qpQd08uQAqy6tvldNCf/39XLAibj714Rpbm90svcGyyTilXoA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0jrnwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 16:49:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58OESO2O030359;
	Wed, 24 Sep 2025 16:49:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a19b6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 16:49:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58OGnrLL50200882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 16:49:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64F1320043;
	Wed, 24 Sep 2025 16:49:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36A0520040;
	Wed, 24 Sep 2025 16:49:53 +0000 (GMT)
Received: from [9.111.167.228] (unknown [9.111.167.228])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Sep 2025 16:49:53 +0000 (GMT)
Message-ID: <9d48c84b-c686-4d79-9b56-ede551ad62fc@linux.ibm.com>
Date: Wed, 24 Sep 2025 18:49:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dibs: Check correct variable in dibs_init()
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Julian Ruess <julianr@linux.ibm.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <aNP-XcrjSUjZAu4a@stanley.mountain>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <aNP-XcrjSUjZAu4a@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX6MnrO8gJCZ9A
 oyDW5NSYJX3p0W9c3MZN6uJAgg1ruGW74H5qNjcoQbVpZ2lQj6iJCaQBAqw1ZpyN/HHrdJPVifL
 xMCOclesw3cGoRJk+orBY7AHNJ7mYSLkvyHX0wjYKpK6Pc+xz+8xDH4L9rmpREb49SejiwX+KX1
 UJHaCSkg3KNXZL5XJc78rlKfl/USY1C9f/yV0Lwl2UHZw9xzkmO5D5De64zuob3L2mkLOTSWm2f
 DVM7yOC8zbsYXmIIN+Ik9LvZeaOmg95LwsargxiH9pgM0iaZTGtKLL5INHxjpCz48GZv4J73ELk
 uaPhX50LUzmvQZS32+WUDm70aXxJUlYtGJM0rNSa8BCL1VaZTV3lPzlIazxOFVjZH9zv0wYFgt4
 Z2xnBRzF
X-Authority-Analysis: v=2.4 cv=TOlFS0la c=1 sm=1 tr=0 ts=68d42134 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=rf5vUxhh8_kBZuwVy0UA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ALSaE6D4M1XY-QmlI867w0uHYMOe_2-A
X-Proofpoint-GUID: ALSaE6D4M1XY-QmlI867w0uHYMOe_2-A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033



On 24.09.25 16:21, Dan Carpenter wrote:
> There is a typo in this code.  It should check "dibs_class" instead of
> "&dibs_class".  Remove the &.
> 
> Fixes: 804737349813 ("dibs: Create class dibs")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/dibs/dibs_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
> index 5425238d5a42..0374f8350ff7 100644
> --- a/drivers/dibs/dibs_main.c
> +++ b/drivers/dibs/dibs_main.c
> @@ -258,8 +258,8 @@ static int __init dibs_init(void)
>  	max_client = 0;
>  
>  	dibs_class = class_create("dibs");
> -	if (IS_ERR(&dibs_class))
> -		return PTR_ERR(&dibs_class);
> +	if (IS_ERR(dibs_class))
> +		return PTR_ERR(dibs_class);
>  
>  	rc = dibs_loopback_init();
>  	if (rc)

oops, this has been wrong since the first RFC in february.
Great catch, thank you Dan.

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>


