Return-Path: <netdev+bounces-184285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0547AA943BB
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 16:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE348E0E4D
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 14:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5993E13B58D;
	Sat, 19 Apr 2025 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VOjbMe7Q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9207A78F47
	for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745073208; cv=fail; b=p4BkWlNzaddjiJORJ/hu7KRDle3Glz3/hMR03SD1XzRDgUjrfFyyPJ3ZrG/HXNaNlPd7vmXQD5lkTTHLjFhpPai3kX+HScxrAAH+s+xToyparqddLbYWg49BFvBjxdolg2tzAMQQ2N9N3m/KgcFLbqe3YdcxgTW0i0RNhQ2oakg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745073208; c=relaxed/simple;
	bh=ynMxcBa3cEUnWMlgc3cVodUJCL9bCXG4/QGfYpTKIf0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UKQAb+T56PL+RxgpWxCn3ujFYr6qt5186d/amJUHf7aGtHJqw5ugzKmMX46b6fCLNiBavabfFsQjREnwWNuH68xu65dDTTeeCS7PLOvcZhQ3/6tLKuo51NsWKDQ861MwiO03jOV7vC+QzHut40BjBLp5lmiC/cYaUO2NfmpPx+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VOjbMe7Q; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SC4UNvijqM7S43e7P7H6TgQdraih56ZaZw3cCzHhpI7vVHe3Ge88nY22EluK8pbI84o+dOeJyGIH+m+Fax3b+S7jvA1gwVvnLblqOVKbSz+NknklNLo+a+Z4vENNWmbdEijnSqykD3VFMP7kMTBQu7ooaMJ+Jj7QMrVex2fbOMm2iNH4ZHMYDqZkVgp4oUX1ZdcFwzEhxo3/8cooK9L2ZKEQKxEjOaqzFqkwg/Dw1AGl+EUCyRDzT3VpFr2AtTJBLFkdOxgDWbS8854kH2GhverP+uwliCTcyyuun8Lm2xxYEACxgnkqAMCTORmFTCMps++vk24DJWxsM1rtT5tx/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynMxcBa3cEUnWMlgc3cVodUJCL9bCXG4/QGfYpTKIf0=;
 b=GtzYzacuSJL4i45tdDWOrM6ZYY47Cr9vvjQUXe0dsoStn/ojeocDrsMPirZe1nF1JpaNMa9MRNjj173KC5ujq6swkYiUxR2V4IIFsVOn18GPFgjhDyTP37XWTyrZ15xOEIqjwpqqnaCxdFKr47XH9CO62GBT6Eo41b9IqaNrAge/7I0A1Y3yE38hNzdJJmn3b1R8rSCKITBBYsgj1m4DPW8hUEI6xvd1DRJKEIldEryjuirL2cdyv5fdlMmaBdVaAqzwOSY6v6qqs1CniLNs6BISZYAMvDLBs3A/c6MCLak8CN3VvgoVrZDArfyj3bWZ9ED4I+T0nm7f3ruNyMgxKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynMxcBa3cEUnWMlgc3cVodUJCL9bCXG4/QGfYpTKIf0=;
 b=VOjbMe7QfNSwlFt3jOPV3aSJc3rFtYeqc9N6zujSxIfRPLz3c2KHz1VGOZF7OZg5xnfVwp/WBg21GDcRdbufMdhfwLAOSXRqR49EHTmAnV2pdZaTKq4k6Z19j536HSGVyqcteoG7Hs+TrsHn7yG5Y4iRFmWXXrKLQGVBo8P33NF6bCJSv6dLLRowdGuSA9HK4d1DZQN91yxeKzoMcc0TYn28FgxK5oLV75LfRNrQsXvM2u+ME50vqkNrntdBWzJKwWAseIOTYQ1JXkRZEcNK4uQYXeB3/GCYjBodJELk9ltcih/P+aYWdGrKnRGHnogXYO0xHIvrjxD6pN21ViyJmQ==
Received: from CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7)
 by BN7PPF49208036B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Sat, 19 Apr
 2025 14:33:23 +0000
Received: from CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face]) by CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face%7]) with mapi id 15.20.8534.043; Sat, 19 Apr 2025
 14:33:22 +0000
