Return-Path: <netdev+bounces-55780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8D580C4DD
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 10:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7361C20BF4
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 09:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9979D21376;
	Mon, 11 Dec 2023 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F5KzC8Xy"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C90D100;
	Mon, 11 Dec 2023 01:39:59 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BB9OqNI008425;
	Mon, 11 Dec 2023 09:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ywIf2KGWfBHKjuhzBAKTlUyPLlWU2PWCzpA1N58A1Ag=;
 b=F5KzC8XycHJb7mr+pbU3dmfuP1NiZOicIvL7MZ9W9CbMjUH4uhl9Cgddb1f8pRicRIV1
 61GXqJ3zFrGs9S1rvyexwZ8V50S5Br+HK6L4gduiugcCTmoaYpofUBh+HI062Ck+St+h
 lENaaTGN0V9PoeDK2iKYjLUH8FvAmSBw7vcjncxv5UHSDpB/ZbOn/F0wu0d0fw/0xcso
 FVciyqqIXjeRAV+wEsTo3WNsUWX+oTo+BtHMenoeejAyYs4M7h9/fQSpl/sHLq7KW8BJ
 KRdqVzq6IsjXbfkD+OwnhFmL7PwxIncrZsdPD9NFVcKuQHHXsvm2dOwXVtCfR8tg7/91 Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uwys50c2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 09:39:55 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BB9bcOC021484;
	Mon, 11 Dec 2023 09:39:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uwys50c2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 09:39:54 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BB70fCb028206;
	Mon, 11 Dec 2023 09:39:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw2xy8k4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 09:39:53 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BB9do2Q42140084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Dec 2023 09:39:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97E0620043;
	Mon, 11 Dec 2023 09:39:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8566220040;
	Mon, 11 Dec 2023 09:39:49 +0000 (GMT)
Received: from [9.171.1.164] (unknown [9.171.1.164])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Dec 2023 09:39:49 +0000 (GMT)
Message-ID: <8b651c68-c51d-49a9-9df0-58e9110fa47d@linux.ibm.com>
Date: Mon, 11 Dec 2023 10:39:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 7/9] net/smc: support extended GID in SMC-D
 lgr netlink attribute
Content-Language: en-US
To: Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, raspl@linux.ibm.com, schnelle@linux.ibm.com,
        guangguan.wang@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1702021259-41504-1-git-send-email-guwen@linux.alibaba.com>
 <1702021259-41504-8-git-send-email-guwen@linux.alibaba.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <1702021259-41504-8-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: InxWy_fHAN6Ljf1o1T1oVLPDiaCLylJo
X-Proofpoint-GUID: OhevF00N-hJJCfjWG0fX0__mIZR4s266
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_03,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=608 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312110078



On 08.12.23 08:40, Wen Gu wrote:
> Virtual ISM devices introduced in SMCv2.1 requires a 128 bit extended
> GID vs. the existing ISM 64bit GID. So the 2nd 64 bit of extended GID
> should be included in SMC-D linkgroup netlink attribute as well.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---

This patch did not apply cleanly.
Please always base patches on the current net-next

