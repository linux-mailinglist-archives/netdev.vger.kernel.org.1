Return-Path: <netdev+bounces-195242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 141A8ACF035
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 15:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AFF8189CDFF
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 13:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0337221FC9;
	Thu,  5 Jun 2025 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b="ShvSEsvp"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021127.outbound.protection.outlook.com [52.101.70.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044A81E5B95;
	Thu,  5 Jun 2025 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749129526; cv=fail; b=iEFCvmFzPkLKUIPHJENYayc/z9dWDhzfyD6lqv9pqe3zhXIt0uxrxSOONWXD+YvofmdBRvbE2AcYq7AcoenPc2LxGiofJS+FWh8amQpuawexPcB4QuMK1bReLjiq3JQ2xRwsFTUloXtOhFkM3/BZSszISpvNV39MHVIWmo1k+04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749129526; c=relaxed/simple;
	bh=qpJXy7hTFUO7cf9Ge50lXnlSOj2/KjRWbvKfaFU4B8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxSYEAWsQ/s0pT3HJFz+u1J1zxU4EbP5z+0ji09l3MX2Wfuaagx053FPNNuRKBowhCthUN6SyF5GFDxIe+BgzgFgvC/w9UN6nVZb6aSkGId8ADYKPsH8YiBMYhHV1z3utr6HaVq4tLBJ/BSURmKCoalZiFGGoZuMsehb3LPq15E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de; spf=pass smtp.mailfrom=technica-engineering.de; dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b=ShvSEsvp; arc=fail smtp.client-ip=52.101.70.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technica-engineering.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQBMQKMH80Vm2ZBul2F5YkxR1Z+vRQJ/C0KrZKlFgrz+SnojsfErvZ1qGSLtmIgzREpdVabUPxyY+h2hnE1viV9dUnRyI/rezzxMeYj76ip/pRpckX066IDf0b8DTICeRSiPpkgRaY/pOS/qsis4B3WeIBn3d4Miaej6gjScdzaI7+bfTNj4YkUWri/zwiTcm+pN2FPnAs/t3hyrdvcl9K7d6k7LyOeXt2wW/TpYhikrBvV0A0Bn7FgYeraKX+KodInNiQLmrLd1S+3kBjiu65fLs93RtVFzNzZP8+SK/3DiAgNUfrcLkCEsnXKBpuBqKcCgABiUPACG/lZebhNz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITODzLQi1PckBoaXElyKR3IRhQzDzOjsE8ZrKJAG49U=;
 b=ha3VvgW5Y/g8CjcJdog3R3FKb6r/7leJFaZnawSagv+0I/P75N5V+st5iiiRCH25lnjGWt1XOKHl2LMbZ7dy8TZqZaY4NvKal6oNt/tO5xcLrqBSpX1YuZG147Fy4kimV+GikBNRBJcrlbmc27xGSAZ8AnFGx0poCoscIyawpHcaOCurj31Ht+0U823n1ExX6AXemAgQChlvT88C4OX7r6jHIdoHK1MQyDm6Psedv4WAbQipsVmD8OkLESXPFDpjWjcV8S3gPplfYfZtkxas9zRdnIpap29JQ7+UTjvQZmvcO/BuKGNd8XOb7f+uBeF1T7i0VjnwYTLJM91icAt58g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 2.136.200.136) smtp.rcpttodomain=davemloft.net
 smtp.mailfrom=technica-engineering.de; dmarc=fail (p=reject sp=reject
 pct=100) action=oreject header.from=technica-engineering.de; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technica-engineering.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITODzLQi1PckBoaXElyKR3IRhQzDzOjsE8ZrKJAG49U=;
 b=ShvSEsvpBOQGh9Z0tRC+pFXums6a5MaAgnZfWcruOHLhM5Ix0QmDg7CNK810RgvEcqt/7MOR24KLnq41/UuREZwuZpjh0GMX4+gCeAbUnDXmFXKcUuCoIGWcxKegzi6JBBqAzpQQIZZlQ4+BfMGlE4pTWgQc77oxYje9q5U7znY=
Received: from DUZPR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::9) by AS8PR08MB7815.eurprd08.prod.outlook.com
 (2603:10a6:20b:529::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.19; Thu, 5 Jun
 2025 13:18:40 +0000
Received: from DB1PEPF000509F2.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::38) by DUZPR01CA0016.outlook.office365.com
 (2603:10a6:10:46b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.33 via Frontend Transport; Thu,
 5 Jun 2025 13:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 2.136.200.136)
 smtp.mailfrom=technica-engineering.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=technica-engineering.de;
