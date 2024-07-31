Return-Path: <netdev+bounces-114411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE80942788
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97EF0B24044
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 07:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56D318B495;
	Wed, 31 Jul 2024 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V25ghA8r"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACE41A4B39
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 07:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722409698; cv=fail; b=dWnqBVJlLl6ntnrI7FVg7lzxUmsDqR5WzBO7Z7gBompCQOx/cepIAN6A1tZ5ttp38WmrnNaBg02TiKaI9lEf5vBNsjAm+IldWpPIcJzfVR78koxz2BuHe0xrgv2AHsmIhv/jMl+g97rg0rnE8p8+2pBeymfwIUwRrszgTvq6EDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722409698; c=relaxed/simple;
	bh=LlrcHQs69AWZpiBQ4rcmZHxNbkmd9LKGHcYKfBRDqBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OiXdsHMrdBuPISHs5NNnhBMRoV6+IHBbR5NgHn2ZFFI9dMjny5hK0kwLkbjXCMV9XyHs9iLnHZqzZn4XWI+ItvqJF3+wlMMwa5KHHe6QM/rLxTS1sSgWhQ4aeRRR0t3e0WcPOL/xn5PCkmbIl9G680R1wNtLiq/BosyQOOvbmMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V25ghA8r; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEzSSoMFeu3sqy9yZShsAvNXT1xpCKRRIX9VF4DOdb2saRPWNrKxq5y+8DudGHM9aKIeMEwy6LRVDs+yozOGlMMQDXU5bzrHM5hmFq7IARbU3/hWCdlclW3zvPKQsTh3nq2N9rssqnRTd3fHszIctBmKmQeWP0ghX21z6d9qKxcFeis8bxQhnFgbbVOjsQltmjrBFTCjhGx8Zi+j4VasIlbaT7CGTlwQKIJqMn1kd77WJCwcMEWDyp3Sm9Q+YrdNNLIV8pzMKFUCtdGo6vbj6KCSc06AwMtotiK/RCPFT3W+1subLYpFDQ0p0Cm/yEj4g9i2RcrgeLkEECmuRnBajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlrcHQs69AWZpiBQ4rcmZHxNbkmd9LKGHcYKfBRDqBs=;
 b=oPH/No693VcAHCiN4Lr+lWBSzTEmNxskJxnoKrA+WSeQGyHYOEyKMVmqPox/4aOhlSA5K8wzkFqevxNTAsW/e9eLKqx5W38+cdlDP5Q2t3/pOi3ZKR3eUIIHzfxCTXK/sLAd1da0ZPaAL0c27+EJN41Wy6kzrQcsLLVfoNbGWoV5VIHcZY3OWIfo7GyFPsS+EkkXPR2X0fROaaBfH5Iz/9C/cLvmr5/I+LTQ8E+I/kCvR/REFcCOT4JtJt51KnnVmhRNJ0WbbNPQFDjLeF01i2OosV0nVkDX+PGqbi7karVEP7iaw/IMuO1KxI3UiOI1CcdvhjdoQweeziO9z9dKNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlrcHQs69AWZpiBQ4rcmZHxNbkmd9LKGHcYKfBRDqBs=;
 b=V25ghA8rwT/t08njKLOG+FGtTmK+S7ZVNfpvag17zVeO5HYHa3vVntYUp7RsnW9mmH9110c9U1qtr4yLNPYQGEtWPSCXXrh2Sp+JoM2+nrQooNzaVDiymk2Ve4Kg8xsLFKjnmW5z32n4M+xQ7kML6JER6kbG5onAQRjRwz4GDbP2my2RH1g67qciRdCyKpalp/ptJoNgdWpu2e2XnEvZEVdg3crZirPWz7P+ZNeQofXw6jAg3CBqdXXYRTzzLQKsv9PM/ELzBO7bakQXIkqyygVqiXRbgPniELdUN8EknGKbp1eUtMuCWgEtsLBJr1/Ce/xpJ0BcgAoongUudr73LQ==
Received: from IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 07:08:13 +0000
Received: from IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::da5c:5840:f24e:1cd4]) by IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::da5c:5840:f24e:1cd4%4]) with mapi id 15.20.7807.030; Wed, 31 Jul 2024
 07:08:13 +0000
From: Jianbo Liu <jianbol@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, Leon Romanovsky
	<leonro@nvidia.com>, "andy@greyhouse.net" <andy@greyhouse.net>, Gal Pressman
	<gal@nvidia.com>, "jv@jvosburgh.net" <jv@jvosburgh.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net 2/4] bonding: call xfrm state xdo_dev_state_free after
 deletion
