Return-Path: <netdev+bounces-129619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809EF984C72
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 22:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994CD1C202CD
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 20:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6646F12E1C2;
	Tue, 24 Sep 2024 20:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yuv55yjE"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011003.outbound.protection.outlook.com [52.101.70.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2574812C52E
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 20:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727211300; cv=fail; b=OXSIrustBPoc2rnyUOBP/JGAyOtXMcFQ3i0YjjZo5AInfJgzIWApFbXWjlKthw4tFyiXTpnqbWb+qLek41f4Zxr/JLko1azHuaDFUZ68TAMIOkeEPUmmtlzh/bF2yGD0XnsIBANfEd8LbzD0nuQYxPI+FbQyQ3pGMaQt43H9Rr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727211300; c=relaxed/simple;
	bh=Kj6MFwWUSgP5kwA9keTP5vtuF9VwkB0L+GNlqJM4diU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DQOaCLdB136hAEb/E9IeOGnEcDgWsi7YfVbgngt+2wnrT9x3khkhomiqUyLHAobuBwsF2500OIzHaokrol41s8t7EWLoLN4sD0MVBD4xCHAKWo+gWD+Xvs8MmUC0upf+KUf+dK+8IrLc2o2REWGGeBCiy3mTns0Hc8iyJrGiJek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yuv55yjE; arc=fail smtp.client-ip=52.101.70.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiVrCYVoru4Hft3M7vCgExIRuQ7IjtwzZZZfT//wpTTHFstnDa7JJ15BCd+RI5iwyZmWihkfTCNT6MKt5TUM46gqy/aFnSmLopE2PMwnLwDl0K78wuoIKVaHoqX+OpynSqTtEQ3fgpdrUf3hRoWzHGqGKm+/lNnld0OrKsigX5UXBWmV1KByvaAHjYcSbkXf/zEkFi6dcZ4GX+3CeUI1L5MeH3Itd+cZDTCy9RQSDddjF1kwntuZmj4egIfOMNhVnJt1QLrURaleaqxxugl+c7vLI+YKaRiOmZSaa9W/4Ewra2ubZqPQOf5BRonl8+2F+CwtVKbq97vZGu46+1OnOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tra+UPZqQsNzz/9oVTpxv2ung86t+AcusOp7s59Aq5M=;
 b=aSBJFGJt1C33h426UQd85EcGK/02lh6n4OyTswXoJ1l5ww7HgNKYIdj2nqyNp9saIjoR2f3gG/a47VHiO8Q4BNJ3HaztGAyLNV+D9PzTyMfMAdYvaGcCZzHJftAV6EM+BgbWJFBAjaLLX22NhAtWsIrY8B6gyTwwJpJxHn18L34f3HB36cgipd6F8fiyIsVl2TwsjrB+i6eV5t0I5Ciejx9qYnEdesosYwu9JsL9QbkznsxRPcWEjh/ssXpOXh2LDkvRzjA4emgJ8M5diLPKNQXQlCcDU2Hl6sOPBC/CJIRtVedDVpx/ejHAtnYA/j1LArDPoUK1DJX+h7HMhxivFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tra+UPZqQsNzz/9oVTpxv2ung86t+AcusOp7s59Aq5M=;
 b=Yuv55yjEFzPDkKNcS+sQ4SKK5SIpMkaEZRf+LdBwRLAVu0pqnFNGlL44xKaOIAqOpE6JmWRdqBBjLuxaMASX/HuxE+c4viWvA7ycZE/qjj1rJlr2hf61ZsZnRJjTO601g9ZXf/ATrlT0VmCDygUOYESSfpiB8DtRu6VUC3ktwKkSVYtOz3jvj0t+neeNZslgEbgPZBgwTb2ZVCQDmlB+X/JBRGfZgkLRdtboVleWJJvclGj1gMU1i/ouWdm6mLBDrKzNI22f28pFzncoyIZTF4xndm20IgWu4fitEo7GxxnX0X1KXcHv/0xYI0ddBtHtpjyn4zhmb+qbQpoo/QJnpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AS1PR04MB9384.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 20:54:50 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%3]) with mapi id 15.20.7939.022; Tue, 24 Sep 2024
 20:54:50 +0000
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
	Serge Semin <fancer.lancer@gmail.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v4 net] net: stmmac: dwmac4: extend timeout for VLAN Tag register busy bit check
