Return-Path: <netdev+bounces-219116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1977CB3FFD1
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D861B21CC9
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13860307AF2;
	Tue,  2 Sep 2025 12:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eeyr4qBs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4522FFDCF
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815102; cv=none; b=WfdtYHEe2BFSPR6vW/npaAa3LKmuQXQZTK4u8JqjQHICZ1WevgurAsWszaQVYqFlpM+d+fDZkcEUXDaw8y5i6ICDLaO/nH+KcmcNOP8cAwB+8djfgSA0LQMeE9KjQQ6ULMUNnyhIFPTN6UwTmdlcpiv6G04RPHOXzxc7CuM3iwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815102; c=relaxed/simple;
	bh=VKPh/ct5Q5m08hxDCp/EDthmOiS6ucPULO1VHGN1G3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjjSFeIXWTjG2pzrBu5aCN5CSSFbhT4NvVgCAl7ElOBqrZF+kOlzZcCBr4zo6nSSnMCfyW9Ae2vATX+AXmVgQdUIRUxlw0ra2XGKyoDsF6m58cdByCe6AxTdl2sj0dQcmAFPikCP9nJkMQJlfJI7m+IhjHZZdIN+gYy/e7Y0v44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eeyr4qBs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582Al7lL025161
	for <netdev@vger.kernel.org>; Tue, 2 Sep 2025 12:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R9+3e9dP2WaVs0y05qgMULMfCunUKyox0pXutflnw2s=; b=eeyr4qBskZ6+frZT
	07ReQadFBKOtqTEhsmyQ9kul7fEYeJO+8J+mQQrnwuO9rQRVpNFrYaAe64uu/GEo
	6/5vGMmjfknMejSA6PujLNvCS6EFRzRGKZqestEKJJa/sn9048M+hHwnRTOFHwAy
	E6Er00oehkoLqYqQ7+xhusvQpk9CZjTw2AxrXLBpj7XC57NlJtCG3EUpc+wzZGWl
	UvM1H/10mMCF6qEEBcDTql2UJQtV8v4MUJ0si0QCTMQcphEJy8Egtbsj8tmbJyh0
	ZGoavm0dRVgWfvUM70fAqplEaWxM/mMs1p5punMdgb1qB9AIRCyAf0tLumVPfaFP
	sw1wtQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuyrca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 12:11:38 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b32dfb5c6fso11117831cf.1
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 05:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756815098; x=1757419898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R9+3e9dP2WaVs0y05qgMULMfCunUKyox0pXutflnw2s=;
        b=pQd3lY642+ciYABditttAQHU7PmuOivZ//pbglaqGCOYQjgchKXG0esM8mipjbaMF8
         OqIY3qNDuXRr5cOpgMIsNHDDYdYJsr5mNnvxdl16x3QYd9XSXnwTklAwssI/PCGcWl22
         +TCL7QnEvSOjcPagvh0ctyp0SLDdfhtQVAbht2bbfJ5bWcFhb+puQ/gOdC1VxtXRyEM0
         I9nd1uquyPpaLTa8ONh0EItF7+81fcpB1vuawwizATa6lqaZMnHHkcI26L37so46MTqD
         2Gx9D8lp4Hst6kHUr8NWJS+X6PebUvgbR1IacTMxTUS+WvDcMREg2sa3XEm6X1Ujx9La
         Kzvg==
X-Forwarded-Encrypted: i=1; AJvYcCWC3tM8jdX2eMmpHb7DbSLYjHabJKEWALJSLer5XvZ91KXEoqyDwOgXzOcHKDYNa7qzaWFyNGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFE7qUq5VY2NsUk2/XlyWQkzelhusOJpIFN0CWzfNB0nxzfKok
	Dmm6STc+EoSpQKB5h4vUmMsqW0akWc9sKFE8+l3Avv4bTB/lgFRvTcOkJFvdMTNxOtP7xvUjHIC
	XWUwJ9ZTafTjL+SJaki5ETosCH9WyzkA3FxgRdBe8Yd37ODcBNjzOBDXvPfc=
X-Gm-Gg: ASbGncsahCbui4bfgdTdFj4StQIJ0VQV9KuSl9+FHw+kB/2z6lk0YJdRkW3nYp5Vyug
	EhFngAtwar5ssWSqg4BkItTDl4fQGxKdCV2kt454WO5i4+P8awAQi4Sbbq7z+Dr6Uj8KqXYJgxi
	VqPeh/wjapm7yhRgB2SR/Vf3qqhQj1zp901N04ItfbOqRpWw3GvbcZwz8FOpQE+y+g3GyD0PiUL
	LE/gh+xYL1f7RpSu6lLh4wZAwdSeg+KFj+/IP/M2fNPNISnqDzZDL09YsrFnjL0m2FGVs2xoP0n
	gRGRqwugf2a/EQgMBNdZEcr7BNNFg+R84CvlmBy0mWjULJ3NYCMyxXWtqpI0sYifvwIUQMZaBFl
	SRXO7af4P0e1urP8BUmFLOQ==
X-Received: by 2002:ac8:5710:0:b0:4ab:723e:fba7 with SMTP id d75a77b69052e-4b313ea00camr114042831cf.7.1756815098018;
        Tue, 02 Sep 2025 05:11:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwW4G4jjkaUKtXkdS+GHMSUK5ZRdAh64PysqQIkVPG7KSVbGILFSKErYbYiYkdMuTYCelzhw==
X-Received: by 2002:ac8:5710:0:b0:4ab:723e:fba7 with SMTP id d75a77b69052e-4b313ea00camr114042341cf.7.1756815097447;
        Tue, 02 Sep 2025 05:11:37 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-affc2fac683sm873825266b.83.2025.09.02.05.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 05:11:36 -0700 (PDT)
Message-ID: <84c48543-815c-44fe-9334-ec1f688e9639@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 14:11:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] clk: qcom: gcc-ipq5424: Add gpll0_out_aux clock
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
 <20250828-qcom_ipq5424_nsscc-v4-5-cb913b205bcb@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250828-qcom_ipq5424_nsscc-v4-5-cb913b205bcb@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX6PEkwE6l3TNd
 skwnZhxK3LU54BBUtC6VINBX9zgUMXCDDRyW/Drz7kfl/DnJIcj5pr1TKQ9seVM4KONHOw+xUI6
 oAUBMNnDIcV+3qUyF6iBw/XLb0QNiN5X3Il0uT3EaSSsX9CEJ6jTLGFTy+etAjvqAfHR0MRavLE
 /idiB66xw1/5hh06pF7KB4UL/RiJe5S6B1cH9GSm8ieHRXX+Cm6LejMOoajWS2XgYG6oEojGQEM
 cTvFb3wg2cSvfyErhBNG18b3vMxf83iB/XlKxV4PvWuLBQ2KMK+xCSUFE1Rlz9IvBdefi8BLfp8
 NWuiARK47buVdENx7lyBimp/joQVMo0VYYt5HwJc56/soDKwAkALg2/WXHaVI+b4/ELZgDV/Is0
 mjVVE4/x
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b6defa cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=xy1T5CxqftMPibTtt60A:9 a=QEXdDO2ut3YA:10 a=jh1YyD438LUA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: qYPw0WfnwEaKT6m8rkEqIpfX0E_Si0wN
X-Proofpoint-GUID: qYPw0WfnwEaKT6m8rkEqIpfX0E_Si0wN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

On 8/28/25 12:32 PM, Luo Jie wrote:
> The clock gpll0_out_aux acts as the parent clock for some of the NSS
> (Network Subsystem) clocks.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