Thread-Topic: [PATCH net 2/4] bonding: call xfrm state xdo_dev_state_free
 after deletion
Thread-Index: AQHa4bU+grLNHe0ZgUmIjXuWQeZGWrIQMlQAgAA7D4A=
Date: Wed, 31 Jul 2024 07:08:13 +0000
Message-ID: <e10218c925c800de81872b21c8de169efcaf4c7e.camel@nvidia.com>
References: <20240729124406.1824592-1-tariqt@nvidia.com>
	 <20240729124406.1824592-3-tariqt@nvidia.com> <ZqmxUD29yIVHTaQb@Laptop-X1>
In-Reply-To: <ZqmxUD29yIVHTaQb@Laptop-X1>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.40.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6235:EE_|DM6PR12MB4284:EE_
x-ms-office365-filtering-correlation-id: 91fd6283-e596-48b1-8118-08dcb12f8ae5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?djhTR2J6N1l5SzVxcFdmenNVbUxsZ1BLVE9OeERLdFZsNUZNTWVhLzd1NWwv?=
 =?utf-8?B?Nklia2ZJU2JPS2l5VTZwRXNvb2VVV09KREU0My81MHdvVWJkZFJGN3E3R0JW?=
 =?utf-8?B?NnMrREZUOTBSTlcvcmhmS0cwWkpBWWl1Ry83UG5MeDViUUFORnhDTWVKNVIv?=
 =?utf-8?B?b1VKczVML2NCRWczcTJXVW5vdFN0UURYQk9IWnh0R2p4VEtLZU5PN0VFRGxL?=
 =?utf-8?B?enlubkdvcnlBVitobm5SRnF6UDM5bis5N2lGenkrSzZ2WDFhWVUvcHdMU0to?=
 =?utf-8?B?VzJOcXpMNVlzbXdWTHZMWVVmWXc2dW5RTTRaaGdPdmhXdmtBU1NwQ2tiSzV1?=
 =?utf-8?B?VE1lQWJXTHAzdFpoTVRQd2xVUWRUT2k1M1RZK1BCMHhZdHNDKys5ZmQ0bS9w?=
 =?utf-8?B?ZVl6cnVlcnR4c3A4UnhkUEFqWUcwWjRrdk5iQlFLOGhVZVkySXh6OVRMRlln?=
 =?utf-8?B?cG13Z0pSc0pXckV2QmlwSGMySzd2eU5ab2k1ZTJvVGFQRFErdzlHMHcyMzRU?=
 =?utf-8?B?UUkxd09wQXIxa1ZwV0xrM0ZuSyt3bjdFd09qZ1Zqd1hxZVBGY2VIMDQrd1Nm?=
 =?utf-8?B?bVljSkFodzBVL0R0ZnFCV3hyUlVyOHZGQzh3UFlCZWdJZU1NT3lpeHpXZnlR?=
 =?utf-8?B?UjhrZ3V4d2pRVWtnejh3RTM1eG8yNnRXN3ZxUDBLTkxKOW9MMXNwRnYyWC9V?=
 =?utf-8?B?QWpOWUVraVJka3ptUjdnWjZnNWhmZU1zbUdyVlcycXM1b3pTRUFEQTRGUXpo?=
 =?utf-8?B?VEt1d21KVXZQYkdKZDF0aDRBdUhjU0dwU1JpWmpORUFLd1Jva0M0K0cxVEpQ?=
 =?utf-8?B?ZnpibWt0UnBDdXR5c2lKaWozRWVjbVNLZTBFZlMyVzBXLzJtWFljUjVSVy9a?=
 =?utf-8?B?Y082WmRQdjE5WTVhSE00OUtUVlhpaUhDN21TUW0rQ25Menh2eU83cTRFMTU2?=
 =?utf-8?B?YlRZcitSRm1PdjlROWlvT1JuRzhuV3pkN3pHZU8wT2p3NldwaXQyMzhkbUJa?=
 =?utf-8?B?WElkTjFaVzEvRVpuZ2JIaUNYYk9DaCtnb2pLQnBrNHdLT3I1d2J5cnM0WXFm?=
 =?utf-8?B?UE9kZUlyalNmVW5HSEhaLzljN1I2RTZUYlVVSHF4M1dPeTA4RG41WGgraWh2?=
 =?utf-8?B?dUY5K3lpQjVuNXJNaVhTbEFIYzNyQk5nbkg1N3BERWh6L0pValF0TnlzZDhh?=
 =?utf-8?B?TWRJRTNTU1hleTNRVTY3UWp4eWpzeTBaRWdJRVUzWUMyUlhTM09jUlhYdFJv?=
 =?utf-8?B?dTI4UEpjMkdRSGRJdVFGNlNmbWMvOUxwdGVyMkl0WWdxUVh5dVNRa0ZWZkFl?=
 =?utf-8?B?NUJyU05FYjZrQ3RLR3FRV0J6MFp3YjJWK2JIWVBRWE9DOXA4d0JJQmJEOTd6?=
 =?utf-8?B?RkY5TGwzc3hQTVEzcTFPY094cEcxMnpUQ2RXMUhOU2JsMVpqenFQZmREZVhw?=
 =?utf-8?B?dStTdGx0Tjg0Nm5TV282UlVySjJGMWh4VVV6UVQwWE9peXZIYVpWMWVoWGgz?=
 =?utf-8?B?d3ZpZzVsSzZpMGtSeksrQTdhVFd4OWQ2WEYzMmo0ZUdFRG9jT25rWUdTSmVJ?=
 =?utf-8?B?VEtDOUk4YnpndVRKd1NRWnEzVXA5MURtSVhTZ1p2cXdjQnBLUnNCblpHaHZM?=
 =?utf-8?B?RGtpN3VwUHhSbSsraVJjelNUU0hEOHp2TitKNXZzSm9RaDB1U0JnMXBreW4r?=
 =?utf-8?B?bFV6VU1hRkJYVjVYNDNRU0lMeVo3SU52SkMxTFFwK243NUR4Q1Juc2FDbSs4?=
 =?utf-8?B?UFpWdlhrL0NvS0tMUEcySmN2UmJWSDRhK1ordTd2NkR2UWdOaFl4akFLZEtM?=
 =?utf-8?B?d0Y4bHBudDhqVkx4TW5CdWMzbjdyUjAzQzkxY0xNNm4rNmNnQ1V3MDlQTEYx?=
 =?utf-8?B?aXR5WEN3NzVrd1JSSS9BdU1lZ3M0L3dVZVcwWGJxT3Iwc1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6235.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkhaaS9wTTZQSS9PUUhPdkpIK1g0M3RjVjZPUGtyc1I3TkV6N1hobnBtbGlr?=
 =?utf-8?B?L0ZpbHhpVHRyeHIvRGREQk5VZ0d4elk5dFE0L0RqN25QL2ZIVGh3MThrQjNY?=
 =?utf-8?B?cm0zYW1DajJrcmVyY3VnMEMwbUdGMUY2blRkU0tlTmgzdGVNam12Z0lPYzJy?=
 =?utf-8?B?cWVaai9TWjNqU0liY1JYbzlUajdjN0Fyb1NybXBVdjhkR2R3VlpVOGUxZ2pT?=
 =?utf-8?B?YkFMOThCZVVJaDVsSjJibWt4bjJ2SVVaQXhpWXRqZzdlRFR3YkxZV0grazBa?=
 =?utf-8?B?aUZZblVyRVZoSEh2ck5hV0VWUmkrczVkMjE1ZVVIT2VOWlRPUERDOXZNQkR4?=
 =?utf-8?B?ZStMSU5iNmdUaDlWK1RLZitGbFgwOE52dzVZUUFHSWYyTXg4OTB2SnpYNWQr?=
 =?utf-8?B?amYzS3JTSEQzellVZVlPRmExdzV3czBBUnNQK2IwL0hoUVh0VkRERldBUzJp?=
 =?utf-8?B?bXlGYW9TZ1BBa3Bkd3VIREZwNUN3M1dsMnloSU1uZkdQZTVFZFVmT0lQenN6?=
 =?utf-8?B?SDExd1VLaGxSY1R2S1VsMWNDU0Q0bDk5ZXlPM1FtTnZtUzRaeDJBZUJpeHJW?=
 =?utf-8?B?R3AwaU16M0t6dnk0Q0lGVFFvRWF6SmFqa3R6aUNWUEN3VWR6Z3dscHR4RkVp?=
 =?utf-8?B?Z3MvQkkzVDh5VksyQUd4cWFuR1puYURaMVlqc25vQUtYQ29RclNwSFdBZ0lS?=
 =?utf-8?B?bGM5bkVUU0trSy8rQlgxUHovMWt4QmhXaDAvc3duUVhoVk82dW1mTENJc1Ns?=
 =?utf-8?B?bzFyeWFuT2VJcExmUlUvV3luOUIrd1dxZkRrdks2aFhTNnppR3g5ZExmMklF?=
 =?utf-8?B?cnE5R0E3WTJjVmt5OC9DWHREQW1QZnJqcXl2WTIxeGFtV3lLclVJK3p3cWRo?=
 =?utf-8?B?cXpqMWNraVdtRkY0VVQ2L1VoNXltd2xxTm1TQjE4ek9oNCthUE5rQnJqeDBO?=
 =?utf-8?B?VjdSVUo1d0VmL3FoUk1sT2Y5OHpROUhUcWI5NjJxUjRZc2doekdFRDdMQzFY?=
 =?utf-8?B?UWZMT2V4QUdycldoZVZBalhJTkFkVUF6MHl1b0QyOVJSME9La09GWmJJclVx?=
 =?utf-8?B?Y0xQYXB3L2NkTmptaDdnaG83Z3RPaWJQcGJxc3hPUHRTNmNaV3dBOE1WREtz?=
 =?utf-8?B?eCtBRVBoaS8vcGx1aG55Rnd1T3k4MWJIb0dicUJSck4vbHFLSXRHeHJuNXpO?=
 =?utf-8?B?WjlGc2ZFM0VmeXR5U0hnSURaVXVZQjdwbUpsWDlsdHIvbUhHRDgvU0lGZUFT?=
 =?utf-8?B?U014b2JhWk14NWNLSEdGODBXajNzZUxkeUJtN0Fqd0lOL0w5QjlBMlR5eWVa?=
 =?utf-8?B?a0lrNWtQMHpWc1Z4cnI4OFFtMU4zUzlTOTFJeHBJV2REL1NPMFRsYXZKTU5Y?=
 =?utf-8?B?QnlsZ0w4ZkVLWlVRN0k1RGswbDNWemVsZUp3NHNSUHpKUEY0cTV4MFRFdkY5?=
 =?utf-8?B?eEZPWURHM0FRMTAvR0VUdHllaUdMVG9TMmluRnpIWFd4cTJES2hQejNiTHEw?=
 =?utf-8?B?Sy8xTXdEQm5ZZlIraTNPVnQ2UloyN1gwSXlOcFNvb1V0eEdabmwzMFFBS0hk?=
 =?utf-8?B?aUFpcW5WZjhhOFVKS01NTTd1bUt0ZktNbnlnY1BRU2tCUkZZZjRtL2poYzZQ?=
 =?utf-8?B?UVRBbzBvZGR2Ymo5MS9xczVQd2JqOEZaTkE0MVVEaGUyeG5DQ1lFVHFqREdi?=
 =?utf-8?B?d1R6RFJ4enBpdURWc2tKOE9OR0poWDl6bmdaUFozSExFQXg0WDZXSThQdS81?=
 =?utf-8?B?bGxrbWZnUWlBRmRWY0pEWTVBN0M4dGNjR3hrait1ankrY3F1VmFOU3g0QmdL?=
 =?utf-8?B?TGYxMHJUd0FnZ05sUUtPVWgrUXVlNCtKNW5NYnJLR25pTEhUVk1zeUwwY1Vn?=
 =?utf-8?B?VDRCbmhNWmJqYXc2bWc1MjY4TVRNajI1blBQSEQvUml0M2k1L1BKMDVjVXpR?=
 =?utf-8?B?L0JFZ2N6ZG9aa1ltQTRsR3JKQi9JU3ZpeWlDNXhmWThOMlBLQnllQ1lQM1RN?=
 =?utf-8?B?aHc3UFhoNU0yM1VHbGhUUUJ0WW9HcFBRNTQrU2xORXQ1MkhUQ3hScXhHS3Jm?=
 =?utf-8?B?dlp6NHoyRjE4b3hFRi9xVUNDMDZ5Tmd6UXN2T3p4Q3Zzd3lzVDM4MWFVdGRp?=
 =?utf-8?B?VFArUWRqc25keU5WSStMaDVhb0tUeVhwR25INjk0Vk01M09LTitCaUVoVWxK?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74CA8A0CFD1BA540BAFE6A8E495D4DC5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6235.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91fd6283-e596-48b1-8118-08dcb12f8ae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 07:08:13.1073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ul+7trrexY9C8xlntoWz953CmST3pj39RqFojo7mc2xYSZGh/9pDVdzrzLM3Bw6IZ4DBr2GS1nCB1Q/G8BLtEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284

