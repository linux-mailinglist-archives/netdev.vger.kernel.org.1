Return-Path: <netdev+bounces-201983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0765FAEBD56
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 18:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B037016288B
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 16:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13ED2EBB9F;
	Fri, 27 Jun 2025 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bDXLCAQ0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311AF2EAB70
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041648; cv=none; b=af4gSpDrHm40roCwLM+IxbdgZSkfO3T7t7xvBXiP12++0SSry6zonACKMQxepuq3eVSzT28uDEVe+8Qeohdl+CRi1ODwetJ21dtJWNnTXN8H6GftpyUS8CUahQdzENWhwqUqpQzHJ6BdTX21wvdC42GCWEiW6uPW2iUFP5/SI+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041648; c=relaxed/simple;
	bh=LRgiyfrICsKTlHv9IhC5r+4XBxhCMDaKngyow+IGVj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JjCkS7VoC1B9R9k7j2bRVYRrEN51b/BLlvPyTUC3cZwbFMszqjW04qjRcYQf201x0aksi8WJiyROBfGRX1+fRsjfdKYKsO1gZjC3Kv00sWSXfk78XJ0bTRsbFZQ6nrO2FY7VqLGFN2M/+yKpHtJN+v/c7Zq/A/6hoD3Z47E1dKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bDXLCAQ0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RBrUVp032671
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 16:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lvYd1deVAhihvBAnBWJn94CrhAU80ERbjP9yegxtMRc=; b=bDXLCAQ0cbgCnzoi
	lm+zHp0o4lGhoQHyD9gxNOKnTFOFDsTWHkH8HmlD5/uBJW4rnl8cXb4Iiurr8HK4
	XWXZUjskbqOFfdlzu8eneXoVRrnHQ0izL8V8U8OGPVNi+/19sBQkKUkT0qngbbsz
	e6H8F3kGVCBMhN9ByxZkXMJfSy/TJnOIRDEDzWtUNA7vCW+VYrAGwBcyNr8ntvII
	HNexMP22VMPgv3qVSUFsSxkjm5C/EVvoDKtIgW4KZ/4PGBIG5DNfUa6r+J3jnP0d
	kzQsq+hYUyJaCEOlqcb7dIarRz7UZeNBOPCWu1nBFcZZieEKow8ZsZwgO1wTFWZP
	yn6sAg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47g7tdhfh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 16:27:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d09a3b806aso43411485a.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 09:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751041645; x=1751646445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lvYd1deVAhihvBAnBWJn94CrhAU80ERbjP9yegxtMRc=;
        b=SY1OVJcVZNEp9/4P+Ylu1zbYrekBJ9qlELH2ezr70t/bfxVS48XjMTSOtWI7/+rLFE
         kk57WmCch9TpWUDQk/1qTXFyIVOgQXSvRCRh8XClfpWQhrhR0KHC16EhmoOtw+HI4LpN
         V1jae794UmfQQhA8oeK1NiLGsAqP9b4358ZZHa+l13kDHpldw2E8cwmqlKxM/eRMcRJA
         ytnrk6wz981SUY1N+gTJeLakQNF17ihcsL5TBcZkHNcOt3h7qjSnb3iYjxhdPXVkICBe
         3brRr5Fg500bNR3duE0wT2XGhjOOX2G7gzGbPN+F766wExUqfWToTRWDXhwVRY03VPAY
         ZCQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9yb65YZoIcrpfc64K+5CXxNHibymP4rgO8RQVeXRY+1XxoKQ8eTEeIRN2g4g1ep0an3hT84U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgLdHUEJYlqQwrG6gaAk/3HUd+D/8X2LmQaYEYYYJXy+Kpa4//
	80weOU0QLE1xvvaW8RN+SPCt+StLaJwT6d6HlxJV3t43nlpkTZ6uyaQWzKAXaMzHr+/QIQO3mBz
	lMkCICx3w5cvi+zvTNgdZ/YWEAJnBxr6jIyjpS3eYCGSJ4qvvHxp9QYekEko=
