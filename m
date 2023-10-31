Return-Path: <netdev+bounces-45495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8E17DD931
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 00:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E89281288
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 23:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9157827468;
	Tue, 31 Oct 2023 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KlHV/fJ0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EC81DFCD
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 23:18:18 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C090B9
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 16:18:17 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VNHMij024026;
	Tue, 31 Oct 2023 23:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=U192Vdp1edkllngGm6yPyW2+sNEHHgHznX9yvP9PDEg=;
 b=KlHV/fJ0DsuBUHK/BnTlpKitUvidb7bfdznhJyULeSPdMgkYdO9woaOpJTrHZMUXm4jQ
 x8DKryE41tqufwN4Izs7pRhFHDLYYmsz1h3+75yknNnDxHAgBYTWobzOycVwCdlXE0G8
 fGlGnb8D96UI63Jl3Lh8sTtqFMXYac8SXOkNxqmOaL12emRWWgDT/wYrUnYQHaKKMR55
 ltdE7rh14xLqhYhsZMQzdB+l1D8/V+PQfUvo3SKWLtKDkf569KS2n7JEjYdoPz0Qo9ex
 MY7xjXs9WlX/WPbhsjTjQY6eqhKDYB4whOFkHIkOftJsnBgXkSxDvstKJupXU6CvMg6f dQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u3b4a80e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Oct 2023 23:18:15 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39VKo27e007681;
	Tue, 31 Oct 2023 23:18:14 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1dmnm2d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Oct 2023 23:18:14 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39VNIDnL2622168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Oct 2023 23:18:13 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8189D5803F;
	Tue, 31 Oct 2023 23:18:13 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55EA45805A;
	Tue, 31 Oct 2023 23:18:13 +0000 (GMT)
Received: from [9.41.99.4] (unknown [9.41.99.4])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Oct 2023 23:18:13 +0000 (GMT)
Message-ID: <6852b406-1301-4570-b448-6fd58694d219@linux.vnet.ibm.com>
Date: Tue, 31 Oct 2023 18:18:14 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/tg3: fix race condition in tg3_reset_task_cancel()
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: netdev@vger.kernel.org, siva.kallam@broadcom.com, prashant@broadcom.com,
        mchan@broadcom.com, drc@linux.vnet.ibm.com,
        Venkata Sai Duggi <venkata.sai.duggi@ibm.com>
References: <20231002185510.1488-1-thinhtr@linux.vnet.ibm.com>
 <CALs4sv1-aw8UgXNOcAJOc5NdrGqjsgLhTBzx7bn0GxUZ072e6Q@mail.gmail.com>
Content-Language: en-US
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
In-Reply-To: <CALs4sv1-aw8UgXNOcAJOc5NdrGqjsgLhTBzx7bn0GxUZ072e6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Bbpxklsxkm2PIMhikiFe5wTNKY7Wj7KM
X-Proofpoint-ORIG-GUID: Bbpxklsxkm2PIMhikiFe5wTNKY7Wj7KM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_10,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 adultscore=0 spamscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310193

Thanks for the review and I apologize for the delayed response. I had 
some trouble accessing the system, which delayed my investigation.

On 10/2/2023 11:34 PM, Pavan Chebbi wrote:
> 
> Can you elaborate on the race condition please? Are you saying
> tg3_reset_task_cancel() cleared the flag and tg3_tx_recover() set it
> again and the reset task never got a chance to run?
> Is that what is leading to TX stall?

This code path only triggered once, and after updating both the system 
and adapter firmware, I haven't encountered it again. However, the race 
condition issue still persists, causing the interfaces to go down.

Implementing the memory barrier, smp_mb__after_atomic(), as suggested by 
Michael Chan, the intermittent problem still persists. Upon closer 
investigation, I identified the root cause, details in the next version 
of the patch. When I commented out the call to the tg3_dump_state() 
function in the tg3_tx_timeout() function, the issue occurred quicker.

I'm working on submitting the v2 of the patch.

Regards,
Thinh Tran

