Return-Path: <netdev+bounces-129381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7358297F1B0
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 22:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E542823D7
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 20:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E332A1A0B1E;
	Mon, 23 Sep 2024 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RotayVLB"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771FB15E86
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 20:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727123194; cv=fail; b=JrFUXV8hUM/56IdjK3bkAyKOUfHwo8/EvEn7SuqsckdXnas++fHO415my788G7FwCVuugB7DrrIJQxTRS1pIBjWbns8lGzj//tNucEf+RxejpCBf5280fMYWZ3er4xJMnJ4FgSinq5482/BXq97CQwVwNjHJXDXHevq2gi5uhuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727123194; c=relaxed/simple;
	bh=0TQLNE6Jriz/8t6ef69R1SSpnaS02tn4GtZ2j0GpBnE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CdakRHbImDMcB1cFlObfytrushbl/vK5EPd5WVB0rkM6vl37NGhyfgi3q0Ov/sX0sOXxt4lXVLKgdrOUYK8BABYkbuQ7AZakNVbST5xNMk7r4FK35dDYTeV61h8QvSY0ohkER5yP690n/kv7cDih2/cPc8B3NHRtlSfJoEq8AQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RotayVLB; arc=fail smtp.client-ip=52.101.66.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAUyXT8L9i1Jz3ePD1hk0maJ6/s7gOU4r/54ww+AhWGM0mHOByQ6k6qU29cSEco78yMyQXgz7QLTupdiHZ9WgV8LzUm9Pue0FdQrD0JmaT8moOHAVPedNqX+0n9A0Dj8AeOQrefrQGBRxiCSo6A+iGuzk8adz1XcfzrR+DmwFEKlKywgsrWlU35ZKzmj3saXSiU7vO1vn78nXX2TCuPyXAmZqxyDuH2GQaNIEigcPhG5lh6P6QijDOCtquynj/WH9u6nl0y12RaUNk0hjdMKpBcZLzlmbOL7P8GQUZ6KZaOdoUrtgh3nJO9XaeQpkRK+rHUvdWeQVBSQ8pnZbagd/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsFWuFPHEuGXtwrNoNYoFEcb8XyclW9WHWBmuh889K8=;
 b=S1WZK+wMkzbKpWXGhRHLOQjSbWmaGdpiLj0gavetZEI1yq2JU//qiJUn13RDGBkJ8FqTOoBK2FmEaDtmB4SEerh/8AE00vf8Ae1sFcuPNNt24mQGZvcafRAKpI7E0V7O8fpwWjwiNYK1LVuXdEW0yJLIYSUpXyoiH0ghwB3d8QJF0Se98HKhqLkL256UNeVxIKS6hJpEDSPTcSUDVrtOrBIMtMEmRS/KpZaO1yUEPr0yO9GEqffvke78kYJHtW+iicas3skxJwBqSo/yqQBkvcBRsZn/RIsnH/PPpUEouk1kDiHKiDglzLfiKKu5zU2/pGrh8tr6i2DlJJsrrEHEQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsFWuFPHEuGXtwrNoNYoFEcb8XyclW9WHWBmuh889K8=;
 b=RotayVLB4SVNYB/kuyr16U/5nggfchlZDwoAh3A6I4d96JUd8fUxbmUljkUPNVkzVDEJ7cz3P5vQLgShF2jHQDh/6/8doTY+zRKqp0NTB2rDiqSJLT51RIS8tw3XMKCZdyCgZEuJdrZyNkvonmOA+AYcF08VRSIfxPOP+gyIsnwneE5s/hXmQrPtbyAEj6IA9i8NS4x2eUoUSASwcUP+guAgd4dPILFNeIQyR4EC6LOwKJghtq+0OEg9cu1hbFRSa0e442UUY1GNTSQjSd0Q2/PmusgSCFcIm/VIGN8inWViKWoFoF7CyJ4UFrzZ1Wr5uQXxmOtoVdF3b+vwMZ6Rxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PA4PR04MB7567.eurprd04.prod.outlook.com (2603:10a6:102:e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 20:26:24 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%3]) with mapi id 15.20.7939.022; Mon, 23 Sep 2024
 20:26:24 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	horms@kernel.org
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	Wong Vee Khee <vee.khee.wong@intel.com>,
	Chuah Kim Tatt <kim.tatt.chuah@intel.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-imx@nxp.com,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v3 net] net: stmmac: dwmac4: extend timeout for VLAN Tag register busy bit check
