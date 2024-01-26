Return-Path: <netdev+bounces-66199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5601D83DEDD
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 17:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD3A1C227B8
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 16:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEEE1C2AC;
	Fri, 26 Jan 2024 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G2/wx8fO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD48B1C29C
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287038; cv=fail; b=TmZVZYpRNNGUJDUBd2+kDLeprlZ2vwzKWb58els5f7L6VLyXRhQ/ol1hA916YL3NCLpUI05guH1Ql7R0OuW1k3aYXK1kvUpQobvdsDlBhQghWr3CNDLVNLbRhmwlIsM5FHT5122PPL2HgdXF8qFzj9RfuYyDW6mACIqv8dyHWYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287038; c=relaxed/simple;
	bh=DrdLefwkeFXoJI9XjlpRYbutmQamlLWeeqXtF5yFe2g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nnpzNWv53mEXOKSsoj88ouvVyDtE5XMXyi+kORXZdPqAIrlgqkAn6dmI6Sp7td5yMdEM98UnwsmiKiV4mqd1xuWBDSOoUnN/kn3z6l/3gGrIt/SWXFISnrycBqvWoou60Ht4kOrITVwPN2ye5yY1pW415wSkVKAGbgixkOfB42I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G2/wx8fO; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3vdRT5m8C2MvWc0vKZ2h9R476RdVs1nIDN/+cwUIKrgEWJJJfu6XBIULlwUAZ8rGanorGVPPPbZS5NO7M3F+ruUZWAgJLTC3EISOX6+a1ZkOyrHEhz4l3oNC0/UD/c7EtXTlTilGBuju5alkJ0JUqA0zenAEVtVa2GKCC6nQhhV9DpFUF4UpcZDBgoE/E0B7bgCqsGiYjVjINzRBv75v5VXekax4jUpxr/yZ6b27RfBC04oLFwJXml2irt6vGkd8ClfbPmbRIuZfiYxElYk2ZDlrFHVpDYnamwrfLs5oafx1e2qqx9cTJWlnw4sdxMZD0dXKJ5SMHouH34gKk7QkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Op04Bfw5JGHE6WxeHRVC1c1YH07fdlsbyXAUZ7CZXiA=;
 b=K8AgeLm/Ro6no9QGHEXUFXMMJKn9HVl5lZJL7h49NstZJO5u823AEw/+5deUgZFcZ+nYth9cu/6yFTqH0EW6ztAOO63UB1ghofhd9wSC0BqXPz2F7seQLXOWmwWeEdsrfsbP9MunedxJgNb3O0rEaRy1+vORa3gy9veVIdT0ncrn1VKygIabv9cUhK7nloyjM55w2lVmVDHJfGaY8zKudPUaC2af42EPAkZBLPL2e+Y6MHRLYSH24qj+dMU6X0VMD/Z9gsaXRvWQZtUcgGmWPaDrJJ8PoraS8wbKn7WzG+wbqcIrxMVOCgvxOrdc6iiygxDWcAGk2vBPIxmbJIn9Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Op04Bfw5JGHE6WxeHRVC1c1YH07fdlsbyXAUZ7CZXiA=;
 b=G2/wx8fOLbcESB46O/pj+/C5Yp8bHZvjl0gDnBvqkY4FzPwLccI1uSgAHYc6eSlcH5g2J0j/YDSoaPRHMjvD0OF1128ezCDntQKplGaUooLJpplx6Hbu/e6lz6SoQrbgywT7g+ffKlx9O2GFV3hgwpMwREA/NbgtQsh1iaR74dFPe3DzNFBCZKEU9lqaGLrIAkk2KFq1+IZnvLemZHSkdgfE0fpQ/IadssY0jGpNcucpgGFyyVS88VdbHEJg/vyiPevpbWJrL7Hqx9R00Hd2l33R3DbzUqiiYmntRR9Utsqs3nfR8oHttDZXuHheIDt+tNwiS5COGZGzs5FhdmQ80w==
