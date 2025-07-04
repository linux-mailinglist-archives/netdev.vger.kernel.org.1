Return-Path: <netdev+bounces-204200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF732AF978D
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 18:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B59482C2D
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 16:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C18F315505;
	Fri,  4 Jul 2025 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="Ka2p1dWk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2127.outbound.protection.outlook.com [40.107.236.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B1330B9B8
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751645157; cv=fail; b=N7vc/1ApRx8LDYqj/lXnlk/MAeFWUWqQxZXroSnQIydsFoYLGV6+x0dkY/ZEpPpyNm4fCJXctbKjtH7riAc5oU91fszdrb+GkPjc1Na5uDW3RP1A3hhWMKimGJvLpTCVEydq7BZ786Wzt4rRlr+nAJFwUYn1oUlNlstntgfckfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751645157; c=relaxed/simple;
	bh=wSJR8F6e/KamF2eGHdigmk3RNp0TGXJMit6smdybxz4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kCLqa+qcKQv8wbJteumPQyj6iLr/6wFFUoFJccSdXfxPZLwurJe4LdW5xKxGvi9EI2rbMgaqexyn4WJIAv1fXFU9FGjZxx0uiQ5LKbJ4yBx+uaH49VCYxTgY2GGnWxUUC0CLEOCTwoZQ1Y4WRyCGgqluJo+3KQlj/JVsRaLsOBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=Ka2p1dWk; arc=fail smtp.client-ip=40.107.236.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kg2JlLY0DhDTxf5VvrSRrq6l5HzPBhrQbVtmR7NGJxvrbTNz0oBvhx4DOoTZcKV8Agdv1ips3mSAScWOTbTpcgy02MmkrGPXy4roI8PjNz8mjQ3ZaNhD+ml5J3MhcMKGffvuEZFu7m9rINCFZp80imr1hIs2LCS3s133ZED9g/RWxahv6cdQ3KOh+hsv+74oLk2fvWuRsRY26mADSf1s7jo9stm6KNJfI6N7SOTSTFQiuE5h/aajeoJ9j3YFGSq3DfTZ6s23XRS3IvCHPEHTSu3yFppgh4AiZoAib26CRRbmZgNhnYNJN4clggxlAVw4BMXUTWWKChZ2cjDaGA3bdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FTAgtJnGSC6syXL1WR4ut3NCeaXPWT/wReg1+d4lpE=;
 b=v1MIPE5DD3X0NFpAxB6CbwuCP+KazHFdNzcM0siYTfhZnXFjzRh4woE7LI87t0dWZAjCKVfu7KmzgMEavKEhqKdRdfsQRQ7m7fIw46FwGUskaL3Oo08x9cHv4BFBoYeRmAbSv3xBZbdS/yEzdmqrXB2gGvLD1+eJ7PyrTLJm55pzo/EdrSuEFvtK8sIjrNd/IBUSQeeZcoK+IX7fErjeaUpwPKurWzAHx270Rgj6UWghRNdz7nupzuY205EVBEP2ATwzn+ObENlGyGYO3Snlm+QTggEwca7y9MIeEWs9AIiqCeJ+yT2z61l76Sxb54XLyVxaK05p8EJ3t9TgQxomAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FTAgtJnGSC6syXL1WR4ut3NCeaXPWT/wReg1+d4lpE=;
 b=Ka2p1dWkUU0nCcgGnp2vJfQkW8tLf+MwoWo6F3LEFxQMs+RuzLKn2vAiSQENGdKxBtA4xshZ6Def+01sbJMLCpkkpy1VwlagI4gxBTqjiRAroNPbEn4EGU1kS2kYm/p6XAuTsf5UZlj6KAcBzCi3528On/+VsFAf86kG9fQd3jA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by BN0PR13MB4582.namprd13.prod.outlook.com (2603:10b6:408:117::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 16:05:51 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0%5]) with mapi id 15.20.8857.026; Fri, 4 Jul 2025
 16:05:51 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [net-next] MAINTAINERS: remove myself as netronome maintainer
