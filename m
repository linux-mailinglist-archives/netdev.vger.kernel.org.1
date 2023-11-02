Return-Path: <netdev+bounces-45770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0488D7DF746
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 17:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EEBAB20E57
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 16:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2EF1D559;
	Thu,  2 Nov 2023 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CehxJM0Z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F74D1CF86
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 16:03:01 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870108E
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 09:03:00 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2Fnq4T004171;
	Thu, 2 Nov 2023 16:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=I0uR0BdNrHt9d/AyCP9KkyCUNtIu5r2lI7qMRwAlkoc=;
 b=CehxJM0Z9jI3VspJF7y6K7q1OuPsIk9l4gpDR9y17MC5tr+QUPlNqkif1pxvhJ65iPqp
 ywCDJtchi0fxPvwbcmaNh5Hw1/t6/yo+PPwzJpM6dvnjPHUxCk8rbxFa8gMx9xmxSnIl
 e1vt0n0AfWNhahhF4gZZvEI9Hdw5yyHOpe1Nh6Vgd+s81igJDd0R0TAUUqKoDScY8UF6
 K0AEs6dsJQoChYhxaXzhGfpbQxmx+zeVBDkU1R/1Eny38AfZBCpJ29BnCbLQe3+sZd4t
 N6mE5HQ1oq8D8GIoTv4zIcvPiPI9Ui02KmQv5V9MSrdSda+5eXBLgzE7o1ATx9n3VOom tg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u4erk0cd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Nov 2023 16:02:58 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2EJBpW031381;
	Thu, 2 Nov 2023 16:02:58 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1fb2f6ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Nov 2023 16:02:58 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A2G2vVm17826468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Nov 2023 16:02:57 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A2B25805B;
	Thu,  2 Nov 2023 16:02:57 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC16958058;
	Thu,  2 Nov 2023 16:02:56 +0000 (GMT)
Received: from [9.41.99.4] (unknown [9.41.99.4])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Nov 2023 16:02:56 +0000 (GMT)
Message-ID: <95e0ba26-7153-4b92-9a20-412ee4e1490d@linux.vnet.ibm.com>
Date: Thu, 2 Nov 2023 11:02:56 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/tg3: fix race condition in tg3_reset_task_cancel()
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, siva.kallam@broadcom.com, prashant@broadcom.com,
        mchan@broadcom.com, drc@linux.vnet.ibm.com, pavan.chebbi@broadcom.com,
        Venkata Sai Duggi <venkata.sai.duggi@ibm.com>
References: <20231002185510.1488-1-thinhtr@linux.vnet.ibm.com>
 <CACKFLinpJgLvYAg+nALVb6RpddXXzXSoXbRAq+nddZvwf5+f3Q@mail.gmail.com>
 <09dbfd72-0efb-0275-9589-6178c9aca8a1@linux.vnet.ibm.com>
Content-Language: en-US
In-Reply-To: <09dbfd72-0efb-0275-9589-6178c9aca8a1@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vdBgy1FoP8pZ_pR4Pcv4eclWBSGUPHzQ
X-Proofpoint-ORIG-GUID: vdBgy1FoP8pZ_pR4Pcv4eclWBSGUPHzQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_05,2023-11-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 mlxlogscore=736
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020130

Hi Michael,

On 10/3/2023 5:05 PM, Thinh Tran wrote:
> Thanks for the review.
> 
> On 10/3/2023 4:37 AM, Michael Chan wrote:
> 
>>
>> tg3_flag_set() calls set_bit() which is atomic.  The same is true for
>> tg3_flag_clear().  Maybe we just need some smp_mb__after_atomic() or
>> similar memory barriers.
>>
> 
> I did not see it being used in this driver. I'll try that.
> 
> Thinh Tran
> 

I tried that but still the intermittent problem still persists.
I have a fix that I'll describe in V2 of the patch

Thinh Tran

