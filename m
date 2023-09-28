Return-Path: <netdev+bounces-36654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCD87B1113
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 05:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 271FB1C209F0
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 03:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE285253;
	Thu, 28 Sep 2023 03:08:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041C55236
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 03:08:26 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C137F99;
	Wed, 27 Sep 2023 20:08:25 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38S17hr5027528;
	Thu, 28 Sep 2023 03:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=BVmXr9IyTUy+vW3rxAdfl5SSdPrcvbaIsCT2YlDRwr4=;
 b=WqgcKro8cu2P4lWMGqo9uKOkNx9dkxwfK6k/dpe7z0fLu+bnGt6Rfk56x/MWRpdFizq0
 An3KUC8oYG+Z9rOgfqLuqERQmpC1LaJyeAwRwxWte1l40Jbo8gzqCQOmC0ufXxbhsbaD
 NY+L5hLxDSP6xl6Q3zP2mpljzc5jtDllGJ0xI3DY7Vqf3qVRAAzlv1JQ+gXyZUfbRszb
 fsLhYsEt2GIP2wP8fpl3yOob4RrGDOTHWqY3Qs7Zxy+rfeZaawCh5UoEM33awOKxbQyh
 EsQ7qqkjhGzpODTl0E5KfHnVYq4gz26nVHqWUf+1zdsB6zUP0QGbrxu1uT6MQEtKNZvt uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcnq0b86p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Sep 2023 03:08:23 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38S38CJx015860;
	Thu, 28 Sep 2023 03:08:22 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcnq0b868-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Sep 2023 03:08:22 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38S1UWof011010;
	Thu, 28 Sep 2023 03:08:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabukrngd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Sep 2023 03:08:21 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38S38IWf15532564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Sep 2023 03:08:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3D2520043;
	Thu, 28 Sep 2023 03:08:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F050F20040;
	Thu, 28 Sep 2023 03:08:16 +0000 (GMT)
Received: from [9.171.44.93] (unknown [9.171.44.93])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Sep 2023 03:08:16 +0000 (GMT)
Message-ID: <d5cf999b-ec76-844a-873b-e8767be9ffb5@linux.ibm.com>
Date: Thu, 28 Sep 2023 05:08:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: Jan Karcher <jaka@linux.ibm.com>
Subject: Re: [PATCH net-next v4 05/18] net/smc: reserve CHID range for SMC-D
 virtual device
To: Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: wintera@linux.ibm.com, schnelle@linux.ibm.com, gbayer@linux.ibm.com,
        pasic@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, dust.li@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
 <1695568613-125057-6-git-send-email-guwen@linux.alibaba.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <1695568613-125057-6-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kLjslwUk4HNjU3Fp_my62sC1BOZ5bbeW
X-Proofpoint-GUID: wpqD0z77ZBj7RhRc3p2kPdhKQaLkSJDY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_17,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=858 lowpriorityscore=0
 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280026
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 24/09/2023 17:16, Wen Gu wrote:
> This patch reserve CHID range from 0xFF00 to 0xFFFF for SMC-D virtual

The current state is that 0xFF00 - 0xFFFF is the range of all virtual 
SMC-D devices. This range devides into:
- 0xFF00 - 0xFFFE is for virto-ism
- 0xFFFF is for loopback


> device and introduces helpers to identify them.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>   net/smc/smc_ism.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
> index 14d2e77..2ecc8de 100644
> --- a/net/smc/smc_ism.h
> +++ b/net/smc/smc_ism.h
> @@ -15,6 +15,9 @@
>   
>   #include "smc.h"
>   
> +#define SMC_VIRT_ISM_CHID_MAX		0xFFFF

SMC_VIRT_ISM_MAX is 0xFFFE. Or do you mean virtual devices as the whole 
group. If yes i think that this naming will be very confusing in a few 
months/years.
Maybe something like SMC_VIRTUAL_DEV_CHID_{MIN|MAX}?

> +#define SMC_VIRT_ISM_CHID_MIN		0xFF00
> +
>   struct smcd_dev_list {	/* List of SMCD devices */
>   	struct list_head list;
>   	struct mutex mutex;	/* Protects list of devices */
> @@ -57,4 +60,16 @@ static inline int smc_ism_write(struct smcd_dev *smcd, u64 dmb_tok,
>   	return rc < 0 ? rc : 0;
>   }
>   
> +static inline bool __smc_ism_is_virtdev(u16 chid)
> +{
> +	return (chid >= SMC_VIRT_ISM_CHID_MIN && chid <= SMC_VIRT_ISM_CHID_MAX);
> +}
> +
> +static inline bool smc_ism_is_virtdev(struct smcd_dev *smcd)
> +{
> +	u16 chid = smcd->ops->get_chid(smcd);
> +
> +	return __smc_ism_is_virtdev(chid);
> +}
> +
>   #endif

