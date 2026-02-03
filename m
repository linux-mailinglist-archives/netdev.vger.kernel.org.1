Return-Path: <netdev+bounces-256476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIaEICx3gmm+UwMAu9opvQ
	(envelope-from <netdev+bounces-256476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:31:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E7CDF47D
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1000300E480
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 22:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F091D378D8A;
	Tue,  3 Feb 2026 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pEqqMCSL"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35973376BE5
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 22:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157790; cv=fail; b=QwbcRCcJteZALQQOb5E6RrdsQWb9FFhgpieuVWh0r2wX2tMwA94wdPsohMefWFjrpDg6VmMI5mD5g/B1mFPyJVzSZ+kLN9IHTQdSLwJYaE1gEf+1k6vOOlIgcWsidpVc2LTwgtdONyL02sioasaJxqpvfsPpnCDwUmeQ0sAYpVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157790; c=relaxed/simple;
	bh=5oe1nXGi3E+gGMDVFF3qYsKmk1k27GVgn2xR9ysqahw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4ff80BqR7t0qt/2emvQGjNR7WZQa+vza5/RNhJL7Hg4MGwoPfN8Pz9u1obYBaHtEp2XsJpPooC9qAnyLlS//jcFJKTQDcXA8A1Mu3/hIkRYFUPCM2EiNkpkNcYcHLtfAWn3KOtTOCWuInYZyZR5LmE9VctsgMIDyvrrU0z6710=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pEqqMCSL; arc=fail smtp.client-ip=52.101.56.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAfbrp7Du6XofJk2TSD681O9cWsof0vTT7r9Ld0ua/RoQ/no2MPM9NBpFnsUA4995W4fg7NcIWgh/2VUbBna8Ark16LSDQ51vIHWVH6fi+SjSPca19uhPF/67Il/KZqjQbxikSSffnkrUfrb91aqlqSPwtDgKQYzhAS98KH6Ay9qgPzLKoSauFibaYCIIaReVSAGOwgDpjY/JGEi/4XQ2mjC1yeK6yLobb1DWt8BSbSeK3QkZiMCYbQr8VKZMKt//hoEysLfeeulxuPK7lzWgcpPmkk5jlxgUG1Qx2YjiN4iH1Z5uCLWGYws/il2GbhT2h2CVKZ456yOVIiNNKvnoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohwOjv+NSzMEm5Bz4uQz2APcJHHvtzWsrGQBotNnWkk=;
 b=XCen5TYo6iVSqzwsnX9shUMBg84nkHmL5l0meuMsSRkDe5EqoM99mzG6aX15zoI2TfoN23zU1XRk9dc6aMx9MmvOx7I7JR0Gd93aufhRUTTn2Ir2YF2CnMXgihzPP8LALjEGm8kcsZA7PboZk4x2xaS5wy73jpuGIsIE2Xt4cDa8RZtyY40XkhHqcIzEpQMKGuibBRr3OCzoSm1UiOptN5JmWQspHs3XgFfnZPYUhaJXxrALME8HAib04Nd/uudC5pnElvc3Fy484CsTzEdRuholwqsVq5UvY7RUvjBbGLzXnlL2xk/2oFOSUP5An/Banueqg/YxCNHB4J9VY72vXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohwOjv+NSzMEm5Bz4uQz2APcJHHvtzWsrGQBotNnWkk=;
 b=pEqqMCSLGDOgoy/b63EXMBPPQZdtT4RokxfPKxU6XEoWzB3fyH3WDSZer9tEGuDlu/GI3mLyWHwhr13ogFH7jjcP192+MDfg6Csw/WhjUSo3PDwyJel7v0e25oq/u2+AgLC+r1uAn9HOGgeeuUnP3FN1dr5umJ7wV77+zKvlMOElCbhrVy+O7uN0bvjycWE90VGrjRn2aUYcTbpF6GvNY+4rD6KfiO7dFvT2YdjVSnS9ctS2S6RFSYdwTz6DZhejS6JduO5awaOOahSJAG1+4mm3LVc+hiJSMVdrQMYA8dcWX/Z2s0SxCWQO32nBMkBAMPDrp0Cm9Pr27UF0qup9Gw==
Received: from BN1PR12CA0004.namprd12.prod.outlook.com (2603:10b6:408:e1::9)
 by CY8PR12MB7706.namprd12.prod.outlook.com (2603:10b6:930:85::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 22:29:42 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:e1:cafe::c7) by BN1PR12CA0004.outlook.office365.com
 (2603:10b6:408:e1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 22:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 22:29:42 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 14:29:25 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 3 Feb 2026 14:29:24 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 14:29:23 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v18 12/12] virtio_net: Add get ethtool flow rules ops
Date: Tue, 3 Feb 2026 16:28:59 -0600
Message-ID: <20260203222859.4219-13-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260203222859.4219-1-danielj@nvidia.com>
References: <20260203222859.4219-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|CY8PR12MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: b33c49f5-f0c5-4903-744d-08de6373b9ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NKMQZ3pvDsPWVm3QUrcnhD3cJO+uplgpwIBFrUzM7x1DMcToc5t4u+R/x6Vb?=
 =?us-ascii?Q?UGzJyykfZwkgoaDPOJRKPpCy7uJdSVLxmP6hf1TCrPLv9aOlq/Vqtff/cYTu?=
 =?us-ascii?Q?IeT2hQ/u3CVEF3EdxalNNzG3YDZ97e6ax5iDqgjE+rDwhIjBfgBsSm/yy3we?=
 =?us-ascii?Q?4ijHKDcIpsC58BtDYNVi2dlz8R0fhe1HTtuqaWwRNM2mSzkpOrigEumZUk9d?=
 =?us-ascii?Q?yfOoMRmy5J4fo4ga02rKJsljuK8kgmpULvK24HEjANjSLPRAnTOtOcLhnihZ?=
 =?us-ascii?Q?yLd68zaHJbEB2cyai4T0qdMNuJ0f3JJd27HbXN2hdl9kg5I3JI2VU6f07JYw?=
 =?us-ascii?Q?pQ+4rEPVc9ikMXqWqc5u5JhuTc6JCXoARjAVBmk2CNSwqZXijzSzIKTmcbB1?=
 =?us-ascii?Q?XGirRasoscw2p6i+uoIC+bPaoIWjQl/dlG32RFj1SWxicP7P8Rp43wWYN+KZ?=
 =?us-ascii?Q?W92byhp3DLGqT7SzImZeD/DX2VKrhINmvHzuekS6wSpHqMqMOLKV71ctMK3g?=
 =?us-ascii?Q?S8NB2q5TOgXEmzUy12szkSjNPHA54/YjvHUjTnB0b0dpUZFOAJimmrLWjH1i?=
 =?us-ascii?Q?7HQ+QVuEnYsXxm+ik83XUbThkN0keaexbpHLreA7bZa5oG/+dcWPsDu3veRA?=
 =?us-ascii?Q?o3w828ZxA0k77+8BT+5tCIQST7mpoy7S1xUvFMUlZ9iGAYuL3y0WOF52mKYd?=
 =?us-ascii?Q?V3CBVSewpFUXLRgC8M7ySUV+M5EmaytMfZkiA2OjwAkgboHcW9I3alKrogEP?=
 =?us-ascii?Q?2ytUu/7yJbW3oXvc14Kp1P5OLSg5f2cD4BboFO2SU2vE0Vpz70rW5sR8L9yN?=
 =?us-ascii?Q?oItf4yGDMi1s38osyMw3qtmbMP4mpP+vrloxaHNBiXTc21zvJrq7GD/Sbc01?=
 =?us-ascii?Q?VqVXBr9GwEcCwNUygDDMBBZMqE5jKjLDHSvN+QWCWBzF9kbGPEVjU0rsvL7f?=
 =?us-ascii?Q?rOBvuo9Gx0l0LBPI7auhZULyMQx5HVUXLNl/I8QOH7Qpp9PPmGAxkzUeb3WM?=
 =?us-ascii?Q?QzAIG/EugpxHChJrdnrbhQo5Jtv2UnG1BLJmLRMeH7zlM9XGUdDjKti2S7Yc?=
 =?us-ascii?Q?DC58wb/REvTm44jETjZe7Vj2hEItRpQgojE1J2YP0BO4MWCNzlvatnebwKY3?=
 =?us-ascii?Q?2haYdAaxTGPbx51x810/eyVXKKa5lGZ9j22dA5Ad+TLTCmdJQ+RXVBDv0iTG?=
 =?us-ascii?Q?Py8wyVpFTpKmBZdzHvsXj1muGf0UZYsGJquV71sXR6EbzCmrwYBSo3iJ8lwO?=
 =?us-ascii?Q?ANl8yhI5FVs7mWz11/9Am31XVjVUPR2QJcN7GYTnixKM7Zfu7lTA6lNjFT7j?=
 =?us-ascii?Q?JguhCxnZRgrw7PRszW2yNwitBY8XlsJKXqKoZtwp3fe18YxYCKZor+NoH5Yp?=
 =?us-ascii?Q?Kx31yhMjQH+OBRNOx4A9wtoD3TsOqieNlunu4fK83Yf+DGcq2sRpnU0FkCm+?=
 =?us-ascii?Q?a584wWoi0RwiuNdCyV2CJK0iBZJwxRQx3XOQxzHbq1EBXqHkrwU92afQ1LgD?=
 =?us-ascii?Q?K+Q4y0o+B91Cc3N1Hz/tH75YW1xn9LTkyrwQ50cDNiy8aplLNgXlB9VIV1vi?=
 =?us-ascii?Q?dwxqhEpFkLNLcKKZsib1nb/lR4azjAH13q0s0PI5Is9QLodGCv0BHpBHFldG?=
 =?us-ascii?Q?tKKyEaw8XABdoCthZ+91NN9gL6FVNk4+t9+E0DYHJPc/oz5oghUlncG5dUJN?=
 =?us-ascii?Q?qz2h6w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TIOpZO9PEzXm8HygUF2BU0g0C/Tyl3M+YL8Peomm+TKiXebIbbDH92bpvDXhXQ8BmLbQ0W9w0HMA+r5e6/991fPo6+Ar9QL+1RkwEqwFg/beA8625mDJ+Np07YHGgflpf6BHV4xppR67cJNgcKbwFOYex1zoj1A49OZ5wsrLFgBx6fqxG1zSs4faT2QJG5KDnqDmemLY3F2TlLvrRdv7tEupY80RRijsnJtHBUkvrUJvnK+/+PkIGBvzHsP4W1hdL1aJoRhSyJFCTsNeZTE4H1eTiU8MgAiQ0cugoEZ8/iko1gPyWFiiMX264unaOensC1s7QZ3D4OE9myywTIJMGSfkQDyMRaPwFA3hodypFv2Ia5iZTThs2+9G3vDjYW69DsdFmNZDqCA/OO+Koznx75O694h30cvDYLVoa+UImqGWi2dl2Ddy02t8La4rDSH1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 22:29:42.0758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b33c49f5-f0c5-4903-744d-08de6373b9ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7706
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256476-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,alibaba.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A5E7CDF47D
X-Rspamd-Action: no action

- Get total number of rules. There's no user interface for this. It is
  used to allocate an appropriately sized buffer for getting all the
  rules.

- Get specific rule
$ ethtool -u ens9 rule 0
	Filter: 0
		Rule Type: UDP over IPv4
		Src IP addr: 0.0.0.0 mask: 255.255.255.255
		Dest IP addr: 192.168.5.2 mask: 0.0.0.0
		TOS: 0x0 mask: 0xff
		Src port: 0 mask: 0xffff
		Dest port: 4321 mask: 0x0
		Action: Direct to queue 16

- Get all rules:
$ ethtool -u ens9
31 RX rings available
Total 2 rules

Filter: 0
        Rule Type: UDP over IPv4
        Src IP addr: 0.0.0.0 mask: 255.255.255.255
        Dest IP addr: 192.168.5.2 mask: 0.0.0.0
...

Filter: 1
        Flow Type: Raw Ethernet
        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
        Dest MAC addr: 08:11:22:33:44:54 mask: 00:00:00:00:00:00

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4: Answered questions about rules_limit overflow with no changes.

v12:
  - Use and set rule_cnt in virtnet_ethtool_get_all_flows. MST
  - Leave rc uninitiazed at the top of virtnet_get_rxnfc. MST
---
---
 drivers/net/virtio_net.c | 82 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 155f0ceab006..24e586ff6b14 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -313,6 +313,13 @@ static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
 				       struct ethtool_rx_flow_spec *fs,
 				       u16 curr_queue_pairs);
 static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location);
