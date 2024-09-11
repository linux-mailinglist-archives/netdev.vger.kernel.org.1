Return-Path: <netdev+bounces-127460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F1D9757A0
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757BC1F27FED
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2086B1AC453;
	Wed, 11 Sep 2024 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VyFQ69Ww"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF761ABED6;
	Wed, 11 Sep 2024 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069935; cv=fail; b=YFoM+QIF80GZ7Ax2FMApJfloAVnknXXkWGcEWSFPOAihvE34VMWsxVXG68nyViGdDdbhQTAW4ldUn+mRrIxzU8EowyGh66WD7kpOBrmwJXNbvwmJ2JqlV0UQg2ysPYJy2AM3xMtVPUFPbBwGSFzfYHSNkAQI2Zw3SLWO1BRREdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069935; c=relaxed/simple;
	bh=phFMPV8p8ajr1tMAb8AD35B2jbYFcQxvp7Um1WoZDQ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bn8KrUEmhfcn/jMBUEgFC8UtJH07xOtWFBOD9BURliTKVlkV1pJucuC6xxJwSEC+hG/L1HBu5tfeeEwsv0TAesTi2OWcVotk/ThQ02tmNB8VGttigqfdxieA7v6KG9NjF7209QjZT4DQBIJHp/2AAUFXGv0QGB+7l/FoMHR3xIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VyFQ69Ww; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAzWLcyQ9S2EAo48x/l3/Gh9LAaTvtC0A0LLYk8sNsCLxbRakGFe30vgTIpJIgrXEwB82ve2kk73xnuqkUwtcEihCJI0DJ57vgRZ2/F3Pp9Vj6viRQOeAJFGyx/01qdvVhjDZu7BgpN4DrunQ5xUESQ7Kw8FHIwlg7cqSXpqR4e5TwFt28lFqghPDyzjUSM6fP81guIMtG1xrAlh9qg9+0NlWiTL4+QK/Po2nesoawjyqIOXESsiBjtoVH/TC0BgmHpaiECtsWVDu/83sGui7JTVAfhfOfLkUY30z59oQfY7jXz2ppK9CIovPQBHLiUg0cnoOhy80dH/yQ5EKBLh+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKr0t5L4XQATlneixNpM5Fhjqt7ayELgA4cETYTJPyQ=;
 b=VOzVYWfZEHlnAS5MAuDtC+7ni7ooQ0q5vtGplDd0vUqz7W+1ap7QUCG7jBIog9y/2qjqZ1lWPTJgd8K9ikT5WcQ3mJhosi2WQ5RJh1EMzAfYr+Vt086HE1+oQHh157t1YpU+xJtikL9X5rykPOA5zqISrE1T5MDqgdDW0BD/+OAaakQHojV5zn0YOwNk2vcBaz4bEc/0ERna8m6cSlJdEzEJCS1KsVmV+kf6iogm/CoiiAMTX4BvL/E10t+XnlaMlB6ATMG7r6/oFDIGbn3fuM9RNRw5cCGFwSfpV/WaUBsRk2xPkNWiE6YRm/lw/vrnGTBArsl6asxgk+qTlT5B8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKr0t5L4XQATlneixNpM5Fhjqt7ayELgA4cETYTJPyQ=;
 b=VyFQ69Ww2h6sWu8xwods/Lu130g45XY5fF8tGW1G8RkE1tEWbPbNeaWltuh4cJplfQRKThGOeOhEvM/ir+qDAsc7hiC8pjdQrV1MoFWG5frSN+Phxanz9Sdx1oV4CTQGej4lF6R8mfK1ahNVJ/hBM3K+th/r2n010tJb1is9dQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by PH7PR12MB7937.namprd12.prod.outlook.com (2603:10b6:510:270::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 15:52:09 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%3]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 15:52:09 +0000
Message-ID: <4973cca2-9e58-42cd-8b28-98fe08bf95a2@amd.com>
Date: Wed, 11 Sep 2024 08:52:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/4] bnxt_en: add support for
 tcp-data-split-thresh ethtool command
To: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, corbet@lwn.net,
 michael.chan@broadcom.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org
Cc: ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, andrew@lunn.ch,
 hkallweit1@gmail.com, kory.maincent@bootlin.com, ahmed.zaki@intel.com,
 paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
 maxime.chevallier@bootlin.com, danieller@nvidia.com,
 aleksander.lobakin@intel.com
