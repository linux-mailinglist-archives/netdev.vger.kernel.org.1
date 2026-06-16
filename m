Return-Path: <netdev+bounces-299815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ic+VKhovMWrpdQUAu9opvQ
	(envelope-from <netdev+bounces-299815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:10:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEF168EA9B
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:10:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=SuKwIqZa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299815-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299815-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 851A23072F5E
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44081436356;
	Tue, 16 Jun 2026 11:07:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9DA42DFF2
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 11:07:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608053; cv=fail; b=drYtv8Bx29D1plPXLoExPyOJA/bK6LeMleFguW+30XLk58+mgJfoXwyfWASSwKy00mdRnewVyG6rAXHFwtOPttTB9BomywjyZjLwRcXaYQ9XekvbtLdBt46/IUvp5+K7QuhVnUbYvtA7nw6G8Sgeve5wpAsLZVFfdrlbpIZ5Y8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608053; c=relaxed/simple;
	bh=767LsbrA8JZstc3YLCw2CsSA2/wep8CxwhBpBf0x0fc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PLSpvADIzsvIFsbrcZL+TmUPVNhjbnubjD6AcGAeNBYLCeFoCGNT2MRGIVEPY7Wqy30t363YdUIlrDXAKTWX7frPJPzVMd9OnyWGICo85DlNJcL0DZ86fzqmYaVwC61lnB/y31W3BqB5mk396V+ND8hxLuZakYzA+B7xbgQr85g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SuKwIqZa; arc=fail smtp.client-ip=52.101.52.19
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duioQWDlg2QCj63UmEKFSBRaG7gSzYeiHIXBenz1/dTPdGBe852wF/LF9mPvCR1ulMhVM8blHCXsL7DIEZKSelDrHAajSW4DI3uno1jucQhjnzZlE0qu0B19sLpVYvLaDNipnW1foTvSyFtMiTneOl8ae2TibUivkzPN4pXR836PVKUw+YRV0yEZHQHgkXtYLNc4bsc5t5gfF+996crsPqi/t8mIz0Ahx8PRsbIMS1b4XURtjEOFEkPMJS9UelUmgBksUyd+oXOzhDrVzZ5A5+fJsoPOwyvMpj9vGfYWC+VbM8k6mLDHM9hby4KC6VpOXxIltFJNkO4Fqby79R3Obg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TX09bX0MoAAYY/wg4iz+5/kMDGHAS+TwBvKiEOu7i8U=;
 b=C8/qj0uaAHdS55xi1F0XBUKigp/5HX4SzW+z5f+4h2Z8d7yprODThiP8KaqlQKp7bO49DBA0XLTs17DAJE6OkP2n8Wz/8ooPlX8/AonfDUtpiTNJUH6qjMdU4TD6GnSm204miwXMHGHtYlkqOrDFJQFprSH9IFUFqn5hTMs+ZBST14pTS0AIrodQ8X4TaCi6mrWQxseX4G0GEsN5pRxSwXE5YT6GD0imVlI/8FEIEeLtiWCOXf7nFOhnILVEPB+vRkrc+EOV5APUFHe24Gv55FcRwISmQCjozIJK2QXv70MMRT1uJ+gHiNOONKSil7KRN7VGeZPOGJOf9zi/rumOlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TX09bX0MoAAYY/wg4iz+5/kMDGHAS+TwBvKiEOu7i8U=;
 b=SuKwIqZaNvApkIGxExTIRC0zOoDSbCmjxYWScPKHAhOPGyHO72PORxfs0ty1g7aZE/ly+uCpttVdVnvsi0p+OLc2LP39a3JHQfPU1XpEMmLvotZdzaUnVQaVwycAyQvwho1wvjjz6dKC65/fVmZ3gdP8cf6nBCDK3d2mVwBy8PFQ4pAC7B8TY9lXPKXSH2+yPzrTVAVoVTt/atKcKEdfQrvR/DC/TtN2gVHBm7XzDviF/xJzQ4imcyA9f5apC+Wp9BRkNs5n0ZNbyN4HJGqxKOvMDTarkAcQlJQvZqbKikHtX2PEwCyI19slvzpWxIjiRUdVYBIDV3Hhu9VBc/gb2w==
Received: from BL1P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::31)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 11:07:25 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::41) by BL1P223CA0026.outlook.office365.com
 (2603:10b6:208:2c4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 11:07:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 11:07:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Jun
 2026 04:07:07 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 16 Jun 2026 04:07:04 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Michal
 Wilczynski <michal.wilczynski@intel.com>, Carolina Jubran
	<cjubran@nvidia.com>, "Cosmin Ratiu" <cratiu@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 0/2] devlink: Fix a couple parent ref leaks
