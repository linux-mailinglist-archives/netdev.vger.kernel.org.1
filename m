Return-Path: <netdev+bounces-13058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1D573A0F8
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 14:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266172819BA
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8838D174FA;
	Thu, 22 Jun 2023 12:33:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA513AAA0
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:33:33 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15178DE;
	Thu, 22 Jun 2023 05:33:32 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MCSA1e026800;
	Thu, 22 Jun 2023 12:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8JPSv3Evs3XhJvxRrV6qa8ynRzMaIEfed2QAdtCFvYo=;
 b=ec+nfDmLYT7jZYWjL292D7sBlG4KWzsgVu3CYMHcx1pggCdvXaGO3qHGl7MnA5E4vOHU
 ziSfK/RaK2KfjxHCquVsjvyvHC79J64BGnOBHPpac7urvX30kZNee4HeT+gZfFxR0Ptg
 BehdE+JcJ4pwYwW2YH9lbmW0jlINZskd2CihRFg7OtabNPMBDViBO86XGAe5SGMqEEy0
 DfcudZbKy6mg5VEgAz8ojI7TNbsuTHqSCKGt4gwySysMzdVsv0SHTrvsdeu5iiBKCC0t
 x2Dd+Zq8rR9RY2CzO+sscHAQaPmbrlzAfyqhsoxaPHYudBdcxj/V3CYlYvkgC3aLX9bq 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rcpb3r4rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jun 2023 12:33:11 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35MCTMkU029556;
	Thu, 22 Jun 2023 12:33:11 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rcpb3r4n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jun 2023 12:33:11 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
	by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35M8P6Gs030863;
	Thu, 22 Jun 2023 12:33:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3r94f52mbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jun 2023 12:33:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35MCX4Il46858694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jun 2023 12:33:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6AAC20040;
	Thu, 22 Jun 2023 12:33:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B911720043;
	Thu, 22 Jun 2023 12:33:03 +0000 (GMT)
Received: from [9.171.62.26] (unknown [9.171.62.26])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Jun 2023 12:33:03 +0000 (GMT)
Message-ID: <55764773-bf9a-94c9-ad2b-1c6e63879798@linux.ibm.com>
Date: Thu, 22 Jun 2023 14:33:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] s390/net: lcs: fix build errors when FDDI is a loadable
 module
To: Alexandra Winter <wintera@linux.ibm.com>,
        Simon Horman <simon.horman@corigine.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <20230621213742.8245-1-rdunlap@infradead.org>
 <98375832-3d29-1f03-145f-8d6e763dd2d2@linux.ibm.com>
 <ZJP99hSRt5MakBXC@corigine.com>
 <3da03251-21ac-b41f-593d-cbc9ac9f86f6@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <3da03251-21ac-b41f-593d-cbc9ac9f86f6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uc70g-gBitPGOyV0dLNCzj0bYDxXYfsQ
X-Proofpoint-GUID: 2Za_iKiyqFQ94YDnoSKL1EWtFi7br6Lc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_08,2023-06-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 impostorscore=0 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220105
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Am 22.06.23 um 14:16 schrieb Alexandra Winter:
> 
> 
> On 22.06.23 09:53, Simon Horman wrote:
>> On Thu, Jun 22, 2023 at 09:15:24AM +0200, Alexandra Winter wrote:
>>>
>>>
>>> On 21.06.23 23:37, Randy Dunlap wrote:
>>>> Require FDDI to be built-in if it is used. LCS needs FDDI to be
>>>> built-in to build without errors.
>>>>
>>>> Prevents these build errors:
>>>> s390-linux-ld: drivers/s390/net/lcs.o: in function `lcs_new_device':
>>>> drivers/s390/net/lcs.c:2150: undefined reference to `fddi_type_trans'
>>>> s390-linux-ld: drivers/s390/net/lcs.c:2151: undefined reference to `alloc_fddidev'
>>>>
>>>> This FDDI requirement effectively restores the previous condition
>>>> before the blamed patch, when #ifdef CONFIG_FDDI was used, without
>>>> testing for CONFIG_FDDI_MODULE.
>>>>
>>>> Fixes: 128272336120 ("s390/net: lcs: use IS_ENABLED() for kconfig detection")
> [...]
>>
>>> 2) I wonder whether
>>>
>>>    	depends on CCW && NETDEVICES && (ETHERNET || FDDI)
>>>   +	depends on FDDI || FDDI=n
>>>
>>> would do what we want here:
>>> When FDDI is a loadable module, LCS mustn't be built-in.
>>>
>>> I will do some experiments and let you know.
>>
>> It does seem to on my side.
>> But checking would be much appreciated.
>   
> 
> Here are my experiments:

Another suggestion. Why not remove the FDDI part of the lcs driver? This seems unused
without hardware for years now.Longterm we could even remove the whole lcs driver.

