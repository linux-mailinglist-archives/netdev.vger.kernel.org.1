Return-Path: <netdev+bounces-208015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85087B095D0
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 22:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DD207B75C8
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 20:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90FD223DC6;
	Thu, 17 Jul 2025 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BLkmmo7k"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321872248A8
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752784834; cv=none; b=ii9+qIj0tLDQz1Aqb3hzJRzj/Zo4Z022BAKq4IKtOd6Dsyze45W31FGjf3GTFjWvTjC80ENqa/dda3puzIfkjO3LbkKRKixAFq80dO5wFGRF6xhnGM1ZSe+tZaq592WvjjGSx0LQ4IuCUV+6AvZM8P8f8+g5rdDs/DBMzPhjRGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752784834; c=relaxed/simple;
	bh=+PKURqZUiFLHGFdok2C2mZeAkQagOq/qdJTWlYR6YI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XjmcQHdfPJ8HO8NeaMxQN488rtqGKeRZHF2t9RflSVunybqr4l2byQ+8McxRKNmDVTYTYWwMQJ1WbX0KD8oIbVIZwe6DMonoXEGIoNDn6AMeRz7e2ZQCk1g7Vc+U1tX/ILSiFmGZJNbf6WRDI/le6vlmDugkEuTbM5XSGXlp8Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BLkmmo7k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCRLMA015727
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 20:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HcA+kp3HypSPdvU2NDchUlEnmvRzp6s5z33xRBR58yg=; b=BLkmmo7kc3scYKxZ
	mjfnbXvyG0g7oXjZUoiUEQ44uLA6XV5nH9+mSFD+fAkInK+06RhrU+wF5uqUFPXY
	UCbek+1GQTOFiEvsYUvD655hpeVtv0OYahZP7QFc29/Q7s9AU0n+bdqxit4zCoDo
	SrDSKDeMU2P+x7tTNOxEOTHR6+GhzvPofq9jZzr19qUHAU/zoTBBgXdzXKf1F9Yb
	XFsAVz00EoI2V/4chGHDZsOaC7e/5ZOcZPyuK49/YV+lGWU9v6wawmujcXbSQuKY
	UDjd9RHMkXuQ8FBJOTN9tI5+yasOyvyrr21eXBC+xby4vgIT/6k3RqwygmyWwxyr
	aO7PFQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dyv3xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 20:40:32 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab3bd0f8d5so1909781cf.1
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 13:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752784831; x=1753389631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HcA+kp3HypSPdvU2NDchUlEnmvRzp6s5z33xRBR58yg=;
        b=OHPDNC+zwQM/b+q0bdztDVDyFK6zJQQ/tz9pWzL7nxVCfV5hjEWnytdbqcnN6UO0EF
         U2LhC5PMwaAKjDC4Y3cDt31eGcd/IpiqAlNm6UXdFlj7iGvJP98+88DgFsTcIpDaTsxW
         4EumfK1mzyFEHw0rl6p7l5wcg7b0mUmWE/f7JGM/tZdToFoNl1PTcsNySNzqpeFO1xkW
         S5DcD1BO0+GYigpX+nXIjOaHL0b0LyawzzMUabZpYkZvUIBXJvBgVRbZvPOdrULkFuzl
         ejjT/uQf8getWHPgz8ywSt2LwVjYq2OnW9Z/005c7Pe2zZGk0kHBCyNwhfOOZTPOIA2/
         tj7g==
X-Forwarded-Encrypted: i=1; AJvYcCWM6pDZUp8VmChs89EnGQE47PmPDRFKlQu5nxPQmQg4AZI3yUxNmUsocmGqgBnltTe7eidU3Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4+Bh3GmsrJ1EvMyNPMTqD/s2KetYZJzGCqgAf189mQHgHupmn
	HzWRCRSAZ33d2Q+ocT7ajHukDlvds+NL/EqyWSs0FE/sXf5Xm7UszfY47fQwNj2+Y1uL0djDto8
	+7E4HM0vh5StQbXG3T6aE65IGUCVzXButNM+0BA/yyKyjgX2BdvMboPffBzM=
X-Gm-Gg: ASbGnctsZaIh048ATYMcXtw/afFkdQEKS1jeboj37MslSkiMnEfp5sJGSw0biU92L5E
	QpEMxrtGB4kYEualL1ccdC0KUVYp/5Tiqpc9MzU7bxg8kojBZA8GgjEZnQg42tXUTgsPvacfRW6
	I36AzWOeKJSfy5hRMhK+9+/3J0qFm31fVCDT6Hqe+Q7tqBlPT+Lx9tUhI8v4ouJsqPp4qz0xJG5
	eUD4aa3GAGJuhE4fQfjPc0bUZCtQDhLXm6VerLQ+T2AYgdxbDvrvb+wt9Ung80FEl79tSLJfoBO
	XRvukZZYY/ZxHfCEuMj8oCH9mQw7Z7oL4MZJZdFfqe3HQQfbMqBL6v64yoK53nj22wjdI1bpI2+
	0FXWYvySX/VFhIJznUxw5
X-Received: by 2002:a05:622a:1211:b0:4ab:5d26:db88 with SMTP id d75a77b69052e-4ab909ca3c2mr62007951cf.3.1752784830693;
        Thu, 17 Jul 2025 13:40:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGacEtOK6P1w0TqLkAVvy3zfLW2JrPG0JSKgt/e9kAEeqsdXApuxd5RMOc2e1Ib7SbZf4Jkog==
