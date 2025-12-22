Return-Path: <netdev+bounces-245690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2818CD5AA0
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 11:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FD9F3036C80
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 10:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF46A32ABDC;
	Mon, 22 Dec 2025 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YVOgBy5F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JDysaVNq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3106432AABD
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766400200; cv=none; b=R70k9px72mb4uwtLz67hMcvDG7Ji1dLg2hTBtMW0Zi67MxPYnle1wUASXo3gbuYQHRP80yzKW3Bc+Y3P9o5BJmpX2FT5m1GXYMg/hTBqWXE0e8j7duS3Qr7xmLpUw4CaybVJW4euE50OJHgx0VtKOjFjPGbPWMNvCh68kj16tn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766400200; c=relaxed/simple;
	bh=2Pr5tS6dx5juS+usjjxKwGgIGUxy5WfliLyjuU18sQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gpxox5zK7g6pOLn28sX2PS9AaTWWDLUUC7wkX5CSdfhNIbo1kvfku9PuJjSUHEPcnejWajOqmFhdZqQNVk+UBmPWc3LL6cjz8hfv6dJiHAF50vWKE6e/dvf4BffhrVS7U7NjWaaJiGjV8SD9QRs2JJIxgdz5EbTJ5LPghzch6cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YVOgBy5F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JDysaVNq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BM7miG63386689
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 10:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+H2N/T2rJtRvnuVUJj2Q3GgjdR9vEA+S2/MkJrPNIMU=; b=YVOgBy5FJ95VB86Z
	36jQFoM9hW6kfRGYAotCeyiUDR1472XXeXiIW+Fg7fFpjqRSKVYFV8DX8abjIjxR
	LYpCF7cplt/muc7lHRl1l5q2iPnzOGRa6FtNAHkmfEnHx+M9RnL4ZtK+Qso6YR8y
	X/1h2kNKTvMX1fnHfwtJmDnSE0IqL6pjj+Ws35gARP9lYptb0lNxZ2w5l3ngNIUc
	5GXtoVDD0gnnvqnd5spMsgHGwNnF/RFt9/afIAXsSjb1F0GTXOVGBIrkIfK3zgbq
	4kNdEAfIjdtLsSne0eHo5lkKYcbX1+BWzQTDo36F/lovSrMKsPApofpsHQtj0XJd
	effqxA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mtqmr5n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 10:43:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29da1ea0b97so106803085ad.3
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 02:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766400197; x=1767004997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+H2N/T2rJtRvnuVUJj2Q3GgjdR9vEA+S2/MkJrPNIMU=;
        b=JDysaVNqJlAHkJGy8tYDXHEIXcL94hPH923AFGOz1lySOjTXWrTJMbQMMITa6elNNl
         omx6Hv4UwALrLs+daoyTr5wAMqCu/haeJoG2HbIROe30gk91wUV568XKxyIsdYSebR3F
         YeiW6qGyRFTE3gBYj0ZJQoH/S7L7x8DMN1GK9KMpCrG6Jx7pP4+dH2rSfp/Lr539/+x5
         15kvItO5l57K74irKUdkBtOpcA7eTA+SDYc0d5jZPI0O0US52xFxN4g+bZkDLlIvN9Dx
         pZ4e487kp4Q0OeDQYFKZwEEHGIckCtFBoCYEKsZV4irGMmRgOkDEOnHjGEyDF4wFur32
         Ukkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766400197; x=1767004997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+H2N/T2rJtRvnuVUJj2Q3GgjdR9vEA+S2/MkJrPNIMU=;
        b=LZboV+5eWwafp2WVcCaHZODIx23zKz8gDEbgOCQbauYPb8f6pcPBw2JoNvniUBawlb
         TT65eQnH5nxoogNqxMbpS6qMU5e0xWDi6187bu+1QEdW/anxQXzrg7lefImZ+xbIh7HM
         BnKCtmdS2rEwa+0QEa6B3IzUWyMWwmhIF6azy5wU0Rz9nyHM9jAebiCANYBY6lniebqK
         aiDMoRQHzVr8PZ8GycjUe4RepMVuIm35hynBbyM8GtHgd0yACGzkCysXXDa8DRqCNfZ0
         J8ZEOqwz53b7xjN5y0p+wXAUdTjVlfmCm2VKAhyUTYaIjpH/CW9rhyTLH2+nFXx++goE
         73SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrPBodUjvBN3pETaHO9qcTLIlEtLgt/P6djP91kxdnnfkQ4zuhQFmTk4ZHi+dGr0NNR9G8Sdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLP8Ydledwxg1ZVGWTh/CMe2ySf8vEk35fIVo0zuHqzVXIBmAl
	+ppLs0YnQFDZJfZT/j0v4y3jCSWe8OcN+zlxRJZ0s/Zl0Fo2UNkskaG6KBMNVfMjNEYT+gNBcBv
	3pGrtF21hPl2v4rQNRpQX4k+7dMPt3nwHoLRI6WwUezXJGqM6Kb9jDAAvfBw=
