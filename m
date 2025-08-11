Return-Path: <netdev+bounces-212562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3324CB2138C
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 19:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B29C3E136A
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E732D47F7;
	Mon, 11 Aug 2025 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OCSTPYf3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F0E2D47FF;
	Mon, 11 Aug 2025 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754934075; cv=fail; b=K39K/WSyOdPvBbJf2lx2QQAwj6AnYvjXqaOhT/hb+2iEEz0sibSkNtiJkBw3D8OQ7+X/d+2cukFMrNzxIgC+kzIIL+sPRUJK+3eZEgMAQqj4bLHemZalOUH2rptWoi94acfLH1F7mxzNOPUL1bjrxmk4zf6xfvHOtHazW7XVBG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754934075; c=relaxed/simple;
	bh=9PMIuXMI4OyWc/HwpPWhl760xY95JrTWOddO6d5HIB4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LpYDWD4mQcIaDJmVzG9JR6Dy1QxzE29r+lrBiwAMyxONaxVbyu2/eonONniGrm0FFVuKpkSjCPr/6FRs6VtgIl5RW+jVGPJMYgW1nY77IyeyuUaHRQsyj9mF2Mu7+32cmEDfy4J7BqZxRohfCYK8RK6/VYlE5Hv1GmYJ7dT70a4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OCSTPYf3; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfQ6iDWmJjns92e9Vov5PbR0QocerS3O+40o7ZuyJ5LrFBE8HhyqEhK3Le3tuIMMxckjPobgbbBVvUZVVIn92GC6l1u/2t4EpAhgWxMC+pyiCxN2Wlh5PfwZvxaANT1aa9PA6taY8qtTmurW2pjLj6e/DsEe5mYjJ42nN3BqdFCIwNERjs5Ax4SKZPmtiSjuzkRyLGoy30oYabHdNs1AJlZOq98f0mhV9nDnhLtEnOYrk9h93MADFO2xbm0xMW7jipwk1GvUqd8eOLF9p2Qi9+nKqxeCjziohKh2DotQeu951OGahTUvlSBraOFda1953Q8tNovJGQq8nrFRJg0JAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PMIuXMI4OyWc/HwpPWhl760xY95JrTWOddO6d5HIB4=;
 b=ihzG583sWEeldjmZPpWazGjsmEKaDexWH+zrinjyBJ95fs3IYauIhGSmWkEL3XVKmzHt/+YyS5mvG+qem6jUIaxmjtIE03YUgB7Y8q2jJm9ibo77DyeRpeMbhNlGGY2U80bA7FxL2Q9TpT0V2G2kgSeryNXjQ5thR39+KIgDBNvuV2hwmyWqRPPzxkVzpixBIhNASmrTTI7ibBx/lwNi970q1iLtuoSb+fH4yKrhrHLzoIWh4p88Puwt0rjF3gO6BCK69PXkcwy+6WljDgE+Wa6f6KNOWorr6Ob3NtViK2qwHELveD6T9bR71hnM0R8KBESX0+odJgNa3/qzKce5Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PMIuXMI4OyWc/HwpPWhl760xY95JrTWOddO6d5HIB4=;
 b=OCSTPYf39pIFZ2LkSeGu+VlPY+rHDi4V5hRuOzqnFOSQBtZsH7xKWrIaABAB1ep0v4t+j1yZnJGOMOeAbXUXO2JKxL8PTPpUh37JpAJOZNg6NqPmUrViJgqKLfGS30TGG7liVzyP0a+b+aMrvjHFnGgvLYZrDSVsO4WQbkAns2Q=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by IA0PR12MB8648.namprd12.prod.outlook.com (2603:10b6:208:486::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 17:41:08 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%5]) with mapi id 15.20.9009.021; Mon, 11 Aug 2025
 17:41:08 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Jakub Kicinski <kuba@kernel.org>, "Pandey, Radhey Shyam"
	<radhey.shyam.pandey@amd.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "Simek, Michal"
	<michal.simek@amd.com>, "sean.anderson@linux.dev" <sean.anderson@linux.dev>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Katakam, Harini" <harini.katakam@amd.com>
Subject: RE: [PATCH net] net: xilinx: axienet: Increment Rx skb ring head
 pointer after BD is successfully allocated in dmaengine flow
