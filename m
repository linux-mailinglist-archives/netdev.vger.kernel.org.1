Return-Path: <netdev+bounces-217657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5C2B39738
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81AC93AFCCD
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 08:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8842EA498;
	Thu, 28 Aug 2025 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Cny0Vp/x"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012056.outbound.protection.outlook.com [40.107.75.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B08C2E5D17;
	Thu, 28 Aug 2025 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370394; cv=fail; b=pgneqgsM1ZHealFo8l9fNJNzZ3HZYpTCW9uVK5SPCI1gHjtc2PKwhUvhW+5AcgVuQNUpNI8GcGOudDmADuqSRJBYU+WVYq9fbL7JWKx+Ih6Lq1Q0YRYqihdih4evsqFf9iMARIajucHv1gq0xikoM+P+lvALZxis7gHVrw3qK+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370394; c=relaxed/simple;
	bh=U6nvUUNC3soUgS0EjQZIthNuy2a4l4d279uNSkbu5VU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VBZzCSq/jjwgh+TnZLjKkfyKAvoawdmPvwF+Xq49e3g4WMJ4QAinl0ovRVuSQf/A9n3F8zv7pzQKoOhuLUsbmFPJjWK7dM6LJzKQpcJ3g36QpqfiSSWDEnDUH7bulDearCnv55s/uRjQdAskoq4veeUcfx5cLECJyN4Sw74yZ8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Cny0Vp/x; arc=fail smtp.client-ip=40.107.75.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNw7O9s/nEEnSD1T8PDDWMqxv3ZBXXT4Kpjsz2IYfG6Walhh9bBvslO+l52s0pY/fjellxo06Hb/UxYetaJb5uLrzWJMHPMEBHW6A2JtBNwOyd6n0fuR/FFhtT8reIUpLLyAGy89dP748GbnpJOx9hHL5mNfrC2lGHZdlnMi3pIPhxTNGQU4igwB7e/gwYNf/nVOg7iijnL3mZee+KhMqdGRr11+HHMZ/GlY1QRSnqGM10mX3RKsXdxXrJDlfVL1f+ZsrREV5mg69/5aOthmjnWojgPGqhHK4c9DElv5ygxQ2p6emXN4R+MeH+GpJXSOcJyyeW7XiFfXPOfcc4uxcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYHdquyT3smQUz8GfV3IKsIUY9xhkqwg2jj4PaHVvV8=;
 b=Ys3cEmzFtMUYyJnHpOwxfm5MtwL+2gFHR2CDwyrr9QMT7KLtdWqpYuID86zROJJs+tl/kq7wn+VBFIo+OYqjhoskGbAIWoG8QjCSQTikMb5k40W+WSGsFwcvoDLztO/7ylMT8gyj1O6qUbdY7/ceC2znANZ4oNE3rtHFhxCgyu6MynwD7m5TEi1zGIw4UDeSN1kJ5XYg2JX/xsFCvNwBU45ER3mWAJJjB7AfPc0PGx97bJs2cHhWmhhTsSGCM34qZKtXnzcKIQ1gBJcZE3I2E1AdkNQ366ts3feYe8hsSzzGjae5va+aa8iinne2IwjztviCQA4gFUE+ZZfFbV1Pow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYHdquyT3smQUz8GfV3IKsIUY9xhkqwg2jj4PaHVvV8=;
 b=Cny0Vp/x7HCuu0UjkoKPguB089WrqQoSosMlasIwzQT84j4lgP3YdevdJEieKlPdHa1qAYtYO8rZK5ACZpyCiOPGX6tMDFRPsUGXMU8/Sh6RUJEaxHOlChGvgwGaA1xOrpHr4ylRtfDfl72K6SUH5JwvzaYiUGwU7T+W1vywy6863suL6oNyT6UTm+1pU1xIU0lj+V9JG5ULKI5wpwpXUQ7Uw6kPNpOFebDChiXCHgD7IZN4dhryka4kPd6xd3KE+870GsvMetx4xgjiwolejqB/0NCYfQZM7OJpTHEBhu/dXZ15WbrNMwtqLGGn0QY4mkOF1qft4sMPFm38GjwtuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYSPR06MB6573.apcprd06.prod.outlook.com (2603:1096:400:482::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 08:39:49 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9073.014; Thu, 28 Aug 2025
 08:39:49 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev (open list:VM SOCKETS (AF_VSOCK)),
	netdev@vger.kernel.org (open list:VM SOCKETS (AF_VSOCK)),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH net-next v2] vsock/test: Remove redundant semicolons
