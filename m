Return-Path: <netdev+bounces-154134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B959FB8FD
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 04:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595A01642B4
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 03:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165DA219FF;
	Tue, 24 Dec 2024 03:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n0OeKiux"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E085219E0
	for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 03:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735011643; cv=fail; b=g/Ay8o4viSsCC8mzB12tKut8LVmbSF2Lo47AoC25A6yYiyThkk3XM1B+fE2KJLjMF6cPJaR5itebVTT75+LhUXsLmuDDZusz9GAxORa8EbWE0KQedqLw5gr48IWo2TnlAulyZACobfOLmXxYE9M8z2B98KC49+xBlkeNXFUd2/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735011643; c=relaxed/simple;
	bh=1/zRbdRorgiMqP43ALbWJ1Eh8dh/Wr3fCsjlZUj6VJ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e+XH4TNnsqBbubNwUmVfD0MwkVEvUUDn/UBku5POxfXoNxnQRjhblRZGjol3xmmdbFvX1KXfMZ+l/XsCwpVj9flXwD6D3hmaChSjT5TQN2fptFVlb/WWNvG1Nl2Kao6p8xR09I+XtK4F5LXsBXjR8+bfe83tr2FhJU8I3fIT/mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n0OeKiux; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDOYkcRyUlKF/oI1ZdtI8nPLTZiLQygeaC6Z7EaKQl+D/xslB8P9QagmYs2JpX3aHN+vpMZDFCgBkG+R78e4dOsUKEucAheLOv7IqmJyDkQ+GvsZI3DJkDIZrj4AwRQYND6S37oC4y1HiH7um+gjANFqjo6YUqaKdbJF0OM86orAMX2WPoU5uxI00ZpThNFUjuJLcI5dPvpSfbUewNYmEgfq7TPiZJASjwyWmvprEE5wSZDRqusS0aLFWBlc30eN5ruIr1R0obbqRdoEHYzwfUmJuQYP0SZn0ZPggKNuQJoqzPkJYhX4M3W5iXAT1ME51T3f5OLF0hs78nmESb3pHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/zRbdRorgiMqP43ALbWJ1Eh8dh/Wr3fCsjlZUj6VJ8=;
 b=nT6wOOITSKL7aFpXJZGC7W6Q5Bj+59M84A4QqQa2I7v8FKKz1HN/PKQMsMssig8EyC3AmenN/0j6ns3SIIJ+N5BQDzeCdSEgUZr/i/ZAfxCgn+13Qtb129LRa91zTC+Yy1GInU4xe/urHHpESssOF30gbOvCLz2/6GbokArqcL0MDC6sVGsI0h0/O1XCLU7YGLly2jSTwS05FrBhdAmZweG2m+n4k3dEg7x0X1WwliKIsjpl730MQ6ezeekNuyD8g3t4ZvnPWXomO6eTFlh+6foGbWtKmaUEzvhKtPatQAUr2ApJGxvlQgfWTDkYkdlA14B21fsn490LJFE1SJQDQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/zRbdRorgiMqP43ALbWJ1Eh8dh/Wr3fCsjlZUj6VJ8=;
 b=n0OeKiuxGbBxilMcWevYp8pLzsGjdIqqxlLj2sGrKotvOGT4qWAkEa/rB3Jbi3OEk9JbdEYMROSpcPIQqsu/ni8QLBmbtsr+Jg+DVB8t0DQp4v8m4YFLu2uR/tEhC0WrBUfjI+h0P17TBndz4DgMY+xg7SzCoHu5xQb7d/IyaFf4zLLBrPMQ6wUsP0GYW5em/Un0mDJSTq50OU9FNq/z0U/qjp4uHN3a4qqmoH5EWgXxpOJcU55yexlOeXC3WWLHVXIL0mNRHZIuZRA5iPV9fZVXSucUlKQ+Y15IunD7VdREm1PKM7NoGjGY9xbfY4xH4uAZmfXxubyfMJ7ywKRPsg==
