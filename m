Return-Path: <netdev+bounces-171728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A782A4E5EA
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 17:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE4619C5677
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 16:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775DE27814C;
	Tue,  4 Mar 2025 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mxZfu9sV"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4967424C09B;
	Tue,  4 Mar 2025 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104402; cv=fail; b=jW30AAPWhc7xTTVNAK1jEMQI+SWJ7iaRaqcKy0E/gvZulvlIKsT35H8rXFYOP/HFeWJJwSsm2zcjEo0o8zoOLSStXAOD122klYlX2hqR6byxX2N6hntOnfBmpjKu9burE/+rqitjJbearK92RK30tjR5I/N3rlUivk966QmJIc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104402; c=relaxed/simple;
	bh=FqLqJe7xJfo3M4LCDxD0irAsN+2DF27058x20KcmN0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NY0ulVcqNh2aO06dt14fOhq1gBNVXwb9Ku2eNuTTOHfT99PWZm6/t2ThWHluUBXcrWHlpaeV/D1l1lA1oZqBJNwb62iFlNKOC12BQ6gX5ENTU6CC9geRbaEHUgldpUcbQDn27w/UR0ACXNO1fvuIkua2ICyXx282g5CKvu8pWnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mxZfu9sV; arc=fail smtp.client-ip=40.107.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TyRBDWVnoHf8NgeoXIxVQfoVB1b2SOHHsSn9xdJ3CLgm35EvM8IWELscjqAb/Jp/+niZ52vGjW2kFyorFWr2QI5ogoIQX3SEbgbe/FWpvUj72X4KBKraqP/rY1VV/5VHPJtNKh+D70G9Ky6HTq+Mpwjyr6IDyyqJ5dwTfHNAmgzNfRv90Ci4lyQqsvPLWKDTjjt76wGYYDkvjXG0GDGaz8+13HhSUJP3LNsx/SY/eLZ5BuSstyJglqqAjrBVpb4kFauQDvA/djsorjFxlh3iDzOwPboqe7IG/XYIzgniGkGAXx5oiLEigjGGiRVtiVIYqpapSXmdMhLULIXMIsSAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSj+OpK+U03lZIw2rLNM5+2Xi3O6uS2EXjdWOQtOE5Y=;
 b=kQssUJ3UEzlcOySvJbG/xtDc/s0dmXOmSN+umL8A8VnE88DUSbjCHDgUHMACLXhlV9d2tBhVxz1ISxb1Hj3iMu3fzzQXcfO/hLH3+J38FR8qN5tCKTolGZgTdWdUIY57UqRYQKfnk6wvSBln2gJkCp5fg1UjMY+cmZiM6NCKq6NXOGgvLZOg5WsG3e2SlwiGo2cdVf0EE91NBwp16QQseEcSw/ggHRzJ67s0LGW5ASe8joh6OIctuTLksOqFISwuJ8HTmpvVPDjARGPV/aN32lcnUGuo+O3vIjPw7O+fFs7KFxSyQUy0Y1O2MQQT6H5M2FQlwD+1MnNIZLx9TpBA4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSj+OpK+U03lZIw2rLNM5+2Xi3O6uS2EXjdWOQtOE5Y=;
 b=mxZfu9sVoJChWsH/JRF3cAocQK4Vf8ZDJHI8yRVOPIH7gq/Qp5wRwzuESXCwe/ZQSBoHpvRZT49aue6JFwf8JNli5WlG6yGdI3i3iEwFJA+4hlSux33UbmFlgQdj1TP8fybEQtZH+BjjYvfvigIDEK0OE5D+LlN+nESbkzTeco/3xv6YlD7iGmXnChEs8mtyo1sI9cKPbTE7HGZ+wcgvjroTO7z2KXz8CZ1jymGPhY/C/62o+Kb2rxiKVB0CcNQj0bOVxYlGv/nVV+nymZlOw2a7DoCcSVEUFxlgG7n6o+ctCAc+Ct2W6EPh9Jftw4HoCqkmzhWOdy60hPPJEVtuqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22)
 by GVXPR04MB10304.eurprd04.prod.outlook.com (2603:10a6:150:1e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 16:06:36 +0000
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a]) by AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 16:06:36 +0000
From: Andrei Botila <andrei.botila@oss.nxp.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>
Subject: [PATCH net v2 0/2] net: phy: nxp-c45-tja11xx: add errata for TJA112XA/B
Date: Tue,  4 Mar 2025 18:06:12 +0200
Message-ID: <20250304160619.181046-1-andrei.botila@oss.nxp.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0166.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::33) To AS8PR04MB8216.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8216:EE_|GVXPR04MB10304:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e6c5ba-f650-4033-b5bf-08dd5b368a1a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6wQ5HLEMMjebjjEngkDfQ5UA0GBDiWWAf2JrVgN0kH7eaGLIFqzs9be67gTv?=
 =?us-ascii?Q?dqHjOeTxwsIbBqMarSHEIErhnK/cRhy9lLWAtufGJCAYU1AyvcJ4oJGwQseE?=
 =?us-ascii?Q?FYBTQy5Ebb+C9F2xCzZfFGWg/QaVesTXX6qne9ebpBClknFTsrvz4xIA9cDl?=
 =?us-ascii?Q?gnKe04VsU5H+vQHaZK04BL/IhbxO1XBwAymvavEwGKSu+zP8fiYbb6VQEG17?=
 =?us-ascii?Q?K2M9LiCcNBBZ9MkY7GW+jvh/UFxfnDGW4qpRR8O4apX5HjcqRL9mtWINJCmi?=
 =?us-ascii?Q?miSFjv33l+UE0rjJTrbx2AY5dj0MwBSzGmLy2tVtHBD6yZmyMZWsuqKT2G/J?=
 =?us-ascii?Q?uJmuVSGgTUYpOcKkdJQDfVSgfMGIFVkKyZGcZhcPa4r8ZlzPPpuLVN1GfDGE?=
 =?us-ascii?Q?a/UPe/6LAkFuzFyi4u8zaGBh34PKHWRm+CxJJKaPu0ZoDtYuf1gTnGygGJ+m?=
 =?us-ascii?Q?m01D3t66X7RMkhZElC0bSG0h4YNq+tumPiQhEMvGCXl7txJPWhh2XVnUA0EZ?=
 =?us-ascii?Q?mfy+BKelJmymE57565N+/iko8weNOaE7kh+GSF4KA6AuMY17BGj4sqgZHYbR?=
 =?us-ascii?Q?TVkRLkK0QaKmct0+2CzlASsaTyike5FQnUAKlEezZCSkcEtyD27iZwHhG5hv?=
 =?us-ascii?Q?PxbClLHVMfCyf0sRkEh5zktnIeb18L6E9BRorB7PUrtI86Jkvm3PdwewA1K1?=
 =?us-ascii?Q?0KIfDNuEx2zYnkjgHOgKet8s9xf62KVjrfX8jayGU7D5OqlXV/oBtnTtN+3c?=
 =?us-ascii?Q?76FRJV7ZRwHLnGf2A4rVSNnXRXs6uVZtAvHznr+3G7sz3GvnBZ0nmoWrSu8v?=
 =?us-ascii?Q?GzyEEsW0/hYsppi85jTZnlCYY5K40ii246Oy3uROiWQiYdKSnK/FoLV6SCw8?=
 =?us-ascii?Q?ULdypwODD1sbyi8Ko29BOgQTlkw5ZeIm3r9gAYdsj3iv+qPdaGgcovR4qhVW?=
 =?us-ascii?Q?mczRNOvoJ4IJjIFgf5lFRN3Fu/baLdYlvnOWeba9lRucsZjldu1q7J7gRC7n?=
 =?us-ascii?Q?Z6ChAsCnEd+F+4+u+so2JuicD1+56qxcRWPYnGEMB/DIvXrBXIbP99zAy3Vl?=
 =?us-ascii?Q?xXuMRgE3U2TJPqY5qoTX7VhkelOPv7aOOsjnsr8oy4ZBczWG5P8VAJR1vIwQ?=
 =?us-ascii?Q?w4teNImCwu7x9dgstywfR1atMxuaLCtWoNp9hY1RnAsSaFb9OQRRiIgN2ind?=
 =?us-ascii?Q?XNuZjeR2m6ruCB5X6xJ35bJVF1xnsbxPudiHEdHkW5PD/3tZdngmTGN2/G/q?=
 =?us-ascii?Q?RsJnqngXoiHBU+8TsFh7r0KhzxNcatm2DcKht7pikC4y9s18hxyLRAEm9hEk?=
 =?us-ascii?Q?CIYQmkLYh0Jl/9hAyPZVqa/YpvpbHJwageImYZ2aQZrCAMyAubKUwPjc5rXk?=
 =?us-ascii?Q?1iyfqrjVL3ajJ36/6RRXhHZpjZcM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?par4LFpsRUyunFjfcUyIgyvIkgSnzBjCpRkyfkholrsFX/3ofsa5j+tDEuf9?=
 =?us-ascii?Q?52OWhFrskvjOZgI4NnTug9IdmhjM00jX7+KxDpabtGmoNVOJzuY308fBJNZR?=
 =?us-ascii?Q?5e9wqwLz+CWZVzsmh2GrHzrCtuGwlubfooXx3JhJdifYQnpYqJLipSdlV4a+?=
 =?us-ascii?Q?NOOBHTRcCR0PyORYbXZeOQ6Ii4BypgpOLUVcM4Q1Ok00jGoRvqY66OrfaG+d?=
 =?us-ascii?Q?QQucc8UszdS70COpC1ZCVGPnUHWUwbvdL/dsossUm3EwewVAJIwKaqG9gYqD?=
 =?us-ascii?Q?JP6nU1oqM5l+MfCQ7RoaZofF7HkQUawlBuAOMHju/ix6pip1622HbBpUjzxu?=
 =?us-ascii?Q?qSp8aakqi+cnbVe3ud2uoKZ3PkL8WXR4223UAp3sEO/lSresntfLMqoJK9Ps?=
 =?us-ascii?Q?1umlsuP1N1DFp/n57V38Zdv9HeowGa8uISrwL7bwFHHyi/N33KlEJE82BGoL?=
 =?us-ascii?Q?LzZfmsVJMX3RxmuXmDvPDyeLo9i03auuay4SSj1OqEX3HFtJdIS/JxZZHUNl?=
 =?us-ascii?Q?dRRvy7th7SnuYY0LP1XcVexr2saIANJgt4YMbD5VeKLGghLOSTLLueaQn0Kp?=
 =?us-ascii?Q?7SCceKp3xFDsZUKop4HY4BDQn8vd1dYRkN+toYGLZGF1gIpCnzbxAdc3r72z?=
 =?us-ascii?Q?QFHKggQLgfoolMnRKVugbzB1lyc9e8ZjqoUaI9pYTE8/8xGa9cjBblazEv2C?=
 =?us-ascii?Q?helReNN+B5lKv2ovN+L2tyfRN+wWccHJ72/RhNuvzLgdNzwWKna2towfay4Y?=
 =?us-ascii?Q?nquU2ejymY/dScB6sqKTn9PolAmd5jPe0d7iH12bocGmsyIIaZJU3htEpMMp?=
 =?us-ascii?Q?IgRWMPwcl6bAVJErXHjBkk+HuoQj34WT0pJUdA74IAFRttHrZAf/FLyVPsGW?=
 =?us-ascii?Q?/TnIeqsCw624ARYycZqyxDXlJnwtD4/b3hUs+nQ6fhjok/6Xv5lzGeE8hsvT?=
 =?us-ascii?Q?BzQZLeqw9VhjUhFksGsvDkCuIQ0do8+hcDMNkTvLjEYJnkSquoEm+KGm1Q63?=
 =?us-ascii?Q?S1/vduAcpP+Ps1r7C3w2WfvuAMHk5qEJbp5T9TQMPSkrZP7vsBgAkJcM4ppY?=
 =?us-ascii?Q?vznnFWAmaNIrW6gXwXd6T/oB4AmZUlOaweBD118FJK+PMoYvgtRmdpztTS0M?=
 =?us-ascii?Q?r1MtpXfjQN1l4SrRXZo+p7kHmCQPnRR1BzeZLF4Ji17A61ptPh8L83fwupnH?=
 =?us-ascii?Q?nPN50A7GYUCc4jOvB/TbmBBazMXVcK/yvSWjETtgR5jrhCN5ZxyiSAGKdHI7?=
 =?us-ascii?Q?NbKTTqYvDULscMU7/4Vg4tJRbCgNwaVwNPxYhNdgcJyBdjucN9EiBmmMB+sC?=
 =?us-ascii?Q?pWKJ3x6FvIElQs54qEsr9raEv7v50WE4DsWl1YeQWoz5XviDQ1xyZ4j9p6p8?=
 =?us-ascii?Q?RbzpAZXDl4ls669AYQfcjLoV4/YpZM652UtLjrLKd01p5AHUj0V3rBRZVoqR?=
 =?us-ascii?Q?+BYBohPXcmK4SuU7gnbUb92cwwvZ/2IK4/gp+ashCPQWE+ZDwkTvu0YHUT/e?=
 =?us-ascii?Q?7V4xaKQu4J9y8k+Xdhfzbsw98t4VYms6NYjHOWmhCQDx+1qjHiOCxLERb9sb?=
 =?us-ascii?Q?NwmN2jH3YjrC/iX1/sBPF9ucHL8VVENjJSPn1JgZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e6c5ba-f650-4033-b5bf-08dd5b368a1a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:06:36.1069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bt55IHnQNNaq+Pkc3+FKvqrj0iKys3WZMzvyTJ7GlQ+2H4zXPv2DbpKDiv+FMCIp2uvfvazTHPa8ewQNCQjZ3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10304

This patch series implements two errata for TJA1120 and TJA1121.

The first errata applicable to both RGMII and SGMII version
of TJA1120 and TJA1121 deals with achieving full silicon performance.
The workaround in this case is putting the PHY in managed mode and
applying a series of PHY writes before the link gest established.

The second errata applicable only to SGMII version of TJA1120 and
TJA1121 deals with achieving a stable operation of SGMII after a
startup event.
The workaround puts the SGMII PCS into power down mode and back up
after restart or wakeup from sleep.

Changes in v2:
- use phy_id_compare() in case phydev->drv->phy_id is not set

Andrei Botila (2):
  net: phy: nxp-c45-tja11xx: add TJA112X PHY configuration errata
  net: phy: nxp-c45-tja11xx: add TJA112XB SGMII PCS restart errata

 drivers/net/phy/nxp-c45-tja11xx.c | 68 +++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

-- 
2.48.1


