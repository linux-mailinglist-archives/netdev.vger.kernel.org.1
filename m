Return-Path: <netdev+bounces-203032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D20FAF03E5
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 21:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD0C3ABBD0
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 19:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B3427EFE6;
	Tue,  1 Jul 2025 19:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="rhbDbiyb";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="CvXJeaiJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A5B274643;
	Tue,  1 Jul 2025 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751398647; cv=fail; b=Ul5J1NW87XCHAOwC+3I4tzxdLaef8RCqOY+cOE+H/lBw3DdP0Z9gUrN+w2MyX444mpF+GHpHSNEnx+1Ngy3rx4gT0Ss/32DggCRXdQnSJ8dhAiabD3FykZxnJKUeBWKl40IsXvagq+jlnR8w4DHBq8co/G30eWmlYNjnhQFDZ0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751398647; c=relaxed/simple;
	bh=KO3G3Rc9luCNIKAEZcUOxyF5mH+nddPxk1Gpiut4xho=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T8V+DuXq9iX9sVDivAceb4ohnVeLzT1QTjDmC5w1v92ce5A9SzNnQkNnT0Vdw7IfYxKjecdd8GL/Fd8Bn8o6p+ufufhGLPXoI6cHWWaw9A/5CS+cNzRSvDkNJR9CRV33l59WLRIVeIhQXvTz01WybRuks4OKR0lT7+6y9HEY8yU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=rhbDbiyb; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=CvXJeaiJ; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220296.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561ICrNj031777;
	Tue, 1 Jul 2025 14:36:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=FwYBsxvIr7+ATBUeI16S+8hGTv7
	H8fNzltVuMyykou8=; b=rhbDbiybxZOA68guhoVeDbdkMO3c69WyPbvcj9TgfQ0
	5OOTYfKbF/Ps5cuQ9Di8MfGMjs/0WfPtB2ybtAk74RJfIp1yBsgJWd21HiFhBYTE
	9py3zcFrSYCkiHU4ZT1NR7ncclHgup/Ti/QXnhQV2jYl2DlltfqIDjTdygDTL7Ci
	0doaIBK3D3W1zEwtXw5VkQO0tfeqoNUD/7rONqervXtYugKWEzEDyAj6+gh9JITM
	Pf+JHaQU9Kbxb0ubABQmF0pyq4FKOqdApqhZ6wVMT78e8N5aJ8tliIbuog/PuOEM
	f8z9kBpcNgGR7bxqAkt88OJ5SRqvauycyomfk0Huscg==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2107.outbound.protection.outlook.com [40.107.220.107])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 47mmrp04ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 14:36:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iioPcBk7EjsL5nDoB6RCM08zDt1cbiPe4w+RzY0RkZfd2dmzW5URQhYM+euePkuIiY7Iw3nfj4pz4GJbQTjhsl0gIDnehgLQXm4yYp0z7wpPzrgPhx5sJ9x86wHh2qJK5dVYTlgNJv1vFJtKIfu0sL3WWUVtio8iJWIMza669EhACLSVGliYCY9Q4L0cPe9P/qQZSOH599xyVBEZ7WedELDSs8aUsvjtlVoMgMGOrs9LJXhqnxg3b7Af6t6l3cwAhjcjgayXZ8TJC/nZrQ3XiDfJjSKOtW1aEnkxhTu0lfTWyMB/MuagOT8qrASJqHnTN2PvZkATsR6qcrU9Hm39oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwYBsxvIr7+ATBUeI16S+8hGTv7H8fNzltVuMyykou8=;
 b=q09pNZyplYqqwUXyG5CfN3sda9YWTsuP2Jd/rsB9GH5R4KepJveg0QPaaOqKyUsicW+VfygIeEsC+J0YUysMblbbbujXXReM6BMCH1MUjMgF+K8aGTyjUBEZ+X0zZr4RfB5b6QOfDmhAKidTCTi6aWQ8y+ehMOQtfxjD8exmlFkKp+JWGC83Av8e7EldwfoWUJgmr6kBvFgI5+aSLFgKiXV5FVlGMsCJRhNFivCpO/rM5P+hOwRVlQLBDJerxTHet8Prt4H38QwgFV8k1Gz4dJmLgTGmc1gecxCEZDZw0qxjhDbcj/IFbxHtbaSX6U+zAlX5Cu2eMvCp4nmsARTWcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=garmin.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwYBsxvIr7+ATBUeI16S+8hGTv7H8fNzltVuMyykou8=;
 b=CvXJeaiJJNG6y7maQjVhtPecvJSnEujWne1j/ysflSD0BRKBIthGuY1dy6ZsoJt2khhyp3urA52SGKtsuiqqont64BDKLud786dt9IovT6ZPtXN48IJZkARh5eOTTD7ohxEoZi6GvkiIMOKvpuPaYAeLNxjA9KIAlz/77AgAHtIk0+cgTbDwmNIg+5FHy/KJ5LwADnQXP8br3iih2pQyVaHU8FgZGBk5dFdocD7JHWDwj7w0S/lxtXNdO7raKCL5QF/K2iPSxq5wxlzJ9IUWG660hp8N54IVIYES1jrr3zjao5xb0GEF08rIzECrYo86JVjWzb06FMp3uxBONGL4Lw==
