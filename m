Return-Path: <netdev+bounces-219617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B00DB425D4
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12C594E5165
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D6F287258;
	Wed,  3 Sep 2025 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l1NjJ32X"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEEE283CB0
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914528; cv=none; b=RV/q2A2k5gcOCf2gvOhHPpaLQKcqqSldAZ8d5k0D8Wtegatxvf43drXGOzXXStKnH79fGBYmCgyRBvKFQVxwIpx0IbDekliqWh09vdnPdOfYxbaxxodkzeqMp8XKQdKpcy74vAd2gmGJ109SskxQKcTHCavpx15dpovtkkMYINA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914528; c=relaxed/simple;
	bh=I4dvzksBGLJ7YYqBj4cjUhjzhWLD2Q/j5EaHEBCG64M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GDdtgDjERDM6a04Y677h3AwBrFE8wN87LsxMl2rvpkTSdtAskkLlkIlKz3Lu6/vkM6xpVu22IljBKoQqK2rzxL3QcHeoHb5u139gLb3Y1EMgnExuoXqDmC8OAg80Crj8Pw/9u/YScEHhd1UF7c7V40FZavegTo98e6rvdgp0zHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l1NjJ32X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583DwpRo021476
	for <netdev@vger.kernel.org>; Wed, 3 Sep 2025 15:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AbNhMpUtMiEUnNVgjFV19+ZJvfwkIjVGX0qqonuR6xo=; b=l1NjJ32XMyIouWXu
	5D27dZcyCCd+V2HyYNKBkRytf2E1U5BQhTOUduM2VlnxIBbH0bk7JzAhnAwv6Tf4
	nVNQfvyFG58cvXVianxi8AlFctEDVBAVanAycQUTgoYw/KNW0y0OCn6K3qpuu4Pm
	zSKcLq1GRKGI2jepchKl40cZnRULSoS/JMALFkAW3BrrBpnuxiAMKLCgDTN6R1fb
	BFaf9lD6bm10cU0CQgT5n1alPDxQ5edxHB/wbP+FqqCrH9LQvEhzQcK2muiaPEpG
	jnGb5nxHjOLV7+plzke+kUklmwSUA1RAyJy7PIkROgcdhkKS4tHkBGsgC4vjuawB
	+10pRw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0emdjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 15:48:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b3387c826eso193671cf.2
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 08:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756914524; x=1757519324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbNhMpUtMiEUnNVgjFV19+ZJvfwkIjVGX0qqonuR6xo=;
        b=F+GT3tRgoKND3e6uFPgvtUsLGHnmFyawy4jsTTUG4tBwHGYglnz6XLJstqcW24T+CO
         QokZg+/PNKdTcUVCfr5xesDiZ+4PQB/lih7ZWrCHga1b2JSizlYM+96+NHiqpJHje27j
         FDzUnE6SxRKizC1dM8KasmmwYSvA+Iol8EoVoFwf2fP34srq/GkcFMPF5BU31FEvpOFC
         CinUQax3Eu/WlVRwhO31uFjg5JbIt/T5IcTn8Pv20vdtDmLsEg0mEw9in2W4JEo9lqLm
         emP7Y4wuYpbFdltjWP6jfOmrEDsPHnpZq12BEijxJ+MCQVdrE0CiVnSkTg33y6wbZ4Jx
         T5hg==
X-Forwarded-Encrypted: i=1; AJvYcCXOLWaj9JXp+72IUFuuRpO2Bzf0VoX+XDB9yh61J4Txplr5SkDFgpL5h57/6o6thoy45geYQP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNn0RSTI7DGCSHO9YHkTTu7jZSdJ1MZ81AAn0cvkzkfhUv3nci
	LBQiK4XXUr7uOzuW7yql5oZ6+XOrZvZAsuZDZVNZWokF3Dg/SNPdAh6CRzc9s4di1YORMxr5P/x
	TH5MJfHyaJMjj3kbTLBtLSICkmrtnfDXSG6MGeWOTK8X56daAmQKCvgRUw58=
