Return-Path: <netdev+bounces-68538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8AB84723E
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 15:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D631C22134
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C388B13EFFB;
	Fri,  2 Feb 2024 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ixAjpcX6"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2148.outbound.protection.outlook.com [40.92.62.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BC946BA0
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.148
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885630; cv=fail; b=rqNeCWep/LbfQeJ8+tyWbVXXOvOyRpBTne+VL4379qfFdklPq9MczyKIH9eVXUQwQIWb8JHdQNX/2AQdRsQ4mvY4TYAwG8FjAn+tcVP7KH/S6fP4E3mM9rcRRC9jJYcX8EwVASpIguOsk+UaGuu8jWY1/cWozZ1NvKMZqP65oY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885630; c=relaxed/simple;
	bh=dUZ8iEBcTypg+w6C+1ca8zjAhhY5k44N76d5qdQgynQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IZyrVNu2iP3xwLzC9JoHg++7O1/WKW2HHf+weFG3PniOvzeBYZrutyploxCMRglFC4/slJU50M1oDA3uwHLBwbEbOP4I6CJ9nlUycHVDsn8CRvVP0jSkNrljSzGeJEc0YQoaZx341P/lVZSAzw2SCHfwiIffWp3EXa2Fd8Oevc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ixAjpcX6; arc=fail smtp.client-ip=40.92.62.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlYG+/jwa8QU9I1mkUVmOxqwrqH9reDCFuDILYtPMe/vJeJwKkPx5fFG9v04I0IeuCJi9khCvcllQNwKZ1d3PwJ69j9r8bhzfTIx/HU3EJqII5ojZ2y0Lbcl22Q4VXuz4BrZ9mCCWJ0o8o47RKOrFlefD7ghUJa+AbLb2IAZ/F/Dkw/YE9kSqymlMlcBA1RVkQO1Zm6cU01xKdj9sIAD1694DvrGe53aTyTJkc8Pmg0A9crBteHhjcAWCC3UDrwOGT+jkFJiaiLOS8MH2TuiJRd6PHH5DTDBs7IVK+be8tku+bmqL/R02jGoDJAW1uMjo7TosjSIvDFuEm3hk1398Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOgJgP7/rgs97LLdWKSQjZJRTc++cKjblmNheX+aH5g=;
 b=lmbpwfTXHe6grXgl6sbf3Zbi+8Y1qsXTXGnlVWe6h/MZrnrkH5Txw38jFv5KTYWjeW3z4xrj6bnPjl1FkVvyVar4e6QNJt/GApzsoi7EmsRVvGwza3kiqN+3ME8HmadUo9h6Px1FgOFpESIl8oProJ6XSN2THNC7E09kJ0/zsbfawErGAfz5RVOKT5HEJeRdUxuS3kOKIFHNirGzO7LyUp0xQgh2IPzX4oBvja2Gw3W/+Mp0wPiqS1/PGghK0t5QjAkv24nKJI7FLDCr+MyOOu4TGI0fSOU0rZVDHfuHuVLJNP3+Cy6O3BbrUJ6hsRmOSERbS4WTV56FTjQjwuhT8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOgJgP7/rgs97LLdWKSQjZJRTc++cKjblmNheX+aH5g=;
 b=ixAjpcX6/KgaFD/XYko2bSJP18BsyEfI02xCNp8HTJuTcFeJxqFruqcaZScakjymqsJRo0+AT9kwPV9m5Q0q/wjLujE/+ug1Kh5wqFgZpIKj/Kki4ahOjprGMQp6t5B8az6JO9a0fgAipbvnzAcQgkATHfA/w9rpbjgxeFEWXx3ROb1x1Kpq2kbAGfl5YiOOaEHRhke8fI3ijRFB+3aPQBB7BLHHxyg3JDKPxnr9Rtz+fDnXNs1DRJJQiNiaQR2LmKOcs9hYPA9dWi4ma1mBHfgFr4NDr1hwNH+NodD/VL6mJwUibRmug0Xwk9uEAcxIqEOc3qhIjuM7qPOlWSVAzA==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME3P282MB3821.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:1bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 14:53:39 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%4]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 14:53:39 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.com,
	vsankar@lenovo.com,
	letitia.tsai@hp.com,
	pin-hao.huang@hp.com,
	danielwinkler@google.com,
	nmarupaka@google.com,
	joey.zhao@fibocom.com,
	liuqf@fibocom.com,
	felix.yan@fibocom.com,
	angel.huang@fibocom.com,
	freddy.lin@fibocom.com,
	alan.zhang1@fibocom.com,
	zhangrc@fibocom.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v8 3/4] net: wwan: t7xx: Infrastructure for early port configuration
Date: Fri,  2 Feb 2024 22:52:48 +0800
Message-ID:
 <MEYP282MB269752061D458F779529C6E9BB422@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202145249.5238-1-songjinjian@hotmail.com>
