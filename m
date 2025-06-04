Return-Path: <netdev+bounces-195065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D8CACDBD0
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 12:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A7F188ED89
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 10:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8006128B50C;
	Wed,  4 Jun 2025 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="T1r+de+L"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022115.outbound.protection.outlook.com [40.107.75.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E001B0F17;
	Wed,  4 Jun 2025 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749032419; cv=fail; b=pgr6Mkp2/BDEEBmXzc7tpu9HlyLTw6Cyj+uzg+9Mm3of89tBIAqWXHKxQLxrLr3SywA4dNXvjLXqb3M2jhqo7avvH+XUWLgVHLTXNvZvBhYAtfpHDs+20E17aKkuHRIn+ImBQn9amUMc99TnuGV7JjaQisdygQEFo0r177DQ5Z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749032419; c=relaxed/simple;
	bh=qEWVzUh8dxtL23Ilk1LrE9Meelri6vTVWa+0DqVgK6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:Content-Disposition:MIME-Version; b=GdK8Nv9MzE7Low5H7DMjmiMKPcywpUJaYBDgBnr7zOvl1P93nPMVUEy509j7t6pX5zcGE4AVETilNbNhYmBbD9ekC8RLdqo4n5cxw/K7jVKuE6s1HSehZqQUp5THSRBNn8Hd7nuU4ahiXHj/eUcVIygkPtlkbmoiSAf6FF3TNxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=T1r+de+L; arc=fail smtp.client-ip=40.107.75.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VaAXoPuGZaMO/w2U82clt/UumnmtbgZa74eYuP0EAcabDEibLh4yX9Bbd9bQwdnDxHgT3VqRYvoJBVJRs7tVu+Oy6jr/8GLhNVD0h4YeUnDzNrC+6jbTLGcPzXgNxbh2vGP63hhY6qjVKKWq6X90ym48b5YXrAhvtDoDfxW8nLWuaJvckpc/W38pgLi8fpjIaai0Xn93lKiwpiElzRfutnRUfEzK6l0qRgjWYVQdesX20c/tG2xYVZ/ZIV7ufvFwMaSMerBKyDKWouJ7QrSjAoZd1A+Pv2w4Yl+iIs7P7jdakgrp2DOVtOyWKbOZUaRo3ogRQ3hswr7yrJhWx+1j5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVrMKRlmBuMmWEiBvZfKhdUM/ymCKO5TLdiJmMnEwOs=;
 b=wPPymnXPUIq9NYfHh8UDDIQJdCiyz1fd0XRIoU25JdIDeeqcL5MzkpnD5tjPnzGsEKUdfSSM/c7aBvWjtzEyj2CRrX+/uLJBtY82nH6KJXbkQqnYVh1U46Y4sgHEtSv3ULeK2Al/pWIOZ0d7KhN8Gvijf9jJBBtLIxr12mon5Vmz/Z1t0OU4XWuwEHdZkUdIab3nPI5ic9yfYQwuiAGIGofsoiIlVgXh0tRomW1J/xar2u0yAcvwXMLIhsSP6k0Exkz8m7tCzJrgnkoM5E/4RsG9JNZ7R8f1PTjgJzz4oFAt/gYSeGKuuJ0j3Ek5/BDwjqjrlrw23ZuBHmSzygXwmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVrMKRlmBuMmWEiBvZfKhdUM/ymCKO5TLdiJmMnEwOs=;
 b=T1r+de+LVr0emCUXfAn3uzMHWp3wFLlq5m+91ZoY4iz7Tkm20N+PNB2xDwnKCOxfhwAk4h2WvISILkeSn/rrGN1p91mx/dfoQPtYeORLtmy+TMK50vP6mwO2o0IsS5RUSZ1v0/5U4Hk/QRKNq5nYXbn/uVU+qQ43R6V1sUamZ+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by JH0PR02MB6424.apcprd02.prod.outlook.com (2603:1096:990:c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 10:20:11 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%4]) with mapi id 15.20.8769.037; Wed, 4 Jun 2025
 10:20:10 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
To: larysa.zaremba@intel.com,
	Jinjian Song <jinjian.song@fibocom.com>
Cc: andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	corbet@lwn.net,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	haijun.liu@mediatek.com,
	helgaas@kernel.org,
	horms@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	johannes@sipsolutions.net,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com,
	matthias.bgg@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com,
	sreehari.kancharla@linux.intel.com
