Return-Path: <netdev+bounces-102652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6953A904144
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 18:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC501F218E7
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 16:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF103BBCE;
	Tue, 11 Jun 2024 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xjv0wonj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6033383A3;
	Tue, 11 Jun 2024 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123322; cv=fail; b=uB3IZS+dxohlWeH7h7gIFlg7TtrpRbKb+/sK2kD5ENi3znOgo0m23VBELgjVM+8r9Ff7ijzWAoTNJuXKelfh4xvvH0J718IM5v5S8v6doSifuDUje8ph5wWbBr4iYVIF5x6qb352zFdZc511zX1d5PHrsJRQxLYEVQH2wmxE+1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123322; c=relaxed/simple;
	bh=OVsa2h1aviDJXM2UXNAoe1rxj1b6DBPxkKHQ9D9Dt10=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aDdy02f9ursg6AyM926CyN0yBJv1+daedmWiIt6ky22jgV/3IytwbF3WjGZnZ+P5A45YIFZgI1+SoZjTIT5eRYUD/a81tIga0LLSc2Lx408LbYpa7x72y1F/BpYWC6Nif0i9ow12/7JSpdIYyb8FT8FrNhn56/zjXtnq33jVNnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xjv0wonj; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9gEv2aclLc2UpllaPnW4HimeehPaR4t9mWPl1eH3LKZyw5Dal2180SxI1F7oUZQPmsLbqQew0qA+/ddlyW9jPSEodgMHg/oTU2jllEOj32Me1nTFreUxWQZg0kfTGaMfohKflkv/b1VBxivQvXXwt8rovJ6LGVRU4TW3hCCnf1WklDmAyHVbif4v7wj8Ks/vqkravaR1G7nngflB2LpCzZzG7YbkChGA8PaBhj9NlKLy3eBRvtBxOLavQr3lpHlqalQWFHTGPPg+GF4T+om3wHRaSqca/bgX45AJt90RfdceZMStt8h/NFTIpVcIQ7ebx8QVLinC3y9hRAGobAQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fz3q+iwhTLhFaR1kRa6AWWqMxHYNnVbgoTW6LoIeUIE=;
 b=YuOHlA5vh6lFu61vC5HPKprKhdgPgMmYnVUHhsMMixCoAotzmkMm93UsbhA7PUOFo2HqWZthQGGrLn8s5iTujTc5qYAJXOcs4JfBNTJa/3+1fYDShniFx2YJAT52RueJkcffa66toJFaGNX5d7DPMgA4yjnC3fjnUV/afnYraKkdbBbyv+ZKvTFlnssSW8YXvxIqhIJV+KV1Z1cAbfTTaEcvz8MRW56VP5p2jCjt0gpQiTkEcC03+MFHFfEc/zQ6TUDCrWRLOv5HOnsF9wltlmArwgaAK9gj3n0PhHax52hcoxjN99aUbowTow31TkXum3pZxJJTgt+SwGaUlX7d+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fz3q+iwhTLhFaR1kRa6AWWqMxHYNnVbgoTW6LoIeUIE=;
 b=Xjv0wonjxaRk+L9zTLsCtxFA2GiOlV6U+fIheC8wkyLzsBhsC3/Vol4fujDqB6YKqO2eWjtOM3q3gBpYQGnThDAhWcDEPW32hPVq2ec2/oY1a7l023kEISZO0KER+vw7F07yH+8oFzlYh07/tdQ8pK2MWIeHdgJ2cJh9uHdlJt4=
Received: from BL1PR13CA0078.namprd13.prod.outlook.com (2603:10b6:208:2b8::23)
 by DS0PR12MB7772.namprd12.prod.outlook.com (2603:10b6:8:138::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:28:34 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::d3) by BL1PR13CA0078.outlook.office365.com
 (2603:10b6:208:2b8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Tue, 11 Jun 2024 16:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:28:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:28:32 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 11 Jun 2024 11:28:28 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v5 0/4] net: macb: WOL enhancements
