Return-Path: <netdev+bounces-305408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lq34BJPXTGrRqgEAu9opvQ
	(envelope-from <netdev+bounces-305408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 12:40:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C04471A825
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 12:40:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=proofpoint-05-2026 header.b=OWuHw8XM;
	dkim=pass header.d=ti.com header.s=selector1 header.b=qF1fAwd8;
	dmarc=pass (policy=quarantine) header.from=ti.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305408-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305408-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0757F3000FFF
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 10:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2255D3ED5C7;
	Tue,  7 Jul 2026 10:40:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C9F3E0C5C;
	Tue,  7 Jul 2026 10:40:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420817; cv=fail; b=lGjusYCANPCuJibV6lf3iYg5oNEfOsVhT3LMgQgnbYBHX8Psatp6Eo7OdLCb7Z3t4ZnLXuvk2JgSsKk9lDp5j1XBKN8LU4xRohWhSck4/Nvrm5aKJh5rVQmDR5kXCeSEvFldOi6pGb7Q9F2+SN57uPAv/9aGFjSNTy7ZzwCI4d4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420817; c=relaxed/simple;
	bh=I7TWUi6ubj7+4Jpxb7MI2RoXUQHSWDSDCFAK7oXuSQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JF2gBO2l3pZQ4ltW1j3GuRxsbVaGSFt1VXRrYddX+iazMQkbB2DjVUuIjVVUkNSOKi+vU4ltYY000o2sul+qX5axaCP1qNWBHgsbq4APh8W2iVRrQJ/RMkD1SPqrxCvwbAYnPeSFbB+ebEI1vaZnCb+oQ1m7O9mY/1IAOFXDSTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=OWuHw8XM; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qF1fAwd8; arc=fail smtp.client-ip=148.163.154.28
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6679VSE03251330;
	Tue, 7 Jul 2026 05:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=VF5lhMnmEW5pfY4WHRhlNgsV5jF7Hj378x+zB44Bo
	X4=; b=OWuHw8XMU665U8l9I0Iutuf3oKmyPinJKLXsCPRsxIQ8GzlkTM7F4YugF
	O+41Ahr9lLvb4MOftUATXGyEnFMNIDw8NY3nL9eyON/TqOhOpa4T9lI6UqNj+2cw
	LT91FE02pNTuH7/2CfuzYt8ndaL8UNZT+ExbLQNffxyLPx7vOxZpuI1qf4ZD+eBJ
	1sPjvlF2PIkb0ol/ge6rpsXToVDquFRwLRxXI21ht8e3+FZvLMrHFgTu533gkMqz
	SwPo8E7/76b+2kX1twJZJOQ7j7eXAG8UKIQcy/uy5HIuCWTczaGgwmCV81jx/w97
	4DmVKrE21hR3hfGVg4UQGFGyBl0Kg==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013028.outbound.protection.outlook.com [40.93.196.28])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f8xwagadm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 05:39:50 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SP/j1BQUFLzuBaH5CCsljBjbi5TBn1s/wHRbz3CH0jNzxIv31o2owz9cPuTMZSd7BneaNd2O8easJQcHFE4dB2bY73mxeMWgeP2ifzujZv/3s7DRw8Sihgcbo21E5GaFpWkKWV0AlmV9u0Hu03Z9B9BE3Ugk6XTAwGhAkREaBA+/DjDNQEhupnxTfoqIvYKTLAWZT8q/wT4F3GGyvm9yAdJzoonBsGh8Oi1FoWnFK0+ah8jbsyCXvjRU8u5GkCl2LF4e+Q2bojcNBUbAHzbwuDvAeiD6uH4Tbo1fynOzYCoFoR4B7Wu/p+iSuE4NQJJODzLY3ZjF0mCV3KyyP3/p7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VF5lhMnmEW5pfY4WHRhlNgsV5jF7Hj378x+zB44BoX4=;
 b=mLJ0LPbaF0fLSkDtMhtzqc3Wf7C+6Hbd9+hm1bOCVVb76FKy21tsLfuQ0nGHEH/n4wQlpSRC1f6cP4aYi7CgfR4mdu8ccsIqJnGW+yZ98hLAAL7t55vKPafvF4elepnKCZWU0f57SqQyD2LULBIOVgRioypYCh6Ob7lzNo0F/P0CXluo2TClVccFVsxsLhqt2hHa9CiDcEgl2CL8r5rvSibRFdYoGWBsB9dnEHxu2Y1w9/na2l/V8E8qwjnEORjj9KHY3vtbvuwtMk7bl7epWTLezQJVoza2D/qcbr1uhlfItT7PbTI9nXks/GW5euqT1WfoN1QXCYn6l8THWXSq3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VF5lhMnmEW5pfY4WHRhlNgsV5jF7Hj378x+zB44BoX4=;
 b=qF1fAwd8rt+YVtUvHTsA0hwAe2iln7SpvK9ZbITcNSsYb1SD6EhIChkj4POb49+e8nU75rROhbcpIusGjftM3wXBdnTwi9UP9da4o3Wh+/T770n4grAGGtifDAZJ6rE65WZxMFZZ0jo35CaWYrEMV8jt2oBmZOgVjGPtII7UpMw=
