Return-Path: <netdev+bounces-140000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F019B4FAC
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 17:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53554B226DB
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC291DD53B;
	Tue, 29 Oct 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ay2QwBnz"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2066.outbound.protection.outlook.com [40.107.249.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4255E1DBB0D;
	Tue, 29 Oct 2024 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730220222; cv=fail; b=AyIbt527/MCn2yoesyi6mJr9irYNNR/Nnk7508lXCs/IPu5W4loHTljSspjhY14o9Ikvh1kiVvDr+OYPpCexC+eObXaFIY8KucJr2ImOLGtn0Q+X2s/1iJsU5KOMS9nv39B1s8bD6diGDis8EDjO+xz0OnHHIpXhie8kmAxGtjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730220222; c=relaxed/simple;
	bh=gMTTh6pjMpVO0SRnvd7k4foOALc45+f+sny+9BqC1Mg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pjT8JUyW97jnAJbs6bAIVys3F7MXsNlEsk78p3NTEPbFG6gL+PdCg9+KbgP+nj+TTuvUIOSPX/VhQTUSR7RVoNmYdOwmzrw/b2SJ/wZNkb1j6InvYpJMFzXCOo/xk3oM52kAy9TI+q78NvC7TwIhBddKwrx63DRIKz4rKrrxnEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ay2QwBnz; arc=fail smtp.client-ip=40.107.249.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTJTdkRUqe2mC5wY15sC+e4tLrLdWTwwy7eOidfeocEJDvdV1ry6Ae7afERh3VdRmCesnxcxJNjBhQYTcF4IKJ9pxEwBn09/XGwFQhAu8o5NA7AIs4Tk5FaJKSmvug3rHNhLx6dorCnscDJu5WrYwRqaMxqKdEtd6p89RQWhMhpjgKRwXnHafP6M8GE/giYcNA0Od8F5jJ3HMMqd2viRPIUqZW1EWzUQ1Fd6PQnPKd/SHxbn7zOy+1x5/TGZEW1Bf4HgrTHRvlepk8ght0kmmRTljrPlcPBcE9QfsZDzmI9tGI9zRsZXomu5ufnQ2tV1O0ThgNWLi9vGvuYOi2lB9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlX4tvx4PX6V1MC1MexVEXQxjIgRjTUSiiDURBbT6pc=;
 b=olt/jf3x1wL5eJfdDkZSSwAOPOUzytQINjIiqZY/6NMR4sACqn4Rgp3m/XtpbCE9Oh6IgxJCweYRH5vSVBcaw5rdAHHP0OwYE1Yl5sx0SfQVoVIF4VkaDZiCA+awh0l1A0of3UzryqfdgOvg/QdltDwP1WtF82BdY7PRe6pb999ftcBJwmoHfxxVGESpclEku7fAZ9FxpRpeb/lCegDd6VARyAoK3VdrJ/iSkeHSuVJJ9f8/eNpMnrM7GAnIBlleoqWSmJ/Gn3O77HDOuLmH2C4o1slcXkSLIHIO0F7mKp9q6sOiZbYKsFxM4FLe7vX6iHv5F03dS+tdCI5x5L88Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlX4tvx4PX6V1MC1MexVEXQxjIgRjTUSiiDURBbT6pc=;
 b=ay2QwBnzl8+Fj7g/37bBoKz8vTE9oOzF4YLFv3pAiFVNoil3GJcr87Y97r8Tq+nnxfhyHg9SmlfKbQvh4J3TuUxCgIeLmEGwbOSBbtTQEPOc9qp0EvwtZwX6EB+1B2P1to1Grt/Ker19Rpyfpr6fuO7Gr/1P1RXn0FZMHitDqAtixVrUDR+HCHv2p1uFI0iMtHxVeflXiJoV+pDxNSMs/cMW68f3ucW4HPUx0JmF9MBovMrltN1SLW0quc5uKySZQsdZ2I5BbCHnkxZNJkpsG+H4hKgutlCLrKP7pl1hC/WosDKJlUJmu7WSMSVsOwZ6qvtbzJ7ZW54u9JOf/kqgyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DUZPR04MB9871.eurprd04.prod.outlook.com (2603:10a6:10:4b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 16:43:33 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 16:43:33 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Radu Bulie <radu-andrei.bulie@nxp.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Sean Anderson <sean.anderson@linux.dev>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 3/3] net: dpaa_eth: extract hash using __be32 pointer in rx_default_dqrr()
