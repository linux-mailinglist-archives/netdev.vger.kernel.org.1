Return-Path: <netdev+bounces-288970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPW9F9ffCmqR8wQAu9opvQ
	(envelope-from <netdev+bounces-288970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:45:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3689569FFB
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D44530EF986
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105AF3E7BBE;
	Mon, 18 May 2026 09:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mhA8NNt4"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56C53E6DFF;
	Mon, 18 May 2026 09:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097065; cv=fail; b=hXYR87LRdchERo5waFSOLZSLrAss2iTV6kA076wPhf7vUzOqlqj4AYgr0VIb3BOaWev1Dt8eDDLSyz4wDEHdKh1EZ5Deaep6Y0t2j35CpesHAKVzSrqB9P7THChNEAncMAdP/SziXxV9z4PUmEgzJpUH/qkmCp7G3MDdr1/o+oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097065; c=relaxed/simple;
	bh=j3L3PAMpDwcWUKzWN9FESX9YmU0QEn1rVt+iFA+9IZA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BLCYtsBxl2ZCTLK4O771YxFUbiTEuhM7o7FWeggIgG34HuSQZSMEiahWvALrKkFMxyGXWGbp02/2rIaSpCUHAKP7cvOoDWW4XwwbJA27EyanUGbg4miR+BXd6Ty/NfySilvU08caRlvX4fUM48UHf8S2UkPRSEWXAsJqNpSVJfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mhA8NNt4; arc=fail smtp.client-ip=52.101.53.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVKsxiWxQl75GOHzmz4URIIKVgAlJ7J7FruvF7Sz1OEOWFhd38cH0ZxIwHPeIhvDyd1nFpolNJZ1RpLWsPjt6xulbHb1ttO/+1qhf/t3T/LlcGKjGml7d5E0sSiQR3jhtygXukztNNZcCY6nKA4y+DZgG+raWLSYvwFK/CKiSgHy4nXOTCeRO8MIs2wwXPjVAkPpYiRp+VDhaElwBj/s3GZTeIupb1sKkaSMOs3zUkz6ZE/G3n11pRkXbF8ElWvQD+szgBexzOecO8a+qUGuMoDjU+yjG0EsGLdBRoIyQ/gMMZrVlKYfHHv2ztOiyNubhu+2RzC30tIcAm9otR1KkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjg+ORjjHEhY4sxyQ7vMWaBvicT+IclMAv9a3iasPVQ=;
 b=FNxpBSPfoJyL3Vrb3ilKRpC0aTNXyaRJKvGZi16MDoa0g7ehOQ7nXCULk56xyum4Sh9lxSL2C9mExq7j2814nlxYH7H0HoARJN31Z1PHXEWVAP3E71Nztuun+zek009wsSNAiyU9Q72MH6xWr/SL/jg0HI16NviF+A9ct098hJlLaAz/NcaCJ2MqifROiucH5iNv0V75DeKVGmu33rimALOM326b3/dPjppSTZspq/4FAuHAtVrs7UUCYSU+A5CnPhkwA5ajrDz1tULirPYB/CxWFy8nnP/14HU5WsuE/tafaKacoVHnGVrlc1516gtyCcG9oQFW3YEofpT25+Lzgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjg+ORjjHEhY4sxyQ7vMWaBvicT+IclMAv9a3iasPVQ=;
 b=mhA8NNt4/kL7cdLkTIKopGPsoVV6CjY9++WDPTcN7fUK+KxNkI+aTsThmhFXx+3Nquv8la01bjNoB/rM4TJPxr+AEpA4ReCiF3y3I3eCBv6oajF5BR4N3a8Ql8VwfMPUeknnYn8X7WLVlSqNWm5I7i1Au7b8MzMSfDohCfxt4xzMyNx/GRrWMBinJKk85E+kIUXtVZW6/0a2PFWyl/+MSn5SMP6XPCgl+x3cWPHK8prd8tQBKkP7nXUWq6WgxIwTpanNBonIlf0XorY/spKolDwErKHMeoeXG6MWk+IvinMoKuPV86hqsWY0THzPNatdJYcCcPocgK1XR5PTjMlBlA==
Received: from BL1P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::19)
 by LV8PR12MB9270.namprd12.prod.outlook.com (2603:10b6:408:205::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 09:37:37 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::3) by BL1P223CA0014.outlook.office365.com
 (2603:10b6:208:2c4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 09:37:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 09:37:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 02:37:21 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 18 May 2026 02:37:16 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Simon Horman <horms@kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Petr Machata <petrm@nvidia.com>, Breno Leitao
	<leitao@debian.org>, Nimrod Oren <noren@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Willem de Bruijn <willemb@google.com>, Dimitri Daskalakis
	<dimitri.daskalakis1@gmail.com>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 0/3] selftests: Use a master ssh connection for remote commands
