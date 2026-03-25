Return-Path: <netdev+bounces-271416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOUtBVyGw2lRrQQAu9opvQ
	(envelope-from <netdev+bounces-271416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:53:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5C5320548
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A872D300694D
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 06:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE57435C193;
	Wed, 25 Mar 2026 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QfrAd8Ls";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Oyp0gIA1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7572066DE
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 06:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774421592; cv=none; b=hIXNt3hMrthaZUKacIkLW+XtXnacEXBTonP5QIi/vesas0pH+zBm0ROyg3EkyAkpzReHVZRxqY+7nHcXZEn43CI29cjZNWhx+QEMp1J1F7zV1kuPPk/E4SvokqHLIsq6vIVsA0+LR9Kd5QbU3jEOGT8mYqF/CRqBIYal5MKZ5Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774421592; c=relaxed/simple;
	bh=8H+GdAKBFaCchsjv5ttuJOMI+f0XuIoJ1n1G5Tfk6vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qPOXiRhkwMVLTcYzTMB838LnIVV+C46ES7xkPlBCm5EDQQIDDHM5zwZ+upCFQxL9z0aGub6mdkTwHq4eAZSVeQDCo6Ou98AwWLSrOxMYEQAiyfhz+vuyue10KmANBYxFXMmnIHB3cW3JL1eBKvz4gg6/Uzuyk8N++kSMpyvlKbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QfrAd8Ls; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Oyp0gIA1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P4tMmH3110462
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 06:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UI7m2+0UYHSeLOdZmZkD5IzpLl2JDpfBb2Td0CnCpfk=; b=QfrAd8Ls5ooL30O9
	SS2DrmlSMnutr4g8mjVXa1K377COiWNwGWgGa3JMkDXiZ0kigwZcw7mRnCNJUXmO
	i/mVpb+KAj7w8AOapWh/3BSxEvw32FCSUrO3VkqWi76TbkZdGxTVVD7/mzOZdbp0
	342DEVghTgL+8Sq7QFf5mIQA9Cb5HrpwIn/cXf2eRCQMlgeyMicjOjGMPvrFg3DW
	Fg44UWCfjMi1tq8BYhtr5/s0RUqw/iI5suuYblji4C8jkIsDLThuXBGFCSXepuxm
	G6EIy+sb5+JgTs7E7hHuZdm16sJrzzTdT+hpAJzjYNCRD/L+xeHdyZcAA1y9Ljn3
	c+jQuQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3vhvu4s4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 06:53:10 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c741f038f7cso3829142a12.2
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 23:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774421590; x=1775026390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UI7m2+0UYHSeLOdZmZkD5IzpLl2JDpfBb2Td0CnCpfk=;
        b=Oyp0gIA1sCAWNt7KDHhRoidFPwYRcT8FiabMTcjnFk/ZZfs4RcLvxa5yRm1k0wwUfo
         AigJ4dUigzQCTjT9QtGEwSw0e7UMTqS9gWSlvQsrqiSBawzfFjqtIvUokexRWcwx+Hmb
         91ejbp/Ye+RyMEgX/3FaAzQwbj9QI80c9gSVCKvGworU5QOtd8uANZefMc3bbEz3Rs5f
         SQwIfxWndeqjyd4Ean1jh0NiV0ENAeXvdCD10CQgASN9UaXjQ0j2DRuIMfjhs+nSCfsg
         PBSDGX2limNt+tF89jnO8MHrlWNAZtan9E5TpyV9+dpe+r7KSopLRIAilzXKBeiPVpSS
         vaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774421590; x=1775026390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UI7m2+0UYHSeLOdZmZkD5IzpLl2JDpfBb2Td0CnCpfk=;
        b=RmZberwSf6hEVPOgVmooa0J52EXtYYZ+FE2D8mcRlG8GKbufaiB6bfQkfDF01OS8ZL
         SYxjWy1boyCB/3nK8a7DHi8/R/LqURFrs4j44gxK26pxb6WosAUgdEmTDnRUyS4tYOz7
         r1CRiHuSnNKks7GSlwAZm5QoPXJP6MI7rdHfZJyyNQTlq+alNO9/iqO1CLAAHo0EpNv/
         5A6HYBLDvTTJRz3iL4OERC09IxCAAD6YEhgtaA3PYukDQtwnz2zarfl+geUmvN5H6Pyh
         XZuN4YlTiL061eaPYhS/SndGoD6kmClEtg/pn59x62pI17Q4Wj7JzUGQ/+qoxsXQ7lWV
         f7lA==
X-Forwarded-Encrypted: i=1; AJvYcCWssoZvY5HuJlW3lz3QQG+BofgHW630R/EHLtZgT7UPRWB5R09W/4vH9IMelpXpIYvc7+jgGeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYm4SqP8xo2WL2ea9Wi9sDMzR3SQdBsb7WIrdp0svdgiOwKafw
	+ythnm23sHoXaMSdGzBPNOXMxmJ6RikUknyK753foAMEWCfmN4ag5qxPTFqwsyWj6nCFDu5ciMX
	HDyqYr6MPqesLvDmptisPHN5iRcAe5tS0UeMulxUo2gi50o7dcTG06t15vqo=
X-Gm-Gg: ATEYQzxqY7tfym6VgcPS6rl+0IiM45Yg3CIfqwiqpJy2IT8j3/Qre1Qo5oRcWEL+Q3/
	vIorrKv/JgnVraV9UgYrcOV4Xzgr6t5JtfXEPil4Ilz50hOnPoiXKeqNkIWktqzrzVUpPxkNMA8
	5DVTW1KH17eWfwnt1OLm9WmjIq3X5XGOnHwfFD9wzHIBX3GnUCx53iGDQhAz2OVdpw4kARsHXAZ
	ukkwDngDgzsNqZsmPkwO7GWW2iujO84GB6yAQAtnDMUTZKogI2JpejK8+LXu6CxuNn/SZgLErlQ
	DHdUbRySRbGniAUlXOpivYmRS1slZe6MlYd2W8nO2P7uJ5f/McQRhFApQPyNrF6/C0f/uhmQY0I
	C4oOd2mF/esxWvhZ7EH8Ap1W2SXlTyK2diljUlQq9gCdMuTtAWM8O8xzO
X-Received: by 2002:a05:6a00:3d4b:b0:81f:394a:4897 with SMTP id d2e1a72fcca58-82c6e0d4280mr2597261b3a.44.1774421589776;
        Tue, 24 Mar 2026 23:53:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d4b:b0:81f:394a:4897 with SMTP id d2e1a72fcca58-82c6e0d4280mr2597246b3a.44.1774421589280;
        Tue, 24 Mar 2026 23:53:09 -0700 (PDT)
Received: from [10.218.37.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c66487634sm3576109b3a.29.2026.03.24.23.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 23:53:08 -0700 (PDT)
Message-ID: <1bc9ab9f-e59d-4dad-aa0d-c4d6fefc957d@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 12:23:04 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/2] net: mhi: Enable Ethernet interface support
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260324-vdev_eth_next-20260323-v9-0-da6e4e486437@oss.qualcomm.com>
 <20260324-vdev_eth_next-20260323-v9-1-da6e4e486437@oss.qualcomm.com>
 <CAFEp6-0zgCwJb8yOZD6hM2KDApoisMYMmw57xJ0uwSvtEHxU1w@mail.gmail.com>
Content-Language: en-US
From: vivek pernamitta <vivek.pernamitta@oss.qualcomm.com>
In-Reply-To: <CAFEp6-0zgCwJb8yOZD6hM2KDApoisMYMmw57xJ0uwSvtEHxU1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA0NyBTYWx0ZWRfXxpZcdRRxS1yM
 +0b/1RGQhSLmoZ5RWb/uGnudc2OVML4eL6kGxJsoN7nYVs441FmtHX+UHJDTwuc/CFFCshk5EDB
 7DbbC8XCa6flBmwMp0i5lp/BfUIeiqXQ3Bpg6pAhJ0S4ZobHRuglV9uL4JelO6ClMu+iyhEJNgI
 iWBjjgY8BJymzEb2WLTyn28bTCyyOduHZ1THyw1VJT3lkpE3GregCPnJAJs3URRCkoV3dNOMqKv
 xVj0vcG1vcj6angnZmtCX0WkvhUqQbPUCp5k/aYHnwVHTALdHdSdPVeJRzDq8VJwdc38ji4CClh
 sMh4onjSMy52QjhJgzW0r1U2bRuN+vU8Rmj24uA79XH3QpDpln3dUlxInwNgOWUc3yB0PVAjd/q
 QpM/8PUdYaYNU/SO4Of7fcMmNvXDoWIulQbMEF7DL6Un4XjBGLB1pExak2t5XcPByFnt/GSGnjp
 aRJaejlYmIw5se85X3Q==
X-Authority-Analysis: v=2.4 cv=P5M3RyAu c=1 sm=1 tr=0 ts=69c38656 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=UIrkJHBKaNELrq0Sgc0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ifmMjDokycqDSQuS4MaQaM7sG2A9XGSM
X-Proofpoint-GUID: ifmMjDokycqDSQuS4MaQaM7sG2A9XGSM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250047
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,linaro.org:email,qualcomm.com:dkim,qualcomm.com:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271416-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vivek.pernamitta@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6B5C5320548
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/24/2026 3:35 PM, Loic Poulain wrote:
> Hi Vivek,
> 
> On Tue, Mar 24, 2026 at 10:02 AM Vivek Pernamitta
> <vivek.pernamitta@oss.qualcomm.com> wrote:
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
>> Introduce ETH0 and ETH1 network interfaces required for NETCONF
>> and S-plane components.
>>
>> IP_ETH channels represent the Ethernet interface exposed by the
>> MHI device. The driver creates a corresponding netdev instance,
>> allowing the host to access and operate the device’s Ethernet
>> interface.
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
>>   drivers/net/mhi_net.c | 65 +++++++++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 53 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
>> index ae169929a9d8e449b5a427993abf68e8d032fae2..87d8c61fab983005eaea99603d74a557d1483b6e 100644
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
>>          const char *netname;
>> +       bool ethernet_if;
>>   };
>>
>>   static int mhi_ndo_open(struct net_device *ndev)
>> @@ -119,11 +121,29 @@ static void mhi_ndo_get_stats64(struct net_device *ndev,
>>          } while (u64_stats_fetch_retry(&mhi_netdev->stats.tx_syncp, start));
>>   }
>>
>> +static int mhi_mac_address(struct net_device *dev, void *p)
>> +{
>> +       if (dev->type == ARPHRD_ETHER)
>> +               return eth_mac_addr(dev, p);
>> +
>> +       return 0;
> 
> return -EOPNOTSUPP ?

Sure , will make changes
> 
>> +}
>> +
>> +static int mhi_validate_address(struct net_device *dev)
>> +{
>> +       if (dev->type == ARPHRD_ETHER)
>> +               return eth_validate_addr(dev);
>> +
>> +       return 0;
>> +}
>> +
>>   static const struct net_device_ops mhi_netdev_ops = {
>>          .ndo_open               = mhi_ndo_open,
>>          .ndo_stop               = mhi_ndo_stop,
>>          .ndo_start_xmit         = mhi_ndo_xmit,
>>          .ndo_get_stats64        = mhi_ndo_get_stats64,
>> +       .ndo_set_mac_address    = mhi_mac_address,
>> +       .ndo_validate_addr      = mhi_validate_address,
>>   };
>>
>>   static void mhi_net_setup(struct net_device *ndev)
>> @@ -140,6 +160,13 @@ static void mhi_net_setup(struct net_device *ndev)
>>          ndev->tx_queue_len = 1000;
>>   }
>>
>> +static void mhi_ethernet_setup(struct net_device *ndev)
>> +{
>> +       ndev->netdev_ops = &mhi_netdev_ops;
>> +       ether_setup(ndev);
>> +       ndev->max_mtu = ETH_MAX_MTU;
>> +}
>> +
>>   static struct sk_buff *mhi_net_skb_agg(struct mhi_net_dev *mhi_netdev,
>>                                         struct sk_buff *skb)
>>   {
>> @@ -208,17 +235,20 @@ static void mhi_net_dl_callback(struct mhi_device *mhi_dev,
>>                          skb = mhi_net_skb_agg(mhi_netdev, skb);
>>                          mhi_netdev->skbagg_head = NULL;
>>                  }
>> -
>> -               switch (skb->data[0] & 0xf0) {
>> -               case 0x40:
>> -                       skb->protocol = htons(ETH_P_IP);
>> -                       break;
>> -               case 0x60:
>> -                       skb->protocol = htons(ETH_P_IPV6);
>> -                       break;
>> -               default:
>> -                       skb->protocol = htons(ETH_P_MAP);
>> -                       break;
>> +               if (mhi_netdev->ndev->type == ARPHRD_ETHER) {
>> +                       skb->protocol = eth_type_trans(skb, mhi_netdev->ndev);
>> +               } else {
>> +                       switch (skb->data[0] & 0xf0) {
>> +                       case 0x40:
>> +                               skb->protocol = htons(ETH_P_IP);
>> +                               break;
>> +                       case 0x60:
>> +                               skb->protocol = htons(ETH_P_IPV6);
>> +                               break;
>> +                       default:
>> +                               skb->protocol = htons(ETH_P_MAP);
>> +                               break;
>> +                       }
>>                  }
>>
>>                  u64_stats_update_begin(&mhi_netdev->stats.rx_syncp);
>> @@ -306,6 +336,9 @@ static int mhi_net_newlink(struct mhi_device *mhi_dev, struct net_device *ndev)
>>          struct mhi_net_dev *mhi_netdev;
>>          int err;
>>
>> +       if (!!ndev->header_ops)
> 
> The double negation does nothing useful here, you don't need it.

OK sure , will correct it

>> +               eth_hw_addr_random(ndev);
>> +
>>          mhi_netdev = netdev_priv(ndev);
>>
>>          dev_set_drvdata(&mhi_dev->dev, mhi_netdev);
>> @@ -356,7 +389,8 @@ static int mhi_net_probe(struct mhi_device *mhi_dev,
>>          int err;
>>
>>          ndev = alloc_netdev(sizeof(struct mhi_net_dev), info->netname,
>> -                           NET_NAME_PREDICTABLE, mhi_net_setup);
>> +                           NET_NAME_ENUM, info->ethernet_if ?
>> +                           mhi_ethernet_setup : mhi_net_setup);
>>          if (!ndev)
>>                  return -ENOMEM;
>>
>> @@ -386,11 +420,18 @@ static const struct mhi_device_info mhi_swip0 = {
>>          .netname = "mhi_swip%d",
>>   };
>>
>> +static const struct mhi_device_info mhi_eth0 = {
>> +       .netname = "eth%d",
> 
> We named other interfaces `mhi_hwipX/mhi_swipX`, would it make sense
> to have similar naming here as well?
> 
Thanks for suggestion.
Incorporated the recommendation to use eth%d for Ethernet interface naming.
https://lore.kernel.org/all/20250725171053.03c0c44d@kernel.org/

>> +       .ethernet_if = true,
>> +};
>> +
>>   static const struct mhi_device_id mhi_net_id_table[] = {
>>          /* Hardware accelerated data PATH (to modem IPA), protocol agnostic */
>>          { .chan = "IP_HW0", .driver_data = (kernel_ulong_t)&mhi_hwip0 },
>>          /* Software data PATH (to modem CPU) */
>>          { .chan = "IP_SW0", .driver_data = (kernel_ulong_t)&mhi_swip0 },
>> +       { .chan = "IP_ETH0", .driver_data = (kernel_ulong_t)&mhi_eth0 },
>> +       { .chan = "IP_ETH1", .driver_data = (kernel_ulong_t)&mhi_eth0 },
>>          {}
>>   };
>>   MODULE_DEVICE_TABLE(mhi, mhi_net_id_table);
>>
>> --
>> 2.34.1
>>
>>


