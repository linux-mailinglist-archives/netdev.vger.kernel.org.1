Return-Path: <netdev+bounces-222574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 706A6B54E0C
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 14:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD4B1D64A2B
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 12:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2980D3043A0;
	Fri, 12 Sep 2025 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="isoXHVb9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F83019AC
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680087; cv=none; b=K/60hO9KWXbEyL6ofgFSfeZxe2H7ffww/x5VYzvi6+Pc2r77yn0OlrZYhWv/+o/sHSUnh+XSbCPXuicepwLYNv8cVBni+DlcSm4w1BXENiyufnihmcafEYxsK446MjC2a0KSck24YNufxtAQaqIW2sto0NCwebO2s4tkVTF1TO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680087; c=relaxed/simple;
	bh=iJsSVwqOcKJ+jvcqQulAE5UoFoAGbSHsV9vI7EwrTJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TrTAktYFe5GHlt1i2s8tpLjqHap9EyZ1CbwCsODBRmml4y+fGalHTbmuH3KFIje7IR4yw3zWVffEcxFiTMq8+DmPRFugL3KAhAc2vFB8d7fj2ux6g9OVvqskWAQHdlw6mleXGjI3tC7cBwMBRHms0aSLe+JnG1zn7oKU8vXtKuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=isoXHVb9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fW0c013177
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hFUuM/6CWr6E6Ua8sjPcJgSq1lagiIOIVJ2nUPnOckM=; b=isoXHVb9i2tKsBRJ
	TQm4lxsHWuFDL7n3ICfQNr262hzzQiEbEnirW7xfG/7AoV8ef1UK6Oc8txWnMXkA
	uxSc1ukeqFtUkLzScgVskQLkNub7tfNBboRwknb7MMknY+C1DYWtSTbt0mEKpO/Z
	PApWevCNI/ZjOkWlZL5uoMwBfZOKfYiXZNEWLsEPPeQf/9sKmO7E9cZr0ulIzkqC
	XQoQwgJPqog8flCd5Bhxp0fZwSS2vxDQs9v9x/lo2QEEa46wKaxYKXGXXfYfLna4
	UC+J23gHmjvSNYciHYAvf4nvezoEx3vG9Z2g2XJVajs19Z2ktEeWUwgdZDQ1C+Tw
	uJbHGw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqgbbaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:28:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b612061144so2064241cf.1
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 05:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757680083; x=1758284883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFUuM/6CWr6E6Ua8sjPcJgSq1lagiIOIVJ2nUPnOckM=;
        b=P9OwcU4odeQ8dRu3Q6XKvRfkjG8gLKH4YlVbgAhoZeMbfGp2aoYF0pVd7vOn9Vi50E
         gEGI/6o2fKPWP0RyKAFsfz+LNow30krbd3Z2N2nf3ulTs5dFCGJf6HXx4yUwCtuCtigC
         yWFawPnWH5HOldFJxNbE3qUzmY6rID5k/Ux5poiYcR2kyFFM++T2IIxroVUac8LwQ3VT
         Ghc5luLyK5r/HQypgde6ZhiyRuSKOPUv+mDb63co/7sVY3HwBddQ30Yuj6+ICzyIw5oG
         6yrNoF6UpNhW7NAuEwK+s8wJXiaLJJTPGNnsjXwmZHyaikAl/VbzsIlmaD47XC1UXHQA
         JPtw==
X-Forwarded-Encrypted: i=1; AJvYcCU0SrPWVFBjlflZ66h7rpU7zzOtXbSZdXHKf2Lz6m822RJ2WItvMyZZOJj8rRNFkoj+tlyima8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZPU+I/gMe0VpGCIZcu+ebDhhyShzy0anMu1iJJD3QSmO2iIJo
	v8HSdHPdlFD+mxixG5i5hr/WwvJnqxEkFY+yYGLFqaXs/+jCnrWE/7h7FjFRtjfTmYV4DaJ7zZ3
	ki247J0d2/M0JjEOpchzHt69NhVP5txgstdZAtYboFMxIoGRWIopqVt3KeJ9WwxayFvY=
X-Gm-Gg: ASbGncsOLSahyyVRzcxmt33OgA2PLMTXJCdERXZL1xjsTp+N41RkUkLVObYKoN/met2
	+Guv2JOH6z57tcOScNQgHVzKq4XbWOEl6xAhQXor5XdIka/DE2HMMPYQUatapkABgZzVOaNlHTQ
	xTfm7fyVc7TtUnx8edHZi3xTLiunF54aHjBPqzn8YWDPd5DsJ5K7gKpIaU4DtmOSC957kgcCTXM
	PMgGMHml9MkpEHaC6s8TRzihHjLelzPUPBRbY6/MnAFyGiFTkzyADFBd5HgKsQoPB8SbBVfKx13
	YX1s2wDw9dCScL8zgVuRQviliGstO9RzpGaeicVLrMDxLWtQZpsdTGuuyhgL+RKVONosnGiGX+K
	c9nX4DEtMddRQSGrPyIyJyA==
X-Received: by 2002:a05:622a:1984:b0:4b5:dfdc:1f0c with SMTP id d75a77b69052e-4b77d06ecbemr20553751cf.12.1757680083135;
        Fri, 12 Sep 2025 05:28:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8QzuRduFlaCIEb8iFypsFpoHRpXBscWN+xA6q9Sfc+5OImw0a6uM7bXGrxC/zLDbpdQwBZg==
X-Received: by 2002:a05:622a:1984:b0:4b5:dfdc:1f0c with SMTP id d75a77b69052e-4b77d06ecbemr20553301cf.12.1757680082556;
        Fri, 12 Sep 2025 05:28:02 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd6f3sm359239166b.67.2025.09.12.05.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 05:28:01 -0700 (PDT)
Message-ID: <cb2a5c93-0643-4c6b-a97f-b947c9aad32c@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 14:27:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/14] arm64: dts: qcom: lemans-evk: Enable PCIe
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
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
 <20250908-lemans-evk-bu-v4-7-5c319c696a7d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250908-lemans-evk-bu-v4-7-5c319c696a7d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: WvUeEkY0Ce74zDh8uPjxQPr4nHqTPb2D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfXxc52wFtRyZ7H
 ic3xawKKGRHokh0oIR8Cu5OLPP5/n8fknJYqRwuAnSbwle+QK/fnIzvEC3wNHW5hDEMfFFsIXZO
 uJQFcUeBZwCA/Wrx4R3nzJqHNX4AeXLScsQbheOWhi6jnhAOQ0kLR7ZQI18JQ16oHHLwnKTVhwI
 LhFrQiqjGpI7W0626b4ocYqc6j19YbRpGYc00VEZ5mpUnIdYXyFdrseuRTVFa1KiwcmGdagbWB1
 avIaCYBR+isp9zCmWvctnEFDjIk31jjbA754rcfjj3GjEC+AN+lT6PnC11SIYEtCGTvRo4jpUcW
 fErdboQufSYWldURdLgtey5UD6BrNc7aYNxOYZH7KDXRrr1dWbwmM9h/30RmPGCvvQr9Z7VVdg7
 c5SV80j6
X-Proofpoint-GUID: WvUeEkY0Ce74zDh8uPjxQPr4nHqTPb2D
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68c411d4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=nUKbQzcQiuh6IjOItDgA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

On 9/8/25 10:19 AM, Wasim Nazir wrote:
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

[...]

> +		perst-pins {
> +			pins = "gpio2";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};

Pulling down an active-low pin is a bad idea

Konrad