Subject: Re: [net v3] net: wwan: t7xx: Fix napi rx poll issue
Date: Wed,  4 Jun 2025 18:19:53 +0800
Message-Id: <aD7BsIXPxYtZYBH_@soc-5CG4396X81.clients.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aD7BsIXPxYtZYBH_@soc-5CG4396X81.clients.intel.com>
References: <20250530031648.5592-1-jinjian.song@fibocom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: VI1PR06CA0174.eurprd06.prod.outlook.com (2603:10a6:803:c8::31) To SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
Precedence: bulk
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0133.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::25) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|JH0PR02MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ca67fa-a0fe-4cbb-f969-08dda35162f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|4022899009|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aOpKfiw21lHtSDRugT+MkF00G8LCfFWyqsEUOpxYCMuKzuZXArn7GPEort8/?=
 =?us-ascii?Q?QaqfhtLK9N7Od7Ur+zy6dOnCC3B6WCrwd4ewqWY0cGvS9cbKQpnOYkrMz78o?=
 =?us-ascii?Q?3W5cYqD0NQdUxBp7SvIAOXKxS9FLo6paWyMGOdsBVVWTy9pzPWsaUiTlz58t?=
 =?us-ascii?Q?knvqx4/4DGYdo9zu3Pn+dZIZqltJT/DwMMa1xFpsqNoL/5vtljk2HYOitHlx?=
 =?us-ascii?Q?iPbtTA6OmgS7P2Bp9T6goK+WqB11TSFChJ4alqE5cUv6AXG9Mkay6t4d1MFX?=
 =?us-ascii?Q?nHdKwS74YAh1DcI7S+1q7HL32911Ckn2dt+0wYzyfvnAwJEkJaPaPn4EZQIN?=
 =?us-ascii?Q?4Q19KF3szxFC8kMBlo97cvOhwuz7pTV1wk8gSykQbm761m4s6oIvY6i1Gx1S?=
 =?us-ascii?Q?yPGVsnt8otFYizBMr/YxlR98lV6corHqdwawYLmrKkS8mREScQKVdxp/kIDt?=
 =?us-ascii?Q?eqCvdoNsX4v/lI/xdwzS0yyKAOdCBXko5TWaFYzowtFgEj8/MZC9UhA6zqFm?=
 =?us-ascii?Q?2nZsuesWmfFH8IhNk6NF1SwzO+nPgYGQv/0I/jG3nNb9Agzja5T1H3XlP8Cl?=
 =?us-ascii?Q?W9qlcBfNRHNebqzcLAxYnN/lOiD5dW9O+ha4nXxRQYBiE1Ic/vfAzNzvCJtk?=
 =?us-ascii?Q?14SIAikRZXBdzELNfOvY/PJdGYPqViNbV2ANHdlnBNSK7nbEnBu4Ia7Wk3R+?=
 =?us-ascii?Q?+riZ21ryOzEGgo+ECNoTc+o5TxSukTjyoF8sMiYVgBBny3bhy6LhQZpCqsPe?=
 =?us-ascii?Q?MKIA4RhofLp8RcBDrWVEU16kaCa9UYlLmNtenmz4cq/gq+f1CQqQi72u8J4M?=
 =?us-ascii?Q?AeqmZMIHehydUItPj37hlQzNMbXQ9nZFGI91MQq/vMCx36OXFg8OnAY2h3pb?=
 =?us-ascii?Q?ek8SIiwXZP/7KOqZTAzBJvC3UjW5+DNM3MGEhnX5J2q0wYTicTUTf3jFvprS?=
 =?us-ascii?Q?bpqsbfZd8piTiNDmzgX8aTB1CulIY2Owjolown+WKbxKuN/i3qMPCXSwQFVE?=
 =?us-ascii?Q?/M5ApmJQf4t/Aup9MRPuMwWlVthlXhK18iwptALy9uA/nhxZ03yzy+kYmuAL?=
 =?us-ascii?Q?tQMk3wEYYDjDCaLskRZ8WW3+V5rA5V22vhMeoLlOQATPgkppKC9xy+Nc+AkG?=
 =?us-ascii?Q?G1uwxscxDgowM3lsdINEvUcrJozhqD+N7qZ/L0gXzRopYp1Fm/rX3Rs9nXaF?=
 =?us-ascii?Q?kEioRwUOMEEX3POE+Sb9PGXjKY8ivp6/TisUFraRtklU790DjZBhZxQ2Gf2d?=
 =?us-ascii?Q?aIfjZ7Mnkx8r0JksI38TAOTNBgVOWEGV0piDTs+6uxrW7zf3kV5J0hyYxUU1?=
 =?us-ascii?Q?Vf4LdbAG+ssutEPf2Lxh/KuFqgkdjeMzuz6of7e2QKc3izujqtcmYyeBsaUK?=
 =?us-ascii?Q?1vyWOL3YWiSNhJ9V9Mdbne7S1ahD+JMt1+oNp6leyaH2p+E4P5Snm1yOHilZ?=
 =?us-ascii?Q?eRyPuhc56+P8d9Gu57HjSpsCfa1IdqRkcpLjmVGwCqVi2nVqMJOxEQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(4022899009)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qRx1lMEpAmztV28TU6CW4wpuCCphlPZDhmCtj0l6fvLque2jd4MjBJXQcIDI?=
 =?us-ascii?Q?J4HJ3IQcF4JnuY2eLkGozo1NI5EpsxUHybpzzCqs9uJVE4CGZoKunj1j10Az?=
 =?us-ascii?Q?o27RborfNt5Nxsdv0jvrUoaLr2ha67XrGrSKQAtL88uJBf//IFfhJqb/P/uH?=
 =?us-ascii?Q?xjMdg2LvSPJbDyvHXCLh1IPYyWtgVnre61vu1hOrzkWdySQX/Lt9I6xfLwCN?=
 =?us-ascii?Q?P71PWiP8qCEzKGWTw6gz3QCYCbU+srRTjAqF56JKNMW9+21a8bYoHkTTjzn3?=
 =?us-ascii?Q?NXQWLQEQFo7al/UfmH/58hoUFx3XXWlfqxc6iBm282WfVB0jdvx2eRaPWOD6?=
 =?us-ascii?Q?e5w/1y/jyJMyUZWhOD422e6NLR1Y7iOiDr1Fbinx6PLtAhGFiauln/060NT6?=
 =?us-ascii?Q?QIOWFoaMKSZ6lWj65DahHEzuRuaw37JoqU/y+9Z87Qii5IIBi6y0Ob6kX6nM?=
 =?us-ascii?Q?o/m2IxZxVJO/S+6hP1OKcq5gIB48bIRJQz3gtcrHwo9Ce/QiVcZ7YEL+pWqu?=
 =?us-ascii?Q?7saFByL8FTFQIdXUQNJyBlPMCaf9oOskQ1JpsNYwaw9e/gWh4tdQ7i4DpokJ?=
 =?us-ascii?Q?iHnE/EBGPEQzYhrZwCy4DEbMckap2Wdy1bgiW4yxCLdk3RVcSyiAeL9p8yso?=
 =?us-ascii?Q?w4sfIP58AyltH4G1gXBucHt6iv5xevftkf0KSeEP1kRUCWN1ZbOFqFuZLBF9?=
 =?us-ascii?Q?dCSEY9vP21jdJOX+sBrobCKF6oPtGYOPsklmFi6CupJuujMMX/+74M0E0LyJ?=
 =?us-ascii?Q?3s5lhIwRKD2zE3lUW6UuK7325y+UKmqOTWbMLJ7MBf8lqAcAegMKrymqts4l?=
 =?us-ascii?Q?sEwrbY2Ho7ZY4x2wJNfjsjCFaWF5JmL4xPw6eulS02zgAeZC/AWWFWt1uIg1?=
 =?us-ascii?Q?1uSow9X+1Av57AGAd+GGgOP0YO2K+n1of2GOHaC/zX9CR8BQH/7uJplYhnt6?=
 =?us-ascii?Q?K8KIpzDApBc6l0DDH5xchRaP8MfokTr1MAnUnwKHdgJsDYllUSFAc1MOr8AK?=
 =?us-ascii?Q?GiRyNgEuxuzC/M5THhWmX5HmLPibrxIKC8Lb1WqdjhpWP67/lFKfZbJmfNGr?=
 =?us-ascii?Q?tcJjMGAWqMuG6Ld368zBJhjYnxM6f5H3+Z+p4fxGT69BA81DUe/EgFbOZoG4?=
 =?us-ascii?Q?OBsr17Rw4e9TfXJdOYhK7iBpDpi5tJCQUWsOmheivpbKA8ONmjCaTRxg/rEy?=
 =?us-ascii?Q?d/tR2j3L1rfDJFRShKddolEUDgF6f0nTEEv7YmGQ7PxnAIVPJGaG+rR37pdm?=
 =?us-ascii?Q?TwsIkF0vp3MRKdG+FADoLPEPUtdJKTLLXISjARry9hdbIkrgNEZKJTWVK35y?=
 =?us-ascii?Q?SuShFDkl4Elg4V6oUunpk70R4zBiRSWH8V172+Jc4U4lgyqNfbyEi8AuIvi/?=
 =?us-ascii?Q?1W3Ne8Y44IuDrYY0uoekUDIAu1gtStokwX1yMjEimmyvCJXazoin29kobV3Y?=
 =?us-ascii?Q?MGtrSoXqdpQPrHR3t0lLRKQPbWSg32X7gfDQrtac9UoHDv7GtlQeYNRnL5NL?=
 =?us-ascii?Q?AaGaznZ5mezf1+cuoQPnuTzxYvi3qKfeZZ2HKgp2VrwjwgtN1fiomoXv4boF?=
 =?us-ascii?Q?Gi8iLTRJtXB3JnvDcloQpcK4G9UECct5sIpNKv7ylmEK+o0d1aiWFJFB/6Sx?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ca67fa-a0fe-4cbb-f969-08dda35162f2
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 10:20:10.7595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NBkaR8gzoK/2a3TXYQxhyoF18BLH89Mq61Ep6XyKiSbSUF0It4w6foIouPRnGROrXw1C+KsFul+KqVAjDuWOmQ8/co/VK3U3q4b57lmUo8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB6424

