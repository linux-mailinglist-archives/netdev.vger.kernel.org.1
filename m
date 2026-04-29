Return-Path: <netdev+bounces-282405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF6YC1MP8mkwngEAu9opvQ
	(envelope-from <netdev+bounces-282405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 16:01:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD77495466
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 16:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12FB83004D95
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D85523F431;
	Wed, 29 Apr 2026 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZVjkz/bw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QBnaAOXO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665B639BFEE
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471214; cv=none; b=jj0WfF+SVC7tLCEsNoCW0yV57NX726RjiSIQLTVuWopBV7/FYh3I9mRU4jGxOnHxTbJIDEOYk1635Lcb6tpGNxdaDjFJ/iAsdPPYSPqygr/My0Ob9TMAw9X/KtLm4kTXeLaTjTjb9fWEpMjNLOMVRnwUz3mTquoH3PbbyXJydWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471214; c=relaxed/simple;
	bh=5yQPAUjn3VunEoidQeZB/XrTAnrzeavxXWZHanAVIvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtuJaUyVJMLpKgD9mCQ6JzubetPo0RhdPY/xUWAXTFl1zRlw5ukTdzeBM2NJ8XxqWhOzcbypJla+9ZXo/iWcAE/QPe7ie+f6TUcpkXjWHNFEE4j24Su25UkxOjUb4juEhJsS7wnbkuhofF6O9dUbx1RLCOaGKPfW9JHK3+mIV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZVjkz/bw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QBnaAOXO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8ptnu1728612
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 14:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YKH9dv7wKtC1p8ZEO04m+kEL
	X8b+zwv/sQpT8PdfGig=; b=ZVjkz/bwitIknIzBQGGYWMnjd+c7U3oo1VDD3ojE
	amdiGSdp8vi58LpqyydYMnBfvL8uamZ8WIYrelSlx2yLPdTEBOa2u20SKht8H31S
	rCBw4E8wCS+ccd6xz/bLRB8HZ3sjjR/CxRL9FhkuuOOdnvzRrymGZEyukKJ/adAg
	VXFsgNc/BcJCVi9QDz5cbpgzNVQMrf9kHGqjuSMKWUA68mslDXOcT1Scn3oUrQ0N
	VnucAWp6lTQ0s2WEiNpo1fwxuo1B4dYbqmecD2AHb2BbvD0DiQg309g1Nz6CblUF
	emwubpt8x6BGtRXRW72mh8KyG5jTGgq91yiJJSyh+Yx8gQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4due5ksaen-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 14:00:12 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82fa5ecd760so6471440b3a.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 07:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777471211; x=1778076011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YKH9dv7wKtC1p8ZEO04m+kELX8b+zwv/sQpT8PdfGig=;
        b=QBnaAOXObISyRoShr1qq3LCMGfheq2m30a+xsaNiJjaxhf3GFvGibEIAl6YTMvLE2I
         SH23IxtHf8QWqayT5wAhENVZqZuibr2J0tZ9nDc+90KZAK860Fl7F+WnGKtOp4bJhxUT
         fzBk7+Y7fQx5GVlzPPbmAv6BA3KBfModclTCG+bSMLVVbtdhgjaqG5X/8LMWyNH6kYj5
         ZqJAZ8l81F2k7fLBleLBNq2v3Eiwu/qSY9watkYlf/1B8svcaMrZHpUbuJ2QfFddqi+3
         Q36lV9YS4ArmIUo/fsM0W1ivL6dFCFTcCUvD0pC6B26aws/TcyQ32lwinhaMS24X0tqI
         waCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471211; x=1778076011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKH9dv7wKtC1p8ZEO04m+kELX8b+zwv/sQpT8PdfGig=;
        b=bEap5W/uvbvEBNafPLCGoxNi0AMOX7X2F7LdHXivnwhyiHf1sWrqSWS6qQV9BSQm4j
         6L/dzM6rGRHwwtmcr17uWBXRnctbT4G8cnF39Np6cJA2u5tbAifkRFTKUBXhz4LyaS5K
         CGAyl7wBv451OFdWHpfbNXJX+2IC6NJ2zKHzAH0eawCMjJ3d4Tm9uW08qOTiuVjuTRb0
         nBrNtHle8/KSIBDGc4tlkcGsshIFRnAP8eptnBXrv0p2rrL1Cq4gLIFrGOmdGU2lHU1h
         J21gd9HSgZ+7kKRBSchLeIVgfaAxmU//tGpAR7Wn3LVoLZV3kExN3bLbvpjzK2fDA++2
         03rg==
X-Forwarded-Encrypted: i=1; AFNElJ/vm3iYEUs5qiFqI57Fk7TypUl6NGvlm/7qHOP9dQz2g+Ab4o7yJkYt44bCgo3/ZK/5VLdsWL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTTWxG50vSH6U9EgkhrBnOkLD3/g6tc+BtD1n6FV9FwNOf0kn+
	aijuh0VZ9y37ZOPx4kSa2rE/4J/xVTot50Z90PArj2KBxgIuOadciaQN46Dh8Qgn6p6VaoVEpI/
	bzrzgSpbiL/yM5NfODjzcoIxnfR5uKELX1q8lNGCyp986bjkJf7I5/EEZM74=
X-Gm-Gg: AeBDietBAXGlGGs6XR3BlZ1NBnX6A9vfc86j3T9hgnEZiX6xle0I21uRqsRKAZSh0Fm
	O0TBO4Kh9HnUEIVY1Yl37G1RhmG1JDcCX62EnZ0ROShKcrJZSZtTsNrlNQtTph5Gbgc4XSgluz7
	xLvxS3ORVPDjCiJ9kX/FqXky5FktsHY7ZH6RAFkfDKpqTh4Y2BdxJ2fB+9hLXpv3+0eSieeWEpq
	Jp8w+xa+iFYnuFNIsD+O4sTTXjECscX4z20Wl5Blj58UiQtDgeA2IrCjqnSoCTv4qK423w7zors
	fT1Q1qxM9pZEh+HBeow/7FRrcmMd2CArbf/wEa34VV6PZ3VReZdajtOT/oeZZnM0YiZCX4GSZPv
	YfBLAOsRKhExymykyTd1gwAKIQWbNkcqK18KjbedJqxt3hROVl0Vgi0hgEYY=
X-Received: by 2002:a05:6a00:4286:b0:82f:316:3208 with SMTP id d2e1a72fcca58-834ddbf1ebamr8578650b3a.29.1777471211007;
        Wed, 29 Apr 2026 07:00:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:4286:b0:82f:316:3208 with SMTP id d2e1a72fcca58-834ddbf1ebamr8578551b3a.29.1777471210136;
        Wed, 29 Apr 2026 07:00:10 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80ec94sm2268304b3a.52.2026.04.29.06.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:00:09 -0700 (PDT)
Date: Wed, 29 Apr 2026 19:29:54 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
        elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jjohnson@kernel.org, mathieu.poirier@linaro.org,
        trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
        jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v4 10/15] drm/msm: Switch to generic PAS TZ APIs
