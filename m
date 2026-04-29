Return-Path: <netdev+bounces-282401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APNhMggM8mkynQEAu9opvQ
	(envelope-from <netdev+bounces-282401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:47:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 900C5495151
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0ED70302D64A
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 13:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDB2401480;
	Wed, 29 Apr 2026 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UGzhSXE9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kVuZO9+/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D04E3FFAB1
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470232; cv=none; b=aKsXCrwIQsuNq6h9LaqvdWeFV6w2+TNHm05w8/GocWQMqygXyG5DfXH6ueYhmuU9L5UkUgFunLdXIs9YIe1tTjyGst0sCco648+6aKbLipCIox3aYQN1+bEyV/v6B3MjMqp7nePR6C+Zn21MPAMPas4+cLJ9bXu0UBDNQ5qO+S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470232; c=relaxed/simple;
	bh=+f2W0byu+VgJjsIBhy66bJHyN85fytLh2R/43wSGVUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaQYTQ1636i44fv70vD5J9g+yCmGigh8eFWtDIE8nrFy0M/SJQsKVYCtJIsp8gszpm/qhxIindnQV+o4p/Z85LwY1pgEIzgljmjC7dHbiLraSK4lvF0vDU1lgL6gqSIeFNq1gQg79IU6MGyqdyc5twyG3ybrnw2svVHMdXqYNN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UGzhSXE9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kVuZO9+/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8q7bI1721232
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 13:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Cuo4xCs+Nso8hPGN5nUCptMR
	sALAnh0wyrAaKAyxQ3Y=; b=UGzhSXE9TYwEoCe3o5G9PQphC8ttYY26Fo2LF0O5
	+66oGW0pUoGEOA6LZOG3uPuBclDYD3+Goy39d6kRD8bPKycGbACg/ZIsruC4EbW7
	LkOmnmtGJo20nIPdCJW4B137JylhFtiJ/Kyixc/X+z0gTrF203Ly7o/Nhhc2sVaL
	EzfLVO+pO3UCZHmCuycIN/CtAZAcz4LcuVeiUAAtCnh4fFLawDXoIZZeYi5yZT+I
	czUD3cguivawcB2g2tnYE+vVGgBRGuLh3FUE3+ZHjwETRXOnAUVcvaEkE5tgl732
	JJnQl5xEZ4x28C0O6SbW+PhJ6Vd/871B7ZfqnV6zwChS/A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dua7328r8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 13:43:45 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c76cb2dce57so7805060a12.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 06:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777470225; x=1778075025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cuo4xCs+Nso8hPGN5nUCptMRsALAnh0wyrAaKAyxQ3Y=;
        b=kVuZO9+/mul2fENUabxZwULBLhpUaAH+T6gtUn5xTCTKVw9gZPePgJqz8Aov2UsxTw
         tBqmoqTr/9suz1a2+Ass3svmqUUcctuKJ9eElt6+YccyQLb+R8kqmIrIA/mTi/ZkmlmV
         bOIKERMT5UCROenKn3suHuolNd2F4N4rUZ4WJoB4Kt9/Zv6zQZKv8UAH1lZmyNpNOWoP
         R+hoD//j+vZrSLOgYnSHmTZ97/Wkki+xkc5r1/A597xveZleDjd5eTQz0K+PxCcxGxa5
         3h7iIRjuQQuIhQ2tYCrnq5Dts1uHbuhKHJhoqjBa+qUx0LmIe8h6ZEYuL4h0DRB3v6xc
         RtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777470225; x=1778075025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cuo4xCs+Nso8hPGN5nUCptMRsALAnh0wyrAaKAyxQ3Y=;
        b=d8ReUCVze6B7brFT544518ah3tQ1VwMoAKOgD+cNiUlP4Mt+EPCmgSNGmAVYxn7sXm
         CWXUApybkNLYzPjZdksrz5y89bd87+Jt22xr6lXieDNKQdQWs302lNxM1zg+A1s2NXcg
         vQ6SgynjUEWqqzX3WFtAzeDkSOaJ1LaMqcwvBXREmxx3+OkMuuYxxYDr/qNtgTzbLKAs
         y9+Ghtznd5wZnsreIg6sqBJkaRSniP5ILxkdscVvfI8MCj8H+jya3u/Atfh6jfAi8ock
         nG6blRWSHw673EeqFhfm04vNDtxc7QDd2AUEwV8oYk5VXTE9a3Xy1MlMzI7xNNqX02RR
         ojVw==
X-Forwarded-Encrypted: i=1; AFNElJ8InIlkss+BxlRR5MaLb1gHL0bZkKBch8UITbddXZ99tWgQ8fiDAkcscFdXvJ3Zl8aO6I5Nfpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTuuMzEVBMov7X5d8k/cucVG+yk1LB7k4qI/14cdv2gqSnklBY
	bo4fqFQKR9pI/YSBsKOcVufJfMpBuamJJyHSgh6aQ6zQgFcUQrgCQUuD8aB9PF0y2P0TaJ97D6d
	WX8BvoQnpFBgtDZNgn0gOqKFiDzqI4zNcgUqZFM+scG7c91IJxYzkjhLOfpM=
X-Gm-Gg: AeBDies5iyQKhH4c+vheNOM3w4+ewWPv32S5f7ypxCEtv4Kfe372cU8dubw/dPjpQOA
	QGYh5k+Esa22mG010bvfjGVCkyWPpEz4DUbrMVYYK3DnQChUx/1Uj7K7EX3Mjma9PHBQfuX9YYm
	EpNIT6mSMm53pmGTgxu5wMoe+0D6K6sa46Cg8dBg95qYTcs3xi2ZemDfepQMB7bZyUzjmOEYoe4
	JnVhEdMgQYYS7uhWx8UZyjQ9vYw7/5eN9n+bpQP4HXZ5So0vXuKCt/IYfl9IkQjhpB6M0xDWfjp
	tMJhtAwz5dWB8oF6YPhBwtAins2Bo1JX5ifj5oqP65tXHThsSpx0p3gw0rZh2Ck3rAnUpG+J9vF
	5ZlbnDlH53vzfSXJ1VWe4hKLn/gfP1vAmr9otL1Xg29vAjYXj2ZW45GFAlfs=
X-Received: by 2002:a17:90b:268f:b0:359:87a8:e65c with SMTP id 98e67ed59e1d1-3649202ea13mr7870202a91.17.1777470224436;
        Wed, 29 Apr 2026 06:43:44 -0700 (PDT)
X-Received: by 2002:a17:90b:268f:b0:359:87a8:e65c with SMTP id 98e67ed59e1d1-3649202ea13mr7870101a91.17.1777470223790;
        Wed, 29 Apr 2026 06:43:43 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a0115143sm3071343a91.3.2026.04.29.06.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:43:43 -0700 (PDT)
Date: Wed, 29 Apr 2026 19:13:27 +0530
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
Subject: Re: [PATCH v4 08/15] remoteproc: qcom_wcnss: Switch to generic PAS
 TZ APIs
Message-ID: <20260429134327.mna45febpcpakfbl@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-9-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-9-sumit.garg@kernel.org>
X-Authority-Analysis: v=2.4 cv=XtvK/1F9 c=1 sm=1 tr=0 ts=69f20b11 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=FjfCcBgXQK_UEADaTeYA:9 a=CjuIK1q_8ugA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEzOSBTYWx0ZWRfX1TB0sFJrk2wQ
 5jDISa/swtnWK2ty1TziYjIttZjWW92FcgK9cBkQWuvmLsMGAMrKbfssGSpaNxqPg/ArM7yD8y5
 /wnTrFdl9RRG20mxWlSsbWHSaVcoAaMfhq5EIzDSq5rFMY6/zYIn6uvEYZlwvZJCyphSeTQpbQp
 KgYK8P1l+WikN/fjjiQDYPCHLEyC4q2lQ/QbGnOQ7EtSMsYXQ1ebgQs910qA369qEt9BsJVk4Dl
 G/bmBu1gC7EwEsT2lB2hEDX79high5CSW6BHZjcII9+42eA1tYE28IeT3+bjruju4ISbtXqP4F9
 72NCMjKHp3SH0IsGQ+JiRBX2L+naW82pefdbul1vTie16B+Xb8TjivntLNqZ4wufUU7CbJkFu/x
 26ADFck+u6gx7kGxlKlunehTvuXijopB5Ycx7E/nRhWrNpp+G0L4y2g57okTEDFB7L+AgNQ+0BY
 os5simfkowui1qR6OTw==
X-Proofpoint-GUID: 7koUB6bja_lcvx8zPIYU4gbOkWhtopNy
X-Proofpoint-ORIG-GUID: 7koUB6bja_lcvx8zPIYU4gbOkWhtopNy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290139
X-Rspamd-Queue-Id: 900C5495151
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282401-lists,netdev=lfdr.de];
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

