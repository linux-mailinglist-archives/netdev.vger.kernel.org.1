Return-Path: <netdev+bounces-245689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 666A7CD59C8
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 11:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DFEF301A19C
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 10:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E063101A7;
	Mon, 22 Dec 2025 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TqPv7ecc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FxtaQIaG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AE930CDA7
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766399659; cv=none; b=sGbTWkBJ2EC9R6lwtm57RmjoPl5nAfZivMFJGuD4VA0UFMxurEsi/4q8hH2GvPl3wed0x6eMubWGWHE745qnnEYCwFX+fpIFQuwoMxoawt+16tzwjEzA52XDT551hDNtqBYtyTn2D89ykEV9HzuAcRhRQcjKm+b+k+ifX5boa5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766399659; c=relaxed/simple;
	bh=DueunpP+LPzYpuMq5+8ZyXotVYWfMtuVEMFhlKWnYl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTZwbC4pgpnxeFP2+ftn5zahSPoNUeQOScNeJ8WkmRBQaEqtCRFdXjUe1eogaCw0hNv9mY8MI74Q2y5YOvF90cT4WvH2b4rCh1ue951QwrgonYqh4VZjDMZwrl1NZoFykjxwos5/jee4aMhZw07G8StydnF/p3TWl2VRVBTnC7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TqPv7ecc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FxtaQIaG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BM80Hbr3585754
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 10:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	upEeL4ZQ3ZDkVenwbkJ58Fhp97VcHoFeYpXcUTrSdys=; b=TqPv7eccvR/5OPG2
	pviQVvFH5/+rsxZJLseokIhnrNz/MUeYnMi76VG+1sQ/xX6TBPKZhCApb+UVeYMo
	umVUh/zj0MhC7HJ91pqSvIOyoUjlpO04ASpqvMMeKAHrIprxyyz+eWsdsQzuqU6h
	p5ue3jdN8F3MarfwwNNJ4Kh+C4L1kI5Ami0OzY7gKqXQarehGbLxVmF+wpwfHWWU
	aLz5JyQ/s92GySiBXCUilAIwcRjioXSnNuA7y1XmoTr84o5vRv7lxZRCd2lZM6d9
	diYPr5OxFhYvPMDLyODWvVAE0RZjO+CHro8u4Dcx/CAtD4kxZlJd0LbRXJ/z74mh
	42yYRA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b69ahjyxd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 10:34:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0bb1192cbso77167355ad.1
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 02:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766399656; x=1767004456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=upEeL4ZQ3ZDkVenwbkJ58Fhp97VcHoFeYpXcUTrSdys=;
        b=FxtaQIaGT4AwYh+jEnw7DNeXyEeGYGHYnb6Gt1PaIimri5oQLe3L0fUlEErg0xxwRI
         2l0cek4Y7kw0m8hU0XbQ+H6JxKy09zcWHcxcYEQTwsR76UG5s3ZrZ80JlY50SBUSe2nK
         W6msZdLfcBDf3N4lXcDeEgbem/CZOBYZsim9G7mnZXZr2SN3Ug16PTV5GCJPf81+2SCa
         rBSk/xejhOTrx13oa34x1hSVNZzVGDJOtsvc8IC2ftu/4xk4FOzv3hojXV3oen16ON3n
         EUZJPdQVBuVx7lCj/IRRTMZkxRvQN1YlVwhZqJyrhU39jJ4iWGbnQYiuSxeVVduBYh3W
         cbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766399656; x=1767004456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upEeL4ZQ3ZDkVenwbkJ58Fhp97VcHoFeYpXcUTrSdys=;
        b=IhOcvghC44K65JyCImu7UVqWGWUEsal9Q/bZC72LfILHdGgo7AnkYOMAmmyweE06cN
         IAh+oCt15Tbj8XsyH0BW+7k8MZEzwS62vkDCIKjWx6oMcp3ofAK4CXI8y7XY/6hfNORV
         xfKFjsqo9iJTw2AyPoCOYn4k5A2WkMdIWRUkxhv/VkLDrB8jpd80p1HzXD8oxWVl30/u
         FAgH+26uOmB9cInkprHKDKntaf7k0PGjd6y+o38Qb3ZI0RNxzBR+2YSgAUFYFIZgI0dJ
         99lKFUbpxMCtDvl7lJ3mWwNKDXKd5bOz0ipFMdetb/iwB8ZWn5cl45iLKEx69QOY41TU
         lVzg==
