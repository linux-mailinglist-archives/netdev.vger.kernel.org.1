Return-Path: <netdev+bounces-166377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F96A35C3D
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 12:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5B63AA04A
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 11:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F8025E44A;
	Fri, 14 Feb 2025 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rxaJzy+N"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866D725D548
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739531666; cv=fail; b=RV8RBhz7LsVikkcRRZgTrilVbE9hNCU7pnjiQcz7f9af1XzxKQkODfRCk/NlfNHxqP/0x06E/XUVTCzL8cxH3B4T7tTQqeALx8z/xRRi+mAE1dp6RuUjGONvUxbRUI1F0rM1WIopXuIJYB2DgH6aEH8/asFMzCy89hv2JYgiQ1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739531666; c=relaxed/simple;
	bh=5nQ34v/fwGjtilV0i0v5kXUjUh45FbBa8oCwkF5LdG0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lk/MzstUFAph2D9EoJMkwLA8JU2EmXUeRJBmAYqrmIYKnSYrW/M2dCWaB0UUCgPuaXtdTDwjC2CAy9nB3rmpn28EtU8PNaU+uMaNV9393ZRvYl4OmC1Msz3zS0IYsP3Zua/R2WlCLdpr1W10qehjt1kqa+1lsHRGi5fwRWyTsV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rxaJzy+N; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRvyNttTZlkGwp2EOXMXU+0tnrOguFBK4m4wmWPTmQZW9vbUdEUwHZBlFrZoCMTb4gTliXbkodF4w3gbKHlSktCXfJldSOhd6o6/+lKMOEebRjh+UGax/glV8wgyZ+P84s2M+zFWi+FpyAcjoa6kZR7/T4QDR3FgLq8dCR4lKgMk8+A5syEcA1ornV6wkcCC0nsN70YGMZC5CzU8X/Qbj/LsLnNOfzhgfGcMZnVpBm/chfCCNOJ7lHD0k+HmOXAKh5QwA8Ij3v7jXFHnEjvsT+Z+AYrfZWimef5ZN4qKGNVZxWdvOy8wlwDcNRCXpf4ROxiNZhIHwGF/LLvzVHbrZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nQ34v/fwGjtilV0i0v5kXUjUh45FbBa8oCwkF5LdG0=;
 b=TZqneljrUymME2PaE25QTaPsHqnWHPOZkOFHvHCKH+Qne7D/kcAx9P6k++5pUOzBGAxCTgkY6eWbYeGpO6EsZCRvDrFTjhI4gs9cXhYKNHRkMzH0oRX+IIOihsqKIZUabPikhShxQnGjJQBZ8F8s0sh3nZgX2MNz90kMfJZbUS+aU89yQP5cyhiBGQkztUPoemTeUOp5gFuItuTWVdERYLflEottilka0rcQ5ki0N3GJwEfDS68U6NntqkwUHvoHSJ00gVAPSIkbi0gz5EK832QD5r9ngc3EXgsYyJsRJGIfXwuOJJx9rKinlzfVUug8x2En+mn6ddP0+3D7M7svjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nQ34v/fwGjtilV0i0v5kXUjUh45FbBa8oCwkF5LdG0=;
 b=rxaJzy+NwM+MAvohcZof+cPSthiVOAeA/3bGKa7i+rDnU6lKoftFATlrVUQUmAvBVshxm5cbOCvhB6kJZad6r2RvC3pnFEmKC3RWePGrAF0aqGXao95xwQBQL1zl06q55zmCRpOsoU6W+66AV+QYataIxJnn8J2gDvhpm2NoWmajbV5TgK2yZ12tnZbizuHdv0VHeFkPk4gt6qCbTAB7QJ0M8vlEIr3KWOdUpRCHEwziIdXnSPO/l7NwtwrEzxQOuHaibDgJc4cJdYREaCDDGAkYptpqoNSBhiSIThhM7sawUOOxO9wWaw4R6mkyKSJx6uh2yavHvAXWcc42vjCXcQ==
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by SJ1PR12MB6170.namprd12.prod.outlook.com (2603:10b6:a03:45b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 11:14:20 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703%4]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 11:14:20 +0000
From: Wojtek Wasko <wwasko@nvidia.com>
To: Thomas Gleixner <tglx@linutronix.de>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "richardcochran@gmail.com" <richardcochran@gmail.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "kuba@kernel.org"
	<kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>, Anna-Maria Behnsen
	<anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>
