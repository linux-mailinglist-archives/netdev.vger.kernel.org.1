Return-Path: <netdev+bounces-223624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0507BB59B9B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 17:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40E6F7B6625
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F0833EB03;
	Tue, 16 Sep 2025 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JL73Uz32"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ED230DD31
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035507; cv=none; b=lvVovSSXyjRjsTNZqCTUUuIbkqVN8kroWOXHwiI2w57Zkp/ytfD6bNzaCk9xI71C/HNQYKM+zKmemYUjnqH+72cAhimD4ly/Z0T8DsIFvReHlzO7ChhauxreIF1PrLh8N6xIOvLfV2ZzSZVQj7R0BkA6flw+sfc0qLk/zl1VedQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035507; c=relaxed/simple;
	bh=t7UUwd4xgMft90yTMEDkSkQCO8HRauBhf0Zx0laARP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/idK73Tp+XlTSe/2Rl5k9/Kon+IjhRcNjxkAUxewK77xj1Jj/8YID9yizAChhS4FzCUManw0i5I9SrsvuZ7LL1vANRcLqZ5t9vVDnWBKLtnpoDjAjdNKqgOK8Y+x4BB2ZJgR2l+18pBVtiiBOuRFvpuH6iKmRqdGJPeeSwyZU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JL73Uz32; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAAXNh020364
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TNby5qq49hfo4o9k//m3Xyh7
	0OtDv47+M1YG9MtLCxg=; b=JL73Uz322hjo7db1y8VK6MOqpZS/kNSXyhblTxji
	X/8ett4qqsRTgS904srclOUiORO9cUQ6fCNQAdqVvbcsd/FpA1QncRkBfd94o/9A
	ayIVhYJNJflxOOTiId6jWan/mBB5kLQNYuopyYXUUqOWrhXA8sAyxX78F0XvlXJG
	pHHv0lRCGDuOZLzhNvBwVoJrRRHia2ITx3ocbJdXEAH7TxVOXS2Ot2X3WxnxRsKs
	w1eOZm7vGwK6MbzBwazgwh3l3yTmEKfroCsKUCamZGZk1e5bGDicRtqDY167Q7ag
	Hs+kbQDaAo6941gLLkSbxgZDV1ZTBANlxA4/IP/V80SL4Q==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951chh89u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:11:45 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-8c6520fc3e7so980636241.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758035503; x=1758640303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNby5qq49hfo4o9k//m3Xyh70OtDv47+M1YG9MtLCxg=;
        b=GdUhJffSBF9322jRVG299xzF0K6wWmLE1I8P6xXBupVK/C7rRwAiHogBizPp4AejYS
         6eKZ4L0xPxTl6o6h5EF014tMc5QYfw7jYI/d+pKWKm8KuzWf1ViMpB4MoUqr/Hx3uwvM
         WE3xFKTOBouP7si50G+zzAwv0nO+BSs1l/bttW+m6cTcfXPLpyTSgv3cO/hOUxy6huM2
         HTJoN3TfgMg3f8F9G0kL/LlFqqvW81dskjaB8/QBR8tZGvVELA2P21RfqGhHv+dVmWQ/
         Atjm+Px0tRtbSrIJtv3tYym+ih2/smECpZnIpQrjrymVKxcu9DUgnMu6VyYJNyBcvBkV
         7U4g==
X-Forwarded-Encrypted: i=1; AJvYcCWL/SzO1mZaqhiFf2SQ4GYJ2sEQPt8aT/CvuEPMcs3YS3S+5w/tD6aiMkWLRmNdzkwGaXWqGdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoTP60UFrl6+fJvKTqIW0uJ2IM6aNzY/hO11XucfX8tAoZuFnA
	iB0RJj2xsS/mgVp8RGLz9/3Qk67ARnR7NE/0TKjaVbSpNW6hZUKR525cJ9keOTn1He8+zmu5v3D
	CiII6YqWre9WSEjaK7Re4TFdf1TUBkHGHq/NggKfFXQK9ZwTJ+IAw9ZmyJ0k=
