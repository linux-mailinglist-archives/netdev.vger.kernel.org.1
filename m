Return-Path: <netdev+bounces-52135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E11DB7FD720
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 13:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73A01B21616
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 12:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03A71D69F;
	Wed, 29 Nov 2023 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BWtX/Xrn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6934510C3;
	Wed, 29 Nov 2023 04:51:06 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATBhAFn013713;
	Wed, 29 Nov 2023 12:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=545HjWb7LuzDoJgOw8VjaY4j1TvSBlJc/6nuXGmbXwI=;
 b=BWtX/Xrntkrrzareoh2LdH5HPzsF03uYtSnSGLMLi7W/0Y2wsMZsE3X7bANBlAKqGRd1
 FuEeNYehv7+soaZsxSJJCUJ+OL/+X0zTIEE90sxnSv+VeZH3VlYJxTtGKymMID4pPcWF
 5+v9dCICruI7WssRUoF8VRr3NkCOrNIFWlMJ9Ev0Zf/Jh1JYXjGyGrP2iSbP5PkfHwbM
 KENcuzvxZt7k5AocKtUCzxJxY0+8HhQA/eCKmkf3l9bNCfTNimx4kroJDy7+biRktWfE
 I0Xt1HrZpSCpBsU4qJul3JaqSD8j17AejylQfLbTdy7z/o8ZYH1AfvsbwSDRrye3FnMy Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up4nu9tmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 12:51:00 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ATCfB5x023626;
	Wed, 29 Nov 2023 12:51:00 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up4nu9tm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 12:51:00 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATB48ss014751;
	Wed, 29 Nov 2023 12:50:59 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukumyqd4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 12:50:59 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ATCowlg11403984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 12:50:58 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4798658065;
	Wed, 29 Nov 2023 12:50:58 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2628358061;
	Wed, 29 Nov 2023 12:50:55 +0000 (GMT)
Received: from [9.171.77.152] (unknown [9.171.77.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Nov 2023 12:50:54 +0000 (GMT)
Message-ID: <937d6964-b3c3-4ff5-b864-881d7de58bd1@linux.ibm.com>
Date: Wed, 29 Nov 2023 13:50:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/7] net/smc: implement SMCv2.1 virtual ISM
 device support
Content-Language: en-GB
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, raspl@linux.ibm.com, schnelle@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1700836935-23819-1-git-send-email-guwen@linux.alibaba.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <1700836935-23819-1-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rXMcfvQtEeTYCbYMC5NC4rDbEBwNl6uf
X-Proofpoint-ORIG-GUID: FTnNHnQJT4rHTL1FoD1qCA4vitKUwxlR
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_09,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 mlxlogscore=970 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290096



On 24.11.23 15:42, Wen Gu wrote:
> The fourth edition of SMCv2 adds the SMC version 2.1 feature updates for
> SMC-Dv2 with virtual ISM. Virtual ISM are created and supported mainly by
> OS or hypervisor software, comparable to IBM ISM which is based on platform
> firmware or hardware.
> 
> With the introduction of virtual ISM, SMCv2.1 makes some updates:
> 
> - Introduce feature bitmask to indicate supplemental features.
> - Reserve a range of CHIDs for virtual ISM.
> - Support extended GIDs (128 bits) in CLC handshake.
> 
> So this patch set aims to implement these updates in Linux kernel. And it
> acts as the first part of SMC-D virtual ISM extension & loopback-ism [1].
> 
> [1] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/
> 
> v2->v1:
> - Fix sparse complaint;
> - Rebase to the latest net-next;
> 

It looks good to me. The testing looks good as well.
If these comments are worked out, I'd like to give my Reviewed-by for 
the next version.
BTW, for the next version, you need to rebase your kernel.