X-Received: by 2002:a05:622a:1211:b0:4ab:5d26:db88 with SMTP id d75a77b69052e-4ab909ca3c2mr62007551cf.3.1752784829965;
        Thu, 17 Jul 2025 13:40:29 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8264fd2sm1430651366b.108.2025.07.17.13.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 13:40:29 -0700 (PDT)
Message-ID: <ad726c8c-0eb0-4498-a430-f906ea61c80f@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 22:40:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] clk: qcom: ipq5424: Enable NSS NoC clocks to use
 icc-clk
To: Luo Jie <quic_luoj@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Anusha Rao <quic_anusha@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_kkumarcs@quicinc.com,
        quic_linchen@quicinc.com, quic_leiwei@quicinc.com,
        quic_pavir@quicinc.com, quic_suruchia@quicinc.com
References: <20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com>
 <20250710-qcom_ipq5424_nsscc-v3-2-f149dc461212@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250710-qcom_ipq5424_nsscc-v3-2-f149dc461212@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: FRZ9K7O583lrYp5JnfIeTeLCwycMI1hO
X-Authority-Analysis: v=2.4 cv=RtXFLDmK c=1 sm=1 tr=0 ts=68795fc0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=53G8P9gWY_1ATa02Ga8A:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE4MiBTYWx0ZWRfX7B2QVygCzbZM
 Lc9MEecwmAMlC9eeF1TWeCG7Eno1b1I6jyAnHJBnGVrWPKECJc+5N8a4yEhfRwKEQhnHA6R5p9R
 KtxMG57SEiQzJgmCW631JocgKbk9EpIjrUwL/MbERKFTAC4mCYWI/at7vQ9wiOIdkzhl8HqC6sz
 KYm634GYA92i6bH5RgfX6qNCGxBfQbAY/lk/dHVIzf7xAs/9XZN+19qBmcmBNWox4nGWUcjgTVK
 pNCwxKYGT7zHHwmviO1YFeqN5Koe93cdElqCHxahcx9tpGSEkYYTs+N/X9234r8jd+UTr30hcBV
 QILAHqcQqOvHbSn10kxDpKCBc2Bql0q9j439N593Hs23XfX822YDYuav+Qd6jXAp/5qa2IPvbiI
 BDk1BwVxk8jjqrbvd4Np9Buhi8HYz2Sk+AMrs0TgPUNAU6q/htM515To85axflzb0K7fZqFR
X-Proofpoint-GUID: FRZ9K7O583lrYp5JnfIeTeLCwycMI1hO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170182

On 7/10/25 2:28 PM, Luo Jie wrote:
> Add NSS NoC clocks using the icc-clk framework to create interconnect
> paths. The network subsystem (NSS) can be connected to these NoCs.

Are there any other similar clocks that we should expect to pop up
in the future? We should most definitely have a single commit that
takes care of everything that'll be used going forward.

grep "\[.*NOC.*CLK\]" drivers/clk/qcom/gcc-ipq5424.c | wc -l

returns a number of them that aren't described as icc clocks, most
notably the GCC_CNOC_USB_CLK is consumed as a regular clock.

> 
> Also update to use the expected icc_first_node_id for registering the
> icc clocks.

This is a separate fix

> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  drivers/clk/qcom/gcc-ipq5424.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq5424.c b/drivers/clk/qcom/gcc-ipq5424.c
> index 3d42f3d85c7a..3a01cb277cac 100644
> --- a/drivers/clk/qcom/gcc-ipq5424.c
> +++ b/drivers/clk/qcom/gcc-ipq5424.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2018,2020 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.

Please follow the latest recommendations for the copyright notices

Konrad

>   */
>  
>  #include <linux/clk-provider.h>
> @@ -3250,6 +3250,9 @@ static const struct qcom_icc_hws_data icc_ipq5424_hws[] = {
>  	{ MASTER_ANOC_PCIE3, SLAVE_ANOC_PCIE3, GCC_ANOC_PCIE3_2LANE_M_CLK },
>  	{ MASTER_CNOC_PCIE3, SLAVE_CNOC_PCIE3, GCC_CNOC_PCIE3_2LANE_S_CLK },
>  	{ MASTER_CNOC_USB, SLAVE_CNOC_USB, GCC_CNOC_USB_CLK },
> +	{ MASTER_NSSNOC_NSSCC, SLAVE_NSSNOC_NSSCC, GCC_NSSNOC_NSSCC_CLK },
> +	{ MASTER_NSSNOC_SNOC_0, SLAVE_NSSNOC_SNOC_0, GCC_NSSNOC_SNOC_CLK },
> +	{ MASTER_NSSNOC_SNOC_1, SLAVE_NSSNOC_SNOC_1, GCC_NSSNOC_SNOC_1_CLK },
>  };
>  
>  static const struct of_device_id gcc_ipq5424_match_table[] = {
> @@ -3284,6 +3287,7 @@ static const struct qcom_cc_desc gcc_ipq5424_desc = {
>  	.num_clk_hws = ARRAY_SIZE(gcc_ipq5424_hws),
>  	.icc_hws = icc_ipq5424_hws,
>  	.num_icc_hws = ARRAY_SIZE(icc_ipq5424_hws),
> +	.icc_first_node_id = IPQ_APPS_ID,
>  };
>  
>  static int gcc_ipq5424_probe(struct platform_device *pdev)
> 

