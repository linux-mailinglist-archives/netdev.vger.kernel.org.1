Return-Path: <netdev+bounces-269899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJw3LJAxvWmI7QIAu9opvQ
	(envelope-from <netdev+bounces-269899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:37:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D862D9B35
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 003B530053A4
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABF2387352;
	Fri, 20 Mar 2026 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C0HCNWI9"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010035.outbound.protection.outlook.com [52.101.193.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A078E361DB9;
	Fri, 20 Mar 2026 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006438; cv=fail; b=kWhokVP3lQdQeXbVtFDsmHuFOMHNqvqncrodvVXHeEolAjoweCPDOijyOLT5CMl0uWyL4AvP7Xk+O3bKGSC7ldq/yL0lhVKnL0JO2xFI30JTTmsM1iAScnoTfF6c0xRSnedH+ot/HtDlhLEVjpf8H7+7bjGJFO4wG9Hb5zz4Y6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006438; c=relaxed/simple;
	bh=jL/JLLXWHNDMSKR0kjEUAxzizRHp9dOf335bhTrF58c=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=lH7KU3lJiDojt/b22/m4OKzl3F6XwkyGcb8QgdyOEchUvuaZHnKtteD7+km6/WERvtHJWtnZUJSUcbtMFFoQ7dHrvyrdMA5dCt3CswsJxvCQkhZNMGqlu/rqjuuBhEznYghocNFZjxkjlbcV2B1oVASEr/rVe8Um8c96Mft81Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C0HCNWI9; arc=fail smtp.client-ip=52.101.193.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPuenS2HElj3OMIqlWcu1t+eC0AsRsn957VDBnpEdG4jvP6TrYVi1hmrsZ+o+ZE1HZsk4oj2QCSdjN60Htwfz7EWbnSJAnQGw8tO0CT0xy+jZTUbesocITSmVHQavNtcAquEfjFlyLuUDzAqXlKVqJMfZlnQzdRN1QlWvPY2j5aYa9zEiTOiPZSp2eXmm06uDFBXJfmhGYvR2vpj1utivc0rTzSdWEyHLNyn/T1xGLeQyN21F8rZkAJa8u/JCo1uefRdrMWzDMX3a9x+Fpun/rnlbXNjHyTNz8y9lxEujtN+0TqNo6DwMl2Dod4ccXu4OhWRgpxQC7wDt337WUPX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jL/JLLXWHNDMSKR0kjEUAxzizRHp9dOf335bhTrF58c=;
 b=d3gUeGryCyaNG8GjjFhiMvSQR51/Kt06Mq+TP1YGJtPuOlJJwPKc32+GcCqSBPcPN0gceRY0XRpzMAkDxYmNknDtvT2YNEuNfFlCNtHvgBUDMrnCDM7NM+3FkfwNbxyIG2AhgjzqaZqfZZgFfSgVV/riyL9+qNZKpSVDxV36OTfUg0n3M2FZDdk3OEuVcz1h6JSj1GEcR37poor7wFRWE3Lbwr+pQbGkR+c9RMEIElDXYXGrXi8gn54HBw8HjBxrEGDgThQx9bOAFkporlZpoHgJd/TU4unHBBE+wqrHPh/WUZRuModm4sE9ILyzwdiHzEhToyqDwwqmcPG5gZ2tZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jL/JLLXWHNDMSKR0kjEUAxzizRHp9dOf335bhTrF58c=;
 b=C0HCNWI9YsXiOzCb4dnyTtp2D3aNCbP2LWiVfkW4TXaplbuMiMNA53FxXo+MTjxfhdFvdIAfRsW7vug22hLh5zXMVRBpM0rPvsEF2ezMShFzrex0GseZCG5EyHy6yv5KH5O6H6YUNoAtrmzwae8LN1dKTkrSP96k8x64840XKnZqHblEAwjCyRbrbOY6YfuypIP1mCBhKbCC5VAaU7KohoaLEUHqxPDKHYoUzLH0UghAQYI/T5aae5/pGVi7H7VXW16w2ZY24Gh2g2pxknRvDn1zRHkybK06UE+Hlj1KJUBZv761GKlPcZTrgI34YMlnYiXQSXglGOIsAG4rk3FcSQ==
Received: from SA1PR05CA0023.namprd05.prod.outlook.com (2603:10b6:806:2d2::17)
 by SJ0PR12MB8092.namprd12.prod.outlook.com (2603:10b6:a03:4ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 11:33:53 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:2d2:cafe::ca) by SA1PR05CA0023.outlook.office365.com
 (2603:10b6:806:2d2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 11:33:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 11:33:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 04:33:34 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 04:33:28 -0700
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
 <20260319160410.2515105-8-ioana.ciornei@nxp.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, <petrm@nvidia.com>,
	<willemb@google.com>
Subject: Re: [PATCH net-next v3 7/9] selftests: drivers: hw: replace counter
 upper limit with UINT32_MAX in rmon test
Date: Fri, 20 Mar 2026 12:33:11 +0100
In-Reply-To: <20260319160410.2515105-8-ioana.ciornei@nxp.com>
Message-ID: <878qbm91ml.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|SJ0PR12MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ab22ca-0eea-4b1d-a38a-08de867490c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7iR7Cq9Dl81OvIUF2z7cYPvv3ivpFuvn8zLLClP+GzaRk36br38eHXn4NsktK853Cqejs2Z/7SeQnk+FRxlh4Z7WNdaBzlkOD79AZn54gCvD5q5aAbsEz4Cb6KH/SJyx9OWQG0nZRsyQT9i3jr+uoQdfgbNHqSGSh4CuVEu3mos9jD6f3iQjs4WWkfyjbFPg0omkckrBqiz34GhKOnAZnHY1edqA5BOEqLocrVA3FGxqjMeB81DIQDcjkmGImV6l02UD4M7ACLcestvMxFvOmu/IYMwt/Gtk18anAs8rdGjMg6va0jQFn/5gNJdAARnUTok1F8GhrtNX8KbWcHVdWX8pH25HfX7yWqjpysgxdT6Jf+uhkWisPGjTewmjAntnGAuM973Hs4lLZKfJWiteR47+9dZyy1hMTEMLKElL9v9uMvYr4Ps63j2pyG4yKop5dHPYuQ17uAaLnyj94NzP3QTYRgqpRWjCBppVExpc1kDqlUzIdxhzhANzfVgb8c9bQzPA09ktd6bFX57Uu3HVwjP0ydk4ayYHzpyAKcQWJaCG1g3YmXy/zSjbmO5p/l8iOOM+32ZRaHhbRHv7KmGmDPzxD2rtnZHgg5eZWGoyMJlSCM61Bsct5o+Ukn/5dQPk1j6EmBUg2F+RyL5GuD+t1FmLJceDT1Pc0Ghq1d313XLccyKlnU4pIdAY/gld5mI0yQdTfZdmMUr1Ao4eq4MeGqNUmBnbvzaQX0W1GKIk55aqiilSsMM18IPP3A3jpiFY4mVcAcWFKMAAXX1kIW05Tw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OkzEJ/+20Q2+dJ5EHOShpwqKThJ8GKATPdjXmSgXPNp+zWzcB60b2hOFVMag6zvhgN9/GjNqAuOw+yw3EAyMoEW3/w3VawDxfjQabhNs0L56vVA4WhVTJQLrIHb65g8sIZz1ZZ5SWm5h2qQgE0scmOrsiofSVs0AQ3+I1h8oiV0P3YbENpUviAyWIv+ct82Obeio6eBY4jgepxjN871pi3DqP/TiOf7MFLzJmr/qBv5wLP6ezGWuEcLCLBOXDmqBamFyDans0kuIpB0A2DIC5rgGf9rHqg2y8sbpOD07auom2c8ipr9njlXwbQ97raZ9Ggl+gAnT6coZWyQnfPifyYSxzQixn2FtISx61Du/a9dP7wNEtKTnURCgixu5VRj0JqhhFPqdl4BFMBLhBpoU3fmqUQHi9vB3+T6Pi9crtgFFVcFKUMIlpFAx+RqKMNTP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 11:33:53.5106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ab22ca-0eea-4b1d-a38a-08de867490c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8092
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269899-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.953];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 26D862D9B35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Ioana Ciornei <ioana.ciornei@nxp.com> writes:

> The ethtool_rmon.sh script checks that the number of packets sent /
> received during a test matches the expected value with a 1% tolerance.
>
> Since in the next patches this test will gain the capability to also be
> run on systems with a single interface where the traffic generator is
> accesible through ssh, use the UINT32_MAX as the upper limit. This is
> necessary since the same interface will be used also for control traffic
> (the ssh commands) as well as the mausezahn generated one.
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

