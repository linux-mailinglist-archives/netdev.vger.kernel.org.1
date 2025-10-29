Return-Path: <netdev+bounces-233879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B26A6C19DF0
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 11:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF616562E19
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 10:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AF52F7AB7;
	Wed, 29 Oct 2025 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UGjBFVCW"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010017.outbound.protection.outlook.com [52.101.69.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BA82C11EB;
	Wed, 29 Oct 2025 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734584; cv=fail; b=Zf/kSHE/0TBg/jcFNlotaQcM5G90ZTYCPUejJaxrLAIK5iYOeiJOAMSXjY4VA6RJsrqr0w1ztgTio58QkA5OMa8TxH1jzKVbCQnPs4GOCchUgl23Z/5ByGg4qLjo+ckIcn7nn1o50SGMpBaIUoFeo9lXQueciAwMr4CaxA817ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734584; c=relaxed/simple;
	bh=U66OZFOTYPR4DlmVlgoaDoO/bVOILvUX82RNW52EdX8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TnQ6E5mg8esKDofdA3zbXVWwF5/owP/nG2wO75qs9QJRslj4UHNRSTAyK6BiZvu7wnv36An/ahiPAJYmI86WElV4bI9gdbcn4bICYn7N7lYWqcFiXihXlIx/c3QzQu0v020SkZCOjidrMLLfGkIu3hhu0sjxVxLLUcPSgU4yUk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UGjBFVCW; arc=fail smtp.client-ip=52.101.69.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMXX0zO0QEmuocboe5aVMB74Uf+NqKIxVhJFo+06NOC7tUQYIu326VMISl5wZOcEir4WipcCvF8ymwqrOFxn2KIVuKmZ/CA6wKfhVZMSRrXbAcRijlODZ6H4D2qi8a9LvBJdgbxs+wRu/yNbOHh/nf43ynF8TGTFgIqnGolg6Yr+0qS+4UznYyRn9ldyknwhegJzS/fKU0M5SypLRCUSBbBIRdzs2vIc+JVGwVZvl33ATQg1p0o/zo0OIL5jMuyZqlWfP9xzcc1eZKL/7uhZsLumRyjh67L3aF3Rebqyf1nfCkdMxUyh0X35LumoKM3WY/ZMIRdY7/xrIo2/b7040g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTj37Qxp7qaRl+6sUjPYNYRcNVtvpyEFPzKvDmzaIec=;
 b=WMOlY8YxDGlnp2rBqnJj+tpTEw3FTjdkrafcu6WuGee6OhOWS7A64Qz/xyyDsdnYGNKL8aMnlXahh7OZtZBKOhMDYH9ZycWMWzgPLOeAF92DvZ9ToUxYtoMkwQAzmJoFU2c7tv1sZNz9Pjtb7lUSeXdGyM5Ua2wA7jed/1Lkhru1fYj7HMy48ovmJvub3NwVdhM8gaTuT0tjLwONg2bFCGJvBmLiHb5to6pxIVmFkNnfPUSQDtlZGR4USNf3vQ2qw6GABUP6sTPkT8nCovkxWfCSMPCB8NUAn1OIl+BzuMeGXLyN4YNklBbOZ1C7E1FrLSmZjtHz20oc/LemlqsRNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTj37Qxp7qaRl+6sUjPYNYRcNVtvpyEFPzKvDmzaIec=;
 b=UGjBFVCWcNm9TgCmr0MXWIIr4wDcp5nYzyOd0z3RczMH8WXw2qds3OEecyIGvDyrTWmrnk9eY3f4UzbMrTt75amKtKIHNzKOxsm2baAqLUs3EIdFv62Lnr6sKarts3NYKFrr+WDmH48ItKCFubweue0ld+cV9TgwHHuZ17N7uo124CzJGy3hHLXpGsiKV3Z6+C48VIDtK03GUenQOti0nN1M6ubCfJ7bEGzRBtge7AUqip31z6LbLrqDsHSLXvA33ew/OuD4bJFwDq8fnhkQu9o6R/ECKdtvq+WYcT0BVZOUaTTJkbq8cfZnhNEGSZAEIrmjR43vEZ8Rb0IatSA7MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8224.eurprd04.prod.outlook.com (2603:10a6:102:1cb::23)
 by DB8PR04MB7129.eurprd04.prod.outlook.com (2603:10a6:10:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 10:42:57 +0000
Received: from PAXPR04MB8224.eurprd04.prod.outlook.com
 ([fe80::be8b:fd0b:d280:f2ca]) by PAXPR04MB8224.eurprd04.prod.outlook.com
 ([fe80::be8b:fd0b:d280:f2ca%3]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 10:42:56 +0000
From: Andrei Botila <andrei.botila@oss.nxp.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>
Subject: [PATCH net-next] net: phy: nxp-c45-tja11xx: config_init restore macsec config
Date: Wed, 29 Oct 2025 12:42:58 +0200
Message-ID: <20251029104258.1499069-1-andrei.botila@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0042.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::20) To PAXPR04MB8224.eurprd04.prod.outlook.com
 (2603:10a6:102:1cb::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8224:EE_|DB8PR04MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c1b3c56-a6f9-421b-0aed-08de16d7ebf7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzMwOUZDdUM4amtodkIyZlJxSVNHOGZwRVFtcExOQkltY3JwU2dBREVHSG5F?=
 =?utf-8?B?TmY2ZXF0WVB4OWJuU3ZlZHVKVW9lZVR0QXNLcE1CdTFnRTZiTDhtelJlUDhN?=
 =?utf-8?B?ZGdJNkFiNmVsWGtGUnBKZEJPVzBLL0hhUW5xUE5GcXhsTk9ObDJNdnNJT1BO?=
 =?utf-8?B?dllqUnFJbEdiSEJFOHJ0TWUvZzNxMjdTOUsyc2V3Y1UzdnVtYm5VK0p5ZWJk?=
 =?utf-8?B?NDVHbi9pR2VvZkVnNWNGZDZueUo2MVZOei9hOXdkYnZYU1VUZ243QnJFcC9Q?=
 =?utf-8?B?cW9FZlV1dnpPcmtNU29pRG1uL1dsc3ZrakdBUGsyT1c2UHJyN01mMjBUZDYz?=
 =?utf-8?B?L2djbEg0QnFGQjFHSDVrdlZVYUVDY2IvZFpjYld6UzdKWVJ2Vk9sUlNvWldS?=
 =?utf-8?B?TlVFRE91TXUvSm9mbHpVNHFKenNkSkl1Vi9TN1lDOGxvMWdwNGRnU3MwM3RR?=
 =?utf-8?B?OWJOSU1TTnlla3VZMGRMVGhyY2ttMU8yNUg3WHQzd1pQeW1TNDFWMFVXeXRw?=
 =?utf-8?B?V3hHTE5ibzRFZDV0aldsSk5LTEFlaWRveHU0WFgvN1VYV0h6SGczTnpzcXBG?=
 =?utf-8?B?dGpHdVFFQjFraVJUbW9NRGVyTkp1NVBBMWNXSDhydnJ2NmhZSTNWcWNtZldH?=
 =?utf-8?B?RzBCMHRsR1NyeXVUMnlSZFhMUkpDUHErK2FwbkVxR2xSOTE5ZjBvaUdVYS9w?=
 =?utf-8?B?aHlGNkdBbHd6enhYMU4rYXFjK3RiWkVTNC9kVDZ1ZENDS1R2WGo2MFNoU25F?=
 =?utf-8?B?cWtQbHNyK2ZzT3RWUmsrKzVETm1lRnVZR0pDaHZEMkxRcEJ6V0psK0wyejkr?=
 =?utf-8?B?Y0xzc2ZsaVYrTWgvMUVWRDFaMDJLa2crVTJLNW4wVjBIYVZBU2RnaDNqSnY3?=
 =?utf-8?B?TmdELzd0dGFrSzdSU0VySDAxa0VHbHRXWjArc2QxeXNwVm84WFBpU0pqQ2FN?=
 =?utf-8?B?M3QyZFRwV2Z4d3hEcXJUS0d1NGVVekl3aE5ab2xqMG40WE5xOWhsa0JEa0Vi?=
 =?utf-8?B?enhJOVdCekM1U0gySDZ3RE9idkN4ckVnSk9QNUxoZXo5UWxRSFVCQlZMUEFO?=
 =?utf-8?B?MUxOU2dabDhMUXZDNjBxOFY0WnpJY1FsMzVSMHJPU244OFhDM3B0cGVjQ0Vy?=
 =?utf-8?B?OGFBVVBabWYvWlQ2ZGNzajA0RzNDaEV0cHNvVTdPbGZIVU84VS9tOEI4czN5?=
 =?utf-8?B?RTV0bEF6dmFnUjBoK2RiNGhETGUxUnVTTmhQYzZJNGFwU0VHdTZmU245QUYr?=
 =?utf-8?B?L0FVZ0szL0FmUHdiQXdGb2xJSWxabEhKVUVWdUN4Y0xIUEVEcU1hN29qVGZU?=
 =?utf-8?B?QWd4OC9CUnRmdjZ6WHJBVW1yazN2UGxCbko1R1VQTFJENkFtT3Y2Q2cyZXFo?=
 =?utf-8?B?UDZBVjFRbm9NMjgrRkJCbWx6SlFUaGlJQXZXcXEzekpML1VFWnRwanE0OERX?=
 =?utf-8?B?NDdWVDZVdllqRjRvNURJOEdTNGpWMGloQy9RQS9UOWU3endqWVJGUnB0V0Vu?=
 =?utf-8?B?MTIvTXdMSHlwQ0k3U2ZlQnRsZkNxRTljcExNcVBsNnVpdWxZU0w3L1BlVUFN?=
 =?utf-8?B?Z1NxNWgvNXBIa09iSXY0NzBuMlFXQVZUcndRN0J6RzhLVU9STWVZUlpuM0pQ?=
 =?utf-8?B?bityOE5lcjVXVy9GNm02L0JBZ0NhOEgvcHF2NWRnOG5IeStCZHNmQWpaRU1z?=
 =?utf-8?B?dGN2dWJiVkFXcG9SR1lPODJJSFdCZnBVbWxoN1ZuTXJ2ZnduaFZRQ2UwcEY5?=
 =?utf-8?B?cFNNNlpBeld1V2tRWlpLbVhWcm4wdnFPRVRMVkxqSmpwRytvei9DTjVVRVI5?=
 =?utf-8?B?SjdGZzRTdEdPemlaSVFkRitPSjF5WTFpdURLbExWSnIxZXB3N05pL0pFSmxF?=
 =?utf-8?B?Q1dMSHl2U1VUQlIxL3pnL0F1dW5tMENPeWs4RWMza2N4ZU5ZMSsrWWhQMWZD?=
 =?utf-8?Q?SGVbtM4ePJYaS7GKhM2FePAd6p/Puc+q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8224.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFpZQ2dyTGljMGhVOERsOGJQSXI2YzJ6dnhIUU0vTFM4YS9QdnZsQVV0MDRw?=
 =?utf-8?B?cEJHbVZ1Z1lhRk1VOFEzOGNMVkgxdzR2M1lPVEFCR3RDTDR6RGFxSUc3SlRB?=
 =?utf-8?B?K3dKZVlpV2FNa2RzclArNlJwcGZTT29jWjQ2eEpudWZSclo0WHR2SU9DUThn?=
 =?utf-8?B?M2tCY293cE5WZ3pWalIrQXpRb29TYXBucHduT1J5SXFIdlY2RUY1bEhIS0pv?=
 =?utf-8?B?T2FJY0hDKzJRdnlBZ0lxdytnOTlPcWpFWWx0dmwzb1dMejdRSS9NYXNaVFAx?=
 =?utf-8?B?YzhUWER5VnVxejd4SGR0MjI5WjhadWhZVXlnMkFhVmFHaW14QmxhaEFaMmdk?=
 =?utf-8?B?SSt3OG1kSUVGVWV4TWxCQ1pJZHk4QmxLeGRZWTF0MkRyYzd3RFQ3Y3RNRHNl?=
 =?utf-8?B?ZmZRWnFlY25XUGFjVXhmVlREQjhOVlJCbml1TEx5UiszdEVQdWxTRFJEaVFr?=
 =?utf-8?B?c0tramJKMEROc3oreENnKzMvWkdoQko5V2orQmFYV0QyVzBPbjE4SW9vT3lY?=
 =?utf-8?B?SlFxR0tDcFJLKzBuUFQ3ek52Z0xnZjRCNFBUaGRWYjBNd3A4c2lmWGJCZXJG?=
 =?utf-8?B?M21pNXg3VGtsSlNFTDhNeVZUN0RzMXJYTEVwOHhnYSttVUM2a2Z3U3NYQjRM?=
 =?utf-8?B?cmM0S3NZbURlQkszSFI4LzFtZXN6ZjZnZTJFVDJrT1Zna1UvZFc3S0lmaStv?=
 =?utf-8?B?L214QWRxUW01UkJQdVA4VkxFWU9UYkE0R1ZTd3BCbGtGdkg2WGxSU1JTVkM4?=
 =?utf-8?B?VVE4TmozSHJwWnhCT2FraEk2TGREM2NOUkxPWVJLcnhDR2VQWE4xQ0J2R3hn?=
 =?utf-8?B?ZUk3SW9sTWlWRlJTdHQ1MkthQmlKVFhLTkVvdHEwUVpDbDhDUnp2NXIyV0Zz?=
 =?utf-8?B?cnZ2VXpFR0tqbGJONVhEWU5ubTZaRzMvM3lrUG5Xb0x5SnZnYk0wL2VxSy9E?=
 =?utf-8?B?MTB0M3dNNm9hMHlBblkwUytaVm43WGd1ZHluUXRHQmtHTkwwSzZWbmhNTnc2?=
 =?utf-8?B?amxxbXBuUnFtaEphRDVWcDVpeGtjSi9kaE9mb3VIWGhOWUxuRTNaUWdWVkVv?=
 =?utf-8?B?a0VRelA3ODRycFZobkIyVUpYR3BjREpOZU5tTHdReWVyUVErR2FJSnBlZGt4?=
 =?utf-8?B?dlpjUzk5cjdCSUs5RnJsemlCODZEM0xCOS9wWk43d1p1RnB0SGpOTTlkV1Ew?=
 =?utf-8?B?SjhPdVM5TVZPYSt4S2ZLbFp5NFNVd2ZiTGVTdXVySzN0MnNXSEgwOElxM3du?=
 =?utf-8?B?UndRN1RlWnBDT0hES09zTTNsdzNCR1N1SEx4QUROYlFVK09RdkpTTUtIbzRj?=
 =?utf-8?B?LzV4R3VvMHR4OUdRcmd6Zm5DU3paOXJuU2NacVlzMElQYytPUmRkcW40RDh3?=
 =?utf-8?B?SVFMYkF3RWM3Q0NsS2cyL1lRVHVsM3MvZXVydnl5cW9tbGM2ejJaRTAvVGVH?=
 =?utf-8?B?ZjVXNHd4WHVJZm5YVHFwMHQybDh4cXZ2Q05VRFNyRGZYS1Rha1pxRG43bDFa?=
 =?utf-8?B?YkhMOWQyb3ZMYnovdWk4RVREcmswWkpxSTNBSS8vSTI1ZHZkYkgvNTN5MWdY?=
 =?utf-8?B?RW9sM2s3V0NXYmhEOW1jZjRVOHlYTVdjUVNMazZTZFA4WnBVUHJFZHcrTUll?=
 =?utf-8?B?c1hoQVlKa01rQ284VE5wblhBM2x4dG5sWTByRG1iTlF5TGkwTjNHRzZqdWZQ?=
 =?utf-8?B?b0lZcERKSnMwd2pYV3hScUh2L1BwajNjcG81bVhseE1WbngrTzFtUmJvUDNr?=
 =?utf-8?B?ZFBuQVJERnVzd2xEWkNzU09YRHAxMjNyaUxoRTZ2KzlaQ29wQU9IR3J4Ymgy?=
 =?utf-8?B?ZE1admE3RTlPOWt6eGxZdk05VDA5WkhvZGJDbXVFUnUwbjFxUWdIS3VCOGd4?=
 =?utf-8?B?WjJwOHlVR1pQeTNqQmVjNTFwYmFCc0ZPWlRwL3l5WG1sd1c4MG1qaS9aajRF?=
 =?utf-8?B?WFZST2VKTjY0ZkE0YkIyempGVHFHTTg4djRZU2s4Qnl1ZTNBeGRPbEFNeWtD?=
 =?utf-8?B?L3E3RWFLZm55THU3UlNXa1drdThDRkZmM3Vyb1JjalV0Z1owR041cmZHZVRy?=
 =?utf-8?B?ZlNqclhrSGlNOGVWQWx5OVFvajd6RXJPVzRwQlBhQ0dYZy9jSnRaS3hVdnBa?=
 =?utf-8?Q?S6UlroJEeaLtvAzfapUI1UXfK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1b3c56-a6f9-421b-0aed-08de16d7ebf7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8224.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:42:56.9229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gExt4poJ+de8raCRhZUnOAP34B7Wm88ipzOToQi8e2UmzsehUJeeMky2vbQyx7DvguF+/d9SyqU2XQu+W1vXow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7129

Any existing MACsec configuration should be restored when config_init is
called.

Signed-off-by: Andrei Botila <andrei.botila@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 123 +++++++++++++++++++++--
 drivers/net/phy/nxp-c45-tja11xx.c        |   3 +
 drivers/net/phy/nxp-c45-tja11xx.h        |   5 +
 3 files changed, 121 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx-macsec.c b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
index fc897ba79b03..39071abe31bc 100644
--- a/drivers/net/phy/nxp-c45-tja11xx-macsec.c
+++ b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
@@ -180,6 +180,10 @@ enum nxp_c45_sa_type {
 };
 
 struct nxp_c45_sa {
+	u8 key[MACSEC_MAX_KEY_LEN];
+	u8 salt[MACSEC_SALT_LEN];
+	u64 npn;
+	ssci_t ssci;
 	void *sa;
 	const struct nxp_c45_sa_regs *regs;
 	enum nxp_c45_sa_type type;
@@ -463,6 +467,18 @@ static void nxp_c45_sa_list_free(struct list_head *sa_list)
 		nxp_c45_sa_free(pos);
 }
 
+static u64 nxp_c45_sa_get_pn(struct phy_device *phydev,
+			     struct nxp_c45_sa *sa)
+{
+	const struct nxp_c45_sa_regs *sa_regs = sa->regs;
+	pn_t npn;
+
+	nxp_c45_macsec_read(phydev, sa_regs->npn, &npn.lower);
+	nxp_c45_macsec_read(phydev, sa_regs->xnpn, &npn.upper);
+
+	return npn.full64;
+}
+
 static void nxp_c45_sa_set_pn(struct phy_device *phydev,
 			      struct nxp_c45_sa *sa, u64 pn,
 			      u32 replay_window)
@@ -485,15 +501,15 @@ static void nxp_c45_sa_set_pn(struct phy_device *phydev,
 	nxp_c45_macsec_write(phydev, sa_regs->lxnpn, lnpn.upper);
 }
 
-static void nxp_c45_sa_set_key(struct macsec_context *ctx,
-			       const struct nxp_c45_sa_regs *sa_regs,
-			       u8 *salt, ssci_t ssci)
+static void nxp_c45_sa_set_key(struct phy_device *phydev, struct nxp_c45_sa *sa,
+			       u16 key_len, bool xpn)
 {
-	struct phy_device *phydev = ctx->phydev;
-	u32 key_size = ctx->secy->key_len / 4;
+	const struct nxp_c45_sa_regs *sa_regs = sa->regs;
 	u32 salt_size = MACSEC_SALT_LEN / 4;
-	u32 *key_u32 = (u32 *)ctx->sa.key;
-	u32 *salt_u32 = (u32 *)salt;
+	u32 *salt_u32 = (u32 *)sa->salt;
+	u32 *key_u32 = (u32 *)sa->key;
+	u32 key_size = key_len / 4;
+	ssci_t ssci = sa->ssci;
 	u32 reg, value;
 	int i;
 
@@ -503,7 +519,7 @@ static void nxp_c45_sa_set_key(struct macsec_context *ctx,
 		nxp_c45_macsec_write(phydev, reg, value);
 	}
 
-	if (ctx->secy->xpn) {
+	if (xpn) {
 		for (i = 0; i < salt_size; i++) {
 			reg = sa_regs->salt + (2 - i) * 4;
 			value = (__force u32)cpu_to_be32(salt_u32[i]);
@@ -1205,10 +1221,16 @@ static int nxp_c45_mdo_add_rxsa(struct macsec_context *ctx)
 	if (IS_ERR(sa))
 		return PTR_ERR(sa);
 
+	memcpy(sa->key, ctx->sa.key, ctx->secy->key_len);
+	if (ctx->secy->xpn) {
+		sa->ssci = rx_sa->ssci;
+		memcpy(sa->salt, rx_sa->key.salt.bytes, MACSEC_SALT_LEN);
+	}
+
 	nxp_c45_select_secy(phydev, phy_secy->secy_id);
 	nxp_c45_sa_set_pn(phydev, sa, rx_sa->next_pn,
 			  ctx->secy->replay_window);
-	nxp_c45_sa_set_key(ctx, sa->regs, rx_sa->key.salt.bytes, rx_sa->ssci);
+	nxp_c45_sa_set_key(phydev, sa, ctx->secy->key_len, ctx->secy->xpn);
 	nxp_c45_rx_sa_update(phydev, sa, rx_sa->active);
 
 	return 0;
@@ -1295,9 +1317,15 @@ static int nxp_c45_mdo_add_txsa(struct macsec_context *ctx)
 	if (IS_ERR(sa))
 		return PTR_ERR(sa);
 
+	memcpy(sa->key, ctx->sa.key, ctx->secy->key_len);
+	if (ctx->secy->xpn) {
+		sa->ssci = tx_sa->ssci;
+		memcpy(sa->salt, tx_sa->key.salt.bytes, MACSEC_SALT_LEN);
+	}
+
 	nxp_c45_select_secy(phydev, phy_secy->secy_id);
 	nxp_c45_sa_set_pn(phydev, sa, tx_sa->next_pn, 0);
-	nxp_c45_sa_set_key(ctx, sa->regs, tx_sa->key.salt.bytes, tx_sa->ssci);
+	nxp_c45_sa_set_key(phydev, sa, ctx->secy->key_len, ctx->secy->xpn);
 	if (ctx->secy->tx_sc.encoding_sa == sa->an)
 		nxp_c45_tx_sa_update(phydev, sa, tx_sa->active);
 
@@ -1597,9 +1625,60 @@ static const struct macsec_ops nxp_c45_macsec_ops = {
 	.needed_tailroom = TJA11XX_TLV_NEEDED_TAILROOM,
 };
 
+void nxp_c45_macsec_link_change_notify(struct phy_device *phydev)
+{
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *secy_p, *secy_t;
+	struct nxp_c45_sa *sa_p, *sa_t;
+	struct list_head *secy_list;
+
+	if (phydev->state != PHY_HALTED)
+		return;
+
+	secy_list = &priv->macsec->secy_list;
+	nxp_c45_macsec_en(phydev, false);
+
+	list_for_each_entry_safe(secy_p, secy_t, secy_list, list) {
+		nxp_c45_select_secy(phydev, secy_p->secy_id);
+		nxp_c45_tx_sc_en_flt(phydev, secy_p->secy_id, false);
+		if (secy_p->rx_sc)
+			nxp_c45_rx_sc_en(phydev, secy_p->rx_sc, false);
+
+		list_for_each_entry_safe(sa_p, sa_t, &secy_p->sa_list, list)
+			sa_p->npn = nxp_c45_sa_get_pn(phydev, sa_p);
+	}
+}
+
+static void nxp_c45_secy_restore(struct phy_device *phydev,
+				 struct nxp_c45_secy *phy_secy)
+{
+	u8 encoding_sa = phy_secy->secy->tx_sc.encoding_sa;
+	u32 replay_window = phy_secy->secy->replay_window;
+	u16 key_len = phy_secy->secy->key_len;
+	bool xpn = phy_secy->secy->xpn;
+	struct nxp_c45_sa *pos, *tmp;
+
+	list_for_each_entry_safe(pos, tmp, &phy_secy->sa_list, list) {
+		nxp_c45_sa_set_pn(phydev, pos, pos->npn, replay_window);
+		nxp_c45_sa_set_key(phydev, pos, key_len, xpn);
+		if (pos->type == RX_SA) {
+			struct macsec_rx_sa *rx_sa = pos->sa;
+
+			nxp_c45_rx_sa_update(phydev, pos, rx_sa->active);
+		} else if (pos->type == TX_SA && pos->an == encoding_sa) {
+			struct macsec_tx_sa *tx_sa = pos->sa;
+
+			nxp_c45_tx_sa_update(phydev, pos, tx_sa->active);
+		}
+	}
+}
+
 int nxp_c45_macsec_config_init(struct phy_device *phydev)
 {
 	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *pos, *tmp;
+	bool rx_sc0_impl = false;
+	int any_bit_set;
 	int ret;
 
 	if (!priv->macsec)
@@ -1643,6 +1722,30 @@ int nxp_c45_macsec_config_init(struct phy_device *phydev)
 
 	ret = nxp_c45_macsec_write(phydev, MACSEC_UPFR0R, MACSEC_UPFR_EN);
 
+	list_for_each_entry_safe(pos, tmp, &priv->macsec->secy_list, list) {
+		nxp_c45_select_secy(phydev, pos->secy_id);
+		nxp_c45_set_sci(phydev, MACSEC_TXSC_SCI_1H, pos->secy->sci);
+		nxp_c45_tx_sc_set_flt(phydev, pos);
+		nxp_c45_tx_sc_update(phydev, pos);
+		nxp_c45_secy_irq_en(phydev, pos, true);
+		if (pos->rx_sc) {
+			nxp_c45_set_sci(phydev, MACSEC_RXSC_SCI_1H, pos->rx_sc->sci);
+			nxp_c45_rx_sc_update(phydev, pos);
+		}
+
+		if (pos->rx_sc0_impl)
+			rx_sc0_impl = pos->rx_sc0_impl;
+
+		nxp_c45_secy_restore(phydev, pos);
+
+		if (test_bit(pos->secy_id, priv->macsec->secy_bitmap))
+			nxp_c45_tx_sc_en_flt(phydev, pos->secy_id, true);
+	}
+
+	nxp_c45_set_rx_sc0_impl(phydev, rx_sc0_impl);
+	any_bit_set = find_first_bit(priv->macsec->secy_bitmap, TX_SC_MAX);
+	nxp_c45_macsec_en(phydev, !(any_bit_set == TX_SC_MAX));
+
 	return ret;
 }
 
diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 87adb6508017..1abe062b05b9 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -1387,6 +1387,8 @@ static void tja1120_link_change_notify(struct phy_device *phydev)
 		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
 				   TJA1120_EPHY_RESETS, EPHY_PCS_RESET);
 	}
+
+	nxp_c45_macsec_link_change_notify(phydev);
 }
 
 static int nxp_c45_get_sqi_max(struct phy_device *phydev)
@@ -2106,6 +2108,7 @@ static struct phy_driver nxp_c45_driver[] = {
 		.get_sqi_max		= nxp_c45_get_sqi_max,
 		.remove			= nxp_c45_remove,
 		.match_phy_device	= tja11xx_macsec_match_phy_device,
+		.link_change_notify	= nxp_c45_macsec_link_change_notify,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1120),
diff --git a/drivers/net/phy/nxp-c45-tja11xx.h b/drivers/net/phy/nxp-c45-tja11xx.h
index 8b5fc383752b..30a1312e22db 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.h
+++ b/drivers/net/phy/nxp-c45-tja11xx.h
@@ -32,12 +32,17 @@ struct nxp_c45_phy {
 };
 
 #if IS_ENABLED(CONFIG_MACSEC)
+void nxp_c45_macsec_link_change_notify(struct phy_device *phydev);
 int nxp_c45_macsec_config_init(struct phy_device *phydev);
 int nxp_c45_macsec_probe(struct phy_device *phydev);
 void nxp_c45_macsec_remove(struct phy_device *phydev);
 void nxp_c45_handle_macsec_interrupt(struct phy_device *phydev,
 				     irqreturn_t *ret);
 #else
+void nxp_c45_macsec_link_change_notify(struct phy_device *phydev)
+{
+}
+
 static inline
 int nxp_c45_macsec_config_init(struct phy_device *phydev)
 {
-- 
2.51.0


