Return-Path: <netdev+bounces-245687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC489CD59B9
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 11:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76C103058A76
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 10:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D84E310629;
	Mon, 22 Dec 2025 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gzhKcOo6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Olzfmtf2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC819303A37
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766399499; cv=none; b=nkIuFkmDis3eW8Q9QqUHkI5tEZc1L86V4Wn6Zmi7qOg5NtTCykqrfW4N/BbYrkYmZnTyCnfW0E4EPSSYA2UGGLWj+cbK1C0r3pgjoqjo0Ek+3SbJ26hVTk4PByS7T8puDJ4GBsT9VK6iS1VibyAEPIajaa7Piq05lUxa0SLfXJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766399499; c=relaxed/simple;
	bh=XZz1xE+YE9rIrAv8TPfmjsTJZft86uRH+WeioLmBXPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hg0cAyv/MRxuftvbeyx4IDPpe5B1963rmA42IGK1MntGazjKs3U3YEBQpKY96WJBGBbxl0BwS43kg+rLFJcdaQMRglkNbyEn/ilXQEkPDU1lKc/QWxou2IBX12fLfUE3xpb8RhD+v8jR3fhtcYZy1wYfhYxXTak48IJttX04zC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gzhKcOo6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Olzfmtf2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BM81WiE3812452
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 10:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sd3ZsPbmm/TqCzyvuwxbyZGAw0bOEcr60FfnyA+uFck=; b=gzhKcOo6lqBBJNa3
	c3Kn6JGPrLuJ4l9ysd+FN10JKgh+8loTKnkeQiFD+rHdHMjGA6ISKqRevxuNMeHz
	IMKM8cO1nts5Y7VYIvlLhvgXKOLlGS0j6xM6Lj6zgJp9pCDmfKbSfLI4w86klXpy
	UcNl1/J60YdBRQlfqizypQN2sc55NdaZKmx9PfGV/z9hU2HcmI/YSm39ej6IKdIr
	mu+kD82d3FfbmWSm5vqpL3tK+Tr+aXeL7yU2UaZAsKJP9ZRiEr5QuAuLvamdUyMH
	StVRu713dKM+6ytUtYCDpU8dA6LjPH+Cu2g8+uMsP57P9niQ1hoWzC+PaPeCNuPS
	7lj/jg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mrtcpcj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 10:31:36 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c3501d784so4247548a91.1
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 02:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766399496; x=1767004296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sd3ZsPbmm/TqCzyvuwxbyZGAw0bOEcr60FfnyA+uFck=;
        b=Olzfmtf2RP+s3H/yxmUDixQCSKpJNG752UR5bSCUSGwnP1OYgiZcw8PlEHaFXHZK8E
         ZMqdiaHWvjbuFpotSP3CqVI3P06KxPGxVssCCccMOXmY4KsWcRuYAfdRVS9Cpy48Ljsh
         tNaap2kcKuS1PE2nqsBS+ONpiRe5+hYoGqmzOusZKmqGJ2d96qIF2xV7KEC6PD3clic7
         EhOPPFot6nBzSe+X4zfcRASsO2xqr48G0+nQUlXhFEMu6V/d3Kz5N0ifTl7Pasbx9l1z
         1rDzQ2fw0GN6LrOTJtb4PAOU6I3BakQm9ZeDgTOpzxl9F3lNsBHFAbQIYCCwTXEqoNKZ
         EWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766399496; x=1767004296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sd3ZsPbmm/TqCzyvuwxbyZGAw0bOEcr60FfnyA+uFck=;
        b=A0cFLNIjNBux4IikTKG4GpYtKzWoUIWceJ6qcwCofqrW8EbAQ3Zf2LhzMuYI6J8dqx
         uiIeE4WazdiacGeNHRKZRkTmqxhVD0eZ4POnxhyLC+NJHQO1EG9B0rFY+OeuJYIIjHCV
         HAQ9NViNqRc+FJ1bXJPHI0cGZQpdXAG45FJeYgMccd2G8HvsoODtovNK4rYI+AyTITCA
         f0RdBC7xP9CP3PCuTEnJMMOu1gfp0jpreD5lQ38FRJGyQdOSefPK3iiSQ4jLv1OlvsJ0
         4+/vbNXJIAK1lrXeJInlt5yHfNh9ixIlL2oExsvcet9vHiRm+B5K7YS0fGBX+/SeBWOX
         znbg==
X-Forwarded-Encrypted: i=1; AJvYcCX15jDV0sTEsAHLk7dSNX6JttixI90StpNgXRKnoYEQSEHHMxg+HxLg/cIcKWN0WUwjgh4LsMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkhGZOwgrGlKJZhOfI0nDrxKMjRwLK8iScl8iAEt/Gf0iSN6ON
	caja7WTXJuPTSJZyHTh1PaoIgJcEs5UxFUjoehhmcc03pSj3j95o5JRFgpxbZ1usrwSNHp31zmt
	eKx2SFIO7dXOAn8jRZYqMuDbc5ISPQjAmzCfx6HbRM/Dff/SXPctLlBF2Fpg=
