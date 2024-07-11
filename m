Return-Path: <netdev+bounces-110718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FED92DE63
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 04:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62950281F25
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 02:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB75C129;
	Thu, 11 Jul 2024 02:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="uqWF7hIb"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2138.outbound.protection.outlook.com [40.107.117.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53D68F4E;
	Thu, 11 Jul 2024 02:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720665324; cv=fail; b=COZysZVyG2RKhbdBHLIIqOQYgkWDBqYNel8C5ustAasOWwSkZA/qO7IZQNlZiOIFXCQLT7OGgXOEQeCC/YqqbpqoRYPk/Qzp8KVuj7+wXIX9+nw47VfQZL5Vm0JoyzDMQWqlNg3WPTqMtFHS4aAw558G/ojTGH22PLxp68E/Il4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720665324; c=relaxed/simple;
	bh=YKRFrflXlBJ4GiQ8A3L6pCOCcEJceq+41xW0ZEF8hl4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=s2zZgcuOc71hL5APUL0qcHUgYDltPvxw7IHLyXNjM02XgQwVzGubqKzrPAicnfhwRbL//AgRBoK8S3k8EN7fh79YihLDTkFYFoAKOFxEl/zA0X9Nz2RHIyxJjM6ki/RSr0searTqfy/LCiisXjYu7sSR2mf3ojk8dZa+spVxvjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=uqWF7hIb; arc=fail smtp.client-ip=40.107.117.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkbS8WlFetkWyOxih4LCiCEjmKOmoMiV5MqvR7L0yiIK0DuXfO0Ac+z/Dv53k/Ifz7JtRbuUSfRz3M9jmioXPqUjxv8ZvU23okFd/P2JPgFh2CYC/1Y4iFO6PP+9DXWxmLHZi41WUm1uKA5aYuv3wXafJ61UjdN0W3505gSDhR4/Z6Bh6qxJkaH1M0/XnCotfg63IEXPwEmmujDhbmcmdQ+9F+BZLzFMl3QascMV1fBt+JDhm7QNXrfqh6SvZFcYebXb/EIWadHWDXvs79+9REK5Qz/KxUrFwMpWy7WOkz6zKcBct77QTusn0+yXhApPETjfkNOBUVTNevgKc1vyfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60c8ldv8Gtq05aGi/r8oign4rTfAuTYPALNPyBHGn0k=;
 b=bPo4fXsaZzxhWkylgVCm0qvJfwa0XCNlzhMllabAZSpzkMisWWoL9xAKhHmtb2mnKepgSID9eVYW34W2O6JCZtGsdK8B8sGzr61pt4Mk1Job3glFtndb1aRGzdzbRYRHulIaoBx4WY8cqwx6ImNgCBIQTD8/TnvSfHXy6PiXiE05wG3LZt/GWC9nZoK8Wwzwmym8y2FJAXoNXysw/cnRoWpInVbwtqXIXJyJeo2l1v4J3zSBhp8LFsP8lAk6rwaVTW0VP0a67kkbovkNjMEz4i+g6KSI90pIneDMYBDbYRJRFscZ+IjhCX8ucziXQXbjNDI9W2ApBAKb696CDRvoYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60c8ldv8Gtq05aGi/r8oign4rTfAuTYPALNPyBHGn0k=;
 b=uqWF7hIbroaPy05LnbZJ0NtAds261JGYZE1lu6Mhe+36k5xoRSqlRPPasBYGgCLszw8d8kLVUgLNRLjd7wjpJznnodmf4jE9J+KQ8uMu2An0ygOaHfEIllSCvceOPgDZhr5zaq4ihco/phq+1ylvG/kBx3rtY/tlA/J9D+ugmis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by TYZPR02MB5713.apcprd02.prod.outlook.com (2603:1096:400:1c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 02:35:16 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%7]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 02:35:16 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
To: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	matthias.bgg@gmail.com,
	corbet@lwn.net,
	linux-mediatek@lists.infradead.org,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v5 0/2] net: wwan: t7xx: Add t7xx debug port 
