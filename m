Return-Path: <netdev+bounces-48737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8856D7EF608
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42619280D64
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B021D171BB;
	Fri, 17 Nov 2023 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UJav78Kk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E68194
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 08:20:00 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHG5ajx021365;
	Fri, 17 Nov 2023 16:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=NqpIc5j4Kkpij3La9Z/jddJpZgoT+qrIZnl4oOf5z5E=;
 b=UJav78Kk4xnVNeXonzqz4TZSt8QgfbXUYEa+yw+eNcpJ8u7VgvF08JuULyeS0iUfsekw
 oOSQm1ccGI3XbZDIuF7Ko9HzcIEPr4x378uk7AztLrNW4fCA0zUMZ5bW5+O57JUZysDW
 kYYjdfXhK4T7nMQNk0gxyV6F93zQJpQ2qnlDefFi6blW1/DXSmB7LYp8ZFX9r4Lxz6Zs
 JFTDXK0MZdJmYnrB0sltVNWmgAXtD2sStBJkeoK+tHdVBSIlaoYKiPahbWGItUcIf7W+
 Brqal0/3D1sBP3J/v0VRkIv0WSbWMYDDIhKSFAG5JW93VcX8S/P0IkROb8AcBQgSt154 Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uebcugjeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Nov 2023 16:19:52 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AHGI5Bm011392;
	Fri, 17 Nov 2023 16:19:41 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uebcugj45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Nov 2023 16:19:41 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHG4HJt008043;
	Fri, 17 Nov 2023 16:19:35 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamxny3s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Nov 2023 16:19:35 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AHGJY1G56951248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Nov 2023 16:19:34 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA5075805A;
	Fri, 17 Nov 2023 16:19:34 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 736D55803F;
	Fri, 17 Nov 2023 16:19:34 +0000 (GMT)
Received: from [9.41.99.4] (unknown [9.41.99.4])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Nov 2023 16:19:34 +0000 (GMT)
Message-ID: <cf143e97-5303-42e3-8a27-3226a6bf7c9b@linux.vnet.ibm.com>
Date: Fri, 17 Nov 2023 10:19:34 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/tg3: fix race condition in tg3_reset_task()
To: Michael Chan <michael.chan@broadcom.com>
Cc: mchan@broadcom.com, pavan.chebbi@broadcom.com, netdev@vger.kernel.org,
        prashant@broadcom.com, siva.kallam@broadcom.com,
        drc@linux.vnet.ibm.com, venkata.sai.duggi@ibm.com, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
References: <20231102161219.220-1-thinhtr@linux.vnet.ibm.com>
 <20231116151822.281-1-thinhtr@linux.vnet.ibm.com>
 <CACKFLik9h4pOPWtyaOutRwnwE+KEyO+50Cf+dMknvR2ybONTzQ@mail.gmail.com>
Content-Language: en-US
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
In-Reply-To: <CACKFLik9h4pOPWtyaOutRwnwE+KEyO+50Cf+dMknvR2ybONTzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kJ6iXHVV5A_KaXq4xIHrqgNS_MeK2xuS
X-Proofpoint-GUID: NRwIQw-cZcRiatk-_pbxyXeDAIn9POuJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_15,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 impostorscore=0 spamscore=0 mlxlogscore=593 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170122


On 11/16/2023 3:34 PM, Michael Chan wrote:
> 
> I think it will be better to add these 2 checks in tg3_reset_task().
> We are already doing a similar check there for tp->pcierr_recovery so
> it is better to centralize all the related checks in the same place.
> I don't think tg3_dump_state() below will cause any problems.  We'll
> probably read 0xffffffff for all registers and it will actually
> confirm that the registers are not readable.
> 

I'm concerned that race conditions could still occur during the handling 
of Partitionable Endpoint (PE) reset by the EEH driver. The issue lies 
in the dependency on the lower-level FW reset procedure. When the driver 
executes tg3_dump_state(), and then follows it with tg3_reset_task(), 
the EEH driver possibility changes in the PCI devices' state, but the 
MMIO and DMA reset procedures may not have completed yet. Leading to a 
crash in tg3_reset_task().  This patch tries to prevent that scenario.

While tg3_dump_state() is helpful, it also poses issues as it takes a 
considerable amount of time, approximately 1 or 2 seconds per device. 
Given our 4-port adapter, this could extend to more than 10 seconds to 
write to the dmesg buffer. With the default size, the dmesg buffer may 
be over-written and not retain all useful information.

Thanks,
Thinh Tran