Date: Fri,  4 Jul 2025 18:05:34 +0200
Message-ID: <20250704160534.32217-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNAP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::11)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|BN0PR13MB4582:EE_
X-MS-Office365-Filtering-Correlation-Id: a5954c5a-fd8c-42bd-6dd8-08ddbb14a57b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JjUVYRJtTmx02YQ01M0fk0AJ7SJh9KL/eoOVNlsej0eL9pIggHDCKbIo/Oxw?=
 =?us-ascii?Q?zyT4acGyZCUNKmVQte6Aowssf+xlialxYwAYAPGZ/emhadyWAzU7Nlsffa3m?=
 =?us-ascii?Q?wWhC6bh9pzS2cLY/sPfaCNnT6oZMe6Fwp3V5ALiMImyyjgPk2t21PTgHNGbP?=
 =?us-ascii?Q?G3l4bczAWZM10k+5RJ8sSTZQR0BbtVE/6iwfAIDycTCfwvjNA4K/oYHLP5XQ?=
 =?us-ascii?Q?tclnIXbOH6ldjG85tjyVC2/SMdoOY3j0MoH1+bFpAmp8Zmww+gnqBlsFr3uM?=
 =?us-ascii?Q?DiDhlPRRwA8OWkx2mZqZgVLrdd4mjBmHhTaFm4H08ES6NZJBEyuV2pk4UHLi?=
 =?us-ascii?Q?7X8BRBfIfUwGVmSnS7BQX0cf7Rwf8zSuDhwJ2SfSnNDpK8Q+SD5IVn1Z/7+r?=
 =?us-ascii?Q?6XHsNByO+vcAAhUco3D2/aw2VLZwPxdN+vxYeKX2YPuckOBJtDOjf2sAGOn7?=
 =?us-ascii?Q?AjC9IQOti57iQVSr0QEjnSU1lGdWiNCkFemwHDFSPKaWU9E5ZkOeXivO72kq?=
 =?us-ascii?Q?Yiza9EjHDMv0phwOXtQ3pidfCWMPCzzTykmyX0iCc8ZL4/9ktzb+T3LJADOv?=
 =?us-ascii?Q?8/S7vW1rQc4rpZoV6I6Ymw2N7BXJMAhxGOumGy+WX5YnF+qF8FeLuAcE51sa?=
 =?us-ascii?Q?c6p1AUqYO2DfuKhiuLWc11S/y5HIHsuJqFQOFa9Bth+h2e3kIJ18Zl9BQZzs?=
 =?us-ascii?Q?KxhSeB04FIpJg+YOkarJ50907Ty8u7u8p7B2Doejwy/s5aobrRjSoN6Mo8R7?=
 =?us-ascii?Q?DhBzmyb4aIPCrKfI7vpP6UssUFiXftWMTY7ZqLiNa0K0ybHoqaEO9RKfT7ky?=
 =?us-ascii?Q?mGbMCxLb/z3BtbA6H2h8IdCwA082H5h4p/VNRmE2Nq5ZFRBuqNj5FjYROCfJ?=
 =?us-ascii?Q?r9j63oKvhOSsnCJCB5X/IRNQInU5DQ7ALwU3nZckNKGbdq3PuluQF47loimC?=
 =?us-ascii?Q?H8/eDk3AuTfMmUhnRH0GJd/qkz2/avfmaQjp04iT58az6qzWG2YqAmxEPoYC?=
 =?us-ascii?Q?x2xqPaJrunkQ2z6duaHYf6rBf9HYqk50s/4UbdW5I6eXZSMsLkW0mNfhczZe?=
 =?us-ascii?Q?g2RzaLiS9evhyrZmVld60SerXsJ6bcZNG5lMEAi28waDCxoTeZ66ucnfJpXO?=
 =?us-ascii?Q?qSq5BEh6umfUJu6bLtBACufepFsO+0lrD3l1p5Ti9yKP9f4nkuWsxNPWg9TA?=
 =?us-ascii?Q?COLzH0uSFuri21FzQQRD42Yntz70ZnfFZY0tu39P6HcVsheC9kqhubRqY8aO?=
 =?us-ascii?Q?z/Ub/8cMhcdiPJgijQ/KiKg9dcfRHTpuILuHsUG/Mh6ubcCQH6/TXbI9fneE?=
 =?us-ascii?Q?L3z+rMfeMWWhKw6GWxquwPDLVtUCrcVsQQ2IQpo3Ue6kbfCesSsDFfzBDwIu?=
 =?us-ascii?Q?QqJAt750dykeyG+36BgmKTgiSckwo2GNKMbRLas/QMdRaCS5kDnQ7PXScmUd?=
 =?us-ascii?Q?vifh3NsbrOOd7Q6DzEmMMvDs5RGTwFyYZ7LChF5ZoQTCMd4MdC61fw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6tA/OgjuK9yJUUcoEGu//FseIWL0cx3kruB+ozrqVpqTVKIs4+xwsL4HuEk8?=
 =?us-ascii?Q?hYPeb5DMMay72iIC6ToRjozPv0/xulaTAOKYOpcCgQupPMK9HGUSX6E3fk+l?=
 =?us-ascii?Q?C2+BlusxPR8zT+tWZ1cWg3aACbkB8ymDAw+2clkCpvI6E4Jg4Q/te9fv2LMT?=
 =?us-ascii?Q?hOb8uXmFgM4vLxcv0tJFhnt+da0V6CDO8rq4Ls0/oP+oNcuA+JktswqlpdP9?=
 =?us-ascii?Q?YA/859rELsJyERaTYrVPB9ZLw87n4Yol70QIp0eTTSu8Sx9AHUa10mjBJfuF?=
 =?us-ascii?Q?H7Pt/n52ZuRCnKZmn4wVEgrsSOnVv9nvg60uNBPqvDFhHC9ZJbZ3ExHTQmQ5?=
 =?us-ascii?Q?NIEWVgzKdn/UNoGUE8FjD3aUQOfSJqZOgKVM+uVZUk0Jq6cUShW23V0ULoOv?=
 =?us-ascii?Q?uSThRvL27N+FuNZK7SpQo0yBw33f9PEz8WzsR7JektD0cUFoA618m6DRzCW6?=
 =?us-ascii?Q?yAaTW0cXYKrT2H4qo4z+ubui0dxrwtRH4vWRcIoHjRx7aYbs/5UhziN9tZvV?=
 =?us-ascii?Q?mZMLwzzO5fbAOWwrsBgPQmLfcQzl2nN3um7nZjXo6Ivg4dEf4QrE/tBC6fvh?=
 =?us-ascii?Q?/LAci4fKCFrZ3O37eyCKCe/F3R37QC7Moc3QQwUmQMgN9dTe1ncVXPKtbVoT?=
 =?us-ascii?Q?RHmD+8uHqifi3wkBn5+PDK04y3ORpWLdxSjHwk1prfQBreJCK8BUvXC9oeSh?=
 =?us-ascii?Q?y2UBwqtjdTaaDDKqDfksEzFcaEXmEXe95lLwW9ez7crj/a/OGq4gFSI9sR2w?=
 =?us-ascii?Q?ykTyvZPKJxhaehId65XkBO9I5VrTmfPQrIWDEjjyUemnW9a7Z56PeL9oZdbl?=
 =?us-ascii?Q?0isn7uTsPH3moVbfJ32/7M+iFx+IfpNbczW/KJRRhymUe+WWlH8ULb1RXJYa?=
 =?us-ascii?Q?hqw9RclF1Rq81wrvs+iXS7cDoxLuztwxwREhMlcL84Gapjmy8uBSp7el+Ylj?=
 =?us-ascii?Q?QuDfUtkzy6pb/3vdoE9Vrrc3FyaNH3+yCwoU9sLyQ0B8vuWptHPVtEwYtcrX?=
 =?us-ascii?Q?wDMjd9JzH22VdvF6YwVKBQLIH9f+DKwaaXc2BZqBjtGW6AiLhrp3TECt+vfZ?=
 =?us-ascii?Q?Cnzow8iKvpqWDcJpB65DtHfL3aNpODhNmxuMVUg59dnNoYuafv53HoPohm0S?=
 =?us-ascii?Q?TnKscij19ZwVPlMPEbN/tQCqQ5LsiYdLLWXfvRB0xGfcYlQbt6sUAtNbva0X?=
 =?us-ascii?Q?31x5Rj23kHLbiu+KXhubT4KlE93OMDbSijKM2ZoOKIfm6sqL8sTwQ9ESQ9eZ?=
 =?us-ascii?Q?SpjUwk1ptFdl9LgbjE6LIH+pfEDSHVUnEFyfuKhH6ce0RmGFK41608MuKuVC?=
 =?us-ascii?Q?byA5I2Mu+8aY4UtBkrVP0tQUFIXQ8E63BnZr02chufETuXCWAf3CBhwCQ0Cx?=
 =?us-ascii?Q?QpwJ7910dM9opiucOFmHDySC+xYv4P7pd3//3imj46HiebciQHtRl9Bm2H92?=
 =?us-ascii?Q?ounof2Zh7x670pc+OF/jWOUOL6yXpyN0AUwe8wJWKUPVmib9lFQVfDt2/Q9U?=
 =?us-ascii?Q?rsRK3yvnX6osNcuiQZpYm+Yqtie2kVltUN0I9EzFAOop/QjRNV2j8v+Nc8AG?=
 =?us-ascii?Q?8cEWCgtMnX2FiiudWSdDmD7cfKxd9qcBpDFenJu6BZy4hTTT5xeRvR4CK0Wq?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5954c5a-fd8c-42bd-6dd8-08ddbb14a57b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 16:05:51.0540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrDbhIIfSmrINvKhbca9A6gszAX37/3xewEVpAGhfgD1d6yaeKr734fetQr6RHIkxs2z4j/oIurMaPygMS5qQTr8oXQTWcyqfg58FIHQOSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4582

I am moving on from Corigine to different things, for the moment
slightly removed from kernel development. Right now there is nobody I
can in good conscience recommend to take over the maintainer role, so
also mark the netronome driver as orphaned.

Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 14196433aa87..1b8a856536e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17227,10 +17227,9 @@ F:	drivers/rtc/rtc-ntxec.c
 F:	include/linux/mfd/ntxec.h
 
 NETRONOME ETHERNET DRIVERS
-M:	Louis Peens <louis.peens@corigine.com>
 R:	Jakub Kicinski <kuba@kernel.org>
 L:	oss-drivers@corigine.com
-S:	Maintained
+S:	Orphan
 F:	drivers/net/ethernet/netronome/
 
 NETWORK BLOCK DEVICE (NBD)
-- 
2.43.0