Message-ID: <20260429135954.nvr6nyfadsjeymyt@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-11-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-11-sumit.garg@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE0MSBTYWx0ZWRfX4ywl6g7SeWgr
 hd+MTZGygMbEg/mTQPc2B22cNuQsWOxHZuuOWYE2xBWG5NAj1S1aVsvBNe7dZK92IlWtUWRjn1v
 zgIC10t6xqdudyCL6EqAiytIXHOi9lozbiZPKBLL1SjFrTfYI6Lvuy6oJmGgHsmPYK13sqxoCtg
 js9tFLbKd3KfsnHNmvzv/dYcYUYCEzmYEJbXkFcPb7iErWwrvw+nVL2a31GmZXwo0v/CcmVzDQy
 Z4yPrT62OhRuCFa0rXO14TY+a4AA4IfxvElQMfykhserb9BgpW53flSx3JG6/M6aBGbLKx36y8H
 POvRBoEsypgK/zOJkbqdpoqVwzUi9wHFnPfvRP2lxcF1i9OI60NJzmCjt1a1oRWTqk0AfQBvtRb
 RndSuKJtKuh29x1Z3TBE6vJzuS7Wj4vCH3hZ4yy62krK9oAV6W7dfhhQsc4hJ+SBBnJ0Mojtj5U
 ytXOUcCBk6wdbPedVBw==
