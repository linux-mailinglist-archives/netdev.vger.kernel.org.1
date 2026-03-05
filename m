Return-Path: <netdev+bounces-264469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEBhI8anqWlSBwEAu9opvQ
	(envelope-from <netdev+bounces-264469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:56:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0615F214F38
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E352B3013ED0
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 15:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EDC3A7F70;
	Thu,  5 Mar 2026 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="VLAs4tpL"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021081.outbound.protection.outlook.com [40.107.74.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7182366803;
	Thu,  5 Mar 2026 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726210; cv=fail; b=tUscMY1DLqmlMjARo2ILeeNWwzTdRdj2zohfjySHgvXUMP8/IbQPjtu878LP4j1+R7mUBw/R0xWEF+3g/hnWHqtSBbVX1zvDNUuQdak1vGORBfp9fxcFsvYyq//b3gGS/HqL8CrBHaf/2d9BNF6ijnSOQbl7xkVOvQgGSsrilfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726210; c=relaxed/simple;
	bh=2SwLOxCcbOcrJlfGSDcWegSZ9mGw3x0lmuxGk5ard68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ge4KNx+bFpjlUsUx/0XrH5DhWIn6j6WSwLIOvZq9woPOf2ZvofylDoRX/FmY1TSLUFBHOg47AYgHxzqaaE/ljSp+X2SH5wp4TSLn6qv9euieUxQFdpH6mJfoqU2iNIycEfHCCp7EXf4dlq+zM6naEdZUUw/DBdpwqj4p4PTz/oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=VLAs4tpL; arc=fail smtp.client-ip=40.107.74.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/8TwtZA09MphEOew+EHi964OyszY7QdCA/CKolaL8TwxhBJyEaOkbKJLRfqclBiLwbDyx69F6Ai45Z5/HMp2MlIsIJDCfMcz9kGx05Z2NlVzS5XcANED1TqpehpWMHu2qt9bJjDuOIfH75L6ipw9v9G9jPbLycCzYOVStl+Adon+ArcDdezhFfKOzWJdHThiFEimCU42GhX1RNLvZspBCCPF4pnNO/t1IWY+mRLgi7NmanpP3/MF0HB3eP3WnxWctGW454Zvq8/L53mY3ulrmK3pIo0CoNiU9U/iFCZFxiq5aylHqQhwWbGpdcxkHoG3BDd1yrRiuyufLfgXIOGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+LRddvNKZhICXhZVakAF/zDQqryIGwJHp6IE6sTRtM=;
 b=dxrKegGE0hKYM8jr+4uV6HKjjO+m6YIoipsNwQIz/LBBBQ7Dvd97m/4Sjrfh9lHS2OS9E1grnpasAKhsUw0hJK1dDuCdpYG2fUkXiE4RudM1FnWsvVBszGFctGS++WNCr3eo6mp7H4h2x+SSy2/9BFVPB300in3sk82Hz/YGFEsbhOheRoamXzUETXD4fCTlAjnwcP3rOjMnwwf/dA/6RDVijgL7uAfiqkxPM3GZnkmTnSU5fyOgFAbkhqtkFVV1ITGOyWJ1F8WKBSZIU8CNbFKzi30HEK7Wo5H4oIXyxmdcc4buXbwebkX9Sn157Mz0uNncBrNjDaa6PA6I+X0ERg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+LRddvNKZhICXhZVakAF/zDQqryIGwJHp6IE6sTRtM=;
 b=VLAs4tpLR3jrS4OX9mPKmsnCxterrvyByzIBIOgc0mOxm2utvyEvsbhpwU30egzVBH8kDEl5+hIQFvYDZL981Bbfmnp2S+lR9gunkyBGka0ZEHCI49b8TKGjxJDRtLH23xrHtvPlh+4wjE/SziShXvnMpFnzr6Bfep+AlqILeI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TY3P286MB2756.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 15:56:44 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%3]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 15:56:44 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] net: ntb_netdev: Introduce per-queue context