References: <20240911145555.318605-1-ap420073@gmail.com>
 <20240911145555.318605-5-ap420073@gmail.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240911145555.318605-5-ap420073@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:610:33::11) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|PH7PR12MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2d1dbc-718c-419b-63a7-08dcd279b180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnozUXRTSkNMMUxWd3FXQytVVVlhc1Nkb08xZFMvMEZUSlJUenRLTFV5NG1t?=
 =?utf-8?B?c1N1UHcvaVNZT09BU0Y1aSt0eU5KRlJMemh6QTdsQWRxck5mOFpmZ0FJRmRS?=
 =?utf-8?B?YUlpeVdWWm1TSVZMTkREdU9DRXpyTW1lNU1KaW9LS2dmVEFmckRHMUR6N1Zr?=
 =?utf-8?B?bGlOTHhzMWU0bFNWYTN5cGxsL3ZpcE9CbW5oQWswUjNsakVRRjJJR0tmZDJq?=
 =?utf-8?B?UXhOWTV4eEpRcmFmZzhHNElCUmt4d2RBL3FjVXk3eVBZR1M4dlJZcDg0bWRT?=
 =?utf-8?B?R2ZNdktzRDhJMlM1OWtzaytnblBkZnNZWmp3RFlHT0lLODM4L0hybDhIV3JL?=
 =?utf-8?B?MGEwNFpEMnp0SlM1T01kd0wrYUpBYndoTEhUSDRRYVNCb3ZpOEU1Uy9MSGxI?=
 =?utf-8?B?ZmlyTjM0OGJzOGVFY1cxb2NlNGlSdFpTdGtxZEQ5RkF6enNsUFdLVyt1S2Za?=
 =?utf-8?B?Tlp5TEhCNHRCYm9jdXZ5eFdGcGpwTXRTQmVaVnA5QytBSGx6VlhRQ3RzSUFP?=
 =?utf-8?B?VTZhbVpabGlTWG9iWEdib2d0MnRxTDBzbmNnNVUyZHp2VEhCbU90N0pVWTl3?=
 =?utf-8?B?Y3ozc0lJWFJEMjdBUjlEVzBKdjU0VWIvODNZYzEzN29NTXNLQlk5b3p1TUll?=
 =?utf-8?B?UkR1TkZMWDM1WTZxeTZsOC9iV2JIRzdLekN1RWU0MUFXeU15bUdxVk52YUhy?=
 =?utf-8?B?dGdoZmI2ZHNxaXZvQ005N3o0Z0RYUndqaDNLUXF5R1d6UGlFdU9maDhwSlo5?=
 =?utf-8?B?TWd4M3dPbytMazQ3UFVpa29oMTBuRFFxMDRtSW8zQWdUQldpMmlKb3FDeFl2?=
 =?utf-8?B?UmhVMjk0Yml0cDZxeCt5Q0p5NXJzcm1sc2Y2RTVWT0E3QWFNbkp2YThtV1ZO?=
 =?utf-8?B?ZHF6ZVpsZXdGT2JKKzNKNi9wLzkwQk0wMm9RT01HZDBLQXhEZXlVLzEwWDNk?=
 =?utf-8?B?NU94U2Z1M1c2M1AyWjF3dlJpbTA0OGYzR25LUDU0eUx3ZXh0OUpTZ0V2emFY?=
 =?utf-8?B?RStjTTV0WjRIMlZxMTg1anM1ajZ5U1RNWHZPRmNpMHQxL1lrdE03amNRQ2Z1?=
 =?utf-8?B?Njd1TUpxNVlXT0F0dXFsTkZWdEMvejhWdEVsdDZiRS94TEhYSzBJb3lFTlBa?=
 =?utf-8?B?WWhWY1U4TXhvMFlnSUl6Wm1zMnhuVXlmdE5ZaHpHRmUyTUhHWE43ZXZON1Bq?=
 =?utf-8?B?Y3N2d0FXendqKzJjam0rcndjV3RnRmwySFBUdlFTWU9EbTZURDNyMUE4b2xC?=
 =?utf-8?B?QnFxVCtTN2lRb2RUOE95MXNuSFlOZzJRNFl6MFBheEtYSTFzcDVZY0p0ZHAz?=
 =?utf-8?B?NG1kSk9pNURiN0lGL0p1USs0bmgrTzQ5NTM0MVF1U0dWRFRQc1pEOUQ0VmI5?=
 =?utf-8?B?RXUvdnVXZU5CQUkvdnNDbllHMEVGQUx1TlRyYjFYeUphSU41NUFZaUZUTERI?=
 =?utf-8?B?emJEYjVxOVc5cUkzNGxUWWxRQjJyenZlc1NmV1pndDU4R3BnaVFuZytFcWFx?=
 =?utf-8?B?RXdoS0Z6bDF1V25rTTNtQkhxOFptNmpvQy9NOFI2M01YdGFITk0vRlczZ2lG?=
 =?utf-8?B?ZUZTVm1jVEJha3BMYnBDd1RvSGN2aFJLNi9VMVgwOXgyem1IdWtVY2tTOFRY?=
 =?utf-8?B?L01Ea0IwcG5DbWdRanhjRjZwaDhzZXVER2loWGVQL0hjYyt2OVlxWElDRXNk?=
 =?utf-8?B?T2EvUWpZZzQzL2p1cGdmdWxXbTNOdHdZWks1K0ZwM1Zhck00N1FrekpSeTU0?=
 =?utf-8?B?ekRGQm5LZkZYeVhIR1MrRis1T0VSeTBIT2U5UGwwRE51UGRpQjlyeC92dXR4?=
 =?utf-8?B?UiszWUp1TXplZzFmU1FVdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzFaVTJ6RE9ZWUdYQ2RSd2xvQjRTVkg0SWhubkdGdGhQSTl3RGxoVm1NeENv?=
 =?utf-8?B?cG54UGRCbFJGSUFuZVlqc0lsK1ZQUDB1WEhhS201emF5WDN6blNqN3V3UlFr?=
 =?utf-8?B?K1k3UjRnL1JmekVMRWRHSElLU0Y0SUtjU2R5blN6NHF4emVpdG5TdW1EUGpt?=
 =?utf-8?B?VC9LYWp4Y0ducTl1S0hwblVtVXpNbFJtS0FqWTd1a1k0WFg2eEEzaW1YT2dU?=
 =?utf-8?B?WkRQTmJlQWpRQXBMZ1YvYmN1Y0drWG84T3ZvcVUwQUhZdWsxUHdsMFVjL3By?=
 =?utf-8?B?WWJjbXNxdFA3ZEU5NE5kRlE3U3J4Ym5ZNE93Mk11UENlQ25GKzhTVE9sY1VW?=
 =?utf-8?B?ckJmd2VQY3k1YUYrNnJ5Y1RqclZrYzdXVnFVNEV0RXRlN2VzUk1sUjE3bFVk?=
 =?utf-8?B?VVhBZWJvVUZtamZKR1Y4cXlicnJybjBZQWtPaitnc0FFTFpsc0tXVmVwNjBK?=
 =?utf-8?B?UHNaRGF0c0pWWW5sRzJjN1ZlQmlmMVhWdCt0TGxjWXJVZlU0bmpiaXZ4Vmxy?=
 =?utf-8?B?Z0F4V2Rwa2RBMFc5WHVuMGtvVlNnZEJxcUI1amdNRWRlczF3MHJSSkQzT0Vt?=
 =?utf-8?B?emJCTGRFUlN2RWZldFdmL2ZqYUx5bUptWnA3Y2wxUW5TMTd5eHlJN0R6dVJh?=
 =?utf-8?B?VzJxUTZuODMzY0dVRC9qME1pM0cwOUdKcHpMaVF4R1EwUFFlQXhIZkF6S0VY?=
 =?utf-8?B?R3JzWUZHZGgrNFdVRVdPdTJodjgvVVdPZFhVTkNTMVdGV2FnWitqeE5ZS0RX?=
 =?utf-8?B?YWVTbklEc3hGa0R3bWpKOHhjK0F1L1R6Ukpldlo4bVp4ckpGWUhLeGVIVHNM?=
 =?utf-8?B?RVZveEZidzRkaGt2eitucExsMjBMbEZpM3FJSU56UEVyUnBzcVNYS2NTT0Rp?=
 =?utf-8?B?RVE4U3RvZEJNR2p2UkI2VHpzdXN4aFB3c0RZeHplWU9pKzVpeEJDdlNqd2cr?=
 =?utf-8?B?MkFKWmtBLzFxMGdzb1Z5RjNlamVDNnM2Wlp5TnhyNEQyYUZNR0xSeTJTUGtE?=
 =?utf-8?B?M3pDbWFxZmp5MC81c1BvcjR2SkJ1SWVSUGlMcTBvTXh3Q3cvd2NHQUxUTk9s?=
 =?utf-8?B?MTFsb2pMMEF1MG83U3hZZ3ZVaDBuTXVSZ2xOQjVXTXBlYmhPd1RRRk1UMTVw?=
 =?utf-8?B?LzFMS3dIMlQvNkMwL2VrbXJFQW83NHJEMUhBRmJyaU1ZQStLa2FaMXZBcURz?=
 =?utf-8?B?ZUN0enNaQUd6U0wweFYyYkhxbGU4bi9sYWZ1MlBKTklMM3FVb0VhT3BqNC9U?=
 =?utf-8?B?bGdpTWxIdlRlakN1cEtFNjg0SUl1VDR2SmF3RjZ4SS9YV0F3Zk9mQ1JTcUJa?=
 =?utf-8?B?cTh2eDFEQWRTK2U3ejBPV1U2ZENpa2M0WVhBbGEyeVZZQ1RuNkJJbitGVEdP?=
 =?utf-8?B?S3RiUmxxRXRJV0p6TXROa0tBVXJUSm5zSzdHaXBnUVdKREJ4OWdWYjk1OVpR?=
 =?utf-8?B?T0Z1OHdpNk55emhxdjNzeWcwTFg3RnJGZXVZcmFobkFtK2FDd0MwakFMQjMx?=
 =?utf-8?B?SE9xRE0xTlEwTW8wT3ZuVjFGOEpmbk5XRTlmbTNUSWlvUHJFK3pvdTVJY29D?=
 =?utf-8?B?VzdtdmRuZzhINGxGRXpxYkRKTHFKRHpTSHZGcTFJTzlSQXptSE9uMWMzMTZD?=
 =?utf-8?B?bmduNDNGOTNEODhjcGdwT0wrR1ppN2lEZmpBYURhSXhobFRiMWlhMWtyMXRS?=
 =?utf-8?B?YjJlVGJIcGpCVU8zRkduRTlpclk4a2k5WFRrZkFYRXdOU3dPeTg0U25oVHNX?=
 =?utf-8?B?K2dtVXBncXpPNlhoUzZxSjNLNWs4M2RSeDFWdXl4TUNQRkp0S0FPRTFZQWpn?=
 =?utf-8?B?T3hnZko0Z2kvTHpmSmF5RnVVSWZtc2RMeTk3YURianpCdFQ2WnRJVVBNdm1H?=
 =?utf-8?B?ekxoeDZoQW92d0s5eTZxcSs4d3M2bmx3V3BaUXc3OWFoc1ZUdkR1dVBQQ1RN?=
 =?utf-8?B?SVIvTlBXWi9JMXRZVzk4d3FaL2Viby9zY0c4TjYrTW9FcjdzSzhQY0k5cHpt?=
 =?utf-8?B?Vml6U25LanQzY1FZZm9ldEpaRnN2TjNIVkNEWTVDZDRMQjRKOVJZL0xUMUJU?=
 =?utf-8?B?U1M4QUN0Q0gyQTlIVEMxM1QwbGsxZVFPcEEvOU4rbjJIWVlHdzBFcUNmMkpJ?=
 =?utf-8?Q?KXuuDpF1LB2JAYhrwTQ2IJMu9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2d1dbc-718c-419b-63a7-08dcd279b180
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 15:52:09.2488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYwdXynbWrDCDie2v486+orLTFKU0Durilvcht++QoWyv+pFWZ6LfahPbEPxxIHah1YvhQW9/QzqH2OoBJW5uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7937



