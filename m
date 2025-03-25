Return-Path: <netdev+bounces-177354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAF7A6FB2D
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7ECA3BBB93
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E6325A2C4;
	Tue, 25 Mar 2025 12:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uBoJEmLh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B81325A2B4
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905042; cv=fail; b=pyPVK0kKqAAcRPyL8x7mryzoaBaV0LDdNatup8UmGVGR8YtLozTYydgNkQPP979DyUZqlPnwdA04/qPA/4QCWIvmrYdF3SnFTelTlXUUAEi2LiNGh5rJmnL1F0/G0wB/sSB0TCjlXy6idkT8RUth8wPaK7a1QEpLRYnrAl6FFso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905042; c=relaxed/simple;
	bh=gWIa8TlLOc6w6l6XR/XVrwhlrf92THs1CqS3op2igJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=misOfTRlqI+tmuwss/9fdu+jYt+oTbqJL6sMJ+OPx61gZDb5YH0QUsWO1MPTsiNuj6/lDFAZoIE636H1wXJJbMQwIPP22Cf++VT+2LRUwo/rBmAeeRz/AM1lSHEU5ummEMfN3pD5hTH4V25tDAvtl1/gYfNXMSWwPRH2M0T06Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uBoJEmLh; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6nQ75iHqHYiR2qJ3pE6Lwm/PBvwRFqJjlvKrtpFzldNEGWhEPfLPix4b0M5/F30DqrtbSH5JOxt0chWYW+NXijKDyKJlSB2CYuloGLBh2HrTaCwkPNRFIfgbsDUivXxWdDGw3K9a5f2aAVGG173kQqdmFRV3JiRtDXUF5LFSHLlSysGuLyc34Eas5p05uKf/9C2mftVtdhbNVlB+qH0UtxZipD/PKNAehOvHFmGwDZAA2V0gNFSgBYBemCm/mcm2Bb859AYGsfVCA1KRKInd8Uic7pB4k/jLuIkIvfGUF8fsxXF4IDkZqLRZ6bdgYst4/2af/HziBoYTNDITf7KwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWIa8TlLOc6w6l6XR/XVrwhlrf92THs1CqS3op2igJo=;
 b=Dw+J5AwyJdkfZhg9SJ4GwF+1AFLBFtOTiz2WxQiWHmo0+Jnx15C8tBP6lT9GtjDR7ym/TpJGzZKAtpJ6jqfkPerLDdJ/3enMyMUXr7ABValoVv1ROR9dOyIZ5ygclxtfJ7RIsP5GLq4bjN01rOnkLg4eVyw6i38KzK8N4A2AQXQ/2kPgvDG2uv1t2SwP5B0plB5sB49WrTOerw0vePnts3d0RwuKGAsgepq7b+USPtEPUl94ZwVDU5GnfX6We4uGGvUCP9VvLJI+Nj3knB6GtNCarWjrPJaP2WpoW9//3FdbCX20SBlqsjOYwR8LykMwgi8YvUb6rScyAJdca1pajQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWIa8TlLOc6w6l6XR/XVrwhlrf92THs1CqS3op2igJo=;
 b=uBoJEmLh5xSheDZHrIwC4y2bCerIw1u6defoApC180OTIBIKwbnSzY9sJ2hCgT84FUxifMq0hl+qtIJyXHVuprMyqNzvn+RLftbKt0sfqWBwBpyLSJR69beUoxjHzzhFKfEaO647p75+WRrveCBk4eX32t+TUxxDawZKQygMJxOpT4Ij0zqJNAvAUsFKOFMMQbKzzsQuLVxqmeUoefLfIdyr+S1Tf750NgM1J81NDRo1Sh94CJg3TKIYX9G0O0wEbUTH1vz5Dm2IImTYwuC49+rjFBnSdJhSTj7GW8qTpX1KiLcQPA15CI6CKAgwPa8SpAW46+9qZV3Fx6TSyZueig==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 SJ0PR12MB5674.namprd12.prod.outlook.com (2603:10b6:a03:42c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Tue, 25 Mar 2025 12:17:15 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%2]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 12:17:15 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "sdf@fomichev.me" <sdf@fomichev.me>