X-Gm-Gg: AY/fxX5pPPALiJFV+nzDfOBhmwKYpYsaxitkx1aEOJWgdJLcMLIdFVtzPAX9SngvV2R
	zQYc4KtnoR6kzeOxyf62wrWuCnkYoLLF2xB5Rtdz++q09fWGmtCkhNx2555/Ws5A+CYdMmfWS7z
	IHWJSY6cgwSojBGYh+14w9GMkQXO+39RQ+jTWp5NohoViZclafBoPPzv+/KvYF1e96FCp2yYSMk
	xZoKztw1iMyxSX3sxPNvzEbiZgRwv28GhB2f6BiWKIG8ed/RGXJ/oloBFSI2RpzFKMmnBOQaGdK
	fsGAhnFrCBAckED0VoMmR069ftyLHI6472QJ08aS/NGpgy0wQaQRGyM2O8ym3tOp9C0I6FEJ4sj
	qB9ui5xmI4fFVKFYLybXFZ13KDJ8KDptgrCLr8UkqHr7l
X-Received: by 2002:a17:902:f710:b0:2a2:f1d4:3b64 with SMTP id d9443c01a7336-2a2f232c5ddmr98309825ad.21.1766400196886;
        Mon, 22 Dec 2025 02:43:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+XrVQ+S7HZ7ZghURDECHoXiME1DrfFnztE9j+C21cTAZrNI+72XesqqlcB1gGPbbGX6rC3A==
X-Received: by 2002:a17:902:f710:b0:2a2:f1d4:3b64 with SMTP id d9443c01a7336-2a2f232c5ddmr98309665ad.21.1766400196404;
        Mon, 22 Dec 2025 02:43:16 -0800 (PST)
Received: from [10.217.219.25] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d76ce3sm95238315ad.90.2025.12.22.02.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 02:43:15 -0800 (PST)
Message-ID: <0235cdaf-4c91-4bb3-9581-9eb24cd1aa47@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 16:13:11 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] net: mhi: Enable Ethernet interface support
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Manivannan Sadhasivam <mani@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org
References: <20251209-vdev_next-20251208_eth_v6-v6-0-80898204f5d8@quicinc.com>
 <20251209-vdev_next-20251208_eth_v6-v6-1-80898204f5d8@quicinc.com>
 <20251210183827.7024a8cf@kernel.org>
Content-Language: en-US
From: vivek pernamitta <vivek.pernamitta@oss.qualcomm.com>
In-Reply-To: <20251210183827.7024a8cf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8AqaO3iq1ymSOLc5mvUv9DwKjOqRHLWP
X-Authority-Analysis: v=2.4 cv=dPWrWeZb c=1 sm=1 tr=0 ts=694920c6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=xEj2kCWnBG9tpPoWntAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 8AqaO3iq1ymSOLc5mvUv9DwKjOqRHLWP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA5NyBTYWx0ZWRfXwCom6tsX3PRv
 yX1Y0bgbEN+DlD/xap4MWNgERhBKh0EflHoBqM74jXPVPCEnnfsg1OZ7FuqwgNzTQh/ai72r84+
 AxOvz56sfdNjWUZs5xKcDjmCm+gb5I0FnpMGh58GOm/wGsRTPY3Q28W0GRGBJLe1ZbiPTUkg60K
 iyUh9IH9QMAyIdBcYXEnOmnzwyR8fOysrY/62iOB3TG9Te/e6eZYXO+82T1C+0w6WEE6SS/e0Rq
 ZzCCvvHLuGJvLKNipz4T2feK4MEraE7y0U9bRlI/Gm9u3bLzzvD486ExDRdTbHeMArq/q/APkSv
 3BhKi8lp5w89lyWlhoiVRnumI4gjgTcCpeAsKLBLOSTfGTqSt3llwh8l6s9oLTZ60gA6p9jOM3K
 1+ejwviIG3quFkqnKab9FYA9wI7n/rVrFPQhflna11eDfA5l+Cg5rBZ2e2BsZdW7oEinbTTaMYt
 L85xnIHMWTpwUAGrajw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220097



On 12/10/2025 3:08 PM, Jakub Kicinski wrote:
> On Tue, 09 Dec 2025 16:55:38 +0530 Vivek Pernamitta wrote:
>> Add support to configure a new client as Ethernet type over MHI by
>> setting "mhi_device_info.ethernet_if = true". Create a new Ethernet
>> interface named eth%d. This complements existing NET driver support.
>>
>> Introduce IP_SW1, ETH0, and ETH1 network interfaces required for
>> M-plane, NETCONF, and S-plane components.
>>
>> M-plane:
>> Implement DU M-Plane software for non-real-time O-RAN management
>> between O-DU and O-RU using NETCONF/YANG and O-RAN WG4 M-Plane YANG
>> models. Provide capability exchange, configuration management,
>> performance monitoring, and fault management per O-RAN.WG4.TS.MP.0-
>> R004-v18.00.
> 
> Noob question perhaps, what does any of this have to do with Ethernet?
> You need Ethernet to exchange NETCONF messages?

The patch primarily addresses host-to-DU communication. However, the
NETCONF/M-Plane packets originating from the host will eventually be
transmitted from the DU to the RU over the fronthaul, which uses
Ethernet. Bridging is therefore required to forward packets received
from the host towards the fronthaul Ethernet interface.
For additional details on this architecture and data flow, please
refer to the O-RAN Management Plane Specification:

O-RAN.WG4.MP.0-v07.00
O-RAN Alliance Working Group 4 – Management Plane Specification
Chapter 4: O-RU to O-DU Interface Management

-Vivek

