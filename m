Return-Path: <netdev+bounces-40433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28B17C7687
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110F32812AA
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CF038BC9;
	Thu, 12 Oct 2023 19:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tnRim4a3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD67B358A7
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 19:15:50 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A394CBB;
	Thu, 12 Oct 2023 12:15:48 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CJCEXf003454;
	Thu, 12 Oct 2023 19:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=G2v9NhoJB2fTb6Fwt17r/EK6+zn7uPTqlFs2lOHCHcc=;
 b=tnRim4a3HmTjRL6TDkyteROThiZdk+eu/zTR8hqp28HUfw6bbnUs/ARLsjgOUMSwaHr+
 uBLUeucf/7fLHCMl2awntUu0NXTcgHErSXByhHtKQyv9QIFRlT+LMYapLg/F1tiKjnj4
 1vBazY/zJpmEu/PH8oE+ypYWtaUxYpQPPP3M28QiMz8FoseqxyI4XbePoNLxoRriX/YE
 BYCvWuTqBAIBN89JjAHsrHBZVuNPnGqGhi6uKiHEJon+dSz0WiRUSEIcH2w4eSIObiLl
 Asb9+SJLZJoa49eha4E5avCuOAq+ajX7ZILsH3xZSC0HnM2JP/UB/vq9FjVhpFN3uNE/ sw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpprj874v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 19:15:44 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CJCTWN005536;
	Thu, 12 Oct 2023 19:15:44 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpprj8736-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 19:15:43 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39CHwVtO000647;
	Thu, 12 Oct 2023 19:15:41 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkk5m1n1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 19:15:41 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39CJFe4F39059838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Oct 2023 19:15:40 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9038558059;
	Thu, 12 Oct 2023 19:15:40 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09EB05805B;
	Thu, 12 Oct 2023 19:15:38 +0000 (GMT)
Received: from [9.171.29.13] (unknown [9.171.29.13])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Oct 2023 19:15:37 +0000 (GMT)
Message-ID: <1cd92217-1926-4990-abae-dcdd2e87cfaa@linux.ibm.com>
Date: Thu, 12 Oct 2023 21:15:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: return the right falback reason when prefix
 checks fail
Content-Language: en-GB
To: Alexandra Winter <wintera@linux.ibm.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Karsten Graul <kgraul@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231012123729.29307-1-dust.li@linux.alibaba.com>
 <5b54a227-2e18-46d5-9b15-aea9709cf2a5@linux.ibm.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <5b54a227-2e18-46d5-9b15-aea9709cf2a5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NpfroVktJi40t2XVKiiSmYMBGjJvtkz2
X-Proofpoint-GUID: yny9i5_eR4foP1UqceZ_ct5ODc7zbYsi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_11,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=861 mlxscore=0 impostorscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120160
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 12.10.23 15:05, Alexandra Winter wrote:
> 
> 
> On 12.10.23 14:37, Dust Li wrote:
>> In the smc_listen_work(), if smc_listen_prfx_check() failed,
>> the real reason: SMC_CLC_DECL_DIFFPREFIX was dropped, and
>> SMC_CLC_DECL_NOSMCDEV was returned.
>>
>> Althrough this is also kind of SMC_CLC_DECL_NOSMCDEV, but return
>> the real reason is much friendly for debugging.
>>
>> Fixes: e49300a6bf62 ("net/smc: add listen processing for SMC-Rv2")
>> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
> 
> As you point out the current code is not really wrong. So I am not sure,
> whether this should be a fix for net, or rather a debug improvement for
> net-next.
> The return code was not precise, and since we do have already a more 
appropriate return code to use. IMO, it was wrong. I'm for net.

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>


