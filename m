Return-Path: <netdev+bounces-155871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F3FA04235
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23FE33A0474
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372BB1F3D28;
	Tue,  7 Jan 2025 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hqTByWA+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79C01F131F
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259302; cv=fail; b=jr4IXGI+gtU6wz+SGQuwZ80gphicJlnOek838AXILFlOomEiv8hNg/kmd1oHleS3dHmesXOyIk+YOOL5+zjBSX/fkmd8qFuIs67LzfIRnGH/0snJXeeDRSaTb5C9NX1IQP62gW1keiprfTRBlDtjp2J4nYc11/rSwQeERDTYv7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259302; c=relaxed/simple;
	bh=HdZhItK/+ki2U5JA/cg78QLwR2Rh+u0qgp5tN8Z8Q+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G36hl2abksmDS09Ci0a9pgObEEYA+mgaDCMjswGhU2iaJJAfmAa5SOcXHAtMRUMJ8njq3sZiN6MUrihuKhXfVeRvDNantlVHnLGCHKRzEu24KtpC2J+8j+pnjyNhyrnK+V81lRvR6AGqCJVRuoWO55JJG6Ay0k3kqqRTdrLqDDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hqTByWA+; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUpNb8HvYPSnahUpuYLa0LSI1hU2asS0GPRykZSVyv2WiAYP9etF61iUQ9M0xxMcklfQGYfNEcwSFcdVKKyz+64wFFYN0E3nIGq2fteOAf04+0WWRtY4vZkFojKCFxBSEEuu5tzDPMUPXKZStiUy9LJMhPELDvxzTWEQG/t1o7s/1KbWfbRvRSuT4medCHptc9b/Gzvk2cD5lkGOF22Zgf7Pfk9qIK8ru7xlgVo8WrYwhYBETqXoHxHZe1ExnzO0O7zRt/XiAIAvTTWsnOR9USaXbebtmZD5vWxxb3WSc4rz94fmIeGe4CkdaT2JUmaR+Ncf1roD2KcsytrR/UcZ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aK+mr0hYhl8kiL9XxnxE9lTN+9aiRXOUDsunoTCtTo=;
 b=jD4yJCvB6KGqDTtnMhAnZc0aSaosf62wWy4P7ywxAUEhQVsFdquf/3lvJ0JaeQ8wbJ5ucRbYwSo5B/3kKA1qLfzHV34Y3EIfMIcptLGfQTfbPewTBYRkPOKrMC5w6zVn2qLTF3PDtSpvaVuVHEAk0aoeBfLc9WSeMl3tmaEFCj8UpliHL39LAM0kk5A/3vWmfJltdYs3GHu8ZxC91bysrydHC792Ota0RXIhdpAWUrzCSeDm5w/OBLxSgsK9Vc8cJYpylSejShgpL4C7e6z/nsfafRcT4vRtpkwlpwrCkSWblrY66phgVcQTJ3bEGW87X5t289MJ3gwB+yMY/EXRjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aK+mr0hYhl8kiL9XxnxE9lTN+9aiRXOUDsunoTCtTo=;
 b=hqTByWA+atwAKRRNdsUOMFn3Z3bP9hiEprkxGmIC/NvjtxM+cYdbdyU9wHqtk/VKKF0nbAYIJKdFiVPhIMq/fci0yQwvH9AESN4LbJwBBHeS1Kpn02dhe3+lg7DeN5DtmUAmo4vEGQMIsHhZKTQCZzDQIn+1vFGPOc9z6anPFRAp290hdctXJMMorDLTcUuHm2t0fqSdkJtiLIelMohw7xnsQVhpgYTVCbGWZSCychIgAfRZjp2MthlLCI4CMF2n6AKbBKrWEOLuy8gM4puD+6tka/wc6gGgoyRld3xmhVTKLeyd58sYlr38RIY0GxPlqPp9xWTM9we8GxWrqIFv0g==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by SA2PR11MB5179.namprd11.prod.outlook.com (2603:10b6:806:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.19; Tue, 7 Jan
 2025 14:14:56 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%6]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 14:14:56 +0000
From: <Woojung.Huh@microchip.com>
To: <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <Thangaraj.S@microchip.com>,
	<Rengarajan.S@microchip.com>
