Return-Path: <netdev+bounces-284901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC/NFxxc+2mUaAMAu9opvQ
	(envelope-from <netdev+bounces-284901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:19:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DACD74DD104
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 637D3301B93D
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5214921A5;
	Wed,  6 May 2026 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ICP8PizP"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6AD48C8DB;
	Wed,  6 May 2026 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080584; cv=fail; b=TV9eMqCgM8AbrQzVfmnAHgxH5bA+OF+JcteyPtKsAjFdLAw2Dn6/9Opfp4G4XH4iMXBuOSoq99/s+hcbk7LdjHwEr9f0dF4JllmvuS4YJvVo6CLn24J/egUosPZNvYIcVE2AwYL4RhG8pGM9tGP/iFzCHFhNRHDsqVPh3KWuuuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080584; c=relaxed/simple;
	bh=/y8RnlgaBH1XJY9Rjzgwi9JzoAQ4+O5ptGb85/govZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AS5DeTO89DSmDkCpX5ZR3NoKiz8fXh9GM+sJr7jIJDF2tMhJqQa99dRJfvkFiCayNWQImTXrvvosAHOd/wCqL0aqdIbsQXdfbr2yyNGYgN/NYnN6KIvDD7VolDYl3jgSMDLgggC73ETWE1nUJod3/aZpj9oJSjTC615Ee1TWBIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ICP8PizP; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpoUQo0+0wKFKAD/UFLpBK8fdT8wD5oljqr9OaYdPxfCa+ZbdtxUbo7BGwVA1MCsbFaAuwyKopGHUtpicXwBANHRxqbUNMs1e/ij2lRPF6Y5ohdKtsaObzwx9LuNfxGxzRHQVDtQtSkHT7F9ANkYVca8AKFIegnbpSFeXHjF91emVc3Gvc02jmExw5O2Q2yfl8mHgFbtQU3w+RDdyffJmpvOGiHyZsdzkC4GzNjywv5tZZxqQI4WDdqqTujdnjjS/P/xNsl2RQVrP4udaDaNlzAn47qPV4szH5FbAxOa4B5CG4nOd4UYrtXilr8hO1iEA5vm0nQ4SlbmcEooNgAxeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bEwlA9m+VGErcjKgrnDpLrgfzxNd2VCkUdBJlNxRG8=;
 b=oTPQg7/Ho0CJ0EfkzZE94yKiS+s/O/RkuiL+tllEdI8mpnQ7l1EpdLIPhW5CMvjlla2Z3Xy2EeIaEg/SgXw/62PCylIUcdpBU+JdzT3VUoAZbAI4Y8eKGebfcg3hK4qKoYijuYOKb8E4HhulPjl3+xHG9n66XeA/sOgb3qgVrIkYF9f0AIBAcaPT54ACOY+Tg57n5+3+2GRyOL1SrnnkitIxcxmGbwYKQszA4HHl2r813Ibkx4xHwhFDdzb9Bj3vSytjo+4/huLJV2Y9DePm8/jwaLy55Hd5bQOcJJX5RmnLWZzxa80ZzfFatBZYnHw64BxZWohbDvG/88QofT8NfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bEwlA9m+VGErcjKgrnDpLrgfzxNd2VCkUdBJlNxRG8=;
 b=ICP8PizPbP7pDpES1i3LShGyVJNpeAC2jpcRHRRncErN0oJmR9+84Lqid5rIyQB8jRUNgqnY9XleritSqKNJJBbQBtEn3ZAhsXxiduh1JxmlcNiDa+PZPTuVHv3rgzufJoAuTrzkzsBvzspJaL8pNPA0FZ5f+eBI5S7QzpVazJJ3jL1fE8B1nV3pqR1QQ5n6jB7ucAyx2/GmyB79rp7loeMzITOKNioIy/eOXJsFicr6kKMC+UZS67JHJDOZHEJomvmBDy/Di5vQC7RnLFMwnHij05m2ZNz56gylNYaMlj9KbiAFL7VrBL/BQtg3Nq3WM3smYCqddykTJz96iNozyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by AS8PR04MB8277.eurprd04.prod.outlook.com
 (2603:10a6:20b:3fc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 15:16:13 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 15:16:13 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 07/13] dpaa2-switch: check early if an FDB entry should be added
Date: Wed,  6 May 2026 18:15:34 +0300
Message-Id: <20260506151540.1242997-8-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
References: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0010.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::7) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 05dfb837-ccf8-4920-c7e7-08deab82694c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KQ8OflY2zN5Wldnp8e34lJOL9JBfB9BZkagIiMHtpU4OFywnlV/GUF8iVbLV9Fcl6ggikqBk0cmdTl6L1z+h/u4cSoj/oKiJUrzli0cIWxuGAh7pLlQcCPb5keZjYU7+ptmMgVriIE4uO9P53yv2yZBHm2vkfDgvz58QAR4pUgwzeYEik7Qhi2TB2+VDaVO8ghhhzM4XgTMor7RcKIW/xYX9qWPiPaJzN57vdxLop2gVJ7VEkj8dCqxe9upZK3hwxuAgXebV9LKuCNA1un0PNYKcw3T9ivvfHRR/nZla712ZqvCZ6H+CyIPYrGgGMXqUyGx53g9IeFus6p7OFwtxYMw/LzIwDarAQRmoknJ3icLDTMpraldRhJhfpfsEJg2C3xmGKewFVjI4ypem4gieW6zYqreP5QKEo9L9E7kbRZcm2wPE4sGatywxlU4RzBG6KVggSxyARqiBv5MEunkQqZdBn0iMa7QAnLb4pZ1jF70P0MRbAA5yAn6INVl9IxJQFYz+64DbAdl6NGwMDAs91gGjsSNTgzrcVgn6hJUnecrTc7V47cwU6VLFtMa+F3FF8C+eXFjLkB2oC8KJmxizsAx7Fnrr4C42J2oj/vvyiJ38Ox8WSmG+cn0Rvdgxm6/rlDhXsaoUKvROm0102MJzwdIqdjMlMzC0y+uE5tHX4t54QHk2HBx/ZEK4xKdiZoZd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rvrvc0amwfXxneDQHE6+at2M8oeTImFdh1V/6YM8baVPqIsLGtrxPpoD2vPg?=
 =?us-ascii?Q?fErJ3LAVSbszIyhmh0Uo237IU1/GavXM0Q9T06jPv7TuQKN/QWcVTEZ5Migf?=
 =?us-ascii?Q?Zu4qZvDIRnoq0QRpg/3tSfTj5/IuuV+J++GjZShnZ3Os8+6pGNMgGm+gTs0a?=
 =?us-ascii?Q?VRhVyxdUaEsle9p8baL3DqmuJLk9ZwA3U96cxe3jAlwP8dX9X8hUzf1X5VvD?=
 =?us-ascii?Q?LkgwXFRL2+E3YNahuW6nSTK8YtaMHJaGeDmYhFk4LMHF37YCWqSvIDJpvt2w?=
 =?us-ascii?Q?1mmc+6GwxGqUMfK8dYHOXiFqmBioC1e4g7zbvtxK+J+ZTMCaQueoG7MsuoBm?=
 =?us-ascii?Q?THV/PmUuZsTytkcBCydINdi7TIcdB3fdCdIA6kCdudjORXxe4X1X1kA0cPHh?=
 =?us-ascii?Q?m/jhOGGS81gA7SmejA8AdU/aa+Q3jQRRsweKoMrhHtJy/MxAFSJNAbzn+yvM?=
 =?us-ascii?Q?D06kEaSBFo8OUubEYvuCRWEvvmjwQi4SglD6EXllqSzo/bCFdXur7Hu3/GWZ?=
 =?us-ascii?Q?ShLlXgxmDiS77K+5EzW42QFNY3ikCFFG16aqMKxaneNv76uQwQsAHtKMh9Mn?=
 =?us-ascii?Q?rRIvpLBPNVsw4TlBbCiQYPnwucN0EurIiow0SQC5PS7/aY0nSSrRyVLxbYft?=
 =?us-ascii?Q?0uFUp7iSbTvTm2jIRG71ksJ+PUSBZOt18QfQeJQsbxkiZ6k/+z0wluISwpE1?=
 =?us-ascii?Q?3q6HVbdJW7VpPAgQJyVl0YIAtWUO2JWaIFWe2M5SRKx+k3LQwG1kPZQgP48W?=
 =?us-ascii?Q?LlfbHcEy+XgNE6xxL8OmLyiVSS1VYWatmLMCZ6kJQrlmo6RpgeisTI+EJaPx?=
 =?us-ascii?Q?zukyynyeDhpK10BnBTyHhoIQlRXe0WJD7BU9PcITVQgN0+wXwh0jTiqc+51A?=
 =?us-ascii?Q?D1zjg4HhnHOMz0ypa2E276rnlazVwxUMLSSWsgskDcJjlJnuJW/vTlOmGGD6?=
 =?us-ascii?Q?X65MRMqv6NxdWow6ZnFQLlBIgzfX9B7ahWUq8tEKqP0b+2dKVIOuHL0xn+UW?=
 =?us-ascii?Q?knFedWsLlbVZyF87nxenCRVd1ryWiyAEoTBcmUiSlq/wyd2tBUsybRDIlUGA?=
 =?us-ascii?Q?UEFVXjCZ50ti1OS5GzIuebJGT/VAGbV7qcq+zo2iO815KUAVHB11BYexw/T2?=
 =?us-ascii?Q?2DtDvR8q3QaKXeWwekz8+utOeOdFN1qGfkthI8ROD39C33q7ukSXp7vYioAd?=
 =?us-ascii?Q?lkTvq7THSvZkiAz0ABoy6HXFBFnjU30FtzfjCokzlVzOoyjaY8BHYaXG4mT9?=
 =?us-ascii?Q?zDhUnJpR6qJg1Miz+JDQQoCdsEpuGD6YNBgpIeMWDLhHgySP6Dxu0J4/L3d1?=
 =?us-ascii?Q?mfdFdIW2Qwui1FuJv8iRg7kUoHGCqNGbfK6exB8aJJbSBuMj6sUN2u03+ezn?=
 =?us-ascii?Q?BvCQCPaRlDIODjLlWgP5mPL7pO32O04hhwKng4X+0QSlqRjZ6PAxBzjPmkrk?=
 =?us-ascii?Q?aqtTN7k0cJ5DgH4e5L+tbHPho7gqLWV/tNh0PkcDms2EV4Z7H/oCO6OCDrRx?=
 =?us-ascii?Q?PVoiELvPkWVRRf+crGGBSk7MD0SVP+g00BTW4uNQbn9maX0UO3IooW70+4wT?=
 =?us-ascii?Q?Dqmp/er8+txC9Nglr2QMZidXndXpVU/MR6j2J2GG5uPp9LZCQGXLYn+MH+uT?=
 =?us-ascii?Q?I4KbKi2JI+F2vwUiEiwdrtbucKUgCvzy/L2cjpoKYbNtXpNyidFpz0ppeCqu?=
 =?us-ascii?Q?uXNBX93AK8Ws30JWvW5+A30lSBOgv+Ao5amuPAAloPuBbayibAhFY/iOBK12?=
 =?us-ascii?Q?42qZUdMG4w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05dfb837-ccf8-4920-c7e7-08deab82694c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 15:16:13.5614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwHMIwZkGeF5a3aFHwFBDsFjJr6kvQGFr1PCSNAh1WyE/lmG2b5yME9kFqnttSUnYC3s5ngjfOOhPolHaxAvLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277