+static int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
+					  struct ethtool_rxnfc *info);
+static int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
+				    struct ethtool_rxnfc *info);
+static int
+virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
+			      struct ethtool_rxnfc *info, u32 *rule_locs);
 
 #define VIRTNET_Q_TYPE_RX 0
 #define VIRTNET_Q_TYPE_TX 1
@@ -5596,6 +5603,28 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
 	return vi->curr_queue_pairs;
 }
 
+static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	int rc;
+
+	switch (info->cmd) {
+	case ETHTOOL_GRXCLSRLCNT:
+		rc = virtnet_ethtool_get_flow_count(&vi->ff, info);
+		break;
+	case ETHTOOL_GRXCLSRULE:
+		rc = virtnet_ethtool_get_flow(&vi->ff, info);
+		break;
+	case ETHTOOL_GRXCLSRLALL:
+		rc = virtnet_ethtool_get_all_flows(&vi->ff, info, rule_locs);
+		break;
+	default:
+		rc = -EOPNOTSUPP;
+	}
+
+	return rc;
+}
+
 static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -5637,6 +5666,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.get_rxnfc = virtnet_get_rxnfc,
 	.set_rxnfc = virtnet_set_rxnfc,
 };
 
@@ -6568,6 +6598,58 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
 	return err;
 }
 
+static int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
+					  struct ethtool_rxnfc *info)
+{
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	info->rule_cnt = ff->ethtool.num_rules;
+	info->data = le32_to_cpu(ff->ff_caps->rules_limit) | RX_CLS_LOC_SPECIAL;
+
+	return 0;
+}
+
+static int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
+				    struct ethtool_rxnfc *info)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	eth_rule = xa_load(&ff->ethtool.rules, info->fs.location);
+	if (!eth_rule)
+		return -ENOENT;
+
+	info->fs = eth_rule->flow_spec;
+
+	return 0;
+}
+
+static int
+virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
+			      struct ethtool_rxnfc *info, u32 *rule_locs)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+	unsigned long i = 0;
+	int idx = 0;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	xa_for_each(&ff->ethtool.rules, i, eth_rule) {
+		if (idx == info->rule_cnt)
+			return -EMSGSIZE;
+		rule_locs[idx++] = i;
+	}
+
+	info->data = le32_to_cpu(ff->ff_caps->rules_limit);
+	info->rule_cnt = idx;
+
+	return 0;
+}
+
 static size_t get_mask_size(u16 type)
 {
 	switch (type) {
-- 
2.50.1


