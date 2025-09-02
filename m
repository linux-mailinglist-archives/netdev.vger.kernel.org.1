Return-Path: <netdev+bounces-219113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 205ABB3FFDE
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24041543CF3
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B983009E8;
	Tue,  2 Sep 2025 12:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C+/dY4wK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515792874E3
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814839; cv=none; b=Xm3WpHNHZvzL5v2E7kYvWfdAQlQQVxSQ8AjoGWTPhNXb6ZubO7sHpLJeHaDqluaOEsY5OLUEOdXxOjTaETMb8x4v1FFKj084x/l7cq9fBxubeA3blES+B4uKlQXNLC1WWZURWusg2JFPPqjhPqf4hwl8GSqzyOpVvIRHv7SWc5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814839; c=relaxed/simple;
	bh=xt2M/EYFY5LLWVrahB1ctY3E6iHAceS7dO6dEG4T8u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/7io+IInDLbAJ7K5JZEdygN4BX05QLIS9ibrYDnMjYOyK5678FiOFOYumW+4Yvp/ZeXvuAkOJ4D7Cxp0zB/pxgswxXa0fpgHo1PT0V69IBbgsZT8U6NKmCQX3U1IwaGguFsb2VV0nbStU49H+QzayzD12pwVn2yte1jcTiMZD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C+/dY4wK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582Ab2K4022312
	for <netdev@vger.kernel.org>; Tue, 2 Sep 2025 12:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ooAgjRpTHNP8kFwOiUKb9Yh/50coU4iyP/eWLaeMM00=; b=C+/dY4wK+FzU9XOb
	4osh6w2fl+WAynCdo5SXzupLhtwkiwRNhcT3l6gtaar/Z3+ZahQMR39JtpSBSuG3
	gxQuAdzeJGV+Ju501Y5mEcDtJPK/cHL3vmZ5W1RBIGUEwEbvgI88sOoXcayivoX7
	wh4Z30+NyS1+BBhYBZj/RSmJA2+02EKmu/rZ0SpnDPeaEAZoqts7cXRdEAuPVuaV
	79xq3DTGKMPsbhnCubvOers1owdLoI9touOy0qusIc1eyPTfhfIc9s1wmc0QnigM
	6G37eyGQyuE9MTejZwjgz/pE/p7uYyCAy6OS3K/x42roEsPi54Y3boGKZb17KOSx
	IROvKA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnp7ujs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 12:07:17 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b2d1c2a205so15957651cf.3
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 05:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756814836; x=1757419636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ooAgjRpTHNP8kFwOiUKb9Yh/50coU4iyP/eWLaeMM00=;
        b=lqzLTZiM1+cXCJWZTJecEE96yyBbneXlZMovy0KPdD1kNbzeowaXDT3TOgvhxgSPmy
         B47aNQ3kJgKoSjGRoblrL+9WfzrF+9j92PyzQcC5Mc1NmW+8kMBHzKCV5XgpnLjdH4pC
         /Bo+zLb0+qOR7/wqi/4qojB6ru6W1q+mLHqLxQPoElSuXniTabtUL0Ij0ZGdYWP3pAam
         oYrU/uCDtDrxJSk0cC3ywxVFlJ6YH4f8I8+ib18ZtOrWvNT6Z/Ra7+zu20gcRxpN5597
         n3h59UVZxujDTT4ufB8QwtEnHVwjQY13sCAIjB+FoqUOC4SZ3Utbt/6T0mQerznxZnok
         SAng==
X-Forwarded-Encrypted: i=1; AJvYcCVD21AhSgF+SUdfcGuLsvkmYZTnUDcXLhBuGz2VXkeSRs6zshefRhioUqttCkJnI4PDe73+9RE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd7pOle91+oo4E1YowboSsJn128Zry36gnZ/+qT2tAKnEmAEWA
	yLko1Z6vyEhQ9XVt0Eu85ThR1JA9s1jwA8o7Y6X0zwlRRmjNsaz3CxbVhXZF1kXap4RGnOBMnhw
	nF9uf3k8HSn+O1AE3CmxHoh6vRmrK+BcRBp7nhwZzpXyl4gjYDejSwpZdKAQ=