Received: from BN9PR03CA0917.namprd03.prod.outlook.com (2603:10b6:408:107::22)
 by DM3PPF0900B6F69.namprd10.prod.outlook.com (2603:10b6:f:fc00::c07) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 7 Jul
 2026 10:39:45 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:107:cafe::1d) by BN9PR03CA0917.outlook.office365.com
 (2603:10b6:408:107::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.12 via Frontend Transport; Tue, 7
 Jul 2026 10:39:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 10:39:45 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 05:39:44 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 05:39:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 7 Jul 2026 05:39:44 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 667Adepw023123;
	Tue, 7 Jul 2026 05:39:41 -0500
Message-ID: <5c9fc598-9449-49aa-aa4b-2afc247bc761@ti.com>
Date: Tue, 7 Jul 2026 16:09:40 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix link-local addresses being
 forwarded out of slave ports
To: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Simon Horman <horms@kernel.org>, "Meghana
 Malladi" <m-malladi@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20260701112535.4027920-1-danishanwar@ti.com>
 <71a1bacf-c54f-45b0-80df-7175261cf2ac@redhat.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <71a1bacf-c54f-45b0-80df-7175261cf2ac@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|DM3PPF0900B6F69:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e1b33c6-4361-4375-f62f-08dedc140f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|13003099007|3023799007|4143699003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0rGMmMlQbbn3d0sR1vHNWxEDD5hgADIMNY7dZhY3d1aLG6HikxARHQiNxxxmUQz6JmYvu1joeZTC1q19NpQZmd1Yd9fiQ7pdPy1yzze9MWGase3UYjdH1xNGn2SmiUvI4U6EE82dAO4nO6bKSzP6QI2UE7F9GOCnRZ6XFRcFFx2USjKLAuHUH1FK0b+OFtWfKydvbjpuaV46KSaj5FUf1bKqc5/mYYVE1CGrvqcZfp3pChPPMMzB48xom68OJpSDpFkveT0xyjw1bQpJo7fNx2P7h+3saiVHmLgt+iJ6dPHtJ4Dzdk7t+T5/rzD4vMC6kYk2Rqjtv6859ef49dUJTj4BYpMh5a35VJEndCZ3GO1/sOhQHTWihVxdZ4B6jQfgHZChZSr6MvB9SZPM4t3tr8VoYwAuvn7fPQVTeoDpU7LJRSylkDvKx9aW2VOdCY+QoTuqbdllH5HEn7tLHPlUtFKkbozhEvcuTTZ8IpZkoR6Y/kF2LI28zLqKI7DS8m6crd+hwcfNt9pysZyN0r6EFdnikhL8mZbTqTr2jmwim12F7sywvAfr7Ed2+NgfVSrDjTVXxmjvUYpMOlo7Wre1ZliYq4NsccugcUi9+ReVs2+ymzSB8pgrCdA15i36Tkysr+jwAiHAiat5Cx8R6bXJ4g==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(13003099007)(3023799007)(4143699003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	neBOV8RoQU860LIqrNGNrPFzmjvdq/AVqSk607Z+q0cqyzxi35X3qBIMbjKY/OXuzPCvwbprSWHw0lOKVmsWED5duRoVNscKSOJJslvSMYeH4n0hsjTrDJSxU8kbONizIU3V08AuPVf1anPcEYD9S3TPR43gscqd0ztuzI6xU0y68G8dLAnsVMftN+BOBioeO+StTJCBIPrkGFAuyOhcFL8OrU/bfpBrf5o3Km2S3Pj36f1VDeT1dNEnO0UuexEKrophMQNVXZfm3vB72o7euq2pc3LBtMmOVqFFvTPgYt5cWohFY1ae+Vvl+E/65qfNC6mMB7YyCv2KafzrM1BIgRB12oNiO6jcgdLWEsp90Dhuz04Pc+klY4FMSvZlcNiAOVGjD7KnL/jfSsgcu6DoiFi1jMbLF+htF8ruTFiESdmbM0PuuRlsLdPLTX3EQQy7
X-Exchange-RoutingPolicyChecked:
	ChTjSWduFwM/o738WtKKDaMe8DE1DIiVOY/70A14zUtIq4UBtbTGOczeFqMO6Lliqje7Qfr1T1vqH7r+bILH4Kkrb+yKCXMenyCw7fd2kQP0BW/SfPXa2I+EYtSIDWHaLk+SXb8Q5iWNB3MT7ACNSukUlzV4fvcvKhE2Ziw21DyoWnAb2vt5tH3b6bGjAAw0bMJs73WBIUkp+OoW0u/4qo7thD1wfhk3bPt5VQzJIMU8HcTi97Irdm/q+hphXwpK3HC9VuyH1cegCwzvs9fwN2qtdHoUnbyFxopJObmCaKFiubgO4V5gmmakk/yc90WvVfiIKbrtNwEvc7qqmsx1+w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 10:39:45.1275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1b33c6-4361-4375-f62f-08dedc140f9b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF0900B6F69
X-Proofpoint-GUID: RU_E2gOHqUFUVTAj7L30Rrbn7c1Bxkpx
X-Proofpoint-ORIG-GUID: RU_E2gOHqUFUVTAj7L30Rrbn7c1Bxkpx
X-Authority-Analysis: v=2.4 cv=FOwrAeos c=1 sm=1 tr=0 ts=6a4cd776 cx=c_pps
 a=J6o3koRVWeMoKD0aP1wsjw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=c92rfblmAAAA:8
 a=sozttTNsAAAA:8 a=QTcmSGy2JdPEEOMrIMsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEwMiBTYWx0ZWRfXyAJ1GtzUqMzn
 z4Bh37BFu2boBp29IB8L0j2wXMkojYSDmhi/1fRk8zzSl3v7/twx1ZW3qj9ICDZMRTjB9SIxgq8
 kj0PegHdsxrjCHi8ngNfUoN0cPHUcsY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEwMiBTYWx0ZWRfX1cLFzlSanyeF
 pJjIBJXLWWrK8pN2I2DH2weEjetAIBN9TSLeWT5cYzfEHBHdBR8Rr5Zr6WLX5XiNH96R6p30h3G
 cKnflCm/hDS7NEORsCJvablTOhlinM3Y6nVhJBWUD12AbuZuPCWacPlnkW0vZlqLb7sQ7Owl4X8
 JvgsyPAO3IkHyDvaQ2KaBHOWX6elVPanFyH51CENvtqZpVaxQ72eRZ1Sc7WM1OyVaaI6QZQKnxU
 SNOq62lEMzYYRw82l8YM3dF2EfjCpw8AKrKr8+AxUm4JL68n4/7bKbBEnkiqC4uzbmuzwAtr4Dl
 R6948YrnMxOJUBlP16km6lXJPX4QJShDkahcj87lnrPORMV5gQY9zYuKI1B5dK+mLiF3vt/cpsf
 CK8r5SFN0TAACS11zilNG3cuZ3rewNSPgyVl81yCpPhYKiLNtb1g8RvizMpe8mbDB0nKut7Lr3L
 V7CKE9E5p9fHaUtmZ9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070102
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=proofpoint-05-2026,ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305408-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:m-malladi@ti.com,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,ti.com:from_mime,ti.com:email,ti.com:mid,ti.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C04471A825

Hi Paolo,

On 07/07/26 4:00 pm, Paolo Abeni wrote:
> On 7/1/26 1:25 PM, MD Danish Anwar wrote:
>> Link-local multicast addresses (01:80:c2:00:00:0x) must only be
>> delivered to the host port (P0) and must not be forwarded out of
>> the physical slave ports. icssg_fdb_add_del() was programming these
>> addresses with P1/P2 membership bits set, causing the firmware to
>> forward them out of slave ports.
>>
>> Clear P1/P2 membership and set only P0 membership when
>> is_link_local_ether_addr() returns true.
>>
>> Fixes: 487f7323f39a ("net: ti: icssg-prueth: Add helper functions to configure FDB")
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  drivers/net/ethernet/ti/icssg/icssg_config.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
>> index 3f8237c17d099..04a81402e3f3c 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
>> @@ -732,6 +732,16 @@ int icssg_fdb_add_del(struct prueth_emac *emac, const unsigned char *addr,
>>  	u8 fid = vid;
>>  	int ret;
>>  
>> +	/* Link-local addresses (01:80:c2:00:00:0x) must only be delivered to
>> +	 * the host port (P0). Clear P1/P2 membership to prevent the firmware
>> +	 * from forwarding them out of the physical slave ports.
>> +	 */
>> +	if (is_link_local_ether_addr(addr)) {
>> +		fid_c2 |= ICSSG_FDB_ENTRY_P0_MEMBERSHIP;
>> +		fid_c2 &= ~(ICSSG_FDB_ENTRY_P1_MEMBERSHIP |
>> +			    ICSSG_FDB_ENTRY_P2_MEMBERSHIP);
>> +	}
> 
> Sashiko gemeni mentioned it could be safer to reject entirely wrong masks:
> 
> https://sashiko.dev/#/patchset/20260701112535.4027920-1-danishanwar%40ti.com
> 
> It's not clear to me if the mentioned bad scenario is actually possibly,
> please have a look.
> 

I had a look at the Sashiko comment. This seems to be a false positive
to me.

Link-local addresses (01:80:c2:00:00:0x) are IEEE 802.1D Table 7-10
reserved addresses that bridges MUST NOT forward. They are consumed
locally by STP, LACP, LLDP, PAE, etc.

No valid protocol or user configuration would add an MDB entry for these
addresses on a slave port — doing so is a misconfiguration regardless of
hardware.

The silent enforcement in icssg_fdb_add_del() ensures the hardware
always reflects the mandatory protocol behavior. Returning -EOPNOTSUPP
would only matter if there were a legitimate caller we needed to reject
— there isn't one.

I think silently adding host port to FDB membership for Link Local
addresses is OK. This Sashiko comment can be ignored.

-- 
Thanks and Regards,
Danish


