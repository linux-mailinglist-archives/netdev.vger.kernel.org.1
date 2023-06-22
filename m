Return-Path: <netdev+bounces-13051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0F673A0AD
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 14:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A0A1C210F1
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605771E522;
	Thu, 22 Jun 2023 12:16:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4DE15AE4
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:16:27 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F93199D;
	Thu, 22 Jun 2023 05:16:25 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MCFmk6014384;
	Thu, 22 Jun 2023 12:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=phZ/ewYB2rSE60dhAYjcOXnd6Amu92ryCcWXav1bxsY=;
 b=lZUeXEE0WhHpHYrFFiiFz6ZMphFhWFCopTtNTwzy4lSoW2VkbsvvcWA3GEblXGqdB4ag
 hhw5sRUOEm67UVZek9zDoUQEeGwAC3Rdc4ignAxoYNoCEIoMnMaGiGazajAnfcSGTXS7
 T9yc6dT2MjBfi9EzOZzzaEHbYeizg5c4+bYrA9eGbrH7bEwhATL7djlRApl5YqdgfzPe
 qAEx6xqjZnn0aNfZRmtm72t9CGYPss+UU1gy5sYKc781y0c5oVR/lPXtykOQ10nRbSWd
 +Do1hZr1LVcxmbtXTYBQYJPt6c2x41M4od6Id7RpubQbibYL8qWO0bbkqmK8J1nKAFlq yA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rcp5c80gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jun 2023 12:16:11 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35MCG8SB015704;
	Thu, 22 Jun 2023 12:16:10 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rcp5c80fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jun 2023 12:16:10 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
	by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35MAtjqb025362;
	Thu, 22 Jun 2023 12:16:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3r943e2m5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jun 2023 12:16:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35MCG5aG19399216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jun 2023 12:16:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBC4B2004B;
	Thu, 22 Jun 2023 12:16:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EB4420040;
	Thu, 22 Jun 2023 12:16:04 +0000 (GMT)
Received: from [9.152.224.35] (unknown [9.152.224.35])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Jun 2023 12:16:04 +0000 (GMT)
Message-ID: <3da03251-21ac-b41f-593d-cbc9ac9f86f6@linux.ibm.com>
Date: Thu, 22 Jun 2023 14:16:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] s390/net: lcs: fix build errors when FDDI is a loadable
 module
Content-Language: en-US
To: Simon Horman <simon.horman@corigine.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <20230621213742.8245-1-rdunlap@infradead.org>
 <98375832-3d29-1f03-145f-8d6e763dd2d2@linux.ibm.com>
 <ZJP99hSRt5MakBXC@corigine.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <ZJP99hSRt5MakBXC@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YRNhdc74ZTrGB_DNBcX-HWGl-XOywLXD
X-Proofpoint-GUID: DUbnREwnHO1FB1BjuyjMLfh5GDkSCDeE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_08,2023-06-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=647 priorityscore=1501 malwarescore=0 mlxscore=0
 adultscore=0 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 22.06.23 09:53, Simon Horman wrote:
> On Thu, Jun 22, 2023 at 09:15:24AM +0200, Alexandra Winter wrote:
>>
>>
>> On 21.06.23 23:37, Randy Dunlap wrote:
>>> Require FDDI to be built-in if it is used. LCS needs FDDI to be
>>> built-in to build without errors.
>>>
>>> Prevents these build errors:
>>> s390-linux-ld: drivers/s390/net/lcs.o: in function `lcs_new_device':
>>> drivers/s390/net/lcs.c:2150: undefined reference to `fddi_type_trans'
>>> s390-linux-ld: drivers/s390/net/lcs.c:2151: undefined reference to `alloc_fddidev'
>>>
>>> This FDDI requirement effectively restores the previous condition
>>> before the blamed patch, when #ifdef CONFIG_FDDI was used, without
>>> testing for CONFIG_FDDI_MODULE.
>>>
>>> Fixes: 128272336120 ("s390/net: lcs: use IS_ENABLED() for kconfig detection")
[...]
> 
>> 2) I wonder whether
>>
>>   	depends on CCW && NETDEVICES && (ETHERNET || FDDI)
>>  +	depends on FDDI || FDDI=n
>>
>> would do what we want here:
>> When FDDI is a loadable module, LCS mustn't be built-in.
>>
>> I will do some experiments and let you know.
> 
> It does seem to on my side.
> But checking would be much appreciated.
 

Here are my experiments:

Current net-next:
-----------------
if !IS_ENABLED(CONFIG_ETHERNET) && !IS_ENABLED(CONFIG_FDDI)

drivers/s390/net/KConfig:
config LCS
	def_tristate m
	depends on CCW && NETDEVICES && (ETHERNET || FDDI)

.config:
ETHERNET  |  FDDI | LCS choices | LCS | compile
--------------------------------------------------------
n		m	m,n	  m	success (failed before Randy's fix)
y		m	y,m,n	  m	success (failed before Randy's fix)
y		m		  y	fails: undefined reference to `fddi_type_trans'


Simon's proposal:
-----------------
        depends on CCW && NETDEVICES && (ETHERNET || FDDI)
+       depends on FDDI=y || FDDI=n

ETHERNET  |  FDDI | LCS choices | LCS | compile
--------------------------------------------------------
n		m	-
y		m	-
y		m	-
y		n	y,m,n	  y	success
y		n	y,m,n	  m	success
y		y	y,m,n	  m	success


Alexandra's proposal:
---------------------
        depends on CCW && NETDEVICES && (ETHERNET || FDDI)
+       depends on FDDI || FDDI=n

ETHERNET  |  FDDI | LCS choices | LCS | compile
--------------------------------------------------------
n		m	m,n	  m	success
y		m	m,n	  m	success
y		n	y,m,n	  y	success
y		n	y,m,n	  m	success
y		y	y,m,n	  m	success

-----------------------------------------------------------

Seems that 
	A[tristate] depends on B[tristate]
means that A cannot be 'higher' than B.
Meaning, if B=n -> A= must be n
	if B=m -> A can be m or n
	if B=y -> A can be y or m or n

Although I did not find documentation confirming that.


@Randy, do you want give a v2 a try with that?

I guess then it is safe to delete from drivers/s390/net/lcs.c
-#if !IS_ENABLED(CONFIG_ETHERNET) && !IS_ENABLED(CONFIG_FDDI)
-#error Cannot compile lcs.c without some net devices switched on.
-#endif



