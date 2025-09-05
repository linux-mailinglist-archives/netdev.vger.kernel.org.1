Return-Path: <netdev+bounces-220336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCBDB45743
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 14:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DFCA46413
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED0C34AAF1;
	Fri,  5 Sep 2025 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c9jG6U7q"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32EF34A32C
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074127; cv=none; b=Zj3gDIjkSQa4xmyJpsb9Ts8TruW5p2aS66FN0cBAsrALsvndHBtzdxvxxb7cPWbKPQF5xZUqhOl8DE6Kr9IJnToXm5UQUAi8j2gNq9BXSP7fYoFJg+BB9eNXLddTXeqjwpe8PIUd6B/BhSL7dtj07zdpf6ewN0UAcM0FAJZ2AdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074127; c=relaxed/simple;
	bh=rbDWYSVIc+S3ABYMQqky0vWnAX9+AFD4sL9me57s3Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPy3Z4AYvtOv9+6bUZuldxYIltfSiapwDcaAG4yWctK8vkZ6fe5vBOQ2xX8gjbmFPcqDQFisUtI2xQisptRokJ09B5N+KYSweNhoiUJpie1qEWN85nUnLJOQ9+Ou2ZJerVVibZrqPM+JLJUfZ5hVa0mGIo78jblK1KV11UbUZD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c9jG6U7q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5856eWoS031741
	for <netdev@vger.kernel.org>; Fri, 5 Sep 2025 12:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1eIGHZDbMCTDRlP1TpKl2lygJjT6lzTuIxUng9v1BgQ=; b=c9jG6U7qi/y2Akcq
	/aWaJwz+hlhRm8vaLj9iyFX4qrzwpdL3gprPhwBGgsPJkzeA9TB52Zs1+YfWrGuc
	/w+oj2c1Q9pOWjv6TDVRf09cz6Ltm2DcjtFvcCB32uTcOBLI/ijYs0+jYAmlnVsj
	kCFkhNma439xkpYjyavyIRf6P1Ff8cI57/VqPSxA/iLzzJAsUgII/GacdlLbXkNC
	IyN0xvUk7DFXI/AjfG39pxn92/udY4s715UZcGJ7Be4tZnkBcMrizpzv7mn3oQs+
	sZgH/BCfwB0WiPkvVLX9crUkdYJ/qlbtS1DZQLOoXRO2BRuk+09gpGIOf0gS30bM
	C+4aVw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw0b4fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 12:08:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b48f648249so6513151cf.3
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 05:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757074124; x=1757678924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1eIGHZDbMCTDRlP1TpKl2lygJjT6lzTuIxUng9v1BgQ=;
        b=GuT3xqSxt5b/GDbop+kaGz3zdYkF+YK/AXqXkk6PRRbvGjNtkTMV3o9uWqhV4SBwho
         XIFk4Xr7VQ4kCp4nkEsgZrNkmRfBT9kVlbHGwUBWA26K/XuhmLBM4WLZ4/V4Wv3cCBDh
         YxbFrKFmO5R8YlepAmbmmsz7L8/AJCGhWJ6zOH5Y1mxXsfj4FIvph1Ad1+fnpbZz4jne
         aISTd5e2DYjFczJt9W4qEJlWyP2P1yT14sjo41yzw1ZECsv+k0olsuuzYFYcSH30kEFV
         VwdmhU3+lHZNV5YY5GgKTE9rTaJyyZOrW3BIkWjBjiT2qLfjFawEY+2CxZmUXRzPTdCY
         yfSA==
X-Forwarded-Encrypted: i=1; AJvYcCUlTj76K747sWg/iMxpnj9otqGwsKGf9n7z58rWymFycu+0/Wid+F6Q6LfbbJ/R3Qk7SGnQG68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjtXjVimk1MgeKJgYPJ4tWfi068r4E4jJU+1tbhqp3y1Zi5ZCK
	gzdAlu494NRlhBK9drZgQfT7ZD63YibZl3QljEtF5prv8EgfZ5csiM6P+oSXj6tSGGlJfG59jqx
	EPThErEu3EDo1mHTNJU1FFpewT8mzTVOAzKog9BAEtTzPYJmSnWhUCv7CGmE=
