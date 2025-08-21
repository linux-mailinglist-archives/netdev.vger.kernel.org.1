Return-Path: <netdev+bounces-215448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8C3B2EB28
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 04:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19343585258
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 02:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23B1225A38;
	Thu, 21 Aug 2025 02:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mx8Xv+UK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F6F21D5AE
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 02:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755742939; cv=none; b=NCgxUgRp2WTQJ74u0Atg7LBVVLU+G5YiU9YNIaCzAn7mZDrxsXGg7NyECIf/Za+FX5riMVbJnu8jLuhzKH6Vef9uUCEQ++CbxYo4APt3x5hpkHoOax4u+Ird3hIrEyfStXeCsS5q1QyYA8BgcoPz7M7zouRu8usF9th4h3O5qc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755742939; c=relaxed/simple;
	bh=M+Tt7lOyvwNBEVxje7vB5+qnUcdtvBNxt4rOINYoqf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d/d3jiISJdK5eJmezLdBYtLFZITu3iBtCNPCTk1lKj+QJIot+z91h3Hzy6C5PYYz95fHOHjLv7eHfP0DanTVgGOuQgLnY0HM80iS+gCnuOZrrLWnlGEYs0Q2duSmmlTPru+4oTJ1tiH8fYM6oXUFov2mv7G1Fto6kPUrY6Uh8xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mx8Xv+UK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KGmO1u025745
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 02:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fhuQQAYtkFz1+EMzbo9h41xY8JijUtMlK2wIkAFemmg=; b=mx8Xv+UKFekjgIea
	zpwoOjBGpC8vG24HybBj9dFPUt5QlmnxYQI1nLF8qREnKjpKlPZWWhwvbIQSm75g
	AcfvH8kA10kv7f/86IZhqHh0uayUClUfBvRuLXE/AJBKZPrNY2mJlOufKoHv0fVy
	c0OBFnzpDknd9ZbpLkJ98UFg9FM+oxyx+q7o3t19K0C754pSN2QwlwdVhOeGq05S
	wyA/ACFZPVgH4tfzv/wZNXwBN7MwYWzXTMeO+citUmkwfWKIixxOuoUwhJzeacWI
	NaBtSrWeTcKHyU4ig+xdplvCIu80jwleequB4k36qWtceMtk4klLI/tzwrWQemCl
	SJD2FQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52aujvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 02:22:16 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32326bf571bso1226296a91.2
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 19:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755742936; x=1756347736;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fhuQQAYtkFz1+EMzbo9h41xY8JijUtMlK2wIkAFemmg=;
        b=RPdr7fcHsuu9Wo29EvekRvfyiVqpCf/50zSVtzf1rf9tCvxx4lfzO67pbNdqZfR9ml
         2HZqHnOaa1KM/TehD1TML13HosbnV9G9GJ/Q6sZAAvQFUFmeyAKLZQC7LTumhuGf3oub
         e36Ho2Xyp0i5mWeKVSPl/PRbxkqUZHoKYI1qrCJA9V5IwlP1o164zSDEZEUxfSYiS1OK
         AkGwrktppy4tPesRW5qv4c7oarflETJiIRHzp4AwvMyBLdQeZFvE8D4omNsojaSPVGjw
         +NBwoEjO7cUrMKAEo8TAEBov/6HjKAAoBZ2gTHFVqBlP86IPX5JFfXzA7ByTjTnuAHOP
         lpjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV42yhJkO155f6WP1v99kk/OD79U8FixBTZ15nOehLyXwVrhuj4Lhc/l31qAPhD3/kulBY6Ofc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPXVKgMlXRRbYD6NWlhrxXXtgtYJWSCivtaRz3N2zBUN5Ivute
	NnA2RT+W/fKB0vIOS4V7uHhM6C7TcnCV/XbyV6Sx23JoEotWwuyZgTFUaIMV+xH48Uh0RXR4XdH
	plEEAi+/vT/QPPGitJS2i6Izi5zwJNjOsjOhlYcMluOZHXhBqyvYo+nZ/UmA=
