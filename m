Return-Path: <netdev+bounces-174800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B42E5A60816
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 05:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE2B19C35EA
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 04:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057B124B29;
	Fri, 14 Mar 2025 04:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ms50FIIG"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012001.outbound.protection.outlook.com [52.101.66.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256A22F4A;
	Fri, 14 Mar 2025 04:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741927874; cv=fail; b=bdZ90+dEr60zFMy7wKNlIrfqhFlNDcBS84F3fQdIxolIepgToAdKZ/sBJbbmJBonIUWLOobuYRwLyYT7u6YgGGwpo7tO2Y0QgwGR5d6tD1lSLE3tXccn37pC48DDlWu4lxhu154/uNYSlbmaHm6rHzMiWBkC/8Ru2h4GllArV5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741927874; c=relaxed/simple;
	bh=kzJ3U9UDA6zzuQYSElGp6LHek8PiP1UcowkrpOzw60I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NFmb+ogz9EhZQrHA71IffsWQr7Rj//FBwKJkuOnnytbbvQkRg3mNs8yMZQ+amebnIVLFr5JnGFVXIbyHwGMN/OKpzsS9ScPWBtmQCm+WYXUhlW7t4NeUNa2+YO1jzaSjwjpYPzlh5+D9rNySG1f9Pnr2X1zRDHyttsCwx1eciOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ms50FIIG; arc=fail smtp.client-ip=52.101.66.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJMDs/x+TFC2pm4wVqVBb+cTMKOxHg0arr2EhWHXY0GCtf99WjgCi+k6euo/AWBfncstsxnPU/6lApOOcO9a64+q6kYou3xbNFD9Aojl8RVc4/Wz4TVpzYX2cnak9XWgoP9oh4rIJXsJPQIkVuvICZSGjyY0RHSKw8c0ZkFSJbf5s4brJqrHWLZXhjQxaAaQRpcBd0ECOwuz1F01G1Kqac5mN82hxwhvznr2SW6zRbO7yhcjjPpZuxZvk22Nd1NbsNoVYNB8C76pbSFaZ4N3VMZSRBDdGePnGhbgscEnizHEA/64U0eWp07YZL5PCIeLWzI56At+NVkAnFuu9PFgvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzJ3U9UDA6zzuQYSElGp6LHek8PiP1UcowkrpOzw60I=;
 b=AQScHeFa+SOAzJug6iQSANK6LrcAmJAOkTLGfwWDZpdbGXrknJl0btazMEvC74V4cD236KwCH/iFhsdEMOTeRgexI/w5aQIBS5EORQWO9H/9pXHzjZJSUFfRZypSI8jeBv8ZxRk/sV69kT/9oOxWj0BXRvBFzplle1mtjCgALG2Eh/HYn3akUQGgkIT/pWarWdMiq/sRx5J+UjvQaJd5MDIPzMCI+QV5qkhP02huD28zCfdPOkNV6TArIxs6uE46GVlG2FZ4GfW03T8FCFL3nmwDMgm40sxjeYcllqA0kvn9Ufwvud7NVEtXwd1QTnwt6OlOY0Rdh0J6DiOWCoKZ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzJ3U9UDA6zzuQYSElGp6LHek8PiP1UcowkrpOzw60I=;
 b=Ms50FIIGhvKHs04sKD5xHEms6kzXt12VUxoDKoMjjoXfrL1h0+7RS9Bh8aGCB66S6WOqIhwsgYoTIEvVGgpypsX+2x6pRjxM/Xr02g/sBLR0GcIXJxm1wVfHhlMcGyyUCmtt7ZKXbllI6gy1Cu4LkOsH2m8HvkVWImtqgcizPeIXdwO+7fswUN/6N8HFn6S2meOvJxDQRk8Bn8FHJf3uQ00N9Hvmv1bdpYfLKoMZTvDED438j6pfqjoeTRMnjKB9CzOXuaUZ6I7/xRbGxH0LP2xC4t+JSH0xYe54C6W/faTrrwBXyeejoku/TttpxD8y/ICWJkXAOIfGZkliJBgdlQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB10586.eurprd04.prod.outlook.com (2603:10a6:150:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 04:51:06 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 04:51:06 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 net-next 02/14] net: enetc: add command BD ring support
 for i.MX95 ENETC
Thread-Topic: [PATCH v4 net-next 02/14] net: enetc: add command BD ring
 support for i.MX95 ENETC