Date: Fri,  6 Mar 2026 00:56:36 +0900
Message-ID: <20260305155639.1885517-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305155639.1885517-1-den@valinux.co.jp>
References: <20260305155639.1885517-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0091.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::14) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TY3P286MB2756:EE_
X-MS-Office365-Filtering-Correlation-Id: b4342f9a-7e89-4751-a75d-08de7acfcc7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	8XFu/um0jN7N1T3BgizsRbR/pKYyQ12Y2YrHa3X6osknorgHWKyS2dK1oPH8Y8omaGxQTgKRxHqm+Pq9LQkGQKBLN0ujb3PZ0MIR5TCRUXP7O0Rlg4RYw4121ohtf/b47bm8W/s7QAfBpDpNoL1IYr0CP0O9zSk2sOBj6C3bUxJU5NDHwK85yBQecqAD4YtmzC541LRzucQowx84QTPzZvLdEzbje9Pt8F4NaL1asqqScuT3xtB+wOZ0u2xyjMoJhI82NOp+329dWgDfdAyfxvQ1TDOOmk5QM45Ozy/PAFIR+k8ItOmS9fwsXcJcv/xSb3ppZ/vcqRclVSz4NKJlxR5U1rAeUvKcHP5+fDiBDWMRdj6jax/TOpREkgFnkELwAoBZGx4/sLQtwpMQXnkhJoIuaEnYJjlWHZEagpY52q+XzWd6y6a4x254HWY5v31890ECgMwQIYWqqTaiI6P75PkLUAXSxK/4imREKNaCD95Jc62kQlwxWQK1/RvQwo4ZL7VRnapea+b/RWP7WR6gdcNTNc7rcCs08Ub19OnfbmLzOTDVjdKC9NezCNwNi0tiGq3d56VzHZCJhvgP0b6wyBSaUNND2bcKBfM0cKFGzOgc6pl93V57EM92AOjlg7TEF3p/qdIfLm+CQ183IvKpP/N0WvxejSSPGh3prHHp1LXxTkrT2krbHCp/p5KYq9xwqSLvI4GFXwNGVUnQZ4FJlK7J+yuEY16a5D3uJ0DiAHs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ASBpR1VF0QszoF6XGJvk06dzp15qCxoQkTqTUrHGkA+SrxztMzzyqL9qLTsX?=
 =?us-ascii?Q?LbB7Y/7PZ0MoUGUd8btNvXjEW6+1oHE9ZkGLaq3/eXRk/2+7yKRch7b5N/EQ?=
 =?us-ascii?Q?WWZbYOKtJlfyN4CYmPcRa0k6dwLvAYtWPND1Oov8MTLVnRBvEJr8VpsKfFKj?=
 =?us-ascii?Q?a+jpeKQmtKFC1M1F7Tz+urlMjdmSt3YmbCB6ODY6lgAzxfEKzQ+jBtCRqG3q?=
 =?us-ascii?Q?UoQl5wOoNyQAlb3/nXnHX3mpjNbhElwLRd7e6R0pqDr9s7zmZ4jYrZv1U3MR?=
 =?us-ascii?Q?NfzQTnXs9hciXN/Nihk2K5b2KLy1d+zNCpMRiUcLf9s4dPT3ZFHSXR3pN33h?=
 =?us-ascii?Q?8jI9yZvIqbAh2ppPqRR0Xev6TVa+2gt1HPkGDHWixAd+CJzYxPClZ2MwH+kd?=
 =?us-ascii?Q?VwCcFKy/cpJBsjx8vk0AOOHuIfoIOsr8zhbXYXWoyFHloT1PoZd93PJEa4Tm?=
 =?us-ascii?Q?zoYiCwPZKaDfUsJAzwSB+J8iX/3gMBL13RPhHvP1/G/NuaNUiczV1WBM+tmr?=
 =?us-ascii?Q?Cgz/GhLsstSWqTYWbsXgt9QvqNbLgUz2z5esbzlZyzD/2nwGG6Btq8wIO1Vj?=
 =?us-ascii?Q?wbKjsvHim7vdOTM2Jq8aQvFgU1BrBd8SsJr5Rn3qiTd/SITPz8jkqkivGlAT?=
 =?us-ascii?Q?O9X5TiX0ymEpcVdLf0mx+lNzzsehXHno5DK54+Aod8Qo4Nr+4K3xtuI1tSgb?=
 =?us-ascii?Q?HQUbN/UtHNzrM6h9Aa5HxKAaMVdTzlYZjk7up0gY+cDmq4w+ZJoJaqnN0f1K?=
 =?us-ascii?Q?cGe1VVticAhzSvRtiA49hgdefByCQc23PPAs0dyoh+fMcGSoJS7YqEnhHsVJ?=
 =?us-ascii?Q?vTj4iSnGNPmz8jXnoN4F/asvDuahhcfBD4Y2rAoxGQ8Uq9AJ+HMoiweEovEX?=
 =?us-ascii?Q?M7m9kCcKKqX8omIraKyMcUc941Pkwe5dp2Q7bhCKIOeQXJS55deIpGwDwq/h?=
 =?us-ascii?Q?VFxImh1dffPwzEwsPddqCmvF3+99ntuFFgM/UqHijdWMrO3DxmTKoSeCHSW3?=
 =?us-ascii?Q?eOnhzBtcMSCPuwE6MDwCoX4m4iEOtwTMWQZxEiDdqu2+KXte/YEp47zkicDC?=
 =?us-ascii?Q?DlU+pEkGhm+R60KLeQ6xBDb+UgOTMQtwgTCGrs0R7NSpO6q2DreZrQhY2jyL?=
 =?us-ascii?Q?U18WbWT59ViRwqQhq1+danPd8hKkTEiocvtzWdsRUULRJLwwYFHtTFlS3hB6?=
 =?us-ascii?Q?fdHqEdTn5n22j90Tylxho118CK2UjPlTTum9MU+WB8gDLHeEGonqWdjhP5qX?=
 =?us-ascii?Q?uThk/PE0gmuuEZU/n+qn9fNa93xWx2kFcYpj7DSDAf76Jh90EUMTvszw9LR/?=
 =?us-ascii?Q?Ws4L41TW14CHrs36osPd/wBu4SqhxTko4UBCdjPTIdBpT5B/x8MbImu7aG+T?=
 =?us-ascii?Q?qsC+w49RWOCi1NW5J8IYhl+xlERV2ZqT9KIJSyEZobB+121zt1aJwJpbhlXZ?=
 =?us-ascii?Q?ucRc9Ewo53eUH41OzSy92Fq+EN78NCNn9hZ09P5g7QCU6PUueJ5gr1DNxr9v?=
 =?us-ascii?Q?/+ZvV5c26gvs09zx4cj6oWHOC4h06ItkDSn/cNQQouNDl4D0zF7BFe0USHwi?=
 =?us-ascii?Q?LoeBoaDkD5CRg05KF9DlYPgx39foEE+36RP4nR3QNOqNU6rUOsUjjj3cbqpD?=
 =?us-ascii?Q?10u7rn3oFXf2hgPvd3YVmCb3/nCkxEcnkGaTW7hUvEYW2nmBX+q4obrTnRcY?=
 =?us-ascii?Q?gfzZDsSEimksjKO6vNjEtBhfYK54/LjwXSqAYdiSO2IwPgbuAKkGuk1uITiQ?=
 =?us-ascii?Q?4mVWUub7Ed67c8cZi+/Yx1EhAiHsKWk5+lhiLFNdCtBe/kmaAF8V?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b4342f9a-7e89-4751-a75d-08de7acfcc7a
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 15:56:44.1229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0iZUMx9GrKdxIYfofFRcLR5xqhHspXOBoxNp9tz6IESjuXBDc73GHgau0xNarkWTdidrygB+XpGynPWXqQRmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2756
X-Rspamd-Queue-Id: 0615F214F38
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kudzu.us,intel.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-264469-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid]
X-Rspamd-Action: no action

