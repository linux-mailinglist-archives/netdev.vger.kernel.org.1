Return-Path: <netdev+bounces-195643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F253AAD18FF
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 09:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED17E7A3FA3
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 07:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDE61DE2D7;
	Mon,  9 Jun 2025 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b="rwMwEt/B"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020113.outbound.protection.outlook.com [52.101.84.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF924C9D;
	Mon,  9 Jun 2025 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749454348; cv=fail; b=VqhYqZHdySYQVR6UoslEfZWPumXu70DK6SxrpnTtKGJNtGSWPLhx0iUgYnt/nFk7nVQVngb7r6RuMU+1YXk0ZNmUn20COEXMWbEOr2niJfHEHOUqJ+adHOLQAkMUIy7BFifxWjTQLnB7yXZfc4ihau7FjU6lW88XYhd3Wd9X+CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749454348; c=relaxed/simple;
	bh=98ubVO00buLighJLOL7yalJzxZrAirS5G8b5YtPop7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cke39Vs5tDEkU1xgesB6Q4uLLtUzoBbaoWqLtlNLnNVxUqH0/RCWScUeAHuZz90/qXso8NJVc9qr5FukIEGFZTBrWzlyak6YN/TVJDzWFEaW9ayJVBLuG6kkP3yHnPyrPa2EoNzjtMQxx+cNDiglHq7ly+3tDsIBDx6ZysaLx2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de; spf=pass smtp.mailfrom=technica-engineering.de; dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b=rwMwEt/B; arc=fail smtp.client-ip=52.101.84.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technica-engineering.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iqhm1NemNAv1IT4FkfnO7kH1+8Pm9qCM8gH+qAugG06duoiwDxFm6rgtSuQoBkCfNipbUogcaFyoZg245Eq37ryYhPtOr0R9DTOH+SoplErcleCWhZR0Fmzwx1cuiJJJnPEOO5TNb19tCQ93a1kNh+4H3E3wgeK4khK42O/YaA82YSykELCrOyvjkwRacTetXkJcjIIFkfwdXDPZgHFWFHx8J9vp5/lpZrsPVrsciPlwSX/Nildo5y9rQt58Wpg0+WJ1Pq7EYtBXzlZM/ocONoUj/jV46oGCKM5Qpv1eEkVrfdOKl7UO39woaQn4XwrVbewvZ9WRUwjcX2PhDQ9wiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dL0s6kQI03T3/CroPCSn4LQzoZbWYB3xWFVH/PgHuT4=;
 b=i8NyJVZxLyJCV5q0+K61tjdkNSAnn1fXlZ7kGf7TseA121w3dm8ejhLp6+QGGlFNU/bxNLSfbua0VJXzMM7pavoP32RCA1/YaNutRcbbHc3sL5ZfGqxf3JcdcWmoDJllEaRL2xM/3KJO94ProYBeumYOTTopU1XmENDDeiT8fDmX+MApENrPVhPHfHJCcPBOGQKXEaiRC625DStlZd5BQVo2waW1ZUbDiFKjmmBxsl+j4Cqc0R6sn9TCFYdw5aVnm10y0Eqyn4BR2A3XXgqqXlk5SmtopKs6hKblI52/NGVC6BNx8/e8dS69imKg51xMtzsL26MOUfmddNR1OhNwtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 2.136.200.136) smtp.rcpttodomain=davemloft.net
 smtp.mailfrom=technica-engineering.de; dmarc=fail (p=reject sp=reject
 pct=100) action=oreject header.from=technica-engineering.de; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technica-engineering.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dL0s6kQI03T3/CroPCSn4LQzoZbWYB3xWFVH/PgHuT4=;
 b=rwMwEt/Bd8wRYs6ukyyJ+a6mZnQck3A32zO/0fHFwCbA7tsBlS/UfobsF61/lprwyredr0xXiCfh0/b961RuyVQbLsZC0dDRI8KfUJ0meI2MaH7+FmUBo6+KDrH2NjD9YIovwoVQBq0Uog3HUclBE8wytdlM6gmM1TKLfz/ZbkM=
Received: from AM9P250CA0016.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:21c::21)
 by DBBPR08MB10506.eurprd08.prod.outlook.com (2603:10a6:10:532::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 07:32:22 +0000
Received: from AM4PEPF00027A61.eurprd04.prod.outlook.com
 (2603:10a6:20b:21c:cafe::b0) by AM9P250CA0016.outlook.office365.com
 (2603:10a6:20b:21c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 07:32:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 2.136.200.136)
 smtp.mailfrom=technica-engineering.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=technica-engineering.de;
Received-SPF: Fail (protection.outlook.com: domain of technica-engineering.de
 does not designate 2.136.200.136 as permitted sender)
 receiver=protection.outlook.com; client-ip=2.136.200.136;
 helo=jump.ad.technica-electronics.es;
Received: from jump.ad.technica-electronics.es (2.136.200.136) by
 AM4PEPF00027A61.mail.protection.outlook.com (10.167.16.70) with Microsoft
 SMTP Server id 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 07:32:21
 +0000
Received: from dalek.ad.technica-electronics.es (unknown [10.10.2.101])
	by jump.ad.technica-electronics.es (Postfix) with ESMTP id 2895E401BF;
	Mon,  9 Jun 2025 09:32:21 +0200 (CEST)
From: Carlos Fernandez <carlos.fernandez@technica-engineering.de>
To:
Cc: carlos.fernandez@technica-engineering.de,
	sbhatta@marvell.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] macsec: MACsec SCI assignment for ES = 0
