Return-Path: <netdev+bounces-102685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8259F904434
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 21:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0AD1C22D3D
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 19:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC360770F2;
	Tue, 11 Jun 2024 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0tv/2OfX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12279475;
	Tue, 11 Jun 2024 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718132736; cv=fail; b=XhU1DS3wUty6rvVi2YHDpbtz9asCmTepGSOArVSVqiWaCkLvTUFqusEJAORJ8aKpqlVWQOxG4YNpuQwgunIRd1C0QlIrYkh4egeTDXZ6MT4AY116+DEozKuAHVbBMidVbjJpzj/FZxo8dvkwZg54OE2BXNMjjWO8+97xv8pJ9TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718132736; c=relaxed/simple;
	bh=yFS299BpWTrq7VxH+yfpgNy01OJzUcYE8u+itAWt1Vg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vsm4aZZrRzv2FQFLtEE7MC4oi2QkIBCILGX9AN1toiYcZffwdUhmHhp+N5HLgkwJcXrBUd4ZMEWkwvn/sDHg0Yl8XZHwxD823/Bw8+zDpU/NcwjmO6UWuyfUbMQ5vORAihT65xuRAj4CO0R0lfow/d2MXRFXD5bCJFYmT0XHld0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0tv/2OfX; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGS96BfoQBPtyPfLagnlJYNLhvc4eZQhie+iQqdYakKdYDK4Jg6/GcDrrGA/fF+MkHVNwImcJgY8YdrNhruZ1gUCS0jh0jXSUBlEiQRk/iEvulEryYmgBOnwLmK8WASMJy/NcLPZsoi1OEHWOSJeBDTCEqxysv6wd6SniRmTbEe3sransmPuYlflC6Fbr10md/I+dFtm8ZYug151tX4wrRvlekBvJ1OLYmN91mIFWbyj+Op2eklDbjW4RHG/DEspztKseGQNMPRq2WwEpHKSgUVNmzcmHjMcWhfgprztTf0P6Bg6epAPraDkReV44Hx0XGWmj2TYv9u7gCuW3w5jrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wb2Gp+K1p0ZfxatNUEE5L0dfcGJx5rQSMJT2kMt1NbM=;
 b=D2mwvl6ySm+RxGCVFhi6NDxaeSwr6E636qB7KjTJ3ZlrObLzNmb8Ru4Pew3XmVLd2U6mspjO0Taeswx7wCYDb92E11YWr7rn9+/YNsuEUVmmfGqOTto4sEyzW15BzcN9SCe8+vwYCk8Eyr8xztRw/FdsdWkz8qo1GXa888PxZjLEBr0C60eU4aY++1iGLTXmfXe3AGDzcBXZ08RwuTLIiDTPPFZ59LWStqQgjpCMi43HaZv8NQkXWOSLnKkap5xTSgPZm35DkTtQzQkQU5PRq+UAZoPzkY9ZClgWU2UNO0Nqt7a/zqoNBRZtm4YeE1NRbIJgPf+5fXyMPb+48blWUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wb2Gp+K1p0ZfxatNUEE5L0dfcGJx5rQSMJT2kMt1NbM=;
 b=0tv/2OfXeHL5wReWzDfaXkPWO7m7Aat4iZaKHXQYqmMj/lgIQP5JJUY8yfii3BM8YMoUeDdTasZPKNdEkOfDKFsbw0Fc30gfffv3VnqPyJqwGU8LUNUxhoDLvaRSlEjbgUUebivUeXDoZk+e1A1vMqk2QcU6fWK3N7eJFZ9ztpc=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 19:05:30 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 19:05:30 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, "Simek,
 Michal" <michal.simek@amd.com>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, "David S . Miller" <davem@davemloft.net>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH net-next v2] net: xilinx: axienet: Use NL_SET_ERR_MSG
 instead of netdev_err
Thread-Topic: [PATCH net-next v2] net: xilinx: axienet: Use NL_SET_ERR_MSG
 instead of netdev_err
