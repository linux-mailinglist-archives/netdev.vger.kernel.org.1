Return-Path: <netdev+bounces-52725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77697FFE77
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 23:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 870A7B20CE9
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 22:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C95161FAE;
	Thu, 30 Nov 2023 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aXDdgLRH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275B11703
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 14:29:42 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AULkDQh010094;
	Thu, 30 Nov 2023 22:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vug6arhqUXDsTlrKdgbv+3BUFsilJEZaBha4G/UXMes=;
 b=aXDdgLRH/3NOAh4QG7wHfhMBbMYK62R1iWxQkC61IOvsquE+dv3PT3KzlbLuRrw1Nrya
 +EoJ95XL8DtpDOOdLP9R9yMjq6QVFSMsiohs24t3ZopMXPgICzlFgzGB/NpYNMyk4PXW
 TXLyAcsRtS012YFvZKqkb4fCN2F/LUHvenQVVveIRVNl+SFp9m4tetiGEexmz4VIqDaX
 g13+/tWMVpELEdUtr3GMVb+N7uYnYgdMEHBAjbcrK7C69MmmUs464DteqwkApZat7mob
 pQVIECP+tbpULJvlo11woc4g1PbpGMzxaMhn/lF7J6tEyodbGlhn1A+EDity8D7EfeJj sw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uq0dtmuhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 22:29:38 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AULldLN013366;
	Thu, 30 Nov 2023 22:29:37 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uq0dtmuh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 22:29:37 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUJhbON012514;
	Thu, 30 Nov 2023 22:29:36 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukv8p18wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 22:29:36 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AUMTZKx11666136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 22:29:35 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFAAC5805D;
	Thu, 30 Nov 2023 22:29:34 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5951058043;
	Thu, 30 Nov 2023 22:29:34 +0000 (GMT)
Received: from [9.41.99.4] (unknown [9.41.99.4])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Nov 2023 22:29:34 +0000 (GMT)
Message-ID: <edafdffb-c1d4-4461-abb6-595624dd7710@linux.vnet.ibm.com>
Date: Thu, 30 Nov 2023 16:29:34 -0600
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
 <cf143e97-5303-42e3-8a27-3226a6bf7c9b@linux.vnet.ibm.com>
 <CACKFLimqMzw4wHT7BLY3v9VYtX0Ax=Xj2efd0hnXKf4A6bouZg@mail.gmail.com>
Content-Language: en-US
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
In-Reply-To: <CACKFLimqMzw4wHT7BLY3v9VYtX0Ax=Xj2efd0hnXKf4A6bouZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NyvGbX_SqjHFc9BNaMH_LHlC3iRBVT1z
X-Proofpoint-GUID: wucmb1ClURXe0mVFHOplr6nuhF_3heVK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_22,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=631 adultscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300165


On 11/17/2023 12:31 PM, Michael Chan wrote:
> On Fri, Nov 17, 2023 at 8:19 AM Thinh Tran <thinhtr@linux.vnet.ibm.com> wrote:
>>
>>
>> On 11/16/2023 3:34 PM, Michael Chan wrote:
>>>
>>> I think it will be better to add these 2 checks in tg3_reset_task().
>>> We are already doing a similar check there for tp->pcierr_recovery so
>>> it is better to centralize all the related checks in the same place.
>>> I don't think tg3_dump_state() below will cause any problems.  We'll
>>> probably read 0xffffffff for all registers and it will actually
>>> confirm that the registers are not readable.
>>>
>>
>> I'm concerned that race conditions could still occur during the handling
>> of Partitionable Endpoint (PE) reset by the EEH driver. The issue lies
>> in the dependency on the lower-level FW reset procedure. When the driver
>> executes tg3_dump_state(), and then follows it with tg3_reset_task(),
>> the EEH driver possibility changes in the PCI devices' state, but the
>> MMIO and DMA reset procedures may not have completed yet. Leading to a
>> crash in tg3_reset_task().  This patch tries to prevent that scenario.
> 
> It seems fragile if you are relying on such timing.  TG3_TX_TIMEOUT is
> 5 seconds but the actual time tg3_tx_timeout() is called varies
> depending on when the TX queue is stopped.  So tg3_tx_timeout() will
> be called 5 seconds or more after EEH if there are uncompleted TX
> packets but we don't know precisely when.
> 
>>
>> While tg3_dump_state() is helpful, it also poses issues as it takes a
>> considerable amount of time, approximately 1 or 2 seconds per device.
>> Given our 4-port adapter, this could extend to more than 10 seconds to
>> write to the dmesg buffer. With the default size, the dmesg buffer may
>> be over-written and not retain all useful information.
>>
> 
> If tg3_dump_state() is not useful and fills the dmesg log with useless
> data, we can add the same check in tg3_dump_state() and skip it.
> tg3_dump_state() is also called by tg3_process_error() so we can avoid
> dumping useless data if we hit tg3_process_error() during EEH or AER.
> 
> Thanks.

I implemented the fix as you suggested and passed the tests.
I will send the next version of patch shortly.

Thanks.

