Return-Path: <netdev+bounces-240961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B9DC7CE03
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 12:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 776F34E30C6
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 11:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9232C21C0;
	Sat, 22 Nov 2025 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SZtS0uQC"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010037.outbound.protection.outlook.com [52.101.69.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5401321255A
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763810034; cv=fail; b=ptXrPbVDNiE/JDAT8lLvUACYzABlC1DB3X83Q6h6PtzJFI6iLMdNYfT2vkfxUa6JFrWvqaMCH1FlXA2F1B4PklWqcMHOZc7rBkxWBLGf3Xbe2y/tSJF0kuMW6Rt06KrEE56dGnaSQBAwI/kM4pUTU22/9y1F9PjkuBpfLTrmN8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763810034; c=relaxed/simple;
	bh=CfeAo93amPBo+tBA07E54TYbR+AGKy9C29FnyWMhub0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZBXueApdJw2/7AsfWUzOOOnyAUyWkD1dnF5IpSFELkbnh1qQA+hF1eBPLG+E7xCwO3VZe/2Jfx4D+g6DWQ9jhAs4EAAmtRb4RQSERbR07LzFSrvQhPZ26+XeeRV85Np8oVXnZSm9VRQtWQmI/zWsjC0URYokrjEB3mM6WKhWTJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SZtS0uQC; arc=fail smtp.client-ip=52.101.69.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRslXgSk6ffZawHcOv5YmXIfLlg8ZXEU0cl/bQk4HvQvgSn8dqbaK/0SXDsPGpKJNZjm6MsHhQlZGvkSVezLQQyGVeviOWcOEUncRAZWpX4yzB8dHJPtEu/nQ8ZvuRYsu7U5+JtwczUGbLBmRJpH10YW9w31Oixz9Jjxa486zdQigyQL7s45MFRP1RJ4Lvf6X629BBAgkmhJoQW/dtxc21ajQKUuqHAxf/97MERucja6LOLqXdcj5iDnstOaBi1IwlGMqohWN4svLKvhr8EwVuFB9lMDqADKDHJBUE9bLlvJyp95+FpamkLf0XM7AnvOmju4HsgXBRQLKr9doIS0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47Af+lgR6Umj8Hht0A+FVL9n23penDjOmpftai6t1OE=;
 b=GWU46N+B0iC0wCEzMrc5h/5gUAixkg4N0QNRj7zLq8QJB5bmLMJNfrUg+bD/7+GfzKOPrfZqpA1Ssk9yDs6Rt0ZklbLhVBlDrJe26EY5xQXPHd1xasqZD4aBKy+yhhOF/1jPkaaax1l78jCXTVhWWGOy2877E1igshlu/aSpIh1AQxAyiSC4FbQjjfrVJloc1KWsrJ8g2eCZoumo4JaH/1xVH1rII5M9bChdkWBtseWzebTpUpbpotVbAHLe5UBKbkFi4ZwEQah2K3nhWmUpJuSUc2T+EI+y4HxZF9lJdYHOVpNGeSqpXnFrYsJTJizVdf5KUToE762zjnarDGrjgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47Af+lgR6Umj8Hht0A+FVL9n23penDjOmpftai6t1OE=;
 b=SZtS0uQCkofFn1WJv6d6gEL7zRFLwpE0oTKRpiG9bWe3RaJ4mNwwgxTyF12lzxIwrOEQrSn/gsJ4pGIFhaZCiXubnukfjWXKugkpd2T8bIzP4ZNOsjpD9v6WFHO5WEqvYw4oYlcLoigpKtskUbg/OckxuOnZPjnjIKTBawas1mlNRJc2OKbT3GlBzjU0LLYwjdxDN51Z2t66DxSKK5xo0mAuCsguBkKIwm7oAMFOMJTilVI5W0lZ74F/LJCNnQeLc/6cMdOiQOxJNQ7p6/7vTxbs0INFYl/01hsewxKwpkeYWbydsJVnxexYz1dKX7XESXoZpou1kG86hBfdxBhI1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB9678.eurprd04.prod.outlook.com (2603:10a6:102:23c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Sat, 22 Nov
 2025 11:13:49 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 11:13:48 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net] net: dsa: sja1105: fix SGMII linking at 10M or 100M but not passing traffic
