Return-Path: <netdev+bounces-287531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLCPDyBZBGqjHAIAu9opvQ
	(envelope-from <netdev+bounces-287531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:57:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A57BD531B98
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C095B3061022
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894D13EF674;
	Wed, 13 May 2026 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B06XdUNG"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013000.outbound.protection.outlook.com [40.107.159.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CD33EF67E;
	Wed, 13 May 2026 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669816; cv=fail; b=lkSTSE+RQEWhSpMFLMcNj0KqWHt8lYZESJNE3R6BbDidx56X8+p0TO8M75/YH80aiyZquizH3MzZLrSaY6DTebZTFJC4bbIcMWoih773oAfRm+M+KdqtBYA6n40iXBeyR9ka2ijXqC4lLa+5KR6S4xqR8rdnnHr1ZC7GOvQyzug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669816; c=relaxed/simple;
	bh=6Gg4lyEyP9ixnsUNLxZqSNz0Z/sb21m1/g/I8vsj0D0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WQM6wN1vCSSQtUxb2AjnnJcljwuTtuiF9V7bYkTks5MmGm2L9jHIc39o3O8Nc4CeqHCjKKImkNKDgencGkA3ajOjcAEdI1bQn6v7dpl5AlfZxhk54QdIcYeR25VaAiA22PAzjOyZOwI43qhpKkkX0sWLHbJZ7poa/7BVa5AplcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B06XdUNG; arc=fail smtp.client-ip=40.107.159.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWwg1NWpzWby31Dz2oyFyxfzzjPMEW05ho7049u4I53IfnOOEUMXJxLBVWCAmwfGchii2yfJt3UBvZTjrasxPxZQ3Etv38Gd2uMiKhSkJcat+U1qLDMHxaXHs3Uo+hdlFh1HmYqmFw4su+Jv7B2tpar6wjgVkwQvoxyX6jf5LQ3i+vwT8l3PpnkVaJBauXcnCRkkOMIQjtdZCiYWKMHncid4YmZv8CWllO2a7cD0LlIoK4rY7B1JNRM3hKgilc8Tcj6WUV5Q2h2XlRigYdIrK2B9nzVeOEzzR2XYwESZXRHIJnz79nhXqBaI6C3rM1opeHJdjwO9KMh/0Z3nGLhnAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6ZXVe7trp5mkUnz7BCRtaZYwI62WzG8ZNqrwGI8nmY=;
 b=PlW1bHv3UJFCj7RzfboQKbpgHbLvGSHX21ZDQAbqhmd7h4K+pMFeRB+6qIn0NmgLOCEEA8VnNHM2tho2lEzgkw3cu+e5V/yHBkQxGGS119gcS7O5nnm1kemVzp291Sf3x25q6dGU3Eu6eVFPtLXCp38NbsUwyVLBKnkkRL8a9P5HH2xXPCXDUzHJwYI1S+n7/CnmlvqRwVNcoij6cAZEa2TUNHu4Dex2sMvIXbLDgoY3uzlTvn0Tj0YAA1OudptiNbHP6zkUk4PpwF0bPByrrPJIC540mPrdra/8R7NOHTl2pjoowWTBIE6jf0zPGN8seW58M5OsTnu+yF7IQDoKfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6ZXVe7trp5mkUnz7BCRtaZYwI62WzG8ZNqrwGI8nmY=;
 b=B06XdUNGmerw33P9CgJLx0v4IFWSApfheOApwrw7Qpj4f7JA5VX26W25t2PfFNzdmKi+tVt1r05WYum9nhJT6Un3FVXKmhxDCC8dmhM9JOq8lkiaQLrjcAaVEuEb9sPFhriwwVltkpKFjg08xV02a1V/yM2c9NpEDXUwROLScUkEIMb95WORGsgfB5tMTOwGOJfiG87J/KM42KqtreNdVJvVyiOiJzWiwz0QCOtc4js614vVvJq0syyUk4ylecd7Xb7Y+wGia/GxHXQQayxXm2LlaNHWoG5itt+WtZSWAt/RNlLcjdh2i1bwzP4DAlqZ15sM+2Knxw8A+x0Gn8aWcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA6PR04MB11806.eurprd04.prod.outlook.com (2603:10a6:102:526::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 10:56:50 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 10:56:50 +0000
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
	linux-kernel@vger.kernel.org,
	catalin.horghidan@nxp.com
Subject: [PATCH net 0/6] net: enetc: SR-IOV robustness and security fixes
Date: Wed, 13 May 2026 18:30:15 +0800
Message-Id: <20260513103021.2190593-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PA6PR04MB11806:EE_
X-MS-Office365-Filtering-Correlation-Id: a74575d0-be81-492f-5b04-08deb0de5573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014|11063799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	BFi053IQ5l/mjWQGRdQMpZ1bx5IaVsY2g0V2iIYf9exC5bCqDkfMGOREZ8zslQ3qNGM4fD75bGH0oQydgU2R+Jzhold4DTBFxcXVMbdSs6+zF0m7Hmqm2uQRJb6g/kwPhcZJgzYrRakubyTyjdy5k+RyyvEuL+YPulgQpBmN9WZdbo9VQq4CkqERowPVL0U2Px0IUKkC57sToMo2gzBMUT7Gjl1p6JpGhrQB+tBZXreUw24QZSSNihJTxgtSCSY61AFoPwWPLDBJoJDrCR/bwaenGP/OavuXpeSIvLwS4grNZ+qqpTeWcuw6p/IqW4ih6Cfo6QosWWzNdUhIhOIbXIWpRlrpysWfPDuue1HL0zRFD9OG3wAxW8qZsBV9VeM0tOa+NNQk9Qs8kq3WvaYRWEOvyQ9bRtZXoh2n8IyyxkHpsSYlKXArfKONTaZfNAg0T2RKhVG30s0MroXks6RXoQ2jSHLjPLRsreF7i/g0HA9WaDs4NiVWm57d2UB1iMwLfOZ4+SZbTncJru+sR5jZebl4JBnqelAYj/8bFUJE7Lug8jBVIwCQN+7j7iZsL9nYJvqovRoQC+yugfK2ohgw8PjyBM4j5lhKIJfDzCOttOtint04RoSKfqG5Yy73udaBI/3ducgyuM28iZDMhCceHdW23jEnYQzqHHmNtbRXbJj3CVHru2T9XWp4/Xu1c+lLFcR0UwoDXqY34wqqRpCcDtq+oUACx4YqlKT2VdJM6PMDzQjyPrtyLDYHt6wgaAtp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014)(11063799003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R0pWZWLcVvok+QIGrCVBhCNyEkZ+GzZgwsVJSmtKEMYf72nOY4EKCcfb9yHq?=
 =?us-ascii?Q?EJUTvrLHmrmYJCYVzg1T9r0SRglKEOAlEjpnstHyo5Hu3YbuJts4oivai07y?=
 =?us-ascii?Q?d74mtUmmqLDkOtk0LmBJ87pTRtABb/Tkh4043siH0f9+4cFNgV53+aY0NMWP?=
 =?us-ascii?Q?5O2B2bRtS7YwtdnEvKWNES45RiAkXnxCM6kLAW1E2tTaGcgctjbxK7uM1FX2?=
 =?us-ascii?Q?ROqyjPNvAgxJa1R6PbIKKOg7XckPNscYpHWYEOEUrrWOnM5NLYMRhSZsBuWe?=
 =?us-ascii?Q?h7Yl87XX/EXr8+JmD/ggFcVAtVkcQaGDBvx3OEx81yLdzAEGrromtOmeWzqc?=
 =?us-ascii?Q?Q6oKdneDC0kM4EfpaYlKnNMwUaLzflvo0W+tcG4vY6NeuDrYPYRRfdTa5E4K?=
 =?us-ascii?Q?jdM26x8XFWYPRMqBBHvYcfWSOT6P0dvklgmB8PXZfrCuTc0bdFeruYL9LfTm?=
 =?us-ascii?Q?grPM52WJWa874zLCaTY05CsCA3oPBwWVF91vBonHRwTaudEWY0DLgS1zApK8?=
 =?us-ascii?Q?0MMNacVbVSb0FitYUQJW+Vq9HuMaB/DKWsdJs9N8VgPT/lHetbRgWAOkmoBF?=
 =?us-ascii?Q?zA5DS9lPgAYYsk47IEp3I6Yr2uZy81/BsVV2pwdgXquEY/4xgFYlo8P5GdAp?=
 =?us-ascii?Q?qlGL31HlvFvuTsneygCPS8hfXnrqY8ebfX9Wc/AYw4/k3mUGcycRQFNXO45z?=
 =?us-ascii?Q?H2p+ZQSssw80aK4DysG/+449GE29iKf7O6bhVr9Fx24FS8nbwWTalZ69OCW5?=
 =?us-ascii?Q?XuKy/ZTnavsieZYmLxI4h8TOj4YD5N70qTZwK2yGk23HGuHdIgpv699yq5ls?=
 =?us-ascii?Q?ZIHKy+9ivQr+tUFujm+2oJBE5+mTh+jwZ4zGr0MGo0uNbjsiyEQnZEf5Ujio?=
 =?us-ascii?Q?66QBe4zrIqMIK95Dtadvj1Mkkwoh5oyEdWwZVxXP9yInZIwRCffq5Mwrg7j8?=
 =?us-ascii?Q?1QEhcUqqrTb5CdoOeV3n/qOEu49HHv2EyH/4kyYOxNpScdXEHZpdQv+XDzKe?=
 =?us-ascii?Q?z2ZpePBTA0D7toCR7oiRXD31HDwTBC6uwGMlPUDCgQ7H6liYiwWVNcp6zt+x?=
 =?us-ascii?Q?+d2gntWChk8VhRMa1uKuvwZ+Bp2C6h/AiGOpg6rtLAgMcCMdKInuh9l6iSFo?=
 =?us-ascii?Q?SLyXpM84f6nHnri/qS2fQ8j0e1hd/3TUIBEGx+MuPkye8CSYBOE5o8fRvINQ?=
 =?us-ascii?Q?JZIo1O8P/Ywy6DS+e4DXqMZfMltpG0eQauFql2UAFrvCa/4s3n4lhHIwQpdc?=
 =?us-ascii?Q?3qa/b0TFVAAWs0TDBdXVQmF2w57f654hHgXbrcvDDmYF7ImO3r6Zcw3l8FjY?=
 =?us-ascii?Q?MD4qzBvusH6IrduSD/WCkNq9/0itULJKtJZvFDu/14Y9MC+/0l3w93mYF9wA?=
 =?us-ascii?Q?aKjShrxX7MuVDid17gmhjQRco8LQrN5RRcw64fMrfZD1A9x5RXHuSqmJimgF?=
 =?us-ascii?Q?uYq5e0AUJqKjfHBH47+yPFmTN60iviGY63GLmfkIRWEC431yqzfI/GqeIYzG?=
 =?us-ascii?Q?mJkYxYjQXIdi5I/ztxhlMqt4HEdUGSneR9k1Z6yJPDFfOj7bc6svpU+xV2iE?=
 =?us-ascii?Q?ZnwooA11awr9OMrTPyXV0gZEh+Ng5AgJIpMl2AkvHsgZhYnAKbA7+0IpJpU9?=
 =?us-ascii?Q?IYONJ8KjzQK7jFBd0F4/19bAso1P4hCCqZx35KWbla9BQX0ZAwmiz+YrWxqv?=
 =?us-ascii?Q?08MT8CuOGVh0Myf+MTPmHpBGddi0AqpX9xuA8OovRbJt2/BHFR/3apeiBQWw?=
 =?us-ascii?Q?qW24LApOMA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a74575d0-be81-492f-5b04-08deb0de5573
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:56:49.9968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tq//mqJP6UkWg+5w5Vo1GYGCL+XlbD25PbS8AXokVyy0Y61p4hd3Zy8Lv8pS62et8ZfEOoGbaDrAmHZvu1+bAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11806
X-Rspamd-Queue-Id: A57BD531B98
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287531-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This series hardens the ENETC PF driver's SR-IOV implementation by
fixing multiple security and stability issues in the VF-to-PF mailbox
communication path, identified through code review.

Issues addressed:
  - Missing input validation for VF requests (security)
  - Race conditions in VF state management (stability)
  - Initialization ordering bugs (reliability)
  - Resource cleanup issues (memory safety)
  - Missing ratelimiting in error paths (DoS prevention)

All issues are theoretical (found through static analysis) but represent
real vulnerabilities exploitable by malicious guests or buggy VF drivers.

Wei Fang (6):
  net: enetc: validate VF primary MAC address before configuration
  net: enetc: fix race condition in VF MAC address configuration
  net: enetc: fix use-after-free in mailbox cleanup on interrupt race
  net: enetc: avoid VF->PF mailbox timeout during SR-IOV teardown
  net: enetc: fix initialization order to prevent use of uninitialized
    resources
  net: enetc: add ratelimiting to VF mailbox error messages

 .../net/ethernet/freescale/enetc/enetc_msg.c  | 34 +++++++++----------
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 28 ++++++++++++---
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 +
 3 files changed, 40 insertions(+), 23 deletions(-)

-- 
2.34.1


