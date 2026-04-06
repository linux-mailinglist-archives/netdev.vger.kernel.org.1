Return-Path: <netdev+bounces-275742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCdiFCIk1GlxrgcAu9opvQ
	(envelope-from <netdev+bounces-275742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 23:22:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E153A7834
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 23:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7332D30157E6
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 21:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D97338D014;
	Mon,  6 Apr 2026 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NPbDU/7K"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013022.outbound.protection.outlook.com [52.101.83.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BDD3947B3
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775510535; cv=fail; b=MzlImnLillWRivOUQ82Fenxy8UqkFUkhXva62p+0lyz4DU+9hK3r1AuwchLxIIB7jft40BceNAy7owuCjIL68fruNyQhM2fQLsZlctHw8eZu7wQtKM1tSIOO3BvOKjDK+vAV7dlJE/uwFKS2GSYBCfBRqecC6jH+hoXMuhwbcMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775510535; c=relaxed/simple;
	bh=7zc3vGnXaoRRWqZMIohHMqexbUn385+NJ4m/se2ipi0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=j1GvzPaypAB65NyLESJLxORgcoWYkTeTUlhAPyKo9gwZvLY/XoFWWcRq/eu56hkdMGyUjxxBMztcmMSDRGqoDo82b2iADp34xAiQtQk/+UsFcjq+8BdVEqcS2XCMTTeu9A7pVSuJTsuRGQoAP861Nep62pCQbRoYBqulu43oZKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NPbDU/7K; arc=fail smtp.client-ip=52.101.83.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMDM2FoozXU07e508ibF9zmXodNkHQj0e06Qj00GihILD4ox8FStAXUwzlQVSsor8kOK4Oo/Hlz3uJSD9FtZvW4NWReIlv/y9lFXNow9YNL6JNz/YsyFB6H0Pf1rw236gKA1OmUX0Hsr4yCl6eU5llePxRMGWypwAva0MNn0kspswhsP8DeswgdQUXRStzX93wcs3xeKznCh2vEzyeREclP04qZv1cioHcu1kSqnOabvs7Qjr5i0FvPDnlRTPTmYxs+iuZzPzj9L+TV9HQpo/6uGojIjWjxVQXDNMBzXDgf1a7H1H7zzvTNqyEdTaLF8dYzvhl4ErkzLiDVWosp9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23mIAHhhxKjNntlhffQ53CrBLhgkE6igGklNVAn+d5g=;
 b=vl1cRlb7g5DFynM6b6swFy1cMtaNjIFEO4aAkZEJICfbK2lZ6uzT68qWRutKPCjZnNy52BNMQwza95xSDE89fREbHMqKEMg7yyITAwNMm1yjuvgX7jE0pFHaPD/mo8vkgs7rQfYwZkMPuLOJzZNWmy60Hd9mJc++5dMHmNaYHbHqKTXz3CCMOdAUhPXBwWxVej8cU7bFxvnzLXJ2UCER7xspDJvGTg3XrQ/IMJqLhR4LqZlBNpNi0IL4DB4lavNbU3OtrKrKJd4sTmuVjQMoWBNEZgAfHxQg4Vg5Dpcp26uetIVcEWoGW0aaYStc0dfEY+gdE6CXbqo43s7JXaO+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23mIAHhhxKjNntlhffQ53CrBLhgkE6igGklNVAn+d5g=;
 b=NPbDU/7KAN8u96IGVeetiT448hURVvLijg9diQT1u27hcFsDMq+je8ISfAFsNnELHfr5G1VjgWjApebf/sApn5Tz7CxWlSzrcmBu37Ms+fZKNSN2QXlfTFmco4VUSDlWTR1UxvfWpbV/Ei5ECr0hKm2mrmW8a2f+MjMBQC+qO4RGI/u4RsAHIsj8+LF34XHv77e8SyflP/GXi0OYgxKal5RSdp/aoQ6ncksxzoYOzNedRicKXabUsSXkl+9fhcANLxQEswaOYDcoRLjnGcWEIb4s6WkJk94AxjPSmFF1NzPkbBA1bSPwZE+EyNyLGyTHnjSKzcXUHucLTDdKi0YGCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS1PR04MB9583.eurprd04.prod.outlook.com (2603:10a6:20b:472::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.24; Mon, 6 Apr
 2026 21:22:10 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 21:22:10 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next 0/4] dsa_loop and platform_data cleanups
Date: Tue,  7 Apr 2026 00:21:54 +0300
Message-ID: <20260406212158.721806-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0098.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::39) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS1PR04MB9583:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f9e13a-7e09-4838-07a6-08de94228ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|10070799003|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	y0JSy/C93xBKu7HCy3INzvsrisLXhrgSKk89EqKD84Xy9KGoldM48WeQ7jPkBMamrZYd48VIjvUzHvvMbYShaqfJZiHYPZQgjRsuK4YDRFsdU7kXWV9Kuph/Q2xhHgkkG/XqWNqCoAOid3T+jV+V19PBHFvMWL38bb3OoqjfoOX6TFhcdJcGjJoPstx+NEAnLDys02V+xchEhwEHeJihRLIsspz4O1r16MlkTelQTxzOICX5DyHhO/XuapnzZAOGR9p3pwuLAApaP2t+sJVXWiVYVhbZ7ly6gszSZW2QZ12oJLnR/tKyZls+N47axkrb9t4Rm9RrG4DRphtbcuNs7f40/jWICve5BgiAdERQdSJ33yZpdmTUj+g+z6spkrhdwCuzeJM6a0PKo84oOemB6hvD7Hrr/kwNkbz5T7LHmTGQCw4ysl0DtL9pRR/Awdofpt4ADI3hpOTsNEHAV8cm5OUHJdgu/GT7sWPwGi3aslud3Z0zhCkdX0DcvYwwFTvt2WzW8IFOjPQlw7hXBCPMZAUJ/wBXcQDg4WMTNDfRZXarjbvm9Qc2UbFFr/9zNNu052eJSlH8c2Zzj+aTYrEbGniv6R9DTFrhcLv9c2h32pPcqXaiW+0nlS7mr7v2YfppGpKFgXNq2sqxTyJIfyvSwEzGZL84/4ydBhUIvAL39PeWxJQfhTDq9/J99hpvgjo7dChzuUcCB+LaIgBUoYD2cw2Iq5Q44ICy6V5b7Hl8uEU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(10070799003)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1fy1QFV4KkHl9icWGYhPUZae+M0iGJfOCR5HclZm5l9yLUROz44kv0FKZaiK?=
 =?us-ascii?Q?FvEty+XiFXsqwI0O9ivbQ7aT09eOh7VBtfPpbJAWXYkepGD8dmsT+a8kV/HV?=
 =?us-ascii?Q?A/ca67dAyP96KCiH7I9h7IHAwXdn7tF0M3wLY64y901eY39bSgaFhUI8XeKk?=
 =?us-ascii?Q?MtqnGjJ/QV8VFbQI8CYRSwCnkKaQexYaqIKvX+U9+C1atoUJJxk44S6X0nwR?=
 =?us-ascii?Q?eh73mDTJVDKOtp1iUzbaO9CVxHOmeHmYrIpTfDokJ/LzBOmRi93AlxI9tyB7?=
 =?us-ascii?Q?B19Q0YIpt1aQbLkk9Bs5TQ81JG/rASbQJreZBv4o4+RWm8bx3OutXXS+FBjB?=
 =?us-ascii?Q?C7mN2YKyFxuCu/h8EfwfOM0IreHQLFRq3S6es8UAIhz8wvNuSbS+rUV2jBIL?=
 =?us-ascii?Q?4S8u+G/ldRsO5EjePUdX2d4hSFjWcFVcdhtnrffANyE1J9VYIGZotqSrMM/U?=
 =?us-ascii?Q?gJ9XADl7W98d/NvUzrV96H6AMD0Pk/lq1BkOP2e+GeHo2S7zAC3fQBM6W7aY?=
 =?us-ascii?Q?XLz2uvRxcEOAXGP2wgXrX4B5IG2+nuIbaEVe/+H6fMXPiFqLmxXNnbUITGky?=
 =?us-ascii?Q?9XMZTovhMPqNrKtUhc496fni2kewTQESSKVoTiQhINafn1Vh3rU3+Lk3zhgw?=
 =?us-ascii?Q?0N0NhgSIFmadO80wHdzYgr3YElOstGqxnqNZ6PNi52/ffI423v/6CyS1a66f?=
 =?us-ascii?Q?6PzUeASzXv3SirJIqacMEWKqteqd2+Li5RkHdSfiw5KhYoMGa7bt5rkil8U6?=
 =?us-ascii?Q?qcxXhCT7IUAZC0EbiWT5YdgTNiBPbPPQYe4aYk1dDJZVF75P9jWK4bPGkid9?=
 =?us-ascii?Q?XgmF1cwRz6yX08/Z56lyzJtSNYp/u0YY+hHf0358PmV0wiZjsPYd6C+brW1Y?=
 =?us-ascii?Q?fyIEdxxUfg0XOC+TqnhHNbVrgU4933gf5VbwVIWwbSdr8Ei25CwR9Pu31Xp2?=
 =?us-ascii?Q?A734cDuyGhoqGwSXvfpjTNTgZyeXImuG0wc60/LF8ROcGylB8rK8wpS6oF3u?=
 =?us-ascii?Q?zBhNwohBlfK0MmBxJFw8mIOMP4WNA2vzLzuf0I0cQyVaf4FTkVrX0Jj6JM88?=
 =?us-ascii?Q?73upvU9ud95NdES1z0ibfgM3yejJTfPhvaBA+z4cY8vk8ZgAHJze+1KWbv4m?=
 =?us-ascii?Q?X1IjbZ7wLx9li8TOxIh5iPAlLkzeMsZ6rkrs8KwV8kJWvKInS2Zxv+3BLvSV?=
 =?us-ascii?Q?y8KpSnOUYDMPcoPVdVexBWP1UZ1+PljBntZKRJZGHsI4gCHWNnKrMZ//1yCa?=
 =?us-ascii?Q?0aa0cWJoCspZmx3Lbf6rMkZwCnKvozI32xGgLWGa2iJig7Ii3TnTmH1dxDlS?=
 =?us-ascii?Q?TZejUADZVab6RBqZqLJybUXHPOuiqu7DCFIWdQKss6O3pFywbuTozxivRK4W?=
 =?us-ascii?Q?ZSLsKy2iPfUFH0Y6twDUbmmhMsES0tLXPR7TjVSW1q3H2AKcSK6UOMKPeQiV?=
 =?us-ascii?Q?iDk1UDWOfgVJN3lprTmIchH0Hpis4aBeEEpS4yTVbYFThBBsUd1tyYBZ/y6t?=
 =?us-ascii?Q?15oSTKs0NyFD6H2MwsUeOEUQHUiO9AyyN+jZPsbRQmU+SwCOlPgwjtc+wYkm?=
 =?us-ascii?Q?dInQnJhpEDDsOu4IaTk8TGJu//wIauVQUG4Yj72Sc471u38iPADP59ksOPT7?=
 =?us-ascii?Q?owAB9c3SEI/R77fLlRJGTXnilVmjG/79TtdMttUxrEHrlOW74Itt1Js3fBsm?=
 =?us-ascii?Q?DWOwiSP0XC3rhnPQCTe+ybh6eNPU7x6Da4Cv+uoMPgLf/lqMhQ0es5ogUJon?=
 =?us-ascii?Q?76M2r9DTrvoeEcfHIMeFHg8NtAoz0alHq6pQcj4/v9qqgek8JpVP4SkT1A/w?=
