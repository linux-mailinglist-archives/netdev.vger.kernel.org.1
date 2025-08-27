Return-Path: <netdev+bounces-217121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63721B376BF
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 03:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343FB1B668A0
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 01:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA491C6BE;
	Wed, 27 Aug 2025 01:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ogvv1BvZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102421EEF9
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 01:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756257579; cv=none; b=FoW+n5zx4kFUKZiAvRmlipKTwFALQIjH2c6aJMl/Ka9LrBYXdyellEB5M74n0FyHNZmP4WFRGi12pXBUaAELFXyloSM7QrgUhYUFHrj24jOSVYUrgDg75X0PI3CnZcAkydkuaQ3W3cYXsHJIGaVH0pbaAlxJZedHpOC6bHUoeGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756257579; c=relaxed/simple;
	bh=IGCfstwo4XOc0xf+hWEIuk9cHwoPJ0osldUwqBU4B/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbnjTi4iOpkrc5ay8xF9fWiidT6quTsWsTCCIOvd5TgL696CBg81S86OGf4qI8oTzyz1kLpWco08yvFhJi3H2SaZb2MyoIH2bPmM5BqeF8Ms/6E9nn3tbWjT/uCGAq0hJ8YYxM8G5P7jaGsqBS9nKiq8H5U2I3Hl+qps2w/lVaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ogvv1BvZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QFs1RM019757
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 01:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xsfaAguD70cRUExIu/eQLUJc
	3R3/gmniu/91/era61k=; b=Ogvv1BvZzZ7kyjcMnQBqHm6GBk9L1iBxRpAU3B3i
	BPnKoef9dbBIOpHVNMHgwEHZVjAw4axS1zhgy5hcnhPpcp2Z0mEnfr5n13886/A7
	3oVF/8PwMXFOK2U43a0X0+UkkwhKNaCbClHRCGHEvI1wyT40DnOZ2p/vNJIvFvd7
	VC64J4KjVPQkDmjURXuFPvAxk0bm/dWTU5JxrK6GwPnx66uP7jEhi6KbvefBJg3D
	yKItGNJ9wHyPQhUrVpgXfZnSakjDMiumy1rE+FPfsn3i43NTL65zPHH60ZD3HVUv
	SXw5WZmK4CTDqFDkDiqNT9cw8kreDBnzOw7D/WYpYORtOw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5untrpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 01:19:37 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70de1a3cec7so3452916d6.3
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 18:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756257576; x=1756862376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsfaAguD70cRUExIu/eQLUJc3R3/gmniu/91/era61k=;
        b=nS/l2EDZZNM5OHBn8+0/xD8k/s8qBUE41tB1z33kJaDd96fDlZVvtoYsAjgi4W+QHw
         TjAo1Zgw7Os9635DXzD7dL33rGr6KF90GbVhocogpCCGpP9Rxq8JDUIJx5xn8+MjSxvI
         wKZwa7QGISDEQkyrAA07oYiP3Ic6oBAs9S0C5LY3HXmy8lxw7lrhKSd4q6X0dfnhyeUf
         CxSTn4mYs7sYCFecarXAgjrJKPOt+x0OEpG+WwHkvOqyeuwnXidWxqGe4eoA/AYDXD1K
         Ku/x9Q1rytwu5z0ppdardQvGri21y4e6UGXkvCgP6OBu1e1fADgE9WHv0rKXcm8FPeiH
         0WZw==
X-Forwarded-Encrypted: i=1; AJvYcCXXbOm7Mn3LW4geQHKO6YNXpuLxOFbKQw1XYQfZr6PYLrx0ifhLETaZEYREEGcHu0BCe2aRfSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9I/JE2YjYeoCDqB3JirNJz5poFjbvA1FaSWwlRhQMAZ/plIaN
	Iwi/UHK0q3harfqJ1EhkLCGU9NO9La0+ASZE+YF8SBtsbyqFY9qvnJXDNBKNx0ynDN/myoBBf59
	4r5dIu7XFv4QuaS21kcA7q7e/uXoHCVlUcDBuiSZgM1dILar33QlJZ8zOW9g=
