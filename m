Return-Path: <netdev+bounces-244192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB17CB2131
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 07:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F302D3022191
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 06:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3EA27380A;
	Wed, 10 Dec 2025 06:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SQcI/UkZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WJIGDbdm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCF62459FD
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 06:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765348234; cv=none; b=H/ki+1BCj7TY1oRacOqcj036wzcAKOnzkHbCmHDr/flo/oNYL38oPzscsDNyaaAJQDVxtZo84h/gI/DMYHx8S0EdV63oj8Rga7WOxV5udLpmSP51w7w/IDXv7hJdmhI+KriZSQDgzhDvjLAwAzJycL/5t4/+mbbPoUTPBRPAQSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765348234; c=relaxed/simple;
	bh=O8HUoaSUxN0lwQuk2R6pVYJ/E9trzG6EwOSZXVhKEdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOzfGOFvccp9MIr3ioqkqg3zsMo9olK7G2eVO4a+Yu0hPM/75iwcJsgrb7dEnTaQH6rrk+6vJpHVO3JnqnBcwcmyfsPupz00xsdev1zJSjUFSB7MXuAmZJ6PPmARDPiF06EGVE/5jVaD9Hzhhjyzq/qEbqXjf0sq/5R38Zf7KUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SQcI/UkZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WJIGDbdm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BA6DvUj1954053
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 06:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6q9RFfbyN7BJ8f14Run+4QbQe+TihAeoBebl1Z0ZT0s=; b=SQcI/UkZuz82q2EC
	ugord4t7WemhvS74IB6IjG8/CJKQisPLSguABIb/HjwJzzYIa6bF/fFVjSrTb66e
	78EsLlySuOAQ6DPTKGrZz3T/HMFFcNTwunGqoiW9rmbDrhXcjnNVsYWIpcFY20cs
	fcgtSJRwI5doz4alP7DDOpaPjla7rT4ylj1em32Xqskeyr0ZNdjj8weA/xgn6BgG
	1AV9y94brL3iSdovkagW2QuWCxQd23Jl/XhhOAPWImzbC0HWDkGHnybyQ2BUfMur
	0VITdoQ7U6kpGzUTBH5sNFyeRbZ3qAiDa72wVeQt6ElLmgIB/aVHGELW1TGhhEdS
	mmkH0Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4axp5p2nyk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 06:30:32 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-340c261fb38so11328403a91.0
        for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 22:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765348231; x=1765953031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6q9RFfbyN7BJ8f14Run+4QbQe+TihAeoBebl1Z0ZT0s=;
        b=WJIGDbdmhMl/qlg6PO1EI06sNehQuS9Sr0avFIQhmd9qxFc3hAZSymMXb1MD6nisGe
         WOgNGMenmg5QTMFOq/bd6TLvGj0Dqk+DUcSHVZeReA4q3b8VwmM5e5BfJtyp8rTvxm9F
         CqSEkMqyZNnYELK927+t0JS2IYe/OnLZ50eLinlvHn1flLvZhB/cLlPfnKCyhVckvRQb
         SHDphqgn6sJbacrA6mosspXKXrLJW8h5gtcYX+7KtvyGyvzHD9ZL9nHYGNpzzTwNADSR
         pbTJodClepU5wU2QCF7DK58KDGGruZZgrAaZYxhHeVcE7fRxwkRe88JNlErRg2vUKyv2
         pVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765348231; x=1765953031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6q9RFfbyN7BJ8f14Run+4QbQe+TihAeoBebl1Z0ZT0s=;
        b=m2OVwNrZc8BOq09ihR2sHnOCYiCJFWD8YhHm2uDha2/euVv/Ytz2wldgRkeWOCIAZm
         QH73bM8FZG52cRQESTTUDnbZN1Z4BC86tmrLygtqc4zxAXRoBtccN0CMpZoIa/BuNJG6
         dM4VF0BQobrxQbjgkjlwlSqdx5oetL+gS85AgIKmROqVb9Qr2kbG+mxSnPOORSHEuZ5e
         N37P2oy7xh+NgXKizroJcaviznsGMa1pUf7zLOOO5VFBAD0zkkUpxOtbyQ90pPVc1bVe
         LKVwK6MHoTXh5tiAiF2IzCKHWsD10/UzuRvOnClSwvPHwG0G03GsnWNDdHmAR8R+Q8t5
         OnlA==
X-Forwarded-Encrypted: i=1; AJvYcCWDtupYRXUgWCzrLBh+wGn/wW1rHXpwo60/cVHm4vi/AviE052afb0PDcVf5wH+6LJOuHdF4tU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzAHX8b0B85Vir9YxNvG19/VRLHW34jJcxTHgKwLbndwOqpHw4
	G0cLwCraa166Z5hoXweXEqC82WKoRHaOsUspftnVHYVZ2yPrv7mVj+LSjjz8hiNAetl9m6xYufA
	29oQ0Szmbjs5s8ILlg6hgBTNiJOvkJC7h1rgsa13pLzpng0DSm2CXZWN1q4M=