X-Gm-Gg: ASbGncuGVEEDmJynfjMoSfE2/u8NrYuv5fS1LQeFmBWZzo33GNez0zFbEyL5Id2K+Pf
	hcGVxdzZHCyNjAnitRy9zXpBYLfOOlNDq7emfLhJh6vXEj9NLrEXwLEgOgZUvO7AbLaLlzy/Qgj
	LNbAZ7xgx6Swxnneb3hqFah5W1dJZEQOL7sc1JmXn5c+ZUgbCY0pg8VZMgCi1luWfHP4Ex0TWR/
	oMFeEgK3gBAD26bdMoS930dsZkc6lTMrk3AwsxkaVXJBeauz9Gc/4HlHIxKtDNKAV2K/6pH6B+B
	sPLhnc7EVJ58K1x9Dc7XVq0UNsc/mnx8Fs7edBs9kOYXg43z2KTp+XLWrtM8OhlovJG/59QFFE4
	cce53fCiwFDJYGN52auK+fv05y9kGndpJqz0LbWRt816O8d9ulB1A
X-Received: by 2002:a05:6122:3bcd:b0:538:d49b:719 with SMTP id 71dfb90a1353d-54a16b2c285mr4799746e0c.1.1758035503247;
        Tue, 16 Sep 2025 08:11:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjpODeFy3ymdDzfM3pALWwp0engqNOO0v2fjb8KygHwUWmCU8dovGzcM73w2iuBtRoo/d/ZQ==
X-Received: by 2002:a05:6122:3bcd:b0:538:d49b:719 with SMTP id 71dfb90a1353d-54a16b2c285mr4799705e0c.1.1758035502721;
        Tue, 16 Sep 2025 08:11:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-35828d19a04sm15474721fa.9.2025.09.16.08.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:11:41 -0700 (PDT)
Date: Tue, 16 Sep 2025 18:11:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: Re: [PATCH v6 02/10] arm64: dts: qcom: lemans-evk: Enable GPI DMA
 and QUPv3 controllers
Message-ID: <pwnt6obqsyq3o2qzqk5fcydzlhwv7ycmywvdeo5pwhvt6kbw35@ce36yjyo3hp4>
References: <20250916-lemans-evk-bu-v6-0-62e6a9018df4@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v6-2-62e6a9018df4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-lemans-evk-bu-v6-2-62e6a9018df4@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=eeo9f6EH c=1 sm=1 tr=0 ts=68c97e31 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=lcEb1VsSqg0gz2oZhFQA:9 a=CjuIK1q_8ugA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: uqsC2bmWqNZi4nJJRP7B5_pK7oVMNbNP
X-Proofpoint-GUID: uqsC2bmWqNZi4nJJRP7B5_pK7oVMNbNP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzNiBTYWx0ZWRfXwQ3FBpCjPSvB
 /ViJpzby8st+/UM1UeKAziItpAImwT07sinXnQDH5seOqwF9Fa9QagFTbrA9hPnyNX//PHajzgH
 tLgRGycXOtONwbLjgq6OF+xedr8y9haxQQ++gMt2jdYhnfXuvm15OiVXhlbEJ80U+QbNWHlkObW
 sehQEPGaSXCcHeDw0EfnHO/aetsFvwnbDDLp/G6qeB/yA7byJ1EZZPOIJFgYtHhnxtlGnZ5GSVd
 TeSMkfdvfp6x+b7NvkJdNK7bKg1V9nwAz7kIRc4WgZ+si03kTO9A3dyA84tBh7ldwxEGKxV0fgZ
 vKQFK7RNPs/REJjsYu3LkSV+PY2LaB5EHlE0Tnm/cF27k9shCR8GlMqfhoDVztmJe7Nru38iaSH
 rlQZJEzK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130036

On Tue, Sep 16, 2025 at 08:29:24PM +0530, Wasim Nazir wrote:
> From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> 
> Enable GPI DMA controllers (gpi_dma0, gpi_dma1, gpi_dma2) and QUPv3
> interfaces (qupv3_id_0, qupv3_id_2) in the device tree to support
> DMA and peripheral communication on the Lemans EVK platform.
> 
> qupv3_id_0 is used for I2C, SPI, UART, and slots 0 to 5.
> qupv3_id_2 is used for I2C, SPI, UART, and slots 14 to 20.

Don't rush sending the next iteration until the discussions have been
sorted out.

> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

-- 
With best wishes
Dmitry