X-Gm-Gg: AY/fxX760xsCV/RW5vO7aY7phwsx5xaxpEfIsK0I5er8zqMuhzNfW5rtArj1jSPrWfy
	pfsxfxCdaocWl0NSXsIxr27ifzTd2ZwpRDBotNkbglKIQRCvd+RoQzOz2VKT/wKCDUh0U65a5K1
	ikYvRYz+/6cZCa3qseOMjGEnQtlCrk9UXOJke8o/l7JDNBL2AxXnpNFuou1UdLfPQMQjPXX3eJt
	9nwn3UyyiI/DMsOrR5t2Z905/govS5NMzHFBbVImGEhm+gbkxMeHDTdgJUhMibSU6aoQwfeTnvc
	WDkSSm7b3G423Dxa0Nd2x6UXcQdJJuv7pxVbACSnLIe4gXGaf+087XMQk7H+RgrLAxbP2610obe
	sgDHv4Bb+b+GUdBPYFZTWrLEw6sevCf1/totKGwqNHWTS
X-Received: by 2002:a05:6a20:7285:b0:352:3695:fa64 with SMTP id adf61e73a8af0-376a94bf23emr10821134637.37.1766399496206;
        Mon, 22 Dec 2025 02:31:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuhGQa6gBuPSQ7RJMYPiXhgGuMHU1tafo5ELmcsVLK1rusMvXx55oS11VPo8V4uxFpTc3UrA==
X-Received: by 2002:a05:6a20:7285:b0:352:3695:fa64 with SMTP id adf61e73a8af0-376a94bf23emr10821111637.37.1766399495655;
        Mon, 22 Dec 2025 02:31:35 -0800 (PST)
Received: from [10.217.219.25] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7bc68ab5sm9256293a12.17.2025.12.22.02.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 02:31:35 -0800 (PST)
Message-ID: <54a25608-57d3-452c-a838-952d0935ef37@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 16:01:30 +0530
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
 <eaf79686-9fcb-4330-8017-83a4e4923985@oss.qualcomm.com>
 <a8e6a25a-24c6-4739-a9cc-0e0621f093ed@lunn.ch>
Content-Language: en-US
From: vivek pernamitta <vivek.pernamitta@oss.qualcomm.com>
In-Reply-To: <a8e6a25a-24c6-4739-a9cc-0e0621f093ed@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -IWlx8viSOasvDNbQP56pSJ6vN9PVIju
X-Proofpoint-GUID: -IWlx8viSOasvDNbQP56pSJ6vN9PVIju
X-Authority-Analysis: v=2.4 cv=CeEFJbrl c=1 sm=1 tr=0 ts=69491e08 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8 a=82xI_hd8Nmh2SGOlAZoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA5NSBTYWx0ZWRfX/+6+AyRYnNDS
 ZIAksV+rrTqfFZ2wsvB2KyJhagMafKiaEl9LClnetkDSvb/oqmGzYWcoO6wjO8mj4yJOiPDF6V3
 qZH0DyhorkG94Rtc/EtAGsGYQeeRylRMbYudUIMLUOE/p0KcZRqrRgAfcrpTQHaQ+cSyHsiDE0V
 tzkU/qlTZk5Vktlv6T30QjtWFzqzdytPYa05LGjkhG5D/tSD3c0fGVCjxg6nB4mKVb8gnRC9+/9
 fHLiIQQ8b6xOdhTJN3Tie5RW+5YhBpTr+SHxDDNeBl2foyPSfmF175IWANNGmtGM2El/DKxhZYX
 2+4cDwoppFH0mH2rluRFfgMaXZwKIhZVSRpDa6+XQqsNUl0Y32+KdKDzIs/W23aACriYgJZGeXK
 ZjTGRsaHGuDaDdMbNvIZBTR59bClhjZQSnvHAn0GnRyDtCQLT5jcSHe7l32ms7/JMW7CduSQPOp
 HWPV3aGMCRCkzAnB+IQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512220095



On 12/10/2025 10:20 PM, Andrew Lunn wrote:
> On Wed, Dec 10, 2025 at 10:46:11AM +0530, vivek pernamitta wrote:
>>
>> On 12/9/2025 7:06 PM, Andrew Lunn wrote:
>>
>>                  ndev = alloc_netdev(sizeof(struct mhi_net_dev), info->netname,
>>          -                           NET_NAME_PREDICTABLE, mhi_net_setup);
>>          +                           NET_NAME_PREDICTABLE, info->ethernet_if ?
>>          +                           mhi_ethernet_setup : mhi_net_setup);
>>
>>      Is the name predictable? I thought "eth%d" was considered
>>      NET_NAME_ENUM?
>>
>>      https://elixir.bootlin.com/linux/v6.18/source/net/ethernet/eth.c#L382
>>
>>              Andrew
>>
>> For Ethernet-type devices, the interface name will follow the standard
>> convention: eth%d,
>> For normal IP interfaces, the interface will be created as mhi_swip%d/
>> mhi_hwip%d.
>> The naming will depend on the details provided through struct mhi_device_info.
> 
> Take a look again at my question. Why is NET_NAME_PREDICTABLE correct?
> Justify it. Especially given what alloc_etherdev_mqs() does.
> 
> 	Andrew

You’re right—eth%d should use NET_NAME_ENUM. I’ll update the patch to 
use NET_NAME_ENUM for both Ethernet-type interfaces and for non-Ethernet 
(SW/HW IP) interfaces.
Thanks for the pointer.

Regards
Vivek



