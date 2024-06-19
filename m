Return-Path: <netdev+bounces-104814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3E990E7DA
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14A91C21738
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 10:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3D582494;
	Wed, 19 Jun 2024 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="COdK+w5q"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2180.outbound.protection.outlook.com [40.92.62.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FF38120D;
	Wed, 19 Jun 2024 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718791760; cv=fail; b=p7LLUGqTW+R8jGpKiW8P22yS3uXfYG6VbbZi26Xb9tGPEoihWwTyPAzxtFQCAi/Asz5KiJTNrrjf7sX1LZnMeukJHS5nIDj/VtsxtvjB8NooxgJCqQeX0YOmB54UDuW0eCFXuJnmHD7cLljsJRmf5dSfeqO/gTpvhvL9GtjZipA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718791760; c=relaxed/simple;
	bh=kk92+fFmvqmtk9Xcsg/QLUvgefVvsJgV7XPpu2zvJhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BHudRg+LHaYHCJzff8lIhhyMnLU4wFkHK/c/N/vsBpeaQNQBvTQFQgQ3UZcWa/wPSbkYn3yqvAtUjTBKpozbVKPm7k6l/awSGr0i+vdlZXZqHmAfyP6KCkCFWvH7lFkoPYL2KQAnJWBVGSIt3ssqDHl9eDgIt30wDvrEnUpmvuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=COdK+w5q; arc=fail smtp.client-ip=40.92.62.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksxv2nkFrN+ez2LFvof955ns+CANfUNHSOxKg+u1aUAx4Er0rx3V45G1s7JMz+4nWLy5dK5WmTNLIx7I3QVPt8nIwHyNHV/KxAiLmjIl6BiEtNWmabrkAIOAgJqpHy+21QVZRRomx9PYtxBIkv54KXFxMFcnVZoLbe8Fqecw8dEuymE1Nofh55TBzKwc735ijK5cMp79qC9Sznfuk04Od1ExpVdTjYZ0qNX+ZlxvSjl8vlWa3UzQN1AIBkyMj0lG4mzf+Zq623KpgnP535p+MO6V06LfR5taPrkistUS0IL/3zhX5gXpPPM7AWX95JKF+/T1c+p38Jp4je7Fgt4R2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ux1+bRl70pr3534GMjaOb7S7Rrn0Tu+/V1jx5cn3Rc=;
 b=HuJzR7sOHBqL769yBLVysPSoC+ixQrBiLn0EngzGB1YcY9piys6wBiZ6okRoksVUEuBBNAqdjkVobiNhh2+OODFBbQZC1h7JPnFiEUN8cZTEic/cfcx358O811zRRZJQ2njiiPqFclCeFUK049j+LuUyHwIK4dNqthW/Wq/ngLrzOSMaQ39CtxTH0DW9cs2M1YiRghXLCx+lG+YSIX2RnvO2gMZQe12K0irdzhrbvdcr60S7EocKCkr9tEclDwrDNYhkWeHmlY1NmfRaJrDJt4Dx/8k/3oL+wJkBBAsrd7AHESa40qcg0fHJ5sBtGZIg0MdDdAVTfhLEh9Jn/EKJMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ux1+bRl70pr3534GMjaOb7S7Rrn0Tu+/V1jx5cn3Rc=;
 b=COdK+w5qVpuyQhxWlwh+rhjP31T3WJBB12BgLvoYo/RF/0wbwr8E/+lhJoQrh0yQQEZV4DAErg8WRNf7HFczZkT3sUHZPAi8F/G1q8IgIkJ5ajZhZBP7bdCmSCoH7sxSPihH1Pz3pYUvAZHcGVsj8lTXP9R3glfN5anwJzaIkmDrk4+VSHa56Iwj4oRLxKQielfGa/BfpFN2Aaj33V9pIwQjTRfwQWVnvRNn25OJcF42vkcqK8nvSKWPcTkJgbHvihg702SxShjeeZySitvOfuEuJgBD3ZMOU5xHJxSIeh5vgcdXLcxJwUkqsYkn6J7wXckdB/8i7lcK0vg27zB0Pg==
Received: from SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b3::6) by
 ME3P282MB1954.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:b1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.19; Wed, 19 Jun 2024 10:09:12 +0000
