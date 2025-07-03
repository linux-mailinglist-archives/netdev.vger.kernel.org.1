Return-Path: <netdev+bounces-203818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78482AF7540
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 15:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF8F1C83E1C
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD625139CE3;
	Thu,  3 Jul 2025 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jHXdUwiX"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010026.outbound.protection.outlook.com [52.101.84.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DDB3594F;
	Thu,  3 Jul 2025 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751548685; cv=fail; b=W2si2vHyVyMlQJxDAnVfjD6WFZ9rv7Pn0Tyu9Ml5/zH76cIBplqd78p7Uj0B4KvBD0G76xMC/ijQ7Y5QaIdCmeWWTnk4o0ASeVc0xPkhJpOWUwY/SiFFUa2wdKIeGSrFN/uJRMATTNOxJzT898J/Igbk8LdTcr2i9BlpUO12V+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751548685; c=relaxed/simple;
	bh=/mehEAvub5TfMLxNwqCyK+cJG9ZUkMQg1wTtPKOPnYA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qVB7T7IqRbTuwE6DIXUlRO1Y+I74Nacb1z5FdJLTVJeh9kfMTWOwXPALEAx6n+NfQyLAlY8g5DlFezf18BXSZDL4qglzPH9KW0Gx+2zkRFdN6nDBMkY/KxJ33LTQMdaoLtO/cjfBKGaMJNsiuNORcmyFK6NOhPde2S051Fmfn5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jHXdUwiX; arc=fail smtp.client-ip=52.101.84.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtkS4/rb1ZYjpkfrDmAHGuTvWvuivUvbkS/HinAwALbwM+ut+t+J5h+N3VVq6zwAK2V693GJxMc3Oia3j2C6fsl3lTLoyhljy7SCFeoImwXtQzrXfq7fNLhyfDrYH75smSollL8FWK94qTudbSBDLywwapOi5empmD8c+SNjVesPvTj9fbmoJp4AClWAxr9iWLB8FlIW79T0ONWNP0mQvcdxklAt9/+8JJsm3j0z4/FBrsDJHI1JZl13rpDC3eTYNpWXhvCXCy8guNlbxaRs+kHZjiBs7TWI2KqQJYEn6Qlxt8DsuJs/z6w/bvnQ8vrEhHI3mEDFN48miLq2FMXtBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rB1gBlNi+k7+bW7ZmZEFqkudGSQekGGxMxsx7EY+Q50=;
 b=g26Nr7FhfJkKSf7XNGJ4Lkg84xeDF2UDLFfxESc6uGvVYGiztzMeczT6BVj0HQhIX+Axr8J5ltMLPDpoJe/7kVz/R/YuDVice+a+jkZ2r6l/S44n7hzmrKX2sOPKp/5iH77xLv/gCk1LyRXvH/hYhsPE+tkFOBze3vcDGDmf6k9pvEVbiQEGC02bF0Yx++ypjxV5rFG3YaXPzNcu0ZQwywJtjaf5mNAGD1soQTcNQu1cx8HL9kYkEx7B/1M99UBZExxIJJ8/91I1fO67L3CG2sobuMzyC7xbd6wBOuJiHxI1B/1Nbcs+uIvk3Tr5FIBNNbjHx93HtuRYjUs5vSVmyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rB1gBlNi+k7+bW7ZmZEFqkudGSQekGGxMxsx7EY+Q50=;
 b=jHXdUwiXpmOnzexN2FruAME5gDMvOSHNwNOED5z3SFk1UyLbBGsvvy/7hIi4vVpFZDcDLshNx8eokKlKFk58iPQjHRmMuoyZ2qVV6PayXN3RNfaeSXNONQwO01wn90YAZyCgd5Ppkuz2vfXJbX3kiGDFQ/gSxrfWjhiQqiQRC/G1KWFIhEXdWRD2q6L9pmKZHOkzaNQXkrzSNr3+l/NftpsDTVcxs7Y+eTmLMkuu1sRAO2T0Pqju4K9LH+1CwuOvoEBUddsj/eNnRrxJoJ41VufQQGVTsftr5yxx8wVw3aM2IxiMDv/26W/PrtV62JMHCrHFJE3isXGduQKDsyXgRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AM9PR04MB8211.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 3 Jul
 2025 13:17:47 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 13:17:45 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	manjeet.gupta@nxp.com
