Return-Path: <netdev+bounces-285173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IN0mDslF/Gn9NgAAu9opvQ
	(envelope-from <netdev+bounces-285173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 09:56:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E44F4E44B6
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 09:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67B37301B4F6
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 07:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C558377017;
	Thu,  7 May 2026 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HWXCoBm1"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EDF33554F
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140613; cv=fail; b=pEr8M0EsYiMcc9Bqf5qi7n3qy+az5Ze5JBFE+QO2w78ollBO1nbC036hunHNYENsMebaHvYoPjSGT3m53hhQURa15X2kbVqdIP2YaaE4tacu26kIm/p92buqKwgoztrS02d7LonJEXZvbm3QW2saIsNg9vkNqreBg9l5aUR1dLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140613; c=relaxed/simple;
	bh=sO1oDD9wda4ah6QhJdl02EziCRFSYju59cVngU07EVg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ugZWbta2syN2CnyRMb4haTHjxv7lNpjKu+t9KXmRdxlPKkk7Krnk3aHc0RTWjS2JkLs8LfW/C+rrfeeqKyTNGtEX+F7Fjol4otG8yEZBwfsXX7hX5bMhwITukusU0wJtoap3+dhuF5EQXZRISjRERoBi4pAGxY/pA8hiITCjELU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HWXCoBm1; arc=fail smtp.client-ip=52.101.52.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=of0I1vMMfZLyAN9K26WzUN400xuylIN6koS85XN04TlHVT7hJmxideGezpI31Z4UQ1ns5S9MDLSRaiH0ccU+P9k3Fb28luAarOADjDxoeQ8kZHJqlk61Z/rcxSqmwnmWUzC+BKhCi8yEMX3q4VSYrg56gd7r/5DKKHLGd9GO7hxI1DpfPbXJfdau8KBYtb9dUhw02Tf9uj9yDkDH/d4IKYtJGKAEofrfx8rUTRlQNWPmqmjWPCm1MMQuqYUz/Zg1gqI7NnbVgVQ1fl6OfnlxpkewAx3Vgs14yxFbJelHCwgkuuuySHAMMMhgly3mPjJtFZIWoTZMWEQ4RrO6zA6qrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cM/TW2vEktCFSoZiaqshh+F/Iy+El/vJ9vdGDbJEP8U=;
 b=tSuPPR31azJu0oon0Iq4ZKwkOaTGRIN5HPb2FXe0SrbEI0xuXEv2zGp/kowvU5rQ6oImpLVF7eIwwDSCsyZIfF8uSolRntWq5KQuO3rqRm5vFPEvVOL7qCYGOtsgKSNmyYPJ7HYi3FUBb5E3DQNRdG+jh1W1hDWhhh1CG3fiEJRAwQCYhxcGldKIHPp/iQwJQ63ILemwD/K8WKAU5FqaxUqprq3VXEQQVEpmPz1Xy9FXILQ+n6BAxF3geMfH43UxJ5upM+0SpQ6dAhTFGlDYda+WhEQ8OEjzlN1S88iBoAShMJDaECgcbA7z3Sw/rtCrARopP/4HdpbnPM+uZUC5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM/TW2vEktCFSoZiaqshh+F/Iy+El/vJ9vdGDbJEP8U=;
 b=HWXCoBm1Ow1ZPbHo2M0PsmbcbWXmJhaIMB9ITRdaNLoGnSwIMze++4F1TZTUcixSbr6chx4WLH8/wxjsj36sZH2Z8XVRFGI1ATj0h1UTXUhB72UA/x/zWYnyUIiaT70tGQ6Tm9FUvDjyEccSegx7+SKo2T783ujL/uiLbz+DZUHz2Xnh+g0SHhANwhaMbgyvwPlun2f27tBPjKw9QHbXmniQ8qlqki6Y/ST6GPd2jMOx5xv2xQtpmGLlwnym9kulRIcmuZjyQqfV7gXoXMLCQVGcC/pphXzf5c1cnkQxhojOI2Nll8VvM8/dFM8NXsQAwZqxqKOB4ekive2Hf7uTAg==
Received: from BYAPR02CA0064.namprd02.prod.outlook.com (2603:10b6:a03:54::41)
 by SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 07:56:46 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::75) by BYAPR02CA0064.outlook.office365.com
 (2603:10b6:a03:54::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Thu,
 7 May 2026 07:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 07:56:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 00:56:31 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 7 May 2026 00:56:28 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Simon Horman <horms@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next v3 0/3] ipv4: Flush the FIB once on multiple nexthop removal
