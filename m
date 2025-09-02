Return-Path: <netdev+bounces-219115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58A8B3FFFD
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCEDD7B78D9
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207242FF157;
	Tue,  2 Sep 2025 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wzt2ivyg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5BB2FDC5C
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 12:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815079; cv=none; b=eAlPGCAbBoaHLlM4+VEH3w8dDgHpOvpKkybiU6c3j47u5DHrMcUWrno9JAmLcj1VOR+x1Qm9xQwrshlwjQKPE83cQj0oqAXID+6DBJ5MIdHoVcoVItBJ3IEozzYmZh4xMVy5Pvpon1t9C2OlSqstrDmitC3MbIB6eSigri1iomI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815079; c=relaxed/simple;
	bh=Q9xhz7InacewkR2sL7hxMKTtf5/Apj8ua9YctrXUMkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fWWYyPldjr6jgowSwS43QBpbZI/TdjJmDrfJjjLnpbVlY5zZ5pJ1RiQh08flXTrK8S8zNAOKyUFCecOjfAReFHWxwn4MdFT+kIcf+MyP2xb358rhkdJK+7diUWvY6hGrgqKOoY+sl498FFKRbi1rP+vNRQveX4NipBjRun9Xqj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wzt2ivyg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582BGFdD010341
	for <netdev@vger.kernel.org>; Tue, 2 Sep 2025 12:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4vrt0A6ANjc79IaqhSJY8cPh7b4X0YAYPY/tdBRrzog=; b=Wzt2ivygiUPCUSwo
	BJAREK+B3YS73ADn7xyrkA3+Yid4oH+u/ktvtdOE2h2Aqx7mOQvkPPDlD6icrrBG
	8S9OW/8/QvXUjbtHgz39CKUw0RxZSjXRqA5DAMW9zUkdmOR4kMSEu4CQVKMcDxQL
	YNw2ENT48z1OpYcLawqx/abCCZksctaQ/99bSs7lkAqi+RDh7ajNPQ4E/st5RjgD
	RcKslF1kElgGzipF2lbQaJ5EUcMdEehlpngPrqnctql7iLR2r0oVhQF+QbHBQowl
	cD12I5MpBTvQbz0xvmgi8fcKmPSvYaqak+HBgFOtdKQwOhENbIiWtavOo1N/T5UT
	ett0MA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjfptm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 12:11:15 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b32dfb5c6fso11116501cf.1
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 05:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756815074; x=1757419874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4vrt0A6ANjc79IaqhSJY8cPh7b4X0YAYPY/tdBRrzog=;
        b=is0HNeSB0iIbEGpfMFgKA2/Bmem9bcMXtV7PoS1gMe7skXcwN4h3MRmcCWCyh4NhGE
         aXn1d3Zc9e1xFI8deLVGs7bveBTJi0qpCT32MpS6wFq47Ic3Nwqizm6nkV07JcrdjBJZ
         eHdi+VYuljilcbnauLY1k98AliLJh/9Qyd4sOSSAiCQDPF0d8kR8qUEC1m25jdivGPn1
         sTOLEFgs0G9st0hvTC4S0db5EFCSJjciWN+IKt7fehE0vB11hkMK0qmMwe10OXBwBG9w
         deGXkMh3FyEGTOdgTFaMdAYFxYXZCfpIRr9cjMqwZpMfDsv4MYUyTatMp+KcQS8QlZiu
         WWZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoqJsd3X5G+TOuk1ZfzWpD7XYKW+c/4RJl2SijvvKv87eK1JExRfP67YzvsdqFJOMB70HSMPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw6rRaXUcKJYS4RCAWtCorX6p+3P0ZCoDOtch8tjszr1QHAwpA
	49k3tO+25iDwHMNzzQVrGxM1/vPWJk84QqY4Si+E9fNV3WT+i9XNrGbHc4sk09kCmRDgST2lVTM
	RHsWBXff4VakZCSCZ4S4ez59jDyQigLbT9BskIWoX7obfjjLM8SXVGkd0xbE=
