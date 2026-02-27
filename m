Return-Path: <netdev+bounces-261916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DfxLJrIoWkVwQQAu9opvQ
	(envelope-from <netdev+bounces-261916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 17:38:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 035751BAE32
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 17:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EA9B3075E92
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721F6346E5E;
	Fri, 27 Feb 2026 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Eyme87Wa"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4A0329E53;
	Fri, 27 Feb 2026 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210325; cv=fail; b=fAnQ/QF3twN+MRZIbGwSld3WB/M4lu889VONifMTalPrQbdu8Q0bBpvNJARcE+F9/qtqb40qwSosW7YKkJ7Pa02H5nH6RUstXxSIqW49rg8JsOYVunS/DMdi2a0rCFW6h/IgpMLhJHYZVAkkbh5j3IXPn9SpG6b+t9J0Xsl56OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210325; c=relaxed/simple;
	bh=OrmpgZIeAh2yn4bVdjmStqDM88dnnETM5kxNAV7GrTw=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Mqn/UbghPXDHXZe8MH+l1jwH8QLN273YVl+k1AV+CdYd+yyneVKJiyMzlibjKBoQ00cdKI5ogCPiypDunYZyHjJ+CEIamYVCKFLxl/ePueGCfCcjjs+vfdjGdTi5YpuixmJE8TvyFGq0GewCShYdN3LhEqw4azfPVe01BgUMMWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Eyme87Wa; arc=fail smtp.client-ip=52.101.48.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIpHPgVFvaUVgv6d0lspavzwX5QTuhkNSkk+XC8v7YIoRrbgXo2j5RVNx7MAGro+FPDvrKDinViF0UNTb/OSena5hdUpfpRO6vnIakszEJVTQoNckn1cOi6X1+ZcKx7CKF4Eq0i1Ju759zg2e4aNbPJ7TEK4uJLK0DNYsrabw3fImf0/RN8h6fMZIY3bZI0lTSMZTr9LUk8wjM1zVLA8yL93wfdBbIUeC3Tt64LiD3OzGGH6LYgjMHxkUM4euAXxSBei5+UMcxJL2PAEj8emFqcs5ouXJDrX8iLd0LR6I63R8XeUisLkHeACndCaGsQDZs4l8U7fAwWQuqV8i6t/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkIxcFL5ZLnSwB2F9Qj7KV6LhZiNrfPECfGV1ApCUg8=;
 b=VuLgFN9xSd9ZjIxLupkO2RkBqyPVV4uo5F/P10KqrrMzARYinsTAOgmAaTRnRKQtnUhGmJAFse8oylO3hZGk0kD/koFmp6ytGok+JFiVVG0dx3m3e6HdMbQSmNRjAtq8mHO/yAHts50SrGnmsjZNcOPtvdCqJ+6Tqh4VyyU5C18vfgnmzWAloWjIDbh8R1AbsR066j3ZVIxDJBJhofm/NHc7KsAycyoRNJy/IkIIcKsL9HHrLmIyFZ63fuAH/7SKwobVo0rt8MAb8c0vdcKinqBTCL90vJjIXvJ9plIB7X3mAPi8mHS0q1wGrDb2WsKdDD3JeUPDHTf5gogWJ2mwYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkIxcFL5ZLnSwB2F9Qj7KV6LhZiNrfPECfGV1ApCUg8=;
 b=Eyme87Wav15QDxtgU9+YZI6a6KQXLQimRTTCom0tNyCaQKm7pqX9Os0zCJSKe21OXfGGjrUaO0N1WmesNOavmtGbYJSHYfIpXIlh94qxpHEG7COAnTED0w6vabZJTX+5OTH6/f/K8Lt6o7s3jGc2jknCP/hJPmLt29Db5S1Q2vy1TPxEE+Suj2F7Hyy50KPkhzgEi3VZOdXVh3HSYDx+SRs6twN/z2ESnZQ715eD1oqH9VyPa57bl/oeNUkGHZg0rBBEmUpB4J+xZGTyQegCtewJwwR6LHL1aRv0nLSZfcBVguswyXiQ/MQYvkrZuQEZF22qo6PhlbKvcBI9XPRYWw==
Received: from CH5P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::14)
 by IA0PR12MB7602.namprd12.prod.outlook.com (2603:10b6:208:43a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 16:38:37 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::56) by CH5P220CA0010.outlook.office365.com
 (2603:10b6:610:1ef::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.27 via Frontend Transport; Fri,
 27 Feb 2026 16:38:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 16:38:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 08:38:21 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 08:38:16 -0800
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
 <20260225150648.1542206-6-ioana.ciornei@nxp.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 5/5] selftests: drivers: hw: add tests for the
 ethtool standard counters
