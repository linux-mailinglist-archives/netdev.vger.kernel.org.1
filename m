Return-Path: <netdev+bounces-48433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19997EE53A
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 17:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C82AB20B69
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 16:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8AD2DF7E;
	Thu, 16 Nov 2023 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MD2QYuEC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E16192
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 08:33:04 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGGLZJh002719;
	Thu, 16 Nov 2023 16:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date : from
 : to : cc : reply-to : subject : content-type : content-transfer-encoding
 : mime-version; s=pp1; bh=rI1/LRzYOWqT4y27p3BtLc1C0dFhzV1aUw+nxs7SIz8=;
 b=MD2QYuEC2pMbFryuxuSwj1e57ght+5UoQ3HpuIIbK/d0M+3wzp4jJs/3h6Bnmq9s1vWK
 zuj/dqyNDVMY0lE4z/gOIkFRmEA5F6jKOBJiYa888QlcppR1oem7dzHVzTK5iL/pIvXg
 FAypYreXUqzH+yIDJV6wPoXb2aoRiYpIbmqZZySVi2pwc4Oye670MxpCyBwbBKl+YZId
 z/vHg2/A8C89MNdby6Pt9IK4wpch4ixmZsIpaJUna733benMrw3EIwti586o4MD5AuxO
 zybIyjAZUnF789rVuY0NZaWbEUoSydLX6PR3T3UYxrl2rG3VC0ci5nezvacWVtHiFM0j Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3udph98eap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 16:32:57 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AGGMPcT005166;
	Thu, 16 Nov 2023 16:32:56 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3udph98e9j-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 16:32:56 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGFY39A029878;
	Thu, 16 Nov 2023 16:08:37 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamxnqp7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 16:08:37 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AGG8Zmf3670742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 16:08:35 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1532E5805F;
	Thu, 16 Nov 2023 16:08:35 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 611E758068;
	Thu, 16 Nov 2023 16:08:34 +0000 (GMT)
Received: from [9.41.99.4] (unknown [9.41.99.4])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Nov 2023 16:08:34 +0000 (GMT)
Message-ID: <4bc40774-eae9-4134-be51-af23ad0b6f84@linux.vnet.ibm.com>
Date: Thu, 16 Nov 2023 10:08:34 -0600
User-Agent: Mozilla Thunderbird
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: aelior@marvell.com, davem@davemloft.net, edumazet@google.com,
        manishc@marvell.com, netdev@vger.kernel.org, pabeni@redhat.com,
        skalluru@marvell.com, VENKATA.SAI.DUGGI@ibm.com,
        Thinh Tran <thinhtr@linux.vnet.ibm.com>,
        Abdul Haleem <abdhalee@in.ibm.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Simon Horman <simon.horman@corigine.com>
Reply-To: 20230818161443.708785-1-thinhtr@linux.vnet.ibm.com
Subject: Re: [Patch v6 0/4] bnx2x: Fix error recovering in switch
 configuration
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 35FwgLdXfyh8GnqqJ-EKDzDLcWxn-Gyr
X-Proofpoint-ORIG-GUID: zAd19Fbc4aViA0HPsx27z5Htv6Gr7eMu
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_16,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311160128

Hi,

Could we proceed with advancing these patches? They've been in the 
"Awaiting Upstream" state for a while now. Notably, one of them has 
successfully made it to the mainline kernel:
  [v6,1/4] bnx2x: new flag for tracking HW resource
 
https://github.com/torvalds/linux/commit/bf23ffc8a9a777dfdeb04232e0946b803adbb6a9

As testing the latest kernel, we are still encountering crashes due to 
the absence of one of the patches:
   [v6,3/4] bnx2x: Prevent access to a freed page in page_pool.

Is there anything specific I need to do to help moving these patches 
forward?
We would greatly appreciate if they could be incorporated into the 
mainline kernel.

Thank you,
Thinh Tran