Received: from PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7)
 by DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Tue, 24 Dec
 2024 03:40:34 +0000
Received: from PH8PR12MB7208.namprd12.prod.outlook.com
 ([fe80::1664:178c:a93e:8c42]) by PH8PR12MB7208.namprd12.prod.outlook.com
 ([fe80::1664:178c:a93e:8c42%5]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 03:40:34 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, Shay Drori
	<shayd@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>
Subject: RE: [PATCH net-next] devlink: Improve the port attributes description
Thread-Topic: [PATCH net-next] devlink: Improve the port attributes
 description
Thread-Index: AQHbUicFtrfeWJBVv0aJBtIyWfxfobL0J26AgACd7NA=
Date: Tue, 24 Dec 2024 03:40:34 +0000
Message-ID:
 <PH8PR12MB72088C3633116EA320A55B5FDC032@PH8PR12MB7208.namprd12.prod.outlook.com>
References: <20241219150158.906064-1-parav@nvidia.com>
 <20241223100955.54ceca21@kernel.org>
In-Reply-To: <20241223100955.54ceca21@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7208:EE_|DS0PR12MB8575:EE_
x-ms-office365-filtering-correlation-id: a7bc6dcd-d069-4753-6ba2-08dd23ccb912
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8OsgWjwrEODQxUda7S3rBdeGPHEwIbuclpD7wOIlsj4GaJbORd4SiUD9MwXf?=
 =?us-ascii?Q?qcbqVhwYL4fFYWwSjnu4v2+cRglgK1aS3CT5j2xlCky1GfrpSj+eQCqWWrK8?=
 =?us-ascii?Q?7zPk9MZAVyfWmvk0+MKf9wqoYmMXZ6kaM/64miRWByOj+CISKy3f9Ba/5re8?=
 =?us-ascii?Q?ODakAdOaq5oPOrIcfqHLq6sOKokoskfzG2UvYTVHHW64RTfEntUOIZ5bVats?=
 =?us-ascii?Q?Sgp9+twgnuWpJePFLKrx5JXJvHdecFqiI3iOm8EbXfuZiXZMk6OtUT1KHPfa?=
 =?us-ascii?Q?NdzilO7cR95fX1GLf0dlLi8gKL7Z4Rg2gs3UbhuAcKOoNSyJ3ps7SDsDTJFj?=
 =?us-ascii?Q?bx+f3I38kUVxG/aEoPU33bz6KIo9tMC+BpLLdKGVLAMWoUML1DUTR/TmzjSX?=
 =?us-ascii?Q?dmdmqpie0MZRLlu/5HTZPBHHT/NqBFJB1YlXECHzpgMt9Hiq+BV6sYOL/gRI?=
 =?us-ascii?Q?eioIl/O6v7MCJzuQmB0I4GBBBia+zcrvFoK5xIuF29UV3aQiW+i74VAyu7ON?=
 =?us-ascii?Q?3TDrf6pbHjTkVMIEmqj4c7c4k4uLhBVsRBkc+/b51jaG0cgU7mBA3Oe37M6T?=
 =?us-ascii?Q?4VnDh6xqx9AhERPrsRO7SHij0rf51gUdAeAuyAM13tLgNZ+NLUI8TKX1ZGuv?=
 =?us-ascii?Q?5uuH/z1EDP86vwtznNfHoaKP7j/eE3wF/HD7Duo0nKPNjvxGxuamyyT5LftP?=
 =?us-ascii?Q?LSsg90tqFMkSaMvZXOtYOKVqgCPU18JAlDeRJY3XwlC0wuxEK/fVi9hZ8he3?=
 =?us-ascii?Q?OWY1NJm8ZdxkV4kXHHHh7UrZd6KdyDbEJsS9f8MUTuMvfI+O5rFCqk8vmZdL?=
 =?us-ascii?Q?3Vkz+YVrlEdc1oj9DMNhnUVixx8uyeT1g5J4g0Ao/xG9Xi3Dor0ZqA+iMKKa?=
 =?us-ascii?Q?dewYZw+f88a6BZgKMM79ZEcDQJMCDxcAH8/2/C3QRsP1dukTLMtN9FA7HllX?=
 =?us-ascii?Q?ZHRIWt/8ctTbzT+9goLTGB5dDsn9B/xVboCsSQ3NI4KX9K+LB6+4N60UASdI?=
 =?us-ascii?Q?MnQNcvbOBhY/hoVpsOi1u5x3RWKCyxT7f0caIHvtzfpBofr+U1tsZ0oB7K7O?=
 =?us-ascii?Q?F4YI3ZI3TOxAYW4R6mwq8F1WyZQ7TvMyYG/vMKvIhy6TplbtZ2DdFz1kgEuE?=
 =?us-ascii?Q?NXFH6NYAsDdcOicQE7W6GyxX4nRi9E+M8CTMW+RyduNDBGEO/NRECbw2ajQ1?=
 =?us-ascii?Q?9EQ+vIK3ZznKCPCGjM/+Ek+RI5uuwggplLtFHa1pb2KBxJykGcTuwwR2XKhn?=
 =?us-ascii?Q?+0vVxryPbIhMYUwPhBWqeHwYEyKMW3SuK3lGyi83Po9iitE1XQCEG69JNqSW?=
 =?us-ascii?Q?su6E39eexenlHE5g3mYiq1UlrtkXHg+pZrsKoTlTjYoaZgfZfxyeomFUpfN3?=
 =?us-ascii?Q?DrYM65vD4Kk5S3S7q6vWXFquc7vXpSc+kJFY5N8+o46FmjcEmsm9ONFQpxFB?=
 =?us-ascii?Q?MmpdUD6ZSeeypThHzYpQKxeZ8IYIVPrG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7208.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RUo6ntXIYQBsjpuzwZlJgMgdCCTjgKE24oYtMJ1KQBf0bteB8rGC9sbNnKtG?=
 =?us-ascii?Q?wkNNpLp7zviOQaAeAH7WSjb02Iw2O0aNWTlYdrwuXPphY5YbPKcmZsxfDewW?=
 =?us-ascii?Q?LTU4K6WH+K2hsNYINC+Afg1p91BmLCpCszXRxcNfAbXMfCPp7DNnVeWXuP20?=
 =?us-ascii?Q?WY1SZgPuWBvaBno5qbE7Qlkw/ltPLvh8nbDaPH204PfLoYay910fAfi9BYn1?=
 =?us-ascii?Q?blCRm6bm9H3p5OTmkBBgGr5iYEQgOeCQZfLBOnoEBtdyUTRbRsCzDA/aMmhA?=
 =?us-ascii?Q?wHFSbFMUcy4hRTds9Rdw3tzZsgBrhhapweQjUEW4FHIo6T8EKzyyoSDHoiqq?=
 =?us-ascii?Q?WSaEw+8ihoePkyE2MSVTw32pN3FQm3zieahMVKQ4DFPBWf3fV4+pCIi8/IGE?=
 =?us-ascii?Q?0ZjX7iTNxH3t2FjcegyLjTiHltXW1YLJU7602PqLHAPRfBq4MMH4K6C9StWu?=
 =?us-ascii?Q?RR2jpJxKiB30wwbRChf/hYwF7B1t2DdCYgTiC3IVCZ26hvaoswNDUnN69jui?=
 =?us-ascii?Q?iN/Zgx9uxCdb6Xjd1vzSKR5XOTnexsdhb83yaBoe5m11ZfEbH2F/WH7HTTF+?=
 =?us-ascii?Q?/CLbsRaTe92F8PM9QCDNYP2AlcyGJuNTPgne6G9ezezhefd/tiHrpzw8cWF0?=
 =?us-ascii?Q?j/EabiDVVwrF3fmlubsoNPtZBKeLU9zbyHNY3Ddl3u+TThI6+CHosHq1oou7?=
 =?us-ascii?Q?0GpuEvJdLE3Ykpaa+Wb/c1J6pFaxiEsz9lB78ciY5bSKRAkLEzJOJSayXhuc?=
 =?us-ascii?Q?pIhdz1+WPOEuPFr5k1fmPHlB84THgThX89kqumRtzVbEO/tlUthbjtXpkqKN?=
 =?us-ascii?Q?tXH07Gm0URWZd7z3iNUsBI4TcJweDT2GagOD/CkwmcbmERAHa6Of2vzBRCPM?=
 =?us-ascii?Q?wY6HdZeRKv+P1eMZutM972qeMtgeJtt6rfS89foVgsmeJ9vq2YTAmUVJUoHA?=
 =?us-ascii?Q?UDXZ134QO53YvsJQTkF4Wd9TKjbbd6ZA1Fo/3GJWnf8UcsY3MBLsKiWbWx5/?=
 =?us-ascii?Q?6OgmyeiKduUGwvzXJZ+9yu4T1ILh0W4e4svqg3wqP6BeB0oGNdoFQCIUcRXc?=
 =?us-ascii?Q?rqwKoAZ1oBLaSdMjzBbiTTUtj1BW1TdYlbHvcF+0phmXkrxN2KK9wMh0vbSy?=
 =?us-ascii?Q?e/CBLwj+DNGiUB4fnqulDhDkA6VTJf/sEsZefLxkh8FSevOmayLB1GdRk9Eu?=
 =?us-ascii?Q?cpMXGbUmCKvOO8kNc+/ih6hu+Mpm3O3IFWY2MbMxlrAvOicwo+L2VcWRLiRr?=
 =?us-ascii?Q?IYZP6QLL7PjcU0i51DvZgbgytn8SLwx5I2loMXp+RR/xzWHPNGv6HiP2ka8l?=
 =?us-ascii?Q?QuC1w4GlUvX4c/ShsS+90Th9/znISpGSVtUzlfN/+uF5v8Gmt9Jt2H4+REsQ?=
 =?us-ascii?Q?T4jGFbwHC3fdyG54kEKa7j+8NKNsDjlL7O2vFYsSWIfKdJ+e7R6F5ambia53?=
 =?us-ascii?Q?MujKM/3KfIxm9sY5izND03jHwf5IB0QuPbFChbosj8tig50na0asumkXHFkV?=
 =?us-ascii?Q?+otcIogDkM34ZoTkd0wmjC993o7i+RyiovwrJRxxI+SeQDBt04tEd9ECZXv6?=
 =?us-ascii?Q?NtkwQanBVcCQX3nXSfE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bc6dcd-d069-4753-6ba2-08dd23ccb912
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2024 03:40:34.1247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9yAWNJJX0/oWPhIlEf8sMufzNQYx6lXFiCW+rbL8S36UTuaH4OEnyRFQGdc7HP8FbJDhvO3Y8iob1xD2oWSP7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575

Hi Jakub,

> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Monday, December 23, 2024 11:40 PM
>=20
> On Thu, 19 Dec 2024 17:01:58 +0200 Parav Pandit wrote:
> > Improve the description of devlink port attributes PF, VF and SF
> > numbers.
>=20
> Please provide more context. It's not obvious why you remove PF from
> descriptions but not VF or SF.

'PF number' was vague and source of confusion. Some started thinking that i=
t is some kind of index like how VF number is an index.
So 'PF number' is rewritten to bring the clarity that it's the function num=
ber of the PCI device which is very will described in the PCI spec.

For VF number, the description is added describing it's an index starting f=
rom 0 (unlike pci spec where vf number starts from 1).
SF number is user supplied number so nothing to remove there.