X-Forwarded-Encrypted: i=1; AJvYcCXYUFTAPtjwamf0OQl6tz9uqOS0zRM5DQN+fHC9Ag2QwU9UradRk/gmB8NdhvrfD345QMXE0mU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrEtUWcHuZWubvpT0wSROQiykIh5QVrc4jwBxjSBDa5VMs+V/H
	53w8qUJAlXUGg8RIJEb8HUQQzDN/LBzg/nghvC8tKP9o3k/AI5c2C33feo5gd5UeoxJ4nhOS5ky
	umGAcjxHIVnerG49QbpxuEQpN+WxAb7wabkaboiaQfjlTyxtjBEUaBj8d1Z8=
X-Gm-Gg: AY/fxX5Mqe9oHrnFG6Xtc89EgDXN/S1qC+hsrW1DcpabJQoEISeExscYC1dMM1es+mb
	Lyum0oB8iL745EafqkcZk5zUKmWk6oPAV4bKRXUs0Sa7Cg0eLkJU0nbidEgUB/f/9frI3zJdLkP
	EA/G/859tLkwUvN09L6oFFIZspkXrEqdVCjQwo/BXRn/r4pDVdMdarbyWeKGVh1JhskxEg44Tjn
	HJhm3qKuH7ax7ba7EZwbE7F8VyvwfUlt6gEFOXFNn5j3l2lIzBmNUUQVLAXrxbHv/q0Ol78Nj/S
	pYLpt8lTV74ZxWa/AO/yTaUvIwjLhvOeKu2y6ofO5pgBuaTcf6fcJ8VDl5BDplzVsSuQ1JGIKHa
	W+8cE6JDPPGU2Z/kHxhq6JbUnQy7Fk9oYLVnSR4t5oYn6
X-Received: by 2002:a17:902:f54f:b0:29d:584e:6349 with SMTP id d9443c01a7336-2a2f2231accmr113770875ad.13.1766399656532;
        Mon, 22 Dec 2025 02:34:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPXS5mUMbO5Xq6d0cLw60JERMVaiiop78hKINewCgC3Co+qqGwI3ZMrNDWQAXh3RXNXany5A==
X-Received: by 2002:a17:902:f54f:b0:29d:584e:6349 with SMTP id d9443c01a7336-2a2f2231accmr113770685ad.13.1766399656052;
        Mon, 22 Dec 2025 02:34:16 -0800 (PST)
Received: from [10.217.219.25] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c820b8sm92614475ad.23.2025.12.22.02.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 02:34:15 -0800 (PST)
Message-ID: <94b7e446-f96c-43dc-8e19-856c927a6cb4@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 16:04:10 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] bus: mhi: host: pci: Enable IP_SW1, IP_ETH0 and
 IP_ETH1 channels for QDU100
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Manivannan Sadhasivam <mani@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org
References: <20251209-vdev_next-20251208_eth_v6-v6-0-80898204f5d8@quicinc.com>
 <20251209-vdev_next-20251208_eth_v6-v6-2-80898204f5d8@quicinc.com>
 <20251210183946.3740a3b3@kernel.org>
