Return-Path: <netdev+bounces-125886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BDB96F1C2
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00EE01F24834
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 10:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B161C8FC3;
	Fri,  6 Sep 2024 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=SILICOMLTD.onmicrosoft.com header.i=@SILICOMLTD.onmicrosoft.com header.b="EIfNAXc+"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11022111.outbound.protection.outlook.com [52.101.66.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036A5149013;
	Fri,  6 Sep 2024 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619325; cv=fail; b=MkCk0GPH4+LW0UCIifT5GKS6eKsCTzbptM2iO6IHwOj3ooLawfca/quUHKGyLC8/uNAtE2otv6Kts5+v+JCTHQDYRPSL0jxD+eotaf1WY57wvMv8biLuOedhvW2PTYzv9FjobHL5Hf1g9/QqtXWP7eXlG4+5I9Jw2n2Daq2YgdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619325; c=relaxed/simple;
	bh=EkJ++q5X484V9pEfjkL+CUkvX5VugwlWS2GXiw2QKaQ=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=A2AlQNl+18kHNTLMlnMCWIzvJQ90lcz35ZvFj/OqQEKXWhF0PeS2qkpsKU6y4yW5Z80RXs7AHl4Gsxrzthop2tqI0rwOps/iMHlW9tmEYJf6tt72sh6jzPmvdvPijvEXvJNQ67VjtZYj+umAhDUvLLzzYqr0SMPyNQTdfmBm4ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=silicom-usa.com; spf=pass smtp.mailfrom=silicom-usa.com; dkim=pass (1024-bit key) header.d=SILICOMLTD.onmicrosoft.com header.i=@SILICOMLTD.onmicrosoft.com header.b=EIfNAXc+; arc=fail smtp.client-ip=52.101.66.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=silicom-usa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silicom-usa.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWoz/bpetDAVIdv8xxLNPgkqjLWEBd6lZvzdFd0/xL9j+Iew8BowtF9ioafODJydVESKZ0u8kThglw1ZVyKV0VKGpRvNeMybuCwb+wviH/I8Q3Q3PS2Ll44Wn3pR1ALNc+TwE/RXyFi/S/n1aBHdZuCjLVXAtIMzv6xtHFXN/GkubWB+7ljPQkHHcS2ysHom1gyR3CU5og3IqyoYzzD/GtCqwQ2iWpEiMgU5dft+l51FEnPriFWnnM1UQVsybMXW7SAfrppDcnW8TiGEpv+wXszEBYoj5lwaJfkbMcCwn1IuSRuZ27gC2rTtGsLID5o4icA58mspxRni/WzZ8DTxBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOgedxQ77NMiSVKQTAdnjrneUiymi49rVDW2ZvK/GeM=;
 b=y4G4z9Mag0hHmTydkbAtr8KojyhOx8fr6dbNDuz/97fvB5J5aaMs/J9u7D0x84i1SyygLpogT8QZWg4m5ZbLUtFET4iX2h7n9scS6U15P5RhP4iSPBGK9nw6S3r3yVIyQii9LzxJRM6u3kejJlfdzSn+CkxqCYz4hQ4IanEhilESEWdLrgPWChERjkpAa0ZtWKQfVXtTYFHdCWcLWEyUsiXlfGS7z23bo0IUKKbLhVvVVKtMqTmZVlyQ8Ht1FQlbwzMns869D5iTxe0R5YiELYXwK0eiSRFB7prTH3/6xrvju1XpiJNH244R78j6/pbjOOMf2FIk3hk+vjeRSDy3dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOgedxQ77NMiSVKQTAdnjrneUiymi49rVDW2ZvK/GeM=;
 b=EIfNAXc+PMyKml/+NAsV/BzLzgq7cmwYTWVu6JqctgHpFW7z94cX2ZLmM6H4hs7Lb4MQPBPuoPOq/CmgDEvphtIUX2T4M9283dOsAnAadxUkWw0rVs4Ue1Zf2FrCfxTHqJx133RWal+23xQUecaOQKHpHQ0RRPd8No/2VNP/MbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silicom-usa.com;
Received: from AM0PR04MB5490.eurprd04.prod.outlook.com (2603:10a6:208:11b::24)
 by AM9PR04MB7697.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 10:42:00 +0000
Received: from AM0PR04MB5490.eurprd04.prod.outlook.com
 ([fe80::2aee:1b56:3c5e:61ce]) by AM0PR04MB5490.eurprd04.prod.outlook.com
 ([fe80::2aee:1b56:3c5e:61ce%4]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 10:42:00 +0000
From: Jeff Daly <jeffd@silicom-usa.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ixgbe: Manual AN-37 for troublesome link partners for X550 SFI
Date: Fri,  6 Sep 2024 06:41:45 -0400
Message-Id: <20240906104145.9587-1-jeffd@silicom-usa.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0017.namprd12.prod.outlook.com
 (2603:10b6:208:a8::30) To AM0PR04MB5490.eurprd04.prod.outlook.com
 (2603:10a6:208:11b::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5490:EE_|AM9PR04MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: b9add339-fce4-4107-125c-08dcce6089a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CZLWCpZ/VFwpizRR0Z0P9WN7eRHRIc8WuV7M6LMM40ypZQGIPzoClRQOMcar?=
 =?us-ascii?Q?YwJsASeKkLtZMKz2oeZU8SPaVXI6VoxU8BtrA99lbIRwOdyWyN0+378wi+qC?=
 =?us-ascii?Q?zRGUXw6gsKs/OXy5c78HPNn7PjE1zkaHogcol5NSAk9XoSZoblGnNLyn5Kmr?=
 =?us-ascii?Q?75HU/qaTs0G/oq71WNqe5npN1JV1rx3o611ndONlKNJ57zCrF/rSapkpIJBk?=
 =?us-ascii?Q?Yk0NCQnJLwjUl5ZPbRACLnb5oz0h5WfeANip9jYm86jTXOjA/6yQKlCiifvK?=
 =?us-ascii?Q?WskgJFnLmCdvEOtOBiEmk8BS8Q1G6iNRPPDqxRyvcuA87PcuXqFf9wl60BEM?=
 =?us-ascii?Q?YXlsr25IPSINvZRqiCw1VfC1zFip9KA4kgasdolTXIq3a7X0Imd5lruYsDp8?=
 =?us-ascii?Q?7Ff+oKMNgYcIW/h2FGHdyT259uqV5Ls/2F0zRL4+dw/YfkrN1F4ke3s+Gwr0?=
 =?us-ascii?Q?yLtSv0zFIzmW//vsXkVkekcFWof5tg2jn9zfaYn/72mJIA/rsFNZtZsLxnmZ?=
 =?us-ascii?Q?S/fmPqd2pvDjYpaGADr4tFFkpzoqybBcbWKdaJNhnik/+wyeZ+U/ibEiCsf0?=
 =?us-ascii?Q?/l9Q4nWEV135fOq9YxWz52aPK6zc8W5+rDZLBpxJrVsQO6fg4ifHkdZiKcEz?=
 =?us-ascii?Q?tI90vmKTKz0KGTlDFPSSaAqY99pI+x9PyyB1WuyKubUPnex+1YbFRISa0rxX?=
 =?us-ascii?Q?yzcJNL4H0yWxAkOk7B86+mTIWUkqZ9NjU00Ka6qjnVaCMbeCJPl1Lb3Hj9Ea?=
 =?us-ascii?Q?Mgeh43mUK5Yw84nld0gE3KluCaVVoA8JeVEoFmc6HmpxQPiuyXxpVR4wK1on?=
 =?us-ascii?Q?0uouyt9xhSAvuIH6l/RDKlpNjTGmLZQGPde4oxyc4hJDK0ze46f9FMCHX0XL?=
 =?us-ascii?Q?cPn2asmqJ/TgiHmcYXV7elLMFa98Qi/42R2MmrNLsz/V+0/nudAMfXtG+hO2?=
 =?us-ascii?Q?cdXZijqe1d3gfGbf7s3978ePzcAx2Rumoy+GMK5t7ORpWCIpF+ADrLI41UcZ?=
 =?us-ascii?Q?O2p9L53RL0S1Ifkbi6fARflBkDcZ4YSJ9kBiQp2plC9vj12LuB+XagbHJoRG?=
 =?us-ascii?Q?KuqRKHhfZxzyb+saXoNVVX9NHL6Fr/aQ6Le+8MsCxdAU1D59ksf3bdqNG0Df?=
 =?us-ascii?Q?0aj4n9Nxl/PeL6/pak12HaYcInqs900+AOGMV29VslxtgA51cke2Qc6EtcWH?=
 =?us-ascii?Q?K+C17p/GpXxC0oKwYeao6S40H6smFg4MeKHPXQKyjdQcSP6KiQDCJl2hi0qw?=
 =?us-ascii?Q?aBYBGh+iVk81OxOloDXXU/muEHKGR3gFreeR9omaIBKrz0hl2DepCr6Ps7Gg?=
 =?us-ascii?Q?n1hTVTKBdFasFYAVsjp+eIaz7AVC2Tzz5yMS0VdBehh+F//RRsZotvEFF7HY?=
 =?us-ascii?Q?IT0lP/WoQ77JykozIdDYaweiENy0nzJcpWBkZv6vR52AxZufOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5490.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JCC2y3H6pFQB0IEllD7POfUPzr67xsaiZejjYDDsRKCKqPQLjo4e+sCH95mo?=
 =?us-ascii?Q?7JZTviJoXRceiJVHGw19fsYujCVAt3rQFL04oSFw2Tme51NlsbWjpHOfD15I?=
 =?us-ascii?Q?XZuYXpdrKZCO+n8Ap2WZQFAsB8+IF+slc3d6An+GaYGAXvoZholpeKurSCuJ?=
 =?us-ascii?Q?7gAvcNzSo4odWi+SYutzXALwXAMNSaSy/JPNad3DzU0WHcwWweuvrs1HJPzO?=
 =?us-ascii?Q?TYfD8RqEWSAMaYu6zo94eXFnwe3YgM0o/VAx34xRpLetynruILm9zUcd5rdN?=
 =?us-ascii?Q?5y03JdMGPV2TeBd8Ea0IVQe3Q1cBKZJIS6C71EdLM6fwHyBgSp6tvDdHMKQJ?=
 =?us-ascii?Q?Ny7+Q3NT4f3wQ3iuGuPTLd8+qIC/z+y0W4/70SLD+zhekUJaQXWWZgDwuA9x?=
 =?us-ascii?Q?dokrhAYh4DnoFBCy9b9YLVfv5pl0LNIm3xAyhuZDoOBO2Mhnh9hnn3spcluI?=
 =?us-ascii?Q?zxvaDQUONKpUQc8sd526/t7Uftejb4fHTNQsl5vPzUZ0757U1FZUwZjUIBrf?=
 =?us-ascii?Q?AGt09R4FIjlj2zUh9XaBIT7gO7qIyj6d9J0cE0FUC2lDzXHCjFdhalq7f4fO?=
 =?us-ascii?Q?MUWGJiZut6GiIkMbVND0UrcSZ9+qaf5f/4e6WaiOWmLre/8fGeQSOefwZcev?=
 =?us-ascii?Q?8JheKP+tOFuqFIS38X4BIZ11zBMHUynZiHrX/+2UpIJGxfaI5hD06VLXB3b+?=
 =?us-ascii?Q?/xYpMdCf3aMQlJqil/cCa3yBmHTCcSX+CxeZTrvB32OKNRsiekf0fQBUrkFh?=
 =?us-ascii?Q?FldoJ56vH5Y335degmjdL5xdQpj4RxJPlHeLjZgKadLtD+gYlVpfBBfJVNbH?=
 =?us-ascii?Q?BemNlg9aycR08rfl5q4JYz+nt20JIGEdEklGSQ4EXTX+3Kq6PFzuOdk1o5b5?=
 =?us-ascii?Q?xbfS1Jc+CIM0wGyH3TCEqHKNXC/wMITIJ53Y3HS2+LMAelnqrw6wRc0icBdw?=
 =?us-ascii?Q?OxxjauRnX6rcscOsRZHZHdJceVpOk7uO1R/fYTudR2nduXTnr3jHXLEzetNE?=
 =?us-ascii?Q?OyWlTZBH05k1aNBsJTVGt4439+WU1ckTl6yWxTVfno+E88ycSiDABL0xZVbu?=
 =?us-ascii?Q?oC8trnwDFjOn4mw/RpjCFxI2CXCEozkLK5k6/k/6oFPH3w3OuFqEFQV7s2g1?=
 =?us-ascii?Q?Aj1YRe0CDh6Cndh4kNQJEyApl9vXfb94pRosdQ/2Q6K0Rwoa04ccPlHtgTmq?=
 =?us-ascii?Q?32LmciDBeuV8sQlhw3sHyIZOH3zMnZabUu3xBbHbmUtMpVHh/3KbQmGRZ4Yb?=
 =?us-ascii?Q?322yRgeasTPeSIBYt20dKATnoeNQ8ERzH/y3H/4z8ZwL9KsKTJCO9dP54w2Y?=
 =?us-ascii?Q?QU1uR1mdZ4FVquFECAa/iPFTb7nIitlKWWugdWB5+9W+222u86avL9m2WkD0?=
 =?us-ascii?Q?gW9I0jr2Rx3NpxJP8h/WKWNTqQ/yNDxX44CIknOfxUsEE6Kaw10OdITT9z7t?=
 =?us-ascii?Q?aefcQf7cEL/1xoN4Y64nzk1HIeFW+PEhKvc6m9PkjMivw9SHpzIL7OD1bBmE?=
 =?us-ascii?Q?hn2+msmp41hX2T90kaLtnUglVyhzld2sX1y0lONORe5v+kejF9Qwc6V/vr7x?=
 =?us-ascii?Q?69nGW3aGowx23n9gtptC+FANAZ1VCGwySxefmHjC?=
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9add339-fce4-4107-125c-08dcce6089a8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5490.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 10:42:00.3092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2HwGiiGNzYavH00foDQoPxcHTS666GmzYktrOj8VaOqB05Kjuzlj4BhA90hbTaFc4NyoeQ7+xGxeH9qBCmwXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7697

Resubmit commit 565736048bd5 ("ixgbe: Manual AN-37 for troublesome link
partners for X550 SFI")

Some (Juniper MX5) SFP link partners exhibit a disinclination to
autonegotiate with X550 configured in SFI mode.  This patch enables
a manual AN-37 restart to work around the problem.

Resubmitted patch includes a module parameter (default disabled) to
isolate changes.

Signed-off-by: Jeff Daly <jeffd@silicom-usa.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  8 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  4 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 52 +++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 8b8404d8c946..ef77df0f94a6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -157,6 +157,11 @@ module_param(allow_unsupported_sfp, bool, 0444);
 MODULE_PARM_DESC(allow_unsupported_sfp,
 		 "Allow unsupported and untested SFP+ modules on 82599-based adapters");
 
+static bool manual_an37_for_sfi;
+module_param(manual_an37_for_sfi, bool, 0444);
+MODULE_PARM_DESC(manual_an37_for_sfi,
+		 "Manual AN-37 for troublesome link partners for X550 SFI");
+
 #define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV|NETIF_MSG_PROBE|NETIF_MSG_LINK)
 static int debug = -1;
 module_param(debug, int, 0);
@@ -10977,6 +10982,9 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (allow_unsupported_sfp)
 		hw->allow_unsupported_sfp = allow_unsupported_sfp;
 
+	if (manual_an37_for_sfi)
+		hw->manual_an37_for_sfi = manual_an37_for_sfi;
+
 	/* reset_hw fills in the perm_addr as well */
 	hw->phy.reset_if_overtemp = true;
 	err = hw->mac.ops.reset_hw(hw);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 346e3d9114a8..288bb2be3c23 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3654,6 +3654,7 @@ struct ixgbe_hw {
 	bool				allow_unsupported_sfp;
 	bool				wol_enabled;
 	bool				need_crosstalk_fix;
+	bool				manual_an37_for_sfi;
 };
 
 struct ixgbe_info {
@@ -3675,7 +3676,9 @@ struct ixgbe_info {
 #define IXGBE_KRM_LINK_S1(P)		((P) ? 0x8200 : 0x4200)
 #define IXGBE_KRM_LINK_CTRL_1(P)	((P) ? 0x820C : 0x420C)
 #define IXGBE_KRM_AN_CNTL_1(P)		((P) ? 0x822C : 0x422C)
+#define IXGBE_KRM_AN_CNTL_4(P)		((P) ? 0x8238 : 0x4238)
 #define IXGBE_KRM_AN_CNTL_8(P)		((P) ? 0x8248 : 0x4248)
+#define IXGBE_KRM_PCS_KX_AN(P)		((P) ? 0x9918 : 0x5918)
 #define IXGBE_KRM_SGMII_CTRL(P)		((P) ? 0x82A0 : 0x42A0)
 #define IXGBE_KRM_LP_BASE_PAGE_HIGH(P)	((P) ? 0x836C : 0x436C)
 #define IXGBE_KRM_DSP_TXFFE_STATE_4(P)	((P) ? 0x8634 : 0x4634)
@@ -3685,6 +3688,7 @@ struct ixgbe_info {
 #define IXGBE_KRM_PMD_FLX_MASK_ST20(P)	((P) ? 0x9054 : 0x5054)
 #define IXGBE_KRM_TX_COEFF_CTRL_1(P)	((P) ? 0x9520 : 0x5520)
 #define IXGBE_KRM_RX_ANA_CTL(P)		((P) ? 0x9A00 : 0x5A00)
+#define IXGBE_KRM_FLX_TMRS_CTRL_ST31(P)	((P) ? 0x9180 : 0x5180)
 
 #define IXGBE_KRM_PMD_FLX_MASK_ST20_SFI_10G_DA		~(0x3 << 20)
 #define IXGBE_KRM_PMD_FLX_MASK_ST20_SFI_10G_SR		BIT(20)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index a5f644934445..e3117ccf092c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1726,6 +1726,58 @@ static int ixgbe_setup_sfi_x550a(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
 				IXGBE_KRM_PMD_FLX_MASK_ST20(hw->bus.lan_id),
 				IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
 
+	if (hw->manual_an37_for_sfi) {
+		/* change mode enforcement rules to hybrid */
+		(void)mac->ops.read_iosf_sb_reg(hw,
+			IXGBE_KRM_FLX_TMRS_CTRL_ST31(hw->bus.lan_id),
+			IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
+			reg_val |= 0x0400;
+
+		(void)mac->ops.write_iosf_sb_reg(hw,
+			IXGBE_KRM_FLX_TMRS_CTRL_ST31(hw->bus.lan_id),
+			IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
+
+		/* manually control the config */
+		(void)mac->ops.read_iosf_sb_reg(hw,
+			IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
+			IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
+		reg_val |= 0x20002240;
+
+		(void)mac->ops.write_iosf_sb_reg(hw,
+			IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
+			IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
+
+		/* move the AN base page values */
+		(void)mac->ops.read_iosf_sb_reg(hw,
+			IXGBE_KRM_PCS_KX_AN(hw->bus.lan_id),
+			IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
+		reg_val |= 0x1;
+
+		(void)mac->ops.write_iosf_sb_reg(hw,
+			IXGBE_KRM_PCS_KX_AN(hw->bus.lan_id),
+			IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
+
+		/* set the AN37 over CB mode */
+		(void)mac->ops.read_iosf_sb_reg(hw,
+			IXGBE_KRM_AN_CNTL_4(hw->bus.lan_id),
+			IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
+		reg_val |= 0x20000000;
+
+		(void)mac->ops.write_iosf_sb_reg(hw,
+			IXGBE_KRM_AN_CNTL_4(hw->bus.lan_id),
+			IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
+
+		/* restart AN manually */
+		(void)mac->ops.read_iosf_sb_reg(hw,
+			IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
+			IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
+		reg_val |= IXGBE_KRM_LINK_CTRL_1_TETH_AN_RESTART;
+
+		(void)mac->ops.write_iosf_sb_reg(hw,
+			IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
+			IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
+	}
+
 	/* Toggle port SW reset by AN reset. */
 	status = ixgbe_restart_an_internal_phy_x550em(hw);
 
-- 
2.25.1