Date: Tue, 11 Jun 2024 21:58:23 +0530
Message-ID: <20240611162827.887162-1-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: vineeth.karumanchi@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|DS0PR12MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: 26646eda-f9ce-44d1-2141-08dc8a338a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|82310400018|36860700005|376006|7416006|1800799016|921012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8PQ/6ABbu5gsquBroGlbZefLKKFgq0C9FwzLW6xy6E3MJi6kEVYcftNmQbPa?=
 =?us-ascii?Q?jGv+mQDmNJk17Q036wVa2iwvsfMZ2DNQXTrfTCOi58k21bvLKEQX5FFdXued?=
 =?us-ascii?Q?D45XHr20NyGwWb8ncd7su4TsGDMCgt/ozbzDszKYtTwS0Qp9X/qYFdoIOa1Z?=
 =?us-ascii?Q?2wiRunYdwsMXKdJyA9hIzGBMArryI+i6xRpDUwFLs1EVCwBYxWl7X0soR9SA?=
 =?us-ascii?Q?G/lG1/k3oin6emnG9Rg4OsFh4RHtOsirLgpyMxE9GP6KM7S1lQFKcwRhVR0R?=
 =?us-ascii?Q?Cszt6jxK4nLEkrRwk7OflVFBmyZnVTv3tcp7jlL0CrkzCd2PdyJrZITWAzpI?=
 =?us-ascii?Q?DvtSQ2so6zob3HUoixGjBIbsyBQTJbGIhBtvkjXsscS065qr7X46tyNHo2Z9?=
 =?us-ascii?Q?wYZ11uWjju7ljCzEHbHCtxmM/mHp88BpnhrP8cF2XxmaysbehI6qKYBeKnVI?=
 =?us-ascii?Q?UUT+qhpNTAGE81GKOUJjxwcBAmA8X4317mnPLY/GzuG5LxSDYwPHJOVC0wY8?=
 =?us-ascii?Q?t3VCc8I7HymiJFYyb8IDdOvLrpBluOeI9VssVOc9zQ3E399Rvhwh5OrjkS3J?=
 =?us-ascii?Q?Ozj+H7cuX1MLoeKq4Mgzx+QJ3rKmf2eO8q+WuGarlvzVg7ieiKqiSZb7FgHl?=
 =?us-ascii?Q?8BAxUcYRCVx/kIWqhhmAqZ3HL0cMpu3aV/tptgV2UrPGPYWnKat17846u3Hj?=
 =?us-ascii?Q?wpfdmzEyaicpIIQG5UnWW2+bKo7wk6lHlEnjN0SZC9l8TS5Vx6T7cCqVnFnS?=
 =?us-ascii?Q?t2cGJV+PdN9qxq9uKmaI/03JRBWiFiVpTXSfeWvz81RJcEIW8SapMKyu9Wgu?=
 =?us-ascii?Q?1RCzGJtcvWFsWY3tI9RAgvrfvCxAdCzhYZFAyfnmqFIjdD4FlM7dl33c+36v?=
 =?us-ascii?Q?4JcXvWzwLdvv1QmQfa/Ls+cIhq5l7ezZLtx0KlKvZLM2b5qg1oR7mAu3Cirz?=
 =?us-ascii?Q?Yi0wl2yggcmoeELBnD50AHpiwoCdcmHlKeE9fAKmz3XulnviH9OFYT8f3a1E?=
 =?us-ascii?Q?91jGw/n5pDuIO1dDMDLbUaVDx5B4R+Tfd+JXvcApJPUJIgzWGxnYYFVumHvE?=
 =?us-ascii?Q?cROk41sAvT1t0MJUKvH7eBCerXg17nEkGSDe6ZDZViU/G8uzfO3WsNEcUm2d?=
 =?us-ascii?Q?gWtod/kVu3Sj++qgi0L3dRErxAys0bcifWA93BwBjvoOL3EaX7fqPf8AM4Ks?=
 =?us-ascii?Q?o3Cf62HYzdqFiWWHdwytBA+MwtSNSsZvlXsRsjxxmsjXbUJwfDIKa7xf/bd6?=
 =?us-ascii?Q?h+ZyOwHbIZqWOxJSYWP9UH3KBr55FJtsyQlYiyKt7dTUoo3wc+/CUhKPrx7C?=
 =?us-ascii?Q?R30nDXVRGQP+SqPP4n0ctGFwAwxqkiXJ2ihfUhpjcbrO1K9FUHr36N/Xc6+s?=
 =?us-ascii?Q?s3HC+C7tX6NZi3Klb5E6R2R57zMt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230032)(82310400018)(36860700005)(376006)(7416006)(1800799016)(921012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:28:34.2135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26646eda-f9ce-44d1-2141-08dc8a338a19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7772

- Add provisioning for queue tie-off and queue disable during suspend.
- Add support for ARP packet types to WoL.
- Advertise WoL attributes by default.
- Extend MACB supported WoL modes to the PHY supported WoL modes.
- Deprecate magic-packet property.

Changes in V5:
- Update comment and error message.

Changes in V4:
- Extend MACB supported wol modes to the PHY supported modes.
- Drop previous ACK from v2 series on 4/4 patch for further review.
v4 link - https://lore.kernel.org/lkml/20240610053936.622237-1-vineeth.karumanchi@amd.com/

Changes in V3:
- Advertise WOL by default.
- Drop previous ACK for further review.
v3 link : https://lore.kernel.org/netdev/20240605102457.4050539-1-vineeth.karumanchi@amd.com/

Changes in v2:
- Re-implement WOL using CAPS instead of device-tree attribute.
- Deprecate device-tree "magic-packet" property.
- Sorted CAPS values.
- New Bit fields inline with existing implementation.
- Optimize code.
- Fix sparse warnings.
- Addressed minor review comments.
v2 link : https://lore.kernel.org/netdev/20240222153848.2374782-1-vineeth.karumanchi@amd.com/

v1 link : https://lore.kernel.org/lkml/20240130104845.3995341-1-vineeth.karumanchi@amd.com/#t


Vineeth Karumanchi (4):
  net: macb: queue tie-off or disable during WOL suspend
  net: macb: Enable queue disable
  net: macb: Add ARP support to WOL
  dt-bindings: net: cdns,macb: Deprecate magic-packet property

 .../devicetree/bindings/net/cdns,macb.yaml    |   1 +
 drivers/net/ethernet/cadence/macb.h           |   8 ++
 drivers/net/ethernet/cadence/macb_main.c      | 119 +++++++++++++-----
 3 files changed, 98 insertions(+), 30 deletions(-)

-- 
2.34.1


