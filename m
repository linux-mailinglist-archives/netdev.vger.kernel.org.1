Return-Path: <netdev+bounces-282395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJYrGUEJ8mnhmwEAu9opvQ
	(envelope-from <netdev+bounces-282395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:36:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D74F494EFC
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2198C3057130
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 13:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD3B3FE362;
	Wed, 29 Apr 2026 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b4ShSk6m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sf2IjMdB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DA43FD14E
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469539; cv=none; b=PLVLwyE7f4+tE/9wkk7rQS3IahIZwMIuKEaPZg8xQbjIU1Zyxj1GSP3P29h9sopH6NY7MtPyme96FfeazoQCj2T1E+NnxJ4VH64dPLoniQJ6Is/f7tY90rcMRQgtjU69zsix+5mvPPRlhlXC+566FOqKSbALbh4yfgWrdSSI/N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469539; c=relaxed/simple;
	bh=8MlgmCf4zwoh87Y1YqLlhl00eWh9D+mSMPCZDrhBsPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdZmIPFWfHzb5ZLQy5G1W/rYKWYlLDTOl56o26FbQPj7RRM+3PRHcTYQ7SSl25MilS/4hmHCZ5uxp8+mAqIr+bYEAtSUp9F6dDElStRs+/o8D4fi9lIJY3MAO5pW3jZ5CnSG2XLXPmZOh7c2qU+c9VuzLmSANaIccGAQmzAsGhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b4ShSk6m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sf2IjMdB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8prNu1728584
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 13:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zlXmXqOMWysl75wyJsPWf9ub
	9kxU1RPWgNiLMjMjO54=; b=b4ShSk6mKXAOrKXOdRb8rgeM9x0E3AOsUVpGffLX
	YHTR3NG/VHJbPyYcC95HQFsUhNe0VmjCUK0JBtUkd5xLFcFUvZngpyRLOUulQDSn
	nhS0ymk5Q/TAqTVAiCkTu/K2KoGMmZd4ITeT38pEf4r1FLCOVVHy8E6SudEJgvCz
	sI9DUmIPcJBOLQH36FG8SrtbCgHiNJttNS8RBr4nrKjz79AgT6VAzVj2EmgqUN5c
	AYY8mOcO8yx/QLoMEJWhB7hiq7WTX1D0YnsBoA1Ov1EpE1a3KvY9F8ZZNhTwA9ez
	4ag4G9vhGXxwOxTZimD4kr4NPA+7utKXEk+8SArbJOKdPQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4due5ks73b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 13:32:17 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b454cac322so120668295ad.2
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 06:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777469536; x=1778074336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zlXmXqOMWysl75wyJsPWf9ub9kxU1RPWgNiLMjMjO54=;
        b=Sf2IjMdBS5fCVLxyyhgvgK6qb0ioWqEp0KkYtXiJOJRkMVK6ZaI2wnra1npeLkItN5
         q4XvXTyqGblTBySxW8MRSco9jEFfKe2QdoIT7IEH25GLEc3pe1dKEX7jQJdEVoBuI1G1
         /rzcjuJAI5EgZip1YmuA9HScbgeGSpa4c4sLSZm0T24QEAtC6mEh0fakLaCsJO6k+6Yu
         o8LmyFoMabQuCEFjti0hkCjSYmhnBbRQ3eFRRL9WbwOaTBVK1FoeATiXw8XCfZrHrRee
         fKH4Wa9WohIvnq55KuXkYVHLB0RTtW6kI6ur1CjbMfOkBMderdYHjtht7Fm63PoPnEDL
         k6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777469536; x=1778074336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlXmXqOMWysl75wyJsPWf9ub9kxU1RPWgNiLMjMjO54=;
        b=Pm4XsgMGQBo4l2ztncAzWz3Xr4rKBJ++avkit54Q2JU3So3uB4OiUqy0BfNvESlGfy
         jOOqZEYG8tetcDWKTxpAYr3Bh99Nk7G75gH5mkrPGA/YfCcwZXLrp+DOyd+j+ACOXOeO
         wpxb5RxXl233uewaBk1nYosSKhej8guHC942U13mAgwFK0NfuC+LXlYDkKG0iYdGHZRM
         xqWhsUsNefWrAhEBfWAC/WLQbl3eCnDgqEOZ19Q28f47A7PI63DWmk4BvvEZPF1EJOKV
         URxxRszj8zULjU9q8PXlB21268+JBO/q9nJ+1Y3PcIrrAvtShRuEDyDWjSsUTbWq/6ON
         wQew==
X-Forwarded-Encrypted: i=1; AFNElJ8KrrL1oK50VlpWQsQaAzawe+dqTo4umTVf7isn2klPvsnGvwMUT0Sm4UzYsYc8oCjfRkTzR7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc7Wvtk1koYwmMy5Gbg5vpIm64rbZzqGeIU4XWBxn7omI/xMS3
	gzr2o4x+zHUW5I2VFbMdz03IlecfJWmNrH5vYnMpRqLOan9IQ7qEavo7HYQLmADjhPmHcaPNTU1
	Fq5kpjkina9Hkuww5mW/LSl3OsWmH5qXjiigYyTOULLKmpHPb6pqb7qNnNLs=
X-Gm-Gg: AeBDieso3FvQwP5YJoAlrsE13bEN17c+qfho/fMtwznnPSSDyWzl8Jc7nxoui8IeuDV
	KEolBzJl3AVXdAo1BwaBQjf/vzevnFUPMeyKmWce+JigC+gWyId1HEEvTEDKmV+9hsL0eRyA0yF
	GIQb1UWhRAdDGZxNRjptop2rJM7Y7Euxh66tCjV/s0KoDie+WeqGJF74WSn5fcToc0INpFFFqNu
	Lq93ZP8qBauxr2v+lihdv9XmQ2Kov3hUOXMYgY7QusW4itDUQQiGdpNxs/r18EM/HE4cbSZM37D
	UjNU7KDUailTmbFi9GLcV32WOMpq5s9I3vQrnwyWGaiVlG9260pItwpjenGze99L9z56p9Tnlo3
	66HaRRZYoH9E7EJqWvQkidYGPwXui/5Qhkq44LWtj16hcrYGyMIsba9Wvj1I=
X-Received: by 2002:a17:903:2283:b0:2b9:86ca:5bf2 with SMTP id d9443c01a7336-2b986ca5cd1mr44795175ad.30.1777469536310;
        Wed, 29 Apr 2026 06:32:16 -0700 (PDT)
X-Received: by 2002:a17:903:2283:b0:2b9:86ca:5bf2 with SMTP id d9443c01a7336-2b986ca5cd1mr44794745ad.30.1777469535665;
        Wed, 29 Apr 2026 06:32:15 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98893f0b7sm25818105ad.40.2026.04.29.06.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:32:13 -0700 (PDT)
Date: Wed, 29 Apr 2026 19:01:57 +0530
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
        Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v4 06/15] remoteproc: qcom_q6v5_mss: Switch to generic
 PAS TZ APIs
