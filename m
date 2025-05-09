Return-Path: <netdev+bounces-189302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B775AB182F
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7D9980BB9
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5640A2144D5;
	Fri,  9 May 2025 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tmiWLiMu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA5A20FA96;
	Fri,  9 May 2025 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803845; cv=fail; b=TDY4cyg5HIXZ4HTpUZJYVWN0J0PmjEIUmclMt5tqqmBp717smvBDrOrxvYcVAIoVGFGrLvTODqOW3dp5/kwi1s7ZZSyy95k6epmTMKTjmnGwlJCOv6Qwvj/OxoWYkdseNQ0KfSJnW5QaP7JnyHBIvjYGkPjf4kWi8DgQbW+ASLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803845; c=relaxed/simple;
	bh=OkRRxGWGvbru3/W8RimbqgvLZdtgoDSzQpjmnrmraxw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gre0v8y6Y1cB2LMxjiRkOVpUG9f9Qx9igRjGJmBXAY/COw99DJvkynNxWI9omzjybMI8yQ0zhW7wUCZaUtW4V4w/p5R232+4EOpvyAEVg4hWM0dj6ghXGJaNcPhoHhqBOG4uDR8ncid4le2MPD69pq99ldxBpCth29ICuiXWnyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tmiWLiMu; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bn+gsHIVdwWIgy+CLgQI83f1TgLgkHS8M0fpg4I8h1cj6NLf+cqQABs3UTsNo6IyGgu0NBL2rEl3CBAGF4cHgiXn45sQTkj9bF1pZpD3bcqdLEYQoA7CzCwqcAX2xUkn8FmpxwtKNwlCdwWVBvviyuzXNo9RugPR575bvx5i1lsqqRqTZxeUIcd+VBNohykPhlirupnu81dSthiyZ8Y+248U0AQ1B4HY6kP14ntzuELUIY8v1tUp4+u0zLY2KWFu2HSdPZJ8vzNfEI2EK4DYzUBnJLoD5wWHls5kIlBRzYzIzRT3XiOGv04Egw1CGVHa7Hj3ek53yYjsjrhNx4y5aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkRRxGWGvbru3/W8RimbqgvLZdtgoDSzQpjmnrmraxw=;
 b=fZltG1ursRiVuYB7pZKg8PbLn7g3U1ACpRoSQLIYU9PVeNBi0skj24/viGSIih/lCRx4YcKQ6PouCBSduSurUEeN5hz7uIXKt+ArM+HB2mV86JA+el6yHPyCM3GbMrrFelqUzKe43q4mdeSOopg55aVjC3TRQNU4aBCYRWGkg9MecmMCX8YCRziEZ36na4Mn0ezgAMoGlF4nTrRpzkJV0qQ52F1buRQSeZ9HrvAknOXArcK2+gjvaAsqaIP5dLsgOrYu4L9qwH+CqxHPpyznOLItzM1E9q3kysFTOd4flwjE1ynjzWn7XY+E19qESvVb1xQ6jRJUK9PuTVn96/p0OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkRRxGWGvbru3/W8RimbqgvLZdtgoDSzQpjmnrmraxw=;
 b=tmiWLiMu5xPYHjpGSfDZrNDRFQQKiLcc07fLGtG58S3Zp2V6QgWIDHpCckPhCUM37QrfanFDq5BUuqdkmSu5t/hq4htbEozm7X726QdXx9VBlKAOGQL9+s6nvZUpmWTwGJW1rNNy6YLC5jd7LbMii/jDISus3Q9nJ9gRSL+Qqo4=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by SN7PR12MB7203.namprd12.prod.outlook.com (2603:10b6:806:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 15:17:19 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%4]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 15:17:19 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Can Ayberk Demir <ayberkdemir@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v3] net: axienet: safely drop oversized RX frames
Thread-Topic: [PATCH net v3] net: axienet: safely drop oversized RX frames
Thread-Index: AQHbwM/hpUCJSXiCvkKAOSDskE60x7PKZ4+g
Date: Fri, 9 May 2025 15:17:19 +0000
Message-ID:
 <BL3PR12MB65713C8109035EC83DE8C9BBC98AA@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20250509063727.35560-1-ayberkdemir@gmail.com>
 <20250509104755.46464-1-ayberkdemir@gmail.com>
