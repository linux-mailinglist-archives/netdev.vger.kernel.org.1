Return-Path: <netdev+bounces-82719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD8188F691
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 05:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865A1294F27
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 04:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BC43FE47;
	Thu, 28 Mar 2024 04:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aorb2FvE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154503FBAE
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 04:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711601261; cv=fail; b=n70gQQqRhOgJ+tH0UDKuYlGKNnDJEs/AP0mW9QDHc+FxSO13yzwrpsJfA+SQfsiH0MkIsQF6Ujzd041RT0xXBuCW2UFkQ25ks9tflz3HBVeH1Gdx2gEmyEnoGMUjBiYjKe/UmwBzIv/Qfw5T8XA76KRlHmFP02ye9y47hpE1F8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711601261; c=relaxed/simple;
	bh=7MzuGWnHs5kD8vIcPfsH5T145lOa2yxqqC2Wf794kXM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rb8PTw91LUh0qmTgaEU5l+uLY24iVZxshsWsq0TY9RWnrASOTykQqdYwu5lZDr5h4ciwV2I8uCHOiNYgvb/nPSIb2FuQa4/VAocFa9Sn1PvHQs8rDTgKwZF4ewhCBQfb1xd5cVecGBoX36viA8g40x7Jvz8KuNeubR2nI9FwD80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aorb2FvE; arc=fail smtp.client-ip=40.107.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKmNOFHrNUio+RWVq3lVhfdcJ4yyQQldP8fmcMj79KRYSBkPQ9ktAaDSCLVHp8MEJjpZarjoTukGZfqV1qJteRMFB7Qfle0j+ChDoQ/rVhESm4Huq0qNOPC37XWBOsLLbjpdUw7f32Y02WgWqCFMXtnjuCzGNEVAFNtWX5MdqUlXUnb/d/f8h0W98hzNWaxqZ+P+UjwFHx/Ceaf3AT+BVbDT5hIctrpnsFZ6Nj9RjuzAUce6MtxUtIeAUhrpl2s+DZgnGEiQJWJtpqnE/qBQQGV311GHOpZ6M3UMsSIK2pmqkgFDJgvDPKykV4yBuIp7mm3zmGoTQh4p0l7znMOQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrKywuJ4+Z/TRBx0E6l1EIMKu8PFNhDc6o81EF4thyY=;
 b=A0xH95n8NFwdfG7wZMp99Fjn724I+tCklq5oCCmDJgBvLXBWSKcGXAHnlSdIByVpAwR1QSiEFFgC5hFEdAFINufgqfNeSGDqjp5e4araoWi5M07rhtf87i74QFRCZy/Ly1FlEp3HKQrLGMsoU2pukq5E6azBeMlIcEso8ESyLdb54wwKPwnC9ByhcmXCQVqFS1gksUP+LIPUcRt373CmEvUw+sFDCxKfteFmRov6Sz6vs6Vf5so73aAOcRqzWJdKGrX0aHxCcve59iUUnVNnogYmiKYz4JsNFLeP2WA11QlRXCDhhHQgMj4ejYXQ1l8dTdk7yXiBqKvl9/SDMatdAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrKywuJ4+Z/TRBx0E6l1EIMKu8PFNhDc6o81EF4thyY=;
 b=aorb2FvEzC1v7Ki9DUQbLZ2qSFRM/SgxdeAKDvzDb7OkBpN039AMBZRkUKhRFJA0VkMjZX464zU8aCcMk1ipnbW/ReNpq3RlP27Zzn5M2A0QZmyAQYXZSt7bJk71kyMTTGX7vN5G/yuSl5qPgRB6s1fwE0qHFZlhxr9NXpwOxr3DgB8RGjt5vbg4Zk47W6JwLf9sg+T+FZlF+wb427qkTlHjTOIqcnfjRghxYMOmY8PbgNGTQx4KM2h/D130y4NhWaH2AsytZldylCAqc41vFm+qyvtWy8G7S+HHhCVPW238HopdKluGs7cWMjjT70GmB/Lbhl2oDFYY2visd+tmKA==