Subject: [PATCH v1 1/2] Bluetooth: coredump: Add hci_devcd_unregister() for cleanup
Date: Thu,  3 Jul 2025 18:29:40 +0530
Message-Id: <20250703125941.1659700-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::7) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|AM9PR04MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: c1acabbc-6b73-43da-3395-08ddba33ff63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9tbq1J+RNZYfCQDRtwCvyLO9pZ9HieoYymWpFRy44rCjsvsFhqXUKFK5iQ73?=
 =?us-ascii?Q?A5cMp69OgH0ezuUmk0Ezs9gZL1Z/Icg6ojpi/ybRCI9aSUPliblCH7+59Efr?=
 =?us-ascii?Q?CBj6ZoEhOB73l8f4mE+WtQWot0Bp2Y7Z7FaYVyqn0pBZrNykgh1igQK+SZbI?=
 =?us-ascii?Q?XEuTrWPrIdUHjQTNb9FGqwwd2iiYjVBtOxy5PRaltzEve17HahwYw4XUbggC?=
 =?us-ascii?Q?r6MrOPamFY9lhRsWy5lBlzrIXvo5u/tQQvzqnpzCXKIZyvF3XkpnS5nWHCJy?=
 =?us-ascii?Q?zxWugQrxC0XHpatrPxzU3nH72FPnpjk6hYSlYJYd4vmjdjq3kNa3+RRXmIMa?=
 =?us-ascii?Q?kgVRmtbhGQDP0x63mTIqGcZeLtFkL/65qes9BXYRisvxzYlmC2QZIMVvoPQL?=
 =?us-ascii?Q?yowrPerB29aA+lGCXq3JgUiRqhvzMSxNt9hzqTeMcSsUC80uG5jBdQsKmL3y?=
 =?us-ascii?Q?mf3Vyq3POaDbYADSZpMGI2UH/Cu2SYHUEWnZb/i+08BVqOiJytnGaNwDiW9/?=
 =?us-ascii?Q?MmOG1rlMa6FbuIblClmhErdjHEpda4q0oAXvJrVFN0CDmh2nJj2zvFrU9gMV?=
 =?us-ascii?Q?eQ3gH2HPuMOzqaq3dzT0lm5i0afuDZF40CgqvIcc9kigtf9nSidRyvtr7txY?=
 =?us-ascii?Q?HXmekvwqnvJgQPJTi4Ukgylr/ZaGjLKvxyMD/jrPE+3sNdsogjt4/4iBvg/a?=
 =?us-ascii?Q?noHCbZk82i4Pm/I2jS39rIdrFkDyIMhZZYNqnzc1IxPYRKeZvbWYbcMDvuWg?=
 =?us-ascii?Q?ZSN/zc5mnIhCkog9mIOfgdnjrynj4Ii3J+ggEZP77AnapNC+5ZuzBw//1yzP?=
 =?us-ascii?Q?hY4bK0gXsbINpt2Kxkl+wCHgghrz2h7jpme4hOCw68U2XQe8fyEkoOkFhY/a?=
 =?us-ascii?Q?ExYsnpBGzFC7Jvd6R4Xk63xja2ZLNIIlzcU/3yzOiWM9DkPZ1Rx87Wcj0lq9?=
 =?us-ascii?Q?crBjTe35mNFahz0uZek5dBSN96KS21xVKsGlM0yULqFjwm6kDCsFIL5DgMuD?=
 =?us-ascii?Q?DAVJd/0w5ghb4eF9Ln6yCpT/w6lDhWL9Iwdgoj8TXbsB/KQ8ifPoNYpUkSCx?=
 =?us-ascii?Q?VHnD5pt/P7U+nNz7TCxrnXexsGhwW+R9wQZc4bHbBgB3oE1TtT+HjfDXWg7Z?=
 =?us-ascii?Q?XGSQEf/7S/25LCfaxswWJAK3tY0nDPLcvIWAb5BbjJpoNxs0tE/qrLrbsYHn?=
 =?us-ascii?Q?ZpS5lFlIVhttQW1ZIGeFoL+kDDjBIJQz+DvCWJhFFwAjgu/8qcT83BI2fu4t?=
 =?us-ascii?Q?lpOojvQWP9LK0Dlf4KY1dhIcqiyrxCTWJqxL8aHffp+f6pGEQ9+XPkIAMEBa?=
 =?us-ascii?Q?5QocB7gb07LTgp6lCcanJHo18tDEKqJjvFhNbEPRna65UrFOTC/PGGha4BkN?=
 =?us-ascii?Q?AqFuNfBE7uzd14Fz8Il1nPOA/+zwEppK4z8dbA3yUAvmBHvFllbwzELqyLXU?=
 =?us-ascii?Q?7dARgszf3sBu9vkxjSbkqrxbcFwExcMEGfIuit3zrbwRSf/UP5n2YA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HBPVN2Vdczfxv2PjoH5CoCpJIwTGcX/5IZe7c/r3Z2UkWx82UkiPH43JXwd8?=
 =?us-ascii?Q?JHOV3PNuniuUDSEjCwjc9wUUp2XRkMMXZtRcsbORiZ04BbpQbbfA+wK5kdOo?=
 =?us-ascii?Q?hjnF1Aa+xR27Wx28HTr7pZxiYZ0BqaXkbnCjX7m3IsNwHyPPIBgwFIMswQfE?=
 =?us-ascii?Q?Q25Kz8NY42eHDZF/24D1IKFxfpWLgytfOot9vNQSAyIsfkUGxoyJ+5UBCGuT?=
 =?us-ascii?Q?XhH1Scbx5wlZWpUafx8kf/ccDhZn+0a4X6EOpA+S8L1Dnqq5xoUIfFOi5NPO?=
 =?us-ascii?Q?DTf/6DvnwrWNRO7uQp7gWJdEPncyM9vDBxpeENPD3vA5kYS+2exY1ywn1eRo?=
 =?us-ascii?Q?dcyzgLwB/76ZqajF7fQlVj1qHjovCZKvg6U46tRII13bh2ceID4mmP2jTMX8?=
 =?us-ascii?Q?YASXyAnf6svIbfxj+hpcbYfPeaf39CpQMp5llBF8WdoYqlyAXNFbiEKRyrNY?=
 =?us-ascii?Q?POC5FQEKbIFuFDJlknHOUb7b6E38029AaY8mNdS0/ymquY/A7lTLgrtYWGHJ?=
 =?us-ascii?Q?TTS00wKPhJ4GZo6TP4gIY0VbeQKwVC+ua4TczMg5I6CA/5ibtpuiuA3DkoLQ?=
 =?us-ascii?Q?tyBD9XP5FcukLI2NF5z6O0tHVtIyPzv5PSGWhwparN4cLwGJ85tKIDJBBIbU?=
 =?us-ascii?Q?VOrI39lZ+So1lhxruLB4MfZo+m7/86fE6r3pwCuZQLHN89k1/RPZhnrdN2Vm?=
 =?us-ascii?Q?zQj8WUDLSqQenP1EVGdPVqqqhdOrCuml16Q7Y0GizBnuRNOS6WqiMO27AEy3?=
 =?us-ascii?Q?xDLi9Z0140/LJ5lxzQBn3GFoilUt5uSgFW8kmaw5yw1xU0NJ4yuew+050C31?=
 =?us-ascii?Q?q62zvl92+onxSQa0fwNrXQbFPxfT0Jltjc/A3r6djLwfd3/Sy2lboTdAjfko?=
 =?us-ascii?Q?Ti4GapwihxRdn410/uxid1XRzw3TokX+ECcqGLlITujMb4hAc2L8JL/+TWP5?=
 =?us-ascii?Q?NDw6oJwCtlXsUsOIiNY4JFDZoEhLsw3RSSJVQ/T4N2LuTBZvdkh0sefmmtd4?=
 =?us-ascii?Q?DMNUgYyy8gaM1cBKwcqpetYpySUA5BMPtmehNSugu1ch7IeqYCe53ZJowUqi?=
 =?us-ascii?Q?RKMTSQtt8KDFxEjOqfJuiS+DiYuAJCKFQmsGoamAWyy8BCKYsoVsQDninytg?=
 =?us-ascii?Q?djQ4bODRLyNmMkE+3bJBE7GDLTSc8y4/LR8j3QrclWHHzpAKBZ5fxswGDlM5?=
 =?us-ascii?Q?LkCbUycdUyggMj3Y39AoyVIYiwbM04VJOSfj62EVz4UCEGvBBSrYzn5egLKn?=
 =?us-ascii?Q?fiQHKYlhA3DgM6LqI/+otn0UZPw1uei+HWEMkvd6BPAprVyVcV5gpSlrmezs?=
 =?us-ascii?Q?xZvagC6VxgTCzI2hUmAlSKBNbALkEmWpJSIVQXR/sfXgaMrKiW+UlyT9vnd1?=
 =?us-ascii?Q?UW+KZ9Pml3F2iAtT3xEGTXOXwIL5XCcGa73nOtfPR/JMweJs/2AF9jvZs3uF?=
 =?us-ascii?Q?d3iNRuAGqMk2zfjnEzJVotI7zgstu/LvhRXGalu00lc18HHJ4TscFxeNfXNz?=
 =?us-ascii?Q?LDvock4sTApaILlmnNr9PXXqqihsm4Bu4DIfdLOaRiOLZ66g895P3P7MYNsf?=
 =?us-ascii?Q?53SQar6wrkPI3MLKJaQ2GEO+cQBiwyc136vmwk3nNqOqlvAxul79OitYPQqv?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1acabbc-6b73-43da-3395-08ddba33ff63
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 13:17:45.1723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLxNgklMeXn9UdeludUJVeOCc1MwDI4fsQtp/tK+n2ifuQrEWKUyBs0S24Ax6BN2DJREm8uCJZ9RgWGsU/p+NdJUEiJPWdXN4EXYyH2UUiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8211