CC: "horms@kernel.org" <horms@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "pabeni@redhat.com"
	<pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 08/11] net: make NETDEV_UNREGISTER and
 instance lock more consistent
Thread-Topic: [PATCH net-next v2 08/11] net: make NETDEV_UNREGISTER and
 instance lock more consistent
Thread-Index: AQHbnQ6wXfIZksHgm0+aIlfbXdNTJrODxY8A
Date: Tue, 25 Mar 2025 12:17:15 +0000
Message-ID: <0be167ba394a9485c78c67d187ec546131a5cbe1.camel@nvidia.com>
References: <20250324224537.248800-1-kuba@kernel.org>
	 <20250324224537.248800-9-kuba@kernel.org>
In-Reply-To: <20250324224537.248800-9-kuba@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|SJ0PR12MB5674:EE_
x-ms-office365-filtering-correlation-id: 79bbc595-40ef-4d83-ad15-08dd6b96fac2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VWxLNVBkQW1uUjUwU3FKWnNrRzFhWUFveWw5Sm4yMktUZWpsZzBmc1FSZnZE?=
 =?utf-8?B?YThNM01KVXRrNXBMcFdLRTFVZVErUExGbHVjLytid094V3NXU2hNem1EWTBC?=
 =?utf-8?B?THBKc0VVTU1HRFJNbzhHaCtxcm5Pcnorb1lXaExZNU02TmFTNWZUaFhwNytO?=
 =?utf-8?B?MDArQ1JZR1RYTEU5dG1qM0ZYUGtWVUJleEVVdXJ3bGhNbDdFR2ozNDR2SzQ4?=
 =?utf-8?B?WU1oenUrZmRIZkROL3NSSS9abmxHZ0hqL0RjbGltdCtlODQreHVIZWVlVDlB?=
 =?utf-8?B?cW9ReUF6Unk3djEzTGppZi9aZ2RCNTRlT3hFei9TcUNuc0NMK2J2OVhGY3p2?=
 =?utf-8?B?SlAvdkhqVHJEVDNtUU9ZRStxejRCSHFFVUlRbitZNlR2N3JYdi9LNlhjVDlV?=
 =?utf-8?B?c1B3ajl0Ykc1eDZScmhxcVVJNDdjUHZYUlJmR1I3bEhLSFk2emc3VGlzYnRJ?=
 =?utf-8?B?cVE3anQxUFo0ZlY3QXNBNmRyUHhTMmJRMG04VUFlWGZFaXl3VS9tOEMwd0sz?=
 =?utf-8?B?S2d6N09mZitCRDJNaWdRMVFhM3c2ME9YVWozVk9DcHhkeXlpRXlLNGZEeGlm?=
 =?utf-8?B?dy80VkFpNE5WS3RXNllvakdkNjZZczNFcUhiWG92SzFpNk9OME9SQVBUUGhw?=
 =?utf-8?B?V0hlSSt5U2lFWTd4V0lwUUxpclNqdVRYNTJ4dG5Ib05Ha0s0SHBBLzZ5WDJO?=
 =?utf-8?B?N3dIaStWcHNJTjV0R0hHVGhtbVB1S3pXN05pemF5THI3aHdQYWErOGxUZlJD?=
 =?utf-8?B?ZTNUTDhRejhuQzBMd3dUeDhBc2kzd2pxVXNJVDErVytMNjJLT0dyQnR5QTZw?=
 =?utf-8?B?blQveGxtaEdNbFdMREZXS0Fna2k0b2UwMVB6dSt3bkdMSjVhNWgwbWZ5SFUr?=
 =?utf-8?B?cEIweGNsalFKS3BSQVNlVnZKalJ6azU5MHZtSzlMaWs1bWVaT0lGYkdMWmgr?=
 =?utf-8?B?OFcwalk4TnNqZE9oYm5WdGgzOTlqOGdzTVVNblA4djVNTW5xcndZMkRPOWxR?=
 =?utf-8?B?VE9HazE3dk02aWNqM1M5YzRIOUJsUVZITGt3UUpDdjg3RlBqZmx3Y2Y3OUxs?=
 =?utf-8?B?Vi9abmk5QVJaNDZ5SmVyWmRhWXorem96MVRPT2FvY1ZOSVNPd0tqaUdYNmt3?=
 =?utf-8?B?Q2xKZEgxVHV4Sk1hZFc3UE5LZ2Jna2gzV1hIMkRYUkkxaWRON0dpZ1JrTU9s?=
 =?utf-8?B?OG9MaGI1bjdHVlRVZWExT3RnQ3g0UWh3cDh2cGp6OW02dFlhZnY0N2hzUGVT?=
 =?utf-8?B?eEdGbllvRUt3bDBtYTh1d0JpMjFDbGtORUVmRVNEd3k4ZCtSd1l3djlYencr?=
 =?utf-8?B?OEo1ck4zZk9DSFMyaHhYM2toMzZpU0RnUHVsTkdYRU5RcHFMeGFGb1ZFQmZM?=
 =?utf-8?B?cFVqclZYUnZHdkRTR3RNTzM2K2tEMFI0QnRZSStkMEtJMmhteUVIcDRabFd2?=
 =?utf-8?B?MHNhNDNzWHhmcEd5KzluclQ4U1p1TW1QWWhOOFoweVRCTUJhdm5FTmpXOHlQ?=
 =?utf-8?B?TTU4eGFhTEJ5d2orSjh4QjZaNFhPY3M2a1ZOOTRYeUtPYjVwU0MzY0Noek85?=
 =?utf-8?B?Q3NGZHc2K3BqeXhHdzBnYUJUNTFRSDBYbVpTckNuK0lhTGxQV0h0U245K3RZ?=
 =?utf-8?B?ZXNYbll3ZlBxQUpSTGU3MzQwR2NlV0JKNDk2eGxUR0crcHdBZTNIc1VpV1Mw?=
 =?utf-8?B?YmM5Y0JGYmlMaTdKVzRkVExDMTI5SXdkTVhlb2VGSkVYU0x1ZFJZRlhvNk0v?=
 =?utf-8?B?SjlCM3JhQWNwcENudzA1Ynh0anI1SEpDVzlNSEVjVXkyQWlWYTYvbGk4Slc2?=
 =?utf-8?B?eC9ITVJCd0ttVlp1clViaFczQXJ5UFEyUEo0MnZWL3djQ3hlYWNsK05Jd0Jo?=
 =?utf-8?B?N0UvMkdOUmtpdUQ5R0pXSUNBOW03SUdDTkJGQlVXdmV4cTIwaVE3NEJZVzVs?=
 =?utf-8?Q?LuCFYF92Y3QsjjGMiGx6ZYJpufyHS1Cz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V284S1VTM3ZJNjZaMHVyVlhnZjBhUFBLbStEUFY4WlJZK1ljTHI3eUE5M2I2?=
 =?utf-8?B?SmRnRldGK1A0eGwxTlB0aXBWL2pmRzdaa1R6V1ZycWRlNFFoYXZ4enFWYlB3?=
 =?utf-8?B?Y0pHZTR1U1ZoenRPbXEzQkhBcE5tZ3ZwKzB0V0RQSlh4emZsY1E2SzBPZnM2?=
 =?utf-8?B?N012T3FLTmFodGptWTkrcEhRcFNCVmgyYkIyMGdvUDRKV0x6K0pVR1hSK0ZT?=
 =?utf-8?B?dHlpZjZ6QWFsREkyQ3YxeU9ORVlJWStndTlGRGs1K0d2TUQ0R3NWTVN4LzBF?=
 =?utf-8?B?dkFTYWRVYnB4Vms2RVpZUmttL1M4Z042d282ZUVoUEdKdkVlNVVCZkNvVVlL?=
 =?utf-8?B?OUxaeENQMWtMblBGSEdXTzlmV29DSWR2NkV5bVJ5RUdFdHhZVGVpRGJsNk5N?=
 =?utf-8?B?eEtiSnB4QVFZc0tXc0owNTFuSDAzTjZQd3NjdnpSR1gxbTRXNGFzQnlhQmFW?=
 =?utf-8?B?ODBxZFlqNlRQQ1hwRFpOdmFTUnVDcmVHUTNDc21lNXlLM2ZwbGJCQWJPVmJQ?=
 =?utf-8?B?WUFrZ1BwUjFWZ2RtaEpUZUVOay9mRmNML0JFSDdUbUNuWXlHL3AxRkVXTDlP?=
 =?utf-8?B?Z1IwaE1GZXcwZWJXRll1RTVXYTJlS2M2R1JGb3RKbjhkYnNQMnRtazZQV1d0?=
 =?utf-8?B?dWtGUkhJejlrcGlZWm9yWnR1ZU9BbHEzOS9MWnMrT3djZmxxWDJzT2YxbE9h?=
 =?utf-8?B?M1NFRzJ3MzFrdkRVazVjcW1kRFNaVmsyMzJ3Z3c3QnBFTlB4TDNZYVEyTFo5?=
 =?utf-8?B?MTQyVW1SeGExenNaZkZ6SDFpa3dUWnRHNTQ5bVBMaUQ3Q25DcE5xN3pBMzRu?=
 =?utf-8?B?amIwNEl6Z3RYTjBVVXFiVlM3OE5EbTdyVTI2ZXlaNVkyVXdpUk0ybFNtRVBO?=
 =?utf-8?B?dHJYWlJhZjRCZE9VeHpMa1BYbEc1KzRSMHV3ZnZScFBycTBvRzJFNVkrcCtO?=
 =?utf-8?B?a3E1TmwvYTZoUWpzeUc1SENwWkFlMThTQlJBRDdnTXdiZUROaFNUVkQ1RGZC?=
 =?utf-8?B?VFdsTXdJdWpGa1BpMTNJZFRDQ2JxRXVyUjdRcWkrOUZDRlo5WFFIM3lKQ2tC?=
 =?utf-8?B?RjlaRTNFVW1FUFZNOWVCNHVXdkZFOCsydlNYYmo5OEgweWtKSFZET01VWCtO?=
 =?utf-8?B?OXB4a25ySi90WS94WitER0lPUGRkdGtMYW9yZHVNSEhvcVIzR25XMHppc3kx?=
 =?utf-8?B?bklNemh4eHJoRnJ4YTE0REY0d3ZZZEJkR2F6c3RmRmdmQjFKUTlLTlhlUTZK?=
 =?utf-8?B?WktTWk8vTkNiRktyYkgxMjNvMjJnQ2FGaU85QXJDTk9MYVo1YXlSV0FSWisz?=
 =?utf-8?B?Qzd4aUNYTnhBb0UvZlYyVmZWOVdkdUpud3hFYzdsWXJwYWRrTVh4UUVNUW1D?=
 =?utf-8?B?SGN2Qi9XVGJHczhvelJROU52NE9hOTFCY01ZdVB4cVNkS25Tejh4MlN5MGZ4?=
 =?utf-8?B?VGNZdmx6STBWaUZ6VWFyUHZEUE1sYVR5MGxheFpQTnRkdVJONnk2V3NnNUxh?=
 =?utf-8?B?RjFxNWZ5SGRDN2tDejRtS3lhTzQzY21nejJXVzF4VUV4Zm0vUDJ4K1RTeWJP?=
 =?utf-8?B?aGtreHJoMWNqa0xDQnhwSDlMOXdpNEYwUStNa1RDS2taN0NuaXNvRjdDVGox?=
 =?utf-8?B?SENMV0FHSElxV3VTaFp6cVN4eEdUYzlSM2c5S3dyS05laUtSWFhNVkk1M0JU?=
 =?utf-8?B?OFoyWUp4OExraDI5N0hSbFU0LzZwelVSNUF5RjFmUjZDRHFmN1plWHNhRXZV?=
 =?utf-8?B?Tm5mOTJjNVN6eHpQVmc5V2ozRXBtZUJUSlVxWG4vcnRHcTU3UHBQNThqcUV6?=
 =?utf-8?B?Sy9GSG1Uc1VvSmI0TlB1eG1FdWhIb2ViUk5HekJ4Q21MN3JKZWQ1VzZYUTk0?=
 =?utf-8?B?N0NocHNVQ0ZValozYS9HZVMwcWJXL3ZldXlmWGRMc1FxREZUbS9KRmp3NWNL?=
 =?utf-8?B?ZmdxMThwRGNCWU5oOGFLQWk5UnRsRlA2eDcxeU1zelJBaVpQeHMxaTJ5bitJ?=
 =?utf-8?B?NXJxbUVNcDlkVnNGTlZkdUxtQ2piSjZNeEFYQVllOGtBd1NjQUhCd01tTjFn?=
 =?utf-8?B?R0J1RUx2Q0dZUkhDclgyYllzcjFBak13aTJWL2ppLzF1ZEpld2EvWE5KK3lW?=
 =?utf-8?Q?ad4H5mHpC45Xqm+8nnUIiibok?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77F00612CBD0BF4A8372A3D76F2F640C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79bbc595-40ef-4d83-ad15-08dd6b96fac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 12:17:15.2345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MpS43U+NEfc1b/HYhT/YH6dt6DTjSpe6bh/Zl+7+hGQsG+UnMGB2jqycrrd8H7IhHLhgJWrztL07kgCkE6P9jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5674

