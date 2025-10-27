Return-Path: <netdev+bounces-233225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D27C0EDED
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 16:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1560534D66D
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED762C325C;
	Mon, 27 Oct 2025 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b="YYJDYPd1";
	dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b="LoXCZ8ae"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay99-hz2-if1.hornetsecurity.com (mx-relay99-hz2-if1.hornetsecurity.com [94.100.137.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E881283FE5
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.137.109
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578167; cv=fail; b=jv8rP9RwaO01ZAMPtnZdhcEpftzjLgY5jWDn2QN6S5CSviz75vJAPYcm4maOpUJzm1dXQvo7G4p/bJTWARLgZ9bg3EeAqqr8y9Iam9zTQCOVgGWzYaNvELsiYturA4dsPmK2O4ScZiVtJYviRBFY1XB/HWAs1Lv2RdfHSAl1xF0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578167; c=relaxed/simple;
	bh=LI7+8INGCdeh51Bm+/fltv/5vlj1nGMWl7q+ufQMh5E=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:
	 MIME-Version:Content-Type; b=O3i44NW1uzcnOfNWUy+5kMAa2caOxO2Rlaoh9pKcpMU/BNU4xUIz8heqwltnUIcDb8ui/hgCHv0Y5Q7Evu17iu9Axc6i/o1Xdrbv12/Hiq8oWEUjJ9xfhGHLCKRf3h9DLh86mOjkgauSAa2Lc6pxBG0OQX8hOSImaOzfE/lMQQ4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de; spf=pass smtp.mailfrom=a-eberle.de; dkim=fail (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b=YYJDYPd1 reason="key not found in DNS"; dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b=LoXCZ8ae; arc=fail smtp.client-ip=94.100.137.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a-eberle.de
ARC-Authentication-Results: i=2; mx-gate99-hz2.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=52.101.65.102, headerfrom=a-eberle.de)
 smtp.mailfrom=a-eberle.de
 smtp.helo=du2pr03cu002.outbound.protection.outlook.com; dkim=permfail
 header.d=aeberlede.onmicrosoft.com; dmarc=fail header.from=a-eberle.de
 orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=ZehNT2EevaU3GIIhQlM670wUFJMnETnO/tpq3i95b8s=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1761578157;
 b=MlrKIWCNRxx+baVT0gsgSPGJyl7jFxWokpVJbESoAon4uX/SsgPk2baJSEuLvhPHVmt/RvFW
 8Sg/ShNBowTtcbeqenMFbhg21MSf3O32sh4G0bCjlC/pPCJkfNQHC5K+iLXGU5FOWce0Z1BXsUm
 8T+1bIafnZQ4Bmw5fK87FHKGdoYMoW1cVhTkX4SVljRLZaLHbDcE3KOidm2kEu0mqm4+qcwEi4k
 8sLPMryix1dLlnGstFOqD8PP4pTBPV69Q78nZ2q/u5y6mOq5tPgkOjjcY8lUypWgW4oIcz/yoJ7
 1X1FQESuhyJr9EPaf20fOTwprCQHXMT0B/ii3K6deqwRQ==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1761578157;
 b=dQhmDQBowWQlPZ/xGVZ50pneF5syiozz1Ts5WcfUm8BMqxRMURPCOA1kXCOsDKt1DCt/YCBt
 vFoZ1lHMOi0VxkpvlgzjYHgCUOzw8GLf7U7O8e2OpBHkAhf8hUq63mg1eJpoMmRfJv7JVI+8X/E
 JcSNrjEFMHYtzmHUgD2vzDjo8lLeWYsHmlhc3/ju99uUqY0BJWaoejPV0OXQOdBnkK0NMIfkGlI
 yZKFzg1LMCvtC6trTQBZAeuDcq3o0bcaU0CZ474feobIv17pMSvu5Pn7elwDoGuFb14b6UWHa8m
 eB1a85D3EPfkll5/DhPVYRBffX4cCexSxYUSurZJLaQDQ==
Received: from mail-northeuropeazon11021102.outbound.protection.outlook.com ([52.101.65.102]) by mx-relay99-hz2.antispameurope.com;
 Mon, 27 Oct 2025 16:15:57 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACgibsOmAsf+qBOP5wdzcEivLHePfpCfdPSkpM/jn+tob+gwHQWtMptXPTS2TMDS7QX69Z+ebg8iw0z/tSfTuOtnH31hjttxPLPcoSfQvfdtbjysmjxcLCVbscetyUKc/1OBU+5bzjSpgMtJAYKyV256tpnpU9xSK5uiarxzBUmitmjQmmXu1pDJFjGu0i7tUg5Xy6SY/59QAlrTzdf7xWdY++GfvY7ccd16K/y5aiLnlt00DR29nA9UZDsDPo+7k77HC6k6IQuqlyuVAwqjp9Ry88ae/8aUw8SL5ik8uzV+7TZaFe/JXFI2JT25MyA/5IptAQ4XvVdRXjt0NY8KDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19REJvPrZsk4ZViyeydf6EIkocElkumhJNR6RozMiJ4=;
 b=xUNjaxG6+10QEp75P1H0V2ulJJL59OKneuBVS1aeDdSfGVHo7q8eXVCb4U1SuUYhmBp1m9u7MBe9OvYnH5OhaXpWso/Mdeai3XLBCHqEXe307psW9zDMbKZQlmPfUFu+Iv5Mu0JSniIQdYTsWvm+/cLTAuMe7ACby2+4vPmARDuc4l4JnhspH9Uvt00k40XkgH6VH1kdc7wzxS0G6R0B1PRynkzZlFG5ZnKPjb8GvYUYTzEglgBn/rOihlJHQ95fmpSjnFaeQ0mW4SuMy6d5YHoNdM65nG3PBqDsAjUCOFVLPQ1Yctb0rvhcElhNbRVQqttxPWejzKUBDuAtoX5gvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19REJvPrZsk4ZViyeydf6EIkocElkumhJNR6RozMiJ4=;
 b=YYJDYPd1//YlYLfhyYISrSQU4QW7CCYwD4aftrq2YFZHdvqAb4J7G2cM7hXFz5Vr4WKuYJOjiQ7WKaKIpk5IV3mP2hsjuqiJG2gXg3X93ggl6lbCVXi3UBVCGYp94TCagQjsJGNghEZnMRCDuwEdus4vD5zVbisme9CM8wGnpwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17a::7)
 by GVXPR10MB8784.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 15:15:22 +0000
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856]) by AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856%2]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 15:15:22 +0000
From: Johannes Eigner <johannes.eigner@a-eberle.de>
Date: Mon, 27 Oct 2025 16:15:12 +0100
Subject: [PATCH ethtool v4 2/2] module info: Fix duplicated JSON keys
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-fix-module-info-json-v4-2-04ea9f7a12a5@a-eberle.de>
References: <20251027-fix-module-info-json-v4-0-04ea9f7a12a5@a-eberle.de>
In-Reply-To: <20251027-fix-module-info-json-v4-0-04ea9f7a12a5@a-eberle.de>
To: netdev@vger.kernel.org
Cc: Michal Kubecek <mkubecek@suse.cz>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Stephan Wurm <stephan.wurm@a-eberle.de>, Andrew Lunn <andrew@lunn.ch>, 
 Johannes Eigner <johannes.eigner@a-eberle.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761578119; l=4232;
 i=johannes.eigner@a-eberle.de; s=20251021; h=from:subject:message-id;
 bh=dMFLIXzG0+sTWbSnHnskjqpe6ycU9ee6Ye3AU7+FdEg=;
 b=8EdSVaoRfdTHQHNBbI0t3NHGynwCG/h7/cK0MRDoZRZsCtMP98xjW+3sPa34WL7vOKw/LfEnn
 U9eAjd2kldGBK2r9LJJ+SogpbT6t4kezPDEy1Nu8XzwQwO9y8TFLZ63
