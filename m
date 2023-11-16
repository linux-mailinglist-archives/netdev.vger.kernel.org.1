Return-Path: <netdev+bounces-48383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E58E97EE332
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1F71F27386
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50A430CE7;
	Thu, 16 Nov 2023 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ptZJRe8j"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB99AAD
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 06:45:57 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGEjmpC004371;
	Thu, 16 Nov 2023 14:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cbyWREBq22R+j5lt31Os+zuNiSHvQDwd1gItytLASrc=;
 b=ptZJRe8jvlQ/IQg8oPtiKpIJRHkOLdwDZAf8tdxfm7VvZuZCNVAxtkfsx4k4OcuYyLKt
 BFnoixvBBoPLkYqLkpw/64Klvi4qi2cQgiPI8NppEVnykTRPK88pqZaK5fMpgm3Gxs6R
 xho6ynzGBFXugwZn0UI9bEYG2iA7XLZjXvS4AcWOkPGkWmALl6SyHwc5+kJz9lEKVW45
 UmKqkA+b1WJv/Wa3p3M6YlEa13j3KdDcZm3d+cg/YkkrjTjH4BCTx7k5/BEjN1dp6CnF
 maEhvKu/rhKLfG0DOMkbhNOYgK8nko4sffY2f0FYwZIFiAIF5U76DcM/OkCT1CKJtw1c gA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3udmg917mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 14:45:55 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGEPB1M026746;
	Thu, 16 Nov 2023 14:41:56 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uakxt7n07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 14:41:56 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AGEftv816253564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 14:41:55 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92F6D5805F;
	Thu, 16 Nov 2023 14:41:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1855C5805A;
	Thu, 16 Nov 2023 14:41:55 +0000 (GMT)
Received: from [9.41.99.4] (unknown [9.41.99.4])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Nov 2023 14:41:55 +0000 (GMT)
Message-ID: <528e0a13-1b34-403e-9470-531c3fe677fa@linux.vnet.ibm.com>
Date: Thu, 16 Nov 2023 08:41:55 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/tg3: fix race condition in tg3_reset_task()
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, siva.kallam@broadcom.com, prashant@broadcom.com,
        mchan@broadcom.com, pavan.chebbi@broadcom.com, drc@linux.vnet.ibm.com,
        venkata.sai.duggi@ibm.com
References: <20231002185510.1488-1-thinhtr@linux.vnet.ibm.com>
 <20231102161219.220-1-thinhtr@linux.vnet.ibm.com>
 <CACKFLimX4Pjm89cneeTa36B519DN3mdXXo5FXfDFi6e0SBwUSA@mail.gmail.com>
 <14584a37-2882-4cd8-9380-40a532d07731@linux.vnet.ibm.com>
 <e76f324b-b043-4349-bd19-455542c6480e@linux.vnet.ibm.com>
 <CACKFLinMiWBabbBdHE=T=vR_BG1st2EsgyCN7GpPYt0g6Pq_AQ@mail.gmail.com>
 <bab94c00-c26e-4883-98c9-eb0a31b781fd@linux.vnet.ibm.com>
 <CACKFLimy_DUPvMzApbgy7j701WCwkzTy_EARd1nmd+XKWC28kw@mail.gmail.com>
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Content-Language: en-US
In-Reply-To: <CACKFLimy_DUPvMzApbgy7j701WCwkzTy_EARd1nmd+XKWC28kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LtIOGFLDQUzHj7Rnts0EjXfCtZM3NxVS
X-Proofpoint-ORIG-GUID: LtIOGFLDQUzHj7Rnts0EjXfCtZM3NxVS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_14,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=751
 malwarescore=0 mlxscore=0 impostorscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160115

I'll re-post the V2 patch shortly.
Thanks for the review.

Thinh Tran
On 11/15/2023 12:56 PM, Michael Chan wrote:
> On Wed, Nov 15, 2023 at 10:23 AM Thinh Tran <thinhtr@linux.vnet.ibm.com> wrote:
>>
>>
>> On 11/14/2023 3:03 PM, Michael Chan wrote:
>>>
>>> Could you provide more information about the crashes?  The
>>> dev_watchdog() code already checks for netif_device_present() and
>>> netif_running() and netif_carrier_ok() before proceeding to check for
>>> TX timeout.  Why would adding some additional checks for PCI errors
>>> cause problems?  Of course the additional checks should only be done
>>> on PCI devices only.  Thanks.
>>
>> The checking for PCI errors is not the problem, avoiding calling drivers
>> ->ndo_tx_timeout() function, causing some issue.
> 
> I see.  By skipping TX timeout during PCI errors, bnx2x crashes in
> .ndo_start_xmit() after EEH error recovery.
> 
> I think it should be fine to fix the original EEH issue in tg3 then.
> Please re-post the tg3 patch.  Thanks.

