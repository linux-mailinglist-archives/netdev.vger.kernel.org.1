Return-Path: <netdev+bounces-104981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202B890F5F6
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9455283769
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4C1157486;
	Wed, 19 Jun 2024 18:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jNz2uIhO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCD615252C
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 18:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718821353; cv=none; b=tulpvBLL/Qv1xLzkHPLMNWF7Aqpi9fSaaxQ6NAOegoJCOnseMQgNPdwibeHcN4Flwtx4BnhMulu5PFRH5+or81SkF+bav02q6FcoWPc9rexm4Alm856omvGP5s2SHmmb8OxSHwadVyDTpayWc+lE1LCxP8V+IjOOKSMAV89bPSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718821353; c=relaxed/simple;
	bh=8cxl/UJtNrpMm+vU+XluCrTn7u8uioSFI0ie5YJ3Dp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bDDMOXvD2yFs6rEXWvXz4P5QbSV0Y5vAxLhOGQNnsNnWHVdQGAF932QhoJc/8K026vMzfODY1mBVET78njRyq8OzGzA6YiZBoySr+klwtlBe2mZrZ+hFGi7uteZQYYZHEcFq57uLXoBt0QdypPwwhIY+tYCYLA2OuUCbOdRVcs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jNz2uIhO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J9Q62O001142;
	Wed, 19 Jun 2024 18:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v4HWOrkGSkHal9yRzbee7Zczs5GfrothUA5hOODjDmc=; b=jNz2uIhOL6Vv+AMk
	AjahYxj7AERA6eFfi0g1bwXyuhDsLn8gfBPBlF+LC/wB7JTLWoUUejMD1d+TyDF7
	MjtV/5pkIL0JdwXvF/b3CVbenpZ8AGbHKPipthgZ9+6UyzyEQPRVb6qJqKSnAZ2O
	rCVGg2+Bx2VDQIbu64VtzICknCrRbYSvOW8Xtou++9tHM9gyjb948stYOmSmcYWC
	zOD4VG8xM1IU8WKm2AAkWee/XwxYdQo/mPj6TUV5hksD5Yh+dT0EQl161FBoCDil
	jizxhzRLqjbOmAVp9lHt/VpwSdHNfftRvvCG6YTcQvpmdubg6Rw/UuaCftNw50YT
	wFVv/w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuja2ag1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 18:22:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45JIMK32025703
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 18:22:20 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Jun
 2024 11:22:20 -0700
Message-ID: <2fa05695-faf9-45ce-95de-f49a6749b828@quicinc.com>
Date: Wed, 19 Jun 2024 11:22:19 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ipsec-next v4 08/18] xfrm: iptfs: add new iptfs xfrm mode
 impl
To: Christian Hopps <chopps@chopps.org>, <devel@linux-ipsec.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>, <netdev@vger.kernel.org>,
        Christian Hopps <chopps@labn.net>
References: <20240617205316.939774-1-chopps@chopps.org>
 <20240617205316.939774-9-chopps@chopps.org>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240617205316.939774-9-chopps@chopps.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CT4D--q8_wGvLj2_CDF33jRM2J-lFYus
X-Proofpoint-ORIG-GUID: CT4D--q8_wGvLj2_CDF33jRM2J-lFYus
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190138

On 6/17/24 13:53, Christian Hopps wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> Add a new xfrm mode implementing AggFrag/IP-TFS from RFC9347.
> 
> This utilizes the new xfrm_mode_cbs to implement demand-driven IP-TFS
> functionality. This functionality can be used to increase bandwidth
> utilization through small packet aggregation, as well as help solve PMTU
> issues through it's efficient use of fragmentation.
> 
>    Link: https://www.rfc-editor.org/rfc/rfc9347.txt
> 
> Multiple commits follow to build the functionality into xfrm_iptfs.c
> 
> Signed-off-by: Christian Hopps <chopps@labn.net>
> ---
>   net/xfrm/Makefile     |   1 +
>   net/xfrm/xfrm_iptfs.c | 225 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 226 insertions(+)
>   create mode 100644 net/xfrm/xfrm_iptfs.c
> 
> diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
> index 547cec77ba03..cd6520d4d777 100644
> --- a/net/xfrm/Makefile
> +++ b/net/xfrm/Makefile
> @@ -20,5 +20,6 @@ obj-$(CONFIG_XFRM_USER) += xfrm_user.o
>   obj-$(CONFIG_XFRM_USER_COMPAT) += xfrm_compat.o
>   obj-$(CONFIG_XFRM_IPCOMP) += xfrm_ipcomp.o
>   obj-$(CONFIG_XFRM_INTERFACE) += xfrm_interface.o
> +obj-$(CONFIG_XFRM_IPTFS) += xfrm_iptfs.o
>   obj-$(CONFIG_XFRM_ESPINTCP) += espintcp.o
>   obj-$(CONFIG_DEBUG_INFO_BTF) += xfrm_state_bpf.o
> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> new file mode 100644
> index 000000000000..e7b5546e1f6a
> --- /dev/null
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -0,0 +1,225 @@
> +// SPDX-License-Identifier: GPL-2.0
...

> +module_init(xfrm_iptfs_init);
> +module_exit(xfrm_iptfs_fini);
> +MODULE_LICENSE("GPL");

missing MODULE_DESCRIPTION() which will cause a warning with make W=1


