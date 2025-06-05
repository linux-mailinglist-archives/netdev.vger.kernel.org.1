Return-Path: <netdev+bounces-195245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAA9ACF044
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 15:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C014118868C9
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 13:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571C2230BCE;
	Thu,  5 Jun 2025 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b="GVro/Pl6"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023084.outbound.protection.outlook.com [40.107.159.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9723522FDE8;
	Thu,  5 Jun 2025 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749129683; cv=fail; b=Nc31rCZlQYT0n7bwPlN7lnsn7e1pfaTfTNUidy10poG2kv2oQcjGURHqa2ifNVxlGtgpx97jCwkBV5siyrHJS2vrAoOY/5xvD6lxbabiKG9/5Tle4x6u+Ls1tZ1F6cVtUCFW2a+PIezVAEDloorMEqHg6uX8O/bNHs1FjExozAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749129683; c=relaxed/simple;
	bh=qpJXy7hTFUO7cf9Ge50lXnlSOj2/KjRWbvKfaFU4B8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lUBrnl4v2fqVVRK6Ek/Qlm2M+VYPXOELGd8URwcp265XBYQvy/KUsb5tlA+esohHEHBQjFPFqc1qWnJTi8P/4YgTSFgcwcZEki3xWFY7TQ/4c9M1+tfTM9CEErwr1xDZyCh8qycJVOAh2lmnqBZuBFufBq1RQt6iZSZ199WZikg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de; spf=pass smtp.mailfrom=technica-engineering.de; dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b=GVro/Pl6; arc=fail smtp.client-ip=40.107.159.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technica-engineering.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCafJI8ic3RG6qFGOQHK7CHGR1RJ5Bo7zSRZVudIh5Z1GuuHsQhpKD5qFlymngbsApXEOzG7OcRQ4AhjBLYB5hraMOPrg54um/gMdjGnehNQOWPp1SlrJMfkmtsRo9ItkUNe/E50e3klic1hr3ko+31MPYOO6cF2XlRb5555HiuXPABLVKa6AuBG8bTt17MoBRkWfpB/LeQy2u4c8/9PgIzS69nzCD7t6o2lnv2mcTGeKVfqRBehOFD8yrdyDESGA3zb/MkcA6Og/F+o5TcPRtvO1Ym1Rf3z8MVWUParMf+f98s41ViK9s1d3RngSrlslfs9NDiIGdfjbiWqsmrWPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITODzLQi1PckBoaXElyKR3IRhQzDzOjsE8ZrKJAG49U=;
 b=mDDEKQQAOf5RaRRd9yjK5rsL9bhQy+WQjjOkVlS9EKl3mCOTi8j3V3obaIQXwTzOYzZM1BKNo91n2eunLvhpXyO0Xf9ATHIsnhUKSd0rdN2SGXu+T7kBMva+wWohQK05ID6Vik4YZVP3RoVh1oeIUYDbuTDRR9+TU4XVImz6kLllFTO8vEpoYCyqRVl4ziRnXuefZppNxcPYDs4rLvmZAPJnVDF9XD0lUk9XvLjq2elqkasWSo6wxJiDuHUVNym15jnU0OYcN+Nkhx0g4Mu3RfJhl/nEUeK+30XJaHM6BC9v+h0tp2nqgJJxKfxVjP/vszVC2rCfD8GoLk+RW2eWqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 2.136.200.136) smtp.rcpttodomain=davemloft.net
 smtp.mailfrom=technica-engineering.de; dmarc=fail (p=reject sp=reject
 pct=100) action=oreject header.from=technica-engineering.de; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technica-engineering.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITODzLQi1PckBoaXElyKR3IRhQzDzOjsE8ZrKJAG49U=;
 b=GVro/Pl6kBd4D3Y0BMFji8DtQh9kgwaaMX5ngxhkdprAST67jEp5BawzwHc42wHeJ0gWZFdiVvxpJQZ+x2qmdrlIDl7KscrevQZ+7kEXhyACzWrxcGtQiEZsGjjCwK2a0saj0yDBpkBHE1cJM/0TxHj2JFxn7MKe3liG+3ukbtQ=