Content-Language: en-US
From: vivek pernamitta <vivek.pernamitta@oss.qualcomm.com>
In-Reply-To: <20251210183946.3740a3b3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JuH8bc4C c=1 sm=1 tr=0 ts=69491ea9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=t_Bvvv5v3GB4GvIpbm0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: eAqrRaHSdckvid6_V_tJt-AV0lcC0Pji
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA5NSBTYWx0ZWRfX3nw1KpAESX7G
 l+t3XNzNrESPPDR3O1Usbtd+2oMznjueBNt9PPQvmtdcqHl7lqyUgzfX7vQ+9SYeSI4U9F+RQWH
 bKm0YCif03JF6vNBlJmZz67EtLwMB37cnBUsTEMJKjyxmrVJsbZ79yiBN4uH9xpJjVET+VYMi4V
 /3Y9oSxKVgqVKX3hVQ5EDBkyHi9lrzifP5QiBK6efOGnW/A6wYPFmw6yB5A9y5xtkJ04UWC8y3W
 C7if/EH3jFV4whpT9Cq2ctMr47LKCRrfFi2VaLbkgoxklb4jrZP64i+TAl1rp0++qWh0BPMQLB0
 YC/HjqN0HcH9Jsg8mOcx1R1GEXyZm4uzo7SZGIvkc8EAGsOgCGmDpCr32drxHHUObwTfwaUbrrV
 KspK/8cPHmebkRalYg61EYLVGfH9DIvMFD8WPP0RRJvhD/5QBHZLeT8OJF2K4fOWd/bC0EOQTgq
 Qn9DwlWI5yGKzY5RN7Q==
X-Proofpoint-GUID: eAqrRaHSdckvid6_V_tJt-AV0lcC0Pji
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512220095



On 12/10/2025 3:09 PM, Jakub Kicinski wrote:
> On Tue, 09 Dec 2025 16:55:39 +0530 Vivek Pernamitta wrote:
>> Enable IP_SW1, IP_ETH0 and IP_ETH1 channels for M-plane, NETCONF and
>> S-plane interface for QDU100.
>>
>> Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
>> ---
>>   drivers/bus/mhi/host/pci_generic.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
>> index e3bc737313a2f0658bc9b9c4f7d85258aec2474c..b64b155e4bd70326fed0aa86f32d8502da2f49d0 100644
>> --- a/drivers/bus/mhi/host/pci_generic.c
>> +++ b/drivers/bus/mhi/host/pci_generic.c
>> @@ -269,6 +269,13 @@ static const struct mhi_channel_config mhi_qcom_qdu100_channels[] = {
>>   	MHI_CHANNEL_CONFIG_DL(41, "MHI_PHC", 32, 4),
>>   	MHI_CHANNEL_CONFIG_UL(46, "IP_SW0", 256, 5),
>>   	MHI_CHANNEL_CONFIG_DL(47, "IP_SW0", 256, 5),
>> +	MHI_CHANNEL_CONFIG_UL(48, "IP_SW1", 256, 6),
>> +	MHI_CHANNEL_CONFIG_DL(49, "IP_SW1", 256, 6),
>> +	MHI_CHANNEL_CONFIG_UL(50, "IP_ETH0", 256, 7),
>> +	MHI_CHANNEL_CONFIG_DL(51, "IP_ETH0", 256, 7),
>> +	MHI_CHANNEL_CONFIG_UL(52, "IP_ETH1", 256, 8),
>> +	MHI_CHANNEL_CONFIG_DL(53, "IP_ETH1", 256, 8),
> 
> What is this CHANNEL_CONFIG thing and why is it part of the bus code
> and not driver code? Having to modify the bus for driver changes
> indicates the abstractions aren't used properly here..

MHI_CHANNEL_CONFIG defines channel attributes for the host controller to
set up channel rings. These entries are part of the MHI controller’s
configuration so that client drivers, such as the MHI network driver,
can attach to them. Each interface is mapped to an MHI channel (for
example, eth0 → IP_ETH0 channels 50/51), which is why this configuration
resides in the bus code.

-Vivek

