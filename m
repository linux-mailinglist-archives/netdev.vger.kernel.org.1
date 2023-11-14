Return-Path: <netdev+bounces-47775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC027EB5A6
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 18:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5321F25029
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 17:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4638F15BC;
	Tue, 14 Nov 2023 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mWBH9jv/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732E92C194
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 17:40:01 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C83A94
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 09:40:00 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEHaYT8020684;
	Tue, 14 Nov 2023 17:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uf9A/zo8jpT8XRT89eZDvEfa2LllxQ8BVy6Zwo247X8=;
 b=mWBH9jv/gv+1Wqm+v9ruqgU6GUA/rM0mm3+zm9J76nQupccHQlDbuSyg/K9BPKJNXa0Q
 8j90fVQRFVnywhb63f/f+b2QNfnNF/DO0ll0g0zwBBX+2NXNPcon/c9a9Z2hb2R4UNj1
 daHkXQNiL5/DHM9lT+Gkm/jI8L/G4nzUUTRD7CVRI74A6K/WlzNBmhk7wf3BBYeG+rpW
 cJp+0kCF+q2QyLTPINjcMvDSUuBzwyrR+O5EbQud1xi2+tikku/R0YSTlbqbYyDjO/Vu
 nbbyFpJal7DZ3c8W9QfcgC1joS642pfIJ/n1PYiSXH66cRzxZUhLcEMQzP4M76hFyQhJ VA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucdeg82xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Nov 2023 17:39:58 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEGXrtL022283;
	Tue, 14 Nov 2023 17:39:57 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uap5k137r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Nov 2023 17:39:57 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AEHdvie26346224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Nov 2023 17:39:57 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DA745805A;
	Tue, 14 Nov 2023 17:39:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1500258051;
	Tue, 14 Nov 2023 17:39:56 +0000 (GMT)
Received: from [9.67.169.53] (unknown [9.67.169.53])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Nov 2023 17:39:55 +0000 (GMT)
Message-ID: <e76f324b-b043-4349-bd19-455542c6480e@linux.vnet.ibm.com>
Date: Tue, 14 Nov 2023 11:39:59 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/tg3: fix race condition in tg3_reset_task()
Content-Language: en-US
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, siva.kallam@broadcom.com, prashant@broadcom.com,
        mchan@broadcom.com, pavan.chebbi@broadcom.com, drc@linux.vnet.ibm.com,
        venkata.sai.duggi@ibm.com
References: <20231002185510.1488-1-thinhtr@linux.vnet.ibm.com>
 <20231102161219.220-1-thinhtr@linux.vnet.ibm.com>
 <CACKFLimX4Pjm89cneeTa36B519DN3mdXXo5FXfDFi6e0SBwUSA@mail.gmail.com>
 <14584a37-2882-4cd8-9380-40a532d07731@linux.vnet.ibm.com>
In-Reply-To: <14584a37-2882-4cd8-9380-40a532d07731@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2qg999YD3_cG3WvoUpqyuLwhckUGK7pn
X-Proofpoint-GUID: 2qg999YD3_cG3WvoUpqyuLwhckUGK7pn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_17,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=589 malwarescore=0 spamscore=0 adultscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140134

Hi Michael,

On 11/2/2023 3:37 PM, Thinh Tran wrote:
> Thanks for the review.
> 
> On 11/2/2023 12:27 PM, Michael Chan wrote:
>>
>> This scenario can affect other drivers too, right?  Shouldn't this be
>> handled in a higher layer before calling ->ndo_tx_timeout() so we
>> don't have to add this logic to all the other drivers?  Thanks.
> 
> Yes, it does. We can add this into the dev_watchdog() function, but 
> further investigations are required. This is because each driver may 
> have a different approach to handling its own ->ndo_tx_timeout() function.
> 
> Thinh Tran

I attempted to relocate the fix into the dev_watchdog(), but we 
experienced crashes in various drivers, leading to the destabilization 
of other drivers.
I propose to accept the current patch, rather than introducing a new fix 
that may potentially create issues for other drivers

Thanks,
Thinh Tran

