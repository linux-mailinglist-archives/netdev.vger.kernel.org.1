Return-Path: <netdev+bounces-22713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC600768EA5
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 09:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A0D1C2087B
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 07:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CDB6112;
	Mon, 31 Jul 2023 07:27:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A91FA4
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 07:27:05 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B692C1703;
	Mon, 31 Jul 2023 00:27:03 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V7BwOK002128;
	Mon, 31 Jul 2023 07:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OGKgTUQdiOBkn8EITMnpjyPTwSnRGvYmwWmatLPbyzs=;
 b=tC1IHoJor0t8foyGv9epTpmmX2M3zNlKapYStTMP5RVxBQde1QwPMQSgTOCZS+Iku8pI
 2Ekzaik9vA7QEqRWoT5RwSAmehyjU6ISm67ee5iIXmaNzEU9AuwfiiAQHl72wJBN2bcE
 4lflMmNowtz03UxxF8/tBw8ibjLwEBDh5yj/EOs1A26juTnXmm2sriDjJTbofABTGPNZ
 O9+KwWDiyC80IvVZbDx8hIDAxxHeM5DS5omGHhdNptKEozzj0k16zlIUzPBN7g44jaMt
 AytQqDaD/ASzaIyO0S1E+HvxdVI0H61kgxiXVk85KX7PRLZFRi3d/PHvQS1RpYgoJPPg OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s68bv0enp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Jul 2023 07:26:47 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36V7C1Sl002470;
	Mon, 31 Jul 2023 07:26:47 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s68bv0en0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Jul 2023 07:26:46 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36V6dYB9015486;
	Mon, 31 Jul 2023 07:26:45 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s5e3mh6y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Jul 2023 07:26:45 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36V7QibZ34079068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Jul 2023 07:26:44 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A85765805E;
	Mon, 31 Jul 2023 07:26:44 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D457D58045;
	Mon, 31 Jul 2023 07:26:41 +0000 (GMT)
Received: from [9.171.26.13] (unknown [9.171.26.13])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Jul 2023 07:26:41 +0000 (GMT)
Message-ID: <67def28b-27cf-560d-8b33-d94a8b8a4d9d@linux.ibm.com>
Date: Mon, 31 Jul 2023 09:26:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] net/smc: Remove unused function declarations
To: Yue Haibing <yuehaibing@huawei.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230729121929.17180-1-yuehaibing@huawei.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20230729121929.17180-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uODoM8UPlxLbEVWzylmkl_fwteAOR5j1
X-Proofpoint-ORIG-GUID: EZqHPi-9IKEEMVyy4IrcDAarHBtdvSRW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1011 malwarescore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310062
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 29.07.23 14:19, Yue Haibing wrote:
> commit f9aab6f2ce57 ("net/smc: immediate freeing in smc_lgr_cleanup_early()")
> left behind smc_lgr_schedule_free_work_fast() declaration.
> And since commit 349d43127dac ("net/smc: fix kernel panic caused by race of smc_sock")
> smc_ib_modify_qp_reset() is not used anymore.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Thank you for the findings!

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

