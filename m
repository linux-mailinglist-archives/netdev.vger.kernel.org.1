Return-Path: <netdev+bounces-282400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNAdBYcL8mlXnAEAu9opvQ
	(envelope-from <netdev+bounces-282400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:45:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D69DE495101
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F8AB3019D82
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 13:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DA23FE66D;
	Wed, 29 Apr 2026 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EpSNPWuN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SqP331y8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5FD401A04
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470157; cv=none; b=enq9OtXo6MXD6BD/ZSWPoS0H81+n7uO/KiAzmq1jJi2I68S4sXbuXlDDmcOLzWVdIgZggUXRinc3/BZRS5aUDjiwXncTr/rF7q+My3E7O618b1lpeRiHFnszkWNysGwGsvox3uYeHG0O4wiABZ2XdLDsD7TgMe5ALmg9FvTE0lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470157; c=relaxed/simple;
	bh=DJ67pB+inv26z87nbeufl52/CsZL8UMBwYrlr7yDzHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2eUp+U59RymEHoV6LFlLxIPep6larw0cMwikRzqMDfk+FKZgq2aOgK4hv5g3Q19ZZvz5EXJmMPfp9YiJJvTQpTH4NMbyVZfibrQjsx+SrFDLDw4DaP3XzQrK18yR+8k6rc3tAYmCMj3gr6n3/Tp1HhJCip4pXxkn7qnKfHTcpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EpSNPWuN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SqP331y8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TCLx342485196
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 13:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ey1EcgzCeETB45FN3v8thWWy
	TAMm9RZnJD/dBNt9Ayk=; b=EpSNPWuNBtzVb7wps9/JYMuZXXliIyiIhRH4k3b3
	fNbr63jYxbM6FPtTcoxEhgqF/7A2aELesDquLAiZclTStoHzt6/jtLrKDqLTVyPz
	ihccrqEd9vpCcMJtPsTyOpb2FETVfGm2/yGO4BRdO2sdLwNltiT3l4mP/kM6rvhT
	PIt29gg+3GzVWDQF36bVgTd++vrhGNLtntM5AhNu8FFafIpGsn5FSwJfJG/5vB44
	EUUAK/0foOIhhioQVurmZe/YnNVyNBigsyPRuwXPSjSLfg3Gek8QAN5Cqkg4/+Xz
	4/TFxTuhm5AJG54FtMBE8YwplkQ6ASXW7APdLpczuO4FYA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duhx908ds-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 13:42:25 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35dacc40f92so12817107a91.2
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 06:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777470145; x=1778074945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ey1EcgzCeETB45FN3v8thWWyTAMm9RZnJD/dBNt9Ayk=;
        b=SqP331y8kNmV4eVdF/Jb48bFzvJjak+ZES5xN7b9OlDOrImK8I1kfMdJpctTwXq8Cg
         BEQTUOcdYGzqh/pPeuSnVEqFdYvgYm7uqa77xv/IOh/59hEGKQoQ63iQwev/c3OqrNH2
         GBo/y9Qac9nA8sEBkVTMxY9R7Rng7uePKdSHd3ENM0iY7LM4l00jjFZTMZOAiutl3Vdv
         SnPP6Hd6lS+8KbDMpXGcH3rMrN3N1vB9aqT8RiNpg3RGn0yqteTA40Qgut7aravSe/H1
         DtGR2SC0b99qSt8Q4M++l+IKHeYLlvY04rfJYVWQ6FjiTdoj3svQ8ObKd6Gxf6hkrrVs
         JYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777470145; x=1778074945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ey1EcgzCeETB45FN3v8thWWyTAMm9RZnJD/dBNt9Ayk=;
        b=ZmoH0M/aTJ7hEradewWy5zrLZ0ZpcdCUx8Xq5rqrtkPui9WF6TmDl+SmwMOGoP+AAt
         voG+pCgOob7Lda/cr1YRkMuyQ8tOdryEdJppz1jfBuvppP6cyvtJCfWqOaFJowuiVUhb
         j5dUX5KQlcsIKnjzGHjOlAaGB7qI5cB1MRuUPQQlhS6AhxbO5SGAKLbQZhvo9LwYB7wR
         SKIagYuqvegZupHafb5KAcQQOZcPEq7Dfuc7juf95xkTbFiH5SaHIwdE7bKCYTXTtvew
         rEi52s2iL03pBYnv7ZhRRgeSPBCQ2ZJFOO3YIsoLJd/O64N1fyU+BIJODRGrJj24xjy+
         6yWw==
X-Forwarded-Encrypted: i=1; AFNElJ8XbC7mu/jhoBrrvZbVqErrLMYLIhtj5FxwTQpMU5Mxwdhsu2iNEO2o6yHtYRk0gvMawmMkkM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn0141m4bERhy1ea9iYBfXsuCxDx6NU/aFsniwzS+gDW1b0BMp
	ZC3bLtWfVHdByMMayT6IXEEVrUJqwxug4B4gM22dXu5CepzgDYJAIu8aGu41uHjWbpq8ZOTuq31
	bL3lQtlbNw0/zfWqt/rNq6kvJ12Y74BZxkLzqRQdRZFbIpiLmJi+oEQYwuUQ=
X-Gm-Gg: AeBDiesMhO8CctRdam0gqqrr2Or52VOatnbDy9CQWMRM0fVi5qnwnVlQ06g7SBq620O
	3shHUAaIxCnRXY2wXyhoJGvkRXx70V9JsI/YIxeelGD8xnyidNemT6njadwPXQuuZGhaL9AGaLp
	nK60djyKmb7IPlHrXW5zaI6zhHpGSpVBbScHgTsgy3pSFI8RMGMjcnbAJ4BppZrKNrCOhf5aweS
	pZyTFlLUAF5KGC/ilYpAcaBH/5ObxXTCI6cC/vKCpUpoTKDlIFschMUU1FHVfHnw1gkxXdC+3pQ
	m0e4oq+NqWgUGH78g2Ms9t93YMfOpqlHPb0OVEu+q66WrSG8PClnZWn3PKGvtwW/9aD03k9QZC+
	CNHokiBXlscDI9tAOtUnJrlOWKCmiQ/xyzf3PxPwARLtfGWulUsi8/EjP22o=
X-Received: by 2002:a17:90b:2ccb:b0:35b:a7be:ae47 with SMTP id 98e67ed59e1d1-3649204fb32mr7693650a91.21.1777470144737;
        Wed, 29 Apr 2026 06:42:24 -0700 (PDT)
X-Received: by 2002:a17:90b:2ccb:b0:35b:a7be:ae47 with SMTP id 98e67ed59e1d1-3649204fb32mr7693557a91.21.1777470144037;
        Wed, 29 Apr 2026 06:42:24 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a27f32b1sm1370451a91.5.2026.04.29.06.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:42:23 -0700 (PDT)
Date: Wed, 29 Apr 2026 19:12:08 +0530
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
Subject: Re: [PATCH v4 07/15] soc: qcom: mdtloader: Switch to generic PAS TZ
 APIs
Message-ID: <20260429134208.pqo67sh3jkvsa5ka@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-8-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-8-sumit.garg@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEzOSBTYWx0ZWRfX2otsqNpRH7Px
 oJkbyrM7sXEQ5aBpIP/0BAJrB9PZSnI0u+jfIbqIRSwFZ2/QBYboCvCHhS60kIDltgWV36/wq77
 sN8CffJZorjc3Xitbe3HRIB4DcEef2x/lUTUm5pi3tOLlNB0WUch/a6ln8P03qUS9u1e34ivAwh
 Cew1vhFgQqYysGgTLC1Nxik1DGXf5iEJk/xwm34pLzGING26hiI0s7z0gqgtpQkKLtYD/kAh6XC
 YFG9mAd4WbyVs8MGvQfFy9SSfUh/WYddyEbi62MnYzAe4BLIrGYPGjrfJIUtIacril7a+K7NL42
 N9mz3HivquVBrUS37ZA4w8OWD+Ghz4tmrn/JMZmPK4A4ajaZNUE+Ln/+m6UZIm/qDopyjeMfCK8
 2uYO6OAUq9wJU5FTFmuXcDnAdXeo9E83XpSnlI2hs5sPy2v8RsWSU4WKfG04nTJgrqnt1ZemUcj
 zdGBDoI4lbwhh5nBAnA==
X-Proofpoint-ORIG-GUID: jXD1QUhARyNxBhQXdFZjnAbHamOLVvm8
X-Authority-Analysis: v=2.4 cv=O5oJeh9W c=1 sm=1 tr=0 ts=69f20ac1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=xqloa5d6wBXDvm8eUWQA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=CjuIK1q_8ugA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: jXD1QUhARyNxBhQXdFZjnAbHamOLVvm8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290139
X-Rspamd-Queue-Id: D69DE495101
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282400-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

On Mon, Apr 27, 2026 at 03:25:55PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch mdtloader client driver over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/mdt_loader.c       | 12 ++++++------
>  include/linux/soc/qcom/mdt_loader.h |  6 +++---
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> index c004d444d698..fdde7eda538a 100644
> --- a/drivers/soc/qcom/mdt_loader.c
> +++ b/drivers/soc/qcom/mdt_loader.c
> @@ -13,7 +13,7 @@
>  #include <linux/firmware.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/soc/qcom/mdt_loader.h>
> @@ -229,7 +229,7 @@ EXPORT_SYMBOL_GPL(qcom_mdt_read_metadata);
>  
>  static int __qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
>  			       const char *fw_name, int pas_id, phys_addr_t mem_phys,
> -			       struct qcom_scm_pas_context *ctx)
> +			       struct qcom_pas_context *ctx)
>  {
>  	const struct elf32_phdr *phdrs;
>  	const struct elf32_phdr *phdr;
> @@ -271,7 +271,7 @@ static int __qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
>  		goto out;
>  	}
>  
> -	ret = qcom_scm_pas_init_image(pas_id, metadata, metadata_len, ctx);
> +	ret = qcom_pas_init_image(pas_id, metadata, metadata_len, ctx);
>  	kfree(metadata);
>  	if (ret) {
>  		/* Invalid firmware metadata */
> @@ -280,7 +280,7 @@ static int __qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
>  	}
>  
>  	if (relocate) {
> -		ret = qcom_scm_pas_mem_setup(pas_id, mem_phys, max_addr - min_addr);
> +		ret = qcom_pas_mem_setup(pas_id, mem_phys, max_addr - min_addr);
>  		if (ret) {
>  			/* Unable to set up relocation */
>  			dev_err(dev, "error %d setting up firmware %s\n", ret, fw_name);
> @@ -472,7 +472,7 @@ EXPORT_SYMBOL_GPL(qcom_mdt_load);
>   * firmware segments (e.g., .bXX files). Authentication of the segments done
>   * by a separate call.
>   *
> - * The PAS context must be initialized using qcom_scm_pas_context_init()
> + * The PAS context must be initialized using qcom_pas_context_init()

Should devm_qcom_pas_context_alloc() now 

>   * prior to invoking this function.
>   *
>   * @ctx:        Pointer to the PAS (Peripheral Authentication Service) context
> @@ -483,7 +483,7 @@ EXPORT_SYMBOL_GPL(qcom_mdt_load);
>   *
>   * Return: 0 on success or a negative error code on failure.
>   */
> -int qcom_mdt_pas_load(struct qcom_scm_pas_context *ctx, const struct firmware *fw,
> +int qcom_mdt_pas_load(struct qcom_pas_context *ctx, const struct firmware *fw,
>  		      const char *firmware, void *mem_region, phys_addr_t *reloc_base)
>  {
>  	int ret;
> diff --git a/include/linux/soc/qcom/mdt_loader.h b/include/linux/soc/qcom/mdt_loader.h
> index 82372e0db0a1..142409555425 100644
> --- a/include/linux/soc/qcom/mdt_loader.h
> +++ b/include/linux/soc/qcom/mdt_loader.h
> @@ -10,7 +10,7 @@
>  
>  struct device;
>  struct firmware;
> -struct qcom_scm_pas_context;
> +struct qcom_pas_context;
>  
>  #if IS_ENABLED(CONFIG_QCOM_MDT_LOADER)
>  
> @@ -20,7 +20,7 @@ int qcom_mdt_load(struct device *dev, const struct firmware *fw,
>  		  phys_addr_t mem_phys, size_t mem_size,
>  		  phys_addr_t *reloc_base);
>  
> -int qcom_mdt_pas_load(struct qcom_scm_pas_context *ctx, const struct firmware *fw,
> +int qcom_mdt_pas_load(struct qcom_pas_context *ctx, const struct firmware *fw,
>  		      const char *firmware, void *mem_region, phys_addr_t *reloc_base);
>  
>  int qcom_mdt_load_no_init(struct device *dev, const struct firmware *fw,
> @@ -45,7 +45,7 @@ static inline int qcom_mdt_load(struct device *dev, const struct firmware *fw,
>  	return -ENODEV;
>  }
>  
> -static inline int qcom_mdt_pas_load(struct qcom_scm_pas_context *ctx,
> +static inline int qcom_mdt_pas_load(struct qcom_pas_context *ctx,
>  				    const struct firmware *fw, const char *firmware,
>  				    void *mem_region, phys_addr_t *reloc_base)
>  {
> -- 
> 2.51.0
> 

With above nit

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

-- 
-Mukesh Ojha