Thread-Topic: [PATCH net] net: xilinx: axienet: Increment Rx skb ring head
 pointer after BD is successfully allocated in dmaengine flow
Thread-Index:
 AQHcBj3ufqq2Yvzk4kWpSUUhUrH6hbRZIlkAgAGeWkCAAt6MAIAABN0AgAANb4CAAAwm0A==
Date: Mon, 11 Aug 2025 17:41:08 +0000
Message-ID:
 <BL3PR12MB6571D8D8CD1605B5FEE7915BC928A@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20250805191958.412220-1-suraj.gupta2@amd.com>
	<20250808120534.0414ffd0@kernel.org>
	<BL3PR12MB65712291B55DD8D535BAE667C92EA@BL3PR12MB6571.namprd12.prod.outlook.com>
	<20250811083738.04bf1e31@kernel.org>
	<MN0PR12MB5953EF5C6557457C1C893668B728A@MN0PR12MB5953.namprd12.prod.outlook.com>
 <20250811094307.4c2d42ae@kernel.org>
In-Reply-To: <20250811094307.4c2d42ae@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-11T17:26:51.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|IA0PR12MB8648:EE_
x-ms-office365-filtering-correlation-id: 205a3f5e-4b28-4425-488e-08ddd8fe4151
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yI+yOhnL62+f4BdCEXQvPARrSDeG0mcPP/WTVOD2NGsH7iBwhpBisin5AUNw?=
 =?us-ascii?Q?UqYQgmgHpWmhSJfmgdJoSBU8UnbSRbQKJ/3Aipwjk88GoBX3mgtlpQDUgPyT?=
 =?us-ascii?Q?4pwOcLwTFihHnJnRpN2Gxe79/pGQtY7AD+3nqdRpvBQ/TQU7SkjTZsWKBPx/?=
 =?us-ascii?Q?Tx74MMdg0eLXNxCVJjhgUKvixOjkFutVLyPeZAaWOLOqulIQIe8JUz1t1GGS?=
 =?us-ascii?Q?HSe2Ga6OM6h0EFcOJWS9iHJd+AGkHBgARexpj/zY0jxZjpwJsVZOGZ+Cfxkr?=
 =?us-ascii?Q?dzuTtVH0AQ26WFKLaialKX9KoEt2FNSv2KGHGebKxkrYbAvhwhgKNIbIR3jP?=
 =?us-ascii?Q?LwH5ew3CHXMuOeacT+v9xRcOhp/dYjtn7Qz+yjWW+a2fPDYCyPvneQxnaXZr?=
 =?us-ascii?Q?nkcHx170OrhLCJcemTbhcIOl9xixYeuXc7fJnO3Ky2z8D+RGoAPQzwC7CpHg?=
 =?us-ascii?Q?/653nOP02d5NDIYhmZWyT8beaaKhDEMSIgaf4f99KhdeclDr5Pj+HAbawsyj?=
 =?us-ascii?Q?lCRaWUa41EJe/nGDYBpafCmbGGjJB5o5aMTenj5vq1IuDjuOQtZoF4GVqQcl?=
 =?us-ascii?Q?D19HXC9r1QYkH4ZfMfAbBJ0pGppXDIUZ41REWhEtEYPtObGIWb2M6bf4Ctki?=
 =?us-ascii?Q?IotU8Lolp0EVBUrpMVTNTWvTN/nERMn25Ot0VhJxUlI2xnwY/apYcQYfJvOH?=
 =?us-ascii?Q?dXEiOcIEX7g47lFu2iwilmXtqiPxLYy+UsyZLttpCOT/X9a5NFw3xiZzXeuv?=
 =?us-ascii?Q?kwt9gQTJ2zQbPUAD99KQ/BXQG2+nc26z4jP1K48/zJ9Q2qDrMXg5MFzLto4j?=
 =?us-ascii?Q?BLnfy160NYE/54ZC0+UD3ZDsKpdHnEscjbimEnQgi83nsh3A1QQKSiLxuUkK?=
 =?us-ascii?Q?ejS0LvLH4Bndq55Vvxu1/wSn5LRSERwohCHxpVPulHfnplINMUyJfoQ1jyw5?=
 =?us-ascii?Q?hVzBq4MRqchFaUyEkTXSLTYi7o+6eJK516QDstny8NKDtSRSnLFGlls4Iy2r?=
 =?us-ascii?Q?VSPdA+wMflBwP5aJJ3WMdVk50jB7N4jxI6M3kCYE7affTbnBoeOqTu6xV6Mh?=
 =?us-ascii?Q?MQ6Uutjvc/pQ0cRpL5sNa336DAmSCvg82aiUv8TOoljWUxxllCwUHUVZVGmR?=
 =?us-ascii?Q?KpodY9ixViIDdGFvW0W7kpgwIARpdqPTj1yUsP4iiczr0S8x6YDuyakqgAhc?=
 =?us-ascii?Q?aU7dR9a72RCYaLvfkM6n0qYnvHT5uLaMaQ9I1tgpObLWBnjn1iYuxwXrXS4J?=
 =?us-ascii?Q?ttIkzJ/GHpszNQ2WYAsCqQQMQfgm5S5mRUbxHuawe9Rrraw0zfqGVzddT01f?=
 =?us-ascii?Q?+DLVTPwSlQK/hmzoJ7IohNeePvjwWDsFb3MyR+a0QPzi7zdMGemHA2sxTTW9?=
 =?us-ascii?Q?K2kkwO+xBOL5UK6Fn7P8GWHlT6SzCQEPnvm6Yzn4f0PYLjkV/yPdm4i3jGXE?=
 =?us-ascii?Q?xmegBVz9HmcBBQ5KKScD3i5h4nVUXkiSz9EmTT8uqiHFoY+I4ZQLNw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zwXzGaCW6aDpxEvtchsIbQbpO8xYubbAOt4kCR2u/jUh1psC6RIGq7s+3REN?=
 =?us-ascii?Q?XxicyVnuSpv4hmT3+3VOUzDx9TetxZOadOeNcRomoQ1Y/nhz9M5euU+FW0ff?=
 =?us-ascii?Q?oGjEkHIofwgCUCs0ZWKrFVMLIMOc6E1NCB6sdtQfq1gheQFAhhYh49tgsFpo?=
 =?us-ascii?Q?jguXdPYdQ9FqKU0cjBXK4VMbaWSTQANBfF4YI6Icnznqjj/BP9k4Foh0xxwA?=
 =?us-ascii?Q?x6TYospgBmz/f29ChNNA1Zecbe8av+asiRBP3gBXfjq/V8FjfX/PybhoF9DJ?=
 =?us-ascii?Q?HYxgjKFg9xz4XKxFqe1eYckJPO3SIfiUYOKumpGQvyxh1Y2in/b8H8A9YtDK?=
 =?us-ascii?Q?3KGuXHL+lYv4YIu5Flr+a/eMiyZpUfgwCDkJQhcESh8KQbCSiAotFGpA9gys?=
 =?us-ascii?Q?rT5gnhB+qbBxNXDo6zccp5fP0dncArhsKENnaeivK33R0JqKHzRGZcRrlbTT?=
 =?us-ascii?Q?kX1zTQn5M62FcTM0Rfh7Hngn9rizl/kT2HNlZar/ZU9eL6ifaHZfdjwL7xtM?=
 =?us-ascii?Q?kXcef6SIOlnueoaVBPWafqxEJjUtkRgwQosHpg1kBbH5IkS53grHYyFkFDjh?=
 =?us-ascii?Q?zYKiKAGr2RCKp8pwi/h739zllqVQLjOxDzSA4If8sdbQUyKIZ8VFyTeLy6wm?=
 =?us-ascii?Q?Qggvzy6dIoWq/MSIceHfB4HIWMwnSWvcJwCQLnLJTTOVJv3qBQEyGqbcAFet?=
 =?us-ascii?Q?XPwRuKEE6Of99A/SVrvV46NCdl6U1ZNf57eC3FcpBqCyUGVE/qOFlN5yilh3?=
 =?us-ascii?Q?QYkHaudCZeKKCGZoIUJeiroV/H9mp3nrLbMF9tNTNCWWIy3CeFEgqnRE//ff?=
 =?us-ascii?Q?j0NX+Iv5tRIj62BBejcFOtkUO+mDIMlHjycDQdSVsTyWTOQPt2GKFWHkC8uj?=
 =?us-ascii?Q?33nbSS7YhkGJzbOoaSA87hk6JRalbPo2JsoFCnwPn76/ZPwOs9lX/yoBhOt+?=
 =?us-ascii?Q?qaS8xF21I7ShMemuQgU2COWQmrZk0BhySDqVK7wK0NtWmt70UpduUIO7SeGT?=
 =?us-ascii?Q?EgA88NH5F+J3hA5nF22Pl9eaGl/4V5ie8/Ousqr8vrVO5rRJbwTBgQN8wtI4?=
 =?us-ascii?Q?YhyJw5MB4ma+X1fkCIh8ojDcMzZqtKtd7Lf/IxxVnUD8ts3FKJ9F2BzqDXKn?=
 =?us-ascii?Q?IMM6QuSHf7/zqhA+GRLs8GO2cjShBEhzuz0cajyWsjDo0qsqhA0HCb+iC7A+?=
 =?us-ascii?Q?SMzKt+VUr0nJKfYiQjsZRObe2Qza0YMHN6+q+ByZ3ddeXFgfPT5ub7NjEmaj?=
 =?us-ascii?Q?rIi4yH+vCwr/ffBV6MYgrw9Wmp/maTqQZVuy0gSLDDGTkHciclNgaa015FRm?=
 =?us-ascii?Q?T9e8LDFQGgRQz6D+UAQKmxBdQ2jadnXNmQKPMJ2WROoiLnEXRugXIjcgdht5?=
 =?us-ascii?Q?1WMr2nUS7wsJNK0925q4nO8gA3guWw7lQWlhAD3SSqK1czPNl28fdPHV8uNI?=
 =?us-ascii?Q?q7EQbxXvJNCFFjG3NKW/QLTe67GnGpDzyJYaYUVpQJvRbEbknBvfsRZDWWgU?=
 =?us-ascii?Q?g+I7+rGvKVrDZGf8/vRtz1Rwm/iHZLpJg/R0YjPNjfmZHUMk6AeIASb/qKnF?=
 =?us-ascii?Q?ih8aOqyCc4kC6E75eqc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 205a3f5e-4b28-4425-488e-08ddd8fe4151
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 17:41:08.5440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nc1hpZZmTfAJPlA0i64NQ1N92oqZUcTN9ukDxU6NgqBSc6rYzyVV3nrd1iDhixvDaiRI80scdabw3SU1j5UW7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8648

