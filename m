Return-Path: <netdev+bounces-107288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E410B91A79D
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54664B29672
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4D9188CBF;
	Thu, 27 Jun 2024 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Aw4FA7Zm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1C4188CBC;
	Thu, 27 Jun 2024 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493974; cv=fail; b=BMn3+SjKlo6VuYfH+dXFfv81sYNYsXlXBFOzwvdBUOQsllkJh/49IS7WYHnhoC6BV+sVyMoHKk8+t8v6CKZAfIPFi1QwkmDdI9P/7KkRhIHECuxjtJIObPKm6hPf+C67KLt+1Fl4aLgwMcFEyOwb8lj+7/ypENDncKvlRddCRwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493974; c=relaxed/simple;
	bh=DhbzgVJ3EmgB0X54cWROxwNmi49+ml+FARp8sBy/lKg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZSnlxJTtT/E6UrTvgUbjBW0PQRuS49s5f14V9mmGitoigrqCx+h+S3ItqdrUGUeTHNFbxlH9S3+UQYXnrzs/F8cMzlqWb9DpsfXL4+QfZBflxO9l197uRwCadTvk1HWd8YkJ8n+OB1Md6cbknk5PuyOSCFFWjfD4dblE4FpLz3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Aw4FA7Zm; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCGVOzUeR8kTmYbS0Lxxk7/fhPF7y7bn3YZdDyYXSycplQheRi+F4L24AaCmyLyDIAnXzuivopwAp8i8+yioMJJiT4tCG2aqB7F1lYFyRIdljjwbUVqE4Npz3C4mkh5HT51GR8gfWEhGC3y1dbWVTPdO3puJuZynpV7KTBPnoiKQtAcg3xqmMkewiGequTDRjPtmMouloLtkHfsJ5elU0U5m+pP73ANzfGSNcnpYkl+y9kKiOkdekwDWgi99KT0ERa+SXkCcKsJOcAdWmoymj84K4oTwRKBS2YEffa/lyVVeCRV6MF6OU+JZzuYLwXCAd79M7uUgZuNMYmZg4r/IsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhbzgVJ3EmgB0X54cWROxwNmi49+ml+FARp8sBy/lKg=;
 b=ddlq8o5hzkc4dVbaBhodoaP9i7ax16Lzo0yWx4lTuFwFwbPtAMLKDg3JWvC2Sg6OE573iOQCV59TiWvbygdWckIhox7xiUy2UDSw/AnL2WruEIRKpU1/9FCxQ9sl5HwFFu3kmZ96lmrxY6QQTOHRtNrgHXbWWP1uUI/8pLFgzmJ3vagVIgyHHtI5tSA0P/NiWGt9oM94Wi9G5xTkhK7iLOo/Mn9Up0sh+vmlEKkYcioaD6flU7Bo5TDWj53nwrqKDzkiMYi/8lSHcJKioBcxA1HR8Y89Ll6jngiHtgNF8455yh/t6aAPC3TmTfCDwLx25Yf/M//jO+MzQj2OFpTzIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhbzgVJ3EmgB0X54cWROxwNmi49+ml+FARp8sBy/lKg=;
 b=Aw4FA7Zmp/vwSkKNGv33ufF/OxhheFufF+LwEcGCsgzkUIke1TiYoIVyDlV/Vfh0UFe1Zza3e/iWVVtRG2g02GJHVO+ivBMewl9rmDh7HKwUXZ9EbuF2JWzPCKwlNTKS+zby2CFn3FZUyH4IrTBOf1DpbqUyGtgrUW/LVt2YXNPrO6EQhmkgBTserzWf/ssTFsZUUe34dFljXpx1theZXvEBR/B0QCyEi0sVk2BitpF9bSvkEgnwVN9d/Oke50zZ+3NzQNmq2OwDPWUzq++wlDSj897vnUZ8+qDAHm0dgFI04/ZVwEblonAhI4Kcrn9vO7lckfYsiyvZ7vnaQAEVpQ==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 13:12:48 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%4]) with mapi id 15.20.7719.022; Thu, 27 Jun 2024
 13:12:48 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "sdf@google.com" <sdf@google.com>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "shayagr@amazon.com" <shayagr@amazon.com>,
	"paul.greenwalt@intel.com" <paul.greenwalt@intel.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, mlxsw
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>
Subject: RE: [PATCH net-next v7 7/9] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Thread-Topic: [PATCH net-next v7 7/9] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Thread-Index:
 AQHaxl9qSClTcs0l902JzHpAxldWxrHXUtgAgADOufCAAc1zQIAAIPQAgAA22tCAAAzygIABO/eQ
