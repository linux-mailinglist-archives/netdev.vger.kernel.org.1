Return-Path: <netdev+bounces-162218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBC2A263AA
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 20:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1605D165F90
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 19:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1864D20E016;
	Mon,  3 Feb 2025 19:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fd5pbfVS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E2D20E70E
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 19:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738610236; cv=fail; b=n7T+YM8tjcW9DiuWwTlSVT/rG2bR3P46i0ecZPIFYZcQL1wtejRqRmX8mxsD5J0bBhaVaOAQ+GjZL9kC3G6OlX2oPuLd6yS9q7sfGHbJ1bUzzfGr2Pp7yB2hwbsDrVDWoSFR4wNhbe/jJkDebU54n7l/cS7g+PwboGw453Y1cNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738610236; c=relaxed/simple;
	bh=l4YlC1HlXhcXi2A42J5UXehJfUS2HU2zknmSMevHcoE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZUoJYZWVGLaKNhhf+9eC2QEfvJGSkcJwIEBeuoTp0BxO9E9NeSMGhXMeL0ZbMNxyackPXZ9PtsPT1pBl8jKRx5n1ZptKvIq19KSdfm4qDTlESwSCQihfKrlYOoq7bYWKnqL+X8AgHJD5KXNVYeOQlSTS2wgsvTWy2TfyeqvKey0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fd5pbfVS; arc=fail smtp.client-ip=40.107.100.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8k91qEJuysVje/SRrn2+n93176ePkWFFLCg+ShHHEb3+ETJFJ8gjDH9Ece/hccRiQ3qtWMk6a2DJOS9yhPV3Lko9aycBcmJ73dJNUNURAwUXWDYRidrK8tYXUGhLuAdu+V9cxXXns8B4To3oOEY5EaiTvYI6YiGxQYXJL3SsApajrhaZJABRJsXiRIxTU+lxIB1GsenE13PjOTn9BnzNzNpO4IisvEAzltGIkRLbjRECuGHu9VJ+7yxTZhZPKYtEp1e7du/X1h/0NvZV3cQbuxCST7t96yi2TuMxp+zN7kwlH4MaLzpp3VwQDOViLLztKOFDz2geApJd6K14E1rBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4YlC1HlXhcXi2A42J5UXehJfUS2HU2zknmSMevHcoE=;
 b=mxld4TcGdWY5yuXHZ13v1GMpq8FGec6zm6hbDK18sv2AXUlUTj8lxrLKnKqcIjvka5PIrKJbKN6yjfnFjSIacY9efV4GIjq2yIHbM81QKowMfDt4AJxLX6Kyed0Gl00OM4FK00ZONtIe3upSgHPrV7nlZFgJH69kJULHuzXb02PWpLBDvografQlO5CL0Yd8hcleSLNyJIuYQ7wIox+4wLOQzvEHRtVUgBb3/GgrmGSMMDARqbaBQSjxiZ3tqhg2aVS1gqwLJK1nFMZrn4PgAYht1pXqPVuJ/VDq3/z9hA8xaW6bEZ/3ctApqa+w6peE/qcWUQGL9xLEFWfftn5ozA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4YlC1HlXhcXi2A42J5UXehJfUS2HU2zknmSMevHcoE=;
 b=Fd5pbfVS4j+cJCvJleGS8xoLmry4ZLO22kWA6bIFSao0pZ7Ft7TMBDo0+tbj+cQO/0c/dGyLaH1I832F4uszXqr09UmaJRLqnZXjz/0OfX1nPdObnHHO0ZfXYpNtj7M0DuwH7ISatf6zaA226XcEVBO2rYua6T1GQws2H2ckZ0GblpMIL/zBgiwQNpWJb/yCWbEoTXawIzYyMrwat3orunEf8Na0qv+voYZE+KFV8jR8DvPe5rSBf4p8oK/ErQyGOPFW4TaStePcuWnFlYynaGaVSaCf874AYYnRxoKzkiFzGw81re9AYGpotkC77RDRP6hx0PkaCZSrIC4v0UZ5xg==
Received: from CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7)
 by SN7PR12MB8603.namprd12.prod.outlook.com (2603:10b6:806:260::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Mon, 3 Feb
 2025 19:17:10 +0000
Received: from CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face]) by CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face%7]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 19:17:08 +0000
From: Yong Wang <yongwang@nvidia.com>
To: "stephen@networkplumber.org" <stephen@networkplumber.org>,
	"kuba@kernel.org" <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, Andy Roulin <aroulin@nvidia.com>, Nikhil Dhar
	<ndhar@nvidia.com>