From: Larysa Zaremba <larysa.zaremba@intel.com>

>> Fixes: 5545b7b9f294 ("net: wwan: t7xx: Add NAPI support")
>> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
>> ---
>> v3:
>>  * Only Use READ_ONCE/WRITE_ONCE when the lock protecting ctlb->ccmni_inst
>>    is not held.
>
>What do you mean by "lock protecting ctlb->ccmni_inst"? Please specify.

Hi Larysa,

This description might have been a bit simplified. This process is as follow:

In patch v1, I directly set ctlb->ccmni_inst. This may be not safe, as the NAPI
processing and the driver's internal interface might not be synchronized. Therefoe,
following Jakub's suggestion, I add READ_ONCE/WRITE_ONCE in all places where this
pointer is accessed.

In patch v2, Paolo suggested using READ_ONCE in places that are not protected by locks.
Some interfaces are protected by synchronization mechanisms, so it's unnecesssary to add them there.
Therefore, I removed READ_ONCE from the interfaces.

>> @@ -441,7 +442,7 @@ static void t7xx_ccmni_recv_skb(struct t7xx_ccmni_ctrl *ccmni_ctlb, struct sk_bu
>>  
>>  static void t7xx_ccmni_queue_tx_irq_notify(struct t7xx_ccmni_ctrl *ctlb, int qno)
>>  {
>> -	struct t7xx_ccmni *ccmni = ctlb->ccmni_inst[0];
>> +	struct t7xx_ccmni *ccmni = READ_ONCE(ctlb->ccmni_inst[0]);
>>  	struct netdev_queue *net_queue;
>> 
>
>You do not seem to check if ccmni is NULL here, so given ctlb->ccmni_inst[0] is 
>not being hot-swapped, I guess that there are some guarantees of it not being 
>NULL at this moment, so I would drop READ_ONCE here.

This ctlb->ccmni_inst[0] is checked in the upper-level interface:
static void t7xx_ccmni_queue_state_notify([...]) {
	[...]
	if (!READ_ONCE(ctlb->ccmni_inst[0])) {
		return;
	}

	if (state == DMPAIF_TXQ_STATE_IRQ)
		t7xx_ccmni_queue_tx_irq_notify(ctlb, qno);
	else if (state == DMPAIF_TXQ_STATE_FULL)
		t7xx_ccmni_queue_tx_full_notify(ctlb, qno);
}

Since this is part of the driver's internal logic for handing queue events, would it be
safer to add READ_ONCE here as well?

>> @@ -453,7 +454,7 @@ static void t7xx_ccmni_queue_tx_irq_notify(struct t7xx_ccmni_ctrl *ctlb, int qno
>>  
>>  static void t7xx_ccmni_queue_tx_full_notify(struct t7xx_ccmni_ctrl *ctlb, int qno)
>>  {
>> -	struct t7xx_ccmni *ccmni = ctlb->ccmni_inst[0];
>> +	struct t7xx_ccmni *ccmni = READ_ONCE(ctlb->ccmni_inst[0]);
>>  	struct netdev_queue *net_queue;
>>
>
>Same as above, either READ_ONCE is not needed or NULL check is required.

Yes, This function in the same upper-level interface.

>  	if (atomic_read(&ccmni->usage) > 0) {
> @@ -471,7 +472,7 @@ static void t7xx_ccmni_queue_state_notify(struct t7xx_pci_dev *t7xx_dev,
>  	if (ctlb->md_sta != MD_STATE_READY)
>  		return;
>  
> -	if (!ctlb->ccmni_inst[0]) {
> +	if (!READ_ONCE(ctlb->ccmni_inst[0])) {
>  		dev_warn(&t7xx_dev->pdev->dev, "No netdev registered yet\n");
>  		return;
>  	}
> -- 
> 2.34.1
> 
> 

Thanks.

Jinjian,
Best Regards.