Date: Fri, 27 Feb 2026 16:45:47 +0100
In-Reply-To: <20260225150648.1542206-6-ioana.ciornei@nxp.com>
Message-ID: <87fr6mf8gb.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|IA0PR12MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 436e3ede-a82b-43d5-89cb-08de761ea813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	ZAsTJbbS1vaROkQCtxJ+ppMGxVoP9bH1h6bM3kwasCBiVHZPjZTjBh+CzIJJvuv703ZxcZvcCI/GRXpad3ThrZd9bZa122pXXueOa7mXSFamM8MFlRZuUapDWwLg2reZMr3MKYNLroT3GLH/9q6xPEtlhyuzqZSnQGThDkuHhBYIKfIaNU73Hd7VjMEYHOOg4DUWQUC6Rx3cKgfX8VnbV6KFFWZwSAFSjLzFaAM92mIZOD9qE+2+s2C/VXsaIHpZFpqfmIc6tn39+XH5py0wcVB7YscjV9weBbg7u6Acnb4OQJ6RC+XeCi7K4SdD3GY6Xk49aL15Fa2HZSF6UqeI7oiBOjR2zFKVJCaAyyP/CDi59Ed7S0IJO2iZSLOQC8FoNfqEaGDJSZS4ncPpYtWoIvRE9hCi9ds4wxx+f2/86QGUVhRAvJAl/VpHq3/ged2Fvw1Tpcj1/WbXYu7Q+f7bh9FfisV3N9dyWDvAdVL2O6os4mSAZ6YuK5+Do/bD5mdLDMy7YAs7zrb5awqkCWP4qKLxTz4NmNUaFpa6ryooAMayilDyC2icTVZJBXj3MR7Fq+J2maO1VaLsRRUqu0wZ2XIJAgAPRDM6K+7lP4SDmoFB85KFgX/np7y2GKcPINlDbVV6qLGZWfMuycL6wDh6zZzISRevByoj/LD1LQWkdi7Ece1DK0tigMYREn3Ub4MfTD7/C/gh2ii/E7cBhw9mJl28nB591PqdsDVcKlFf94t5qo7jnTAcCFLkJDlzVHN7wHrajE/UTjVsKBP5cfbUCRo+WYw9ALhb+S7B9knnDSB8bu7WY/Z6vjLMMMEx3acE7Oxj++cKwOuGeSWLTDV85A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+FbDoe8K0Ov25P6QzbkMsdbzEHc/tWkjkY77gcawMDUoj2pAT79i1fcYffWU33hG6yct+hWY5q737+pZ6fv00eqeBVVNtHVdCGP9jcfTVr8PuFnsaVtC4cuR/TDte2+e3F5I63wK6R99j6wMR2z4JDrXpAS2ndnqzwbTPSdjCa/ByxYN3RTfVVrDp4mcFDhpbnmTuJAGze6FmPYNOeQWwpZvyJj2AaVgssGIZ8XwYNjlY278+dCAl789DkDIvoXfu0feb0ZaUczWt8QXjDBw9j/D+Y6bb1W7yFZoTjEOPmOpzGfGV0oMLk83U+WTsMFKlxM/VwLv3EsjGDmbJ+KGY/rZFxaxLCLuqxPxXqTI6m86Ee+oofkNVEYu4ek5vjDLd+K/5Q06Bw438aVzv844cmLfSc9pLtSsI7gxqmOyO+OgWH42dEbdjVtn4vI2QgKk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:38:37.2547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 436e3ede-a82b-43d5-89cb-08de761ea813
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7602
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261916-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ethtool_extended_state.sh:url,ethtool_rmon.sh:url,ethtool_mm.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hw_stats_l3_gre.sh:url,nvidia.com:mid,Nvidia.com:dkim,nxp.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 035751BAE32
X-Rspamd-Action: no action