Received: from CH5P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::28)
 by CY5PR12MB6408.namprd12.prod.outlook.com (2603:10b6:930:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 16:36:57 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::70) by CH5P220CA0022.outlook.office365.com
 (2603:10b6:610:1ef::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Fri, 26 Jan 2024 16:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 16:36:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 26 Jan
 2024 08:36:39 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 26 Jan
 2024 08:36:38 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Petr Machata <petrm@nvidia.com>
Subject: [PATCH net-next] selftests: forwarding: Add missing config entries
Date: Fri, 26 Jan 2024 17:36:16 +0100
Message-ID: <025abded7ff9cea5874a7fe35dcd3fd41bf5e6ac.1706286755.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|CY5PR12MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0df8d6-a90b-4618-f6e1-08dc1e8d02e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KLQ8TMWvpuwpdCIoVaKTvlCu5HN/4Fm6bajjuoGpiwc4N1bhF/FzQt8cGIIAA9PXgkBHVHmFo3/Bj/vYGcm9SFIQH5laU+DH2zB5EKZRbdzFsUrCwSkDlV0dlABwHuyz7YifNFnfyZrqmZ/o1JBax6MRAq4DClMoGxiI+pAKfKnhabn4SaQ544oiLHH7ooRfs9HvFpeJ9edUO1u0g9mgkYPNkdHMmSD0Mri32eTidIQ7CyYLRgC8GUoWdGYfkJdCeQDbSOZFyCDzy9NuIY1Riu3yxEzw3XIlLpCpu/MVVaRo3AuLz0dp7PCwV8MYN8FPu8D/3hSg4NweTwSKUaoRMdyJtF3ZngC3f8NItPrGwlXs5Gpx0XLgNHXfVAjAvfgJRcbUKUI5LwVRlyT2H7AhKbNNQ8I9d+8mRsGjNgkcxw9K5EyMiS3TSUYUKZgBf5vVZw9afSpZDcKmgcUGdoIxE7jNi4F8j4QY/WVs/ywoiS8fanwdECCG3IWCkFer9mLT6FN1VuN0uW9vxUV2v3q/mv+SuUNGaaRybfwroKcWdSp1/d3dgxn1zQhZWz8MULVlsROooigqHfIy+zTQSX8YFPnZRhutVXxU6e1kwTvpah7CktfnLOrdH/o/G8qGvqI3pck4S43v71j+ykw9+pDSJgYd3us06o64VLALRdU0GZbWJftsKIMGrJpoKCHxHLyxPYKlJHxkg7x064fyYzlwU4SQK4iYumoDGxGP8zS0MqCaU/lp7DboniMArRg8Kt6R
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(82310400011)(64100799003)(451199024)(186009)(1800799012)(46966006)(40470700004)(36840700001)(83380400001)(2906002)(336012)(4326008)(8676002)(5660300002)(36860700001)(426003)(47076005)(36756003)(41300700001)(40460700003)(2616005)(40480700001)(107886003)(82740400003)(478600001)(86362001)(70586007)(316002)(70206006)(110136005)(7636003)(6666004)(356005)(16526019)(26005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 16:36:56.6183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0df8d6-a90b-4618-f6e1-08dc1e8d02e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6408

The config file contains a partial kernel configuration to be used by
`virtme-configkernel --custom'. The presumption is that the config file
contains all Kconfig options needed by the selftests from the directory.

In net/forwarding/config, many are missing, which manifests as spurious
failures when running the selftests, with messages about unknown device
types, qdisc kinds or classifier actions. Add the missing configurations.

Tested the resulting configuration using virtme-ng as follows:

 # vng -b -f tools/testing/selftests/net/forwarding/config
 # vng --user root
 (within the VM:)
 # make -C tools/testing/selftests TARGETS=net/forwarding run_tests

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/config | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/config b/tools/testing/selftests/net/forwarding/config
index 697994a9278b..ba2343514582 100644
--- a/tools/testing/selftests/net/forwarding/config
+++ b/tools/testing/selftests/net/forwarding/config
@@ -6,14 +6,42 @@ CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_NET_VRF=m
 CONFIG_BPF_SYSCALL=y
 CONFIG_CGROUP_BPF=y
+CONFIG_DUMMY=m
+CONFIG_IPV6=y
+CONFIG_IPV6_GRE=m
+CONFIG_MACVLAN=m
 CONFIG_NET_ACT_CT=m
 CONFIG_NET_ACT_MIRRED=m
 CONFIG_NET_ACT_MPLS=m
+CONFIG_NET_ACT_PEDIT=m
+CONFIG_NET_ACT_POLICE=m
+CONFIG_NET_ACT_SAMPLE=m
+CONFIG_NET_ACT_SKBEDIT=m
+CONFIG_NET_ACT_TUNNEL_KEY=m
 CONFIG_NET_ACT_VLAN=m
 CONFIG_NET_CLS_FLOWER=m
 CONFIG_NET_CLS_MATCHALL=m
+CONFIG_NET_CLS_BASIC=m
+CONFIG_NET_EMATCH=y
+CONFIG_NET_EMATCH_META=m
+CONFIG_NET_IPGRE=m
+CONFIG_NET_IPGRE_DEMUX=m
+CONFIG_NET_IPIP=m
+CONFIG_NET_SCH_ETS=m
 CONFIG_NET_SCH_INGRESS=m
 CONFIG_NET_ACT_GACT=m
+CONFIG_NET_SCH_PRIO=m
+CONFIG_NET_SCH_RED=m
+CONFIG_NET_SCH_TBF=m
+CONFIG_NET_TC_SKB_EXT=y
+CONFIG_NET_TEAM=y
+CONFIG_NET_TEAM_MODE_LOADBALANCE=y
+CONFIG_NETFILTER=y
+CONFIG_NF_CONNTRACK=m
+CONFIG_NF_FLOW_TABLE=m
+CONFIG_NF_TABLES=m
 CONFIG_VETH=m
 CONFIG_NAMESPACES=y
 CONFIG_NET_NS=y
+CONFIG_VXLAN=m
+CONFIG_XFRM_USER=m
-- 
2.43.0


