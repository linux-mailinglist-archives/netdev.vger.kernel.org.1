Return-Path: <netdev+bounces-271756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCdnEVFfxGkuywQAu9opvQ
	(envelope-from <netdev+bounces-271756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 23:18:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD4132CD59
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 23:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 097F43082FAD
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 22:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6548538E109;
	Wed, 25 Mar 2026 22:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="YbHAB8dk"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020075.outbound.protection.outlook.com [52.101.61.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E6D358376;
	Wed, 25 Mar 2026 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774476703; cv=fail; b=cfdpJhnlAqRoeL0Dh3ziDJ/kfk65VsxGLTiO0GezeKYAtJr2miMArURdCVS6ilCI7nCUCwoPaofNZSlRij2Sr8KP5qWudUMDSR8jCsiPqubIXwyFAhOFX6o26It767EKPf1eo0eW9tZC/jxnH+jU5Fh+izjYya1sD/8urE/IUHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774476703; c=relaxed/simple;
	bh=DNRWL1haq9vNczFjccnI63e0FbYcAEJjr/IKft2ygHY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gHIvRAKJMM9f7SWU3idYziVgiDYJKamEoNWN9OMxaSbl/y4QwszrBxI2QxIr7EilQbxwRf8b/TMSGBZADIUDpbH6xutSckb4lWQb+hffImiQTzKCCldS78wzN7Xluar5Dq6P59PS6xa5jAde8Pxd11L4n7IPwdnPsGN9PrYd4Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=YbHAB8dk; arc=fail smtp.client-ip=52.101.61.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svKoRqxeSBPJL6ukeZc0xeaDvSIR3XUhc5nP1gvRq5ybvgdhsQuE8TGCbl/cvbcXWtVo/fM3TBo5GCBcG5Z55XRiPYJSU3OxX81tQ0dy+VaBu4Bf+wnfz3+1o++q6TUdW1ov0ZH5yrMs9e4+gFPYqQFgDo1HRohCsyYFzWsn5SiM6aSTeyJJVX895nudX/ILVWLn8ULs5QwDsgGoCjwE2Hotx/o6L7Ur3KuOn8N1biWiow1F84iIw9m5x69GofgxjKvCZWo80ebzmJEmO+92QBkYgyEpFlh09+58J5pOv3QfRdM8qnJhHlj6fYT7EZvSp5xguhIG/bOyOfYoyE7TbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21ru2M39FKhKemr2Qsv10q2gpQ35dKcc56w9WcQyde4=;
 b=f3BNZ5jbGyhcAJ3VO4GX/FT7RoFpsRKByMbK0gny6r7v0rHCuHnNlMJ0ftAtYDTUAeLvSqQe41ocSmmO1HFd8F8tivhafes+fGgkMLjnxbBIWcJCieR9g8CMSQjWIvTY8bNfQc+lrFmGqzP0JOJy7/GETn8VQH8ZRuT1hOceARsy2cEIBX5l8LSyL63XxQnRyZfRrtDMFXU1T235ABrK0GqnxFPazLITRpRJglM5gQxCF7DkWHs/kb90qq9g8pfKyCjz9hImpgwWJdBhsVYxWAcEE5RUb60Uog2dOo1zldIexzdl0bIi+zbNxsUNuk6RMF0DhfItuCDKruwlLSCO5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21ru2M39FKhKemr2Qsv10q2gpQ35dKcc56w9WcQyde4=;
 b=YbHAB8dk7OtxmUm2Ejii2chGA1SfBkxF+ZzBWtKI7ZpJnYCXBu7OBh+L/a04vRCcOUS+hi41gTs3lipfglGUVHDr8F6NHGwt8nozKiWnxPfyzGjsxeW2K/1+z3wFtuSyVu4NiEwRnOvIFKKM522TgmXZsisXHboHscsNEtnX7Eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 IA0PR01MB8237.prod.exchangelabs.com (2603:10b6:208:48d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Wed, 25 Mar 2026 22:11:36 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 22:11:36 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next v1.5] mlx5_core: fall back to dev->board_id for shd id
Date: Wed, 25 Mar 2026 18:11:31 -0400
Message-ID: <20260325221131.1001431-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0079.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::20) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|IA0PR01MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 38654a26-471f-4224-e8f6-08de8abb7b43
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|55112099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	LnGKqer1Qb7+X47UVKtL7LxZffDayCyX975ET5Ngtw0ASnGsITOA797DrttbS6yVbkG2VuAuisU3QBWAgTox2DXHHeMCgIfypB65jtTwh9NGvFiXg8Nc9Re98TQ3p1eg76+V0op7vZIZqJFAfJ+JndctMuNC/WLnjCClyKAB+k0VDpddQ/Q/cHe19X5+WmVxK8hzcFaXrlCWcgrCEaFlzoGW90ueMp9Pe6Fjfv6cfRZfo7LktuacrpdOPPkI9ypZ7W2XgKuN4Ga0BoFBJ5xq9j6uKOB1p9QSWhEaRpdTpOdLg3zDN/R7oBDLDxtrXNY5e39zHgP6lTC/4yzh+k0QpIiSA8Aw3F+f2xVGsdfB+0T+9ehvvdw6PSc8e0c6II1urzrjWDDcmeeBYFE1YhyHTB5hMXbpXQu5p5fHRHXL2rQWyiAxdrPCEC0zOYPeV0npdxzlg0nygeCZzrGLALxeRM/BygUSTGhZO13JcFKLN4a+aww5e/2/usb6VDFgFrkkTnKqNdVjo+mxWqNAvBv9tyawcjAiJzVdpfBNpCkn35571YBImNyuLSM2ij/uV0hhAu5uRhbnjWkXHAzSdKbSXa3WOEBKee0N7OHYIZqg2zlYtDcjMjUBd5SVlhCRZ1qrWImEa0y+vsspUlOlXW2boele9jhibzzjz2uavo6VbaY2UwHHYzgFPE1R/S7aKavsBEJ0H85VwqjOYSW1oidvgK/fZHHtwj9OFHKaoMv2foA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(55112099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iuHg9/pFoDvnkYDuYWhOi6USKXg+EnUggFOdv0DojlVsEujhBBLmh+kK3GaS?=
 =?us-ascii?Q?NLizelmzWRPuGjgift5hwBUzOKb597k409gBXbflxQb+PUC79t8FvswBbWEz?=
 =?us-ascii?Q?R0Eb2t5xdAY6JDIZuW5O2Pa9WCrQY+7yjiF65rgbUBvEds1t2z9BsEx2bTup?=
 =?us-ascii?Q?DMDiGqbux5lVqjgNg8Ma2geuZ0Jiw666Ijxi9wlrmLm1yx092Tr3k7GQnA7k?=
 =?us-ascii?Q?CkUVFC4TUlA3oNq7Y+MgpQ9BIE8iD1wApiSyHosSd4TxgJbDkB0/NiomXS5X?=
 =?us-ascii?Q?IZlHpVxJyq28qpefPZ+cbJy1h+D4cuO0fIacCMa7zxgKIi63pRJL6Iq4S0l5?=
 =?us-ascii?Q?QZLquNoBsieNZ5STnR3EhhavBp26Wg4fbJr/QdoE2JhzG7ulV4pV6xoR5zeX?=
 =?us-ascii?Q?tm7fOwrU05PBfxClF6uYWejdmwmdKcfiU6SnQkhGb5MGXBjn1Oga71zlo+8g?=
 =?us-ascii?Q?GQFnMuaxWOlZOR/KL1oxBTlqcaAKmupjhd2MWEiQMM5KsJawE524ai5+n/w0?=
 =?us-ascii?Q?nHFSAPSmIqf8W8bYmVCbetXn4uOrFooUbef8xHWckI26g0y87xjGlqWWZp7F?=
 =?us-ascii?Q?lK5/SpHANisTw7tOfgrHcp74V8/LMC1dkobS3k+ey+rdVUle0YHjnkglACYv?=
 =?us-ascii?Q?/E90CaS59Vlz8H+Cu1VHD9zun7Q3nIhcmLQ0MvNxgajP7Fpuec3qIwKUHJMc?=
 =?us-ascii?Q?VlZB/+hd6dQq+vC/9dB7mXIjHQ08LJpP2/TY71x5n1+8rGslFS99rI0r76Gk?=
 =?us-ascii?Q?Qpz6KJtaXPsirz2uy4zmVnYCbSU4cQ92CxaE84ouOs6miCaVN3+IHX8uJad/?=
 =?us-ascii?Q?A45hF1WtkMjVWjbmGZIVxGhuFZwV/pkZd+bjldGXWayKBAZzVXec/qeZZzgJ?=
 =?us-ascii?Q?ZwyF3/H5Y8esoU50fWyxk7VMj57wVE0cUILIxHRbNQQkPNHGN5mvUdXGCwPb?=
 =?us-ascii?Q?bDO0xlBT69ank6DfulumeNeGj1aBmQ/oaO1I55RCshCXARFirokTua+KVpju?=
 =?us-ascii?Q?IkiQIoUJrjJqB7fzlaNrU+9/yOd+5J/NCJCzyjEzLEBC1BgK3unH3wg0IVG6?=
 =?us-ascii?Q?v6BsXMKenupwpTnUfbougldZZds0JRoXAZA3Zw1/bzNT0S+6c2OPy+HVKMBa?=
 =?us-ascii?Q?Ev+qg5ZxRho8yamKnx5DlXQYzY43/wWFdLCNPO9Tx3AmzhI26TqABl3dcz9L?=
 =?us-ascii?Q?u8cvSUCwWxzHu5N3n7Go3vOIzpp65jM2nqwnZ9qvpSXnSWTD4hI1JgLuaS/r?=
 =?us-ascii?Q?41Ej6vOG23/HEuKE42CZl3Vbie6SbzfIQduvoK0DXfNU4WS7F80y/1sn/z7c?=
 =?us-ascii?Q?PgdTMwJsjQ8ZEAvSfEjM31qTYSJ1/s4zf+HfJe5WZOk5FD4gY9BD7h7pWkrr?=
 =?us-ascii?Q?AxkFOMpePZTQvkfg5sd73RgNUiOb9lB0t+bDxwDpq7JnL84Xw4ppbd3Ihm8r?=
 =?us-ascii?Q?ak7MD+hPZZoa0ZcXa06w1pk8zFvEtWTS5/db4RM4YXbPJP1ugNbf0py2VN7h?=
 =?us-ascii?Q?eJqbN4YFmCf1Xf25d8cLm9NthWGo20+HZEu6CogGk0M+yacqVysztNsgYpaH?=
 =?us-ascii?Q?ZJU5tWZWcWoDuPkW59GsCvMuLdqOFY9CV1/3fzlobd47RCCuyIJn4w1TqCCP?=
 =?us-ascii?Q?Der7eQbKnX1Z5DcxOFpyd5BDAoW+jO3xLtmC63LlpXeI7ttETDJ6wEpiNT+d?=
 =?us-ascii?Q?JD0a6Yca57kRbzB8Ou0EfcZ3x6p8kxyRv2bEpzYz8nfPokBctvOKdDCwUsvi?=
 =?us-ascii?Q?fVqfoAca5UwxJE8ZeaC0F0ATU630INcvcGvkTepXcRRs4R1PohQt2SalzOTQ?=
X-MS-Exchange-AntiSpam-MessageData-1:
	At4Lie+Xah0vycbxqBpYkYr1mPyWVSIc2XYYlzgGfu3cWquEe4t48EvH
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38654a26-471f-4224-e8f6-08de8abb7b43
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 22:11:36.6036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jfSc5udrk1lJknawbcBnBY6fuoJas0kYosgxlNxOMufqK8X+up9FbZE/S9zfOaLPJ4cBncikIR4G7wyG7zy/uXgA2JJnsmlRwCXaUTH4yUgk6A0UzaEPQOZMwstGGgY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8237
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271756-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@os.amperecomputing.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amperecomputing.com:email,os.amperecomputing.com:dkim,os.amperecomputing.com:mid]
X-Rspamd-Queue-Id: 9CD4132CD59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Making the devlink device shared requires an identifier
to uniquely related the netlink device and the physical
board.  The original code used the serial number, requested
from the boards attributes.   However, not all members of
the family of cards expose that attribute.  The module init
will fail on these devices.  As a fall back, the driver can
use the board_id, which is guaranteed to be present, and
which is unique for every board in a deployment.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
index bc33f95302df..6fa691aca81f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
@@ -32,12 +32,14 @@ int mlx5_shd_init(struct mlx5_core_dev *dev)
 		/* Fall-back to SN for older devices. */
 		start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
 						     PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
-		if (start < 0)
-			return -ENOENT;
 	}
-	sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
+	if (start < 0)
+		sn = kstrndup(dev->board_id, MLX5_BOARD_ID_LEN, GFP_KERNEL);
+	else
+		sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
 	if (!sn)
 		return -ENOMEM;
+
 	/* Firmware may return spaces at the end of the string, strip it. */
 	end = strchrnul(sn, ' ');
 	*end = '\0';
-- 
2.43.0


