Return-Path: <netdev+bounces-69445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A51484B377
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 12:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75C71C22200
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 11:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74A912F39E;
	Tue,  6 Feb 2024 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qYd5swwU"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2057.outbound.protection.outlook.com [40.107.14.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87DA12EBF0
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218987; cv=fail; b=DAOCTeAB5pAFpR8X/Bu20HBx8GGRzQdWZ2i4S6zJ4TvEyrGP/e7CsEU4TkGlerUD5lj2JfHq+MXGqxLcGMKe56wuOtbKmfxtB5BrPzimRc4f+CYLjbRu27YwbillBSSCeW9iXrnAzjhM1SWT+2jFV2VqvQZFnAfCj/m8f2T7MnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218987; c=relaxed/simple;
	bh=q3Yajsj4A2WFX8f/rC6ThwVlEmAH3DH8Hn4j1UVJhGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YijKdbq+M/f0cffFZuvRj1/TifqywQuYgxOVebZcPST0rFRKywEzukBcDqKTj4eP/vtijqxFWiTcYq91mZ0wXKmvBMXL3FzYNcFu6iFV6k8xfI/Q9AEK5rUst1tyqBH1sVVBHA5vm13VNTo8dCyuhtp2Hrn+oL1I/iB2QkxwM4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qYd5swwU; arc=fail smtp.client-ip=40.107.14.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDUpEEiBfSA6PhYL1ZaseEHjsIzIHjcKKEHkBQhYrpiwdJccj96o5BPlfqUfgB7VDyiEaeISTRtjetotesd6cqfSiETAoo26yMXc2gcA4gRFhac8tCJ8yT79AvevCJtXor5KfIAdP+TH+ifteNMpj52MEqz4krq8PdhvQT7SlsDtKKwm2IkpyqPX97sk2D6F3Ek7XqDGsDSfzGmit0NvTg9UNHiE4vg2J3taNvQpuvG4Cl53GOLOK0uuVvjmKwFTodF3RGmpOyQfSN/u/jqacxLHbp7rXYPt60Yfyx7wNjxgDopDRBWN3qj5Fxv6bJWkC+H4An/ntLBljbjZzPkAbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guHR6aKZklc9e/p18GgalTV/YMmkWlgahxzB/XkbK0g=;
 b=jAFFrr2je7xtgjYLWG4FmNj3Ejm/rQlJ+robGdVAfIPdA0vXuNf2rRf6feLpK/wUvLMLPTRRZoqZOXjvL78tHGLsrtnqpmSpqehdEGuPq/J3furwsnwzO+mfo0kHJsDt7x6G6mQzEk2EjJEy2ABgpZvU7ITYmHVQHU8W/Zb2c9D04pvPMwyBZoq5MClz8t+2yHAJUi7WgHNaHhjt8EQsyPTnuINuAD08HB8Lo/qf4diyeLIxx5HWnuFwXH5L8FQ/0Sbze31T7kILdM/xo0zkR9in5xy7m9H1i/3R8tEx+W0uH0z29HcbjOJN3r+LjgCsiSnkD1bdYr/3db/Hf+fo3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guHR6aKZklc9e/p18GgalTV/YMmkWlgahxzB/XkbK0g=;
 b=qYd5swwUcuzcy8Y6Ar2nSiDwzoC1L7egueJAiAnrm3o05V2sJjhVq10Xv0TuycV+5uNsdcCoyXSiEEDt3sw0BIIp4DoXy4qp1geV2IhR8N3w516BeM3xBZyNs4sdY1D90bc5K8ThCC7+5lXGSVeMbMa3+Vot66W0nijguyytqfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by PAXPR04MB9057.eurprd04.prod.outlook.com (2603:10a6:102:230::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 11:29:41 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34%7]) with mapi id 15.20.7249.027; Tue, 6 Feb 2024
 11:29:41 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net-next 2/2] net: dsa: tag_sja1105: remove "inline" keyword