Date: Thu, 11 Jul 2024 10:34:58 +0800
Message-Id: <20240711023500.6972-1-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0175.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::19) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|TYZPR02MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ffc7d9-7c56-4d40-bd82-08dca1521929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IANn1ypzf6L8ddVNyJVou0Em+ReHSM3YcgqPDN49kFcSfKTVchSn0b8pvuCA?=
 =?us-ascii?Q?P07AbqJdGQ+DxOxS1MWwP0BVEv2JWlYgbFeYfs9s0XKSzESnbtmM2A0mWukO?=
 =?us-ascii?Q?NfxI+2xbYVZil88wTPCGBXRWYQivpKbcmr4D4AIB/fn7GdTLFiR6z5cLZ4kL?=
 =?us-ascii?Q?4MgM9gQM5yROmkXnQZ7erIJthHmp6XVdVCO4ttbeFkIDCtLH/rD29iIf7jb+?=
 =?us-ascii?Q?0M2qESc2B/Y30DdWqhX8YUMUvY1YL/lh65mTSq+/ofF5kJQSEErBuIY7+c2n?=
 =?us-ascii?Q?n/wRRD5P0qkBNEeHWZ0/j7zPNTo1VfBXNs8eNiIH/6o9SQFkgQYDsi+DsWaD?=
 =?us-ascii?Q?ViB566LYued2FaslEdiJzLWxrvknCE5wSviK9Hpms5eiC5Y6YGejAOu2yG4P?=
 =?us-ascii?Q?eHhB2lWC5wmizRYHtQWDHdu8gqti36gDI+3EvRQj7XgwP0n1Xt7erjBlcxZB?=
 =?us-ascii?Q?wgKiVi/WL6ayo31FxJI1frZBul0RWtFPzKa7Teq0Yup8VmHZVslj8qCdaxD2?=
 =?us-ascii?Q?E7DrDajDevgKl0CUsrvDh2G4Rwy1kOBdzMToLo8D2lnmewn2eo/3L2aLp53E?=
 =?us-ascii?Q?D1a1/Y6OVXhWy8PXCc21YEOLnuukRJCCY8ncOzUmwXdehhXZZgxK2XEJrGVH?=
 =?us-ascii?Q?9epxxNq3SCa3EJyHrXqMPxnd20kQmKiKvd1AKpTrGXDYO4j45rxx4ctF71U3?=
 =?us-ascii?Q?FH4D0RuEcQvxzjGvrAyfZPY6IXpRB7pQe/aUDFUGDpcfZMrBiTk8lcmLYsh9?=
 =?us-ascii?Q?uV4m0Ol39QqiqwTD/KalsdxeUKE1kuB5QGiIWP6LJqUj9mPe+fy4+dpHiyb9?=
 =?us-ascii?Q?JFWak9yUDJT5+rpgKpc4oF+6ltcF8uajQjGt0wanz50+jcieWYnZWsYCg1+Q?=
 =?us-ascii?Q?JqXv3uzircyDkiCLjZeOaK72OHtvxsQrvGCm9H968jLeHuNyKCmeAGyZEPQl?=
 =?us-ascii?Q?4/8OqPa/kXg2HFoxS4j8qk0Xi3TkC4l5ggG0Zt3VV9gfYfWkwZvQlnywpuSl?=
 =?us-ascii?Q?JqKf4LSjjjHtBJZcvqwLSjzsKOryYSIiHUO38khUsHMa7oU35cGhkCfFmo8B?=
 =?us-ascii?Q?c+l31uIYkWa88HAUODYnGSEjMgHDSiFdlTs/wMISuRbFbD3OoWXTiKLw5lel?=
 =?us-ascii?Q?r5Qbs1q/7OgVTpclsM416CBMfmGnaPSx5GEoHdJUifjgCzYTBmIE2/YdCadH?=
 =?us-ascii?Q?aNV5zb6A1uDgY/XY+5RzWHnf2Aub1ZF0hITCIwnenqDuekl6+kOWwv49yf5I?=
 =?us-ascii?Q?VBAEFhq0myXdoGvNkcs6m8VsGPYsEMOTnh4NH8hJ4xxNM64nxeDC0KQYbesy?=
 =?us-ascii?Q?z/TfiMPAz4pujsW9AwxiMMajXLHZAl1YuOpzIhXW4Hm7uqStKdRo/E3eLXMA?=
 =?us-ascii?Q?IkModnjgVGNKMy/5/Kgto9Iy91BXFOzQFYAzo7oR7nDk4G8fP95ylvZOnZNa?=
 =?us-ascii?Q?6xmtuzn0f7k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(7416014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b4kDI+jEDTw/pBnhMTI/ZGWoYv/vbTaJ+WB/a+t0vvvD4bo5jbcYC7Pbc0Cy?=
 =?us-ascii?Q?W32xqNG4ehKhRaea7/UoJWieh+3hex1DaqYTMa+lY1jSIpFD0R+v9DSrOfIt?=
 =?us-ascii?Q?tKUKlUuPKfbuFZexye2vT5HcvKgppB7bH7wdV4j7OcJjhRcCCEWDN5g1Hhk7?=
 =?us-ascii?Q?uTjGujM1fhOGSD3c6GkWMJJQOV/YdBTAdOfaHC3Jj7ssmewqSvLYTO7iau57?=
 =?us-ascii?Q?WLGdd20mu+LnNbRpIQyYOIMY1hfMJUbq19GhFaPSS2xCQIyMh+DaIHol8Rxj?=
 =?us-ascii?Q?OpCLAsgxTgLgqAQknKqobF7klJdRzPmgT66Ly/bCdm+TUZ0131UtHN9bNVBA?=
 =?us-ascii?Q?dEuHtbRi6az68y+ALVuhhQmJNhcSSvR6RuEqFt5jw+gf4GsTZl8veqNWxRTs?=
 =?us-ascii?Q?xQ4hhqABiAHNir0Uy1/MRbi2SEPWxGLtkSbcwJ9mrj6BW9K4CODpMweKyG9i?=
 =?us-ascii?Q?BiJvaeGlArVZYo3ziHHBmiQgZIXHbFcWZ6JYM6tfl+uUuKhAC9M8bLjfAfz3?=
 =?us-ascii?Q?0Be+P4oxKzsOlnlb5ekAeHu38NWFbxZcKly6MxcbFflT4pT15jFsA/eRIqj1?=
 =?us-ascii?Q?ks7jrL9YoSRD2lwK8h3miUB6sjEszCGY+oATI6eEj/wQSQhfOgGikJWhtrgE?=
 =?us-ascii?Q?JhU1tFdC3cfvGL7vR4Ag/nlGP5uSrLRkGUkQkyEjoTMKmvP5TNBiC8qqm+Uo?=
 =?us-ascii?Q?PKzGFeiX7mEkHW6XCUUJLD+H27idWvHKybC8HDUf5nzNdhUvZxsN2FaJnbMr?=
 =?us-ascii?Q?Qf/7RekcyBA4OfvNQVsywkY4hDfya847hQFyb/GdoCKHIfPwVYdF7S/lBcyN?=
 =?us-ascii?Q?U1bnaUNr6XIABhr1ViheW6vMqXe8fliS2s/wfQ+HJ+xaEb4c7hzhcDwbC9OE?=
 =?us-ascii?Q?xgdeTmMQj8y5nGhEL2KIb8QRcL882prF+OkTE+jKa/zZKjWBpXUYigOj6Gsn?=
 =?us-ascii?Q?TKKpJH2DqcRpSQavmJ6cgYezooJO/WWml4bAVE6vA7Jxd5EwF5QlJAjhthlc?=
 =?us-ascii?Q?6XRAS+lphj4h2OQN0NLqTY8dT75tmnZnIQQWC/kOgpACW6jTwMR6Cf91sVRj?=
 =?us-ascii?Q?B0yTWTz0oOVUJSrytrUkgWYQAMxxwzjtN2BtOZSD0Uk5qRrrVVTQIonp8/kx?=
 =?us-ascii?Q?oVW6PtzV3S2Snq4TI+CufVzuSXz8XjJxDLBp5Z6KYzNWUt3727UL60+U0nHg?=
 =?us-ascii?Q?GqgLrToY9u50PAMq5DDDtJzxBxP7zRKQ6/76GjIuWQNt08XpLcxkI5KJgBna?=
 =?us-ascii?Q?BFx0SYLRpPqqODgMgqB8jgKRuwdbfWHaFQ1wjmf+LiGZ/Iin1grGP5wlBqGw?=
 =?us-ascii?Q?icMxzWRvPwlRVx3l8PsHlw5eOobxi3xvpmaTZlVGaZe8ldKqSBetxRI3Paph?=
 =?us-ascii?Q?1wsLQu23qZfzOs057wCdbNAAArpz3Gxny3/dfgOMYkteVmssgX7oRipuSCjP?=
 =?us-ascii?Q?JhkiKdeZzhPzkiD7rwJTTaAD4LJewOIPBy7oLrvtAZK8F6a1SknhijFxXQOj?=
 =?us-ascii?Q?vCr8KlTbyFkAsssJptqev9BD6J9HNlYEZx99wJbwdfGm0TrArhcaiEL0o/cY?=
 =?us-ascii?Q?2y2Zdqy4KQzXQVZcwZG5eNg5MP7hZx3aIDQrXiYvgsl4wReu8mdZ1ZmcMEL5?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ffc7d9-7c56-4d40-bd82-08dca1521929
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 02:35:16.4018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/Qhg8wA6Q7/6RMfA4YiFKRZGi8MZb5cbHYzDiRkFrB5N8A9X6iqfWcKjpw3RiKazhjkugyFGz/iLT3z5cA+9W0O1hSeFjctm5q0ohNS7e8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5713

Add support for t7xx WWAN device to debug by ADB (Android Debug Bridge)
port and MTK MIPCi (Modem Information Process Center) port.

Application can use ADB (Android Debg Bridge) port to implement
functions (shell, pull, push ...) by ADB protocol commands.

Application can use MIPC (Modem Information Process Center) port
to debug antenna tunner or noise profiling through this MTK modem
diagnostic interface.

Jinjian Song (2):
  wwan: core: Add WWAN ADB and MIPC port type
  net: wwan: t7xx: Add debug port

 .../networking/device_drivers/wwan/t7xx.rst   | 47 +++++++++++++
 drivers/net/wwan/t7xx/t7xx_pci.c              | 67 +++++++++++++++++--
 drivers/net/wwan/t7xx/t7xx_pci.h              |  7 ++
 drivers/net/wwan/t7xx/t7xx_port.h             |  3 +
 drivers/net/wwan/t7xx/t7xx_port_proxy.c       | 45 ++++++++++++-
 drivers/net/wwan/t7xx/t7xx_port_proxy.h       |  1 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c        |  8 ++-
 drivers/net/wwan/wwan_core.c                  |  8 +++
 include/linux/wwan.h                          |  4 ++
 9 files changed, 180 insertions(+), 10 deletions(-)

-- 
2.34.1


