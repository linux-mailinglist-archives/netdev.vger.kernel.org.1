Return-Path: <netdev+bounces-234090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9AAC1C645
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA51E4E2638
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E0534A764;
	Wed, 29 Oct 2025 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="t7asOzPs"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012018.outbound.protection.outlook.com [40.93.195.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FBF481DD;
	Wed, 29 Oct 2025 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757833; cv=fail; b=MWV57PedN5twuqlGn93Oxq1nmxYCUGHlV1+pSyoH9SfCAhbLA28S6iT/UuwgS8QYyp+NwVvOms9vsUtjHwHRO3C1n6zhmKIh8Lz7ZdK+qhrJvUEPpoNOm2/wMstdwh8YNR6LtYL+VNvUXRnP74zbIf337ljVsoa6x5jFlGhttBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757833; c=relaxed/simple;
	bh=jrh/68Pe6mY0yHVnjPnRF6u7LZ2vKYDC9jRBPFmNtqw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rqDjIdkDlXPCt1rQvmsARt59H28eK1Y6JD+9EPUjO65Q43+g1d8Z9Cph8tyUn7lIjDp0SlIMTV44mPtF4MiJ0Cd7TmbRY+yXQ2J3fyU9A+OqvNuRaOoaXnvY5w4a8a2f6DRA21TJK6MLToN1lkFlLqQmnSwC7GA7OhyR4VltiyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=t7asOzPs; arc=fail smtp.client-ip=40.93.195.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBQ3crDUb7Y4jjJvNcoScEYiDbG07ry1yIeqmkVq6gaGzsDKCuO0qSPQKLVFJdjmgH2oPoCko/GR/lho25MhoBs5d+Tzfusk6S9OFaGZT9c7vR98ADbS8Bt8hnTaY2zsyIKcqW9dRJecZbj/2QCRbXK9u3Gz3bEiXptpnP/zaSQtbNgpRxEe+1lZrOVaVF/y7FOTtiHJ7DoW3actuEpXbpFGaSRf/lIBwFqGTkxlWymuo1coktOdazM0/Ir+apBvl+Lc4q46RudVhaOk0c2jEvUqMPdCBby6RjY2OIGk2i6LTxkZemkEbkpFezv4e3NrBCrikNabDI8ic3oX9tt0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOMngDa82g8PCX+hefdWHis2Q+BcWshtsu6GQDSeXY0=;
 b=kFkfZbGhIPC0Re5ePiUDu05fVByEnjvbBZ5te9+TAvxNSffdFcoSbSYtAumIvy4HDJZ/gJZP44nPhGzoLLUmR3C9xDYA+DjnTigrYIa/kYIgwTcJu4H5B+qrVzxjM3zgm/CR5pJdk9Y4RFTxKbqPAV2IHyiaqUMmcH/en6wGXJz8P9oS3gGZk1iNdfgxYU7INDfDH8ag8E1rQnQHAMexb8WfTOa4rdtUx5v57S1BJ4EEgGzaMd5eKlMkwzTnlCaRVrURtJlATi6QvRq+jXX81BGzuOP4fCgXoNELMoYVbA7343e2HqlRiSABYa4Ov214JElvF0kLd5fbfU5fJr+b2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOMngDa82g8PCX+hefdWHis2Q+BcWshtsu6GQDSeXY0=;
 b=t7asOzPskhvH/D9ryqlWFt9Wto8cIiI95Vf3CMoCb2I3GOcuQLd+ZM9VrcP0SKgKMutL0qCPfalzENvEW9fnZbRwTtfy6NsQeqtPeHAp84s8xHV1aRxsaoCvkJFuMAb6H5j6kDgdkQ7EX2K0htgs2oRqC2rRxMYyzdJ/VVROlNjNAKsC5hvN4+HVJa0cbpAL6EwkdAprWDw9ABoyOckkoQm6LWps4FpEPcSOFCg54f10lmo2J0ePL2i5/eH0tcY0PkW4eAxsBrwW+QP2ntb0ab1k+ppky+gBmC3i2yenoKy/Ry5zkAY7pbj4XxBNHgMZl/V9ivIjKv8EZcpNSqP9PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by MN2PR03MB5360.namprd03.prod.outlook.com (2603:10b6:208:1e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 17:10:28 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 17:10:28 +0000
Message-ID: <90624259-de59-489a-a121-fabbbe83c773@altera.com>
Date: Wed, 29 Oct 2025 22:40:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] net: stmmac: socfpga: Add hardware supported
 cross-timestamp
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251029-agilex5_ext-v1-0-1931132d77d6@altera.com>
 <20251029-agilex5_ext-v1-4-1931132d77d6@altera.com>
 <07589613-8567-4e14-b17a-a8dd04f3098c@bootlin.com>
 <ed9e4ffb-3386-4a22-8d4c-38058885845a@altera.com>
 <d4b1c65d-17d2-4f41-b559-9cae55993f6e@bootlin.com>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <d4b1c65d-17d2-4f41-b559-9cae55993f6e@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::6) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|MN2PR03MB5360:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f027fbc-7d88-4957-9b89-08de170e0ecc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmcwSHkyUFdDRVVjb25FYnYyVlBiZkEydUx3MjZ6VWEyT3haeEtGRm0xUzY0?=
 =?utf-8?B?QUJ6Zm1lL2gyRFFrVlNTUHRzb0Q3dDRIbGFiTi9OdU40cGY3MkdPcHpWVncx?=
 =?utf-8?B?c3Z4bGxJaHUzVmRNdkpZNExoZzgwZ1V2Skhxejd3K1VPR3dQWmRIM3pMMzhs?=
 =?utf-8?B?YWdnOVJWVWhiZWpDK05aSEczd1F1TEM0VDZFdlZNeE9Tajk5OFUwSWI1Rjdw?=
 =?utf-8?B?b3JQN1ZpMGwyckZOSU1PaHdYUDVibW5yTmgrbFZKa3dmR2JSL1lJYUVoTFlk?=
 =?utf-8?B?alZXSHpXSHJPR1pseDk1OGUrUWJVMFB6NHZRcHd1dnc0enNra0JBamxrbE1H?=
 =?utf-8?B?NGlmMGE2V3RWTllhSlVQbkhqTGUzMEtjS0lUZ3pOK21VQnRIVTh6elJGOE5Z?=
 =?utf-8?B?NTFUdFpyTGdoeWNLZVdYSm9LSTNHVVVSS0VVdzZnQVRrOE92Z0toUXVwSEln?=
 =?utf-8?B?QytNeUdIREdPV2p2OHRtSS9mTExseTZOK1d1aDZFSWRuemtmSWVSei84bmVS?=
 =?utf-8?B?bkRBTzFnYXlOK1dDZXF4MHE4U1Vac0NRcTYycHdWcXNnUGFadTJyR2wwQTFw?=
 =?utf-8?B?eW9FZVFOK2Z4YTViMkticUFRbERpcCtZV01mRXNoYWx2OWpvMUV6NEZ2Witl?=
 =?utf-8?B?eHFmMzJHazRlZUxQeW05Y0l4QSs1NEV2WXRqRjZ5OE4veVlodzlyZjdnNjVr?=
 =?utf-8?B?M2NxR283UVVUUTZPMElUL1NTZ29uZkVmRkpCanJQeGJueUVZNkwzLzgxdS85?=
 =?utf-8?B?UXNveTJyQlNqckQzVnBIdEJUTE80YWpuZ2pTYytNb3RHVGNOSmUzd1UxTEtF?=
 =?utf-8?B?Qlo5dnloSUt1emtLSE1aTncwd2IzU3BlbS9NSi8rdVZpVmJENmFxRWZxWlJR?=
 =?utf-8?B?NVlNdjZHeUY4T2lUZjlwazBwN2VMK0g0QjRVVms3Nm5vOUpZcUhXVkEvdUlL?=
 =?utf-8?B?TUlCYnF6dmJSdi9IRGU2OVFFREFObkNkM2FkOWNHeUQ5Y1BWZFd3ZW55K0ZW?=
 =?utf-8?B?WTFzeHlFc21VQTMveFpaTTVJQUFYN2RJWWxpUm9yK1cxOWpqR3VVWUtieWhE?=
 =?utf-8?B?eHorN1g5WGNWZG5hdXhxQlVER3lXdEtMMzhBWWoxeHBUVURsSXh2azVyeW96?=
 =?utf-8?B?dm1LOXFkbzEwc3R6TTZYdUJ3T2w1dXlvaDNSdWh3MU9xODlZcjlSTGI0bjdP?=
 =?utf-8?B?WFdUaVRJNnBRak5xaVhLSFFuZ1FidzZEMHltWnJBaEc0RHV2V21uVW1vcnV0?=
 =?utf-8?B?TDhXWkNQMmtROWUyRENPaW0yMUN6cTFnL0JuZ2V0MWVuRE5aMzQzanVrVWlo?=
 =?utf-8?B?dm9NbzNTQWU5MjI2NElpcm1nNHVTRUxmaXVLakZtc0k0NmY3WDZFVnk2MUFl?=
 =?utf-8?B?amFXdkJIc1J4b0pGMlpNMGUrVGJ6QlZqbGJhdUUxc0h2eDNyU2dJREtRTEla?=
 =?utf-8?B?T3VLWU9DOFM5MUNJM25HWGZhdzJiaDJsYjYxSFl6Y3RRYlpXU1JoTCtjUnRu?=
 =?utf-8?B?MnJiVDFNWTIranNWZGNCTjVtNU5CRHdBeGk5eGc0QmpseWlVWTEyTmVxeUlB?=
 =?utf-8?B?UUlBZmNMR3VMd01Ca1BkalBjK293RmlpNS9xRFZKbHZPSkNWMU5sREtFbnlw?=
 =?utf-8?B?UERhb0NXRE81U3VKS3AxSy9TUVVQbXZuT3NjVk91c0ZMOFJEaEZyK3ByZXFu?=
 =?utf-8?B?VG5rOVJDbVlqYUxxOUVpd1FoTno5VFRkciswZ2l6RW00ZnhYNnNjL3BXMjNF?=
 =?utf-8?B?QXpjbW1PQ2drc3ZvRk9UNFg0dk5RNlhwVmx0azk1c1JRVHhOS210dDRHVzEy?=
 =?utf-8?B?bUdUV1kwOG5NbkswbzNiVk1sUjg5YkszZlAxZlFvRHh5UTR2Q210dDh6aEph?=
 =?utf-8?B?V2ROQkdrS2Q4bDhpTEQyYWg0Zjg2OWpsUCtud3lKN3VuVE1vSHJsQjZRSmg2?=
 =?utf-8?B?RFIxdnFvM1VQMkY1UFhXUWtBQ3B4SnlFK1ZFVU1IV1JYZmIrWEMxUDVJOG1V?=
 =?utf-8?Q?DEFIpNcKNbS4PsyjLb437dOiyYYcAU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHJvNlF0cUFWUjY3WVJCTzBET2xwUDNyN0JmMzh0Vng3V2JOK1BiNXlrbVlN?=
 =?utf-8?B?L2M5Q3YxNURvWWJsbDlXRDQzcFcrdklQSzBBRjA3K0pDeUJTWlphWnhoTFBF?=
 =?utf-8?B?ZVZGUDFYOVpUSkpEUk1MNmMwMStGbnYvT3ptUnA5KzFUL09ONFVPZTBSL1Ra?=
 =?utf-8?B?STl1TVZiZUluRHYrSFBiOUpiTVR0T1Q2aUFNV3JqbGpXZG1zS1VYY3N6L1hw?=
 =?utf-8?B?ZXNnUmM5NTk4V1NtMVk3UDNnbzdSQ0lwMThGQXF0WTVzcnprbnJDci9ObFRu?=
 =?utf-8?B?MVhWT1N2UlZDK0U1UlBmM2NsUlhTQkEwTHNEZnlhTjU5QitNa2lpbjQ1Y1Fy?=
 =?utf-8?B?blFQMDRUdkNQQ0VzZWFHUm80NktDOVRZVkZKSklJQ08xcUZxdnJDVnMzY1JT?=
 =?utf-8?B?Nmp1T0xkVFpmYnZhS3FGamk5TjFFazFiNTN4aS9oSnk4WlJkOStJRmE0dTNH?=
 =?utf-8?B?b3lnc0tBQVdEQ3pRZnB4RXdKY2JLaDlocDhpWm51MUdGOU1tbHJSaGVwQXla?=
 =?utf-8?B?eWdONFoxc3UwVTZXNW9hMHdFOWpLNjZmaDgwUmNPMko3OUFBMUxHMWUvK3VB?=
 =?utf-8?B?VDBmblVCcFRUYXhGaTcyNFd0aGdSNHBnMDdiWUJPT3JHV2oyeWZQdkRWNU5k?=
 =?utf-8?B?MmZkN2NGQVRudVN0Q1NDVWVONnY4YjJBRkw1MFR5VGNBRDhadXZtUlM5b0p3?=
 =?utf-8?B?SnpHUVcwalZFSzVWbnZBUHFvMmJHZWg4S3hQNXFaWldoRm9xYWNPdmZndGF4?=
 =?utf-8?B?dEdrajAzVXcxU1RReVBNcDlWUjBmN1ZUNUtESkhmVUxYRm1HaXNmZllRRzVV?=
 =?utf-8?B?eVp2aDM4aUJ6eWZjNlF0RExDUkU2a1ZPOEY2amJiVjZuTFF6aU1qbTd0ckJh?=
 =?utf-8?B?OHpJaW9SSnIvd3c5VDBnNjkwb09pVUE1Q3kxK0lXcGFRUHpGTUE1Ymxvd0RE?=
 =?utf-8?B?RkYrdlNTVVZVZlVTSnA0N1lIQ1I2MElDMkNyNVZueGVVZ0hVby82b2JkdFBl?=
 =?utf-8?B?NE5FTmpSTExxRUVZQmVBaVpscEcvZXhGVjFMYWpLcE9NUG9oS0hDZ0ZDckZK?=
 =?utf-8?B?Zm1PUGltYldFdURQZXNXWWFwVkxFL3VxeXpMSjB1QnNiRExLN3E2U052VUV1?=
 =?utf-8?B?TG9xL1ZGQ2l4SFdXRmVIUWFQbnFZVWZtQVpucmhEMzVRbHNqVWxIcEtjNUpX?=
 =?utf-8?B?M01RWkxLY3BiUys0WUFVbGNOeGtCdXkwZS9GRGxWTER1OHRodFBRb1UxOHoy?=
 =?utf-8?B?dDhiZDFEU1YvbzB5MUxZQzM3dXYxQ0tvTk4xcWxUeHRSWHVUbjQ0ZzBSVndy?=
 =?utf-8?B?b0N1MDMrMkpUdHdxRGlocEpiY0xUYktHZDdqdDBzNkk3T3l2QUMwa3RPbEtS?=
 =?utf-8?B?S05BR0JSVmhmYktKZVM2SHBRK0VVVUNGYnJabmQ4cmtWYXl5b29ORDM1ZWV0?=
 =?utf-8?B?cllDd0N0aFZWSlVPK3ltZEp0VE5NQUxWclJXTjhiUDVrM2dqQ0xlMXlGVkF2?=
 =?utf-8?B?RHN2TFcwZTdrMUh5MDIvRCs3RDJCN0hncUVqN2pBL0hQV2J4MWtLM2tUK2xC?=
 =?utf-8?B?TXlVNDZNUVgvZ1N1RENpZFhJUUlYcEJlMkZvY1dQbzhoZERvYjhkTktjRXB3?=
 =?utf-8?B?UmV4cWw4M0FyM3VwdnNNRktNVGV0ZFpBS1RnMzVhOXRCOFRTeEZLWWZ2OC9E?=
 =?utf-8?B?L285QkVyVi9VZlh5TmlVUUxvdVBCZFVna083K2daZXg2cmNwTWRkNWswWlh5?=
 =?utf-8?B?YU1DaE1HY24xT00yallnNnhQM0NML2RwMzFLSFY0eUlPcE5xUG5JZnp6NTRZ?=
 =?utf-8?B?Y1ArTnM3WGVNL1JzcmhmQW1QVVYvMXMzbHJ6VjNKTUdVaVI2ZXhPRGdidjBN?=
 =?utf-8?B?eWdZZytFZWduRVRCNy95bTVTTWxxZ24yTk9seCtPQWZCK25zcE9rOFFIbEFN?=
 =?utf-8?B?aVFlMi9jN3NscjFmejRBcTBPOVpoU0FzMEpFTmpCUSthaDN2QWEwWTNHQ2s1?=
 =?utf-8?B?NmtGUlN4Y2NId1pwdG5Wb0k3bExVTTdzbXUyWldVMHl5RVRjKzJQekQwa3B2?=
 =?utf-8?B?RjExZERIVy9Ed2RKaTFQMm8yRHdQRyt0aFlXSWFLalo3R2dCZ0hDUjRuS1Mr?=
 =?utf-8?B?NjNYbHlxN1Q4bUpxMW1RY1lQNktKZWFxd0RHUDFYZ21tOVd1eFJDZVJVbWlv?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f027fbc-7d88-4957-9b89-08de170e0ecc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:10:28.2871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vN4VLyp2GfLD06+6VcmatMIHTzpnQSfWL0muoW/eAKC6v3O8Sja4KCETSlQn5XEW5dBdk46p6k9DGKOYtPquDHh16AWDQ8KxH74i263+gzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5360