Date: Sat, 22 Nov 2025 13:13:24 +0200
Message-Id: <20251122111324.136761-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0009.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::12) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB9678:EE_
X-MS-Office365-Filtering-Correlation-Id: cd03518d-ef52-4858-b03e-08de29b835a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|19092799006|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rUSIjl+kfh3yh0hmyEPDYsSJJGO476t2Pmw8NXrdVXKFqNaOJYBB6XzEJxvL?=
 =?us-ascii?Q?ri0Rv+b5MF0E45Ibn6CD02hlh8z6GD4b0htNJD5/Ka2lgHUXIpZkYx3j255/?=
 =?us-ascii?Q?SGJdhQS0/vo8JHswtH5fXHIOCFQg6jswIYkNXFjp7tU1pRkb4+rX7AxaU3kq?=
 =?us-ascii?Q?ab6ruApxo1e65YAu9nW/MuU+MUmxwnA9/z23oxlVzocA4jgdehjXYUElaerN?=
 =?us-ascii?Q?h79IJ74uRUFaGndotULB2BYy5RpKSzp6bVV2c6bxqcOI3urnGqZ5i58pbDOC?=
 =?us-ascii?Q?EmBJCKgFIZ2GXenxuI/IVZvCtreC+PaN8jHcJGKpxm4eP/sCw861EA0qv1im?=
 =?us-ascii?Q?HNx7oITVwGZdgPCIru5aQwY9OmhyIm1tdvfHW+R1UobgoCxeVgLs13HId1UZ?=
 =?us-ascii?Q?NuRyK0zAUrog8sLQU4AXDTzuBXB6sYRLOWubSqpdxjjk3fGwjzi53S2bzbed?=
 =?us-ascii?Q?dDXpev6NEgM6mTbIv8Mqf0tXs8OH7ZH+e1nn4YBYUGeCjq9mHopXxruiVGNv?=
 =?us-ascii?Q?ev6E5Ywzg17Uc4SSjdsJZKz8ClaCh6KN4N97kn+edftH5tnYsnzrPztnY1+6?=
 =?us-ascii?Q?K+DZOxCR4xw73IxSalqhrdde5UPbXfYWuf2sRjJlf0FnNMOoaxRzlEJSoMDA?=
 =?us-ascii?Q?TzyLbwgHIo1JPOb1Fos6HqxtcUXnz+OCwXBAzwfvUiAnEfuePJaVRK33qQ+F?=
 =?us-ascii?Q?+L2UBi7igQNlgapRiNN3CCBynRGLQCVWOl/B/7X16D5PyFEIq53XAZxYeAzF?=
 =?us-ascii?Q?xA02wP9qXvjjVw+XTC2kBaUOyfDQwnp8KsM3SO0fITgjDkGWqfKIWTxICUQm?=
 =?us-ascii?Q?oMXo0pYeBVfxBMGXrXteWbEjNyIcuwsfoFWXdRNFw+0CgkNKz16lJyjyzll/?=
 =?us-ascii?Q?4gbqbeUebQUqv9CqedgPlcB1Ti8t1aB7iKSYGTrBDIl4/hP6YIoMMnWrYRXr?=
 =?us-ascii?Q?bwA2e3ejsU1w3dM9bNKlGApMSfZTxMltFU11kqA9Qkg2gVYBtdCecIoqKCL4?=
 =?us-ascii?Q?o9wEVbAFE++kcSAz3F25loLOHtgP0d6CEQp65n53EaWszybEi790nXmMKC0W?=
 =?us-ascii?Q?eUIB2qGL/8M3dNKw8Susdq+HbE0SwMAqhHUc+JCaL0FvgBXSo2ZMFyzzuZ9T?=
 =?us-ascii?Q?XwuNxFm7389O2ZPb50yMuEKMdvFMGQz1g0kYwuHgdLh35KE88tMSYdcfUALU?=
 =?us-ascii?Q?wuxDHjWmzKBBHqYbwU8y7x/KFHI4iHpgXtQ+C+Kv6+p3SS2qulLIAP4QRvH+?=
 =?us-ascii?Q?Udm6CIDrad17NeCkjChWLXNpkmfgDfRzSRkJCXBBCf1cnlQHdywYYZFnWPco?=
 =?us-ascii?Q?J3/hJOGuVVc5n/eDstmeFz7zAH93YK0flUKuBXyA8HktFfupyIfX1C36e5rh?=
 =?us-ascii?Q?ZFEE7omoyfLQW6jWB9ElCfdPJsOkvsAQW6BzFIjAPy8Sm68OTqXQ014uLtFp?=
 =?us-ascii?Q?Yv/bdkGREP3hMEgmF6t0Y/KWhX+jyXH0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(19092799006)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IHklUABrnwCui2nm8zJY+SGkg7Y+mL/veNpqvr+fqnRgPjiP1h85TMrTu+GE?=
 =?us-ascii?Q?ihHWZMNGkoxk2gUBYIvhGn1fHIu4OoaB0A+wwVwW4P70yS/9MjCSe3dABRPQ?=
 =?us-ascii?Q?eM7RORmWSnFk+y6Q4VBJA883TKa/X8XNN3mHfQ482ugWFHbI1lEGKJIDNuCi?=
 =?us-ascii?Q?fU8yfemuYtZFu9jiVt1RbuSXWu1mhskZ8JOhE1TwTs+lwbCTQTiMK6EckETK?=
 =?us-ascii?Q?jGIRdbFjJNHynxZFpv3xN4YoSGi3u34ePlcAIAP+qdtockbTBcviMrW4qsip?=
 =?us-ascii?Q?KPOWplrPy15OOw7fxsKrdW2WAybbeoETkB184HY6m6r1+FPfy/G3awb+ZhGv?=
 =?us-ascii?Q?kvZ1fniWLXtvvegu9SQnTN07nYnhD22SdyV1EG2PxTDtddhUbWdQyc8MduyZ?=
 =?us-ascii?Q?ogD2BbsltCqvfkxKNUAgkxfHIpqgiaeWQx++Y5HfBK3PsRyvNmkKvHwAEjoj?=
 =?us-ascii?Q?9H6cuHUMIr1DtHT1JbwvjaIwB12iltf5HiFiROmh53f2sKAglVccohrhnbiH?=
 =?us-ascii?Q?LjeqP2x577O49YdLW/AmznblH7ylFew8WYUhi93xhQLuVkHLnJ+bnsAkYfTj?=
 =?us-ascii?Q?hXxFTFqnP8vbL1qqxYKLL64/qGx9zdp/Ktd32DjRGLWE+atDbvjOncxJ4X9p?=
 =?us-ascii?Q?jYazq9TRpgP9uFUA04vHEwvbYY8JAsJp38a4qf5nfvufGO6Jo6Z/0/JMYW68?=
 =?us-ascii?Q?KDfoTmounExfRb49VFlD4OvasScxySDrGdUMcv5XJK/cOY6UVsuUnap0F66A?=
 =?us-ascii?Q?MxQUTHXtmvvmyxY/JRRNGqfX83t8mCvTmxj2jbxalSr6kONG7XSnTg8PI2J+?=
 =?us-ascii?Q?Q3ylovRvcs+wfhSwPZbG+y86U48vXuHspGzU1sZ1mj/wStfv671VQBGNKzfL?=
 =?us-ascii?Q?W8/FvzoZJsDVWlkHo5XsgYKWTwYddK+j+u3R4+d9pr2xtFVwJU0hRbGRNHLU?=
 =?us-ascii?Q?GRv+JDbdrmQXQoqMMs6aV38UfP1WAcOj3ozVd8xAHwuHci+aGbOVETbS4AmS?=
 =?us-ascii?Q?5ozlyYjF9wnUZOXYhvg8QqSQqeuTxXeBn29Em7CGhDUrUdSfx89upFmtdSd1?=
 =?us-ascii?Q?mWi+B46Mbix9ezSOrPfst5ksQpFdRBfufwNg+cTP/sbAfoHv8ay2VoarWypk?=
 =?us-ascii?Q?f0kfVqUJWX97oAyqBooaC0mfMUu0Mgttugo776NWUPwAH3kUluyEN6cszIJX?=
 =?us-ascii?Q?ALWBhVLx65QVAq+LmMvoeV5ekr2pyaIdMzW7YD7t6fjh8ueAFW5BeUVtH708?=
 =?us-ascii?Q?OszVamyoRf/bV2bx1LAFWMAjgRAq02JAmDn0RTGuZdOlkE5xDs6nJv7vBzlE?=
 =?us-ascii?Q?c77oGRci1z66SSKcwa2paZPVQ9pzW9jlQIBjttZzoikyskmQ+oOdwX8UHzU5?=
 =?us-ascii?Q?+7T7qLfGdFNFUY3kEBiq3zAAvWUJT8LFp009Pk0V2TJxdnQxNLXyAiJcMIgL?=
 =?us-ascii?Q?rLTPg1Ij4oqR2yAYN3ROz4s3rWvwXw3BpfidR3buFZiWzNz13yfjoQzAau6k?=
 =?us-ascii?Q?ZHdMMtaOZyiju7jKWtoIJzay9ufIdxTxI1DgIOmb/+K37GBlD7vtDBMRu2ti?=
 =?us-ascii?Q?2t1PKwS3f823MJsoXBomRbzAweOMNY9wzPio6yJDMj+2ABQIc/dxSfdUnluB?=
 =?us-ascii?Q?V0GsJAmtX4h8TFGBnR5M5C4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd03518d-ef52-4858-b03e-08de29b835a5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 11:13:48.9028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aIQ9FIyggPkZ0PdQ6Bf7XwJpgySB0s9Xw/Alig3umvVlm+r/69NvA54eAfuYrIx1jqNTPVxWjDZl/PykelqtGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9678