X-Gm-Gg: ASbGncsYJMPTtYNYQFtQQPXamIqF+OOasiRx4DD4KF0fcuXnW5Rwy3ubUH0sB/IHMhC
	yLhsvyeriONZWALy3elSkW+SQhHS9wX2mjAOH4m6BMCeQY74BWm32CcYcUxPOR8kbxpMgUA3K/H
	Ze7riVkjORh1GJPxDb8KouHJ6rvRbfUWJSVnS7kdPeKmYzK4Ohoq5IeE2OWqRW2wtPCy+dYsR5b
	uJq19atzxMDgQwESL4QOSz0vMb0hXXgzxtpNgR5YlX2cMbNEmf8a1nIsnm/3f77Q0Q1utsstTnH
	GdpQNaT1wi+836wctRj9qQMn0BxJ89IHazwVgnQbqH5T9HYWBEJ72BZsXCyW/Sw5E8bURuXKNjj
	RUtqBxMvk3EpxURQZygu7hmxxqjUcrxnTp4kbXH0OU6+RQwUVMF0F
X-Received: by 2002:ac8:5942:0:b0:4b2:9603:a4bd with SMTP id d75a77b69052e-4b2aaacf398mr219214611cf.45.1756257576186;
        Tue, 26 Aug 2025 18:19:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBIJX90L8EObhiLkdvR77pF3EwleHjpNvQLWAxyOYReDyxz2hOIAWEk7V784kNonw+M03DGQ==
X-Received: by 2002:ac8:5942:0:b0:4b2:9603:a4bd with SMTP id d75a77b69052e-4b2aaacf398mr219214431cf.45.1756257575696;
        Tue, 26 Aug 2025 18:19:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c02229sm2578423e87.24.2025.08.26.18.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:19:34 -0700 (PDT)
Date: Wed, 27 Aug 2025 04:19:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
Subject: Re: [PATCH 1/5] dt-bindings: mmc: sdhci-msm: Document the Lemans
 compatible
Message-ID: <lxcbfiiw5ierl7r6wmrmkhkyavhysddfb2ndg6ydawb32xs6ju@aq2jkmx4irrq>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-1-08016e0d3ce5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826-lemans-evk-bu-v1-1-08016e0d3ce5@oss.qualcomm.com>
X-Proofpoint-GUID: 3hsU6mi_HuWxkc_3CI5o2SaEiKtpFVG6
X-Proofpoint-ORIG-GUID: 3hsU6mi_HuWxkc_3CI5o2SaEiKtpFVG6
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68ae5d29 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=EhCOwLgeIwc9STI1HsMA:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX1Qj4VFPfkZDh
 GWfL0gZoa1ldveTHJye7OVL/HidrRPEwrWvFeGOCZnWekzhkpMm8bk6mlD54361exbh+jOrE4z/
 0mDhBXii0udL+xqud2prLbfUqMGjrO5FGpBhWP503PltIaroZTvFYXchyf92lR1rEO4CYs0DiB5
 Pj9wTXlirSlJh/u78qaReEsTEtZMXzyBn6aVj6dmBhfBZqlF1WCniWqZ2AXYHHPSQe7korCxboS
 lCBmWXmurGVFLuTH8QBV4naiXejQ97o98mb6P2K5G8aLrYZLJCHUQPhpd7j9Tx2KSc/YHhWruBD
 d/5wN3+RLwcGHeTDhrLyUHfmC7DM2LxeJ6GrBauwjeKK0tuiEqYgZc4iCg4Y8IMOd/rOzSNATdG
 Bsz4EOfA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

On Tue, Aug 26, 2025 at 11:51:00PM +0530, Wasim Nazir wrote:
> From: Monish Chunara <quic_mchunara@quicinc.com>
> 
> Add the MSM SDHCI compatible name to support both eMMC and SD card for
> Lemans, which uses 'sa8775p' as the fallback SoC. Ensure the new
> compatible string matches existing Lemans-compatible formats without
> introducing a new naming convention.
> 
> The SDHCI controller on Lemans is based on MSM SDHCI v5 IP. Hence,
> document the compatible with "qcom,sdhci-msm-v5" as the fallback.
> 
> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 22d1f50c3fd1..fac5d21abb94 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -49,6 +49,7 @@ properties:
>                - qcom,qcs8300-sdhci
>                - qcom,qdu1000-sdhci
>                - qcom,sar2130p-sdhci
> +              - qcom,sa8775p-sdhci

8 < 'r'

>                - qcom,sc7180-sdhci
>                - qcom,sc7280-sdhci
>                - qcom,sc8280xp-sdhci
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