X-Gm-Gg: ASbGncv+DUMnWNQMvTpaY7BRdU81aUnvbR6EHAhZ9tLzj/+U/cuXucyaybDclC/FUxV
	975ugxdJ6NlfooQWINLUgybcBWFXK7q9Nx/uqUrHLG52YZYxrfzYYSRiYZVDkK9pkol3r9MaBuW
	iBmiWI6KlQTvF5Z3yGyj/rNw0TWwkNQGlz0VbEn8vv1j0bMmYwKOlFwiPgf00d+VHHdKiBLrgIW
	6H8IpP3PnvqyPfWT3DQLjsC14F3zFrR6n0xnnInw17gxMfeQfbZKj3Mawf8YMF1zJqrM6BCfNEJ
	Rcmm7NKq4FRNkiAeuFhG6L1mfiLWVVbFI72g80B8TYbJ3LYB/OGVvo5+iGCO1W0GKHn4MSzenev
	xq7OngBmA65IeT4cDh4K+Zw==
X-Received: by 2002:a05:622a:241:b0:4b2:fb6b:38c2 with SMTP id d75a77b69052e-4b313e63155mr114514221cf.5.1756815073703;
        Tue, 02 Sep 2025 05:11:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3KfpCYj++Nh+x6sT1ov8IcNZd1mz0M6lJHlQz2dAizYJPZViCf3FEA46K+1XVLTY1Q97W+A==
X-Received: by 2002:a05:622a:241:b0:4b2:fb6b:38c2 with SMTP id d75a77b69052e-4b313e63155mr114513821cf.5.1756815073082;
        Tue, 02 Sep 2025 05:11:13 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b040f1cf4b9sm698003666b.29.2025.09.02.05.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 05:11:12 -0700 (PDT)
Message-ID: <b2838f7b-8da9-434b-83aa-fa117bdb715a@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 14:11:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] clk: qcom: gcc-ipq5424: Enable NSS NoC clocks to
 use icc-clk
To: Luo Jie <quic_luoj@quicinc.com>, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com, quic_pavir@quicinc.com,
        quic_suruchia@quicinc.com
References: <20250828-qcom_ipq5424_nsscc-v4-0-cb913b205bcb@quicinc.com>
 <20250828-qcom_ipq5424_nsscc-v4-3-cb913b205bcb@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250828-qcom_ipq5424_nsscc-v4-3-cb913b205bcb@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b6dee3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=DdE-_dUAR9VioeaCo_UA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: dJmI-3D-LSmrmTdh7qIRATOoLrZsR9jf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX/FUbz3n9DTP9
 ies5/C9ba4l4YWY+0ZddrxboWys314a8moCR4Es74aRvZBq1BUi398VYjeMM6B3IYv3Pe4BgZDX
 MI/CeyC4JRAt4wQuxQVRWRfZnYVjl3y51OkHrtvfB0M9zeMnnZXIG+x6XWlOJUAJK8o49MUUw4I
 2lXCXHgvMZ9EF9/Jd9yvzefaCi5qpb+EAF4ge6kkMvP5DJMFiD1P7Ok32rmfnAf9E6HxGIr2N0h
 nKVKQown8aZ69vTpX8IaGNnLupPjyEVYeJgfMS/n2mr7+yr3kHuAR2TTIV2WFgf8NTzY3uaxpA/
 Ug+dZluDlolU7AK3T0KdCQ5r+VuSAOyjTjOI21dOn5kRhphat1dVyoe8bMbbDgdOwYmEsiCRMrm
 wHAeFpOe
X-Proofpoint-ORIG-GUID: dJmI-3D-LSmrmTdh7qIRATOoLrZsR9jf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

On 8/28/25 12:32 PM, Luo Jie wrote:
> Add NSS NoC clocks using the icc-clk framework to create interconnect
> paths. The network subsystem (NSS) can be connected to these NoCs.
> 
> Additionally, add the LPASS CNOC and SNOC nodes to establish the complete
> interconnect path.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