X-Rspamd-Queue-Id: DACD74DD104
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-284901-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Instead of waiting until the last moment to check if an FDB entry should
be added to HW, move the check earlier (before even scheduling the work
item) so that we don't just waste time.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 476ee8b46921..a057fd85bd27 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2725,8 +2725,6 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 
 	switch (switchdev_work->event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
-		if (!fdb_info->added_by_user || fdb_info->is_local)
-			break;
 		if (is_unicast_ether_addr(fdb_info->addr))
 			err = dpaa2_switch_port_fdb_add_uc(netdev_priv(dev),
 							   fdb_info->addr);
@@ -2740,8 +2738,6 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 					 &fdb_info->info, NULL);
 		break;
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
-		if (!fdb_info->added_by_user || fdb_info->is_local)
-			break;
 		if (is_unicast_ether_addr(fdb_info->addr))
 			dpaa2_switch_port_fdb_del_uc(netdev_priv(dev), fdb_info->addr);
 		else
@@ -2767,6 +2763,9 @@ static int dpaa2_switch_port_fdb_event(struct notifier_block *nb,
 	if (!dpaa2_switch_port_dev_check(dev))
 		return NOTIFY_DONE;
 
+	if (!fdb_info->added_by_user || fdb_info->is_local)
+		return NOTIFY_DONE;
+
 	switchdev_work = kzalloc_obj(*switchdev_work, GFP_ATOMIC);
 	if (!switchdev_work)
 		return NOTIFY_BAD;
-- 
2.25.1