X-Gm-Gg: ASbGncswgPYT/GXz6OcoZtXnqR1JZ94rDNIabzeSFPUg3gKBzxVriTBC8tSVcFLqkmk
	vvNrtfsjrSKEjS2+5Yb7WTifD2wdG8CFRlM9R6VxUMEb1WTLYfSyX6DlSzognVr6kJJX2sCaf9P
	Gv5pXkEFE9U/RYqw+k1Lq9oyuOnh5ZWUxqiYRWIOMaikObpi1hffs+jk20rxiV+aJigXauAR2I1
	3FmkRdaiLOUrGihBB6jxRozhMZ4bSZy8NbN7Shy//wht6h/hgv7EoibJ5bJb0XVAqRMM4PDLQi2
	QV8rY6yJ/WZPA/lZ47qLfxG7wcc2JENwoWIyG0RXiRSMK8PuUQgzuLSqtwFcNs96tWNvVnsj5fR
	pjvU=
X-Received: by 2002:a05:620a:6011:b0:7c0:c024:d5 with SMTP id af79cd13be357-7d44393af52mr224994485a.8.1751041644589;
        Fri, 27 Jun 2025 09:27:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQx+88Ksz4ECZwUoGt+Ed4X8fsAOVBGWYUZ4j8qk+znxirQR95/4sMWkJF3ZwWKFN09XhTLg==
X-Received: by 2002:a05:620a:6011:b0:7c0:c024:d5 with SMTP id af79cd13be357-7d44393af52mr224991485a.8.1751041644137;
        Fri, 27 Jun 2025 09:27:24 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353659e12sm148855366b.40.2025.06.27.09.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 09:27:23 -0700 (PDT)
Message-ID: <cd6f018d-5653-47d8-abd2-a13f780eb38f@oss.qualcomm.com>
Date: Fri, 27 Jun 2025 18:27:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: ipq5424: Add NSS clock
 controller node
To: Luo Jie <quic_luoj@quicinc.com>, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Anusha Rao <quic_anusha@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_kkumarcs@quicinc.com,
        quic_linchen@quicinc.com, quic_leiwei@quicinc.com,
        quic_suruchia@quicinc.com, quic_pavir@quicinc.com
References: <20250627-qcom_ipq5424_nsscc-v2-0-8d392f65102a@quicinc.com>
 <20250627-qcom_ipq5424_nsscc-v2-7-8d392f65102a@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250627-qcom_ipq5424_nsscc-v2-7-8d392f65102a@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CPYqXQrD c=1 sm=1 tr=0 ts=685ec66e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=f6GukiY9ARMaQ3Zrt0MA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEzMyBTYWx0ZWRfX34YSaVuHajvi
 xvGG7+VdVjd8EO9RoNL5PckwC4M4/VRpqzHejSNr08CWQDDG/8Q7VQyRhPnThcOO2OfU8Lflbsi
 YjJJKJ5zkki8TMbFVqco2La5bDqOVABPSD32AuNYEio4JCI3QdnvKx17361pGqRTbOoA3m++YGo
 XagIF2T/a+d68YjqRaT8cHi6Kdp/t8U5Vov2tXMnxyWxG5unyhBE4aEQ+Qwp5darR3jXhP2Jgb2
 g/fFwJuSdl4sDhlu4zAAEBpCqvyZU3KF6cRvdRC4aHiUU14kXeXj/cSL04F8B51v1DhX2WjVFqk
 akurOomlCh054aE9xuBC2ueQXq40oA8OSEqQnR+2t9GxO/iOnT5JRho91xHtUZJwri8X4TajF9b
 9rOeesLORiY+av/CCAX+/qikjxa6Swh0D0e03sUby6seX1Iu4KKul3DvSQrLDwb8lyD3/JHm
X-Proofpoint-GUID: xg5ZvVS1RZZIIysrrrJZ28xOmstEHVNC
X-Proofpoint-ORIG-GUID: xg5ZvVS1RZZIIysrrrJZ28xOmstEHVNC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270133

On 6/27/25 2:09 PM, Luo Jie wrote:
> NSS clock controller provides the clocks and resets to the networking
> hardware blocks on the IPQ5424, such as PPE (Packet Process Engine) and
> UNIPHY (PCS) blocks.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5424.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> index 2eea8a078595..eb4aa778269c 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> @@ -730,6 +730,36 @@ frame@f42d000 {
>  			};
>  		};
>  
> +		clock-controller@39b00000 {
> +			compatible = "qcom,ipq5424-nsscc";
> +			reg = <0 0x39b00000 0 0x800>;

size = 0x100_000

with that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