This adds hci_devcd_unregister() which can be called when driver is
removed, which will cleanup the devcoredump data and cancel delayed
dump_timeout work.

With BTNXPUART driver, it is observed that after FW dump, if driver is
removed and re-loaded, it creates hci1 interface instead of hci0
interface.

But after DEVCD_TIMEOUT (5 minutes) if driver is re-loaded, hci0 is
created. This is because after FW dump, hci0 is not unregistered
properly for DEVCD_TIMEOUT.

With this patch, BTNXPUART is able to create hci0 after every FW dump
and driver reload.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 include/net/bluetooth/coredump.h | 3 +++
 net/bluetooth/coredump.c         | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/net/bluetooth/coredump.h b/include/net/bluetooth/coredump.h
index 72f51b587a04..bc8856e4bfe7 100644
--- a/include/net/bluetooth/coredump.h
+++ b/include/net/bluetooth/coredump.h
@@ -66,6 +66,7 @@ void hci_devcd_timeout(struct work_struct *work);
 
 int hci_devcd_register(struct hci_dev *hdev, coredump_t coredump,
 		       dmp_hdr_t dmp_hdr, notify_change_t notify_change);
+void hci_devcd_unregister(struct hci_dev *hdev);
 int hci_devcd_init(struct hci_dev *hdev, u32 dump_size);
 int hci_devcd_append(struct hci_dev *hdev, struct sk_buff *skb);
 int hci_devcd_append_pattern(struct hci_dev *hdev, u8 pattern, u32 len);
@@ -85,6 +86,8 @@ static inline int hci_devcd_register(struct hci_dev *hdev, coredump_t coredump,
 	return -EOPNOTSUPP;
 }
 
+static inline void hci_devcd_unregister(struct hci_dev *hdev) {}
+
 static inline int hci_devcd_init(struct hci_dev *hdev, u32 dump_size)
 {
 	return -EOPNOTSUPP;
diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
index 819eacb38762..dd7bd40e3eba 100644
--- a/net/bluetooth/coredump.c
+++ b/net/bluetooth/coredump.c
@@ -442,6 +442,14 @@ int hci_devcd_register(struct hci_dev *hdev, coredump_t coredump,
 }
 EXPORT_SYMBOL(hci_devcd_register);
 
+void hci_devcd_unregister(struct hci_dev *hdev)
+{
+	cancel_delayed_work(&hdev->dump.dump_timeout);
+	skb_queue_purge(&hdev->dump.dump_q);
+	dev_coredump_put(&hdev->dev);
+}
+EXPORT_SYMBOL_GPL(hci_devcd_unregister);
+
 static inline bool hci_devcd_enabled(struct hci_dev *hdev)
 {
 	return hdev->dump.supported;
-- 
2.34.1