T24gTW9uLCAyMDI1LTAzLTI0IGF0IDE1OjQ1IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gVGhlIE5FVERFVl9VTlJFR0lTVEVSIG5vdGlmaWVyIGdldHMgY2FsbGVkIHVuZGVyIHRoZSBv
cHMgbG9jaw0KPiB3aGVuIGRldmljZSBjaGFuZ2VzIG5hbWVzcGFjZSBidXQgbm90IGR1cmluZyBy
ZWFsIHVucmVnaXN0cmF0aW9uLg0KPiBUYWtlIGl0IGNvbnNpc3RlbnRseSwgWFNLIHRyaWVzIHRv
IHBva2UgYXQgbmV0ZGV2IHF1ZXVlIHN0YXRlDQo+IGZyb20gdGhpcyBub3RpZmllci4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+DQo+IC0tLQ0K
PiDCoG5ldC9jb3JlL2Rldi5jIHwgOSArKysrKysrKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgOCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L2NvcmUv
ZGV2LmMgYi9uZXQvY29yZS9kZXYuYw0KPiBpbmRleCA2NTJmMmM2ZjU2NzQuLjdiZDhiZDgyZjY2
ZiAxMDA2NDQNCj4gLS0tIGEvbmV0L2NvcmUvZGV2LmMNCj4gKysrIGIvbmV0L2NvcmUvZGV2LmMN
Cj4gQEAgLTE4NDgsNyArMTg0OCw5IEBAIHN0YXRpYyB2b2lkDQo+IGNhbGxfbmV0ZGV2aWNlX3Vu
cmVnaXN0ZXJfbm90aWZpZXJzKHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIsDQo+IMKgCQkJCQlk
ZXYpOw0KPiDCoAkJY2FsbF9uZXRkZXZpY2Vfbm90aWZpZXIobmIsIE5FVERFVl9ET1dOLCBkZXYp
Ow0KPiDCoAl9DQo+ICsJbmV0ZGV2X2xvY2tfb3BzKGRldik7DQo+IMKgCWNhbGxfbmV0ZGV2aWNl
X25vdGlmaWVyKG5iLCBORVRERVZfVU5SRUdJU1RFUiwgZGV2KTsNCj4gKwluZXRkZXZfdW5sb2Nr
X29wcyhkZXYpOw0KPiDCoH0NCg0KVGhpcyBpbnRyb2R1Y2VzIGEgcG90ZW50aWFsIGRlYWRsb2Nr
IHdoZW4gY2hhbmdpbmcgYSBkZXZpY2UgbmFtZXNwYWNlOg0KZG9fc2V0bGluayBhbHJlYWR5IGxv
Y2tzIHRoZSBpbnN0YW5jZSBsb2NrIGFuZA0KY2FsbF9uZXRkZXZpY2VfdW5yZWdpc3Rlcl9ub3Rp
ZmllcnMgd2lsbCB0aGVuIGRlYWRsb2NrLg0KDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQ0KV0FSTklORzogcG9zc2libGUgcmVjdXJzaXZlIGxvY2tpbmcgZGV0
ZWN0ZWQNCjYuMTQuMC1yYzYrICMxNDMgTm90IHRhaW50ZWQNCi0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQppcC8yNDU5IGlzIHRyeWluZyB0byBhY3F1aXJlIGxv
Y2s6DQpmZmZmODg4MTEzY2E4YzgwICgmZGV2LT5sb2NrKXsrLisufS17NDo0fSwgYXQ6DQpjYWxs
X25ldGRldmljZV91bnJlZ2lzdGVyX25vdGlmaWVycysweDczLzB4MTEwDQoNCmJ1dCB0YXNrIGlz
IGFscmVhZHkgaG9sZGluZyBsb2NrOg0KZmZmZjg4ODE1NWExMGM4MCAoJmRldi0+bG9jayl7Ky4r
Ln0tezQ6NH0sIGF0Og0KZG9fc2V0bGluay5pc3JhLjArMHg1Yi8weDEyMjANCg0Kb3RoZXIgaW5m
byB0aGF0IG1pZ2h0IGhlbHAgdXMgZGVidWcgdGhpczoNCiBQb3NzaWJsZSB1bnNhZmUgbG9ja2lu
ZyBzY2VuYXJpbzoNCg0KICAgICAgIENQVTANCiAgICAgICAtLS0tDQogIGxvY2soJmRldi0+bG9j
ayk7DQogIGxvY2soJmRldi0+bG9jayk7DQoNCiAqKiogREVBRExPQ0sgKioqDQoNCiBNYXkgYmUg
ZHVlIHRvIG1pc3NpbmcgbG9jayBuZXN0aW5nIG5vdGF0aW9uDQoNCjIgbG9ja3MgaGVsZCBieSBp
cC8yNDU5Og0KICMwOiBmZmZmZmZmZjgyZGYxOGM4IChydG5sX211dGV4KXsrLisufS17NDo0fSwg
YXQ6DQpydG5sX25ld2xpbmsrMHgzNWQvMHhiNTANCiAjMTogZmZmZjg4ODE1NWExMGM4MCAoJmRl
di0+bG9jayl7Ky4rLn0tezQ6NH0sIGF0Og0KZG9fc2V0bGluay5pc3JhLjArMHg1Yi8weDEyMjAN
Cg0KQ2FsbCBUcmFjZToNCiA8VEFTSz4NCiBkdW1wX3N0YWNrX2x2bCsweDYyLzB4OTANCiBwcmlu
dF9kZWFkbG9ja19idWcrMHgyNzQvMHgzYjANCiBfX2xvY2tfYWNxdWlyZSsweDEyMjkvMHgyNDcw
DQogbG9ja19hY3F1aXJlKzB4YjcvMHgyYjANCiBfX211dGV4X2xvY2srMHhhNi8weGQyMA0KIGNh
bGxfbmV0ZGV2aWNlX3VucmVnaXN0ZXJfbm90aWZpZXJzKzB4NzMvMHgxMTANCiBuZXRpZl9jaGFu
Z2VfbmV0X25hbWVzcGFjZSsweDRiNy8weGE5MA0KIGRvX3NldGxpbmsuaXNyYS4wKzB4ZDUvMHgx
MjIwDQogcnRubF9uZXdsaW5rKzB4N2VhLzB4YjUwDQogcnRuZXRsaW5rX3Jjdl9tc2crMHg0NTkv
MHg1ZTANCiBuZXRsaW5rX3Jjdl9za2IrMHg1NC8weDEwMA0KIG5ldGxpbmtfdW5pY2FzdCsweDE5
My8weDI3MA0KIG5ldGxpbmtfc2VuZG1zZysweDIwNC8weDQ1MA0KIDxzbmlwPg0KDQo=

