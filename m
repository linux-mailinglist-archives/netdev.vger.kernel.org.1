Return-Path: <netdev+bounces-194832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF898ACCE51
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 22:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F95163B3B
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 20:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3B21F30C3;
	Tue,  3 Jun 2025 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KFBk0X6X"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C7217C224;
	Tue,  3 Jun 2025 20:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983214; cv=none; b=F881g/0Kc2pWdRxs0OzSVpzRdOSk4icG06uyYDfXUU+8xVTrfjpLVClA2TKr7NlJmm+g5douPxEilQGAX/Z8RGzQSFpK2Sib9nKs+lqCoB9kZWwIiggiETNvYAgkYwT6G52DOKmy4Q42qotmPUdNoHUUmtUWUTPDserTc1JjXmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983214; c=relaxed/simple;
	bh=59kjn+T/iQcq2WtpMy+enLaS4aE2tpQL8fp9wGq05To=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jCIkbAVGk5xRhQDlM5E2vX/yNH5I3dtxKBB1JkJahWSRgAQ0djcVqGHbHaY3q8mOkg1fB8yV5JhanahZpLy8zuQS1jlJgHdBxrUq2iLc7DTJ02FpSzNa+xnz9PsT8wQBObv/JE6P0aMY/fvOC1f85qWQ5sj5KzHTVIH93bwb5I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KFBk0X6X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553JkeUv032286;
	Tue, 3 Jun 2025 20:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jpyoMrO4J6DQiZ/1xEwHZm7LlDQyjZc8GnXpDrN8mfc=; b=KFBk0X6Xm+my0T5P
	+1Cbq8SbhTEOocgvDLxy7oyZtjTldN+EgRdpPCZmjHvebu778YbGs4YLHOSmOLMT
	JH2/8vMz/1SpTeSL2VdoVfoZ9U+V3fW089wlXgmOYkPlm2HWt+7KyjTpiQuF5XBL
	hRfsto1KaM9YoN8qe6fel9F6uHIFMwx7Cn0zifZnOaDzvMdzQ+zbZi3O1wUD3vJK
	WJt8/eGt9Qgs8W0NSlcuKmcx2trDcvyysi6e9d7gfqlatMUG+Lgkv4X8oVXx9Fzp
	dPa3aQ+HdYErrqKWw6DOT7CkrhlnMpAVpXD1Ad+t14OWuOkTghM5jSkxC1FbCNNY
	g7Ds4w==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471sfutmwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jun 2025 20:39:51 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 553Kdorb001777
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Jun 2025 20:39:50 GMT
Received: from [10.110.52.127] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Jun 2025
 13:39:49 -0700
Message-ID: <d696a426-40bb-4c1a-b42d-990fb690de5e@quicinc.com>
Date: Tue, 3 Jun 2025 13:39:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: phy: clear phydev->devlink when the link is
 deleted
To: Florian Fainelli <f.fainelli@gmail.com>, Wei Fang <wei.fang@nxp.com>,
        <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <xiaolei.wang@windriver.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <imx@lists.linux.dev>
References: <20250523083759.3741168-1-wei.fang@nxp.com>
 <8b947cec-f559-40b4-a0e0-7a506fd89341@gmail.com>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <8b947cec-f559-40b4-a0e0-7a506fd89341@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=CY8I5Krl c=1 sm=1 tr=0 ts=683f5d97 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=jZjJzmEmTJcjZ5Ws:21 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=8AirrxEcAAAA:8 a=Q-fNiiVtAAAA:8 a=oBgyJLT1gLfHoXy3vE4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: u1YVSUlZlxDwz-UxLmuQY1GiUL2HMaad
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDE4MCBTYWx0ZWRfX7YXCgV9ZhaXc
 vJ4uWAx71rBDom39tS8Uog3jxfMVthIYaXu2ndn7GprjimU4/GLlEAnoC36F9QqUc3V87eyrCT1
 xcdCGP+G0erJIvJekWFIOTCtfb5Fs13ZxARxmLPjYx5P+zXD5SwYvU9xuxU/D5k0IrT0i66yVb3
 w96x4L0Xot5h7i83IHqjO4rk+MzJ7dO4qaVkI4XPDvmez2rltNUhE8pi77lhB3oQHknfSE+oBCY
 q5wzUXJrU3zWgpQtCB2RKoDm7JFNG22E0MWURsKu6jL/mkpEvvKJFvy/Pwg27gvvYP4SvI8zqNs
 kyeFHXQSHLtoR2MuIYfUq3aPTrEoczM6GVBFWFwKnF1q5D1H/Nm9NKg0bZP9bVY0xePQgQol28C
 4ZqWmo4OAqyFiZeF5GiqzSSYOAhAgUpYW3Jogq3kzGKfC5Lm0SKUbkIU7yhneBOF2uZRtQ5b
