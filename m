Return-Path: <netdev+bounces-124123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AB69682B6
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 11:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C701C21F90
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 09:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0220187328;
	Mon,  2 Sep 2024 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stwmm.onmicrosoft.com header.i=@stwmm.onmicrosoft.com header.b="WlqStIjE"
X-Original-To: netdev@vger.kernel.org
Received: from mail.sensor-technik.de (mail.sensor-technik.de [80.150.181.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C34187330;
	Mon,  2 Sep 2024 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=80.150.181.156
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268140; cv=fail; b=JACXNFfxebJQjuEANpLsqhgI28967B8Xfu1YLoUvqdiGKI8C4zH8lKoU6tXW7cRWGeI3Gl6fzZHbmiJzOgB6PsmHAAd333z5i9XVsJ3zHPgxm4OO8xbKi14bLikXetDuN2oXa9XIwivBCxGlbTx9K3gWreyToANIMjA6mfNMvaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268140; c=relaxed/simple;
	bh=Emsx5fuhjCsZqL49Yv3Rd4K4gQxYYadi762mC9AZ/y0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=STvLNSxwPbn8eDuSG4HZpXQf87fSIPmPTBdl5MJvJADnISsugy7N5fSd/Tyn7WbZAKde1VcQnfp3mQsRwq/NSPIbIWDrF9Md2rwXu/TNfx8F/TkK/215Zt6nxS229Sqt93wVA1VMZf+9TJqtRs0p5txIXkn4u/DgaB4FO6z5x14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiedemann-group.com; spf=pass smtp.mailfrom=wiedemann-group.com; dkim=pass (1024-bit key) header.d=stwmm.onmicrosoft.com header.i=@stwmm.onmicrosoft.com header.b=WlqStIjE; arc=fail smtp.client-ip=80.150.181.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiedemann-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiedemann-group.com
X-CSE-ConnectionGUID: DkXE4p7GRq6oOM6Yy2KbgQ==
X-CSE-MsgGUID: 4Yc8WVK5R0+yftqs5tKV8w==
Received: from stwz1.stww2k.local (HELO stwz1.wiedemann-group.com) ([172.25.209.3])
  by mail.sensor-technik.de with ESMTP; 02 Sep 2024 11:07:40 +0200
Received: from stwz1.stww2k.local (localhost [127.0.0.1])
	by stwz1.wiedemann-group.com (Postfix) with ESMTP id 5ECBEB5A8A;
	Mon,  2 Sep 2024 11:07:40 +0200 (CEST)
Received: from mail.wiedemann-group.com (stwexm.stww2k.local [172.25.2.110])
	by stwz1.wiedemann-group.com (Postfix) with ESMTP id 55885B5A87;
	Mon,  2 Sep 2024 11:06:03 +0200 (CEST)
Received: from stwexm.stww2k.local (172.25.2.110) by stwexm.stww2k.local
 (172.25.2.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 2 Sep
 2024 11:06:03 +0200
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (104.47.11.238)
 by stwexm.stww2k.local (172.25.2.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37 via Frontend Transport; Mon, 2 Sep 2024 11:06:03 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbV/3ynaan+ZPljuIrnbK/EaSpTSZ3fif9oWTVZB9E0kpi4uST9q6jwFb/TiDgKj5mrN5T9LipgxiIhFqfX7M+t+lR6XbIGw+4aVUhZ9itJ2nn8o7XvqrUikjcXCl1ckK2HaXSeA0gcuta+3WLHBaBWtcDz0n1oV6u1wWLODDGHzxiRrHDCdYXXe6QhE120V1jTu8IqlW0Ybjg3AIPEvnFDrPUoydQ+AOJvb6c0n+4aXnwkLmAufH1REqAwm9Pa6mT2bRtJUFMrUZoYYir6Yi80TttyYTh++asHVmIccgh2JC8h7GEYGM4vvjEDGkTppIrWffW1/XiX5mBh0ExlERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0bAWbMTsCNn80mmc1VytjP3yJc+HZLqzERTw4UxNGw=;
 b=b8mbVctH845pUlwLzrr8ieNtq9LyJntVphtBbiLJbY0NOqWclG+JCCNzV0W9P2RbIiJpJtmTkvMsOUAaGgXfiBHhdmPwVAXvTeV0mXOG6WpemopIIGsc03xGLF96Cfw8mgdl9jk+tFRXWLXnW5EUfToJaESraDt25sBy1xIJO0D1kddsRPDwUThy6yDM2+anHDwC2zphVvNxTMUzlZM5ZTQTc/NH3IBDmOcqTMYlEHHSNv5E7sp+criyOblekMjZ+6nEWB7aG7Sz7acVIKFllGizDEJku8iAe/MVAYH1P0ZSRpZDGZ23mmNbgtpfK6y4gPtc26nkK4iPWfhMQrQ3Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiedemann-group.com; dmarc=pass action=none
 header.from=wiedemann-group.com; dkim=pass header.d=wiedemann-group.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwmm.onmicrosoft.com;
 s=selector1-stwmm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0bAWbMTsCNn80mmc1VytjP3yJc+HZLqzERTw4UxNGw=;
 b=WlqStIjE5H/mDHjtD4BTOL/HydOM7xyYGdVrx810b2mccrenRjNcAUFe8489B68xTcb5S7maMkzy4xRq3KaItswwHRzhjFZZrH/+uZSd5Oc0GXk/nb0YFiB5k7NHOTv8haW+ZJCSO+Ta04yQBf0VHIUgm0h3/5lmiGKjO4N/Juo=
Received: from AS1P250MB0608.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:48d::22)
 by PAXP250MB0424.EURP250.PROD.OUTLOOK.COM (2603:10a6:102:287::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 09:05:54 +0000
Received: from AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
 ([fe80::b4a:3a:227e:8da2]) by AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
 ([fe80::b4a:3a:227e:8da2%4]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 09:05:54 +0000
From: Michel Alex <Alex.Michel@wiedemann-group.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, "Abel
 Vesa" <abelvesa@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>
CC: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>, "lee@kernel.org"
	<lee@kernel.org>, "abel.vesa@linaro.org" <abel.vesa@linaro.org>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"NXP Linux Team" <linux-imx@nxp.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Waibel Georg <Georg.Waibel@wiedemann-group.com>,
	Appelt Andreas <Andreas.Appelt@wiedemann-group.com>, Michel Alex
	<Alex.Michel@wiedemann-group.com>
Subject: [PATCH 1/1] clk: imx6ul: fix clock parent for
 IMX6UL_CLK_ENETx_REF_SEL
Thread-Topic: [PATCH 1/1] clk: imx6ul: fix clock parent for
 IMX6UL_CLK_ENETx_REF_SEL
Thread-Index: Adr9EzHKHzzDMWF3TX6ldy1WNJe8vA==
Date: Mon, 2 Sep 2024 09:05:53 +0000
Message-ID: <AS1P250MB0608F9CE4009DCE65C61EEDEA9922@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiedemann-group.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1P250MB0608:EE_|PAXP250MB0424:EE_
x-ms-office365-filtering-correlation-id: 02c195f8-a1bc-4157-5d57-08dccb2e7322
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?CFDX0xXtQp9WNs2dVqBxxUPRC1XrtwKNK+9czPOEiU0duEU34CWdghH5LiQ3?=
 =?us-ascii?Q?FKe69VmGgiY/YFRUffSJDcxX5QelCKCRiiIIEQJ0pPDnpAbmbgIf+yyhMKHW?=
 =?us-ascii?Q?1GJO2H6aK/isnteNNqw1R3VqE++ooUoETgKSSEdtLvXFQBduTUemAO7wttwl?=
 =?us-ascii?Q?meK323ivOMR6Xw9t7f1aPr9+4DMz+pgiUmYr4wVTyg7DVi2nNlxg8T9bi5no?=
 =?us-ascii?Q?gegnPo4JPIfYUvBIp1JWwhlHqrbyAhhJZ+HcoxHOyOD1wBfBs6ju5A9ZdtMO?=
 =?us-ascii?Q?SB09Gtm9N75lv/Y/cpg0mgWbEXfU4zDtiD1v5VdYfi0izBXraLPBCqj/wV0c?=
 =?us-ascii?Q?5BoAnr3lxikjp7RYPOKolJgN7gCZcSuW7E0YPfvQu9BzoLEDMJqQjgV+cLd8?=
 =?us-ascii?Q?qjudO6eoOKk3n/Lwy1PaeA9DtfaNrO2Yn/lBig5glDZ86EvGIiqgH5o8NP9s?=
 =?us-ascii?Q?DfJ91V1KdDNKNAEm09h0Q18aeIR8kPaxPgZ2fYC98zJDqguxshVSvTx458q+?=
 =?us-ascii?Q?ng2tWKQYTQKRZtK1nO5LqN8sO/WCE9wBa10Duk9QzkJ4/QpYJnHLL2DAABZM?=
 =?us-ascii?Q?ujulDeeU2FmiLq/93bFutKwlUZ7ULoqOdAnG72mPIFm2psdrA66o2BW9pimU?=
 =?us-ascii?Q?J3GYWkCuAzgdYhMAHZ7va5L93T0h7PZN6sxUq3Qhfg8BBP5minQaqE+ktOHm?=
 =?us-ascii?Q?d2VpqruCg9PZO9jNLIcJfx/zM/fMCxS8X4BTgDclvb6zTPlrP7x0Z9x0FVOp?=
 =?us-ascii?Q?+lbOMHrdH/X9ckpwIccqbWyfqK/9VhDTax73y44ZUtYLwjip6wfUXmm9EPh6?=
 =?us-ascii?Q?qgDp1ptJyKFjVSQ0csTO2zPhlbGPprwlp9kf5KuVPqNMdKvaZvPLFBKVWXMc?=
 =?us-ascii?Q?wy0qQo/WVyURTt3kDEaloT3QeS/tG4g5hupG6qD4vU8zX6zokWENJq6qCuk/?=
 =?us-ascii?Q?jlWowqo7/3YGMywQDZ2CdxuLsgSpX2i0Y+teuXVmfa3ysV6F25s6ygGcjE9T?=
 =?us-ascii?Q?NBUquoDkR0qVZy407B+ssURWJDlet+MongIksxRS8XOhD+9oETmbXb+566Wm?=
 =?us-ascii?Q?UVbppJRQafwR1n+MfrSQYVd9KJhlKvDcB8cfWQr1+14pdseLx5gA2Y7sVsnn?=
 =?us-ascii?Q?MoWdlkoOzx93Df3oqMe99to9vrbkpPDv/zy8yE2caGcitx0PPv6rTtby4V1Y?=
 =?us-ascii?Q?H+NK8l2ZUTDPAZd2kMtoxe/lpjnUBM+FA9PehCUco17HsbebAowBL5NhupYZ?=
 =?us-ascii?Q?CHAl0BVGTUUFu/CIae1MS0061zK/1YfmQf5kaGQCiVysdF+I+ctk63zLb2H9?=
 =?us-ascii?Q?o5ZfDmQWKkWKNJWZAmu1ElMg1xXBttSffH6mTSu7d7igMaEhqXfgOtimJ70w?=
 =?us-ascii?Q?10Rqc4271D4ysVO7QWRwDkEv7mYv4epNcCJl8QvXEJQskp8uxw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1P250MB0608.EURP250.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7bUTsNj1U5MjHu0AF3iu78DNK/C9mOp9X0wv6oiuJ0LIh7AJE8q/XAUdqLtD?=
 =?us-ascii?Q?/52t4EUhvAtcgJ0+fS3VG0ZbfL2EZicFqxDphCrlDZsLMAV6BLabBzGMvob7?=
 =?us-ascii?Q?s1Q1TRIObbjYrzg0BP8XKygRMwLNAKvTHyjG8mNJFbxFzSLw0RH0OvQUcQHE?=
 =?us-ascii?Q?kuQZYFZtSs5O6smv3K8UsHON2NCr6EJGCMQ+RJg8R+n9UfmmoJdI4nJBeUim?=
 =?us-ascii?Q?LXM3HziZ4rTgRLLw2APEt1xealbYMiGfWhJzR2uWwHJ1V6Kpht3t+INnWXpi?=
 =?us-ascii?Q?EA5DfN8vp14gCyU8jmV6vCPtgWNo6j1ux5IluKLG7R/9klCsPFYbCo/hyrXq?=
 =?us-ascii?Q?/08pbE+j+H9c7/6o3n4FGkAtTHNujHN2mISUt46jadSHillKIWfnJzhjVHjG?=
 =?us-ascii?Q?xXpOEHMVUk0BMHsiIrmm98ElVeqsYebhBQs5ZMWGJf9yUjFYSKTtMdgGM1sG?=
 =?us-ascii?Q?Qat22LIdkWZkb3YMKNE87Jhv9x3LYFih8OsKPAXRn+6UsHz0j9OnU3WCid+E?=
 =?us-ascii?Q?EtBNruRfOuGlZ0tMApQKX1rTTv5CvOJf+kfRSjmc752NHRKqFkPVrj2rldfx?=
 =?us-ascii?Q?B0mA1I1B5JqqWijLud5p9PDihpTKysBiayPyi5FRlAvMCNkjhcwHnhODjuRP?=
 =?us-ascii?Q?MvNrT9FsoYN73V9Fbq35lxUkpaZFictlll7PFrZGaqeESHZ9P0dIthEguDEq?=
 =?us-ascii?Q?kqoK7+FBbQEbRhmRlpbtgw9kTQl4lkV8fv2ZODpQyZ+SWuh8rKOZwUtWSMMJ?=
 =?us-ascii?Q?kpfADgD9sV4/Pgx2Nle35HJFTB+2yjEgtX8mhPqftMSi6xzAu0n1kr7k3VMn?=
 =?us-ascii?Q?f/9FwvtmNECBLZZX1g8OaqvQY8JD3SbQ5trQPRENngqIv99BiwSvUhoed+An?=
 =?us-ascii?Q?l4vXIX355OauCXzNAeWPnn+7e9HJtFr7u+ZaybkR9BcGu/tu0lL4S2lblTI0?=
 =?us-ascii?Q?HNi2LlnAKqCy2+WFNQnylgdlnltEKMawkxL6zLSw+3d1RutWQ3bXYqYSmlQM?=
 =?us-ascii?Q?LljPhiEQTsJM0w+ohkcFuFZVyEn4yJJrp0dFtwOEoW5vH+AORuyIWAyYSHwm?=
 =?us-ascii?Q?bBXrVmMGPBtpYeq9RV2iBI+/uq1r/zFAf+cE35+MbEzOIwMu2IKk44cpdAdq?=
 =?us-ascii?Q?KdRB5m5Q/IrZzARmMxykKoCdZI484j3Ano6gs4cyo7hQjxmR8pgDAmxUusyo?=
 =?us-ascii?Q?P+4ohxtTwuXilpZWejwBKz83akuFYZ1J02htZ5svYYjLr/3s9wPYVC4d0qZU?=
 =?us-ascii?Q?KsZKALEufEX7khhPFLxPhJXmZlXornE1xXKL7B4k9L/ZLqQR2daCFeKTgWlf?=
 =?us-ascii?Q?vBBx/vlOvNnY68Jc6FM/vEqvTB5RI544chm5E3KBXJqadgvE9g2TsOZR4VvL?=
 =?us-ascii?Q?5uUAXU6ybRNHJz8stHfvLCrH30HhFuzcuJoDeoXDMh2XZ56UL/m7MSoGFaQH?=
 =?us-ascii?Q?UZgBxcmSBcmzSS+GxjrhvmODm6y2ebKFsiMUxxp2ewh90AYvUgt3JcJtpH1r?=
 =?us-ascii?Q?hrpe+IVBEen/mdKg9xD1NBa9o2Y9rjx8jTwxBgx73RM8haJMnFgOLq4D7Ddr?=
 =?us-ascii?Q?nI+5Cu2odYoL4ylwXDEnXqtF0Dme6Be/dDDVRIxLtbqdsYOK9TdYF6Rh3DoP?=
 =?us-ascii?Q?xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3bFcVrf3n/KUAcs3SIgYoVMXstueFITRmwlCWKaEct2TYv8U4uViuMPZlWhLuI5sIIotzqf4zwOWtGk+Mc0iuO+yNrKsySAkc8TUUh96tvvvuKeqLumhit6z4GiZ2+1pa9MaXT/dJ7ZU0t7HosoEz8/HeB0hfV8OujdROWfPbkTnesd/mM1wV8qgOYLpFZTU0xutcsU3W+mk1ZrmjroLBDi3kz3tOfzmJ5ZSTFxqDmytCK4oNuQsPWBj3haxuhjpfSTO7b3vN9w4Nz3wKzJaEExQizDKPqF0ulOt1PdSWZmPm28FRm3MF3uS6PfDjpassm71xRP2UHiS1gkRicBDt637G2n52dcBk8XryDP0MRECLrv2lY+eYejixlVw4wsOI5OKVZQVVus01zSk1+Kyi4qVfrAm7t5FRvAsWpRSJTuVYXla+B6IC57jOtMMCIsBGFdjj/8+NkCCNHt0HlzTcKF5nAw2M1Mwiq6rn5IrF0G32RjM580a7+lmLtjcN+VA2KF8ttpEszZHuVPOSwnOV9LilWSV7dDoNw2qd/BSgQ81wzzjHskKziSsT0d3rSNUbxx/FxYXzwuDrJlOxg1gmQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c195f8-a1bc-4157-5d57-08dccb2e7322
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 09:05:54.0039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f92d38a3-9c84-427f-afc3-aef091509c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mN34U4XJLyEnZwvFEJSvwnWYVpZr/sReuqMZg7gUgtNE5srkAOqfB6VpIPybZF4ImxGZLpkIMSPLS7CkRPO33x1mc00xi7vhVcTnJXrUuK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP250MB0424
X-C2ProcessedOrg: 71f8fb5e-29e9-40bb-a2d4-613e155b19df
X-TBoneOriginalFrom: Michel Alex <Alex.Michel@wiedemann-group.com>
X-TBoneOriginalTo: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, "Abel
 Vesa" <abelvesa@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>
X-TBoneOriginalCC: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>, "lee@kernel.org"
	<lee@kernel.org>, "abel.vesa@linaro.org" <abel.vesa@linaro.org>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"NXP Linux Team" <linux-imx@nxp.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Waibel Georg <Georg.Waibel@wiedemann-group.com>,
	Appelt Andreas <Andreas.Appelt@wiedemann-group.com>, Michel Alex
	<Alex.Michel@wiedemann-group.com>
X-TBoneDomainSigned: false

Commit 4e197ee880c24ecb63f7fe17449b3653bc64b03c ("clk: imx6ul: add
ethernet refclock mux support") sets the internal clock as default
ethernet clock.

Since IMX6UL_CLK_ENET_REF cannot be parent for IMX6UL_CLK_ENET1_REF_SEL,
the call to clk_set_parent() fails. IMX6UL_CLK_ENET1_REF_125M is the correc=
t
parent and shall be used instead.
Same applies for IMX6UL_CLK_ENET2_REF_SEL, for which IMX6UL_CLK_ENET2_REF_1=
25M
is the correct parent.

Cc: stable@vger.kernel.org
Signed-off-by: Alex Michel <alex.michel@wiedemann-group.com>
---
 drivers/clk/imx/clk-imx6ul.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index f9394e94f69d..05c7a82b751f 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -542,8 +542,8 @@ static void __init imx6ul_clocks_init(struct device_nod=
e *ccm_node)
=20
 	clk_set_parent(hws[IMX6UL_CLK_ENFC_SEL]->clk, hws[IMX6UL_CLK_PLL2_PFD2]->=
clk);
=20
-	clk_set_parent(hws[IMX6UL_CLK_ENET1_REF_SEL]->clk, hws[IMX6UL_CLK_ENET_RE=
F]->clk);
-	clk_set_parent(hws[IMX6UL_CLK_ENET2_REF_SEL]->clk, hws[IMX6UL_CLK_ENET2_R=
EF]->clk);
+	clk_set_parent(hws[IMX6UL_CLK_ENET1_REF_SEL]->clk, hws[IMX6UL_CLK_ENET1_R=
EF_125M]->clk);
+	clk_set_parent(hws[IMX6UL_CLK_ENET2_REF_SEL]->clk, hws[IMX6UL_CLK_ENET2_R=
EF_125M]->clk);
=20
 	imx_register_uart_clocks();
 }
--=20
2.43.0