X-Gm-Gg: ASbGnctcl3KiNo3VUYjE2Ri/oEde56UKVPhDpZw8/RgkSp2g3Vu0OdrAZs0NhSbIJqk
	/WMYt094H/RIVzsdMj0G1kd1YfVwaWUVB13qD4iI7jFW3pbbSCzh1trUn2AEOFU/0QVSZYH0lHO
	OoiqVxMfaklziUJiVnBG8IMoHfv9X0UTsbvavi5eozres4pmv7rMcPD1Ff92Uratl9unYXvI3DW
	wPRmvIVyzrYWMzRtAFUUkEPfLUIlyeRTRCnvWeh+muLNK4jtpZA/Aj9dn48CgIRD8MSp5XZbMNq
	2/Fv74FdE/TLzdTN+LC4hDXgciEQzwWCcr0UbGFjVQ74/m7iBEV7TFisIARi1QOND5zr6Liq9Hc
	hgAkaxxLqw1h9OTpqiKM5ww==
X-Received: by 2002:a05:622a:164d:b0:4b3:d90:7b6f with SMTP id d75a77b69052e-4b313e6f3aamr104880761cf.6.1756814836084;
        Tue, 02 Sep 2025 05:07:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi7UgyhFAah0VP0bJeUSU1wMpek7APbVlPpwHN7xSB0N6vFLNU7Pjd9+3uvDbCoDIOTsYYeg==
X-Received: by 2002:a05:622a:164d:b0:4b3:d90:7b6f with SMTP id d75a77b69052e-4b313e6f3aamr104880181cf.6.1756814835494;
        Tue, 02 Sep 2025 05:07:15 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc52ae40sm9249215a12.44.2025.09.02.05.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 05:07:15 -0700 (PDT)
Message-ID: <e9c70483-8538-4f9c-9dd0-b4136b34a667@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 14:07:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] clk: qcom: gcc-ipq5424: Correct the
 icc_first_node_id
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
 <20250828-qcom_ipq5424_nsscc-v4-1-cb913b205bcb@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250828-qcom_ipq5424_nsscc-v4-1-cb913b205bcb@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MHSzY07OGDz9YtjzhoUkoAfnzpbJbfNt
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b6ddf5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=5e-Oaz1CA7JNmZ_uPyAA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: MHSzY07OGDz9YtjzhoUkoAfnzpbJbfNt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX4aGsA+oNel1b
 hOJfCRJDizqL9Ni++71LGde17oE29lulbY5mxY04DmMOOFDSF1yCgRVnEhIIsSV+pA/8k86FG1n
 e34klyc3boEnLWS760tEmMTW6k20Xg+pzFuXz5JZinri7ZlCPob3Pgrdop/IVYjjEapoqtcS06O
 eKQ+8oRWM6zTmSPTecFryj/Vjqqm5ds7Cegb5sGRp7/dV0/lLEQ7bMMDsfREP6+AVjdTlWIcfpj
 ts7wKfFoOT6TMMDps2KgwOS7+MbmDocyPoSUwjUZwIsGlcA1FZVXBtxr3iBjvWaQaU3aZta9Y5I
 QV867uuyZr+kAxBh6YGWaA2IXDiRyW5zkaZGGCHGVA4v1Ir6QtbJP52b7px6JH0gmFv/SXo0ZXL
 G8G3a5va
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On 8/28/25 12:32 PM, Luo Jie wrote:
> Update to use the expected icc_first_node_id for registering the icc
> clocks, ensuring correct association of clocks with interconnect nodes.
> 
> Fixes: 170f3d2c065e ("clk: qcom: ipq5424: Use icc-clk for enabling NoC related clocks")
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

