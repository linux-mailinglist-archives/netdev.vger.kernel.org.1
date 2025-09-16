Return-Path: <netdev+bounces-223481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DECB594C6
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5875A486F5B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFE82C3244;
	Tue, 16 Sep 2025 11:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dlMnqi8U"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F512C0F64
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020760; cv=none; b=R/TnvNHTSWE0spfrnEiRWgkXWPzBo/jjiaXzq1sPjX3kMOFUxSD1j+ZWCR5xaj8zFSG93OjnTZ/We/C5T0b2Oj2iRo+HSoLHr/S7d/c6qRUQOzjX/yexU3TBylKIJSVOB1L3Y3hEel0fcCn8klAQHu4aw9bGEzT7YQdpjApepaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020760; c=relaxed/simple;
	bh=Or3sS/huFAjjeAedfhopVNlc2SuDocesMGLsvA4ovd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Da71Co2gxwX0a7WSxfhzxxeKxuUidY67wREShblxXOTTmJ8yNh4VPdZk1UHY52WStTmPGLTa3qTFJev0o35KEo+1w+w/pzknlPDFTiP2ZQXtteAAciSedCIljfJshuOaOHKeWh7lTRMnuHophmfFNGojx+A9XD/z38fG2FCst34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dlMnqi8U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAAIKE020370
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 11:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ViaUWXz7piwPDVzZe4GL/ffGnLLhDpYLwoddXmEXM0M=; b=dlMnqi8U2RnOWLuX
	aUoo0GYh4eO3jt2D79hq2zvH/s22QZ4in9+ugovXj7b8YuuCsexG8YKjLFdc9SHO
	3dmhpbPf7JzY92hJpDvqvOOhjThlIrGQjPJqJ1FVmzJK3fuGGwo/QmXm0Ojg9vPM
	H+t51KcT923S/64eW6v5izajWnen1tdA/1NWXt95CZifKbvu14UrOlRaVJRVbHUP
	iF7ePXDwHTyu5u3U7MfQLSmjlurJjO1XF5NB8I/M2cxz7DeHYanVxei9CsUhdLq3
	gjVsUtEMeI6knYUh5ShX0fuTR57RqRy4G3HoB/uOwhJy1sqvr+8bFLxoQAk7nUYU
	t8WfQg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951chgj7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 11:05:57 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-78df9ea0c9fso300626d6.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 04:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758020756; x=1758625556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ViaUWXz7piwPDVzZe4GL/ffGnLLhDpYLwoddXmEXM0M=;
        b=qJdMY5kuRUKLvN18VaUZ5u7Os1VMOWhk6fMbkmMoSml/Rz3P3G1tVMv6QOvqHSxDEB
         vxSWF+kn0CWdfNvc3zJFqXxU68cqFgiP5MIj5WQvYIDlZZCoInYDnpr57I2+oKWueaEn
         vIkRoV2Z/2PQVPBPjjLTaOG64XNl+MBCMo++8ZOn1vJZ99Rp0m89V4HQ5BUbMu3n3oW0
         scVuQ5zDE9unEvFj38+DEfpuEihieAi9TE15wIRURPVpOhXmKZbbH8XCUVjtND6xOwBn
         hPmQUCkB3MMyMvBP3TV6AczbnZr4Y7i2IYoS/BUegF8TYRY/o4iHeiYIn3CgshTFWX3M
         HcpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfi7XxZyZsu9xtTQPWAXYDt3aiexiDsrfwH2ZVRK9OOFEjMNZqqTTEK/M0CXmwnwTfBAi0ysc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk1E3+und/niBiUX/VgRnrI4Z5ikLVnCJLt7aSJ8v7Z1B2kZrm
	T03YtuCtE7aD/lM+tbRjL9sDWxT6mjxorFp3cK6SdXka/3wkmxpKZUgUVXQeewVTpjpOtVOpIra
	TZ5J6QTBn7YAg+iyryivd1QWvVYbZr6YsKEE4pQjbLG54kL5IeY+BOb7wBIA=
X-Gm-Gg: ASbGnctsm5IxV8DKO848uKAMTSO5PNtF20S4AFEjx/Md/Q61X0gXzoi09khFMjoiYCi
	rZ5c5JKMDgk5f1cd3qkDEjoy4m/QNdGGWRNh2vVU4S4ktD8E4x4dgqJsblJ9lB/GmmUfvhz/Qk7
	ZbBntYhCppIqzri3goUrxb6BHz833Iuo2dpa3Zh2UucJ/OY8ZLFtc6HSnwbW4Ev8nisgrBTGzDK
	jRyt0ylK9bymuzTCzMsyts2+Mc3WKd9JL/S0mEBCujqpT2+CFgUOvgSSBYPT5s0drLS/bNLzC6k
	5Y0rKzT/z+qq2v+Y83GRQQ8HoPColM+pwGgSGyNBZ7pvcyyefbScNcSEoxMSS7DPXRTKwNeWYvi
	4quPiMvIiM8daGdQBVQYKDg==
X-Received: by 2002:a05:622a:143:b0:4b5:f521:30f7 with SMTP id d75a77b69052e-4b77cfeb0a8mr138161811cf.4.1758020755561;
        Tue, 16 Sep 2025 04:05:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwsWlh/wMA1kgn62I3osn9yA6YaFnlN+94SeqOOqPpYtWKmcu0OzDbrZ+IaTwxiRXlalQ7pQ==
X-Received: by 2002:a05:622a:143:b0:4b5:f521:30f7 with SMTP id d75a77b69052e-4b77cfeb0a8mr138161411cf.4.1758020754944;
        Tue, 16 Sep 2025 04:05:54 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b31287cesm1146190666b.30.2025.09.16.04.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 04:05:54 -0700 (PDT)
Message-ID: <cd6d164e-a6bc-457b-97d3-503b897fbd62@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 13:05:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] arm64: dts: qcom: lemans-evk: Enable PCIe
 support
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
        linux-i2c@vger.kernel.org,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v5-5-53d7d206669d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250916-lemans-evk-bu-v5-5-53d7d206669d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=eeo9f6EH c=1 sm=1 tr=0 ts=68c94495 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=lLTZtybaiap_q6JmIOoA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: XEL7CqHEtD_d2LwSNPkJZBCfWOucPkOe
X-Proofpoint-GUID: XEL7CqHEtD_d2LwSNPkJZBCfWOucPkOe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzNiBTYWx0ZWRfXxeMtCb3+zw1z
 ZICRj1IwTxc/1Wkm5R6NAXMfpEM+LaVlvZ2FKzH18nCdApOH0KFaLBC6Bs6NKf4VKwAcHD7vYSD
 jPA+nDhgaWD8YBlxe3lPZqKNIF+R+r7gspmeleW6PnnFdHeb00p4eunY789UioU3pzqBONIaIcX
 nH3SENGu1bfIwOJUOtGMulIFNk6eBZ/dlTFAZWj6WmAJRwDOcM4d4xgEmK8vcinmCGSaXzkDyeR
 dZJdTPrw3bcxvspl/oMJdhpgQIdd/KVfcuilnSPwG2PoODhU3yKKx3GRqBAEqztZLcGUqecfdX5
 IJWmwxuv/MpjuDaiDVAySnLiKFgwGiDkAQkrbssNvFV7BXSuSRzGbHzCnHyMsr0gZb5F7wojidk
 VR5b5IDe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130036

On 9/16/25 12:46 PM, Wasim Nazir wrote:
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

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