X-Gm-Gg: ASbGncuxSoN7MfnooS0mGyXUxETp+aQ+EleaHqq5x1MQHTDnjJ3AeGHM9wL354BH30t
	69SF0BFjqAxnFFfXk6zBRcy3xK2gKxzxwYWxhJjsHO7PJnBHsp0P+TurmtMomt/doBjnLF5RdNl
	TkeJdIzoEGajUjAUGeI/o2C7DKntaEJNXXEEOS2AZdDr/CZTA29wt4onOJG+x+sdo8zMRTYr/Me
	cARhIBRBolWHJqIHHEdg9RlZYwxaIOeTiQpq8gYN+pehmgzdA15x67WK842ms8yUymSkX2Z6k6E
	YWURC5zpld61autRO1QlyYN7o7CE6SizU5pXwqcz7MJqJJC0P7MUqIIcgBE2nLIomNccENkUVyP
	t1xYC687ghKlbC5ewMnp05Q==
X-Received: by 2002:ac8:5790:0:b0:4b2:d2ea:f8fa with SMTP id d75a77b69052e-4b313f40452mr157015411cf.9.1756914524074;
        Wed, 03 Sep 2025 08:48:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZCJQ2TWEynp/QBOoS3m9oi3irQOjHy8GVuyxF08zwcCb9nsDksfZu3ls0HCvZ0YFtj5n0xA==
X-Received: by 2002:ac8:5790:0:b0:4b2:d2ea:f8fa with SMTP id d75a77b69052e-4b313f40452mr157015011cf.9.1756914523509;
        Wed, 03 Sep 2025 08:48:43 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b03ab857474sm1070857866b.89.2025.09.03.08.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 08:48:42 -0700 (PDT)
Message-ID: <8a963e12-1113-4604-b15f-a5867c4b5bbf@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 17:48:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] arm64: dts: qcom: lemans: Add SDHC controller
 and SDC pin configuration
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Monish Chunara <quic_mchunara@quicinc.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-2-bfa381bf8ba2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-2-bfa381bf8ba2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: uXUGQtHSvK1fSkEb4XWd46lDLT7r7he-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfXyJUAZieuqYEp
 ItX14NlL0N72weq/Bwom6wwV71UXeU+hQBlpDJAC9RRsodRyhozxo1KIp72h+oi/wzN8/Pw1Swl
 8AogO4upc77JS7t9EeNgjrQSde5WgCPRUH46/t9l10bmmB12sLBf7YMjgWpvNwu/AnlUXTPjsBa
 QuQAPxiRBzmmmRHw/HsYCnOjAcVTisSuFTlBpmz2BfNFEbmwVhUWDa/hcD8tnifVKmI/zIywuH0
 VZkO+4OE3TZ0RtXWqhxl68k8eFa3nw6Ovyer8wPwveFdpe3WxtYXuOLylBi7JZuSmH4KAb/humH
 d237U/XUPMGLxZn4DUu7sTB80duzGGMTk46FAkOgtPyEX2iXo161rTVhvszUNmV427o3H4kH97H
 T3fBIbbk
X-Proofpoint-ORIG-GUID: uXUGQtHSvK1fSkEb4XWd46lDLT7r7he-
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b8635d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=GqXf0neY-Zx-3wbHtdMA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004

On 9/3/25 1:47 PM, Wasim Nazir wrote:
> From: Monish Chunara <quic_mchunara@quicinc.com>
> 
> Introduce the SDHC v5 controller node for the Lemans platform.
> This controller supports either eMMC or SD-card, but only one
> can be active at a time. SD-card is the preferred configuration
> on Lemans targets, so describe this controller.
> 
> Define the SDC interface pins including clk, cmd, and data lines
> to enable proper communication with the SDHC controller.
> 
> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans.dtsi | 91 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> index 99a566b42ef2..9e4709dce32b 100644
> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> @@ -3834,6 +3834,57 @@ apss_tpdm2_out: endpoint {
>  			};
>  		};
>  
> +		sdhc: mmc@87c4000 {
> +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0x0 0x087c4000 0x0 0x1000>;
> +
> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";

1 entry per line in xx-names too, please> +
> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> +				 <&gcc GCC_SDCC1_APPS_CLK>;
> +			clock-names = "iface", "core";
> +
> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;

QCOM_ICC_TAG_ALWAYS for the first path, both endpoints
QCOM_ICC_TAG_ACTIVE_ONLY for the second one

[...]

> +
> +				data-pins {
> +					pins = "sdc1_data";
> +					bias-pull-up;

Please put bias properties below drive-strength for consistency

Konrad

