Return-Path: <netdev+bounces-219620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440EBB425ED
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5880C54845E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A85528A1E6;
	Wed,  3 Sep 2025 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p2+sutGY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE806287276
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914609; cv=none; b=MTVEKMbI21XMu24TBDhxy7gE7sOb0AqP9s+3P526cbqC3p0ec7hy7R1ZgPqyFVNPLqlU0krd4qGXsdPpOKJVqApiREtfDHajwzydbI2gcoyKTM136lW0ycrnUskMoL/C8hFtyi3a57pVjRjn0id0HxDkwxzOAI3DNhTAcqyFuMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914609; c=relaxed/simple;
	bh=H5qfSjclHJYp6VlMCGtyMvRXByBYpsPV4yiw5eNY7so=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mxeFzL0K0I1+Txfz5rIK9ztVtxKfL5kOdlu8xT8BhjUmBdMZhDgbKfOUuhD3lwg0R73+A2bLcdAlI+eFsn5eIVSSIrihP8aeCAT/Dee24vVbTv2YeTEbclBRuhfZNZm3IionbYXDsA/WKAMkIoI4Xg0P3qNo5c/61sQ3R3DBmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p2+sutGY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dwqml005254
	for <netdev@vger.kernel.org>; Wed, 3 Sep 2025 15:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wix1g4uaPabNljAYVNfcf6lXHFclM2pJ4RBkrprNZ6o=; b=p2+sutGYPslM6Z2C
	j5bJtXi8oO7ulNmoKt2MenR5taVhx+NdfhbmAHyq2GpQfZ+/kNTELUfVaBaKqkAN
	C0fb1Z15DYrLLhlwpWMWBpIuYuaxi1hj773G9nIunQkRH/aOFK49y6E+6aN+AXqT
	NkgDVHvVjodweK3/0SiOUM9V3j/KzauwIuPixykixjLBVzR/ar/000pLuY3ca3Rd
	aNdTLLHG4br25j4f6s8eCHn+jONf2tPzTReOrRLPq1ipf2KO2YAFbJFQL0IcrcMe
	zl9x7R1TBj8k0l6Wji5EZkktqJdIyOVMbDUNcBNNr445xB9l/gYo6LQ3aS7lcq7o
	IgWBWA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjm6pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 15:50:05 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e87065670fso1479185a.2
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 08:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756914605; x=1757519405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wix1g4uaPabNljAYVNfcf6lXHFclM2pJ4RBkrprNZ6o=;
        b=DBtFAizvhiNKrZyotPTf28sli+YxoR+bJU3pJep/hWJl80fdf3m0hnt9gK4CfFhdvs
         8mnyNYD8VsDjGxTYwcBi5dt0Y5PsPH17+hms//MH0QCMAMCTHvxquxl22zwMn+y/Jk0y
         9J18fLxNBcTd4QOlFSQFLaUhK1+LKX/nAW8khS0EZwIW8UfLfxgFKE2juHou6lLGDxeG
         SsQVb71oV2Y5FpUPOtt23ZNh58C7u4C+DZJZgKy8Hnp4T2JvkHuq+3TBjE/1IEXq88B8
         rxpjb4erxLKd8YZfW8j2yFkoB0vvLn5kKexCV85sYOxgVLkZOQW2TafAbCpr6aN+2vrd
         Zo5g==
X-Forwarded-Encrypted: i=1; AJvYcCWE7gXXvBM/auMWBF1ZWHT4MN7YFtpwiiYrXwTJV5pCx5UdrRWydGT0fdQgMMUK0Ig15L+DU2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI/UsiAg4DDomJ9YgzdpFv/wbbHZmIDOCMCfA++w4e2Q9lTO9T
	ekbxIgBDl8+CM5zpUoXun72AHv3SY6L1XVee6Csy6Fnhcu3Esq8O6pafLFvRCTPj2nzkYg9KEls
	kWU6MxuIe7fp1NTEYiXBKDjpI5E1AxxtyOw6SVJ6UFwAYPJwrzZ5kP0PpfLE=