[Public]

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Monday, August 11, 2025 10:13 PM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Cc: Gupta, Suraj <Suraj.Gupta2@amd.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; pabeni@redhat.com; Simek,
> Michal <michal.simek@amd.com>; sean.anderson@linux.dev;
> horms@kernel.org; netdev@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Katakam, Harini
> <harini.katakam@amd.com>
> Subject: Re: [PATCH net] net: xilinx: axienet: Increment Rx skb ring head
> pointer after BD is successfully allocated in dmaengine flow
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On Mon, 11 Aug 2025 15:55:02 +0000 Pandey, Radhey Shyam wrote:
> > > That wasn't my reading, maybe I misinterpreted the code.
> > >
> > > From what I could tell the driver tries to give one new buffer for
> > > each buffer completed. So it never tries to "catch up" on previously
> > > missed allocations. IOW say we have a queue with 16 indexes, after
> > > 16 failures (which may be spread out over
> > > time) the ring will be empty.
> >
> > Yes, IIRC there is 1:1 mapping for RX DMA callback and
> > axienet_rx_submit_desc(). In case there are failure in
> > axienet_rx_submit_desc() it is not able to reattempt in current
> > implementation. Theoretically there could be other error in
> > rx_submit_desc() (like dma_mapping/netdev
> > allocation)
> >
> > One thought is to have some flag/index to tell that it should be
> > reattempted in subsequent axienet_rx_submit_desc() ?
>
> Yes, some kind of counter of buffer that need to be allocated.
> The other problem to solve is when the buffers are completely depleted th=
ere
> will be no callback so no opportunity to refill.
> For drivers which refill from NAPI this is usually solved by periodically
> scheduling NAPI.
I think even after this same problem will exist in dmaengine flow because m=
ain problem here is axidma descriptor is freed after invoking callback. Cal=
lback (axienet_rx_cb()) will try to request new descriptor in rx_submit_des=
c(), but it won't be free till that time.
One possible solution I can think of is together with NAPI, having some DMA=
engine interface invoked by AXIDMA (similar to callback, say post_cb()) aft=
er freeing descriptor, which requests new descriptor from AXIDMA?