From: Yong Wang <yongwang@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>, Petr Machata
	<petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, "bridge@lists.linux.dev"
	<bridge@lists.linux.dev>, Andy Roulin <aroulin@nvidia.com>, mlxsw
	<mlxsw@nvidia.com>, Nikhil Dhar <ndhar@nvidia.com>
Subject: Re: [PATCH net-next 1/3] net: bridge: mcast: re-implement
 br_multicast_{enable, disable}_port functions
Thread-Topic: [PATCH net-next 1/3] net: bridge: mcast: re-implement
 br_multicast_{enable, disable}_port functions
Thread-Index: AQHbr57Hx1eTUp+haEGFerWzZlR2gLOqjBEAgAAPWIA=
Date: Sat, 19 Apr 2025 14:33:22 +0000
Message-ID: <8F591F22-50C7-429E-AF42-BDFBE35FD10B@nvidia.com>
References: <cover.1744896433.git.petrm@nvidia.com>
 <36976a87816f7228ca25d7481512ebe2556d892c.1744896433.git.petrm@nvidia.com>
 <8af190ea-5b12-4393-95ac-2bc5cf682c65@blackwall.org>
In-Reply-To: <8af190ea-5b12-4393-95ac-2bc5cf682c65@blackwall.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Microsoft-MacOutlook/16.95.25032931
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4858:EE_|BN7PPF49208036B:EE_
x-ms-office365-filtering-correlation-id: 60145993-4c19-4339-bd60-08dd7f4f22fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eGR2dDljYUd5ZDVQNXpCNWhOSi83MVJGTkFFWUNlZEpwNUhLZ25zZFdHelpq?=
 =?utf-8?B?TG5lWWdOcTNEMWRiZzl0ZVJQRXEvRDRRRFNhZnVGT2ZWZ3FXeGpsa2ExeUNK?=
 =?utf-8?B?Y3FWUnQwUTlmb3dsYUQ2d0RKYWt5S1Q5VjZwQTdxcTRKSjVBWFZEYmZtUEhF?=
 =?utf-8?B?NmUrR3NVUnhGWDZlWEpzSVhEbG5oZlJSRUZBdjU4ZjNXWEV5Nkc0ZlhUclNH?=
 =?utf-8?B?VWZQWGhUNTRnUStQQTVLays5Z3JlN0Rocm02VDY2VXprMTc0SWxRb2J3cE1k?=
 =?utf-8?B?RGFNVEk5anovVkk5K2F2NUlKUXZxZkowUUk4MFJoOG9iMGYvREhOc2h3UG5C?=
 =?utf-8?B?bE5SVURvTzFtY1RvbkwycVFTUTJjbFRxZGVxckFQUGdpSFFBNjVPdmlnV1U4?=
 =?utf-8?B?U0tNMGx5Tlk3dlZwYnpwS202ZUVnMm1Qb2xHWWVpQ3RHQnFydTIzakZDUm1F?=
 =?utf-8?B?SG5GdExSMTBWdUVVcDJ2T2orTFdCQjY3cUplS0dGMVhUamZOVUJETjZPdzZG?=
 =?utf-8?B?elZBOXJRTzNkYUhnZ0hlZDUxVzNjR3RzamJlM2ZHS1lRdmQ5M0t3U1poT3Rv?=
 =?utf-8?B?VkYyQmw3ZXNQVU9PZ2FwaVBhUHhPbFFQZzgvQlVCcHVIc2RwQlZ0RTBzSEFF?=
 =?utf-8?B?b1BRby9DazdnaEp5QlUyOENaRTBXMzhDMDA4dk15K0VXMWV0S2NnTldzRHVB?=
 =?utf-8?B?d0NDV0srNEtNZTVGSFJDWllxbmp6OGl3MFQ1UmdhNTIrZ25hNHp3a2FTMGQ2?=
 =?utf-8?B?eW45elhhRitrRVRlNmRkUFVQS1EzRXVyWlJKMXRXZUNkSEJBSzlTRVcvc3RE?=
 =?utf-8?B?QzJ5c2NMOENaUk9YZ3hCRFlGQ3JiUmVmTElVZWdqTGZMQVFHTEtWNE9ydkE5?=
 =?utf-8?B?RHBnVUkyWjVNSGFaajNKejNYdUlVeitzQ0xSMWRwZERoSldDUVdOWkd0MXdj?=
 =?utf-8?B?VWgvWnVkQW1NWjNzYUlpMU1XMjIzR0wzU1UzV1F5dG5Fd0x2TXNrNzY5TGtk?=
 =?utf-8?B?eWZXR1N6STRUb3pGSy8wVzk2a2E4aDdWYnlTN1FhR01qdHFLczhtZWtaNDNH?=
 =?utf-8?B?TXlIbHBtNEY0Uk5BbjBnQWpqZjVNZk9tYTR6eXkxOVhnWlBaeXJ4M3RxTnRY?=
 =?utf-8?B?Tmxhd3lYb2RjSHZpbERsTnloZmlTTDVtVXRKTU1yWWxyazR5eVJsWURQUHNO?=
 =?utf-8?B?VHVWSHAwelo3K3g4eXhtNE1Remp0QnJMcHNoQUdnWi9DZzdVZStQZGFKdkZk?=
 =?utf-8?B?ZWhnVE5DcWZOOExDa2lvdWkxS1ZUVlFISVR6dDNuVkRNK1R4M0VDTVZyTUZM?=
 =?utf-8?B?SVRzaEQ2ZmxZamJQTk5PanN2NEJLVDluNUZzLzZMOU84UkNISVB3WUM5ZnVm?=
 =?utf-8?B?SUZMYTJiQUJ1aktrTks0T1dDK3lycHZsZTc3dGFPdWoyZ29kdTJDVU90UmFP?=
 =?utf-8?B?ZzdyYXlCL3lPVjFwalMzWDZJYlc3NzdDS2ptZVV3V1o3ZGpvT0tndGhjZHBk?=
 =?utf-8?B?TC9KYmlDaTZrUWhTUjlCb0dBSjJsL3JZcUhlQUYva1dSU3VyY3JKQWxWeVU3?=
 =?utf-8?B?SVZBdXdGOWF5TGphR2lyR25GYlJyQmQzL0hyUDMwcVpEcHRiQWJlWHhjZE1n?=
 =?utf-8?B?dDhuVk1RejZWZXRjcGhZUFBJZXRaZGxFWXRYNk1qYVdTa0JyMEJkZDBHWGlo?=
 =?utf-8?B?VUFFd3NVb3FIdWlwcDZLd2t5a2N5WXNweE9MVEJCbytZdWFHeWt2VUxCM2p4?=
 =?utf-8?B?d2hwMGFwRVB2NFFTYzlxblY3bjUxaXp2c21Bd0tpTUhlbTlUc1duYVdiVTJO?=
 =?utf-8?B?UGRkR2ZTbTl5WmFmMm1iRE1GNVl4bmhoNk9WeXFaWnpKQUlxUkxFOEI4c3pG?=
 =?utf-8?B?M0dvaytVWVN4ZndGSkxuc3ZReUIwQkxxRjFEc2JKU0dQUmpidmNHaVFSYVg2?=
 =?utf-8?B?Rkt4T2hJYStVeVd3Y2ljQ0M5NE9XWlhrUWdmbzNoNlVURWdlNXVyOUZSWDc0?=
 =?utf-8?B?V1kzamdYaTZRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4858.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWNkQmlHakdtK29VTGVDdlZ3U2M3bEVtY2dUN1VvUHE4TXcrOU4ySjlvQ3Fw?=
 =?utf-8?B?Zm5QSXJGcVZkZkFod1g1eWpjSytlTXpoRlFuZ2U1cGNEdDk1NWRsbFZGSkFB?=
 =?utf-8?B?ZkpxQ2duZXljcldzNjFBOTd6ME1ZbitPOXNwMUFrSnk5SHhSK0d5bUdxWFIv?=
 =?utf-8?B?WUt2VDZacEN6TVJqVGsrUmdCVWhVelBScnJpUG0vMUNkRHJxVkc0Z21kMTc1?=
 =?utf-8?B?enM2dWVEOGI5QVFHaE1NSGE5YzNLYk1sZ25kZ2U3N1dSd2U3REN4bThmN0V5?=
 =?utf-8?B?UHJmakMyQVBNUlM3QU04RllBQktTMGtMdFlnSW1KeUpaQlFNYmxBdlh2emt4?=
 =?utf-8?B?WWtlNHd4b3h5QndhLzF4cHMydHhUUEZBemFrVDJ0aVY3QjI5Y2pmL1Q2MFdp?=
 =?utf-8?B?QmxHcGV1WGEyc1hDU1ZyZGdBMUVLSENwV09lMmNwOXRJL20yU2U4N3hkaGl2?=
 =?utf-8?B?SEpkRnE2aEJXWGpSQy9zekt2MFQ4Y0Q5Rzhxa29xUzhsVlVIZU53Ry92cGZN?=
 =?utf-8?B?L1p6Q1dMWDIraFZvbVJFcEhaRTd4bDRKYTErQUl1SmR6SU9HSDdrWVZkL1FH?=
 =?utf-8?B?Mjk0eUlXWGI4WjJ4UmYvdFdiN1Y4NjFWUU9WdVM3SjJMWGg5cFV5OE1tYVZk?=
 =?utf-8?B?RW5QSWFGTllqR25rOG5yMDhFSU05T0lYeWNMYmU1djQ4ZEFHWnJCZnVDM1k5?=
 =?utf-8?B?aEtHYUZaazlnL0p4MFFncnM1THovQURLZ0F4QWhKRnFNRmNqaG8xbFpRK05K?=
 =?utf-8?B?b1FBQ0Vjd3hrb2VCcmZxMkJCMzU5M3REb1hSY1ZYZEZZa2dMOUwrUDhnL2h5?=
 =?utf-8?B?MTBuRjRYMExMd3ljQnNicHhXTTN2Y0JjSWNkTW5Sd3J5U3FvdElicmh0SHVr?=
 =?utf-8?B?aWV4NzhQUUR0ZzllTnFaNXhqRUtVU3BubDNRdk8xYThicy81Yys3dkd2aGg0?=
 =?utf-8?B?eURRV3VaYmwvNXRCbml1clo2ZEorMm1EYjNwUUxUQWN5ektTQkRCY29JWmVC?=
 =?utf-8?B?STZQZlJ3Umkzb3U2SnJEdVpGT0FSZUpzc25MYTFoMlVCTUtkWEdkRDIrNDlM?=
 =?utf-8?B?cFJuTFYvY2M0UG5aT3VDeDRhQk02NnljT1dEemY1ZW52TDQ0d3J5UUNwNG91?=
 =?utf-8?B?Rm5GUUtiNFRIdlJzWnB5dkU0VkpMbjRaSlRSMWRacHBZNU9oTXJQUkxVeVdU?=
 =?utf-8?B?L0JiM3dVWHBpTEMzZWtKKzZiOVBqWG9kS0FkRnRCREdRazZjLzBGeEloZEJI?=
 =?utf-8?B?YmYwTS8wMGVXOUkwTW5RejFROHdPaHdRR1NpM2JMK2ZwbFRVYjJVbnV3WFBn?=
 =?utf-8?B?Qm4zVEs0Zkh3ZWU2Wnh4VFhFQjIvUGNnbWxIL2Jua2tRT1VxVDNGdXl6b3dW?=
 =?utf-8?B?WHRNZkVheXpyemxicWk0SEQxd1JGWjdlTmdBaUVwMThzVmZMdWpidGhpNnIy?=
 =?utf-8?B?UmZjWEJSdlNNRHoxbmxOMDZrWHpvb29BNGxMUnlLWEVvb0Q0ckEzYWh0YUtk?=
 =?utf-8?B?ZjZ2ZDhDcy9wN3lVM0RiY1JGSGtMSGo4d3YraXZXUUpZeFNqMjZaeG41TFNh?=
 =?utf-8?B?NmN3Ty8vcEFLMEpaSXNZZVRyT2tvM1Y5WitqMEQvQzZRaWdUTGZwSE9IS1dH?=
 =?utf-8?B?Q0x1NVR4OWJseExNek5VSys0RnB0QzRBTjJGemxyaXlha1luN3lOZ0JBTXlH?=
 =?utf-8?B?WG1sYkkrRlBEdkN1U1JsOTBzZGlwRE1CSUxtbzc3ekxhUE1VU1dVUFF0Mm9q?=
 =?utf-8?B?aWVySjVPb0tic2hFRjJFbSs3UHFsTE5zMFdseExneUdUTzRMdExabk5VRDZX?=
 =?utf-8?B?MkNaZDlRd3lvZW1SSmVzWmlycjAwWGlvOHpLd1p3M291RHRuTy9rSUxxa2JO?=
 =?utf-8?B?emExcVVFRDNWNjAvMW5MV1NvL1NXN0tWT1M1Q1FkN0ZkaTVqUVFIbmxaa0Jq?=
 =?utf-8?B?MURlUzMzZmJxeEJQZEJWV0toSGRnK0RNZ3JmY1d5U0p4NzJLVThKa1lWMnFh?=
 =?utf-8?B?S3hRRHVBS3hBVkNmODBwblRQK0VpNk1NcEJucm1NZGdpcUZoWGM4YU1sRzI2?=
 =?utf-8?B?RTZuOFcrM01LN2dzZU12T2w4R2ZONjFxKzY5ODJ6dlFvRTlXT1Ftbm1DcmFz?=
 =?utf-8?B?bk14QldISU1jV1lkRVJEd0J2MG1jQjd3RnRiVGRkRXBGTnFnZWt2QU1wWG5W?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC4850259123364A82E5B0B4AA723112@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 60145993-4c19-4339-bd60-08dd7f4f22fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2025 14:33:22.2358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhRr765S3vIRbQ0Upu1gCOC02OgDaVngXAlZSq9RPpkTz+KNIHK5zk50+EXShCzBPFdXvgl2zCFXO+Y+kSnBgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF49208036B

