Return-Path: <netdev+bounces-128857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A92597C091
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 21:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2156A1C210F1
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 19:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED53A1C9DF0;
	Wed, 18 Sep 2024 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gOzCvwjK"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011067.outbound.protection.outlook.com [52.101.70.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01A412B17C
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726688129; cv=fail; b=TsglOw8FH+b2Eu7nZiFCNdaU5CqWdat+vCgQACWugzFd1ienqdlilAJC6gjt+v2esNqSM3XImvl6xferV0Wpi4rRRdr3+UOwPKSMhnBTCLxPeZX+bC1dvzrWxxlly3dRnSAl3R8VfkuGHE5eHPuAa1/emlAfvcGPh3nD64DuPaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726688129; c=relaxed/simple;
	bh=fPWUNxuGy4UY04VMPQxUDrsxfTGQt2RFU7ZV3UMrltE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PYpXHdIaY5FRCyxYt3AKlqQfCtjOa/1hVvp5o6EjFVM36bjXaYvzJClonG73oi2WjJwtavNluL5xp8jaFG+sRu+3wkQtcgo+sx711Ts3xPibwEqGiKI20cpNGiQ4Pfw4KlIswbg+UWPB7b0ZpcrZGtWzbpmGQgzWddZE24JNbbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gOzCvwjK; arc=fail smtp.client-ip=52.101.70.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDyEJ/XZQTIQgmKj+EXUFFdHUn6IgBnYZFxKc9ZZiL4DU/TSg4qdW7464In7MSiH59cXJuCziF5vgFcqniNpBY4sf255MZWSQyxUMrKh5LpUb0SV9eC4TBhqfvSWxkvoBsyeBi0kE2J4PZkOJuCMAWzK5quOpq8dkF76h4KBXMXJCu5MV32GtFT3rUKFYQRnCMfofjzWrKNGjiYb5aa2rkCRU5yfWdQg5SUTrtjzb/BNJwcY5uYsL/3MdnkVqaVCIQ71YbW8QGgu6HiGYB/IbP1ZOdsFsUY2qca6jgDwcV2zc6fphsXb4606MOrCoFb2kMMuomHH8gh6k6xsljDeCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5/SM/0l1qlyf2sZmxs2dMvV6GRHGhExzB78rxEp9Jg=;
 b=q80lD84eNziV8KUT+H8qw0P4g06s3cAwyBRTNs3nWEwB9Bd9cJvMt6wXExO9MRFDsRhXm7hdYIu/koq6mM0Copq/9MOyn3q8oat565BrH8iy7esDfBkIuFgsqsDcnNLMZ+Mid3PpWm/+4SA6mR1kuJM3LCf/ja4NRDbqwGnADIFSFTRNGyRmOZlfVxTpb4SthBCO0FyLf+pmcHaIUp9eweiUzILvOz4ae9ZUZPI6C2m/zdyIy41zn6veCkGbrN+YQZ02v8JqduyQkqr6tVGPXDoSsItRM8A2+OVI54R3Z18HJHlXLqZ4ZvmJ0bCM+e8BcAhoTG2FcimiNRt3aQRwKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5/SM/0l1qlyf2sZmxs2dMvV6GRHGhExzB78rxEp9Jg=;
 b=gOzCvwjKOhNYSeOa/C1d8Jcwv5z5MUwiyP08EE6elImZYZGu3E0heO72ye9IBcP1AZ3VIzuvFek38Su19tTNRwR58eVWrNZhCxR71/5NMWNSglQHUL/6JAJNcZeQMNLQrdvBoOdYuu6qiGcRdLzXwQQNeWG4GcHDjiuPwJSKp4L4KY3fLYpLklC1U3gLlHL+P7DhuUQyeb+K4rQX7xM17d3D9t8qLpiGpLHBENI3bxH8eRTOAr/FliWa4ma1AxbKlMcP+gJNvZiUqM/XyO5YpFwFhMafbpnz/xSq8wDot8r895OYWmpTz5qEhltuev8w1ttSaskhsXeyxvJqXKJtRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by VI2PR04MB10764.eurprd04.prod.outlook.com (2603:10a6:800:271::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 19:35:24 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%3]) with mapi id 15.20.7939.022; Wed, 18 Sep 2024
 19:35:23 +0000
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
	Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v2 net] net: stmmac: dwmac4: extend timeout for VLAN Tag register busy bit check