X-Developer-Key: i=johannes.eigner@a-eberle.de; a=ed25519;
 pk=tjZLx5Tp2iwCN/XmbFBW4CrbjZnFMF6fyMoIgx/dEws=
X-ClientProxiedBy: FR3P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::14) To AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17a::7)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3873:EE_|GVXPR10MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: f436c5e0-4dfb-4764-6624-08de156ba633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SCtMTlh1WG5nNjAxbXJyQ01FL1hRMWMvQTN5TnNadFNBYjJiSFl6UkdJdkIv?=
 =?utf-8?B?dlJaYkt3NlFubU5iSnZLbDJKNGdrd0lwbnZ1VVpiVGZuQUVnR3lMSU1QYkVC?=
 =?utf-8?B?TWMvVjAxUXZNYnlPb0kzSDZKYWw5azZ6bGp4UUwrdnYwUERtbUZ0ZTZESWh1?=
 =?utf-8?B?M0haK0FjR2d5UGZISUsvQ01hT1pVa0JUcFhmZVRQWXVHQmNITThWc3pmcGEv?=
 =?utf-8?B?eDhOeWpydW9JRUg4SFJNQTh0cXRGUjZKUmlsRUphOXp2OVUxSFJHSjkyK200?=
 =?utf-8?B?OXAxZzZZOVN2UmRRRXNwN3VlQUZ3VE9Ebno3OE9LODR1Tk9lbVpNeGVVcWg4?=
 =?utf-8?B?WTZuVlRSOUo4MytyTStiRkQ4M2hGY21hdjBGQ1FTaGpYWVdHY2Z5djNRWnNB?=
 =?utf-8?B?Szh0WTRTOTV4YTVsRFF5Zy90cUM4UzhQYjUvS1dQVTFEMWQwWTNXNjRoK2Jl?=
 =?utf-8?B?NGxpaXdwbGlKaC8rYXFiRWt0TU4zZnlSWXpUbUYzNk1zVUdNNjR3NDNnMUlU?=
 =?utf-8?B?dUg2WjZ0NUF5bXJOOXc1dEdwQTNJTzE2TURqcnhvTmwra0FhZ1RONnZtbnFW?=
 =?utf-8?B?bGxFOFJRVWYrQ0ptWGtHNjlZK3hraks0L2Exb3I3WS9oNjVSd0hXbDNjRlBm?=
 =?utf-8?B?UlhneFFHenNrV3FYa1hvN080ckNBUjZNaE9pYTc2cTR2Qm15c0ZQL0VqNHJE?=
 =?utf-8?B?bklTTlB3dU1DeHh4QjR4TlBlRFg5VVZGbXFmSkt1R0R3SXBnU1RZaWFPaUdG?=
 =?utf-8?B?clprVnZSODdEMjYvajFUallrY0ZrUVh4a2c2MkQ2anV4SFc5RGlCTG5LcmNS?=
 =?utf-8?B?NnU2VEY4eEpySzFJa2RpdjBsK20xQ2Y2V3JpT2hnVFpReXFTbXUzMWNZNURR?=
 =?utf-8?B?MDc5MldmZy9sYmE5b2Y5OE1HNGFvNXBzUG53UEI0OXR0N2NQOW4wNnduRTVy?=
 =?utf-8?B?SkVmSmxNZnpTWGhEeHM5TkdqWlo3V1EvaUROcFBkb1JUTFFST0VKb05iK2FV?=
 =?utf-8?B?SG1INlo0TGJKTmNwRm9EZlR4WXRmZWhIbjZBSVRTeXEyTTEvb2lNdXFvNFdI?=
 =?utf-8?B?bjR5Mm02OEJ6T3crWUdUMFlNNU9LeStKajh6ekliSzFKZ2hQSWljRml6b1VZ?=
 =?utf-8?B?UjB5M1gwTXdyNnplY0MrT3hxQlJ0NEJRejhiV1V6SXU4cENmaFY3WkhWQ3Ro?=
 =?utf-8?B?M0dHQjlGYXBxMmRsN2hveG5ZRlBWWlhwSTVvSWtWYTZUcTd5YnlzSFpyZC9L?=
 =?utf-8?B?bkNTYkxoelRoTGp0WnFhN0dBcWw0UU9talRBK3dZZ0R6dStQaEwwSUNSUks2?=
 =?utf-8?B?MjBHNkN3QXpBbStRMDdUS3l6a1h5WEdXb1IxTi8zb2toMFZlWFBUSHNONXIx?=
 =?utf-8?B?WXVHYlNtdWJVZm1hWEZUemxwcGR4aXhQZ0oweGRVd0JLY3Fwd0hMU1ErKzQ5?=
 =?utf-8?B?YXBWUnFpbEpnVHhhQW56VEF1cllyTFlxUFU0QUUrcTYzU1pReHJqcEZiUllO?=
 =?utf-8?B?NitacVVjcGUrWmMrUU1Nd3VRUWZxemhady9GaU9aazJvU3FqblB6d1FXMTJP?=
 =?utf-8?B?d2FVTU1NblJucnFaVWlEU1dVOWtJNHdsNXdtZ25VVkxNbUVOZFZpTmx1RG1Q?=
 =?utf-8?B?MVpXYWE5bG5TNWNjQmszM040amY0UldOVjZmVWpBdHBHWTk4Smd4NWk5S3Fp?=
 =?utf-8?B?R3Bja1dGZnQyZEdBdFlWY2JybUhEMHZpbnpnSDA3bXFGRDFaQlZvOEIwbGpL?=
 =?utf-8?B?RmdsMHA5eFltQUdVQ013TWVIOXcyY1ZLT3Z3M3psanQ0bUd6NWhYNWhJR09s?=
 =?utf-8?B?enlTemtLekgrcFRrY0laREhRbTNGTjdRZFhNdHZuRE9pUU1WVlBkUnZuTWtB?=
 =?utf-8?B?a1FQUWhhU0prckRqeVAreXNQSmFjbHpoQjhYcWJuRUVkZmpLejMvY0dQNXJH?=
 =?utf-8?Q?HXDYlkOQINR+POOFIHENz6vJkgsk162t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VExGTlZ1dlNKQ2Y0WlVPU1ZhZ0lsWUNqUkt4dFZqdmE1bFZKMjA1amUzaHpS?=
 =?utf-8?B?Z1RoZjhSV0UxSEpESWpIVU83ZTV0eTJPOHlJVnN1KzlldE12enJWMWJNaWd4?=
 =?utf-8?B?OGNZYWFYY1dMdFRLY1FuN0o0QmlLemhvQlI5UnNxNndEVWNnV2VUOWZmWGFV?=
 =?utf-8?B?T0IybnUrYWR2eDlvblZmdFNXNkovOVFQbENFOXd6cG01MWxhaTlJc2l1LzdY?=
 =?utf-8?B?Y1l3ajhJK1lseDZjeGl4NFIxZXh0SWRIYjZvUEdjbFg5Sm83SVJRbEdYWjFC?=
 =?utf-8?B?dXpFZGgraGY1ZlNia1BBaDdCOVF4d2hLcGRMZTE3clZIbmFWdXZjaFFxdXVq?=
 =?utf-8?B?Smp5SHNKTnpMN1dGaXNlWmVMS2ZOY0hYeEIrS0gxUDFiSnlvbUhiUlJpbkUy?=
 =?utf-8?B?RDBGaTIrOEEvU2hyT0piMW04S0RHeEpmcUJqTm1VQjlNaHM0Tjd4WXBpdnpC?=
 =?utf-8?B?WGMrVzZxZ0c5eUdzRkk4QlJsMnIwRmZvWDRhTE5ab28xeUlZR3ZBQXdLNDRP?=
 =?utf-8?B?dFpBc2NiTDFGSDdIZGt4MlYzeWhyalgrYnMrS2lmNC9vK2Z0dGJmTTNkTjFx?=
 =?utf-8?B?cWp0VldsVU1ROVRvUExjRnNlL1p4blZQZVJlNjV2WkZaWHdzc29yaXpUbURn?=
 =?utf-8?B?K29kUlp4OXIyNWtsWnlWRjBPb1A2S0kxS2FueWs1andSWWpFZTM1RlJiY3U4?=
 =?utf-8?B?SGpUTGJVbGtZeFZiZ1pHc0lkZ09VdXYyUDR5UWNtRlk4cFQ1ZFArZWFkdTkv?=
 =?utf-8?B?OGNRNVdmNmRCR0k5c0c2UE9nSC8rWTNkVGVURXlJOEhqTUFNai9yMGNVNnZv?=
 =?utf-8?B?WDV5OWZ3eFJJZnQ3TnRrdCs0T3Y3bjNPRXBVRXdDcVBUdTd3empjeTltYUxU?=
 =?utf-8?B?UTVTZ2V0eDlDOVU0ZkpNVnpVMU53WFFqOFZjTk9pMHpqYWRJUll0Q0s2RGpY?=
 =?utf-8?B?S1NJZENSNlU4Y2tBTmk5ZmdXbU9XV1pFQUFCYjZrT0duTkpvMlU1SjhqeHB5?=
 =?utf-8?B?VEFXamxuMGpiYTdxQlZyQ0JISytlU1RJaFNUSVR0dDNHVDlneXM5NmdhOFFR?=
 =?utf-8?B?ZFlvMlh2eFBZVkFHNkM5aXlpS2tMNXFtbjRRZEtRdXFwL0gvSWJreTdQYzUx?=
 =?utf-8?B?UnpVWnVlRnlaTXdtbmowL252bThXMkFNeTN0cDFJeHlFMDVLNmQ1Mno4T1oz?=
 =?utf-8?B?Yk4za3R6NnNXVy9JR2pYZlA0TVVyaVZzSyttWUQ2TFNISXYxWFZJRTM2cFcy?=
 =?utf-8?B?UUdYK0xwUTFjdWMvdzdOWS9EWS9MVnNpT2dtdytxZGUzdHgzeHdnazJqTXBM?=
 =?utf-8?B?OFRrTnVEdUpUc0JwWW9HSnJqMUZ1SElNNW1ERXNRck9Kc256WUorcHIyc0p0?=
 =?utf-8?B?UjdZWmlXcmQxb01IcVRRYXFySVFuVDY1SzhWd1dOdCtGMWhzZWFiSFk4M0xT?=
 =?utf-8?B?R2FVS3dsTnFhUDl2QXlzdTBZT1RoVVB3R3JjSk5DR3VvUkx4aDl0aTU4NTZ0?=
 =?utf-8?B?NEJlUWpQV1V3a3pQUmNsSGZjL1RPdEg4NUp5Zk1ZcEhFQVMza2xldEk4SzVS?=
 =?utf-8?B?OFJYVUV3bThBelduMGw3N1hIRXpjMUtRb0gwVlNjd2RiT3E5ekV3NHNPMjZ1?=
 =?utf-8?B?cmNQSm5vOGxwcWQwd29WWkVuQ3NYZE1WRmd1OXJ2TWU3ampFQ3RSYkcydzdC?=
 =?utf-8?B?NXFxbUpPSFFEZFlzbFdtaWorU0Z0YkRrSWJVbFhaZWsyc1Bxc0lEdnpWTXFB?=
 =?utf-8?B?OElDNllUTTQwSUcvdWMzeURnSjJoQjAwQ2YwV05DTzZ3dUgvcnhWSlkxWFlq?=
 =?utf-8?B?c01KblhaQ21wa1YvbU14M3FCelBLbWFjRlQveGhsM0pxNFNybFlCK21aQTVh?=
 =?utf-8?B?QitmWld3eTdWdFJ5SGlDZlRBaEczam5YdU9jMklLd0tqWEJJRjRlczIvMFk1?=
 =?utf-8?B?RGt0aitoS051YklkbFpVbGhIK3JYZnZTaGR2bjFnMnFQRUxJWUZaMHpIQ1Vm?=
 =?utf-8?B?MmhIY3NVTFphTW51NXZnOFFuVmM4b0V6UVJ4c0xKbkN6SHpUR3ptV0N2c0p1?=
 =?utf-8?B?ZnlpS09hUTFVR3czSlBvdVlWL1BCcTAzTUhaY3BMa2FXUG9PSHVSeXNvOEZq?=
 =?utf-8?B?Qlg4alU4RUppbmNtSG14VUhOaThwTGV6Q2N4bnVhTUliUGJ3TVlmcVdvYzF3?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f436c5e0-4dfb-4764-6624-08de156ba633
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 15:15:22.8308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAs0paOZYHlQ65B7t5UllsiCpT5YjI9ohmLCTkXlMPCvlkaQjOTr/it1BFbcFucm+hMZF7RFRF6VGGhfEbAyBMOfIDxKyX01sHwhS8THyzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8784
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----B27B63D697593F2F341332F76DB2B9D6"
X-cloud-security-sender:johannes.eigner@a-eberle.de
X-cloud-security-recipient:netdev@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-crypt-policy: TRYSMIME
X-cloud-security-Mailarchiv: E-Mail archived for: johannes.eigner@a-eberle.de
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay99-hz2.antispameurope.com with 4cwHBp2CB7z28mZK
X-cloud-security-connect: mail-northeuropeazon11021102.outbound.protection.outlook.com[52.101.65.102], TLS=1, IP=52.101.65.102
X-cloud-security-Digest:90e281ad5cb96b183a8848c8a5a743f2
X-cloud-security-crypt: smime sign status=06 sign_complete
X-cloud-security:scantime:1.699
DKIM-Signature: a=rsa-sha256;
 bh=ZehNT2EevaU3GIIhQlM670wUFJMnETnO/tpq3i95b8s=; c=relaxed/relaxed;
 d=a-eberle.de; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1761578156; v=1;
 b=LoXCZ8ae/u1aCPOJdIaF6m2d3Hx9MXYgM7jigvP50lFVb05siuPjo7pZAYKWaByhCqpaeix7
 Vy5s0fO5QdmrSiJlLPo2ggVBNuzZhXwBCungXUF3fP6BPR+QspCTjA8zIZL4imhEszyAu9REO2v
 aA3w/ypsU8E1WzG4dn07YV6jVCcJS/bDvI1DpkvJ1f5ZCjwQf1atYF8GGkh4VcjCD5egjhLvqn9
 TgW5G9uFHYLJHILl8Cz1e7UQCHvaubA3kQgBKZ7u+iYca7z63vQWy/z7lCvS+h6okGf/yLmLjI0
 1rpb5GmYbm5AT9Y3xfQ7w2XlndhiH/CNR2Jr2MtrcI40A==