Date: Mon, 23 Sep 2024 15:26:02 -0500
Message-Id: <20240923202602.506066-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0081.namprd05.prod.outlook.com
 (2603:10b6:a03:332::26) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|PA4PR04MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: d48173f2-e8f1-4a24-d860-08dcdc0dfe8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmtENVdHUDNYcGtrMExTK0JYeFdoVzc1Ynh1RzZWeHRickxQaUNRM29vMFdZ?=
 =?utf-8?B?Zlk2SzEvWFhFbENOOEt5eTJSVGthT0lISXVHZ242TEl5bk03S2N3dXlIcisw?=
 =?utf-8?B?M1NjZzdqZWRzQVZVVGJ6YzhIQTFnblZjdFIwbEJaaTVrekdSWWdlSU92SVd6?=
 =?utf-8?B?RVlDK3FsQ2pjNEIxKzJTbEdSWWo5OUpUcWcwMlh3cFdKQTZrcU1zY1FDcklj?=
 =?utf-8?B?c3NTbm1FN3ZBV0VuMHBQdHhCNzYvVUkwaUdITzJoRzVWaUZXUm0vOW9ZblBN?=
 =?utf-8?B?OWVoNDgzWlBaRDVocUJSNFNNd2x3d0NWK01PSmFNakdwSW5CZWV1ZGRLbUgz?=
 =?utf-8?B?YVFHRUJDLzZDT3JYVXN4ZkRpazJjNGVUWmkvd3JsQlM3SXRBRy9WMDNZb1VI?=
 =?utf-8?B?STdPZ25jby9xc3o5b0Q1SEt0UEpnRmpnU0tRSDJROXVuWGFaNmRYTmNMRzlW?=
 =?utf-8?B?WHZkNDlVcENsWWVNMFBTck9XR3puZjU4eUpSVG10VGQ0cmwzbytLV0YvRURj?=
 =?utf-8?B?R1hyb0tyK085OFpMc2dWQ285TmRpWWhlRXV4VjZjWG5wV1dNdzVwMHlCQlQv?=
 =?utf-8?B?OUlYNCs2Q3hXSkptNzQrZGdZWkxlT0dDZjBsWlkxNjNydXdkTCtETGZWRGpL?=
 =?utf-8?B?UFo1Q2lqM2JTM0ZDUEUyd3Y0eU9IWVRaRXAxZkYwVVZaMmoyc1hlRDFKUmtt?=
 =?utf-8?B?RER5ZzNWTlo5U21BaVJKVWFoeEZDaWUvKy9FNU9wQlV4Wml3M09obG5IdjYw?=
 =?utf-8?B?b0dXYXlYMis2VkZjNGRNZnF3RXJzbG5wVnEycXdVd21sY2N5d3lwTzRQY1dE?=
 =?utf-8?B?U1VBZ1JCdlQyTEcwTUt4KzNMUUEwYTF6VGZKOElEQkhZN2E0a0R3T3hGUnFq?=
 =?utf-8?B?am5LelJoU0hxdHlyTDY1ckZGRmxpb1BKdmFjbFVTQWd6eWgycmx3OGU0NDQx?=
 =?utf-8?B?dEtNUFRldnduakJ1bzFQcWRuRWFMVzRGS0dmNThQZlZaekJqNlpsRS9aYjcv?=
 =?utf-8?B?dDNZUlE4b3NTSEhzenNBOGthY3llWHd2V1ZuV3EzWlZrdUxneVBUYTFDS3Jo?=
 =?utf-8?B?QktnT1M1SnZPL05hWXpQdkdoS21nQysvV3hPUTBhQWpuZTZ1SkF4dGhDS0lx?=
 =?utf-8?B?VHQ1SUR1TjI5bkN0TzIrVFhwMWRmVFBBYzZQQnhDQkxzY29PTTZuU0dFM2tG?=
 =?utf-8?B?cFd6MlJuRmlZZEpWMnp2UXdLUWVscytRZFNtMXppOTIxbGk1TVc1V2pSOHhy?=
 =?utf-8?B?SFY5TnMrNDh6ZTRvR3YxRDVQYXhGUU9mNFAvVm5RTWo3SThwQmgvQ1FuQXZT?=
 =?utf-8?B?VzBHYUF6RXh3TkhvcW1rZTJvdnF3SHEyN2RHYkhuQnFHQlhvRmJJRHBScXpY?=
 =?utf-8?B?QU41RlhSc0owYUV2WUlCcDl5WTdnbjc4U05HQXE0ckJWMWFjNGdtY1h4WFpR?=
 =?utf-8?B?RE01SW56YnZaN1FQTFhYZUlIV3UzUDR3eDQrcm5kMDJkNERJV0Qxbm9vNmNP?=
 =?utf-8?B?NWc1dWw0Nk9ma3pHbjhQRGZ4VE4wdUFnM3lKcEtEUktaNERLV05IS2tXcHhv?=
 =?utf-8?B?KysxeFRhV0NUUVZVYXByMWpPZlpFdHlDNExldUVZQ0ZvUXZKYzVSbHA0bEl4?=
 =?utf-8?B?SzZBRDZjL1dEMm1mOFNiVDBtZVJ0RUJ6SGx4NkVka0xUeHVQYlp3THZYaUZh?=
 =?utf-8?B?TWhGYmJHSkErQ0dDRTlKT1JMeTd5ZVhReXBDdXhjUGhaUlFmRGNCNjhzT2R5?=
 =?utf-8?B?dUJ1RU9jRk84QjN3bkptSnFuRHdCRjk0RmRFZWpBY0tPZFZOZ0F0U3Y0aVRC?=
 =?utf-8?B?YTRIUDFoMXRReHBGOEYxZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d09KdTl2ZzV3cEZxMHh0eG1YUWxSYUpQdEg2NXpnQ1drRVhmYktVNHRGODZj?=
 =?utf-8?B?bmgvSXhjcEVvNUlSOWpucEJtM0kxbS8vdnNtN2kzSm5uUWtPQ2VwNW5DczVR?=
 =?utf-8?B?a0xQV0djTGZUa0hpL2RydVFuM3FOUXJTK0hVUWhXUXB3YWdxNmFPV21PQUNQ?=
 =?utf-8?B?cis5RnYxVG9pL1VncTNXWWtnYStjWWdoM2JISjU4bk9TTXVkQm44eDBkdHNl?=
 =?utf-8?B?MWpnd1BoT2ErTk1hMlNKMG13Mi9RK0RVdWxZRklaTXF2Q2ZNVHZIeXZtZjRU?=
 =?utf-8?B?WmNpY3ZWRmZmNlE2dnZxZ1Bhcmc4eCszYmVSU2V5SkhzZTBTVGNIZ3VmQnow?=
 =?utf-8?B?S25WK011RlhLN2lKT05UU2tSbXNDY0dTcDczUmVMaEVrRUhtS0QyZy8yc3NJ?=
 =?utf-8?B?RXpEWUc4dEhkRm9relNiVTl3cGYrdG91ZEg3enF3RDdDVXU4ZnRtOVRhOHI2?=
 =?utf-8?B?ejc0ZE1EZzlVbHJWWGhLbDkzQ3FjQUo0RmtVZHdMeVArZWwzN2VtMEhONGJM?=
 =?utf-8?B?T1dSVU9HUTkzdE0xK1FxQ2wrQ2JLMVBjZmNtZUptQmxXeVRNWlZCK3M3SUt3?=
 =?utf-8?B?MlQ1ZVFzRU1CY2lCcElXS0ZFVUZWUDg2YWRadmJMeGpSMURDM05wWGtpR1gv?=
 =?utf-8?B?STl3WGdpSk1ncmNoOEpaZWx5VW9NZkR4bS85QVQ3K3F0WkdaVFRFaXRrc0Q0?=
 =?utf-8?B?aUZIR1JZSmlSNGpBRTlxUFhqYVl0Y01WRzE3QmRZSVVqSThtenkrUnpZdUY0?=
 =?utf-8?B?SGk5UktNQVl6Z0hUakRodE95OFlmcFdIRDlzZnhrLzByU1RzOTM1TitsS0J2?=
 =?utf-8?B?eDJqcG5admpiZmcwSjYxektTK0JDZ3VrbWV0ZEZzM1MxampGODY1ZE1OU2x5?=
 =?utf-8?B?SW52RUNMM3ppQ0NCT2RJLzNqOUJWNDMvKzRTNFU4SFFDWldvQU43RDJjeW01?=
 =?utf-8?B?UThvUUF6SXM3dTJtdFJ3Z01WdUNKOVRmQ28xMno0Z3BudGdsKyswNDdtOFJ5?=
 =?utf-8?B?SnNRV1RlWnhKRTcwb2JXUkJQcGFOMHowcDI3bHB4WUtHZnNzYWVLc25VMlQ2?=
 =?utf-8?B?L0JtRG51eWNFcVgwYnFndVVxWTY2SnU0U29JYXdRQWRVdE9vNGxtcC9zdG5l?=
 =?utf-8?B?VGN1VmlvV2lzNXpNZDR5bndYTWREVVJaUzR3NkdyQzJqdnFPUGtmbnM1Y1pM?=
 =?utf-8?B?MDk0cEE5N3BaektQZ2xFZWprNHViemxsWlN3YXlMenhMTEhpNzgrWms1Yzhl?=
 =?utf-8?B?by9odDZ2K01IVkJDYVhJTTJ1Um9PQjB6UStaRnR1RDdsaG9BZ24vWGx6OHI4?=
 =?utf-8?B?YVBmdThkbVZlb0ppUnl2SWUwYUV0TlB5VnJQT1gwN1NYUStpY2ZYakx2RkVU?=
 =?utf-8?B?YzFhQ1d5ajkzTko1TEtJa1ptZmt3aGJ1cGJLcERuaWZzeDhwOVVMN3NGZjBm?=
 =?utf-8?B?TlhlM2ZkeVVEdWNlVFdjUnBiVTVFV29xQStobGx3V004djc3WDI1VTh5c2c4?=
 =?utf-8?B?OFFRRmVRN2RVVnFCMFVDelNvWklhdTMxb1ZDQW4vV2orNlA2RHYwZHdwd2dE?=
 =?utf-8?B?UTBrcnFQRWwrSkcvY2g5RDI0TVNQc3B1WHBoQjE0cThGK0tuaDQxQTUwV1ZZ?=
 =?utf-8?B?MjNLdzAyTW4yTjFzTVJBNDVwS3dyeG04UlZrcjFVa1ByZWZkc3RFY2pjVC9D?=
 =?utf-8?B?YUFlNXlkNG1jTVZBUU9tMjIxVkdwMXc5LzI3N09JdU1OaFViSlpjWG9SdnRD?=
 =?utf-8?B?a28vSlI2WmhlRlRSelUzTTV2V0RxZEFMYkZHeFYrOWtoeGNLYjh3Nlgwazkv?=
 =?utf-8?B?aXRWMm80aUcyRzRvVy9Kb1d5c3FEWkJJTEVqVVVhTVBUMGlVU2oyZVluQlhC?=
 =?utf-8?B?VE96Z1hPdzZLVW1uZVNPNXBJeVlqTDRJcExLR3JoRklQVmVCZmRaYVptUkc0?=
 =?utf-8?B?MHRiNm9qanFlbHNRblJNaUwzSTZ1Zk02T1ZWQjRaZ3Vub3orVmgvSDdWNlc1?=
 =?utf-8?B?cDkzdFEvRTgway9pR2UxeHJyR1Njb2hJZ0VCTUR6U2haWjZkZWNRajlzN1Vp?=
 =?utf-8?B?dGwxV2I5ejNSMW02YXhlTEJWYVlJdGNrTlBwR1kzWWl0dmNuVE9KbnowQnJY?=
 =?utf-8?Q?gf/z8PlZ34eHVtAwGFGyYWuH9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d48173f2-e8f1-4a24-d860-08dcdc0dfe8a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 20:26:24.4125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grdxQdAoLRCaQXyIhHdIod67qvVMk/rZ4coJPzYXhbku9qQGm+yyfy/lRY8kmkqPXteP14ZHat0ZmZBn0jvSNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7567