Date: Thu, 28 Aug 2025 16:39:38 +0800
Message-Id: <20250828083938.400872-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYSPR06MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d9435a-d5b4-4a38-3df7-08dde60e7303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h7VRz0r18l8GpPjkOvj4YjkuSYlGZc8CmglXGfNULKU7NsSLx/CB/ORwhV0K?=
 =?us-ascii?Q?9/qJdw+SXcxZe+2pylVMsuKIrG5B4BMyjKLAl3qsC0jwcyx+/0cVKTJKcCbJ?=
 =?us-ascii?Q?3j/PCSIuQUZU3jOuiwwEUpkZCvpgmv+L8yjS3bih1hS8l9VNysmxszENNXlX?=
 =?us-ascii?Q?2eqneJPmf2AG5e1SvaF0t3LxdZsql2ZO9rCFP9UJpIUTlPY5M/MRR2RSu0rc?=
 =?us-ascii?Q?O+dUyHQxY+L/RU4euoAuWbZVf89rRdSNI14UfREc2fLOWySVodjGA6yDepSs?=
 =?us-ascii?Q?vjYWnA2lB+YRnJtE+YZRrBRdqLR+D6rzfOak/sb8JUe6Y15fbL5c91O+D+fY?=
 =?us-ascii?Q?U6Y7Ym8RgT1pk7keErYNQdilu6jAKGzErAEodIJ0DBTnZYbX/ficBO4OGTFX?=
 =?us-ascii?Q?CdzrVvs+moKAURVi5EkdamqCINi7aw8zmO/BoQYfFNAf9G5WSFPc/QH/y548?=
 =?us-ascii?Q?MnMj4fU1+Ge2IvadFyzAN07ZABExzDcgp6ChoPZutdCdSN0/54NoYwOmMd96?=
 =?us-ascii?Q?J42Txuxh5fIVikpa69BhM7uBWAJvtXy9GqC53D7y+nzadweMCuogfUxjgFyZ?=
 =?us-ascii?Q?9lGpJwECyYljrVHAat4SFNNH+G/tJJ+nYmBhn4z7Cd+s1nE4QpSI2sH+YQfe?=
 =?us-ascii?Q?0Jl3sejlPlKT+bchORytToSatA9y0qdZGfqsAMYz6m7080qPe4ennTavV5Y8?=
 =?us-ascii?Q?1Ieroe76dDSyjDvI2pJE7PfsunGvrG+P517eXUvVPwJTBKC64KLez8tIp8dV?=
 =?us-ascii?Q?S6tLuZbhjsx91RtSOQgrpOvIf6IrGlWd/Q92Mpu+nEAQBRYJSA76yDKIr3bp?=
 =?us-ascii?Q?1yc1EdMCSmGXqlX39JlMF0w9/z0D9+COZL3ood3V3zQciuQ1bmubPMSL1XHn?=
 =?us-ascii?Q?PsKKfLVgLUDQbCEScJChXsHuMpCqII1HpFTGRhxNhdoVVtX+KDefQr9VaceD?=
 =?us-ascii?Q?VTLjeJ9nSWySn5gubwR2SprHCiQelVpA8u7kNBb4pa+HAY1B41IjxECTDbgi?=
 =?us-ascii?Q?8hyaRv4gB04tYXlEC2yHKJecC6OqLWGpRqk4DobvQKzvjA0h+QP8eEsMXv+S?=
 =?us-ascii?Q?Yy5m1cwG0nzlMWfNpXLQvq65mxDN79SmWSNdNQKbp+kAfBAxyIXtnZOY/USv?=
 =?us-ascii?Q?faapZRWnxT4iDxxlNVKr9LQ6E2GFMkBEViYQCADk6yqBr+ATZkGLc4L5YFD7?=
 =?us-ascii?Q?wJ3IjQKrFTGZ4HMmofUigJHLKJFhtVEuC8ouANmplw2XqRoc6Oe0jmq6hY9Y?=
 =?us-ascii?Q?bTZNdm91jrgexekPKNe8GzjeZ8TZKoezfg3TJjcM4WXBbwwHH5DSY4T2o07H?=
 =?us-ascii?Q?In4wU2HbvQzwEhjr3uWYssOXsarATN8vSISn3A/9h0BKSnrl5pTzQq4JDGQB?=
 =?us-ascii?Q?bq8SdjEbVmDl7oOFOKGZVXQsbG2H+0rZPG/Pxi3UvgouPo4iUfbTwkIzK8wC?=
 =?us-ascii?Q?GMp/bLknI0YqIw2ojRSLrbyvH3uCvY/LYpkO23Od7guOp1o+ReDfMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5wirUiqmTXq+3OgCRbTwNaRx5PW3wA9+4NR+xfKBELsUBY1cwE9Bfp8xxI7+?=
 =?us-ascii?Q?MWXA6CSSwVYEyLQsLSGV2YSi7Xfh8sfNxPB2mb7UOM4v+yhqlKKAay07oJC6?=
 =?us-ascii?Q?ptvK58+1CzmVmnkI+g6hQP/yuQOc82mUBmD3a05xyNmZL4Lifkaxp4lq9fTB?=
 =?us-ascii?Q?QNoX8f+RgOtwm7Duc2vmCbnGHa0Y7/iX8mqHJW3PlV/eKh6rO9jfLXbqa7CQ?=
 =?us-ascii?Q?yEHHKGZj6f61QyUYwTKWnTESaL0staGMieQnD6Y50G+U7qshJX5WSUzqOfFl?=
 =?us-ascii?Q?SLc/XQVU/1/WablopDxi7CJxjW9YeAs5WXtyxgDojfrgHhZYPuW7y0keT0pj?=
 =?us-ascii?Q?r1M8tOAqUdC0MmYMrcMbOCaQfQYlNGGsVencMlng/UKgJf8Wle0Pxw6RZtzP?=
 =?us-ascii?Q?47L3M5mxzh136ve3OozkE4vtlXInPTthJaTCpMwyPhbA5gEfgKvburq/i6EZ?=
 =?us-ascii?Q?Ek29mBaP9eWO12nqdE8SJKNDcGbqjXrw5SXorECaGzsXUPaIeKHHzYYgYK6h?=
 =?us-ascii?Q?VvHF/uVor/yQ2wlwAF6mMSG6oYXZb0LVZ0VefVs/4VO1JiSbggwJ8BE5ba7K?=
 =?us-ascii?Q?/sjlVEkJUQQdktdYHy54085A105grJpxhVr/Ac5e6HL0cXcvK31YHgo0Ln3x?=
 =?us-ascii?Q?FljddGnH8/KBGvIPrQGQ1rCyW5E8vnVDEB8eigSE6GDZUXB5GIb6ifDJSnrp?=
 =?us-ascii?Q?Iz54d0+Q0eRAECnOZf4x/A6Df4xHgg+4nXWdBcSM0CyC4LSBhtr4mhNx09JX?=
 =?us-ascii?Q?pSOldGm7P8cpoT0WpD1WPcO9VfU8DdL6/Jk5/jCk9AQtuv/hBI+2mGbd0dmd?=
 =?us-ascii?Q?1ukdcOn0HQFxAXO30ALjS94rzvur3gpK1LM5klf1c69mOWWN10mc5T6nm2gy?=
 =?us-ascii?Q?Xb0e3rvv9OBFyQQErBF7OpcEbAfDP2jUraaEnNXFqanTvdlquoQWFWQ33Bh7?=
 =?us-ascii?Q?cCBkAkyLQslEKbvAP7XAoRIjuzaVIXx3hM/iEsMkIPJQzBcty1QG/PZwLJhf?=
 =?us-ascii?Q?2o+XUn8cRwrBe8QK+nVz/+DLLYD/JFq96WABPZI94kPbqoBiztLeURdBGhAe?=
 =?us-ascii?Q?DsE70K7s9+fdFUz9m5UKkNhwo3bHLu+ckQt4fWEkym/hRtBaK9LxmkfOL8fF?=
 =?us-ascii?Q?EQUoVYLT3P6lfyOsoSfbjEKTTZWHhlAhxuhQzRPwXP1DPyG27uJLJ5M7R17Z?=
 =?us-ascii?Q?0zzl/RXKIGt5U7L+xLvDFRmkhgy63Nguti2eXozI2mG+SbS2PIQ5qtE0cVJj?=
 =?us-ascii?Q?Tnez96JQfC6KFy1Zs8SE3ImR55VfBQjfJ2lDF4kB95LI5BsObxIiUQ9SbTuO?=
 =?us-ascii?Q?5ZLfiVNmAOfqtC6eLH3cNTeOUvGkrkOubmgVAAQ1ZCfOLcyB450Ci75dVROv?=
 =?us-ascii?Q?fCgccQldBlFBBaLRwbAtLAE/s2U6DdTBVq5TEakfAS6wXuU4eDlebowbBKxv?=
 =?us-ascii?Q?SPrtVR2QXaO8LdRXjNDG4lDZ1Mw/kFRLf+xdwJFpnAwt8naKh1/sct4HCnQb?=
 =?us-ascii?Q?R5N5kM/phYRmmjhxaLufFJIYmLVpAyMmZbavBQOmIxfGrX2U9v2db2NTtvc9?=
 =?us-ascii?Q?btU0iAYS64gF/K2E4cZNQ4tHGxiihSn9LKOARIX4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d9435a-d5b4-4a38-3df7-08dde60e7303
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 08:39:49.3017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: leDrRKnxvjl6UAqnQ5bvz6ySxkMGM35cjm5C2+tbgK1m9D4eC9JIzacaLf0dvr8+Cpkx0+Le1WK80AgBvqP0eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6573

Remove unnecessary semicolons.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
Changes in v2:
	- Remove fixes tag.
---
 tools/testing/vsock/util.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 7b861a8e997a..d843643ced6b 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -756,7 +756,6 @@ void setsockopt_ull_check(int fd, int level, int optname,
 fail:
 	fprintf(stderr, "%s  val %llu\n", errmsg, val);
 	exit(EXIT_FAILURE);
-;
 }
 
 /* Set "int" socket option and check that it's indeed set */
-- 
2.34.1


