Return-Path: <netdev+bounces-130790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD71898B8E2
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE80280B91
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951C31A0702;
	Tue,  1 Oct 2024 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AnFvWQn2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0B71A01DE;
	Tue,  1 Oct 2024 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777046; cv=fail; b=UZEqJv3jt1sKZtbqYQy+9rSN94AQvRvyhkNQON+118J9l6XDyos68crGwcr2U/skEcdwDYsOBfC0eotx63JbYTX3FRVSNu2ndW3PJ60dwbP/ktB4MZgu9Z54+servxKMJjtZRQpxqyGrjV7dffCCo93dmyKrdk764neMhd6vAz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777046; c=relaxed/simple;
	bh=N6NW0SD4vzsxB6Vk/2UBNr/eiJqAKjYFBJeditUVAo0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eJWgtcBzWdKvA+YXCefYsoWO7QrIaHR72q6E13R8F+m3yUv0lRQjDRaNGOulEsjNjUG2mP3twKRJf/C0h0917oWn3gf1zRNafrh1c4Rt/H8I/PMBGPqYVf9Zm56Bj19l3nLLvOfR+5YJMCUrr22dtHrULlQ/XJK8NvqtMxqXh5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AnFvWQn2; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtEBb9DXZmcLtE8MwODqcEVxkSW0GDc1DgZBuyFAOvX8IAQRMs6J+N8jXf3RpWmO7MCBTTkmPfl5tAuKUbbKs2+q6VJ5xeuO4TFT+nBF5nr/kMcUoobvh4b3Pi3ccIUgTNu47NOJQnDf2pCmwefi8x+q5OXRkkGrULnFTu/z6bWvOcqtwP1tiRcFPlG9DDpnQoJ4STG8XW8L+U0q04HJh6HvcgP5B8RVa5d7dHjDiavYG7Rq6nomiY9+QlysHe9nKD6WPL9yDmHLobiepo1wasc+r5nE7A7HlV1YMJeFE3XE3UagoFvydCophUE7zUTs97L5weDumjzn8TfzYwOorg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6NW0SD4vzsxB6Vk/2UBNr/eiJqAKjYFBJeditUVAo0=;
 b=BzXaU6fiHnWtkCvTP2DYi9AKXPNvbc38ggd0SHt/84mql8g5deNbHnO/+4nS8IIN9tHjvYVlrigBD+puYEwiRbwBDHs7Nw/evsxN+FVMikacIDYeZyeuVqd79GH/eSd+Qe0dOdFK+9wtgjIMe/6jD/6PXKmvslM5NFqrbV8c02PJd3TBFumQJqo/1T1GxYqDF3RX4Cc5VUVs4jvblmwlPh2pe8WKWItjuQWA90Elk3O7/kSlD5MP7sCSNjgkR6Dp4zMiNckU+K/lSx8hf+8ilW9WdwPH772L98ZwfL4uMBi9qNNpTxqVycoKGxs5N2h0H7VqIysyewxBcOrm8FkzPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6NW0SD4vzsxB6Vk/2UBNr/eiJqAKjYFBJeditUVAo0=;
 b=AnFvWQn2K0maEt34U3WWV5cRdyZpiSGGtWt7om4WdQPp4rVUcZ/EsN1BKqwBeAt4OaQuj4rGw5IGW1c8ZFTmT7cYZo3DFVumoL7nEZIT8wXTUwgPiack0s4F8TAwXpC4nJx8N/mJJ8JuApJ0h/WmCdH3+G9csT4yjuUEGvtRJD96win2ZmhextM1FnpaQMZ44CjuxrZ0cMqDerruVUHS/IMjv6Y9WwzNboGk03ah5gkSE62187soQ0PvWSlSznezfoIILG413oo3VNMdxwaVY1hhhOz+3oR1ezYA9q1U+1M1q7dydtS9E2cw+sOr9PBupMeZIgj/6Na+RHmHjsM67g==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by SN7PR12MB8820.namprd12.prod.outlook.com (2603:10b6:806:341::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 10:04:01 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 10:04:01 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"yuehaibing@huawei.com" <yuehaibing@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Petr Machata
	<petrm@nvidia.com>
Subject: RE: [PATCH net-next v3 2/2] net: ethtool: Add support for writing
 firmware blocks using EPL payload
Thread-Topic: [PATCH net-next v3 2/2] net: ethtool: Add support for writing
 firmware blocks using EPL payload
Thread-Index: AQHbExVasWsRyaaMDkiPw4U40K5hrLJwiSUAgAEi4aA=
Date: Tue, 1 Oct 2024 10:04:01 +0000
Message-ID:
 <DM6PR12MB45167DD7F11B0CF99E0E4622D8772@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240930084637.1338686-1-danieller@nvidia.com>
 <20240930084637.1338686-3-danieller@nvidia.com>
 <20240930164154.GG1310185@kernel.org>
In-Reply-To: <20240930164154.GG1310185@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|SN7PR12MB8820:EE_
x-ms-office365-filtering-correlation-id: bfd7d8d6-b449-4ae2-27d7-08dce2005fb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eDFUOUd6OC81MTVMeXl1QjJDSFJwNVZETXZCT0E2bitweWc3aXlJemtzb0Vn?=
 =?utf-8?B?Ti9xNy9BOGtXRDlMcTFYdjZYS3BjdU5EUk5uenhQaHRLWHVwWkk0VTFTZXFH?=
 =?utf-8?B?aUxGS1VBeE4rd2hiWlplOG9mSUxsaXV2RThYakpwUU9aRjJnNktwVnUxYVQy?=
 =?utf-8?B?dEl6TUdQelNjQThjckwveUkwNDIyUWlIbGo5dkFSRytOcjUyazRuZ215K2VW?=
 =?utf-8?B?bncxLzBnMWt6ZkhVY2VSSTNRMTBCQ295RE96KzJUcVVDY0MzSUVvTHRMaE5G?=
 =?utf-8?B?TmUzMngvYURQZkR5YW55bjZ4NFNnekU0UU1Xa0lGTVNVREdSd2tRSWpKZitM?=
 =?utf-8?B?Yk9mbWtHRHVQYlQvK0dvRHhhc1IzOTFMWGZTVitsOEtXQXF2RHNqelFGYUJR?=
 =?utf-8?B?ZFZhNjM5R2hqUWcvTzhndTd0NThQZUlPVXVFblpzMFJROWJMM2tnVnNvS2Nr?=
 =?utf-8?B?Z3I4bTBtMS9lK0dqaDRNSVNFM0tCWHZraDkralpUclFQb3FKODcvL1U4dkVs?=
 =?utf-8?B?UEJhamNualhEVmJ4cXlsV2NDcFhLV1ZZd3dVdjFxS1lnaGFxaHk5WnZUZHE1?=
 =?utf-8?B?YWJMQUJwUURSc2ZsYnNWRHJwNjJpVEh2SjRqM3JIZEY3WGxYdHNvb2lKbUFz?=
 =?utf-8?B?WkphWEluQVVzdmt6SUQ1Nms1ZU1hYXVTUkVsbkNtNEdMUzl6MWlRYkpwaHBF?=
 =?utf-8?B?K1E2Z21iSFNud2xjZHJVT3NvZllRUFQ2SjEyeU5JU1NBWGNpYjgxMjJROXJs?=
 =?utf-8?B?WWlPa2ZEOTZ1UytpcE9hQTY1KzRKQWM0RTJidXNFMjFVUHJPbGZLb1hWTyt2?=
 =?utf-8?B?Rkpybk5pRjNLeXlMb0YrVzhROXIrRjFjUGpjUUhzT3JmbG5kK2Q5d0VYMStp?=
 =?utf-8?B?UGRpclFWeFY3NkJxL20rVE4zeTZpNDFBQThsd2hYdlM0ZXQxbm9KaEdMdFB2?=
 =?utf-8?B?NlhRQ0xMSTJDZmNPYWJ1OXVkUUNOWERPdlBJeVkvUFJHNkR1eEpXbVNLdkht?=
 =?utf-8?B?R1Z3TjQ3VDIrU3ByRnBxUllqSFRNVEpjdFBSdWYwNDFLNHR0dUxyRzFXQkh0?=
 =?utf-8?B?a25NcjF2djYzSlBGbXlabjhFaUlZUzl0Qk9DQVdjU09OSHdycVp0SjBNaXVL?=
 =?utf-8?B?dnJKUGdtanFKRW5lWFBpSXR6ZzRTbWdCTDd4SHNwY3BpY2FsNE5WS2taMG8z?=
 =?utf-8?B?c0U0a25oMTN3MkJCNW9uNUtYRVd5amJhZ0tpeVhrWFBVWFJTaHByc0tTVVll?=
 =?utf-8?B?WVJmVnRlUkpBUWZLdnlGcnpKQmdacVNGUStabnJNY0RmT0U0OFR2cWI3ak13?=
 =?utf-8?B?bkNIVklRTnpvNDN5czZXMnZSVmRETmpIaGU3eExoSFd3dHRRWDd5cUtpOWxQ?=
 =?utf-8?B?YjlFNjFnK08yS3pwbUVGcmtTcEJLeEVTNStpcU1HYVYvOUpDM29lc3c3bHZI?=
 =?utf-8?B?ZDJtL2V5cXBleXkvQkJBWVRpaElSQi9tdnVuZ2FFb2ovbEVDSDQ4WlRoQlhT?=
 =?utf-8?B?cklqaWEveXhkRjFjRFRHK0hHVkJSM0NpVndQV0E4d0I3Ylh1SDBCMnZTakN5?=
 =?utf-8?B?Vyt4L1plYnBtMk9rTkxaT1NLTytvaStPdDZVT0ozYUM1M3hRUVBNQjNjeGZv?=
 =?utf-8?B?Y3hYOWJkVTdXNDJKU1JhaFg2OWg5b0F5dmpqZVFqOG5TUmZrc0V2U0tNUU91?=
 =?utf-8?B?ZmtJY0lFbUg0Rk5UZ1RSdVNUcFUrOU94VmsxSm1WMVNUdXVLbk9FMFhoNmpX?=
 =?utf-8?B?V1BoNnZjcVNyQnRLdnM1M2ttYVdCdFlCSFZ1bVF0ZTExR0NDRFVGbzRZT0xT?=
 =?utf-8?B?NEVkMlhQcVYyUERQb1FSQndTd2VQSHVTUE9WN2NCaHV6Um5Xd1MzQXVKQ1FU?=
 =?utf-8?B?b1pqSmlsRnFoSVBjWDlIWkcybWxUZVhUaXhFbldXSXAwRFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?KytFdFF6Q05aOW5CLzM0M0V2TmJaLzZ6cjJ0eGpnVUxwbExWS2U0ODFRbEdr?=
 =?utf-8?B?emFtNVRFR0R4MUdONWpPcXM5WFlTZmdPa3RlTTd4NG5KRkptT05mM3pRVzVz?=
 =?utf-8?B?RkRZRnVhVTJIelBvYzlSSUNpc0lKNktyMndvTHlmeDZwRWVhTXo2YjhoaVd4?=
 =?utf-8?B?L3JpVFRjRWRjbjZHVTRLNUZCN3dub0t5bVcwU3d6WlFHWDUyZFdpQzZuWVYx?=
 =?utf-8?B?T3M5T0llN2V3Ukw2QWxBbkZzZ1BCNzNyQlRybjJmUGJQTmxrbGZRNytmRFFW?=
 =?utf-8?B?T3lUNEpWY1REclBZN1RzaW5aSkhueGtFaVdheHdYaWhJaDloMVZhWFNlbFFk?=
 =?utf-8?B?WU1YNlpJRTVjQllPMDRSUXRzQVovQ1dERzIydVJkbm1HZzVjaXpGTER4K1ZV?=
 =?utf-8?B?YWlJb1ZFVWErR05KRFQ1SjM2UWQxT3F0YS9hSERqQVFwZ1Z4Vm9PNUc1NENU?=
 =?utf-8?B?c1JLYm9mWDExa3R5TnVJR0tGQ3ZuWTJ0c3RRZ1BsRS9iZ2lGeFZXYkpGT2Zj?=
 =?utf-8?B?bkV0UUpoejJGc2NOOWpaSjJRQU5pQlRDWndYcVR0RkNvb1I1S0Y3WDVFdERN?=
 =?utf-8?B?RzNXQkI0OFZPOFBacHpUbVk4eEhrSi9kbXJmQXF2MTR0NVl2ZmVjZlpIV3ZF?=
 =?utf-8?B?VEFnOXd4cmRJbVlBKytPd1FTQXlrVGhIdlJwU2E5RDZtVVZ2SjB4ejgyYWds?=
 =?utf-8?B?elBLL0xyUXV4OVkzYW85bkkrV2pMcWFNNU1ocWE3Y01ZNVgwNFp6azlURmw4?=
 =?utf-8?B?c3JHLzB2NTdQbXlEMVllWmVOUHdKaWYzb1BmLzRrUzBRVDdoRUdqZDVMbC9U?=
 =?utf-8?B?cVZURld6RTJua0VVWUduYmFFcHEzaEhHRDFucTRBbzhKemY3VWI0SnUxTk9G?=
 =?utf-8?B?ZTZaYU96N2FCTStGbmt0NWN1dEVnKzJ2NlRuUE5qREZUc0lWYkowY1NYU2la?=
 =?utf-8?B?S2FnUm9UZWNrVWxGQmV5M3I5VzNrRHBVekpyNnBJQkdlRHBjak1XL1RpcEV1?=
 =?utf-8?B?ZXZpUkU3bENwSDREbVlsd1VFWmZDdWZFcUlycGFsV0pVZmxGb2lQeDJkS1gw?=
 =?utf-8?B?YS9WWkRmaDlLTmp0T0FWOEJqUllDaW1SL3JIZ002YTFNNStkOTNhOUIxWWdW?=
 =?utf-8?B?UHZmODVqT0JnRGpuc0dRU0szQ0tNQ2V1UVdQN0Y0cE5wUkxBMFdqOE00ZHBn?=
 =?utf-8?B?dUxyeHlNVTQ3Y1diMGp1QlRUWng2aFRkVWRQSE9LbzZqOFZNTTN2WkVqbFNi?=
 =?utf-8?B?WGMvT0dHeVkrNHd1WFdjT2NDVzR5cGdZTkwwckVtSTJ2aHVtd2M2Q05DUy9q?=
 =?utf-8?B?b3AraEdGamxsNDBzM09NWXNPRnFmZ0NndHQ1UzVxVWROeEMyY0lnaVovU3ZQ?=
 =?utf-8?B?cm94UHV3aGI1T0laMW80VEFWZjVVeGEyWUR0M0hYZTY4MWh4M2Zwam14MnM0?=
 =?utf-8?B?MHRKc1ZZODhPYXkzZlRiejJPNGJMU0xJNWRjd0NNUU9NclpXK3NMbnptUnVJ?=
 =?utf-8?B?eWVWZ1I4eVlOekxGOVF3MEZmSHYwV2RaR1VMYlRPc0M3dDIwejR3d1M0ZEZE?=
 =?utf-8?B?NCtKUVl0VlpQVlB0b1RwUVVMR1N2czNkL3ZDeW1BUUlxVWxuQjBPdzkzcFUv?=
 =?utf-8?B?aElURnNIVDYvMUpIVEw0YkpuK2FtYXJQd0JReVZ0ZmNHN29PYnR4aXViaHc0?=
 =?utf-8?B?YUJtWnBmU0hkWDg0dTFYVW53T0Nla2dDeEhyYWpEZUdkYUtNVCtLMGdKNTZP?=
 =?utf-8?B?bk4rTFl4eVVUUHdtUUxvQ0RoL3dGZzlVYWlpYTNYdkdqazNRWG9ZQk5neU5B?=
 =?utf-8?B?dXErQ04vOUF1RmJZSVJKc3RRUzJPMmRDU2ozZFJrUlRxRGVvakJvV2FMb0Zk?=
 =?utf-8?B?eVF3Ym5DNHF1RGN4MTU1N1hGcjRicUZHS0EvalB0M2c1Y1kzSGtjWVJFOThx?=
 =?utf-8?B?YTdQSFNaVTZWSmpRdzMrdm4rTGN0SUVnUWl3VXNIUmRhK2hLeW1zQ2pHWktm?=
 =?utf-8?B?c0d0OTdKd2VYSUFKNTBORVRJTmhLMVdwVDNCRFNFQmlmVU5pMFA5MDMwRlU3?=
 =?utf-8?B?QVNLWU5GZEJVTTJVNTgzVkZSTDF3bXNTcHNrcW91WU5PY205RFk4MlM4SHkx?=
 =?utf-8?Q?9S+MG75ZBl5S4vM+mWc9Wf06s?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd7d8d6-b449-4ae2-27d7-08dce2005fb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 10:04:01.2864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b4FwAd/k7nzhkx2K0IQr+ofdweDF1AenEDHjXoikcPIEZGpwDh6P1Mp0vZZT1Jrj1FEqzbf5oSvSuaU70SW8iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8820

PiBGcm9tOiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwg
MzAgU2VwdGVtYmVyIDIwMjQgMTk6NDINCj4gVG86IERhbmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVy
QG52aWRpYS5jb20+DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkYXZlbUBkYXZlbWxv
ZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOw0KPiBrdWJhQGtlcm5lbC5vcmc7IHBhYmVuaUBy
ZWRoYXQuY29tOyB5dWVoYWliaW5nQGh1YXdlaS5jb207IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBQZXRyIE1hY2hhdGEgPHBldHJtQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggbmV0LW5leHQgdjMgMi8yXSBuZXQ6IGV0aHRvb2w6IEFkZCBzdXBwb3J0IGZvciB3
cml0aW5nDQo+IGZpcm13YXJlIGJsb2NrcyB1c2luZyBFUEwgcGF5bG9hZA0KPiANCj4gT24gTW9u
LCBTZXAgMzAsIDIwMjQgYXQgMTE6NDY6MzdBTSArMDMwMCwgRGFuaWVsbGUgUmF0c29uIHdyb3Rl
Og0KPiA+IEluIHRoZSBDTUlTIHNwZWNpZmljYXRpb24gZm9yIHBsdWdnYWJsZSBtb2R1bGVzLCBM
UEwgKExvdy1Qcmlvcml0eQ0KPiA+IFBheWxvYWQpIGFuZCBFUEwgKEV4dGVuZGVkIFBheWxvYWQg
TGVuZ3RoKSBhcmUgdHdvIHR5cGVzIG9mIGRhdGENCj4gPiBwYXlsb2FkcyB1c2VkIGZvciBtYW5h
Z2luZyB2YXJpb3VzIGZ1bmN0aW9ucyBhbmQgZmVhdHVyZXMgb2YgdGhlIG1vZHVsZS4NCj4gPg0K
PiA+IEVQTCBwYXlsb2FkcyBhcmUgdXNlZCBmb3IgbW9yZSBjb21wbGV4IGFuZCBleHRlbnNpdmUg
bWFuYWdlbWVudA0KPiA+IGZ1bmN0aW9ucyB0aGF0IHJlcXVpcmUgYSBsYXJnZXIgYW1vdW50IG9m
IGRhdGEsIHNvIHdyaXRpbmcgZmlybXdhcmUNCj4gPiBibG9ja3MgdXNpbmcgRVBMIGlzIG11Y2gg
bW9yZSBlZmZpY2llbnQuDQo+ID4NCj4gPiBDdXJyZW50bHksIG9ubHkgTFBMIHBheWxvYWQgaXMg
c3VwcG9ydGVkIGZvciB3cml0aW5nIGZpcm13YXJlIGJsb2Nrcw0KPiA+IHRvIHRoZSBtb2R1bGUu
DQo+ID4NCj4gPiBBZGQgc3VwcG9ydCBmb3Igd3JpdGluZyBmaXJtd2FyZSBibG9jayB1c2luZyBF
UEwgcGF5bG9hZCwgYm90aCB0bw0KPiA+IHN1cHBvcnQgbW9kdWxlcyB0aGF0IHN1cHBvcnRzIG9u
bHkgRVBMIHdyaXRlIG1lY2hhbmlzbSwgYW5kIHRvDQo+ID4gb3B0aW1pemUgdGhlIGZsYXNoaW5n
IHByb2Nlc3Mgb2YgbW9kdWxlcyB0aGF0IHN1cHBvcnQgTFBMIGFuZCBFUEwuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBEYW5pZWxsZSBSYXRzb24gPGRhbmllbGxlckBudmlkaWEuY29tPg0KPiA+
IFJldmlld2VkLWJ5OiBQZXRyIE1hY2hhdGEgPHBldHJtQG52aWRpYS5jb20+DQo+ID4gUmV2aWV3
ZWQtYnk6IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4NCj4gDQo+IC4uLg0KPiANCj4g
PiBAQCAtNTU2LDYgKzU2Myw0OSBAQCBfX2V0aHRvb2xfY21pc19jZGJfZXhlY3V0ZV9jbWQoc3Ry
dWN0DQo+IG5ldF9kZXZpY2UgKmRldiwNCj4gPiAgCXJldHVybiBlcnI7DQo+ID4gIH0NCj4gPg0K
PiA+ICsjZGVmaW5lIENNSVNfQ0RCX0VQTF9QQUdFX1NUQVJUCQkJMHhBMA0KPiA+ICsjZGVmaW5l
IENNSVNfQ0RCX0VQTF9QQUdFX0VORAkJCTB4QUYNCj4gPiArI2RlZmluZSBDTUlTX0NEQl9FUExf
RldfQkxPQ0tfT0ZGU0VUX1NUQVJUCTEyOA0KPiA+ICsjZGVmaW5lIENNSVNfQ0RCX0VQTF9GV19C
TE9DS19PRkZTRVRfRU5ECTI1NQ0KPiA+ICsNCj4gPiArc3RhdGljIGludA0KPiA+ICtldGh0b29s
X2NtaXNfY2RiX2V4ZWN1dGVfZXBsX2NtZChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LA0KPiA+ICsJ
CQkJIHN0cnVjdCBldGh0b29sX2NtaXNfY2RiX2NtZF9hcmdzICphcmdzLA0KPiA+ICsJCQkJIHN0
cnVjdCBldGh0b29sX21vZHVsZV9lZXByb20gKnBhZ2VfZGF0YSkgew0KPiA+ICsJdTE2IGVwbF9s
ZW4gPSBiZTE2X3RvX2NwdShhcmdzLT5yZXEuZXBsX2xlbik7DQo+ID4gKwl1MzIgYnl0ZXNfd3Jp
dHRlbjsNCj4gPiArCXU4IHBhZ2U7DQo+ID4gKwlpbnQgZXJyOw0KPiA+ICsNCj4gPiArCWZvciAo
cGFnZSA9IENNSVNfQ0RCX0VQTF9QQUdFX1NUQVJUOw0KPiA+ICsJICAgICBwYWdlIDw9IENNSVNf
Q0RCX0VQTF9QQUdFX0VORCAmJiBieXRlc193cml0dGVuIDwgZXBsX2xlbjsNCj4gPiArcGFnZSsr
KSB7DQo+IA0KPiBieXRlc193cml0dGVuIGRvZXMgbm90IHNlZW0gdG8gYmUgaW5pdGlhbGlzZWQg
aGVyZSBmb3IgdGhlIGZpcnN0IGl0ZXJhdGlvbiBvZiB0aGUNCj4gbG9vcC4NCj4gDQo+IEZsYWdn
ZWQgYnkgVz0xIGJ1aWxkcyB3aXRoIGNsYW5nLTE4Lg0KDQpZb3UgYXJlIHJpZ2h0LCBJIG1pc3Rh
a2VubHkgc2VudCB0aGUgd3JvbmcgdmVyc2lvbi4gV2lsbCBzZW5kIHRoZSBmaXhlZCBvbmUuDQpU
aGFua3MuDQoNCj4gDQo+ID4gKwkJdTE2IG9mZnNldCA9IENNSVNfQ0RCX0VQTF9GV19CTE9DS19P
RkZTRVRfU1RBUlQ7DQo+ID4gKw0KPiA+ICsJCXdoaWxlIChvZmZzZXQgPD0gQ01JU19DREJfRVBM
X0ZXX0JMT0NLX09GRlNFVF9FTkQgJiYNCj4gPiArCQkgICAgICAgYnl0ZXNfd3JpdHRlbiA8IGVw
bF9sZW4pIHsNCj4gPiArCQkJdTMyIGJ5dGVzX2xlZnQgPSBlcGxfbGVuIC0gYnl0ZXNfd3JpdHRl
bjsNCj4gPiArCQkJdTE2IHNwYWNlX2xlZnQsIGJ5dGVzX3RvX3dyaXRlOw0KPiA+ICsNCj4gPiAr
CQkJc3BhY2VfbGVmdCA9IENNSVNfQ0RCX0VQTF9GV19CTE9DS19PRkZTRVRfRU5EDQo+IC0gb2Zm
c2V0ICsgMTsNCj4gPiArCQkJYnl0ZXNfdG9fd3JpdGUgPSBtaW5fdCh1MTYsIGJ5dGVzX2xlZnQs
DQo+ID4gKwkJCQkJICAgICAgIG1pbl90KHUxNiwgc3BhY2VfbGVmdCwNCj4gPiArCQkJCQkJICAg
ICBhcmdzLT5yZWFkX3dyaXRlX2xlbl9leHQpKTsNCj4gPiArDQo+ID4gKwkJCWVyciA9IF9fZXRo
dG9vbF9jbWlzX2NkYl9leGVjdXRlX2NtZChkZXYsDQo+IHBhZ2VfZGF0YSwNCj4gPiArCQkJCQkJ
CSAgICAgcGFnZSwgb2Zmc2V0LA0KPiA+ICsJCQkJCQkJICAgICBieXRlc190b193cml0ZSwNCj4g
PiArCQkJCQkJCSAgICAgYXJncy0+cmVxLmVwbCArDQo+IGJ5dGVzX3dyaXR0ZW4pOw0KPiA+ICsJ
CQlpZiAoZXJyIDwgMCkNCj4gPiArCQkJCXJldHVybiBlcnI7DQo+ID4gKw0KPiA+ICsJCQlvZmZz
ZXQgKz0gYnl0ZXNfdG9fd3JpdGU7DQo+ID4gKwkJCWJ5dGVzX3dyaXR0ZW4gKz0gYnl0ZXNfdG9f
d3JpdGU7DQo+ID4gKwkJfQ0KPiA+ICsJfQ0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiAr
DQo+ID4gIHN0YXRpYyB1OCBjbWlzX2NkYl9jYWxjX2NoZWNrc3VtKGNvbnN0IHZvaWQgKmRhdGEs
IHNpemVfdCBzaXplKSAgew0KPiA+ICAJY29uc3QgdTggKmJ5dGVzID0gKGNvbnN0IHU4ICopZGF0
YTsNCj4gDQo+IC4uLg0KPiANCj4gLS0NCj4gcHctYm90OiBjaGFuZ2VzLXJlcXVlc3RlZA0K

