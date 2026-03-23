Return-Path: <netdev+bounces-270378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BruFerawGn6NQQAu9opvQ
	(envelope-from <netdev+bounces-270378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 07:17:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E70102ECF0A
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 07:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C04D6300A77D
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 06:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561DC2D2385;
	Mon, 23 Mar 2026 06:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CFpF05iT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YV3s9ZCl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E5E2C15BE
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 06:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774246295; cv=none; b=VAHTAbldghZQs8PSwZgPv55GGfkLwYA60NNPIOjxJnJUtUxQC19cx9tKEhKPtg7UDiMUsrofnMyVDQjMFNSsIgVv/L16/9Bke9Ig5voPbmpaFYgnAj5hy258bzOrnD2JsZMab4moV1NnDSmMQ6WmuS9OhfNZ4NOZbeP3nh92UQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774246295; c=relaxed/simple;
	bh=pjRgCznVlyp9cNp2lA4Kt/IJyC2fATKMnAaA25YLIpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwiQtElMbxjv8VUZ1esUkEGXwdmYmmv+ctc60lD92D1nyyZBxPUOfh5/xl+DEgR30W17sMbAaM/Ow3uf9MVKN8qvy97aU4YaK/upq8T6KUsSi6LR+HU5E2+lWMBbHf3vB14th2zDbvkXIDLM/aI+JCtYrHIg5Qpno662PDM8R0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CFpF05iT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YV3s9ZCl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N59so51916089
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 06:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AcjdfUkzYoRl0mzb7WG32C/ytt3hRVIB0eCN5m8GzrA=; b=CFpF05iTkHQ058Gq
	9mRDGHG9TCRMw1TkNE43oUFlchTyYiwd8jfUJ7NPURKDwRBmC8+srD367VaaAxe8
	tLb04+LOU+Tq4s58qq1dRn6aMzQ173ibQAWIMHKkHM/M9hyJhQT0O9sE4g/dzDcw
	klJJkaRYA4GEYKDiiU6YLXbNtp3YhnCy54T/IK9FNYEUy+g2VKwoq8pIKFQ0u6zB
	W5JxYNqPJFooIYvJvRXsY6PZDtqF8B9ncxcxqAj2/9ZJuIKPKm/yXFDl25iZuI4q
	k6aNudMROSNjFn6KiqwTbN09JPRu2As0wA+m4D0s1q8eW4s5RT3AYG6dapDF+tjH
	FcdJuw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1jng3yx5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 06:11:32 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35a032cdd78so2257443a91.1
        for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 23:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774246292; x=1774851092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcjdfUkzYoRl0mzb7WG32C/ytt3hRVIB0eCN5m8GzrA=;
        b=YV3s9ZClQmD35b2hGwKXH7uS50TNF5yVZe5RSrrWJOQAQIK52KLxbhcuGfdLDtvO4O
         002E3UhS0oZ4DQHCznY9rr7Tot87aV7jVVlnkFxOZJfwr/Ac6TepGgw3S1Em9qOHw5JA
         3tJ0QYI8ugQO/W7pFsWA1TYro9tFwEYKvLWom2Y/lJyCwXxG4ud3dtHIqrb8D6RV3Lgr
         7ui/wkucWxQASGsjnAwqsDIleEG+7ar6JETc8jY7HYzUMqFcw6ZcPqgk/qKHZn2lPq31
         DmDOZ0LgDLRsnx7IUNlwUMkl7T75eLPzC90+z5iQusE2eHM7ZKvduWGSuu6SzGtbhF1p
         O4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774246292; x=1774851092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AcjdfUkzYoRl0mzb7WG32C/ytt3hRVIB0eCN5m8GzrA=;
        b=CKOSCdti2Gn7Uh/sczJ+CZ4/Mm532sfrrwjDyytYzmla6BVesEB5V/2ZMrSMZ/GZr7
         XcVilvlV4EZd93CQdIoIFcDTrg0GDbfuTGaUTwRnXE9bxKrYtxKB6URqgn/duQVQOxbl
         Y/j7kZFiq8JVJUsi+sm942e+pkuAgYUIZKgg4pzSxfghROCecpGndrs5lSw1+3GH3v8u
         R3+onElAqfULJJCjTz/RG7/IY+ysQEKoNVrH0aTb8s7tFw4UMyY/YIbSKuJZsGcNy/o8
         h3cpUHRXbjINDw+uCpGf2Y+LMVpuB1X+es/uwg68QGVa1U8R1IU54gPrRX51LHkyLdWL
         5D1w==
X-Forwarded-Encrypted: i=1; AJvYcCXulaXuS7qW42MA5cdDM78dCtSdaLup/fff//tRdNDEr6LRTIuf0OMmdI8AOj/GjjiD9WFHKgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn+gX0GleHKCpIP2mrNc3aBEBRXUkBwewBKwZKzUtxgRVIYd8e
	zw9TKONILSCP6Vu/M1ndRZx2BYgtS5Oc9xCa5rQo2cxIB1zuPkte3N9LVLfCt9ks7uNnRi/njia
	cNbX947T/bE8JDhhAeHPqp/Ia5Qp4twkGteSJnCuqgmB8DYPttXqtdUulOCc=
X-Gm-Gg: ATEYQzySTY5YSFBFyk2w28EEk/4ZjyzYjTAO7bCNYq8AkEILmZQzy5G/DX1iCiQz75z
	I8V+yyHkIy1dlfgFPKeY3Jx/9ETK1JTktB0R+86RqZB4RxH9ADg0y1oDMMaUAMCwFEv+TfCATa7
	pPIRTCtboFLcama721byycJ69mdsQFjxH/JkWE+BKS8gpGICysjSaFX+WY0UQ/KrnknH1a3nVdi
	WIdZtkEGRq7jItfZre5JTyi/BsxQX1y+pVH+2tCxI3PLHDbfuHxasTP8QfyIu2GcFlsGqNHlOEW
	wZI3m/y7H+OeDBD3IbWTjVcH2NbqQw+6dgoqtGztHoEkN97alMtO+h0SY2UiWkvMbwFJs7A+5HS
	8vA4vbtSrnHJCAXflGN6s1X/5hqLUjAb6TOc8mUYYO/ax2M13tTllLRUtkw==
X-Received: by 2002:a17:90b:5624:b0:35b:a656:a60a with SMTP id 98e67ed59e1d1-35bd2bfdf43mr10025562a91.8.1774246291754;
        Sun, 22 Mar 2026 23:11:31 -0700 (PDT)
X-Received: by 2002:a17:90b:5624:b0:35b:a656:a60a with SMTP id 98e67ed59e1d1-35bd2bfdf43mr10025536a91.8.1774246291249;
        Sun, 22 Mar 2026 23:11:31 -0700 (PDT)
Received: from [10.217.219.205] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd264bb29sm3922465a91.2.2026.03.22.23.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 23:11:30 -0700 (PDT)
Message-ID: <872d3520-f749-4d4d-a8c3-25dba30e947c@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 11:41:26 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] net: mhi: Enable Ethernet interface support
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org
References: <20260212-eth_vdev_next-20260211-v8-0-0974b3a8d61b@qti.qualcomm.com>
 <20260212-eth_vdev_next-20260211-v8-1-0974b3a8d61b@qti.qualcomm.com>
 <myiqilk7t6yvqrjx5ew7srbtqh6xbk5jdd5pjqfeanwh3ymbdu@xy6lledx4hha>
