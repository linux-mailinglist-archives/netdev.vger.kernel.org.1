Return-Path: <netdev+bounces-214913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E08A4B2BC8A
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 11:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49FE61BA586B
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 09:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3021D31197E;
	Tue, 19 Aug 2025 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nb05A76Y"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B617B2DE1FC
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594260; cv=none; b=m36W8g8uJX3ksQ78RfILdlN4pCEeB2mZQXMPPe4Kuj7QUSUDp+0Qyh9JO02FO2Rll0xOpaLkoFzVYjrf8uJkZMH4L9WkQRW5iHQ0Mxg9OWEH45mWIvlWgWPn5dWSPaQVtwpy1Mx0mQaFCWPphaib7hkERu3K/ZYX2OGPVQ1Izzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594260; c=relaxed/simple;
	bh=Ur/EDwulXmk+KxS1Iyo/HiGIsV1LuoVRseDCDX7NNHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/nfKaY6OJ1iCkfW+PY/zxGYFSbH6bUxtuqxDUzev8ySw8hGE95LPM0xkXn3ARU4UCUZ9CnZy9I70/RFtsNaBYhxKNtHC8d6tLnyMMUA8yf0x8mrCRWZogixBKkSptuz/vW/jTUEYpXbTDZqmY02ljnnnUGjGYgyoIIXMOB0d44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nb05A76Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90uOk023878
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 09:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PtQwBBE7A/L6DYrB3suka029FN2KX9K7yxrcnIgCQII=; b=nb05A76YpPiOGSz2
	vwKgyfBmE6HTLMxdi6KMSAwl+lCIrsM15BUf4wC5FcFazt++cmigwggE66ZVHZ+Z
	LII/VhS37canuQuPj57BEoCVcQtDCQRHJZa1bDvjE7RmxNwQuI0qOdLDNEouVx1W
	RXipSQsgCZ2tXrvtKmTPYVnzEQY10R31absN9NHWNQ4LNLFpHAHGlrwczdPAbeZK
	8CvgKPFlbbnMT31my/tqNor12JVqpfefFg4bdNMJ7bIVA2gjNFoaNn6ovC/0KrYy
	e3hZjWpl7xsh7UcxJcedHUcNRbJkRpLhqe2wYrcCxtTZakAiMefhOTSv3tC8E9Lk
	zG1gJw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48mca5hkgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 09:04:17 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4704f9dfc0so5116406a12.0
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 02:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755594257; x=1756199057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PtQwBBE7A/L6DYrB3suka029FN2KX9K7yxrcnIgCQII=;
        b=RP6qzdSpmRWaAiWOyq8N8wBXJQ5bXKDD1xx+Ea53JoWFgF7DyiCbd3drgDpiD8yfdc
         QRtz5OrkZ/mcTlGyWs0RykgUh4D9qQAzecw07lljw5HP/ky5Rn7lki0Y9GwiVpZkHHSx
         C4smu7lNdvsi9Mm3MTvKtY5VZVWiCR0K9Ks0whp+eMms3RSmphvQvBIcsie/xApwTTfs
         BZFl/jRiZZFxjHSuwQAK+CQ+DblbDNpgZDVBB+nKqJTPC9Sp3PmaVnhXyKbCwTjEb0jv
         LDpFssEo3mJETIwem7aJI2OBOoFaNsL21qxcazyZ4IB2XHYm63GjNhpzfhehV+6urw2K
         ijxg==
X-Gm-Message-State: AOJu0YzB48ftHdWFer7M6msGbWSJ3umtYxXxuWLHO9aj6TT8O6Pv53pR
	yWKkptQloaDlJHAW25mIm/ghC4z6GdU+V5VNp8ILb4tDPIPh1qjyEZ1AeQt7gRoTjxc3qZSyVpy
	+YgTFUnb7LZDouATh099bsTZ8FIIm2/HX4or1qzbT3rJ29gXp/1wxCoUwPP4=
X-Gm-Gg: ASbGnctUtQnSPtKjC4LdyNTmAMgCwo8a+7gqKYOTJ7JK6n967aSqceatCt44IuTzbXw
	KIMhdMjidMTisj/DcdeeeMUzMKuzDoZb+qkGzWJXyzp9+k2HRe94fQVipNhuIbrmbprsgpvYcsQ
	OtI5Toq9BKhCd2PmHDddTDrvcJ1I6TMaTe0ilBrDLoT+bHgpsYU1GRowQgafJcsSDzPQ5AKkUFW
	W8Oz2kXFRanVoD3dagTljCuAWqfc2vN6Ji0MVgpXa/5OJAmYn6072VN/EyZFTCF8PnqnXiBEpYo
	fLUtRZlKhHiMCMJliucFgTCJqYCFwuHg3lrFwuDegQAERc0QnYihAWbeJ3r+ZFTs3FPR0Khys1+
	IUmgNxL0EdoxNjlntYNiw3ZvIjdGNvxsj