Received: from SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 ([fe80::a8e8:3859:c279:c289]) by SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 ([fe80::a8e8:3859:c279:c289%5]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 10:09:12 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: kuba@kernel.org,
	Vanillan Wang <songjinjian@hotmail.com>
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	haijun.liu@mediatek.com,
	jinjian.song@fibocom.com,
	johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com
Subject: Re: [net-next v1] net: wwan: t7xx: Add debug port
Date: Wed, 19 Jun 2024 18:08:38 +0800
Message-ID:
 <SYBP282MB3528ACDD0F9077C35ADE236BBBCF2@SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614081136.17dd3d1f@kernel.org>
References: <20240614081136.17dd3d1f@kernel.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TMN: [zbEZ06kR55lNr3t9ZQKVtT4X7tA3CSmZ]
X-ClientProxiedBy: SG2PR02CA0126.apcprd02.prod.outlook.com
 (2603:1096:4:188::11) To SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:1b3::6)
X-Microsoft-Original-Message-ID:
 <20240619100838.5186-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB3528:EE_|ME3P282MB1954:EE_
X-MS-Office365-Filtering-Correlation-Id: 79367eb8-4c15-4b08-8560-08dc9047ddab
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|440099025|3412199022|1710799023;
X-Microsoft-Antispam-Message-Info:
	t06vlSfH+0elnWxdCCMhwRq7hezUN8+lkUxOkrBJOYgXpyS+XI3eE8rUZboRA35xAWtzO87rJCAI3Rm0eTTf9HVs8QoW55/ZGmVh3MFvYTWIv9DMKj5Gc+KPHsCRvraeyJaiPRuEZ21hF2YDuPTumNrHJMEnosamCRqIMbSpvTvw7n7BWld9O5+3lCfN73PXxiHu0Tq34Y6Dhm3C67fdpX8WUKZg+/yccUwFn8wh+4E+SDzMeZaFWtUdeXB2Kks+QDb/Lp5wYp5s6hdwF5jsR0FtjtO7OinnSzeFpjLtDEEsvodY/mxRuDH7TnCDzt8jakPgA5GNWCR1zVHZRYXh5UfaP0DEotG9LiqlM7f8TC0I4q658yr7u6iAQaZtgtzJ+AmdKtEs+GIGdgsvRwqq8i1H1ZnafUgX1/2kbwur3WtfcBj7EGk61L/3zGQvJQOObuJhqgWiFBFN0QnD7PblxATcarhChxEj5CEi0hB9blCLb/WEzMUDP5UCCOCffyY2gqoztw1pIkiwD77oOfWnCwx1nv6o+gLM6ub2zSoicYHykiZt4j8ROqFiY3r/CtAyLq4AZoODeeAYkRcObalUv3E02nLvOV/RZC4NgWCbqUNHAfB0BtlinHnEd5uClVRg
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JMRRqcS8sZQWPWMb3AwedrA1tbtubBSLG8cVrIVwEVDQcA4erQY27iF0zfHn?=
 =?us-ascii?Q?3Py5R1WhrFoxDuksscX8cs9q1hNK6PsVxfh3egtubqj2WaTm+ENDP6pzK/Xz?=
 =?us-ascii?Q?DIhDbjUr22+VchnQroxIM5xWEUP3O8TTj6onNT5twvQ1ZjHeii6+oG65z9cd?=
 =?us-ascii?Q?9WPC77f5/xXZTPYV3pc7yT2vaA/Rd7pLRTaAiT3gcEETb3AKF2NRH9WLbh2T?=
 =?us-ascii?Q?LTRXbCt2Kh1llVDSYxpiHmcjJNW/ssvvajArg1QoduWCj1DYVwU9+ROrSjth?=
 =?us-ascii?Q?uH9SDChGLm9iRQd2F7kP25bX9QepLyJ8lZMKlwdcTqaxVkPDkJbZoOSE3TNO?=
 =?us-ascii?Q?Uq9eGB7PIKKTC1/SrLhM45xxIq3Ea1XaZOY3CxGHGO4quc3leX81XKRzQSKk?=
 =?us-ascii?Q?tkj9Vn1bMMKue4EgRQFyT8w6w+lprXIOdUAmvsMPEKlM9vusZlb5bx3SDw2t?=
 =?us-ascii?Q?GKAK02wdjQHo7D5y3sKZAytPhVXK2ojPVegQq3/dsU49HolAMvrxYFSbw9VH?=
 =?us-ascii?Q?eMDAVN/OT/QUNeanykgIt0/IqAd9vyD8wMCyFQcGjD7EY1clr/DrOlhl8zil?=
 =?us-ascii?Q?shFyTUVmQtuAj1qKhsRIDegV48nEufiJUp6Ezn3NhOHuWkbfz3n0YuPmpxDQ?=
 =?us-ascii?Q?cK1pJI6SGoX4sMGcsTgtjR2sjBVx9hqiOyX18eR7+x0l2DffrUu8ZNDbuHV7?=
 =?us-ascii?Q?yK4KFRC3dIpd84yRjBiuKuJvggU74Y216xMBFY6278nUG0PTZOufvjg+5hUv?=
 =?us-ascii?Q?6yOG9ZerN6Zitq2q813V8y/Am6fUZ4MwJQizeoY8N06NODHX6VKH6l03GfAY?=
 =?us-ascii?Q?gLS/w2W0ciKSbmbj1oaOpgGKIZh0BLNmPUMuLm0tW3f76DSq2R+5QHLvhY4h?=
 =?us-ascii?Q?I9J1R0bFnbwHLpjGBcVguhQ5UsYbkfsZP/aZK5aj9MQVE5jfhny9ntqEhwRu?=
 =?us-ascii?Q?wsb4qRr3efFVnbCo7pu33nzg1JcY9dcG1CNTQl7P+V+Z/97QR6U/oYl3sWQw?=
 =?us-ascii?Q?kI/FM8mOnm3VdWKTKkMCkh16Lb1ZKxeqKLGiBI6//9cMdYMSL2K+9AD3i8B3?=
 =?us-ascii?Q?kblP4bcw2zQ862o1WTIBXLPw2MYq0S97cqnUmBCSJwT0feA4DlZ3RkkCyKO9?=
 =?us-ascii?Q?RI0mx9k0c7gfPbBKkzi7T2WdkksCyFf6D9NI8lHMssex0RxsHdVbMa+s7DYl?=
 =?us-ascii?Q?1I+sqL1YkOEusV5Vw5ntl9xBwQbFLIqaS0X8iEUeFTaUb5n/NhuKmUJiZAxj?=
 =?us-ascii?Q?nqdQYz4nq3sPNe2cMtgJ?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 79367eb8-4c15-4b08-8560-08dc9047ddab
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 10:09:12.0361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB1954

From: Jakub Kicinski <kuba@kernel.org>

>On Fri, 14 Jun 2024 17:49:51 +0800 Vanillan Wang wrote:
>> From: Jinjian Song <jinjian.song@fibocom.com>
>> 
>> Add support for userspace to switch on the debug port(ADB,MIPC).
>>  - ADB port: /dev/ccci_sap_adb
>>  - MIPC port: /dev/ttyMIPC0
>> 
>> Switch on debug port:
>>  - debug: 'echo debug > /sys/bus/pci/devices/${bdf}/t7xx_mode
>> 
>> Switch off debug port:
>>  - normal: 'echo normal > /sys/bus/pci/devices/${bdf}/t7xx_mode
>
>You need to provide more detail on what it does and how it's used.
I will add more detail to that, thanks.

>> +	txq_mtu = t7xx_get_port_mtu(port);
>> +	if (txq_mtu < 0)
>> +		return -EINVAL;
>
>drivers/net/wwan/t7xx/t7xx_port_debug.c:153:5-12: WARNING: Unsigned expression compared with zero: txq_mtu < 0
>-- 
>
I will fix it, thanks

Jinjian,
Best Regards.