Content-Language: en-US
From: vivek pernamitta <vivek.pernamitta@oss.qualcomm.com>
In-Reply-To: <myiqilk7t6yvqrjx5ew7srbtqh6xbk5jdd5pjqfeanwh3ymbdu@xy6lledx4hha>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: u_k9tr01-_m2Hu6kWWFC0233eS4svjxk
X-Authority-Analysis: v=2.4 cv=Q63fIo2a c=1 sm=1 tr=0 ts=69c0d994 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=E1vQDyoac-6XQvGmIAwA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: u_k9tr01-_m2Hu6kWWFC0233eS4svjxk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA0NSBTYWx0ZWRfX3mbU4UXLWYqe
 5VyPoF1Ynd3eyQJsBbeoQ1cGnvgcSNM+UpaWn1AZTVMZSd13fLbGN2QqfHSBQe/unqG359SQrRo
 mqMjGGnQiqhj/VAXT/BzJmMxIfdpR3i8gOZvGFT9MdhGZBOMekgQlclYJnNFN/feahg/afOrqrp
 w+tiHDHWhfsRrzw7AL3wMqERvBAL1RhNHcrfC2lgwoEPPJjkRLlsSVhe8kxGoqpvoOq14OIjNb/
 Ms9NELi6dsPp+5Ne/pioIr1bvKC94rBjGMdN1RQ05AusdpCpddYqe8GfsxAhReQNTemj4Gmyn8O
 a4rdZKzDPVM8qs3tm0yZa9kmnjAWqUVuEmYDAlPqkqRUfo8wjv9URsYwu8NTD0Hg0Wj+VivumWy
 xr/IxdSfGl+da6ft8rxVNwWFeaaQuYaa+9I1wMm4aRRh+5nHhiRgoYKq/EqvK6vOHZSBQazLPxI
 NzmvyCP9siiOEERfQZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230045
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270378-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vivek.pernamitta@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E70102ECF0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/6/2026 11:24 AM, Manivannan Sadhasivam wrote:
> On Thu, Feb 12, 2026 at 04:30:22PM +0530, Vivek Pernamitta wrote:
>> From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
>>
>> Add support to configure a new client as Ethernet type over MHI by
>> setting "mhi_device_info.ethernet_if = true". Create a new Ethernet
>> interface named eth%d. This complements existing NET driver support.
>>
>> Allocate MHI netdevs using NET_NAME_ENUM to reflect kernel-enumerated
>> naming. This updates the reported name_assign_type for MHI net
>> interfaces created by this driver, aligning naming semantics across
>> existing and new devices. No functional or interface naming changes
>> are introduced
>>
>> Introduce IP_SW1, ETH0, and ETH1 network interfaces required for
> 
> IP_SW1 is not related to this patch.
Will create an new patch for IP_SW1 alone in the same series.
> 
>> M-plane, NETCONF, and S-plane components.
>>
> 
> The main thing you want to describe in description is that IP_ETH channels are
> representing the Ethernet interface of the MHI device for which the driver is
> also creating the netdev interface so that the host can access the Ethernet
> interface of the device.
Will add this information in commit message.
> 
>> M-plane:
>> Implement DU M-Plane software for non-real-time O-RAN management
>> between O-DU and O-RU using NETCONF/YANG and O-RAN WG4 M-Plane YANG
>> models. Provide capability exchange, configuration management,
>> performance monitoring, and fault management per O-RAN.WG4.TS.MP.0-
>> R004-v18.00.
>>
>> NETCONF:
>> Use NETCONF protocol for configuration operations such as fetching,
>> modifying, and deleting network device configurations.
>>
>> S-plane:
>> Support frequency and time synchronization between O-DUs and O-RUs
>> using Synchronous Ethernet and IEEE 1588. Assume PTP transport over
>> L2 Ethernet (ITU-T G.8275.1) for full timing support; allow PTP over
>> UDP/IP (ITU-T G.8275.2) with reduced reliability. as per ORAN spec
>> O-RAN.WG4.CUS.0-R003-v12.00.
>>
>> Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
>> ---
>>   drivers/net/mhi_net.c | 67 ++++++++++++++++++++++++++++++++++++++++++---------
>>   1 file changed, 56 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
>> index ae169929a9d8e449b5a427993abf68e8d032fae2..aa65b267d5c06c76482eaede097c500edc1cdf7f 100644
>> --- a/drivers/net/mhi_net.c
>> +++ b/drivers/net/mhi_net.c
>> @@ -4,6 +4,7 @@
>>    * Copyright (C) 2020 Linaro Ltd <loic.poulain@linaro.org>
>>    */
>>   
>> +#include <linux/etherdevice.h>
>>   #include <linux/if_arp.h>
>>   #include <linux/mhi.h>
>>   #include <linux/mod_devicetable.h>
>> @@ -42,6 +43,7 @@ struct mhi_net_dev {
>>   
>>   struct mhi_device_info {
>>   	const char *netname;
>> +	bool ethernet_if;
>>   };
>>   
>>   static int mhi_ndo_open(struct net_device *ndev)
>> @@ -119,11 +121,29 @@ static void mhi_ndo_get_stats64(struct net_device *ndev,
>>   	} while (u64_stats_fetch_retry(&mhi_netdev->stats.tx_syncp, start));
>>   }
>>   
>> +static int mhi_mac_address(struct net_device *dev, void *p)
>> +{
>> +	if (dev->type == ARPHRD_ETHER)
>> +		return eth_mac_addr(dev, p);
>> +
>> +	return 0;
>> +}
>> +
>> +static int mhi_validate_address(struct net_device *dev)
>> +{
>> +	if (dev->type == ARPHRD_ETHER)
>> +		return eth_validate_addr(dev);
>> +
>> +	return 0;
>> +}
>> +
>>   static const struct net_device_ops mhi_netdev_ops = {
>>   	.ndo_open               = mhi_ndo_open,
>>   	.ndo_stop               = mhi_ndo_stop,
>>   	.ndo_start_xmit         = mhi_ndo_xmit,
>>   	.ndo_get_stats64	= mhi_ndo_get_stats64,
>> +	.ndo_set_mac_address    = mhi_mac_address,
>> +	.ndo_validate_addr      = mhi_validate_address,
>>   };
>>   
>>   static void mhi_net_setup(struct net_device *ndev)
>> @@ -140,6 +160,13 @@ static void mhi_net_setup(struct net_device *ndev)
>>   	ndev->tx_queue_len = 1000;
>>   }
>>   
>> +static void mhi_ethernet_setup(struct net_device *ndev)
>> +{
>> +	ndev->netdev_ops = &mhi_netdev_ops;
>> +	ether_setup(ndev);
>> +	ndev->max_mtu = ETH_MAX_MTU;
>> +}
>> +
>>   static struct sk_buff *mhi_net_skb_agg(struct mhi_net_dev *mhi_netdev,
>>   				       struct sk_buff *skb)
>>   {
>> @@ -209,16 +236,20 @@ static void mhi_net_dl_callback(struct mhi_device *mhi_dev,
>>   			mhi_netdev->skbagg_head = NULL;
>>   		}
>>   
>> -		switch (skb->data[0] & 0xf0) {
>> -		case 0x40:
>> -			skb->protocol = htons(ETH_P_IP);
>> -			break;
>> -		case 0x60:
>> -			skb->protocol = htons(ETH_P_IPV6);
>> -			break;
>> -		default:
>> -			skb->protocol = htons(ETH_P_MAP);
>> -			break;
>> +		if (!!mhi_netdev->ndev->header_ops) {
> 
> Why not just if (mhi_netdev->ndev->header_ops)?
sure , will make changes accordingly.

> 
> But you should really check ARPHRD_ETHER type here and below.
Sure, Will add an check for ARPHRD_ETHER type before assigning protocol.

> 
>> +			skb->protocol = eth_type_trans(skb, mhi_netdev->ndev);
>> +		} else {
>> +			switch (skb->data[0] & 0xf0) {
>> +			case 0x40:
>> +				skb->protocol = htons(ETH_P_IP);
>> +				break;
>> +			case 0x60:
>> +				skb->protocol = htons(ETH_P_IPV6);
>> +				break;
>> +			default:
>> +				skb->protocol = htons(ETH_P_MAP);
>> +				break;
>> +			}
>>   		}
>>   
>>   		u64_stats_update_begin(&mhi_netdev->stats.rx_syncp);
>> @@ -306,6 +337,9 @@ static int mhi_net_newlink(struct mhi_device *mhi_dev, struct net_device *ndev)
>>   	struct mhi_net_dev *mhi_netdev;
>>   	int err;
>>   
>> +	if (!!ndev->header_ops)
>> +		eth_hw_addr_random(ndev);
>> +
>>   	mhi_netdev = netdev_priv(ndev);
>>   
>>   	dev_set_drvdata(&mhi_dev->dev, mhi_netdev);
>> @@ -356,7 +390,8 @@ static int mhi_net_probe(struct mhi_device *mhi_dev,
>>   	int err;
>>   
>>   	ndev = alloc_netdev(sizeof(struct mhi_net_dev), info->netname,
>> -			    NET_NAME_PREDICTABLE, mhi_net_setup);
>> +			    NET_NAME_ENUM, info->ethernet_if ?
>> +			    mhi_ethernet_setup : mhi_net_setup);
>>   	if (!ndev)
>>   		return -ENOMEM;
>>   
>> @@ -380,10 +415,17 @@ static void mhi_net_remove(struct mhi_device *mhi_dev)
>>   
>>   static const struct mhi_device_info mhi_hwip0 = {
>>   	.netname = "mhi_hwip%d",
>> +	.ethernet_if = false,
> 
> Default state is false isn't it? No need to set it explicitly.\
> 
> - Mani
> 
ok, will make changes in next patchset.