Hi Maxime,

On 10/29/2025 8:36 PM, Maxime Chevallier wrote:
> Hi Rohan,
> 
> On 29/10/2025 15:41, G Thomas, Rohan wrote:
>> Hi Maxime,
>>
>> On 10/29/2025 3:20 PM, Maxime Chevallier wrote:
>>> Hi Rohan,
>>>
>>> On 29/10/2025 09:06, Rohan G Thomas via B4 Relay wrote:
>>>> From: Rohan G Thomas <rohan.g.thomas@altera.com>
>>>>
>>>> Cross timestamping is supported on Agilex5 platform with Synchronized
>>>> Multidrop Timestamp Gathering(SMTG) IP. The hardware cross-timestamp
>>>> result is made available the applications through the ioctl call
>>>> PTP_SYS_OFFSET_PRECISE, which inturn calls stmmac_getcrosststamp().
>>>>
>>>> Device time is stored in the MAC Auxiliary register. The 64-bit System
>>>> time (ARM_ARCH_COUNTER) is stored in SMTG IP. SMTG IP is an MDIO device
>>>> with 0xC - 0xF MDIO register space holds 64-bit system time.
>>>>
>>>> This commit is similar to following commit for Intel platforms:
>>>> Commit 341f67e424e5 ("net: stmmac: Add hardware supported cross-timestamp")
>>>>
>>>> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> 
> [...]
> 
>>>> +	/* Time sync done Indication - Interrupt method */
>>>> +	if (!wait_event_interruptible_timeout(priv->tstamp_busy_wait,
>>>> +					      dwxgmac_cross_ts_isr(priv),
>>>> +					      HZ / 100)) {
>>>> +		priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
>>>> +		return -ETIMEDOUT;
>>>
>>> Don't you need to set priv->plat->flags |= STMMAC_FLAG_INT_SNAPSHOT_EN first?
>>> Otherwise, timestamp_interrupt() in stmmac_hwtstamp() won't call wake_up()
>>> on the wait_queue.
>>>
>>
>> Thanks for pointing this out. My intention was to use the polling
>> method, but I accidentally left behind some code from experimenting with
>> the interrupt method. While reverting those changes, I missed updating
>> this part of the code. Will fix this in the next revision. Sorry for the
>> error. Currently not seeing any timeout issues with polling method on
>> XGMAC IP. Also some spurios interrupts causing stall when using
>> the interrupt method in XGMAC.
> 
> So, if you use the polling method, this will likely bring this code
> even closer to what's implemented in the intel dwmac wrapper. Is this
> the same IP ?
> 

AFAIK, this is an Altera specific IP. Altera was part of Intel and may
be the SMTG IP implementation was inspired by ART timer on x86 platforms
:). But for later platforms this may diverge.

Also, latest intel dwmac wrapper is using interrupt method.

> To me it looks like the only difference will be a few
> register offsets (XGMAC vs GMAC), some clock id and the mdio accesses,
> maybe it could be worth considering re-using what's been done on the
> Intel side and avoid duplication...
> 
> That could be all moved to stmmac_ptp for instance, using some flag
> in the plat data to indicate if cross timestamping is supported, and
> use the core type (xgmac, gmac, etc.) for the offsets ?
> 

Since SMTG or ART is a vendor specific IP, I'm not sure it is good to
move this to the stmmac_ptp. Also, not sure other ways (other than mdio
acess, gpo toggling) to implement hw cross timestamping. Open to
suggestions.

> Of course with the risk of regressing dwmac-intel.c :(
> 
> Maxime

Best Regards,
Rohan