X-MS-Exchange-AntiSpam-MessageData-1: N7iqyIGOCqZ+TTZapDJUnxm0sgYRoeJrEoI=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f9e13a-7e09-4838-07a6-08de94228ff0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 21:22:10.0697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQ+1/bs7DXvulfH51WHe4NdafGo+7HNTdIXb3qIZixbFTcnTUCH99luGDlvV5u8Nm1wq1Pe+xHR5vMJOpWruMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9583
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275742-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 73E153A7834
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

While working to add some new features to dsa_loop, I gathered a number
of cleanup patches. They mostly remove some data structures that became
unused after the multi-switch platforms were migrated to the modern DT
bindings.

Vladimir Oltean (4):
  net: dsa: remove struct platform_data
  net: dsa: clean up struct dsa_chip_data
  net: dsa: remove unused platform_data definitions
  net: dsa: eliminate <linux/dsa/loop.h>

 Documentation/networking/dsa/dsa.rst |  5 ----
 drivers/net/dsa/dsa_loop.c           | 35 ++++++++++++++++++++++-
 include/linux/dsa/loop.h             | 42 ----------------------------
 include/linux/platform_data/dsa.h    | 40 --------------------------
 4 files changed, 34 insertions(+), 88 deletions(-)
 delete mode 100644 include/linux/dsa/loop.h

-- 
2.43.0