Received: from VI1PR0902CA0026.eurprd09.prod.outlook.com (2603:10a6:802:1::15)
 by DU0PR08MB8883.eurprd08.prod.outlook.com (2603:10a6:10:47e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Thu, 5 Jun
 2025 13:21:15 +0000
Received: from DU2PEPF00028D0F.eurprd03.prod.outlook.com
 (2603:10a6:802:1:cafe::ea) by VI1PR0902CA0026.outlook.office365.com
 (2603:10a6:802:1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.32 via Frontend Transport; Thu,
 5 Jun 2025 13:21:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 2.136.200.136)
 smtp.mailfrom=technica-engineering.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=technica-engineering.de;
Received-SPF: Fail (protection.outlook.com: domain of technica-engineering.de
 does not designate 2.136.200.136 as permitted sender)
 receiver=protection.outlook.com; client-ip=2.136.200.136;
 helo=jump.ad.technica-electronics.es;
Received: from jump.ad.technica-electronics.es (2.136.200.136) by
 DU2PEPF00028D0F.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server id 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 13:21:12
 +0000
Received: from dalek.ad.technica-electronics.es (unknown [10.10.2.101])
	by jump.ad.technica-electronics.es (Postfix) with ESMTP id 3DB09402BC;
	Thu,  5 Jun 2025 15:21:12 +0200 (CEST)
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
Subject: Re: [PATCH net v3] macsec: MACsec SCI assignment for ES = 0
Date: Thu,  5 Jun 2025 15:21:04 +0200
Message-ID: <20250605132110.3922404-1-carlos.fernandez@technica-engineering.de>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0F:EE_|DU0PR08MB8883:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 17a1346c-65a9-4aff-0efe-08dda433d7c8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rdk9G68RbjTjKO7uigRRuishuwTGtXrMdHESM0Wjn81oPPkVotCN2sydbn54?=
 =?us-ascii?Q?EAR2LuTXRqIL47d+onQRypa15n9JWqk4ORo7/avryEe/RjdrMVl8ZqVoRMOQ?=
 =?us-ascii?Q?1RGN9OGLUI2P4Pm29cbS3aQ9W6Yl4vSd9UOZp+qNYAUqUk83izh9J2LH6U6v?=
 =?us-ascii?Q?Ebepw3JXrEASTxUEMNcBd8ZLnohzRzqAi576+INRNL9oHW9RRRPk7SCuKY+y?=
 =?us-ascii?Q?JrLywb+Y67BQtykNHb8tweT5ylrqSWH4Mj9sSkP2bT1GYEybHfdSBBw3WEYW?=
 =?us-ascii?Q?LG9TyLwt+pbQ88lEZM/j6yE4KO4u8CreWRh4n7RMkunssXFhIYX9Jc2J0rWj?=
 =?us-ascii?Q?+kjx5+NdhrMP/TQXobCpG+aJSBvwj6VpZ+t/56ta45DUeSwdMVrVa2XHkArt?=
 =?us-ascii?Q?90tfzL+ZUuz/BhC8DzB+TmC/KvuZ0o9YKZtfkt748TQbH9GK0pImkGzwT8KQ?=
 =?us-ascii?Q?F/pI1gmLnwJYw0UXSsofQ8DcaswAe+RQVZAuSGXbbobcbxU3AwN0cZ/L826W?=
 =?us-ascii?Q?fewjtDspM5tlcyMjuKbWmotXqbC227wnZ+QBg+84qNH+15JUk5BBW7GYtvrB?=
 =?us-ascii?Q?Y8brXY353ijJdnePJ7eK/p+FzBgYFyLlm9uAz27QFDy3WWtDc9PKZOHMSIVm?=
 =?us-ascii?Q?dB+QB8UqBOpFnHjisvQ+Pbl2v1uXLb2M34dEOfvCGaZIQtLZUC5l95QNTXIv?=
 =?us-ascii?Q?IpY+lQbvmGIVDkrIl4ATtIXyUHXdxm/ZMSaQOu4DmK2wFETaGx+PO8lup+KL?=
 =?us-ascii?Q?sQyRGVZf0I6WBbSf07Jw/B6lYq12wm2urqT2gb7RclkVfpxesq7NBEhCc9C/?=
 =?us-ascii?Q?POBUS3ZK/fMIgzoHWk6UVpRNH3FidMZ512Tm/WdfSSsm/9UEujyBmivlVzlC?=
 =?us-ascii?Q?Woi5LM7+jYGyFiDhsQx8xg5J2bIlt9YOvtWl3UWKn366Q6AFOTYVnGkAW45R?=
 =?us-ascii?Q?++HH1Tvu1Z4v5IXZSLzI1E/80SdmQB0CYzT4XACuoozaTtcFBOE72t7UIrHh?=
 =?us-ascii?Q?ALe7FNFCtQUmst9e6ydJwj/dqLOngNxK+p3GSSe6RPE4wjkTBqB6Sw5CAE0x?=
 =?us-ascii?Q?L26L0+1YVF/Gr4H7qe1EQafGKK2+WcmR5AgPJ+De0V3fVPTWkkPO/wO0Dvuo?=
 =?us-ascii?Q?2TrHCPrqgS0rnwgHc4UJXgXXYGNxDwvZ4H68mHqkGZ4zgGkLCCifEm23eygZ?=
 =?us-ascii?Q?fO9Is7KMGL/m/74tIgJRKuzyQ9XNu6tgD+iqjRJIE71RPEryv6cOIsK0ARVt?=
 =?us-ascii?Q?5uFSJwhqfVIOaJajEQf7UsEWM/qiTD6QsPB3b//ZQf08HIB5wdVje16J0Yv1?=
 =?us-ascii?Q?j0nJkRpHyJeeRoebaXX26PdnM8b+WKyLdDOmIBHcZr+AaFc3iw67KAefdVao?=
 =?us-ascii?Q?tv2Ep6+nk/nh4891eoDJ9By0M8kL7vZEmeiKSrrp0NGpTwqw+m0jG2EhKnHy?=
 =?us-ascii?Q?yCbcp97wpsV1TMbZQUpGY+qLtdVmiGSiwV0vb6WmpYPIYZNzGZHlYn7zu4PL?=
 =?us-ascii?Q?J5gxLjpHD97+hUOi3l61UJxDhYFpyQwPrxQY?=
X-Forefront-Antispam-Report:
	CIP:2.136.200.136;CTRY:ES;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jump.ad.technica-electronics.es;PTR:136.red-2-136-200.staticip.rima-tde.net;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: technica-engineering.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 13:21:12.5693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a1346c-65a9-4aff-0efe-08dda433d7c8
X-MS-Exchange-CrossTenant-Id: 1f04372a-6892-44e3-8f58-03845e1a70c1
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1f04372a-6892-44e3-8f58-03845e1a70c1;Ip=[2.136.200.136];Helo=[jump.ad.technica-electronics.es]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8883

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

