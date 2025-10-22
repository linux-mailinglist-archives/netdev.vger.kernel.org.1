Return-Path: <netdev+bounces-231695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B449BFCB3F
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7BE1A009D6
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 14:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401E334BA3B;
	Wed, 22 Oct 2025 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b="Dkllv1P9";
	dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b="gU1eXl3t"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay36-hz1-if1.hornetsecurity.com (mx-relay36-hz1-if1.hornetsecurity.com [94.100.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D45F328633
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.128.46
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144799; cv=fail; b=nz4gEQyAFtJ3teqDa3/N0h0OXpCh+WQdGi6O/Z/ml9ftmxN8zfb+X+/vefeiP1OHV6TfF/fn+LExHn2F5wudbAfaaddGSQKL0ycWAwmZQsPoJDtjf2v2UW8noDLPs6EHkfkktzPDWfwmtxYmmFRDZ8bBHJpJo+ErXrRW8Hg/Pbo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144799; c=relaxed/simple;
	bh=b5NKZUG06cqSEHNoKFsMSio7k5SIZZ3Mvxt1VlxOWow=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:
	 MIME-Version:Content-Type; b=rBvgdjsSN39h+DIG7EazRhEYfmuteeJzhKgrLLiObDMDwPb2cGsuKGRfdoI8dxbTOelvvxK5kEPkHeCvL/fZ/s+CbO1a9RGc0whjqqFHRSGLaHWbPc/aV/OctanXBcMlZlBdFbCSLRHdwhhirg68GgilOr2mvvYAC4gd0czTRb4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de; spf=pass smtp.mailfrom=a-eberle.de; dkim=fail (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b=Dkllv1P9 reason="key not found in DNS"; dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b=gU1eXl3t; arc=fail smtp.client-ip=94.100.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a-eberle.de
ARC-Authentication-Results: i=2; mx-gate36-hz1.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=40.107.130.96, headerfrom=a-eberle.de)
 smtp.mailfrom=a-eberle.de
 smtp.helo=mrwpr03cu001.outbound.protection.outlook.com; dkim=permfail
 header.d=aeberlede.onmicrosoft.com; dmarc=fail header.from=a-eberle.de
 orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=ZbKOwKau+5KpOLX+JqrmlGY4Nf8vQn5aKkz0fQrt/xM=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1761144793;
 b=MXvUyQZQLXHK1aedIEbU5BzQiyhnorpdiroK/LkN0akEh2fXAu8aTiDyAy4RVJ31yMFaylzo
 jfNfkNbJYOKcyJwCN0Yx5vbLk5flBBXn0IjjlQq1RgkQZcRDwGPl9zLizl4w1OTYSRQADCM1PQx
 dax6j/89EdaJP3kpyRQuaSdxUW1TNKZeT7h6WVn7cMzXTcdMxwmkwQE5Hy+DuFooQ151fzcRsob
 HZ+WATuecwshwZNIQS6NXbMC5w44JiXdJ24DO0d04QwGsh4smt7pVN9LWbPwTfPHIAkKnX66opu
 xXQpTTLvOs5v5jaCwmyZzEKsnA01y617SNlXFRgQ3XaXw==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1761144793;
 b=E9WRbGCjGMi30ABGvqAYbXHWvaabbWrcU3iOtcsUsLRriOp07Hp6XwqRDbIUmQV1vzTqax7j
 H6fMrXDVc6wvJO6x5otqqht94f0Rl5CKATMzuRKCIMFl8w23JPNG9w9Yh6YD2p/575bktapZU7r
 /X9wSG/1gwJmDaCx62ukMnfQf2+nzSVb6aAjSOMPWR8b7tyLf8ZS7kfpncnRYEkgpFhaAK3HUXn
 XF9F/yur9Ug8iLXLngjDyftunf0YNMY0+Cu9Xwk+sxCJMRi+6rqKNrcXT1oJ0Vaz1tkOgrlzugb
 zVtTvhxWbkMdrISUzwfRP/jYt/Z7HjMGCtVeayXmYapjA==
Received: from mail-francesouthazon11021096.outbound.protection.outlook.com ([40.107.130.96]) by mx-relay36-hz1.antispameurope.com;
 Wed, 22 Oct 2025 16:53:13 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdndQk2R+iDL9M4A8D/2BcOLL8C/4FmvvjrxTh1TcmaFA34C5rDFTjMbIQpipgWV8+KIXDASsh6MuX+s5ruCrRXRyQNiApXOyNSOIJG35wS8dHhtXIqWuiw2NKeQqcSkIAQ7eUpXPoAX8mfSwmizEtdh6NfibiI3u0N20Yrmqg4wDSDjJt7+fhRojxRhkq5E4H0vGfgQ+gmNMv9RxEelQFT6UzfBDVUN8GsoW/E02JG9YIyOhOzhUiB+B3T5GbDdpZ8sXHmC8O3vpZdOfcuNS0yX1GNlBa0gXdgYFS+K9Efzea9SXh9H5KMBQkchGrQN9HjF3qieqgMIAtr00fpQTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlTb8mPh/EX3WpTPV+3fMnKvNa42P+lEsVChnArQD2Q=;
 b=tAhPJ0ZHpKs2MiBe3jheoXz16L6ytkeR4L81lSZofkvLGN1A5X44B7GJHyyz8MgIDIszbSetxLYf8EkcxPJZ4X8dfYEB7DERySHrLdTeUWncMOsWcWrvGmZ6s0noNRuzoXhXauf0dmL5S1JfW9LXkHiVr9laF5aQxDks686mCfT59PW+DmfSZYwzcc1a84y1iRGAKO+SsVMGtI+Ru09oq/s+YCLTARzE/zXLW8Ab+o0WwwyNgE0ZC7u5GK3zT8kKtdxLUrGmfVgm7XHCWa3AY04H4xUuD/BJwllmb0aafMzN5gyDczOcUz/jbNjlOY+M0NPdDikzTCBRCkl53ztHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlTb8mPh/EX3WpTPV+3fMnKvNa42P+lEsVChnArQD2Q=;
 b=Dkllv1P9WLyqhsCmAM5fxT+IYc8FG5SSTVWfH/XyjINcugTyGX4B1iqE/jW/2piudS4mfBwwcmc5Wbo/cBrkmJbeRV50PYtS6ZXmojuldKjx9GhMv4J7H/4xYcaY9IDHb6SSosCPeALPp7EJSL/GfKB5hwVVUNPs7gBbjEAUdt0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17a::7)
 by AM8PR10MB4036.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 14:52:52 +0000
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856]) by AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856%2]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 14:52:52 +0000
From: Johannes Eigner <johannes.eigner@a-eberle.de>
Date: Wed, 22 Oct 2025 16:52:43 +0200
Subject: [PATCH ethtool v2 1/2] sfpid: Fix JSON output of SFP diagnostics
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-fix-module-info-json-v2-1-d1f7b3d2e759@a-eberle.de>
References: <20251022-fix-module-info-json-v2-0-d1f7b3d2e759@a-eberle.de>
In-Reply-To: <20251022-fix-module-info-json-v2-0-d1f7b3d2e759@a-eberle.de>
To: netdev@vger.kernel.org
Cc: Michal Kubecek <mkubecek@suse.cz>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Stephan Wurm <stephan.wurm@a-eberle.de>, 
 Johannes Eigner <johannes.eigner@a-eberle.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761144770; l=1235;
 i=johannes.eigner@a-eberle.de; s=20251021; h=from:subject:message-id;
 bh=5aY3/WskpR1BUZnU5kcG3RtLPqTdOVVjvwNPWSVBW/g=;
 b=ymP3jTdoKO1L3AlN+INQwpYrALnMa3DvxHDy7vB62j4m7eCVHoHE+OZpgZomyxk4YkwJsfTSV
 tZh19Y++xSUCjeTBrJUHEIOl/bDII0by7HMbhZuurztjqzohzU2ZAwA
