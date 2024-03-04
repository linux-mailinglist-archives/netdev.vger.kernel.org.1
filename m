Return-Path: <netdev+bounces-77030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB6C86FE25
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 10:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35FD1F24206
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 09:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8572208A;
	Mon,  4 Mar 2024 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jVuH4MvS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A621B801
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 09:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546221; cv=fail; b=XiZ71nXslW+nPqYooNFpUIqbYRJ64T3QgBS36gdPsfaCgu6klu6h0V8BEGN8huloMciTWw2UlxGC2TLyx0rwnBgic8DPEGZUA26josW05TeHmHJweiR4dqlWhuMujx6qD9VTkWV8HIXJQfa6HuDe8aY5WurJgbWHeKaJfurJDGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546221; c=relaxed/simple;
	bh=AniAQWqbqpziiy90niHZOosA1A/D8ru500tG6S+e7NQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YtDbXQD/Ft7NgfY8zTiIz6PyMY9YiW8lSd+a1xmdXwyAVO22VI86twcFmFrFqLNzUZ4HF4UvfFBcIUAfw1btNIX4cPJ2fiuc23lns2JXOkG034M5JmZemMOXTBdMLKnTzPbsQcRU/T2G7JDz0v+dSHMc2flXZOV4OhbsM1Tfb6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jVuH4MvS; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKYd3UprBKXsWL4QWS0QRGc8fyM8xxv7ILA7CqPm/oc0DHUrEI3b4Agexrdq8AMoJF6ZCyaOsRxfAozXzzjxdiSApiPVwgPc/iB0NGjxD/nMJkhYZU0KaRyPfvGXB/zD5GbPtDfwcKp/BR8oCgO2Hxh4EYh6Y5vJZN40NOTl3TgpWOLsszKJaiOdDNFZMLjOg/KlSBQy90l8j72/w3j0kQgZsh6yjU5OMqEQkkj7zoGtPLrwPDb16xi3Dd4NXgPd6PS7jkKVSCgAyw4QFL3rd6NUji+JGo0SDxIVtyBAwLgiBts0cmgjUtM8hF7AUQq2G+dF+xXjbmbAJhyRSKfzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7bZGYvmdil7fl17Ty+LllLjZ/MplrRgT0mSY8elidw=;
 b=csG2UseHWWqdQJ1GwO4oOQUSo6KBTcxX37nqrR3NZ46jOdFgWI725rhW4n42ZD/cTRrSkL2RvWO1qrCWAliLPBAYMJUl1Zz+NprM1yqltGK+ee5J81SSJLllNYdfvZHx5CFmDKWBUSpCPaE+gsERDKYTCGgkBKDvE4+3WFIJ541+zJZXKI/X0GB4X+2nPpjz2CfEsPXV+NJotVOnF2YCRs03QFfVmQ0CHoqhmI4dyQmdy2VNd+tJM1IQbDE5qxbrNCX+o1Sk2mEALZ8XFzS9XXDv9q9R+ql0bewnVhMmkPU0ELZMsaxZTOSiz2FJnFRfsUYKHodvt+KYa65HyIiBQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7bZGYvmdil7fl17Ty+LllLjZ/MplrRgT0mSY8elidw=;
 b=jVuH4MvSV/012p1N4+ReetNoC7wECDCb0IQVL2sNze6ZH+7ADACRaeaeLMZO0QoDd0p5izgGIgPka6zeawn1Bukz4viKwMFtZT8X0FAQcv669/xEqO/oLQrgvypAA9fwNicl3ZGHtG+NyNt3CFot4BRfA3C1Y1w5fB/r8u6Hv1BqypRNKMkeNtI+3Pq+vPePYKzc61bAzogOlJ2tPFc7/SUlfXtgykm9VbZILZenGFgFM2R+ISOPvyeenlAdG+oGsUTaMQOTx8nb2+vxHf98JJFPODnlNNC6Ukw1NWHMVUZsB7BjHgUpw8CoF35+Q981xlZMp/10qJM1L3+FrxGODw==
Received: from BN0PR07CA0010.namprd07.prod.outlook.com (2603:10b6:408:141::10)
 by CH3PR12MB8548.namprd12.prod.outlook.com (2603:10b6:610:165::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 09:56:56 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:141:cafe::f8) by BN0PR07CA0010.outlook.office365.com
 (2603:10b6:408:141::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38 via Frontend
 Transport; Mon, 4 Mar 2024 09:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 09:56:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Mar 2024
 01:56:44 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 4 Mar 2024 01:56:41 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <bpoirier@nvidia.com>,
	<shuah@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 0/6] selftests: forwarding: Various improvements