Received-SPF: Fail (protection.outlook.com: domain of technica-engineering.de
 does not designate 2.136.200.136 as permitted sender)
 receiver=protection.outlook.com; client-ip=2.136.200.136;
 helo=jump.ad.technica-electronics.es;
Received: from jump.ad.technica-electronics.es (2.136.200.136) by
 DB1PEPF000509F2.mail.protection.outlook.com (10.167.242.148) with Microsoft
 SMTP Server id 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 13:18:39
 +0000
Received: from dalek.ad.technica-electronics.es (unknown [10.10.2.101])
	by jump.ad.technica-electronics.es (Postfix) with ESMTP id 9ACA640175;
	Thu,  5 Jun 2025 15:18:38 +0200 (CEST)
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
Subject: Re: [PATCH net] macsec: MACsec SCI assignment for ES = 0
Date: Thu,  5 Jun 2025 15:17:15 +0200
Message-ID: <20250605131835.3883275-1-carlos.fernandez@technica-engineering.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604123407.2795263-1-carlos.fernandez@technica-engineering.de>
References: <20250604123407.2795263-1-carlos.fernandez@technica-engineering.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F2:EE_|AS8PR08MB7815:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c8f57854-b9a4-4589-c5ab-08dda4337c49
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NH9RJW7pSkrpmm/qdEsy7U1XJcltSbA8ngfAPb8d/ZnBm1qMCeUB/zHDf2Kt?=
 =?us-ascii?Q?dAFBNCJmKF5oD1bEYHR6xMaOri3JofDA4Q+ffgHQ4M7R+PDfxGFWE3dOx/vO?=
 =?us-ascii?Q?qLaQM4/JgE/o3M0oLNzd/qU5v/CiUkx0FW1cfkzmKo46FwSBXpztkWpx0boQ?=
 =?us-ascii?Q?FbvqnD0I8xLWlhQI1LSInrNSCEY1vyNRCl6u3mjmDAp0nSo0IzESohFQ/skr?=
 =?us-ascii?Q?5a+6mCb6PhzDE7SDeCqVEI23fMfLSSsVnFfs4iIb74XwCdXLVsr/DpTVgpJt?=
 =?us-ascii?Q?CwvH0qvBANkoKTScF4zpNSiixju1jaX4B9+hZalniugmCPErDFh0d0x72nS3?=
 =?us-ascii?Q?CQeeyPO6b2Fu9BqkBSifiPy0tjcijttFupNFIu6Yffbwy5eRNzh1kdMjlJiW?=
 =?us-ascii?Q?69MHe2z5O/vvPvESUaVSKU68Ktchu4Mt7WLi4JM7GTyHMtPXoKX2+FuWBFnM?=
 =?us-ascii?Q?v0B9vC8bonCoGGdrpbrSUYuJm+mehDUm4uIXyyj/S6ZAqzYDwuld+q0oE72R?=
 =?us-ascii?Q?W2YHt3O29qcWrmhLPv9GqAZ+GKC04Zzxz9eK4C367/fiaT173QpLS9yBHQyn?=
 =?us-ascii?Q?QS5ze10P/+bNHpyA0eIvpFJTa5qpHRop0VSplXf3ky/6Z77BtGuHG/G8p8l8?=
 =?us-ascii?Q?xcourX1sLSx2atTxe71MAq/gcYHIby2WryJXDTDFjRZJX6HHPAV677XKrdup?=
 =?us-ascii?Q?e7hjRnKor6VwxbdCBD3l36TzEf8Db1WuhgVeHQ+5Yp7D1YUVPo0wrkK04AiA?=
 =?us-ascii?Q?dXghWNQXhyOL3mvVXjrCJXoHoR7fmKKEW7wRb5K/zsUHwQr+TCCO6T3C9xlM?=
 =?us-ascii?Q?nkf7hyERwxHs4GH+xxtITNtavWtOV/qCuUwRGIjwmzb19VWiO1cHMLm4v+5t?=
 =?us-ascii?Q?EShTXEAN6EJjDVHF8KgjzSD5Sea12JD/fE+wJVF9qgqeBR2L1kPasOTI95GC?=
 =?us-ascii?Q?WNq88cmiTGWYVokNBGTU2eTv3l5CPTjverqLIGKp/aCye0qhtR16PSyCGmS2?=
 =?us-ascii?Q?bsB4UOVxffFqvZerLU1PfrmXMPWO3SqG08iVrxtTB6scyb99KDvcZhyvv3W2?=
 =?us-ascii?Q?+sI2kL9QsdX4pkzk5Jb61M1gPXh6C+yEPg47vKlfW7Ei/eFgS3gcrZX5IQ4E?=
 =?us-ascii?Q?1cSRGKMgKdQNiP6R7MZFexMkWU8cHjE31gh+bTX9lmO5uvJw5fTPp1H1vxw4?=
 =?us-ascii?Q?5LOwQnotrJfbdo/XnoIKMrCSd14q30Vt8UodGOYUET6s62h8+8VULuO8YNqJ?=
 =?us-ascii?Q?0xIR5GIMpxUI4ZqEpRmUP/CaoNAnnwkqZCwogVuXg1OU/6woaPc6K+e+6YTM?=
 =?us-ascii?Q?uwv7QZ62xJPZRpnbQLTV7GlxedWuMFo5XDmg+2dpoKlOu3bn8CZX8Cj/QeiT?=
 =?us-ascii?Q?OP1QEtdzI2vPjgww5dH6Erwf25WW2/4dPpZO4psep18Ra7X4bcdYv5Xbg6AA?=
 =?us-ascii?Q?xBJb8OaAcfgLz9nb8r3bNCmBiKbzC6YWq+2cq6SimNF9sCzwcin9BJP0f+ja?=
 =?us-ascii?Q?JvXfG3ImRFs87ae3vF15Pjaf6u53g5OVzhOu?=