Thread-Index: AQHavBXdRESnBvzehE+BJnQF69x8abHC7D9w
Date: Tue, 11 Jun 2024 19:05:30 +0000
Message-ID:
 <MN0PR12MB5953B7A04D4B9C9D92D210B8B7C72@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20240611154116.2643662-1-sean.anderson@linux.dev>
In-Reply-To: <20240611154116.2643662-1-sean.anderson@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|DM6PR12MB4402:EE_
x-ms-office365-filtering-correlation-id: 69f548d8-91eb-416d-6d54-08dc8a497655
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230032|1800799016|366008|376006|7416006|38070700010;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VbTDe4Rl1uBZRDCORly4KeiOFYTFYZCNO/4B0tFxb4c2jJQryCb/C4WYBg+j?=
 =?us-ascii?Q?gJMlZfIw8AqdOVYw6VcxS0Fo6PgEtOxkMpBqYCRCrtutaZxbDAKFDHw2pjeU?=
 =?us-ascii?Q?+4HM/WsA5b/nUYvImqZUXG6XR04sqC7Lkaz8QT2DPooW8KFl7gXJcdpQZLxg?=
 =?us-ascii?Q?S3KFlAF+Wec5FICq3k0QN5o9IN29NIQiwkFn0AOuVinjv331vszEDGkuDPYE?=
 =?us-ascii?Q?JT4UY1Vb0YjcmPov6t2z+RQRV0kU023mYtEBP76XZ4ZlCctetudu5mo4vZhc?=
 =?us-ascii?Q?4yYbvj8xl8uLn88OywTh5KVzo7eFinAGZ/Q5H2rsb8FiilqZzZe1B8tayX8o?=
 =?us-ascii?Q?CnRehUfl7MMVlAaK15fGxQm5VmI7xWe8XkSGcJ8Molw8pp/a4MSyqun5uY2Q?=
 =?us-ascii?Q?4eRJHQfMzO2pHxD7DaJBKuw+FC8Cyjli+XBDkhzSTavU17BD8aOkiyUrR4Ab?=
 =?us-ascii?Q?W9sI1pjV2lwAo9g+QC1D1HOQ5+Xunxy/DzEH8Jv8rATnnUc5premeijtNKh6?=
 =?us-ascii?Q?Q/URCUKNk1FXPyoHih72KG5H/V60IIkTLErHlvomfNFFI1iOU1vIpDruZKpd?=
 =?us-ascii?Q?Tt9hcuirk9dL99aMAZJNbMXXqW2p/mQTEXVP9Ucu8xmrGqPtIxy403uGpO76?=
 =?us-ascii?Q?P9gdtm9H6+Sh9YW5zQ/62ZDb8A4tUFlOv6VUIiUvF7GsMRMuzFdTiCdCaHmY?=
 =?us-ascii?Q?cAX7XDuMADVfHrYWGBf4gjFKgqZDbWp0sysI/Ik1iQN+ityXfxXIGKnJJOeI?=
 =?us-ascii?Q?NsZc3jvNBtWiSU82nJ3c6G8iACyHrLm19GskVQmy+jrKM0iioqhhGP43rF7A?=
 =?us-ascii?Q?AO4ki5q/tYIUw80iQAxncMZ8j7bDhHFZRlwphNJg64GrDgpMAUS5XVfdNMDs?=
 =?us-ascii?Q?2okmsZC2762ki+rzbOTiMLUEWsheptMkEVDb1WWoc1zrWkhI4Ox9068+oWHu?=
 =?us-ascii?Q?BoEdu6g41PVuYn97zABvijDDw/vDwt32EXJCQ6Sij/5uXN3GdCwHieg67O0x?=
 =?us-ascii?Q?KqwrGJL9d3D7iYzhhTCvekvVF409PszgCd8rK/Or04YyVeDf2Nc1JOVF1+Xy?=
 =?us-ascii?Q?fP7JorFMfWIFSkmlDFF5pi7qpQ6qgaMabCPw/zKfSd9KMK99+52qBN+lbCv5?=
 =?us-ascii?Q?p/Lbqk8wqa5x3yMwDSYSJd+Bv7nYhAhY9rTIiJlUrxmYbfVxq/yZd26iA9fX?=
 =?us-ascii?Q?DFSYnBRLgJcy9FEH/6I20YCGTGLaQes9kI3v4YQs5grtiB7mO9RyHdyvL0Fv?=
 =?us-ascii?Q?vEPlY0Ldi0pIhAk11gfBF+uCFJ1x/L0F5/AtZA3HLv0Rxsbh4JQQ6MhOzhTO?=
 =?us-ascii?Q?cHxx88DIAgsu4JIMSRcs4AjdtXUUWW0uCa8l9TyQoWuWa54+dPZHiqS6y19A?=
 =?us-ascii?Q?UWwyVeo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006)(7416006)(38070700010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yohdquRueKuwiFue0oLCxrR1jJDWwWDpmkeDHHD/K5ICeOrGcmwYkxDHB0d9?=
 =?us-ascii?Q?VJNdbnqGTrmeUPRyWkgKu2XLNxJ109Wn7tQtHv1Wdgtzds0kHuqNki76v7uc?=
 =?us-ascii?Q?zfu5kO83EWbbdVLMZPm706VdGHrNM4uM/OlDVw7+JG6Xz1n02AzmuhXSh68g?=
 =?us-ascii?Q?l7rr1BK2L4LoXLck09qgWHWX2DGb7kAfpKG1opL/ukZuV0xou9ktKSu4ZAm9?=
 =?us-ascii?Q?IS1EyrmgnOLpc9ftHDRDYEmI0CYFGKZ1+1tTI3qtvPBhtuZkzPEVJO3mLgyL?=
 =?us-ascii?Q?4nMlLwmnomVb825LXSRBRPHkXh7NPnHgUQeIbNtt0k+/8IJi1VSxfdFo/yrb?=
 =?us-ascii?Q?WIl0NJDV6Ak4yZldZ5Xmek08talHEllVe5C7XAukARL68qjdmBXFerUR/7lR?=
 =?us-ascii?Q?ic6InRBqLfMgfxGYOT9GoZDoq2jUsBHnatYsdJEwefb6JA71bUbVx5m6BIsT?=
 =?us-ascii?Q?Jq3J9U+qbnhZkRg9kFknYf4IM8T2auFQAQqX0+dvht14YYIKw56DmlGlm48H?=
 =?us-ascii?Q?O8FibZj68cOxEWB0ICp5pRCkRz2xub/p50ZFHZOrEKVaaH/vo+3ETUteA48T?=
 =?us-ascii?Q?OE9eqCoFCMhIcJRO5gI92YR+OaRT+h4RkNJ3RaRsZjuFrPn0JqRedIF24HlF?=
 =?us-ascii?Q?XCialtSXOv5PrKuzZ/zn7MBfCtVLacEebhCmnjvUpxizYm3iZppTFXgSxOBJ?=
 =?us-ascii?Q?w4oNt6sOEr69Uk4ifObjcU8CKRbyiZSWExOGxpRvd9ynhLdnSvfNkB+8K9A7?=
 =?us-ascii?Q?ENhtlycGGGRW35mUBMDRPiYbLo0GOixNq8A6TC4nREI/FKDNQ2VMkoiSWy32?=
 =?us-ascii?Q?tQXqhktf+kzb3w9hcGdQx2Dcdqyt7CJRI2POrVSJ5bXyq7zpp8K1X0dTZCup?=
 =?us-ascii?Q?1iOxIESckNa+YNzjJ5yRDeBsRXbXplb4AQ2tCuILxwRDttdQdoeCTSWSyc9/?=
 =?us-ascii?Q?W5lYdFNLNV/DQBck4j1xk9sMwhYn1y7SrbzEJThuV71ZdXzmR+nnfQInAwnn?=
 =?us-ascii?Q?h9ey44ejzY9ZTpa/UW9uC7Fn3GSuTCNtGyPbV2LvRl0UX8QlHXynonGE7rM5?=
 =?us-ascii?Q?550eF0xhhSNJYFgkKF/I1Bmfa45mzBeWnwO5LLtiAK1uOAeb1nOiA62ccwtN?=
 =?us-ascii?Q?jhna3KZTpclRtEQ6c+yL4U7rnxsqhMEMHE0PzRCeRdTnQVPUPsBdVRmLWRiU?=
 =?us-ascii?Q?Ey9hLJsaX9+Ba/F4F2F1V8MEFFJCorE1coqF4FPf07SYrxd1pd1b3Pdf3xZs?=
 =?us-ascii?Q?AFLyYhNG5BMH7/dpsdwktDwcyivTJQPRSM7FMMe/KVkmgDcr8hBkM5FfBQE/?=
 =?us-ascii?Q?biTL26FLCkOVzuqnbhdGRYOE/Xe0lpOZAw5cxDe9rxYuqV+I0/Sp3CTeDDbg?=
 =?us-ascii?Q?ZjEmf2NrAoOA2431cQ1ljej/Xf9bYG0iYkeQEubxjYJIFZ4153hm65WvD55k?=
 =?us-ascii?Q?4WnMXVaebH2amHBPJgF1dfhbbV8+MOMeRk17YvHCzaV94Y2H6AgA+ZgYjBON?=
 =?us-ascii?Q?vr15zLK1z9KbzMTahtuM1LFjO18SxCYzG1c8yH9cODKFsy59Aro0dc88kEt0?=
 =?us-ascii?Q?6qgtk9FAAD53qDAHF2g=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f548d8-91eb-416d-6d54-08dc8a497655
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 19:05:30.2112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X2DAX+3gWFv9oL8jWGJWAcRmWX+oTvNpMuZDG43VoFZqfSM+x6eOm6+QroEaSNzc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402

> -----Original Message-----
> From: Sean Anderson <sean.anderson@linux.dev>
> Sent: Tuesday, June 11, 2024 9:11 PM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; Andrew
> Lunn <andrew@lunn.ch>; netdev@vger.kernel.org
> Cc: Jakub Kicinski <kuba@kernel.org>; linux-kernel@vger.kernel.org; Russe=
ll
> King <linux@armlinux.org.uk>; Simek, Michal <michal.simek@amd.com>;
> Paolo Abeni <pabeni@redhat.com>; Eric Dumazet <edumazet@google.com>;
> David S . Miller <davem@davemloft.net>; linux-arm-
> kernel@lists.infradead.org; Sean Anderson <sean.anderson@linux.dev>
> Subject: [PATCH net-next v2] net: xilinx: axienet: Use NL_SET_ERR_MSG
> instead of netdev_err
>=20
> This error message can be triggered by userspace. Use NL_SET_ERR_MSG so
> the message is returned to the user and to avoid polluting the kernel
> logs. Additionally, change the return value from EFAULT to EBUSY to
> better reflect the error (which has nothing to do with addressing).
>=20
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!
> ---
>=20
> Changes in v2:
> - Split off from stats series
> - Document return value change
>=20
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index c29809cd9201..5f98daa5b341 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -1945,9 +1945,9 @@ axienet_ethtools_set_coalesce(struct net_device
> *ndev,
>  	struct axienet_local *lp =3D netdev_priv(ndev);
>=20
>  	if (netif_running(ndev)) {
> -		netdev_err(ndev,
> -			   "Please stop netif before applying
> configuration\n");
> -		return -EFAULT;
> +		NL_SET_ERR_MSG(extack,
> +			       "Please stop netif before applying
> configuration");
> +		return -EBUSY;
>  	}
>=20
>  	if (ecoalesce->rx_max_coalesced_frames)
> --
> 2.35.1.1320.gc452695387.dirty