X-Developer-Key: i=johannes.eigner@a-eberle.de; a=ed25519;
 pk=tjZLx5Tp2iwCN/XmbFBW4CrbjZnFMF6fyMoIgx/dEws=
X-ClientProxiedBy: FR2P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::19) To AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17a::7)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3873:EE_|AM8PR10MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: 588650eb-6beb-484f-a971-08de117aacf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXhRdSs1L0F4WFE5NDNBTW5PalBNMXBBMEFxYWQxM3Y3TThxY2UrSEVneG5I?=
 =?utf-8?B?ZFRpc1dZRUhIS1RSTnZ5QW9VVVI4WW5hcUR1MmdjaGRoVzRJYUtLUWhCNEtN?=
 =?utf-8?B?cjZMS0NFQlBoZWtEOTM1Y1hLeHBvK3hrdzJFTjRCNG0rSUc1R29nUmtRd2hC?=
 =?utf-8?B?WU9wcyswbklBbU9KOEFUUTFEa1cwTERYWUZsNjFNZnRLWms2N01wekV6dGIr?=
 =?utf-8?B?eXkxZU8vMDNQZUgwL2Yvd0lGS2JMOVc0alRaV3V1aVZFSVhLUWhJT0RIUDlt?=
 =?utf-8?B?WUxsRDdtZzNBWjltckVHUld1NldwaVY5UFc4SUR4Y1FsekJZK3NHdTJnSVlH?=
 =?utf-8?B?Z2hJZnNDbk9tQ0JPSjJYSFgvNkFJM2FWMFNBUXd1SHdrUlhKVHJiQXM0aXk5?=
 =?utf-8?B?azBrRDBUVVd6ME80d1o2Y2NmUlBHcm9JS1p1NW0wek85cS9kTCs4aW5EdWth?=
 =?utf-8?B?VW9JY0VzYnh4S2o4MzNsQmlRaUdmZ1ZaditlcS9Nc09NOG1Gbzc3QXR2QWtW?=
 =?utf-8?B?U25GVE5MbVZnV2JEVzFPNmM3RGNHakxBVXYyYnJadEZkZUI1cHZYZ3h2bjlJ?=
 =?utf-8?B?QWNhK0pJUFhxMWV1bm8rSGxuZ211bnhUZy9EZUJLMGtDR2wwd2p4aDFOTUY5?=
 =?utf-8?B?NkExSmdnY0p5eS9qa2NnK1c2N3pMZlpOTnIvVWwyZjJLczNaNTVWQVNVT05t?=
 =?utf-8?B?UFh0azFuVmNWSnF3LzVYdGFjdFhuSUNhYWhJNFk0dmFEaGIyRldJcG5aZUxq?=
 =?utf-8?B?Ti9GL29rNCswK0dHRzUyYWtKRnBCeDhqbHU3S29meHRNNFhLcGFFcGErUVRP?=
 =?utf-8?B?MFZrNEJCcm8xYWlhS3d4NUxVZ1NhaDg3ZVdvdDl0NmxHK0IxeWlHQ2U4bEtF?=
 =?utf-8?B?YktQcXFZS2lSVkpTcWpCM1B4a2o0Nm9iMmVlNnBaM1FCV09NVytRY2FLUWFi?=
 =?utf-8?B?RVUxRUkwUmdzRUVSRXdtTjY1NTYwaXRSV1RwMGtUTkVOWU41aFNrWkplU3Vy?=
 =?utf-8?B?RFRwSGQrYUk1Si9kSjRLVkY0Z3IxQ1NSTDh5WDBadmhIelk3cC90bGNXb0xS?=
 =?utf-8?B?M1k5TkloYzY2UU9BZXVJaUdpeFlXb3lyNm1qOURXMFB5N0FLOE9aT3I5Y2RC?=
 =?utf-8?B?M2duVWZCcTV2Y0wzeGgvUUZsaUhMVFQxRWZLc3RTUUJQcFh2TUIrQ0diR1Vn?=
 =?utf-8?B?a1ZITWE0VU5rWkdHWjRQNHdVL0Q1Zngxbk1IZFJsb3ROYkk5VVo1V016TDFs?=
 =?utf-8?B?MFVvQjFtREFjQW53Y0FJZWNCZnYxVy94MllWQ1hTWFliMXNUQnhYbFlHcEhB?=
 =?utf-8?B?ZXAyb1V5b1RhQ2VWak1LNzRqTFpIWk5LRElSeWxxY1ovYUdyM3BhRjVsYU44?=
 =?utf-8?B?R0RVTWlhazdRQ1c3RmY1bWtyRjlsNHJPbGp0K3AzeWZtdHhKTW1GaW1QVTNY?=
 =?utf-8?B?ZVdxc2k4NVAvT1RsVEVTcGxsK2lJcWlvdU05dTN4SkNaelhreTJvemxuRFQy?=
 =?utf-8?B?TFhyRHVoZEtXaVcyK1RKcVRlb213bjQvSEFtdVErMEVLYXVFdmQrN1ZOOWRR?=
 =?utf-8?B?Rk1rZFhyMnkvRlIzd3AwaThId3ZEemsvUE53bmIvdUxMWDlWS1RGQTM2eUlM?=
 =?utf-8?B?bDhERndVRXhoOVpKTmQ4ZG1iUXVjR0grdStEaXpjT1I2bXN0dlM2c0k4dnVI?=
 =?utf-8?B?ZytIbGpXNzk1WUdkdzVzM3l3a1RZbUNOYUVRb0NhRmpDSFN5NVVZQVR6SHFS?=
 =?utf-8?B?cC9lZGs0U3VGTUo3b0pXbi91L0U0anRvQm9sb1hZOEpjaXlQbWZDU0M0U0ZF?=
 =?utf-8?B?UkdEYWJLd1d2WmF0RW1lYUIvbWVmZWk0L0FieGdhR0NXaGUySElrdU5objhI?=
 =?utf-8?B?NVlCOGxENVU0QlIvZGRscnVINUVWSVkwcEtyTzVFOTVpL09FT0ZBRjdNK05j?=
 =?utf-8?Q?03QWuKUNNieVmx8UedEMxsILhEpM5DnN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3h1N0lqUmI3QnVNdzRScnQ3MWZmb1JacjNSOHN0WlRYdWVFWUFPRmJVYStk?=
 =?utf-8?B?ZGRZUzY1dFBzeU5vUGZCY1VlNS9MN0ZWTFZpOVhBeDNpQ0VzREtIcXJIS08x?=
 =?utf-8?B?bE9Rb3UvWG5pUUVTWkFaMDZGVFVwK2dmZDZUT2s2blF4YlpRVFdBV2ppdDEz?=
 =?utf-8?B?UXRrWmpNNlFzZXgyK2tPMmpYU2orRVR5WmNHZEpsMFl5VjZ3U2NsakdFSjZN?=
 =?utf-8?B?TEd5bTFXcFdlaDhMbk9hejdCRUdvRHRiSVZDektraVdGeVFLS1FLSm9xVlVu?=
 =?utf-8?B?bzdJYk5WYlJQZnhyYytBYy9pMFhNNEZZYjVGQkJBNWlSZk5lNEdGZXVoLzYr?=
 =?utf-8?B?OUZ6dUpsKzlMVk5uT0VqMEh5bjBRRWpZOHhKNWRxaExqYmxvTFdweFlFSllB?=
 =?utf-8?B?TjgxczNLcWV2N1dnd1ZVQ0xVMmFHWXFVQ0ZTUW9sUkQyRDJwQUMwd0ZmbkIz?=
 =?utf-8?B?Z2pWYkpnUlBQWnV0Yyt5bEt0UFFDK1o2eXFZcnc4dGR6cFBpVGhWZ2d0R1Zw?=
 =?utf-8?B?aDhtNjlFQ0NaUXhtNXl1VWpSMzRPTTBWNm5BMGZ0VldFWm1WR1BTVDdKc1ZR?=
 =?utf-8?B?cnVHeWVSSWRMbTVnT0o5V2V4R2ZkK1lSakJvc1NldmR0eXZvUUhXYUFzMWFw?=
 =?utf-8?B?OWJEMTdKSXVobFI0T0F2THN1dENoeUZ6ekhtcEw1Wld4V2JMU3VpMG1PRERs?=
 =?utf-8?B?M2ZiLzNaNkZaV1psUGZEV3ZmS0pvZ0ROcTl1M0xKNUxzSENvUnN5M2VBTitx?=
 =?utf-8?B?a3lpNVExaW4ybU9OZTlVWTBkM0VtSnlid1lBVk4wZW90QUpHT08ySnFObDFK?=
 =?utf-8?B?d3pkcFgwT2JuUW96YmM2S3ByeEl6OW5lb3AwUFUwNnB2Z3FuN2g3OU0yaWJx?=
 =?utf-8?B?TmVRNkIwNW5LYkQxQVV5WUJWclBVTHhSSjdRT1g3Ym1zK0IxdDVaU3dSeXcw?=
 =?utf-8?B?QTJiKzJ3TXBqRjk2cGNNaXVNZVhhelkvK0pjbUtwNEEwL0JRMXNLQjNLZjRM?=
 =?utf-8?B?OTJwV2NKZ2gyaUp1ZmNjZm1hd3A0QWxWNkMrbGZaUkpoQmZncU56QkNLK1F4?=
 =?utf-8?B?ZGtEUHVETWJxQk40RHl6M2tra045Qm1wQ2p4aDEvQlF2OFNVdWR2VXg0Y24x?=
 =?utf-8?B?OG5EZmxBYW5YUTg2OFgrQU01U2F5UTY4MmQyT2dyczhlUmNMWDlkcFhZWmNy?=
 =?utf-8?B?a0N5cjBaZVlmdHJXUjFyMi84NmJvTnBjTzZEeEVCQkVuSCs4cGNQUDJWcDVa?=
 =?utf-8?B?K2FUVWtZU3BoeS9jRmJveDEvcG5FclVlelA3SDVZSjdVNHZrYlFqbTJrZU0v?=
 =?utf-8?B?amNnamQ2ZW0xTW5uNEhSZkdXMHVxZE1KenQ2L1RhUDdxSlRHaGxpRy90c29R?=
 =?utf-8?B?elVvZ2RBeXQ3MEIxNnlWa2o4L05oVW9xcVRVdlBQRS9YdURoK0IyOCtKSk5E?=
 =?utf-8?B?cENNV2dFT3hSbm9SU3QzOUFGTmIrSU10bldvNVFPT3IyaGJhdmthUEtBSmM1?=
 =?utf-8?B?WU1XdVlDd3FqcEZBTDdabGVEMTZLME9FVGVhVW1BaDBkK0l5SjhEWDBNdGlF?=
 =?utf-8?B?ZXNFM3hiVEk2YjBkYUFJcWlmQ25PN1huOFVMZlNUbmNFQStMNFZEQmVseENZ?=
 =?utf-8?B?RTJxYmZLVTRXSnpFaXowZlNqbnA5aWVBUE90QTUweHNyTVBpUEhtbzk2Mnlu?=
 =?utf-8?B?Nm9lOFhNZzhyVjNTejA5RTJuSkdJVXgwZjdnTXNvS1FlaXgvWTV2a01SNGcz?=
 =?utf-8?B?bVJmTVBjd1I1QldEb3NCYzljRnFQcWZXTkJmd0dlS0NWZEJOQlliUHBvSHls?=
 =?utf-8?B?VGdibVdhQUQ2ZmFBUlp1RTdwbDd5ZmZ4RHdaaGJNaW15Y09KMUFERTFxdVNC?=
 =?utf-8?B?MjZuRUd3Ykh2c0tFZmZEa0w0SUgrR1NkZEFsT0N5Q2RITVhCaHl1VGFnNjZN?=
 =?utf-8?B?U2VVdldjL3hhc2lEcFF6a0dSNTVtZUk0ay9NMzVRZkpUY3lncURHVHF3Wmh4?=
 =?utf-8?B?WWJyajZSZzFjNmRGSSsyaFF6OXF0ZThDbGcvbzMzb2dENFJIZm1UekpoUFNM?=
 =?utf-8?B?TFJ3OVRZTXcvdGNoVW5QSGVyTjZabUNySnhURmtxQ3pHRGxITjVYaVFHbU5l?=
 =?utf-8?B?TTRVS2dkQkNhTFUrUWE4ZDlMT203MzE4ZVFqL2E5d2d1UUZSc1FhVGFmTEc2?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 588650eb-6beb-484f-a971-08de117aacf1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 14:52:51.9413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hdm+Y0Jyrqi4pU1eTFpCYAWiO0f5X/kryADqL+J4ozeU4oOeot7JPvw/VkUehYRB4+wF9h2+AMXitjNgOEBas3XVH0V/CIv9a3uih9gieMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4036
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----0654DB31EB0DB32F86F28765284825D3"
X-cloud-security-sender:johannes.eigner@a-eberle.de
X-cloud-security-recipient:netdev@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-crypt-policy: TRYSMIME
X-cloud-security-Mailarchiv: E-Mail archived for: johannes.eigner@a-eberle.de
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay36-hz1.antispameurope.com with 4csBwv2pgzz2HYnD
X-cloud-security-connect: mail-francesouthazon11021096.outbound.protection.outlook.com[40.107.130.96], TLS=1, IP=40.107.130.96
X-cloud-security-Digest:706502a75c106868ac90d18dc49d94f4
X-cloud-security-crypt: smime sign status=06 sign_complete
X-cloud-security:scantime:2.078
DKIM-Signature: a=rsa-sha256;
 bh=ZbKOwKau+5KpOLX+JqrmlGY4Nf8vQn5aKkz0fQrt/xM=; c=relaxed/relaxed;
 d=a-eberle.de; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1761144793; v=1;
 b=gU1eXl3t/KN2otHaYNfdUfbUUADh6PeyDn45Fhv5wUM+QDSmZUb3hxcj+dp6PxeEfbyv0XXN
 xsaDUV2Ayh8FlGHQ0RJEWcr55Gk9cxWw6vaJtqsYyrhp4bWc+er4ErClGhdGPX2hKRXpIFYu5sA
 hHNOSdfMpVemPOAJvJTaD/NHMoaJnpbyLMgP1AocWnHMibEaPemShTOtAJgm0o/KQMFX2ACiky6
 hL6amEMzBahY2LrZuGCCvFAQTY4Bv53RJGsc5V40yapWbKBxj0hgPX1pMNlIcet2noFIfd76ihP
 exvmbLkQLscsIna4tjEs+Lt+U/RyVC5FmGqHeA98d6Sig==