Subject: RE: [PATCH net 2/8] MAINTAINERS: mark Microchip LAN78xx as Orphan
Thread-Topic: [PATCH net 2/8] MAINTAINERS: mark Microchip LAN78xx as Orphan
Thread-Index: AQHbYFuyrVcAlX+vYkCLN6Uqrkp8arMLWwrw
Date: Tue, 7 Jan 2025 14:14:56 +0000
Message-ID:
 <BL0PR11MB29136D1F91BBC69E985BFBD6E7112@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20250106165404.1832481-1-kuba@kernel.org>
 <20250106165404.1832481-3-kuba@kernel.org>
In-Reply-To: <20250106165404.1832481-3-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|SA2PR11MB5179:EE_
x-ms-office365-filtering-correlation-id: a4670ef2-1014-4316-e45a-08dd2f25a99e
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EqeN7zxk1CqSA/AlYGNiUIMqUtRLkPVzqV2nX73cdlq1WZTiZ6h6VEq98A1X?=
 =?us-ascii?Q?mbJaTBNTT7UPvCMG4KUaRLrODJXxs4aW2AUQkF5SebsNZR8nZ5SgX6YM6x0b?=
 =?us-ascii?Q?XsQ0gLOCAg3O3sPnxMycPsZLWt6uYtegpdGWQUf613o1pVP2tAVeIYvbmLaF?=
 =?us-ascii?Q?Hy/58Sb+4+DfSyz+jlLDymn+81OgWeGJ6u/98BM9fZ50TPpu+5pxhTxqKot1?=
 =?us-ascii?Q?FD9KT8rVjFAUmOsRAOTgKRj8f1heZjGE7T+cNL7Y+CwxdT5jhbVH5nA0QFBq?=
 =?us-ascii?Q?yiTNHIlj4/zyHod8CmW60Sj3UDq6h427uTqWfBtx0KKH8aJIocdMeOe/8fgX?=
 =?us-ascii?Q?U1C2mZpWSfIuQfbNH/RKGSumJRwHq1j6nbSaibUfBUH7r3FWi1WCFk4DQCiG?=
 =?us-ascii?Q?AN53Rm3bwSGc+jZnylUoqkSY2ttrH886acZiqeQ67AZuCf6unQTGTKD0cIgu?=
 =?us-ascii?Q?OtFGA97uR6LX5Y1GNkkr3sG9AqrfTW9UK7ZiO440hRm3sCgCAJ9ynDL/CzWq?=
 =?us-ascii?Q?adciT800B9Kbbm4Rl0+dlBuiyvq8zLRMVIHs73U+Fx3Clp1BJzQfoRxIVfyP?=
 =?us-ascii?Q?bDwBv/WyqRZ1CiJfM8ic7Fmgy9+KbS2OfqqX1agHMxPXDmymGp/qb/nvdl30?=
 =?us-ascii?Q?Ajahkejb73TdfoxwsekKkSAZXLBzCLL0153A975Rt8wH36+BZdRCtpDSyeqL?=
 =?us-ascii?Q?rdGPUi/xA70z6ov4N9L0/bQ/p7WTk82Y61HQqjzOLYyVMsmY9XBaC7fjGyH3?=
 =?us-ascii?Q?uOkBji+ICjhxuLxDzWcv4u1owdUOl6ZdBS7au9E8jAb+SO/2uvUd6T02ay+T?=
 =?us-ascii?Q?0XF2QMSY9XypJHF27RUlFaSbKd11C9jmqIeQI0zGlUSDXiUwxiwoTjsWvQcS?=
 =?us-ascii?Q?t5GNiu6nWV8Pdl2A3U8MK3xnjeU2iUdJeB2+IaRhG7eMFMyaTYAcdWuqeHeP?=
 =?us-ascii?Q?MYafkAQ2esw+1tg0lyYdP10CfVIHGZBztmtQaCMvF/m7wele6M1dyPDxVnwc?=
 =?us-ascii?Q?qff2OwjMaFo9vFexfdoLdImGwwX8Yafmg0h76kRer/3/YTaCbsx/EnWxp7su?=
 =?us-ascii?Q?8+ZyHFTIN8V1XViEfmqJXTSgsLDiuIJhzff4rHWKWmY424joe6pMRn1v8L8J?=
 =?us-ascii?Q?VpZqnJSw6iVIzSBLT0z0XnAHn4IcnaQvj6B/vM6Omwc9Uc5jXhM04vYFU07m?=
 =?us-ascii?Q?ZxxDIK4YVyiemzFaPVBDmLdiR38zW60HHKYioSFO/4UENUjWAiqqLtvtkAaj?=
 =?us-ascii?Q?7Xytsk6o0O8we9c6faOTgnrRFvHIDNK64sU/FOrEgGZgfQVvl/CPvJeBzjm7?=
 =?us-ascii?Q?gDEdT7QcHltXIuVOJbO0jZYn0Ax814tME418UamxghLfeL39OFDOvkpNWLV1?=
 =?us-ascii?Q?nUSSuatnWYXLpEobKDrXTkcqBkqA+RGJ31AFRcnJoUkINZj3PWoRb367rc8V?=
 =?us-ascii?Q?9hcW2qhKK96fyH2Fznl3R0Bi9rqMYJq4?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Kh+86ZmJiEXPH/3WBqsBpwuC+7odW3mI9aWSePBRV8xJFaqfLnn+oxtFvDi+?=
 =?us-ascii?Q?zDDpfMark7gkf4WupCM9uhFmENV1dw3uDMSl4Rio7s1vJ5+hgSUzqAEaRmST?=
 =?us-ascii?Q?lqBrhXSx2RwJgFao20sxnWQBPEv2+YuIPEJfNBWDzT0eniAPmWkwzogEcsI/?=
 =?us-ascii?Q?e5TKyBwHjUEmRD9PGc23UrJ6yjpFSSlS5m9tFmTLU0alY8aSeRvP2OTA/rLz?=
 =?us-ascii?Q?Bblolz0pOhodgmTAeTD87NUIa7PuvNjb1r6KCP6BzMnbyaNbZyqO9/DQlyZ/?=
 =?us-ascii?Q?RNVhK7AMC1609QwQ5c80ixpMBZdgOBYgR96amVGq+VW8sWusbko3W7z2GaEI?=
 =?us-ascii?Q?M+5FbgX8tgCIQyRN5uxjmVnSMdduJn7bxNLFs/rEFOiHdo8nQuS30F2xvu0U?=
 =?us-ascii?Q?HzoBTLglXTuszh6iUg6AJw3eCkrDhO79I6+KWd8AYy3Uy/sthlT4RgiJMnQM?=
 =?us-ascii?Q?dH5QoOTdXrduEiccUyWmryD29BYH0YWsTSEz4MLq8F38Oum/wCtDW7R4DtIo?=
 =?us-ascii?Q?m8xjDnDQpx1P9OqrEOx3rxxP9rl3OzU1v2Nm5Qz8dyFRfs52oYso2mQaJCZk?=
 =?us-ascii?Q?VBcLaxXGHQB9EOBh7CwAf7Dfz+RGIIh+Njrgof8rTzukxIPwNyQAkgiqmuW3?=
 =?us-ascii?Q?ub5Z68bC6kMWeRhTYaMYyrVsHuOYal34uB+we+e2HIlgmjJvdeepTI4sS/Kx?=
 =?us-ascii?Q?ehAWDlyALjI2ZYpptS5dwz2BMiqLgV6WYE8Ob4X595I/mvDED5WFSIy+oEzz?=
 =?us-ascii?Q?tnUjTEmtj4wWJ5UR10XmrjC/ty3J6+zrBlEqMer4K6C+biLD8S0xVlHyM44l?=
 =?us-ascii?Q?Lo8KtwqVyzuZlvBXKFHIl8MQsP8LixAxQ4AKvyRIWJaN4yzwHJ83skC8JbkF?=
 =?us-ascii?Q?9uynungwos1V5CY5cl1HjI2+ao8KTgjEHq0Q/xwnRPzGerSxSZdNjE7p3g9w?=
 =?us-ascii?Q?bOcqeNkv4aSdv/UbJJpnzW9IRgdiY0/7ryX9iCH3urJDCydQ1BJ0qV0tSKgz?=
 =?us-ascii?Q?fyg2RC5K7mEU6WzOjLKO1N1MtvkZwg3n0HyqIryRcpsWXt1DncYlFmzeF3WB?=
 =?us-ascii?Q?YtMQVkPmw+9on/Ltmk2EMk/fmURcgisnlEo3V/mV28AP8twifrpe5vS4o1jC?=
 =?us-ascii?Q?pAkGoUmjJ24B+jHwv37ZlqtOCd1SilI+LXcD5TS3LTzVFt/0D+JNYpW07TyN?=
 =?us-ascii?Q?EjujA10vkCHweNZV8UCm9L3TrNH8Vpvni6pngfYQN4VPLRFJZNVCl79iiU0F?=
 =?us-ascii?Q?mOgkcQ7QCmgAsGHxYurER4zgt8b4oHyp2bPF4jSOobvOAUTVFrx4RUdskzyW?=
 =?us-ascii?Q?InnNj6AvRKbC6Bd3+PJMqQxwWS7RXou+ayrMMNjJmUZl2fjNVUEKAmzI2osh?=
 =?us-ascii?Q?iwziL+UgjyNxhZjPxYcYFV8YRx9O+1OKG9ivK41D8dr3HfIqTU+474oNG7JJ?=
 =?us-ascii?Q?6pdbD1T3eWZb1TcmZpI3F4ivE4XWuGd7a37BOy41tLm/a++CT8Vvr59Vxl9L?=
 =?us-ascii?Q?hKkGTQnLwAmAufxuR/ENCBJm56THXd0axZ+95jtfKGKMTFlEPHigA28pHPND?=
 =?us-ascii?Q?Pzk0tQKrANBxpOoDUEw6QzSnCnoAhAsvB+jHZymp?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4670ef2-1014-4316-e45a-08dd2f25a99e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 14:14:56.2477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5XAm/4n99WIWHOzWbw1u+rwC1xQeb5Z3xldkuHgmWYmFwrDo/c3PvkBSqjCN9BYbERMNnFoLqwhkoZ9IamCnqZ4bMNbvl2is00yXsADY5WA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5179