Date: Wed, 18 Sep 2024 14:34:52 -0500
Message-Id: <20240918193452.417115-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::29) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|VI2PR04MB10764:EE_
X-MS-Office365-Filtering-Correlation-Id: 6750c744-e610-4099-1f3e-08dcd8190a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEUvNHNubHdBdXc2ZStSUHpGbGZaZ1BNRHFaSU9XckZTZzAxdjBCRHZCOWY5?=
 =?utf-8?B?ZDFtakRSUmZaTVBKd1VEd2M3WERTZGMzNzR0dGNRbXk5Q05WYnd1bWpOSnov?=
 =?utf-8?B?ZVgyM1JuYXZEcGViamsweTJiNktQdi9yQmNYZmdlVTgxU2tjN2hrWFR6UXBp?=
 =?utf-8?B?ZEs2KzVycXZ3VmR4Z2o1NVZHTUxXNjE4U2ZWb3VqUzhGSzg3UTZGNXQ2cU1x?=
 =?utf-8?B?ZlR3RDl4dmlGdVBSK3o2d21tdTZzaTFkbnNWdVpQNXBzZEZOWDR0dVJSYVJ1?=
 =?utf-8?B?LzJUYWNRZW9Pc0hDUmY1eXlaWVJZUHNTTHc2TFloNDhYK2lJbkhoclVlVWNu?=
 =?utf-8?B?ck1ham9DK2IwUmhlOHIrS3NYcEI0ZWdOZjBPVkJDeWRGZytCWGpUS21RSGYr?=
 =?utf-8?B?dlk3SHVVOERTdHpza2RNTGlRTTRkNmQ3N1NWQkkrRUpTT2lXazVCY0xhTmU4?=
 =?utf-8?B?SVc5bll5MkFFSWNOQnorU3JGMGR6bE1ydjVSTlN3U0JQZDJwNDVjME9lMnRT?=
 =?utf-8?B?dGtJMW9UOTIvZjZNMlpZLzF1SVJlR2wwSHJ0Ly93OXRPZzFPUURLTVZHWFdW?=
 =?utf-8?B?NitsTExnUzFtVCtiQVB3NXFidWd4VGhUc1dINlpxR0Q4YTU1SUFZNWdRRnc1?=
 =?utf-8?B?dG9NOGw2NjJYRTNQWjkrbFdMVHZTZVdjVWp2aWdnb2pJM3hTTGgvZWVPRXBY?=
 =?utf-8?B?elFocUorT0R2U1BCVTVCbmtZZ0xETnBGQWdrYnJ3UER4VmJkbVdaNjlBM3Jy?=
 =?utf-8?B?K0NZejQ4SjVWQXEwZXZlSlgxa1hSWnF4ZG9OeHdxdU90OXlXM2dIZ3JNM2Vu?=
 =?utf-8?B?QzlCU2NtZVFOVnprQWZqU1B6S2ZscFlHMlBjNnVMOXlMNFIyaGpld3kyTnZy?=
 =?utf-8?B?NzdVZ1RyK0pJdUMwUlN4bUcvdGxhQ0NDRXlMVkZ4YXMzVEl0VlpXUGYyVU53?=
 =?utf-8?B?bytkcFhMem1TWUN4NVFMbFBubXp6YkRUelZqSnY5R3VrOWZ5VjNRc09YdTVF?=
 =?utf-8?B?MVpqZTd2blAzSWVpazVmMlJEdzFKTEYyd1NMUm5FMzhFNkhsbjhkTklPd2Nr?=
 =?utf-8?B?TW5mT3BRbWNmU1FxQ0lFRFNYaXQyd1BjK3JhZDQrajBuNFdmM0YxY3JpZGlE?=
 =?utf-8?B?RmM1MVFiaDU4ekd5cG5KTnhyNnBIYWVrUVIvQm1BSU9ETnp5VmtOV3BHRFVX?=
 =?utf-8?B?dVYzOHpacG5qS0FQdk5rNjBac1ZHaU56cTUxc2R5VzU1dXIvaUdHL3pPVHdW?=
 =?utf-8?B?N3VFa1pPOGhKVXdmZmpQSW5aN3R1MHFmWHQ0UDRwckNVM1J4TGUrcTNJeUxH?=
 =?utf-8?B?MkVuMGpxamI5b0RmWlkwTEhlVUY3cnM3ejNxYUtuaC9uYXBpeE5ZQ0t4V3Fp?=
 =?utf-8?B?NU1LWG81cTI5RjdGbzBoclp5Kyt0Z2c1RjRQQUdzZ1ZXK3hhUkVoVW8vcjgy?=
 =?utf-8?B?VEdNVzVLZHRaejBKMnR1SktuSWdXdmdvMXB5bTdxcEdwVURKTXIwek9nL25Q?=
 =?utf-8?B?NktjUk53T0l0U0wzWXhwemd1Ymw5VXVTY05Fc2RHKythNE5teE1MNmY0UXFt?=
 =?utf-8?B?SjlpVkNrWm5oVVFrMjhOaEd4RlRGUHRZOE5sRUN4Y2p5UzROZ1pZVWtRQ0tE?=
 =?utf-8?B?S2N3ZEFHckdJMXJrOU9KMjVIZXBSVEJsUTZLWitPVmJBYU5HNisxSE5tRkdE?=
 =?utf-8?B?UlVUMDY1TTdHaHlZWTNjVk9xdGV1cGJsSGVYVlFnQyszbDZBdkdWTzFLamNY?=
 =?utf-8?B?YmoyWWZ5aXk2VVFWa0lQS25wUkJHa01BeUUrbzMvcTFUYXpQY3Mzb1Mzb1Mw?=
 =?utf-8?B?UGZYaU9odEpKcW5teHhUQ1c2ZnEyckk4ZTBlR3lsWHJDZnFjdXZ5TW9mRjl5?=
 =?utf-8?B?dVN1bXJybzdqM2Z6WE5uRVdlME9Sa09NSTVPVk5WQUx0Smc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTZSZXRxMzAzQ09Kc1VzR2xmT0oxOVNweVBKME91emxzRlo0VllEUWJwSXJR?=
 =?utf-8?B?NlVaQWNoV01qMWtyS296ZitCd09zdmJxSU1WaDFNeVZreGlZcDh1ejB2Z2Vi?=
 =?utf-8?B?azFlcTc1Ni9mVC9GWE1oZGtQRjFxYVljS0ZFRmNGVjdFbmVnaEFIdUU4Vi8w?=
 =?utf-8?B?NzNnY3BlWFJLdWdlbGptR0xFTHdLb3pOTVBpRHVZZkZGSm9TcllxdDl1N0J5?=
 =?utf-8?B?eEFaNUlYMjVidlMyYmw5VU5BdVUwTldDQ29iSnVncnMyUmtzTUdZUjNDNFhh?=
 =?utf-8?B?b3czZjcyMmdqK0pVM1Zkcm9waFlEL1U0czM5dUhLWnFndGR1d2RZODBzZnRP?=
 =?utf-8?B?ZzZqTkdieFdZV2Qwc01Fb1JPdzVObnAwcTErbUYzbGx0NGkrTWVjNGNNWXhv?=
 =?utf-8?B?YVlweVpib0prZ2dua29FU1NTeWFPbG8xS251NUVYY3AwbzZPWmFwbXQwRUta?=
 =?utf-8?B?RjhJSWRvaWJiSGFyb3kxRWFRYnRHT0VETCtKRnpRRkVJN2l5UUtxNzJ4S016?=
 =?utf-8?B?RXR3RU9HN1lzTXNQdm5zT2NnaW84WFg2aytrMnVDMnVzQUl4ZFJ6WFp3YjR4?=
 =?utf-8?B?YU1wTStFVGxvTEVGYTFNeEJYRTlOQUpHTUtsOEg3cFppTWRMejRkUnltYXZ5?=
 =?utf-8?B?clVZTmVUUldCeUpRTnF1V0M1ZzdacXppMVdpQ2xLcXBtU2pFRzZMZ1JZNnhw?=
 =?utf-8?B?czI5WFkzRjRMeEVrRUhEK1ZpYWd3dGZqRnJWNDI1ZTAyU0RraFVKTDEvR28z?=
 =?utf-8?B?ajdHak1ldVQyemw1eXMrdThlTno3bUo2VVVOTHp5c3dyL2ZndUFneHNSdXpF?=
 =?utf-8?B?b2JuQzlhMTZzbC9vZ2h2R1RaNHgrbnRjNmt2WXh2Y0IvT21kSlZYc1U5VXNa?=
 =?utf-8?B?VGtnekxBT1VCMWhaNmVxdXp2eDBhMitWVXRhSWU0bC8zMnZGcUJzU013a3E1?=
 =?utf-8?B?aFlDUWdqeXNoajBrMFJ4NVJCNnh3WmZZUWZWRWhYSUN0c0Y1L0dwT1c4R09O?=
 =?utf-8?B?bGVRRjlObG1ST01zZWFhVjFWN3dPOWJHVVJLSjg4TEVoalZjR09kL2ZLY2pD?=
 =?utf-8?B?bzlKWFBuZXZVQlNVQjZXd2MwMG9SY0tCVkV0K2RFUHdPMXhPSmt1b09QMCsw?=
 =?utf-8?B?SmYyL1FLMWI5QVlqdGdXU3cvSFVOdzhWc3NsZm02RVNRVEVKSmtOWHRkUS81?=
 =?utf-8?B?TGsvNFpwMDlqZHYxSy9Bcm9JeU96YWlyQ0gyVFFsVzVBWU5OUUVwVU9kSDdw?=
 =?utf-8?B?OUFoUG53MzlLL1ZWZUFGMHdDd0lXd09zcHV2aStkYzl2dWtudWdUUGVBcWQr?=
 =?utf-8?B?SVptdDdaQjUvM3dZVmVNL211NTB1cUUxT2JHc2RVN1ZvdEFsSE5xQmgrSWp3?=
 =?utf-8?B?RDRFbTVjemZNVkJuMG00UEhrVldBcUVwQ2VkS3B1djJwYnJGb21TZzBBTWpz?=
 =?utf-8?B?ZFh3eXExcTUxc00yZzVKUHlqUS80Nm9mTTN0bGw1d2UwMFdjSHp0eVF0WEFN?=
 =?utf-8?B?cFliRGJ6SnRDWVEzYXJzK1RYbDRuWU5aQ3ZJVEQ5QWFlTkFCWDFYRW16NGxC?=
 =?utf-8?B?eDFkaGp5T1VBUWVkODh6Z0dDeUY0MDFxTEtkWTJvM2RPNTI4cHZHVW1DSUZx?=
 =?utf-8?B?Q0NZcjU1UHNtaFZra3Y4anFIU3dwZ0pCQmsyMUV5bkFwaGFmRjBxNGRvRTVU?=
 =?utf-8?B?OEY0Vjc3b241TEdLRFhpT1BabEVjL2VZVzZPdWtQNm54bzNPM291OWFaOS9Q?=
 =?utf-8?B?TzEvSWF1ZUdGM1pXY0NtN25XZU1qd09yM3lLRmd4MHNOVXpHWnZ6eXVQZWw0?=
 =?utf-8?B?d1hzeDZXNkhITjRacGxiUkhmNmpBVW11bklGOGF1ZW5LWnFPRkJjNHdZV0pS?=
 =?utf-8?B?UXQvU0ZGK1d5ckFHSzhwWUdGZ1BjczJjcDJlMXovVUxVZkpOSlpUVEZObi9H?=
 =?utf-8?B?OEVCZG81TU9GZ1B6M3M4OFJ4andGMmU0V0U4cWdsYUZBRUtiWHcvc1JTN3J4?=
 =?utf-8?B?aTN6N2FRMnA0bk05MWZkSHpIWjV6RVhqQklRb1pnQVFvVmx4OExlVGZRUVNL?=
 =?utf-8?B?ZnZJUmwrUW40L0hNNk15Q3FvWkxGWG5DdE4wU0hDMDBWaEFjVHNabkZZcTl0?=
 =?utf-8?Q?9hB0YvnQbIuxVlZg4CSA1Kchd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6750c744-e610-4099-1f3e-08dcd8190a17
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 19:35:23.7930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gRCBvQ9cEodzeJXxQiYIOLhLXR5/ElMNjj8/JbMPCCL6GB5aQ0ZMV53EzmiPPUPtcCsJ3NfZHVOZQmQs5FCtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10764