Date: Thu, 27 Jun 2024 13:12:48 +0000
Message-ID:
 <DM6PR12MB45160145A33D8B802F5AE961D8D72@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240624175201.130522-1-danieller@nvidia.com>
 <20240624175201.130522-8-danieller@nvidia.com>
 <003ca0dd-ea1c-4721-8c3f-d4a578662057@lunn.ch>
 <DM6PR12MB4516DD74CA5F4D52D5290E26D8D62@DM6PR12MB4516.namprd12.prod.outlook.com>
 <DM6PR12MB4516907EAC007FCB05955F7CD8D62@DM6PR12MB4516.namprd12.prod.outlook.com>
 <baf84bde-79d3-4570-a1df-e6adbe14c823@lunn.ch>
 <DM6PR12MB4516062B5684DA1F4C5F49FED8D62@DM6PR12MB4516.namprd12.prod.outlook.com>
 <ad5dd612-1b8d-4061-808e-2199144dc486@lunn.ch>
In-Reply-To: <ad5dd612-1b8d-4061-808e-2199144dc486@lunn.ch>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|IA1PR12MB7661:EE_
x-ms-office365-filtering-correlation-id: ea194f73-5286-4c8f-6328-08dc96aad788
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YXVHQ3hSSVNjZkNWZjlVUkNhdHhZbEZURVF3cjVtaC8yM0JBeXd2bEVJOUpi?=
 =?utf-8?B?bFdaRGxDajJ2UGZqWnNrbVFIZmFzS0tXakpENWJJQ3k3NXYvZW4weGNFb3hi?=
 =?utf-8?B?dzI2Q0FvMHVCSUJnSTREUDdTaEZ6MlFURUFZMDV4b0t3dlNWVmYxN0dvWDRW?=
 =?utf-8?B?UGFwRXVYbWFuRzQwaUtpYUw2TlVKTGN4ZEwwSys0VmxWaUdmSzQ5d09kbHJV?=
 =?utf-8?B?UGJKTmUyM1ZuZmc1KzhZelNQQ1FqTktLZVFRcW5va3BiSUowNTc3VFlTZGFW?=
 =?utf-8?B?YkhXelZjU1Z1WTMwSFFkMnRVTUZGTkxheHFjMUYxZ25yenZaMHB5MXBXUWI4?=
 =?utf-8?B?N0owMzJ6b3lzODNPVjRpUXovSmNvTTlTaEYyNnhtZ0ZLY2xuT0diSG9ZbWdK?=
 =?utf-8?B?dmRuWW1jd3MvUW9MaFdJSXIvZGlCS2ExWVFiWkJzMmdqQ1lDaWZqNXNXN0Nt?=
 =?utf-8?B?bktraXkvL1FzSW5GNTBUTEE1dHk4WkIyNCtmNG1EaHlxS2VIaXAyNmZFNlV1?=
 =?utf-8?B?WE9xd0FSU1J4SGtUZDFjZTRhRVJ4KzZ3VGtqOHFERmc3R3llMVUrNTRHNzBx?=
 =?utf-8?B?L1lZTlFEby9ucHprVE5EeHFBbjRmMFRZM04rOU85RUtvWFh5ZGpXYkVmTnha?=
 =?utf-8?B?VVhKVWhLbEtFVk0zZExaOWIwbnRxNEQwZnE5RTlNTS9RMjcyQk1iRGw2ZTRU?=
 =?utf-8?B?OWhLa1NZUEJ4TE43RkRscjg5cThNWEViVlpKemw1eWlWYTcrbUJnQ1hPbDFm?=
 =?utf-8?B?b2s1M3QvcXFZT1V6TTdaa3VuU1FyWk9vMFFhWEE0bXk0YnhscjBpZ1BRd1Vm?=
 =?utf-8?B?a0Fqc0JaZDhrKy9KUTUrYnI5ZWZheVVjUHlxaE4zSlg1aDJ1bU1YSVFpRWwy?=
 =?utf-8?B?VWN6Zmt0WWVaMk5wZW4zblkzczRqTEtheHVSdmp1NENVUFlLRC94ZlJrREN0?=
 =?utf-8?B?T21OY2YycnoydGExaHJJN3BsNmc0VEozQ2lJZGRyRXBaaFZQQkY1N3VHZmZL?=
 =?utf-8?B?d0d5Q0QxbEs0OFlvTWU5RVpIeWowa1Z4VS9ZRC9GUWhQYzd1NlVFSklEZjZU?=
 =?utf-8?B?b2V0eHpVUFE5WmNKK0xXSk9oU0wrWlpBdXFBdGpLTkljOWhOdm14U2p6clZn?=
 =?utf-8?B?dWpFY1hDaWUzOHNiTkQyOU1KM3phenlQWXRUMEhZVEZTa1JGNUJGTy9rTVhM?=
 =?utf-8?B?MzRTS1l6VjJsdVNkdnhVNEwzUjVSMENqT2tWM1BlWjN5WUJXUjA1S2d2a2hm?=
 =?utf-8?B?YnRMc2c2RDlSeERsWm9mSyswaDRDdmc5MmJqMXByaWtoMWszZUtBZkwraEFS?=
 =?utf-8?B?QlJLVXRkTDlDV2ozNFF6TnJmNjZkODB6LzNxbkFkMUtBVFFpb3JWZ0NLcWpa?=
 =?utf-8?B?SHVnVWZwR3QrNG9rR216NGhpdTFPdk83WHVTcEFaK2JqdmtzUDVqd3FiWTZU?=
 =?utf-8?B?YjVqeHBYYnFtQVhaZG9mQ2RMNXpld0lxR2ZJSnowUTQwbExSc01DeURWVGQ0?=
 =?utf-8?B?bnE3YkxVYWlQdEpRRXk0WjY1NHd3eElKaWM3YjY4WnZqNGpYMGFXdHBaQnQ1?=
 =?utf-8?B?TlNSZmE5SzNLSWIxSGwzaGRMN1o3cHpCOW4vaHdoRFhKbGRKS1RmNmlxaHpu?=
 =?utf-8?B?S1lFL2pxWFpqNkd0R0NQZW9PQ3B6SGFRSHl2UklvckdvYWkvczRQWVJwdlFs?=
 =?utf-8?B?aE5tbjR2TG9JV1NDTVBYZGxRL2Z2a3l4Q05KUm1mdHZHM1lGQkFUTFNWZHF1?=
 =?utf-8?B?K3J1Z1RiNkRxUWFGQXErSGtZek5kREJFcmJqOFVoTUZFcTF3WUx0Yyt6a2xE?=
 =?utf-8?B?S3puanFObnpaLytsWVREYWlNVGt6ek9jaExRRnNKcVkzcDQ3Y3FtUExXS29W?=
 =?utf-8?B?SDN2ektLeVhSRG1TYVhad003NXF5S2ZuaXdhTnZZN3ZRQkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a2wwRlNiOWU5RUthV3NabnRCVHJOVEpTTGFQSGhiUitINDlGVVJ2NW01cEhu?=
 =?utf-8?B?YWk1OEJOUTRTWXcxRGRtLzkvL2dkZStTbHJ5VVRTU05Tc0F0Y1puckRpMG1I?=
 =?utf-8?B?K05iUGF6QUpJYysyRFNmc09LRG85WlhwYmhTRmwwc2pzMDRMTDB0WUs4ZlBm?=
 =?utf-8?B?VEtWaVdMQ3J6aW12NFcvRkIwUTk3dHRDdVZwdnFHVUZ5WHJNSEdpWjllNmN6?=
 =?utf-8?B?RllJOWtMbEUwc1dEdENScHkvRFI0S3NUMXpzM2ErV0ZOYWFxb2Z5MldGV0FY?=
 =?utf-8?B?L3BmMDAybjBDbktnVTBIZHdjQzYzSnUrYXdTdkxXNEwzUmFlNTBteUlDMVht?=
 =?utf-8?B?WEs1SGtBY2RsdkFwaXNYZjcycTl2TkRhaGd0aHg2aU1vZVJocDZIaWVLRDFw?=
 =?utf-8?B?WVh4WUlDTmtEOXl3YVRlL1JJcEZsNDIxWU9QWXFxN2VmS3NPT2lsMnh4MGJ1?=
 =?utf-8?B?dVl3Z0hkaVp2bG94L1I5UXphV1EweUJUTnRtZ2NFSkd0VGE2K0FCclRnNGEr?=
 =?utf-8?B?RUVmRnRvaHVPWi9XUW5EQ1ArdGRrNUVLbkc2RVZySDRDRi8zNHFNQzM3TXgx?=
 =?utf-8?B?dFBXVGJxZ29vTXlSb2RxYnEwY25RVnoyeTVKay9xcDV4Wm41UHU5TVRnQ0Yy?=
 =?utf-8?B?ZFp4anJ2NlFCZGVCWFpKRzlUYTFYdS81UzNLWVFRWG5KNXhRV2d2dzFYVWVi?=
 =?utf-8?B?UWVtU2QzaEg2TWdEQ29UQ2Jkby9WTU9aSDNMT01nZkttbDN2MER2SUFUTytZ?=
 =?utf-8?B?ZmxtTVFhVnQvZlVsOGRqWFNlemdrbjFUYnROZkY3a2dYVVBQenVEendiQlBk?=
 =?utf-8?B?Y2U0ZjRaWG1YTmJzelNRd1ROZ0dOdk9iM3k4bXNCR0cxZnA4UzRzUUMzTnkw?=
 =?utf-8?B?azRFdlBpWVluUjJoYzM0bG1lMDFvMTFXNTRlQXJUNHlqdWRpNHRBSTV5Yk1t?=
 =?utf-8?B?dm9abG92VUxmbi9kQk81NnczUzZtcGVsYlZhenByd0JIVGwveENDeVFjdjNZ?=
 =?utf-8?B?dG5lUU5nMFI3K2E5b0xXZk81ZmxEYzdKdUo4TW56WTNDL1lJRHdIaW53TTRm?=
 =?utf-8?B?ejFEWUEzS0NtMXBXSUdZRnlsRmgvRmJMZzVOVTFZb3VhR1BkTGsrUDIzRExu?=
 =?utf-8?B?OHN0bFYxOUVnd285dDhrdUFNT0FRcVdwRFJqc1ExZjF0ZXVsNlhuVmZmZWlk?=
 =?utf-8?B?NHZUTFhMc1ZHb3JLMmxSNWg2MnRJNjJjQksrVzNHYmV5QjhuRjhTRUtSckZi?=
 =?utf-8?B?bnM3VkFvMEdzSWpVdVJsTnpRK3YvSGh6cC95WHRwZzdSOUpFd1lmakZKbmNO?=
 =?utf-8?B?QitRVVgvSmZpRlBhRndsazlONGRyV1h2Mmc3a0E4emZIYnBkeWZDWUlaY0w4?=
 =?utf-8?B?OWZic2RUSklTMmIyc3RLcTdBUnhJOHFreUZUQndISGZoUnVwK0gwcDBJbVpY?=
 =?utf-8?B?VWw0SUtPVm5DWm82M1Vtakl4WDk3cGFieCtOSm9lTFpRUWdpMWtGcGhnR1NH?=
 =?utf-8?B?bzdJTEtMLzJ2eTk5TjVEWWlhVkFKWXRsajJ4U0VqUyt0NnJUSVB0NVRmbXM3?=
 =?utf-8?B?bGJOb1pNdjdmM1pnMk9TVGNIRHAwZS9MRFk1eVhHRzhoZnhpUlcxSk9YandU?=
 =?utf-8?B?d0dHTEFWMFlIYWU5VUhjWUdyeVM3WFNMNHN5ZjlJV3c0cFoyblBxOXdPdkZk?=
 =?utf-8?B?dkxNVERyeHM3c2pzTDFEK1RsUjF5RTRtNjJsaUk0TTBPNjJWU005cC9Ob3h0?=
 =?utf-8?B?bnB3ZTBVaDdjTFFKcmd2K3NKR1JidUtTMXUrcENYYk4zRFNLNndhMklZOHA4?=
 =?utf-8?B?R1NNMlhmMllXMzVaYWlXTzdMaXNBSTl4a2hsRmhmWTU4azQ4d3hBYS9JRHRu?=
 =?utf-8?B?TnhPNHBGYlNmWjZhUjl1UEM0WWIzM1ptbHQvcngvWGFMM05pRTkvd1dYcms5?=
 =?utf-8?B?TmVURkFQc1VrZGdjV1RqQUVETUVjTHRFZTJkRXpnVGhsNnFpakpxOTEvN1Bw?=
 =?utf-8?B?MTk1bGorSlNCSnk4b0YyWGFJYkxnWU5iRUJ2STVyMExzTzlwT21zUW85ZFhX?=
 =?utf-8?B?dlpDRFZrTHJhWXFzWDhQeXhJN3JqbnZIVEkvTXhHd29vUWY1RkZ4RVVVZXpD?=
 =?utf-8?Q?VlUdSd6zC/Ya6gEaQyZDjXmi1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ea194f73-5286-4c8f-6328-08dc96aad788
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 13:12:48.4118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 60n3huu4akd+nl6o5YwkZ6JGs/6fDw6cb1KYGzHWLH2HxR3XtAfUHrFFl3DtnuFn2fYhcO9s+CPKHrCfv0ARFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7661

PiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+IFNlbnQ6IFdlZG5lc2RheSwg
MjYgSnVuZSAyMDI0IDIwOjQzDQo+IFRvOiBEYW5pZWxsZSBSYXRzb24gPGRhbmllbGxlckBudmlk
aWEuY29tPg0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGF2ZW1AZGF2ZW1sb2Z0Lm5l
dDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsNCj4ga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0
LmNvbTsgY29yYmV0QGx3bi5uZXQ7DQo+IGxpbnV4QGFybWxpbnV4Lm9yZy51azsgc2RmQGdvb2ds
ZS5jb207IGtvcnkubWFpbmNlbnRAYm9vdGxpbi5jb207DQo+IG1heGltZS5jaGV2YWxsaWVyQGJv
b3RsaW4uY29tOyB2bGFkaW1pci5vbHRlYW5AbnhwLmNvbTsNCj4gcHJ6ZW15c2xhdy5raXRzemVs
QGludGVsLmNvbTsgYWhtZWQuemFraUBpbnRlbC5jb207DQo+IHJpY2hhcmRjb2NocmFuQGdtYWls
LmNvbTsgc2hheWFnckBhbWF6b24uY29tOw0KPiBwYXVsLmdyZWVud2FsdEBpbnRlbC5jb207IGpp
cmlAcmVzbnVsbGkudXM7IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBtbHhzdyA8bWx4c3dAbnZpZGlhLmNvbT47IElkbyBTY2hpbW1l
bA0KPiA8aWRvc2NoQG52aWRpYS5jb20+OyBQZXRyIE1hY2hhdGEgPHBldHJtQG52aWRpYS5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgdjcgNy85XSBldGh0b29sOiBjbWlzX2Nk
YjogQWRkIGEgbGF5ZXIgZm9yDQo+IHN1cHBvcnRpbmcgQ0RCIGNvbW1hbmRzDQo+IA0KPiA+ID4g
UGxlYXNlIGNvdWxkIHlvdSB0ZXN0IGl0Lg0KPiA+ID4NCj4gPiA+IDY1NTM1IGppZmZpZXMgaXMg
aSB0aGluayA2NTUgc2Vjb25kcz8gVGhhdCBpcyBwcm9iYWJseSB0b28gbG9uZyB0bw0KPiA+ID4g
bG9vcCB3aGVuIHRoZSBtb2R1bGUgaGFzIGJlZW4gZWplY3RlZC4gTWF5YmUgcmVwbGFjZSBpdCB3
aXRoIEhaPw0KPiA+ID4NCj4gPg0KPiA+IFdlbGwgYWN0dWFsbHkgaXQgaXMgNjU1MzUgbXNlYyB3
aGljaCBpcyB+NjUgc2VjIGFuZCBhIGJpdCBvdmVyIDEgbWludXRlLg0KPiANCj4gSSBfdGhpbmtf
IGl0IGRlcGVuZHMgb24gQ09ORklHX0haLCB3aGljaCBjYW4gYmUgMTAwLCAyNTAsIDMwMCBhbmQg
MTAwMC4NCj4gDQo+ID4gVGhlIHRlc3QgeW91IGFyZSBhc2tpbmcgZm9yIGlzIGEgYml0IGNvbXBs
aWNhdGVkIHNpbmNlIEkgZG9u4oCZdCBoYXZlIGENCj4gPiBtYWNoaW5lIHBoeXNpY2FsbHkgbmVh
cmJ5LCBkbyB5b3UgZmluZCBpdCB2ZXJ5IG11Y2ggaW1wb3J0YW50Pw0KPiANCj4gPiBJIG1lYW4s
IGl0IGlzIG5vdCB2ZXJ5IHJlYXNvbmFibGUgdGhpbmcgdG8gZG8sIGJ1cm5pbmcgZncgb24gYSBt
b2R1bGUNCj4gPiBhbmQgaW4gdGhlIGV4YWN0IHNhbWUgdGltZSBlamVjdCBpdC4NCj4gDQo+IFNo
b290aW5nIHlvdXJzZWxmIGluIHRoZSBmb290IGlzIG5vdCBhIHZlcnkgcmVhc29uYWJsZSB0aGlu
ZyB0byBkbywgYnV0IHRoZSBVbml4DQo+IHBoaWxvc29waHkgaXMgdG8gYWxsIHJvb3QgdG8gZG8g
aXQuIERvIHdlIHJlYWxseSB3YW50IDYwIHRvIDYwMCBzZWNvbmRzIG9mIHRoZQ0KPiBrZXJuZWwg
c3BhbW1pbmcgdGhlIGxvZyB3aGVuIHNvbWVib2R5IGRvZXMgZG8gdGhpcz8NCg0KT2sgaSBjaGVj
a2VkIGl0IGFuZCB1c2luZyBuZXRkZXZfZXJyX29uY2UoKSBmdWxmaWxsIHRoYXQgaXNzdWUuIFRo
YW5rcyENCg0KPiANCj4gPiA+IE1heWJlIG5ldGRldl9lcnIoKSBzaG91bGQgYmVjb21lIG5ldGRl
dl9kYmcoKT8gQW5kIHBsZWFzZSBhZGQgYSAyMG1zDQo+ID4gPiBkZWxheSBiZWZvcmUgdGhlIGNv
bnRpbnVlLg0KPiA+ID4NCj4gPiA+ID4gPiA+ID4gKwkJfQ0KPiA+ID4gPiA+ID4gPiArDQo+ID4g
PiA+ID4gPiA+ICsJCWlmICgoKmNvbmRfc3VjY2VzcykocnBsLnN0YXRlKSkNCj4gPiA+ID4gPiA+
ID4gKwkJCXJldHVybiAwOw0KPiA+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiA+ICsJCWlmICgq
Y29uZF9mYWlsICYmICgqY29uZF9mYWlsKShycGwuc3RhdGUpKQ0KPiA+ID4gPiA+ID4gPiArCQkJ
YnJlYWs7DQo+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4gKwkJbXNsZWVwKDIwKTsNCj4g
PiA+ID4gPiA+ID4gKwl9IHdoaWxlICh0aW1lX2JlZm9yZShqaWZmaWVzLCBlbmQpKTsNCj4gPiA+
ID4gPiA+DQo+IA0KPiA+ID4gTy5LLiBQbGVhc2UgZXZhbHVhdGUgdGhlIGNvbmRpdGlvbiBhZ2Fp
biBhZnRlciB0aGUgd2hpbGUoKSBqdXN0IHNvDQo+ID4gPiBFVElNRURPVVQgaXMgbm90IHJldHVy
bmVkIGluIGVycm9yLg0KPiA+DQo+ID4gTm90IHN1cmUgSSB1bmRlcnN0b29kLg0KPiA+IERvIHlv
dSB3YW50IHRvIGhhdmUgb25lIG1vcmUgcG9sbGluZyBpbiB0aGUgZW5kIG9mIHRoZSBsb29wPyBX
aGF0IGNvdWxkDQo+IHJldHVybiBFVElNRURPVVQ/DQo+IA0KPiBDb25zaWRlciB3aGF0IGhhcHBl
bnMgd2hlbiBtc2xlZXAoMjApIGFjdHVhbGx5IHNsZWVwcyBhIGxvdCBsb25nZXIuDQo+IA0KPiBM
b29rIGF0IHRoZSBjb3JlIGNvZGUgd2hpY2ggZ2V0cyB0aGlzIGNvcnJlY3Q6DQo+IA0KPiAjZGVm
aW5lIHJlYWRfcG9sbF90aW1lb3V0KG9wLCB2YWwsIGNvbmQsIHNsZWVwX3VzLCB0aW1lb3V0X3Vz
LCBcDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2xlZXBfYmVmb3JlX3JlYWQs
IGFyZ3MuLi4pIFwgKHsgXA0KPiAgICAgICAgIHU2NCBfX3RpbWVvdXRfdXMgPSAodGltZW91dF91
cyk7IFwNCj4gICAgICAgICB1bnNpZ25lZCBsb25nIF9fc2xlZXBfdXMgPSAoc2xlZXBfdXMpOyBc
DQo+ICAgICAgICAga3RpbWVfdCBfX3RpbWVvdXQgPSBrdGltZV9hZGRfdXMoa3RpbWVfZ2V0KCks
IF9fdGltZW91dF91cyk7IFwNCj4gICAgICAgICBtaWdodF9zbGVlcF9pZigoX19zbGVlcF91cykg
IT0gMCk7IFwNCj4gICAgICAgICBpZiAoc2xlZXBfYmVmb3JlX3JlYWQgJiYgX19zbGVlcF91cykg
XA0KPiAgICAgICAgICAgICAgICAgdXNsZWVwX3JhbmdlKChfX3NsZWVwX3VzID4+IDIpICsgMSwg
X19zbGVlcF91cyk7IFwNCj4gICAgICAgICBmb3IgKDs7KSB7IFwNCj4gICAgICAgICAgICAgICAg
ICh2YWwpID0gb3AoYXJncyk7IFwNCj4gICAgICAgICAgICAgICAgIGlmIChjb25kKSBcDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOyBcDQo+ICAgICAgICAgICAgICAgICBpZiAoX190
aW1lb3V0X3VzICYmIFwNCj4gICAgICAgICAgICAgICAgICAgICBrdGltZV9jb21wYXJlKGt0aW1l
X2dldCgpLCBfX3RpbWVvdXQpID4gMCkgeyBcDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICh2
YWwpID0gb3AoYXJncyk7IFwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7IFwNCj4g
ICAgICAgICAgICAgICAgIH0gXA0KPiAgICAgICAgICAgICAgICAgaWYgKF9fc2xlZXBfdXMpIFwN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgdXNsZWVwX3JhbmdlKChfX3NsZWVwX3VzID4+IDIp
ICsgMSwgX19zbGVlcF91cyk7IFwNCj4gICAgICAgICAgICAgICAgIGNwdV9yZWxheCgpOyBcDQo+
ICAgICAgICAgfSBcDQo+ICAgICAgICAgKGNvbmQpID8gMCA6IC1FVElNRURPVVQ7IFwNCj4gfSkN
Cj4gDQo+IFNvIGFmdGVyIGJyZWFraW5nIG91dCBvZiB0aGUgZm9yIGxvb3Agd2l0aCBhIHRpbWVv
dXQsIGl0IGV2YWx1YXRlcyB0aGUgY29uZGl0aW9uDQo+IG9uZSBtb3JlIHRpbWUsIGFuZCB1c2Vz
IHRoYXQgdG8gZGVjaWRlIG9uIDAgb3IgRVRJTUVET1VULiBTbyBpdCBkb2VzIG5vdA0KPiBtYXR0
ZXIgaWYgdXNsZWVwX3JhbmdlKCkgcmFuZ2Ugc2xlcHQgZm9yIDYwIHNlY29uZHMsIG5vdCA2MG1z
LCB0aGUgZXhpdCBjb2RlDQo+IHdpbGwgYmUgY29ycmVjdC4NCj4gDQo+ICAgICAgIEFuZHJldw0K
DQpPayBpbGwgZml4IGl0LCB0aGFua3MuDQo=