X-Gm-Gg: ASbGncvOhOnn2ODoafpyz0dHGMfwhvD6ybgI+QfPVu37tkxiV4BkET8ac4Lno93Cf8C
	JpllO4ebyzMbFmDFqrOSRPx7FzRF8pC18065s3Eh8rnblEY29C+RYuJ7XbRA3g8LhDqYLAgZwpt
	FbRVRuAPz6KMRLa52mu0uT9OEokAaaszHbVso2+HuBQmF7iCrUJWJaXH9yvIscNyLOcs7ElkegM
	qC947kBKskToGe3j04Ai3S+8P6VN7rb3QEz8edq7l7tbmPOU2wB8m7wWU5f8xuO6n/cczDGrFJE
	kcX9E2TiJpueliVrcUNiCYxXvJw4/qDYNvhbiSx6CxI8gN5l0IaBXY5z/2KjwS0pLSRqr6+uBBs
	9gBGcCpA0XYiTuettvHLOSJEtZ0qgvUgd
X-Received: by 2002:a17:90b:53c4:b0:324:e642:b5ca with SMTP id 98e67ed59e1d1-324ed13a72dmr1379011a91.29.1755742935710;
        Wed, 20 Aug 2025 19:22:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJRz4sysTqGhrRLL4dSQy2QlK07feYrDXxAVKB+n79aOM7MsuZWRLWFY/xgGqdwpBUmHYgnw==
X-Received: by 2002:a17:90b:53c4:b0:324:e642:b5ca with SMTP id 98e67ed59e1d1-324ed13a72dmr1378979a91.29.1755742935196;
        Wed, 20 Aug 2025 19:22:15 -0700 (PDT)
Received: from [10.133.33.88] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f23d745csm356703a91.4.2025.08.20.19.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 19:22:14 -0700 (PDT)
Message-ID: <f467aade-e604-448d-b23e-9b169c30ff2e@oss.qualcomm.com>
Date: Thu, 21 Aug 2025 10:22:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] net: stmmac: Inverse the phy-mode definition
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vinod Koul <vkoul@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable+noautosel@kernel.org
References: <20250819-qcs615_eth-v4-0-5050ed3402cb@oss.qualcomm.com>
 <20250819-qcs615_eth-v4-2-5050ed3402cb@oss.qualcomm.com>
 <80a60564-3174-4edd-a57c-706431f2ad91@lunn.ch>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <80a60564-3174-4edd-a57c-706431f2ad91@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXxHOTrkdEyfOm
 nkmktHRFIyBlL4iQyQP/fiuLd0CiOUnrypltQC/BuYshPBv1A7hHsLh8NUrPzFERDi4ZCVgoYbQ
 Uwr2aRwtMTyf++foi32OvnUHes/Uccu7N7/Mnp4RVTXYnlGFm5451CvEChjRjVBje3vZfGjXpmN
 KMGUFz/qj3o5nQP9C4S0u36CCKO0OzRNnCW86u4iz9R+zTTlS/8O0FGaaEPNA4B8nu9C/2H2ROt
 kh2flkVFCFX550amzD8t/22GCJlNG84eY49Qt37RdmtZ2ukxP6bihlw+yvTgmIwJGPDQaYIQb4H
 1ktXITtzvsmmqH5NYiVe6l4ge3TRFva/IjEBNKNX0Zj+zCEIlAJa9CACUrM3APMxvIIB7ga15Zo
 qBBASPZ+bAF+0KZOSp6T4SVs91izDg==
X-Authority-Analysis: v=2.4 cv=TIIci1la c=1 sm=1 tr=0 ts=68a682d9 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=uddfqdTxQVX4ueY0IN0A:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: nPP0gVLmrD7e0GbvTkyHxHxQmGxWuDYW
X-Proofpoint-GUID: nPP0gVLmrD7e0GbvTkyHxHxQmGxWuDYW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013



On 2025-08-20 00:20, Andrew Lunn wrote:
>>   static int ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos, int speed)
>>   {
>>   	struct device *dev = &ethqos->pdev->dev;
>> -	int phase_shift;
>> +	int phase_shift = 0;
>>   	int loopback;
>>   
>>   	/* Determine if the PHY adds a 2 ns TX delay or the MAC handles it */
>> -	if (ethqos->phy_mode == PHY_INTERFACE_MODE_RGMII_ID ||
>> -	    ethqos->phy_mode == PHY_INTERFACE_MODE_RGMII_TXID)
>> -		phase_shift = 0;
>> -	else
>> +	if (ethqos->phy_mode == PHY_INTERFACE_MODE_RGMII_ID)
>>   		phase_shift = RGMII_CONFIG2_TX_CLK_PHASE_SHIFT_EN;
> 
> Does this one setting control both RX and TX delays? The hardware
> cannot support 2ns delay on TX, but 0ns on RX? Or 2ns on RX but 0ns on
> TX?
> 

This setting is only for Tx delay. Rx delays are taken care separately 
with DLL delays.

> 	Andrew

-- 
Best Regards,
Yijie


