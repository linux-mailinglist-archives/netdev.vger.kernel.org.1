Return-Path: <netdev+bounces-86410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460BE89EAE3
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 08:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6991C1C21063
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 06:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E436129CFE;
	Wed, 10 Apr 2024 06:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l6O/XGyV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2134.outbound.protection.outlook.com [40.107.94.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB3328370
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730668; cv=fail; b=VkaGdJIINiCi2FPjwPAMaR6FdVx72pOcYOACgtwaQ0WpfYoraFM7M2ouiMHAgBTwiFxT1v9EQ4LmAex++7xNUkvbVGkknIHHZI1WKS50N9gF1T0wWBC0YupscAaUyKWfJNagWqHEcZaHgwUI0yG3p29RJL2Flfw7w2zSaZ9Q7Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730668; c=relaxed/simple;
	bh=3T0tFNf2cpTB1ks9j87C9XXSi0Y22XV2QiuJ/numiJE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V563edNGU+xp5thefg7j5erZdypxwh69SW/vAXVrnObzqR+SxKTxpgmsX8PNAXEHZlrigKOm0xse66QcMGKlsHKI+QnZAR/m0POGxwQvgkyyDSr4frCiWRWL1sGGq1fKs1hzV4whcs045GyIP/Lr3BoZgrtU/psmV4BBPVnmvD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l6O/XGyV; arc=fail smtp.client-ip=40.107.94.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxP+d5ZJa+aPIUqlCnUNrhkPuI2yXymYQs0w2JZgQSk1/+1WVZ5htAzo5sg2ZkHdjeHfbgoVachKHoX/w+GB30jSI4fMtgv9GP0TaX7ZGhN9A/z3iFZ1ZrVx+n8Ydv+SDH/mENsIobEo65TD76XHU4TBTXbIuZIL18tFOKdYkS2hEGczdeydCZek6IHKBxz37KE1eWT/l4L1I0StdUF70FFjJLVOXt68tHsOEqi2IIKFSd8W6bY1lxXbvYZr/nRWQZvPtBeASjXEcK/JjId9fcRBM9J5uGcvm7qb6SJDXvjBobGCL0Mc+UJRzOD5unWBbFY3+CJeta6rReqNCxBVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3T0tFNf2cpTB1ks9j87C9XXSi0Y22XV2QiuJ/numiJE=;
 b=JfpYbo1rbWQN5jZFyX5zxGGcKZe/IomBr2ndm/Rbpi3sll4gfJzvXGNdZD3Tyu7AiE5MAURIVFboUB2CRirU6iHTOsQJrn3VLcVUvmHMm92NZmbdBRf5dx5QbTggqmf5bk4tndt8HhCM5A66yvXLhKh/JHQngkECGAOQa3VWmQn6kFmpSxSvjtHXVW8Vm7G0IePJh2/idzdPEPcV98iLDv2tl7i8+56iN19bMhuo/1vy8rRJX7gd/JoVc09G6xrpxZrNvq2BcxmbYksnGwya6oIFVHiZC0UKCqT8j1dY6bE8DpT9qCxOvYNjIQnOYiSjBVAaLU+6+xhu3lkZykBBIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T0tFNf2cpTB1ks9j87C9XXSi0Y22XV2QiuJ/numiJE=;
 b=l6O/XGyVk7XAjun/3u8RYuxhDPvyIm923lgH8byu0lInNoOalcLsOoPn0lDNftyKjPeCmrVJ4d7/Xm8+QJQOCu0OFUP1klt6imIPPQ3ltikHRedCcpCKUAm1yZwX5MTFz+Wb/jbzUEWtO+V12ETLXLkXp44Oi7kuROH0OU6QXPsXCMED0IJpDu+ZYZ7qhDVPxDb1X3TaIQ6wG763MKz14yXc7ykUMnpndbLJbaugK/TaAux8jqsGj2d87TBaxBBOB/je5Cfb7+tfjOh/gVzuMwoMMRIuGna4hOmGk6AZxEzk/AakHnqFdUnJL28KT5Cvqm6R3oYx8XSYW4UzwbNwyA==
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 06:31:04 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 06:31:04 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>
CC: Boris Pismenny <borisp@nvidia.com>, "aurelien.aptel@gmail.com"
	<aurelien.aptel@gmail.com>, Shai Malin <smalin@nvidia.com>,
	"malin1024@gmail.com" <malin1024@gmail.com>, Or Gerlitz
	<ogerlitz@nvidia.com>, Yoray Zack <yorayz@nvidia.com>, Gal Shalom
	<galshalom@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: RE: [PATCH v24 06/20] nvme-tcp: Add DDP data-path
Thread-Topic: [PATCH v24 06/20] nvme-tcp: Add DDP data-path
Thread-Index: AQHahozr1CSHzxR3ZUO2E0aMrm+r7rFdYxQAgAOw87A=
Date: Wed, 10 Apr 2024 06:31:03 +0000
Message-ID:
 <SJ1PR12MB6075F997ED346A333A86D763A5062@SJ1PR12MB6075.namprd12.prod.outlook.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-7-aaptel@nvidia.com>
 <a307cd8b-510d-4bb0-9e5d-68fdbd8a362c@grimberg.me>
In-Reply-To: <a307cd8b-510d-4bb0-9e5d-68fdbd8a362c@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6075:EE_|SJ2PR12MB7896:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Z98yYrECeOidF3xPjZL7KEv09V+v9Xdiv8gW3QS1C2QdAcXHWaBeUSHsUIEwzTBZybjppTuyRW8BG1WOIrbm1ujDkeDJErMw4TJxgdG7U+j/FOP1Jptz5rkor3Y8lN3pktiyJ7F9dcrC7duAb6+tSnkU8flpNNuMN8kvvv2a9hBSxJGFMTpmbkBkziCqYdrA9SoetOBKLchzk/09Wa9/7nZ5ZzRI3b0dfHtGb6xRWioMCi6vaKrA7QTvPqsD/3ttp38WMag3YS00Ppd5Ycqv1paolSS8PHP4+tMEzLnTcnZBze9qy9EmdpilUIJb1y4qKBwi8dAGIDsJneEzAjOb3llXI0cMSNyxe7gH2PP24Cv93Y1Mt6DiT+5pAXIpGjZZMQFrBTYCBGOEZKUpOLPf/Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1FzempPOE1maVdDeDFoOStCTTZIbldPWUhmeUJMMGF4U2lRdVlGM0JSbTE2?=
 =?utf-8?B?WjBucU9PbjFQa2hSY3E1SHhLVFFHalkwRDlQVC9PSUxZa0w5Y25Dd2ZvT29H?=
 =?utf-8?B?WFJ0Sk9ZSVJSN2pyMGRieW9qaW5oR2tHUS9mOWd3dm5hTEljTlFLWEFjdEw3?=
 =?utf-8?B?amRVVUdvb0pOZFVBM0FvdTI1Unh1VUVBZE81QzNEZEVsK2UyL3lFdXE4WTBH?=
 =?utf-8?B?MmtCU2h0QzZEQkdQVXEwQTYzbk5rYnduUHRENE16ay9nVkNydHBUY0hWTjVq?=
 =?utf-8?B?cDFtQ0V4R2lSbkY2bXVubkFNaUw4YUNzdkhQc2k5U0JtMkJMa1llMmx0Wmh5?=
 =?utf-8?B?SGtQc1RDcEpSWFVxcW1GaFF0WDBOMmhvZUlrczVsb2gwL3R5R0NCT2ZhUS9r?=
 =?utf-8?B?SXZ4aHpjNTJuOXA4d0lzMmlQQTF1VVR6SDQwNUI4UjVtQjlMR01TTTdlVUps?=
 =?utf-8?B?MzI1M3NDV3FUb0czOEFBUGsyNEk4S1NhSVg5cnJXQTNSYVYvTWdZSFVHVGtV?=
 =?utf-8?B?a3lUMit1UEdpNnBtM3FNdmxOVUlmbHdzWlpUMVdrTStIY0tIMW8vR1FtZE5K?=
 =?utf-8?B?cFdNN1FuME1VVDRpWVZkWEMzcWdvaHJSNXNlMHN5UzBTZUFKUWx6N0tLUS92?=
 =?utf-8?B?Q09lN0paZ1BZN1hQY24yMXJyMUVLNGR3WTZTMncyakY3VUg0NjU2eUxMZ1Zi?=
 =?utf-8?B?R3lJMnUvcDB3SmVRK1NTSWJub1NkK2dnNWFhT0U5VWwxZkVkblljN21IRkY2?=
 =?utf-8?B?eXovZmFXeVRra3lCWXFtcHZ3dlgyMkJVL3V2bUNEb2ZKd2lSTVhHUGNwWk5v?=
 =?utf-8?B?SW5neERyQXY0TThzb0dsR2QzTUs1Vk9LNzBtSlg1dXJtOS9OTWVLREF5Vk1i?=
 =?utf-8?B?QU9iRTdVb3l4a1MwVGdVQWpIQUdSOU0xTXJrSU03S1JKc25XK0p0Y3Y1REJn?=
 =?utf-8?B?S2FOa0RBKzAxcFFDOTMzNXk1MU5aeFJublg5NEwxckRTb1pNMktzR2dhb0Ri?=
 =?utf-8?B?WlhuWVlySWZxQkx5b2ttQ29HYWx2L0cyemh0d1Vjc3cxbzhRY2NrOGhxa1No?=
 =?utf-8?B?WnlubjB6VEtjbHRPbEdnN2VFY3RaQzhUc0tkMU9mOGZLekVSQWRIdExGenVk?=
 =?utf-8?B?ZEl2TnJYdFhyYk5xQjUrY00yU1IrZDBPN01kUkhOTE1RMXZVWGdzcnlGckx0?=
 =?utf-8?B?eHlMOHh2ZFU3aE5jMFNRSlVvTVhTRnRJYnFNdTlGdVAvUng5d0NYNWJmUlJX?=
 =?utf-8?B?RjNMQVpJSXpzN1VGdWRQRHYzNzFsNFczeVUwbkx0TzB1UlVEUWtmWjlFQUxk?=
 =?utf-8?B?dHdERlE4UTFRdGd2ZndDUTB1RmxGbFE2SnpodXM1MnNLRlQ4b2VOd1VkU25j?=
 =?utf-8?B?OFhndktISE93UUFvY0lLbWg5UU92MXB3TFBlRUNwMi8yZUZvalVOcytEM2Zi?=
 =?utf-8?B?QWMxSERzb3ZEa0VrSHRPM2hoK29XS25PZEF5N01odGZvVlZ2QXh1VXFieHJy?=
 =?utf-8?B?Zkh3aG9iTkVNUjFwUjlOcTl1S1ZTaFVjOEx3dHlTYjZmbjJsUU1KQWFuU1k0?=
 =?utf-8?B?cEhac2haVmpSNHZTQXJyQ05ndzd2STNMRFJVUnBtZDJHSllFY2hxREpjamJK?=
 =?utf-8?B?eXFZd21wdEpncFAySkxMV0pPaHl0cnF5ZWRBOEhxeTRuSjBmVnQyTldOUzRU?=
 =?utf-8?B?Q2c5YSs0YjlXU2RwbmZBRFYyV2x6YWd0dDhpS3dzWEFSM1NIL1JtbHZjRUp0?=
 =?utf-8?B?bVhOWmEvQ3NKUFNwZ2NRcENFNWRrNE1xR0VtUlRzM3M3RUpGSEJGMTJUSkEx?=
 =?utf-8?B?TTkxZ3o3NW1GUjlTZm9abThyeXdYWmtoeDEzNXR3OWZQT0JIbnBLNVlqTlBH?=
 =?utf-8?B?QVlkSzJSa21uMVZIUWxVT1Nvd0lNZzZuSnJnVUcwMFNnRnM2UGpFUEdtQW9W?=
 =?utf-8?B?UFlOOVJwOXphWlJBMVdERkthaXNCYy81K01WbDNNaWpEMkl1Mnl3cXVTWnZE?=
 =?utf-8?B?Z3MyNmM2OGlyVDJBSkNmVktVRG1ZQ2lDcGVIWkY3UEtXTm9GeWN4S0pKcTd6?=
 =?utf-8?B?eFd0VUlqSm9QamUyTWFOa1RaQnNYcTVVM1ZaNXFFRWdNSDc5WHkzd0NRYWdr?=
 =?utf-8?Q?0zdM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db52e7f-b274-4471-fc31-08dc5927cbe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 06:31:03.8261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gLNcuLaUVbLl1E07yv2LkjQC+ECVswHzrRzZ97vc/S3qPsg3V5UT4AzrE6vSElxUf2x9Ha7zyn20ENtipTnqXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896

VGhhbmtzIQ0K

