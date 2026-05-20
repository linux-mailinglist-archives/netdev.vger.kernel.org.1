Return-Path: <netdev+bounces-289781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBg/MxZYDWpuwQUAu9opvQ
	(envelope-from <netdev+bounces-289781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:43:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FF75884C7
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9FF930391E3
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82438344D81;
	Wed, 20 May 2026 06:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R6520YjA"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B77533F58B;
	Wed, 20 May 2026 06:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259333; cv=fail; b=aVOFFcKbOCwAg9+3kZyGfNFZX2xD3WXOCIiR/KoazIMUcoaCmOTwKZdSCNL94Q+nz38Joq4Bvu4k7eghzHt3clieE3MBYZ5B3owlWGiR+ZALoddUtOKENgd4+S+9Ijtj0cChoEctKTbh0ItLNF4499ayz2mgO1T+qvAFDHzY8ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259333; c=relaxed/simple;
	bh=v0I85YJcxGiwmjXMcIbx7cZIcihKONCK73Fhu8uIfG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TTkktDpXLGvs4hQ184z/DYQ5kdQTve9zVE5xPycEo/BiC1L0fbc7A9PK/D1e/ZU+38lrYs93XJkDdLJNHJa1+jTIYqC9OjxmSk42RzGbl/IS9aUURk21ONTVZM8tjSpl2Z3DsgUIEnhVuYnsWK2ythXLiHN1pd6A+cyk6E8PkU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R6520YjA; arc=fail smtp.client-ip=52.101.84.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNPO5szzTyQ/ZFNZpEQWLMWFJ3oAHS0TPFmVBY5TT48IN6b9ivpnUz4x4pPs+d9HkRPWav0OuPJIqaM2xLa+QBKC6vuhkP2isiz+kkpfzPeC/4TGodR1BwyL7r1lQzE2DQVe8RsegzFB5TC5G7ncZh8DJ0SfZLi+sQJzpGpQkVl7cMKYUinmy2BqthXmIoqSPWjm5dTpscFharjemC2r+E9gCvOBlWeO+1VwIgfYOvxuZMhMUVTpztzbSvQY5EXYcFlLxuxPfjmO2SQYXplGiqMAm7FDGYePclXE2c+HvrOLr2jwgzme/2Q5LwWGAc1S8aZTlrOVa/qt3uBJ13dGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuplyGqa5jYAgMC+ls9wqvI06+BAVcpqAIgBVchaDUU=;
 b=egry2eLUeCT9tj4DoCjlkU+R6FfT3F/DlQOlWvhUVvUz/RZuXBxg/qEQ0nTpZC1gSD6uku+WesNPMjJK5nDE315PKUoG/sNL4kiWGnRNK1/cYoicfpnxxPa5TeG/TTx8xq+z2JcDuZ3JL1K+QF3Qyakxh4oNRmb9eM/IVvt4/CiyBhBl/ijoqzsJqcj6QEP7HAe+3wUbHBklicOnQvi4Uh30UM772u3ZGbmpHOyYN8+3/seA6KblmICC5gkeUUeTYE/XTuuGxgZ4i8292JLS8ArpSBtTKIpa6MGXZdw18KzPkjnA79EGl/94MS6o8QuRfUR8xTWLSZFhbCLihPxPPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuplyGqa5jYAgMC+ls9wqvI06+BAVcpqAIgBVchaDUU=;
 b=R6520YjApQckbjDhjEq+azy/d6IKFE+uIgxTTnqWCf048GLhbBK06Bgnf4GmHqz1ZJe3qyvnSiULOnyL6icXwRMsc0Sq3QXqFUS1fx2pBCdk3caCJZM6wUvULOZAgi7OtzycvUMwvdNodsRMS+BGFJRRX03ypgoh3pK00G7C8Pmfr0qrobAeQk+9iBEQW5Izk3NlgJ//UELkj3oLD6UV7jSSBKzV9toUzaWasDYaLVvq2NVh7auGBd0Pxr2Q3ArII+AggvJtXQjrepdl5aLYNgBp2Rcw/jBkAbJJ54QwWgcCF6vKBM3xzVQ+NxV/wW6dXhSvFM1O6otfxgXjidgDSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM0PR04MB6948.eurprd04.prod.outlook.com (2603:10a6:208:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 06:42:08 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 20 May 2026
 06:42:08 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hramamurthy@google.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	catalin.horghidan@nxp.com
Subject: [PATCH v3 net 3/9] net: enetc: add ratelimiting to VF mailbox error messages
Date: Wed, 20 May 2026 14:44:15 +0800
Message-Id: <20260520064421.91569-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260520064421.91569-1-wei.fang@nxp.com>
References: <20260520064421.91569-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|AM0PR04MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: ab7b641d-845c-4467-da03-08deb63aea20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|19092799006|366016|38350700014|22082099003|56012099003|18002099003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	W5lowwr1TaCXVTojNUZkJQ+7ApYYOUkMOGN2DXWOgwWfbk0SDt/l+hqrokknXkDsMfjpPvKHSmYwoLAAksPhB3/7bHjuKGx+x/nO/yyX9oYnA0fIB761+fG/UorY9IV6DBKhZrd6r0I9RPtzVy2hCKjj80swpm+pIxtQwzREkwUBWY40gezO6PWQvkGgRDfbNIEHA4gEqwZsX/WAVJ8Jn5g2gqftNL/3eyKIpBzFPC+vaeF9LISdGzgahuZPjLM41Vt1O8+to7u03YvDhyrd2zw07ta/jibVNX2+eybqR/OB3eW7aEBg5qhh8s/laH//UKEQA08Teai9L26sSS84WcpxL5IPQNiUJ6Uxca2UC5XUI5+v7dJ9sJbLjbzoJHBDXgOqF3J990WDTVsBGT75VyLa/Y5/zQ+8E8EF1QFbJ6KLzgzxyeRx6ZkbL/JqOt3wAbSeUz97rfUxXQ7wfKhxHPCt/N6YWogqxOrHJX3XkFeCjv+xRdTgTFspp/hz2k2m6Hz8jH3UNjyRv4kAH8INkjqm8YzIfrFn26upzFiE7qFaGc7RTd8oKL4X2o27iZEFNPq60RiVrd8o3zkoGq2N2JoSw6Z+GlmV50qyV713v8na1vg29lX1knaSGf05qb/rVC9ZGhG4UIdXgpRjaKOR0QTnmaagL3KxFobUmFX6nE+T7DBSwy25EKj58VV7uenr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(19092799006)(366016)(38350700014)(22082099003)(56012099003)(18002099003)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dmra7ip1YdPc29mIB6p4jRMl1pCC1OoexQMV1fh8gFg9bE4bfkBeTsZ6HC1k?=
 =?us-ascii?Q?4RAicgR8QR3b4BaGG2B3klJPeP7cV4oG4zPlZFwCYSPF4/AZJG+EW6k+iN5U?=
 =?us-ascii?Q?xD4QusAVh0IK1r5tLUYrQiGE8fAlM3qn0eoPJ6fwRzp5a8Dhp3ztvS5yuWCC?=
 =?us-ascii?Q?eI/0Q60YtK7QZpupXnZsxH5MGFap696SyB8NJ/GjDgle6HhntFo8yRj9Xtci?=
 =?us-ascii?Q?GRzv9idfPQeTy9iFItse2qtXaVb3dFOlm84zcun0vvPn90Rx6n8FqocyJ4Ke?=
 =?us-ascii?Q?0TfdSyH2x6xb31WCKh2Ops5U2yT7KEPkNUSmIdsEa9GFP8QJualm7262NoCO?=
 =?us-ascii?Q?FQRA2gvacr4jTcJrxlL8eVfQAT3TEnMKwjKNCL2O94px9JalvH/YbvmFiwBC?=
 =?us-ascii?Q?Sn2dgQFBn0EyGWUjlmHCJTbHdViqZ5mSNNXc93/qE5vIySM87NFb8no1EOk9?=
 =?us-ascii?Q?qmAOeF/EEHtEt1oAqN0aPHEbePG6caG/0r9+AkxYvxmk9S+A2eGs/YyodkCG?=
 =?us-ascii?Q?ID1ciznyPaaHMRz6AGQTO3TsPGvBWZG1QzPamFjRMOUDXGET8EY9apqdIiZE?=
 =?us-ascii?Q?CNH/wfGZOAxIIcLkar/A29HVRIN5dhIl3DlMZ8fG/aMmYHZvCofN8E6d+MPT?=
 =?us-ascii?Q?SVenycJ6uvFYUwvu4HXbi4sdROQsdUthBKuubM6APGk3zFrfyjCC8B3JEWVt?=
 =?us-ascii?Q?Hgwh86/eyEdIJZIrSgAfcBcZYkj5BWgxT8abqKkCOhpBWKOsYGQMfax2QSyk?=
 =?us-ascii?Q?9oJCTXY0x48D/LdgwCP/oQYradnXo6Wi3QgZS/ydaE2Wt1CwDS/o9xZm30oD?=
 =?us-ascii?Q?AKynUl4OjO0gTyQuNtscYrextI9i6kBdb/cVobVPHt2/61sxRnYOWatwtO7v?=
 =?us-ascii?Q?xU2k8xFW6pVr5nLKRyoKjEaKRhv8ad572FjpgaVGPoj7KXIBarkkrPWgK1Uh?=
 =?us-ascii?Q?23VTIHTEZeHBRWfz4ZZPUTcavCx8TWUQiereUEEAm6SNXF8HZHdAC1Qy5OAk?=
 =?us-ascii?Q?eDy3MOKrMVKcpSCKKSx5yRFRPhsh798ikVCIXORHDYgeU1mTqFT5pcrPtct0?=
 =?us-ascii?Q?kR6+VdLijtTjvqzoCg331dVnsW/cEmrtSjRnPale85JL9AKn+u9TTRaeKQgn?=
 =?us-ascii?Q?K11siZA+/bR+Zj8VXoDGr3Y0UHncW49BuA9DDGUOfylq9JyTlJ0H/dMEt/nt?=
 =?us-ascii?Q?0ifGRNR4PbOgNxBVvGZs+AVPCCXbee2PROz6CSnSqOcOyhsxNQnc348IX3m4?=
 =?us-ascii?Q?K5VCYQj+gzEeOsGEczs9g3kAUP3h9vjd4UIdHgMxC2m+6COtxS5NWBRACk5S?=
 =?us-ascii?Q?mBE6lGzCbL9KVLrU94+rtjdm3Ub2DUuCcTWhTYASGUIyqF5wu3wz8ojKcuqp?=
 =?us-ascii?Q?uKhD+POaiAE9j0ZYcZ1LaWBAV88627HMt18QdhxGRlC+rIucfDd+nwfD+S+l?=
 =?us-ascii?Q?7vcHXkDhoVy2zIm5dkP4VG6VfjaxavDawPF4j4pRcPKVHsOK6683LMV/UMLQ?=
 =?us-ascii?Q?WMTl++qlUlxHDgPAaQ0A/iywOpvIfTfifxrHfPob9vKpxR5j4hDYTuuEJ9rH?=
 =?us-ascii?Q?gzsZmYrlc2n9BVlf0k9UL93gW6W8aZVSNm3MeQRsJAq6AzFer4twsYafkQgq?=
 =?us-ascii?Q?jh/6bkCdncNIEoL3efas2buGPqaTgqqOHWIKL51sgXx3Kh8En58cyCSnuosV?=
 =?us-ascii?Q?VaID3H08x80kv+KwiTPWtZ8xCr/8F9jsQa6ICoKUYMEqHP9ILB9bbKJ8TkLm?=
 =?us-ascii?Q?53bDwrbG1A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7b641d-845c-4467-da03-08deb63aea20
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 06:42:08.7979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A659ge24WHStGb6MLbjzNLdnSfbzVhfHXGH+uwpC+XSIXlP0VjcW6yMNZX8IvwTffcxIjl31W6EUJ1Y6MAPUag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6948
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289781-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 03FF75884C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko reported that a buggy or malicious guest VM can flood the host
kernel log by repeatedly sending VF-to-PF messages at a high rate,
degrading host performance and hiding important system logs [1].

Fix by replacing dev_err()/dev_warn() with dev_err_ratelimited(),
limiting output to the default kernel ratelimit. This ensures errors are
still logged for debugging while preventing log flooding attacks.

Link: https://sashiko.dev/#/patchset/20260511080805.2052495-1-wei.fang%40nxp.com #1
Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index b743b6d33ccc..dea3a92c4722 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -494,8 +494,9 @@ static u16 enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
 
 	addr = cmd->mac.sa_data;
 	if (vf_state->flags & ENETC_VF_FLAG_PF_SET_MAC) {
-		dev_warn(dev, "Attempt to override PF set mac addr for VF%d\n",
-			 vf_id);
+		dev_err_ratelimited(dev,
+				    "VF%d attempted to override PF set MAC\n",
+				    vf_id);
 		return ENETC_MSG_CMD_STATUS_FAIL;
 	}
 
@@ -520,8 +521,9 @@ void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id, u16 *status)
 		break;
 	default:
 		*status = ENETC_MSG_CMD_STATUS_FAIL;
-		dev_err(dev, "command not supported (cmd_type: 0x%x)\n",
-			cmd_type);
+		dev_err_ratelimited(dev,
+				    "command not supported (cmd_type: 0x%x)\n",
+				    cmd_type);
 	}
 }
 
-- 
2.34.1