This is an S/MIME signed message

------B27B63D697593F2F341332F76DB2B9D6
To: netdev@vger.kernel.org
Subject: [PATCH ethtool v4 2/2] module info: Fix duplicated JSON keys
Cc: Michal Kubecek <mkubecek@suse.cz>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Stephan Wurm <stephan.wurm@a-eberle.de>, Andrew Lunn <andrew@lunn.ch>, 
 Johannes Eigner <johannes.eigner@a-eberle.de>
Date: Mon, 27 Oct 2025 16:15:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Fix duplicated JSON keys in the module diagnostics output.
This changes the JSON API in an incompatible way, but leaving it as it
is is not an option either. The API change is limited to the following
keys for measured values on QSFP and CMIS modules:
* "module_temperature" renamed to "module_temperature_measurement"
* "module_voltage" renamed to "module_voltage_measurement"
Keys with the same names for threshold values are kept unchanged to
maximize backward compatibility. Keys for SFP modules are changed as
well, but since it was never possible to get the diagnostics in JSON
format for SFP modules, this does not introduce any backward
compatibility issues for SFP modules. Used key names for SFP modules are
aligned with QSFP and CMIS modules.

Duplicated JSON keys result in undefined behavior which is handled
differently by different JSON parsers. From RFC 8259:
   Many implementations report the last name/value pair
   only. Other implementations report an error or fail to parse the
   object, and some implementations report all of the name/value pairs,
   including duplicates.