X-Proofpoint-GUID: u1YVSUlZlxDwz-UxLmuQY1GiUL2HMaad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_03,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506030180



On 5/23/2025 8:19 AM, Florian Fainelli wrote:
> 
> 
> On 5/23/2025 1:37 AM, Wei Fang wrote:
>> There is a potential crash issue when disabling and re-enabling the
>> network port. When disabling the network port, phy_detach() calls
>> device_link_del() to remove the device link, but it does not clear
>> phydev->devlink, so phydev->devlink is not a NULL pointer. Then the
>> network port is re-enabled, but if phy_attach_direct() fails before
>> calling device_link_add(), the code jumps to the "error" label and
>> calls phy_detach(). Since phydev->devlink retains the old value from
>> the previous attach/detach cycle, device_link_del() uses the old value,
>> which accesses a NULL pointer and causes a crash. The simplified crash
>> log is as follows.
>>
>> [   24.702421] Call trace:
>> [   24.704856]  device_link_put_kref+0x20/0x120
>> [   24.709124]  device_link_del+0x30/0x48
>> [   24.712864]  phy_detach+0x24/0x168
>> [   24.716261]  phy_attach_direct+0x168/0x3a4
>> [   24.720352]  phylink_fwnode_phy_connect+0xc8/0x14c
>> [   24.725140]  phylink_of_phy_connect+0x1c/0x34
>>
>> Therefore, phydev->devlink needs to be cleared when the device link is
>> deleted.
>>
>> Fixes: bc66fa87d4fd ("net: phy: Add link between phy dev and mac dev")
>> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> 
@Wei 
What happens in case of shared mdio ? 

1. Device 23040000 has the mdio node of both the ethernet phy and device 23000000 references the phy-handle present in the Device 23040000
2. When rmmod of the driver happens 
3. the parent devlink is already deleted. 
4. This cause the child mdio to access an entry causing a corruption. 
5. Thought this fix would help but i see that its not helping the case. 

Wondering if this is a legacy issue with shared mdio framework. 


 43369.232799:   qcom-ethqos 23040000.ethernet eth1: stmmac_dvr_remove: removing driver
 43369.233782:   stmmac_pcs: Link Down
 43369.258337:   qcom-ethqos 23040000.ethernet eth1: FPE workqueue stop
 43369.258522:   br1: port 1(eth1) entered disabled state
 43369.758779:   qcom-ethqos 23040000.ethernet eth1: Timeout accessing MAC_VLAN_Tag_Filter
 43369.758789:   qcom-ethqos 23040000.ethernet eth1: failed to kill vid 0081/0
 43369.759270:   qcom-ethqos 23040000.ethernet eth1 (unregistering): left allmulticast mode
 43369.759275:   qcom-ethqos 23040000.ethernet eth1 (unregistering): left promiscuous mode
 43369.759301:   br1: port 1(eth1) entered disabled state
 43370.259618:   qcom-ethqos 23040000.ethernet eth1 (unregistering): Timeout accessing MAC_VLAN_Tag_Filter
 43370.309863:   qcom-ethqos 23000000.ethernet eth0: stmmac_dvr_remove: removing driver
 43370.310019:   list_del corruption, ffffff80c6ec9408->prev is LIST_POISON2 (dead000000000122)
 43370.310034:   ------------[ cut here ]------------
 43370.310035:   kernel BUG at lib/list_debug.c:59!
 43370.310119:   CPU: 4 PID: 3067767 Comm: rmmod Tainted: G        W  OE      6.6.65-rt47-debug #1
 43370.310122:   Hardware name: Qualcomm Technologies, Inc. SA8775P Ride (DT)
 43370.310165:   Call trace:
 43370.310166:    __list_del_entry_valid_or_report+0xa8/0xe0
 43370.310168:    __device_link_del+0x40/0xf0
 43370.310172:    device_link_put_kref+0xb4/0xc8
 43370.310174:    device_link_del+0x38/0x58
 43370.310176:    phy_detach+0x2c/0x170
 43370.310181:    phy_disconnect+0x4c/0x70
 43370.310184:    phylink_disconnect_phy+0x6c/0xc0 [phylink]
 43370.310194:    stmmac_release+0x60/0x358 [stmmac]
 43370.310210:    __dev_close_many+0xb4/0x160
 43370.310213:    dev_close_many+0xbc/0x1a0
 43370.310215:    unregister_netdevice_many_notify+0x178/0x870
 43370.310218:    unregister_netdevice_queue+0xf8/0x140
 43370.310221:    unregister_netdev+0x2c/0x48
 43370.310223:    stmmac_dvr_remove+0xd0/0x1b0 [stmmac]
 43370.310233:    devm_stmmac_pltfr_remove+0x2c/0x58 [stmmac_platform]


> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