Message-ID: <20260429133157.lopr6n5vaik36466@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-7-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-7-sumit.garg@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEzNyBTYWx0ZWRfX3rsGd6dza/oc
 20TvBGC0EIAF8qYDZ+iEKO3NKg5RTtrjWJMSvY3ZSb++OIyTp54vjfURIflCYC4F7qnw8dw0eq1
 ZQNgArAKiPYdmX/KLVn75reQNfAQSQICh8xqxvNdvOH+6XHT9cmJOJcXdCp1LzkskZmvcjcWDok
 zX/KRwf3N/KrA4rFWEpefPthRfX3MsKq8HX0P/UJ+13hjHwfrLxpGwaMTunKAZOFgszsSa8aA8+
 omhe/HX9G6Gt7Zj6WxI5rISfIWGQgf3CotieST6fQQ5crhK8p+W/3PC3b5oLh1HrVE3Nt0llhxr
 HHOEIfzX95tKMfPNLYsikVnaV6147z9dcJBKoM811gyB8/8WRvG3Md80UVkivUFTo7N1C7vDIS6
 CKFc8ax3nQwAWNCRTwEuNqex+GnWM+9ecZIpRbRwKVzsnNRm2qTbLmRv9qRAUaXqjCUuweISzSF
 TJb/HaCzxI7RfU3s2wA==
X-Proofpoint-GUID: 9oBXDzUpoL1oXqtcKSwkD_MsuK9M9-_L
X-Proofpoint-ORIG-GUID: 9oBXDzUpoL1oXqtcKSwkD_MsuK9M9-_L
X-Authority-Analysis: v=2.4 cv=CL4amxrD c=1 sm=1 tr=0 ts=69f20861 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=UXi9AHVq_sPz40Hf2JYA:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290137
X-Rspamd-Queue-Id: 0D74F494EFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282395-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.ojha@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

On Mon, Apr 27, 2026 at 03:25:54PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom_q6v5_mss client driver over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index ae78f5c7c1b6..96888007faa8 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -34,6 +34,7 @@
>  #include "qcom_pil_info.h"
>  #include "qcom_q6v5.h"
>  
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/firmware/qcom/qcom_scm.h>

same here., whether it is needed now ?

>  
>  #define MPSS_CRASH_REASON_SMEM		421
> @@ -1480,7 +1481,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>  	}
>  
>  	if (qproc->need_pas_mem_setup) {
> -		ret = qcom_scm_pas_mem_setup(MPSS_PAS_ID, qproc->mpss_phys, qproc->mpss_size);
> +		ret = qcom_pas_mem_setup(MPSS_PAS_ID, qproc->mpss_phys, qproc->mpss_size);
>  		if (ret) {
>  			dev_err(qproc->dev,
>  				"setting up mpss memory failed: %d\n", ret);
> @@ -2077,7 +2078,7 @@ static int q6v5_probe(struct platform_device *pdev)
>  	if (!desc)
>  		return -EINVAL;
>  
> -	if (desc->need_mem_protection && !qcom_scm_is_available())
> +	if (desc->need_mem_protection && !qcom_pas_is_available())
>  		return -EPROBE_DEFER;
>  
>  	mba_image = desc->hexagon_mba_image;

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

> -- 
> 2.51.0
> 

-- 
-Mukesh Ojha