On 9/11/2024 7:55 AM, Taehee Yoo wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> The bnxt_en driver has configured the hds_threshold value automatically
> when TPA is enabled based on the rx-copybreak default value.
> Now the tcp-data-split-thresh ethtool command is added, so it adds an
> implementation of tcp-data-split-thresh option.
> 
> Configuration of the tcp-data-split-thresh is allowed only when
> the tcp-data-split is enabled. The default value of
> tcp-data-split-thresh is 256, which is the default value of rx-copybreak,
> which used to be the hds_thresh value.
> 
>     # Example:
>     # ethtool -G enp14s0f0np0 tcp-data-split on tcp-data-split-thresh 256
>     # ethtool -g enp14s0f0np0
>     Ring parameters for enp14s0f0np0:
>     Pre-set maximums:
>     ...
>     Current hardware settings:
>     ...
>     TCP data split:         on
>     TCP data split thresh:  256
> 
> It enables tcp-data-split and sets tcp-data-split-thresh value to 256.
> 
>     # ethtool -G enp14s0f0np0 tcp-data-split off
>     # ethtool -g enp14s0f0np0
>     Ring parameters for enp14s0f0np0:
>     Pre-set maximums:
>     ...
>     Current hardware settings:
>     ...
>     TCP data split:         off
>     TCP data split thresh:  n/a
> 
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
> 
> v2:
>   - Patch added.
> 
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 3 ++-
>   drivers/net/ethernet/broadcom/bnxt/bnxt.h         | 2 ++
>   drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 9 +++++++++
>   3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index f046478dfd2a..872b15842b11 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -4455,6 +4455,7 @@ static void bnxt_init_ring_params(struct bnxt *bp)
>   {
>          bp->rx_copybreak = BNXT_DEFAULT_RX_COPYBREAK;
>          bp->flags |= BNXT_FLAG_HDS;
> +       bp->hds_threshold = BNXT_DEFAULT_RX_COPYBREAK;
>   }
> 
>   /* bp->rx_ring_size, bp->tx_ring_size, dev->mtu, BNXT_FLAG_{G|L}RO flags must
> @@ -6429,7 +6430,7 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
>                                            VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV6);
>                  req->enables |=
>                          cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THRESHOLD_VALID);
> -               req->hds_threshold = cpu_to_le16(bp->rx_copybreak);
> +               req->hds_threshold = cpu_to_le16(bp->hds_threshold);
>          }
>          req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
>          return hwrm_req_send(bp, req);
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index 35601c71dfe9..48f390519c35 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -2311,6 +2311,8 @@ struct bnxt {
>          int                     rx_agg_nr_pages;
>          int                     rx_nr_rings;
>          int                     rsscos_nr_ctxs;
> +#define BNXT_HDS_THRESHOLD_MAX 256
> +       u16                     hds_threshold;
> 
>          u32                     tx_ring_size;
>          u32                     tx_ring_mask;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index ab64d7f94796..5b1f3047bf84 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -839,6 +839,8 @@ static void bnxt_get_ringparam(struct net_device *dev,
>          else
>                  kernel_ering->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_DISABLED;
> 
> +       kernel_ering->tcp_data_split_thresh = bp->hds_threshold;
> +
>          ering->tx_max_pending = BNXT_MAX_TX_DESC_CNT;
> 
>          ering->rx_pending = bp->rx_ring_size;
> @@ -864,6 +866,12 @@ static int bnxt_set_ringparam(struct net_device *dev,
>                  return -EINVAL;
>          }
> 
> +       if (kernel_ering->tcp_data_split_thresh > BNXT_HDS_THRESHOLD_MAX) {
> +               NL_SET_ERR_MSG_MOD(extack,
> +                                  "tcp-data-split-thresh size too big");

Should you print the BNXT_HDS_THRESHOLD_MAX value here so the user knows 
the max size?

Actually, does it make more sense for ethtool get_ringparam to query the 
max threshold size from the driver and reject this in the core so all 
drivers don't have to have this same kind of check?

Thanks,

Brett

> +               return -EINVAL;
> +       }
> +
>          if (netif_running(dev))
>                  bnxt_close_nic(bp, false, false);
> 
> @@ -871,6 +879,7 @@ static int bnxt_set_ringparam(struct net_device *dev,
>          case ETHTOOL_TCP_DATA_SPLIT_UNKNOWN:
>          case ETHTOOL_TCP_DATA_SPLIT_ENABLED:
>                  bp->flags |= BNXT_FLAG_HDS;
> +               bp->hds_threshold = (u16)kernel_ering->tcp_data_split_thresh;
>                  break;
>          case ETHTOOL_TCP_DATA_SPLIT_DISABLED:
>                  bp->flags &= ~BNXT_FLAG_HDS;
> --
> 2.34.1
> 
> 