Date: Tue, 24 Sep 2024 15:54:24 -0500
Message-Id: <20240924205424.573913-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:805:66::35) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AS1PR04MB9384:EE_
X-MS-Office365-Filtering-Correlation-Id: eeeb987b-58d9-4f17-a0b9-08dcdcdb21f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K25PWEVuVHhGOEw2dEtvTUFBNzdQekJhcUZENXM2eVkwU2c4QmFSMVE0cldq?=
 =?utf-8?B?K0pidFN1OVNJTzk4WjNIajRlaEprbkdQRXNtQzR3QXB2aStkdGRNNk5MMzYy?=
 =?utf-8?B?UFBHQjFtNHp2U21nNnV4dDhPR2FRaFQzWGlvRzZvSWM5bVZJSTdoT1IrR0Nt?=
 =?utf-8?B?OXZYVklsLzlhV25YQ0psZXN4b0R6aDhnMlBFZnhHVVl3eGtmcjZvNzl5T1cx?=
 =?utf-8?B?WDB3WXZMQ3hpdmhiOEsyeC94VWFaMUYwaHQ0cmJYVDRxdmRBYUZkNmVRbTBh?=
 =?utf-8?B?TW8rb0RBY0dybEpjSExxVGlYZ2F6anl3eEtCWUdaZDJ0d3dqQnF4NHNsZmN0?=
 =?utf-8?B?MXdVcFdiS25sSXNCWXNOSWk1alA4VklYbFRQTXVmc2lnYkk2ckZKYm9Ibm5u?=
 =?utf-8?B?N253WXlYeHNsbTNYSmcvQ2syUW9BU3R0WnFZV2R4QzROdEIrdUtYcWd6MnNl?=
 =?utf-8?B?eGdpOEhvR01pVm5vc0tFRUFlQjlnWVZaWXdoOEpuS1ZUNXNHSjBURVVlM2dp?=
 =?utf-8?B?MzZ1WUxuUjEvVjMxTzBFRjNMTnZFS3A3dTJuUzVqYkV4eUpFRjUwNGV3cnNv?=
 =?utf-8?B?M2pKN1AwdWtiVkxVRDBmQXdOa2JnZG5pL3RZWVJZNDlpLy9CakRPaERSb1NR?=
 =?utf-8?B?VWV4UDVmTzZQb2NDak9IM2pEQkIvRUpBN3N1UmdKcmpFSWxCeFhVUGFWcFAy?=
 =?utf-8?B?emhrVW1kK3pYQ0w1NEoxdWVDR1dwV1NBU3JJSEhYNmkrSDVYaWpEOWtCaVZN?=
 =?utf-8?B?MFZJdlk0TmhoQ1hOUTZ3RnB3UDgrNkFZSm5Edzhzd0cvLysrQ1JQcG92Tkdk?=
 =?utf-8?B?VTUrbk0ya3Q2dHo3QlNyaksrc3g5bG1VeCsyNUlYVERQRlNQeUNBK3lYYitv?=
 =?utf-8?B?b3F3Q05ZSVVsWUZheVVibFFPamJ4bkJTYWNiUm92TmZRTk1nYldnYnpQSDlL?=
 =?utf-8?B?NWZIUFFYVzZlV1dVYTBaMnZteHJEZ2ZRT2tpMHAybVJkbUFJN1VzWlpMYU1r?=
 =?utf-8?B?VVQvU2VwQWRmV1EvOFU5TFpWeU5TbzRQaU83OGZ0aFBnNWFBUk0zeU54WDlN?=
 =?utf-8?B?cUQ1d3FrRXFBQ3oycC9SQm5jVmxwMFJIeU1KY0lOME1XTG9EeGVFL2p4a3A0?=
 =?utf-8?B?TDMrRFg3azBtYnRLTnlrQUZlRUFEc0d2QXJzWW90bzdMSWQ2SFBDN2lmUnlQ?=
 =?utf-8?B?akM4V0Q2VWdZdnZwQmpYeHFCLzVYUTdCMzFJVTc4cm5ZWDZualh3Q0NKL1BZ?=
 =?utf-8?B?WXJXMVJuRTAyQmp6ci8xQlAvMDRsWDZvL2NYUlRDZDFldmFnYTlnZG9GSTN2?=
 =?utf-8?B?WktnZEltL0V0TGhTUDBOWW96aFJwWS9ORFdKN0RIeEZVajRjVGVqaTJmdjBa?=
 =?utf-8?B?VEdCcytoYU1Ub3BHQmtOVXRLcVo2T0xZQXRyMEZjTmV0NjRxMndYTVJtYzZX?=
 =?utf-8?B?dFY4dGhFN2w3VzY3RWFENkY0allKTytYNERnQklVWmxQL1ZTWlA0bTFCOUtl?=
 =?utf-8?B?SlZxK2ZxR1pmMVJFVDg5dmRYaHAydjZESjR3QU93bk5aK3dLRGtkSHJFZDdM?=
 =?utf-8?B?bE9Oa1d1RjZXTFdKcGxIa3ZqcnQ3WnduZmtPWVhLRldteVhQRzFSLzUvcytF?=
 =?utf-8?B?c0pqWHMzQlVJV0JaOVZTRlgzR1QzMGIzZUNyWDByNTdWVEhhdFVNdlp3b3Ju?=
 =?utf-8?B?N1RXTGZYNUdzUjI3OUVpSFhROSttV0Y5WmpYRGRpWUdqbktBb3RmRXB6ak1p?=
 =?utf-8?B?V2VlanNTY0RLNS9NY1A3RHRvSHVNVVczRHljMVViMzNQejNYTHhmM2ZNUmdx?=
 =?utf-8?B?ZWl0cE5iMGpZS1ExSDNjZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFFhM1EvSkllZGk0SkVEK1dmMWRzOGRNUDhVWjZRVm1tMFVPNmNRRkZpait3?=
 =?utf-8?B?dFQ0clpxSTNmSnVDb3REUm9ubmx6azI2R3F0RHIzOGltWitTcFlGVksxTmti?=
 =?utf-8?B?K1hsQW1DbDRya0N6UVJ6aHE4UW9Qb2xrNUQreHNHY1RMVjdROHhrckxFQnFr?=
 =?utf-8?B?SE1SQWlmZDNWaGVDTjRLUU0yNVljZDVYSzVWMlJvY1E0UEs1R0VOeWFneXFO?=
 =?utf-8?B?QTV3Z0MwUjRMTXhkNmVZdTkxTG9kdmhScGE0Y2RwdFNNSjg5bFJtZG9PTjkw?=
 =?utf-8?B?dGhTM2JMeE1Gclgxa05UT2pNUmJjUkw0YnpZN2loak5vUTZGUUpPWWl5S290?=
 =?utf-8?B?V3JhM1RKQ3N5djkvQWJZUEtua3d4SVBsclJvUTJGbjY0VjdscVRqdTBScCth?=
 =?utf-8?B?aVBHL0ZXQ1RDLzRLM1hxT3RqQ1IwdkUyN1I0bWpzM2dyVTV6LzFCbXVjVDJr?=
 =?utf-8?B?MGJqT0Z0S2txR1M3b2l3TXRUZi9NL3ZxeS9yMnhBRC9lRXpOSUh0L0xWZGJ3?=
 =?utf-8?B?Ny9MUFFmNldLc3ZKelJYY3J2LysyYnJ0OHVZL0t6MTZpai9sT3BJR0tpSEs2?=
 =?utf-8?B?Mm0yM3NIQXMyLzJvdGYvQ3RLWmZaS3hiZXlJSjIzWmhoTHlZWUQ5cmFQOXRK?=
 =?utf-8?B?S1cwYWRGWlAxR0ZXWDdDWU5oSG9ZbWorNXA1SEo2eWlQdUttTFJsbTNKMnpR?=
 =?utf-8?B?UDk0YVM3b09ucnpTdFZpL29MdzU1c1A4dE5LelB0SWNMQ0dlb20wcFFDcmRk?=
 =?utf-8?B?N2RXU2N5WEVKL2lLY1FOUkdMUmt6bWE1dm0xMm9DNkYwNnZRMGpiTFN0ZG1q?=
 =?utf-8?B?RUo3VXIyRGpxZHdDM0FEMmdibjFSelBta25xUmlkU3QyV1hhc3JrTyt1Um9v?=
 =?utf-8?B?YmZNMUg5TFJxWXJUSGNBYlBYR0RESGdBVCt3R3NGenJ5cXhLTTVWN0VISVda?=
 =?utf-8?B?ZCtUa1JiZEJIVzNtYTlBbHRUeWNHVTdxREU2K09KckFCczZBMUllczNCdE9y?=
 =?utf-8?B?Lzc0SU9xNjliblNSb2dDR0pNYWhaUXh1T2NNbGVCaHg1UGh2SDBkWHE4UXRZ?=
 =?utf-8?B?cnZSTXdaQU02V1B1VXcxSGlmZG5Xb09mUDBCalpVckZ2eDMrNktyUWZzL2d5?=
 =?utf-8?B?ZTBiVUFKK1YwVWtaSGRUemU0VVBsQjkwME96NDRFUi9pZTVXVE5rcWhvMmFh?=
 =?utf-8?B?ZVFvdkpBdElONkszSyt1a3c5NGV4R1dpNkFkOEYrcHZ6dVJUQVArWnRyYWh4?=
 =?utf-8?B?eDEvNXFxUGE4cllBcUZZaVI3d2hEclFrQzgyZGxwNktkTnJwVFNMc3dOWVF0?=
 =?utf-8?B?TnRraGdSTXlHV3djcTlJSDBkOSsybU1MV1Q0QitvVVNENVRicHVIVzkxL0Nw?=
 =?utf-8?B?WlEvMUFWTGVZeVhCaEtPY1owekFjYVVOWEtsdFRnYTcwM25ZV2FPclBickJq?=
 =?utf-8?B?L2xqZVNpV2pmODV0MDJFQldtNVBJZG12akFkekFLcEVQT2JndmJlRXc0OWJz?=
 =?utf-8?B?RUVacURtQ2huQlRaN20wbEoyVkVUYmlrU1ZhMThVbFZ6bHlKMlZBdEdPZmJU?=
 =?utf-8?B?R3I0Sm5XYmFkOVVSR1ZwUHBMM0c1MHVjQkJYTHg2MlZLV05oMy81N3BpdEd3?=
 =?utf-8?B?c3BiUzdlNVRNa1d4aXNZLzBKMTRBb2VVem9EVzFhOEVvSDhuWnJza1FucUFW?=
 =?utf-8?B?bzEycGdrRXJtL293QitxbmZ5a1REQmZMWHUzN3l3RjJSTWFzR3l3UkU3bUlP?=
 =?utf-8?B?T3czcU5oMVc5d2VwalRyanpFWTVXWTdSQTdRaFNYWHBxNWdTYy9WdTBKVjZt?=
 =?utf-8?B?RHFHSW50VnVSRGJWOE1nRXl5RUltNlZURGozRlpPT0drZUhtYXlBUCszTVJN?=
 =?utf-8?B?RjZyZVB4YXFnMyt5dS90b3VDR1pjajhrblFvVy9mWmNJZGxFNyt0SDhVVm1j?=
 =?utf-8?B?N3QwWVhnVkdDNG1HakwwVXpvMlZIWEJjR0JrK1hoZEhRTnFOSDhJcUZhUXRz?=
 =?utf-8?B?eTBHdUdaZjVuSytndE5qWHlIanJ1TW5nN0ZXelJUcHNTdkF3ODZ5ajZDTVc5?=
 =?utf-8?B?c1RTVExHUTFoUlFwT3ZXZ0JVZy9ibytiRWFXV1Z4aVh2eDNXeDlrUU94RUlz?=
 =?utf-8?Q?fH2gB7yzr4sLi4C72dcVoY8tp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeeb987b-58d9-4f17-a0b9-08dcdcdb21f5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 20:54:50.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+TJFphoI8TZDJQ9IIEeR7ewjweVYzGHUGL7sQis0W9g8DcnyR0R+DsJqXUARoWO4PvpYQElFu3+c1GDHimU0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9384

Increase the timeout for checking the busy bit of the VLAN Tag register
from 10µs to 500ms. This change is necessary to accommodate scenarios
where Energy Efficient Ethernet (EEE) is enabled.

Overnight testing revealed that when EEE is active, the busy bit can
remain set for up to approximately 300ms. The new 500ms timeout provides
a safety margin.

Fixes: ed64639bc1e0 ("net: stmmac: Add support for VLAN Rx filtering")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
Changes in V4:
 - fixed the comments and R-b.

Changes in V3:
 - re-org the error-check flow per Serge's review.

Changes in v2:
 - replace the udelay with readl_poll_timeout per Simon's review.

---
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c  | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index a1858f083eef..e65a65666cc1 100644
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
+				 1000, 500000);
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