On Mon, Apr 27, 2026 at 03:25:56PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom_wcnss client driver over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/remoteproc/qcom_wcnss.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
> index 4add9037dbd5..0dbdd18ab3dd 100644
> --- a/drivers/remoteproc/qcom_wcnss.c
> +++ b/drivers/remoteproc/qcom_wcnss.c
> @@ -19,7 +19,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> -#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/remoteproc.h>
>  #include <linux/soc/qcom/mdt_loader.h>
> @@ -257,7 +257,7 @@ static int wcnss_start(struct rproc *rproc)
>  	wcnss_indicate_nv_download(wcnss);
>  	wcnss_configure_iris(wcnss);
>  
> -	ret = qcom_scm_pas_auth_and_reset(WCNSS_PAS_ID);
> +	ret = qcom_pas_auth_and_reset(WCNSS_PAS_ID);
>  	if (ret) {
>  		dev_err(wcnss->dev,
>  			"failed to authenticate image and release reset\n");
> @@ -269,7 +269,7 @@ static int wcnss_start(struct rproc *rproc)
>  	if (wcnss->ready_irq > 0 && ret == 0) {
>  		/* We have a ready_irq, but it didn't fire in time. */
>  		dev_err(wcnss->dev, "start timed out\n");
> -		qcom_scm_pas_shutdown(WCNSS_PAS_ID);
> +		qcom_pas_shutdown(WCNSS_PAS_ID);
>  		ret = -ETIMEDOUT;
>  		goto disable_iris;
>  	}
> @@ -311,7 +311,7 @@ static int wcnss_stop(struct rproc *rproc)
>  					    0);
>  	}
>  
> -	ret = qcom_scm_pas_shutdown(WCNSS_PAS_ID);
> +	ret = qcom_pas_shutdown(WCNSS_PAS_ID);
>  	if (ret)
>  		dev_err(wcnss->dev, "failed to shutdown: %d\n", ret);
>  
> @@ -557,10 +557,10 @@ static int wcnss_probe(struct platform_device *pdev)
>  
>  	data = of_device_get_match_data(&pdev->dev);
>  
> -	if (!qcom_scm_is_available())
> +	if (!qcom_pas_is_available())
>  		return -EPROBE_DEFER;
>  
> -	if (!qcom_scm_pas_supported(WCNSS_PAS_ID)) {
> +	if (!qcom_pas_supported(WCNSS_PAS_ID)) {
>  		dev_err(&pdev->dev, "PAS is not available for WCNSS\n");
>  		return -ENXIO;
>  	}

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

> -- 
> 2.51.0
> 

-- 
-Mukesh Ojha