This is an S/MIME signed message

------0654DB31EB0DB32F86F28765284825D3
To: netdev@vger.kernel.org
Subject: [PATCH ethtool v2 1/2] sfpid: Fix JSON output of SFP diagnostics
Cc: Michal Kubecek <mkubecek@suse.cz>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Stephan Wurm <stephan.wurm@a-eberle.de>, 
 Johannes Eigner <johannes.eigner@a-eberle.de>
Date: Wed, 22 Oct 2025 16:52:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Close and delete JSON object only after output of SFP diagnostics so
that it is also JSON formatted. If the JSON object is deleted too early,
some of the output will not be JSON formatted, resulting in mixed output
formats.

Fixes: 703bfee13649 (ethtool: Enable JSON output support for SFF8079 and SFF8472 modules)
Signed-off-by: Johannes Eigner <johannes.eigner@a-eberle.de>
---
 sfpid.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sfpid.c b/sfpid.c
index 62acb4f..9d09256 100644
--- a/sfpid.c
+++ b/sfpid.c
@@ -520,22 +520,23 @@ int sff8079_show_all_nl(struct cmd_context *ctx)
 	new_json_obj(ctx->json);
 	open_json_object(NULL);
 	sff8079_show_all_common(buf);
-	close_json_object();
-	delete_json_obj();
 
 	/* Finish if A2h page is not present */
 	if (!(buf[92] & (1 << 6)))