References: <20240202145249.5238-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ot7wRGDkYyOwxhUjU57t70LhV0pQUGDm]
X-ClientProxiedBy: SG2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:3:18::14) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240202145249.5238-4-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME3P282MB3821:EE_
X-MS-Office365-Filtering-Correlation-Id: f663f5de-c0bd-48ab-47ec-08dc23febda3
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3hhRB6TN622AZ2jjLlppNF9CTe20euV6xLXwCS0GTlvnLM2hnj4zqB6ctZuSGuJ9QglKT/a6+rtUF4LYSKZNw6NUYc5NTi7NMNAItkBl/14vzAPunCAWV4OGRHdlT+CuIHXZb3xBN4yRmRQHQxubbRWO+skN01rTB6LsQo1VwVWhZlU4dLTMU6ESa+kq37PfZcBb3VmELkH+MPIsztymXazTjwKY2kiZn+5N8a/vN2HNAnDErq6ZbS++YeGnovmNenMXpZKDrWGV2HTCJepnEKiaqYSWxfUUaghSX9D8y/fKEBqTCbrppUHD68FMifGQQreXgqtpylwB51+OW0Drt8Oek37RAWrPPAqJ0+0WMuFw388KXu6pLag5uDGFmRib52YBovnPPHLw3xXg3QN4qPp2cj7YHEnd8/ia6XRH3HK1yiN7/NBZDgKz5d2IoN14dpZITus794zTTt5GT80EZRvQuNLt1iKDlcST5Y3yMQWN+uyIjmeGtLuV+8QDXmsOdZrStETaIo85Zq77DRpeQZ7pp7zkRAYSLmNftZGPlqi6X2gDpKFeShr2chcMR9isP73dGLFXDme/7j/ZlELYrfVlUaaSwNOWIriDnFg4WtzBtegY/50r2IzRVt9cQ3YM0Rd2L5HiK3z/wMIg3czksuC2+ev9dvP192NcGDt9xmhyslLE2kmV6bqwt+jCeCC3IbktUqLWj9vbYPSSGtOeNI6VZjxxE3FrsbOMzChcqf+niEGZk1C6GJNJt30hg0nxGU/JMr2vw/eEvXqvy3i95qdan0iDoVHQko=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xs17wa2ps5pw1H63YERL0tjxlJ63I6fTfj6knc1MQ+E/F/lAR3vABSPo0hPrGGx15k9iqSk8lllqYenJOUyXeJmbiJ1wSLrmR7PgMP4G+5V7RzcTwcRKm/f0WS3Oh1Qvg0Kr5naD7jNxw1pqty3rRnGQyAo+Vh1svsQdrcG7xJwPUn0jWMBvF9ZboKflNR7d9ofn1DX76cooHyQ35Jeb2uaJ8SLV3lZrwFu30a4E9aPUL8eUudpuaF6N3tT+c6KA/OtM7eyBNH2UFZNd+oUFO3vwmjAKz0aO+ey9qsy037W4yRY0Lfp+tOnJz61Cu3L9IXJ9S4EWq6QWfT9/hIGZ2ALp8tXitTSudGdCxt4xU6ZA7EssJHEhHwKOrJAD1vqYKSguZG3yJDAdzqe6pmJ3ajcOtkC6RrjzihMYcbXl6XuIPfpuH4vqdWVQhOPA2+KJAdW8ATmIHWMcB4wcSN7RtNRaKVg7ypNjcKtNBdTZ9TlJ9nInCyFZrYC5B6reMdN6kc9aZHfmpCJlzd8djX8B4jmcCilMsi3fKTcFj/fQWnvcqQ2H4/GIFg32VGiPZrlEJOWf4/pHsWTApRpJiKhdWbIJrMfNV/k+31hsQFqgRSw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?It2T3htFd0K2oy2E2hGg6o3hXu2widI02c8UnRhaC2bkx1TRaAvZbDwheOIU?=
 =?us-ascii?Q?EvhiezNnANNyPZIzyxXFggFBd9q0Vepe4+E4NZ7sDt8ePzU2Ki5n6R1xMr4j?=
 =?us-ascii?Q?nWzeJ1gooq3w8k+w4RRfvuREQZvki/NYokhsrs1RkOqKDRlAuXNWGayE4tWc?=
 =?us-ascii?Q?nK6Epu40g5+zHoQqe6MAREUcpplp3kfwZ5VpiCM5LOwRLUbRskWrbHdpKnQ9?=
 =?us-ascii?Q?rSVGpQVtmwNtr42SJxI2O5GVxxJ2PBpuT3rB0G60l1IYHVF/RSS/u42nm0Cg?=
 =?us-ascii?Q?eJfYoMlDH2M5cZxOH41aFW7V7E+tr/FuAVYgBIpFkPJxBusp+xH8/sEcfgWT?=
 =?us-ascii?Q?zfKg/Pg+wt/Dde5dNhu/lLgpFtXi9GJHyJcVlyHwhLZxqhzuWcoHI7GWLQ+X?=
 =?us-ascii?Q?VkgjiVzz/7dt+UHU+r3qy8SwqunuDDif7Je6HtnqmbF8zERD7coolVx6I97R?=
 =?us-ascii?Q?/dzYxs1Vao0HfQRbrJDdMaELz67onKUukRjxoWiQsnHa65tVXHncpsKqmioY?=
 =?us-ascii?Q?jKfvwrFw1zYJwGY8O/FJEmm3Ti6xicS2e0HlYklN5hoeY6/xlyZ5J2MYlegu?=
 =?us-ascii?Q?X5KQqMVZI90K4MIoSR6Hkq2F0CIPkcOPZNJytVA57uLdxPqpRFvDwb/adSks?=
 =?us-ascii?Q?B2OGIY3HerELTfMpD560LiFmMOyozk8ltT2geZj2w9k9P3yqoBTOJc4Ad0F6?=
 =?us-ascii?Q?33RPmXGNgCP25BKJLO51Zhms5+VMAg/XL6U2MWWebuFRJUyvHT4moXPWntjq?=
 =?us-ascii?Q?gCX3W0tni8dt+llzcoIsHKHuyHsbFotUr/CjqRn55eJkDmUDum3iBisr3qIl?=
 =?us-ascii?Q?K4cJDylcgxHBES565O4Yjp0TJ91WAu4UBwCj5SQ4V7ssVUZpnovOVClm8rtU?=
 =?us-ascii?Q?hPgsL65IzRfyVPDAOsOwGVsLeJCeposxtwLhrQ2lZj8QqsLu4M3wp6rAZiHH?=
 =?us-ascii?Q?tbf0LbGFzE68ey/pPKCSTW9lAs5jWW8MGn+Ym3WjCDOvyfT1UClO5sD9CxoA?=
 =?us-ascii?Q?V+niF/Fi0VNUQ2rKljpdorOVAVO0Hhtyp4+Dg+85sIz6QcE6Fh+r6+CCY5OA?=
 =?us-ascii?Q?EW8xK4bYrxX7GTpX0xTyDoHASXN0eKnrOHF28sBQaHDihjShVIbeOCzVzoJG?=
 =?us-ascii?Q?mDCjU87btAYOi7/37KqwqbLxDglFFOygrdRAEFp9CRcJwNVtI3YECKIsmy9O?=
 =?us-ascii?Q?RJFr5yNqh7RYjxY2WtjkJIzJXF6fUZLKK/yGKe+K4rWkQMuPRKQCi4XQXEo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f663f5de-c0bd-48ab-47ec-08dc23febda3
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 14:53:39.2742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB3821

From: Jinjian Song <jinjian.song@fibocom.com>

To support cases such as FW update or Core dump, the t7xx
device is capable of signaling the host that a special port
needs to be created before the handshake phase.

