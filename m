Return-Path: <netdev+bounces-270888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N8DOL4vwmk+aAQAu9opvQ
	(envelope-from <netdev+bounces-270888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:31:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D7B30300A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85CBB30DABBC
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 06:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483BA3B27EF;
	Tue, 24 Mar 2026 06:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JUU3KIsA"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013030.outbound.protection.outlook.com [52.101.83.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8954C30EF8B;
	Tue, 24 Mar 2026 06:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333171; cv=fail; b=E80vaCzbcBcsovGhCvQo84edQ9aE6KCzS24yJOcLoz01x7QBGz5DjbtqgVK8BfFKkVqssBE1Yjtmovz0zZ/wSWLAXI6A0gA9VFGl0Fe65TXQ27xI6A21WsHK0poLkmZ/TlRBuGkjvxqT8PNtR9EFgtMLW9wOrLnPhLzsC7+Onog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333171; c=relaxed/simple;
	bh=tRsthECSdcTrasUwnj4oAJwYLa3igcKER9UEk7cmMzE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GuCWggbtdRIN8BYli4/RVOChODDULjYBW1S3Drrt0hfVLKvmffGCc36IwsnYVvW3ph7GSe0HrrOplEtTB4dVjmwfMZdl7/NyzZvi4fXuMsvLCNp/y7fx361ROkNHAoCShrADsh2AeKI1nEkWyM9/d36kxqeI5u4Ay86nc1syVQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JUU3KIsA; arc=fail smtp.client-ip=52.101.83.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCEt28iFYvAnSgMjhNqWaiXDZ+17Dak0H0tNOa2aDKlAIRbQ/S2qtzs4dAH5SzGc64VfbWARULaQI7KWMrOBoF9bFbfOAjHaUfm5to3MiKJdRmbNCiMXfyYXM4rsAsFz7ioWYJrO3Dj3HCZWb89zzIKNez2lfOOXmUUsDuT3+VFoQB1Ggvdc0DCbN3+VujtBGVsU4isFeCsA+7vhMAZsjTEaMzrfWryLECAgSrVbhUfyIWFCSC/djwtQXxcumKAXoOqcu49geIM30S0907HOP0zZkNdqEYxeOx1zcVAZs/IWpd+Jz8JD90m6fF3PI/AYSDb1KvSmJYcaMEGLVmNGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lHHPG6WxveiGHt+QacAGmkyLYko+DN4k6SUxAiyA4Q=;
 b=YPpTNUeud5r5ZNKwlpljharIrhA15LIGKauqqBR+GSZSMMP5ubS3EKZRom2NeRUGtCtXxgJ6wz58kEyYcxVeqaw9TuZccuJwPpU8fyDtlHob1rZCMIbAHlTDlkQF/FI+AOO/CoRnCDqFTb9094fkVaVhxpl3WhFixx1x7QTO2fcaZjQs+8a1haN3ErzxW0ZnsRleQfCzj+fij7kgp4eJRcSwx64kOwnY00eRo46SS9boLFWJKINQgfFZ7LMxeb5mtI24mQPtdnX5auvkpHjPmUKXfZkhK0QR0kFpuGPCVWAKVclKx3SXUcACvVehetl/cqcI9Wtb7qj8Pb46FZkoTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lHHPG6WxveiGHt+QacAGmkyLYko+DN4k6SUxAiyA4Q=;
 b=JUU3KIsA49jJR6sSEFeszX+OmYBpuZoPCsiKF1LwUE8Q1YEE6CQGQ8yuHe4/HPT9SF13VWRG2mtDbg6RFRT247Wwra27djxN/oEC/90NnZMFSvuwoMVFuRBsLQyiGJvw7VdQstQ1Zyjulf98V5+Tx+UQveXZDxVRGe6NA+R8mxuyR3urmjWf7d+/VMUumb3vEhv0DGPq05pP7Pe/EDMr8ne2Ks5bk7EIxX+oREEtAqgntGROOBZ0Rxpa9glBmDRk1Aa/tCod/kFU+/4FcG3nIUP94JVkueCHgk2Oct4ASs7cCy1eb+R8VmkVQiki3W3VzeWIMps1rfJR7e6GmyoHtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB10960.eurprd04.prod.outlook.com (2603:10a6:10:585::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Tue, 24 Mar
 2026 06:19:00 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 06:19:21 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	Frank.Li@nxp.com,
	horms@kernel.org,
	saikrishnag@marvell.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v5 RESEND net 0/3] net: enetc: safely reinitialize TX BD ring when it has unsent frames
Date: Tue, 24 Mar 2026 14:21:18 +0800
Message-Id: <20260324062121.2745033-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0225.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::18) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU4PR04MB10960:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e0593d-4b67-4f0d-3836-08de896d4958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|921020|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	NUhbnpldRg6xs0D3SnO5/VGcAk+f+MCUsRxMD3efwU6kA+zPl+wA1U+VCO5k6L3QvY1tmwKKNnwNksz6rtOnb/1vhqTiOAh+VjoLe5AQI9bcA5z1CKRaEw4W7BTTfKkZkQvU6BoxzDihmScoT41VFsyTLSS0Pso/Wtkpi8rDGxaiY+GW+hvv+ACnj24xbubQNRxBoFNBS90S1tW9BZe48qypSjYxUucSiLWv71WrNU5Xs5Jqfv3p5Y4b1VDXfO8CpL8H9/7iLx5ivuTYFv3tMuXH/LWaUixER0DYgdh/wPYkMpLw80LATSlNvNarsVAUAHxsCD5AVHe5wZYNqw/ROA6Zu9KqDIgfhvUXmsKqEH5xeYdU1BSOLmpxoEBC4BJ8Zv/Q104BmFDFEp9qRJ+DqMF2UQd9U8h0xu21wR7JQj/P5qSDtQ52yByPqY5uxk0fBNi8XKF/ieehx9+GDuweMYge8nMNMs3DRdZSK7y4lW+Q2KflM3AKE/or5uNUwaJYM2z8FsfLlD3+UlQflo0QFAUsf7nN6sV3cE17HpQFGs+nV9B/h9JSK9t23g04PW0CztYgZ7A7ofe/I+0cc8biexFMdAr1MPN5othcWDmY3k8JFBsdK4D8TGxUuS2NyZD7ZZVFxZ9BN7IiMN7+qqBfxS8cwLV1UwZmfHWLb9e12xApgAtrX1LQfNXWfvDOZV2aW49+B3u4V5iWVw01kWL7+Sq5c+ZpEzaYiCmQ4rxZ9Zxy3ftRR0MDuYsa3RJ6LBJAups6SOpkOxPv/IPNXdtagMuqfbuR8wfnrOyC1dAn9cDLJcXrb0qeri982WJWAWCb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(921020)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S9mpzXbE7T7T/b7sUL2kdEQfVvilgW/3e1lOt2mIsuI9ll0fs8B3GuxhlO5l?=
 =?us-ascii?Q?+xEEslejpTrHfF39sI9HqlxFtrehN4JnvsDyXPlOX5Q47i8iJ3zJE1Gf+XNr?=
 =?us-ascii?Q?5NhtZpsE25I/zzs205pmXTW+R2igmD6FIkgbtaSq0DyFPY68ZSARm8444tlp?=
 =?us-ascii?Q?YlzqZ1xNHzV8VA28YhDN9bi1p0X44FNxhz9R9a90Mme5J/opNSs30jSkcSGt?=
 =?us-ascii?Q?oQtf4ehpSOfIMP6yv2SYRnMDIFNj4vEzmE/dsX7vqILjCEYTQf7YRljw4rrB?=
 =?us-ascii?Q?bk0BLix73xFIsDovCJUttPq2AlgHBYo6rAHsySTTGKmfM8JiAYeS2yhc9x84?=
 =?us-ascii?Q?mC1W2+x6EoFg7GFJRYWgatnbjpvskT1CfBEPcSpPcSLCVJFqlP/AqQQEImZK?=
 =?us-ascii?Q?SSnZgSV616cUO1DxcQsb31EmtuVCZ3R7dM4t9/MzPA9iXdWuu2nXQEOrHqSa?=
 =?us-ascii?Q?71N/iicHVZnnmVnPF/SFPhZb3htKOrJ0pt4go/Ab5MU6BMCGVu/4Dd3Yumb+?=
 =?us-ascii?Q?uoirYocuEpuOZzgqWTZZbup1ZeBlFKZk6yUrue7W0AkEqHEL39Ret5Lc2qlq?=
 =?us-ascii?Q?jo5vdvvqJTUDUPuf1wiRaw3lFFyopeNleyZGMYXyHpeSO1LKjKTBb7qoR5bD?=
 =?us-ascii?Q?heh1be1jM3XGRRwS9PoMj4rOlKl36HJCCZlhOWHwlYj6xZdHRL7M87YRuAHj?=
 =?us-ascii?Q?vz84qXHCnlSNwAEXRXnuOBSrt9g8ljOFlMXKsIDqEoVTFld7rj5OJIqHUE07?=
 =?us-ascii?Q?9giWrKSMwTl6duYvFts+FyDtNO52a01msvpD46ikf/iCOOPHwjy/rAcnPySQ?=
 =?us-ascii?Q?W1ROCq+IqCvM5Qen4LrBk1PUkpDHrNxjEBgAmiSpDrSNqlcR83VzCWU1XpoP?=
 =?us-ascii?Q?PXjzO3KH9snoifCF+FOSI0X2wAHeSYRmNo1gXA4kUU+8d3EAJrYnaCvsWS/Z?=
 =?us-ascii?Q?SuHC7oe5Rl9Ob2bRSU2740ILPqMQHo/Ow37KbTQSm5iGSBqmAoo6Re9+HWBE?=
 =?us-ascii?Q?Og48Y/ZhWYCUK48tITgg3Igv6mlJlAjrW9qa81sMW1f9zjmAGAGke8MP3XTW?=
 =?us-ascii?Q?SKHvbPDa0RD/aQmhJA5ait41jlFAW0oLLuz3TocDwIMWuviQHXKd/9VfO2/7?=
 =?us-ascii?Q?RNNCKGcbVwWUCuDR++LzkV7mQCtWdbSnxkfQgNNjb0jA6KXdUMJXyErYDneZ?=
 =?us-ascii?Q?UPz8vh0YjCdWQl3NUr1SFNXK4BGidUnPv1f8TtFUE88dpKfZVUllqDwl0XHY?=
 =?us-ascii?Q?doJOrvcNzlzd/3NgjkEMGzX8fo3XpHr+/Ko3jb7+Knz1gqNQGUvFRZCQ7WXW?=
 =?us-ascii?Q?IardFSUlwOv1jdTboSTrfk176SctU0D23NrCgzCnM1gyCA2UAKHwQ856O76R?=
 =?us-ascii?Q?r3Zou1vTK2XUyg8BMPJWJZpPrl75ihE4pcg07iFWSBJNBWTNsd4fXkEzva/L?=
 =?us-ascii?Q?GV+B7MTk+T7P6gl8BGrgAyomx7s1WcmbKgwAnUe5w7lsNv8uzY/cVJ1V4hFN?=
 =?us-ascii?Q?TqK7Tm9KSAjxwFL+JBaOmbnj3p3ZgJB9cLLx8iYwAkmI/YhprX7sJyrzXWV2?=
 =?us-ascii?Q?KZvWTIovSI99yuAXqo9WHNtIQkUtkvvhz9YaCuguySEYlK7ovt3b5wgsttnx?=
 =?us-ascii?Q?PYkMUq6rylU9in14mr6AYy3vBlcGazVMIvw6hGMEssi6TVDSTpAJTs9tVmbv?=
 =?us-ascii?Q?tP1/f1eOr1bCUGlrIwbjoVe07TeVctpiEG6hbA25r9WrT5xbXv9ggZPAdUeW?=
 =?us-ascii?Q?6w3Sj/5Fog=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e0593d-4b67-4f0d-3836-08de896d4958
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 06:19:21.3515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PDFO+ptl9JccECOHvRW1FW3xPpFxm4inYJ5mywJlNL65iX7SleMBlgtEqCpbJHFiZmUGCXPeadDuc2f7T5nmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10960
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270888-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 43D7B30300A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently the driver does not reset the producer index register (PIR) and
consumer index register (CIR) when initializing a TX BD ring. The driver
only reads the PIR and CIR and initializes the software indexes. If the
TX BD ring is reinitialized when it still contains unsent frames, its PIR
and CIR will not be equal after the reinitialization. However, the BDs
between CIR and PIR have been freed and become invalid and this can lead
to a hardware malfunction, causing the TX BD ring will not work properly.

