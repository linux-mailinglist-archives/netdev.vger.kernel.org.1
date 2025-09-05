Return-Path: <netdev+bounces-220345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBBAB45819
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 14:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 714C14E5804
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2573C350827;
	Fri,  5 Sep 2025 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YJrdYtEt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9979A2BDC10
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076414; cv=none; b=tZWEjtS65pY1ppQ6OYQvkIJxZ6FArKFd4HuiIb3kDsPhjAyatfbNXTIxF0Jrh/7Z0Bhjg9yE861QwIeN3Zt8Ai7xXQRczTThZgXP+BFmewBj+lLKOru/M0D90KPBcTf2XBak5vNUSnSteOryVWpeTBnsW+0Yc7AO1caN4dHLTJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076414; c=relaxed/simple;
	bh=WdzrylW6D5k/Tf3MlXm009pxRMhKTuh6CF95xa9C5lM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGoCdNxz2Sqv8PByMpc2NPmW5QsxRTpoKzZP8xXgiGb80An2K7xu6IjFx4lwnmm/uwit2SuOY6GpdjgsYw5Ua0wjjLBW1lAPjG4V1+nQ78dJZj0mjYwxDdvO5EovXxSMWk4KqQJsE7GfHPzVslga1JvUIEGXA8GFPybCl6i6b74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YJrdYtEt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857bgSK023899
	for <netdev@vger.kernel.org>; Fri, 5 Sep 2025 12:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1SB7U/jII62BtLsfK3kvMJLkTFF545hw+zs878TRZ3c=; b=YJrdYtEttXAITCPY
	4qYd8AMnHHfAG/l+5jjnZLO8fLK6foNRQnVcZp67dxmdhGF0v7r/eqgP3l46j1sl
	f5jXTVz8d87UBAyagvT9l4cMu2QYvBRN5g2ECHq9bD8vkEfaGxuIJUri/OKQ+q85
	QtWaRis+ADqBGL6KORlALm3UJHwlYbMylZ+hmz5XPCoCFfcEc49ZdUQm8mstRF2W
	4BSiMS/mdr8nHL41mM7cHXDtjDBjwK/G6kiB/rF21aGgz/90cbrKk82TNLYJFmgy
	/9BIYzY6vn1BDyOuw8brJPIbvKsudX6L/f4iZ9XbZtK1P++x1E5r1SlDlIxMhjM9
	5ZH+Rg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fu0jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 12:46:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8051d4916b0so76103485a.1
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 05:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757076410; x=1757681210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1SB7U/jII62BtLsfK3kvMJLkTFF545hw+zs878TRZ3c=;
        b=ClGSqVcU60gIrta/+6guNIYyZqBl4EeWDfqvu/b+IPjKb7eB5HaWrjceuSqa7g9yLT
         0B8HaHG+aZXAuOVIhOuBCfVdOWUswlgoeJpXYkLs6bcw2pUMEGqIeEO+b3WOXymzqMZH
         XA+4shkDd0G4zKmfxAv5jsHlZ2B87FkEWFbvBmzJrKAkBjswln49aJ7BpEflhgEN76bB
         WPLojBh/NHYb3yov9DQZU7douev1/wKVwLJikBfgbQmT1Zm3MUHqbWO3Is7VpPnUvDbX
         bHMB9co6ED3eODR3AzUtygu6p33rCiBcpv/KryK/yKIdMN7c8VtTB3SrTLk7ziRvHPJ3
         lmVA==
X-Forwarded-Encrypted: i=1; AJvYcCWL5bJJVFVh0HjZs/o9a3lnDgRtxRL6YYqgoBdfE99WNRI4aRrtys2RN8AZibSY8zp4M/uBkhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBpaF2CIMtEOZ86wPttAcoDFddiuT0nrAvCwnMlg1knpVQAhHS
	+2s87LcgNsXxcPDQh3N6ZJGuuvVOo/IgK+uPlPnl6eOVhGDH+BPTyojMgIsAbYS97Vw4V1qIOHp
	RQeaCjzrL1c7aH+BY3bMKVq12ogG5q61kvDL0UWt+CoEWlcsoR5PPHspPCT8=
