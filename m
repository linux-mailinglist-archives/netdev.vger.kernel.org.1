Return-Path: <netdev+bounces-86411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E17589EAE4
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 08:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9351BB2141E
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 06:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E019B8C15;
	Wed, 10 Apr 2024 06:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N1SYqS1o"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2132.outbound.protection.outlook.com [40.107.223.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3F11FA5
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 06:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730701; cv=fail; b=FUASavoVW7NGTkk7GJO0gHP2Vns+QsNkY56kscxm0IRLLQRVHWn8VoX+HKArAK8NjPyAwIKhRS5r1o4+QpCKXwU3rOaP25m+yTpK6asDb8S5t6ZSq8NaqkJh2dIOBZQ6QZ3/NevYoYLH6ohV8WwQ6eNRmYSPchLhpcQXhUYeBWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730701; c=relaxed/simple;
	bh=eMZid5d9vhxiHw9q2DE1tVbKMEIcSD8A5f0Z8rzjuQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mx0QzxKBBTAKcokR/d8pgaJw2/blJ8Oh/tK4Pbu/qU4MqAdYsomO1+W/TQ7V+cWu8tYmvPGwoHHQF/hPQkXZ8OJzqd8RZDXwaePMYe2Vy4Y3HjNAK0JreoqcW+fEY/YGxTqpkGPxl7gNo/TFHao+MCDU0H7RbgSoU53DM5JaG6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N1SYqS1o; arc=fail smtp.client-ip=40.107.223.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aL+FVfaSYmtyZMhBHUQZyfSxWmUDYOrFraryn0wVUao4JfWsY6DEa6QOspQtKyfbmZ+ZqtTdgb7bol46VZcur1ND4bt1UP2fc3SFKxhEXQPGT7bBoX5Sdq2Evzt817I6wuAK6zidhcWxMW4OGkIxXmlnYft8ykbnZfnPq5KzFkDrIb1vrYBfxLnq6j9u+T4kduYHTwTPFoUADpJNeOhCPGl8ZCj7bMXpLxhG8VHcqmOjAltVIeQa63GL1yt63JjUIBJDKiOi3gp1Tgb/jjhwaJLHyWN0D0Mw5nJXeRh9aQZl068WwyfK/0VyFsp4f7aj78u78H3YJe6gO8PnD3aMRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMZid5d9vhxiHw9q2DE1tVbKMEIcSD8A5f0Z8rzjuQ8=;
 b=aCtA79Sulp3Sm2/u74dl1iDDf0Zvz2d7DhkdHbsMxyRje0J+LyBN5jBQ3+oP2eHWYymj1hyjXAz9rnNSVgzf/z+559il4YALRavvg8DuZ1EZVy4jEgJhQDRNrkp1GWwTKA4ZTABfNjyP4TLExWx+rjUI9a2bYWEwxxBPARUHGbs+NYUpaxExuroqS7Aj8FxldhPlalzRx3J/Dc8ZQ72HJWZdt2SOXYBckur+gs4iAjEdW8Kubr1wnsC+VlEVcJRN/632aqMlcAZWtqKDnITzkIewDWvT0CWeNBycleyZV4d5w9PErCp3docBdz7obt/ccXwvWSP/oqpjg4S/28SDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMZid5d9vhxiHw9q2DE1tVbKMEIcSD8A5f0Z8rzjuQ8=;
 b=N1SYqS1oCrHbHU7J+mYhp8a1n78YwTglNVamRPrakCnezPVZsqI81G3MGWPJ8nhET11aK/wF+sO9Y5rAW4wVFeHjwWsqf06FmjN437rMB9sz/hc4RIid+mP5fq1mnjxKuM3OsFstGWwGheDz0b9RHIbJxcAVgRftcTfQZbU8FpEWpZFXUSdD7g8KSxjLAXcFgilCub/S0pzPLRq1k1B388M8Q0J/8dBpnGdlGzGE2EGePfP1O5+p6FQhNbyvXT1i5AJITRky175s0LxxD7zE6jmDgzE0XGMBmMwULQRnR+nNEvTwOMdreRm+zYxOyjn98VDgUvSS67WLys0azem0og==
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 06:31:36 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 06:31:32 +0000
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
	<galshalom@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	"brauner@kernel.org" <brauner@kernel.org>