Date: Mon, 4 Mar 2024 11:56:06 +0200
Message-ID: <20240304095612.462900-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|CH3PR12MB8548:EE_
X-MS-Office365-Filtering-Correlation-Id: f65f160d-68f9-4ecb-a264-08dc3c316d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FR2fbG251C0pyu663EY8zXYlPpu9X8qFPE4EIZsRzNXw/UTVjjwGBDwXPdgs14yq9Tlwm9BDHPrPPkHwSDcQsbR92XD93FDNasTRXjBHS5AAwEfa+x9JQ+WAQnbobpqy2eB670B6XE9yAqngAm8S2yc+7Fu1TalRTO/FlyHYK0JOHDO8G5C7PZmPxrO0iR1wKgvds6tyhCA9dbI5gQ4ttFV10GcO04bEA/fN1Y+7XcOYQSuqwfUBbzMtafl0O+BVqi3YN0w6LUZNoyjU1zD8zr28ZRgg0XXZ3e5XS5atTIiWfcgY1Iy/ieUF+RF9S4WhLzVK0xxr2xlY61go/Xv+x4Ou3MpExRr32NBFc4B4HlHTJo9swQm3MFS3KvZufWJFyzz+JUkROygHtjXTrEz6wE7T3kQ4eMil6y/cXSr/1dtt1rJDq5Hh847+bJfJuEA9dHagfcl6z29gfEI4sFaPAyn/4A5Pe70ibsplRImiRnopWT0ILaTdEL3jMUK9u31rwmhqPuuUuA0dGWk3gRSkwwn6Z/lwtCL0QZMhfBH6brVFfPrFGJlSQPaA1sfxvHInJhqmwN5R3pe0ODBJO3KlCvkNXygSxjba1+LDsuRsElD07KL4ui3Guytee7Xpo8wvAlNTKA8oAYOs0mIRPR8RJEi4IBMhvHR6rIe0ud6oJBu1TsaNFyKd86okMT/pZpj5Q7/Flb+MSA+7/ytzz8+xXZdNfR0/zU80R5ud/IJhJ7oxA4BoafL/XSXSBOjuIJaH
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 09:56:56.6496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f65f160d-68f9-4ecb-a264-08dc3c316d86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8548

This patchset speeds up the multipath tests (patches #1-#2) and makes
other tests more stable (patches #3-#6) so that they will not randomly
fail in the netdev CI.

On my system, after applying the first two patches, the run time of
gre_multipath_nh_res.sh is reduced by over 90%.

Ido Schimmel (6):
  selftests: forwarding: Remove IPv6 L3 multipath hash tests
  selftests: forwarding: Parametrize mausezahn delay
  selftests: forwarding: Make tc-police pass on debug kernels
  selftests: forwarding: Make vxlan-bridge-1q pass on debug kernels
  selftests: forwarding: Make VXLAN ECN encap tests more robust
  selftests: forwarding: Make {, ip6}gre-inner-v6-multipath tests more
    robust

 .../net/forwarding/custom_multipath_hash.sh   | 16 +++----
 .../net/forwarding/forwarding.config.sample   |  2 +
 .../forwarding/gre_custom_multipath_hash.sh   | 16 +++----
 .../net/forwarding/gre_inner_v4_multipath.sh  |  2 +-
 .../net/forwarding/gre_inner_v6_multipath.sh  |  6 +--
 .../selftests/net/forwarding/gre_multipath.sh |  2 +-
 .../net/forwarding/gre_multipath_nh.sh        | 41 +-----------------
 .../net/forwarding/gre_multipath_nh_res.sh    | 42 +-----------------
 .../ip6gre_custom_multipath_hash.sh           | 16 +++----
 .../forwarding/ip6gre_inner_v4_multipath.sh   |  2 +-
 .../forwarding/ip6gre_inner_v6_multipath.sh   |  6 +--
 .../selftests/net/forwarding/ip6gre_lib.sh    |  4 +-
 tools/testing/selftests/net/forwarding/lib.sh |  1 +
 .../net/forwarding/router_mpath_nh.sh         | 39 ++---------------
 .../net/forwarding/router_mpath_nh_res.sh     |  4 +-
 .../net/forwarding/router_multipath.sh        | 43 ++-----------------
 .../selftests/net/forwarding/tc_police.sh     | 16 +++----
 .../net/forwarding/vxlan_bridge_1d.sh         |  4 +-
 .../net/forwarding/vxlan_bridge_1d_ipv6.sh    |  4 +-
 .../net/forwarding/vxlan_bridge_1q.sh         | 10 ++---
 20 files changed, 67 insertions(+), 209 deletions(-)

-- 
2.43.0


