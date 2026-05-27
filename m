Return-Path: <netdev+bounces-292088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id x7wINeltFmpumQcAu9opvQ
	(envelope-from <netdev+bounces-292088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 06:07:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A65685DF1AA
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 06:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 800D8300349E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 04:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3A62C0282;
	Wed, 27 May 2026 04:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="gfiIUuZs"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023111.outbound.protection.outlook.com [52.101.72.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5576D2147E6;
	Wed, 27 May 2026 04:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779854819; cv=fail; b=J6tORfHl3WbElGl9+0VhSYjSJKzJBxpaudhhk8Fg8YrRbTnpWePqfG1wHyiBirlnkVQl5+uwl0yo2Jcvqr+b/XIMzSeLeSiZ0vZhi40UqDjOT8sfRmyeZJV40wAOrVAD2sxdVOHecyrmvoX9ftU7weJTPjSEW6p7LmWSoGNq0i4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779854819; c=relaxed/simple;
	bh=9Z7bt9mcM4eLjC7uhkt+E4zrh6UARJEy0OwGDMUFOOw=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=g06rif/Pjw/uJUFoHxp8f/dVbTR6sff1ObZ9okqi8E5mLP+BGuWFZtN+IlcYkAabz+dHZrRn07vaxg1S+uu7RVWueSHU4t9vHSH+vykoHptcG1CiS9OamKKkzQN1YDpNTX7U8PiPbYUh3aByKF5MZjLFWOPm+Az3X9LED3YUYlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=gfiIUuZs; arc=fail smtp.client-ip=52.101.72.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XY8RvRt9JwZ1aEZDsD3C0x3Tp6pOnqGtSRIlRyOrgau9mR5k3l1afBxVjp9zBcnHhuwwzx7/qhiKQ9CE/Puc3b8BDNsPTK6w4lFVvemyzYkDtX9ztFpaJrODrnqfHMo3aBThE9UIBPfBLY+w484kOZXxZh3BG043FP9g8pgXDQBxwta+7mJUvyqFNSXe1VvGQ6KUtmkQP3ON2PU8euDXzs4mlwkwkJmxtP95QeifOdJSvhI3muYWKx9i8osjLn7726LWqoUVzsQdXaNRX1VkM3AVWcOMLrYM66ddAn6NezVpxOaruQXvHxHCh1jekOb8my1tF+dpq/toKAdvDLx1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFFRJ9bprNXb1qC3+0yPP0w/BVmetuyopmY2+k8FFv4=;
 b=fYVDyC1wQreAvlKjJI+/leoCV3UeRKBGBIPzp0BMLSN8PizlBxeqgSYZ5pJjNt2XNHQDlGVB+KyfYIo40RtiFKhjdg6xZbv0Oh1Lvl0PteQ8AwHjEZIirEcOa6PpVCpwIYJHRkLW/L5F4xVdDR+TAHWxHMDZNuE/aFgYCy7AkQDYPMB7oIY/A5XYE94myJTIezP+MTS4A/Rqn8fJ4w0YLdOk59xstwk9S1FbiIc66ar9mzrTay76T9TX0aAGlufcfPRc00V2QnyTwmBcKfIuEmtQK5uwYqeihYbmE60zlB2FSl7jAV8j8P93u0Smat2OBNTVwPK22Afe6vXyIG141Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFFRJ9bprNXb1qC3+0yPP0w/BVmetuyopmY2+k8FFv4=;
 b=gfiIUuZs1WuRDNYxT9Ftu4RLbPMYZv+k+TPK5QefWfcycgw68z3x8y3mJLW/OXWWldHuJ7VpT7mmVI6L1ZZOoORNyYE2bbLyOVD5X4yaZGLv0nW5LEVgvoqzG2CHvlaHnHyEFoKGaFNjT/HxTi6suwr+FAo89csitRSdwc2uMlHCQCSqspQ8q7KGg4Lw9yhsmptpMrINvKPSo74UpZGxQ1NOaAiucZKkvHV6aK045GDW03+akxhwm7FTO49SjIDaUlftXNRHickYqKLYG8Us/LAG1hgvpuLm8/t8wZvNvPlJC2kGSe0kT8viFfJFU4OudckD4g02mjyfWwLKQdZcrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 04:06:49 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69%7]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 04:06:49 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Wed, 27 May 2026 04:06:40 +0000
Subject: [PATCH v2] net: fec: fix pinctrl default state restore order on
 resume
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-b4-fec-resume-pinctrl-order-v2-1-293096f48703@vaisala.com>
X-B4-Tracking: v=1; b=H4sIAM9tFmoC/43NQQ6CMBCF4auQrh0DI5DoynsYFqXMyCRAyRQbD
 endrZzA5fcW/9tNIBUK5lbsRilKEL9k4KkwbrTLk0CGbIMltmWDLfQ1MDlQCq+ZYJXFbTqB14E
 UeKDSMWPfM5tcWJVY3kf90WWPEjavn+MsVr/1v26soAJGvmJ7wabG+h6tBDvZs/Oz6VJKXyVwq
 V7IAAAA
X-Change-ID: 20260526-b4-fec-resume-pinctrl-order-fde0cff2bbff
To: Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>, 
 Shenwei Wang <shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Nimrod Andy <B38611@freescale.com>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779854808; l=2618;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=9Z7bt9mcM4eLjC7uhkt+E4zrh6UARJEy0OwGDMUFOOw=;
 b=1VTurO2q9CWRzyzMA87gppZNwhnEK4r3m4X83oE3iAtJHyGwUdzaCyho9Z2NJ+bfFl8a8YczL
 h4/qEAo1YS/DYwt/InXVMvHzeE9OXAHnj7sV9qSgTK0ZQrGuFdoLHVs
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV3P280CA0048.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::29) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|PA2PR06MB9176:EE_
X-MS-Office365-Filtering-Correlation-Id: e55aacd7-ff94-4a5c-1744-08debba56071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|52116014|38350700014|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	NUV856EEhpPTWGakVlNM7OvI5jw5+VE4GZh6Wj0Ys3D+sby654/0Pqgldf2R2HoE/hTTNtpuN2mdrBXaO/GgvJfle7OnZhmxVH2zqhRZrLAhLHmZ5MivdHZy52Um3Z0V3v5AJlKeMGzSs3q3DpoPJpflDP/bjQp23dmcdv34HWO4Vs1kAGdEtw8/n4ya7/LTOP5emt+DCcIXwqw7ZRHCKs0Tb6UQnU1W28bXnMVtd0VYeQet7Ah2Nn6UiydbbC5dHBsmaL8GxdGaYcBrldqE9prn7ScYrLXm5zZSii4fDzd7WPTNF9P1M5cQV4WelzHjKMT6GfSd0mv16ZPYUBTFG9VQYHfJEDbxDclO1BwpeB/G08g/MDD/tlHNinjsechQ+8RTwl5Uh2vBKuIiEcfLjmRwMoiHyQZnIDtODBqqaDgVXFSBmJLdcj5QvdC6S1tEjhFkwaJHLFWJQIeLpHxSDHGcwzwyfePAbpHMCIAXmMuMtV0qJF7ghHbXgdc4fDRtTdPSciCW+XQHzFMGxu30zvnRTP0ucfXcXt/2YJymtzGiT9nAXOun7L/HCvoG+W32arMlofkZxUly0TXd/p5WgzIRnOseopapTKGrnEbU4mtsJ1pN0nkTdRoCoYgHR0OET9QIvq1vwNgVrsZJcdRk7fsuW3AQjRLOjMQqXj131fDwKvaNByS7PmSqRAsUXg/XwdX3TkNr0/CjCGRlrJKh9+aTnk0QIuRZRN7XGDv6a048VSe7SaGO+uGpdnFskJo2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(52116014)(38350700014)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjdHSVQ1bnZWQWlZR2FYLzhZYjA0NkdVNHBTRDZwWDNIUzNjRUJicWJxSlpM?=
 =?utf-8?B?T2EwOEhrUVY1cityZ3ZpZ2pCa1hhdE9PczFrbTJQK1lSK2pkY1FHNXo1N3BS?=
 =?utf-8?B?TkpOREg3LzQ4V3dyUmhjYkVxelVFa1lBdFRLZCtNeUNoMERNaExNSzlSRjl3?=
 =?utf-8?B?T1JqK1ZwS1Y1dzFIMm1rbnNUdGhaUkIxVWtnVjRHUjAvc0NpZS9DeE5kaWN4?=
 =?utf-8?B?UHE2bTd0SEpOVWxCM1ZUSyttUmhYVlBXaC82WlIvbmp6clUzdnBGK1pUNG1W?=
 =?utf-8?B?bmVPVTRLMjhXWHYxWkNCRGIvRlplSUJaL3RHOTIrR1VWQVpXTVhMOHEySkhN?=
 =?utf-8?B?a2JKUWZoVi9uQ2FUTCtZU1NZaUswN3VValNLdTgyaXFyNkxTdU5XeEphL0VE?=
 =?utf-8?B?OVRkVnhlOVdNMWNRK0svUUsxVW1ESG5jTk8xZ3JqemdCQWxaM3FDSGQ0NU5h?=
 =?utf-8?B?ck4vOHVndzE4ZytqQTZHcUpSYkVtWkFlREQzMEtEY29jZ1B1dkZyWVFDbk1W?=
 =?utf-8?B?WXdPMGFoQ2dBcHdsMDIxZGV2Y0cybUd1c1cvTUlRNEl2amdDRVpvTTZJd2VX?=
 =?utf-8?B?Smt3K3RoamxXUHNNYmN3dGVjT2IvQ0tFWFdkdjJEZmgyTE9udFZDZ1BzVGFV?=
 =?utf-8?B?N1FvVmNuUHdPMm5RTGhUR3JhT0JUcnNKV1VIbUZwN0Qva1JNMk4zR0JQblM1?=
 =?utf-8?B?bCtsMVhMTXZjWGg4U1NuYnFSRnlXVENhdUNoSmNlR3hzUTFMa091dzJVM2la?=
 =?utf-8?B?bXZSRzlLYXVTUWV3NUIwanIraE5BcmdLeW8yMUtaK1A4Q1RiS2dKMDZ6ZmtB?=
 =?utf-8?B?K2JwVzlZZDFXQWpwc2NCZjFoaDBkeXZieW1VWlpRWWVueGZmQ0ZRZWRXUWVu?=
 =?utf-8?B?SDk2UkJ5SXEySFNZNE5URncvTUU3SXZjVW9jbmNCTFA0TGtPRW82VlN6SVBH?=
 =?utf-8?B?bU5CTFMwalpkbUJzSVhxVG1mcUZKN2NRWWJoY3lkU2dERlVxalVTdkpsUElt?=
 =?utf-8?B?TGFvczljM3RJQ3JDYnRmVGdKRW5LZjZBSHZGVUFPYTdpUS9kRnZoZWxJcGNH?=
 =?utf-8?B?cndUOXpZdm9zMUIyM3JNUHk5TUpwMUdHQklLalluamttYVpORnJYRW43bk9s?=
 =?utf-8?B?bUIwV3RIZFhYNmlNR3NtU3FyWlp0MDZlYzlNOURxblgyYmphc0ZoN0lCUVFj?=
 =?utf-8?B?ZVUzQjM5YjFrU2hROFVtNGhvTWNUTjBmelhLV1VMbStzS1RWTmFHeXZpOWQr?=
 =?utf-8?B?NHh4UkFyZnZhV2dqWVAvTVRsWmo4UjBOQUY2VUU5aGFxMUl0SmFCakpZNXpV?=
 =?utf-8?B?dDhDTlFVVmx5NG4yR2JhWlozUjJkUXR4Y0RWR2xJTHh1STM3Ty9hU3N6L0JP?=
 =?utf-8?B?cGxDKzZ2bUFYb21qbm8rNXdxVE1JSUoxMlBtR2xIRmxZZGNzTVNCUXlYdGpi?=
 =?utf-8?B?ZXB3NDU4NzBCM0ltOWR4K1ZQNGRzNnpUQklXMHZiZUNDSzMzSkFtMWtjRExC?=
 =?utf-8?B?SzNIcXMvN0FmUUJjeHR5TkhjODJlRnMzVE9LRFEwcUxwbjFlNHlTWWlxTi9P?=
 =?utf-8?B?V3o5KzY4WjZvVnRGT3NHWno2WXlQaVNaUFU2SFhIQ1V3QzJJYXYyR1hjdnoy?=
 =?utf-8?B?ZUtlUmVSL1F5WThNQTMxVEYrSVpISis1L1VkVEhRcjhQRXptZmpETUVRdmEy?=
 =?utf-8?B?d0prOWFOTmlNMDdTaTI0NjJjYkRNVmFRV2dhM1NKSGN6YTk0U0pJTW9vNW1q?=
 =?utf-8?B?eVRJaWlSVGdnTG1RMkFZTWtUaTlBVEtLWmtHblljU0tTWGZRSTdwNnd6dGNW?=
 =?utf-8?B?OFFtS2M5QklHM295TW5Ga0tKYlVSTW1NVEROT1NmeTNaU3RIUVVCRExDbkFP?=
 =?utf-8?B?WmhyWE1pUER1ZG1EZEN3WlBxU0UwYVZWMzNRUGdFU29nYjY4MHV6TUtJUVN6?=
 =?utf-8?B?S2dRZy92SXhiN3llbTRiaXg0N2xyMUNCWncrcXVkQXV2REZ2ZGp3bWgyTUVJ?=
 =?utf-8?B?MUptaTdnalV5Y3dqRU5uaDJFb1phVXVNYTNkR1lvZ1YraXRkKzl1REpiVXN0?=
 =?utf-8?B?T0U3aXQzQnBqR3A3eG93TE1pdTNEckVDUWxSenBocmljd3d5WE8vVUVhcEl6?=
 =?utf-8?B?eG5VM2dYRTBCM3FxSCtuWFUyOU43Q05zQ2tUcElaV1g2dHZubVZJR0MydWhy?=
 =?utf-8?B?ZXdiRk93eUZYVjhDS2VXaHlQbkRTMmM3MWs2T0FpZGFGY2VDMzBNd1BhR09L?=
 =?utf-8?B?LzM0blJkaWJnVTVuaW9WK0xKeEJRNW1xZGk5dVNmT1hEbkl3dnphcng2MG00?=
 =?utf-8?B?NFl0VGFyWGJORS90NW1HV0pkeXRQMVNlN2pRcEpEZDV6cUFFcEtOL2dFS3VY?=
 =?utf-8?Q?VaTWfhmTNJ9ZQjGk=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e55aacd7-ff94-4a5c-1744-08debba56071
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 04:06:49.6117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xb6bsDdWhA4lllfsPFXU2tUUy05GTqmNE17O/Tim1KmNzpPK5MXq1DrwE81eqh5ESuxqREYwqkFu/bWiuCOBHJMqtd2GcNeXD9BkDDnJhjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR06MB9176
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[vaisala.com,reject];
	R_DKIM_ALLOW(-0.20)[vaisala.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-292088-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tapio.reijonen@vaisala.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[vaisala.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vaisala.com:email,vaisala.com:mid,vaisala.com:dkim]
X-Rspamd-Queue-Id: A65685DF1AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In fec_resume(), fec_enet_clk_enable() is called before
pinctrl_pm_select_default_state() in the non-WoL path, inverting the
ordering used in fec_suspend() which correctly switches to the sleep
pinctrl state before disabling clocks.

For PHYs with the PHY_RST_AFTER_CLK_EN flag (e.g. TI DP83848 or
SMSC LAN87xx), fec_enet_clk_enable() triggers a hardware reset pulse
via the phy-reset GPIO. With the GPIO pin still in sleep pinctrl state
at that point, the GPIO write has no physical effect and the PHY never
receives the required reset after clock enable, leading to unreliable
link establishment after system resume.

Fix by restoring the default pinctrl state before enabling clocks in the
non-WoL resume path, making resume the proper mirror of suspend.

Fixes: de40ed31b3c5 ("net: fec: add Wake-on-LAN support")
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
Changes in v2:
- Remove a stray blank line between the Fixes: tag and Signed-off-by:
  in the commit message; no functional change (per Wei Fang's review).
- Link to v1: https://lore.kernel.org/r/20260526-b4-fec-resume-pinctrl-order-v1-1-f2f926325424@vaisala.com
---
 drivers/net/ethernet/freescale/fec_main.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f89aa94ce0202d5f28f37362ce70e0943aa14025..723af4c057d7aeacb1e90301d95da52b79264400 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -5594,12 +5594,12 @@ static int fec_resume(struct device *dev)
 		if (fep->rpm_active)
 			pm_runtime_force_resume(dev);
 
-		ret = fec_enet_clk_enable(ndev, true);
-		if (ret) {
-			rtnl_unlock();
-			goto failed_clk;
-		}
 		if (fep->wol_flag & FEC_WOL_FLAG_ENABLE) {
+			ret = fec_enet_clk_enable(ndev, true);
+			if (ret) {
+				rtnl_unlock();
+				goto failed_clk;
+			}
 			fec_enet_stop_mode(fep, false);
 			if (fep->wake_irq) {
 				disable_irq_wake(fep->wake_irq);
@@ -5612,6 +5612,11 @@ static int fec_resume(struct device *dev)
 			fep->wol_flag &= ~FEC_WOL_FLAG_SLEEP_ON;
 		} else {
 			pinctrl_pm_select_default_state(&fep->pdev->dev);
+			ret = fec_enet_clk_enable(ndev, true);
+			if (ret) {
+				rtnl_unlock();
+				goto failed_clk;
+			}
 		}
 		fec_restart(ndev);
 		netif_tx_lock_bh(ndev);

---
base-commit: 79bd2dded182b1d458b18e62684b7f82ffc682e5
change-id: 20260526-b4-fec-resume-pinctrl-order-fde0cff2bbff

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>