X-Gm-Gg: ASbGncub544Hl/apSU/yh3zmjs7gde0ahYAukTY6J+DDj8h8RaKzeSD19RApPmRjcn3
	s+VoegCeMyga/Atyg/kGD9gvvp/iWxKTzeSseCztCp2kr0yN+Zph/qfMjrNBfAvDkH8uZC6cily
	kDydL8Oftxit8zlDBnmSxGlOBz23eJkjBR430hlVICIUHlDDhsntEd2znJtwW1wPIIzTpyXWMk5
	JNw2L4wrN3EPpwTlIJgDlQRHaSVyKXcz4UXCEuLRS50ku4Vz/nAo0MJboPz4AiXM2YWqboXcPqz
	RTdlC4KP5txKG9gzmuKe6Vj7rPArlhFt57rbKKD5NgSYvCFw1opuj3My0thuLjkjYU+4J6JVT3J
	8TZLQgfBLi5axGz3SoADZ+Q==
X-Received: by 2002:ac8:5fc4:0:b0:4b5:a0fb:59a4 with SMTP id d75a77b69052e-4b5a0fb5d54mr56116331cf.1.1757074123760;
        Fri, 05 Sep 2025 05:08:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGhLb6AyLTtxi6It/6ZDvuBl0OtYQNFkjfz2TPhZg6tNQSWGAKLOvNvVjqsEPiE59zf6K0vQ==
X-Received: by 2002:ac8:5fc4:0:b0:4b5:a0fb:59a4 with SMTP id d75a77b69052e-4b5a0fb5d54mr56115811cf.1.1757074123024;
        Fri, 05 Sep 2025 05:08:43 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0079183496sm1557522966b.13.2025.09.05.05.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:08:42 -0700 (PDT)
Message-ID: <cd40b690-69cd-44c6-82f2-39703beb1801@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:08:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] arm64: dts: qcom: lemans-evk: Enable Iris video
 codec support
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org, Vikash Garodia <quic_vgarodia@quicinc.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-9-8bbaac1f25e8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-9-8bbaac1f25e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: r-7fbkjCpcejYkllG3EVdQyk7QYqpSRI
X-Proofpoint-ORIG-GUID: r-7fbkjCpcejYkllG3EVdQyk7QYqpSRI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX9UESwUoTWr1u
 Yu/Dm4W2fQ8DUgKBTVbg8Ddd6/o63fsxVaLMOKnxw0UA4XAMPj749TslXYNyILxt4DPj6PCxTW8
 WaAGR+Csu8jL62u+VwI9Bydj4o6Z7fceLkH1nJa/lh8z397T1PA7WCgxp/ZRMHgSfypXsKj0lPr
 2i7Nf9uQ5pts4pYlwZtSBOy5IgM+8z07mS1qkKj06ee3aDH2iBncBddWblzgjkMKDUei0FygwJS
 eAyLEv4xRSR5eCN/bnqbhh9mNYtp7ucTfNgC+Lb/c3CElb85UutoLN9Y/atGSMd8iLuw0OY+UZD
 N2vJVkDXmbL3cEGc0FxqEd6i5/el+dcTfcSLZ04euphCSG1hMY2J/gn4PhZwBsRjwyB+HTmq+sP
 rnF+VjIf
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68bad2cc cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=yPPeNZB_paKBOZgJB6kA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On 9/4/25 6:39 PM, Wasim Nazir wrote:
> From: Vikash Garodia <quic_vgarodia@quicinc.com>
> 
> Enable the Iris video codec accelerator on the Lemans EVK board
> and reference the appropriate firmware required for its operation.
> This allows hardware-accelerated video encoding and decoding using
> the Iris codec engine.
> 
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