X-Forefront-Antispam-Report:
	CIP:2.136.200.136;CTRY:ES;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jump.ad.technica-electronics.es;PTR:136.red-2-136-200.staticip.rima-tde.net;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: technica-engineering.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 13:18:39.0664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f57854-b9a4-4589-c5ab-08dda4337c49
X-MS-Exchange-CrossTenant-Id: 1f04372a-6892-44e3-8f58-03845e1a70c1
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1f04372a-6892-44e3-8f58-03845e1a70c1;Ip=[2.136.200.136];Helo=[jump.ad.technica-electronics.es]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7815

Hi Sundeep, 

In order to test this scenario, ES and SC flags must be 0 and 
port identifier should be different than 1.

In order to test it, I runned the following commands that configure
two network interfaces on qemu over different namespaces.

After applying this configuration, MACsec ping works in the patched version 
but fails with the original code.

I'll paste the script commands here. Hope it helps your testing.

PORT=11
SEND_SCI="off"
ETH1_MAC="52:54:00:12:34:57"
ETH0_MAC="52:54:00:12:34:56"
ENCRYPT="on"

ip netns add macsec1
ip netns add macsec0
ip link set eth0 netns macsec0
ip link set eth1 netns macsec1
  
ip netns exec macsec0 ip link add link eth0 macsec0 type macsec port $PORT send_sci $SEND_SCI end_station off encrypt $ENCRYPT
ip netns exec macsec0 ip macsec add macsec0 tx sa 0 pn 2 on key 01 12345678901234567890123456789012
ip netns exec macsec0 ip macsec add macsec0 rx port $PORT address $ETH1_MAC 
ip netns exec macsec0 ip macsec add macsec0 rx port $PORT address $ETH1_MAC sa 0 pn 2 on key 02 09876543210987654321098765432109
ip netns exec macsec0 ip link set dev macsec0 up
ip netns exec macsec0 ip addr add 10.10.12.1/24 dev macsec0

ip netns exec macsec1 ip link add link eth1 macsec1 type macsec port $PORT send_sci $SEND_SCI end_station off encrypt $ENCRYPT
ip netns exec macsec1 ip macsec add macsec1 tx sa 0 pn 2 on key 02 09876543210987654321098765432109
ip netns exec macsec1 ip macsec add macsec1 rx port $PORT address $ETH0_MAC 
ip netns exec macsec1 ip macsec add macsec1 rx port $PORT address $ETH0_MAC sa 0 pn 2 on key 01 12345678901234567890123456789012
ip netns exec macsec1 ip link set dev macsec1 up
ip netns exec macsec1 ip addr add 10.10.12.2/24 dev macsec1

ip netns exec macsec1 ping 10.10.12.1 #Ping works on patched version.

Thanks, 
Carlos