First behavior can be confirmed for Boost.JSON, nlohmann json,
javascript (running in Firefox and Chromium), jq, php, python and ruby.
With these parsers it was not possible to get the measured module
temperature and voltage, since they were silently overwritten by the
threshold values.

Shortened example output for module temperature.
Without patch:
  $ ethtool -j -m sfp1
  [ {
  ...
          "module_temperature": 26.5898,
  ...
          "module_temperature": {
              "high_alarm_threshold": 110,
              "low_alarm_threshold": -45,
              "high_warning_threshold": 95,
              "low_warning_threshold": -42
          },
  ...
      } ]
With patch:
  $ ethtool -j -m sfp1
  [ {
  ...
          "module_temperature_measurement": 35.793,
  ...
          "module_temperature": {
              "high_alarm_threshold": 110,
              "low_alarm_threshold": -45,
              "high_warning_threshold": 95,
              "low_warning_threshold": -42
          },
  ...
      } ]

Fixes: 3448a2f73e77 (cmis: Add JSON output handling to --module-info in CMIS modules)
Fixes: 008167804e54 (module_common: Add helpers to support JSON printing for common value types)
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Johannes Eigner <johannes.eigner@a-eberle.de>
---
 module-common.c  | 4 ++--
 module_info.json | 4 ++--
 sfpdiag.c        | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/module-common.c b/module-common.c
