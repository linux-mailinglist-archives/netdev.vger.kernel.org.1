Return-Path: <netdev+bounces-286515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FSGAqiVAWqXfAEAu9opvQ
	(envelope-from <netdev+bounces-286515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:39:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BFC50A358
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A26C5300360F
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04FB3B19C6;
	Mon, 11 May 2026 08:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hwfxolBp"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010031.outbound.protection.outlook.com [52.101.84.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A273BA244;
	Mon, 11 May 2026 08:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488488; cv=fail; b=mJlA69Esq1w6KwGQ3ilptwrW5CsdbH2BqLqZtAYDrpf8VWzjEV1USuOM6wRdjkbHfNX4I9ACmYdb5CYL6Dfd4SrEqHd4uVaTeZceR6InDIbTbBWSzQv/idVnamk8ddSknHTUv86Nu7IgGV9tU5lkeSMmLIBMB6IWidltHgu7NJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488488; c=relaxed/simple;
	bh=BH+Rx2Y4Mc1zKBDRXPm7T1SUYFzusnKqC4kCuOVirao=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jEA7VxWxoF2SGRNp11dLU5gFPYC2LIsxvEICIwtEplulwe5cjQEQeOIoMCnibHWv10Lg9lfEAMNnrtvu/DHnPldgReQqEV+6EQ//Y6jWE0DVXJfrEnR3rVFI2ZYfjRSGB13fB4ivIZODJF/LOR7Fp1ivX2DDzwIWClDTFebHSxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hwfxolBp; arc=fail smtp.client-ip=52.101.84.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVbudewxArtZwetp747wjCiJ5HuOm/1ucae8/ztFMEbjI5ooN1ODta77dkYmWDgT+d5ntRgHazXZGTskRB3ffgz3/cB27hO4k5Xq/KSvnabe+N8Yv8nEQodT7ALZ3mp/h5YJ54uOYD33rqle4ZD0MGXpRzNU8eYgRrC7cBO8UuSbBJxG0Li3rhbBeUMiTLRBMoQKvQRKu91YWWWNZWM88sGa/6JcLD81aF+51jHXGYtcD3VlKwGmFLo4/pGnWl13YsOvW9PhdpqZlBBhDE+VNSEOWEwfHF1s7tRHi/cRB89AoGYTnwaSv5kuMpOdoxCodKir95k4GQh9aJJIoajG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tq7d3MMLECEUzD8TyyG2727kv8GIlGzF14ejX/5M2M=;
 b=yfQQcjUxr4f6kylcp84gEyv6qGob5d5pBfsAgnTnG7tqHeJLP7aRLLrRkVZvpGi3ZOcamPs4CPqlkLO8ApqZG/zBXeOhpI2Hy3OcdWBt0baI3fvKiY0CFQAEfOeAPSTYj8XxuDPd/2iBxS9fDXOf5vrZNS6/N6NiHjbr9KL4QKAnSVKtVuHlhlkndwePcy3+gNa+jFeb+mwXD8Jv2DqjSQP1IUcOe+3c4nYQyhT/PIc3dcQeq2ZS/ERwXlZwa3ceks+DwnTiBJdZKmgyEpsCuI84jaUqEGCGxupUD004p50bZyQavT4Yft9A9lFyB7YewViy0axfMkbXaOZT7jkb/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tq7d3MMLECEUzD8TyyG2727kv8GIlGzF14ejX/5M2M=;
 b=hwfxolBpGX9ztONdNntbktZWQEqx75ysXoB8brhrRWAAeD7H8KTGb6o3qqZRll83hFljnuFvnCpFikCCYmjPhU2fdbnGOKn6tSerCAwIr+8Z7nkjOJ5V1EKSbraHp5eDTa9oGat4Yaf0xUtvFFgmvAOdeQ4jFST/CfwnDQ9Y13FEcr+/h9QJdF6gIKVpmjnz1j9Stdi7VlZAJHblWLqrvFEcOltUEaDzAMw0JgcsWe6KXRFu3JnRyt3bUuHO9anG/uOVsNovGXpcFZtk1+WwAhtG4+zQVq1xUsCymD8FV4b7ONOgy0iHHiVrt0+D/oDOTyTJ5t9dvCnBfL3M1JgReA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21)
 by PAWPR04MB10055.eurprd04.prod.outlook.com (2603:10a6:102:380::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 08:34:38 +0000
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0]) by PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:34:38 +0000
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
Subject: [PATCH net-next 00/15] net: enetc: Prepare for ENETC v4 VF support
Date: Mon, 11 May 2026 16:07:50 +0800
Message-Id: <20260511080805.2052495-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: a6b6bc72-b48a-4af9-72a0-08deaf382358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	np6m9sR9XgYq34eALg5gsuy9tCiRychlIZZEAjta3Qq3mEGmmJfVaPYx739lDRrx+ZkXeI895o7xrZC7z+FSYuNJmUEumvrJHCPLw4H01yogN/OBMvtmrqvshAviYShCnIWhv5Yo8/ivBgfzDNpMPeZyz5DD098xl1EKmFYiDZwzZF73i8p8CngNudIfrKC1E+RxMlcL/AcaRGIBsnWauTS3K/axNvK5KPQ6yGNy7Wz6vvZE/juVMxIa+YDmUxu8weC8CEv82cdcnwjN94kJpULP86bRUWPGDG5BTgSz+CyXt9LACGR8vNUkB6hl1ZwWGle66RcJhcsZSfPVOe89D2VuY1zoOY7ZUTghX/aOoze+Li3/iHeAP1tO7zW0xvDOad/DRpfAJWwPBHRRttRWvgSYvuBAkHU+HFOytmO6ISDJ1ZK3qKzz56tVe4y+C9avguuJiDMUKrECn0kh35hM3JQPh25qXVaCfdT2DU5OutIW6q/ucAC3pE96orcgrAlbCKRbeYhQetEylVn5F5trGdSxe5+HaQHH1Gy64lVS18eLFwvUeYt/P4XoQINRoyq6MV2DmXWIWwfwOVEszCO4SlCiGvoal0eiJAFEV+XUvze8rw2rbGt4riHi25+FE7FR0qdwuAda1bv7k5eex4yG5m2rj1Y6wr0dLhSghQRn9CibzTQRjtt27ou/llP9SFPC3FzcWS8iklO451YWrZu8Sc1aJp4ipSTwB09L/mJ6+zYCWUsn6ghgyesIJc+ajUHA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7502.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vKT5vPKY4de/lA5i1IYIWKB8k1igagv8GxvkDTiRFNOfHBvlDSAE//o/n0Bv?=
 =?us-ascii?Q?IZw2QFn59anQ9athY0vuNvwod+uwUz9PkJVk5ofV7fNJ14rpaS0r/obS9H19?=
 =?us-ascii?Q?LQ9e08WhbtWVWCBd8VNQQVGQrvH5OVAnX3apsym51+hVDCP0z3WHlEywyvUj?=
 =?us-ascii?Q?cFMTZDyODAAFIzUUSh0M2HZXfkXBW88dD/mcuroMByg17IhiOpnyJELLVGXS?=
 =?us-ascii?Q?Pn9RJBktk4etgmzu+gQQQeXJHIerXYIFEN1Jj1X0/iJn8C0JaWvPU4soKBu4?=
 =?us-ascii?Q?kdaW9CAeJQBRlEXxTFNNzpbYz+5DtxJUEans9W6YzgG2wbQuocDLYmcALBhi?=
 =?us-ascii?Q?dth94Cs1OPKyi1rUIRdvuDn9dcNSPIfm5ht1+6w27faoqYEArLZkSRPIWTrD?=
 =?us-ascii?Q?7cY8rgpu9/N5ARlyfJLL7KR7E4mVHCpMfku7gBS+3xCJopKgbiwEU5uRC5NA?=
 =?us-ascii?Q?Vxz5iqNle80FzDYPIksFiUZK1hqQ/1EBBdlm1neAD5m/ZiO11ddhAavVDoSA?=
 =?us-ascii?Q?cu8ShNwl0CjMB/v3K2ISvcy739ROYipdYWNhYgGfkj99sYMRwm2zr0I5YHWY?=
 =?us-ascii?Q?peKhxGRJTbecC5FBZQTyYW5sy1B+C4O+cmg1KGtpCI/yX8vNqYpgRDMU4vkK?=
 =?us-ascii?Q?xRaitw3lDZlUa1kocN8ebI2VWYa9HZbJD/FgPRnfIfihRP9zXXTVn7hzkfD/?=
 =?us-ascii?Q?yurNDIYe9aNJuh6VQYxuYhqcZNNNhVmf7GH39INACCBAABKRp6/l2akVOmvn?=
 =?us-ascii?Q?nh1Vb061EnjjjsDuP6rqoKiDDlffWQjoUKs+lE6WPYWZrwoeRKPupWPuD85u?=
 =?us-ascii?Q?QvQbCvppLyLAXQQEAEnhZZWArYDpK+XWrQ3vJ3cO9i2DmGHxi4b4xQ0gaz3K?=
 =?us-ascii?Q?8g/q8JpfnPoDLU51kotZzAGB5g6QcrCRACNhi3PliYWkzSYWKYlzGe7orSbD?=
 =?us-ascii?Q?0ne2zCh5BhoRt1j4FD1NPnzUq6/rPQaxngR7pQ/DWQOkr6SbansP1h1hVjRo?=
 =?us-ascii?Q?TfyfOPe8/FXdsU3naLuyMtmb1+VmG2+KB4nUAcpEHX48TqngcvG7Q5ArwPBP?=
 =?us-ascii?Q?C5QrYaCKB92SymsVu89pa7awaaT92TRSL6ch+Q0Ymc3C+JqPddNeZwZutIzZ?=
 =?us-ascii?Q?tVbOclW4hf38Ue8rJ6ROV6Y/qKv/dTf2rnBEZxYJ7m4qGz4OPRZ6pSTvgZ50?=
 =?us-ascii?Q?Pvj0QLBsDRH8LtzcGvXTU+FWr9xF2l59t3k4GrgBmglh9ns7cvCky9LHI0SK?=
 =?us-ascii?Q?ZTINpExfJeXFyL5U3RuYyPVXtmLs4BKlIobWTsn3p+9yZfURLfrOHgvUn3P1?=
 =?us-ascii?Q?C3MkFIhoOgfFFgvQ7BeRnb3O9fVe6dPnCFrXU7jsehHkK3pf8LmliCKpGnKY?=
 =?us-ascii?Q?q6UMO2k3JLwgLaxVlTqtL6Z/BEnKGC5oZHAl4EOGLmVQMsQVZ5zOwfjcbaK+?=
 =?us-ascii?Q?wwG8OLh/HPfD+NTAWt5TCvAQZCFug7j6/n+gOSyEj2I4+6hxvVYS3rrtC7rS?=
 =?us-ascii?Q?hxcSUi+0LOD7Bx7vw13/yAL+LWiv+gi/BGpltHwfCu4qR5dhOXmHQ5rAJHXA?=
 =?us-ascii?Q?VpnXsdthlnFI6znrxdHSLmuJeti+78qEvxAFeLHzf/8O7z5xNyUyCA0ASP4c?=
 =?us-ascii?Q?RkwZrKutBgkzEUSefPXc0rR2ZWXRrqcvJmHV/NsjN71rHDEYm87vXxFFaJEU?=
 =?us-ascii?Q?Xm8zRAtpGhoY1xw3tanknT6Xxy7bhJnkUeb+VeKlb5RY2GxbUm+xICgoJ0K0?=
 =?us-ascii?Q?Pw0NNbg6Lg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b6bc72-b48a-4af9-72a0-08deaf382358
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7502.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:34:38.2378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCmUkfrsM5Qo27FHh00n/eX5v/68L7hT2cIUtiTDRV9ma9wOi4bdYwjouiUup1h2KE5d1Plec2htp9g7TIss5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10055
X-Rspamd-Queue-Id: 62BFC50A358
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
	TAGGED_FROM(0.00)[bounces-286515-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

This patch series refactors and extends the ENETC driver infrastructure
to prepare for upcoming ENETC v4 Virtual Function (VF) support. The main
focus is on code commonization, improved VF-PF communication, and dynamic
resource allocation.

The ENETC IP has evolved across different revisions, and the existing
driver architecture was primarily designed around v1 hardware. To support
v4 VFs efficiently, we need to share common code between PF drivers of
different IP versions while maintaining compatibility.

Key changes in this series:

1. VF-PF Messaging Infrastructure:
   - Convert mailbox messages to new formats
   - Use read_poll_timeout() for simplifying VF mailbox polling
   - Avoid mailbox timeouts during SR-IOV teardown
   - Add support for IP minor revision query via messaging

2. Code Commonization:
   - Relocate SR-IOV configuration helpers to common PF code
   - Move VF message handlers to dedicated enetc_msg.c
   - Integrate enetc_msg.c into enetc-pf-common driver
   - Switch VF primary MAC setter to PF ops for sharing

3. CBDR (Control Buffer Descriptor Ring) Improvements:
   - Align v1 CBDR API with v4 for VF driver sharing
   - Add CBDR setup/teardown hooks to enetc_si_ops

4. Dynamic Resource Management:
   - Dynamically allocate rxmsg based on actual VF count
   - Generate MR interrupt mask based on enabled VFs
   - Refactor MR interrupt enable/disable helpers
   - Use MADDR_TYPE constant for MAC filter array sizing

5. Generic SR-IOV Initialization:
   - Add generic helper to initialize SR-IOV resources

This refactoring lays the groundwork for cleanly integrating ENETC v4 VF
support in subsequent patch series, allowing code reuse between v1 and v4
PF drivers while maintaining a clean separation of version-specific
logic.

Wei Fang (15):
  net: enetc: switch VF primary MAC setter to PF ops for commonization
  net: enetc: move VF message handlers to enetc_msg.c
  net: enetc: avoid VF->PF mailbox timeout during SR-IOV teardown
  net: enetc: relocate SR-IOV configuration helper for common PF support
  net: enetc: integrate enetc_msg.c into enetc-pf-common driver
  net: enetc: use read_poll_timeout() for VF mailbox polling
  net: enetc: convert mailbox messages to new formats
  net: enetc: add VF-PF messaging support for IP minor revision query
  net: enetc: align v1 CBDR API with v4 for VF driver sharing
  net: enetc: add CBDR setup/teardown hooks to enetc_si_ops for VF
    support
  net: enetc: add generic helper to initialize SR-IOV resources
  net: enetc: use MADDR_TYPE for MAC filter array size
  net: enetc: dynamically allocate rxmsg based on VF count
  net: enetc: refactor MR interrupt enable/disable helpers
  net: enetc: generate MR interrupt mask based on the number of enabled
    VFs

 drivers/net/ethernet/freescale/enetc/Kconfig  |   2 +
 drivers/net/ethernet/freescale/enetc/Makefile |   2 +-
 drivers/net/ethernet/freescale/enetc/enetc.h  |  22 +-
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |   4 -
 .../net/ethernet/freescale/enetc/enetc_cbdr.c |  16 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   4 +-
 .../ethernet/freescale/enetc/enetc_mailbox.h  | 177 ++++++++++++++
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 217 ++++++++++++++++--
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 109 +--------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  10 +-
 .../freescale/enetc/enetc_pf_common.c         |  24 ++
 .../freescale/enetc/enetc_pf_common.h         |  10 +
 .../net/ethernet/freescale/enetc/enetc_vf.c   | 162 ++++++++++---
 13 files changed, 559 insertions(+), 200 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_mailbox.h

-- 
2.34.1