Thread-Index: AQHbkkpLRYKdL7a04kCsKfHEkw9g2bNxSx9ggADF3gA=
Date: Fri, 14 Mar 2025 04:51:06 +0000
Message-ID:
 <PAXPR04MB8510D3A2F2A792A89941A7FD88D22@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250311053830.1516523-1-wei.fang@nxp.com>
 <20250311053830.1516523-1-wei.fang@nxp.com>
 <20250311053830.1516523-3-wei.fang@nxp.com>
 <20250311053830.1516523-3-wei.fang@nxp.com>
 <20250313164908.rdy3y77xno3fza3l@skbuf>
In-Reply-To: <20250313164908.rdy3y77xno3fza3l@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GVXPR04MB10586:EE_
x-ms-office365-filtering-correlation-id: c138ea49-0bcf-45e3-6e82-08dd62b3d492
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SlZldkJ3QjNzMHpSZ0Z3MUo5dk0rOVFUejlBQnFZWVFaYVg5MHdzZkZjc29t?=
 =?utf-8?B?WkVWK29FZlhqVTJuQVZoK3pVU3JZS2NHVGQ1QWtMM1BUS2ZodEwrMUFDNGVy?=
 =?utf-8?B?dHBDNzU3NnplSEdhdno3UUlMQkhWajBUTGh3cnM0Y1dLLzNTNUNWMkY1NlFm?=
 =?utf-8?B?ZW1RVThZc0hMYXRGM0E4QStVYW9QMVJVSjRGYjBOUGpEV3pCMmM2ejhjcFFF?=
 =?utf-8?B?ZkRENVNHb0ZhSlRoMzlKN3JpaW9uK1lWUVJCaGNXazY0TkQ0clhJYnlhL050?=
 =?utf-8?B?NDZ3c0p6ZGhFUXViMTg5ZnVmMHV2S1ZXcFZqRU5JUWU4Qmsrbk1iYytyOG1P?=
 =?utf-8?B?OGd5SVQ5YlV3MnlVc0orMmxnVmhsejJyMFUySWZnVDdGeWxGWG8vT0F1Y09T?=
 =?utf-8?B?ekQ1eWZTelZVYzNTQ2hHdE02clM5a1d1czM4OElBM3NmRmRzeUpBVEgxRlVh?=
 =?utf-8?B?ZVFUbGdIN2h2TFhNd0tTeDdCZnNlb1gxVS9HS21FODB2bzNzVk1EN1JmcURB?=
 =?utf-8?B?OFJrQnorMjkvSlF0NUR0b2RxanpoZjlOM1VSbmx3SE5HQ1p4ZmM2OXdGWU5i?=
 =?utf-8?B?NkRuVUJZVlhqazlrbzVmSXNrbEFRbjZKQUpqOG05VEVhbGUrZTlSZzZFU0dE?=
 =?utf-8?B?VEozeC9jYjc2OFBsVE1yRWVMZTJ2SUdSdXZxcDE4bC8yTUpSVnh4R0Yzbk1y?=
 =?utf-8?B?NVlycUVCcC92NG1Jakc5eGhCTDhCN0Fybk1VMGpJWm9xRVlocUx0am1uc0RU?=
 =?utf-8?B?cTZNdmZFZGpFUGF4UG42MnhCTVk4ZzNiQmE5cHVwR05sR0JwTWIrMjI2YmJi?=
 =?utf-8?B?YlBCSmNLUXZ1UitNSERkVGY4aGZ0QURjZVNkamU5NWI1NGJMQlNTa1ErdHdi?=
 =?utf-8?B?SjNYbDBjM2FFSFp0MUZXdGRmN2hLVHBFRnoyWVE4MC9kUnZlOGVwK0hLU0RW?=
 =?utf-8?B?bHpLczNHTHFvanRuK0FkUHRFeEpIb0pTWWtZMUVoR0plRlpUUGxKUGo5NHRD?=
 =?utf-8?B?TzNEc3lpYmlzL0tSeDJpR2tVZEpKSjNtZXh2aXUrU2NBNDBMdnNkcnFreHpr?=
 =?utf-8?B?cVFKdEZYcVNrcG1WNlBGTXlvd09SRGJSc29aQ29HNmxLNjRrWHFWT0ZxUGZn?=
 =?utf-8?B?R29ScCtlQ3B6cFJndjdFVDVzK1Q2NU5odTEvTktmY1ViV1hNajFGNHcrZTEz?=
 =?utf-8?B?NjFDMzhIL1BxNUtDNlgxMlYrNWpLTEMrTXQxdXBkbnFINzkxUmtEK2h2cFJz?=
 =?utf-8?B?RHFyUGErZlE5cU50SEJROHdFb21yMTZZM1d4WVBHenhKa0c2MVpUY0haZUdw?=
 =?utf-8?B?QWlPZFp3c3BxZktNVnF1UHNnRWtSeENyejVHNjRaZEZnWXFXRkMzcjVUOWpq?=
 =?utf-8?B?YmhUcmVocWpYMVFoZVVyOGp2Q3FxeGJHZWx6NVZocmlGdHpkL0p3eGd6WGJj?=
 =?utf-8?B?R2ljL05ZeExBK28xY1pvMXlBN1ZyekNFbzZMNDBlMmU4Q3dUNzVrcnNyalVK?=
 =?utf-8?B?NGxacDFGSDNFTHoxakQwVGlxbDMyT1pocXRSc3Q3bDc2YS9LMnBkci9FYUNo?=
 =?utf-8?B?TjF4dy9UbWVjNHJ1ZWpzWFB5bSsyb2tZZklvTGswSEVmQllqWDVJZVZDNkM4?=
 =?utf-8?B?eTNsSW5NSlRDbDZYYmNCeTh0eTdnSHlyWlJESzJJSWU4c0g4THExSlU0VlVK?=
 =?utf-8?B?N0JpUDROS3hWSUhWd3Z0SVE1OWdiQ3FzeDlRZjlHVlpubXFxc3JUUGdSMmxl?=
 =?utf-8?B?QWVNZHRaRHZ3akhZQm5HSmwvN2JmYXVlcjdwTGdsb0NEeTU2UVBsZGRUMDZ6?=
 =?utf-8?B?cmV3SXRtYi92VDI1bFdZbFAzeHByRnFkYnRZdFlENEk1SzhJN09YYUNQR0Ev?=
 =?utf-8?B?M1ZMZUREZ3huQ2tpVVAvaEVtNEt6QUFLVTg3cnVSRDAzWjlsYkdJSS9CVkJa?=
 =?utf-8?Q?Y5tIL7IFkMIwN6AE+uQtyJLJj2UZqe59?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SlQrWHR4RTI2WnoySElWcXdJTEloSk0zRjZRb0RrNTlTQTk5MGZBTFhOZGF3?=
 =?utf-8?B?LzI1M09aY01CWUt5ME5wdWQrUnFZY3JUNWtiSXpmc0JHTms0ZHRvT2pPLzMy?=
 =?utf-8?B?TEtIS1FGNEtjRUZzVTRaZEZiVTVmNjZaelpXa21sSFI1U3l4ajAyTTN0M2hB?=
 =?utf-8?B?YlpNT3RFeENCWmUrbTNhM2tpd0VueHVocURBcGNVNGRWZURIRnFUd0o4THBC?=
 =?utf-8?B?MUVPcWM0OHBScWtWM01mWHZhcUg2RXprZFYrMkhibE1WSjRMQ1lQbUFRbWpG?=
 =?utf-8?B?RWNyNUFnY2JvWTltbUIzeU9iVzloU0VFUHc0emRuN2QwUi9jUzMydG5VZm1w?=
 =?utf-8?B?WUZkeUxncHM5NlZCOTZIeXA2OWdnS1RxN0FZNkovczFXaG9NVkEwVUNMbmhm?=
 =?utf-8?B?STVFU3gxamVuQXZyQnJtRERSZjVGQXh1VWQ2TUFMMUZ3VWVxVXF5TmZlSEV6?=
 =?utf-8?B?aXR4U0Y3ZHJpU3dNeEhERGZKL3M1Y0dRem1OZ09oci9mNlBqUkRLYUFhaUJn?=
 =?utf-8?B?MGdxSTE1TjcyY01hNmVMSmJnbExVT2NTcU4rZkdZdUw4azEvR0krOWZPN3Mr?=
 =?utf-8?B?NlMvbFpLNmJjM0ZId2RRUU9XYVgxbFE3aXJYUTk4YmNQUks3YUpWcDZTMWtu?=
 =?utf-8?B?aElsNXRXc0FSZUVXNlhFbklxV3Q1Q3l0UzdzbjNlR1J5MkUyc004RW8zR3lU?=
 =?utf-8?B?c3Vsdk1YQXNZQVp6bGRzY05PRHZmTm1VNTl0aWU2N3p6MWlWOVZwKzJOYk8v?=
 =?utf-8?B?VEZsd3hHdG8xOE5mR0Q2eS8ycWdNelJNWjhRQ3F6aUdTcUNRMzc1M1FyZm4z?=
 =?utf-8?B?Q1plakgybmxtTTRlTVFOOHJZWnBubjF4OXVyRjhzdE9nZk1ZSGpuTS9mcGd4?=
 =?utf-8?B?SWxMRnJPbHlxL3BLSjlsei93TkNJQjVCVTJaTXc0b1BCWlQ1MnpIWk5vQlE3?=
 =?utf-8?B?cllBdUh6UDVpcTRXVXR4MXdpbUlMWTFoYUxiZ1EraEJsUUI3U3ZIR3JiQ1Mx?=
 =?utf-8?B?bzJrRHAyTmxMN1pFeVJGY3k2V1hTN3RFVXZHdUMyQVhWT0IycVFOckFxQ2I5?=
 =?utf-8?B?VFlJdE9ncXhlV0tyRWRhMTFzblQvYW9HNnlPVmlId28ySUVFcjJ2Q0hnTDdC?=
 =?utf-8?B?NXRJeVIrOUJaa1huUzZqemh3cExjbE1VZGQxSEhIYUQ5eVlGR3JnRXRvNGJQ?=
 =?utf-8?B?dGFja2tkV0hhVFZFeDVESC9hMDFoWVlsVDhsTmtZbm1CZndXSWJmZDJHN3pY?=
 =?utf-8?B?aW5jUEpHUDFaRzQzMk9zNkREZmtZc2FYT3Vxdm9yNzFwSFhoWTBDeHI2UTdP?=
 =?utf-8?B?aUxRT3VwTVdTTGRWS2dGcHh5QytZRE80S1pVd0RVZENlNXFxYy9xczdRMmI1?=
 =?utf-8?B?MGFMNEFzUXJKdFo0a1BFdithM2JGZ2hGRjZ5aUsrd3ZUais2MHFNR0lSWEtr?=
 =?utf-8?B?cE9EV05RZXFrYlJ2S3BPT3pueTRkR1BVa1hUNHk2Zll0L2kxejJzZUtlRGox?=
 =?utf-8?B?VWM0WWNiZnB6d3lJNEo3VkdwblJiMkM3cXFmbDI4dXRBQTlFeTVCZHNiSVFz?=
 =?utf-8?B?OXRSTTV2TGk3S2VPdUVjWXdURCtDRmpUQWw1dG9KaW43bmhCMEpkRmJBV1FO?=
 =?utf-8?B?WXo5MEV2dm5xN1NtSHllSkZNbDFkeUZINjJLemgrbUQvbFpIOUVjakxmZTZo?=
 =?utf-8?B?Z05mVTdHRXFSWnFwWGZNRndweHJQN3lka1dlUDROUVg5WElVczI0djA4dk05?=
 =?utf-8?B?eEp0UGphcURLRW56OHQyUGw2bENsQ0ZFYk1qVFNIcjFmRExqaWt0NlcvODNO?=
 =?utf-8?B?d0FLRHpFTzFtU3VvbTdwS3RhakZScUxxQjNnNnFKdWNncXA0UUJIT2VlVzhO?=
 =?utf-8?B?Zk5zUVYxbVcyT1RzT0MzSGFVM1NEZ0dQTWFXUm1GUnZRT0V5Mnl3dHVqQjF3?=
 =?utf-8?B?bXlUdzRqQ0d4b2VURnkvN0FtSlFlVkZqb3VjcEFCRk9udkUwTlZzeXBlNTVV?=
 =?utf-8?B?SXpiT05kY3Q1S01Qa0huRzhYTklFcm1zbVJkUmNrS3NEaUFiakFiTHNjM0l4?=
 =?utf-8?B?ZWhMYU5BV2xwdlFNeFlreGRHU0E0K2JDbFV3WDE2bGQ5OFlDbHRKdWRPcklO?=
 =?utf-8?Q?c1Js=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c138ea49-0bcf-45e3-6e82-08dd62b3d492
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 04:51:06.1278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7zYFi22/euba3o0UYy8QLC7FbM8lQfbPsPUNmsmxfrRW49rxVrrxntqny89BVTK4HGyRiqRVVf6Zykwe2R8D4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10586

