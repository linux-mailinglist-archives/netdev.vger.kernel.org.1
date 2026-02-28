Return-Path: <netdev+bounces-262153-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPB2AXsCo2kJ8wQAu9opvQ
	(envelope-from <netdev+bounces-262153-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:58:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ABC1C3C0F
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2FD3311B20D
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6883D44CF4F;
	Sat, 28 Feb 2026 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="e+MQ0t1D"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020096.outbound.protection.outlook.com [52.101.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FF844BC89;
	Sat, 28 Feb 2026 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290555; cv=fail; b=Y6xy1MEaDmzmEXN7hPZZw2u0+jfCThjLeYfPOzsJ2wE3C1HpRxkxutE3kUiLdSAstjtrayGMw3tnlSv0BIZs4I5Hg24dL6240XOUJAePkv7hLR+BSQx1SBDiNuAQ/eFZSwBbUDRxSQQcLLUKiHOS18qFhKPlsiygfHA64knIWto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290555; c=relaxed/simple;
	bh=Rs/ureIuz5rpZWNFJATPsZPW2/ha1dch4gJGxyvGaW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=omzdbauyxAz/1QcDxUbLZdE4c+Aq67aWC9gix8jKhbF+rooxUvJPi146IobKil2jQ3PTPOoihqWPGCILZVST6S5Cs4FLyEJIMASCUTIQTtgfeFjOfpwwxkNv3/Hf41lEpD6qwk2W9SL5QMYY34lbKL/QgiYITBhlqIZwPQWYZAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=e+MQ0t1D; arc=fail smtp.client-ip=52.101.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQMC5jsztpbyRda/tM5hHtnjQTWmM7rXXtZTbOBtbKIAYOqBye4dYKWXHla/kxMZXF+z++I54rDUL3XDAbciGauNq/ar6mgfzTDsj+Fa5K839iY4DO5CYcKPlsSO9CJ8x/+pq1ZHF1KnEReev+93gRDyVV4eetbwzq4nlbjaNlZDjN3k1cX25XsmevrDod+kJVcEMsJYblXiYU+43grAsw4RwlQ0CNva4WDgm+EB/F3NR4Ry/9iJjddszYp57ajRIJ7jtQKjWFU9vJ6uEe0ZkzSpr7SIm41sv/0t0DQFVHlVwMyoy7atr/dTUEvsaxUbbKWeOExN96W59dcf54WYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zZttERInpH2212CkOMsuFpRsaBRmoT7Aty5F6mfMvI=;
 b=Gv6Vjha+l0disY65/8aqcwaMnuuZPi3T5xeqLiifCN693O8Qj7CmvS8ENebiiKxUCKooJxDnsJhqyJLwcUG135IKAYLq3UkuX4xGKP9vP0oK9WV6rSEfc0yje7H1j00hdCkjXGcBDNEOA1l4hVyHtAJcRG0AQ1OOvYlnhBq67j5frdWcA0yDesE2jW+qGI3E7RMIuz75Te4KPjP/LbZ3dpMzOvGbYetbDJIwGgy3dcSEJ8lHQ9c43WetIvVXy1HwOsvGdLHSmgy/DivraqoPbBIiqLdCR4x/y3ufS4aRr8X8uanMjsPnoURQKJMshZcdTFOw1zSs1vTApms3irdxqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zZttERInpH2212CkOMsuFpRsaBRmoT7Aty5F6mfMvI=;
 b=e+MQ0t1DP7CwM7trscsqdFo8Gf5lezkipVuuVNbzU8Sv/tsZnzxKZx4OSxe13V+BkGB6FDISQmUgmw7pLotZmOHajotvPrjBkHw0O2r+X4Zky2lNr1ok6xWwltNAO7BSyK9eFEvpiexOBI5rbOaWHlRUdMTmlK9DGlcw5GG+Orc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB5182.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:164::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Sat, 28 Feb
 2026 14:55:48 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.013; Sat, 28 Feb 2026
 14:55:48 +0000
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
Subject: [PATCH v2 3/4] net: ntb_netdev: Factor out multi-queue helpers
Date: Sat, 28 Feb 2026 23:55:37 +0900
Message-ID: <20260228145538.3955864-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228145538.3955864-1-den@valinux.co.jp>
References: <20260228145538.3955864-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0076.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB5182:EE_
X-MS-Office365-Filtering-Correlation-Id: 067a878b-068f-49d1-b0ab-08de76d9753c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	78Fzm17m0ys5DyReq2kApic6gok4RwiiZse25v+koA8qdPIDUIj9kWl0ji2F67HSwoE5RYRVxsV+oL4aQS352GB4+dtRHZ5ikm+0bApm422/RdBvnI+2XMEwIDpgTYiNVRzjw92pHoLrTybIQiApt8W9scMs2N4SYnbbRoS9KRiJ0XVj15kaVUPInc01x9EMthE1uzrkIKydbrjcl3lhb1qH5Byhn/aoT5ZruSYG9m0cdrRKHVBFXiD7lokdxqWvfQl/OrWYSl3T8LLXvftDX5CPUARE5Jl6aUSlb57MVuljwYmEY6kKpOjZMfPmkhJPceYgLWl4ZGnHPE6fxUlTINd0eRT4sTg3/LwC86BiWFdxTKhC8+dAQQ2458sonGZ+gzPH0u3f3bPYnH5w7lI+AlPQKxDBZ1KVWhROkYiNiW6y0sGfX/BSsPhS64STXbSh/DXLibpa5G5lOGghth2+uuIMWvYvUiU430h+LeStMhXnXsQ8zfYX5Bj/Hj8JxshDFpLg/Rq5d4owYQ1V5vWOW1xzcUWjTfmV65CulS6cK95FYxn5FKZ7ObAvv8Un3T5Kkbm3b+l2kmf96eUNYTa0SIbLzi56QjQpCBcymnB7wSRNxX2YJkRF8hw7eaHrSba0WeYYIO+s3pm7q2C6MHNf7gli7ewRBWNWBb6yt7BbH+k2UCzUTQ8ywYFYm/4AS+8UxS3qAUrQhxi1MZLmJp1zAocXHhQJNxuIPlsaIWllgSc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zUwN8Xec5bayQkNueW8hJbPAj7VZYwO270UZHQ1L8obFkZnzamE9gSaWGyGr?=
 =?us-ascii?Q?4yqvMwFTGuxLmAxqf4tnhdqYiVbCOUjtKUiz21v9Qevisks9lAOgiVzJvJdM?=
 =?us-ascii?Q?7oeZGoAS9tWGGaOBBmwapSklXSapLNcJJSt8qX8dWmYlf7Y4m+hXrORaD1ve?=
 =?us-ascii?Q?fJAYJ4xl4CzjIRcC21IR0ixmBDKgVExJu1BfBV3625egZFQCsAmSnLB8Pmt1?=
 =?us-ascii?Q?kOaHA6bQgGI5Ky6G5Cqlu2AfsPrML7uCcUPIlAmm32o7Wz4o6A4XfCs9mrtg?=
 =?us-ascii?Q?mJUbYEkFPeEDF2Judp9R+RoDhDHH3I7P56aHKvlvXHemPEIQIiXayXV6ywBD?=
 =?us-ascii?Q?rcjg00jomw1GQRoTAlm7kuiO3DvTvUx5Yj+z0kc4laXPZnhCw1Kx0Wdq96iU?=
 =?us-ascii?Q?7ZMfWCVxKnqDbwbglVT/YEDX+Bl1HwWpO6a9JtAO08dqYT0j6NyEtAh3Pgyn?=
 =?us-ascii?Q?FXN1fx4LyUyhPe5iNSDOg/bNWiNLEtoliAV6Fv7NaViU/+tkeuTjcDaWFasW?=
 =?us-ascii?Q?5gqXNf8S+8hkB8P7xEzNrrSGi224HpWoBOgDUJkQV1wKJkaysapzolTMVnG0?=
 =?us-ascii?Q?x5bTPOjzHZxVPDhK1FvlDA9EOlMCO7pwTZ8s5vOJURPLVztu7bAnwbl9XEGH?=
 =?us-ascii?Q?89v4/PZmBRLUr2Js+awMs1ezf6lPhDf3fain7U0u6MI4jLp3sr1wQLFznkOk?=
 =?us-ascii?Q?6cOo0Ow8vUQy5xVWDIm1mMc2dK2B/5guoGU+kiterMQLuu2dX+wOwQ5yKZEM?=
 =?us-ascii?Q?1Zed9wlX3vc4I4tLvhLbZyYpTMtilE0iASNrIEcKt9td5ym3Xuh2KcxysjDx?=
 =?us-ascii?Q?kUsoJPhjrBYILWaNAPtOw23NJh/JY8fwq1H04KB7FHBiM1E/L+3igzw8jBy+?=
 =?us-ascii?Q?/krwSH3qNfKK4acVtHFKFhqRT7AcKqP18B9tCaOlhArpYjFKEOVAPb+VYOZO?=
 =?us-ascii?Q?PGr+i/VtRvD+QdYNInVhE4vbvF0f0hBEYfSDiR4zBIqXtEus94qc0aSe9ysG?=
 =?us-ascii?Q?thw1CzTC6rfEYQWiiO5KBKldm9A/SRSVub7B0hebEioel4VgjQS0/LPT7IvQ?=
 =?us-ascii?Q?s7vPalnxNQuHUydUkj2a+7bARdXCFoOiyAZ3aJlHcK5sm/T/IdsrJ/L9pEL2?=
 =?us-ascii?Q?T87jPpuuGXdZU8fMrpKd06xru/+S3Ete4zVehdEY8I2pFpXlLpVyPJ4Q00lR?=
 =?us-ascii?Q?JM7qaT1W09CMYLvi25Gdpdg+OEX9CeU8nOea4chcdTMEDbjiDmmfTEC79kP9?=
 =?us-ascii?Q?tf1tqqdR4x09ZasDEYIZyOB58bp3u781Qvi4+XxrsdK57VA2052zflozC5ya?=
 =?us-ascii?Q?GYJFIaW6wdMIJyYkE8mHtgYyfFYSApDjZjhcKzvy1r+nZgJZs2SJPg9XsBzR?=
 =?us-ascii?Q?q4OL2zzgx8Ebiykx7g9zSBxpqc73DRrUGCsfczbl//ITV0D/V7OPnXi98kwL?=
 =?us-ascii?Q?+ypyS1st45RHF9m2xNApdbWv3WsmrHawapI9hsf7ucxbkEhKbJz/+x7sLnZJ?=
 =?us-ascii?Q?N2K/vqrlgsCATffgEXGmY/O5pM0wRh7EyaBBmcCvWcGwnKDrSYQyMgJ5mAMe?=
 =?us-ascii?Q?tLcqFx9EAmqlV/loBmYPWgGejaB61JwinXSq7Laau0dH5yulOvuiO8d2oh0w?=
 =?us-ascii?Q?joLfVp3Nf6DL9s0G/Hr2WutfavkxQ5P+Kk0Fp5WUW1BvTBiiBfj/4yVB8Rsc?=
 =?us-ascii?Q?P3fnq1AaNHjJXM64mXIaxd1A39pa7eI82HkDaX+5DQiMJvm/6Jw6tNspLLZO?=
 =?us-ascii?Q?+W3hHOy6xuK9SGRtYhwsIN12b6sMCpGdh4+bpX6KEWMAO+VkGAM1?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 067a878b-068f-49d1-b0ab-08de76d9753c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 14:55:48.0588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4GoqmqfJVMz4PU3t7iCbo8fL2bJznnPUVOQvKzB8ZrtedonJf6WUpC4itK1FObIn+GTeZZMT5F0FG421kFFOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5182
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kudzu.us,intel.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-262153-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:mid,valinux.co.jp:dkim,valinux.co.jp:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55ABC1C3C0F
X-Rspamd-Action: no action

Implementing .set_channels will otherwise duplicate the same multi-queue
operations at multiple call sites. Factor out the following helpers:

  - ntb_netdev_update_carrier(): carrier is switched on when at least
                                 one QP link is up
  - ntb_netdev_queue_rx_drain(): drain and free all queued RX packets
                                 for one QP
  - ntb_netdev_queue_rx_fill():  prefill RX ring for one QP

No functional change.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/net/ntb_netdev.c | 99 ++++++++++++++++++++++++----------------
 1 file changed, 59 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 19a3383d86f8..6aa59316569c 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -94,24 +94,12 @@ struct ntb_netdev {
 #define	NTB_TX_TIMEOUT_MS	1000
 #define	NTB_RXQ_SIZE		100
 
-static void ntb_netdev_event_handler(void *data, int link_is_up)
+static void ntb_netdev_update_carrier(struct ntb_netdev *dev)
 {
-	struct ntb_netdev_queue *q = data;
-	struct ntb_netdev *dev = q->ntdev;
 	struct net_device *ndev = dev->ndev;
 	bool any_up = false;
 	unsigned int i;
 
-	netdev_dbg(ndev, "Event %x, Link %x, qp %u\n", link_is_up,
-		   ntb_transport_link_query(q->qp), q->qid);
-
-	if (netif_running(ndev)) {
-		if (link_is_up)
-			netif_wake_subqueue(ndev, q->qid);
-		else
-			netif_stop_subqueue(ndev, q->qid);
-	}
-
 	for (i = 0; i < dev->num_queues; i++) {
 		if (ntb_transport_link_query(dev->queues[i].qp)) {
 			any_up = true;
@@ -125,6 +113,56 @@ static void ntb_netdev_event_handler(void *data, int link_is_up)
 		netif_carrier_off(ndev);
 }
 
+static void ntb_netdev_queue_rx_drain(struct ntb_netdev_queue *queue)
+{
+	struct sk_buff *skb;
+	int len;
+
+	while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
+		dev_kfree_skb(skb);
+}
+
+static int ntb_netdev_queue_rx_fill(struct net_device *ndev,
+				    struct ntb_netdev_queue *queue)
+{
+	struct sk_buff *skb;
+	int rc, i;
+
+	for (i = 0; i < NTB_RXQ_SIZE; i++) {
+		skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
+		if (!skb)
+			return -ENOMEM;
+
+		rc = ntb_transport_rx_enqueue(queue->qp, skb, skb->data,
+					      ndev->mtu + ETH_HLEN);
+		if (rc) {
+			dev_kfree_skb(skb);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
+static void ntb_netdev_event_handler(void *data, int link_is_up)
+{
+	struct ntb_netdev_queue *q = data;
+	struct ntb_netdev *dev = q->ntdev;
+	struct net_device *ndev = dev->ndev;
+
+	netdev_dbg(ndev, "Event %x, Link %x, qp %u\n", link_is_up,
+		   ntb_transport_link_query(q->qp), q->qid);
+
+	if (netif_running(ndev)) {
+		if (link_is_up)
+			netif_wake_subqueue(ndev, q->qid);
+		else
+			netif_stop_subqueue(ndev, q->qid);
+	}
+
+	ntb_netdev_update_carrier(dev);
+}
+
 static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 				  void *data, int len)
 {
@@ -299,28 +337,16 @@ static int ntb_netdev_open(struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
 	struct ntb_netdev_queue *queue;
-	struct sk_buff *skb;
 	unsigned int q;
-	int rc = 0, i, len;
+	int rc = 0;
 
 	/* Add some empty rx bufs for each queue */
 	for (q = 0; q < dev->num_queues; q++) {
 		queue = &dev->queues[q];
 
-		for (i = 0; i < NTB_RXQ_SIZE; i++) {
-			skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
-			if (!skb) {
-				rc = -ENOMEM;
-				goto err;
-			}
-
-			rc = ntb_transport_rx_enqueue(queue->qp, skb, skb->data,
-						      ndev->mtu + ETH_HLEN);
-			if (rc) {
-				dev_kfree_skb(skb);
-				goto err;
-			}
-		}
+		rc = ntb_netdev_queue_rx_fill(ndev, queue);
+		if (rc)
+			goto err;
 
 		timer_setup(&queue->tx_timer, ntb_netdev_tx_timer, 0);
 	}
@@ -336,9 +362,7 @@ static int ntb_netdev_open(struct net_device *ndev)
 err:
 	for (q = 0; q < dev->num_queues; q++) {
 		queue = &dev->queues[q];
-
-		while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
-			dev_kfree_skb(skb);
+		ntb_netdev_queue_rx_drain(queue);
 	}
 	return rc;
 }
@@ -347,9 +371,7 @@ static int ntb_netdev_close(struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
 	struct ntb_netdev_queue *queue;
-	struct sk_buff *skb;
 	unsigned int q;
-	int len;
 
 	netif_tx_stop_all_queues(ndev);
 	netif_carrier_off(ndev);
@@ -358,12 +380,10 @@ static int ntb_netdev_close(struct net_device *ndev)
 		queue = &dev->queues[q];
 
 		ntb_transport_link_down(queue->qp);
-
-		while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
-			dev_kfree_skb(skb);
-
+		ntb_netdev_queue_rx_drain(queue);
 		timer_delete_sync(&queue->tx_timer);
 	}
+
 	return 0;
 }
 
@@ -429,8 +449,7 @@ static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
 
 		ntb_transport_link_down(queue->qp);
 
-		while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
-			dev_kfree_skb(skb);
+		ntb_netdev_queue_rx_drain(queue);
 	}
 
 	netdev_err(ndev, "Error changing MTU, device inoperable\n");
-- 
2.51.0