index 11b71bd..4e9a0a7 100644
--- a/module-common.c
+++ b/module-common.c
@@ -651,8 +651,8 @@ void module_show_mit_compliance(u16 value)
 
 void module_show_dom_mod_lvl_monitors(const struct sff_diags *sd)
 {
-	PRINT_TEMP_ALL("Module temperature", "module_temperature",
+	PRINT_TEMP_ALL("Module temperature", "module_temperature_measurement",
 		       sd->sfp_temp[MCURR]);
-	PRINT_VCC_ALL("Module voltage", "module_voltage",
+	PRINT_VCC_ALL("Module voltage", "module_voltage_measurement",
 		      sd->sfp_voltage[MCURR]);
 }
diff --git a/module_info.json b/module_info.json
index 1ef214b..049250b 100644
--- a/module_info.json
+++ b/module_info.json
@@ -47,11 +47,11 @@
 				"type": "integer",
 				"description": "Unit: nm"
 			},
-			"module_temperature": {
+			"module_temperature_measurement": {
 				"type": "number",
 				"description": "Unit: degrees C"
 			},
-			"module_voltage": {
+			"module_voltage_measurement": {
 				"type": "number",
 				"description": "Unit: V"
 			},
diff --git a/sfpdiag.c b/sfpdiag.c
index a32f72c..137a109 100644
--- a/sfpdiag.c
+++ b/sfpdiag.c
@@ -254,9 +254,9 @@ void sff8472_show_all(const __u8 *id)
 	if (!sd.supports_dom)
 		return;
 
-	PRINT_BIAS_ALL("Laser bias current", "laser_bias_current",
+	PRINT_BIAS_ALL("Laser bias current", "laser_tx_bias_current",
 		       sd.bias_cur[MCURR]);
-	PRINT_xX_PWR_ALL("Laser output power", "laser_output_power",
+	PRINT_xX_PWR_ALL("Laser output power", "transmit_avg_optical_power",
 			 sd.tx_power[MCURR]);
 
 	if (!sd.rx_power_type)

-- 
2.43.0


------B27B63D697593F2F341332F76DB2B9D6
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIQNQYJKoZIhvcNAQcCoIIQJjCCECICAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgggw7MIIGEDCCA/igAwIBAgIQTZQsENQ74JQJxYEtOisGTzANBgkq
hkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkx
FDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5l
dHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMTgxMTAyMDAwMDAwWhcNMzAxMjMxMjM1OTU5WjCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMo87ZQKQf/e+Ua56NY75tqS
vysQTqoavIK9viYcKSoq0s2cUIE/bZQu85eoZ9X140qOTKl1HyLTJbazGl6nBEib
ivHbSuejQkq6uIgymiqvTcTlxZql19szfBxxo0Nm9l79L9S+TZNTEDygNfcXlkHK
RhBhVFHdJDfqB6Mfi/Wlda43zYgo92yZOpCWjj2mz4tudN55/yE1+XvFnz5xsOFb
me/SoY9WAa39uJORHtbC0x7C7aYivToxuIkEQXaumf05Vcf4RgHs+Yd+mwSTManR
y6XcCFJE6k/LHt3ndD3sA3If/JBz6OX2ZebtQdHnKav7Azf+bAhudg7PkFOTuRMC
AwEAAaOCAWQwggFgMB8GA1UdIwQYMBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0G
A1UdDgQWBBQJwPL8C9qU21/+K9+omULPyeCtADAOBgNVHQ8BAf8EBAMCAYYwEgYD
VR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQw
EQYDVR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwu
dXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5
LmNybDB2BggrBgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNl
cnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcw
AYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEA
QUR1AKs5whX13o6VbTJxaIwA3RfXehwQOJDI47G9FzGR87bjgrShfsbMIYdhqpFu
SUKzPM1ZVPgNlT+9istp5UQNRsJiD4KLu+E2f102qxxvM3TEoGg65FWM89YN5yFT
vSB5PelcLGnCLwRfCX6iLPvGlh9j30lKzcT+mLO1NLGWMeK1w+vnKhav2VuQVHwp
Tf64ZNnXUF8p+5JJpGtkUG/XfdJ5jR3YCq8H0OPZkNoVkDQ5CSSF8Co2AOlVEf32
VBXglIrHQ3v9AAS0yPo4Xl1FdXqGFe5TcDQSqXh3TbjugGnG+d9yZX3lB8bwc/Tn
2FlIl7tPbDAL4jNdUNA7jGee+tAnTtlZ6bFz+CsWmCIb6j6lDFqkXVsp+3KyLTZG
Xq6F2nnBtN4t5jO3ZIj2gpIKHAYNBAWLG2Q2fG7Bt2tPC8BLC9WIM90gbMhAmtMG
quITn/2fORdsNmaV3z/sPKuIn8DvdEhmWVfh0fyYeqxGlTw0RfwhBlakdYYrkDmd
WC+XszE19GUi8K8plBNKcIvyg2omAdebrMIHiAHAOiczxX/aS5ABRVrNUDcjfvp4
hYbDOO6qHcfzy/uY0fO5ssebmHQREJJA3PpSgdVnLernF6pthJrGkNDPeUI05svq
w1o5A2HcNzLOpklhNwZ+4uWYLcAi14ACHuVvJsmzNicwggYjMIIFC6ADAgECAhAl
5qzXGH8Da+FSta/hHFZ+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEb
MBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgw
FgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENs
aWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIzMDcx
OTAwMDAwMFoXDTI2MDcxODIzNTk1OVowLDEqMCgGCSqGSIb3DQEJARYbam9oYW5u
ZXMuZWlnbmVyQGEtZWJlcmxlLmRlMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
CgKCAgEAwEFNcbuq7Ae+YCfg2alacqHWh08bvE6bFOZZ1Rxl1w/sFuXUwJ8o+gbB
TA/mmITzst+fnsjwMmrjtCecn8wILPitSD2wXy+yiaWmn8ywuBBw8toRX0xSMgif
KM494f9SSFjJDOgZGmAG+umMO6v5KNA1K0wSWrlZmG0yC0pzp6FFVVyMnp4/vJh3
6BuYgOf0s7KK5ShCQ4mKOD0dOOcMTBFHcQuD8d2Ha9lH5KzF4CVR6W3p+DUs2r6o
WwSPc0MrTqq0Ci9KPaKmvxzMQRZqSqa5ySqyw4guw0vnPYwtS0BEYZM+mL/5BwAP
Uga7nUg/9tjzyEgUY3tmimfWD0UIi9oDHT59n4s5iriWcnZNS5dAWnu7NqEBs+w6
lpWo2g60mmxPULNnwSUYxqdfXn5udIde0boYLKfEy11JC9xkshXBgLPhq4xTkbWs
fkoH+EQyEdep5AhaLeTsJHpw0tp2whpeH9Fwck8tx/nWtudo7bfYZUF4lDtyEHmi
p7UJa6x4LKEO2XFlY5v6ZOfVAm+zqNWEdDGO3bfv3HO5ciIHjXHLVFx/XI73OVsC
aObazBuEcqXafTK9ThLS5Sh4uZ3nLv3n5m8m/UUUKbOmOI7MTId7WlP9hOeNAzEu
SiA/n8VFk4RO7iwajXximGU/0rxuUJtN7RJFumksH7sbO5ypjCcCAwEAAaOCAdQw
ggHQMB8GA1UdIwQYMBaAFAnA8vwL2pTbX/4r36iZQs/J4K0AMB0GA1UdDgQWBBSz
BXMVnJ+omSJdNUgpzP64lg+gRDAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIw
ADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQAYDVR0gBDkwNzA1Bgwr
BgEEAbIxAQIBAQEwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9D
UFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0
aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCB
igYIKwYBBQUHAQEEfjB8MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LnNlY3RpZ28u
Y29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTAmBgNV
HREEHzAdgRtqb2hhbm5lcy5laWduZXJAYS1lYmVybGUuZGUwDQYJKoZIhvcNAQEL
BQADggEBAMJhsGQW6C4UBZr7OpMg/n65GOd5Iy7i3vXW7gO7sgPe1pHYi1LJZ68J
lB9sP93yDViPMJ4Cir+/QqU7AtLyKkf+oo8nQTlx5gQeJnftZ/O6RkCS20I18GxC
aRDRRwD2JViL5Dk9uB87sV5DlOZV8w2VNWh+mm8wZGonaQ3NoNX+7jHcF5QX23Hx
x8ikwfv4jj3qajpv1l362Wl5FySKhdEXB/hhyxLjMfHEYs8PKHnjeWGbMPnqyTtt
xgnK+Gtmc4fjSlRf8Nzpr/q3iPppdSOmVk1lGmaGTJ+7ItiA1OTcFf7Atm8GomFp
QXdyoI/DW3zj355K+YADYhwhosfaQY4xggO+MIIDugIBATCBqzCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQ
Jeas1xh/A2vhUrWv4RxWfjANBglghkgBZQMEAgEFAKCB5DAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTEwMjcxNTE1NDlaMC8GCSqG
SIb3DQEJBDEiBCDmrjzvVlAg/eJ1ghAQnV1d2+lcJ8kUxEYmpXCiBBdQXTB5Bgkq
hkiG9w0BCQ8xbDBqMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUD
BAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAH
BgUrDgMCBzANBggqhkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAgAq6wqoLXVl
xAFg69xNfNrP2JOv1QqMlMr7IUVmaAeS1KBYzAVnIYblv5cFh+Ukkeq8Xru11qX7
H6JAJ0We6cAQ107sDKlqvNwzf5vwk+6KvBNoGn2gh48TTZW+55C6ZHUFGjGdyCgD
J2K/jui6aOiqR5Wp5BouzetImBG9BoMon/heExZbqQxFFngZCu5NY/rIqbr45WD4
8vmKUneOHM24qpixV3AFJFuNakMy2K7j/wmDn4Svtkw0Obgy3gZ7lpSD3ZKkAsV1
FvMLNSSfplDHd8AiDsFmmma80vjbvgLrZ1oDzmRTQgmvjJu14kxnmHnlzv90QU6K
xqIW1hZNnmFSllFBZf7RfmwfQ+6/jpGdZpuSCLkcTcMAyZ47MOW1YHOBCiU/+g+o
3gJgiiKiDXLlefYww+sr58ihWVDaj/70dFeK/phQheGY48Y7Gn6qiG3ROM8TnoNo
lAZh7GdtLUldODWCw8dxTQiA8/ITnlRrMNhNpHDP1Zu+w1RqP8zTakKsBJ9X7IAL
pH1h3rK6fyNj+oMLIYMYtczYIik1yVnSj6+ViEihV0ILnJ9SFx+TwGmplO1LS2LR
8COYTXwyh2uCeFR0kjYviEaVaU6HBzFyTwknb/LMlxUpi3QHnDdGqqnXYmJNMKQu
+PQg3jUskHg4hv+haYEuG2SKgDzWOdwfyQ==

------B27B63D697593F2F341332F76DB2B9D6--