Since the PIR and CIR are sofeware-configurable on ENETC v4. Therefore,
the driver must reset them if they are not equal when reinitializing
the TX BD ring.

However, resetting the PIR and CIR alone is insufficient, it cannot
completely solve the problem. When a link-down event occurs while the TX
BD ring is transmitting frames, subsequent reinitialization of the TX BD
ring may cause it to malfunction. Because enetc4_pl_mac_link_down() only
clears PMa_COMMAND_CONFIG[TX_EN] to disable MAC transmit data path. It
doesn't set PORT[TXDIS] to 1 to flush the TX BD ring. Therefore, it is
not safe to reinitialize the TX BD ring at this point.

To safely reinitialize the TX BD ring after a link-down event, we checked
with the NETC IP team, a proper Ethernet MAC graceful stop is necessary.
Therefore, add the Ethernet MAC graceful stop to the link-down event
handler enetc4_pl_mac_link_down(). Note that this patch set is not
applicable to ENETC v1 (LS1028A).

---
v5 link: https://lore.kernel.org/netdev/20260313094644.1132411-1-wei.fang@nxp.com/
v5:
1. Add patch 3
2. Correct the typo in commit message of patch 1
v4 link: https://lore.kernel.org/imx/20260312095415.669128-1-wei.fang@nxp.com/
v4:
Correct the offset of ENETC4_PSR
v3 link: https://lore.kernel.org/imx/20260311084105.3982037-1-wei.fang@nxp.com/
v3:
1. Split the v2 patch into two parts
2. Update the comments regarding PIR and CIR in enetc_setup_txbdr()
3. Use read_poll_timeout() instead of the while loop
v2 link: https://lore.kernel.org/imx/20260309030412.2716984-1-wei.fang@nxp.com/
v2:
1. Remove unused register macros (ENETC_SISR and SISR_TX_BUSY)
2. Remove spurious semicolon from enetc4_mac_wait_rx_empty()
---

Wei Fang (3):
  net: enetc: reset PIR and CIR if they are not equal when initializing
    TX ring
  net: enetc: add graceful stop to safely reinitialize the TX Ring
  net: enetc: do not access non-existent registers on pseudo MAC

 drivers/net/ethernet/freescale/enetc/enetc.c  |  13 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  11 ++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 118 +++++++++++++++---
 3 files changed, 127 insertions(+), 15 deletions(-)

-- 
2.34.1


