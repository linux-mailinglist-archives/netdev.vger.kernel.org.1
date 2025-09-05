Return-Path: <netdev+bounces-220346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F797B45822
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 14:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EC994E1E03
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFE835083F;
	Fri,  5 Sep 2025 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hi6yo34A"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF742E3B07
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076489; cv=none; b=WUjREuQf1TZWQ1pFiDbS+HzlTlXch/DIuIVzaO2h0bpmWO1ZKTjccPl9LexOipDoS5EL5qrdsU4mTsD6i6ZkRj4Jt2T7vvZ6PBdx3Jl4giTWRpB2cWQh90Fm3TsWncfUGev8KWhix9B56QjH8IFZovQZTplCUFUmfRkg6upyobo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076489; c=relaxed/simple;
	bh=eP867im1PNQSlQH0RP105yUK43I1I7etGb230DP2KcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oct6XnHCQeCDZFlVbWVualIOUgGzHWHsMebf+9pwMJgT9CnAaSjhpMs+xXAdmjBvH+xUDi19p6XlG66xkHsfEALcXisjtU4AAY5wUwuIwVoOQ+G3971d6grnV4dXOiEThyyB0h1oQBo6qTfU/MtdJUup3m1JC5ilI5pr+kx0bFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hi6yo34A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58578euv005051
	for <netdev@vger.kernel.org>; Fri, 5 Sep 2025 12:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1ZVoQZK/NUQF8NTLJXml9/Jc9mpKZVnyeUkELKpWfaA=; b=Hi6yo34A4CSECkEy
	in3l+VwwNrdQ6GuihEaLSZ8pdMPQDi9lXGOksR3My2YGA1VKteV4zqqlwdEMzoJl
	B4lQpu6s1rmjeIWEqbH0YsMJANl8znAiyzkOH9Y2LO+pgTd5FsSw/xkI0Egp7tKu
	SC35tPxJBmHl2caBubK6NAHEwBUQzgKVbyGQoIXsZ/kEx65UwN6UqxGrGt3nMEFw
	PATPGNA4XaOZJ/VXljLilvqq075X2eXhmRYvbXfvaUqIka/dwLDHlY7oifDaUyNV
	ohIH/PlqNWtFc7RGCkMv6NYYYGfliyTPtPjOyhs2hInzVExp/zykB/clpvO1jzd8
	ufcaLg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8sb8t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 12:48:07 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a9f5a43b6so4890686d6.2
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 05:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757076486; x=1757681286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZVoQZK/NUQF8NTLJXml9/Jc9mpKZVnyeUkELKpWfaA=;
        b=BzxRzpm6yxC6k/H6kp5baFJDZrMkHpIT3zs5MrcFdovAmL2W4e+GQY/Kzi3QOGqVja
         5x6UZKIcOqkNFsHYsoFrVofWJ56pVz4Di62QFO+vH9p82lG8ipCHNWlSHKzdLYGQsxYk
         L3RtWOjSVRdlRZVUF7smWxwpEPX0VcE56e8vyyFmyiZkJwvwd9ZJsOEYNv9//WIE8Bck
         i/Q0YH5mt3UXqfewD6+MRco6jf6EFYRqDMS0iXc8abWf6SvsFSx2doDnG/THbYL6yqYx
         fMal5ZJElqKDRV8M+8PpkGeXtepxvxrabZjPHG7W/jxNL/GfgIVqiq2ISBmBpShOJ4cw
         D23g==
X-Forwarded-Encrypted: i=1; AJvYcCXqIgwFfPWCR7+hIjLkBUA4OzXcqOObobcQCOJnmlc+hkfk+nLnSpiK6OsJFHMIA6c//WR6JLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YydE37pPGBWKOzAj+m6GZP1Im3M03gvkVLB7EvTV/nPrBLKKx5t
	8dgs15drkOcJj7n+LHuPq5pS7zPM0JvLjYj2Qf++SC+9Xk1ycBiMfPyg2ZcNaMJb0A0LRMtzUa2
	gVikWHE643AZrsAPBkIVOyjigVnWv83HXQot6MBN66loldFoeq3PGIP2SaUo=
X-Gm-Gg: ASbGnctbGY4PDeUPpw5CkSTcbjMFYjDLCJtkDXCSnFcJrYsryEW4tvCQdEii6+cWGEI
	QhM6TwxdxJwNFU7rY5J5NQzcMKCfLshGtzpkK7KZCOyW31IWBgbimqZ6vtVyp7EpiV++OBdKV5i
	JYpNh1VqQ/HXWa0FYz1M4CVatAxCyZjcjancoh9ivGGtY0jkAVHFKNIyYhr9xOSI3NjBInZ/LZY
	UeIX8REbrB8kpzljyj4b3GLUnuth2PzNwwkK6fkqmq/oDbd5pvvs32k68PCPmvc3exWaDjgbdB3
	kfwT4rHv3GITSoCzq9NB1ahsVutzF6cxOZ7ktJfvTGIBUJdY6EUa+iWaKwIYc9bXBLamHriys2Z
	0tc5qgqykUxczsiIi3NM3KA==
X-Received: by 2002:a05:622a:349:b0:4b3:d2c:f2a0 with SMTP id d75a77b69052e-4b30e9a9735mr211937281cf.11.1757076486028;
        Fri, 05 Sep 2025 05:48:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2ElF7QOoyt6gf6FW/4zDA+dbADMgok/NNv8+HL6CTAMy+7viHFeskOkCiSzRQ+mmOfHHfSA==
X-Received: by 2002:a05:622a:349:b0:4b3:d2c:f2a0 with SMTP id d75a77b69052e-4b30e9a9735mr211936971cf.11.1757076485517;
        Fri, 05 Sep 2025 05:48:05 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0466a962c4sm694167966b.71.2025.09.05.05.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:48:05 -0700 (PDT)
Message-ID: <25489432-7cdc-4e99-b5a7-eb976df302f6@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:48:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/14] arm64: dts: qcom: lemans: Add SDHC controller
 and SDC pin configuration
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
        linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-2-8bbaac1f25e8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-2-8bbaac1f25e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfXwfFcb490SOo2
 ovcJrwipiJmA3wSRJLxISMmXcBQrPmbouIOblqW16Rhf5DaFyn7xBZaDbecqEK9NAJbDOyJN/nG
 48QIfBaF94d+89urUS3U4PYlgmnNt/qttpJPRxawUaeHmDW0zzqqmvEDyQOFn9W6f3jD6AOHKoB
 3ZhMXKD7InABIYIj8hO6vNdVZjJh7MDK1YGSQzxu0rXictr37msWAkqZwTjqqBPSEas1DWlqkky
 f+y1ZfctBGeiaUicrp/DhR4dOh1SQHp1badLvFDXDDxWQk2y5S6bvvhx47VbYLDmCpBB3EHnvb5
 IN4XLqYZhwqn96LC9D4m1CzyJxi+vgv80PaT6lorVmICEDLrlsW6WznZP5PYyJDt3UtifevD2rh
 2J34oD7z
X-Proofpoint-GUID: FrV5NyQduYl_KHzr7QNLxDPNbrr-CKTn
X-Proofpoint-ORIG-GUID: FrV5NyQduYl_KHzr7QNLxDPNbrr-CKTn
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68badc07 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=EaOeOJoe_TH6RZfqOFQA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On 9/4/25 6:38 PM, Wasim Nazir wrote:
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

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

