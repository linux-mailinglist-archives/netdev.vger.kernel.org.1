Return-Path: <netdev+bounces-46386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F52B7E3866
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 11:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA395B20A4C
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 10:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D132712E4F;
	Tue,  7 Nov 2023 10:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WbETTBqc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF2F12E40
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 10:06:38 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF666BD;
	Tue,  7 Nov 2023 02:06:36 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7A5SCx021752;
	Tue, 7 Nov 2023 10:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xCzAIxDzdZw4u5P6QZTEVT+k4CCb6tUvJUdCVUov6+E=;
 b=WbETTBqc9Cz6qsFdvOyvAsmY3KE0gFH/JuVtNmJIZQdbV4x0vCvxz9aqThCZlaxza0Tl
 QxxPPWqVhfz2R+T/i6ojMZ1KmOQa8CUETFb3emX8La1Lib+Tj+jZHPCK+asue0Lq9jqA
 DLhGfpjp34w4+6k6Py0fl8PX89caB9/olhd6cCQ2MLp4FuK/HZuiLNjAXrxk0Lj4Eyex
 hqXYbDXbKmB5TJK02LRV68v7mvuBK/cjc6vqcHQFXRRC/M+UcahTWcpKdSEZuV8+kIbi
 UVB0Ngl/kxPaZq2xIdjGYFMgmAXaaFzoAyxkUvaGgv6Z1bywPa+f/D7EL7zt3ZOcXQN7 aQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7k64r2q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Nov 2023 10:06:35 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A7A5lsM023227;
	Tue, 7 Nov 2023 10:06:35 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7k64r2kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Nov 2023 10:06:34 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A79lg4T025666;
	Tue, 7 Nov 2023 10:06:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u619nfts3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Nov 2023 10:06:33 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A7A6UQa18153984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Nov 2023 10:06:30 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4467E20075;
	Tue,  7 Nov 2023 10:06:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15E3B20073;
	Tue,  7 Nov 2023 10:06:30 +0000 (GMT)
Received: from [9.152.224.24] (unknown [9.152.224.24])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Nov 2023 10:06:30 +0000 (GMT)
Message-ID: <7c88cf8a-7c96-40a1-82a7-5c357609044a@linux.ibm.com>
Date: Tue, 7 Nov 2023 11:06:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/qeth: Fix typo 'weed' in comment
To: Kuan-Wei Chiu <visitorckw@gmail.com>, wenjia@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231106222059.1475375-1-visitorckw@gmail.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20231106222059.1475375-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qLJ2DM32zlDWyDQye-x5vYzEurUlqPuD
X-Proofpoint-GUID: lp-QasmdaNzxI7_wEha0rWt2sKg_2pIn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 phishscore=0 priorityscore=1501 mlxlogscore=940 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311070083



On 06.11.23 23:20, Kuan-Wei Chiu wrote:
> Replace 'weed' with 'we' in the comment.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  drivers/s390/net/qeth_core_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
> index 6af2511e070c..cf8506d0f185 100644
> --- a/drivers/s390/net/qeth_core_main.c
> +++ b/drivers/s390/net/qeth_core_main.c
> @@ -3675,7 +3675,7 @@ static void qeth_flush_queue(struct qeth_qdio_out_q *queue)
>  static void qeth_check_outbound_queue(struct qeth_qdio_out_q *queue)
>  {
>  	/*
> -	 * check if weed have to switch to non-packing mode or if
> +	 * check if we have to switch to non-packing mode or if
>  	 * we have to get a pci flag out on the queue
>  	 */
>  	if ((atomic_read(&queue->used_buffers) <= QETH_LOW_WATERMARK_PACK) ||


Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>