Ioana Ciornei <ioana.ciornei@nxp.com> writes:

> Add a new selftest - ethtool_std_stats.sh - which validates the
> eth-ctrl, eth-mac and pause standard statistics exported by an
> interface. Not all counters can be validated in software, especially
> those that are keeping track of errors. Counters such as
> SingleCollisionFrames, FrameCheckSequenceErrors etc are not tested nor
> included in this new selftest.
>
> The central part of this patch is the traffic_test() function which
> gathers the 'before' counter values, sends a batch of traffic and then
> interrogates again the same counters in order to determine if the delta
> is on target. The function receives an array through which the caller
> can request what counters to be interrogated and, for each of them, what
> is their target delta value.
>
> The output from this selftest looks as follows on a LX2160ARDB board:
>
> $ ./ethtool_std_stats.sh eth0 eth1
> TEST: eth-ctrl tx on eth0 (MACControlFramesTransmitted on eth0)     [ OK ]
> TEST: eth-ctrl tx on eth0 (MACControlFramesReceived on eth1)        [ OK ]
> TEST: eth-ctrl tx on eth1 (MACControlFramesTransmitted on eth1)     [ OK ]
> TEST: eth-ctrl tx on eth1 (MACControlFramesReceived on eth0)        [ OK ]
> TEST: eth-mac bcast tx on eth0 (BroadcastFramesXmittedOK on eth0)   [ OK ]
> TEST: eth-mac bcast tx on eth0 (FramesTransmittedOK on eth0)        [ OK ]
> TEST: eth-mac bcast tx on eth0 (OctetsTransmittedOK on eth0)        [ OK ]
> TEST: eth-mac bcast tx on eth0 (MulticastFramesXmittedOK on eth0)   [ OK ]
> TEST: eth-mac bcast tx on eth0 (BroadcastFramesReceivedOK on eth1)  [ OK ]
> TEST: eth-mac bcast tx on eth0 (FramesReceivedOK on eth1)           [ OK ]
> TEST: eth-mac bcast tx on eth0 (OctetsReceivedOK on eth1)           [ OK ]
> TEST: eth-mac bcast tx on eth0 (MulticastFramesReceivedOK on eth1)  [ OK ]
> TEST: eth-mac mcast tx on eth0 (BroadcastFramesXmittedOK on eth0)   [ OK ]
> TEST: eth-mac mcast tx on eth0 (FramesTransmittedOK on eth0)        [ OK ]
> TEST: eth-mac mcast tx on eth0 (OctetsTransmittedOK on eth0)        [ OK ]
> TEST: eth-mac mcast tx on eth0 (MulticastFramesXmittedOK on eth0)   [ OK ]
> TEST: eth-mac mcast tx on eth0 (BroadcastFramesReceivedOK on eth1)  [ OK ]
> TEST: eth-mac mcast tx on eth0 (FramesReceivedOK on eth1)           [ OK ]
> TEST: eth-mac mcast tx on eth0 (OctetsReceivedOK on eth1)           [ OK ]
> TEST: eth-mac mcast tx on eth0 (MulticastFramesReceivedOK on eth1)  [ OK ]
> TEST: eth-mac ucast tx on eth0 (BroadcastFramesXmittedOK on eth0)   [ OK ]
> TEST: eth-mac ucast tx on eth0 (FramesTransmittedOK on eth0)        [ OK ]
> TEST: eth-mac ucast tx on eth0 (OctetsTransmittedOK on eth0)        [ OK ]
> TEST: eth-mac ucast tx on eth0 (MulticastFramesXmittedOK on eth0)   [ OK ]
> TEST: eth-mac ucast tx on eth0 (BroadcastFramesReceivedOK on eth1)  [ OK ]
> TEST: eth-mac ucast tx on eth0 (FramesReceivedOK on eth1)           [ OK ]
> TEST: eth-mac ucast tx on eth0 (OctetsReceivedOK on eth1)           [ OK ]
> TEST: eth-mac ucast tx on eth0 (MulticastFramesReceivedOK on eth1)  [ OK ]
> TEST: pause tx on eth0 (tx_pause_frames on eth0)                    [ OK ]
> TEST: pause tx on eth0 (rx_pause_frames on eth1)                    [ OK ]
> TEST: pause tx on eth1 (tx_pause_frames on eth1)                    [ OK ]
> TEST: pause tx on eth1 (rx_pause_frames on eth0)                    [ OK ]
>
> Please note that not all MACs are counting the software injected pause
> frames as real Tx pause. For example, on a LS1028ARDB the selftest
> output will reflect the fact that neither the ENETC MAC, nor the Felix
> switch MAC are able to detect Tx pause frames injected by software.
>
> $ ./ethtool_std_stats.sh eno0 swp0
> (...)
> TEST: Not all MACs detect injected pause frames                     [XFAIL]
> TEST: pause tx on eno0 (rx_pause_frames on swp0)                    [ OK ]
> TEST: Not all MACs detect injected pause frames                     [XFAIL]
> TEST: pause tx on swp0 (rx_pause_frames on eno0)                    [ OK ]
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  .../testing/selftests/drivers/net/hw/Makefile |   1 +
>  .../drivers/net/hw/ethtool_std_stats.sh       | 192 ++++++++++++++++++
>  2 files changed, 193 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh
>
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index a64140333a46..d447813a14b2 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -26,6 +26,7 @@ TEST_PROGS = \
>  	ethtool_extended_state.sh \
>  	ethtool_mm.sh \
>  	ethtool_rmon.sh \
> +	ethtool_std_stats.sh \
>  	hw_stats_l3.sh \
>  	hw_stats_l3_gre.sh \
>  	iou-zcrx.py \
> diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh b/tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh
> new file mode 100755
> index 000000000000..4ce8f140a18c
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh
> @@ -0,0 +1,192 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#shellcheck disable=SC2034 # SC does not see the global variables
> +
> +ALL_TESTS="
> +	test_eth_ctrl_stats
> +	test_eth_mac_stats
> +	test_pause_stats
> +"
> +STABLE_MAC_ADDRS=yes
> +NUM_NETIFS=2
> +lib_dir=$(dirname "$0")
> +# shellcheck source=./../../../net/forwarding/lib.sh
> +source "$lib_dir"/../../../net/forwarding/lib.sh
> +
> +traffic_test()
> +{
> +	local iface=$1; shift
> +	local neigh=$1; shift
> +	local num_tx=$1; shift
> +	local pkt_format="$1"; shift
> +	local title="$1"; shift
> +	declare -a counters=( "${@:2:$1}" ); shift "$(( $1 + 1 ))"

Please make this local -a. declare inside a function also introduces a
local variable, so the effect is the same, but using local is more
obvious.

BTW, just a suggestion, personally I'd just make the counters a pure
"rest" argument:

	local -a counters=("$@")

simply because functions usually don't need more than one, and it's
easier to use on call site, and easier to understand what's going on.

> +	local before after delta target_high extra
> +	local int grp counter target unit
> +	local num_rx=$((num_tx * 2))
> +	local xfail_message
> +	local src="aggregate"

And local i.

> +
> +	for i in "${!counters[@]}"; do
> +		read -r int grp counter target unit xfail_message <<< "${counters[$i]}"
> +		before[i]=$(ethtool_std_stats_get "$int" "$grp" "$counter" "$src")
> +	done
> +
> +	# shellcheck disable=SC2086 # needs split options
> +	$MZ "$iface" -q -c "$num_tx" $pkt_format
> +
> +	# shellcheck disable=SC2086 # needs split options
> +	$MZ "$neigh" -q -c "$num_rx" $pkt_format
> +
> +	for i in "${!counters[@]}"; do

There should be a RET=0 here, so that the check_err below gets a clean slate.

> +		read -r int grp counter target unit xfail_message<<< "${counters[$i]}"
> +
> +		after[i]=$(ethtool_std_stats_get "$int" "$grp" "$counter" "$src")
> +		if [[ "${after[$i]}" == "null" ]]; then
> +			log_test_skip "$int does not support $grp-$counter"
> +			continue;
> +		fi
> +
> +		delta=$((after[i] - before[i]))
> +
> +		# Allow an extra 1% tolerance for random packets sent by the stack
> +		extra=$((num_pkts * unit / 100))
> +		target_high=$((target + extra))
> +
> +		RET=0
> +		[ "$delta" -ge "$target" ] && [ "$delta" -le "$target_high" ]
> +		err="$?"
> +		if [[ $err != 0  ]] && [[ -n $xfail_message ]]; then
> +			log_test_xfail "$xfail_message"

I think this should mention the $title as well. I think that the
xfail_message could be the log_test's opt_str, so:

                        log_test_xfail "$title" "$xfail_message"

A bit annoying that log_test_xfail clears the retmsg. It does so so that
messages from previous runs do not show up, which is desirable in
general, but here it would be handy.

> +			continue;
> +		fi
> +		check_err "$err" "$grp-$counter is not valid on $int (expected $target, got $delta)"
> +		log_test "$title" "$counter on $int"
> +	done
> +}
> +
> +test_eth_ctrl_stats()
> +{
> +	local pkt_format="-a own -b bcast 88:08 -p 64"
> +	local num_pkts=1000
> +	local counters

local -a

(Though yeah, bash doesn't care.)

> +
> +	counters=("$h1 eth-ctrl MACControlFramesTransmitted $num_pkts 1"
> +		  "$h2 eth-ctrl MACControlFramesReceived $num_pkts 1")
> +	traffic_test "$h1" "$h2" "$num_pkts" "$pkt_format" \
> +		"eth-ctrl tx on $h1" \
> +		"${#counters[@]}" "${counters[@]}"
> +
> +	counters=("$h2 eth-ctrl MACControlFramesTransmitted $num_pkts 1"
> +		  "$h1 eth-ctrl MACControlFramesReceived $num_pkts 1")
> +	traffic_test "$h2" "$h1" "$num_pkts" "$pkt_format" \
> +		"eth-ctrl tx on $h2" \
> +		"${#counters[@]}" "${counters[@]}"
> +}
> +
> +test_eth_mac_stats()
> +{
> +	local pkt_size=100
> +	local pkt_size_fcs=$((pkt_size + 4))
> +	local bcast_pkt_format="-a own -b bcast -p $pkt_size"
> +	local mcast_pkt_format="-a own -b -b 01:00:5E:00:00:01 -p $pkt_size"
> +	local ucast_pkt_format="-a own -b $h2_mac -p $pkt_size"
> +	local num_pkts=2000
> +	local octets=$((pkt_size_fcs * num_pkts))
> +	local counters

local -a

> +
> +	counters=("$h1 eth-mac BroadcastFramesXmittedOK $num_pkts 1"
> +		  "$h1 eth-mac FramesTransmittedOK $num_pkts 1"
> +		  "$h1 eth-mac OctetsTransmittedOK $octets $pkt_size_fcs"
> +		  "$h1 eth-mac MulticastFramesXmittedOK 0 1"
> +		  "$h2 eth-mac BroadcastFramesReceivedOK $num_pkts 1"
> +		  "$h2 eth-mac FramesReceivedOK $num_pkts 1"
> +		  "$h2 eth-mac OctetsReceivedOK $octets $pkt_size_fcs"
> +		  "$h2 eth-mac MulticastFramesReceivedOK 0 1")
> +	traffic_test "$h1" "$h2" "$num_pkts" "$bcast_pkt_format" \
> +		"eth-mac bcast tx on $h1" \
> +		"${#counters[@]}" "${counters[@]}"
> +
> +	counters=("$h1 eth-mac BroadcastFramesXmittedOK 0 1"
> +		  "$h1 eth-mac FramesTransmittedOK $num_pkts 1"
> +		  "$h1 eth-mac OctetsTransmittedOK $octets $pkt_size_fcs"
> +		  "$h1 eth-mac MulticastFramesXmittedOK $num_pkts 1"
> +		  "$h2 eth-mac BroadcastFramesReceivedOK 0 1"
> +		  "$h2 eth-mac FramesReceivedOK $num_pkts 1"
> +		  "$h2 eth-mac OctetsReceivedOK $octets $pkt_size_fcs"
> +		  "$h2 eth-mac MulticastFramesReceivedOK $num_pkts 1")
> +	traffic_test "$h1" "$h2" "$num_pkts" "$mcast_pkt_format" \
> +		"eth-mac mcast tx on $h1" \
> +		"${#counters[@]}" "${counters[@]}"
> +
> +	counters=("$h1 eth-mac BroadcastFramesXmittedOK 0 1"
> +		  "$h1 eth-mac FramesTransmittedOK $num_pkts 1"
> +		  "$h1 eth-mac OctetsTransmittedOK $octets $pkt_size_fcs"
> +		  "$h1 eth-mac MulticastFramesXmittedOK 0 1"
> +		  "$h2 eth-mac BroadcastFramesReceivedOK 0 1"
> +		  "$h2 eth-mac FramesReceivedOK $num_pkts 1"
> +		  "$h2 eth-mac OctetsReceivedOK $octets $pkt_size_fcs"
> +		  "$h2 eth-mac MulticastFramesReceivedOK 0 1")
> +	traffic_test "$h1" "$h2" "$num_pkts" "$ucast_pkt_format" \
> +		"eth-mac ucast tx on $h1" \
> +		"${#counters[@]}" "${counters[@]}"
> +}
> +
> +test_pause_stats()
> +{
> +	local pkt_format="-a own -b 01:80:c2:00:00:01 88:08:00:01:00:01"
> +	local xfail_message="Not all MACs detect injected pause frames"
> +	local num_pkts=2000
> +	local counters i

counters should be declared local -a

> +
> +	# Check that there is pause frame support
> +	for ((i = 1; i <= NUM_NETIFS; ++i)); do
> +		if ! ethtool -I --json -a "${NETIFS[p$i]}" > /dev/null 2>&1; then
> +			log_test_skip "No support for pause frames, skip tests"
> +			exit
> +		fi
> +	done
> +
> +	counters=("$h1 pause tx_pause_frames $num_pkts 1 $xfail_message"
> +		  "$h2 pause rx_pause_frames $num_pkts 1")
> +	traffic_test "$h1" "$h2" "$num_pkts" "$pkt_format" \
> +		"pause tx on $h1" \
> +		"${#counters[@]}" "${counters[@]}"
> +
> +	counters=("$h2 pause tx_pause_frames $num_pkts 1 $xfail_message"
> +		  "$h1 pause rx_pause_frames $num_pkts 1")
> +	traffic_test "$h2" "$h1" "$num_pkts" "$pkt_format" \
> +		"pause tx on $h2" \
> +		"${#counters[@]}" "${counters[@]}"
> +}
> +
> +setup_prepare()
> +{
> +	h1=${NETIFS[p1]}
> +	h2=${NETIFS[p2]}
> +
> +	h2_mac=$(mac_get "$h2")
> +
> +	for iface in $h1 $h2; do

These should be quoted.
iface should be local.

> +		ip link set dev "$iface" up

Plesae use defer:

		ip link set dev "$iface" up
		defer ip link set dev "$iface" down

Then drop the hand-rolled cleanup() altogether. Retain the "trap cleanup
EXIT" -- it will pick up forwarding/lib.sh's cleanup(), which calls
pre_cleanup and defer_scopes_cleanup().

> +	done
> +}
> +
> +cleanup()
> +{
> +	pre_cleanup
> +
> +	for iface in $h2 $h1; do
> +		ip link set dev "$iface" down
> +	done
> +}
> +
> +check_ethtool_counter_group_support
> +trap cleanup EXIT
> +
> +setup_prepare
> +setup_wait
> +
> +tests_run
> +
> +exit "$EXIT_STATUS"