Increase the timeout for checking the busy bit of the VLAN Tag register
from 10µs to 500ms. This change is necessary to accommodate scenarios
where Energy Efficient Ethernet (EEE) is enabled.

Overnight testing revealed that when EEE is active, the busy bit can
remain set for up to approximately 300ms. The new 500ms timeout provides
a safety margin.

Fixes: ed64639bc1e0 ("net: stmmac: Add support for VLAN Rx filtering")
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
Changes in v2:
 - replace the udelay with readl_poll_timeout per Simon's review.

---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index a1858f083eef..a0cfa2eaebb4 100644
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
+	int ret, timeout = 500000; //500ms
 	u32 val;

 	if (index >= hw->num_vlan)
@@ -487,12 +488,11 @@ static int dwmac4_write_vlan_filter(struct net_device *dev,

 	writel(val, ioaddr + GMAC_VLAN_TAG);

-	for (i = 0; i < timeout; i++) {
-		val = readl(ioaddr + GMAC_VLAN_TAG);
-		if (!(val & GMAC_VLAN_TAG_CTRL_OB))
-			return 0;
-		udelay(1);
-	}
+	ret = readl_poll_timeout(ioaddr + GMAC_VLAN_TAG, val,
+				 !(val & GMAC_VLAN_TAG_CTRL_OB),
+				 1000, timeout);
+	if (!ret)
+		return 0;

 	netdev_err(dev, "Timeout accessing MAC_VLAN_Tag_Filter\n");

--
2.34.1


