Return-Path: <netdev+bounces-141460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400609BB020
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 10:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8929BB24E4B
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0B91ABECD;
	Mon,  4 Nov 2024 09:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="M4K5bo/t"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2110.outbound.protection.outlook.com [40.107.255.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC66E18B46D;
	Mon,  4 Nov 2024 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730713550; cv=fail; b=S/g8Tb7ncVTaS4BvywNZDNonGlul6z+FtjdaEVBAFD6DydEXPF6Gj5fTGKogW8j8IgKnKF1dcxFScU0RIkDftlCAbgX3XGBd+/gmHcuZ2MiUdAsWYqIrskTwA90t/jpyPfDdSuaS/iwoFMGlmOx3Yx7HoRrmRbzb34T+brpR3OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730713550; c=relaxed/simple;
	bh=Awsdpv9iJtd5RQsMBVrtFRu8Zd9UY7XK/Hr9EbUsDz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZwxponBmNizkOEhxmV0DXf+yXzL2u75Q2Tqn0Q1V33+CJj0u5iIHYS3pKHk6EEx+E74J6Xsvaoep6l1KmfdupczJ4dOyD4lMk/29GwWz3oS56sVdJBGBQW+pOE8eoFs4sm+fuU22eKOuz2FjxJ+2ECSMjx9zTCG22ZiJXWUZZls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=M4K5bo/t; arc=fail smtp.client-ip=40.107.255.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qs+jAypRb23QRWiWcbrWB+g+hEnh4zoL+dTL9ZuFrS3nRAFrT7RiXs6KGC4dzco/KD3QKrDz2Tx/IfVt5CpjQ83CsPMLycxq/RIKg1lufSTHN/ufxkvAESPGRCHvS6ZspUhbObqkzWPrIHXb9o5KjMUgUrbbuCWMH6g1nDNpHimy/mTnOeGFX7JEI2fimMABzY+/b+LVSMa2JwIfeKsZbweOK1vnst9hNXybTuH/uN85oLuUoAcggy+xTFwTwMDRzXmLvAETwPNIwZxmsfydKdLXfJQ0UT0qrW/DMxECzHQwW8FhlOeq8No0+RS3brPYr4YOsIO1ypfwqYLo4JKtcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZT4d0RlYtep/xw9LoODzoqU4/NPwsYW+uVi/V+DCSXk=;
 b=GwY5hxZpc4+q6Y8mES8ISaD/xPNZfe58yzh7WBpnXlzyxxy8vqGXOz2RGW+IMW1vj5WbZ4Q9MtTFddFOjpxwpnBHj0NSck7GtmGec0+1+m0PtaYR4FXZB1bvVN7be0AprUcrxv1CK0+Pt6qI2AxgN+ra8pekcwQT44vEWS4VxES9MD6oapL1CB7g6Gj9P8D8/WBNICOa3aEH0JH46ESJax8R5xVNcFzAMzBsHJl0SUAd4xK6lIJzEliIpBhMG3ICqNQylzUGDGSFs7rQaOduTVgLEPeep3wETzhL4QKeaOdv/B/6ESUoH/JGfz5H8MfF52IwUhAuNPbf9R0L0/QAkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZT4d0RlYtep/xw9LoODzoqU4/NPwsYW+uVi/V+DCSXk=;
 b=M4K5bo/tNDfosrqgsLTK4WkJBxPI9zNbcCY47JFbTUDpn3aWeySxzIDtm54PTHUa0Sm0WuqiZNa2PYsMfDuzow0YQzavji9EW9TSq5QNlG+Rbi+E8kTCyqrkN3Vb+HCL90nY2cNlFtjd4JBSHLG5P1ytScpdv8QJoLoNhmlERxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from SEZPR02MB5782.apcprd02.prod.outlook.com (2603:1096:101:4f::8)
 by TYZPR02MB5764.apcprd02.prod.outlook.com (2603:1096:400:1d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.28; Mon, 4 Nov
 2024 09:45:45 +0000
Received: from SEZPR02MB5782.apcprd02.prod.outlook.com
 ([fe80::4843:bf84:bd17:827e]) by SEZPR02MB5782.apcprd02.prod.outlook.com
 ([fe80::4843:bf84:bd17:827e%5]) with mapi id 15.20.8114.020; Mon, 4 Nov 2024
 09:45:45 +0000
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
	helgaas@kernel.org,
	danielwinkler@google.com,
	korneld@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v8 2/3] net: wwan: t7xx: Add debug ports
Date: Mon,  4 Nov 2024 17:44:35 +0800
Message-Id: <20241104094436.466861-3-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104094436.466861-1-jinjian.song@fibocom.com>
References: <20241104094436.466861-1-jinjian.song@fibocom.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To SEZPR02MB5782.apcprd02.prod.outlook.com
 (2603:1096:101:4f::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR02MB5782:EE_|TYZPR02MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ec3c78-0fab-4995-6b6d-08dcfcb57407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nTIqlIR896vRbiPWZ0sLRm7xF+u+94XzKL9vHEMFaFXDQCLtOYREBfp+gQHW?=
 =?us-ascii?Q?LEQ6LjbqgOOIeTUbC2T/2rV+SIdCDR9LJ9svhg2+3bsLM2Fs3UzITjLzReW4?=
 =?us-ascii?Q?0NAdQ9fOJThS7NBRMH3rDhdTG+pANRq9f5uIbXDbh3Irac7Qa6Zz0+wcBs8+?=
 =?us-ascii?Q?OmE24XC9F1ZG+6Hq/QFNuqIRtv87g8FjML9h2MyKj90ZH+PVTHqWoOCXMUuD?=
 =?us-ascii?Q?Y333SZtqLIrhg4Hhnkoy50lQxcSDdQFGVEkihwf5xGYnCcpnIbeGeGrRTaEN?=
 =?us-ascii?Q?7FscwR21AKgTPfoqy+VdS05bOgZ3uVKXgO8sYu5BFHM1Vo/DoysCT4N7fAl8?=
 =?us-ascii?Q?SnBZKsME5Pee5twEA3AUGliJ5+OGqwSp7Goed1nIPspmpYMQ0sYPdMTZ5kXU?=
 =?us-ascii?Q?tZc94imm9g2uJ0lUUOi/6/zhQlW8b98nHPL+cJ8muC4JuXsTLuFPiafwf+Fe?=
 =?us-ascii?Q?w8x3YxJR9UPOqOwusDDqntP5L+19B4uKkHsPECXjVphTJV1ih5kyO0GPGpU/?=
 =?us-ascii?Q?1c/Wl13i5adSndMB833f5zxy+OjITLAAjDnZevpumOmadOTVKhOdHBp+9nNR?=
 =?us-ascii?Q?XCHtCbv6ojHmr7nCFDN0tT77+VgDQ6bHuMI7ctVexmTRgcjR9vPBrF04zuPZ?=
 =?us-ascii?Q?WNySVdtK4BhfZu4LKe/5sBslsxAzdYyRJLe9regE2Cg9z0tNJXuV4h4D23im?=
 =?us-ascii?Q?AA+yBZzbSjxlm7+jRKHaYLOpKn3nRMuM/9qK21Qq503JkPFPbqePuILSfMa2?=
 =?us-ascii?Q?jp/HGPo74Jot+MGuY0Llmp/KlGpEHqZtjOO6rBSjCyl7+igMUUO4v6y45//g?=
 =?us-ascii?Q?UwatQgMhtUCdXZrrBXE5ca8VbfsqYOcyHXfl+vMghkGFSosKt+nWR3kxs8CM?=
 =?us-ascii?Q?OnkQRumI0/pvJshwXydg6KGhcQvwqGKo1T46NFriA+anEeSoCESOzNSp/2Tf?=
 =?us-ascii?Q?0fj785uTwUxV/argkCbsDmn38X5kTjHtTIGR9svuWat+byS4tbvdrlC+vwvX?=
 =?us-ascii?Q?C6LYPWyDO3CqrFh6aWm+CmyYuC3NB92r9uuWbJkB3LB27kMCn+lxSU8T8N1W?=
 =?us-ascii?Q?9uWljjtZbz2DKjtpRjzegS8orAwGjvorBW/XlEIcufRar0V+i+lSsUu7FL9k?=
 =?us-ascii?Q?9yCv+cI0+FbaQTxYnUgocSFpK1h7YUliUi1Bykb+M5zoFKCpBBV0aqtzFzHJ?=
 =?us-ascii?Q?3ao8xBUBhsvKAaJvGHouZu65Mv+IvkVHDnUOez0HlntksGK9vAy7VjaFV4V5?=
 =?us-ascii?Q?xrwHm/ZZ0ekNbntIDLkH71BRhEr35dCsTcx1WXxFfwVMhDTEcLO4TwzlLedW?=
 =?us-ascii?Q?4idj6aeGq3rRPteG3nFyK8fA3JAzp+b25iNaBJgUb3IzAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR02MB5782.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oRM4u8Us3cH4fkgFuQTQ0G/69CZa1Ivw1+/dlIc/algIFA0Xa/4pQ78j+Gm5?=
 =?us-ascii?Q?rR8dKfiixVe6NS02e5i2LHuCFghVb9oNo8pvlRNZI2b3c/85AMvowJKYrTIp?=
 =?us-ascii?Q?S9MptHcJXRwYsWWh2Qepz7PJSfzakHby1zz3LYtgdhh2iFQ5OoCWYZK8QVX9?=
 =?us-ascii?Q?ZWIPR2lhgUaZ4hWHrqGr1/yUuBYF/tFfVUhG9XbExM1rv/5kY1zHxo0iGDik?=
 =?us-ascii?Q?t0loPOdQNn1Z6yhqaN9GVaMR2LSP1c+RKT31NuLDojFJX2GhibfjajK1LtDL?=
 =?us-ascii?Q?xnTjKNBwAolWA6T+63caZ/meaDlqUVdNdUSL6pmKBbx/JbZAdtV/egFsQODk?=
 =?us-ascii?Q?ffd/HmgLI3V1dOo37SaPeVZygR1Xb+plQc5J4eARcPl6Y4l4GwPskylyopwt?=
 =?us-ascii?Q?g2cEu5ODbgmf3rM6b78FxpHQ8IC7aoSkaTtnuvJ6Ggo7F1HBzdw+x1DXPyiW?=
 =?us-ascii?Q?A0fd7vqIEKrgJ6BtWK80V3e6s9Gb/xLmg5O3URKqbNCQZKrsXAne0IACrHym?=
 =?us-ascii?Q?mvIYsGZ1FldzhaqFaNIC/0NJ4sNIC5K3izH/3R4c0I3QOG7VwCz3/vQkxhPG?=
 =?us-ascii?Q?RH/aHnl6i5963ouOUQYqwYfXPqVZEHGqX4CxS2z5n2lP7WpzBH5bzn1zuMbO?=
 =?us-ascii?Q?9uYOTva71bJ3an1WRmMzhI7TFBq5WHinkUfbKhalFxkO2qjn2rtt/YrMDXA+?=
 =?us-ascii?Q?yZPYDgLTWJHuruKuaVB7s/ecignB8DsET9Jyv9Ctzx2+s3hYZRJtm9YilOUH?=
 =?us-ascii?Q?MedED3UTu4vCHQ6wHjBg6FX27GY11F1vN7kH+GzS89fQQPLeroLMQpeZ6r8Y?=
 =?us-ascii?Q?GPnn7FyINiBJgQ5u014xVCRrM7LW3/koGjT1F3ziuVG2Eq4baUnxOIh84gFj?=
 =?us-ascii?Q?FwT5gydjKVM0Xw/LPsIbUx4u+N0wSF3dAlIv9rUJkk0ZnBMK9A6/V/VRCzjU?=
 =?us-ascii?Q?Z+j1gmn1n8aWE8lGKhCHIkd+I1FnKZDrRZoOCBox0MsgZ+JB26rvbv8DpABs?=
 =?us-ascii?Q?jY8SoUKt+LifsH08vNmSVsmK3sX8qqq/+8KDJu91EIOUUZmrIfqg76m8CIO5?=
 =?us-ascii?Q?vsPVk+L2qnvDJovI36JdwsNnFF8qVzlCpJ408dW1zd0dC9HZ3xd5rKFViQ+W?=
 =?us-ascii?Q?fCxi2YzFSGMl7ItVSiZfAQaGL0k71BcXzVUktzA5dsP6RrgbQMJdKt36qC7m?=
 =?us-ascii?Q?xvWypHhEBKPKWcNBPHBXuLYZYyFCI8Rds2WulUrDpuF0Iusr1Eru0xRvghSA?=
 =?us-ascii?Q?I/TfOcb/EQjckTbqAmfp9K+mJ7MkaIYk1poL0X+9o0WvfImEZRrT++EPPk1H?=
 =?us-ascii?Q?92AgSAuZMRW+Z8tBKZmcof+XcLqMdSpZyGMkRefGELJBv3iWJVN0vEzTRx2b?=
 =?us-ascii?Q?N1V1kFGeWDnZuwDs9hPv7/Ywbiy4hf3IVVUmllg2kUbI74ZM0haMmoAaMXkJ?=
 =?us-ascii?Q?TXlzCm5BfrGLA0GHul55d5EYVpQchRuycsQCcYcwqf3jWkJmrz2JrMyQQhpI?=
 =?us-ascii?Q?IAvt20wptzG8Gp5xbnNJhV6KjEkYJV+WppqOyHe3cZw2ugXjRyDRVyQFYD8B?=
 =?us-ascii?Q?5IsIB7WhrGFwsDhHThzbDuMAqQw5ob/GK2jUtoMM4HUXpUklvs3YK+Bj7/Zu?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ec3c78-0fab-4995-6b6d-08dcfcb57407
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB5782.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 09:45:45.1321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9m+Ordvpo0AsiKnvXsWUQmS92tAoXUsDvj+jGqi+y4WeKk6j5mO33Jf1y/UhtcPP+EPv71A24AUNB9QuKj6iS1v2o0ffankfXV8qUxBPd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5764

Add support for userspace to enable/disable the debug ports(ADB,MIPC).
 - ADB port: /dev/wwan0adb0
 - MIPC port: /dev/wwan0mipc0

Application can use ADB (Android Debug Bridge) port to implement
functions (shell, pull, push ...) by ADB protocol commands.
E.g., ADB commands:
 - A_OPEN: OPEN(local-id, 0, "destination")
 - A_WRTE: WRITE(local-id, remote-id, "data")
 - A_OKEY: READY(local-id, remote-id, "")
 - A_CLSE: CLOSE(local-id, remote-id, "")

Link: https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/main/README.md

Application can use MIPC (Modem Information Process Center) port
to debug antenna tuner or noise profiling through this MTK modem
diagnostic interface.

By default, debug ports are not exposed, so using the command
to enable or disable debug ports.

Enable debug ports:
 - enable: 'echo 1 > /sys/bus/pci/devices/${bdf}/t7xx_debug_ports

Disable debug ports:
 - disable: 'echo 0 > /sys/bus/pci/devices/${bdf}/t7xx_debug_ports

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v8:
 * Rename knod t7xx_port_mode to t7xx_debug_ports and update commit
   messages
 * Modify the alignment in knod t7xx_debug_ports_store() and
   t7xx_debug_ports_show()
 * Separate the column width modification of t7xx.rst into another
   patch
 * Rename t7xx_proxy_port_debug() to t7xx_proxy_debug_ports_show()
 * Modify the port_mode to debug_ports_show in struct t7xx_pci_dev
 * Modify the Q_IDX_MBIM to Q_IDX_MBIM_MIPC and delete the
   Q_IDX_MIPC to avoid id name duplications
 * Modify the conditional check in t7xx_proxy_debug_ports_show()
   to make port init() and uninit() call safer
v7:
 * Adjust t7xx.rst columns and word spelling in commit message
v5:
 * Modify line length warning in t7xx_proxy_port_debug()
v4:
 * Modify commit message t7xx_mode to t7xx_port_mode
v3:
 * Add sysfs interface t7xx_port_mode
 * Delete spin_lock_init in t7xx_proxy_port_debug()
 * Modify document t7xx.rst
v2:
 * Add WWAN ADB and MIPC port
---
 .../networking/device_drivers/wwan/t7xx.rst   | 47 +++++++++++++++
 drivers/net/wwan/t7xx/t7xx_modem_ops.c        |  1 +
 drivers/net/wwan/t7xx/t7xx_pci.c              | 58 +++++++++++++++++--
 drivers/net/wwan/t7xx/t7xx_pci.h              |  1 +
 drivers/net/wwan/t7xx/t7xx_port.h             |  3 +
 drivers/net/wwan/t7xx/t7xx_port_proxy.c       | 51 ++++++++++++++--
 drivers/net/wwan/t7xx/t7xx_port_proxy.h       |  1 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c        |  8 ++-
 8 files changed, 157 insertions(+), 13 deletions(-)

diff --git a/Documentation/networking/device_drivers/wwan/t7xx.rst b/Documentation/networking/device_drivers/wwan/t7xx.rst
index f346f5f85f15..4cf777c341cd 100644
--- a/Documentation/networking/device_drivers/wwan/t7xx.rst
+++ b/Documentation/networking/device_drivers/wwan/t7xx.rst
@@ -67,6 +67,28 @@ Write from userspace to set the device mode.
 ::
   $ echo fastboot_switching > /sys/bus/pci/devices/${bdf}/t7xx_mode
 
+t7xx_debug_ports
+----------------
+The sysfs interface provides userspace with access to enable/disable the debug
+ports, this interface supports read and write operations.
+
+Debug port status:
+
+- ``1`` represents enable debug ports
+- ``0`` represents disable debug ports
+
+Currently supported debug ports (ADB/MIPC).
+
+Read from userspace to get the current debug ports status.
+
+::
+  $ cat /sys/bus/pci/devices/${bdf}/t7xx_debug_ports
+
+Write from userspace to set the debug ports status.
+
+::
+  $ echo 1 > /sys/bus/pci/devices/${bdf}/t7xx_debug_ports
+
 Management application development
 ==================================
 The driver and userspace interfaces are described below. The MBIM protocol is
@@ -139,6 +161,25 @@ Please note that driver needs to be reloaded to export /dev/wwan0fastboot0
 port, because device needs a cold reset after enter ``fastboot_switching``
 mode.
 
+ADB port userspace ABI
+----------------------
+
+/dev/wwan0adb0 character device
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The driver exposes a ADB protocol interface by implementing ADB WWAN Port.
+The userspace end of the ADB channel pipe is a /dev/wwan0adb0 character device.
+Application shall use this interface for ADB protocol communication.
+
+MIPC port userspace ABI
+-----------------------
+
+/dev/wwan0mipc0 character device
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The driver exposes a diagnostic interface by implementing MIPC (Modem
+Information Process Center) WWAN Port. The userspace end of the MIPC channel
+pipe is a /dev/wwan0mipc0 character device.
+Application shall use this interface for MTK modem diagnostic communication.
+
 The MediaTek's T700 modem supports the 3GPP TS 27.007 [4] specification.
 
 References
@@ -164,3 +205,9 @@ speak the Mobile Interface Broadband Model (MBIM) protocol"*
 [5] *fastboot "a mechanism for communicating with bootloaders"*
 
 - https://android.googlesource.com/platform/system/core/+/refs/heads/main/fastboot/README.md
+
+[6] *ADB (Android Debug Bridge) "a mechanism to keep track of Android devices
+and emulators instances connected to or running on a given host developer
+machine with ADB protocol"*
+
+- https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/main/README.md
diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
index 79f17100f70b..7968e208dd37 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
@@ -198,6 +198,7 @@ int t7xx_reset_device(struct t7xx_pci_dev *t7xx_dev, enum reset_type type)
 	pci_save_state(t7xx_dev->pdev);
 	t7xx_pci_reprobe_early(t7xx_dev);
 	t7xx_mode_update(t7xx_dev, T7XX_RESET);
+	WRITE_ONCE(t7xx_dev->debug_ports_show, false);
 
 	if (type == FLDR) {
 		ret = t7xx_acpi_reset(t7xx_dev, "_RST");
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index e556e5bd49ab..7b8c17b029c7 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -41,6 +41,7 @@
 #include "t7xx_pcie_mac.h"
 #include "t7xx_reg.h"
 #include "t7xx_state_monitor.h"
+#include "t7xx_port_proxy.h"
 
 #define T7XX_PCI_IREG_BASE		0
 #define T7XX_PCI_EREG_BASE		2
@@ -120,13 +121,58 @@ static ssize_t t7xx_mode_show(struct device *dev,
 
 static DEVICE_ATTR_RW(t7xx_mode);
 
-static struct attribute *t7xx_mode_attr[] = {
+static ssize_t t7xx_debug_ports_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct t7xx_pci_dev *t7xx_dev;
+	struct pci_dev *pdev;
+	bool show;
+	int ret;
+
+	pdev = to_pci_dev(dev);
+	t7xx_dev = pci_get_drvdata(pdev);
+	if (!t7xx_dev)
+		return -ENODEV;
+
+	ret = kstrtobool(buf, &show);
+	if (ret < 0)
+		return ret;
+
+	t7xx_proxy_debug_ports_show(t7xx_dev, show);
+	WRITE_ONCE(t7xx_dev->debug_ports_show, show);
+
+	return count;
+};
+
+static ssize_t t7xx_debug_ports_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct t7xx_pci_dev *t7xx_dev;
+	struct pci_dev *pdev;
+	bool show;
+
+	pdev = to_pci_dev(dev);
+	t7xx_dev = pci_get_drvdata(pdev);
+	if (!t7xx_dev)
+		return -ENODEV;
+
+	show = READ_ONCE(t7xx_dev->debug_ports_show);
+
+	return sysfs_emit(buf, "%d\n", show);
+}
+
+static DEVICE_ATTR_RW(t7xx_debug_ports);
+
+static struct attribute *t7xx_attr[] = {
 	&dev_attr_t7xx_mode.attr,
+	&dev_attr_t7xx_debug_ports.attr,
 	NULL
 };
 
-static const struct attribute_group t7xx_mode_attribute_group = {
-	.attrs = t7xx_mode_attr,
+static const struct attribute_group t7xx_attribute_group = {
+	.attrs = t7xx_attr,
 };
 
 void t7xx_mode_update(struct t7xx_pci_dev *t7xx_dev, enum t7xx_mode mode)
@@ -839,7 +885,7 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	t7xx_pcie_mac_interrupts_dis(t7xx_dev);
 
 	ret = sysfs_create_group(&t7xx_dev->pdev->dev.kobj,
-				 &t7xx_mode_attribute_group);
+				 &t7xx_attribute_group);
 	if (ret)
 		goto err_md_exit;
 
@@ -855,7 +901,7 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 err_remove_group:
 	sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
-			   &t7xx_mode_attribute_group);
+			   &t7xx_attribute_group);
 
 err_md_exit:
 	t7xx_md_exit(t7xx_dev);
@@ -870,7 +916,7 @@ static void t7xx_pci_remove(struct pci_dev *pdev)
 	t7xx_dev = pci_get_drvdata(pdev);
 
 	sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
-			   &t7xx_mode_attribute_group);
+			   &t7xx_attribute_group);
 	t7xx_md_exit(t7xx_dev);
 
 	for (i = 0; i < EXT_INT_NUM; i++) {
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index cd8ea17c2644..b25d867e72d2 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.h
+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
@@ -94,6 +94,7 @@ struct t7xx_pci_dev {
 	struct dentry		*debugfs_dir;
 #endif
 	u32			mode;
+	bool			debug_ports_show;
 };
 
 enum t7xx_pm_id {
diff --git a/drivers/net/wwan/t7xx/t7xx_port.h b/drivers/net/wwan/t7xx/t7xx_port.h
index f74d3bab810d..9f5d6d288c97 100644
--- a/drivers/net/wwan/t7xx/t7xx_port.h
+++ b/drivers/net/wwan/t7xx/t7xx_port.h
@@ -42,6 +42,8 @@ enum port_ch {
 	/* to AP */
 	PORT_CH_AP_CONTROL_RX = 0x1000,
 	PORT_CH_AP_CONTROL_TX = 0x1001,
+	PORT_CH_AP_ADB_RX = 0x100a,
+	PORT_CH_AP_ADB_TX = 0x100b,
 
 	/* to MD */
 	PORT_CH_CONTROL_RX = 0x2000,
@@ -100,6 +102,7 @@ struct t7xx_port_conf {
 	struct port_ops		*ops;
 	char			*name;
 	enum wwan_port_type	port_type;
+	bool			debug;
 };
 
 struct t7xx_port {
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
index 35743e7de0c3..4fc131f9632f 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -38,7 +38,8 @@
 #include "t7xx_state_monitor.h"
 
 #define Q_IDX_CTRL			0
-#define Q_IDX_MBIM			2
+#define Q_IDX_MBIM_MIPC		2
+#define Q_IDX_ADB			3
 #define Q_IDX_AT_CMD			5
 
 #define INVALID_SEQ_NUM			GENMASK(15, 0)
@@ -66,8 +67,8 @@ static const struct t7xx_port_conf t7xx_port_conf[] = {
 	}, {
 		.tx_ch = PORT_CH_MBIM_TX,
 		.rx_ch = PORT_CH_MBIM_RX,
-		.txq_index = Q_IDX_MBIM,
-		.rxq_index = Q_IDX_MBIM,
+		.txq_index = Q_IDX_MBIM_MIPC,
+		.rxq_index = Q_IDX_MBIM_MIPC,
 		.path_id = CLDMA_ID_MD,
 		.ops = &wwan_sub_port_ops,
 		.name = "MBIM",
@@ -100,7 +101,27 @@ static const struct t7xx_port_conf t7xx_port_conf[] = {
 		.path_id = CLDMA_ID_AP,
 		.ops = &ctl_port_ops,
 		.name = "t7xx_ap_ctrl",
-	},
+	}, {
+		.tx_ch = PORT_CH_AP_ADB_TX,
+		.rx_ch = PORT_CH_AP_ADB_RX,
+		.txq_index = Q_IDX_ADB,
+		.rxq_index = Q_IDX_ADB,
+		.path_id = CLDMA_ID_AP,
+		.ops = &wwan_sub_port_ops,
+		.name = "adb",
+		.port_type = WWAN_PORT_ADB,
+		.debug = true,
+	}, {
+		.tx_ch = PORT_CH_MIPC_TX,
+		.rx_ch = PORT_CH_MIPC_RX,
+		.txq_index = Q_IDX_MBIM_MIPC,
+		.rxq_index = Q_IDX_MBIM_MIPC,
+		.path_id = CLDMA_ID_MD,
+		.ops = &wwan_sub_port_ops,
+		.name = "mipc",
+		.port_type = WWAN_PORT_MIPC,
+		.debug = true,
+	}
 };
 
 static const struct t7xx_port_conf t7xx_early_port_conf[] = {
@@ -505,13 +526,33 @@ static void t7xx_proxy_init_all_ports(struct t7xx_modem *md)
 		spin_lock_init(&port->port_update_lock);
 		port->chan_enable = false;
 
-		if (port_conf->ops && port_conf->ops->init)
+		if (!port_conf->debug &&
+		    port_conf->ops &&
+		    port_conf->ops->init)
 			port_conf->ops->init(port);
 	}
 
 	t7xx_proxy_setup_ch_mapping(port_prox);
 }
 
+void t7xx_proxy_debug_ports_show(struct t7xx_pci_dev *t7xx_dev, bool show)
+{
+	struct port_proxy *port_prox = t7xx_dev->md->port_prox;
+	struct t7xx_port *port;
+	int i;
+
+	for_each_proxy_port(i, port, port_prox) {
+		const struct t7xx_port_conf *port_conf = port->port_conf;
+
+		if (port_conf->debug && port_conf->ops) {
+			if (show && port_conf->ops->init)
+				port_conf->ops->init(port);
+			else if (!show && port_conf->ops->uninit)
+				port_conf->ops->uninit(port);
+		}
+	}
+}
+
 void t7xx_port_proxy_set_cfg(struct t7xx_modem *md, enum port_cfg_id cfg_id)
 {
 	struct port_proxy *port_prox = md->port_prox;
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.h b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
index 7f5706811445..f0918b36e899 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
@@ -98,6 +98,7 @@ extern struct port_ops ctl_port_ops;
 extern struct port_ops t7xx_trace_port_ops;
 #endif
 
+void t7xx_proxy_debug_ports_show(struct t7xx_pci_dev *t7xx_dev, bool show);
 void t7xx_port_proxy_reset(struct port_proxy *port_prox);
 void t7xx_port_proxy_uninit(struct port_proxy *port_prox);
 int t7xx_port_proxy_init(struct t7xx_modem *md);
diff --git a/drivers/net/wwan/t7xx/t7xx_port_wwan.c b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
index 4b23ba693f3f..7fc569565ff9 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_wwan.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
@@ -169,7 +169,9 @@ static int t7xx_port_wwan_init(struct t7xx_port *port)
 {
 	const struct t7xx_port_conf *port_conf = port->port_conf;
 
-	if (port_conf->port_type == WWAN_PORT_FASTBOOT)
+	if (port_conf->port_type == WWAN_PORT_FASTBOOT ||
+	    port_conf->port_type == WWAN_PORT_ADB ||
+	    port_conf->port_type == WWAN_PORT_MIPC)
 		t7xx_port_wwan_create(port);
 
 	port->rx_length_th = RX_QUEUE_MAXLEN;
@@ -224,7 +226,9 @@ static void t7xx_port_wwan_md_state_notify(struct t7xx_port *port, unsigned int
 {
 	const struct t7xx_port_conf *port_conf = port->port_conf;
 
-	if (port_conf->port_type == WWAN_PORT_FASTBOOT)
+	if (port_conf->port_type == WWAN_PORT_FASTBOOT ||
+	    port_conf->port_type == WWAN_PORT_ADB ||
+	    port_conf->port_type == WWAN_PORT_MIPC)
 		return;
 
 	if (state != MD_STATE_READY)
-- 
2.34.1