Date: Mon, 18 May 2026 12:36:50 +0300
Message-ID: <20260518093653.551166-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|LV8PR12MB9270:EE_
X-MS-Office365-Filtering-Correlation-Id: c19b8403-7df5-48e6-6662-08deb4c118ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|56012099003|18002099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	FW9fyCGZVkbmnlLIDuxcKnOVFjzZIDuZudePrVVfhUUKRRvxu/0cLKWQHUFw8tkdMXyELhDAXzhCUoSZuWF7yfZWPWMuI48wUFlfWEdT+5X4zQG0WorbqWGpswrfGU3VBiKR+vT2Wez4LqYSasTqkEh8u5J/ep01YwYj2y9fk5J1ZEAIk5/OwQw1VynH+Hfgs6Ip2rjqbyk5n2TMsFTPULi94HbCXYaPHe0RqaYl+XZuS3CjBXupdiZX8Lv13KdVBmxFN5MV5LvMyjYezKPbp/qm2UnbheL64fVKVwkgIkPGTn8ueNRXy9KQ8A00l70Iaz/RPXkeHzeY6aOjo+dZwYWYPGvwWjHMHolu1ObI6JHTJPCKFsqhIz4E4iNWKgpmYR3r3AdbEjUrTi4INKDybTD3lzo24hHsIQq1rrDrt5B+LqrHmBoHGeFgXyCy09CF0fWY99I0WNZNFoK28rI9c8dDFANw5Xzv/vKfV9+vHJMagFdZGYe7839ES9UhvVG3H95q5YH2Uugq+JwEi1DxC4Xj3Dnq0TEEclGQ6heSWDR10z85IeUXQUlxkHGjAiPoZ58OzCk2+hQEDRY4qLRelJPn+FgQRmTd41qXIdST72+vryT/B92PAOpMQ2L/RI8/NBdSD3+WpqAy7keMmJK/VHe0Cy9osfXZ1uw33KPorzPYSRA1ybnHSTrTidfFvWOF6Rq3eWFT0rDCGoSx9A+McoG5US9xB95xnM+1t/7U4Ns=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(56012099003)(18002099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Hx3GFmzqBmDTZd9zXJ5w1GXKJzsQd6jY7YDS/rJVAPGtN3/Q7y+wDcHEfRHJY+o1epPyBFOd+P4b9Tf+RJKDEqZ0isuo71QJ7esv5C/l36bMTZNS1SH9NG5D2FWWvpCMfOCQJlSA3nn2gKLKsYm/VX4EYDntei5VT8m+op3v4Ful3T4rx1IIdjvCwGeHA8ibeDQouPYWPVh6dz4SeUswqZpNG75XuFq3qRSoImIo6IcvoQSGjBFzad99jc2+0r5vT3UlY6FXpJhihb2WO39ywPZgy15ngpNFNuU2eERAoU3n5BYfYrM8BQAOIVyyEy3w6avBrP9fNNmXjpytZhaXCMqTyJ+T5GPEx32wZSb6gc6sUS8pyYFnm2p0pDuuM6m08g7miAY7exCk0RJuhUJytUQJXgvp/CABNyZR8ZiB0oOJ10TgcIb7kX7DNyji4L+k
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 09:37:36.7895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c19b8403-7df5-48e6-6662-08deb4c118ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9270
X-Rspamd-Queue-Id: D3689569FFB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,debian.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288970-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

This series switches selftests to run remote ssh commands over an ssh
master connection, significantly speeding up test execution in most
environments by avoiding the need to repeatedly authenticate.

The first patch fixes an issue with stdin inheritance, the 2nd patch
wraps some remote command executions in PTYs to avoid a termination
issue and the 3rd patch finally converts remote command execution to use
an ssh master connection. For details, please see individual patches.

Cosmin Ratiu (3):
  selftests: Disable stdin for remote commands over ssh
  selftests: Wrap remote command executions in PTYs
  selftests: Use a master ssh connection for remote commands

 .../drivers/net/lib/py/remote_netns.py        |  2 +-
 .../drivers/net/lib/py/remote_ssh.py          | 52 ++++++++++++++++---
 tools/testing/selftests/net/lib/py/utils.py   |  4 +-
 3 files changed, 50 insertions(+), 8 deletions(-)

-- 
2.53.0