Subject: Re: netdev: operstate UNKNOWN for loopback and other devices?
Thread-Topic: netdev: operstate UNKNOWN for loopback and other devices?
Thread-Index: AQHbdnA3Tt/LvJihDkCRHR+QD3QPhg==
Date: Mon, 3 Feb 2025 19:17:08 +0000
Message-ID: <FF839E2F-B2FB-4FBB-850C-CDB62AD0D05E@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Microsoft-MacOutlook/16.93.25012611
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4858:EE_|SN7PR12MB8603:EE_
x-ms-office365-filtering-correlation-id: 935c5b92-1fdb-487c-16b0-08dd44875a67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M2VMdWhVK1BEVnEvZVNqKzY0SXFvL1J2VUdpNUtSWGhraUhRV2VJbXlQOUhn?=
 =?utf-8?B?cCtPYXJaeVVMZVBidUFGc2JLc1RtOHg4UzcyTzNVNEtKeTd4b2dZWGpLbnE2?=
 =?utf-8?B?L2hHK1dFT3BTbjE2SzRsQmNMSituTGlDV3d2eWlScmJrVHBMRFZnVFoxc0tO?=
 =?utf-8?B?dGI4ZWJJODl5K3h1Q3g3SlZYWDI5OHViNU1DSEtOVytET2N6ZFlxUXhnbkwr?=
 =?utf-8?B?eHBoK0ZYZkZsT2JZeEkxNDc5MGtGcmt1VTFnNEFnVi8yaVJDclFrSVZta2hI?=
 =?utf-8?B?SS9sbVFlMUxnbmU1ZlUzcEtBRnJVdDM2UGg4L29SUGFad2ZZUHRlWDFRbDh2?=
 =?utf-8?B?dG9HNVJQeld5YnowTWRRdkhGcXlmcm05YUprTTBYczlmY3NHTWJkT2M4aXBj?=
 =?utf-8?B?UnhNaGpaMm9ML0lJbmN2UjNCNFY2VzdOM25qSkRUaW5DZ0xCUWZXcTQyK0Q4?=
 =?utf-8?B?cHFTTUUxbGJEek9ub0VLMk9YWnBHNDUxbkpRRndGZE9iV1ZEMlZ3TmJRRVdo?=
 =?utf-8?B?cHFvQ1d1OVI0RGtaUVVEMHdVSlBFTDF2bG44Q1d5Q2EvSGdpWnNVSnJabmFh?=
 =?utf-8?B?OWd2RVhPbThOdnZSeXpkT0NLUVhRazhCRUFLTVNlKzVyTWx0UTZYMXpIcGpy?=
 =?utf-8?B?aGtPcGE1VXJaaFNERFArN3pPdnIrWFFpWGFLcVNZa2cwVHMrYkhBclMvYkk3?=
 =?utf-8?B?VElxeGQ4UXFTeWxHM1lMd09jUG1LM0U1UHJpSGdtUVVMMHoyaElWWnBGQTJB?=
 =?utf-8?B?WkVqSDZMUlR3Y2lEaG1EazRGVmthL091ZGlBS2JLZklUSURKSjNrUXhPNjdo?=
 =?utf-8?B?V1VRMk1OM0RvNExuYXZmZndwZXlBZFdQQ3dzRTFSYWlFUFNTZmlkTlVGWW5G?=
 =?utf-8?B?ZFRuY2ZFM3hXZzQvREZQb3IrOVFVVWFhbk5oL3MzR0pLcSthUUxON0pmZDdV?=
 =?utf-8?B?dWtnb0xsQndVQ1V5WjFzYVl5cDhQLytpeTZ2QThGZk16ZytMeEd0Wi9yd0M0?=
 =?utf-8?B?SUVJMFE4ZXBCc0tkRE5DVzY2bzlLSFJ6U1RWTlpVTlVTaFNXaU1BbVdEQkNq?=
 =?utf-8?B?WVkyT3JaKzJxdlJxejdrdC9uRGdKOEVGWENybCs5cXJvMERyR1JtZzdPZCsx?=
 =?utf-8?B?R1lqLzVJYm9IVmhtTU5rOHZLR0E3T1hNVlN1S3hIRkpGaGVsMmNzTHNHb1ZV?=
 =?utf-8?B?d1BiRzE5MzBNcUtqbCtSNGdpQzRuVmIwZDRhblF5S0FudDJxWXoxZjRXZ3Mx?=
 =?utf-8?B?bXBRTnpyanRBQWZteTJRQitCRGRMakpaVTEwbHRYOWZIQUZRK1ZZSlNMQlVj?=
 =?utf-8?B?UThIT01ieVBnNkZLWGRqaUxMckZRQjR2aTNrandLREVodEdOc1RaRU9PamNx?=
 =?utf-8?B?ZXNqbHNrc0UvMkRtaEJSbThQSE5Wekh3VytZeDRqbXpTVk9uQ0ZyaWphVHh2?=
 =?utf-8?B?cFhscVYzaFl1N25ydVRQTHhwcHVTWU12UElhM2p1L1lUaWxzZnRaS3ExQVNm?=
 =?utf-8?B?UCtmdGZoTEdVTk9LaitaNEZUWWpkOHNNS3A4NVozdjl3Y3E0Y1M2SXNOVXU1?=
 =?utf-8?B?U1VBV1p2M3B4RVprZjVJckQ5SWFLNXdNUkd2a211b0RrL0dVVEJDL1lrOHVw?=
 =?utf-8?B?V013RmszU1Nydm5tLzd2WEttQWYxaVEzNWswNWVsbkkvZC9ob0hheEJWTWp1?=
 =?utf-8?B?K2Q2ZWl3WnkwWFdLYytGQk4yYjViZE5lRE1yVFFCakQ2cXpEUXpVTEpzcThM?=
 =?utf-8?B?b0o0WFZmdzRFOHhLekpkNGJqVDN5T3hLQ0ZkMzVETXZsNkZpWGUwOTQrWkJR?=
 =?utf-8?B?WjdoUDgxVUpZK3BGMy9TU1pvTVpubTVpSmowTzk1RGJHdktXRk5CbDN0SDAx?=
 =?utf-8?B?OHVnTVdodW1oekMwOGcwVEZ5dUdaejlOcDZ6TkpJWTVoWkVORTlDUjVtdXZ2?=
 =?utf-8?Q?OmJbqt5fyOzGktuWxJgLi4kmfPGDgIuQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4858.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVA4L2pzaWl2V3QrdXZESER5UHFaS1Q3WHhYTkltSjRFU1NOMHJyOXJqTG5R?=
 =?utf-8?B?K0E2M1pUaW15ZDZRTlBpbTcvd2Y5S2tMRTRaTEx3VE9mbk1GdVlNd24yY211?=
 =?utf-8?B?ZlppYmdFVk5UR2FNeGc1OWdvaTh6M0wwZXFudDVTMFBISVRRQTh3ZHlWSHlD?=
 =?utf-8?B?b2NMZkU1UWw4bHhoOWhQWmlycUU4TVhtRlU1UWVIRjRicU4vNE9qMkVqSlZz?=
 =?utf-8?B?M0loYlZVSVhFNTREK0cxREluVEtqZjYrRzZ3R1lNM21XZDFDV3J5L2VXRnhh?=
 =?utf-8?B?SDg1MnlnU0xwVlM0TVpQdklmQmFrNlhtcERSZU1sdGYwTGNIeDhuanNHTjU2?=
 =?utf-8?B?STZZVllxTWhkd1oxbDBPTnhEMTBkRGNaTzVnZFJHSWNDZ29LTExLU2xORGlk?=
 =?utf-8?B?RTlkL0xpYlFWdFYvSWVnL0E3dG1TUXZkbW11Q0d2YzQxMm9FQ2lmcU9tWGVJ?=
 =?utf-8?B?eDBVVFBpeHJzM3UrNEZZT04wWmZkQ1FGS1ZlamxCYktNL0dLRS81K1U1bnRx?=
 =?utf-8?B?YktlNVJReWlUV0t2bFJsREFCYmpXWThnL2E0ejNuWmhXcHVaV0FCT3FlQXNs?=
 =?utf-8?B?RVpqcG03YlM5ZnFwRWFhTXYyN2dvbUtTMSs2cWJCM3luVUlzSFBXUTFiRXpo?=
 =?utf-8?B?dnlhZysrMHB6MzNqK2pYanBLOFJFY21VQmdSVkdVVUViT1RUVlB5d3RMSDJI?=
 =?utf-8?B?OGFxVzNYNlcwUzFyMXFCQUJaOXcyT0UvVWVmbTJRU1MxYnVkcHJpZ1ArSktz?=
 =?utf-8?B?aVdwbHEvOE5HaW5CaTRBS01SMlRpZEFCZTBIWGk5RDc4VnNwSDdab2hxNDF3?=
 =?utf-8?B?YWJOZWxSRGtDZEQ1OE1ZSVFxY3UwWEtzaU5RUXJWSWtJRFYwYlgrdWlSdlZV?=
 =?utf-8?B?ejczcmpYUTl1RkZQUWVOeFdlelNKV2wxNWlmN2NqaE1EN1BLRnR5LzZPOVZz?=
 =?utf-8?B?ZmRzNzJIVkFIdkpPeW85RzJ3TjRJUmVCdG9NZkZOd0d5a3QvVjQwNWxNUWMv?=
 =?utf-8?B?TXJuaHcwRllaNFdFTHFpRVkwVkZYYVordUJGL0dNa0I5YnlRNnBReGhDVTEx?=
 =?utf-8?B?SzU3SmxITWM5OTBzSWhvQlpvUXM2YW1mVDRYSVd1cnBCYStPOVNOa1JJdFVQ?=
 =?utf-8?B?b1U3RmgrdjlGTUUvV1BUOWJXaTBDZlVickNZeityQXFwQVlFOExSNkxjcjNz?=
 =?utf-8?B?L2c4WWZTTkhwaDV6eVpSNTJvZ3d5NG5JVGFraWovOWFkVGw4NVk3dWlPQ0pL?=
 =?utf-8?B?TW1aQUh5Ujg2S1N0RHQrcVVRS1hwdmtHbFBySFhCRXdJS29MbG5Na0dFMzd6?=
 =?utf-8?B?NXRyUU9ENTFSSzE0TEk3bnU4dU51Q3J0WDAzRXMrcXVMRWlqVDRDUDd6V2tH?=
 =?utf-8?B?WWNjVzVsY3ZBTXg1VGM0emEwc1pnVURXcWt6dGJoMHhaRC9sZmMyQUNHTkZy?=
 =?utf-8?B?TUk0RHN4Y2VIbXRmcVE0dE5xMkloamhWNEFzNTZvK2NEcE9JL3JnVXZzSjBu?=
 =?utf-8?B?ZWg0U1dVcGpiSHpJbmIzR2padjFqTDVRQU4zZ1hiRlIvTG02bmJOcWNGL0xF?=
 =?utf-8?B?T1RzNUhpcjdaTzlNUVZBdUE5MlFlbTZ1dFR0VnE4cGkrNm5uYUhTSlMwZE9r?=
 =?utf-8?B?alptZHBQSzBQVTl5TVphQllwUXBWZWo3bDU2bW5FaHlGZTlNOUNXMHM1UzlS?=
 =?utf-8?B?cDM3Y0lkMjVBV0tWbDBoaG12LzJWbDFpVTQwTHNUcnpNbmRWK0xDY1FMbUJH?=
 =?utf-8?B?cWw3STQ5ZjFYWXg1ZC9pUHVkc1FHMTkzaE1kR2phMDQydXZqRVJDeGp4MVpT?=
 =?utf-8?B?T2Z0UXFFdm1vbmFYRSt1UGxoZkRvR0ZwY0pEbXIzZTU4cy9nZ1NnVFJSRTcr?=
 =?utf-8?B?VFZTc2VRZmc3cklJVUk5UGIvanQva3pIUTlxZWJ2YlhuMStFOWF2Mk5aWDZV?=
 =?utf-8?B?V095Z1l1UW1JWVpMOEM0dUZaYUs3SVU4akE1OFoyT2p5Z0U5RmE0clNEaElw?=
 =?utf-8?B?LzV1YW13Yy9CY1NOd1R5Vk5saVFZV3UyMSt6b0VVZlBSQ0VIWGF2K0ZjcjRQ?=
 =?utf-8?B?djlLNlBYOG81dVJRdXNYbFllVnk1RWJySk9DUWUzcytqL1FsOTFKM2FERnV4?=
 =?utf-8?B?andVSEhIZjVWQTR5RGxaTk5NeDBxMDZ4M3hhOVdjckdvTzMxL0ZyM1BZOEcy?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <208ECB3A8F3C1D4C893EA4C46E0C6ED5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935c5b92-1fdb-487c-16b0-08dd44875a67
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 19:17:08.4418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b79GAiS7iMAML1cF3qNmRBHbkuy1OFXL0YBpqjUePoA4jh65aewcHT8g1xDFYY6OHZKZZ9SkeRWSiFPQlDI1cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8603