X-Gm-Gg: AY/fxX627cc5f/qfsTXaD+2OQqUHTetoADlFvIauTswtPr8Nf6SKiHtRvVybVm5MvV0
	Ox4H5FA8pg8QUraM4YQ9hESVEbQGkb/WvsmjroHa/B4dNKiN5NeFHS5e0XAjXIwLaBPUdq0Ndd2
	laQFBo1oVUQzy0vuaasOVcojpwbYevPpE8xHESOt3derTiSai0PfENHI2BLNhgmzgmNbB3Xr88x
	FaIQ5XQG92BmQiSS5OlQBA/e5PP4pcIl/lVvtdrcvistkTb9dqGvazLvwwzd6jWSv1T0OwGQt7s
	FTIH5qfHe/Q5fPceMnI+geVhQoZ0gcUgmt+mG0Ji85SajDPIZ5vV4SLLsbH4C0QhXyAijxJYv19
	QjdHZ4ZBJU0oq98OOHmC8mIo/D1cA14ToNPRwPIe9QLg6
X-Received: by 2002:a17:90b:4b8b:b0:349:8a8b:da5c with SMTP id 98e67ed59e1d1-34a727cfdbfmr1209099a91.11.1765348231162;
        Tue, 09 Dec 2025 22:30:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXMxHZ4YLg9CFRwKxi/cgDsFxsPK6LFkqm/CLc1kVT+n707zz0quc94eSaxC/51ZwIj/qpLw==
X-Received: by 2002:a17:90b:4b8b:b0:349:8a8b:da5c with SMTP id 98e67ed59e1d1-34a727cfdbfmr1209079a91.11.1765348230691;
        Tue, 09 Dec 2025 22:30:30 -0800 (PST)
Received: from [10.218.37.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeaabf5fsm172705885ad.78.2025.12.09.22.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 22:30:30 -0800 (PST)
Message-ID: <3470cae3-d86c-4dd5-a24c-c7f4bf6e017a@oss.qualcomm.com>
Date: Wed, 10 Dec 2025 12:00:25 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] net: mhi: Enable Ethernet interface support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Manivannan Sadhasivam <mani@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org
References: <20251209-vdev_next-20251208_eth_v6-v6-0-80898204f5d8@quicinc.com>
 <20251209-vdev_next-20251208_eth_v6-v6-1-80898204f5d8@quicinc.com>
 <5a137b11-fa08-40b5-b4b4-79d10844a5b7@lunn.ch>
Content-Language: en-US
From: vivek pernamitta <vivek.pernamitta@oss.qualcomm.com>
In-Reply-To: <5a137b11-fa08-40b5-b4b4-79d10844a5b7@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: NEWhfuSrY5dZZVG9Z8VkNTlARDog-Nx7
X-Authority-Analysis: v=2.4 cv=ZZYQ98VA c=1 sm=1 tr=0 ts=69391388 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8 a=qHXWqmT0JF4T8da83qwA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDA1NCBTYWx0ZWRfX1qg1Xv7cnlxp
 TdtAyB4Hz5BOHID81CQVO2XvUhOAKeTspy83wl0NcYRpSM9fbm2uxIqcQd0nucU4wKDzF3SXceW
 P+LLrzSK5YukBfei7ysskct9mrB45EavzmBWqKsxb9bOnVzNGXGOLBZ2zsjN4mlR387eljz+Dtb
 5nsfDNgu+hGJQpfyLsMl1B1Hk+vBNqp0stprD98X7uzWVz4KvKOO4+KEOKv2xa9dEM/C2yoCD3M
 yjHK1Z375F8I/UyrdE9yZjM8wYJqTDT57dFXH2xiqVdj5y25WHBxhWMF1mDkcl2AnYMZhOFkW1U
 kqqSHpllcDcQxWk+1OvNYID+2vYhfVxB6iyfolW1MNV/ZRXyjK9LWzL7CD+ezk9nlYnI8yJX4g1
 47hRbmowlaFbnb4IevmYbp3kDUG4mg==
X-Proofpoint-GUID: NEWhfuSrY5dZZVG9Z8VkNTlARDog-Nx7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512100054



On 12/9/2025 7:06 PM, Andrew Lunn wrote:
>>   	ndev = alloc_netdev(sizeof(struct mhi_net_dev), info->netname,
>> -			    NET_NAME_PREDICTABLE, mhi_net_setup);
>> +			    NET_NAME_PREDICTABLE, info->ethernet_if ?
>> +			    mhi_ethernet_setup : mhi_net_setup);
> 
> Is the name predictable? I thought "eth%d" was considered
> NET_NAME_ENUM?
> 
> https://elixir.bootlin.com/linux/v6.18/source/net/ethernet/eth.c#L382
> 
> 	Andrew
For Ethernet-type devices, the interface name will follow the standard
convention: eth%d, For normal IP interfaces, the interface will be
created as mhi_swip%d/mhi_hwip%d.The naming will depend on the details
provided through |struct mhi_device_info.|