-		goto out;
+		goto out_json;
 
 	/* Read A2h page */
 	ret = sff8079_get_eeprom_page(ctx, SFF8079_I2C_ADDRESS_HIGH,
 				      buf + ETH_MODULE_SFF_8079_LEN);
 	if (ret) {
 		fprintf(stderr, "Failed to read Page A2h.\n");
-		goto out;
+		goto out_json;
 	}
 
 	sff8472_show_all(buf);
+out_json:
+	close_json_object();
+	delete_json_obj();
 out:
 	free(buf);
 

-- 
2.43.0


------0654DB31EB0DB32F86F28765284825D3
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
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTEwMjIxNDUzMDdaMC8GCSqG
SIb3DQEJBDEiBCCiR8VbhgDpRrectyvrKUw5fu6+Y1mXuGxLza7AfltwFzB5Bgkq
hkiG9w0BCQ8xbDBqMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUD
BAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAH
BgUrDgMCBzANBggqhkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAgAW5v0xXvtD
pBK8nLZRez0PkoB/7hF3ZduNJ28UrnV7gEkzGM3Bd4QcxkeFN3zaGGr2jRVyiHBf
pDkGQvnBp770FdSTNEqlEPfWp0ZtiZUFsP+ZCd8uTQAe3esKkjRpwZ4P/SFUzxjZ
CdEE1eNdEXFSoxpDGn9KhXetTi0YKB4jB8w99fMAy6A7PG8/yvrkWZHhKk3DNqfB
bdfKBl7xb/btMpBZnVEVzQ+yiFEHxj5spGqPgWYvdVWJNcmcbhxe31zAm5E5+JFX
jWw4UsuxWxWqX4jB545E4DROGdZ1U1Mkm+CosNDebJXObENXsWvS9wOVxnDN5pGQ
oyZy6EVh+YBMnWxzb87EuAOvFfXVWiBc3MZ2mjk6/CBwtQka1iP79grWM10LcthF
qVhf722KHIWBcnduSh2sS0G/AU7bnLgzZkqcoAMJ/hqq3qZ4GFcjz6cGMckXW7Zx
BwEYft0zPqe8GT0BNa2FKRxrNvKxTHH/wcKchwPuMxXQtKN6OA3DEk90koWQoPJ/
kHm4TgxMf7VbE/2ykJCle+Ae+GDLYmlOydT4CkLbMDznjJJlZU9baPGatbqDyqPP
xKrxOBQTquSA0bUqhC7LlQHgbvHkkqRb6ADbFL0W/L1u7tPiQF+YREdwhNtsdpfS
0PkyEZ4ETaD1F5qYTdsi/Mbmd/ziudygSA==

------0654DB31EB0DB32F86F28765284825D3--