PiBPbiBUdWUsIE1hciAxMSwgMjAyNSBhdCAwMTozODoxOFBNICswODAwLCBXZWkgRmFuZyB3cm90
ZToNCj4gPiBUaGUgY29tbWFuZCBCRCByaW5nIGlzIHVzZWQgdG8gY29uZmlndXJlIGZ1bmN0aW9u
YWxpdHkgd2hlcmUgdGhlDQo+ID4gdW5kZXJseWluZyByZXNvdXJjZXMgbWF5IGJlIHNoYXJlZCBi
ZXR3ZWVuIGRpZmZlcmVudCBlbnRpdGllcyBvciBiZWluZw0KPiA+IHRvbyBsYXJnZSB0byBjb25m
aWd1cmUgdXNpbmcgZGlyZWN0IHJlZ2lzdGVycyAoc3VjaCBhcyBsb29rdXAgdGFibGVzKS4NCj4g
Pg0KPiA+IEJlY2F1c2UgdGhlIGNvbW1hbmQgQkQgYW5kIHRhYmxlIGZvcm1hdHMgb2YgaS5NWDk1
IGFuZCBMUzEwMjhBIGFyZSB2ZXJ5DQo+ID4gZGlmZmVyZW50LCB0aGUgc29mdHdhcmUgcHJvY2Vz
c2luZyBsb2dpYyBpcyBhbHNvIGRpZmZlcmVudC4gSW4gb3JkZXIgdG8NCj4gPiBlbnN1cmUgZHJp
dmVyIGNvbXBhdGliaWxpdHksIHN0cnVjdCBlbmV0Y19zaV9vcHMgaXMgaW50cm9kdWNlZC4gVGhp
cw0KPiA+IHN0cnVjdHVyZSBkZWZpbmVzIHNvbWUgaG9va3Mgc2hhcmVkIGJ5IFZTSSBhbmQgUFNJ
LiBEaWZmZXJlbnQgaGFyZHdhcmUNCj4gPiBkcml2ZXIgd2lsbCByZWdpc3RlciBkaWZmZXJlbnQg
aG9va3MsIEZvciBleGFtcGxlLCBzZXR1cF9jYmRyKCkgaXMgdXNlZA0KPiA+IHRvIGluaXRpYWxp
emUgdGhlIGNvbW1hbmQgQkQgcmluZywgYW5kIHRlYXJkb3duX2NiZHIoKSBpcyB1c2VkIHRvIGZy
ZWUNCj4gPiB0aGUgY29tbWFuZCBCRCByaW5nLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2Vp
IEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L2V0aGVy
bmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5oICB8IDI3ICsrKysrKystLQ0KPiA+ICAuLi4vbmV0
L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0YzRfcGYuYyAgfCA0NyArKysrKysrKysrKysr
KystDQo+ID4gIC4uLi9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjX2NiZHIuYyB8
IDU1ICsrKysrKysrKysrKysrKysrLS0NCj4gPiAgLi4uL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUv
ZW5ldGMvZW5ldGNfcGYuYyAgIHwgMTMgKysrLS0NCj4gPiAgLi4uL25ldC9ldGhlcm5ldC9mcmVl
c2NhbGUvZW5ldGMvZW5ldGNfdmYuYyAgIHwgMTMgKysrLS0NCj4gPiAgNSBmaWxlcyBjaGFuZ2Vk
LCAxMzYgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjLmgNCj4gYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGMuaA0KPiA+IGluZGV4IDRhZDRl
YjVjNWE3NC4uNGZmMDk1N2U2OWJlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5oDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjLmgNCj4gPiBAQCAtOCw2ICs4LDcgQEANCj4gPiAgI2lu
Y2x1ZGUgPGxpbnV4L2RtYS1tYXBwaW5nLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9za2J1ZmYu
aD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2V0aHRvb2wuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4
L2ZzbC9udG1wLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9pZl92bGFuLmg+DQo+ID4gICNpbmNs
dWRlIDxsaW51eC9waHlsaW5rLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9kaW0uaD4NCj4gPiBA
QCAtMjY2LDYgKzI2NywxOSBAQCBzdHJ1Y3QgZW5ldGNfcGxhdGZvcm1faW5mbyB7DQo+ID4gIAlj
b25zdCBzdHJ1Y3QgZW5ldGNfZHJ2ZGF0YSAqZGF0YTsNCj4gPiAgfTsNCj4gPg0KPiA+ICtzdHJ1
Y3QgZW5ldGNfc2k7DQo+ID4gKw0KPiA+ICsvKg0KPiA+ICsgKiBUaGlzIHN0cnVjdHVyZSBkZWZp
bmVzIHRoZSBzb21lIGNvbW1vbiBob29rcyBmb3IgRU5FVEMgUFNJIGFuZCBWU0kuDQo+ID4gKyAq
IEluIGFkZGl0aW9uLCBzaW5jZSBWU0kgb25seSB1c2VzIHRoZSBzdHJ1Y3QgZW5ldGNfc2kgYXMg
aXRzIHByaXZhdGUNCj4gPiArICogZHJpdmVyIGRhdGEsIHNvIHRoaXMgc3RydWN0dXJlIGFsc28g
ZGVmaW5lIHNvbWUgaG9va3Mgc3BlY2lmaWNhbGx5DQo+ID4gKyAqIGZvciBWU0kuIEZvciBWU0kt
c3BlY2lmaWMgaG9va3MsIHRoZSBmb3JtYXQgaXMg4oCYdmZfKigp4oCZLg0KPiA+ICsgKi8NCj4g
PiArc3RydWN0IGVuZXRjX3NpX29wcyB7DQo+ID4gKwlpbnQgKCpzZXR1cF9jYmRyKShzdHJ1Y3Qg
ZW5ldGNfc2kgKnNpKTsNCj4gPiArCXZvaWQgKCp0ZWFyZG93bl9jYmRyKShzdHJ1Y3QgZW5ldGNf
c2kgKnNpKTsNCj4gPiArfTsNCj4gDQo+IEkgZG9uJ3QgdW5kZXJzdGFuZCB0aGUgbmVlZCBmb3Ig
c2ktPm9wcy0+c2V0dXBfY2JkcigpIGFuZA0KPiBzaS0+b3BzLT50ZWFyZG93bl9jYmRyKCk/DQo+
IERvZXNuJ3QgZXZlcnkgY2FsbCBzaXRlIGtub3cgd2hpY2gga2luZCBvZiBTSSBpdCBpcyBkZWFs
aW5nIHdpdGgsIGFuZCB0aHVzIGl0IGNhbg0KPiBhcHByb3ByaWF0ZWx5IGNhbGwgdGhlIGRpcmVj
dCBzeW1ib2w/DQo+IC0gdGhlIHYxIFBTSSBhbmQgdGhlIFZTSSBjYWxsIGVuZXRjX3NldHVwX2Ni
ZHIoKSBhbmQgZW5ldGNfdGVhcmRvd25fY2JkcigpDQo+IC0gdGhlIHY0IFBTSSBjYWxscyBlbmV0
YzRfc2V0dXBfY2JkcigpIGFuZCBlbmV0YzRfdGVhcmRvd25fY2JkcigpDQoNClllcywgZm9yIFBT
SSB3ZSBjYW4gdXNlIGRpcmVjdGx5IGNhbGwgdGhlc2UgZnVuY3Rpb25zIGJlY2F1c2UgdGhleSBh
cmUgZGlmZmVyZW50DQpkcml2ZXJzLCBidXQgZm9yIFZTSSwgdjEgYW5kIHY0IHdpbGwgdXNlIHRo
ZSBzYW1lIGRyaXZlci4gSSBqdXN0IHdhbnQgdGhlIFBTSSBhbmQNClZTSSB0byBiZSBjb25zaXN0
ZW50LiBJZiB5b3UgZG9uJ3QgbGlrZSB0aGlzLCBJIGNhbiByZW1vdmUgdGhlc2UgaW50ZXJmYWNl
cyBmcm9tDQp0aGUgcGF0Y2ggc2V0LCBhbmQgYWRkIHZmX3NldHVwX2NiZHIgYW5kIHZmX3RlYXJk
b3duX2NiZHIgaW4gdGhlIGZ1dHVyZSB3aGVuDQpJIGFkZCB0aGUgVkYgc3VwcG9ydCBmb3IgRU5F
VEMgdjQuDQoNCj4gV2hhdCBiZW5lZml0IGlzIHRoZXJlIHRvIG1ha2luZyBhbiBpbmRpcmVjdCBm
dW5jdGlvbiBjYWxsPw0KPiANCj4gQXQgbGVhc3QgdGhhdCdzIHdoYXQgdGhlIGN1cnJlbnQgY29k
ZSBkb2VzLCBJJ20gbm90IHN1cmUgaWYgdGhhdCBpcyB0aGUgaW50ZW50aW9uLg0KDQoNCg==