T24gV2VkLCAyMDI0LTA3LTMxIGF0IDExOjM2ICswODAwLCBIYW5nYmluIExpdSB3cm90ZToNCj4g
T24gTW9uLCBKdWwgMjksIDIwMjQgYXQgMDM6NDQ6MDNQTSArMDMwMCwgVGFyaXEgVG91a2FuIHdy
b3RlOg0KPiA+IEZyb206IEppYW5ibyBMaXUgPGppYW5ib2xAbnZpZGlhLmNvbT4NCj4gPiANCj4g
PiBOZWVkIHRvIGNhbGwgeGRvX2Rldl9zdGF0ZV9mcmVlIEFQSSB0byBhdm9pZCBoYXJkd2FyZSBy
ZXNvdXJjZQ0KPiA+IGxlYWthZ2UNCj4gPiB3aGVuIGRlbGV0aW5nIGFsbCBTQXMgZnJvbSBvbGQg
YWN0aXZlIHJlYWwgaW50ZXJmYWNlLg0KPiA+IA0KPiA+IEZpeGVzOiA5YTU2MDU1MDVkOWMgKCJi
b25kaW5nOiBBZGQgc3RydWN0IGJvbmRfaXBlc2MgdG8gbWFuYWdlIFNBIikNCj4gPiBTaWduZWQt
b2ZmLWJ5OiBKaWFuYm8gTGl1IDxqaWFuYm9sQG52aWRpYS5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6
IENvc21pbiBSYXRpdSA8Y3JhdGl1QG52aWRpYS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGFy
aXEgVG91a2FuIDx0YXJpcXRAbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiDCoGRyaXZlcnMvbmV0
L2JvbmRpbmcvYm9uZF9tYWluLmMgfCAyICsrDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2JvbmRpbmcvYm9u
ZF9tYWluLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2JvbmRpbmcvYm9uZF9tYWluLmMNCj4gPiBpbmRl
eCAzYjg4MGZmMmI4MmEuLjU1MWNlYmZhMzI2MSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25l
dC9ib25kaW5nL2JvbmRfbWFpbi5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvYm9uZGluZy9ib25k
X21haW4uYw0KPiA+IEBAIC01ODEsNiArNTgxLDggQEAgc3RhdGljIHZvaWQgYm9uZF9pcHNlY19k
ZWxfc2FfYWxsKHN0cnVjdA0KPiA+IGJvbmRpbmcgKmJvbmQpDQo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19m
dW5jX18pOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfSBlbHNlIHsNCj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzbGF2ZS0+
ZGV2LT54ZnJtZGV2X29wcy0NCj4gPiA+eGRvX2Rldl9zdGF0ZV9kZWxldGUoaXBzZWMtPnhzKTsN
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChz
bGF2ZS0+ZGV2LT54ZnJtZGV2X29wcy0NCj4gPiA+eGRvX2Rldl9zdGF0ZV9mcmVlKQ0KPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHNsYXZlLT5kZXYtPnhmcm1kZXZfb3BzLQ0KPiA+ID54ZG9fZGV2X3N0YXRlX2ZyZWUoaXBz
ZWMtPnhzKTsNCj4gDQo+IE9ILCB5b3UgZG8gaXQgaGVyZS4gDQo+IA0KDQpZZXMgOikNCg0KPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgaXBzZWMtPnhzLT54c28ucmVhbF9kZXYgPSBOVUxMOw0KPiANCj4gSSdt
IG5vdCBzdXJlIGlmIHdlIHNob3VsZCBtYWtlIHhkb19kZXZfc3RhdGVfZnJlZSgpIHJlbHkgb24N
Cj4geGRvX2Rldl9zdGF0ZV9kZWxldGUoKS4gSW4geGZybV9zdGF0ZV9maW5kKCkgdGhlDQo+IHhm
cm1fZGV2X3N0YXRlX2ZyZWUoKQ0KPiBpcyBjYWxsZWQgd2hhdGV2ZXIgeGZybV9kZXZfc3RhdGVf
ZGVsZXRlKCkgaXMgc3VwcG9ydCBvciBub3QuDQo+IEFsdGhvdWdoDQo+IHVzdWFsbHkgdGhlIE5J
QyBkcml2ZXIgd2lsbCBzdXBwb3J0IHRoZSBfZGVsZXRlKCkgaWYgdGhlIF9mcmVlKCkNCj4gc3Vw
cG9ydGVkLg0KPiANCg0KSSBkb24ndCBzZWUgdGhleSByZWx5IG9uIGVhY2ggb3RoZXIsIHNvIEkn
ZCBsaWtlIHRvIGtlZXAgaXQgYXMgaXMuDQoNCj4gQlRXLCBGb3IgbWUgdGhpcyBwYXRjaCBzaG91
bGQgbWVyZ2Ugd2l0aCBQYXRjaCAxLzQNCg0KV2lsbCBkby4gVGhhbmtzIQ0KDQo+IA0KPiBUaGFu
a3MNCj4gSGFuZ2Jpbg0KDQo=