Date: Mon,  9 Jun 2025 09:31:53 +0200
Message-ID: <20250609073219.939903-1-carlos.fernandez@technica-engineering.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250609064707.773982-1-carlos.fernandez@technica-engineering.de>
References: <20250609064707.773982-1-carlos.fernandez@technica-engineering.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A61:EE_|DBBPR08MB10506:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 367cbc03-1d53-4478-58f4-08dda727c582
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bOqBwwT7RP5PKf7X+VaLxEw+2VBlJ8vYtOGf6ECGJ2Y78ayRMJFE13EgUrOI?=
 =?us-ascii?Q?SQ4X2r9MhAuZRfbBceDV9jF9/GV8EI0EYdZVJYdss7v98/sou6XPX+bLbTHs?=
 =?us-ascii?Q?/BgEVXoLSRIF5JrGXCG1hyt4CXneagizdaZ3IDaGgpeJvOsVxzaBKn9KyRtW?=
 =?us-ascii?Q?o7m+0FZ0dc29LN6+gevxcVvSk/v241TYW3NFcmOhNGBrzYwz/eUNRnqBgTci?=
 =?us-ascii?Q?Dwu15e73ltqmJOHFPUq5a5GUihPOU2hIWS35seBYGxHonsqBlN/HAyntCBBH?=
 =?us-ascii?Q?H6WhbunXiDoJSnPLMPH3Im5WQ+kWmKcFksZ4nlgHpypWewGuNb2HMtBN0BDM?=
 =?us-ascii?Q?wp2vVhdFGX1TmXd88Rn9eoE6qHrwk93IjPKQyQUc7/9dLC8IUHEHm2/HoBwl?=
 =?us-ascii?Q?Q3ZXun7cxuCL0AKXisBiaWZJtQx5s7pPVcMSBx0jRNwQWmmNMtNxhUBfTB15?=
 =?us-ascii?Q?ZpW3a0UUqe8ilXuVxv81Jv/Pb8VtgCCyJutVNKN45qXrT6mc1XblLsaLQMeW?=
 =?us-ascii?Q?/XqTZX9gk+favBDsO4TEeOkYnGy9162xsmwY9G9xVFSg30aOKW+0+SHEHPoL?=
 =?us-ascii?Q?rPMLNHMaTSgTddXyFb530Mv+YvnUrZX/06T5nCc5Ehh1SbgBm/9Q9yMKXaHN?=
 =?us-ascii?Q?pOIYFL485ZjuXy1Pn/fp/9FK8/T4HbU1RUFMIqlIzoF3F2NkPkLvihQUkIsI?=
 =?us-ascii?Q?bl9DGSGPSKMbGtVWD/ZZi/O+J3VdZj19XC7qQ6RuDrTPMfys8QZsqHYZ8Uma?=
 =?us-ascii?Q?G9c/3wx8EDIziDdm1ZQRTvPo3gMVvi2FtXRNcri6xpjgQ+IC1ni5gKbovYaf?=
 =?us-ascii?Q?DSiE/J2jQQcuswoIxOk+b6z53HLdRsh3EcorVNlNK30NjygrBUwHYP0YD2a5?=
 =?us-ascii?Q?0KvK/yiLuZHG3dO6ru/cHnlOcjbfp5aM2J0+MSTJw0jwKb1trk6HczkKX9SR?=
 =?us-ascii?Q?pgac7LIEDcxgMJvTh7ax2fcVzItH/i3+G69mXUUtXrlhXXGFOWxOB5ZspRmr?=
 =?us-ascii?Q?2P5AeDYgFEogKpQcdi6qfAw9SHOOirh7tbl6qA9ANGkZB7eMP1bfEcW4wEO6?=
 =?us-ascii?Q?vKxUoe6KgIoyYEpcf3CMiKxOhq38Ge7bzXAXk6R7MoJcgpa971cZNzqzGfRn?=
 =?us-ascii?Q?H3I2KLYChBMi06wjK6YntbOvSwQzMp7PxnYI5273uw/ps1TxAXfhrguTAx2V?=
 =?us-ascii?Q?HUi4mBsRqwTCIneBSh0jJL9P4Di1495A2Y3PA8Dn1+Dzh5QeESnrmuH8fJVn?=
 =?us-ascii?Q?GIsnEIuutVAttcwvLt1fL49bJgVhLTbu4+LQZDYcz7AzpcnpSp0RSXnVeZbi?=
 =?us-ascii?Q?lhckEYpK9Yb52An++1iQkVadlvGbDKvaVScnLV6g4Dk7OXHYgJH2BBg4uCEA?=
 =?us-ascii?Q?VUD466PcC1CUh1SbxrK5U6ZWO1WpINJrWgM4l5XADyAK9W4goJf4rR9TwyVn?=
 =?us-ascii?Q?ef/oxmvesVANGsqOO6TxOLyDfThBEKjpB6pqzY3BefEDFjgyfYenQqITgQT5?=
 =?us-ascii?Q?NDO+i91ZZdpvW1OblUhdX0pecj0YNSAenJYL?=
X-Forefront-Antispam-Report:
	CIP:2.136.200.136;CTRY:ES;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jump.ad.technica-electronics.es;PTR:136.red-2-136-200.staticip.rima-tde.net;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: technica-engineering.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 07:32:21.4558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 367cbc03-1d53-4478-58f4-08dda727c582
X-MS-Exchange-CrossTenant-Id: 1f04372a-6892-44e3-8f58-03845e1a70c1
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1f04372a-6892-44e3-8f58-03845e1a70c1;Ip=[2.136.200.136];Helo=[jump.ad.technica-electronics.es]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A61.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10506

Hi Sundeep, 

Thanks for catching the typo. I've corrected it and added your review tag in v5
https://patchwork.kernel.org/project/netdevbpf/patch/20250609072630.913017-1-carlos.fernandez@technica-engineering.de/