Date: Tue, 16 Jun 2026 14:06:31 +0300
Message-ID: <20260616110633.1449432-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CH2PR12MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: 206c5e52-478c-4ce1-0f7d-08decb97725c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	HLhDLlIsEjj2dCPAgMurhOTrg6IGLEY88ImPS1SxaR3eeURiCWTFFr9IUzj7oR/znZsKfr4dTRj+HSCKRfIUG+a9ih0HEbZTHXMOWjqYgYclfrJnRAJAMsDixh0fZfUdMPf8qtBA6V2LAYer3syOGfneJxBPAm5ZPJePebY8EoZb57KLuDirJ3MOpkvS4r8tfPm9TBI6ub3vGAB53Hydhi9soTHu/Nm/2uOGcNvkBarbI+eDRViCFm9g8b5Fj8hjRuxSUZexZo205bHQJgKtNM6UQ5ywSvAiET71jB7BHZtFp0GcjAjkrPSP3+HCamoLfPVkNzlN+oI0ptsBhbMJHmrF594cI3DV/ZZnSxGFMPE08nahfNiJFS38taM64kMAFiZ5XJmeD3fO65jV4WfvmkhcmeJ7ZeGzT77pzR9sOJXkQD3U4Q00IOrxZwGEQj+nT1sEVy4YCJbCmBhGJDUdti6h2UhJU1lNQmJItMmzlgjBL414PnT3MVP16JWmTaTR9qTD8boSFNTA6xhF5xqQEmOirYwTCH9TK76c67skanaD7AHOVlu4pP84gY8+pzHG3E/myxupIohTPI81aO4uqKJcCNDKQ2MzEVXEtXRdv9MHbjiO7QOWBHaX9aTSlmKc8Ov1sCFb/6vNMJdMpBD7ftwt3QzeZayJ6rmi3puE7caNIJmkzp9a3qoGPClPX+vSvJXf0h3vILidhf/zYWDp2/5qsZW26R3nRVsAlKBaQX4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1Ul/DHBxddnqhFb8Qucfx8nYPojK71tAFitsNPGFv+bYPXdwXtgUlf9EALbTc/n668F3mV9BAhjVbww8BhLHq6+j1ShN0cim6FeCAXGo4vb6cjDu+9Sit4flRY+Umu+XDNt//S2MFSMFKAup/eXTeFpWKM5UCunKmdGjZvTBj3YjNvqRf/RQrCRf2ARXSLeBEAA2xfqp2jva36hC2DDjW453P+Q8bLg8vWsmQZmyY7PFrYOCQkBEWqcVTWJ1hoMXjYQLz+TIIzagFEx1BdHCyOilfqR1me2v/P+35MEc0yedFbvZ69/GazJFVKrrqD9LEu3YCRsDo+q4Hn6ws9iqEGyJaPCAOnGtSZSdGKJYR9SPxlOoFgQgAPNY3lObAels380JEeRDcLPWPTQkInrw8oX6V9vLBp0O7hV6u2HVUKLlSqOMJ5DOha6p9Zb3TjdS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 11:07:25.0488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 206c5e52-478c-4ce1-0f7d-08decb97725c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-299815-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:michal.wilczynski@intel.com,m:cjubran@nvidia.com,m:cratiu@nvidia.com,m:mbloch@nvidia.com,m:tariqt@nvidia.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFEF168EA9B

These two patches fix parent ref leaks on errors.

Cosmin Ratiu (2):
  devlink: Fix parent ref leak in devl_rate_node_create()
  devlink: Fix parent ref leak on tc-bw failure

 net/devlink/rate.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

-- 
2.53.0