Subject: RE: [PATCH v24 05/20] nvme-tcp: Add DDP offload control path
Thread-Topic: [PATCH v24 05/20] nvme-tcp: Add DDP offload control path
Thread-Index: AQHahozouB5ThOj+0Eaix8CMe4wuqrFdYwmAgAOxM4A=
Date: Wed, 10 Apr 2024 06:31:32 +0000
Message-ID:
 <SJ1PR12MB60759F1B575FD36E62A8BB49A5062@SJ1PR12MB6075.namprd12.prod.outlook.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-6-aaptel@nvidia.com>
 <c9b64779-2e8d-4d32-bfc3-c1281f59fa9e@grimberg.me>
In-Reply-To: <c9b64779-2e8d-4d32-bfc3-c1281f59fa9e@grimberg.me>
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
 IefALiebltY9C6A3z311aN3m8Xbo+ww1updS2Qt6jlz78asQZnwjTCgDPEZH8IeEr6jHlPJynDFc5dwyae51ehi+1yX2z/yyw5Hhi/pdi9nW6R8LdUNPAhlEZxoHO5MJHNPVYv/qAHFUtEZcw44A3fiyfNLTQWv4n3QVANY617ddy7FxykBKtIjcT6imJFccux2n1ceHuA+GTpaIfC6omgIt5WxcBf5gO8U4aV6VxwcFbk/wR5YyyXJhbwDwRAAVzBdwyie20IG86sbemArN5H0O+3B5t5cQFC3dJcGHdJWT8irbfz4TdlOOlitbp+9VyLvH+mNox8PntF1xL51fP+2NpwPcozhcE6DOnY4Y3zEYwrspyy53TPneHeTALaIBYQPKnaCOoL6l78D6rhpuCEgBFbTA2y/6r7LwZSz6iPzWA9QPUoBkU58/WkLkZyiPY45NZjW3VzpVOHpIqLT7lpC03oPlXqAW2o6Ub6Tv4+FPWCAv/oQjT9EMHinoVFL9N2RW3RWyJApce9ZCaOCSZXAyHQmOARxb1Fy7dFjSAi6IMGPP0kI/UzWA6piRHH8NTlcEdKjEH7tOHnVGZf9nVY2xCGy5Vc9RdFNlNvmMUgjUH2aoJnvs7/spzWOHdxJkY3fs+mbhnHmdb2occIBRcBsT8/GgK+FN1gYx0yfgYvI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzBONjlFYWlURjlyNVlHM1FXcVlxMDBPcDR5c1FleGVqMFJ6YTNaQmYwVXRO?=
 =?utf-8?B?MTB3NDlDYXV6TERHRHFGYkVxQlpmaHE4bDNjTnhFOXV5L0xjYlM3cXZ2a0tj?=
 =?utf-8?B?NUs5ZkxNeGZIQkNCQWtvUytnZFBqRks1b2lTNDJLS0tYOG1DdDlVdXdXKytl?=
 =?utf-8?B?NmNpQ0ZLN3U3NUpNQ2Z4eTluWXRMNmFBcWgydzE0WVNOTVBsV3hNVE12ekpw?=
 =?utf-8?B?MWFvZTREUmpMZmNUcS8va2txbzkveVZYSHJhMWpGMmN6aDArNnl1UjZjK1ZP?=
 =?utf-8?B?SzdsMXFzMEpBVHJYd1pDMFVkNitlTTFjWWhBUElJSnBHNllnTk44M3hzaVdV?=
 =?utf-8?B?L082TlNCd3NGaUdTQm9RdGErMWRXN0t1NVFGcFoxdkNaWFUvTkJtbXd5MUda?=
 =?utf-8?B?M2RFc0RpM2ZnVEVJM2thOHJ4LzRPOHZQd1E3TVN6OVhIR244VE5jSmtMS2Z1?=
 =?utf-8?B?TFVtaXhqQTdGSTZMWlpML3NlQlRKaHRoK3pxK0ZUMFIycHFySngzYUxhWnN6?=
 =?utf-8?B?eTMzN2pCZVJITUlqc0hWeVNIVnZDUUFNdmhSdVdsYU1pZzN6QU1rWmFtUEVo?=
 =?utf-8?B?UkRhVDd6U1pIVnk2UEhyMnRzaGovMkwxbjZXSDBiWE5KckpwNjVpZE9xNWVr?=
 =?utf-8?B?eXI1K2NMZzVHbzJxNHlCZ0ZjMnFZV0RXR2xONmw3d3BPejAyeEI4Qi9SUXdt?=
 =?utf-8?B?b1ExQWNMaW9ubjBPb3lBdkRDNG9RNkIrZEtJMCtwSkQ1TC8rRHZ5dFJvRTVo?=
 =?utf-8?B?ZEJhd0FnbVFSaEs5TUhFa3hzTUh1YnFEOXhwUjJqR0M2WEZTSmxBUzNDc0Vo?=
 =?utf-8?B?eGZZSTQwd1l6eDQxWDNXWjFrOTRjVE5nOEpYaGxHenIwdTZ0dy8rd3JIVmxx?=
 =?utf-8?B?cVhqK2RqYVFPOVVOOSthL09kMGVGeVYzb1Y3cFQ1a1F3N0ZmbEhtdEN1ZTVN?=
 =?utf-8?B?NGpNZTJoQkF6M1hqU21XVTd0VGxvRzdUTDMvQUEyOVVwVDBmKzQ0aWNoZSta?=
 =?utf-8?B?MjljdHVVclZwOWpLQWZlTVBmWG9qS3lYNm9LZGZxeTZ0VU5hUDcya2dxeWs1?=
 =?utf-8?B?QWh6eERTMi82UWpwTVhlSCtGazh5bjIvSG92RS82RDJXK2tUaFIyc3A4bnVu?=
 =?utf-8?B?ZFFqZ1hyVFZ2VnowMDF0L1VnWmlLMGdGV1U2UmlDZDJudXhXaWlVdHNuaU4v?=
 =?utf-8?B?VEphcy80SUF4cWxjaFNBNXp2R0owVGxKQ28yemVjMXQ0RmlSTzBCbHV3WTly?=
 =?utf-8?B?dzdyaG4wa1I2Ry9DWC9WMHJtL2U4V3l5dHo4UkM2YTNLYTloK0MwMmtWWHY2?=
 =?utf-8?B?NmRPdmFRb05yUG41NzNnNVRTYXVPaDJEMTZKMFpNNmFwT2o0NlQvUGlsV1VR?=
 =?utf-8?B?TEVRSXVUc0ZFSGJLN3VMWEgyVHc5ajNDbG0rVHBERFBXN0lWQ2U4Q01icE1r?=
 =?utf-8?B?TEpmVlhmd0ZZQ1ZRTGNCeEsxL05PSVpBcDRuYzFSQldjWlBYOG9YNVpmMncy?=
 =?utf-8?B?R1Q5bEhWMUtPTzdUcWU4L216N3d5U1FJOVQ1RkRDdkI5d0lzMnVReDdkZFhB?=
 =?utf-8?B?cVhhc2NyL0ZmVlRVNDR6N1FiZG5ta3puUjJiU2pYLzdHeGJpKzRlOVMvc2FU?=
 =?utf-8?B?ZWRwUmQ4U2lyTmN6MXB0bFBkV292TkJQUnhiTmJTYWpSVVZVY2RXc25FeElD?=
 =?utf-8?B?K2pjdEhwWkY2OWl1K1A3UC92RkdOWTR4d3lHY1JKTnJXSzcrQ3ZVWW1uQy83?=
 =?utf-8?B?NG95Q3gvUnFTNUhEaGpzMk41enhRTWU0S2RGd05hOGZsQzVzMWxXMDR1V28x?=
 =?utf-8?B?bzd1bFlYN2pRTTB1L0hKTTBidG9FOUNVTnJPaVNyajVMMGI4NXlNbW5ubCt1?=
 =?utf-8?B?ZDl2SEp2eXNocFFySFhtRXFiVEJQcGZZSTlwK05ReDdZZU4rK3VkaDBXRTJy?=
 =?utf-8?B?bXg2cUY1VVdsaDJpNGpBc3o0UjdBajkzOGtmNFBVbGdiMmdCUGRFMDlpdW5x?=
 =?utf-8?B?Yjc1U21oVWVNUTE2YWhuTVYwTkNtTy9rdlM5UXVtUTQ3YUlxeWhxcG5BY0NF?=
 =?utf-8?B?cGRPZ3UvMCtvOTlwVjJ2RUxnQThLWmNGWjlnbmtJM3lhZXdUc0VaZ0RsaXZs?=
 =?utf-8?Q?zpQw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e688fb1f-1204-4f0a-98dc-08dc5927dcc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 06:31:32.1861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLmujXCnVLGmcryuNecpcUym0eNdCD5fitqUvyJeyz09BR1dh0F2KKQKeSCrkP6zoueA0KB3pHVxwgRw3jv7pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896

VGhhbmtzIGZvciB0aGUgcmV2aWV3cyENCg==

