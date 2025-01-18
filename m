Return-Path: <netdev+bounces-159506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A2DA15ABF
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 01:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4603E7A40DB
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 00:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9894DF59;
	Sat, 18 Jan 2025 00:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nmLPueqf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F58BA2D;
	Sat, 18 Jan 2025 00:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737161971; cv=fail; b=m+CuxNAgtPwY0cWMP17jAiUWSxNKLhrz+3Sd3zxZr3yhR/si6LB0FF0xegN4uLG2n4z7qob57MU4eu2ElR8LoyWEp7B2K5U7Ap9yh/XrxH1fGoowa3inbifW3383XyyGOuf8nKRK+O1fmtT+NeuCVsbRjWEjPxC05jbwx8P4vzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737161971; c=relaxed/simple;
	bh=oDumimlvHBC8RLSRpTqdLIMoXtKT3meuWEUj/bo7Yes=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sLgToyM3HbZ5l9gWplXVYUzIF35LpMRHnTCasW+tjei942sBi4OVy3W5YwplgjfOqP5gmJU7j2lHj4+6XdyXEnAhxWSoGWBJ+kTgEVe7OUlHbRRATyRDQ289NFkRsXgwinH40ZQpVQ3VnDqvjk/qsFKYTa/g/fW7xAcmfQufBvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nmLPueqf; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMB5uafbmi9SxUdPZmPExjOotS2kWKrNZR/+LiUbn1J/2WZ4ZCEauuLVHW9xvW6WRrLjdUc/NEdSeJBexp4hZCuDnovuVkmM3yG4JnwIXVsc7ETX90z9wzU8AqDBoh/yi0rZNz4Kj2rw4/5FokOiOb6uLrFaCLMvEhbRkoVH/cMEi+ntwPqSQP2jGwsBqzv/tNAWUaj7eXgwkMZL+l4lpdTmEEQkGgjF2Qsz3pMqT6JOqePZ1cW651ofGysj2PlJZAs4E4cbCObAIwAJGPkXTJ3fNgDTHwtGiay4quBiCnS0IGOOcVdbx8Aaw2Qcpkvy7+eL3Yjo2+plTZCZYcBtZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYaKDLSCiroWUGDJRz2KSQk69l5JdGfvrsyNBk4ojGE=;
 b=B5Igg2f946KRQ8z82CVpd9sHNQwJS71ov5IAzI6FEd8Tb8wGQEKbt+FAG3BqLkXlUDcYwuE0aV2kXYuBzelKWGPUC8J7ZDRo1x0nkTXNpRS9zQCkyfaaRsdlvRJVXyVZdSujgu4prTSgmtGeiJEupb6PR5YTyglL6b4ycxpnisMUDbgVmvFngIFefqZjRhMjfgqFzW/HUervW5xItNufyjzIc+aM5yS9r8RS8Cz0ymTX7zprDGf5fNjUIVdX2lXTF9NN7acI4WEY98TCYvNd3qHyhKsZFiikrTALKc1pDbs7uhAoRgCUsifS/cH9NqCio9sUCRM6jm3cZWL5DiMuVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYaKDLSCiroWUGDJRz2KSQk69l5JdGfvrsyNBk4ojGE=;
 b=nmLPueqfwYJ/GuNbajGq9fUE1aeCIm3iGjp/bG2MRxi3z+l2QQf89/LUdPj41ZaD8Yf5fXktUL578IsmLhB/OnWOzSgFYQ929RPS7av7JvIA4vQxun2A3r7kkPF/+K6jLVAnrYnswl9rrJdYtsy8pDtuWz+8D2yjTDLwP3Rc8Id95d3YFqAt07ZOuJBIF5pSfMM5l88vjNxAyJm9lpnnB81lb9CiJABLJRFcQlM26Y4kXiAVxn1C3P5AL2TFyejtjoyNnLtTk03ILoSD3h+0SepDV3SSF6Vs0tj1FBKsyzrE9df4pU/8KYbwPlBx5UKJr61b7zWiiF1eJsnwgT+7ig==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 DS0PR11MB7406.namprd11.prod.outlook.com (2603:10b6:8:136::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.17; Sat, 18 Jan 2025 00:59:25 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 00:59:25 +0000
From: <Tristram.Ha@microchip.com>
To: <andrew@lunn.ch>
CC: <maxime.chevallier@bootlin.com>, <olteanv@gmail.com>,
	<Woojung.Huh@microchip.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Topic: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Index: AQHbZi6jUsb5OQZHf0qguVy2R8e1urMWcOoAgAEuMACAAohtsIAA1aiAgAC9nfA=
Date: Sat, 18 Jan 2025 00:59:25 +0000
Message-ID:
 <DM3PR11MB873695894DC7B99A15357CCBECE52@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250114024704.36972-1-Tristram.Ha@microchip.com>
 <20250114160908.les2vsq42ivtrvqe@skbuf> <20250115111042.2bf22b61@fedora.home>
 <DM3PR11MB87361CADB3A3A26772B11EEEEC1B2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <91b52099-20de-4b6e-8b05-661e598a3ef3@lunn.ch>
In-Reply-To: <91b52099-20de-4b6e-8b05-661e598a3ef3@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|DS0PR11MB7406:EE_
x-ms-office365-filtering-correlation-id: 18bebd7e-f605-4345-8d23-08dd375b5a66
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2CkZ/VEVNNQjPZD8C6nQZw53xmnsuud8/rhtTpzNOy3IbdVP4pV3jIDN/R6g?=
 =?us-ascii?Q?6DBhCDwDQrVGgFKKRDs/hPIVMYFoT0Bf/iD3CSEZw/IXsf4A0kn/xXsuB8ie?=
 =?us-ascii?Q?hNbcEJofq+2EXyXKGSKIiMiPhUB/pSC568+2/UB944lZIuEqm2JStAmHF4x2?=
 =?us-ascii?Q?SOKqZKkcJnY9TCMQEMpHBh+2CSzjrLuRMIkt2MkXurLOnq6jsSROqldIMJYR?=
 =?us-ascii?Q?hIRy+LJeae2Iz3DKj6mlwm+jARPzJpPmDFyUMdhTPkfsmQPG71VXgR0ZTFCE?=
 =?us-ascii?Q?kndodhAJxNicUkqmRoTJo0k5rblV2jaIjeWTK+kkrLWh20IiiaCJgrC6zbZy?=
 =?us-ascii?Q?co2lrbs0gnQDvfl3dGS4hVshBCicqMox+tEKu+ILBs/C3aioNWQYZ5gB0mWJ?=
 =?us-ascii?Q?xP60Jn3YGwjqyr9ovI4DWWl51Ov0Z2H1X/mrhp3J/iGliDTGlEeBTcwmQg9T?=
 =?us-ascii?Q?DUegJ+FsC0a0Ail1RUxWDliFwgHVgT3RPQQcHbyneRXlGS+mak29eWrnZlvr?=
 =?us-ascii?Q?uxqmjoBSSR+sqGKFdLBT1TW013reUksPXyBaPxKbZG3WNJT4mbEP0OYGjQ5I?=
 =?us-ascii?Q?39ky8IsUn1uCn8VGUvAq8Iwzel+M1JHtJagLoE0KcDiyKUuJAlA153ezq4og?=
 =?us-ascii?Q?6ZgeaZB143vtm8Yif6iUpMkiYK4qpfG208VEm7NzDYXCfU7ueYXKwJZ8aJ8v?=
 =?us-ascii?Q?fNbTVVsjPwHKz8YXS4zV40vq/asJmM+xOfgvfHIZmEtHzhK4szLJ8O+PmVTi?=
 =?us-ascii?Q?wkii1/+ui8T1u2wtOF1kZz2BRlPUlDh725hQ0wzJJOKKkwV9qhVKpLZBCsKd?=
 =?us-ascii?Q?KAfsdppVh6ALmyduQtQ2PrlzoCEUD8kUAswsgYGiLrqC50gERzOdOGbS2hUq?=
 =?us-ascii?Q?sjjRzIU8Xb8HcIeJOa062Ztqx62mbXhH8dKSCNpR2R6uC1GLyqc6PjGvuTIx?=
 =?us-ascii?Q?OiOr2Lg3GtUsB+TYBMAO2FOhkzA/I1Yk8PE3AKYyFmZ+ruyo4OgOKKL2/o36?=
 =?us-ascii?Q?XYa11aO76QRCm0diL/ZHVeNjq2XYPJwOHZdo4YmPnCCsvMEPZri9egn1SHh0?=
 =?us-ascii?Q?DuIXDa3v+zvd/SDXPO21/WsclnXv2xMy4YxrdkoGgwdDas0Jp9WJO4K7d/6Z?=
 =?us-ascii?Q?93Su1V6DwfNwSxemvOyggeAHUTSkHr1SmBcULigkaQL3VS3h1vW5zQpLEDUg?=
 =?us-ascii?Q?9nGPjb3laCbi8BzNG4gvIzkSrjMrGyfVBLFDUFmio13S4jmONzaSMPKhTcEB?=
 =?us-ascii?Q?bFwxTR/dGTZJ7NfEei51UOFBAeELgNjzZdg3WZQU7GGVWvXL5AYffOXZkgYa?=
 =?us-ascii?Q?Xs1tEDVrxieqO8sKyFoyQIb0OjX2uuGDtKDGXFPgkysTXH0XSGCSYgxcfXqp?=
 =?us-ascii?Q?0seZubMM5EiTW+jBu8xx3SKT6uzQtlvbzwrazh5Nleq3H8ycd2L4WFH2XnrQ?=
 =?us-ascii?Q?JITARg6+5SSm5EEzVrV7tsNiDBdj1SGp?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gE77GulypW0uepl3mtqHBXy/baX8+K2UpH1Ryx6jjMBXtW5QMVmMJ6lqyWvs?=
 =?us-ascii?Q?/GEMMXi4Pbe3uuKR5M7Q9dWHvGa5+UJkz5igOsRTi2+0e0JJApEm6Evb5WZt?=
 =?us-ascii?Q?sy3LcqYFBKpZ1AxkSZshUQHqWQimehjdgu1jDQQEDwzNUtlkNDeC/ZSqo4a8?=
 =?us-ascii?Q?f2UY1G6edC5MpUdxsX3xH7SXo94S5r4aXxS6+Hz/LZfv06XlMsa3Mu+PJPSn?=
 =?us-ascii?Q?MBVBRCNXgEEbYdRiK0tMjk6Zncx+23jFSYMMIgBLfVz/yfA9/7mvQHtQVRt2?=
 =?us-ascii?Q?GksDj9bWX4+IbJltM7fCXvr1K6sKvkK/8k9wH32DS+7hBhW5kqeUk4N1Zdgl?=
 =?us-ascii?Q?Mf73stuvP9h1t4SB521LpoAS2gQKU+FrQq/OY5lkSloLCcQRkaXT28mD6Lma?=
 =?us-ascii?Q?qgslXiSSB8UkQqKOu3qE5xw6dOJyUzWAdLc92ELfZvHkFp+PHMQ6q7jt5Omy?=
 =?us-ascii?Q?n3X6/tmblZVpN9ECGJjBB/GZ9okymmo2TZS7hnb4MCYjzEgePFA4+LdWga96?=
 =?us-ascii?Q?YqMUe0GV4VEh5XPeMCjXg/UO5QsMebQW2vj0+ZaT4TFT7dqYbiq1elqqZPdO?=
 =?us-ascii?Q?7yCZcMQW4U5fnBPsD9M7QdrwmHkcW0AuzOS6oohqX1vM8+HosJooz8+jyHID?=
 =?us-ascii?Q?X033HWJRTQCX8esI5fthPbzA6qUxS4jn0d8aMKANhWVrMGRscpB4Vj2jJMJT?=
 =?us-ascii?Q?//i+vBxfGwABZTUAea/BezMjE9KOvBGfaiugKd/kUemvuh7LLuJtK40qmcfA?=
 =?us-ascii?Q?emgsW6ZMHaXMQYZASAosZYBvt6SVY4+q6PG0zf3XG/do8J7OgfTPvpB+HngP?=
 =?us-ascii?Q?NC9DQ0qE/TSN4UJXP6IHq7Npu4e/4sFbCl7bj4hocYl6YpZKflkAxY1G95Jw?=
 =?us-ascii?Q?ac+LsUJ6u1ufNeC7lG20+0zooOHb5hjlzEs8H8EXKPwTJ/9BC7UJ8g1U1yeR?=
 =?us-ascii?Q?Sn098kltylsFiKabBR9lZiclMz3aGelcXFbFTmdVMuClyBeMiV9Lkn48dY9c?=
 =?us-ascii?Q?kuzdeQlJ27NDeSerU2t8HFxpZk95l4ysIxIn2rsYqxZ0bJCAKDGG4phxMQme?=
 =?us-ascii?Q?DY3VI2DlU8+wN9CpE5yIwDTBDgM3uv+IPyVFiELx0/AKC3BvfOKU3tunht8i?=
 =?us-ascii?Q?2CEj7o6tsxJDvfELLGp44HHKsw9haj4VVVWZF5jtquK3cKxPapcPou0ZnGJZ?=
 =?us-ascii?Q?ZLz8fjJNX0dV/T4uktZOmUCzUaES/pha4GEXAolvQKtykRogsPl6WCnjiabt?=
 =?us-ascii?Q?5f0Tq1jBRGDkjE6VQ2AJvINxMkR5GMDmXZXwrvwOwV00raXXkwAU9Y59G4MD?=
 =?us-ascii?Q?YJYFLNB+Xany7OBlQvBRtBxKt/yy9vyMl8twBLYCTDi5AHes3ER/oWyC7Jco?=
 =?us-ascii?Q?8HZ9kE9/4xQ3PAEp6G3KqOON4X63Uxf+kUxkhESmBtHLQ7BUcVQZFxvtqss3?=
 =?us-ascii?Q?CE1glTQdfbxTZj6/ZwOOdluINhM+AiKaGL1Am9Krj47nfqehhLG9/jXOWJQ2?=
 =?us-ascii?Q?N1ILPtI0vRCZLb98SKQ5O9XEOWgImnlTqxzVaFff6FksaKuzboAMuubmEZHl?=
 =?us-ascii?Q?95+zGHXiY7wS8fvQfjkq2jVIoR1EgXkZOwzqdAIu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18bebd7e-f605-4345-8d23-08dd375b5a66
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2025 00:59:25.4424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PjS38iYXheHkuCT3Ukh+Luw23+fB1FtD/lPe1wHrDpyZKRF4Sb+S7ENs2aMg6YcS6KaKkOYo73+mFfVMFgVPkQD5v9AkYGYMvb7ayvCZj2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7406

> > The KSZ9477 SGMII module does use DesignWare IP, but its implementation
> > is probably too old as some registers do not match.
>=20
> Is there a revision value somewhere in the registers? Maybe the lower
> nibble of ID registers 2 and 3?
>=20

I am not aware of getting the version of the DesignWare IP to
differentiate different implementations.  I will find out from hardware
designers.

> > When using XPCS
> > driver link detection works but the SGMII port does not pass traffic fo=
r
> > some SFPs.  It is probably doable to update the XPCS driver to work in
> > KSZ9477, but there is no way to submit that patch as that may affect
> > other hardware implementation.
>=20
> We have PHY drivers which change their behaviour based on the
> revision. So it is possible. And XPCS is used quite a bit, so i don't
> think it will be an issue finding somebody to do some regression
> testing.
>=20
> Using a PCS driver is the correct way to go here. So either you need
> to copy/paste/edit the XPCS driver to create a version specific for
> you hardware, or you need to extend the XPCS driver so it supports
> your hardware.

Some of the register definitions are not present in the XPCS driver so I
need to add them.

Some register bits programmed by the XPCS driver do not have effect.

Actually KSZ9477 has a bug in SGMII implementation and needs a software
workaround.  I am not sure if the generic XCPS driver can cover that.