Received: from BY1P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::7)
 by CO6PR04MB7602.namprd04.prod.outlook.com (2603:10b6:303:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Tue, 1 Jul
 2025 19:36:54 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::db) by BY1P220CA0009.outlook.office365.com
 (2603:10b6:a03:59d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 19:36:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 19:36:54 +0000
Received: from OLAWPA-EXMB13.ad.garmin.com (10.5.144.17) by cv1wpa-edge1
 (10.60.4.252) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Jul 2025
 14:36:47 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 OLAWPA-EXMB13.ad.garmin.com (10.5.144.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.34; Tue, 1 Jul 2025 14:36:48 -0500
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 CV1WPA-EXMB1.ad.garmin.com (10.5.144.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Jul 2025 14:36:48 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.73) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 1 Jul 2025 14:36:47 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Joseph Huang <Joseph.Huang@garmin.com>,
        Nikolay Aleksandrov
	<razor@blackwall.org>,
        Ido Schimmel <idosch@nvidia.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean
	<vladimir.oltean@nxp.com>,
        Tobias Waldekranz <tobias@waldekranz.com>, <bridge@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: bridge: Do not offload IGMP/MLD messages
Date: Tue, 1 Jul 2025 15:36:38 -0400
Message-ID: <20250701193639.836027-1-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|CO6PR04MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3a3747-3a6a-4a9f-1c1a-08ddb8d6a258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hGh/emQdjtl05UCFBNShHuqtLvWb77+qehgEy8wzUT2VyXJnAcGrQQPxI6by?=
 =?us-ascii?Q?6+UzR6/+i6HmLZY+aNHC2B5vUYV4ScMWHwopia6/QtwiFiiaRNCZFc/sp6Ys?=
 =?us-ascii?Q?3fBCmBBdTFVYvMvX2+AaBaO2tiz1pSsiBjnMprlxg6eNA1c7cs1W4rDROoXH?=
 =?us-ascii?Q?DtvSdctoDYM/77M1T5JcsjoBTzG3S7NkKJ45UlCxGtmGohuttPtx84xhmmQg?=
 =?us-ascii?Q?se1ljSvkNZV3CCggadZdsbK1D3hM0N8q56kvvhiph0BKZp1A8wmSGvXqfYCd?=
 =?us-ascii?Q?yvQeXXL+H59Ycn4Nq5SjzOXGyHe9KhlvIkrgrTxv7GCxoJCD9KLQLP+ZYTq5?=
 =?us-ascii?Q?e8610/oXiG/KtIzQF1C5XQcv8DUs9SMn0AelPCDoT1h+Vs2NJT5lrY12eU48?=
 =?us-ascii?Q?EHU5LveTz6BfnJbkiEb4hgKMrUFIYJY77/ZoL44Zs5u4wf35tQ/8uyFnkuox?=
 =?us-ascii?Q?ftfj1/6qb8ssITB0uB6mF9ecLHYtAyefxa8LMRDua8CrPyQBYZx5OTBvRJRP?=
 =?us-ascii?Q?9eBd7UNRpXp2qBj2QjlObvGZPayU0YrZ+qiQxcPopp7SIMZ/is9KqmaSLoN3?=
 =?us-ascii?Q?8zV9ZJkroqLXUmdA+lAO0mtKPN6RPaRT0OfKbLKK3mXy8w5vktkpKYFq03z2?=
 =?us-ascii?Q?HhI3Pt+lU+lJsm6y+YHom7EjX/HQUldWi1QnudVTHodDAejwYuTKiT4G0nqa?=
 =?us-ascii?Q?QoWdvYcye6r8TTl+F8sMhIcIJKY6Pw5TEz8hVLoMMSHEpWZyezsuHJ/X90Gk?=
 =?us-ascii?Q?dk6/Ku/IZ/A3dj8/PFMeOVEHi2lBKNv/IVTV4+Y30ZOtCyNi/irQB/keX1pZ?=
 =?us-ascii?Q?p+rRBZCl00u2KrBvz+3mpEiPUTPEMI4iU2G0aGXxHuwaO5SGMMGl9dSGvlII?=
 =?us-ascii?Q?S35SrQ6ARJAJQQgwgbqVkn5D3q4aA2ovWHU1nant6fENFKSMfh1dqxcWkJse?=
 =?us-ascii?Q?iMtM0eknxqXzAt0M6+s4AhF3qKhRcdxZ4VnoL2jcPRdQS/dkFJZLslvTLDaT?=
 =?us-ascii?Q?up3r1OjK/yNZgWhy0/hl3p4RCKK3UEDGgRj8Sw8db5WzIUgLZX+rRIP2By4T?=
 =?us-ascii?Q?dn2S1ksp/klkhBl1l5jJsqK3eNtZ4dh/uhahHE2ebAz5adpKLT0yfhP4ohvq?=
 =?us-ascii?Q?yGJcGnWN7/rE6sFkAC2flS+FQC8LhfyyTwycKQxCcbZAGm2zmQMY2rFhja/p?=
 =?us-ascii?Q?6eoT1+OoLntyuwO/A5XiCTsjnpLmwaEPLILcUO08WjsXbsO1aQ43Kkcl9xo8?=
 =?us-ascii?Q?w1rBkFGT/4qbvl41nzkftvg+FxTF6XJ68g8lsTSFYfyoMdH2+HfXVVUo6C+t?=
 =?us-ascii?Q?AaKLvGB3fHaHD40ZBxy2AZZulSOuIBKbqhb3iClOv7NPEPlHurJ/SlXGpFmT?=
 =?us-ascii?Q?rbEbYIo/VZnNJuYz9WX1ww0ZkQW3YBJvxy7pBKBJn6W6a8O8I3WtsXFYy/SF?=
 =?us-ascii?Q?qMcVQElT40BXrPBDLgKZheZg8iH1Y1CATtmrwYGee89jeXSI9EvKVWQwHKup?=
 =?us-ascii?Q?NCGFFU3FCTmKXbN+cIYt3BerTbTpkBL2dWx6?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 19:36:54.1242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3a3747-3a6a-4a9f-1c1a-08ddb8d6a258
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7602
X-Proofpoint-ORIG-GUID: Cwunfg_zsvjjkZyPI8edD7Km-b9hE0MR
X-Authority-Analysis: v=2.4 cv=Bd/Y0qt2 c=1 sm=1 tr=0 ts=686438da cx=c_pps a=QkMd9A5hkDPJHF1mgsh70Q==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Wb1JkmetP80A:10 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=6AO1rQK50EryyGBc9MEA:9 cc=ntf
X-Proofpoint-GUID: Cwunfg_zsvjjkZyPI8edD7Km-b9hE0MR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDEzNiBTYWx0ZWRfXwvRQb6F9DsJg TJAHh+7+PfFnNQtydGB0/sXBQH82Pa8Rkkh6gFTfijPwHyAbrIgyVW1PiPQYsPpKAUlzV2JlRiw HNxwnDiwmPUaEeeAy7I216yOMNzYgOYztNQVsw0Lk5uRk2gyAstqmZOVBuqg6dtPavupUv5UCwR
 gU3aTu5TgJY2Bf4UpKAeKCDZ2M14cF071/d/EI9iFSQDk6FsZ2jHeSEAVCdEpk0iYo/JE8lEdTA DBIFMZJARl6yv3Yr0Msu5DcUIH99LPemQqGRLnbEROzIHgxtX3cN1Bk4EeksRm/LzUjpoVpZkch XGpIr9DFFPiNmP9TcT4Oj+AkpAWU3a8TuQweK2c46je4tl+Ave/5RUvqM7S/zUwAtNNkFOUZxCy
 X9obDVtAbxMsgD3SlGOkq9M+R6QYVUyCcQEqfdrJB29ktDys6HlMQZgprZy3kQAYGZuv84uB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a
 authcc=notification route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2505280000 definitions=main-2507010136

Do not offload IGMP/MLD messages as it could lead to IGMP/MLD Reports
being unintentionally flooded to Hosts. Instead, let the bridge decide
where to send these IGMP/MLD messages.

Fixes: 472111920f1c ("net: bridge: switchdev: allow the TX data plane forwarding to be offloaded")
Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 net/bridge/br_switchdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 95d7355a0407..757c34bf5931 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -18,7 +18,8 @@ static bool nbp_switchdev_can_offload_tx_fwd(const struct net_bridge_port *p,
 		return false;
 
 	return (p->flags & BR_TX_FWD_OFFLOAD) &&
-	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom);
+	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom) &&
+	       !br_multicast_igmp_type(skb);
 }
 
 bool br_switchdev_frame_uses_tx_fwd_offload(struct sk_buff *skb)
-- 
2.49.0