Subject: RE: [PATCH net-next v2 1/3] posix clocks: Store file pointer in clock
 context
Thread-Topic: [PATCH net-next v2 1/3] posix clocks: Store file pointer in
 clock context
Thread-Index: AQHbfJbtWHi0PEvY60K/ENTGWuZBh7NFHjWAgACyswCAANfEQA==
Date: Fri, 14 Feb 2025 11:14:20 +0000
Message-ID:
 <DM4PR12MB8558CDDBD2DC65B41CCB34A4BEFE2@DM4PR12MB8558.namprd12.prod.outlook.com>
References: <20250211150913.772545-1-wwasko@nvidia.com>
 <20250211150913.772545-2-wwasko@nvidia.com>
 <a360c048-96f3-486e-a097-e3456a6243a8@redhat.com> <87msepjxqp.ffs@tglx>
In-Reply-To: <87msepjxqp.ffs@tglx>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB8558:EE_|SJ1PR12MB6170:EE_
x-ms-office365-filtering-correlation-id: 5b97b918-88d7-46bc-9c1f-08dd4ce8ba7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pu71WNodUTahWs1X6lPRJBCiQJ6KOK0xShyruNf3MEabDjL6Dz2QEc4FpJ+0?=
 =?us-ascii?Q?yxnZS3lHfu+EVe/7CcgGxu0cluPcmc5Iw5NWM2iqjOvo0Me/l50pHPZ9JRRo?=
 =?us-ascii?Q?vK8uVNS8kVmupFpdQNwZgTIKWvJZ9sewTmaJ+1pMXR6zCr053bohYKMIeQ6c?=
 =?us-ascii?Q?Lz6A5mP1jefR2OVlLSPIFMvTUTfhn4m+0fYpsZRf/LJsHWUL9XpQgh2qWhba?=
 =?us-ascii?Q?nTtI7taWBM+o9w19ESkgcSUAjb3c+dclDg6xxH6f1H9QRgdgWFW0y3qWRCGy?=
 =?us-ascii?Q?JFVsqUoZvvTGd8rnWvUcxKBHBiJb1JiZjgTsvkSowIiRtoVPgBVk2w6MwsEg?=
 =?us-ascii?Q?Ckv5JRGZmLZPSOP8z2A9PE9ww431W8Vnv6LnTZk5uhGfQLpLZ/4Av5Xp5HIK?=
 =?us-ascii?Q?/rd8eZ6gSZdNSrS4h76urwV73wUPprIQN9hbauBU94bua1y/wxIEJU3bHpG2?=
 =?us-ascii?Q?SgFs4h9buUj0TrB8QL/7dI33vAvr0Lc1ub43nNkqSjhqw1pVYAwjyaUpddZI?=
 =?us-ascii?Q?qooJErFDhVskwsdyqNKtXgnlv9sg0sPDHX2U7sqGf9BRl3J37nqmoeQV5j5I?=
 =?us-ascii?Q?ces+77M8fGmAIVvwzKGiAB0JrtKk9GQfp3576W3X1rY+buBieW5Fz6R5GhY/?=
 =?us-ascii?Q?rIY1RujP/hhph0izJot/mbygke4ckw5lc5Zxwsq+6EG2ehWOWXZf/0vK38NC?=
 =?us-ascii?Q?iqwaMJEWlyu4lzSy13bnmqnoJZXqk/vueMsIexXF2YJJQ+hmACeeaX2L9lOY?=
 =?us-ascii?Q?XwDQcnuo21KDZ8j4n+E78KQzxlQQzxcz7hqFbg8HwRSx2lnZz5TCuPliJUnF?=
 =?us-ascii?Q?x+qnY5n7ch5BD7zBKNoPymjQwt9ad0o1uLLspGHdigFlf44Vaes4jy2SDbsu?=
 =?us-ascii?Q?P2NWwVW/YiZdBsALhbqW73amGiBwHS/Mptczp2xCqe+JfQvZumsPrOz/AUB7?=
 =?us-ascii?Q?p6sf2ulqOyrsC6n2eQf4F9aX8sm6ikN6OwNi/FXI7oZYp4FjSzNZDoypJ4Hl?=
 =?us-ascii?Q?5FXV3hww/7sC27G2FzbLc58yPsZl2zZyzB3DNmDJGbarc0ni+lZXoZGKpI8Z?=
 =?us-ascii?Q?5ZlncNyDCVBKGAPwDh2hkIsCTLJ3/DHVXrBthQ9Y4r0HRQ4JaP/bSV6ryfT9?=
 =?us-ascii?Q?Hl7CD9TwRXiXSaq8Lp48VBzQzUpc3PGXza905DIC9u6bWF+I6ZrJn6Js+PRL?=
 =?us-ascii?Q?NItYHro3vGa1162Yt28B4QVyhqDF0KJiTaYaheemTtY8JLW4cLorceWGchAq?=
 =?us-ascii?Q?k62HUHl+xbNFZCV4kIValw9o7q6r/nIUld9Iqd8+G4gYuq0aIzkrgH6OFd+g?=
 =?us-ascii?Q?sOSPw+XVHmIYXY2flMMbomWCQtW7pHdqqHHn0fSeeuJhqh+LmEgqnNIWDZwN?=
 =?us-ascii?Q?QJK+pK968AHP1jtgLXYHg5hOivGMc6P9/X3+K35uS0nnDtClzRI7hmxJ9xei?=
 =?us-ascii?Q?5XhO7X5beLuFZN5YsaDR7E2XN4tnFoD9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?98fWhQ7SBr7uhUEiVAoO6oZ99AUURuyTNXjAcfCjagMDnmBFtKBTR/+AEw4E?=
 =?us-ascii?Q?WZ06jFW85i9SyTqLVZkJC6bMI8fB420L83t7A+LgXRiwBAxVvWedgV84Glhi?=
 =?us-ascii?Q?eT4t/Av1iYWLmLeB69O5gb63FkyvyLB+rVgkos+LJduGsv3otetoT8eLq/ub?=
 =?us-ascii?Q?SxrjSJ44r/mILmZoJ8teHsJNWFWmZySOwr/4pO1u39P2j2HDfoO/sPiOqyBL?=
 =?us-ascii?Q?jH5tPQEbbhINGUDMtJgaTcN+5fAZ2xL7Zx9CRm57s/lnY7uVMe3cUfn2xjAP?=
 =?us-ascii?Q?JnzdSee3PkhsNfhPC5y8jY87G31X1FAaGzddo/JZAbgf0rJwqbx7MzoNqGq7?=
 =?us-ascii?Q?DkVqdt4spojKlmYOjI6mg6fPYeC6cBO02ip6s7zDfpEYPNrAmt0UjmmUOfgw?=
 =?us-ascii?Q?7gO84kl18ypxiYf2B8NJYcXVZuzIjAkAaYQvpIm+D4JjGrN53GpqxjFY7lTN?=
 =?us-ascii?Q?9ZX05wEdJKlZEVRU8VGAwBxnbPw9FUXXkua+crc4YTGC0YVacGw4gyjb2kDg?=
 =?us-ascii?Q?EKpjEnzWF5x3afeB4ulVRbw2xf9bJr1YYXri3nPEyIjcOi1oN3kaovb3NCm9?=
 =?us-ascii?Q?LwsQ61sreFuO6pP244SZ8+8CbIa8uetm2GfRW4hlg6XD5JYEWnF+paYLVykR?=
 =?us-ascii?Q?E4HDTLLzsFjB/luc1Kip2PteDhiuLkiNo8d14rR/jVVZCvstkyTWIys5hNth?=
 =?us-ascii?Q?y03s2vDQHVuG2KlNDhzmN6g1IYM3Qi57WqtSA82ylb1Qz/cukgNNesn5n1uN?=
 =?us-ascii?Q?KmtIuWB9Jn2jpQLYmTq15A5CroyKfaWFwpRRYSecb7YCkwPqvDS9f75qBs1G?=
 =?us-ascii?Q?WPUUI96oODvXzfZEkDpJe6zDVsHIcyLO02XMeMPV5SouWw9xZKi4yBDnCXAM?=
 =?us-ascii?Q?4Ze6QDhKE5/0movacty9HbD40tEhj7KlR2WlbnYj7vqNWkceqQ1XKYbIEGVi?=
 =?us-ascii?Q?Ux1H1wnI/yPvZQR0BeWkYEqrQnOCWWCu1QMuW/Xlng9004hQ6NzKZuyKH4x6?=
 =?us-ascii?Q?cLZPFB02Jeow9GeomUP1gY+D7sMRqR26BOlR3B2VbA2pE0fwaw2xuKDOW5l/?=
 =?us-ascii?Q?zv4uZYH/LTzYwxeGbQVmoQtJ+dwaWUp5K9R2akpci5KSyxJm6hkty/dWXACO?=
 =?us-ascii?Q?IXGHzay3qa9qxOdpGxp56XKJin2fR+RrE0apV+jsw3U6tnPMTna79jmfAPBv?=
 =?us-ascii?Q?B6/232kPfogITk/hCHxCCfNQjZUOcE3t7kEiF0OwhcgQO3QHY/u+w4Xs9Aus?=
 =?us-ascii?Q?oStNFcQdGtfdm3ZwVBOMD3F7QVztZN9Qm3srHL1/1e8922EiuTH9TwSSatZA?=
 =?us-ascii?Q?GGo7RzVkF+9k7Ia07up6p1AYNSRgvuc8/NVa8POHYbNn9xngh3hgx6mhue32?=
 =?us-ascii?Q?ENLUFYqn2Hr6RMXpLlDedrnW/73fnci3lcQ0L0QNXe9dY5ETHf5Lmb6Rvoka?=
 =?us-ascii?Q?Q+XmhUiW0VGYX7R7ZMhS6Q19nH90/HgdynS4nexDVMtH/XmlPw/6ewjqcYrd?=
 =?us-ascii?Q?XdFaqX960iNSIoYY6GfrrTw3gvo5sqqapH29aXObM+foPJ+m9Nm8LydQ8GJW?=
 =?us-ascii?Q?PZtuJJ2wAWDvZOGtDGs=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b97b918-88d7-46bc-9c1f-08dd4ce8ba7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 11:14:20.0801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H2JrYxxVFv3qehMNmVKp92i1w6ataRXivqoOAO1sKjK/4HSNuhcqQtEnb6EmE102ARGQHyeRCLB6CaUQefcDsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6170

On Thu, Feb 13 2025 at 12:37, Paolo Abeni wrote:
> Posix clock maintainers have not being CC-ed, adding them.
Thank you! Initially this patch was fully contained in the ptp subsystem wh=
ich is why I missed that.

On Thu, Feb 13 2025 at 23:17, Thomas Gleixner wrote:
> Other than that this looks sane.
I'll wait a day to see if there's any feedback from other posix-clock maint=
ainers and post a v3 with revised wording.

Thanks,
Wojtek

