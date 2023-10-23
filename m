Return-Path: <netdev+bounces-43650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FF97D4145
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 22:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0522813E9
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 20:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D741C288;
	Mon, 23 Oct 2023 20:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XhWKRVJe"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C3C1848
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 20:53:39 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5989D;
	Mon, 23 Oct 2023 13:53:38 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NKlSAe023681;
	Mon, 23 Oct 2023 20:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lG6+KIGulqHHzmBQbMsYVUYJkrHe0LuJdSltIONQjGU=;
 b=XhWKRVJeSs0nUXk5p72jbycKNqpGI6j27emdwwa87jHTqP9eZScaHnhyCj7kNFPmMiDM
 Hl3ScVLt0sskFPCFXyk6p+nJ45pvsMt5H4GNx7L43bjP9LI2Ylo3GGus0ix94J01NUHn
 GErFfTLxqOW3YNS9J8NoSs9/BBthyZH6JB40PsG202AYHr3i2MwRduxgDBJFVsN5pzxk
 RpBhmeBEwr5emr497MJ0nAkOW1EQFMnFzT4I5ymRb4cMTZey2XgijclaX2wNLZfZv6FM
 8YIqkmszx+XR5E7TwwKisIQTvPtsb871A/UEY/7BC1UIUnHqMt1OxeHgY7nUfQBCb9tc 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tx061g4j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Oct 2023 20:53:35 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39NKmG2X026713;
	Mon, 23 Oct 2023 20:53:35 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tx061g4bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Oct 2023 20:53:33 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39NIeCRe010231;
	Mon, 23 Oct 2023 20:53:25 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsbyb729-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Oct 2023 20:53:25 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39NKrOTc23790296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Oct 2023 20:53:24 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A39458051;
	Mon, 23 Oct 2023 20:53:24 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADD2E5805C;
	Mon, 23 Oct 2023 20:53:22 +0000 (GMT)
Received: from [9.171.5.241] (unknown [9.171.5.241])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Oct 2023 20:53:22 +0000 (GMT)
Message-ID: <6c3014ee-b374-4b24-93f1-cc6156704e8c@linux.ibm.com>
Date: Mon, 23 Oct 2023 22:53:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/5] net/smc: fix dangling sock under state
 SMC_APPFINCLOSEWAIT
Content-Language: en-GB
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, wintera@linux.ibm.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
 <1697009600-22367-2-git-send-email-alibuda@linux.alibaba.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <1697009600-22367-2-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: baefmuEgOvGhyV9WLiuG0uhS2an8iaIs
X-Proofpoint-GUID: Fd8vBH9lrbdjSTYVIyhjBBEg1h-8j7XH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_20,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=916
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230183



On 11.10.23 09:33, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> Considering scenario:
> 
> 				smc_cdc_rx_handler_rwwi
> __smc_release
> 				sock_set_flag
> smc_close_active()
> sock_set_flag
> 
> __set_bit(DEAD)			__set_bit(DONE)
> 
> Dues to __set_bit is not atomic, the DEAD or DONE might be lost.
> if the DEAD flag lost, the state SMC_CLOSED  will be never be reached
> in smc_close_passive_work:
> 
> if (sock_flag(sk, SOCK_DEAD) &&
> 	smc_close_sent_any_close(conn)) {
> 	sk->sk_state = SMC_CLOSED;
> } else {
> 	/* just shutdown, but not yet closed locally */
> 	sk->sk_state = SMC_APPFINCLOSEWAIT;
> }
> 
> Replace sock_set_flags or __set_bit to set_bit will fix this problem.
> Since set_bit is atomic.
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>   net/smc/af_smc.c    | 4 ++--
>   net/smc/smc.h       | 5 +++++
>   net/smc/smc_cdc.c   | 2 +-
>   net/smc/smc_close.c | 2 +-
>   4 files changed, 9 insertions(+), 4 deletions(-)
> 

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