Prepare ntb_netdev for multi-queue operation by moving queue-pair state
out of struct ntb_netdev.

Introduce struct ntb_netdev_queue to carry the ntb_transport_qp pointer,
the per-QP TX timer and queue id. Pass this object as the callback
context and convert the RX/TX handlers and link event path accordingly.

The probe path allocates a fixed upper bound for netdev queues while
instantiating only a single ntb_transport queue pair, preserving the
previous behavior. Also store client_dev for future queue pair
creation/removal via the ntb_transport API.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Drop redundant defensive checks in start_xmit().
  - Use kzalloc_objs() for the queue array.
  - Use the local qp argument where applicable.
  - Make variable declarations follow reverse Christmas tree style.
  - Remove double blank line.

 drivers/net/ntb_netdev.c | 277 ++++++++++++++++++++++++++-------------
 1 file changed, 188 insertions(+), 89 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index fbeae05817e9..4b65e938d549 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -53,6 +53,7 @@
 #include <linux/pci.h>
 #include <linux/ntb.h>
 #include <linux/ntb_transport.h>
+#include <linux/slab.h>
 
 #define NTB_NETDEV_VER	"0.7"
 
@@ -70,11 +71,24 @@ static unsigned int tx_start = 10;
 /* Number of descriptors still available before stop upper layer tx */
 static unsigned int tx_stop = 5;
 