DQpPbiBXZWQsIDIwIE5vdiAyMDI0IDA5OjA4OjMyIC0wODAwDQpTdGVwaGVuIEhlbW1pbmdlciA8
c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+IHdyb3RlOg0KDQoNCj5PbiBUdWUsIDE5IE5vdiAy
MDI0IDE5OjIzOjUzIC0wODAwDQo+SmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4gd3Jv
dGU6DQo+DQo+PiBPbiBUdWUsIDE5IE5vdiAyMDI0IDE1OjM3OjAzIC0wODAwIFN0ZXBoZW4gSGVt
bWluZ2VyIHdyb3RlOg0KPj4gPiBJdCBsb29rcyBsaWtlIGxvb3BiYWNrIGFuZCBvdGhlciBzb2Z0
d2FyZSBkZXZpY2VzIG5ldmVyIGdldCB0aGUgb3BlcnN0YXRlDQo+PiA+IHNldCBjb3JyZWN0bHku
IE5vdCBhIHNlcmlvdXMgcHJvYmxlbSwgYnV0IGl0IGlzIGluY29ycmVjdC4NCj4+ID4gDQo+PiA+
IEZvciBleGFtcGxlOg0KPj4gPiAkIGlwIC1iciBsaW5rDQo+PiA+IGxvICAgICAgICAgICAgICAg
VU5LTk9XTiAgICAgICAgMDA6MDA6MDA6MDA6MDA6MDAgPExPT1BCQUNLLFVQLExPV0VSX1VQPiAN
Cj4+ID4gDQo+PiA+IHRhcDAgICAgICAgICAgICAgVU5LTk9XTiAgICAgICAgY2E6ZmY6ZWQ6YmY6
OTY6YTAgPEJST0FEQ0FTVCxQUk9NSVNDLFVQLExPV0VSX1VQPiANCj4+ID4gdGFwMSAgICAgICAg
ICAgICBVTktOT1dOICAgICAgICAzNjpmNToxNjpkMTo0YzoxNSA8QlJPQURDQVNULFBST01JU0Ms
VVAsTE9XRVJfVVA+IA0KPj4gPiANCj4+ID4gRm9yIHdpcmVsZXNzIGFuZCBldGhlcm5ldCBkZXZp
Y2VzIGtlcm5lbCByZXBvcnRzIFVQIGFuZCBET1dOIGNvcnJlY3RseS4NCj4+ID4gDQo+PiA+IExv
b2tzIGxpa2Ugc29tZSBtaXNzaW5nIGJpdHMgaW4gZGV2X29wZW4gYnV0IG5vdCBzdXJlIGV4YWN0
bHkgd2hlcmUuICANCj4+IA0KPj4gSSB0aG91Z2h0IGl0IG1lYW5zIHRoZSBkcml2ZXIgZG9lc24n
dCBoYXZlIGFueSBub3Rpb24gb2YgdGhlIGNhcnJpZXIsDQo+PiBJT1cgdGhlIGNhcnJpZXIgd2ls
bCBuZXZlciBnbyBkb3duLiBCYXNpY2FsbHkgdGhvc2UgZHJpdmVycyBkb24ndA0KPj4gY2FsbCBu
ZXRpZl9jYXJyaWVyX3tvbixvZmZ9KCkgYXQgYWxsLCBhbmQgcmVseSBvbiBjYXJyaWVyIGJlaW5n
IG9uDQo+PiBieSBkZWZhdWx0IGF0IG5ldGRldiByZWdpc3RyYXRpb24uDQo+DQo+VGFwIGRldmlj
ZSBkb2VzIGhhdmUgY29uY2VwdCBvZiBwc2V1ZG8gY2Fycmllci4gSWYgYXBwbGljYXRpb24gaGFz
IGZpbGUgZGVzY3JpcHRvcg0KPm9wZW4gaXQgcmVwb3J0cyBjYXJyaWVyLCBpZiB0aGUgZGV2aWNl
IGlzIHByZXNlbnQgYnV0IGFwcGxpY2F0aW9uIGhhcyBub3Qgb3BlbmVkDQo+aXQgdGhlbiBjYXJy
aWVyIGlzIHJlcG9ydGVkIGRvd24uDQo+DQoNClRoZSBVTktOT1dOIG9wZXJzdGF0ZSBzb21ldGlt
ZXMgaXMgbWlzbGVhZGluZywgZm9yIGxvb3BiYWNrIGRldmljZSwgdGhlIGZpeCBzZWVtcyANCnNp
bXBsZSwgd2UgY2FuIGp1c3Qgc2V0ICdkZXYtPm9wZXJzdGF0ZSA9IElGX09QRVJfVVAnIGluIGl0
cyBpbml0aWFsaXphdGlvbiBmdW5jdGlvbg0Kb3IgYWRkIG5kb19vcGVuIGhhbmRsZXIgdG8gY2Fs
bCBuZXRpZl9jYXJyaWVyX25vLCBhcyBkaXNjdXNzZWQgaW4gdGhyZWFkIGF0DQpodHRwczovL2J1
Z3MuZGViaWFuLm9yZy9jZ2ktYmluL2J1Z3JlcG9ydC5jZ2k/YnVnPTc1NDk4NyM4OS4NCg0KDQoN
Cg0KDQo=