HI Jakub,

I have no complaint about removing my name from the maintainer. :)

One question is replacing to another person in Microchip.
Let this patch go through and create a new patch to add maintainers?

Surely, they should involve more on patches and earn credits, but
Thangaraj Samynathan <Thangaraj.S@microchip.com> and=20
Rengarajan S <Rengarajan.S@microchip.com> are going to take care LAN78xx
from Microchip.

Best regards,
Woojung

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Monday, January 6, 2025 11:54 AM
> To: davem@davemloft.net
> Cc: netdev@vger.kernel.org; edumazet@google.com; pabeni@redhat.com;
> andrew+netdev@lunn.ch; Jakub Kicinski <kuba@kernel.org>; Woojung Huh -
> C21699 <Woojung.Huh@microchip.com>
> Subject: [PATCH net 2/8] MAINTAINERS: mark Microchip LAN78xx as Orphan
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Woojung Huh seems to have only replied to the list 35 times
> in the last 5 years, and didn't provide any reviews in 3 years.
> The LAN78XX driver has seen quite a bit of activity lately.
>=20
> gitdm missingmaints says:
>=20
> Subsystem USB LAN78XX ETHERNET DRIVER
>   Changes 35 / 91 (38%)
>   (No activity)
>   Top reviewers:
>     [23]: andrew@lunn.ch
>     [3]: horms@kernel.org
>     [2]: mateusz.polchlopek@intel.com
>   INACTIVE MAINTAINER Woojung Huh <woojung.huh@microchip.com>
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: woojung.huh@microchip.com
> ---
>  CREDITS     | 4 ++++
>  MAINTAINERS | 4 +---
>  2 files changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/CREDITS b/CREDITS
> index 2a5f5f49269f..7a5332907ef0 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -1816,6 +1816,10 @@ D: Author/maintainer of most DRM drivers (especial=
ly
> ATI, MGA)
>  D: Core DRM templates, general DRM and 3D-related hacking
>  S: No fixed address
>=20
> +N: Woojung Huh
> +E: woojung.huh@microchip.com
> +D: Microchip LAN78XX USB Ethernet driver
> +
>  N: Kenn Humborg
>  E: kenn@wombat.ie
>  D: Mods to loop device to support sparse backing files
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 188c08cd16de..91b72e8d8661 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24261,10 +24261,8 @@ F:
> Documentation/devicetree/bindings/usb/nxp,isp1760.yaml
>  F:     drivers/usb/isp1760/*
>=20
>  USB LAN78XX ETHERNET DRIVER
> -M:     Woojung Huh <woojung.huh@microchip.com>
> -M:     UNGLinuxDriver@microchip.com
>  L:     netdev@vger.kernel.org
> -S:     Maintained
> +S:     Orphan
>  F:     Documentation/devicetree/bindings/net/microchip,lan78xx.txt
>  F:     drivers/net/usb/lan78xx.*
>  F:     include/dt-bindings/net/microchip-lan78xx.h
> --
> 2.47.1
>=20