X-Gm-Gg: ASbGncvweHBcawSbCEmcdga6Fe3jiYdZqXLJ1hep4RfXZtrmZlcf27iEFyQBiJoCNVg
	yvY1OILaFa+7fVfX7ZRVpy12NW4YTQ16NlL0wTInI4ZZ9QpSpI4OcRNz162llIizpVObVkQPjAT
	+MRnUr61CqjCHorCvbVjCRVlKAHGyE9xi3oFBxngYMzZEJMGNgB0dEeV9cp/F6GnYctAlZrsk9d
	KEiz6i0YTbDnyp3kjThs6tgFJZ95OUQm9dSO9SdDsqTpWfPfVcg8ls+eOrJwFTe1BwZz8Wkd3aU
	Lkc29pqrEVc4MpcjxbqNk+5CtiE8EQFuxNCdsSjXyPnq1nbAUbD2XV66QNOKpAE0RKG0C4L+dLV
	UvbtxkAK4mL9oaimPQGXXCA==
X-Received: by 2002:ac8:7f53:0:b0:4b1:2122:4a51 with SMTP id d75a77b69052e-4b313e59df0mr162339051cf.4.1756914604660;
        Wed, 03 Sep 2025 08:50:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYKt+soWuAENoVdQ9j/e/O6Qu8NlsHabjBSI6xYSgRI5GQL7c5Sk7w14RsYRKa3ZHe4HcE9A==
X-Received: by 2002:ac8:7f53:0:b0:4b1:2122:4a51 with SMTP id d75a77b69052e-4b313e59df0mr162338661cf.4.1756914604015;
        Wed, 03 Sep 2025 08:50:04 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc5306e6sm12116057a12.47.2025.09.03.08.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 08:50:03 -0700 (PDT)
Message-ID: <facc2270-e700-49e4-a7ab-3b473e343ccb@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 17:50:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] arm64: dts: qcom: lemans-evk: Enable PCIe
 support
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
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-6-bfa381bf8ba2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-6-bfa381bf8ba2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b863ad cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=g-wiT8vaiPKb6nfFgJ4A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: l4N3dsj1qHwrDU0DUiukkDyEatwZUICI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX4RGnt7RySNu8
 3CA47fORkXaRMpLenPy54eTdaG34iQC+TGsEo2SQMhMMgFDpmvtOIyzGBf8zNJxYOHc/CZbGUZ1
 /evAmGPBFVllp2onTvS0ETknSRbJFbKuia6silc6XiAbIW4YzkUf8VaLB3VUR/mzGxyJdWtGKK0
 hnWqVIfSyyuADXSgm+HBm3IVmGy1l29likgUDrafhfUSVUFxCZxpPAEWU7/mYRM9vFu23/HNuVe
 AtitssgwFXiSZQNZAuWzNpOcFOYsIJmjo6vmJr/cVVcWs7/00Q09jIFpNaa0qKTa+B69qQa02Z9
 RyiNqL0CkfP0mJTgjhwee4nZasNRu4xvfWnpnQxGK1+RSHgTQ6wAulHFSKldy72XBGh8H3B3cmU
 0rRh7cz4
X-Proofpoint-ORIG-GUID: l4N3dsj1qHwrDU0DUiukkDyEatwZUICI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

On 9/3/25 1:47 PM, Wasim Nazir wrote:
> From: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> 
> Enable PCIe0 and PCIe1 along with the respective phy-nodes.
> 
> PCIe0 is routed to an m.2 E key connector on the mainboard for wifi
> attaches while PCIe1 routes to a standard PCIe x4 expansion slot.
> 
> Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 82 +++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> index 196c5ee0dd34..7528fa1c661a 100644
> --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> @@ -379,6 +379,40 @@ &mdss0_dp1_phy {
>  	status = "okay";
>  };
>  
> +&pcie0 {
> +	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie0_default_state>;

property-n
property-names

in this order, please

Konrad