Adds the infrastructure required to create the early ports
which also requires a different configuration of CLDMA queues.

Base on the v5 patch version of follow series:
'net: wwan: t7xx: fw flashing & coredump support'
(https://patchwork.kernel.org/project/netdevbpf/patch/3777bb382f4b0395cb594a602c5c79dbab86c9e0.1674307425.git.m.chetan.kumar@linux.intel.com/)

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v7:
 * optimize fsm_routine_stopping()
v5:
 * using t7xx_mode_update to update sysfs t7xx_mode
v4:
 * change PORT_CH_ID_UNIMPORTANT to PORT_CH_UNIMPORTANT
 * delete t7xx_wait_pm_config() in t7xx_pci_pm_init()
 * define T7XX_MAX_POSSIBLE_PORTS_NUM to get max port num
 * define macro wait_for_expected_dev_stage to be more readable
 * change prev_status to status in struct t7xx_fsm_ctl
---
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c     |  47 +++++---
 drivers/net/wwan/t7xx/t7xx_hif_cldma.h     |  18 ++-
 drivers/net/wwan/t7xx/t7xx_modem_ops.c     |   4 +-
 drivers/net/wwan/t7xx/t7xx_pci.c           |   2 +-
 drivers/net/wwan/t7xx/t7xx_port.h          |   4 +
 drivers/net/wwan/t7xx/t7xx_port_proxy.c    | 105 ++++++++++++++---
 drivers/net/wwan/t7xx/t7xx_port_proxy.h    |  10 ++
 drivers/net/wwan/t7xx/t7xx_port_wwan.c     |   5 +-
 drivers/net/wwan/t7xx/t7xx_reg.h           |  24 +++-
 drivers/net/wwan/t7xx/t7xx_state_monitor.c | 131 +++++++++++++++++----
 drivers/net/wwan/t7xx/t7xx_state_monitor.h |   1 +
 11 files changed, 290 insertions(+), 61 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
index cc70360364b7..abc41a7089fa 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
@@ -57,8 +57,6 @@
 #define CHECK_Q_STOP_TIMEOUT_US		1000000
 #define CHECK_Q_STOP_STEP_US		10000
 
-#define CLDMA_JUMBO_BUFF_SZ		(63 * 1024 + sizeof(struct ccci_header))
-
 static void md_cd_queue_struct_reset(struct cldma_queue *queue, struct cldma_ctrl *md_ctrl,
 				     enum mtk_txrx tx_rx, unsigned int index)
 {
@@ -161,7 +159,7 @@ static int t7xx_cldma_gpd_rx_from_q(struct cldma_queue *queue, int budget, bool
 		skb_reset_tail_pointer(skb);
 		skb_put(skb, le16_to_cpu(gpd->data_buff_len));
 
-		ret = md_ctrl->recv_skb(queue, skb);
+		ret = queue->recv_skb(queue, skb);
 		/* Break processing, will try again later */
 		if (ret < 0)
 			return ret;
@@ -897,13 +895,13 @@ static void t7xx_cldma_hw_start_send(struct cldma_ctrl *md_ctrl, int qno,
 
 /**
  * t7xx_cldma_set_recv_skb() - Set the callback to handle RX packets.
- * @md_ctrl: CLDMA context structure.
+ * @queue: CLDMA queue.
  * @recv_skb: Receiving skb callback.
  */
-void t7xx_cldma_set_recv_skb(struct cldma_ctrl *md_ctrl,
+void t7xx_cldma_set_recv_skb(struct cldma_queue *queue,
 			     int (*recv_skb)(struct cldma_queue *queue, struct sk_buff *skb))
 {
-	md_ctrl->recv_skb = recv_skb;
+	queue->recv_skb = recv_skb;
 }
 
 /**
@@ -993,6 +991,28 @@ int t7xx_cldma_send_skb(struct cldma_ctrl *md_ctrl, int qno, struct sk_buff *skb
 	return ret;
 }
 
+static void t7xx_cldma_adjust_config(struct cldma_ctrl *md_ctrl, enum cldma_cfg cfg_id)
+{
+	int qno;
+
+	for (qno = 0; qno < CLDMA_RXQ_NUM; qno++) {
+		md_ctrl->rx_ring[qno].pkt_size = CLDMA_SHARED_Q_BUFF_SZ;
+		t7xx_cldma_set_recv_skb(&md_ctrl->rxq[qno], t7xx_port_proxy_recv_skb);
+	}
+
+	md_ctrl->rx_ring[CLDMA_RXQ_NUM - 1].pkt_size = CLDMA_JUMBO_BUFF_SZ;
+
+	for (qno = 0; qno < CLDMA_TXQ_NUM; qno++)
+		md_ctrl->tx_ring[qno].pkt_size = CLDMA_SHARED_Q_BUFF_SZ;
+
+	if (cfg_id == CLDMA_DEDICATED_Q_CFG) {
+		md_ctrl->tx_ring[CLDMA_Q_IDX_DUMP].pkt_size = CLDMA_DEDICATED_Q_BUFF_SZ;
+		md_ctrl->rx_ring[CLDMA_Q_IDX_DUMP].pkt_size = CLDMA_DEDICATED_Q_BUFF_SZ;
+		t7xx_cldma_set_recv_skb(&md_ctrl->rxq[CLDMA_Q_IDX_DUMP],
+					t7xx_port_proxy_recv_skb_from_dedicated_queue);
+	}
+}
+
 static int t7xx_cldma_late_init(struct cldma_ctrl *md_ctrl)
 {
 	char dma_pool_name[32];
@@ -1018,16 +1038,9 @@ static int t7xx_cldma_late_init(struct cldma_ctrl *md_ctrl)
 			dev_err(md_ctrl->dev, "control TX ring init fail\n");
 			goto err_free_tx_ring;
 		}
-
-		md_ctrl->tx_ring[i].pkt_size = CLDMA_MTU;
 	}
 
 	for (j = 0; j < CLDMA_RXQ_NUM; j++) {
-		md_ctrl->rx_ring[j].pkt_size = CLDMA_MTU;
-
-		if (j == CLDMA_RXQ_NUM - 1)
-			md_ctrl->rx_ring[j].pkt_size = CLDMA_JUMBO_BUFF_SZ;
-
 		ret = t7xx_cldma_rx_ring_init(md_ctrl, &md_ctrl->rx_ring[j]);
 		if (ret) {
 			dev_err(md_ctrl->dev, "Control RX ring init fail\n");
@@ -1094,6 +1107,7 @@ int t7xx_cldma_alloc(enum cldma_id hif_id, struct t7xx_pci_dev *t7xx_dev)
 {
 	struct device *dev = &t7xx_dev->pdev->dev;
 	struct cldma_ctrl *md_ctrl;
+	int qno;
 
 	md_ctrl = devm_kzalloc(dev, sizeof(*md_ctrl), GFP_KERNEL);
 	if (!md_ctrl)
@@ -1102,7 +1116,9 @@ int t7xx_cldma_alloc(enum cldma_id hif_id, struct t7xx_pci_dev *t7xx_dev)
 	md_ctrl->t7xx_dev = t7xx_dev;
 	md_ctrl->dev = dev;
 	md_ctrl->hif_id = hif_id;
-	md_ctrl->recv_skb = t7xx_cldma_default_recv_skb;
+	for (qno = 0; qno < CLDMA_RXQ_NUM; qno++)
+		md_ctrl->rxq[qno].recv_skb = t7xx_cldma_default_recv_skb;
+
 	t7xx_hw_info_init(md_ctrl);
 	t7xx_dev->md->md_ctrl[hif_id] = md_ctrl;
 	return 0;
@@ -1332,9 +1348,10 @@ int t7xx_cldma_init(struct cldma_ctrl *md_ctrl)
 	return -ENOMEM;
 }
 
-void t7xx_cldma_switch_cfg(struct cldma_ctrl *md_ctrl)
+void t7xx_cldma_switch_cfg(struct cldma_ctrl *md_ctrl, enum cldma_cfg cfg_id)
 {
 	t7xx_cldma_late_release(md_ctrl);
+	t7xx_cldma_adjust_config(md_ctrl, cfg_id);
 	t7xx_cldma_late_init(md_ctrl);
 }
 
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.h b/drivers/net/wwan/t7xx/t7xx_hif_cldma.h
index 4410bac6993a..f2d9941be9c8 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.h
+++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.h
@@ -31,6 +31,10 @@
 #include "t7xx_cldma.h"
 #include "t7xx_pci.h"
 
+#define CLDMA_JUMBO_BUFF_SZ		(63 * 1024 + sizeof(struct ccci_header))
+#define CLDMA_SHARED_Q_BUFF_SZ		3584
+#define CLDMA_DEDICATED_Q_BUFF_SZ	2048
+
 /**
  * enum cldma_id - Identifiers for CLDMA HW units.
  * @CLDMA_ID_MD: Modem control channel.
@@ -55,6 +59,11 @@ struct cldma_gpd {
 	__le16 not_used2;
 };
 
+enum cldma_cfg {
+	CLDMA_SHARED_Q_CFG,
+	CLDMA_DEDICATED_Q_CFG,
+};
+
 struct cldma_request {
 	struct cldma_gpd *gpd;	/* Virtual address for CPU */
 	dma_addr_t gpd_addr;	/* Physical address for DMA */
@@ -82,6 +91,7 @@ struct cldma_queue {
 	wait_queue_head_t req_wq;	/* Only for TX */
 	struct workqueue_struct *worker;
 	struct work_struct cldma_work;
+	int (*recv_skb)(struct cldma_queue *queue, struct sk_buff *skb);
 };
 
 struct cldma_ctrl {
@@ -101,24 +111,22 @@ struct cldma_ctrl {
 	struct md_pm_entity *pm_entity;
 	struct t7xx_cldma_hw hw_info;
 	bool is_late_init;
-	int (*recv_skb)(struct cldma_queue *queue, struct sk_buff *skb);
 };
 
+#define CLDMA_Q_IDX_DUMP	1
 #define GPD_FLAGS_HWO		BIT(0)
 #define GPD_FLAGS_IOC		BIT(7)
 #define GPD_DMAPOOL_ALIGN	16
 
-#define CLDMA_MTU		3584	/* 3.5kB */
-
 int t7xx_cldma_alloc(enum cldma_id hif_id, struct t7xx_pci_dev *t7xx_dev);
 void t7xx_cldma_hif_hw_init(struct cldma_ctrl *md_ctrl);
 int t7xx_cldma_init(struct cldma_ctrl *md_ctrl);
 void t7xx_cldma_exit(struct cldma_ctrl *md_ctrl);
-void t7xx_cldma_switch_cfg(struct cldma_ctrl *md_ctrl);
+void t7xx_cldma_switch_cfg(struct cldma_ctrl *md_ctrl, enum cldma_cfg cfg_id);
 void t7xx_cldma_start(struct cldma_ctrl *md_ctrl);
 int t7xx_cldma_stop(struct cldma_ctrl *md_ctrl);
 void t7xx_cldma_reset(struct cldma_ctrl *md_ctrl);
-void t7xx_cldma_set_recv_skb(struct cldma_ctrl *md_ctrl,
+void t7xx_cldma_set_recv_skb(struct cldma_queue *queue,
 			     int (*recv_skb)(struct cldma_queue *queue, struct sk_buff *skb));
 int t7xx_cldma_send_skb(struct cldma_ctrl *md_ctrl, int qno, struct sk_buff *skb);
 void t7xx_cldma_stop_all_qs(struct cldma_ctrl *md_ctrl, enum mtk_txrx tx_rx);
diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
index ca262d2961ed..fd79a2a1cc6f 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
@@ -535,7 +535,7 @@ static void t7xx_md_hk_wq(struct work_struct *work)
 
 	/* Clear the HS2 EXIT event appended in core_reset() */
 	t7xx_fsm_clr_event(ctl, FSM_EVENT_MD_HS2_EXIT);
-	t7xx_cldma_switch_cfg(md->md_ctrl[CLDMA_ID_MD]);
+	t7xx_cldma_switch_cfg(md->md_ctrl[CLDMA_ID_MD], CLDMA_SHARED_Q_CFG);
 	t7xx_cldma_start(md->md_ctrl[CLDMA_ID_MD]);
 	t7xx_fsm_broadcast_state(ctl, MD_STATE_WAITING_FOR_HS2);
 	md->core_md.handshake_ongoing = true;
@@ -550,7 +550,7 @@ static void t7xx_ap_hk_wq(struct work_struct *work)
 	 /* Clear the HS2 EXIT event appended in t7xx_core_reset(). */
 	t7xx_fsm_clr_event(ctl, FSM_EVENT_AP_HS2_EXIT);
 	t7xx_cldma_stop(md->md_ctrl[CLDMA_ID_AP]);
-	t7xx_cldma_switch_cfg(md->md_ctrl[CLDMA_ID_AP]);
+	t7xx_cldma_switch_cfg(md->md_ctrl[CLDMA_ID_AP], CLDMA_SHARED_Q_CFG);
 	t7xx_cldma_start(md->md_ctrl[CLDMA_ID_AP]);
 	md->core_ap.handshake_ongoing = true;
 	t7xx_core_hk_handler(md, &md->core_ap, ctl, FSM_EVENT_AP_HS2, FSM_EVENT_AP_HS2_EXIT);
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index f99eb21cb8cc..e0b1e7a616ca 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -183,7 +183,7 @@ static int t7xx_pci_pm_init(struct t7xx_pci_dev *t7xx_dev)
 	pm_runtime_set_autosuspend_delay(&pdev->dev, PM_AUTOSUSPEND_MS);
 	pm_runtime_use_autosuspend(&pdev->dev);
 
-	return t7xx_wait_pm_config(t7xx_dev);
+	return 0;
 }
 
 void t7xx_pci_pm_init_late(struct t7xx_pci_dev *t7xx_dev)
diff --git a/drivers/net/wwan/t7xx/t7xx_port.h b/drivers/net/wwan/t7xx/t7xx_port.h
index 4ae8a00a8532..f74d3bab810d 100644
--- a/drivers/net/wwan/t7xx/t7xx_port.h
+++ b/drivers/net/wwan/t7xx/t7xx_port.h
@@ -75,6 +75,8 @@ enum port_ch {
 	PORT_CH_DSS6_TX = 0x20df,
 	PORT_CH_DSS7_RX = 0x20e0,
 	PORT_CH_DSS7_TX = 0x20e1,
+
+	PORT_CH_UNIMPORTANT = 0xffff,
 };
 
 struct t7xx_port;
@@ -135,11 +137,13 @@ struct t7xx_port {
 	};
 };
 
+int t7xx_get_port_mtu(struct t7xx_port *port);
 struct sk_buff *t7xx_port_alloc_skb(int payload);
 struct sk_buff *t7xx_ctrl_alloc_skb(int payload);
 int t7xx_port_enqueue_skb(struct t7xx_port *port, struct sk_buff *skb);
 int t7xx_port_send_skb(struct t7xx_port *port, struct sk_buff *skb, unsigned int pkt_header,
 		       unsigned int ex_msg);
+int t7xx_port_send_raw_skb(struct t7xx_port *port, struct sk_buff *skb);
 int t7xx_port_send_ctl_skb(struct t7xx_port *port, struct sk_buff *skb, unsigned int msg,
 			   unsigned int ex_msg);
 
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
index 274846d39fbf..e53a152faee4 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -48,6 +48,9 @@
 	     i < (proxy)->port_count;		\
 	     i++, (p) = &(proxy)->ports[i])
 
+#define T7XX_MAX_POSSIBLE_PORTS_NUM	\
+	(max(ARRAY_SIZE(t7xx_port_conf), ARRAY_SIZE(t7xx_early_port_conf)))
+
 static const struct t7xx_port_conf t7xx_port_conf[] = {
 	{
 		.tx_ch = PORT_CH_UART2_TX,
@@ -100,6 +103,18 @@ static const struct t7xx_port_conf t7xx_port_conf[] = {
 	},
 };
 
+static const struct t7xx_port_conf t7xx_early_port_conf[] = {
+	{
+		.tx_ch = PORT_CH_UNIMPORTANT,
+		.rx_ch = PORT_CH_UNIMPORTANT,
+		.txq_index = CLDMA_Q_IDX_DUMP,
+		.rxq_index = CLDMA_Q_IDX_DUMP,
+		.txq_exp_index = CLDMA_Q_IDX_DUMP,
+		.rxq_exp_index = CLDMA_Q_IDX_DUMP,
+		.path_id = CLDMA_ID_AP,
+	},
+};
+
 static struct t7xx_port *t7xx_proxy_get_port_by_ch(struct port_proxy *port_prox, enum port_ch ch)
 {
 	const struct t7xx_port_conf *port_conf;
@@ -214,7 +229,17 @@ int t7xx_port_enqueue_skb(struct t7xx_port *port, struct sk_buff *skb)
 	return 0;
 }
 
-static int t7xx_port_send_raw_skb(struct t7xx_port *port, struct sk_buff *skb)
+int t7xx_get_port_mtu(struct t7xx_port *port)
+{
+	enum cldma_id path_id = port->port_conf->path_id;
+	int tx_qno = t7xx_port_get_queue_no(port);
+	struct cldma_ctrl *md_ctrl;
+
+	md_ctrl = port->t7xx_dev->md->md_ctrl[path_id];
+	return md_ctrl->tx_ring[tx_qno].pkt_size;
+}
+
+int t7xx_port_send_raw_skb(struct t7xx_port *port, struct sk_buff *skb)
 {
 	enum cldma_id path_id = port->port_conf->path_id;
 	struct cldma_ctrl *md_ctrl;
@@ -329,6 +354,39 @@ static void t7xx_proxy_setup_ch_mapping(struct port_proxy *port_prox)
 	}
 }
 
+/**
+ * t7xx_port_proxy_recv_skb_from_dedicated_queue() - Dispatch early port received skb.
+ * @queue: CLDMA queue.
+ * @skb: Socket buffer.
+ *
+ * Return:
+ ** 0		- Packet consumed.
+ ** -ERROR	- Failed to process skb.
+ */
+int t7xx_port_proxy_recv_skb_from_dedicated_queue(struct cldma_queue *queue, struct sk_buff *skb)
+{
+	struct t7xx_pci_dev *t7xx_dev = queue->md_ctrl->t7xx_dev;
+	struct port_proxy *port_prox = t7xx_dev->md->port_prox;
+	const struct t7xx_port_conf *port_conf;
+	struct t7xx_port *port;
+	int ret;
+
+	port = &port_prox->ports[0];
+	if (WARN_ON_ONCE(port->port_conf->rxq_index != queue->index)) {
+		dev_kfree_skb_any(skb);
+		return -EINVAL;
+	}
+
+	port_conf = port->port_conf;
+	ret = port_conf->ops->recv_skb(port, skb);
+	if (ret < 0 && ret != -ENOBUFS) {
+		dev_err(port->dev, "drop on RX ch %d, %d\n", port_conf->rx_ch, ret);
+		dev_kfree_skb_any(skb);
+	}
+
+	return ret;
+}
+
 static struct t7xx_port *t7xx_port_proxy_find_port(struct t7xx_pci_dev *t7xx_dev,
 						   struct cldma_queue *queue, u16 channel)
 {
@@ -359,7 +417,7 @@ static struct t7xx_port *t7xx_port_proxy_find_port(struct t7xx_pci_dev *t7xx_dev
  ** 0		- Packet consumed.
  ** -ERROR	- Failed to process skb.
  */
-static int t7xx_port_proxy_recv_skb(struct cldma_queue *queue, struct sk_buff *skb)
+int t7xx_port_proxy_recv_skb(struct cldma_queue *queue, struct sk_buff *skb)
 {
 	struct ccci_header *ccci_h = (struct ccci_header *)skb->data;
 	struct t7xx_pci_dev *t7xx_dev = queue->md_ctrl->t7xx_dev;
@@ -444,33 +502,54 @@ static void t7xx_proxy_init_all_ports(struct t7xx_modem *md)
 		spin_lock_init(&port->port_update_lock);
 		port->chan_enable = false;
 
-		if (port_conf->ops->init)
+		if (port_conf->ops && port_conf->ops->init)
 			port_conf->ops->init(port);
 	}
 
 	t7xx_proxy_setup_ch_mapping(port_prox);
 }
 
+void t7xx_port_proxy_set_cfg(struct t7xx_modem *md, enum port_cfg_id cfg_id)
+{
+	struct port_proxy *port_prox = md->port_prox;
+	const struct t7xx_port_conf *port_conf;
+	u32 port_count;
+	int i;
+
+	t7xx_port_proxy_uninit(port_prox);
+
+	if (cfg_id == PORT_CFG_ID_EARLY) {
+		port_conf = t7xx_early_port_conf;
+		port_count = ARRAY_SIZE(t7xx_early_port_conf);
+	} else {
+		port_conf = t7xx_port_conf;
+		port_count = ARRAY_SIZE(t7xx_port_conf);
+	}
+
+	for (i = 0; i < port_count; i++)
+		port_prox->ports[i].port_conf = &port_conf[i];
+
+	port_prox->cfg_id = cfg_id;
+	port_prox->port_count = port_count;
+
+	t7xx_proxy_init_all_ports(md);
+}
+
 static int t7xx_proxy_alloc(struct t7xx_modem *md)
 {
-	unsigned int port_count = ARRAY_SIZE(t7xx_port_conf);
 	struct device *dev = &md->t7xx_dev->pdev->dev;
 	struct port_proxy *port_prox;
-	int i;
 
-	port_prox = devm_kzalloc(dev, sizeof(*port_prox) + sizeof(struct t7xx_port) * port_count,
+	port_prox = devm_kzalloc(dev, sizeof(*port_prox) +
+				 sizeof(struct t7xx_port) * T7XX_MAX_POSSIBLE_PORTS_NUM,
 				 GFP_KERNEL);
 	if (!port_prox)
 		return -ENOMEM;
 
 	md->port_prox = port_prox;
 	port_prox->dev = dev;
+	t7xx_port_proxy_set_cfg(md, PORT_CFG_ID_EARLY);
 
-	for (i = 0; i < port_count; i++)
-		port_prox->ports[i].port_conf = &t7xx_port_conf[i];
-
-	port_prox->port_count = port_count;
-	t7xx_proxy_init_all_ports(md);
 	return 0;
 }
 
@@ -492,8 +571,6 @@ int t7xx_port_proxy_init(struct t7xx_modem *md)
 	if (ret)
 		return ret;
 
-	t7xx_cldma_set_recv_skb(md->md_ctrl[CLDMA_ID_AP], t7xx_port_proxy_recv_skb);
-	t7xx_cldma_set_recv_skb(md->md_ctrl[CLDMA_ID_MD], t7xx_port_proxy_recv_skb);
 	return 0;
 }
 
@@ -505,7 +582,7 @@ void t7xx_port_proxy_uninit(struct port_proxy *port_prox)
 	for_each_proxy_port(i, port, port_prox) {
 		const struct t7xx_port_conf *port_conf = port->port_conf;
 
-		if (port_conf->ops->uninit)
+		if (port_conf->ops && port_conf->ops->uninit)
 			port_conf->ops->uninit(port);
 	}
 }
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.h b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
index 81d059fbc0fb..7f5706811445 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
@@ -31,11 +31,18 @@
 #define RX_QUEUE_MAXLEN		32
 #define CTRL_QUEUE_MAXLEN	16
 
+enum port_cfg_id {
+	PORT_CFG_ID_INVALID,
+	PORT_CFG_ID_NORMAL,
+	PORT_CFG_ID_EARLY,
+};
+
 struct port_proxy {
 	int			port_count;
 	struct list_head	rx_ch_ports[PORT_CH_ID_MASK + 1];
 	struct list_head	queue_ports[CLDMA_NUM][MTK_QUEUES];
 	struct device		*dev;
+	enum port_cfg_id	cfg_id;
 	struct t7xx_port	ports[];
 };
 
@@ -98,5 +105,8 @@ void t7xx_port_proxy_md_status_notify(struct port_proxy *port_prox, unsigned int
 int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg);
 int t7xx_port_proxy_chl_enable_disable(struct port_proxy *port_prox, unsigned int ch_id,
 				       bool en_flag);
+void t7xx_port_proxy_set_cfg(struct t7xx_modem *md, enum port_cfg_id cfg_id);
+int t7xx_port_proxy_recv_skb(struct cldma_queue *queue, struct sk_buff *skb);
+int t7xx_port_proxy_recv_skb_from_dedicated_queue(struct cldma_queue *queue, struct sk_buff *skb);
 
 #endif /* __T7XX_PORT_PROXY_H__ */
diff --git a/drivers/net/wwan/t7xx/t7xx_port_wwan.c b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
index 17389c8f6600..ddc20ddfa734 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_wwan.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
@@ -152,14 +152,15 @@ static int t7xx_port_wwan_disable_chl(struct t7xx_port *port)
 static void t7xx_port_wwan_md_state_notify(struct t7xx_port *port, unsigned int state)
 {
 	const struct t7xx_port_conf *port_conf = port->port_conf;
-	unsigned int header_len = sizeof(struct ccci_header);
+	unsigned int header_len = sizeof(struct ccci_header), mtu;
 	struct wwan_port_caps caps;
 
 	if (state != MD_STATE_READY)
 		return;
 
 	if (!port->wwan.wwan_port) {
-		caps.frag_len = CLDMA_MTU - header_len;
+		mtu = t7xx_get_port_mtu(port);
+		caps.frag_len = mtu - header_len;
 		caps.headroom_len = header_len;
 		port->wwan.wwan_port = wwan_create_port(port->dev, port_conf->port_type,
 							&wwan_ops, &caps, port);
diff --git a/drivers/net/wwan/t7xx/t7xx_reg.h b/drivers/net/wwan/t7xx/t7xx_reg.h
index c41d7d094c08..9c7dc72ac6f6 100644
--- a/drivers/net/wwan/t7xx/t7xx_reg.h
+++ b/drivers/net/wwan/t7xx/t7xx_reg.h
@@ -101,11 +101,33 @@ enum t7xx_pm_resume_state {
 	PM_RESUME_REG_STATE_L2_EXP,
 };
 
+enum host_event_e {
+	HOST_EVENT_INIT = 0,
+	FASTBOOT_DL_NOTIFY = 0x3,
+};
+
 #define T7XX_PCIE_MISC_DEV_STATUS		0x0d1c
 #define MISC_STAGE_MASK				GENMASK(2, 0)
 #define MISC_RESET_TYPE_PLDR			BIT(26)
 #define MISC_RESET_TYPE_FLDR			BIT(27)
-#define LINUX_STAGE				4
+#define MISC_RESET_TYPE_PLDR			BIT(26)
+#define MISC_LK_EVENT_MASK			GENMASK(11, 8)
+#define HOST_EVENT_MASK				GENMASK(31, 28)
+
+enum lk_event_id {
+	LK_EVENT_NORMAL = 0,
+	LK_EVENT_CREATE_PD_PORT = 1,
+	LK_EVENT_CREATE_POST_DL_PORT = 2,
+	LK_EVENT_RESET = 7,
+};
+
+enum t7xx_device_stage {
+	T7XX_DEV_STAGE_INIT = 0,
+	T7XX_DEV_STAGE_BROM_PRE = 1,
+	T7XX_DEV_STAGE_BROM_POST = 2,
+	T7XX_DEV_STAGE_LK = 3,
+	T7XX_DEV_STAGE_LINUX = 4,
+};
 
 #define T7XX_PCIE_RESOURCE_STATUS		0x0d28
 #define T7XX_PCIE_RESOURCE_STS_MSK		GENMASK(4, 0)
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index c5d46f45fa62..123f54b81cdc 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -47,6 +47,13 @@
 #define FSM_MD_EX_PASS_TIMEOUT_MS		45000
 #define FSM_CMD_TIMEOUT_MS			2000
 
+#define wait_for_expected_dev_stage(status)	\
+	read_poll_timeout(ioread32, status,	\
+			  ((status & MISC_STAGE_MASK) == T7XX_DEV_STAGE_LINUX) ||	\
+			  ((status & MISC_STAGE_MASK) == T7XX_DEV_STAGE_LK), 100000,	\
+			  20000000, false, IREG_BASE(md->t7xx_dev) +	\
+			  T7XX_PCIE_MISC_DEV_STATUS)
+
 void t7xx_fsm_notifier_register(struct t7xx_modem *md, struct t7xx_fsm_notifier *notifier)
 {
 	struct t7xx_fsm_ctl *ctl = md->fsm_ctl;
@@ -206,6 +213,51 @@ static void fsm_routine_exception(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comm
 		fsm_finish_command(ctl, cmd, 0);
 }
 
+static void t7xx_host_event_notify(struct t7xx_modem *md, unsigned int event_id)
+{
+	u32 value;
+
+	value = ioread32(IREG_BASE(md->t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
+	value &= ~HOST_EVENT_MASK;
+	value |= FIELD_PREP(HOST_EVENT_MASK, event_id);
+	iowrite32(value, IREG_BASE(md->t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
+}
+
+static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int status)
+{
+	struct t7xx_modem *md = ctl->md;
+	struct cldma_ctrl *md_ctrl;
+	enum lk_event_id lk_event;
+	struct device *dev;
+
+	dev = &md->t7xx_dev->pdev->dev;
+	lk_event = FIELD_GET(MISC_LK_EVENT_MASK, status);
+	switch (lk_event) {
+	case LK_EVENT_NORMAL:
+	case LK_EVENT_RESET:
+		break;
+
+	case LK_EVENT_CREATE_PD_PORT:
+	case LK_EVENT_CREATE_POST_DL_PORT:
+		md_ctrl = md->md_ctrl[CLDMA_ID_AP];
+		t7xx_cldma_hif_hw_init(md_ctrl);
+		t7xx_cldma_stop(md_ctrl);
+		t7xx_cldma_switch_cfg(md_ctrl, CLDMA_DEDICATED_Q_CFG);
+
+		t7xx_cldma_start(md_ctrl);
+
+		if (lk_event == LK_EVENT_CREATE_POST_DL_PORT)
+			t7xx_mode_update(md->t7xx_dev, T7XX_FASTBOOT_DOWNLOAD);
+		else
+			t7xx_mode_update(md->t7xx_dev, T7XX_FASTBOOT_DUMP);
+		break;
+
+	default:
+		dev_err(dev, "Invalid LK event %d\n", lk_event);
+		break;
+	}
+}
+
 static int fsm_stopped_handler(struct t7xx_fsm_ctl *ctl)
 {
 	ctl->curr_state = FSM_STATE_STOPPED;
@@ -226,27 +278,32 @@ static void fsm_routine_stopped(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comman
 
 static void fsm_routine_stopping(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_command *cmd)
 {
-	struct t7xx_pci_dev *t7xx_dev;
-	struct cldma_ctrl *md_ctrl;
+	struct cldma_ctrl *md_ctrl = ctl->md->md_ctrl[CLDMA_ID_MD];
+	struct t7xx_pci_dev *t7xx_dev = ctl->md->t7xx_dev;
+	u32 mode = READ_ONCE(t7xx_dev->mode);
 	int err;
 
-	if (ctl->curr_state == FSM_STATE_STOPPED || ctl->curr_state == FSM_STATE_STOPPING) {
+	if (ctl->curr_state == FSM_STATE_STOPPED ||
+	    ctl->curr_state == FSM_STATE_STOPPING ||
+	    mode == T7XX_RESET) {
 		fsm_finish_command(ctl, cmd, -EINVAL);
 		return;
 	}
 
-	md_ctrl = ctl->md->md_ctrl[CLDMA_ID_MD];
-	t7xx_dev = ctl->md->t7xx_dev;
-
 	ctl->curr_state = FSM_STATE_STOPPING;
 	t7xx_fsm_broadcast_state(ctl, MD_STATE_WAITING_TO_STOP);
 	t7xx_cldma_stop(md_ctrl);
 
-	if (!ctl->md->rgu_irq_asserted) {
-		t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DRM_DISABLE_AP);
-		/* Wait for the DRM disable to take effect */
-		msleep(FSM_DRM_DISABLE_DELAY_MS);
+	if (mode == T7XX_FASTBOOT_SWITCHING)
+		t7xx_host_event_notify(ctl->md, FASTBOOT_DL_NOTIFY);
+
+	t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DRM_DISABLE_AP);
+	/* Wait for the DRM disable to take effect */
+	msleep(FSM_DRM_DISABLE_DELAY_MS);
 
+	if (mode == T7XX_FASTBOOT_SWITCHING) {
+		t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DEVICE_RESET);
+	} else {
 		err = t7xx_acpi_fldr_func(t7xx_dev);
 		if (err)
 			t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DEVICE_RESET);
@@ -318,7 +375,8 @@ static int fsm_routine_starting(struct t7xx_fsm_ctl *ctl)
 static void fsm_routine_start(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_command *cmd)
 {
 	struct t7xx_modem *md = ctl->md;
-	u32 dev_status;
+	struct device *dev;
+	u32 status;
 	int ret;
 
 	if (!md)
@@ -330,23 +388,53 @@ static void fsm_routine_start(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_command
 		return;
 	}
 
+	dev = &md->t7xx_dev->pdev->dev;
 	ctl->curr_state = FSM_STATE_PRE_START;
 	t7xx_md_event_notify(md, FSM_PRE_START);
 
-	ret = read_poll_timeout(ioread32, dev_status,
-				(dev_status & MISC_STAGE_MASK) == LINUX_STAGE, 20000, 2000000,
-				false, IREG_BASE(md->t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
+	ret = wait_for_expected_dev_stage(status);
+
 	if (ret) {
-		struct device *dev = &md->t7xx_dev->pdev->dev;
+		dev_err(dev, "read poll timeout %d\n", ret);
+		goto finish_command;
+	}
 
-		fsm_finish_command(ctl, cmd, -ETIMEDOUT);
-		dev_err(dev, "Invalid device status 0x%lx\n", dev_status & MISC_STAGE_MASK);
-		return;
+	if (status != ctl->status || cmd->flag != 0) {
+		u32 stage = FIELD_GET(MISC_STAGE_MASK, status);
+
+		switch (stage) {
+		case T7XX_DEV_STAGE_INIT:
+		case T7XX_DEV_STAGE_BROM_PRE:
+		case T7XX_DEV_STAGE_BROM_POST:
+			dev_dbg(dev, "BROM_STAGE Entered\n");
+			ret = t7xx_fsm_append_cmd(ctl, FSM_CMD_START, 0);
+			break;
+
+		case T7XX_DEV_STAGE_LK:
+			dev_dbg(dev, "LK_STAGE Entered\n");
+			t7xx_lk_stage_event_handling(ctl, status);
+			break;
+
+		case T7XX_DEV_STAGE_LINUX:
+			dev_dbg(dev, "LINUX_STAGE Entered\n");
+			t7xx_mhccif_mask_clr(md->t7xx_dev, D2H_INT_PORT_ENUM |
+					     D2H_INT_ASYNC_MD_HK | D2H_INT_ASYNC_AP_HK);
+			if (cmd->flag == 0)
+				break;
+			t7xx_cldma_hif_hw_init(md->md_ctrl[CLDMA_ID_AP]);
+			t7xx_cldma_hif_hw_init(md->md_ctrl[CLDMA_ID_MD]);
+			t7xx_port_proxy_set_cfg(md, PORT_CFG_ID_NORMAL);
+			ret = fsm_routine_starting(ctl);
+			break;
+
+		default:
+			break;
+		}
+		ctl->status = status;
 	}
 
-	t7xx_cldma_hif_hw_init(md->md_ctrl[CLDMA_ID_AP]);
-	t7xx_cldma_hif_hw_init(md->md_ctrl[CLDMA_ID_MD]);
-	fsm_finish_command(ctl, cmd, fsm_routine_starting(ctl));
+finish_command:
+	fsm_finish_command(ctl, cmd, ret);
 }
 
 static int fsm_main_thread(void *data)
@@ -518,6 +606,7 @@ void t7xx_fsm_reset(struct t7xx_modem *md)
 	fsm_flush_event_cmd_qs(ctl);
 	ctl->curr_state = FSM_STATE_STOPPED;
 	ctl->exp_flg = false;
+	ctl->status = T7XX_DEV_STAGE_INIT;
 }
 
 int t7xx_fsm_init(struct t7xx_modem *md)
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.h b/drivers/net/wwan/t7xx/t7xx_state_monitor.h
index b0b3662ae6d7..7b0a9baf488c 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.h
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.h
@@ -96,6 +96,7 @@ struct t7xx_fsm_ctl {
 	bool			exp_flg;
 	spinlock_t		notifier_lock;		/* Protects notifier list */
 	struct list_head	notifier_list;
+	u32			status;			/* Device boot stage */
 };
 
 struct t7xx_fsm_event {
-- 
2.34.1