X-Received: by 2002:a17:903:1205:b0:231:d0da:5e1f with SMTP id d9443c01a7336-245e0f2775amr16133815ad.21.1755594256725;
        Tue, 19 Aug 2025 02:04:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkh7QwrfpTpI4CY81hIJagXgTCB6D+xkbxXMTtgq4VmPlFbLxOxb5dFrnqC4gKaobuk82+qA==
X-Received: by 2002:a17:903:1205:b0:231:d0da:5e1f with SMTP id d9443c01a7336-245e0f2775amr16133355ad.21.1755594256080;
        Tue, 19 Aug 2025 02:04:16 -0700 (PDT)
Received: from [10.133.33.88] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f8d0sm102888145ad.100.2025.08.19.02.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 02:04:15 -0700 (PDT)
Message-ID: <1394aa43-3edc-4ed5-9662-43d98bf8d85f@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 17:04:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] arm64: dts: qcom: qcs615: add ethernet node
To: Krzysztof Kozlowski <krzk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable+noautosel@kernel.org,
        Yijie Yang <quic_yijiyang@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250819-qcs615_eth-v4-0-5050ed3402cb@oss.qualcomm.com>
 <20250819-qcs615_eth-v4-3-5050ed3402cb@oss.qualcomm.com>
 <c4cbd50e-82e3-410b-bec6-72b9db1bafca@kernel.org>
 <157c048d-0efd-458c-8a3f-dfc30d07edf8@oss.qualcomm.com>
 <0b53dc0b-a96f-49e1-a81e-3748fa908144@kernel.org>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <0b53dc0b-a96f-49e1-a81e-3748fa908144@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FdU3xI+6 c=1 sm=1 tr=0 ts=68a43e11 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=WpKivvdH6quKUe0GCQ0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: pxddp_f2tBwGZ7brcQdWKMMPbjTNtzAk
X-Proofpoint-GUID: pxddp_f2tBwGZ7brcQdWKMMPbjTNtzAk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDIwMiBTYWx0ZWRfXyOm2QaPcRScK
 YWWFbnPkHvOcYq9iGhPIfN957foWaF4rGXrYVIE1GQNAsUlYs9ij+Xa0vyKcZ17flG8ScPLTO6z
 ISJh3WLKCOsQVaHCAxN68j71P/aoHTcFZpJ8RKae5xi23Ceioh0RanC+fvGGI9jDSbI78/i7xYf
 km7L6LJIzi/NrZrQRkciiShZ9EfgThghEYB6X4H6EoJIjJwZgv/cuIxmX3yflcRfrxZuyH8GopZ
 p7OR7H+dxGAE/z7/tKrMnWNehPGBBsiEkhiP3iWdecITdJWaUZW4Qm2u3x0JZFq/N2cMxck3atc
 Tn66cDsg9iYMIq3EqWPmJ+MMFzkccv5iDkUxEOzWdE2VPd24nUsQ1xj1n7A3qrwKtVB9fozdixQ
 taeuSh34
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180202



On 2025-08-19 15:15, Krzysztof Kozlowski wrote:
> On 19/08/2025 08:51, Yijie Yang wrote:
>>
>>
>> On 2025-08-19 14:44, Krzysztof Kozlowski wrote:
>>> On 19/08/2025 08:35, YijieYang wrote:
>>>> From: Yijie Yang <quic_yijiyang@quicinc.com>
>>>>
>>>> Add an ethernet controller node for QCS615 SoC to enable ethernet
>>>> functionality.
>>>>
>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>> Signed-off-by: Yijie Yang <quic_yijiyang@quicinc.com>
>>>> ---
>>>
>>>
>>> Why do you mix up DTS and net-next patches? This only makes difficult to
>>> apply it, for no benefits.
>>
>> The DTS changes and driver code modifications work together to achieve a
>> single purpose, so I included them in one patch series. Should I
>> consider splitting them into two separate series?
> Of course yes. You are just making difficult to apply this. Patches are
> completely independent and even your internal guideline asks to NOT
> combine independent patches.

The challenge with splitting this series lies in the fact that it 
attempts to reverse the incorrect semantics of phy-mode in both the 
driver code and the device tree. Selecting only part of the series would 
break Ethernet functionality on both boards.

As you can see, I’ve CC’d noautosel to prevent this issue. Given the 
circumstances, I’m wondering if it would be acceptable to leave the 
series as-is?

> 
> Best regards,
> Krzysztof

-- 
Best Regards,
Yijie


