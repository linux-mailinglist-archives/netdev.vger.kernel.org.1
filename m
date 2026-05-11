Return-Path: <netdev+bounces-286519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DsqL06WAWqXfAEAu9opvQ
	(envelope-from <netdev+bounces-286519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:41:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC2250A3CF
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D9D230607D8
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851213BE147;
	Mon, 11 May 2026 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ImzhTa6r"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010031.outbound.protection.outlook.com [52.101.84.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15163BB9EF;
	Mon, 11 May 2026 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488525; cv=fail; b=KXf1syqZ9gUDO+3sbcEQTzkyJfSP13FyeXF5xp0nsEFDNJdn4+ep2nLaGP8PI926DqKtOeGDnhR7L1RK8txh2gqeyuG1rrqApBB+IKJzkW4wMwSJi+wHmIEJ9Ulioekuo5N1DmP4itUrE1tZvvdB2iwRHJywJBrluAhf7OQaLVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488525; c=relaxed/simple;
	bh=XSR729WUHSkcebFMtQmZOSmaabQCHHVxR2372dsfhK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cTrYDneBY8uXY2m6JjjCecb2+bZbO8Fysh66YmeYoiCz6yGti1pVh/Kz9NP/VGt6TYUUqAD2yE7p6pvP2ve5zR/pjrUjkxe0ngIlag4gN2CpOUrAgPWFpnFUDfbW9GNcR/L1x23kLt/HkoMeqD/IO30I67vrGLYl8NihseUHW4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ImzhTa6r; arc=fail smtp.client-ip=52.101.84.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=roy2HyTcNigIxzt8nPW8pig4dywM8Fwxc4S0deQD0pO+a7LW5nUT50VlwJbj1qnrwdW6wjb4COTIzxf2ofnAiMn6/D2A8n/LMSxS81ks/ihekt2DTikZ7B23ddiIWNw0cKq5gPiCPUmsAptsI6j1riijtuDAx4a9o6FeaukGFoW3bcgOz+2uAljIM8emX+KRCB3Ne+92MhZK2XNoCtmxFIQvPNQMDq/A7AYChwFL+I0eHxPco7tF9hZur8NXs/0n7a3R45uOwyytqN+frxGpPPQlOTehJ8yXGjIiv4PGJYRabDZR7OQ8qb7ZWs7mtmyL/SMRJc1WLomhf8VVHRGyUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kli22O7M+23ruj6+6QTOQxjN8xRSxdnsrOanxceTcoo=;
 b=cxSKwGvlyoqyFwOkG8NS0Lc79PDWDTG5pSpbwiwoZV0sTWVYHF7drIWJ3oU2PweFgYxVnIgLpzZFhrEEnduYtLmk0D8KotZcANkluyRLZ0SkDaXo/5URacj/0wd7n+gvvGulvKhDL32BqPSaUQIkJn1MZf+Jyrp9zOkhOAkGSyHFKaH7CN9qJ2eYyZek5ttO/r/X97LDXdn/2IYQejOJdQ5oMDWOhqxjyi7qUc0DqE2SMTj12C0xAzFpCp05lGE/22h1Bs643seQ72KMa/IbTHBL0zvpXlssSSiyGSv5ttty9vpDOW7fM2Z2Q6IuLxvucDgNMU5ZBra3AgAJ26nsag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kli22O7M+23ruj6+6QTOQxjN8xRSxdnsrOanxceTcoo=;
 b=ImzhTa6rOer5ZdIBSluH7vKjM5NkiRbXOYHUg6ghcT1Si3pWUf1/qvpvuGoDsYQxLUnPEbgaJ71m+3EW8l1lKQK0N2OK7UaNgM/WaNtmLdEv6s0p1E0n5oOEgHJTsRhF6HvT3x6cxnN19PFodfkUoFuvAxkAQ/bhoJWs4WdY2ZZ61n+8Gp6MdoJuC2ezErRnuGdSS2+jnhq3GM4DQ0c6i1Jwb6NeeO09QLKVQ+9PvajN9Z+aHI6fMSS23OaIFZsmUf697jyfNVcPa5dzRGPyOKF1b6HT6Zjcoq2UNK+bG2qg2bp4uFM/BqVU8C9arQxbQuRHrhSMpw83uGl9YizEPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21)
 by PAWPR04MB10055.eurprd04.prod.outlook.com (2603:10a6:102:380::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 08:34:56 +0000
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0]) by PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:34:55 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 05/15] net: enetc: integrate enetc_msg.c into enetc-pf-common driver
Date: Mon, 11 May 2026 16:07:55 +0800
Message-Id: <20260511080805.2052495-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511080805.2052495-1-wei.fang@nxp.com>
References: <20260511080805.2052495-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0114.apcprd02.prod.outlook.com
 (2603:1096:4:92::30) To PA4PR04MB7502.eurprd04.prod.outlook.com
 (2603:10a6:102:ef::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7502:EE_|PAWPR04MB10055:EE_
X-MS-Office365-Filtering-Correlation-Id: e74e417e-5600-4f9d-dd75-08deaf382df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WrUwu/fXxEU8M8QNmPsQZI7J1HVWB8fCqLQyKejYYJ1T21i3VZmU06RykZElH+HMiWHcK563lsEi6Z3JgUXltgMExJ+72MmWmnhnsjwPZ5jfiT7B5mVzvaEY+HSpBclcA3UKU2DcPwv9mwniUIUPabRRiY654B66rWhaMkYTmhtP67yO0tqtqRL6PpPWs2FtZyp4XCJQE5b6fjWAWY2TUyjuzSxVVbbUaKZRxZqY4QsRUsyIhSbhJZehTdd2I77dQT9gk7qarkJyG2MDdi0yp5lg7pLoS2nPrpZG7RpdIhY1g3ywtZdkciQuF2IR2S943PvrHr1MCd3IW8ShY2JSdqO6e8mY8JEu++JXyw7qHaPwMoPzPrdU1ivJ+seo8rkqNzcMDoUlQhEvai2hjEYYoIkeikVstvJY8TppAan9UHdCfOvz3SgTdOwTzvS1HfLrocABtGL8/6rEj5T4I8pObGoj4Ja4a4yhsIEy8nohNGlCqxgUOhUgKJK8GIA+GV2fm4wu2Slg2t/qzYtMP0S5ooumElGA+FDZQVAAVIjrsejvNxGWwtY7BvkOPnn3snDD1+ss3wa8EVokZiUlz/Eo5hPLe3SL6ms3sOuO4PNcSkvZ/2D6l9lcnrQSDPdcy3tMnie6oZ2SU8/4LC0G6EpshHMz+50MViIoEaAhzWZ+r4wZXZcJQX2L3UpniA80w8XpQ+zg/AxRydArDH3RX4JYkG8kf2CP/yE60RjxrTNEvsSEtkcc3OoRmlEwa8GKowgJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7502.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t/HnFNkJAqTsH8lB1poiNwAThbtFHDlU7A0wHPNdLF8Dmkb0F/49doDpH6O5?=
 =?us-ascii?Q?UcTKhilbqfscriUXSwnRlgErfQ7XPG0vd+m236vweY+xhuKdsRHWkbkALopX?=
 =?us-ascii?Q?axFa4VySX3Z3dbYM9+plJA/ABMKwAyehlSbNQdXyAGPPJ1RDCTs7i8YIuLhC?=
 =?us-ascii?Q?/T+gdasVFtFNsebNBsm97+nXzPV4IzhKivtKPyBF8PkLmGse/EVxyl4fQKu0?=
 =?us-ascii?Q?1xZxbUkxapD3A5DLxemVHHF+UX3kzdLEZv/1m2NuQBgJVSQVhNwoUy5o/9N+?=
 =?us-ascii?Q?m8dOLcSRneylrAmddQ8v7lUOSaiFtosKlCIdlRBN+hDBILz1cJVLJPO+6hwj?=
 =?us-ascii?Q?0xILnHNDIDrYq2pgznE47B481tiu+APy86SQd1ecYj0obIvRqW4yXw2OgBco?=
 =?us-ascii?Q?caFQyq8D8miYfoC+L2+RH9LU6giaG8Ed3jtNxJT+p86qtCVPo5ZLLloVahUp?=
 =?us-ascii?Q?kPc1Ubf/Y8gTCq3M/ucypXEQt0MpvfbyA7U8DDbhiUGibB5YyRrv8EgbVoig?=
 =?us-ascii?Q?4Gg1/S5qHiUK99G1Bi8N8oqXkNCEgLR9nlsW6cv7Dsv6n7YGSiymWgGu2tLL?=
 =?us-ascii?Q?yTGXOG2GVm0Dcyg67RUiLLXpoyeE3z7k9ZjsvHh3/kxBpDX/4ibUamX9DvOd?=
 =?us-ascii?Q?DgA7WlDdrJjWuDzZw/+FifK/5SJXEYFXaNzj+TzXn2SoqB7EtpS6PaN+m/XD?=
 =?us-ascii?Q?2LRLREor1wz5mdMq0DGj5/juwKR1Exg8mbxjzu0W+Gi+nw6WCp5EJ+VQv6i5?=
 =?us-ascii?Q?BAfyzUYQSsBWxfSrubeRLYoWSEBExKd30r0VMqH7qRSO0ZESrBjSlnyp3hpV?=
 =?us-ascii?Q?g8AsSW7tXBDvcGZ+YN7Nm+C6Gg/eyJRW/eq4HLwdFjJaeYxt7x6W7cFygyUT?=
 =?us-ascii?Q?MseZWaTCJBotrwKhDhZ/4cFmjXIHin9poQg0KIALRaSlLlNhBPZ2otkczqEb?=
 =?us-ascii?Q?zoVkAcPjoJ3hpIBL3IXM7/6A3Uz9UGsfjNc8gL0xzePyG30XJ2jHTdsh/HPl?=
 =?us-ascii?Q?gXqQ7yq+TMviJ/xpNYI4ZyIzLeMS+eWpJPgYuK+cmPFq85TUQVJMny/FzLla?=
 =?us-ascii?Q?7K9CF2U7CXlpmbFnXTjeASaGXg5gbAQKVrjiXaNequ9oKpofyWKvyooRCWCc?=
 =?us-ascii?Q?MpPUAW9/84Hc5kMoksBbfJXPCi+GArM2T+Jj2ZEQVMBCcPNuRkkFyZZxTJfy?=
 =?us-ascii?Q?q/53jArGczMmK2uJwxAftMeQjIMwrnhhN85d+3cSUI+8B8/6RedVsu/lqtaS?=
 =?us-ascii?Q?Hvk4hHfJ773gOUEngjToV6040D8QQEOyhvbh1QRF/hgJ5rbDWxLfdiNUGtX7?=
 =?us-ascii?Q?aWW6kFEJdmIcZ8xeB4cLPEHXqZ8UpjH3XlGRk0cRH6V0GdRO3qVJEd7bppMU?=
 =?us-ascii?Q?ohrwylbGzCB+6WbJVrvsRGCNoLZm6+lp0qIJJ8tH7ojN5h4pZH4JzpnurTsA?=
 =?us-ascii?Q?Z4Qc6bm0ixPikTzgiCbqLKFoXzln7yaiPuIPAIQ3T/3qJuSxX9zbOnlNFODb?=
 =?us-ascii?Q?wphSfpYboLUjOWu+SIWyTJhwmzAoZzWgx/Ow951y3AELXvgc+l3mHlI+IoTO?=
 =?us-ascii?Q?VgbwVkwO6SMtVibOnrBS4GqMYL2tHPclfs6Y6uuppwSZfxncNYlFgfwrU0vI?=
 =?us-ascii?Q?uexm/8NI9N/wLHXZhTMRkA8rnV/B+i0iArtkNVWzIlhLV7XCgaKhsqn2GVse?=
 =?us-ascii?Q?XH16i9AlvhINWtIogjsXOXMeQRyTkAXV0ZHfX1SZgjc972YH68sCN9bhFrs0?=
 =?us-ascii?Q?7RJwmr9fPA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74e417e-5600-4f9d-dd75-08deaf382df1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7502.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:34:55.9040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Bd+XDtkB+5w4yX96xbD2OP64A58+RqxenImScP/YqVYFJEzwnihvrvXE8Pc7S5cwsZem7NON9MYz5V6SH60fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10055
X-Rspamd-Queue-Id: 2BC2250A3CF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-286519-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

Move enetc_msg.c from the fsl-enetc driver to the nxp-enetc-pf-common
driver so that SR-IOV mailbox handling can be shared between ENETC v1
and v4 PF drivers.

Changes:
- Move enetc_msg.o compilation from fsl-enetc to nxp-enetc-pf-common
- Export enetc_sriov_configure() with EXPORT_SYMBOL_GPL for use by
  both PF drivers
- Move enetc_sriov_configure() declaration from enetc_pf.h to
  enetc_pf_common.h
- Update enetc_msg.c to include enetc_pf_common.h instead of enetc_pf.h

The fsl-enetc driver now depends on nxp-enetc-pf-common for SR-IOV
functionality.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/Makefile          | 2 +-
 drivers/net/ethernet/freescale/enetc/enetc_msg.c       | 3 ++-
 drivers/net/ethernet/freescale/enetc/enetc_pf.h        | 9 ---------
 drivers/net/ethernet/freescale/enetc/enetc_pf_common.h | 9 +++++++++
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index f1c5ad45fd76..10ab6694c314 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -5,13 +5,13 @@ fsl-enetc-core-y := enetc.o enetc_cbdr.o enetc_ethtool.o
 
 obj-$(CONFIG_NXP_ENETC_PF_COMMON) += nxp-enetc-pf-common.o
 nxp-enetc-pf-common-y := enetc_pf_common.o
+nxp-enetc-pf-common-$(CONFIG_PCI_IOV) += enetc_msg.o
 
 obj-$(CONFIG_NXP_NETC_LIB) += nxp-netc-lib.o
 nxp-netc-lib-y := ntmp.o
 
 obj-$(CONFIG_FSL_ENETC) += fsl-enetc.o
 fsl-enetc-y := enetc_pf.o
-fsl-enetc-$(CONFIG_PCI_IOV) += enetc_msg.o
 fsl-enetc-$(CONFIG_FSL_ENETC_QOS) += enetc_qos.o
 
 obj-$(CONFIG_NXP_ENETC4) += nxp-enetc4.o
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index 6f7927f40bea..a137fa1e6f20 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /* Copyright 2017-2019 NXP */
 
-#include "enetc_pf.h"
+#include "enetc_pf_common.h"
 
 static void enetc_msg_disable_mr_int(struct enetc_hw *hw)
 {
@@ -245,3 +245,4 @@ int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(enetc_sriov_configure);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 44cfb7bdd7e8..731d56bad5fc 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -67,12 +67,3 @@ struct enetc_pf {
 
 #define phylink_to_enetc_pf(config) \
 	container_of((config), struct enetc_pf, phylink_config)
-
-#if IS_ENABLED(CONFIG_PCI_IOV)
-int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs);
-#else
-static inline int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
-{
-	return 0;
-}
-#endif
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index 96d4840a3107..548323d29f36 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -20,3 +20,12 @@ static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
 	return enetc_global_rd(hw, ENETC_G_EIPBRR0) & EIPBRR0_REVISION;
 }
+
+#if IS_ENABLED(CONFIG_PCI_IOV)
+int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs);
+#else
+static inline int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	return 0;
+}
+#endif
-- 
2.34.1