Date: Thu, 7 May 2026 10:56:03 +0300
Message-ID: <20260507075606.322405-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|SJ2PR12MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 7598d5e8-8922-4bfc-e46a-08deac0e3009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	W3pcodALHvGnNIUrTx3rbr6zEA0yn+TK/JgFEpH5Pp2VSl+/8UuEeBY1nrjfo7lnsuN+RyXCHdKNTG/UkfD2+e4o9Hr9RwQvZxHkSNiXcoTlBJrHbTNDje8uHn07C/3Q6CIThQXjGk8Bj7zdB1KYZMNxjI8v0YBSQcMREvLHtAldMJg7U4EQlD2WLjAEe9k63umGfT3XHfSYGjTkCaMnDRo7VbqgYKK8bmWlFLvkulnm0cMrXpmOgYjUDoZrMatJECtVWbCRBVXT5iDEC5z8nw0LYytcCFUiYbmxr3mIOgLQPbm5eitdO9APKGQCRupS0CZ6GFLrecbghbszJnpNLuaas1QDJUsBHY171MMK9LgQectDm+eXsVGBQS6hlI/LgwIrBNadnjxaK4xZSjEIeR7JNHLWPf76P3tvwqksorOIB0vpKP3IJ3L2KtXawNudFb5PxyCys04SPY5+rfgWJzBuzuv2hIEovvNc341NJF7BtIJc4bJBLjE29VRiYGS5INOcVQvP2qZXWv4b5KChdSZ+U0+xDsaruUBUjcfgRFMglD31vaJ/TzX5RDCjf/RceZ99FNHpzxFL2tVeHN+SlKui16Raw2eTDDFIqaPoJPaAN6Bxs7+dWMEHUdyZiJ9pEq/DjCtsWYU6CLbQo/H26NVAvunF/jgjdMNhZ2mmtofiOkFuUfi3BlVGV+w5S3KQhNENYPeipSxJ2sV08lUCGDFE2DKqReNQPQquXbfNrP4vnd5vaQboIhPO3qPDnNV8
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ho8sUIvwbr7tQKIMjewHUrAn5T0O4jFRvx3eOl/rfkIf1RE13P4ME3T0PeUrXoCkEizkrwW/2LjXaN0449DK8qAFbuCMFjdKOSJUKvFQYJyXKi+dRdf0zvm8zKwMz90fn7dL+sRMHrIrhaxg5tLbpxyn1ZglhXFNEYy55wq1xyCr01pAMlyZD7Qsy8oHfu7FSd2AF10OEcSeGE8D3DH2Zu+zHTX7Eq9sso6p16xqMkxTkVNiIzPXjyoA945IBbWrWuI/WGm7peF0pd7KfxQZENvcUJ53UW/+SfoKptU5wM4kytfQdSrtDs7xHvLV1cuNogqow3kWftVojt5MQgQv/7oAXcm3eh/GqpykPBwfxaoNLdan7qAgVWAXaDEDxrE2U6Lt8YgOKg3M098uFVr9qHZbT1SmBj+oax2S1EiKWC033foQzD2lcwjcoiaeAzjk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 07:56:46.8310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7598d5e8-8922-4bfc-e46a-08deac0e3009
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7917
X-Rspamd-Queue-Id: 9E44F4E44B6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285173-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

This series optimizes multiple nexthop removal performance from having
to do a FIB flush for each nexthop being removed to only doing a single
FIB flush after all nexthops are removed.

This dramatically improves performance in scenarios where there are
many nexthops and many ipv4 routes. Please see individual patches for
more details and for a test scenario.

V2 -> V3: https://lore.kernel.org/netdev/8fea4084-c9ec-472a-b8ab-ecc87e537216@kernel.org/T/#t
- Split the patch into 3 (Ido Schimmel, David Ahern)
- Used WARN_ON_ONCE instead of WARN_ON (Ido Schimmel)

V1 -> V2:
- Fixes xmas tree in a couple places (Kuniyuki Iwashima)
- Added __must_check to remove_nexthop_from_groups() (Kuniyuki Iwashima)

Cosmin Ratiu (3):
  ipv4: Provide a FIB flushing signal from nexthop removal functions
  ipv4: Flush the FIB once on multiple nexthop removal
  ipv4: Add __must_check to nexthop removal functions

 net/ipv4/nexthop.c | 88 +++++++++++++++++++++++++++++-----------------
 1 file changed, 56 insertions(+), 32 deletions(-)

-- 
2.53.0