Date: Tue,  6 Feb 2024 13:29:27 +0200
Message-Id: <20240206112927.4134375-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206112927.4134375-1-vladimir.oltean@nxp.com>
References: <20240206112927.4134375-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR08CA0028.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::41) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|PAXPR04MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: 0edb6dcf-0be2-4405-145f-08dc2706e8c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ihn20aVlmlwgHaniT1gLFtZpnqIFCBSEN8drJd1umxnu3UvltSRWeHAw29cKOqJ0x7yH8rABEJqqzdrimqEBG7TQrbvST1S7TolsubO28iFpRJap0PlGysnazu6S3bOQh19ytzMpXdixeAsSmEWXR9namQyhKTFoM0/Sn7w1b83IqktIFNoBxqAMqZb/cyA2KCyRfZ/irHCVMNjqn3UrOkl/nrY1WQJCbNTGoZ4DZCPYpXAvYbIto7FV//55KA9F8szzHguAW9+iN1Klhb9j52d2UDy0hRQBqHTQEIAXfAWkemPVuMv8F7lIaTbKxCYvjUVNcZb5/6kKzq0GctNRwtlzf/yShaby/CehscSFTD7xaL49D1pJSNCoQotZ/2mvMGYhE/nLikyMyGcfSVdR/xnsC59VM8frdb6ujDtxGajo4slWmM/Q1T8/2wHe19SeLy6lPPj2dnIvi8ei2mCK8LO83uQihdqR03WCEfYR7QUheb26pNplaEDk+Guf33AMhBSFJm3QSkSr3oO7PvRPNNgzeRfwt3QsgJw40gINP7Y+P+XVdYkLYuuNlzpA3h1UJiXh42d8m2ESKlW6a/4twlIcEXTTgqvbnl9/xloDLBZg4bcH9WrOdebdiqLicN9t
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(36756003)(38350700005)(4326008)(8936002)(44832011)(86362001)(41300700001)(478600001)(6486002)(66556008)(66476007)(54906003)(6916009)(316002)(66946007)(2906002)(2616005)(26005)(8676002)(38100700002)(5660300002)(6666004)(6506007)(83380400001)(1076003)(52116002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LSwFVhZUuDk6MzoPAcsWPRbjjyEKtC2IEivkxRh4bRbtTv3LIeSuWMs7bWld?=
 =?us-ascii?Q?SsY6VCNiQovKqA6Z/DhEAMA4hWT1ZPp6/ovRTmnOUmzPvIfYNvDQLXkjSgwH?=
 =?us-ascii?Q?bgcdh62yVqf22y9tIV99NO7O6kCNYUCbkDKntEWmWrJ78TUMzOnYp6QavwG1?=
 =?us-ascii?Q?jYbO84tQbqVSSTWLVtmzjlaMkHrtYpqjL4vriI5DuwGRCY5X317ajtY8QF6L?=
 =?us-ascii?Q?DqAjvh7c/qHv+NhiiUM0Hys38rJwSv1VDhs2j0q/N80AVi51vzBfVBLR6sF3?=
 =?us-ascii?Q?A9It7KwRABGtS2Nx2LXDWRkOEOjNjJIuyioIzwCf0kvS2sGhUL/Cl3JqrWVT?=
 =?us-ascii?Q?NzpcDKOEL3hVYeqqTmNjtorLMh/0eUn3YM72sekpLW+OUmm4KP8s4g1lkqKc?=
 =?us-ascii?Q?fJ6j1VRuQ7rZl/411WXmBkrxEgWKwpnxA70pHWthMnYzaRbgNH8D8fd1Qy/d?=
 =?us-ascii?Q?IzgnleMeLJfJYpSKAQwX/f7yEf3SRYxYtE1oyp5OJDSZb0WL6B98ybb5xaTl?=
 =?us-ascii?Q?lpxe/Su496sUZBJPb1T5Sw20R7wBilkpu4EwxhS8YfLlMRDQmZG939mOQHwx?=
 =?us-ascii?Q?ayVB1Eh5z1f0Ou2am8mef6SIp/2QuwhHcfN8KB7wXkf8vb0f4vxl1dgWukWr?=
 =?us-ascii?Q?dFVaccDQFiTpiuqpl/E7IVwR4vKVhdDwPY7O9TLRQ4tuneB9o4mYBQP9mXus?=
 =?us-ascii?Q?m4SBXVBpgJoh4kGaFpizymLsVg1CLOgiaK5UTz8bqjUhtSprSbzLGFFX2D1c?=
 =?us-ascii?Q?8dvxNXNaB5qSqcubSnq0dvwdQ6z1dJzkQPlXJKT6e6yMaziBagXVSH1vWFud?=
 =?us-ascii?Q?f2tP7ky+OcPVbZ/3LeKeUGCqoIWrlaoOuMPwKuQbV2KQHyySb7/LMRUVlVn+?=
 =?us-ascii?Q?czov1SA+fKSwwh5OEhlqGekO0fxzy6//7fmZ1hgQ5B3zmfHTe/1BwMqNVqaz?=
 =?us-ascii?Q?S+NY6iFzVAYptkLTIdHDHmQK/jouhu1le+tLU010qSkmX2SLCyrcbEpIOofL?=
 =?us-ascii?Q?dMYVPxDep467trL6G7ttZ3E3LJ0j0mrVb8iZdLN/3ZiBg4tvKusbh30gokVR?=
 =?us-ascii?Q?VE1LpT4YtLJvSqpGjC3R2aj3Re55/pSxdBDfGol87HKf2iigXJluccugHBvR?=
 =?us-ascii?Q?FSf9l0qCDEx7pOu13lWsgLJl3paax5OqGsOq+SHkIM5wJGlM2VnQj/6Os3ot?=
 =?us-ascii?Q?q9VRJH1NSeHlUm2UPAz+b5GQaq+tHTd8q9fIDrHWqkfyV02+VJVOyQw4N9Fl?=
 =?us-ascii?Q?kTCsynzwHRaC/MBId+tGnJJ8l9/D+DDHepd5sO0EotBMzu3xudQxew4Rrz0/?=
 =?us-ascii?Q?YU8HhxM9Qvp6GkzRuCA7mwqyEBJHokGu8qHPQWdAKQ9Jz81Ld8NyU8u42QdF?=
 =?us-ascii?Q?PFItGDQEE6QhMQ9Mx4IUrgcY44aVXD5EAMHNHn+RoBzUpJMWn6YSvyfUofLa?=
 =?us-ascii?Q?zAj4WgXVTUXi4ua1FjEzxkUoeQSqaU2eOKynBXeH2bSzlzVvFWQqCK1nD/uy?=
 =?us-ascii?Q?P9+QX3KlBqWwZq3R72mVXPrDoWqNe44g2DgPVOk3YQDLEhWLv582CUmwYewE?=
 =?us-ascii?Q?qCZCEOCK6YWwZ+adZZwnB0ah0gWXt77rlRCHhPK7DAzKiSi7xZIt0GZIebCR?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edb6dcf-0be2-4405-145f-08dc2706e8c5
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 11:29:41.0991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jD5Unk3Er8L+jB72GEzU4H1IlUIIGr6n0H0cYvwIp0M019DwWvR0PDZosm8dPseBs36NrSJ6FCQrAoYvBYgLow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9057

The convention is to not use the "inline" keyword for functions in C
files, but to let the compiler choose.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/tag_sja1105.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index 2717e9d7b612..1aba1d05c27a 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -75,7 +75,7 @@ sja1105_tagger_private(struct dsa_switch *ds)
 }
 
 /* Similar to is_link_local_ether_addr(hdr->h_dest) but also covers PTP */
-static inline bool sja1105_is_link_local(const struct sk_buff *skb)
+static bool sja1105_is_link_local(const struct sk_buff *skb)
 {
 	const struct ethhdr *hdr = eth_hdr(skb);
 	u64 dmac = ether_addr_to_u64(hdr->h_dest);
@@ -121,7 +121,7 @@ static void sja1105_meta_unpack(const struct sk_buff *skb,
 	packing(buf + 7, &meta->switch_id,   7, 0, 1, UNPACK, 0);
 }
 
-static inline bool sja1105_is_meta_frame(const struct sk_buff *skb)
+static bool sja1105_is_meta_frame(const struct sk_buff *skb)
 {
 	const struct ethhdr *hdr = eth_hdr(skb);
 	u64 smac = ether_addr_to_u64(hdr->h_source);
-- 
2.34.1