Increase the timeout for checking the busy bit of the VLAN Tag register
from 10µs to 500ms. This change is necessary to accommodate scenarios
where Energy Efficient Ethernet (EEE) is enabled.

Overnight testing revealed that when EEE is active, the busy bit can
remain set for up to approximately 300ms. The new 500ms timeout provides
a safety margin.

Fixes: ed64639bc1e0 ("net: stmmac: Add support for VLAN Rx filtering")
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
Changes in V3:
 - re-org the error-check flow per Serge's review.

Changes in v2:
 - replace the udelay with readl_poll_timeout per Simon's review.

---
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c  | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index a1858f083eef..0d27dd71b43e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/ethtool.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include "stmmac.h"
 #include "stmmac_pcs.h"
 #include "dwmac4.h"
@@ -471,7 +472,7 @@ static int dwmac4_write_vlan_filter(struct net_device *dev,
 				    u8 index, u32 data)
 {
 	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
-	int i, timeout = 10;
+	int ret;
 	u32 val;

 	if (index >= hw->num_vlan)
@@ -487,16 +488,15 @@ static int dwmac4_write_vlan_filter(struct net_device *dev,

 	writel(val, ioaddr + GMAC_VLAN_TAG);

-	for (i = 0; i < timeout; i++) {
-		val = readl(ioaddr + GMAC_VLAN_TAG);
-		if (!(val & GMAC_VLAN_TAG_CTRL_OB))
-			return 0;
-		udelay(1);
+	ret = readl_poll_timeout(ioaddr + GMAC_VLAN_TAG, val,
+				 !(val & GMAC_VLAN_TAG_CTRL_OB),
+				 1000, 500000); //Timeout 500ms
+	if (ret) {
+		netdev_err(dev, "Timeout accessing MAC_VLAN_Tag_Filter\n");
+		return -EBUSY;
 	}

-	netdev_err(dev, "Timeout accessing MAC_VLAN_Tag_Filter\n");
-
-	return -EBUSY;
+	return 0;
 }

 static int dwmac4_add_hw_vlan_rx_fltr(struct net_device *dev,
--
2.34.1


