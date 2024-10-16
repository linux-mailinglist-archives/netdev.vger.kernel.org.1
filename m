Return-Path: <netdev+bounces-136120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA259A063D
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D4AEB21E16
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB17220605B;
	Wed, 16 Oct 2024 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stwmm.onmicrosoft.com header.i=@stwmm.onmicrosoft.com header.b="QrROXuJg"
X-Original-To: netdev@vger.kernel.org
Received: from mail.sensor-technik.de (mail.sensor-technik.de [80.150.181.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0293518CC02;
	Wed, 16 Oct 2024 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=80.150.181.156
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072692; cv=fail; b=uEwVvG7SXm5XYx7y5ehH+OuuiGeQO5M6RINA8+Thd8bjGgfjZzdO5Ena6saJgZYGLzljEl+Z9nMhhf3izTELx6Uzvzlwl2tN44YNehprX2ljsUZM6ephQ5QN1UyUqvqCeWXeiC1GDk0hNaziOgi0YgmTnbvacHIrgmSf2ghZlMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072692; c=relaxed/simple;
	bh=yDinozNRTKwhZ8gNeeFGoSYDNYuKXrIzt2vfaP6ALy4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=frMMaCw5BQxuILxX2VgXoffYsKrhcWlH8CpfwUz8nwLsD+2hhTo3AeRBwqFOss2uSt/35U2w59RN7p6ufkCvohgkLAVD9iQf8vV6igfZJt85KZuxGG1ZJmEFeCeo1ID6P3nFvICI36y/VneNvyQcfj6unv+GrnXpwy7VsRVoWxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiedemann-group.com; spf=pass smtp.mailfrom=wiedemann-group.com; dkim=pass (1024-bit key) header.d=stwmm.onmicrosoft.com header.i=@stwmm.onmicrosoft.com header.b=QrROXuJg; arc=fail smtp.client-ip=80.150.181.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiedemann-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiedemann-group.com
X-CSE-ConnectionGUID: pqTjW6zFTs6mKPQuT9zEUw==
X-CSE-MsgGUID: zkZuDNn8TTC/aoVpPappcQ==
Received: from stwz1.stww2k.local (HELO stwz1.wiedemann-group.com) ([172.25.209.3])
  by mail.sensor-technik.de with ESMTP; 16 Oct 2024 11:56:54 +0200
Received: from stwz1.stww2k.local (localhost [127.0.0.1])
	by stwz1.wiedemann-group.com (Postfix) with ESMTP id 73580B5A87;
	Wed, 16 Oct 2024 11:56:54 +0200 (CEST)
Received: from mail.wiedemann-group.com (stwexm.stww2k.local [172.25.2.110])
	by stwz1.wiedemann-group.com (Postfix) with ESMTP id 2725AB5A86;
	Wed, 16 Oct 2024 11:56:42 +0200 (CEST)
Received: from stwexm.stww2k.local (172.25.2.110) by stwexm.stww2k.local
 (172.25.2.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 16 Oct
 2024 11:56:42 +0200
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (104.47.11.49) by
 stwexm.stww2k.local (172.25.2.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37 via Frontend Transport; Wed, 16 Oct 2024 11:56:41 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnaHnkiOPPkdzO+fHy6S/3yWMi/kqD4A0AhwBAKRywr0rNPmxmctmwMRQ/yEdMF19lvYtPGxUrgjlwVgXVdjyUsjuYMsB2Pk85HW3pcbwf0bahmvtaR0iOnedOzgxtWkPC5xbjZEH6sQkySWuKHp62gps+/hfuGcBbCOv3w76U10ViVMr5x+z0OR5WNPSVpKzmTk2wcEWRFH/HwergKgd68GS2fpPOFrg2WsVVb8/J7g0DSnPV6nekwdMvorxwmL2RAAsth5yscMU8l3/xoxhykvL/p4ImXKtSo0m1/+nCwJI8Qj3oGhd3AYpCxP+ThRKG/m5H8LGxd5nLbJrfIoTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+91GzFEWrtbX2iXu/XjcBy6Kd+hlnhvBkiEJG7tI00=;
 b=dwZ24xGGwcKhDWujfdoCFjdoJub0UYTtEybFigacZBCbJMmlA81KVH8xrTbYJBfZwRzvJ8eWQelX2BbKN2qddV2ZVPQtHE5Sp42E8eo0qIRLWGHYSchP4fcxKwe+FgwfWV7MoNHWx2xnT7nFjFBl4NwEuqx/cWfA+NkE3DeLtKOQ5n74OgU3cSPKXof/zHaw5MYGlcfOS1x1iy8xv2UGYdzHP2Ht77lbYLOsN3d6RNBcKVCpXslbmMk/2tvbS/jJRbjg5a4MX5ymgUWoFdiq8Mo7/EWxHpbj137IiFeNgSldfmBKzSgg5i4Sq9bvN1Suygvu9WtywxaDUfNTtHHqAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiedemann-group.com; dmarc=pass action=none
 header.from=wiedemann-group.com; dkim=pass header.d=wiedemann-group.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwmm.onmicrosoft.com;
 s=selector1-stwmm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+91GzFEWrtbX2iXu/XjcBy6Kd+hlnhvBkiEJG7tI00=;
 b=QrROXuJgScgsm5OHE73Cj9cA7c7FCp5GGla7ikyTUmjmVKilm8HOAs2ZCOXthYLe6VkepAX8AB7w8CeOFjBG4/0ewG+fSRZNFq6ulCZJcvGTlyPzYJLG64c6r3T1m8Xz30D6SBRHU9w+ieNb/Kt/ec9R8Hl0mIK6FgALJHFjNzI=
Received: from AS1P250MB0608.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:48d::22)
 by AS8P250MB0070.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:37d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 09:56:34 +0000
Received: from AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
 ([fe80::b4a:3a:227e:8da2]) by AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
 ([fe80::b4a:3a:227e:8da2%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 09:56:34 +0000
From: Michel Alex <Alex.Michel@wiedemann-group.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Michel Alex <Alex.Michel@wiedemann-group.com>, Waibel Georg
	<Georg.Waibel@wiedemann-group.com>, Appelt Andreas
	<Andreas.Appelt@wiedemann-group.com>, Russell King <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: net: phy: dp83822: Fix reset pin definitions
Thread-Topic: net: phy: dp83822: Fix reset pin definitions
Thread-Index: AdsfrkeuGN1t4G4rQ5uDp9cO4ywjXA==
Date: Wed, 16 Oct 2024 09:56:34 +0000
Message-ID: <AS1P250MB060858238D6D869D2E063282A9462@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiedemann-group.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1P250MB0608:EE_|AS8P250MB0070:EE_
x-ms-office365-filtering-correlation-id: 3d2071b8-75cf-4077-9e53-08dcedc8d1bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?PTv/8gtEwDSwG7FQsopWY0ZySbhVEBF4zb5aGelAipUmaKPDa/JYj7BGN+mU?=
 =?us-ascii?Q?AxlC0ppgmwJkrlY93DHEX3BweIIM86bZ/C5kB9skEd3CkcQM4fu4Hlf+4DKb?=
 =?us-ascii?Q?aOyRDRW+47eW/Usa82lN73QJGImF/qhPeNeKvHx3p2PSBpsCXKzfbQ4Q8lNR?=
 =?us-ascii?Q?V6cl3Jx4PuctDnPKAFjLxO37Ri8ZQAlFR/xnObcSti/g1ehbuh64Vqnwm5dO?=
 =?us-ascii?Q?bt1p6Oa5SuArOc5V4tnT6wosR4SKwK0aYuTAGK3TGJ8O7Mgj/wlASWuFaaW+?=
 =?us-ascii?Q?u2+PpxoghV4i+lBZFEU81OalqPugi8t+9XubfFd9bk8eqdK2pABtzdMPojUF?=
 =?us-ascii?Q?b06TMaOPURnijzC8bhaXoTZjH2LDVyrdwVoVFG/gEsINeV4iNsIRLcEHMHxB?=
 =?us-ascii?Q?cHw1bh4i7JDGWreZkv2tmlxiEUunuWAmA8RrSiC6l0jdNCbuCmqHYsW+YPOr?=
 =?us-ascii?Q?kvp8fb5NWfpaY+Wh30QkrpwjWy5490CLdibL+RLhjmflLi714olkCravTiXU?=
 =?us-ascii?Q?b57GfhV/xrt5aR4Y3Orp/QK253QcwKmHobroJJ4u0xelNxnVG9+ffaCScgB2?=
 =?us-ascii?Q?RXPMKvO45llCfGK46kIGRPu8M7R7UwjFvv6Gx/9mBBiZ9YQS+O6JjLHlCodw?=
 =?us-ascii?Q?7NNrqjcjfVCoOOmEesa5fIxHcGeQifdqVa3UwKz7DSSvbvU8PZ/zFHQvU2D+?=
 =?us-ascii?Q?lnm0xc24Q3FACFz/wg1CyyhGpToATuVFLWrt+UbE8BlgaR4CAGAR6SEmg2WZ?=
 =?us-ascii?Q?vggEqNS9/MKC/djRFU/Uo80DBhrYGtcVnx5pjDYTv/ZsWcOfXFQIfo1FCG0T?=
 =?us-ascii?Q?/dFGDUc5IgKcW2Rs6ULF8mY2P9QYGWh4h9z+ZioynPXJY9mV9JKSbi3XaAky?=
 =?us-ascii?Q?uSdIy/JDtQtuxTENGUdN9kbyMNkeZtmPwdyFWQylzzZGlcwnbtiy0gqwB9c3?=
 =?us-ascii?Q?Yq00OcAweAFS/uofLPCPDZ9pLwuP3jUmacLlgSyIjTds7WYU4p+0GJzSoJZs?=
 =?us-ascii?Q?zkNjFxsuezKOPEDYU0V6t8FwELFe3dusZ4COfA6S5yoaKtYtk52FxbLJ9b8m?=
 =?us-ascii?Q?NcKRDjg/RrShL9Tw/sv1fP7K9AtdTTZui8hEyy47e9uXtdKpYZgUkjM0t0Eo?=
 =?us-ascii?Q?8EjVOtOqodL/qsMVqWZF/GTmB611ILJ+b1KC3Cto3iVnxC2E0dzx+YFdbYPX?=
 =?us-ascii?Q?90xT6VRdcoQl/Q6MVGxGao/f+iqNSEzLLak3BvEc/Ty/1tPkawUTiTePqSc2?=
 =?us-ascii?Q?yMfGl1pb3MYb2kucxjSVOkWqnTaNLCVlr6hWVLUEYScLP+SXyW61fqW78YwP?=
 =?us-ascii?Q?Ip1U5m6K6QJGTvcJxbn1t9GK1MDHm6nCYXw7BxWbW6FUNg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1P250MB0608.EURP250.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rGep9pKvoYRYC3idGiik/SgzznAtWR5+rah6aZd/DkuszLp27HyKhpJjxUV5?=
 =?us-ascii?Q?j5f7aEhcuoTe09bct4BJE8ZKFBwWYbLQQ4HSw/KE8RXjw+3VeNYQRcbz/CoW?=
 =?us-ascii?Q?422TRXQKHh20rQe9xq3qvP6SYCipFE8u3OaJc31kjy1kfjOsAVvxHQOH3mvX?=
 =?us-ascii?Q?d8I+F0sf+OZAE+rgHaEpiJ8KJMn8xhlJDv88bxJ85k58qXLjZzlBmR5b+lAN?=
 =?us-ascii?Q?u3PW2XSSK+aelNMUrQosz8RK+KHDRDGD335EIgr1+7gYQ3yJmfx0uTwDq2ZC?=
 =?us-ascii?Q?cjRPXKdqEaCovyivXYEaCCjnwrcxOyFnC8NnUF9szsHKuBHQRWlY3Bor/QFR?=
 =?us-ascii?Q?JlGscrdU8Q+nmXPu002BqkLcKHgbLFHNeLeQF3EfgKQmappmQI8OVNtJxwGn?=
 =?us-ascii?Q?OUCCf9vdNlRpQTNlGsD0RjjGVOWsfTRugBxF1ayW0z0y9SEJKqcUKhp70mMJ?=
 =?us-ascii?Q?KhdJRevAdoXi1DoZZvP76h9AfMqb5NfTBF+Re3CSY+Gx6ekDL4Wus8DIgwkj?=
 =?us-ascii?Q?UaiFwzMw9a5W0pCnVQXQhvpcPcdy45gM3PYeWLgKGb8u1xPEE/yTGU6cytZJ?=
 =?us-ascii?Q?D2Kz0BtEyOxuYpGKhuj2DBVUolrHf17TtlHkXCaBsE7chE54i9WK7jdfFsBp?=
 =?us-ascii?Q?ptmgxJt9QbHnybPSlgNsgZjMSNDcOTLVP57OyNHq+TtsAtV6QJhmMCxCvWep?=
 =?us-ascii?Q?L6ud/oY6p9EOiqkGRIhtlMy/pjfmMvO1VWZaFbaJOf87tecP6KwptSjPlqKU?=
 =?us-ascii?Q?1NGjpnkcPbwDYogIz1KQDcVnghad2SMXKp1AnSBKH2U2brKtt6rcp+zI4ICf?=
 =?us-ascii?Q?NWLSsGuCLvl+xRCvlfwt81Rq4AP2n9pX8TbF95FWkBU8hwNSlcIUtJl5jSIF?=
 =?us-ascii?Q?dk5SI5PK9VFM9SaPH5FHZGke3ZzwfgpGt31RRHMNDmnxkZCOijgUln3diBnb?=
 =?us-ascii?Q?+dIY6+K8snmRlusfloy8+grIQnSqCEhQyJV4KlBCpTfHL4gl8ZO+IgMhuDDr?=
 =?us-ascii?Q?2i4z/G80zt7SWLQH8vOTIgujgY8BZS8UvATQGxkd8RgmyRNTuYKiHKQ/tutA?=
 =?us-ascii?Q?BCqLLPajwG6yHjpB07FGK0CXHD9qIpfr6JWWBAB7V4/ShmZoGvjWNKL6BKjP?=
 =?us-ascii?Q?mOyeIJu3uIEDfPiE3B9O2dHiH3Az5K2jZ/i7kTa6LvoNUjOqT0dH0dRlM3j4?=
 =?us-ascii?Q?eyvfUaJUHh+VD24DXEKL73/TfPCSyvXg1joIfw+yH5CIVZKBlMRDQMskKZi+?=
 =?us-ascii?Q?8kAuy/KLex4FVf3gy0vdKXhTLNjYmwn5+38Xta/Xx2N7t7rK213/pvEyvsqq?=
 =?us-ascii?Q?tEpRqHwGC474kyneazfhKxLtfDHp0k5uX26nLPSZwcxhj93hVxuld0aD8Noo?=
 =?us-ascii?Q?ju5/ERwrW0vkRdKy7D1sY/K2F947XIJWG/b5T+61KsvngjXzF5jVZhShKX1y?=
 =?us-ascii?Q?bNYkXZp8DsKRgYjdueZO5xwOlAMKsZktlsg+8sQ42/iLW5FNvBH1fxZgkQ6d?=
 =?us-ascii?Q?ruXpOcFHH8e3Oz4bqKoqIVvloqPlpaPGsaGrZCWBsUlsw7GArXqUDmFj9bMS?=
 =?us-ascii?Q?HPqjSBPKRpKMhLCv8eTyRBhi5FAGEyNjBdSKml7bY0hHuPhUj7bXHMMgF10+?=
 =?us-ascii?Q?Og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: F9KFRzp5e8lXq9T2zv5sMTRp5vY0k3fma7UjZqsKtDeAVe7jyTLhRI54Gu4+uVxJq/1RLXawoeRiXOlm52rTlMXmT+6uv6NIzpti0aIHvYa5953sUxOPqMp5ThZC+MeFZ5l2XtPGr/rLsm82BTB6q8yWGeZv118t81W/VOPuweRcQq5pMEhx224maAvSW5AeIcfzLAuPfGfCAMV8D45tZc0/RaVUiJDR/41f+hv3Q0lDrAjg+GjcsyS4zpds3aGMrF2WzkmIeSb17f/ySgmkYAUUGV6FfRwJKyizUOs9epsbXp8ZDkqYj4+wSlEZ8ZAsZRvPxPAmDCk6/rCT5PjTZF8374XPqlgZ4dFJhXBT+lgq+3RwFimUj+mErQDjXslm7cZrAdVX/9UtAKVMCjkUM18jJL8bOYIbupRY6Xqw67sj6qqbjSSS/euTxhz+FcY5saDxo9FJGgUMS8hCQED7HJoGmpsbphiH/W2AGJtR0msh5Ml/yQQW90PfX8iVtUVxg0P+dwZGLHRKGayF736F63Ffw6C6qUzw2bBL645fny9/UPOtXReqnNdFjqhNHKA9RXcXDC3WpMVWAenH7P9jDQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2071b8-75cf-4077-9e53-08dcedc8d1bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 09:56:34.7541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f92d38a3-9c84-427f-afc3-aef091509c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P4NPEJudClGEoFI2U0D+gU8s7qOfxiyYWxP5OnWwjAgjFTlL9KZqBRTuiCBSW2xmGqQfcr6LctGnVM+TZBaF63S1cLl/cWnbyVpPSJVG+bU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P250MB0070
X-C2ProcessedOrg: 71f8fb5e-29e9-40bb-a2d4-613e155b19df
X-TBoneOriginalFrom: Michel Alex <Alex.Michel@wiedemann-group.com>
X-TBoneOriginalTo: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
X-TBoneOriginalCC: Michel Alex <Alex.Michel@wiedemann-group.com>, Waibel Georg
	<Georg.Waibel@wiedemann-group.com>, Appelt Andreas
	<Andreas.Appelt@wiedemann-group.com>, Russell King <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-TBoneDomainSigned: false

The SW_RESET definition was incorrectly assigned to bit 14, which is the
Digital Restart bit according to the datasheet. This commit corrects
SW_RESET to bit 15 and assigns DIG_RESTART to bit 14 as per the
datasheet specifications.

The SW_RESET define is only used in the phy_reset function, which fully
re-initializes the PHY after the reset is performed. The change in the
bit definitions should not have any negative impact on the functionality
of the PHY.

Cc: mailto:stable@vger.kernel.org
Signed-off-by: Alex Michel <mailto:alex.michel@wiedemann-group.com>
---
 drivers/net/phy/dp83822.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index fc247f479257..3ab64e04a01c 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -45,8 +45,8 @@
 /* Control Register 2 bits */
 #define DP83822_FX_ENABLE	BIT(14)
=20
-#define DP83822_HW_RESET	BIT(15)
-#define DP83822_SW_RESET	BIT(14)
+#define DP83822_SW_RESET	BIT(15)
+#define DP83822_DIG_RESTART	BIT(14)
=20
 /* PHY STS bits */
 #define DP83822_PHYSTS_DUPLEX			BIT(2)
--=20
2.43.0