Received: from SJ0P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::21)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 04:47:30 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:a03:41b:cafe::25) by SJ0P220CA0023.outlook.office365.com
 (2603:10b6:a03:41b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33 via Frontend
 Transport; Thu, 28 Mar 2024 04:47:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 04:47:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 27 Mar
 2024 21:47:20 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 27 Mar 2024 21:47:19 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 27 Mar 2024 21:47:19 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v2 0/6] Remove RTNL lock protection of CVQ
Date: Thu, 28 Mar 2024 06:47:09 +0200
Message-ID: <20240328044715.266641-1-danielj@nvidia.com>
X-Mailer: git-send-email 2.27.0
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e7421ba-6172-443f-0600-08dc4ee22cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TiHFDU6jCVmfV9ZuiUzWPMLpJlq8NFqpbxC3VWj4utJMT+i/OkgNFDAojAPvfktf8WiQ7mCF//jiFE2tUluPlAcklCX/PYNSO41xvMc0gS5z0MmTavg6JXPXYE4fPzDjcMYpkvdoAvDidh0RthCV/BHHtkLN3+zi7t7eDK56kZitdt+OY6zjRIrsFHFt/4OLfC//ABxClCLTlBd6kRGFIHKaQmS9NAux+VpGvMYQrAKtFuarewAOxRe31Gq5EgpCj+zn49PSOe4KeVQ5WSk3hF0so382x6HFpVfDwaD5f456KyPqHqhqvwd+cwHq/1RL7oCnqqT6Mg0Hi+vq/FBeazQM4w057PdoAXxCG0ohUFKEBahXz/el3hSw0kfXO/a2BC02jnX/g8YkB5nJRje7Jc78NbOhYBeOs72Ccj+BbpKiJ4iD/RkPx4Dmc5z65eLXYVAA8T2JPzwpICt7QnP3t1ewJLTMMxpNtls3dGvWZ3hraMJUDbqL9Z2w8EzF7UGf5yobrgxwyqs25cVxyS8WrxjeQVt47dmUJiTVSM23Ow0NR9aEdwZb0wpgXEOAsgwiN9cDg/fu8K97gM+pilugqnNmi1ZKEdFnpwSRHorwKT+LSiQfkjGIAGV83CaI99QHGNxcyWS9F/U1ac6JJlDAyFhmFwEeBcpmpfwkBk7sUKG84bGeg/HZmRbkeBzUBsePkhftMC+b0cbf5CP4HQl3H3S1CPxPUjlbS8d27gSTOtJkYOrzxVK+GkAlmr4/6edM
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 04:47:29.8718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7421ba-6172-443f-0600-08dc4ee22cc0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898

Currently the buffer used for control VQ commands is protected by the
RTNL lock. Previously this wasn't a major concern because the control
VQ was only used during device setup and user interaction. With the
recent addition of dynamic interrupt moderation the control VQ may be
used frequently during normal operation.

This series removes the RNTL lock dependancy by introducing a spin lock
to protect the control buffer and writing SGs to the control VQ.

v2:
	- New patch to only process the provided queue in
	  virtnet_dim_work
	- New patch to lock per queue rx coalescing structure.

Daniel Jurgens (6):
  virtio_net: Store RSS setting in virtnet_info
  virtio_net: Remove command data from control_buf
  virtio_net: Add a lock for the command VQ.
  virtio_net: Do DIM update for specified queue only
  virtio_net: Add a lock for per queue RX coalesce
  virtio_net: Remove rtnl lock protection of command buffers

 drivers/net/virtio_net.c | 243 +++++++++++++++++++++------------------
 1 file changed, 134 insertions(+), 109 deletions(-)

-- 
2.42.0