X-Proofpoint-GUID: LSEWaR11D20bQ3gMRTbkHbeEaFAcbTU-
X-Proofpoint-ORIG-GUID: LSEWaR11D20bQ3gMRTbkHbeEaFAcbTU-
X-Authority-Analysis: v=2.4 cv=CL4amxrD c=1 sm=1 tr=0 ts=69f20eec cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=DQeyY4SaC-8ekjbwpG4A:9 a=CjuIK1q_8ugA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290141
X-Rspamd-Queue-Id: 4DD77495466
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-282405-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.ojha@oss.qualcomm.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On Mon, Apr 27, 2026 at 03:25:58PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch drm/msm client drivers over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/Kconfig             |  1 +
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  4 ++--
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 11 ++++++-----
>  3 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gdrivers/gpu/drm/msm/Kconfigpu/drm/msm/Kconfig
> index 250246f81ea9..09469d56513b 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -21,6 +21,7 @@ config DRM_MSM
>  	select SHMEM
>  	select TMPFS
>  	select QCOM_SCM

do we need this ?

> +	select QCOM_PAS
>  	select QCOM_UBWC_CONFIG
>  	select WANT_DEV_COREDUMP
>  	select SND_SOC_HDMI_CODEC if SND_SOC
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> index 79acae11154a..b556da823897 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -5,7 +5,7 @@
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/cpumask.h>
> -#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/pm_opp.h>
>  #include <linux/nvmem-consumer.h>
>  #include <linux/slab.h>
> @@ -653,7 +653,7 @@ static int a5xx_zap_shader_resume(struct msm_gpu *gpu)
>  	if (adreno_is_a506(adreno_gpu))
>  		return 0;
>  
> -	ret = qcom_scm_set_remote_state(SCM_GPU_ZAP_SHADER_RESUME, GPU_PAS_ID);
> +	ret = qcom_pas_set_remote_state(SCM_GPU_ZAP_SHADER_RESUME, GPU_PAS_ID);
>  	if (ret)
>  		DRM_ERROR("%s: zap-shader resume failed: %d\n",
>  			gpu->name, ret);
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 66f80f2d12f9..6d68edf0578c 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/ascii85.h>
>  #include <linux/interconnect.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/firmware/qcom/qcom_scm.h>

do we need this ?

>  #include <linux/kernel.h>
>  #include <linux/of_reserved_mem.h>
> @@ -146,10 +147,10 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
>  		goto out;
>  
>  	/* Send the image to the secure world */
> -	ret = qcom_scm_pas_auth_and_reset(pasid);
> +	ret = qcom_pas_auth_and_reset(pasid);
>  
>  	/*
> -	 * If the scm call returns -EOPNOTSUPP we assume that this target
> +	 * If the pas call returns -EOPNOTSUPP we assume that this target
>  	 * doesn't need/support the zap shader so quietly fail
>  	 */
>  	if (ret == -EOPNOTSUPP)
> @@ -175,9 +176,9 @@ int adreno_zap_shader_load(struct msm_gpu *gpu, u32 pasid)
>  	if (!zap_available)
>  		return -ENODEV;
>  
> -	/* We need SCM to be able to load the firmware */
> -	if (!qcom_scm_is_available()) {
> -		DRM_DEV_ERROR(&pdev->dev, "SCM is not available\n");
> +	/* We need PAS to be able to load the firmware */
> +	if (!qcom_pas_is_available()) {
> +		DRM_DEV_ERROR(&pdev->dev, "Qcom PAS is not available\n");
>  		return -EPROBE_DEFER;
>  	}
>  
> -- 
> 2.51.0
> 

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> 

-- 
-Mukesh Ojha