In-Reply-To: <20250509104755.46464-1-ayberkdemir@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=11b4c595-6648-4c11-90bd-9f8f18a8699e;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-09T15:11:08Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|SN7PR12MB7203:EE_
x-ms-office365-filtering-correlation-id: 8d8a5aca-7bc4-4a3e-829f-08dd8f0c9724
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MmkwaE9RTnoyMHFoNWhpYjBYU25BSWFxZW81aFdxN1pnbFhCK0FEL1dmNk5N?=
 =?utf-8?B?cVJRN3dWVmVBN3A1UHZYakJCRlpGYzcwV0E2QUNpRnB0SzRIU1lqdFpnQldz?=
 =?utf-8?B?UXZIZ1V6VFRtNWRMNzRoRlF0clQ5YVVGQlVET3hmYXNRc1E5alYvSTlaYnYv?=
 =?utf-8?B?cDRTY1lFQllxMEpScVYwZTFQRG4ycmc2VEpSZlZLWkttZUJMYXZsdUQwNGpr?=
 =?utf-8?B?VEVtRzlWd1JUQzcvY0FNb0hrdWJRWjJGZUhvYXdPbE1YTDRoblRpMnNBZUlC?=
 =?utf-8?B?cGYzRnpkNG5iZXFQWHAvTTk2cU9KN2I4c2VjVXpJeEdkbGtrN0x2UVJyTGQy?=
 =?utf-8?B?ZnlYckE3anpMbFkxVGd0TVdzcnJBUm5nMm93Ymx6VUc2dXN6U2VGMHRwbm04?=
 =?utf-8?B?bVpxcnZRdm9GOFZBYU5pZC95U09qVlc3WGFTYlpJbnY0U29aUldmbDNCV2h5?=
 =?utf-8?B?Y0U5MmVvZHUvMWMrQmIwa2d3RlltZmhKK1U2THNXK055WEtxcGQ2YXZseExo?=
 =?utf-8?B?R25mQjczR2VXc0tpQWxua0J3MDNqZk5mSnBaYm43YXkwVjVNZnZFeGdJNjZ2?=
 =?utf-8?B?UjdDNFUrTWYwZjduVEZzNFlFeUtOR0x6d0ZEem12RVBWSzlDaXN1THZyMzRp?=
 =?utf-8?B?Tlg4MnhEeURHUHdEZ3REZWEzNFlkT3NxU0ZyZHhmY2pNRWtEbWp3TC9KMVV6?=
 =?utf-8?B?eWYyWWg5TnNZVGozMEU5VmpaUG9BWmlBSlJpRklSOGttc1lyTXFIcm1ST1VL?=
 =?utf-8?B?Q2xraG9CbmlocmZWMThoclpGbkh4MjJ3MWl0aVd6SVkyay82QWR1Ui9ndDc2?=
 =?utf-8?B?S1I2TE1oc2JCT1JNSHNpRHlxQXdiR0dKWGhiMDJla1lJMFFWMlVIemgrYXhp?=
 =?utf-8?B?d1ErYUYzSW1qUFA5M3ZlbjlhREtKMnlIVi9YOFRhRlFTNG43aE5KMnFXdUFL?=
 =?utf-8?B?dUpqbXViYUxDVkpPYUt0Z1d4alV0REpkTzd3bzkxSkJLVW5QZjgyZWFXbFlO?=
 =?utf-8?B?bE4xWG5YYlBCcmlVb0NYa1E2cDF3UjV1VGpBZnh1dzU4Z1VQQUU4K2loMmNB?=
 =?utf-8?B?RHNNdlFaWjlGbnNSREdLSEM2UzByMDg4SEg1NzdCUFNDaHdFT0dLMEJvN0Rv?=
 =?utf-8?B?S2lPazgrM2tEMS93YmJ0cVpmRG8vTm1veXVOVVcrTG5hdEthUS9KNndiWEIx?=
 =?utf-8?B?YkJIa29tR2Z5WktyWGc4L00xYVVScU5sUWJ5NmMvL0VwdVdmNEt1SXNUbjJI?=
 =?utf-8?B?UEo4YVZESWlRcHJCMXVlWGxiT1VVMXd3NUViSWZPODN1QWF1cXRESEdhVk5N?=
 =?utf-8?B?bkQwdlVVY1NXdmZRd2srMWNUTSt2QlU5c1B1dEpmeC9KYjkrTFhYSkQ2bmtw?=
 =?utf-8?B?Uk1MQS9PTHVybmdySnY4L2hiVmZLNDVxUFQwYnhCWms3M1duYzYzNWhDbFZJ?=
 =?utf-8?B?S0ZHNVB3KzkweUZ5c3psOXUwZ1drcmZtUDkzTjhhNGxFQUNWNFdFZXdCanZq?=
 =?utf-8?B?OTJUNCtwY2VwbjFpeDhIL3d3aktld1RDWEQrakM1YWhWMGVIbWNPZU02K2l4?=
 =?utf-8?B?cEVEOS9hUkNlTHpzd3M4dTNxN1FyWkFzNFZ1c0hjZitndmZMeng1ek9KYVla?=
 =?utf-8?B?OGFSTFlyRkp1Wm1RdVRpR29CZ3BvUTlmTk9IczhTemQvS0VwdGY0RDFpQjBI?=
 =?utf-8?B?cjFNWDV5b3hJQzYvUkhkSDRsMG41ZS9pTUovMTU1NHM1aHlieGxmQ0Rldlg2?=
 =?utf-8?B?TEVHSnZpdDQ3MkQ1THFqMnRXYjZ5M2d5aXAwNHJ4TzNuOC8xRWNZVy93UUND?=
 =?utf-8?B?Z09ia01pSERPcUpKYW5nam4yWUpjY0oxakNwTXYyb0pVZGkyZFYxdFpIdTBp?=
 =?utf-8?B?WTNlbjZZL3U3MDhhNXp0bzFQUzZaU25Ic3pqTFpWK25mK042QUlKNWo2VlE0?=
 =?utf-8?B?SmRkd0IwWEY2dkFKNlEzTnYrOWVwTldJbFpPZ1h3OElRWjNxRktQWkNjelNj?=
 =?utf-8?Q?K3BTeIU+YcXzC5OqPH5a1xszVsGbOs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eFB0YVBRaTJuRW53cVZQODZBdEdIdVZHNTZaM1dJS2hEbXNyWkZjQ2ViMGk2?=
 =?utf-8?B?OEhFVDBYWE8rSXQyK1FCQ3JZUmVvQjlZakE4TVZOeUQ5S3kzQWRlbUduaEVn?=
 =?utf-8?B?YVV5RmdHNUs2WHZGS3hNd2FaU1V4S3lQREF5UHZxUkVVcnB2SU1iUXYycTMr?=
 =?utf-8?B?ckFacmtRYjh4elZ2SHZyTWJ5dWhkREYrYW1KTnRzaFRtQktsSkt5QmZmTG4w?=
 =?utf-8?B?YUtnL1pOQWYyQzZlZGZZSnhadTluejQ0cWxuUDhTYm1SL3U0STdISHNKWGVo?=
 =?utf-8?B?SWxKWVBxMldCZFB2dDJydUtGc2FRUVUzczVabFRJZG9nNVVSVTloeWs2Q1ZJ?=
 =?utf-8?B?S1hKZmhUSVJpSCtlSEJVQXhoMzZVUnFkSTBSd2Jab3FiWjVWaTJqZk1qU0xq?=
 =?utf-8?B?TEVRcVVtd2hvazBDZkxSZnhJa1hKR1JzTnoxd2xhYk5hUEZTVnl1djEvTklF?=
 =?utf-8?B?cWZQRmI5cUtkdXRzb1VIaWlWK0JkQVVmODFUWDFPY0Y2WllSYUNWSjlDSDlW?=
 =?utf-8?B?b2VIdTZweFg5dThyYjRYY3Z1QkhCSEdLR2RNQ21WZXFGNWQzNGpUYWJKcVVj?=
 =?utf-8?B?WWRFSGJHLzZJNGlDcXV0Q3M5Y2tUUFlkS1FwazVBS0tQWTAzSHM0cldrcUZk?=
 =?utf-8?B?aURRUUdNeXQvN21nZ1lJUndrbW5JU2cxR01IMHJZNitaR2hNSDE3SitYOEdB?=
 =?utf-8?B?c3Rwc1BhVGpJY3FJUjJwSXVZOW9CaVkwZGpoUGtZYi9tWTNNOXlBSG5HOWRZ?=
 =?utf-8?B?K3daSU5LeXdxTHRpYXhqRmVCcDQ1Nk13UmxXYkFyK20rRjdQOUdPN05hNm5k?=
 =?utf-8?B?YUJ2bHRkOHM4SzlBeStCaXpoNnJKNmE2TEZHSHFVbHFnZk9aaEN5enlTMTgz?=
 =?utf-8?B?UlZMUDZrajZsN2NNeEJCMnYxRzBJa2hJdWFlK2loK0cxbE1PWWVJbldwN2dk?=
 =?utf-8?B?SmpMcWo0TnZaRDRsakU1TXZpY1hzZVNqWmJjOEZXcmkzekxtNWNhWmJnZS9s?=
 =?utf-8?B?ZlI2MElZWmRPcTdWU3p3K3RhOFA5T2tqb2pzOUhHaWEzM2t0ZHVTWWlMdXVk?=
 =?utf-8?B?bldJaHJZMndTTklHbGNqTXFqYUJINmlOTzdva0FZRjhzdEdtUmNuSW5DTWJa?=
 =?utf-8?B?YVNsZmNTYmNrbEUxNWVvS0ZxTGczTVAwazBST3RxMjYwY0lkcVNDWDQwbDBQ?=
 =?utf-8?B?b3ZhUVNVR0ZiQVVEakkzNUxhUzRmUm1yR3E2S1FGSWg3d05uVTlaZ3JuMHFQ?=
 =?utf-8?B?VzkwUFN0QXJtYlRrVzAvdzR1Y0FVcnVJUlhpUFVoUVFBanZYREYraVAvdDdm?=
 =?utf-8?B?Tk5WaFMxRng0UzFlUW9NaUlHR0E0QXlOYXBIcWZKWmpValVtNGNZU3RpV3gy?=
 =?utf-8?B?RWV3cVJpWE12cnJwMC94U3R4ZEJnQmY0Z05lelhMdnhpWTAwOUxobG05MWZZ?=
 =?utf-8?B?cDRySG1SNjMxTVg0VHlxR0g1RFhqbGNqeGQvbFNqUHFOb3Z3andITWx5R2p1?=
 =?utf-8?B?NEVadG1xZjNtRDhpbVVvN0pVS2RtVnhwQjhyeUF2R1FZV1R1VXRCd0FLVU5S?=
 =?utf-8?B?VU9yWTdDL0lqdjJXMkd3MnhJRENtays3cVZjd3RRWnZ6WDd1R1lqa0lUZnN6?=
 =?utf-8?B?QVNNRTg1NDlyODI1QmJBdlphbnFyM0pVSGZVcndTWnRQWEYyMk9henBHZkVk?=
 =?utf-8?B?U3VCazZOcDVCSGRTNndXK1FIZXUxOEZIQ3phZnpUVWtLeDd6azBVdzFWQlVP?=
 =?utf-8?B?VGdRNjA1cUFZVUN1TGFQcGNCZVBCMUZ0NHpMUU1ZdnNNbXE4RDBrRzcxMWZE?=
 =?utf-8?B?cEY4cXVyb205UUlwVTJIZnFIS3ZLSXQyMVdSdmdOWUhDaStyL1A4Rll3ckZr?=
 =?utf-8?B?SmkxQUF6bFlvR2hPM255YWpNWCsySGRHem4yUjhWNmgyVXVGVFJJd2Rlc0NR?=
 =?utf-8?B?L29KU1hrV3BsSzNGYkVGMmlMaU1FemxxTFdPcllVMS9EVytmVDB3ODUvQnV2?=
 =?utf-8?B?UUVNdWxTUWtjaE1qM2NpYjl0d2owYzc4SS9FMXh4cG9ES01mQmZDTy84bmJP?=
 =?utf-8?B?VElWSHVxWVZkY1ZWWGszd3Y5Z3kvVWp2U294VmI5UEdmZHJyTVk1dVBvT2JD?=
 =?utf-8?Q?HXSs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8a5aca-7bc4-4a3e-829f-08dd8f0c9724
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 15:17:19.4484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ip88dfAvUyCq8Ldwbvli5QQylt07l+oaz4vfb6SGAAbkgJ3V9KKg8jRVetjEDWtB6Qauri6kHJ/11hiw/4xu7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7203

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDYW4gQXliZXJrIERlbWly
IDxheWJlcmtkZW1pckBnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTWF5IDksIDIwMjUgNDox
OCBQTQ0KPiBUbzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBDYzogUGFuZGV5LCBSYWRoZXkg
U2h5YW0gPHJhZGhleS5zaHlhbS5wYW5kZXlAYW1kLmNvbT47IEFuZHJldyBMdW5uDQo+IDxhbmRy
ZXcrbmV0ZGV2QGx1bm4uY2g+OyBEYXZpZCBTIC4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0
PjsgRXJpYw0KPiBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kg
PGt1YmFAa2VybmVsLm9yZz47IFBhb2xvDQo+IEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IFNp
bWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgbGludXgtYXJtLQ0KPiBrZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQ2FuIEF5
YmVyayBERU1JUg0KPiA8YXliZXJrZGVtaXJAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0gg
bmV0IHYzXSBuZXQ6IGF4aWVuZXQ6IHNhZmVseSBkcm9wIG92ZXJzaXplZCBSWCBmcmFtZXMNCj4N
Cj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3Vy
Y2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNr
aW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBGcm9tOiBDYW4gQXliZXJrIERFTUlS
IDxheWJlcmtkZW1pckBnbWFpbC5jb20+DQo+DQo+IEluIEFYSSBFdGhlcm5ldCAoYXhpZW5ldCkg
ZHJpdmVyLCByZWNlaXZpbmcgYW4gRXRoZXJuZXQgZnJhbWUgbGFyZ2VyIHRoYW4gdGhlIGFsbG9j
YXRlZA0KPiBza2IgYnVmZmVyIG1heSBjYXVzZSBtZW1vcnkgY29ycnVwdGlvbiBvciBrZXJuZWwg
cGFuaWMsIGVzcGVjaWFsbHkgd2hlbiB0aGUNCj4gaW50ZXJmYWNlIE1UVSBpcyBzbWFsbCBhbmQg
YSBqdW1ibyBmcmFtZSBpcyByZWNlaXZlZC4NCj4NCj4gRml4ZXM6IDhhM2I3YTI1MmRjYSAoImRy
aXZlcnMvbmV0L2V0aGVybmV0L3hpbGlueDogYWRkZWQgWGlsaW54IEFYSSBFdGhlcm5ldCBkcml2
ZXIiKQ0KUGxlYXNlIG1vdmUgaXQganVzdCBiZWZvcmUgU09CLg0KDQo+DQo+IFRoaXMgYnVnIHdh
cyBkaXNjb3ZlcmVkIGR1cmluZyB0ZXN0aW5nIG9uIGEgS3JpYSBLMjYgcGxhdGZvcm0uIFdoZW4g
YW4gb3ZlcnNpemVkDQo+IGZyYW1lIGlzIHJlY2VpdmVkIGFuZCBgc2tiX3B1dCgpYCBpcyBjYWxs
ZWQgd2l0aG91dCBjaGVja2luZyB0aGUgdGFpbHJvb20sIHRoZQ0KPiBmb2xsb3dpbmcga2VybmVs
IHBhbmljIG9jY3VyczoNCj4NCj4gICBza2JfcGFuaWMrMHg1OC8weDVjDQo+ICAgc2tiX3B1dCsw
eDkwLzB4YjANCj4gICBheGllbmV0X3J4X3BvbGwrMHgxMzAvMHg0ZWMNCj4gICAuLi4NCj4gICBL
ZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogT29wcyAtIEJVRzogRmF0YWwgZXhjZXB0aW9uIGlu
IGludGVycnVwdA0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBDYW4gQXliZXJrIERFTUlSIDxheWJlcmtk
ZW1pckBnbWFpbC5jb20+DQo+IC0tLQ0KDQpUZXN0ZWQgd2l0aCB6Y3UxMDIgc2V0dXAuDQpUZXN0
ZWQtYnk6IDxzdXJhai5ndXB0YTJAYW1kLmNvbT4NCg0KPiBDaGFuZ2VzIGluIHYzOg0KPiAtIEZp
eGVkICduZGV2JyB1bmRlY2xhcmVkIGVycm9yIOKGkiByZXBsYWNlZCB3aXRoICdscC0+bmRldicN
Cj4gLSBBZGRlZCByeF9kcm9wcGVkKysgZm9yIHN0YXRpc3RpY3MNCj4gLSBBZGRlZCBGaXhlczog
dGFnDQo+DQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gVGhpcyBwYXRjaCBhZGRyZXNzZXMgc3R5bGUg
aXNzdWVzIHBvaW50ZWQgb3V0IGluIHYxLg0KPiAtLS0NCj4gIC4uLi9uZXQvZXRoZXJuZXQveGls
aW54L3hpbGlueF9heGllbmV0X21haW4uYyB8IDQ3ICsrKysrKysrKysrLS0tLS0tLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkNCj4NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3hpbGlueC94aWxpbnhfYXhpZW5ldF9tYWlu
LmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC94aWxpbngveGlsaW54X2F4aWVuZXRfbWFpbi5j
DQo+IGluZGV4IDFiN2E2NTNjMWY0ZS4uN2ExMjEzMmUyYjdjIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC94aWxpbngveGlsaW54X2F4aWVuZXRfbWFpbi5jDQo+ICsrKyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L3hpbGlueC94aWxpbnhfYXhpZW5ldF9tYWluLmMNCj4gQEAgLTEy
MjMsMjggKzEyMjMsMzcgQEAgc3RhdGljIGludCBheGllbmV0X3J4X3BvbGwoc3RydWN0IG5hcGlf
c3RydWN0ICpuYXBpLCBpbnQNCj4gYnVkZ2V0KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBk
bWFfdW5tYXBfc2luZ2xlKGxwLT5kZXYsIHBoeXMsIGxwLT5tYXhfZnJtX3NpemUsDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRE1BX0ZST01fREVWSUNFKTsNCj4N
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgc2tiX3B1dChza2IsIGxlbmd0aCk7DQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgIHNrYi0+cHJvdG9jb2wgPSBldGhfdHlwZV90cmFucyhza2IsIGxw
LT5uZGV2KTsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgLypza2JfY2hlY2tzdW1fbm9uZV9h
c3NlcnQoc2tiKTsqLw0KPiAtICAgICAgICAgICAgICAgICAgICAgICBza2ItPmlwX3N1bW1lZCA9
IENIRUNLU1VNX05PTkU7DQo+IC0NCj4gLSAgICAgICAgICAgICAgICAgICAgICAgLyogaWYgd2Un
cmUgZG9pbmcgUnggY3N1bSBvZmZsb2FkLCBzZXQgaXQgdXAgKi8NCj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKGxwLT5mZWF0dXJlcyAmIFhBRV9GRUFUVVJFX0ZVTExfUlhfQ1NVTSkgew0K
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNzdW1zdGF0dXMgPSAoY3VyX3AtPmFw
cDIgJg0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgWEFF
X0ZVTExfQ1NVTV9TVEFUVVNfTUFTSykgPj4gMzsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpZiAoY3N1bXN0YXR1cyA9PSBYQUVfSVBfVENQX0NTVU1fVkFMSURBVEVEIHx8DQo+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNzdW1zdGF0dXMgPT0gWEFFX0lQ
X1VEUF9DU1VNX1ZBTElEQVRFRCkgew0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc2tiLT5pcF9zdW1tZWQgPSBDSEVDS1NVTV9VTk5FQ0VTU0FSWTsNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KGxlbmd0aCA+IHNrYl90YWlscm9vbShza2Ip
KSkgew0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5ldGRldl93YXJuKGxwLT5u
ZGV2LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJEcm9w
cGluZyBvdmVyc2l6ZWQgUlggZnJhbWUgKGxlbj0ldSwNCj4gdGFpbHJvb209JXUpXG4iLA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxlbmd0aCwgc2tiX3Rh
aWxyb29tKHNrYikpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9rZnJl
ZV9za2Ioc2tiKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBscC0+bmRldi0+
c3RhdHMucnhfZHJvcHBlZCsrOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNr
YiA9IE5VTEw7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc2tiX3B1dChza2IsIGxlbmd0aCk7DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc2tiLT5wcm90b2NvbCA9IGV0aF90eXBlX3RyYW5zKHNr
YiwgbHAtPm5kZXYpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qc2tiX2No
ZWNrc3VtX25vbmVfYXNzZXJ0KHNrYik7Ki8NCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBza2ItPmlwX3N1bW1lZCA9IENIRUNLU1VNX05PTkU7DQo+ICsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAvKiBpZiB3ZSdyZSBkb2luZyBSeCBjc3VtIG9mZmxvYWQsIHNl
dCBpdCB1cCAqLw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChscC0+ZmVh
dHVyZXMgJiBYQUVfRkVBVFVSRV9GVUxMX1JYX0NTVU0pIHsNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNzdW1zdGF0dXMgPSAoY3VyX3AtPmFwcDIgJg0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFhBRV9G
VUxMX0NTVU1fU1RBVFVTX01BU0spID4+IDM7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBpZiAoY3N1bXN0YXR1cyA9PSBYQUVfSVBfVENQX0NTVU1fVkFMSURBVEVE
IHx8DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3N1bXN0
YXR1cyA9PSBYQUVfSVBfVURQX0NTVU1fVkFMSURBVEVEKSB7DQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNrYi0+aXBfc3VtbWVkID0gQ0hFQ0tTVU1f
VU5ORUNFU1NBUlk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIGlmIChscC0+ZmVhdHVy
ZXMgJiBYQUVfRkVBVFVSRV9QQVJUSUFMX1JYX0NTVU0pDQo+IHsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHNrYi0+Y3N1bSA9IGJlMzJfdG9fY3B1KGN1cl9wLT5h
cHAzICYgMHhGRkZGKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHNrYi0+aXBfc3VtbWVkID0NCj4gKyBDSEVDS1NVTV9DT01QTEVURTsNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB9DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSBp
ZiAobHAtPmZlYXR1cmVzICYgWEFFX0ZFQVRVUkVfUEFSVElBTF9SWF9DU1VNKSB7DQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc2tiLT5jc3VtID0gYmUzMl90b19jcHUoY3VyX3At
PmFwcDMgJiAweEZGRkYpOw0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNrYi0+
aXBfc3VtbWVkID0gQ0hFQ0tTVU1fQ09NUExFVEU7DQo+IC0gICAgICAgICAgICAgICAgICAgICAg
IH0NCj4NCj4gLSAgICAgICAgICAgICAgICAgICAgICAgbmFwaV9ncm9fcmVjZWl2ZShuYXBpLCBz
a2IpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5hcGlfZ3JvX3JlY2VpdmUo
bmFwaSwgc2tiKTsNCj4NCj4gLSAgICAgICAgICAgICAgICAgICAgICAgc2l6ZSArPSBsZW5ndGg7
DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHBhY2tldHMrKzsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzaXplICs9IGxlbmd0aDsNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBwYWNrZXRzKys7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gICAg
ICAgICAgICAgICAgIH0NCj4NCj4gICAgICAgICAgICAgICAgIG5ld19za2IgPSBuYXBpX2FsbG9j
X3NrYihuYXBpLCBscC0+bWF4X2ZybV9zaXplKTsNCj4gLS0NCj4gMi4zOS41IChBcHBsZSBHaXQt
MTU0KQ0KPg0KDQo=

