Return-Path: <netdev+bounces-40365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EE37C6EBC
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 15:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB92E28281B
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 13:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1173F27701;
	Thu, 12 Oct 2023 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oTVXtGsc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6456C26E3B
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 13:05:35 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DA291;
	Thu, 12 Oct 2023 06:05:32 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CD2FJ9020431;
	Thu, 12 Oct 2023 13:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MdX39D2VCl3WqSbBA2/QodKI3FFA8NAfRhUxo9CYmpI=;
 b=oTVXtGsc/fSE5bnLHCfLaHb+3CiQ0EYzlqWZlfpEN1pl0Fv5F51l7DBuPO+RVr5Kihzf
 vIqH5vNxL+A0kjC/NIpTUGJmVH6iIoIDLka8nFMH63ZIsNJpCE16xagBHxJ1oPWZMa+G
 owVex5gq6MFInxQ/BMfkP24ECcQ3hi+tUP/wwsWWsxfr2Ao5zj8IyjjC6zgA3I5lHvg8
 dGiwQl82xInT80Ap+s7UH2N5NlZnd4+sN6X6YjXwKtc/OCIqiSU67bSAPu3JV0Mod8nQ
 4BCnlw0dlSuWXI5dvK9vOjONUxaJnSiLafgeyikOa4HRKg12X0gK+G/8HGjXfKB9C+rB RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tphb1r49g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 13:05:26 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CD2HCC020614;
	Thu, 12 Oct 2023 13:05:26 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tphb1r48n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 13:05:25 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39CCc1Ys025907;
	Thu, 12 Oct 2023 13:05:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkjnnqk3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 13:05:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39CD5LxS44237196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Oct 2023 13:05:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA0A320040;
	Thu, 12 Oct 2023 13:05:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B633020043;
	Thu, 12 Oct 2023 13:05:20 +0000 (GMT)
Received: from [9.152.224.54] (unknown [9.152.224.54])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Oct 2023 13:05:20 +0000 (GMT)
Message-ID: <5b54a227-2e18-46d5-9b15-aea9709cf2a5@linux.ibm.com>
Date: Thu, 12 Oct 2023 15:05:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: return the right falback reason when prefix
 checks fail
To: Dust Li <dust.li@linux.alibaba.com>, Karsten Graul
 <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231012123729.29307-1-dust.li@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20231012123729.29307-1-dust.li@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MBfSyhAb_8tj5JP09lTYfO1AzGohvjlX
X-Proofpoint-GUID: W2eDNxbKHD0fOckijwWojFYiy3FjFkAU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 12.10.23 14:37, Dust Li wrote:
> In the smc_listen_work(), if smc_listen_prfx_check() failed,
> the real reason: SMC_CLC_DECL_DIFFPREFIX was dropped, and
> SMC_CLC_DECL_NOSMCDEV was returned.
> 
> Althrough this is also kind of SMC_CLC_DECL_NOSMCDEV, but return
> the real reason is much friendly for debugging.
> 
> Fixes: e49300a6bf62 ("net/smc: add listen processing for SMC-Rv2")
> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>

As you point out the current code is not really wrong. So I am not sure,
whether this should be a fix for net, or rather a debug improvement for
net-next.

> ---
>  net/smc/af_smc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index bacdd971615e..21d4476b937b 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -2361,7 +2361,7 @@ static int smc_listen_find_device(struct smc_sock *new_smc,
>  		smc_find_ism_store_rc(rc, ini);
>  		return (!rc) ? 0 : ini->rc;
>  	}
> -	return SMC_CLC_DECL_NOSMCDEV;
> +	return prfx_rc;
>  }
>  
>  /* listen worker: finish RDMA setup */

For the code change:
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>