When using the SGMII PCS as a fixed-link chip-to-chip connection, it is
easy to miss the fact that traffic passes only at 1G, since that's what
any normal such connection would use.

When using the SGMII PCS connected towards an on-board PHY or an SFP
module, it is immediately noticeable that when the link resolves to a
speed other than 1G, traffic from the MAC fails to pass: TX counters
increase, but nothing gets decoded by the other end, and no local RX
counters increase either.

Artificially lowering a fixed-link rate to speed = <100> makes us able
to see the same issue as in the case of having an SGMII PHY.

Some debugging shows that the XPCS configuration is A-OK, but that the
MAC Configuration Table entry for the port has the SPEED bits still set
to 1000Mbps, due to a special condition in the driver. Deleting that
condition, and letting the resolved link speed be programmed directly
into the MAC speed field, results in a functional link at all 3 speeds.

This piece of evidence, based on testing on both generations with SGMII
support (SJA1105S and SJA1110A) directly contradicts the statement from
the blamed commit that "the MAC is fixed at 1 Gbps and we need to
configure the PCS only (if even that)". Worse, that statement is not
backed by any documentation, and no one from NXP knows what it might
refer to.

I am unable to recall sufficient context regarding my testing from March
2020 to understand what led me to draw such a braindead and factually
incorrect conclusion. Yet, there is nothing of value regarding forcing
the MAC speed, either for SGMII or 2500Base-X (introduced at a later
stage), so remove all such logic.

Fixes: ffe10e679cec ("net: dsa: sja1105: Add support for the SGMII port")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index f674c400f05b..aa2145cf29a6 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -1302,14 +1302,7 @@ static int sja1105_set_port_speed(struct sja1105_private *priv, int port,
 	 * table, since this will be used for the clocking setup, and we no
 	 * longer need to store it in the static config (already told hardware
 	 * we want auto during upload phase).
-	 * Actually for the SGMII port, the MAC is fixed at 1 Gbps and
-	 * we need to configure the PCS only (if even that).
 	 */
-	if (priv->phy_mode[port] == PHY_INTERFACE_MODE_SGMII)
-		speed = priv->info->port_speed[SJA1105_SPEED_1000MBPS];
-	else if (priv->phy_mode[port] == PHY_INTERFACE_MODE_2500BASEX)
-		speed = priv->info->port_speed[SJA1105_SPEED_2500MBPS];
-
 	mac[port].speed = speed;
 
 	return 0;
-- 
2.34.1