Date: Tue, 29 Oct 2024 18:43:17 +0200
Message-Id: <20241029164317.50182-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029164317.50182-1-vladimir.oltean@nxp.com>
References: <20241029164317.50182-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0010.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::14) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DUZPR04MB9871:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a3d34d-d44c-4574-862c-08dcf838d341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UZ/yN0JVvZX13KsGOwJEeWXkbnGSY4wpBaA/cfCNl4NINaEOtV9uvl4Ona21?=
 =?us-ascii?Q?bfjNY3WS2JXu/M7bHBxFlOKeNAjsRnGPX/qs/ubWWI8NLoeYB+BONqoLA8d4?=
 =?us-ascii?Q?/rCvTdhgoovsDdi/ezt83Pw1GfsdB93/1eySWN8RUcX6Pm+R9LEjbmLLgUiq?=
 =?us-ascii?Q?0hBVTO7L9eJmGEC3RImQ1JhFWlqJXoamAoBJZ6qODFbaHNoYw0dB8gind2kb?=
 =?us-ascii?Q?P3PTYA3VzX1UliTqLbVF2i2FZN2Jqq+D24JBDcjRxsF0/aaCFT6Ku6G7uzVv?=
 =?us-ascii?Q?cBptBq0yiPBAYC9f46NzDJFbaWBXPst931ed/Gau/e2zOmcT/86hYkibM1Em?=
 =?us-ascii?Q?yYuMJl4Z+1CtYA5Qxr9KkqNetrmDpmCrRqXQ/thg+TwRpqxpBqEiqaPgsEFs?=
 =?us-ascii?Q?YRXf1nU9TfMj9k095to1Dnd0sOOZpyAXulSUYuxjPmoZIJEoD462dN+rOX1W?=
 =?us-ascii?Q?zU2/QUSsMWdiDPm1vhba0qXzSHjtcSuzPECe5Beyk3g6q1l6cHIeRHzVVYQi?=
 =?us-ascii?Q?99NdmDgMgyQ2jY/o8N2W79598IKIQsYsZFeYleqawR2A8vezQSCYnKp5g896?=
 =?us-ascii?Q?1uJ/9fRloiqvAVY8VzlmHpmTL5ybo6udPfGKixtZA6vvX9Y1cPFpFXB29ucf?=
 =?us-ascii?Q?gvJKd71BEnNJBd/4I+wGJXnBz1MIY9kAuuqruqj2iVm5iafIc/gaBF9PYhcZ?=
 =?us-ascii?Q?8JdgzL7iz8LFHvKrSo4ZegegAJCNLe9ajQ3/a2oyA78ueZbALe3xMoIS8+Vp?=
 =?us-ascii?Q?FYOXiq31folp2a/weXAkbeSdzMthG/7SiLdBwFJAKblpgaSbEbIIPLJdSPFF?=
 =?us-ascii?Q?/2UKvI5Ei6rCqYibiRlHQM7aniBB7Zb1CuSKSyBYk4h7KEmY6AUfUVEIS4TA?=
 =?us-ascii?Q?YrwAf6z3bgyItoR6H54qNYdm7+2yA2KCwWc0vaZWjZVWZ7JUwfzyFdJazUUt?=
 =?us-ascii?Q?TK/LYycCXhWqYou/O8waWaFHoD+vz3ZH4bCoyJOlsb4WnYzuxD6Fy315eDDR?=
 =?us-ascii?Q?ZM5GJ8Bg5o9c1Cbk/JkoqXdxoNvxcq9fiSjYlI27Zcjet4Wd0cq4mSvEFh71?=
 =?us-ascii?Q?xG0vMqTa+OqP6UKD5cJxW9xqyqFw1dqGnE+0wMVstOmpFfcR3vc5vdVt0uR+?=
 =?us-ascii?Q?N0IxhcD7Y+4XzsNCCjIjn7g8Ge9sZdQGR8eQAD2yMUA2i2LH4cg5SRA/J1in?=
 =?us-ascii?Q?6JN0KgvK8lI1Lvs5aH4iCvpVrwwm78vqF4ZlezagZokaaB+XPs6Lw7cAF2JC?=
 =?us-ascii?Q?nNsh4NUD2BAKUOqCnJhJGK/NFzBaJmS6bIVdr8A7r4REGlbZuPBNPS+5CD9n?=
 =?us-ascii?Q?uYmPXwK5u9jDeE8eJKnCZkrtx0WRWInfwrvcft3i3y95bSpv/QiE2NgYPKLb?=
 =?us-ascii?Q?oJPcfj4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V/P1oTBXVOMphf3eI3UPuyJVkv+2ohljAcMVb5NOMn9jR1j1V/nuAcwd43JP?=
 =?us-ascii?Q?S5DHyzkw4d0Fo7ux+dlXYmR5E6ilWKiXYIeXm8oibmvUPy0aY2PmOiYgkADP?=
 =?us-ascii?Q?8Ag1wSpFJEUbEmGjIto0LGCaClHXVFr/cpHlr/gBfsmPPrVfhu19nsGiDfeg?=
 =?us-ascii?Q?EU4VbL2nFWV1hkn6CoTni9tVACCci+qnYig0DyygasC339gNnZpueLT3cRE9?=
 =?us-ascii?Q?qRyvZlAcTASqeaYVTZzIWfa1gvJuSTBeWM0AZz9YxoAZuV3L6vfyveJTbp3G?=
 =?us-ascii?Q?MUe3u84V14GsAF5CewW9aM62NOc1YcgGFWjf80/t/qBV1PAtLCXZIfvVphCY?=
 =?us-ascii?Q?cA/durxWhDM/h6cmqGuC1f52EBM0Oz8Iru9Ang8QXMGeZdITlUX2ZeDZ5/+u?=
 =?us-ascii?Q?T8HfJsUr7pjh3BD39XJSjM6qNfZFiKaKh3GPNqNR9dS4jqJb4q0yBrFGxes0?=
 =?us-ascii?Q?D9uLf/LIfYr57/mPtrJU2wU/dnmuUrkrspP9o8YPAKw0rfIK7Zk1avAiTR1c?=
 =?us-ascii?Q?AvMQ1267x8Qc6rZpgJv0AAfByUJFkUSdFJdd9tfp3qo9zfupjNQs70tXpMSq?=
 =?us-ascii?Q?1MhSHVs83GP4AEGlozIxtE9MZNtJOCjGpQ8eQxUaCZguAesoRzks3kY2T2vL?=
 =?us-ascii?Q?nspUq3t07ax5tbfFFXlDcZUi7AskYMfAqpoM/llBegQkBWwNqQcukjs++9mF?=
 =?us-ascii?Q?gw8brnlLVNUDa2SWyOC1sFX4qMX20bKw2qE0CCsYL35ag9wGYbnrCWy2W67T?=
 =?us-ascii?Q?MW7s2b4xTytn+OCgydXXSt3Lh25edZxMg0B/FTiiCKsgKODyaPwY765FNNoI?=
 =?us-ascii?Q?DinVXtQC7lbTi+emvjmcPQGA+D1PZhHsE2fM5LeDVxnTfXUIhN/6iehXkEVn?=
 =?us-ascii?Q?VtPXZ6fe1klzi2hwjdFB+BT7SgMdVjWr5x+/yRv4T2qBfmlL325EbVw1mkfq?=
 =?us-ascii?Q?YYRmMQN/14sHZ2Kb7OckTnHN0K03Xl+v5AG+jSIGNZcC5ZAABfJSwepXrZDq?=
 =?us-ascii?Q?tmdskp35oJOxWwaqlU3A7GSDn6NsiTqEPJBGCc+HIkbtEhSPccoFn16kXYIp?=
 =?us-ascii?Q?3yzuaJC7iw/h8Te6FzDClyc39UvXbrGq9Z7ZpnHcY99mHwpJ9W3N+f1/dn4v?=
 =?us-ascii?Q?oLQdgzpj9JrOuLfMxYAT0yBzkcuq+XYc6p76nheB9QyIIjk8bB3mz7CqgXFl?=
 =?us-ascii?Q?gjPvapgEW47aXljoXx3TCftToUN1Y9l0oR5bjZnjaDCdDyikEUCSjrrIJiwr?=
 =?us-ascii?Q?Zl0aQ/aCPjDXOUEj+cWnLG3o79e9rW4o/HLsFwWCQeMZUNEdQKhHHEegGUvv?=
 =?us-ascii?Q?+3TVhbuT8APMA0PO3lbEreRD9ivsMEwlPxZlqmlrGYZFiRQm1Xz2S9Mb+iBZ?=
 =?us-ascii?Q?bjitBgt/+NLrYtp5cYALzXvk6bJrxq6ths4KDAELX1KaTpTo830bMDKX4/AQ?=
 =?us-ascii?Q?65kAl7DbEQ09QIcb+siZhUO0gIPPKWY2445pz1RlqdnUY+LK39H2BTC+h9+3?=
 =?us-ascii?Q?8eNUvNi5iyU4Q/2j3WmzQ9EPSOV3tZ9lfYM+oT522PmrIATaDsGe8rkKMrb4?=
 =?us-ascii?Q?LA8TCeVr0SmboV2yEbrcUenGxkwS6DvlZLoR2R3f96mjovKpsWvus6FMpA2I?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a3d34d-d44c-4574-862c-08dcf838d341
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:43:32.9899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwx3zVYtpcLVaQjU8lO2kz3576C2gXphFgZfWkCPo98zoEPuNO793D3zxvWOgIKt1d23Srvddbgklmqw9SgCjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9871

Sparse provides the following output:

warning: cast to restricted __be32

This is a harmless warning due to the fact that we dereference the hash
stored in the FD using an incorrect type annotation. Suppress the
warning by using the correct __be32 type instead of u32. No functional
change.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index e280013afa63..bf5baef5c3e0 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2772,7 +2772,7 @@ static enum qman_cb_dqrr_result rx_default_dqrr(struct qman_portal *portal,
 	if (net_dev->features & NETIF_F_RXHASH && priv->keygen_in_use &&
 	    !fman_port_get_hash_result_offset(priv->mac_dev->port[RX],
 					      &hash_offset)) {
-		hash = be32_to_cpu(*(u32 *)(vaddr + hash_offset));
+		hash = be32_to_cpu(*(__be32 *)(vaddr + hash_offset));
 		hash_valid = true;
 	}
 
-- 
2.34.1