-struct ntb_netdev {
-	struct pci_dev *pdev;
-	struct net_device *ndev;
+#define NTB_NETDEV_MAX_QUEUES		64
+#define NTB_NETDEV_DEFAULT_QUEUES	1
+
+struct ntb_netdev;
+
+struct ntb_netdev_queue {
+	struct ntb_netdev *ntdev;
 	struct ntb_transport_qp *qp;
 	struct timer_list tx_timer;
+	u16 qid;
+};
+
+struct ntb_netdev {
+	struct pci_dev *pdev;
+	struct device *client_dev;
+	struct net_device *ndev;
+	unsigned int num_queues;
+	struct ntb_netdev_queue *queues;
 };
 
 #define	NTB_TX_TIMEOUT_MS	1000
@@ -82,14 +96,17 @@ struct ntb_netdev {
 
 static void ntb_netdev_event_handler(void *data, int link_is_up)
 {
-	struct net_device *ndev = data;
-	struct ntb_netdev *dev = netdev_priv(ndev);
+	struct ntb_netdev_queue *q = data;
+	struct ntb_netdev *dev = q->ntdev;
+	struct net_device *ndev;
 
-	netdev_dbg(ndev, "Event %x, Link %x\n", link_is_up,
-		   ntb_transport_link_query(dev->qp));
+	ndev = dev->ndev;
+
+	netdev_dbg(ndev, "Event %x, Link %x, qp %u\n", link_is_up,
+		   ntb_transport_link_query(q->qp), q->qid);
 
 	if (link_is_up) {
-		if (ntb_transport_link_query(dev->qp))
+		if (ntb_transport_link_query(q->qp))
 			netif_carrier_on(ndev);
 	} else {
 		netif_carrier_off(ndev);
@@ -99,10 +116,13 @@ static void ntb_netdev_event_handler(void *data, int link_is_up)
 static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 				  void *data, int len)
 {
-	struct net_device *ndev = qp_data;
+	struct ntb_netdev_queue *q = qp_data;
+	struct ntb_netdev *dev = q->ntdev;
+	struct net_device *ndev;
 	struct sk_buff *skb;
 	int rc;
 
+	ndev = dev->ndev;
 	skb = data;
 	if (!skb)
 		return;
@@ -118,6 +138,7 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 	skb_put(skb, len);
 	skb->protocol = eth_type_trans(skb, ndev);
 	skb->ip_summed = CHECKSUM_NONE;
+	skb_record_rx_queue(skb, q->qid);
 
 	if (netif_rx(skb) == NET_RX_DROP) {
 		ndev->stats.rx_errors++;
@@ -144,42 +165,43 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 }
 
 static int __ntb_netdev_maybe_stop_tx(struct net_device *netdev,
-				      struct ntb_transport_qp *qp, int size)
+				      struct ntb_netdev_queue *q, int size)
 {
-	struct ntb_netdev *dev = netdev_priv(netdev);
+	netif_stop_subqueue(netdev, q->qid);
 
-	netif_stop_queue(netdev);
 	/* Make sure to see the latest value of ntb_transport_tx_free_entry()
 	 * since the queue was last started.
 	 */
 	smp_mb();
 
-	if (likely(ntb_transport_tx_free_entry(qp) < size)) {
-		mod_timer(&dev->tx_timer, jiffies + usecs_to_jiffies(tx_time));
+	if (likely(ntb_transport_tx_free_entry(q->qp) < size)) {
+		mod_timer(&q->tx_timer, jiffies + usecs_to_jiffies(tx_time));
 		return -EBUSY;
 	}
 
-	netif_start_queue(netdev);
+	netif_start_subqueue(netdev, q->qid);
 	return 0;
 }
 
 static int ntb_netdev_maybe_stop_tx(struct net_device *ndev,
-				    struct ntb_transport_qp *qp, int size)
+				    struct ntb_netdev_queue *q, int size)
 {
-	if (netif_queue_stopped(ndev) ||
-	    (ntb_transport_tx_free_entry(qp) >= size))
+	if (__netif_subqueue_stopped(ndev, q->qid) ||
+	    (ntb_transport_tx_free_entry(q->qp) >= size))
 		return 0;
 
-	return __ntb_netdev_maybe_stop_tx(ndev, qp, size);
+	return __ntb_netdev_maybe_stop_tx(ndev, q, size);
 }
 
 static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 				  void *data, int len)
 {
-	struct net_device *ndev = qp_data;
+	struct ntb_netdev_queue *q = qp_data;
+	struct ntb_netdev *dev = q->ntdev;
+	struct net_device *ndev;
 	struct sk_buff *skb;
-	struct ntb_netdev *dev = netdev_priv(ndev);
 
+	ndev = dev->ndev;
 	skb = data;
 	if (!skb || !ndev)
 		return;
@@ -194,13 +216,13 @@ static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 
 	dev_kfree_skb_any(skb);
 
-	if (ntb_transport_tx_free_entry(dev->qp) >= tx_start) {
+	if (ntb_transport_tx_free_entry(qp) >= tx_start) {
 		/* Make sure anybody stopping the queue after this sees the new
 		 * value of ntb_transport_tx_free_entry()
 		 */
 		smp_mb();
-		if (netif_queue_stopped(ndev))
-			netif_wake_queue(ndev);
+		if (__netif_subqueue_stopped(ndev, q->qid))
+			netif_wake_subqueue(ndev, q->qid);
 	}
 }
 
@@ -208,16 +230,20 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 					 struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	u16 qid = skb_get_queue_mapping(skb);
+	struct ntb_netdev_queue *q;
 	int rc;
 
-	ntb_netdev_maybe_stop_tx(ndev, dev->qp, tx_stop);
+	q = &dev->queues[qid];
 
-	rc = ntb_transport_tx_enqueue(dev->qp, skb, skb->data, skb->len);
+	ntb_netdev_maybe_stop_tx(ndev, q, tx_stop);
+
+	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len);
 	if (rc)
 		goto err;
 
 	/* check for next submit */
-	ntb_netdev_maybe_stop_tx(ndev, dev->qp, tx_stop);
+	ntb_netdev_maybe_stop_tx(ndev, q, tx_stop);
 
 	return NETDEV_TX_OK;
 
@@ -229,80 +255,104 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 
 static void ntb_netdev_tx_timer(struct timer_list *t)
 {
-	struct ntb_netdev *dev = timer_container_of(dev, t, tx_timer);
-	struct net_device *ndev = dev->ndev;
+	struct ntb_netdev_queue *q = timer_container_of(q, t, tx_timer);
+	struct ntb_netdev *dev = q->ntdev;
+	struct net_device *ndev;
 
-	if (ntb_transport_tx_free_entry(dev->qp) < tx_stop) {
-		mod_timer(&dev->tx_timer, jiffies + usecs_to_jiffies(tx_time));
+	ndev = dev->ndev;
+
+	if (ntb_transport_tx_free_entry(q->qp) < tx_stop) {
+		mod_timer(&q->tx_timer, jiffies + usecs_to_jiffies(tx_time));
 	} else {
 		/* Make sure anybody stopping the queue after this sees the new
 		 * value of ntb_transport_tx_free_entry()
 		 */
 		smp_mb();
-		if (netif_queue_stopped(ndev))
-			netif_wake_queue(ndev);
+		if (__netif_subqueue_stopped(ndev, q->qid))
+			netif_wake_subqueue(ndev, q->qid);
 	}
 }
 
 static int ntb_netdev_open(struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	struct ntb_netdev_queue *queue;
 	struct sk_buff *skb;
-	int rc, i, len;
+	int rc = 0, i, len;
+	unsigned int q;
 
-	/* Add some empty rx bufs */
-	for (i = 0; i < NTB_RXQ_SIZE; i++) {
-		skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
-		if (!skb) {
-			rc = -ENOMEM;
-			goto err;
-		}
+	/* Add some empty rx bufs for each queue */
+	for (q = 0; q < dev->num_queues; q++) {
+		queue = &dev->queues[q];
+
+		for (i = 0; i < NTB_RXQ_SIZE; i++) {
+			skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
+			if (!skb) {
+				rc = -ENOMEM;
+				goto err;
+			}
 
-		rc = ntb_transport_rx_enqueue(dev->qp, skb, skb->data,
-					      ndev->mtu + ETH_HLEN);
-		if (rc) {
-			dev_kfree_skb(skb);
-			goto err;
+			rc = ntb_transport_rx_enqueue(queue->qp, skb, skb->data,
+						      ndev->mtu + ETH_HLEN);
+			if (rc) {
+				dev_kfree_skb(skb);
+				goto err;
+			}
 		}
+
+		timer_setup(&queue->tx_timer, ntb_netdev_tx_timer, 0);
 	}
 
-	timer_setup(&dev->tx_timer, ntb_netdev_tx_timer, 0);
-
 	netif_carrier_off(ndev);
-	ntb_transport_link_up(dev->qp);
+
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_link_up(dev->queues[q].qp);
+
 	netif_start_queue(ndev);
 
 	return 0;
 
 err:
-	while ((skb = ntb_transport_rx_remove(dev->qp, &len)))
-		dev_kfree_skb(skb);
+	for (q = 0; q < dev->num_queues; q++) {
+		queue = &dev->queues[q];
+
+		while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
+			dev_kfree_skb(skb);
+	}
 	return rc;
 }
 
 static int ntb_netdev_close(struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	struct ntb_netdev_queue *queue;
 	struct sk_buff *skb;
+	unsigned int q;
 	int len;
 
-	ntb_transport_link_down(dev->qp);
 
-	while ((skb = ntb_transport_rx_remove(dev->qp, &len)))
-		dev_kfree_skb(skb);
+	for (q = 0; q < dev->num_queues; q++) {
+		queue = &dev->queues[q];
 
-	timer_delete_sync(&dev->tx_timer);
+		ntb_transport_link_down(queue->qp);
 
+		while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
+			dev_kfree_skb(skb);
+
+		timer_delete_sync(&queue->tx_timer);
+	}
 	return 0;
 }
 
 static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	struct ntb_netdev_queue *queue;
 	struct sk_buff *skb;
-	int len, rc;
+	unsigned int q, i;
+	int len, rc = 0;
 
-	if (new_mtu > ntb_transport_max_size(dev->qp) - ETH_HLEN)
+	if (new_mtu > ntb_transport_max_size(dev->queues[0].qp) - ETH_HLEN)
 		return -EINVAL;
 
 	if (!netif_running(ndev)) {
@@ -311,41 +361,54 @@ static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
 	}
 
 	/* Bring down the link and dispose of posted rx entries */
-	ntb_transport_link_down(dev->qp);
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_link_down(dev->queues[q].qp);
 
 	if (ndev->mtu < new_mtu) {
-		int i;
+		for (q = 0; q < dev->num_queues; q++) {
+			queue = &dev->queues[q];
 
-		for (i = 0; (skb = ntb_transport_rx_remove(dev->qp, &len)); i++)
-			dev_kfree_skb(skb);
-
-		for (; i; i--) {
-			skb = netdev_alloc_skb(ndev, new_mtu + ETH_HLEN);
-			if (!skb) {
-				rc = -ENOMEM;
-				goto err;
-			}
-
-			rc = ntb_transport_rx_enqueue(dev->qp, skb, skb->data,
-						      new_mtu + ETH_HLEN);
-			if (rc) {
+			for (i = 0;
+			     (skb = ntb_transport_rx_remove(queue->qp, &len));
+			     i++)
 				dev_kfree_skb(skb);
-				goto err;
+
+			for (; i; i--) {
+				skb = netdev_alloc_skb(ndev,
+						       new_mtu + ETH_HLEN);
+				if (!skb) {
+					rc = -ENOMEM;
+					goto err;
+				}
+
+				rc = ntb_transport_rx_enqueue(queue->qp, skb,
+							      skb->data,
+							      new_mtu +
+							      ETH_HLEN);
+				if (rc) {
+					dev_kfree_skb(skb);
+					goto err;
+				}
 			}
 		}
 	}
 
 	WRITE_ONCE(ndev->mtu, new_mtu);
 
-	ntb_transport_link_up(dev->qp);
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_link_up(dev->queues[q].qp);
 
 	return 0;
 
 err:
-	ntb_transport_link_down(dev->qp);
+	for (q = 0; q < dev->num_queues; q++) {
+		struct ntb_netdev_queue *queue = &dev->queues[q];
 
-	while ((skb = ntb_transport_rx_remove(dev->qp, &len)))
-		dev_kfree_skb(skb);
+		ntb_transport_link_down(queue->qp);
+
+		while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
+			dev_kfree_skb(skb);
+	}
 
 	netdev_err(ndev, "Error changing MTU, device inoperable\n");
 	return rc;
@@ -404,6 +467,7 @@ static int ntb_netdev_probe(struct device *client_dev)
 	struct net_device *ndev;
 	struct pci_dev *pdev;
 	struct ntb_netdev *dev;
+	unsigned int q;
 	int rc;
 
 	ntb = dev_ntb(client_dev->parent);
@@ -411,7 +475,7 @@ static int ntb_netdev_probe(struct device *client_dev)
 	if (!pdev)
 		return -ENODEV;
 
-	ndev = alloc_etherdev(sizeof(*dev));
+	ndev = alloc_etherdev_mq(sizeof(*dev), NTB_NETDEV_MAX_QUEUES);
 	if (!ndev)
 		return -ENOMEM;
 
@@ -420,6 +484,16 @@ static int ntb_netdev_probe(struct device *client_dev)
 	dev = netdev_priv(ndev);
 	dev->ndev = ndev;
 	dev->pdev = pdev;
+	dev->client_dev = client_dev;
+	dev->num_queues = 0;
+
+	dev->queues = kzalloc_objs(*dev->queues, NTB_NETDEV_MAX_QUEUES,
+				   GFP_KERNEL);
+	if (!dev->queues) {
+		rc = -ENOMEM;
+		goto err_free_netdev;
+	}
+
 	ndev->features = NETIF_F_HIGHDMA;
 
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
@@ -436,26 +510,47 @@ static int ntb_netdev_probe(struct device *client_dev)
 	ndev->min_mtu = 0;
 	ndev->max_mtu = ETH_MAX_MTU;
 
-	dev->qp = ntb_transport_create_queue(ndev, client_dev,
-					     &ntb_netdev_handlers);
-	if (!dev->qp) {
+	for (q = 0; q < NTB_NETDEV_DEFAULT_QUEUES; q++) {
+		struct ntb_netdev_queue *queue = &dev->queues[q];
+
+		queue->ntdev = dev;
+		queue->qid = q;
+		queue->qp = ntb_transport_create_queue(queue, client_dev,
+						       &ntb_netdev_handlers);
+		if (!queue->qp)
+			break;
+
+		dev->num_queues++;
+	}
+
+	if (!dev->num_queues) {
 		rc = -EIO;
-		goto err;
+		goto err_free_queues;
 	}
 
-	ndev->mtu = ntb_transport_max_size(dev->qp) - ETH_HLEN;
+	rc = netif_set_real_num_queues(ndev, dev->num_queues, dev->num_queues);
+	if (rc)
+		goto err_free_qps;
+
+	ndev->mtu = ntb_transport_max_size(dev->queues[0].qp) - ETH_HLEN;
 
 	rc = register_netdev(ndev);
 	if (rc)
-		goto err1;
+		goto err_free_qps;
 
 	dev_set_drvdata(client_dev, ndev);
-	dev_info(&pdev->dev, "%s created\n", ndev->name);
+	dev_info(&pdev->dev, "%s created with %u queue pairs\n",
+		 ndev->name, dev->num_queues);
 	return 0;
 
-err1:
-	ntb_transport_free_queue(dev->qp);
-err:
+err_free_qps:
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_free_queue(dev->queues[q].qp);
+
+err_free_queues:
+	kfree(dev->queues);
+
+err_free_netdev:
 	free_netdev(ndev);
 	return rc;
 }
@@ -464,9 +559,13 @@ static void ntb_netdev_remove(struct device *client_dev)
 {
 	struct net_device *ndev = dev_get_drvdata(client_dev);
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	unsigned int q;
 
 	unregister_netdev(ndev);
-	ntb_transport_free_queue(dev->qp);
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_free_queue(dev->queues[q].qp);
+
+	kfree(dev->queues);
 	free_netdev(ndev);
 }
 
-- 
2.51.0


