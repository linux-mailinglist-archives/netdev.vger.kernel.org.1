Return-Path: <netdev+bounces-89325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEE58AA096
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AE77B22328
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE75B172BBA;
	Thu, 18 Apr 2024 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B5JEBjiF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1542AF00
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459572; cv=fail; b=qLQpgqaskp/JL4GnRiDKFfwCGIzkoKSrnKYnUjFML2pCRLOzqkDPbPpH5GAdWXNZ4UOfDSODPemuR4/UxtxyoJ80E0R8w2GPaVCXlFSZFgdzC0FA96v8Gn4dgQ8bx/wpmOZIDEFlzSzpOUv1JXosGlY4K5cbkMR2UbpqT5+b8sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459572; c=relaxed/simple;
	bh=raQVhAUM7BywgYabyKkVRKPCnQWQ3ASUaA/O+drsEtk=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JUc9horlYW5fOekRbtOtsIVUuq4jkGHNgm4jFMbbQ5v3rQ3z5KlU/4d6Mqa+kzTqZiGEwW4Qe6gliNAb69tZ4gvswjRXJAt6LSC9gSzUsR6a6gzUCSLLR07+d+ysc4+zmGvIBQWn0vo1K+Ekr4jzDqg7yrRA+bqQJyH3qZC7OK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B5JEBjiF; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iN4LP+Ll8/LBC4n1jBHvZibSizEDr47VNNLUVzuuJH+PVt+Dae3+9AGT/lDIlvOCZS7VZyYKoWyMZvs7+2smYDdoLvEROW1hAy892WeYdVfx177/sSSB5mONsXZG/3iTnQUP8O5uY7GgSj2jh8kkNGtQZovuzRCJoZ0z45L3aB6XJqANNuEsJz//gapmDo3C//vGGc9ash40H1sCkPvdS+Uxto/BCDOrHXQhzme6DGXV9HyJXxeBorrjn8imvxpt8iTw6Xyky/5Oo9xTcLk67bDa1TNhYye7kACVFXeIJ44U7LgB8k8EHstnj3XbSfowCC60v4k0sckdX5qov2GguQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raQVhAUM7BywgYabyKkVRKPCnQWQ3ASUaA/O+drsEtk=;
 b=Ge/gYf5ppFwJUEAKZk8pBttSKL8gNbCEzXAfeO8Y4meSoWSnAOh98waWeGF8Vc71elPFp16yRuFXd6Oh3hb3LpJVMl5xnbJ2ulh8IAR++usIEoyYa44HiL3p4G4NZlXetMQr9Onqzep7tNzGPj16j4BF/R8YUVY+4lbSNE8lpOLZVb23oMG9Vh8LvpmWuL3Njc4M2ryjDsyEfvWz7/vGwhrMAxgxtIgX5XDPCtdL8sRsf8ckGn4JUy3Dr8zUBeAarPX6CzI2A6sG2gsVYj1lkOH23K6+B7kOgOhat3ZcRxlbCBOOlteeZeZQwuvkrdnFtg3LX3EEJxaUTj8MDwh2VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raQVhAUM7BywgYabyKkVRKPCnQWQ3ASUaA/O+drsEtk=;
 b=B5JEBjiF4+4OLO09RTbuhrsFLj3dP+WbamWjukeEpjS3UqACzmbskYx364AeJTR8jRZsMe4J6BXFt0nCP+Cd+ua3rsmq7y9GqLGwYAIvP5e/py2CsLmmrvcLR4uFcGQXWFX48dc2A0r02l+PKg76hWwvTZ6l0shw0/mQC9o/HpKxA/EB/tiu36HzkbKCdhDZQrKrpznmOUHQIX5TLRIwVj3Rw25UnIrkgBe3rU1r+VLrXWn1kxTBZixsHPqnDEK3QZbLZY1HizbDkI5G1wg8sxcREu0L7NUtU5qMGgsWPRZzYKe7uM5phvrohb6MlYzeZe7ergOGJm2Gcs14UcpmXg==
Received: from BL0PR02CA0070.namprd02.prod.outlook.com (2603:10b6:207:3d::47)
 by SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 16:59:27 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:207:3d:cafe::a9) by BL0PR02CA0070.outlook.office365.com
 (2603:10b6:207:3d::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.24 via Frontend
 Transport; Thu, 18 Apr 2024 16:59:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 16:59:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 09:59:06 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 09:59:00 -0700
References: <20240418160830.3751846-1-jiri@resnulli.us>
 <20240418160830.3751846-4-jiri@resnulli.us>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <parav@nvidia.com>,
	<mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<shuah@kernel.org>, <petrm@nvidia.com>, <liuhangbin@gmail.com>,
	<vladimir.oltean@nxp.com>, <bpoirier@nvidia.com>, <idosch@nvidia.com>,
	<virtualization@lists.linux.dev>
Subject: Re: [patch net-next v4 3/6] selftests: forwarding: add ability to
 assemble NETIFS array by driver name
Date: Thu, 18 Apr 2024 18:58:35 +0200
In-Reply-To: <20240418160830.3751846-4-jiri@resnulli.us>
Message-ID: <87h6fyboa8.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|SA3PR12MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8daccd-c76d-4872-3ef8-08dc5fc8e878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Bh8Dn6mwY9QxpH8lG8V06EVi/7LSughfwPKVPV6o68B/5+ixuOIZxYvWkliwfenHeLDnUmzGGEEA30piEoK2w99sjcUp4NxN4Aoc2KXr6tVmLatuI6j0SfuIv5xXyuh9bxAg8oHQjjw7jNHcw+SZHCIWJm5ZV/INXWipWhZHlhSygX9qr2h62cQG47v+bvi9209gn1pHNSvaFbJZ1+dpuTuiy1cKiAvrXJyGSNofkNCipdn71ODbwfqOXZlxR6zS0SgNBkIqlijL0aaJfHn4LG7T5lliw4YRnWNh8Qvx5uJi1VQBtN0ICjoePVl7kWd43+sNrs331USgHxau9hbWG42yOTGcCZLtrJnTrkv42EpPHDYJaoh1m5pmWp2QimdRx0+4xJDRZqJvNmbUijR2VYltwaFrsuDJRDHWTA55f2uu+x4PMLnx1CtzIAtKngtsK2A9k9Pg10pyjcJ0QdaWzY03JoKoBxRrnwbPU8rKgcW/74dkVxqoACVhXURL/pMdL9VcQd7CEmV+1cbSeq3SXC2NrPovqEufUJA3d/G8IaYdrENBBQ53/7DBbwJR6ADgLwxasLW4VZaY0VYAJp81cCzQzbOgMI94kYcMIAnBjRJyBUBZ+Rygoy5Nqy+gH1pOjMgA7mQsfgqR8WRdhVZGvoIfQ5ZfXPStTFpnwj4WD632gs/haO5+zQp6lTfOb+5svstGBQBvtmBuUy349ohjYhGe3xTTV93QBHdO3+rrFoI19jidHNnrBQ93UdUrYZoM
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(7416005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:59:27.5872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8daccd-c76d-4872-3ef8-08dc5fc8e878
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199


Jiri Pirko <jiri@resnulli.us> writes:

> From: Jiri Pirko <jiri@nvidia.com>
>
> Allow driver tests to work without specifying the netdevice names.
> Introduce a possibility to search for available netdevices according to
> set driver name. Allow test to specify the name by setting
> NETIF_FIND_DRIVER variable.
>
> Note that user overrides this either by passing netdevice names on the
> command line or by declaring NETIFS array in custom forwarding.config
> configuration file.
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