T24gNC8xOC8yNSwgMTE6MzggUE0sICJOaWtvbGF5IEFsZWtzYW5kcm92IiA8cmF6b3JAYmxhY2t3
YWxsLm9yZyA+IHdyb3RlOg0KDQo+T24gNC8xNy8yNSAxNjo0MywgUGV0ciBNYWNoYXRhIHdyb3Rl
Og0KPj4gRnJvbTogWW9uZyBXYW5nIDx5b25nd2FuZ0BudmlkaWEuY29tPg0KPj4NCj4+IFdoZW4g
YSBicmlkZ2UgcG9ydCBTVFAgc3RhdGUgaXMgY2hhbmdlZCBmcm9tIEJMT0NLSU5HL0RJU0FCTEVE
IHRvDQo+PiBGT1JXQVJESU5HLCB0aGUgcG9ydCdzIGlnbXAgcXVlcnkgdGltZXIgd2lsbCBOT1Qg
cmUtYXJtIGl0c2VsZiBpZiB0aGUNCj4+IGJyaWRnZSBoYXMgYmVlbiBjb25maWd1cmVkIGFzIHBl
ci1WTEFOIG11bHRpY2FzdCBzbm9vcGluZy4NCj4+DQo+PiBTb2x2ZSB0aGlzIGJ5IGNob29zaW5n
IHRoZSBjb3JyZWN0IG11bHRpY2FzdCBjb250ZXh0KHMpIHRvIGVuYWJsZS9kaXNhYmxlDQo+PiBw
b3J0IG11bHRpY2FzdCBiYXNlZCBvbiB3aGV0aGVyIHBlci1WTEFOIG11bHRpY2FzdCBzbm9vcGlu
ZyBpcyBlbmFibGVkIG9yDQo+PiBub3QsIGkuZS4gdXNpbmcgcGVyLXtwb3J0LCBWTEFOfSBjb250
ZXh0IGluIGNhc2Ugb2YgcGVyLVZMQU4gbXVsdGljYXN0DQo+PiBzbm9vcGluZyBieSByZS1pbXBs
ZW1lbnRpbmcgYnJfbXVsdGljYXN0X2VuYWJsZV9wb3J0KCkgYW5kDQo+PiBicl9tdWx0aWNhc3Rf
ZGlzYWJsZV9wb3J0KCkgZnVuY3Rpb25zLg0KPj4NCj4+IEJlZm9yZSB0aGUgcGF0Y2gsIHRoZSBJ
R01QIHF1ZXJ5IGRvZXMgbm90IGhhcHBlbiBpbiB0aGUgbGFzdCBzdGVwIG9mIHRoZQ0KPj4gZm9s
bG93aW5nIHRlc3Qgc2VxdWVuY2UsIGkuZS4gbm8gZ3Jvd3RoIGZvciB0eCBjb3VudGVyOg0KPj4g
ICMgaXAgbGluayBhZGQgbmFtZSBicjEgdXAgdHlwZSBicmlkZ2Ugdmxhbl9maWx0ZXJpbmcgMSBt
Y2FzdF9zbm9vcGluZyAxIG1jYXN0X3ZsYW5fc25vb3BpbmcgMSBtY2FzdF9xdWVyaWVyIDEgbWNh
c3Rfc3RhdHNfZW5hYmxlZCAxDQo+PiAgIyBicmlkZ2UgdmxhbiBnbG9iYWwgc2V0IHZpZCAxIGRl
diBicjEgbWNhc3Rfc25vb3BpbmcgMSBtY2FzdF9xdWVyaWVyIDEgbWNhc3RfcXVlcnlfaW50ZXJ2
YWwgMTAwIG1jYXN0X3N0YXJ0dXBfcXVlcnlfY291bnQgMA0KPj4gICMgaXAgbGluayBhZGQgbmFt
ZSBzd3AxIHVwIG1hc3RlciBicjEgdHlwZSBkdW1teQ0KPj4gICMgYnJpZGdlIGxpbmsgc2V0IGRl
diBzd3AxIHN0YXRlIDANCj4+ICAjIGlwIC1qIC1wIHN0YXRzIHNob3cgZGV2IHN3cDEgZ3JvdXAg
eHN0YXRzX3NsYXZlIHN1Ymdyb3VwIGJyaWRnZSBzdWl0ZSBtY2FzdCB8IGpxICcuW11bIm11bHRp
Y2FzdCJdWyJpZ21wX3F1ZXJpZXMiXVsidHhfdjIiXScNCj4+IDENCj4+ICAjIHNsZWVwIDENCj4+
ICAjIGlwIC1qIC1wIHN0YXRzIHNob3cgZGV2IHN3cDEgZ3JvdXAgeHN0YXRzX3NsYXZlIHN1Ymdy
b3VwIGJyaWRnZSBzdWl0ZSBtY2FzdCB8IGpxICcuW11bIm11bHRpY2FzdCJdWyJpZ21wX3F1ZXJp
ZXMiXVsidHhfdjIiXScNCj4+IDENCj4+ICAjIGJyaWRnZSBsaW5rIHNldCBkZXYgc3dwMSBzdGF0
ZSAzDQo+PiAgIyBzbGVlcCAyDQo+PiAgIyBpcCAtaiAtcCBzdGF0cyBzaG93IGRldiBzd3AxIGdy
b3VwIHhzdGF0c19zbGF2ZSBzdWJncm91cCBicmlkZ2Ugc3VpdGUgbWNhc3QgfCBqcSAnLltdWyJt
dWx0aWNhc3QiXVsiaWdtcF9xdWVyaWVzIl1bInR4X3YyIl0nDQo+PiAxDQo+Pg0KPj4gQWZ0ZXIg
dGhlIHBhdGNoLCB0aGUgSUdNUCBxdWVyeSBoYXBwZW5zIGluIHRoZSBsYXN0IHN0ZXAgb2YgdGhl
IHRlc3Q6DQo+PiAgIyBpcCBsaW5rIGFkZCBuYW1lIGJyMSB1cCB0eXBlIGJyaWRnZSB2bGFuX2Zp
bHRlcmluZyAxIG1jYXN0X3Nub29waW5nIDEgbWNhc3Rfdmxhbl9zbm9vcGluZyAxIG1jYXN0X3F1
ZXJpZXIgMSBtY2FzdF9zdGF0c19lbmFibGVkIDENCj4+ICAjIGJyaWRnZSB2bGFuIGdsb2JhbCBz
ZXQgdmlkIDEgZGV2IGJyMSBtY2FzdF9zbm9vcGluZyAxIG1jYXN0X3F1ZXJpZXIgMSBtY2FzdF9x
dWVyeV9pbnRlcnZhbCAxMDAgbWNhc3Rfc3RhcnR1cF9xdWVyeV9jb3VudCAwDQo+PiAgIyBpcCBs
aW5rIGFkZCBuYW1lIHN3cDEgdXAgbWFzdGVyIGJyMSB0eXBlIGR1bW15DQo+PiAgIyBicmlkZ2Ug
bGluayBzZXQgZGV2IHN3cDEgc3RhdGUgMA0KPj4gICMgaXAgLWogLXAgc3RhdHMgc2hvdyBkZXYg
c3dwMSBncm91cCB4c3RhdHNfc2xhdmUgc3ViZ3JvdXAgYnJpZGdlIHN1aXRlIG1jYXN0IHwganEg
Jy5bXVsibXVsdGljYXN0Il1bImlnbXBfcXVlcmllcyJdWyJ0eF92MiJdJw0KPj4gMQ0KPj4gICMg
c2xlZXAgMQ0KPj4gICMgaXAgLWogLXAgc3RhdHMgc2hvdyBkZXYgc3dwMSBncm91cCB4c3RhdHNf
c2xhdmUgc3ViZ3JvdXAgYnJpZGdlIHN1aXRlIG1jYXN0IHwganEgJy5bXVsibXVsdGljYXN0Il1b
ImlnbXBfcXVlcmllcyJdWyJ0eF92MiJdJw0KPj4gMQ0KPj4gICMgYnJpZGdlIGxpbmsgc2V0IGRl
diBzd3AxIHN0YXRlIDMNCj4+ICAjIHNsZWVwIDINCj4+ICAjIGlwIC1qIC1wIHN0YXRzIHNob3cg
ZGV2IHN3cDEgZ3JvdXAgeHN0YXRzX3NsYXZlIHN1Ymdyb3VwIGJyaWRnZSBzdWl0ZSBtY2FzdCB8
IGpxICcuW11bIm11bHRpY2FzdCJdWyJpZ21wX3F1ZXJpZXMiXVsidHhfdjIiXScNCj4+IDMNCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBZb25nIFdhbmcgPHlvbmd3YW5nQG52aWRpYS5jb20+DQo+PiBS
ZXZpZXdlZC1ieTogQW5keSBSb3VsaW4gPGFyb3VsaW5AbnZpZGlhLmNvbT4NCj4+IFJldmlld2Vk
LWJ5OiBJZG8gU2NoaW1tZWwgPGlkb3NjaEBudmlkaWEuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTog
UGV0ciBNYWNoYXRhIDxwZXRybUBudmlkaWEuY29tPg0KPj4gLS0tDQo+PiAgbmV0L2JyaWRnZS9i
cl9tdWx0aWNhc3QuYyB8IDc3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA2OSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0K
Pj4NCj4NCj5JIGZlZWwgbGlrZSBJJ3ZlIHNlZW4gYSBzaW1pbGFyIHBhdGNoIGJlZm9yZS4gQXJl
IHlvdSBzdXJlIHRoaXMgaXMgbm90IHYyPyA6KQ0KPkFueXdheSBsb29rcyBnb29kIHRvIG1lLiBU
aGFua3MhDQo+DQo+QWNrZWQtYnk6IE5pa29sYXkgQWxla3NhbmRyb3YgPHJhem9yQGJsYWNrd2Fs
bC5vcmc+DQoNClllcywgdGhpcyBzaG91bGQgYmUgVjIuIFBldHIgaXMgaGVscGluZyB1cHN0cmVh
bWluZyB0aGlzIHBhdGNoLiBUaGFua3MgZm9yIHlvdXIgYWNrbm93bGVkZ2VtZW50Lg0KDQoNCg==