X-Gm-Gg: ASbGnctOC4bPi1KxlLY7S67S4PL8a0VkfTPC3mY0hA0+jA7bq/RIEkS9fL/B32O6Vwj
	6ZA0hFrBhEp20Up67NZyALA8iIhdWf/9MLPB8G0tDWLwp3kfrMpmM/yOwfm3i8ubeKLhjthqNRY
	0zN+f1Bi6wkZajvhh4iKWHPmiO5nqQ17Q/xPG0r6yNFKs8X7lBTangIS9RfBwIt3hKgXcSGLy6s
	f+RtaOuZ1dfMoaCZqNEE6GDFN0uGG6nUeBFz0WydhYbtdKKAQkIevcdr3AxN+HFupV0BAhR5WjL
	yUs05LOgc3Hl3vBme6MLwGfhGka/YoM6uIt45ZeJVCn0vl81TeiKtJxhfaLKVOdKaX01oWfnDfn
	lHo+E3h8h+AnY5yQI+SosfQ==
X-Received: by 2002:a05:622a:50a:b0:4b5:e9b6:c96 with SMTP id d75a77b69052e-4b5e9b60fa0mr18609601cf.7.1757076410261;
        Fri, 05 Sep 2025 05:46:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IED88BDkAu3hHD2gZnrUFPzTysohw+/x37Lmb3zruLYrQfgSkQsU1HdrPUH85++Pzq/cKzFMg==
X-Received: by 2002:a05:622a:50a:b0:4b5:e9b6:c96 with SMTP id d75a77b69052e-4b5e9b60fa0mr18609281cf.7.1757076409449;
        Fri, 05 Sep 2025 05:46:49 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff0cb2cb07sm1727752366b.16.2025.09.05.05.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:46:48 -0700 (PDT)
Message-ID: <055bb10a-21a6-4486-ab0f-07be25712aa5@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:46:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/14] arm64: dts: qcom: lemans-evk: Enable remoteproc
 subsystems
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-8-8bbaac1f25e8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-8-8bbaac1f25e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX1mdq6ypGztnj
 YQBPaxKjDLnvyML4Q2RmTiSX0XRFkIX3hYuuhISpV1ZsKoZ0V3S38Fu2YYWuoivdg3EeA1IvQ84
 yFDInyFi0z/FqJ0xRx/vVibdJFZ902Rt+IJea/zGGqxEtjOr+xj/U2wAmgYPYCJ0bbIbDFFzMi4
 OhBk5YMzFc+gvNmk9fnFDleDFPQoyOiPafO+9IWEWtY9ly+k1BO6kQH1KdAGgKbx7A1CGccuvKN
 k4EHWP3BitmeLQclz/95USfpW5PfJWNQP6UfpbTAVTzYX5xVzu3xC2iCt61ubzRJc3I5UjVFD7c
 0fH5IcMhKtf5tlrChLEyCmUNW2sqP6nAZXz90T0YN8zfXLj3SOc50sN0q7XgjLh05K+a34+SJ4m
 h2TRli3V
X-Proofpoint-ORIG-GUID: iWgAfNGm8jaXUW3brqrkE56eWR7BbGNF
X-Proofpoint-GUID: iWgAfNGm8jaXUW3brqrkE56eWR7BbGNF
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68badbbb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=3WfgD9H-dY_QjJaUS7MA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038

On 9/4/25 6:39 PM, Wasim Nazir wrote:
> Enable remoteproc subsystems for supported DSPs such as Audio DSP,
> Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
> firmware.
> 
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> index 17ba3ee99494..1ae3a2a0f6d9 100644
> --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> @@ -425,6 +425,36 @@ &qupv3_id_2 {
>  	status = "okay";
>  };
>  
> +&remoteproc_adsp {
> +	firmware-name = "qcom/sa8775p/adsp.mbn";

Are the firmwares compatible? The current upload seems to have
been made with Ride boards in mind by +Dmitry

Konrad

